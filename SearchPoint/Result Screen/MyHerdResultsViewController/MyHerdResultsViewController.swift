//
//  MyHerdResultsViewController.swift
//  SearchPoint
//
//  Created by Mobile Programming on 05/03/21.
//

import UIKit
import Vision
import VisionKit
import CoreBluetooth
import Alamofire
import MBProgressHUD
import CoreData
import Toast_Swift

var stopPagination : Bool = false

// MARK: - CLASS
class MyHerdResultsViewController: UIViewController, VNDocumentCameraViewControllerDelegate{
    
    // MARK: - OUTLETS
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var totalAnimalCount: UILabel!
    @IBOutlet weak var bckBtnOutlet: customButton!
    @IBOutlet weak var screenTitleLbl: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var officalIdLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var calendarViewBkg: UIView!
    @IBOutlet weak var blebttn1: UIButton!
    @IBOutlet weak var connectedBtnOutlet: UIButton!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var connectionImg: UIImageView!
    @IBOutlet weak var headerstackview: UIStackView!
    @IBOutlet weak var pairedBackroundView: UIView!
    @IBOutlet weak var pairedDeviceTitle: UILabel!
    @IBOutlet weak var pairedTableView: UITableView!
    @IBOutlet weak var pairedDeviceView: UIView!
    @IBOutlet weak var providerFilterBtnOutlet: customButton!
    @IBOutlet weak var breedFilterBtnOutlet: customButton!
    @IBOutlet weak var dateFilterBtnOutlet: customButton!
    @IBOutlet weak var sexFilterBtnOutlet: customButton!
    @IBOutlet weak var rfidBtnOutlet: customButton!
    
    // MARK: - VARIABLES AND CONSTANTS
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
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    var value = 0
    var selectedbreedID = String()
    var saveAnimalGroupUpdatedViewModel: AnimalGroupsForCustomerUpdateVM?
    var productArray = [String]()
    var providerarray = [Int]()
    var breedArray = [String]()
    var breedIDArray = [String]()
    var breedName = String()
    var breedID = String()
    var productName = String()
    var providerID = Int()
    var checkid = String()
    var bckRetain = Bool()
    var resultMasterGet = [ResultMasterTemplate]()
    var request = VNRecognizeTextRequest(completionHandler: nil)
    var myTableView: UITableView!
    var datasource = [callSwipeStruct]()
    var myHerdArray = [ResultMyHerdData]()
    var sexname : String!
    var tempArray = Bool()
    var arrNearbyDevice : [CBPeripheral] = [] {
        didSet{
            
            pairedTableView?.reloadData()
        }
    }
    var ranktitle : String?
    var BttnTag = Int()
    var datePicker : UIDatePicker!
    let toolBar = UIToolbar()
    var dateFrom = String()
    var dateTo = String()
    var fromdatecheck = String()
    var currentdate = String()
    var  todatecheck = String()
    let dateFormatter3 = DateFormatter()
    var custmerID = Int64()
    var customerId:Int64?
    var userId : Int?
    var langId : Int?
    var textRecognitionRequest = VNRecognizeTextRequest(completionHandler: nil)
    private let textRecognitionWorkQueue = DispatchQueue(label: "MyVisionScannerQueue", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
    var fetchFilterData = NSArray()
    var fetchTempObj1new = NSArray()
    var qrData: QRData? = nil {
        didSet {
            if qrData != nil {
                searchTextField.text = qrData?.codeString
                
            }else {
                
            }
        } willSet {
        }
    }
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIOnDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setUIOnDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        UserDefaults.standard.removeObject(forKey: keyValue.fromManagement.rawValue)
    }
    
    // MARK: - INITIAL UI METHODS
    func setUIOnDidLoad(){
        showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncResultsData, comment: ""), and: "")
        datasource.removeAll()
        UserDefaults.standard.set(0, forKey: keyValue.breedIndex.rawValue)
        langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
        self.customerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64
        self.userId = UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int
        self.navigationController?.navigationBar.isHidden = true
        self.calenderView.isHidden = true
        self.calendarViewBkg.isHidden = true
        pairedDeviceView.isHidden = true
        pairedBackroundView.isHidden = true
        initialNetworkCheck()
        searchTextField.autocorrectionType = .yes
    }
    
    func setUIOnDidAppear(){
        hideIndicator()
        hideIndicator()
        fetchFilterData = fetchResultFilterData(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: Int(customerId ?? 0))
        fetchTempObj1new = fetchAllData(entityName: Entities.resultPageByTraitTblEntity)
        if fetchFilterData.count == 0{
            myFilterController = MyHerdFilterController()
            myFilterController?.delegate = self
            if !bckRetain {
                navigateToMyherfFilterControler()
            }
        }
        else{
            for items in fetchFilterData{
                let newfetch = items as? ResultFIlterDataSave
                let sex = newfetch?.sex ?? ""
                let dateto = newfetch?.dateto ?? ""
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = DateFormatters.yyyyMMddTHHmmssFormat
                let  datetofromate  = dateFormatter.date(from: dateto)!
                if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                    dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                } else {
                    dateFormatter.dateFormat = DateFormatters.ddMMyyyyFormat
                }
                
                let datetostring = dateFormatter.string(from: datetofromate)
                let datefrom = newfetch?.datefrom ?? ""
                dateFormatter.dateFormat = DateFormatters.yyyyMMddTHHmmssFormat
                let  datefromfromate  = dateFormatter.date(from: datefrom)!
                if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                    dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                } else {
                    dateFormatter.dateFormat = DateFormatters.ddMMyyyyFormat
                }
                
                let datefromstring = dateFormatter.string(from: datefromfromate)
                let traidname = newfetch?.traidsave ?? ""
                providerFilterBtnOutlet.setTitle(newfetch?.productName, for: .normal)
                
                if (newfetch?.breedName?.components(separatedBy: ",").count ?? 0) > 1{
                    breedFilterBtnOutlet.setTitle(ButtonTitles.multipleBreedsText, for: .normal)
                }else{
                    breedFilterBtnOutlet.setTitle(newfetch?.breedName ?? "", for: .normal)
                }
                let stringdate = datefromstring + " - " + datetostring
                dateFilterBtnOutlet.setTitle(stringdate, for: .normal)
                if  sex == "F" {
                    sexFilterBtnOutlet .setTitle(ButtonTitles.femaleText.localized, for: .normal)
                }
                else if sex == "M"{
                    sexFilterBtnOutlet .setTitle(ButtonTitles.maleText.localized, for: .normal)
                }
                
                else if sex == "A"{
                    sexFilterBtnOutlet .setTitle(ButtonTitles.allText.localized, for: .normal)
                }
                let checkid = newfetch?.idselection ?? ""
                if checkid == LocalizedStrings.officialCheckId{
                    rankLabel.text = "        \(traidname)"
                }
                else{
                    rankLabel.text = " \(traidname)"
                }
                
                myHerdArray   = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:customerId ?? 0) as! [ResultMyHerdData]
                if myHerdArray.count == 0{
                    hideIndicator()
                    hideIndicator()
                    showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncDataLabel, comment: ""), and: "")
                    group.enter()
                    saveResulyByPageViewModel = ResulyByPageViewModel(callBack: resultcallbackaction)
                    saveResulyByPageViewModel?.callResultByPageAnimalApi()
                }
            }
        }
        
        myHerdArray   = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:customerId ?? 0) as! [ResultMyHerdData]
        totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: myHerdArray.count)
        
        if myHerdArray.count == 0{
            message.isHidden = false
            tblView.isHidden = true
            headerview.isHidden = true
        }
        if myHerdArray.count != 0 {
            message.isHidden = true
            tblView.isHidden = false
            headerview.isHidden = false
            datasource.removeAll()
            for i in 0...myHerdArray.count - 1{
                let ab = callSwipeStruct(name: [myHerdArray[i]], color: .white, image: UIImage(named:ImageNames.threeDotsInactiveImg)!, backgroundGroup: UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0))
                datasource.append(ab)
            }
        }
        
        screenTitleLbl.text = ButtonTitles.myHerdResultText.localized
        bckBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.backBtnText, comment: ""), for: .normal)
        officalIdLabel.text = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
        groupLabel.text = ButtonTitles.groupText.localized
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        UserDefaults.standard.setValue("", forKey: keyValue.del.rawValue)
        UserDefaults.standard.set("", forKey: keyValue.checkGroup.rawValue)
        UserDefaults.standard.set("", forKey: keyValue.groupDetails.rawValue)
        
        if UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue {
            blebttn1.setBackgroundImage(UIImage(named: ImageNames.ocrInactiveImg), for: .normal)
        }
        else {
            if BluetoothCentre.shared.smartBowPeripheral?.state == .connected{
                blebttn1.setBackgroundImage(UIImage(named: ImageNames.forma1Copy2Img), for: .normal)
                
            } else {
                blebttn1.setBackgroundImage(UIImage(named: ImageNames.scanIconActiveImg), for: .normal)
            }
        }
        BluetoothCentre.shared.navController = self
        BluetoothCentre.shared.manager.scanForPeripherals(withServices: nil, options: nil)
        self.navigationController?.navigationBar.isHidden = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        BluetoothCentre.shared.delegateRFID  = self
        BluetoothCentre.shared.nearByDeviceDelegate  = self
        datasource.removeAll()
        myHerdArray   = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:customerId ?? 0) as! [ResultMyHerdData]
        if searchTextField.text != ""{
            myHerdArray = fetchOrdersWithMyHerdFilter(entityName: Entities.resultMyherdDataTblEntity, searchText:  (searchTextField.text ?? ""),customerId: Int64(customerId ?? 0)) as! [ResultMyHerdData]
        }
        
        if myHerdArray.count != 0 {
            for i in 0...myHerdArray.count - 1{
                let ab = callSwipeStruct(name: [myHerdArray[i]], color: .white, image: UIImage(named:ImageNames.threeDotsInactiveImg)!, backgroundGroup: UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0))
                datasource.append(ab)
            }
        }
        tblView.reloadData()
        tblView.delegate = self
        tblView.dataSource = self
    }
    
    // MARK: - OBJC SELECTOR METHODS
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
        if statusText?.text == ButtonTitles.connectedText.localized {
            self.connectedBtnOutlet.isHidden = true
            self.connectionImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else {
            self.connectedBtnOutlet.isHidden = false
            self.connectionImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    // MARK: - NAVIGATION METHODS
    func navigateToMyherfFilterControler(){
        if Connectivity.isConnectedToInternet(){
            let vc = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.myHerdFilterControllerVC) as! MyHerdFilterController
            vc.delegate = self
            
            if UserDefaults.standard.value(forKey: keyValue.checkFilter.rawValue) == nil{
                self.navigationController?.present(vc, animated: false, completion: nil)
            }
            else{
                let fetchFilterData = fetchResultFilterData(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: Int(customerId ?? 0))
                
                for items in fetchFilterData{
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
            return
        }
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
        myHerdArray   = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:customerId ?? 0) as! [ResultMyHerdData]
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
            totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: myHerdArray.count)
            self.view.isUserInteractionEnabled = true
            self.tblView.reloadData()
        }
    }
    
    // MARK: - API CALL BACK AND OTHER METHODS
    func resultcallbackaction(){
        fetchFilterData = fetchResultFilterData(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: Int(customerId ?? 0))
        fetchTempObj1new = fetchAllData(entityName: Entities.resultPageByTraitTblEntity)
        group.leave()
        hideIndicator()
        self.view.isUserInteractionEnabled = false
        DispatchQueue.global(qos: .background).sync {
            self.showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncResultsData, comment: ""), and: "")
            self.saveAnimalGroupUpdatedViewModel = AnimalGroupsForCustomerUpdateVM(callBack: self.navigateTosaveanimal)
            self.saveAnimalGroupUpdatedViewModel?.callAnimalGroupsForCustomerUpdateApi()
        }
    }
    
    func removeAnimalInGroup(groupId:String,animalIds: String, completionHandler: @escaping  CompletionHandler){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict = [LocalizedStrings.authorizationHeader: accessToken!,LocalizedStrings.contentType : LocalizedStrings.formURLEncoded]
        let urlString = Configuration.Dev(packet: ApiKeys.removeAnimalsGroup.rawValue).getUrl()
        let parameters : [String: Any] = [keyValue.groupId.rawValue: groupId,"animalIds":[animalIds]]
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
        
        let toDateBttn = dateFormatter.string(from: Date())
        let previousMonth = Calendar.current.date(byAdding: .month, value: -15, to: Date())
        let fromDateBttn = dateFormatter.string(from: previousMonth!)
        let showDate = fromDateBttn + " - " + toDateBttn
        dateFilterBtnOutlet.setTitle(showDate, for: .normal)
        dateFormatter = DateFormatter()
        if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
            dateFormatter.dateFormat = DateFormatters.MMddyyyy0000Format
        } else {
            dateFormatter.dateFormat = DateFormatters.ddMMyyyy0000Format
        }
    }
    
    func breednameset(){
        custmerID = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64 ?? 0
        let fetchFilterData = fetchResultFilterData1(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: Int(custmerID),isheridity: UserDefaults.standard.bool(forKey: keyValue.isHerditySelected.rawValue), productID: providerID)
        for items in fetchFilterData{
            let newfetch = items as? ResultFIlterDataSave
            if (newfetch?.breedName?.components(separatedBy: ",").count ?? 0) > 1{
                breedFilterBtnOutlet.setTitle(ButtonTitles.multipleBreedsText.localized, for: .normal)
            }else{
                breedFilterBtnOutlet.setTitle(newfetch?.breedName, for: .normal)
            }
        }
        
        showIndicator(self.view, withTitle: NSLocalizedString("Syncing data...", comment: ""), and: "")
        group.enter()
        saveResulyByPageViewModel = ResulyByPageViewModel(callBack: resultcallbackactionResult)
        saveResulyByPageViewModel?.myherdresult = self
        saveResulyByPageViewModel?.callResultByPageAnimalApi()
    }
    
    func resultcallbackactionResult(){
        
        group.leave()
        hideIndicator()
        self.reloaddata()
    }
    
    func dissmissbackcall(){
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    func tablereload(){
        myHerdArray   = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:customerId ?? 0) as! [ResultMyHerdData]
        
        totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: myHerdArray.count)
        tblView.isHidden = true
        tblView.reloadData()
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
    
    private func setVisionTextRecognizeImage(image: UIImage){
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
                            let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
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
                            let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
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
}

// MARK: - SWIPE CELL EXTENSION
extension MyHerdResultsViewController : swipeCell {
    func swipeLeft(index: Int) {
        let cell : MyHerdTblCell = self.tblView.cellForRow(at: IndexPath(row: index, section: 0)) as! MyHerdTblCell
        let dataObject = self.myHerdArray[index]
        let animalId = dataObject.animalID ?? ""
        let status = dataObject.status ?? ""
        let onfarmid = dataObject.onFarmID ?? ""
        let officialID = dataObject.officialID ?? ""
        let fetchActiveBarnExist = fetchGroupExistInDataBase(entityName: Entities.resultGroupCreateTblEntity, groupStatusId: 1, groupTypeId: 1, customerId: Int64(customerId ?? 0))
        
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
                        updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ?? 0), animalID: animalId, status: LocalizedStrings.inactiveStatus)
                    }
                })
                self.myHerdArray = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:self.customerId ?? 0) as! [ResultMyHerdData]
                self.datasource[index].backgroundGroup = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
                self.datasource[index].image = UIImage(named: ImageNames.threeDotsInactiveImg)!
                cell.groupView.layer.backgroundColor  = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0).cgColor
                cell.groupImage.image = UIImage(named: ImageNames.threeDotsInactiveImg)!
            }
            else {
                let data = fetchGroupIdupdateanimal(entityName: Entities.resultGroupAnimalsTblEntity, customerId:Int64(self.customerId ?? 0), groupTypeId: 0 ,onFarmId:onfarmid, officialID: officialID)
                
                if data.count > 0{
                    let datafetch = data.object(at: 0) as! ResultGroupsAnimals
                    let groupstatus = datafetch.groupStatusId
                    if groupstatus != 0{
                        self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                        removeAnimalInGroup(groupId: datafetch.serverGroupId ?? "", animalIds: animalId, completionHandler: { (result) in
                            if result {
                                _ = deletGroupInfoResultGroupDetail(entityName: Entities.resultGroupAnimalsTblEntity, groupName:datafetch.groupName ?? "", customerId: Int64(self.customerId ?? 0), onFarmId: datafetch.onFarmId ?? "", officalId: datafetch.officalId ?? "")
                            }
                        })
                    }
                }
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: LocalizedStrings.en_US_POSIXStr)
                dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                
                let date:Date? = dateFormatter.date(from:dataObject.dob ?? "")
                saveAnimaldataResult(entity: Entities.resultGroupAnimalsTblEntity, serverGroupId: groupServerId, groupName: fetchObject.groupName ?? "", groupStatusId: Int(fetchObject.groupStatusId), groupStatus: fetchObject.groupStatus ?? "", groupTypeId: Int(fetchObject.groupTypeId), groupTypeName: fetchObject.groupTypeName ?? "", animalID: animalId , onFarmId: dataObject.onFarmID ?? "", officalId: dataObject.officialID ?? "", dob: dataObject.dob ?? "", sex: dataObject.sex ?? "", breedId: dataObject.breedID ?? "", breedName: dataObject.breed ?? "", name: dataObject.name ?? "", groupId: 0, customerId: dataObject.customerId,datedob:date ?? Date())
                
                updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ?? 0), animalID: animalId, status: LocalizedStrings.banStatus)
                self.datasource[index].backgroundGroup = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0)
                self.datasource[index].image = UIImage(named: ImageNames.barnActiveImg)!
                cell.groupView.layer.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0).cgColor
                cell.groupImage.image = UIImage(named: ImageNames.barnActiveImg)!
            }
        }
        self.hideIndicator()
    }
    
    func swipeRight(index: Int) {
        let cell : MyHerdTblCell = self.tblView.cellForRow(at: IndexPath(row: index, section: 0)) as! MyHerdTblCell
        let dataObject = datasource[index].name
        let animalId = dataObject[0].animalID ?? ""
        let status = dataObject[0].status ?? ""
        let onfarmid = dataObject[0].onFarmID ?? ""
        let officialID = dataObject[0].officialID ?? ""
        let fetchActiveBarnExist = fetchGroupExistInDataBase(entityName: Entities.resultGroupCreateTblEntity, groupStatusId: 1, groupTypeId: 0, customerId: Int64(customerId ?? 0))
        if fetchActiveBarnExist.count == 0  {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(LocalizedStrings.noActiveDoller, comment: "") )
            return
        }
        else {
            let fetchObject = fetchActiveBarnExist.object(at: 0) as! ResultGroupCreate
            let groupServerId = fetchObject.groupServerId ?? ""
            updateMyHerdData(entity: Entities.resultMyherdDataTblEntity, customerId : Int64(self.customerId ?? 0) ,animalID : animalId ,groupIDs : groupServerId)
            
            if status == LocalizedStrings.dollerStatus{
                self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                removeAnimalInGroup(groupId: fetchObject.groupServerId ?? "", animalIds: animalId, completionHandler: { (result) in
                    if result {
                        _ = deletGroupInfoResult(entityName: Entities.resultGroupAnimalsTblEntity, groupName: fetchObject.groupName ?? "", customerId: dataObject[0].customerId, animalId: animalId, onFarmId: dataObject[0].onFarmID ?? "")
                    }
                })
                
                updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ?? 0), animalID: animalId, status: LocalizedStrings.inactiveStatus)
                self.myHerdArray = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:self.customerId ?? 0) as! [ResultMyHerdData]
                self.datasource[index].image = UIImage(named: ImageNames.threeDotsInactiveImg)!
                self.datasource[index].backgroundGroup = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
                cell.groupView.layer.backgroundColor  = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0).cgColor
                cell.groupImage.image = UIImage(named: ImageNames.threeDotsInactiveImg)!
            }
            else {
                let data = fetchGroupIdupdateanimal(entityName: Entities.resultGroupAnimalsTblEntity, customerId:Int64(self.customerId ?? 0), groupTypeId: 1,onFarmId:onfarmid, officialID: officialID)
                
                if data.count > 0{
                    let datafetch = data.object(at: 0) as! ResultGroupsAnimals
                    let groupstatus = datafetch.groupStatusId
                    if groupstatus != 0{
                        self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                        removeAnimalInGroup(groupId: datafetch.serverGroupId ?? "", animalIds: animalId, completionHandler: { (result) in
                            if result {
                                _ = deletGroupInfoResultGroupDetail(entityName: Entities.resultGroupAnimalsTblEntity, groupName:datafetch.groupName ?? "", customerId: Int64(self.customerId ?? 0), onFarmId: datafetch.onFarmId ?? "", officalId: datafetch.officalId ?? "")
                            }
                        })
                    }
                }
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: LocalizedStrings.en_US_POSIXStr)
                dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                let date:Date? = dateFormatter.date(from:dataObject[0].dob ?? "")
                
                saveAnimaldataResult(entity: Entities.resultGroupAnimalsTblEntity, serverGroupId: groupServerId, groupName: fetchObject.groupName ?? "", groupStatusId: Int(fetchObject.groupStatusId), groupStatus: fetchObject.groupStatus ?? "", groupTypeId: Int(fetchObject.groupTypeId), groupTypeName: fetchObject.groupTypeName ?? "", animalID: animalId , onFarmId: dataObject[0].onFarmID ?? "", officalId: dataObject[0].officialID ?? "", dob: dataObject[0].dob ?? "", sex: dataObject[0].sex ?? "", breedId: dataObject[0].breedID ?? "", breedName: dataObject[0].breed ?? "", name: dataObject[0].name ?? "", groupId: 0, customerId: dataObject[0].customerId, datedob: date ?? Date())
                
                updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ?? 0), animalID: animalId, status: LocalizedStrings.dollerStatus)
                self.datasource[index].backgroundGroup = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0)
                self.datasource[index].image = UIImage(named: ImageNames.dollarActiveImg)!
                cell.groupView.layer.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0).cgColor
                cell.groupImage.image = UIImage(named: ImageNames.dollarActiveImg)!
            }
        }
        self.hideIndicator()
    }
}

// MARK: - OBJECT PICK CART SCREEN
extension MyHerdResultsViewController : objectPickCartScreen {
    func objectGetOnSelection(temp: Int) {
        // Intentionally left empty.
        // This delegate method is required by the protocol,
        // but we don’t need custom behavior here (for now).
    }
}

// MARK: - IMAGE PICKER CONTROLLER DELEGATE
extension MyHerdResultsViewController : UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true, completion: nil)
        if self.searchTextField.tag == 0 {
            self.searchTextField.text = ""
        }
        else  {
            self.searchTextField.text = ""
        }
        
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        self.imageView.image = image
        setVisionTextRecognizeImage(image: image)
    }
}
