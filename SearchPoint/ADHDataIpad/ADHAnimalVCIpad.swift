//
//  ADHAnimalVCIpad.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 07/04/25.
//

import Foundation
import Vision
import VisionKit
import CoreBluetooth
import Alamofire
import MBProgressHUD
import CoreData
import Toast_Swift
import DropDown

//MARK: ADH ANIMAL VC
class ADHAnimalVCIpad: BaseViewController, VNDocumentCameraViewControllerDelegate{
    
    //MARK: IB OUTLETS
    @IBOutlet weak var sortByOfficialIDImgView: UIImageView!
    @IBOutlet weak var sortByOfficialIDBtn: UIButton!
    @IBOutlet weak var sortByFarmImgView: UIImageView!
    @IBOutlet weak var sortByFarmIDBtn: UIButton!
    @IBOutlet weak var sortByAscendingBtn: UIButton!
    @IBOutlet weak var sortByAscendingImgView: UIImageView!
    @IBOutlet weak var sortByDescendingBtn: UIButton!
    @IBOutlet weak var sortByDescendingImgView: UIImageView!
    @IBOutlet weak var sortByView: UIView!
    @IBOutlet weak var scanBarCodeButton: UIButton!
    @IBOutlet weak var scanBarCodeTextField: UITextField! {
        didSet{
          scanBarCodeTextField.keyboardType = .numbersAndPunctuation
          scanBarCodeTextField.delegate = self
        }
    }
    @IBOutlet weak var farmIdLbl: UILabel!
    @IBOutlet weak var barcodeView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var importList: UIButton!
    @IBOutlet weak var findMyAnimal: UIButton!
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var adhCollectionView: UICollectionView!
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
    var farmId = Int()
    var officialId = Int()
    var barcodeText = String()
    var adhCollectionViewCell : ADHListCollectionViewCell?
    var saveAnimalGroupUpdatedViewModel: AnimalGroupsForCustomerUpdateVM?
    var selectedDate = Date()
    var autoD = Int()
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
    var fromDaten = Date()
    var ToDaten = Date()
    let dropDown = DropDown()
    var lastIndex = -1
    var tempArray = Bool()
    var arrNearbyDevice : [CBPeripheral] = [] {
        didSet{
            
            pairedTableView?.reloadData()
        }
    }
    weak var importDelegate : ImportListProtocol?
    var BttnTag = Int()
    var datePicker : UIDatePicker!
    let toolBar = UIToolbar()
    var dateFrom = String()
    var dateTo = String()
    var fromdatecheck = String()
    var currentdate = String()
    var  todatecheck = String()
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
    var delegate: ADHCellProtocol?
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setButtonState(button: importList, isOn: false)
        self.setButtonState(button: findMyAnimal, isOn: true)
        self.searchTextField.setLeftPaddingPoints(20.0)
        self.scanBarCodeTextField.setLeftPaddingPoints(20.0)
        bottomView.layer.shadowColor = UIColor.gray.cgColor
        bottomView.layer.shadowOpacity = 5
        bottomView.layer.shadowOffset = CGSize.zero
        bottomView.layer.shadowRadius = 35
        langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
        
        self.userId = UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int
        
        switch pvid {
        case 1 :
            clickOnDropDown = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
            self.sortByFarmImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
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
//        tblView.estimatedRowHeight = 65
//        tblView.rowHeight = UITableView.automaticDimension
        
        setupLangaugeBR()
        setupClosures()
        hideAllEmptyTextFields()
        self.fetchADHAnimalData()
        showTotalCount()
        
    }
    @objc func searchDidChange(sender: UITextField) {
        self.searchForADHAnimal(seachText: sender.text ?? "")
    }
    
    func setupLangaugeBR() {
        
//        screenTitleLbl.text = NSLocalizedString(LocalizedStrings.findMyAnimalText, comment: "")
//        lblTitleSortBy.text = NSLocalizedString(ButtonTitles.sortByText, comment: "")
//        
//        btnClearList.setTitle(NSLocalizedString(LocalizedStrings.clearAllText, comment: ""), for: .normal)
//        btnSubmitAnimal.setTitle(NSLocalizedString(ButtonTitles.addAnimalText, comment: ""), for: .normal)
        
    }
    
    func setupClosures() {
        viewModel.redirectControllerClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.hideIndicator()
                if self?.viewModel.adhAnimalData.count == 0 {
                   // self?.tblView.isHidden = true
                    self?.adhCollectionView.isHidden = true
                    self?.message.isHidden = false
                   // self?.cartIcon.isHidden = false
                } else {
                  //  self?.tblView.isHidden = false
                    self?.message.isHidden = true
                 //   self?.cartIcon.isHidden = true
                    self?.adhCollectionView.reloadData()
                    self?.adhCollectionView.isHidden = false
                    
                  //  self?.tblView.reloadData()
                }
            }
        }
    }
    
    func hideAllEmptyTextFields() {
        self.viewModel.updateADhListToHideExpansion()
    }
    
    func fetchADHAnimalData() {
        self.viewModel.fetchADHAnimalList(userId: self.userId!, customerID: Int(self.customerId))
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
    
    @objc func scanButtonAction() {
        barcodeScreen = true
        let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.cameraViewControllerVC) as? CameraViewController
        vc?.delegate = self
        self.present(vc!, animated: true, completion: nil)
    }
    
    func removeAnimalInGroup(groupId:String,animalIds: String, completionHandler: @escaping  CompletionHandler){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict = [LocalizedStrings.authorizationHeader: accessToken!,LocalizedStrings.contentType : LocalizedStrings.formURLEncoded]
        let urlString = Configuration.Dev(packet: ApiKeys.removeAnimalsGroup.rawValue).getUrl()
        let parameters : [String: Any] = ["groupId": groupId,"animalIds":[animalIds]]
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headerDict
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch _ {
        }
        
        AF.request(request as URLRequestConvertible).responseJSON { response in
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
        return
    }
    
    func getToDateFromDate() {
        var dateFormatter = DateFormatter()
        dateFormatter = DateFormatter()
        if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
            dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
        } else {
            dateFormatter.dateFormat = DateFormatters.ddMMyyyyFormat
        }
        
        dateFormatter = DateFormatter()
        if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
            dateFormatter.dateFormat = DateFormatters.MMddyyyy0000Format
        } else {
            dateFormatter.dateFormat = DateFormatters.ddMMyyyy0000Format
        }
    }
    
    func breednameset(){}
    
    @objc func methodOfReceivedNotification(notification: Notification){
        if value == 0{
            UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
            let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
            self.hideIndicator()
            value = value + 1
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.farmId = 0
        self.officialId = 0
        updateCartCount()
    }
    
    func navigateToAnotherVc143(){
        group.leave()
        hideIndicator()
        self.view.isUserInteractionEnabled = false
        DispatchQueue.global(qos: .background).sync {
            self.showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncResultsData, comment: ""), and: "")
            self.saveAnimalGroupUpdatedViewModel = AnimalGroupsForCustomerUpdateVM( callBack: self.navigateTosaveanimal)
            self.saveAnimalGroupUpdatedViewModel?.callAnimalGroupsForCustomerUpdateApi()
        }
    }
    
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
           // self.tblView.reloadData()
            self.adhCollectionView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hideIndicator()
        super.viewDidAppear(animated)
      //  tblView.reloadData()
        self.adhCollectionView.reloadData()
      //  tblView.estimatedRowHeight = 40.0
      //  tblView.rowHeight = UITableView.automaticDimension
      //  tblView.separatorStyle = .none
        fetchFilterData = fetchResultFilterData(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: Int(customerId ))
        fetchTempObj1new = fetchAllData(entityName: Entities.resultPageByTraitTblEntity)
        if fetchFilterData.count == 0{
            if bckRetain == false {
             //   navigateToADHFilterControler()
            }
        }
    }
    
    func updateCartCount() {
        let orderId  = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: 1,orderId:orderId,orderStatus:"false", providerId: pvid)
        self.cartCountLbl.text = String(animalCount.count)
        if animalCount.count == 0 {
            self.cartCountLbl.isHidden = true
            self.cartButton.isHidden = true
            self.cartView.isHidden = true
        } else {
            self.cartCountLbl.isHidden = false
            self.cartButton.isHidden = false
            self.cartView.isHidden = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.standard.removeObject(forKey: keyValue.fromManagement.rawValue)
    }
    
    func dissmissbackcall(){
        UserDefaults.standard.removeObject(forKey: keyValue.ADHFilterApplied.rawValue)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
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
                    if result == true{
                        _ = deletGroupInfoResult(entityName: Entities.resultGroupAnimalsTblEntity, groupName: fetchObject.groupName ?? "", customerId: dataObject.customerId, animalId: animalId, onFarmId: dataObject.onFarmID ?? "")
                        self.datasource[index].backgroundGroup = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
                        self.datasource[index].image = UIImage(named: ImageNames.threeDotsInactiveImg)!
                        updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ), animalID: animalId, status: LocalizedStrings.inactiveStatus)
                        self.myHerdArray = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:Int64(self.customerId )) as! [ResultMyHerdData]
                   //     self.tblView.reloadData()
                        self.adhCollectionView.reloadData()
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
                            if result == true{
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
      //  tblView.reloadData()
        self.adhCollectionView.reloadData()
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
                    if result == true{
                        _ = deletGroupInfoResult(entityName: Entities.resultGroupAnimalsTblEntity, groupName: fetchObject.groupName ?? "", customerId: dataObject[0].customerId, animalId: animalId, onFarmId: dataObject[0].onFarmID ?? "")
                        self.datasource[index].image = UIImage(named: ImageNames.threeDotsInactiveImg)!
                        self.datasource[index].backgroundGroup = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
                        updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ), animalID: animalId, status: LocalizedStrings.inactiveStatus)
                        
                        self.myHerdArray = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:Int64(self.customerId)) as! [ResultMyHerdData]
                      //  self.tblView.reloadData()
                        self.adhCollectionView.reloadData()
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
                            if result == true{
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
      //  tblView.reloadData()
        self.adhCollectionView.reloadData()
    }
    
    func tablereload(){
        myHerdArray   = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:Int64(customerId)) as! [ResultMyHerdData]
        totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: myHerdArray.count)
        self.adhCollectionView.isHidden = true
        self.adhCollectionView.reloadData()
    //    tblView.isHidden = true
      //  tblView.reloadData()
    }
    
    func navigateToADHFilterControler(){
        if Connectivity.isConnectedToInternet() {
            let vc = UIStoryboard.init(name: "DairyPlaceAnOrder", bundle: Bundle.main).instantiateViewController(withIdentifier: "ADHFilteriPadVC") as? ADHFilteriPadVC
           
            vc?.delegate = self
            vc?.adhFilterDelegate = self
           // vc?.modalPresentationStyle = .formSheet
            vc?.preferredContentSize = CGSize(width: 700, height: 600)
            if UserDefaults.standard.value(forKey: keyValue.checkFilter.rawValue) == nil {
                self.navigationController?.present(vc!, animated: false, completion: nil)
            }
            
        }
        else{
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.connectToInternetStr, comment: ""))
            return
        }
        
    }
    
    private func setUpGallary(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imgPhotoLib = UIImagePickerController()
            imgPhotoLib.delegate = self
            imgPhotoLib.allowsEditing = true
            imgPhotoLib.sourceType = .camera
            self.present(imgPhotoLib,animated: true,completion: nil)
        }
    }
    
    func setVisionTextRecognizeImage(image: UIImage){
        var textStr = ""
        request = VNRecognizeTextRequest(completionHandler: {(request,error)in
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                fatalError("Received invalid observation")
            }
            for observation in observations{
                guard let topCandidate = observation.topCandidates(1).first else{
                    continue
                }
                textStr += "\n\(topCandidate.string)"
                DispatchQueue.main.async {
                    if self.searchTextField.tag == 0 {
                        let trimmed = String(textStr.compactMap({ $0.isWhitespace ? nil : $0 }))
                        let test = String(trimmed.filter{!"\n\t\r(),.-[]:}{".contains($0)})
                        self.searchTextField.text = ""
                        self.imageView.isHidden = true
                        var mesageShow = String()
                        mesageShow = LocalizedStrings.unableToReadValue.localized(with: test)
                        
                        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: mesageShow, preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: NSLocalizedString("Retry", comment: ""), style: UIAlertAction.Style.default, handler: {
                            (_)in
                            let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil) //
                            let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.textScanVC) as? TextScanVC
                            vc?.delegate = self
                            self.navigationController?.pushViewController(vc!, animated: true)
                            
                        })
                        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "") , style: UIAlertAction.Style.default, handler: {
                            (_)in
                        })
                        let thirdAction = UIAlertAction(title: NSLocalizedString(LocalizedStrings.useScannedValue, comment: ""), style: UIAlertAction.Style.default, handler: {
                            (_)in
                            self.searchTextField.text = test
                            self.imageView.isHidden = true
                            self.searchTextField.returnKeyType = UIReturnKeyType.done
                            self.searchTextField.delegate = self
                            self.searchTextField.tag = 1
                            self.textFieldDidEndEditing(self.searchTextField)
                        })
                        alert.addAction(OKAction)
                        alert.addAction(cancelAction)
                        alert.addAction(thirdAction)
                        self.present(alert, animated: true, completion: nil)
                        return
                    }
                    else {
                        let trimmed = String(textStr.compactMap({ $0.isWhitespace ? nil : $0 }))
                        let test = String(trimmed.filter{!"\n\t\r(),.-[]:}{".contains($0)})
                        self.searchTextField.text = ""
                        var mesageShow = String()
                        mesageShow = LocalizedStrings.unableToReadValue.localized(with: test)
                        
                        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: mesageShow, preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: NSLocalizedString("Retry", comment: ""), style: UIAlertAction.Style.default, handler: {
                            (_)in
                            let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil) //
                            let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.textScanVC) as? TextScanVC
                            vc?.delegate = self
                            self.navigationController?.pushViewController(vc!, animated: true)
                            
                        })
                        let cancelAction = UIAlertAction(title:NSLocalizedString("Cancel", comment: "") , style: UIAlertAction.Style.default, handler: {
                            (_)in
                        })
                        let thirdAction = UIAlertAction(title: NSLocalizedString(NSLocalizedString(LocalizedStrings.useScannedValue, comment: ""), comment: ""), style: UIAlertAction.Style.default, handler: {
                            (_)in
                            
                            self.searchTextField.text = test
                            self.imageView.isHidden = true
                            self.textFieldDidEndEditing(self.searchTextField)
                            self.searchTextField.delegate = self
                        })
                        
                        alert.addAction(OKAction)
                        alert.addAction(cancelAction)
                        alert.addAction(thirdAction)
                        self.present(alert, animated: true, completion: nil)
                        return
                    }
                    self.imageView.isHidden = true
                    self.searchTextField.becomeFirstResponder()
                }
            }
        })
        
        request.customWords = ["custOm"]
        request.minimumTextHeight = 0.03125
        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["en_US"]
        request.usesLanguageCorrection = true
        let requests = [request]
        DispatchQueue.global(qos: .userInitiated).async {
            guard let img1 = image.cgImage else{
                fatalError("Missing image to scan")
            }
            let handle = VNImageRequestHandler(cgImage: img1, options: [:])
            try?handle.perform(requests)
        }
    }
    
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
              //  cartIcon.isHidden = false
            //    tblView.isHidden = true
                self.adhCollectionView.isHidden = true
            } else  {
                showTotalCount()
                message.isHidden = true
              //  cartIcon.isHidden = true
             //   tblView.isHidden = false
                adhCollectionView.isHidden = false
                self.viewModel.filterAdhAnimalData = filteredData
              //  tblView.reloadData()
                self.adhCollectionView.reloadData()
            }
            
        } else {
            searchFound = false
            if isADHFilterApplied ?? false {
                self.viewModel.fetchFilteredADHAnimalList(userId: self.userId!, customerID: Int(self.customerId), fromDate: self.filterFromDate ?? "", toDate: self.filterToDate ?? "", gender: self.filterGender ?? "", breedID: filterBreedId ?? "")
            } else {
              //  tblView.reloadData()
                if filteredData.count > 0 {
                    self.adhCollectionView.isHidden = false
                    self.adhCollectionView.reloadData()
                    message.isHidden = true
                } else {
                    self.adhCollectionView.isHidden = true
                    message.isHidden = false
                }
         
               // cartIcon.isHidden = true
              //  tblView.isHidden = false
            }
        }
    }
    
    func SaveAnimaltoCart(_ dataGet: AnimalMaster, orderID: Int) {
        let pvid =  UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue)
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        var addonArr = NSArray()
        var addedd = Bool()
        let animalData = fetchAnimaldataDairy(entityName: Entities.animalAddTblEntity, animalTag:Int(dataGet.animalId ),orderId:orderID,userId:userId)
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
                            saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid , status: "false", farmId:animalId.farmId ?? "", orderId: orderID, orderStatus: "false", isSync: "false", userId: userId,udid:"", animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                            updateOrderStatusAnimal(entity: Entities.dataEntryAnimalAddTbl, status: "true", orderId: orderID, userId: userId, animalId: Int(dataGet.animalId ))
                        }
                    }
                    else {
                        saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: Int(dataGet.providerId), status: "false", farmId:animalId.farmId ?? "", orderId: orderID, orderStatus: "false", isSync: "false", userId: userId,udid:"", animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                    }
                }
                else {
                    saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId ?? "", productId:Int(data.productId) , productName: data.productName ?? "", providerId: Int(dataGet.providerId), status: "false",  farmId:animalId.farmId ?? "", orderId: orderID, orderStatus: "false", isSync: "false", userId: userId,udid:"", animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                }
                
                if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
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
                                saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: orderID, orderStatus: "false", isSync: "false", userId: userId,udid:"", farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue), status: "true")
                                
                            }
                            else {
                                saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: orderID, orderStatus: "false", isSync: "false", userId: userId,udid:"", farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                            }
                        }
                        else {
                            saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: orderID, orderStatus: "false", isSync: "false", userId: userId,udid:"",  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                        }
                    }
                    else {
                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: orderID, orderStatus: "false", isSync: "false", userId: userId,udid:"",  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                    }
                }
            }
            let autoD = fetchFromAutoIncrement()
            let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:autoD, customerID: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue))
            if data12333.count > 0 {
                if addedd == false {
                    
                    let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAddedBVDV, comment: ""), preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        deleteDataWithProduct(Int(dataGet.animalId ))
                        deleteDataWithSubProduct(Int(dataGet.animalId ))
                        deleteDataWithAnimal(Int(dataGet.animalId ))
                        
                        let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(userId),orderId:orderID,orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(dataGet.custmerId ), providerId: pvid )
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
                        return
                    }
                    
                    let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        deleteDataWithProduct(Int(dataGet.animalId ))
                        deleteDataWithSubProduct(Int(dataGet.animalId ))
                        deleteDataWithAnimal(Int(dataGet.animalId ))
                        UserDefaults.standard.set("", forKey: keyValue.tsuKey.rawValue)
                        return
                    }
                    alertController.addAction(okAction)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
            }
        }
        createDataList()
    }
    
    func setButtonState(button : UIButton, isOn : Bool) {
        if isOn {
            button.isSelected = true
            button.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1.0)
            button.layer.borderColor = UIColor.clear.cgColor
            button.setTitleColor(UIColor.white, for: .selected)
        }
        else {
            button.isSelected = false
            button.backgroundColor = UIColor.white
            button.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
            button.setTitleColor(UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1.0), for: .normal)
            
        }
    }
}
