//
//  GroupDeetailsVCiPad.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 20/05/25.
//

import Foundation
import Vision
import VisionKit
import CoreBluetooth
import Alamofire
import MBProgressHUD
import CoreData
import Toast_Swift

//MARK: CLASS
class GroupDeetailsVCiPad: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, VNDocumentCameraViewControllerDelegate{
    
    //MARK: OUTLETS
    @IBOutlet weak var tableviewstackviewnew: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var groupDetailTitle: UILabel!
    @IBOutlet weak var blebttn1: UIButton!
    @IBOutlet weak var bckBtnOutlet: customButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var idLabl: UILabel!
    @IBOutlet weak var officalIdLabel: UILabel!
    @IBOutlet weak var rankLabl: UILabel!
    @IBOutlet weak var dobLabl: UILabel!
    @IBOutlet weak var groupLabl: UILabel!
    @IBOutlet weak var totalAnimalCount: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var connectedBtnOutlet: UIButton!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var connectionImg: UIImageView!
    @IBOutlet weak var pairedBackroundView: UIView!
    @IBOutlet weak var pairedDeviceTitle: UILabel!
    @IBOutlet weak var pairedTableView: UITableView!
    @IBOutlet weak var pairedDeviceView: UIView!
    @IBOutlet weak var groupsCollectionView: UICollectionView!
    
    //MARK: VARIABLES AND CONSTANTS
    var groupStatus = String()
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    var myHerdArray = [ResultGroupsAnimals]()
    var datasource = [callSwipeStructGroup]()
    var callbeforecall = MyHerdResultsViewController()
    var groupName = String()
    var groupTypeId = Int64()
    var isDetailScreen = true
    var groupStatusId = Int64()
    var checkint : Int64?
    var boolcheck = ""
    var selectedMyHerdArray = ResultGroupsAnimals()
    var selectedIndex = Int()
    var request = VNRecognizeTextRequest(completionHandler: nil)
    var rankid = String()
    var rankidnms = String()
    var fetchTempObj1new = [ResultPageByTrait]()
    var fetchFilterData = NSArray()
    var customerId:Int64?
    var userId : Int?
    var checkid = String()
    var searchByAnimal = Bool()
    var isBarcodeAutoIncrementedEnabled = false
    var textRecognitionRequest = VNRecognizeTextRequest(completionHandler: nil)
    private let textRecognitionWorkQueue = DispatchQueue(label: "MyVisionScannerQueue", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
    var value = 0
    var ranktitle : String?
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    var arrNearbyDevice : [CBPeripheral] = [] {
        didSet{
            pairedTableView?.reloadData()
        }
    }
    var qrData: QRData? = nil {
        didSet {
            if qrData != nil {
                searchTextField.text = qrData?.codeString
                
            }else {
                
            }
        } willSet {
        }
    }
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIOnDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUIOnWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self,name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        NotificationCenter.default.removeObserver(self,name: Notification.Name(LocalizedStrings.animationEndNoti), object: nil)
    }
    
    //MARK: INITIAL UI METHODS
    func setUIOnDidLoad(){
        self.customerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64
        self.userId = UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int
        self.navigationController?.navigationBar.isHidden = true
        pairedDeviceView.isHidden = true
        pairedBackroundView.isHidden = true
        initialNetworkCheck()
    }
    
    func setUIOnWillAppear(){
        searchTextField.setLeftPaddingPoints(20.0)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncDataLabel, comment: ""), and: "")
        fetchFilterData = fetchResultFilterData(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: Int(customerId ?? 0))
//        if fetchFilterData.count == 0{
//            rankLabl.text = "DWP$"
//            rankid = "dea75ef2-d49e-478b-a621-f54b0334c4b2"
//        }
//        else{
//            for items in fetchFilterData{
//                let newfetch = items as? ResultFIlterDataSave
//                let traidname = newfetch?.traidsave ?? ""
//                let checkid = newfetch?.idselection ?? ""
//                if checkid == LocalizedStrings.officialCheckId{
//                    rankLabl.text = "     \(traidname)"
//                }
//                else{
//                    rankLabl.text = "  \(traidname)"
//                }
//            }
//        }
        
        UserDefaults.standard.removeObject(forKey: keyValue.scrollIncrement.rawValue)
        self.customerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64
        myHerdArray = fetchGroupInfoResultnew(entityName: Entities.resultGroupAnimalsTblEntity,groupName: groupName,customerId:self.customerId ?? 0) as! [ResultGroupsAnimals]
        fetchTempObj1new = fetchAllData(entityName: Entities.resultPageByTraitTblEntity) as! [ResultPageByTrait]
        fetchTempObj1new = fetchTempObj1new.filter{$0.display == "DWP$" || $0.trait == "DWP" }
        totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: self.myHerdArray.count)
        
        if myHerdArray.count != 0 {
            message.isHidden = true
          //  tblView.isHidden = false
           // headerview.isHidden = false
            self.groupsCollectionView.isHidden = false
            for i in 0...myHerdArray.count - 1{
                let myArray = myHerdArray[i]
                groupTypeId = Int64(myArray.groupTypeId)
                
                if groupTypeId == 0 {
                    let ab = callSwipeStructGroup(name: [myHerdArray[i]], color: .white, image: UIImage(named:ImageNames.dollarActiveImg)!, backgroundGroup: UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0))
                    datasource.append(ab)
                }
                else {
                    let ab = callSwipeStructGroup(name: [myHerdArray[i]], color: .white, image: UIImage(named:ImageNames.barnActiveImg)!, backgroundGroup: UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0))
                    datasource.append(ab)
                }
            }
        }
        else{
           // headerview.isHidden = true
            message.isHidden = false
           // tblView.isHidden = true
            self.groupsCollectionView.isHidden = true
        }
//        tblView.reloadData()
//        tblView.delegate = self
//        tblView.dataSource = self
        groupsCollectionView.reloadData()
        groupsCollectionView.delegate = self
        groupsCollectionView.dataSource = self
        hideIndicator()
//        if UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue {
//            blebttn1.setBackgroundImage(UIImage(named: ImageNames.ocrInactiveImg), for: .normal)
//        }
//        else {
//            if BluetoothCentre.shared.smartBowPeripheral?.state == .connected{
//                blebttn1.setBackgroundImage(UIImage(named: ImageNames.forma1Copy2Img), for: .normal)
//            }
//            else {
//                blebttn1.setBackgroundImage(UIImage(named: ImageNames.scanIconActiveImg), for: .normal)
//            }
//        }
        BluetoothCentre.shared.navController = self
        BluetoothCentre.shared.manager.scanForPeripherals(withServices: nil, options: nil)
        self.navigationController?.navigationBar.isHidden = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        BluetoothCentre.shared.delegateRFID  = self
        BluetoothCentre.shared.nearByDeviceDelegate  = self
        groupDetailTitle.text = self.groupName
     //   bckBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.backBtnText, comment: ""), for: .normal)
    }
    
    //MARK: OBJC SELECTOR METHODS
    @objc func notificationRecevied(notification: Notification) {
        self.groupsCollectionView.reloadData()
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
    
    //MARK: NAVIGATION METHODS
    func navigatetoProviderSelection(showCDCB:Bool,showDatagene:Bool,showHerdity:Bool, showViewCount : Int){
        let vc = UIStoryboard.init(name: "Results", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChooseProviderVCiPad") as! ChooseProviderVCiPad
        vc.modalPresentationStyle = .overFullScreen
        vc.isCDCBFound = showCDCB
        vc.isDategeneFound = showDatagene
        vc.isHerdityFound = showHerdity
        vc.selectedValue = showViewCount
        vc.delegate = self
        self.navigationController?.present(vc, animated: false, completion: nil)
    }
    
    func navigateToIndividualController(productNameStr:String){
        UserDefaults.standard.removeObject(forKey: keyValue.scrollIncrement.rawValue)
        let vc = UIStoryboard.init(name: "Results", bundle: Bundle.main).instantiateViewController(withIdentifier: "IndividualAnimalResultsVCiPad") as? IndividualAnimalResultsVCiPad
        vc?.checkCOntroller = LocalizedStrings.resultController
        vc?.backScreenClickIndex = selectedIndex
        vc?.groupanimalarray = myHerdArray
        vc?.navigateFromGroupDetailScreen = true
        vc?.groupNameExist = groupName
        vc?.productName = productNameStr
        vc?.searchbyAnimal = true
        let offlicalidmyherd = selectedMyHerdArray.officalId
        let onfarmid = selectedMyHerdArray.onFarmId
        vc?.groupStatus = self.groupStatus
        vc?.groupName = self.groupDetailTitle.text ?? ""
        UserDefaults.standard.set(true, forKey: keyValue.searchByAnimal.rawValue)
        UserDefaults.standard.set(offlicalidmyherd, forKey: keyValue.myHerdOfficalid.rawValue)
        UserDefaults.standard.set(onfarmid, forKey: keyValue.myHerdOnfarmId.rawValue)
        UserDefaults.standard.set(selectedIndex, forKey: keyValue.newBackScreenIndex.rawValue)
        
        UserDefaults.standard.set(selectedMyHerdArray.animalID, forKey: keyValue.groupOnAnimalId.rawValue)
        UserDefaults.standard.set(groupName, forKey: keyValue.groupNameSave.rawValue)
        UserDefaults.standard.set(selectedMyHerdArray.groupStatus, forKey: keyValue.groupStatus.rawValue)
        UserDefaults.standard.set(selectedMyHerdArray.groupId, forKey: keyValue.groupTypeId.rawValue)
        UserDefaults.standard.set(keyValue.groupName.rawValue, forKey: keyValue.groupDetails.rawValue)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    //MARK: IB ACTIONS
    @IBAction func scanButtonAction(_ sender: UIButton) {
        barcodeScreen = true
        
    }
    
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
        vc?.module = LocalizedStrings.resultsText.localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
    }
    
    
    @IBAction func rfidBtnClick(_ sender: Any) {
        view.endEditing(true)
        if UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue {
            let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.textScanVC) as? TextScanVC
            vc?.delegate = self
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else  {
            if BluetoothCentre.shared.manager.state == .poweredOff{
                let alertController = UIAlertController (title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.bluetoothOffText, comment: ""), preferredStyle: .alert)
                let settingsAction = UIAlertAction(title: NSLocalizedString(LocalizedStrings.settingsText, comment: ""), style: .default) { (_) -> Void in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
                            
                        } else {
                            UIApplication.shared.openURL(settingsUrl)
                            
                        }
                    }
                }
                alertController.addAction(settingsAction)
                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: nil)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                if BluetoothCentre.shared.smartBowPeripheral?.state == CBPeripheralState.disconnected || BluetoothCentre.shared.smartBowPeripheral == nil{
                    pairedDeviceView.isHidden = false
                    pairedBackroundView.isHidden = false
                    pairedTableView.reloadData()
                }
                if BluetoothCentre.shared.smartBowPeripheral?.state == CBPeripheralState.connected || BluetoothCentre.shared.smartBowPeripheral?.state == CBPeripheralState.connecting {
                    BluetoothCentre.shared.manager.scanForPeripherals(withServices: nil, options: nil)
                    
                    for i in 0 ..< arrNearbyDevice.count{
                        let state = arrNearbyDevice[i].state
                        if state == .connecting {
                        }
                    }
                    pairedDeviceView.isHidden = false
                    pairedBackroundView.isHidden = false
                    pairedTableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func dashboardBtnClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
        
    }
    @IBAction func menuBtnClick(_ sender: Any) {
        self.view.makeCorner(withRadius: 40)
        self.sideMenuViewController?.presentRightMenuViewController()
        
    }
    
    @IBAction func crossPairedAction(_ sender: UIButton) {
        pairedBackroundView.isHidden = true
        pairedDeviceView.isHidden = true
    }
    
    @IBAction func bckBtnClick(_ sender: Any) {
        boolcheck = "checkpoint"
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func connectedBtnAction(_ sender: Any) {
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(DataEntryModeHelpVC.buttonbgPressed), for: .touchUpInside)
        buttonbg.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view .addSubview(buttonbg)
        customPopView = OfflinePopUp.loadFromNibNamed(ClassIdentifiers.offlineViewNib) as? OfflinePopUp
        customPopView.delegate = self
        customPopView.frame = CGRect(x: 30,y: 160,width: screenSize.width - 30,height: screenSize.height/1.7)
        customPopView.center = view.center
        customPopView.layer.cornerRadius = 8
        customPopView.layer.borderWidth = 3
        customPopView.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg .addSubview(customPopView)
    }
    
    //MARK: METHODS AND FUNCTIONS
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
                            self.searchTextField.tag = 1
                            self.textFieldDidEndEditing(textField: self.searchTextField)
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
                            self.searchTextField.returnKeyType = UIReturnKeyType.done
                            self.searchTextField.delegate = self
                            self.textFieldDidEndEditing(textField: self.searchTextField)
                            self.searchTextField.tag = 1
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
        } catch let error {
            print(error.localizedDescription)
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
            else {
                self.hideIndicator()
            }
        }
        return
    }
    
    //MARK: IMAGEPICKER CONTROLLER DELEGATE
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true, completion: nil)
        if self.searchTextField.tag == 0 {
            self.searchTextField.text = ""
        }
        else {
            self.searchTextField.text = ""
        }
        
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        self.imageView.image = image
        setVisionTextRecognizeImage(image: image)
        
    }
}



