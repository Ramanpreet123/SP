//
//  OrderingAnimalVC.swift
//  SearchPoint
////  Created by "" on 04/10/2019.
//aaaa
//  Created by "" on 04/10/2019.
//  ""
//Raman
import UIKit
import DropDown
import CoreBluetooth
import Toast_Swift
import Vision
import VisionKit
import Alamofire

//MARK: ORDERING ANIMAL VC CLASS
class OrderingAnimalVC: UIViewController,VNDocumentCameraViewControllerDelegate{
    
    //MARK: IB OUTLETS
    @IBOutlet weak var keyBoardOptionsView: UIView!
    @IBOutlet weak var keyBoardOptionsViewBottomConstrains: NSLayoutConstraint!
    @IBOutlet weak var addanimalbo:UIButton!
    @IBOutlet weak var countineanimalbo: UIButton!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var closeImage1: UIImageView!
    @IBOutlet weak var closeImage2: UIImageView!
    @IBOutlet weak var selectListLbl: UILabel!
    @IBOutlet weak var crossedBtnOutlet: UIButton!
    @IBOutlet weak var importBGView: UIView!
    @IBOutlet weak var importListMainView: UIView!
    @IBOutlet weak var importTblView: UITableView!
    @IBOutlet weak var cancelBtnOutlet: UIButton!
    @IBOutlet weak var okBtnOutlet: UIButton!
    @IBOutlet weak var btnFindAnimal: UIButton!
    @IBOutlet weak var mergeListBtnOulet: UIButton!
    @IBOutlet weak var matchedBarcodeLbl: UILabel!
    @IBOutlet weak var matchedBarcodeCheckBox: UIImageView!
    @IBOutlet weak var matchedBarcodeBtnOutlet: UIButton!
    @IBOutlet weak var matchedBarcdeContainer: UIView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var internalBtnOulet: UIButton!
    @IBOutlet weak var notificationLblCount: UILabel!
    @IBOutlet weak var farmIdOutlet: customButton!
    @IBOutlet weak var networkStatusImg: UIImageView!
    @IBOutlet weak var offLineBtn: UIButton!
    @IBOutlet weak var permanentIDTextField: UITextField!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var pairedBackroundView: UIView!
    @IBOutlet weak var farmIdTextField: UITextField!
    @IBOutlet weak var noneBttn: UIButton!
    @IBOutlet weak var pairedDeviceTitle: UILabel!
    @IBOutlet weak var calendarViewBkg: UIView!
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var male_femaleBtnOutlet: UIButton!
    @IBOutlet weak var scanAnimalTagText: UITextField!
    @IBOutlet weak var scanBarcodeText: UITextField!
    @IBOutlet weak var sireIdTextField: UITextField!
    @IBOutlet weak var damtexfield: UITextField!
    @IBOutlet weak var dateBtnOutlet: UIButton!
    @IBOutlet weak var NAAB_CodeOutlet: UITextField!
    @IBOutlet weak var RFID_Outlet: UITextField!
    @IBOutlet weak var etBttn: UIButton!
    @IBOutlet weak var multipleBirthBttn: UIButton!
    @IBOutlet weak var singleBttn: UIButton!
    @IBOutlet weak var scrollInnerView: UIView!
    @IBOutlet weak var blebttn1: UIButton!
    @IBOutlet weak var tissueLbl: UILabel!
    @IBOutlet weak var breedLbl: UILabel!
    @IBOutlet weak var tissueBtnOutlet: customButton!
    @IBOutlet weak var NetworkStatusLbl: UILabel!
    @IBOutlet weak var breedBtnOutlet: customButton!
    @IBOutlet weak var bleBttn: UIButton!
    @IBOutlet weak var countLbl: UIButton!
    @IBOutlet weak var officalTagView: UIView!
    @IBOutlet weak var farmIdView: UIView!
    @IBOutlet weak var barcodeView: UIView!
    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var SplitEmbryoOutlet: UIButton!
    @IBOutlet weak var cloneOutlet: UIButton!
    @IBOutlet weak var sireIAuTextField: UITextField!
    @IBOutlet weak var nationalHerdIdTextField: UITextField!
    @IBOutlet weak var sireIdAuHeightConstrainr: NSLayoutConstraint!
    @IBOutlet weak var nationalHerdAuHeightConstrainr: NSLayoutConstraint!
    @IBOutlet weak var sireIdAuUperConstraint: NSLayoutConstraint!
    @IBOutlet weak var nationalHerdAuUperConstraint: NSLayoutConstraint!
    @IBOutlet weak var formIdViewHConstraint: NSLayoutConstraint!
    @IBOutlet weak var formIdViewBConstraint: NSLayoutConstraint!
    @IBOutlet weak var bornTypeCollection: UICollectionView!
    @IBOutlet weak var auPOPupTitle: UILabel!
    @IBOutlet weak var dateOfBirthLbl: UILabel!
    @IBOutlet weak var calenderDobView: UIView!
    @IBOutlet weak var incrementalBarcodeCheckBox: UIImageView!
    @IBOutlet weak var incrementalBarcodeTitleLabel: UILabel!
    @IBOutlet weak var incrementalBarcodeButton: UIButton!
    @IBOutlet weak var AUbackroundView: UIView!
    @IBOutlet weak var auSelectionView: UIView!
    @IBOutlet weak var pairedTableView: UITableView!
    @IBOutlet weak var pairedDeviceView: UIView!
    @IBOutlet weak var sireTipBTNoUTLET: customButton!
    @IBOutlet weak var scanButton: UIButton! {
        didSet {
        }
    }
    @IBOutlet weak var clearFormOutlet: UIButton!
    @IBOutlet weak var importFromListOutlet: UIButton!
    
    //MARK: VARIABLES AND CONSTANTS
    var loadedAnimalData : AnimaladdTbl?
    var iscomingFromCart = Bool()
    var addonArr = NSArray()
    var adhAnimalData = [AnimalMaster]()
    var filterAdhAnimalData = [AnimalMaster]()
    var listIdGet = Int()
    var sections = [Section]()
    let tapRec = UITapGestureRecognizer()
    var importListArray = [DataEntryList]()
    var tempImportListArray = [DataEntryList]()
    var conflictArr = [DataEntryAnimaladdTbl]()
    var listId = Int()
    var newfarmid = String()
    var newtextfieldfarmid = String()
    var listNameString = String()
    var arrayCountCond = NSArray()
    var allDataAnimalTbl = NSArray()
    var onfarmidtext = String()
    var fetchrecord = Bool()
    var fetchrecord1 = Bool()
    var fetchrecord2 = Bool()
    var fetchrecord3 = Bool()
    var fetchrecord4 = Bool()
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    let acceptableCharactersClassVar = LocalizedStrings.alphaNumericFormat
    var XDFound = Bool()
    var conflicitArrayCountCheck =  [DataEntryAnimaladdTbl]()
    var cartListName = String()
    var farmiDValueStore = String()
    var dataAutoPopulatedBool = false
    var farmIDBoolEntry = false
    var  siraidcheck = false
    var  scanbarcodecheck = false
    var  mainrecord = false
    var  minrecord = false
    var farmIDBoolEntrySecond = false
    var farmIDBoolEntryTag = false
    var checkBarcode = Bool()
    var adhDataServerAutoPopulate  = Bool()
    var AusNabb = NSArray()
    var ausBullId = NSArray()
    var sireNationalID = NSArray()
    var request = VNRecognizeTextRequest(completionHandler: nil)
    var  newanimaltagvalue = String()
    var methReturn = String()
    var barAutoPopu = false
    var autoPopulapte = Bool()
    var animalIdBool = Bool()
    let buttonbg2 = UIButton ()
    let buttonbgAutoSuggestion = UIButton ()
    let labletbale = UILabel()
    var AutoSuggestionTableView  = UITableView ()
    var droperTableView  = UITableView ()
    var breedArr = NSArray()
    var breedId = String()
    var tissuId = Int()
    var animalId1 = Int()
    var tissueArr = NSArray()
    var btnTag = Int()
    var identify = Bool()
    var identify1 = Bool()
    var msgcheckk  = Bool()
    var isautoPopulated = false
    var statusOrder = Bool()
    var updateOrder = Bool()
    var editIngText = Bool()
    var autoD = Int()
    var editAid = Int()
    var messageCheck = Bool()
    var msgAnimalSucess = Bool()
    var addedd = Bool()
    var scanAnimalText = String()
    var savebarcodecopyofficialid = String()
    var farmIdText = String()
    let buttonbg1 = UIButton ()
    var customPopView1 :TipPopUp!
    var animalTag = true
    var sireIdBool = true
    var offPmidBool = true
    var barCodeIdBool = true
    var damIdBool = true
    var farmIdTagBool = true
    var idAnimal = Int()
    var isUpdate = Bool()
    var msgUpatedd = Bool()
    var animalSucInOrder = String()
    var barcodeflag = Bool()
    var defaltscreen = String()
    var genderToggleFlag : Int = 0
    let dateFormatter = DateFormatter()
    var locale = NSLocale.current
    var datePicker : UIDatePicker!
    var selectedDate = Date()
    let toolBar = UIToolbar()
    var genderString = String()
    var counter = 0
    var lblTimeStamp = String()
    let dropDown = DropDown()
    let date = Date()
    var breedChanged = Bool()
    var timeStampString = String()
    var sampleArr = NSMutableArray()
    var borderRedCheck = true
    var  farmidcheck = String()
    var checkfarmbool = Bool()
    var isoverride :Bool? = false
    var checkofsaveanimalid :Bool? = false
    var saveanimalID = Int64()
    var message = String()
    let screentext = UserDefaults.standard.value(forKey: keyValue.screen.rawValue) as? String
    var selctionAuProvider = UserDefaults.standard.value(forKey: keyValue.clickAuProvider.rawValue) as? Bool
    var addContiuneBtn = Int()
    var textFieldAnimal = String()
    var sampleID = Int()
    var sampleName = String()
    var userId = Int()
    var orderId = Int()
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    var custmerId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
    var countryCodesArray = NSArray()
    var breedCodesArray = NSArray()
    var naabCodesArray = NSArray()
    var genderFirst = String()
    var sireIdValidationB = true
    var damIdValidationB = true
    var breedAr = NSArray()
    var threeCharCode = NSArray()
    var countryArr = NSArray()
    var naabArr = NSArray()
    var counteryNumericArr = NSArray()
    var providerSelectionCountryCode = String()
    var providerCountryCodeAlpha2 = String()
    let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
    var getBornTypes = [GetBornTypes]()
    var isGrayField = true
    var selectedBornTypeId = -1
    var translationslanguageResponseData = TranslationslanguageResponse()
    var etBtn = String()
    var barcodeEnable = Bool()
    var barcodefixed = Bool()
    var incrementalBarCode = ""
    var fetchNaabBullArray = NSArray ()
    var autocompleteUrls1 = NSMutableArray ()
    var autocompleteUrls2 = NSMutableArray ()
    var autocompleteUrlsbullname = NSMutableArray ()
    var sireNatonIdArray  = NSMutableArray ()
    var autoSuggestionStatus : Bool?
    var dateVale = ""
    var attrs : [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.init(red: 29/225, green: 131/225, blue: 174/225, alpha: 1.0),.underlineStyle: NSUnderlineStyle.single.rawValue]
    var isBarcodeAutoIncrementedEnabled = false
    var value = 0
    var arrNearbyDevice : [CBPeripheral] = [] {
        didSet{
            pairedTableView?.reloadData()
        }
    }
    var currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int
    var validateDateFlag = true
    let langCode : String = UserDefaults.standard.object(forKey: keyValue.lngCode.rawValue) as! String
    let orderingDataListViewModel = OrderingDataListViewModel()
    let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
    var textRecognitionRequest = VNRecognizeTextRequest(completionHandler: nil)
    var damiidTextValueStore = String()
    var borderRedChange = Bool()
    var validateFirstLetter  = false
    private let textRecognitionWorkQueue = DispatchQueue(label: "MyVisionScannerQueue", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
    var qrData: QRData? = nil {
        didSet {
            if qrData != nil {
                scanBarcodeText.text = qrData?.codeString
            }
        } willSet {
        }
    }
    
    //MARK: STRUCT SECTION
    struct Section {
        let letter : String
        let names : [String]
    }
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIOnDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUIOnWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setUIOnDidAppear()
    }
    
    override func viewDidDisappear(_ animakted: Bool) {
        self.defaultIncrementalBarCodeSetting()
        scrolView.flashScrollIndicators()
        addanimalbo.isHidden = false
        countineanimalbo.isHidden = false
        removeObserver()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(Notification.Name(keyValue.notificationIdentifier.rawValue))
    }
    
    override func viewDidLayoutSubviews() {
        if counter == 0 || counter == 1{
            counter = counter + 1
        }
    }
    
    // MARK: - NAVIGATE TO ORDER PRODUCT SELECTION SCREEN
    func NavigateToOrderingProductSelectionScreen(screenType: Int = 1) {
        let viewAnimalArray =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid)
        let dataListAnimals : [AnimaladdTbl] = viewAnimalArray as! [AnimaladdTbl]
        let animals = dataListAnimals.filter({ $0.animalbarCodeTag == "" || $0.animalbarCodeTag == nil })
        
        if animals.count > 0 {
            let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message: AlertMessagesStrings.reviewTheCartToUpdate.localized(with: animals.count), preferredStyle: .alert)
            
            let ok = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { action in
                self.selectedDate = Date()
                let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.viewAnimalsControllerVC) as? ViewAnimalsController
                vc?.delegateCustom = self
                vc!.screenBackSave = false
                vc!.productBackSave = false
                self.navigationController?.pushViewController(vc!, animated: true)
            })
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        else {
            if screenType == 1 {
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.orderingProductSelectionVC)), animated: true)
            } else {
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.orderProductSelectionSecondVC)), animated: true)
            }
        }
    }
    
    //MARK: METHODS AND FUNCTIONS
    func ShowAlertforSampletype(){
        let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default){
            UIAlertAction in
            self.byDefaultSetting()
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.byDefaultSetting()
            return
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        return
        
    }
    
    func showAlertforwithoutBarcodeAnimal() {
        createDataList()
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid) as! [AnimaladdTbl]
        let animals = animalCount.filter({$0.animalbarCodeTag == "" || $0.animalbarCodeTag == nil})
        
        if animals.count > 0 {
            let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message:  AlertMessagesStrings.reviewTheCartToUpdate.localized(with: animals.count), preferredStyle: .alert)
            
            let ok = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { action in
                self.selectedDate = Date()
                let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.viewAnimalsControllerVC) as? ViewAnimalsController
                vc?.delegateCustom = self
                vc!.screenBackSave = false
                vc!.productBackSave = false
                self.navigationController?.pushViewController(vc!, animated: true)
            })
            alert.addAction(ok)
            DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
            })
        }
    }
    
    func defaultIncrementalBarCodeSetting() {
        incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
        incrementalBarcodeTitleLabel.text =  NSLocalizedString("Incremental Barcode", comment: "")
    }
    
    func updateCartCount() {
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
        self.notificationLblCount.text = String(animalCount.count)
        if animalCount.count == 0 {
            self.notificationLblCount.isHidden = true
            self.countLbl.isHidden = true
        } else {
            self.notificationLblCount.isHidden = false
            self.countLbl.isHidden = false
        }
    }
    
    func anOptionalMethod(check :Bool){
        if check {
            isUpdate = false
            editIngText = false
            statusOrder = false
            animalId1 = -1
            editAid = -1
            idAnimal = 0
            isautoPopulated = false
            byDefaultSetting()
            textFieldBackroungGrey()
            msgUpatedd = false
        }
    }
    
    func getCurrentTimeStampWOMiliseconds(dateToConvert: NSDate) -> String {
        let objDateformat: DateFormatter = DateFormatter()
        objDateformat.dateFormat = DateFormatters.yyyyMMddFormat
        let strTime: String = objDateformat.string(from: dateToConvert as Date)
        let objUTCDate: NSDate = objDateformat.date(from: strTime)! as NSDate
        let milliseconds: Int64 = Int64(objUTCDate.timeIntervalSince1970)
        let strTimeStamp: String = "\(milliseconds)"
        return strTimeStamp
    }
    
    func statusOrderTrue() -> Bool{
        let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.animalMasterTblEntity, animalId: idAnimal, customerID: custmerId)
        if animalFetch.count > 0{
            statusOrder = true
            return true
        } else {
            return false
        }
        
    }
    
    func doDatePicker(){
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 40, width: self.calenderView.frame.size.width, height: 260))
        self.datePicker?.backgroundColor = UIColor.white
        if langId == 2{
            self.datePicker?.locale = Locale(identifier: Languages.portuguese)
        }
        else if langId == 3{
            self.datePicker?.locale = Locale(identifier: Languages.italian)
        }
        else{
            self.datePicker?.locale = Locale(identifier: Languages.eng)
        }
        
        self.datePicker?.datePickerMode = UIDatePicker.Mode.date
        self.datePicker.setDate(selectedDate, animated: true)
        
        if #available(iOS 14, *) {
            self.datePicker?.preferredDatePickerStyle = .wheels
        }
        calenderView.backgroundColor = UIColor.white
        calenderView.addSubview(self.datePicker)
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 1, alpha: 1)
        toolBar.sizeToFit()
        self.datePicker.maximumDate = Date()
        let doneButton = UIBarButtonItem(title: "Done".localized, style: .plain, target: self, action: #selector(self.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel".localized, style: .plain, target: self, action: #selector(self.cancelClick))
        cancelButton.tintColor = UIColor.black
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = CGRect(x: 0, y: 0, width: self.calenderView.frame.size.width, height: 40)
        self.calenderView.addSubview(toolBar)
        self.toolBar.isHidden = false
    }
    
    
    func tableViewpop() {
        buttonbg2.frame = CGRect(x:0,y: 0,width: 1024,height: 1000)
        buttonbg2.addTarget(self, action:#selector(OrderingAnimalVC.buttonPreddDroper), for: .touchUpInside)
        buttonbg2.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        self.view.addSubview(buttonbg2)
        droperTableView.delegate = self
        droperTableView.dataSource = self
        droperTableView.layer.cornerRadius = 8.0
        droperTableView.layer.borderWidth = 0.5
        droperTableView.layer.borderColor =  UIColor.gray.cgColor
        buttonbg2.addSubview(droperTableView)
    }
    
    func tableViewpopAutosugesstion() {
        btnTag = 30
        buttonbgAutoSuggestion.frame = CGRect(x:0,y: 0,width: 1024,height: 1000)
        buttonbgAutoSuggestion.addTarget(self, action:#selector(OrderingAnimalVC.buttonPreddDroperAutosugesstion), for: .touchUpInside)
        buttonbgAutoSuggestion.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        self.view.addSubview(buttonbgAutoSuggestion)
        AutoSuggestionTableView.delegate = self
        AutoSuggestionTableView.dataSource = self
        AutoSuggestionTableView.layer.cornerRadius = 8.0
        AutoSuggestionTableView.layer.borderWidth = 0.5
        AutoSuggestionTableView.layer.borderColor =  UIColor.gray.cgColor
        buttonbgAutoSuggestion.addSubview(AutoSuggestionTableView)
    }
    
    
    func dataPopulateInScreen(animalId:Int){
        isautoPopulated = true
        barAutoPopu = true
        var animalFetch = NSArray()
        
        if animalIdBool  {
            textFieldBackroungWhite()
            animalFetch = fetchAllDataWithAnimalId(entityName: Entities.animalAddTblEntity, animalId: animalId, customerID: custmerId)
            let data = animalFetch.object(at: 0) as! AnimaladdTbl
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            animalId1 = Int(data.animalId)
            dataAutoPopulatedBool =  true
            
            if selctionAuProvider == true {
                if data.sireIDAU != "" {
                    nationalHerdIdTextField.text = data.nationHerdAU
                    sireIAuTextField.text = data.sireIDAU
                }
                
            } else {
                nationalHerdIdTextField.text = data.nationHerdAU
                sireIAuTextField.text = data.sireIDAU
            }
            
            officalTagView.layer.borderColor = UIColor.gray.cgColor
            farmIdView.layer.borderColor = UIColor.gray.cgColor
            barcodeView.layer.borderColor = UIColor.gray.cgColor
            permanentIDTextField.layer.borderColor = UIColor.gray.cgColor
            sireIdTextField.layer.borderColor = UIColor.gray.cgColor
            damtexfield.layer.borderColor = UIColor.gray.cgColor
            dateBtnOutlet.titleLabel!.text = ""
            
            if data.date != "" {
                let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
                let formatter = DateFormatter()
                if UserDefaults.standard.value(forKey: "defaultDatePicker") as? String == "defaultEntry"{
                    if dateStr == "MM"{
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        dateVale = month + "/" + date + "/" + year
                        dateTextField.text = dateVale
                        formatter.dateFormat = DateFormatters.MMddyyyyFormat
                    }
                }
                else {
                    var dateVale = ""
                    let values = data.date!.components(separatedBy: "/")
                    let date = values[0]
                    let month = values[1]
                    let year = values[2]
                    dateVale = date + "/" + month + "/" + year
                    dateBtnOutlet.setTitle(dateVale, for: .normal)
                    dateTextField.text = dateVale
                    formatter.dateFormat = DateFormatters.MMddyyyyFormat
                }
                
                self.selectedDate = formatter.date(from:  dateTextField.text!) ?? Date()
                let isGreater = Date().isSmaller(than: selectedDate)
                if isGreater  {
                    dateBtnOutlet.setTitle("", for: .normal)
                    dateTextField.text = ""
                }
            }
            
            scanBarcodeText.text = data.animalbarCodeTag
            borderRedCheck = false
            barcodeflag = false
            permanentIDTextField.text = data.offPermanentId
            if pvid == 3 {
                sireIdTextField.text = data.offsireId
            }
            else  {
                sireIdTextField.text = data.offsireId
            }
            
            damtexfield.text = data.offDamId
            breedBtnOutlet.setTitle(data.breedName, for: .normal)
            tissueBtnOutlet.setTitleColor(.black, for: .normal)
            breedBtnOutlet.setTitleColor(.black, for: .normal)
            saveSampleNameandID(sampleNameStr: data.tissuName ?? "",sampleID: Int(data.tissuId))
            tissueBtnOutlet.setTitle(sampleName.localized, for: .normal)
            breedId = data.breedId!
            UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
            
            if data.gender == "Male".localized || data.gender == "M" {
                self.male_femaleBtnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                genderToggleFlag = 1
                genderString = NSLocalizedString("Male", comment: "")
                UserDefaults.standard.set("M", forKey: "USDairyGender")
            }
            else {
                self.male_femaleBtnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                genderToggleFlag = 0
                genderString = NSLocalizedString("Female", comment: "")
                UserDefaults.standard.set("F", forKey: "USDairyGender")
            }
            
            checkBarcode = false
            incrementalBarcodeTitleLabel.textColor = .black
            incrementalBarcodeButton.isEnabled = true
            let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.animalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
            
            if dataFetch.count == 0 {
                scanBarcodeText.text = data.animalbarCodeTag
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                self.isBarcodeAutoIncrementedEnabled = false
                incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                incrementalBarcodeButton.isEnabled = false
                incrementalBarcodeTitleLabel.textColor = .gray
                checkBarcode = false
                incrementalBarcodeTitleLabel.alpha = 0.6
                incrementalBarcodeButton.alpha = 0.6
                incrementalBarcodeCheckBox.alpha = 0.6
            }
            
            matchedBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
            matchedBarcodeBtnOutlet.isEnabled = false
            matchedBarcodeLbl.textColor = .gray
            matchedBarcodeCheckBox.alpha = 0.6
            matchedBarcodeBtnOutlet.alpha = 0.6
            matchedBarcodeLbl.alpha = 0.6
            UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlag.rawValue)
            let screenRefernce = UserDefaults.standard.value(forKey:keyValue.screen.rawValue) as? String
            
            if screenRefernce == keyValue.farmId.rawValue || screenRefernce == "" {
                scanAnimalTagText.text = data.farmId
                farmIdTextField.text = data.animalTag
                farmiDValueStore = data.farmId ?? ""
                UserDefaults.standard.set(data.animalTag!.uppercased(), forKey: keyValue.selectAnimalId.rawValue)
                textFieldAnimal = data.animalTag!
            } else {
                textFieldAnimal = data.farmId!
                scanAnimalTagText.text = data.animalTag
                UserDefaults.standard.set(data.animalTag!.uppercased(), forKey: keyValue.selectAnimalId.rawValue)
                farmIdTextField.text = data.farmId
                textFieldAnimal = data.animalTag!
            }
            
            if pvid == 3 {
                sireIdValidationB = true
                autoSuggestionStatus = true
            } else {
                sireIdValidationB = false
                autoSuggestionStatus = false
            }
            
            sireIdValidationB = false
            damIdValidationB = false
            let et = data.eT
            etBtn = et!
            etBttn.layer.borderWidth = 0.5
            singleBttn.layer.borderWidth = 0.5
            multipleBirthBttn.layer.borderWidth = 0.5
            cloneOutlet.layer.borderWidth = 0.5
            SplitEmbryoOutlet.layer.borderWidth = 0.5
            internalBtnOulet.layer.borderWidth = 0.5
            
            if et == "Et"{
                etBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                etBttn.layer.borderWidth = 2
                singleBttn.layer.borderColor = UIColor.gray.cgColor
                internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                selectedBornTypeId = 3
            }
            else if et == LocalizedStrings.singlesText{
                singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                singleBttn.layer.borderWidth = 2
                internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                etBttn.layer.borderColor = UIColor.gray.cgColor
                selectedBornTypeId = 1
            }
            else if et == LocalizedStrings.multipleBirthStr{
                multipleBirthBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                multipleBirthBttn.layer.borderWidth = 2
                internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                singleBttn.layer.borderColor = UIColor.gray.cgColor
                SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                etBttn.layer.borderColor = UIColor.gray.cgColor
                selectedBornTypeId = 2
            }
            else if et == NSLocalizedString(LocalizedStrings.splitEmbryoStr, comment: ""){
                SplitEmbryoOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                SplitEmbryoOutlet.layer.borderWidth = 2
                internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                singleBttn.layer.borderColor = UIColor.gray.cgColor
                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                etBttn.layer.borderColor = UIColor.gray.cgColor
                selectedBornTypeId = 4
            }
            else if et == LocalizedStrings.cloneText{
                cloneOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                cloneOutlet.layer.borderWidth = 2
                internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                singleBttn.layer.borderColor = UIColor.gray.cgColor
                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                etBttn.layer.borderColor = UIColor.gray.cgColor
                selectedBornTypeId = 5
            }
            else if et == LocalizedStrings.internalStr{
                internalBtnOulet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                internalBtnOulet.layer.borderWidth = 2
                cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                singleBttn.layer.borderColor = UIColor.gray.cgColor
                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                etBttn.layer.borderColor = UIColor.gray.cgColor
                selectedBornTypeId = 6
            }
            else {
                singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                singleBttn.layer.borderWidth = 2
                internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                etBttn.layer.borderColor = UIColor.gray.cgColor
                selectedBornTypeId = 1
            }
            
            tissuId = Int(data.tissuId)
            dateBtnOutlet.setTitleColor(.black, for: .normal)
            let adata = fetchAllDataOrderStatusMaster(entityName: Entities.animalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
            animalIdBool = false
            
            if adata.count > 0{
                let animal  = adata.object(at: 0) as! AnimalMaster
                idAnimal = Int(animal.animalId)
            }
        }
        else {
            animalFetch = fetchAllDataWithAnimalId(entityName: Entities.animalMasterTblEntity, animalId: idAnimal, customerID: custmerId)
            if animalFetch.count > 0 {
                let  data = animalFetch.object(at: 0) as! AnimalMaster
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                animalId1 = Int(data.animalId)
                if selctionAuProvider == true {
                    if data.sireIDAU == "" {
                        nationalHerdIdTextField.text = ""
                        sireIAuTextField.text = ""
                    } else {
                        nationalHerdIdTextField.text = data.nationHerdAU
                        sireIAuTextField.text = data.sireIDAU
                    }
                    
                } else {
                    nationalHerdIdTextField.text = data.nationHerdAU
                    sireIAuTextField.text = data.sireIDAU
                }
                
                officalTagView.layer.borderColor = UIColor.gray.cgColor
                farmIdView.layer.borderColor = UIColor.gray.cgColor
                barcodeView.layer.borderColor = UIColor.gray.cgColor
                permanentIDTextField.layer.borderColor = UIColor.gray.cgColor
                sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                damtexfield.layer.borderColor = UIColor.gray.cgColor
                
                if data.date != "" {
                    let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
                    let formatter = DateFormatter()
                    if dateStr == "MM"{
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        dateVale = month + "/" + date + "/" + year
                        dateBtnOutlet.setTitle(dateVale, for: .normal)
                        dateTextField.text = dateVale
                        formatter.dateFormat = DateFormatters.MMddyyyyFormat
                    }
                    else {
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        dateVale = date + "/" + month + "/" + year
                        dateBtnOutlet.setTitle(dateVale, for: .normal)
                        dateTextField.text = dateVale
                        formatter.dateFormat = DateFormatters.MMddyyyyFormat
                    }
                    
                    self.selectedDate = formatter.date(from: dateBtnOutlet.titleLabel!.text!)!
                    let isGreater = Date().isSmaller(than: selectedDate)
                    if isGreater  {
                        dateBtnOutlet.setTitle("", for: .normal)
                        dateTextField.text = ""
                        
                    }
                }
                scanBarcodeText.text = data.animalbarCodeTag
                permanentIDTextField.text = data.offPermanentId
                
                if pvid == 3 {
                    sireIdTextField.text = data.offsireId
                } else  {
                    sireIdTextField.text = data.offsireId
                }
                
                damtexfield.text = data.offDamId
                borderRedCheck = false
                breedBtnOutlet.setTitle(data.breedName, for: .normal)
                tissueBtnOutlet.setTitleColor(.black, for: .normal)
                breedBtnOutlet.setTitleColor(.black, for: .normal)
                tissueBtnOutlet.setTitle(data.tissuName?.localized, for: .normal)
                saveSampleNameandID(sampleNameStr: data.tissuName ?? "", sampleID: Int(data.tissuId ))
                breedId = data.breedId!
                UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                
                if data.gender == "Male".localized || data.gender == "M" {
                    self.male_femaleBtnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 1
                    genderString = NSLocalizedString("Male", comment: "")
                    UserDefaults.standard.set("M", forKey: "USDairyGender")
                    
                }
                else {
                    self.male_femaleBtnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 0
                    genderString = NSLocalizedString("Female", comment: "")
                    UserDefaults.standard.set("M", forKey: "USDairyGender")
                }
                
                let screenRefernce = UserDefaults.standard.value(forKey:keyValue.screen.rawValue) as? String
                
                if screenRefernce == keyValue.farmId.rawValue || screenRefernce == ""{
                    scanAnimalTagText.text = data.farmId
                    farmIdTextField.text = data.animalTag
                    textFieldAnimal = data.animalTag!
                }
                else {
                    textFieldAnimal = data.farmId!
                    scanAnimalTagText.text = data.animalTag
                    farmIdTextField.text = data.farmId
                    textFieldAnimal = data.animalTag!
                    
                    if data.animalTag?.count == 17 {
                        let twoString = data.animalTag
                        let twoBreed  = String((twoString?.prefix(2))!)
                        
                        if breedAr.contains(twoBreed) {
                            self.breedBtnOutlet.setTitle(twoBreed, for: .normal)
                            let codeId1 = fetchBreedDatabreedCode( entityName: Entities.getBreedsTblEntity,provId: self.pvid,breedCode:(self.breedBtnOutlet.titleLabel?.text)!)
                            let naabFetch11 = codeId1.value(forKey: keyValue.breedId.rawValue) as? NSArray
                            if naabFetch11!.count == 0 {
                                
                            } else {
                                let breedIdGet = (naabFetch11![0] as? String)!
                                self.breedId = breedIdGet
                                UserDefaults.standard.set(self.breedId, forKey: keyValue.breed.rawValue)
                                let breedName = codeId1.value(forKey: keyValue.alpha2.rawValue) as? NSArray
                                if naabFetch11!.count != 0 {
                                    let nameBreed = (breedName![0] as? String)!
                                    self.breedBtnOutlet.setTitle(nameBreed, for: .normal)
                                }}
                        }
                    }
                }
                sireIdValidationB = false
                damIdValidationB = false
                
                if pvid == 3 {
                    sireIdValidationB = true
                    autoSuggestionStatus = true
                }
                else {
                    sireIdValidationB = false
                    autoSuggestionStatus = false
                }
                
                checkBarcode = false
                incrementalBarcodeTitleLabel.textColor = .black
                incrementalBarcodeButton.isEnabled = true
                let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.animalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                if dataFetch.count != 0 {
                    scanBarcodeText.text = data.animalbarCodeTag
                    UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                    self.isBarcodeAutoIncrementedEnabled = false
                    incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                    incrementalBarcodeButton.isEnabled = false
                    incrementalBarcodeTitleLabel.textColor = .gray
                    checkBarcode = false
                }
                let et = data.eT
                etBtn = et!
                etBttn.layer.borderWidth = 0.5
                singleBttn.layer.borderWidth = 0.5
                multipleBirthBttn.layer.borderWidth = 0.5
                cloneOutlet.layer.borderWidth = 0.5
                SplitEmbryoOutlet.layer.borderWidth = 0.5
                internalBtnOulet.layer.borderWidth = 0.5
                
                if et == "Et"{
                    etBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    etBttn.layer.borderWidth = 2
                    singleBttn.layer.borderColor = UIColor.gray.cgColor
                    internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                    cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 3
                }
                else if et == LocalizedStrings.singlesText{
                    singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    singleBttn.layer.borderWidth = 2
                    internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                    cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                    etBttn.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 1
                }
                else if et == LocalizedStrings.multipleBirthStr{
                    multipleBirthBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    multipleBirthBttn.layer.borderWidth = 2
                    internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                    singleBttn.layer.borderColor = UIColor.gray.cgColor
                    SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                    cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                    etBttn.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 2
                }
                else if et == NSLocalizedString(LocalizedStrings.splitEmbryoStr, comment: ""){
                    SplitEmbryoOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    SplitEmbryoOutlet.layer.borderWidth = 2
                    internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                    singleBttn.layer.borderColor = UIColor.gray.cgColor
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                    etBttn.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 4
                }
                else if et == LocalizedStrings.cloneText{
                    cloneOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    cloneOutlet.layer.borderWidth = 2
                    internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                    singleBttn.layer.borderColor = UIColor.gray.cgColor
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                    etBttn.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 5
                }
                else if et == LocalizedStrings.internalStr{
                    internalBtnOulet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    internalBtnOulet.layer.borderWidth = 2
                    cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                    singleBttn.layer.borderColor = UIColor.gray.cgColor
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                    etBttn.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 6
                }
                else {
                    singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    singleBttn.layer.borderWidth = 2
                    internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                    cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                    etBttn.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 1
                }
                
                tissuId = Int(data.tissuId)
                dateBtnOutlet.setTitleColor(.black, for: .normal)
                let adata = fetchAllDataOrderStatusMaster(entityName: Entities.animalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
                animalIdBool = false
                
                if adata.count > 0{
                    let animal  = adata.object(at: 0) as! AnimalMaster
                    idAnimal = Int(animal.animalId)
                    statusOrder = true
                }
            }
        }
    }
    
    //MARK: VALIDATION ID17 AND BREED METHODS
    func validateBreed(completionHandler: CompletionHandler) {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        let data1 = fetchAllDataOrderStatus(entityName: Entities.animalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
        var bredidd123 = String ()
        
        if data1.count > 0 {
            let breeid1 = data1.object(at: 0) as! AnimaladdTbl
            bredidd123 = breeid1.breedName ?? ""
        }
        
        if data1.count == 1 {
            UserDefaults.standard.set(false, forKey: keyValue.identifyStore.rawValue)
            
        }
        else {
            for i in 0 ..< data1.count{
                let breeid1 = data1.object(at: i) as! AnimaladdTbl
                if bredidd123 == breeid1.breedName {
                    UserDefaults.standard.set(false, forKey: keyValue.identifyStore.rawValue)
                }
                else{
                    UserDefaults.standard.set(true, forKey: keyValue.identifyStore.rawValue)
                    return completionHandler(true)
                }
                bredidd123 = breeid1.breedName ?? ""
            }
        }
        return completionHandler(true)
    }
    
    
    
    
    func validateFirstLetter(firstLetter:Character)->String{
        let breedAr = breedCodesArray.value(forKey: keyValue.alpha2.rawValue) as! NSArray
        var finalString = String()
        for (index, item) in breedAr.enumerated() {
            let srt = item as! String
            for (ind, char) in srt.enumerated() {
                if (char == firstLetter) && ind == 0 {
                    finalString = breedAr[index] as! String
                    validateFirstLetter = true
                    break
                }else {
                    validateFirstLetter = false
                }
            }
            if validateFirstLetter  {
                break
            }
        }
        return finalString
    }
    
    func validationId17(animalId:String) {
        let breedAr = breedCodesArray.value(forKey: keyValue.alpha2.rawValue) as! NSArray
        let threeCharCode = breedCodesArray.value(forKey: keyValue.threeCharCode.rawValue) as! NSArray
        countryCodesArray = fetchAllData(entityName: Entities.getCountryCodeTblEntity)
        let countryArr = countryCodesArray.value(forKey: keyValue.alphaCode.rawValue) as! NSArray
        let naabArr = naabCodesArray.value(forKey: keyValue.naabCode.rawValue) as! NSArray
        let counteryNumericArr = countryCodesArray.value(forKey: keyValue.numericCode.rawValue) as! NSArray
        
        if genderString == "Male".localized || genderString == "M"{
            genderFirst = "M"
        } else if genderString == "Female" || genderString == "F"{
            genderFirst = "F"
        }
        
        var idAnimal = animalId.uppercased()
        if idAnimal.isInt  {
            rfidScanning(animalId: animalId)
        }
        else {
            let firstElement = String(idAnimal.prefix(1))
            if firstElement.isInt  {
                var idAnimal = animalId.uppercased()
                let getSec = String(idAnimal.prefix(2).uppercased())
                let second = getSec.dropFirst(1).uppercased()
                let getThi = String(idAnimal.prefix(3).uppercased())
                let thirdCHAR = getThi.dropFirst(2).uppercased()
                let getFive = String(idAnimal.prefix(5).uppercased())
                let dropBreedName = String(getFive.dropFirst(3).uppercased())
                let dropBreedFirstName = String(dropBreedName.dropFirst(1).uppercased())
                let getFour = String(dropBreedName.dropLast(1).uppercased())
                let dropFour = String(idAnimal.dropFirst(4).uppercased())
                var dropFive = String(idAnimal.dropFirst(5).uppercased())
                
                if second.isInt  {
                    if thirdCHAR.isInt  {
                        if breedAr.contains(dropBreedName) {
                            if dropFive.count == 0 {
                                self.view.hideToast()
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNaabCode, comment: ""), duration: 2, position: .top)
                                id17display(animalId: idAnimal, borderRed: true)
                                return
                            }
                            
                            
                            if dropFive.isInt  || dropFive == "" {
                                let addObject = 5 - dropFive.count
                                if dropFive.count <= 5 {
                                    if addObject != 0 {
                                        for _ in 0...addObject - 1{
                                            dropFive = "0" + dropFive
                                        }
                                    }
                                    idAnimal = getFive + dropFive
                                    naabCodeCheck(animalId: idAnimal)
                                    
                                } else {
                                    self.view.hideToast()
                                    id17display(animalId: idAnimal, borderRed: true)
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNaabCode, comment: ""), duration: 2, position: .top)
                                    return
                                }
                            }else {
                                self.view.hideToast()
                                id17display(animalId: idAnimal, borderRed: true)
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNaabCode, comment: ""), duration: 2, position: .top)
                                return
                            }
                        }
                        else {
                            if !dropBreedName.isInt  && !dropBreedFirstName.isInt {
                                if idAnimal.count >= 5 {
                                    rinvalidBreedCodeContiune(animalId: idAnimal)
                                    return
                                } else {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalId, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                    return
                                }
                            }
                            
                            let ab = validateFirstLetter(firstLetter: Character(getFour))
                            
                            if breedAr.contains(ab)  {
                                var lastFive = dropFour
                                if lastFive.isInt  {
                                    let addObject = 5 - lastFive.count
                                    if lastFive.count <= 5 {
                                        if addObject != 0 {
                                            for _ in 0...addObject - 1{
                                                lastFive = "0" + lastFive
                                            }
                                        }
                                        idAnimal =  getThi + ab + lastFive
                                        naabCodeCheck(animalId: idAnimal)
                                        
                                    }else {
                                        self.view.hideToast()
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNaabCode, comment: ""), duration: 2, position: .top)
                                        id17display(animalId: idAnimal, borderRed: true)
                                    }
                                }
                                else {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNaabCode, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                }
                            }
                            else {
                                if idAnimal.count >= 5 {
                                    let addObject = 12 - idAnimal.count
                                    if idAnimal.count <= 12 {
                                        
                                        if addObject != 0 {
                                            for _ in 0...addObject - 1{
                                                idAnimal = "0" + idAnimal
                                            }
                                        }
                                        idAnimal = breedBtnOutlet.titleLabel!.text! + providerSelectionCountryCode +  idAnimal
                                        id17display(animalId: idAnimal, borderRed: false)
                                    }
                                    else {
                                        self.view.hideToast()
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidRFIDId, comment: ""), duration: 2, position: .top)
                                        id17display(animalId: idAnimal, borderRed: true)
                                    }
                                    return
                                    
                                } else {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidRFIDId, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                    return
                                }
                            }
                        }
                    }
                    else {
                        let fo = animalId.prefix(4).uppercased()
                        let fourChar = String(fo.dropFirst(3).uppercased())
                        
                        if fourChar.count == 0 {
                            self.view.hideToast()
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidInput, comment: ""), duration: 2, position: .top)
                            id17display(animalId: idAnimal, borderRed: true)
                            return
                        }
                        
                        if fourChar.isInt  {
                            let start = animalId.prefix(2).uppercased()
                            let thirddCheck = animalId.dropFirst(2)
                            let dropThird = animalId.dropFirst(3)
                            let breed = thirddCheck.prefix(1).uppercased()
                            var idFive = dropThird.uppercased()
                            let ab = validateFirstLetter(firstLetter: Character(breed))
                            
                            if breedAr.contains(ab) {
                                if idFive.isInt  {
                                    let addObject = 5 - idFive.count
                                    if idFive.count <= 5 {
                                        if addObject != 0 {
                                            for _ in 0...addObject - 1{
                                                idFive = "0" + idFive
                                            }
                                        }
                                        idAnimal = "0" + start + ab + idFive
                                        naabCodeCheck(animalId: idAnimal)
                                    }
                                    else {
                                        self.view.hideToast()
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                                        id17display(animalId: idAnimal, borderRed: true)
                                        return
                                    }
                                }
                                else {
                                    self.view.hideToast()
                                    id17display(animalId: idAnimal, borderRed: true)
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNaabCode, comment: ""), duration: 2, position: .top)
                                    return
                                }
                            }
                            else {
                                let alertAnimId = idAnimal.uppercased()
                                let addObject = 12 - idAnimal.count
                                if idAnimal.count <= 12 {
                                    if addObject != 0 {
                                        for _ in 0...addObject - 1{
                                            idAnimal = "0" + idAnimal
                                        }
                                    }
                                    
                                    idAnimal = (breedBtnOutlet.titleLabel?.text)! + providerSelectionCountryCode + idAnimal
                                    id17display(animalId: idAnimal, borderRed: false)
                                    return
                                }
                                else {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: alertAnimId, borderRed: true)
                                    return
                                }
                            }
                        } else {
                            let fetchFour = animalId.prefix(4).uppercased()
                            let dropFirsTwoBreed = fetchFour.dropFirst(2).uppercased()
                            let dropFirstFour = animalId.dropFirst(4).uppercased()
                            var idFive = dropFirstFour
                            if breedAr.contains(dropFirsTwoBreed) {
                                if idFive.isInt  {
                                    let addObject = 5 - idFive.count
                                    if idFive.count <= 5 {
                                        
                                        if addObject != 0 {
                                            for _ in 0...addObject - 1{
                                                idFive = "0" + idFive
                                            }
                                        }
                                        idAnimal = "0" + fetchFour + idFive
                                        naabCodeCheck(animalId: idAnimal)
                                    }
                                    else {
                                        self.view.hideToast()
                                        id17display(animalId: idAnimal, borderRed: true)
                                        
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                                        return
                                    }
                                }
                                else {
                                    self.view.hideToast()
                                    id17display(animalId: idAnimal, borderRed: true)
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNaabCode, comment: ""), duration: 2, position: .top)
                                    return
                                }
                            }
                            else {
                                if idAnimal.count >= 5 {
                                    rinvalidBreedCodeContiune(animalId: idAnimal)
                                    return
                                    
                                } else {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidBreedCode, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                    
                                    return
                                }
                            }
                        }
                    }
                }
                else {
                    if thirdCHAR.count == 0 {
                        self.view.hideToast()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNaabCode, comment: ""), duration: 2, position: .top)
                        id17display(animalId: idAnimal, borderRed: true)
                        return
                    }
                    
                    if thirdCHAR.isInt  {
                        let ab = validateFirstLetter(firstLetter: Character(second))
                        if breedAr.contains(ab)  {
                            var lastFive = animalId.dropFirst(2).uppercased()
                            if lastFive.isInt  {
                                let addObject = 5 - lastFive.count
                                if lastFive.count <= 5 {
                                    if addObject != 0 {
                                        for _ in 0...addObject - 1{
                                            lastFive = "0" + lastFive
                                        }
                                    }
                                    idAnimal = "00" + firstElement + ab + lastFive
                                    
                                    if naabArr.contains(idAnimal.uppercased()) {
                                        let fetchNaab = fetchNaabIdToAnimalId(entityName: Entities.getNaabCodeTblEntity, naabCode: idAnimal.uppercased())
                                        if fetchNaab.count == 0 {
                                            self.view.makeToast(NSLocalizedString(LocalizedStrings.noNaabCode, comment: ""), duration: 2, position: .top)
                                            
                                            id17display(animalId: idAnimal, borderRed: true)
                                            return
                                        } else {
                                            let naabFetch = fetchNaab.value(forKey: keyValue.animalId.rawValue) as? NSArray
                                            idAnimal = (naabFetch![0] as? String)!
                                            
                                            id17display(animalId: idAnimal, borderRed: false)
                                            return
                                        }
                                    } else {
                                        self.view.hideToast()
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.naabCodeNotFound, comment: ""), duration: 2, position: .top)
                                        id17display(animalId: idAnimal, borderRed: true)
                                        return
                                        
                                    }
                                    
                                } else {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                    return
                                }
                                
                            }else {
                                self.view.hideToast()
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                                id17display(animalId: idAnimal, borderRed: true)
                                
                            }
                        } else {
                            self.view.hideToast()
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidBreedCode, comment: ""), duration: 2, position: .top)
                            id17display(animalId: idAnimal, borderRed: true)
                            return
                            
                        }
                        
                    } else {
                        let dropFirst = getThi.dropFirst(1).uppercased()
                        
                        if breedAr.contains(dropFirst)  {
                            let arr = idAnimal.components(separatedBy: dropFirst)
                            var lastFive = arr[1]
                            let addObject = 5 - lastFive.count
                            
                            if lastFive.count <= 5 {
                                if lastFive.count == 0 {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNaabCode, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                    return
                                }
                                if addObject != 0 {
                                    for _ in 0...addObject - 1{
                                        lastFive = "0" + lastFive
                                    }
                                }
                                idAnimal = "00" + getThi + lastFive
                                
                                naabCodeCheck(animalId: idAnimal)
                                
                            } else {
                                self.view.hideToast()
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                                id17display(animalId: idAnimal, borderRed: true)
                                return
                                
                            }
                        } else {
                            self.view.hideToast()
                            id17display(animalId: idAnimal, borderRed: true)
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidBreedCode, comment: ""), duration: 2, position: .top)
                            return
                        }
                    }
                }
            }
            else {
                let firstThreeElement = String(idAnimal.prefix(3).uppercased())
                let firstTwo = String(idAnimal.prefix(2).uppercased())
                let removeFirstThree = String(idAnimal.dropFirst(3).uppercased())
                let getCountryCode = String(removeFirstThree.prefix(3).uppercased())
                let gGet = String(removeFirstThree.prefix(4).uppercased())
                let genderGet = String(gGet.dropFirst(3).uppercased())
                if firstThreeElement.isInt != true {
                    if threeCharCode.contains(firstThreeElement) {
                        let indexOfA = threeCharCode.index(of: firstThreeElement)
                        
                        if getCountryCode.uppercased() == "" || getCountryCode.count  == 1 || getCountryCode.count == 2{
                            id17display(animalId: idAnimal, borderRed: true)
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCountryCode, comment: ""), duration: 2, position: .top)
                            return
                        }
                        
                        if countryArr.contains(getCountryCode.uppercased()) || counteryNumericArr.contains(Int(getCountryCode) as Any){
                            if String(genderGet) == "M" || String(genderGet) == "F"{
                                var removeSeven = String(idAnimal.dropFirst(7))
                                
                                if removeSeven.count == 0 {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                    return
                                    
                                }
                                
                                let addObject = 12 - removeSeven.count
                                if removeSeven.count <= 12 {
                                    if addObject != 0 {
                                        for _ in 0...addObject - 1{
                                            removeSeven = "0" + removeSeven
                                        }
                                    }
                                    
                                    idAnimal = firstThreeElement + getCountryCode + removeSeven
                                    
                                    if getCountryCode == "840" || getCountryCode == "USA"{
                                        let obj1 = rangeCheckReturnString(animalId: String(idAnimal.dropFirst(7)), countryCode: getCountryCode)
                                        
                                        if obj1 == LocalizedStrings.invalidRangeStr {
                                            self.view.hideToast()
                                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnim840, comment: ""), duration: 2, position: .top)
                                            id17display(animalId: firstThreeElement + removeFirstThree , borderRed: true)
                                            return
                                        }
                                        let breedC = breedCodesArray.value(forKey: keyValue.alpha2.rawValue) as? NSArray
                                        let breedTwo = (breedC![indexOfA] as? String)!
                                        genderBtnChange(genderFlag: genderGet)
                                        idAnimal = breedTwo + obj1 + removeSeven
                                        breedBtnOutlet.setTitle(breedTwo.uppercased(), for: .normal)
                                        id17display(animalId: idAnimal, borderRed: false)
                                    }
                                    else {
                                        let breedC = breedCodesArray.value(forKey: keyValue.alpha2.rawValue) as? NSArray
                                        let breedTwo = (breedC![indexOfA] as? String)!
                                        genderBtnChange(genderFlag: genderGet)
                                        idAnimal = breedTwo + getCountryCode + removeSeven
                                        breedBtnOutlet.setTitle(breedTwo.uppercased(), for: .normal)
                                        id17display(animalId: idAnimal, borderRed: false)
                                    }
                                    
                                }
                                else {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                    return
                                }
                                
                            } else {
                                self.view.hideToast()
                                id17display(animalId: idAnimal, borderRed: true)
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidGenderCode, comment: ""), duration: 2, position: .top)
                                return
                            }
                        }
                        else {
                            self.view.hideToast()
                            id17display(animalId: idAnimal, borderRed: true)
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCountryCode, comment: ""), duration: 2, position: .top)
                            return
                        }
                    } else {
                        if firstTwo == "XD"{
                            let breedAr = breedCodesArray.value(forKey: keyValue.alpha2.rawValue) as! NSArray
                            XDFound = breedAr.contains("XX")
                        }
                        
                        if breedAr.contains(firstTwo) || XDFound  {
                            let getTwoBreedCode = firstThreeElement.dropLast(1)
                            let removeThreeChar = idAnimal.dropFirst(2)
                            let countryCode = removeThreeChar.prefix(3).uppercased()
                            if countryCode.isInt  {
                                id17FlowNumeric(animalId: idAnimal,countryCode:countryCode,breedCode:firstTwo)
                                return
                            }
                            let cc = removeThreeChar.prefix(4).uppercased()
                            let getGender = cc.dropFirst(3).uppercased()
                            if countryCode.count != 3 {
                                
                                if scanAnimalTagText.tag == 0 {
                                    officalTagView.layer.borderColor = UIColor.red.cgColor
                                }
                                else {
                                    farmIdView.layer.borderColor = UIColor.red.cgColor
                                }
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCountryCode, comment: ""), duration: 2, position: .top)
                                return
                            }
                            if countryCode == CountryCodes.canada {
                                canadaFlow(animalId: idAnimal)
                                return
                            }
                            
                            if countryCode == CountryCodes.australia {
                                AUSFlow(animalId: idAnimal)
                                return
                            }
                            
                            if countryCode == CountryCodes.chile {
                                chiliFlow(animalId:idAnimal)
                                return
                            }
                            
                            if countryCode == CountryCodes.argentina {
                                ARGFlow(animalId:idAnimal)
                                return
                            }
                            
                            if countryCode == CountryCodes.italy {
                                italyFlow(animalId: idAnimal)
                                return
                            }
                            
                            if countryArr.contains(countryCode.uppercased()) {
                                if String(getGender) == "M" || String(getGender) == "F"{
                                    var removeSeven = String(idAnimal.dropFirst(6))
                                    
                                    if removeSeven.isInt  {
                                        let addObject = 12 - removeSeven.count
                                        
                                        if removeSeven.count <= 12 {
                                            if addObject != 0 {
                                                for _ in 0...addObject - 1{
                                                    removeSeven = "0" + removeSeven
                                                }
                                            }
                                            
                                            idAnimal = getTwoBreedCode + countryCode + removeSeven
                                            let obj = rangeCheck(animalId:  removeSeven, countryCode: countryCode.uppercased())
                                            
                                            if obj {
                                                if getTwoBreedCode == "XD"{
                                                    breedBtnOutlet.setTitle("XX", for: .normal)
                                                } else {
                                                    breedBtnOutlet.setTitle(getTwoBreedCode.uppercased(), for: .normal)
                                                }
                                                genderBtnChange(genderFlag: getGender)
                                                id17display(animalId: idAnimal, borderRed: false)
                                                
                                            } else {
                                                self.view.hideToast()
                                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimUSA, comment: ""), duration: 2, position: .top)
                                                id17display(animalId: animalId.uppercased(), borderRed: true)
                                                return
                                            }
                                        }
                                        else {
                                            self.view.hideToast()
                                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                                            id17display(animalId: idAnimal, borderRed: true)
                                            return
                                        }
                                    } else {
                                        self.view.hideToast()
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                                        id17display(animalId: idAnimal, borderRed: true)
                                        return
                                    }
                                } else {
                                    id17FlowNumeric(animalId: idAnimal,countryCode:countryCode,breedCode:firstTwo)
                                }
                            }
                            else {
                                if firstTwo == "XD"{
                                    let breedAr = breedCodesArray.value(forKey: keyValue.alpha2.rawValue) as! NSArray
                                    XDFound = breedAr.contains("XX")
                                }
                                
                                if breedAr.contains(firstTwo) || XDFound {
                                    let dropOne = idAnimal.dropFirst(1).uppercased()
                                    let nextThree = dropOne.prefix(3).uppercased()
                                    var dropThree = dropOne.dropFirst(3).uppercased()
                                    
                                    if countryArr.contains(nextThree.uppercased()) {
                                        let addObject = 12 - dropThree.count
                                        if dropThree.count <= 12 {
                                            if addObject != 0 {
                                                for _ in 0...addObject - 1{
                                                    dropThree = "0" + dropThree
                                                }
                                            }
                                            
                                            let ob = rangeCheckReturnString(animalId: dropThree, countryCode: nextThree)
                                            if ob == LocalizedStrings.invalidRangeStr {
                                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnim840, comment: ""), duration: 2, position: .top)
                                                id17display(animalId: idAnimal, borderRed: true)
                                                return
                                            }
                                            else {
                                                idAnimal = firstTwo + ob +  dropThree
                                                id17display(animalId: idAnimal, borderRed: false)
                                                return
                                            }
                                        }
                                        else {
                                            self.view.hideToast()
                                            id17display(animalId: idAnimal, borderRed: true)
                                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                                            return
                                        }
                                    }
                                    
                                    var dropFirstTwo = idAnimal.dropFirst(2).uppercased()
                                    let addObject = 12 - dropFirstTwo.count
                                    
                                    if dropFirstTwo.count <= 12 {
                                        if addObject != 0 {
                                            for _ in 0...addObject - 1{
                                                dropFirstTwo = "0" + dropFirstTwo
                                            }
                                        }
                                        
                                        idAnimal = firstTwo + providerSelectionCountryCode +  dropFirstTwo
                                        if firstTwo == "XD" {
                                            breedBtnOutlet.setTitle("XX", for: .normal)
                                        } else {
                                            breedBtnOutlet.setTitle(firstTwo, for: .normal)
                                        }
                                        id17display(animalId: idAnimal, borderRed: false)
                                    } else {
                                        self.view.hideToast()
                                        id17display(animalId: idAnimal, borderRed: true)
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                                        return
                                    }
                                }
                            }
                        } else {
                            idseventiyfifty(animalId: idAnimal)
                        }
                    }
                }
            }
        }
    }
    
    func rinvalidBreedCodeContiune(animalId:String){
        var idAnimal = animalId
        if idAnimal.count >= 5 {
            let addObject = 12 - idAnimal.count
            if idAnimal.count <= 12 {
                if addObject != 0 {
                    for _ in 0...addObject - 1{
                        idAnimal = "0" + idAnimal
                    }
                }
                idAnimal = breedBtnOutlet.titleLabel!.text! + providerSelectionCountryCode +  idAnimal
                id17display(animalId: idAnimal, borderRed: false)
                
            } else {
                self.view.hideToast()
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidRFIDId, comment: ""), duration: 2, position: .top)
                
                id17display(animalId: idAnimal, borderRed: true)
            }
            return
        }
        else {
            self.view.hideToast()
            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidRFIDId, comment: ""), duration: 2, position: .top)
            id17display(animalId: idAnimal, borderRed: true)
            return
        }
    }
    
    func id17FlowNumeric(animalId:String,countryCode:String,breedCode:String){
        let countryC = countryCode
        let breedC = breedCode
        var idAnimal = animalId.uppercased()
        let breedAr = breedCodesArray.value(forKey: keyValue.alpha2.rawValue) as! NSArray
        countryCodesArray = fetchAllData(entityName: Entities.getCountryCodeTblEntity)
        let countryArr = countryCodesArray.value(forKey: keyValue.alphaCode.rawValue) as! NSArray
        let counteryNumericArr = countryCodesArray.value(forKey: keyValue.numericCode.rawValue) as! NSArray
        var dropFive = idAnimal.dropFirst(5).uppercased()
        
        if countryArr.contains(countryC.uppercased()) || counteryNumericArr.contains(Int(countryC) as Any){
            if dropFive.count == 0 {
                self.view.hideToast()
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                id17display(animalId: idAnimal, borderRed: true)
                return
            }
            
            if dropFive.count <= 12 {
                let addObject = 12 - dropFive.count
                if dropFive.count <= 12 {
                    
                    if addObject != 0 {
                        for _ in 0...addObject - 1{
                            dropFive = "0" + dropFive
                        }
                    }
                    
                    if dropFive.isInt  {
                        let obj = rangeCheckReturnString(animalId: dropFive, countryCode: countryC)
                        
                        if obj == LocalizedStrings.invalidRangeStr {
                            self.view.hideToast()
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnim840, comment: ""), duration: 2, position: .top)
                            id17display(animalId: idAnimal, borderRed: true)
                            return
                        }
                        
                        idAnimal = breedC + obj + dropFive
                        if breedC == "XD"{
                            breedBtnOutlet.setTitle("XX", for: .normal)
                        } else {
                            breedBtnOutlet.setTitle(breedC.uppercased(), for: .normal)
                        }
                        id17display(animalId: idAnimal, borderRed: false)
                    }
                    else {
                        idAnimal = breedC + countryC + dropFive
                        if breedC == "XD"{
                            breedBtnOutlet.setTitle("XX", for: .normal)
                        } else {
                            breedBtnOutlet.setTitle(breedC.uppercased(), for: .normal)
                        }
                        id17display(animalId: idAnimal, borderRed: false)
                        
                    }
                } else {
                    self.view.hideToast()
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                    id17display(animalId: idAnimal, borderRed: true)
                    
                }
            } else {
                self.view.hideToast()
                id17display(animalId: idAnimal, borderRed: true)
                
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
            }
            
        } else {
            
            let firstTwo = idAnimal.prefix(2).uppercased()
            if firstTwo == "XD"{
                let breedAr = breedCodesArray.value(forKey: keyValue.alpha2.rawValue) as! NSArray
                XDFound = breedAr.contains("XX")
            }
            
            if breedAr.contains(firstTwo) ||  XDFound {
                var dropFirstTwo = idAnimal.dropFirst(2).uppercased()
                let addObject = 12 - dropFirstTwo.count
                if dropFirstTwo.count <= 12 {
                    
                    if addObject != 0 {
                        for _ in 0...addObject - 1{
                            dropFirstTwo = "0" + dropFirstTwo
                        }
                    }
                    
                    if countryCode == "840" || countryCode == "USA"{
                        let ob = rangeCheckReturnString(animalId: dropFirstTwo, countryCode: providerSelectionCountryCode)
                        if firstTwo == "XD"{
                            breedBtnOutlet.setTitle("XX", for: .normal)
                        } else {
                            breedBtnOutlet.setTitle(firstTwo.uppercased(), for: .normal)
                        }
                        idAnimal = firstTwo + ob +  dropFirstTwo
                        id17display(animalId: idAnimal, borderRed: false)
                        return
                    }
                    else {
                        let ob = rangeCheckReturnString(animalId: dropFirstTwo, countryCode: providerSelectionCountryCode)
                        
                        if ob == LocalizedStrings.invalidRangeStr {
                            self.view.hideToast()
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnim840, comment: ""), duration: 2, position: .top)
                            id17display(animalId: idAnimal, borderRed: true)
                            return
                            
                        }
                        else {
                            if firstTwo == "XD"{
                                breedBtnOutlet.setTitle("XX", for: .normal)
                            } else {
                                breedBtnOutlet.setTitle(firstTwo.uppercased(), for: .normal)
                            }
                            idAnimal = firstTwo + providerSelectionCountryCode +  dropFirstTwo
                            id17display(animalId: idAnimal, borderRed: false)
                            return
                        }
                    }
                } else {
                    self.view.hideToast()
                    id17display(animalId: idAnimal, borderRed: true)
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                    return
                }
            }
        }
    }
    
    func id17display(animalId:String,borderRed :Bool){
        self.borderRedChange = borderRed
        let idAnimal = animalId
        
        if scanAnimalTagText.tag == 0 {
            if !borderRedChange {
                scanAnimalTagText.text! = idAnimal.uppercased()
                UserDefaults.standard.set(idAnimal.uppercased(), forKey: keyValue.selectAnimalId.rawValue)
                scanAnimalTagText.textColor = UIColor.black
                self.view.makeToast(NSLocalizedString(LocalizedStrings.animalIDValidated, comment: ""), duration: 1, position: .top)
                borderRedChange = false
                let breedName = idAnimal.prefix(2).uppercased()
                let codeId = fetchBreedDatabreedCode( entityName: Entities.getBreedsTblEntity,provId: pvid,breedCode:breedName)
                
                if codeId.count != 0 {
                    let naabFetch1 = codeId.value(forKey: keyValue.breedId.rawValue) as? NSArray
                    let breedIdGet = (naabFetch1![0] as? String)!
                    breedId = breedIdGet
                }
                
                textFieldAnimal = idAnimal.uppercased()
                borderRedCheck = false
                officalTagView.layer.borderColor = UIColor.gray.cgColor
                
                if dataAutoPopulatedBool  {
                    let bbb =  fetchAnimaldataValidateAnimalBarcodetag(entityName: Entities.animalAddTblEntity,animalbarCodeTag:textFieldAnimal ,orderId: orderId, userId: userId, custmerId: custmerId)
                    if bbb.count != 0 {
                        farmIDBoolEntryTag = true
                    } else {
                        farmIDBoolEntryTag = false
                    }
                }
                else {
                    let newcheck = fetchAllDataOrdercheck(entityName: Entities.animalMasterTblEntity, ordestatus: "true", animalTag:animalId ,userId: userId, animalBarcode: "")
                    let newcheck1 = fetchAllDataOrdercheck(entityName: Entities.animalAddTblEntity, ordestatus: "false", animalTag:animalId ,userId: userId, animalBarcode: "")
                    
                    if newcheck.count > 0{
                        let screenRefernce = UserDefaults.standard.value(forKey:keyValue.screen.rawValue) as? String
                        if screenRefernce == keyValue.officialId.rawValue || screenRefernce == ""{
                            dataPopulateInFocusChange()
                        }
                        else{
                            newanimaltagvalue = animalId
                            mainrecord = true
                        }
                    }
                    
                    if newcheck1.count > 0{
                        let screenRefernce = UserDefaults.standard.value(forKey:keyValue.screen.rawValue) as? String
                        if screenRefernce == keyValue.officialId.rawValue || screenRefernce == ""{
                            dataPopulateInFocusChange()
                        }
                        else{
                            newanimaltagvalue = animalId
                            mainrecord = true
                        }
                    }
                }
                
            } else {
                scanAnimalTagText.text! = idAnimal.uppercased()
                scanAnimalTagText.textColor = UIColor.red
                borderRedChange = true
                textFieldAnimal = ""
                borderRedCheck = true
                officalTagView.layer.borderColor = UIColor.red.cgColor
            }
            
        } else {
            if !borderRedChange  {
                farmIdTextField.text! = idAnimal.uppercased()
                farmIdTextField.textColor = UIColor.black
                self.view.makeToast(NSLocalizedString(LocalizedStrings.animalIDValidated, comment: ""), duration: 1, position: .top)
                UserDefaults.standard.set(idAnimal.uppercased(), forKey: keyValue.selectAnimalId.rawValue)
                borderRedChange = false
                textFieldAnimal = idAnimal.uppercased()
                borderRedCheck = false
                farmIdView.layer.borderColor = UIColor.gray.cgColor
                let breedName = idAnimal.prefix(2).uppercased()
                let codeId = fetchBreedDatabreedCode( entityName: Entities.getBreedsTblEntity,provId: pvid,breedCode:breedName)
                if codeId.count != 0 {
                    
                    let naabFetch1 = codeId.value(forKey: keyValue.breedId.rawValue) as? NSArray
                    let breedIdGet = (naabFetch1![0] as? String)!
                    breedId = breedIdGet
                    if idAnimal.prefix(2).uppercased() == "XD" {
                        breedBtnOutlet.setTitle("XX", for: UIControl.State.normal)
                    } else {
                        breedBtnOutlet.setTitle(idAnimal.prefix(2).uppercased(), for: UIControl.State.normal)
                    }
                }
            }
            else {
                farmIdTextField.text! = idAnimal.uppercased()
                farmIdTextField.textColor = UIColor.red
                borderRedChange = true
                textFieldAnimal = ""
                borderRedCheck = true
                farmIdView.layer.borderColor = UIColor.red.cgColor
                
            }
        }
    }
    
    
    func idseventiyfifty(animalId:String){
        let breedAr = breedCodesArray.value(forKey: keyValue.alpha2.rawValue) as! NSArray
        countryCodesArray = fetchAllData(entityName: Entities.getCountryCodeTblEntity)
        let countryArr = countryCodesArray.value(forKey: keyValue.alphaCode.rawValue) as! NSArray
        let counteryNumericArr = countryCodesArray.value(forKey: keyValue.numericCode.rawValue) as! NSArray
        
        if genderString == "Male".localized {
            genderFirst = "M"
        } else if genderString == "Female" {
            genderFirst = "F"
        }
        var idAnimal = animalId.uppercased()
        let firstthrree = String(idAnimal.prefix(3).uppercased())
        let firstTwoBreedCode = String(idAnimal.prefix(2).uppercased())
        let cCheck = String(idAnimal.prefix(5).uppercased())
        let countryCode = String(cCheck.dropFirst(2).uppercased())
        let gender = String(idAnimal.prefix(6).uppercased())
        let getGender = String(gender.dropFirst(5).uppercased())
        var removeFirstSix = String(idAnimal.dropFirst(6).uppercased())
        var removeFive = String(idAnimal.dropFirst(5).uppercased())
        
        if firstTwoBreedCode.isInt  {
            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalId, comment: ""), duration: 2, position: .top)
            id17display(animalId: idAnimal, borderRed: true)
        }
        else {
            if breedAr.contains(firstTwoBreedCode) {
                if countryCode.isInt {
                    if countryArr.contains(countryCode.uppercased()) || counteryNumericArr.contains(Int(countryCode) as Any){
                        if removeFive.isInt  {
                            let addObject = 12 - removeFive.count
                            
                            if addObject != 0 {
                                for _ in 0...addObject - 1{
                                    removeFive = "0" + removeFive
                                }
                            }
                            
                            idAnimal =  firstTwoBreedCode  + countryCode + removeFive
                            breedBtnOutlet.setTitle(firstTwoBreedCode.uppercased(), for: .normal)
                            id17display(animalId: idAnimal, borderRed: false)
                        } else {
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                            id17display(animalId: idAnimal, borderRed: true)
                        }
                    } else {
                        id17display(animalId: idAnimal, borderRed: true)
                        
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCountryCode, comment: ""), duration: 2, position: .top)
                    }
                } else {
                    if countryArr.contains(countryCode.uppercased()) || counteryNumericArr.contains(Int(countryCode) as Any){
                        if String(getGender) == "M" || String(getGender) == "F"{
                            if removeFirstSix.isInt  {
                                let addObject = 12 - removeFirstSix.count
                                
                                if addObject != 0 {
                                    for _ in 0...addObject - 1{
                                        removeFirstSix = "0" + removeFirstSix
                                    }
                                }
                                
                                idAnimal =  firstTwoBreedCode  + countryCode + removeFirstSix
                                breedBtnOutlet.setTitle(firstTwoBreedCode.uppercased(), for: .normal)
                                genderBtnChange(genderFlag: getGender)
                                id17display(animalId: idAnimal, borderRed: false)
                            }
                            else {
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                                id17display(animalId: idAnimal, borderRed: true)
                            }
                        }
                        else {
                            id17display(animalId: idAnimal, borderRed: true)
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidGenderCode, comment: ""), duration: 2, position: .top)
                        }
                        
                    } else {
                        id17display(animalId: idAnimal, borderRed: true)
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCountryCode, comment: ""), duration: 2, position: .top)
                    }
                }
                
            } else {
                if countryArr.contains(firstthrree.uppercased()) {
                    if firstthrree == CountryCodes.chile || firstthrree == "chl" {
                        if idAnimal.isInt != true {
                            let firstSixLetter = idAnimal.prefix(6).uppercased()
                            let firstThreeLetter = firstSixLetter.prefix(3).uppercased()
                            let nextThree = firstSixLetter.dropFirst(3).uppercased()
                            var dropFirstSix = idAnimal.dropFirst(6).uppercased()
                            if firstThreeLetter == CountryCodes.chile {
                                if nextThree == "SAG" {
                                    if dropFirstSix.count >= 6 && dropFirstSix.count <= 9 {
                                        
                                        let addObject = 9 - dropFirstSix.count
                                        if dropFirstSix.count <= 9 {
                                            if addObject != 0 {
                                                for _ in 0...addObject - 1{
                                                    dropFirstSix = "0" + dropFirstSix
                                                }
                                            }
                                            
                                            idAnimal =  (breedBtnOutlet.titleLabel?.text)!  + firstSixLetter + dropFirstSix
                                            id17display(animalId: idAnimal, borderRed: false)
                                            return
                                        } else {
                                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                                            id17display(animalId: idAnimal, borderRed: true)
                                            
                                        }
                                    } else {
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                                        id17display(animalId: idAnimal, borderRed: true)
                                        return
                                        
                                    }
                                } else {
                                    
                                    var idanimmal = idAnimal.dropFirst(3).uppercased()
                                    let dropFive = idanimmal.prefix(5).uppercased()
                                    if dropFive == "00000" {
                                        if idanimmal.count >= 6 && idanimmal.count <= 9 {
                                            let addObject = 12 - idanimmal.count
                                            if idanimmal.count <= 12 {
                                                if addObject != 0 {
                                                    for _ in 0...addObject - 1{
                                                        idanimmal = "0" + idanimmal
                                                    }
                                                }
                                                idAnimal =  (breedBtnOutlet.titleLabel?.text)!  + CountryCodes.chile + idanimmal
                                                id17display(animalId: idAnimal, borderRed: false)
                                                return
                                            }
                                        }
                                        else {
                                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                                            id17display(animalId: idAnimal, borderRed: true)
                                            return
                                        }
                                    } else {
                                        if idanimmal.count >= 6 && idanimmal.count <= 9 {
                                            
                                            let addObject = 9 - idanimmal.count
                                            if idanimmal.count <= 9 {
                                                
                                                if addObject != 0 {
                                                    for _ in 0...addObject - 1{
                                                        idanimmal = "0" + idanimmal
                                                    }
                                                }
                                                
                                                idAnimal =  (breedBtnOutlet.titleLabel?.text)!  + "CHLSAG" + idanimmal
                                                id17display(animalId: idAnimal, borderRed: false)
                                                return
                                            } else {
                                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                                                id17display(animalId: idAnimal, borderRed: true)
                                                return
                                            }
                                        } else {
                                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                                            id17display(animalId: idAnimal, borderRed: true)
                                            return
                                        }
                                    }
                                }
                                
                            } else {
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                                id17display(animalId: idAnimal, borderRed: true)
                                return
                                
                            }
                        }
                    }
                }
                
                if firstthrree == "SAG" {
                    let firstThreeDrop = idAnimal.dropFirst(3).uppercased()
                    if firstThreeDrop.count == 0 {
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                        id17display(animalId: idAnimal, borderRed: true)
                        return
                    }
                    if firstThreeDrop.isInt  {
                        if firstThreeDrop.count >= 6 &&  firstThreeDrop.count <= 9 {
                            var idanimmal = idAnimal.dropFirst(3).uppercased()
                            let addObject = 9 - idanimmal.count
                            
                            if addObject != 0 {
                                for _ in 0...addObject - 1{
                                    idanimmal = "0" + idanimmal
                                }
                            }
                            
                            idAnimal =  (breedBtnOutlet.titleLabel?.text)!  + "CHLSAG" + idanimmal
                            id17display(animalId: idAnimal, borderRed: false)
                            return
                        }
                        else {
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                            id17display(animalId: idAnimal, borderRed: true)
                            return
                        }
                    } else {
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                        id17display(animalId: idAnimal, borderRed: true)
                        return
                    }
                }
                if firstthrree == CountryCodes.argentina {
                    var firstThreeDrop = idAnimal.dropFirst(3).uppercased()
                    if firstThreeDrop.count == 0 {
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                        id17display(animalId: idAnimal, borderRed: true)
                        return
                    }
                    
                    if idAnimal.contains("RCE"){
                        let indexRCE = firstThreeDrop.range(of: "RCE", options: .forcedOrdering)?.upperBound
                        if indexRCE != nil{
                            let beforeRCE = String(firstThreeDrop[..<indexRCE!])
                            let animalCountE = firstThreeDrop.count - beforeRCE.count
                            let dropLastEl = String(firstThreeDrop.dropFirst(beforeRCE.count))
                            let dropFirstVale = String(beforeRCE.dropLast(3))
                            
                            if dropLastEl.isInt  && (dropFirstVale.isInt  || dropFirstVale.count == 0 ){
                                if animalCountE == 6 {
                                    let addObject = 12 - firstThreeDrop.count
                                    if firstThreeDrop.count <= 12 {
                                        
                                        if addObject != 0 {
                                            for _ in 0...addObject - 1{
                                                firstThreeDrop = "0" + firstThreeDrop
                                            }
                                        }
                                        idAnimal =  (breedBtnOutlet.titleLabel?.text)!  + CountryCodes.argentina + firstThreeDrop
                                        
                                        id17display(animalId: idAnimal, borderRed: false)
                                        return
                                    } else {
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                        id17display(animalId: idAnimal, borderRed: true)
                                        return
                                    }
                                    
                                } else {
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                    return
                                }
                            }else {
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                id17display(animalId: idAnimal, borderRed: true)
                                return
                            }
                        }
                    }
                    
                    if idAnimal.contains("E"){
                        if firstThreeDrop.count > 7 {
                            let indexE = firstThreeDrop.range(of: "E", options: .forcedOrdering)?.upperBound
                            if indexE != nil{
                                let beforeE = String(firstThreeDrop[..<indexE!])
                                let dropElast = String(beforeE.dropLast())
                                let animalCountE = firstThreeDrop.count - beforeE.count
                                let dropLastEl = String(firstThreeDrop.dropFirst(beforeE.count))
                                
                                if (dropElast.isInt  || dropElast.count == 0) && (dropLastEl.isInt  || dropLastEl.count == 0) {
                                    
                                    if animalCountE == 6 {
                                        let addObject = 12 - firstThreeDrop.count
                                        if firstThreeDrop.count <= 12 {
                                            
                                            if addObject != 0 {
                                                for _ in 0...addObject - 1{
                                                    firstThreeDrop = "0" + firstThreeDrop
                                                }
                                            }
                                            idAnimal =  (breedBtnOutlet.titleLabel?.text)!  + CountryCodes.argentina + firstThreeDrop
                                            
                                            id17display(animalId: idAnimal, borderRed: false)
                                            return
                                        } else {
                                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                            id17display(animalId: idAnimal, borderRed: true)
                                            return
                                        }
                                        
                                    } else {
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                        id17display(animalId: idAnimal, borderRed: true)
                                        return
                                    }
                                    
                                } else {
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                    return
                                }
                            }
                            
                        } else {
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                            id17display(animalId: idAnimal, borderRed: true)
                        }
                    }
                    
                    if idAnimal.contains("U"){
                        if firstThreeDrop.count > 7 {
                            let indexE = firstThreeDrop.range(of: "U", options: .forcedOrdering)?.upperBound
                            if indexE != nil{
                                let beforeE = String(firstThreeDrop[..<indexE!])
                                let dropElast = String(beforeE.dropLast())
                                
                                let animalCountE = firstThreeDrop.count - beforeE.count
                                let dropLastEl = String(firstThreeDrop.dropFirst(beforeE.count))
                                
                                if (dropElast.isInt  || dropElast.count == 0) && (dropLastEl.isInt  || dropLastEl.count == 0) {
                                    
                                    if animalCountE == 8 {
                                        let addObject = 12 - firstThreeDrop.count
                                        if firstThreeDrop.count <= 12 {
                                            
                                            if addObject != 0 {
                                                for _ in 0...addObject - 1{
                                                    firstThreeDrop = "0" + firstThreeDrop
                                                }
                                            }
                                            idAnimal =  (breedBtnOutlet.titleLabel?.text)!  + CountryCodes.argentina + firstThreeDrop
                                            
                                            id17display(animalId: idAnimal, borderRed: false)
                                            return
                                        } else {
                                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                            id17display(animalId: idAnimal, borderRed: true)
                                            return
                                        }
                                        
                                    } else {
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                        id17display(animalId: idAnimal, borderRed: true)
                                        return
                                    }
                                    
                                } else {
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                    return
                                }
                            }
                            
                        } else {
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                            id17display(animalId: idAnimal, borderRed: true)
                            
                        }
                    }
                }
                
                if providerSelectionCountryCode == CountryCodes.argentina {
                    var firstThreeDrop = idAnimal
                    if idAnimal.contains("RCE"){
                        let indexRCE = firstThreeDrop.range(of: "RCE", options: .forcedOrdering)?.upperBound
                        if indexRCE != nil{
                            let beforeRCE = String(firstThreeDrop[..<indexRCE!])
                            let animalCountE = firstThreeDrop.count - beforeRCE.count
                            let dropLastEl = String(firstThreeDrop.dropFirst(beforeRCE.count))
                            let dropFirstVale = String(beforeRCE.dropLast(3))
                            
                            if dropLastEl.isInt  && (dropFirstVale.isInt  || dropFirstVale.count == 0 ){
                                
                                if animalCountE == 6 {
                                    let addObject = 12 - firstThreeDrop.count
                                    if firstThreeDrop.count <= 12 {
                                        
                                        if addObject != 0 {
                                            for _ in 0...addObject - 1{
                                                firstThreeDrop = "0" + firstThreeDrop
                                            }
                                        }
                                        idAnimal =  (breedBtnOutlet.titleLabel?.text)!  + CountryCodes.argentina + firstThreeDrop
                                        
                                        id17display(animalId: idAnimal, borderRed: false)
                                        return
                                    } else {
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                        id17display(animalId: idAnimal, borderRed: true)
                                        return
                                    }
                                    
                                } else {
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                    return
                                }
                            }else {
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                id17display(animalId: idAnimal, borderRed: true)
                                return
                            }
                        }
                    }
                    
                    if firstThreeDrop.count >= 7 {
                        let indexE = firstThreeDrop.range(of: "E", options: .forcedOrdering)?.upperBound
                        if indexE != nil{
                            let beforeE = String(firstThreeDrop[..<indexE!])
                            let dropElast = String(beforeE.dropLast())
                            let animalCountE = firstThreeDrop.count - beforeE.count
                            let dropLastEl = String(firstThreeDrop.dropFirst(beforeE.count))
                            
                            if (dropElast.isInt  || dropElast.count == 0) && (dropLastEl.isInt  || dropLastEl.count == 0) {
                                if animalCountE == 6 {
                                    let addObject = 12 - firstThreeDrop.count
                                    if firstThreeDrop.count <= 12 {
                                        
                                        if addObject != 0 {
                                            for _ in 0...addObject - 1{
                                                firstThreeDrop = "0" + firstThreeDrop
                                            }
                                        }
                                        idAnimal =  (breedBtnOutlet.titleLabel?.text)!  + CountryCodes.argentina + firstThreeDrop
                                        
                                        id17display(animalId: idAnimal, borderRed: false)
                                        return
                                    } else {
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                        id17display(animalId: idAnimal, borderRed: true)
                                        return
                                    }
                                    
                                } else {
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                    return
                                }
                                
                            } else {
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                id17display(animalId: idAnimal, borderRed: true)
                                return
                            }
                        }
                    }
                    if idAnimal.contains("U"){
                        if firstThreeDrop.count > 7 {
                            let indexE = firstThreeDrop.range(of: "U", options: .forcedOrdering)?.upperBound
                            if indexE != nil{
                                let beforeE = String(firstThreeDrop[..<indexE!])
                                let dropElast = String(beforeE.dropLast())
                                let animalCountE = firstThreeDrop.count - beforeE.count
                                let dropLastEl = String(firstThreeDrop.dropFirst(beforeE.count))
                                
                                if (dropElast.isInt  || dropElast.count == 0) && (dropLastEl.isInt  || dropLastEl.count == 0) {
                                    if animalCountE == 8 {
                                        let addObject = 12 - firstThreeDrop.count
                                        if firstThreeDrop.count <= 12 {
                                            
                                            if addObject != 0 {
                                                for _ in 0...addObject - 1{
                                                    firstThreeDrop = "0" + firstThreeDrop
                                                }
                                            }
                                            idAnimal =  (breedBtnOutlet.titleLabel?.text)!  + CountryCodes.argentina + firstThreeDrop
                                            
                                            id17display(animalId: idAnimal, borderRed: false)
                                            return
                                        } else {
                                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                            id17display(animalId: idAnimal, borderRed: true)
                                            return
                                        }
                                        
                                    } else {
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                        id17display(animalId: idAnimal, borderRed: true)
                                        return
                                    }
                                    
                                } else {
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                    return
                                }
                            }
                            
                        } else {
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                            id17display(animalId: idAnimal, borderRed: true)
                            
                        }
                    }
                }
                
                let firsttt = firstthrree.prefix(1).uppercased()
                let ab = validateFirstLetter(firstLetter: Character(firsttt))
                
                if ab.count != 0 {
                    let dropFirstFour = idAnimal.prefix(4).uppercased()
                    let dropFirstOne = dropFirstFour.dropFirst(1).uppercased()
                    var dropFour = idAnimal.dropFirst(4).uppercased()
                    
                    
                    if dropFirstOne == "" {
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalId, comment: ""), duration: 2, position: .top)
                        id17display(animalId: idAnimal, borderRed: true)
                        return
                    }
                    
                    if countryArr.contains(dropFirstOne.uppercased()) {
                        let addObject = 12 - dropFour.count
                        if dropFour.count <= 12 {
                            if addObject != 0 {
                                for _ in 0...addObject - 1{
                                    dropFour = "0" + dropFour
                                }
                            }
                            
                            if dropFirstOne == "840" || dropFirstOne == "USA"{
                                let ob = rangeCheckReturnString(animalId: dropFour, countryCode: dropFirstOne)
                                if ob == LocalizedStrings.invalidRangeStr {
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnim840, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                    return
                                    
                                }else {
                                    idAnimal = ab + ob +  dropFour
                                    id17display(animalId: idAnimal, borderRed: false)
                                    return
                                }
                            } else {
                                idAnimal = ab + dropFirstOne +  dropFour
                                id17display(animalId: idAnimal, borderRed: false)
                                return
                            }
                        } else {
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                            id17display(animalId: idAnimal, borderRed: true)
                            return
                        }
                    }
                }
                
                let countryCode = idAnimal.prefix(3).uppercased()
                var remaningValue = idAnimal.dropFirst(3).uppercased()
                
                if idAnimal.isAlphanumeric  {
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                    id17display(animalId: idAnimal, borderRed: true)
                    return
                    
                }
                
                if countryArr.contains(countryCode.uppercased()) {
                    let addObject = 12 - remaningValue.count
                    if remaningValue.count <= 12 {
                        if addObject != 0 {
                            for _ in 0...addObject - 1{
                                remaningValue = "0" + remaningValue
                            }
                        }
                        
                        if remaningValue.isInt  {
                            if countryCode == "840" || countryCode == "USA"{
                                let ob = rangeCheckReturnString(animalId: remaningValue, countryCode: countryCode)
                                idAnimal = breedBtnOutlet.titleLabel!.text! + ob +  remaningValue
                                id17display(animalId: idAnimal, borderRed: false)
                                return
                            } else {
                                idAnimal = breedBtnOutlet.titleLabel!.text! + countryCode +  remaningValue
                                id17display(animalId: idAnimal, borderRed: false)
                                return
                            }
                            
                        } else {
                            idAnimal = breedBtnOutlet.titleLabel!.text! + countryCode +  remaningValue
                            id17display(animalId: idAnimal, borderRed: false)
                            return
                        }
                    }else {
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                        id17display(animalId: idAnimal, borderRed: true)
                    }
                }
                else {
                    let addObject = 12 - idAnimal.count
                    if idAnimal.count <= 12 {
                        
                        if addObject != 0 {
                            for _ in 0...addObject - 1{
                                idAnimal = "0" + idAnimal
                            }
                        }
                        
                        idAnimal = breedBtnOutlet.titleLabel!.text! + providerSelectionCountryCode +  idAnimal
                        id17display(animalId: idAnimal, borderRed: false)
                        
                        return
                    } else {
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                        id17display(animalId: idAnimal, borderRed: true)
                        return
                    }
                }
            }
        }
    }
    
    //MARK: RFID SCANNING AND OTHER METHODS
    func rfidScanning(animalId:String){
        var inputLessThenEight = animalId
        let numberAsInt = Int(animalId)
        let backToString = "\(numberAsInt!)"
        var idAnimal = backToString
        let firstValueThree = idAnimal.prefix(1)
        var get3CountryCode = idAnimal.prefix(3)
        let drop3 = idAnimal.dropFirst(3).uppercased()
        
        if inputLessThenEight.count < 8 {
            let addObject = 12 - inputLessThenEight.count
            if inputLessThenEight.count <= 12 {
                if addObject != 0 {
                    for _ in 0...addObject - 1{
                        inputLessThenEight = "0" + inputLessThenEight
                    }
                }
            }
            
            if providerSelectionCountryCode != "USA" {
                let last12 = inputLessThenEight.suffix(12)
                
                if last12 == "000000000000" {
                    self.view.makeToast(NSLocalizedString("Invalid Animal Id", comment: ""), duration: 2, position: .top)
                    id17display(animalId: animalId, borderRed: true)
                    return
                }
            }
            
            let obj1 = rangeCheckReturnString(animalId: String(inputLessThenEight), countryCode: providerSelectionCountryCode)
            
            if obj1 == LocalizedStrings.invalidRangeStr {
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimUSA, comment: ""), duration: 2, position: .top)
                id17display(animalId: animalId, borderRed: true)
                return
            }
            else {
                idAnimal = breedBtnOutlet.titleLabel!.text! + providerSelectionCountryCode + inputLessThenEight
                id17display(animalId: idAnimal, borderRed: false)
                return
            }
        }
        
        if get3CountryCode.count != 3 {
            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCountryCode, comment: ""), duration: 2, position: .top)
            id17display(animalId: idAnimal, borderRed: true)
            return
        }
        
        var dropElments = idAnimal
        if firstValueThree == "3" && (003001000001) <= (Int(animalId)!) && providerSelectionCountryCode == "USA"{
            let addObject = 12 - dropElments.count
            if dropElments.count <= 12 {
                if addObject != 0 {
                    for _ in 0...addObject - 1{
                        dropElments = "0" + dropElments
                    }
                }
                idAnimal = breedBtnOutlet.titleLabel!.text! + "840" + dropElments
                id17display(animalId: idAnimal, borderRed: false)
                return
            }
            else {
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidRFIDId, comment: ""), duration: 2, position: .top)
                id17display(animalId: idAnimal, borderRed: true)
                return
            }
        }
        
        if counteryNumericArr.contains(Int(get3CountryCode) as Any) && pvid != 11{
            var digitsTwelve = dropElments.dropFirst(3)
            if digitsTwelve.count == 0  {
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidRFIDId, comment: ""), duration: 2, position: .top)
                id17display(animalId: idAnimal, borderRed: true)
                return
            }
            if digitsTwelve.count <= 12 {
                if get3CountryCode == "840" || get3CountryCode == "USA"{
                    if get3CountryCode == "840" && (003001000001) <= (Int(digitsTwelve)!) {
                        let addObject = 12 - digitsTwelve.count
                        if addObject != 0{
                            for _ in 0...addObject - 1{
                                digitsTwelve = "0" + digitsTwelve
                            }
                        }
                        idAnimal = breedBtnOutlet.titleLabel!.text! + get3CountryCode + digitsTwelve
                        id17display(animalId: idAnimal, borderRed: false)
                        
                    }
                    else if get3CountryCode == "840" && (10000...003001000001).contains(Int(digitsTwelve)!)  {
                        let addObject = 12 - digitsTwelve.count
                        if addObject != 0{
                            for _ in 0...addObject - 1{
                                digitsTwelve = "0" + digitsTwelve
                            }
                        }
                        if get3CountryCode == "840"{
                            get3CountryCode = "USA"
                        }
                        idAnimal = breedBtnOutlet.titleLabel!.text! + get3CountryCode + digitsTwelve
                        id17display(animalId: idAnimal, borderRed: false)
                    }
                    else {
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnim840, comment: ""), duration: 2, position: .top)
                        id17display(animalId: idAnimal, borderRed: true)
                        return
                    }
                }
                else {
                    let addObject = 12 - digitsTwelve.count
                    if addObject != 0{
                        for _ in 0...addObject - 1{
                            digitsTwelve = "0" + digitsTwelve
                        }
                    }
                    if get3CountryCode == "000"{
                        get3CountryCode = "USA"
                    }
                    
                    idAnimal = breedBtnOutlet.titleLabel!.text! + get3CountryCode + digitsTwelve
                    id17display(animalId: idAnimal, borderRed: false)
                }
            }
            else {
                id17display(animalId: idAnimal, borderRed: true)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalRFIDId, comment: ""), duration: 2, position: .top)
            }
        }
        else {
            if drop3.count == 0 {
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCountryCode, comment: ""), duration: 2, position: .top)
                id17display(animalId: idAnimal, borderRed: true)
                return
            }
            
            
            if idAnimal.count >= 5 {
                let addObject = 12 - idAnimal.count
                if idAnimal.count <= 12 {
                    
                    if addObject != 0 {
                        for _ in 0...addObject - 1{
                            idAnimal = "0" + idAnimal
                        }
                    }
                    
                    if providerSelectionCountryCode == "USA" {
                        let obj1 = rangeCheckReturnString(animalId: String(idAnimal), countryCode: providerSelectionCountryCode)
                        if obj1 != LocalizedStrings.invalidRangeStr {
                            idAnimal = breedBtnOutlet.titleLabel!.text! + obj1 +  idAnimal
                            id17display(animalId: idAnimal, borderRed: false)
                        }
                    }
                    else {
                        idAnimal = breedBtnOutlet.titleLabel!.text! + providerSelectionCountryCode +  idAnimal
                        id17display(animalId: idAnimal, borderRed: false)
                    }
                } else {
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidRFIDId, comment: ""), duration: 2, position: .top)
                    
                    id17display(animalId: idAnimal, borderRed: true)
                }
                return
            }
            else {
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCountryCode, comment: ""), duration: 2, position: .top)
                id17display(animalId: idAnimal, borderRed: true)
                return
            }
        }
    }
    
    
    
    
    func genderBtnChange(genderFlag: String){
        if genderFlag == "M" {
            self.male_femaleBtnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 1
            genderString = NSLocalizedString("Male", comment: "")
            UserDefaults.standard.set("M", forKey: "USDairyGender")
            
        } else if genderFlag == "F" {
            self.male_femaleBtnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 0
            genderString = NSLocalizedString("Female", comment: "")
            UserDefaults.standard.set("F", forKey: "USDairyGender")
            
        }
    }
    
    func naabCodeCheck(animalId:String){
        let naabArr = naabCodesArray.value(forKey: keyValue.naabCode.rawValue) as! NSArray
        var idAnimal = animalId
        
        if naabArr.contains(idAnimal.uppercased()) {
            let fetchNaab = fetchNaabIdToAnimalId(entityName: Entities.getNaabCodeTblEntity, naabCode: idAnimal.uppercased())
            if fetchNaab.count == 0 {
                self.view.makeToast(NSLocalizedString(LocalizedStrings.naabCodeNotFound, comment: ""), duration: 2, position: .top)
                
                id17display(animalId: idAnimal, borderRed: true)
            } else {
                let naabFetch = fetchNaab.value(forKey: keyValue.animalId.rawValue) as? NSArray
                idAnimal = (naabFetch![0] as? String)!
                id17display(animalId: idAnimal, borderRed: false)
            }
        }else {
            self.view.makeToast(NSLocalizedString(LocalizedStrings.naabCodeNotFound, comment: ""), duration: 2, position: .top)
            id17display(animalId: idAnimal, borderRed: true)
        }
    }
    
    //MARK: CHECK RANGE METHODS
    func rangeCheckReturnString(animalId :String,countryCode:String)-> String{
        var  animalId = String(animalId)
        let trimmedString = animalId.replacingOccurrences(of: " ", with: "")
        animalId = trimmedString
        if countryCode == "840" ||  countryCode == "USA"  {
            if animalId.isInt  {
                if (003001000001) <= (Int(animalId)!){
                    return "840"
                }
                
                if (10000...003001000001).contains(Int(animalId)!){
                    return "USA"
                }
                else {
                    return LocalizedStrings.invalidRangeStr
                }
            }
        }
        return countryCode
    }
    
    func rangeCheckForOCRString(animalId :String,countryCode:String)-> String{
        let animalId = String(animalId)
        if animalId.isInt  {
            
            if countryCode == "840" ||  countryCode == "USA"{
                if (003001000001) <= (Int(animalId)!){
                    return "840"
                }
                if (10000...003001000001).contains(Int(animalId)!){
                    return "USA"
                    
                } else {
                    return LocalizedStrings.invalidRangeStr
                }
            }
        }
        return countryCode
    }
    
    func rangeCheck(animalId :String,countryCode:String)-> Bool{
        var animalId = String(animalId)
        let trimmedString = animalId.replacingOccurrences(of: " ", with: "")
        animalId = trimmedString
        if animalId.isInt  {
            if countryCode == "840" {
                if (003001000001) <= (Int(animalId)!){
                    return true
                    
                } else {
                    return false
                }
            }
            
            if countryCode == "USA"  {
                if (10000...003001000001).contains(Int(animalId)!){
                    return true
                    
                } else {
                    return false
                }
            } else {
                return true
                
            }
        }
        return true
    }
    
    func ukTagReutn(animalId:String)-> String{
        let idAnimal = animalId.uppercased()
        let stringResult = idAnimal.contains("UK")
        if stringResult  {
            let trimmedString = String(idAnimal.compactMap({ $0.isWhitespace ? nil : $0 }))
            let test = String(trimmedString.filter{!LocalizedStrings.trimmedCharFromString.contains($0)})
            
            let dropTwelveElement = test.suffix(12).uppercased()
            borderRedCheck = false
            let totalString = dropTwelveElement
            return totalString
            
        } else {
            let stringResultUS = idAnimal.contains("US")
            let stringResult840 = idAnimal.contains("840")
            
            if stringResultUS  && stringResult840  {
                
                let trimmedString = String(idAnimal.compactMap({ $0.isWhitespace ? nil : $0 }))
                let test = String(trimmedString.filter{!"\n\t\r.][:".contains($0)})
                if test.count < 15 {
                    return LocalizedStrings.againClick
                } else {
                    guard let range: Range<String.Index> = test.range(of: "840") else {
                        return LocalizedStrings.againClick
                        
                    }
                    let index: Int = test.distance(from: test.startIndex, to: range.lowerBound)
                    let countt = index + 14
                    if test.count < countt {
                        return LocalizedStrings.againClick
                    }
                    else {
                        let indexGet = test.subString(from: index, to: index + 14)
                        return indexGet
                    }
                }
            } else {
                return LocalizedStrings.againClick
            }
        }
    }
    
    func usTagReutn(animalId:String)-> String {
        let idAnimal = animalId.uppercased()
        let trimmedString = String(idAnimal.compactMap({ $0.isWhitespace ? nil : $0 }))
        let test = String(trimmedString.filter{!LocalizedStrings.trimmedCharFromString.contains($0)})
        if test.count > 15 {
            guard let range: Range<String.Index> = test.range(of: "840") else {
                return LocalizedStrings.againClick
                
            }
            let index: Int = test.distance(from: test.startIndex, to: range.lowerBound)
            
            let countt = index + 14
            if test.count < countt {
                
                return LocalizedStrings.againClick
            }
            else {
                let indexGet = test.subString(from: index, to: index + 14)
                return indexGet
            }
        }
        return LocalizedStrings.againClick
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
                    if self.scanAnimalTagText.tag == 0 {
                        
                        let trimmed = String(textStr.compactMap({ $0.isWhitespace ? nil : $0 }))
                        let test = String(trimmed.filter{!LocalizedStrings.trimmedCharFromString.contains($0)})
                        self.methReturn = self.ukTagReutn(animalId: test.uppercased())
                        if self.methReturn == LocalizedStrings.againClick {
                            
                            self.scanAnimalTagText.text = ""
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
                                print(LocalizedStrings.cancelPressed)
                            })
                            let thirdAction = UIAlertAction(title: NSLocalizedString(LocalizedStrings.useScannedValue, comment: ""), style: UIAlertAction.Style.default, handler: {
                                (_)in
                                
                                self.scanAnimalTagText.text = test
                                self.imageView.isHidden = true
                                self.textFieldBackroungWhite()
                                self.scanAnimalTagText.becomeFirstResponder()
                            })
                            
                            alert.addAction(OKAction)
                            alert.addAction(cancelAction)
                            alert.addAction(thirdAction)
                            self.present(alert, animated: true, completion: nil)
                            return
                        }
                        
                        self.scanAnimalTagText.text = self.methReturn
                        self.imageView.isHidden = true
                        self.textFieldBackroungWhite()
                        self.scanAnimalTagText.becomeFirstResponder()
                    }
                    else {
                        let trimmed = String(textStr.compactMap({ $0.isWhitespace ? nil : $0 }))
                        let test = String(trimmed.filter{!LocalizedStrings.trimmedCharFromString.contains($0)})
                        self.methReturn =  self.ukTagReutn(animalId: test.uppercased())
                        if self.methReturn == LocalizedStrings.againClick {
                            
                            self.farmIdTextField.text = ""
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
                                print(LocalizedStrings.cancelPressed)
                            })
                            let thirdAction = UIAlertAction(title: NSLocalizedString(NSLocalizedString(LocalizedStrings.useScannedValue, comment: ""), comment: ""), style: UIAlertAction.Style.default, handler: {
                                (_)in
                                
                                self.farmIdTextField.text = test
                                self.imageView.isHidden = true
                                self.textFieldBackroungWhite()
                                self.farmIdTextField.becomeFirstResponder()
                            })
                            
                            alert.addAction(OKAction)
                            alert.addAction(cancelAction)
                            alert.addAction(thirdAction)
                            self.present(alert, animated: true, completion: nil)
                            return
                        }
                        
                        self.farmIdTextField.text = self.methReturn
                        self.imageView.isHidden = true
                        self.farmIdTextField.becomeFirstResponder()
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
}


