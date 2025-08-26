//
//  ADHAnimalVC.swift
//  SearchPoint
//
//  Created by Mobile Programming on 03/06/22.
//

import UIKit
import Vision
import VisionKit
import CoreBluetooth
import Alamofire
import MBProgressHUD
import CoreData
import Toast_Swift
import DropDown

//MARK: ADH ANIMAL VC
class ADHAnimalVC: BaseViewController, VNDocumentCameraViewControllerDelegate{
    
    //MARK: IB OUTLETS
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var cartIcon: UIImageView!
    @IBOutlet weak var totalAnimalCount: UILabel!
    @IBOutlet weak var totalAnimalLabel: UILabel!
    @IBOutlet weak var bckBtnOutlet: customButton!
    @IBOutlet weak var filterBtnOutlet: customButton!
    @IBOutlet weak var screenTitleLbl: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var searchTextField: UITextField! {
        didSet{
            searchTextField.delegate = self
        }
    }
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var calendarViewBkg: UIView!
    @IBOutlet weak var connectedBtnOutlet: UIButton!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var connectionImg: UIImageView!
    @IBOutlet weak var sortByDownlbl: UILabel!
    @IBOutlet weak var sortByDropDownOutlet: UIButton!
    @IBOutlet weak var headerstackview: UIStackView!
    @IBOutlet weak var pairedBackroundView: UIView!
    @IBOutlet weak var pairedDeviceTitle: UILabel!
    @IBOutlet weak var sortByButtonOutlet: customButton!
    @IBOutlet weak var pairedTableView: UITableView!
    @IBOutlet weak var lblTitleSortBy: UILabel!
    @IBOutlet weak var btnClearList: UIButton!
    @IBOutlet weak var btnSubmitAnimal: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var cartCountLbl: UILabel!
    @IBOutlet weak var rfidBtnOutlet: customButton!
    
    //MARK: VARIABLES AND CONSTANTS
    var saveAnimalGroupUpdatedViewModel: AnimalGroupsForCustomerUpdateVM?
    var selectedDate = Date()
    var timeStampString = String()
    var productName = String()
    var checkid = String()
    var bckRetain = Bool()
    var resultMasterGet = [ResultMasterTemplate]()
    var request = VNRecognizeTextRequest(completionHandler: nil)
    var myTableView: UITableView!
    var datasource = [callSwipeStruct]()
    var myHerdArray = [ResultMyHerdData]()
    var sexname : String!
    var group = DispatchGroup()
    var copyarray = NSArray()
    var rankid = String()
    var rankidnms = String()
    var yourarray = [String : Any]()
    var myFilterController : MyHerdFilterController?
    var saveResulyByPageViewModel: ResulyByPageViewModel?
    var dasboard :  DashboardVC?
    let dropDown = DropDown()
    var lastIndex = -1
    var tempArray = Bool()
    var arrNearbyDevice : [CBPeripheral] = [] {
        didSet{
            
            pairedTableView?.reloadData()
        }
    }
    var autoD = Int()
    var datePicker : UIDatePicker!
    let toolBar = UIToolbar()
    var dateFrom = String()
    var dateTo = String()
    var fromdatecheck = String()
    var currentdate = String()
    var todatecheck = String()
    let dateFormatter3 = DateFormatter()
    var searchFound = Bool()
    var cellIndexForScanner : IndexPath?
    var clickOnDropDown = String()
    var customerId  = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
    var userId : Int?
    var langId : Int?
    var textRecognitionRequest = VNRecognizeTextRequest(completionHandler: nil)
    private let textRecognitionWorkQueue = DispatchQueue(label: "MyVisionScannerQueue", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
    var fetchFilterData = NSArray()
    var fetchTempObj1new = NSArray()
    var adhAnimalData = [AnimalMaster]()
    var workItem: DispatchWorkItem?
    var adhAnimalModel = [ADHAnimalModel]()
    var isADHFilterApplied: Bool?
    var filterToDate: String?
    var filterFromDate: String?
    var filterGender: String?
    var filterBreedId: String?
    lazy var viewModel: ADHAnimalVM  = {
        let obj = ADHAnimalVM(userService: UserService())
        self.baseVwModel = obj
        return obj
    }()
    let pvid = UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue)
    let orderingDataListViewModel = OrderingDataListViewModel()
    var qrData: QRData? = nil {
        didSet {
            if qrData != nil {
                searchTextField.text = qrData?.codeString
            }
        }
    }
    var value = 0
    var ranktitle : String?
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        
        super.viewDidLoad()
        langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
        
        self.userId = UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int
        
        switch pvid {
        case 1 :
            clickOnDropDown = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
        case 4:
            clickOnDropDown = NSLocalizedString(ButtonTitles.earTagText, comment: "")
        default:
            break
        }
        UserDefaults.standard.set(false, forKey: keyValue.ADHFilterApplied.rawValue)
        self.navigationController?.navigationBar.isHidden = true
        self.calenderView.isHidden = true
        self.calendarViewBkg.isHidden = true
        pairedBackroundView.isHidden = true
        
        initialNetworkCheck()
        searchTextField.autocorrectionType = .yes
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(searchDidChange(sender:)), for: .editingChanged)
        tblView.estimatedRowHeight = 65
        tblView.rowHeight = UITableView.automaticDimension
        
        setupLangaugeBR()
        setupClosures()
        hideAllEmptyTextFields()
        self.fetchADHAnimalData()
        showTotalCount()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateCartCount()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hideIndicator()
        super.viewDidAppear(animated)
        tblView.reloadData()
        tblView.estimatedRowHeight = 40.0
        tblView.rowHeight = UITableView.automaticDimension
        tblView.separatorStyle = .none
        fetchFilterData = fetchResultFilterData(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: Int(customerId ))
        fetchTempObj1new = fetchAllData(entityName: Entities.resultPageByTraitTblEntity)
        if fetchFilterData.count == 0 && !bckRetain{
            navigateToADHFilterControler()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.standard.removeObject(forKey: keyValue.fromManagement.rawValue)
    }
    
    //MARK: UI METHODS
    func initialNetworkCheck(){
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del = UIApplication.shared.delegate as? AppDelegate
        self.statusText?.text = NSLocalizedString((del?.status)!, comment: "")
        if statusText?.text == ButtonTitles.connectedText.localized {
            self.connectedBtnOutlet.isHidden = true
            self.connectionImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else {
            self.connectedBtnOutlet.isHidden = false
            self.connectionImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    func updateCartCount() {
        let orderId  = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        let pvIdUser = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: 1,orderId:orderId,orderStatus:"false", providerId: pvIdUser)
        self.cartCountLbl.text = String(animalCount.count)
        if animalCount.count == 0 {
            self.cartCountLbl.isHidden = true
            self.cartButton.isHidden = true
        } else {
            self.cartCountLbl.isHidden = false
            self.cartButton.isHidden = false
        }
    }
    
    func tablereload(){
        myHerdArray   = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:Int64(customerId)) as! [ResultMyHerdData]
        totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: myHerdArray.count)
        tblView.isHidden = true
        tblView.reloadData()
    }
    
    
    func breednameset(){
        // This method is intentionally left empty.
        // It will be implemented in the future to handle navigation logic.
    }
    
    
    func setupLangaugeBR() {
        screenTitleLbl.text = NSLocalizedString(LocalizedStrings.findMyAnimalText, comment: "")
        lblTitleSortBy.text = NSLocalizedString(ButtonTitles.sortByText, comment: "")
        
        btnClearList.setTitle(NSLocalizedString(LocalizedStrings.clearAllText, comment: ""), for: .normal)
        btnSubmitAnimal.setTitle(NSLocalizedString(ButtonTitles.addAnimalText, comment: ""), for: .normal)
        
    }
    
    func setupClosures() {
        viewModel.redirectControllerClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.hideIndicator()
                if self?.viewModel.adhAnimalData.count == 0 {
                    self?.tblView.isHidden = true
                    self?.message.isHidden = false
                    self?.cartIcon.isHidden = false
                } else {
                    self?.tblView.isHidden = false
                    self?.message.isHidden = true
                    self?.cartIcon.isHidden = true
                    self?.tblView.reloadData()
                }
            }
        }
    }
    
    func hideAllEmptyTextFields() {
        self.viewModel.updateADhListToHideExpansion()
    }
    
    func showTotalCount() {
        if searchFound {
            let filterData = self.viewModel.filterAdhAnimalData.filter({$0.isADHSelected ==  true})
            if(filterData.count>0){
                totalAnimalCount.isHidden = false
                totalAnimalLabel.isHidden = false
                totalAnimalCount.text = "\(filterData.count)" + "/" + "\(self.viewModel.filterAdhAnimalData.count)"
            } else  {
                totalAnimalCount.isHidden = true
                totalAnimalLabel.isHidden = true
            }
        } else {
            let filterData = self.viewModel.adhAnimalData.filter({$0.isADHSelected ==  true})
            if(filterData.count>0){
                totalAnimalCount.isHidden = false
                totalAnimalLabel.isHidden = false
                totalAnimalCount.text = "\(filterData.count)" + "/" + "\(self.viewModel.adhAnimalData.count)"
            } else  {
                totalAnimalCount.isHidden = true
                totalAnimalLabel.isHidden = true
            }
        }
    }
    
    func resultcallbackaction(){
        group.leave()
        hideIndicator()
        self.view.isUserInteractionEnabled = false
        DispatchQueue.global(qos: .background).sync {
            self.showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncResultsData, comment: ""), and: "")
            self.saveAnimalGroupUpdatedViewModel = AnimalGroupsForCustomerUpdateVM(callBack: self.navigateTosaveanimal)
            self.saveAnimalGroupUpdatedViewModel?.callAnimalGroupsForCustomerUpdateApi()
        }
    }
    
    //MARK: SELECTOR METHODS
    
    @objc func scanButtonAction() {
        barcodeScreen = true
        let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.cameraViewControllerVC) as? CameraViewController
        vc?.delegate = self
        self.present(vc!, animated: true, completion: nil)
    }
    
    @objc func searchDidChange(sender: UITextField) {
        self.searchForADHAnimal(seachText: sender.text ?? "")
    }
    
    @objc func methodOfReceivedNotification(notification: Notification){
        if value == 0{
            UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
            self.hideIndicator()
            value = value + 1
        }
    }
    
    @objc func buttonbgPressed (){
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
    @objc func checkForReachability(notification:Notification){
        let del =  UIApplication.shared.delegate as? AppDelegate
        self.statusText?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if statusText?.text == ButtonTitles.connectedText.localized{
            self.connectedBtnOutlet.isHidden = true
            self.connectionImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else {
            self.connectedBtnOutlet.isHidden = false
            self.connectionImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    //MARK: NAVIGATION METHODS
    
    func navigateTosaveanimal(){
        datasource.removeAll()
        myHerdArray   = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:Int64(customerId)) as! [ResultMyHerdData]
        if myHerdArray.count != 0 {
            for i in 0...myHerdArray.count - 1{
                let ab = callSwipeStruct(name: [myHerdArray[i]], color: .white, image: UIImage(named:ImageNames.threeDotsInactiveImg)!, backgroundGroup: UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0))
                datasource.append(ab)
            }
        }
        
        DispatchQueue.main.async { [self] in
            self.hideIndicator()
            self.hideIndicator()
            self.hideIndicator()
            self.hideIndicator()
            self.hideIndicator()
            self.hideIndicator()
            self.hideIndicator()
            self.hideIndicator()
            self.hideIndicator()
            self.totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: self.myHerdArray.count)
            self.view.isUserInteractionEnabled = true
            self.tblView.reloadData()
        }
    }
    
    func navigateToADHFilterControler(){
        if Connectivity.isConnectedToInternet() {
            let vc = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.adhFilterVC) as! ADHFilterVC
            vc.delegate = self
            vc.adhFilterDelegate = self
            if UserDefaults.standard.value(forKey: keyValue.checkFilter.rawValue) == nil {
                self.navigationController?.present(vc, animated: false, completion: nil)
            }
            else{
                let filteredData = fetchResultFilterData(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: Int(customerId ))
                for items in filteredData{
                    let newfetch = items as? ResultFIlterDataSave
                    let headerstring = newfetch?.header ?? ""
                    let traidstting = newfetch?.trait ?? ""
                    UserDefaults.standard.set(headerstring, forKey: keyValue.headerValue.rawValue)
                    UserDefaults.standard.set(traidstting, forKey: keyValue.traitValue.rawValue)
                    UserDefaults.standard.synchronize()
                }
                self.navigationController?.present(vc, animated: false, completion: nil)
            }
        }
        else{
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.connectToInternetStr, comment: ""))
        }
    }
    
    func navigateToOCRScanner() {
        let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.textScanVC) as? TextScanVC {
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func dissmissbackcall(){
        UserDefaults.standard.removeObject(forKey: keyValue.ADHFilterApplied.rawValue)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    //MARK: DATA HANDLING
    
    func fetchADHAnimalData() {
        self.viewModel.fetchADHAnimalList(userId: self.userId!, customerID: Int(self.customerId))
    }
    
    func removeAnimalInGroup(groupId:String,animalIds: String, completionHandler: @escaping  CompletionHandler){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict = [LocalizedStrings.authorizationHeader: accessToken!,LocalizedStrings.contentType : LocalizedStrings.formURLEncoded]
        let urlString = Configuration.Dev(packet: ApiKeys.removeAnimalsGroup.rawValue).getUrl()
        let parameters : [String: Any] = ["groupId": groupId,"animalIds":[animalIds]]
        var apiRequest = URLRequest(url: URL(string: urlString)! )
        apiRequest.httpMethod = "POST"
        apiRequest.allHTTPHeaderFields = headerDict
        apiRequest.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        do {
            apiRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch _ {
        }
        
        AF.request(apiRequest as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            if statusCode == 200 {
                switch response.result {
                case .success(_):
                    Date().saveCurrentDate()
                    return completionHandler(true)
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
    func getToDateFromDate() {
        let dateFormatter = DateFormatter()
        
        if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
            dateFormatter.dateFormat = DateFormatters.MMddyyyy0000Format
        } else {
            dateFormatter.dateFormat = DateFormatters.ddMMyyyy0000Format
        }
    }
    
    func swipeLeft(index: Int) {
        let dataObject = self.myHerdArray[index]
        let animalId = dataObject.animalID ?? ""
        let status = dataObject.status ?? ""
        let onfarmid = dataObject.onFarmID ?? ""
        let officialID = dataObject.officialID ?? ""
        let fetchActiveBarnExist = fetchGroupExistInDataBase(entityName: Entities.resultGroupCreateTblEntity, groupStatusId: 1, groupTypeId: 1, customerId: Int64(customerId ))
        
        if fetchActiveBarnExist.count == 0  {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.noActiveBarn, comment: "") )
            return
        }
        else {
            let fetchObject = fetchActiveBarnExist.object(at: 0) as! ResultGroupCreate
            let groupServerId = fetchObject.groupServerId ?? ""
            
            if status == LocalizedStrings.banStatus  {
                self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                removeAnimalInGroup(groupId: fetchObject.groupServerId ?? "", animalIds: animalId, completionHandler: { (result) in
                    if result {
                        _ = deletGroupInfoResult(entityName: Entities.resultGroupAnimalsTblEntity, groupName: fetchObject.groupName ?? "", customerId: dataObject.customerId, animalId: animalId, onFarmId: dataObject.onFarmID ?? "")
                        self.datasource[index].backgroundGroup = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
                        self.datasource[index].image = UIImage(named: ImageNames.threeDotsInactiveImg)!
                        updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ), animalID: animalId, status: LocalizedStrings.inactiveStatus)
                        self.myHerdArray = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:Int64(self.customerId )) as! [ResultMyHerdData]
                        self.tblView.reloadData()
                        self.hideIndicator()
                    }
                })
            } else {
                let data = fetchGroupIdupdateanimal(entityName: Entities.resultGroupAnimalsTblEntity, customerId:Int64(self.customerId ), groupTypeId: 0 ,onFarmId:onfarmid, officialID: officialID)
                if data.count > 0{
                    let datafetch = data.object(at: 0) as! ResultGroupsAnimals
                    let groupstatus = datafetch.groupStatusId
                    if groupstatus != 0{
                        self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                        removeAnimalInGroup(groupId: datafetch.serverGroupId ?? "", animalIds: animalId, completionHandler: { (result) in
                            if result {
                                _ = deletGroupInfoResultGroupDetail(entityName: Entities.resultGroupAnimalsTblEntity, groupName:datafetch.groupName ?? "", customerId: Int64(self.customerId ), onFarmId: datafetch.onFarmId ?? "", officalId: datafetch.officalId ?? "")
                            }
                        })
                    }
                }
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: LocalizedStrings.en_US_POSIXStr)
                dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                let date:Date? = dateFormatter.date(from:dataObject.dob ?? "")
                
                saveAnimaldataResult(entity: Entities.resultGroupAnimalsTblEntity, serverGroupId: groupServerId, groupName: fetchObject.groupName ?? "", groupStatusId: Int(fetchObject.groupStatusId), groupStatus: fetchObject.groupStatus ?? "", groupTypeId: Int(fetchObject.groupTypeId), groupTypeName: fetchObject.groupTypeName ?? "", animalID: animalId , onFarmId: dataObject.onFarmID ?? "", officalId: dataObject.officialID ?? "", dob: dataObject.dob ?? "", sex: dataObject.sex ?? "", breedId: dataObject.breedID ?? "", breedName: dataObject.breed ?? "", name: dataObject.name ?? "", groupId: 0, customerId: dataObject.customerId,datedob:date ?? Date())
                
                updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ), animalID: animalId, status: LocalizedStrings.banStatus)
                self.datasource[index].backgroundGroup = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0)
                self.datasource[index].image = UIImage(named: ImageNames.barnActiveImg)!
            }
        }
        self.hideIndicator()
        tblView.reloadData()
    }
    
    func swipeRight(index: Int) {
        let dataObject = datasource[index].name
        let animalId = dataObject[0].animalID ?? ""
        let status = dataObject[0].status ?? ""
        let onfarmid = dataObject[0].onFarmID ?? ""
        let officialId = dataObject[0].officialID ?? ""
        let fetchActiveBarnExist = fetchGroupExistInDataBase(entityName: Entities.resultGroupCreateTblEntity, groupStatusId: 1, groupTypeId: 0, customerId: Int64(customerId ))
        
        if fetchActiveBarnExist.count == 0  {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(LocalizedStrings.noActiveDoller, comment: "") )
            return
        } else {
            let fetchObject = fetchActiveBarnExist.object(at: 0) as! ResultGroupCreate
            let groupServerId = fetchObject.groupServerId ?? ""
            updateMyHerdData(entity: Entities.resultMyherdDataTblEntity, customerId : Int64(self.customerId ) ,animalID : animalId ,groupIDs : groupServerId)
            
            if status == LocalizedStrings.dollerStatus{
                self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                removeAnimalInGroup(groupId: fetchObject.groupServerId ?? "", animalIds: animalId, completionHandler: { (result) in
                    if result {
                        _ = deletGroupInfoResult(entityName: Entities.resultGroupAnimalsTblEntity, groupName: fetchObject.groupName ?? "", customerId: dataObject[0].customerId, animalId: animalId, onFarmId: dataObject[0].onFarmID ?? "")
                        self.datasource[index].image = UIImage(named: ImageNames.threeDotsInactiveImg)!
                        self.datasource[index].backgroundGroup = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
                        updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ), animalID: animalId, status: LocalizedStrings.inactiveStatus)
                        
                        self.myHerdArray = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:Int64(self.customerId)) as! [ResultMyHerdData]
                        self.tblView.reloadData()
                        self.hideIndicator()
                    }
                })
            }
            else {
                let data = fetchGroupIdupdateanimal(entityName: Entities.resultGroupAnimalsTblEntity, customerId:Int64(self.customerId ), groupTypeId: 1,onFarmId:onfarmid, officialID: officialId)
                if data.count > 0{
                    let datafetch = data.object(at: 0) as! ResultGroupsAnimals
                    let groupstatus = datafetch.groupStatusId
                    if groupstatus != 0{
                        self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                        removeAnimalInGroup(groupId: datafetch.serverGroupId ?? "", animalIds: animalId, completionHandler: { (result) in
                            if result {
                                _ = deletGroupInfoResultGroupDetail(entityName: Entities.resultGroupAnimalsTblEntity, groupName:datafetch.groupName ?? "", customerId: Int64(self.customerId ), onFarmId: datafetch.onFarmId ?? "", officalId: datafetch.officalId ?? "")
                            }
                        })
                    }
                }
                
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: LocalizedStrings.en_US_POSIXStr)
                dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                let date:Date? = dateFormatter.date(from:dataObject[0].dob ?? "")
                
                saveAnimaldataResult(entity: Entities.resultGroupAnimalsTblEntity, serverGroupId: groupServerId, groupName: fetchObject.groupName ?? "", groupStatusId: Int(fetchObject.groupStatusId), groupStatus: fetchObject.groupStatus ?? "", groupTypeId: Int(fetchObject.groupTypeId), groupTypeName: fetchObject.groupTypeName ?? "", animalID: animalId , onFarmId: dataObject[0].onFarmID ?? "", officalId: dataObject[0].officialID ?? "", dob: dataObject[0].dob ?? "", sex: dataObject[0].sex ?? "", breedId: dataObject[0].breedID ?? "", breedName: dataObject[0].breed ?? "", name: dataObject[0].name ?? "", groupId: 0, customerId: dataObject[0].customerId, datedob: date ?? Date())
                
                updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ), animalID: animalId, status: LocalizedStrings.dollerStatus)
                updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ), animalID: animalId, status: LocalizedStrings.dollerStatus)
                self.datasource[index].backgroundGroup = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0)
                self.datasource[index].image = UIImage(named: ImageNames.dollarActiveImg)!
            }
        }
        tblView.reloadData()
    }
    
    
    func searchForADHAnimal (seachText: String) {
        var filteredData = [AnimalMaster]()
        
        if seachText != "" {
            searchFound = true
            if (self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")) {
                filteredData  =  self.viewModel.adhAnimalData.filter { ($0.farmId?.lowercased())!.contains( seachText.lowercased())}
            }
            else if (clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: "")) {
                filteredData  =  self.viewModel.adhAnimalData.filter { ($0.animalTag?.lowercased())!.contains( seachText.lowercased())}
            }
            if(filteredData.count == 0) {
                message.isHidden = false
                cartIcon.isHidden = false
                tblView.isHidden = true
            } else  {
                showTotalCount()
                message.isHidden = true
                cartIcon.isHidden = true
                tblView.isHidden = false
                self.viewModel.filterAdhAnimalData = filteredData
                tblView.reloadData()
            }
            
        } else {
            searchFound = false
            if isADHFilterApplied ?? false {
                self.viewModel.fetchFilteredADHAnimalList(userId: self.userId!, customerID: Int(self.customerId), fromDate: self.filterFromDate ?? "", toDate: self.filterToDate ?? "", gender: self.filterGender ?? "", breedID: filterBreedId ?? "")
            } else {
                tblView.reloadData()
                message.isHidden = true
                cartIcon.isHidden = true
                tblView.isHidden = false
            }
        }
    }
    
    func saveAnimaltoCart(_ dataGet: AnimalMaster, orderID: Int) {
        let pvIdPrivate =  UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue)
        let userIdPrivate = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        var addonArr = NSArray()
        var addedd = Bool()
        let animalData = fetchAnimaldataDairy(entityName: Entities.animalAddTblEntity, animalTag:Int(dataGet.animalId ),orderId:orderID,userId:userIdPrivate)
        let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: Int(dataGet.providerId), breedId: dataGet.breedId ?? "" )
        
        for k in 0 ..< animalData.count{
            let animalId = animalData[k] as! AnimaladdTbl
            for i in 0 ..< product.count{
                let data = product[i] as! GetProductTbl
                if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                    let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:orderID, customerID: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue))
                    if data12333.count > 0 {
                        let adonDat =  fetchProductAdonDataWithBVDV(entityName: Entities.getAdonTblEntity, prodId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue),adonId : LocalizedStrings.bvdvAddOnId)
                        if adonDat.count > 0 {
                            addedd = true
                            saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvIdPrivate , status: "false", farmId:animalId.farmId ?? "", orderId: orderID, orderStatus: "false", isSync: "false", userId: userIdPrivate,udid:"", animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                            updateOrderStatusAnimal(entity: Entities.dataEntryAnimalAddTbl, status: "true", orderId: orderID, userId: userIdPrivate, animalId: Int(dataGet.animalId ))
                        }
                    }
                    else {
                        saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: Int(dataGet.providerId), status: "false", farmId:animalId.farmId ?? "", orderId: orderID, orderStatus: "false", isSync: "false", userId: userIdPrivate,udid:"", animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                    }
                }
                else {
                    saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId ?? "", productId:Int(data.productId) , productName: data.productName ?? "", providerId: Int(dataGet.providerId), status: "false",  farmId:animalId.farmId ?? "", orderId: orderID, orderStatus: "false", isSync: "false", userId: userIdPrivate,udid:"", animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                }
                
                if pvIdPrivate == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                    addonArr = fetchProductAdonData(entityName : Entities.getAdonTblEntity,prodId: Int(data.productId),isCdcbProduct:false)
                    
                } else {
                    addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                }
                
                for j in 0 ..< addonArr.count {
                    let addonDat = addonArr[j] as! GetAdonTbl
                    if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                        let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:orderID, customerID: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue))
                        if data12333.count > 0 {
                            if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: orderID, orderStatus: "false", isSync: "false", userId: userIdPrivate,udid:"", farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue), status: "true")
                                
                            }
                            else {
                                saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: orderID, orderStatus: "false", isSync: "false", userId: userIdPrivate,udid:"", farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                            }
                        }
                        else {
                            saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: orderID, orderStatus: "false", isSync: "false", userId: userIdPrivate,udid:"",  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                        }
                    }
                    else {
                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: orderID, orderStatus: "false", isSync: "false", userId: userIdPrivate,udid:"",  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                    }
                }
            }
            let autoIncrement = fetchFromAutoIncrement()
            let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:autoIncrement, customerID: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue))
            if data12333.count > 0 && !addedd {
                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAddedBVDV, comment: ""), preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    deleteDataWithProduct(Int(dataGet.animalId ))
                    deleteDataWithSubProduct(Int(dataGet.animalId ))
                    deleteDataWithAnimal(Int(dataGet.animalId ))
                    
                    let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(userIdPrivate),orderId:orderID,orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(dataGet.custmerId ), providerId: pvIdPrivate )
                    var bredidd123 = String ()
                    if animalCount.count > 0 {
                        let breeid1 = animalCount.object(at: 0) as! AnimaladdTbl
                        bredidd123 = breeid1.breedName ?? ""
                    }
                    
                    for i in 0 ..< animalCount.count{
                        let breeid1 = animalCount.object(at: i) as! AnimaladdTbl
                        if bredidd123 == breeid1.breedName {
                            bredidd123 = breeid1.breedName ?? ""
                            UserDefaults.standard.set(breeid1.breedId, forKey: keyValue.breedId.rawValue)
                        }
                    }
                }
                
                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    deleteDataWithProduct(Int(dataGet.animalId ))
                    deleteDataWithSubProduct(Int(dataGet.animalId ))
                    deleteDataWithAnimal(Int(dataGet.animalId ))
                    UserDefaults.standard.set("", forKey: keyValue.tsuKey.rawValue)
                    
                }
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
        }
        createDataList()
    }
}

