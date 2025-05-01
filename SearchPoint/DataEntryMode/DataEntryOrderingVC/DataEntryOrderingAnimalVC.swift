//
//  OrderingAnimalVC.swift
//  SearchPoint
////  Created by "" on 04/10/2019.
//aaaa
//  Created by "" on 04/10/2019.
//  ""

import UIKit
import DropDown
import CoreBluetooth
import Toast_Swift
import Vision
import VisionKit

// MARK: - CLASS
class DataEntryOrderingAnimalVC: UIViewController,UIScrollViewDelegate ,VNDocumentCameraViewControllerDelegate {
    
    // MARK: - OUTLETS
    @IBOutlet weak var bckkkBtnOutlet: customButton!
    @IBOutlet weak var calenderDobView: UIView!
    @IBOutlet weak var incrementalBarcodeCheckBox: UIImageView!
    @IBOutlet weak var incrementalBarcodeTitleLabel: UILabel!
    @IBOutlet weak var incrementalBarcodeButton: UIButton!
    @IBOutlet weak var dropDownExpand: UIImageView!
    @IBOutlet weak var addAnimalTtitle: UILabel!
    @IBOutlet weak var resetIconImage: UIImageView!
    @IBOutlet weak var dataEntryMenuBtnOutlet: UIButton!
    @IBOutlet weak var dataEntryAddAnimal: UIButton!
    @IBOutlet weak var dataEntryReviewData: UIButton!
    @IBOutlet weak var matchedBarcodeLbl: UILabel!
    @IBOutlet weak var matchedBarcodeCheckBox: UIImageView!
    @IBOutlet weak var matchedBarcodeBtnOutlet: UIButton!
    @IBOutlet weak var matchedBarcdeContainer: UIView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var keyBoardOptionsView: UIView!
    @IBOutlet weak var keyBoardOptionsViewBottomConstrains: NSLayoutConstraint!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var closeImage1: UIImageView!
    @IBOutlet weak var closeImage2: UIImageView!
    @IBOutlet weak var appStatusTtitleText: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var internalBtnOulet: UIButton!
    @IBOutlet weak var notificationLblCount: UILabel!
    @IBOutlet weak var farmIdOutlet: customButton!
    @IBOutlet weak var networkStatusImg: UIImageView!
    @IBOutlet weak var offLineBtn: UIButton!
    @IBOutlet weak var permanentIDTextField: UITextField!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var pairedBackroundView: UIView!
    @IBOutlet weak var farmIdTextField: CustomTextField!
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
    @IBOutlet weak var bornTypeCollection: UICollectionView!
    @IBOutlet weak var auPOPupTitle: UILabel!
    @IBOutlet weak var dateOfBirthLbl: UILabel!
    @IBOutlet weak var colletionViewHeightConstaint: NSLayoutConstraint!
    @IBOutlet weak var nationalHerdBottom: NSLayoutConstraint!
    @IBOutlet weak var sireIdAuHeightConstrainr: NSLayoutConstraint!
    @IBOutlet weak var nationalHerdAuHeightConstrainr: NSLayoutConstraint!
    @IBOutlet weak var sireIdAuUperConstraint: NSLayoutConstraint!
    @IBOutlet weak var nationalHerdAuUperConstraint: NSLayoutConstraint!
    @IBOutlet weak var damIdTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var damIdHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sireIdHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sireIdTopConstaint: NSLayoutConstraint!
    @IBOutlet weak var expandFormOutlet: UIButton!
    @IBOutlet weak var breedHeightContaint: NSLayoutConstraint!
    @IBOutlet weak var calenderHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var maleFemaleHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tissueHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tissueDropDownArrow: UIImageView!
    @IBOutlet weak var breedDropDownArrow: UIImageView!
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
    
    // MARK: - VARIABLES
    var isBarcodeAutoIncrementedEnabled = false
    var arrNearbyDevice : [CBPeripheral] = [] {
        didSet{
            pairedTableView?.reloadData()
        }
    }
    let langCode : String = UserDefaults.standard.object(forKey: keyValue.lngCode.rawValue) as! String
    var validateDateFlag = true
    var farmIDBoolEntryTag = false
    let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
    var adhAnimalData = [AnimalMaster]()
    var filterAdhAnimalData = [AnimalMaster]()
    var incrementalBarCode = ""
    var fetchNaabBullArray = NSArray ()
    var autocompleteUrls1 = NSMutableArray ()
    var autocompleteUrls2 = NSMutableArray ()
    var sireNatonIdArray  = NSMutableArray ()
    var autoSuggestionStatus : Bool?
    var attrs : [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.blue,.underlineStyle: NSUnderlineStyle.single.rawValue]
    var barcodeEnable = Bool()
    var scanAnimalText = String()
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
    let locale = NSLocale.current
    var datePicker : UIDatePicker!
    var selectedDate = Date()
    let toolBar = UIToolbar()
    var genderString = String()
    var counter = 0
    var lblTimeStamp = String()
    let dropDown = DropDown()
    let date = Date()
    var timeStampString = String()
    var sampleArr = NSMutableArray()
    var borderRedCheck = true
    var message = String()
    var selctionAuProvider = UserDefaults.standard.value(forKey: keyValue.clickAuProvider.rawValue) as? Bool
    var addContiuneBtn = Int()
    var textFieldAnimal = String()
    var dataEntryConflicedBack = Bool()
    var farmiDValueStore = String()
    var barAutoPopu = false
    var AusNabb = NSArray()
    var ausBullId = NSArray()
    var sireNationalID = NSArray()
    let tapRec = UITapGestureRecognizer()
    var adhDataServerAutoPopulate  = Bool()
    var request = VNRecognizeTextRequest(completionHandler: nil)
    var methReturn = String()
    var userId = Int()
    var orderId = Int()
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    var custmerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
    var checkBarcode = Bool()
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
    var dataAutoPopulatedBool = false
    var farmIDBoolEntry = false
    var farmIDBoolEntrySecond = false
    var listIdGet = Int()
    var listName = String()
    var sampleID = Int()
    var sampleName = String()
    var getBornTypes = [GetBornTypes]()
    var isGrayField = true
    var selectedBornTypeId = -1
    var etBtn = String()
    var autoPopulapte = Bool()
    var animalIdBool = Bool()
    let buttonbg2 = UIButton ()
    let buttonbgAutoSuggestion = UIButton ()
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
    var XDFound = Bool()
    var addedd = Bool()
    var isComingFromDataList = false
    var loadedAnimalData : DataEntryAnimaladdTbl?
    var textRecognitionRequest = VNRecognizeTextRequest(completionHandler: nil)
    private let textRecognitionWorkQueue = DispatchQueue(label: "MyVisionScannerQueue", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
    var qrData: QRData? = nil {
        didSet {
            if qrData != nil {
                scanBarcodeText.text = qrData?.codeString
            }else {
                
            }
        } willSet {
        }
    }
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    var newString  = false
    var damiidTextValueStore = String()
    var borderRedChange = Bool()
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIOnDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUIOnWillAppear()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setUIOnDidAppear()
    }
    
    override func viewDidDisappear(_ animakted: Bool) {
        self.defaultIncrementalBarCodeSetting()
        scrolView.flashScrollIndicators()
        removeObserver()
        
    }
    
    override func viewDidLayoutSubviews() {
        if counter == 0 || counter == 1{
            counter = counter + 1
        }
    }
    
    // MARK: - METHODS AND FUNCTIONS
    
    func ShowAlertforSampletype(){
        let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAddedBVDV, comment: ""), preferredStyle: .alert)
        
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
    
    func addBtnCondtion(completionHandler: CompletionHandler){
        if checkBarcode == true {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.barcodeMustEndWithNumAlert, comment: ""))
            return
        }
        
        if tissueBtnOutlet.titleLabel?.text == nil || tissueBtnOutlet.titleLabel?.text == "" {
            tissueBtnOutlet.layer.borderColor = UIColor.red.cgColor
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
            return
        }
        
        var dateVale = ""
        let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            dateVale = dateTextField.text ?? ""
            
        } else {
            dateVale = dateBtnOutlet.titleLabel?.text ?? ""
            
        }
        let codeId = fetchBreedDataTissueCode(entityName: Entities.getSampleTblEntity,provId: self.pvid,tissueName:(sampleName))
        let naabFetch1 = codeId.value(forKey: keyValue.sampleId.rawValue) as? NSArray
        if naabFetch1!.count == 0 {
            
        } else {
            let breedIdGet = naabFetch1![0] as? Int
            self.tissuId = breedIdGet!
        }
        
        let codeId1 = fetchBreedDatabreedCode( entityName: Entities.getBreedsTblEntity,provId: self.pvid,breedCode:(self.breedBtnOutlet.titleLabel?.text)!)
        let naabFetch11 = codeId1.value(forKey: keyValue.breedId.rawValue) as? NSArray
        if naabFetch11!.count == 0 {
            
        } else {
            let breedIdGet = (naabFetch11![0] as? String)!
            self.breedId = breedIdGet
            UserDefaults.standard.set(self.breedId, forKey: keyValue.dataEntrybreedId.rawValue)
            
        }
        
        if dateTextField.text?.count == 0 {
            
            
        }
        else {
            if dateTextField.text?.count == 10 {
                let validate = isValidDate(dateString: dateTextField.text ?? "")
                if validate == LocalizedStrings.correctFormatStr {
                    dateBtnOutlet.layer.borderColor = UIColor.gray.cgColor
                    dateBtnOutlet.layer.borderWidth = 0.5
                    validateDateFlag = true
                } else {
                    dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
                    validateDateFlag = false
                    
                    if validate == LocalizedStrings.greaterThenDateStr {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.dobSmallerthanCurrDate, comment: ""))
                        return
                    } else {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
                        return
                    }
                    return
                }
            }
            else {
                dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
                validateDateFlag = false
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
                return
            }
        }
        
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            dateVale = dateTextField.text ?? ""
            if dateVale != "" {
                if dateStr == "DD"{
                    dateVale = dateTextField.text ?? ""
                }
                else {
                    let values = dateVale.components(separatedBy: "/")
                    let date = values[0]
                    let month = values[1]
                    let year = values[2]
                    dateVale = month + "/" + date + "/" + year
                    
                }}
        }
        else {
            if dateVale != "" {
                if dateStr == "DD"{
                    dateVale = dateBtnOutlet.titleLabel?.text ?? ""
                }
                else {
                    let values = dateVale.components(separatedBy: "/")
                    let date = values[0]
                    let month = values[1]
                    let year = values[2]
                    dateVale = month + "/" + date + "/" + year
                }}
            
        }
        
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        
        if scanAnimalTagText.tag == 0 {
            scanAnimalText = scanAnimalTagText.text!
            farmIdText = farmIdTextField.text!
        }
        else {
            scanAnimalText = farmIdTextField.text!
            farmIdText = scanAnimalTagText.text!
        }
        
        if scanBarcodeText.text != ""{
            if barcodeflag == true {
                let barCode = fetchAnimaldataValidateAnimalBarcodeanimalIdOrderId(entityName: Entities.dataEntryAnimalAddTbl, animalbarCodeTag: scanBarcodeText.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"false",orderid:orderId,custId:custmerId!)
                if barCode.count > 0 {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sampleAlreadyExists, comment: ""))
                    barcodeView.layer.borderColor = UIColor.red.cgColor
                    return
                }
            }
        }
        
        let animalData = fetchAnimaldataValidateListAndCustomerId(entityName: Entities.dataEntryAnimalAddTbl, animalTag: scanAnimalText, farmId: farmIdText, userId: userId, listId: listIdGet, customerId: custmerId!) as! [DataEntryAnimaladdTbl]
        if scanBarcodeText.text != ""{
            let animaBarcOde = fetchAnimaldataValidateAnimalBarcodeanimalId(entityName: Entities.dataEntryAnimalAddTbl, animalbarCodeTag: scanBarcodeText.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"true",custId:custmerId!,IsDataEmail: false)
            if animaBarcOde.count > 0 {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sampleAlreadyExists, comment: ""))
                barcodeView.layer.borderColor = UIColor.red.cgColor
                return
            }
            incrementalBarCode = scanBarcodeText.text ?? ""
        }
        
        if animalData.count > 0 || isComingFromDataList  {
            let dataBVDV =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:autoD, customerID: custmerId ?? 0)
//            if dataBVDV.count>0 {
//                ShowAlertforSampletype()
//            } else{
                isUpdate = true
                if animalId1 == 0{
                  animalId1 = Int(animalData[0].animalId)
                }
                updateOrderStatusISyncAnimalMasterDataEntry(entity: Entities.animalMasterTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false)
          
          updateOrderStatusISyncAnimalMasterDataEntry(entity: Entities.animalAddTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false)
                
                updateOrderStatusISyncAnimalMasterDataEntry(entity: Entities.dataEntryAnimalAddTbl, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!, sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "true", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false)
                
                updateOrderStatusISyncProduct(entity: Entities.productAdonAnimalTblEntity,animalTag: scanAnimalText,barCodetag:  scanBarcodeText.text!,farmId: farmIdText,orderId: orderId,userId:userId,animalId:animalId1)
                updateOrderStatusISyncSubProduct(entity: Entities.subProductTblEntity,animalTag: scanAnimalText,barCodetag:  scanBarcodeText.text!,farmId: farmIdText,orderId: orderId,userId:userId,animalId: animalId1)
                
                updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId ?? 0,offlineSync:false,listid: listIdGet)
                
                let fetchDataUpdate = fetchAnimalDataAccOfficalFarmid(entityName: Entities.dataEntryAnimalAddTbl,farmId:farmIdText,anmalTag:scanAnimalText,custmerId :custmerId ?? 0)
                let fetchDataUpdate1 = fetchAnimalDataAccOfficalFarmid(entityName: Entities.animalAddTblEntity,farmId:farmIdText,anmalTag:scanAnimalText,custmerId :custmerId ?? 0)
                
                if fetchDataUpdate.count != 0 {
                    updateDataInMasterAnimalTbl(entity: Entities.dataEntryAnimalAddTbl, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, custmerId: custmerId ?? 0, editFlagSave: true)
                    
                    updateDataInMasterAnimalTbl(entity: Entities.animalMasterTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, custmerId: custmerId ?? 0, editFlagSave: true)
                  
                  updateDataInMasterAnimalTbl(entity: Entities.animalAddTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, custmerId: custmerId ?? 0, editFlagSave: true)
                    
                }
                
                if fetchDataUpdate1.count != 0 {
                    updateDataInMasterAnimalTbl(entity: Entities.dataEntryAnimalAddTbl, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, custmerId: custmerId ?? 0, editFlagSave: true)
                    
                    updateDataInMasterAnimalTbl(entity: Entities.animalAddTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, custmerId: custmerId ?? 0, editFlagSave: true)
                    
                    updateDataInMasterAnimalTbl(entity: Entities.animalMasterTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, custmerId: custmerId ?? 0, editFlagSave: true)
                    
                    
                }
                let adata = fetchAllDataOrderStatusMaster(entityName: Entities.animalMasterTblEntity, ordestatus: "true", userId: userId,farmId: farmIdText,animalTag:scanAnimalText,barcodeTag:scanBarcodeText.text!)
                let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryAnimalAddTbl, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                
                if adata.count > 0{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                    byDefaultSetting()
                }
                
                else if animalDataMaster.count > 0 {
                    if  msgUpatedd == true{
                        UserDefaults.standard.set(sampleName, forKey: keyValue.dataEntryTsuClear.rawValue)
                        UserDefaults.standard.set(breedBtnOutlet.titleLabel?.text, forKey: keyValue.dataEntrybreedNameClear.rawValue)
                        UserDefaults.standard.set(sampleName, forKey: keyValue.dataEntryTsu.rawValue)
                        UserDefaults.standard.set(breedBtnOutlet.titleLabel?.text, forKey: keyValue.dataEntrybreedName.rawValue)
                        
                        let dialogMessage = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalRecordUpdated, comment: ""), preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .default, handler: { [self] (action) -> Void in
                            if self.dataEntryConflicedBack == true {
                                
                                let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.DataEntryViewConflicedImportListVC) as! DataEntryViewConflicedImportList
                                vc.listId = self.listIdGet
                                self.navigationController?.pushViewController(vc,animated: false)
                                
                            }else {
                                self.byDefaultSetting()
                            }
                        })
                        
                        dialogMessage.addAction(ok)
                        self.present(dialogMessage, animated: true, completion: nil)
                    }
                    else{
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAddedList, comment: ""))
                        byDefaultSetting()
                    }
                }
                
                editAid = animalId1
                animalId1 = 0
                if identify1 == true {
                    let data1 = fetchAllDataOrderStatusDataEntry(entityName: Entities.dataEntryAnimalAddTbl,ordestatus: "false",orderId:orderId,userId:userId,listId:listIdGet)
                    if data1.count > 0 {
                        completionHandler(true)
                        return
                    }
                }
                completionHandler(true)
                scrolView.contentOffset.y = 0.0
           // }
        } else if isUpdate == true {
            
            animalId1 = editAid
            updateOrderStatusISyncAnimalMasterDataEntry(entity: Entities.animalMasterTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text?.uppercased() ?? "", sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false)
          
          updateOrderStatusISyncAnimalMasterDataEntry(entity: Entities.animalAddTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text?.uppercased() ?? "", sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false)
            
            updateOrderStatusISyncAnimalMasterDataEntry(entity: Entities.dataEntryAnimalAddTbl, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text?.uppercased() ?? "", sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "true", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false)
            
            updateOrderStatusISyncProduct(entity: Entities.productAdonAnimalTblEntity,animalTag: scanAnimalText,barCodetag:  scanBarcodeText.text!,farmId: farmIdText,orderId: orderId,userId:userId,animalId:animalId1)
            updateOrderStatusISyncSubProduct(entity: Entities.subProductTblEntity,animalTag: scanAnimalText,barCodetag:  scanBarcodeText.text!,farmId: farmIdText,orderId: orderId,userId:userId,animalId: animalId1)
            updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId ?? 0,offlineSync:false,listid: listIdGet)
            
            let fetchDataUpdate = fetchAnimalDataAccOfficalFarmid(entityName: Entities.dataEntryAnimalAddTbl,farmId:farmIdText,anmalTag:scanAnimalText,custmerId :custmerId ?? 0)
            let fetchDataUpdate1 = fetchAnimalDataAccOfficalFarmid(entityName: Entities.animalAddTblEntity,farmId:farmIdText,anmalTag:scanAnimalText,custmerId :custmerId ?? 0)
            
            if fetchDataUpdate.count != 0 {
                
                updateDataInMasterAnimalTbl(entity: Entities.dataEntryAnimalAddTbl, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, custmerId: custmerId ?? 0, editFlagSave: true)
                
                updateDataInMasterAnimalTbl(entity: Entities.animalMasterTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, custmerId: custmerId ?? 0, editFlagSave: true)
              
              updateDataInMasterAnimalTbl(entity: Entities.animalAddTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, custmerId: custmerId ?? 0, editFlagSave: true)
                
            }
            
            if fetchDataUpdate1.count != 0 {
                
                updateDataInMasterAnimalTbl(entity: Entities.dataEntryAnimalAddTbl, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, custmerId: custmerId ?? 0, editFlagSave: true)
                
                updateDataInMasterAnimalTbl(entity: Entities.animalAddTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, custmerId: custmerId ?? 0, editFlagSave: true)
                
                updateDataInMasterAnimalTbl(entity: Entities.animalMasterTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, custmerId: custmerId ?? 0, editFlagSave: true)
                
            }
            
            if identify1 == true {
                let data1 = fetchAllDataOrderStatusDataEntry(entityName: Entities.dataEntryAnimalAddTbl,ordestatus: "false",orderId:orderId,userId:userId,listId:listIdGet)
                if data1.count > 0 {
                    completionHandler(true)
                    return
                }
            }
            isautoPopulated = false
            let adata = fetchAllDataOrderStatusMaster(entityName: Entities.animalMasterTblEntity, ordestatus: "true", userId: userId,farmId: farmIdText,animalTag:scanAnimalText,barcodeTag:scanBarcodeText.text!)
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryAnimalAddTbl, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            
            if adata.count > 0{
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAddedList, comment: ""))
                byDefaultSetting()
            }
            
            else if animalDataMaster.count > 0 {
                if  msgUpatedd == true {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalRecordUpdated, comment: ""))
                    UserDefaults.standard.set(sampleName, forKey: keyValue.dataEntryTsuClear.rawValue)
                    UserDefaults.standard.set(breedBtnOutlet.titleLabel?.text, forKey: keyValue.dataEntrybreedNameClear.rawValue)
                    UserDefaults.standard.set(sampleName, forKey: keyValue.dataEntryTsu.rawValue)
                    UserDefaults.standard.set(breedBtnOutlet.titleLabel?.text, forKey: keyValue.dataEntrybreedName.rawValue)
                    byDefaultSetting()
                }
                else{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAddedList, comment: ""))
                    byDefaultSetting()
                    
                }
            }
            completionHandler(true)
            scrolView.contentOffset.y = 0.0
            
        } else {
            isUpdate = false
            
            if pvid == 2 {
                if breedId  == "" {
                    let inheritBreed = fetchAllDataProductBeefIdDairy(entityName: Entities.getBreedsTblEntity, breedName: (breedBtnOutlet.titleLabel?.text)!, pvid: 2)
                    if inheritBreed.count != 0 {
                        let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                        breedId = medbreedRegArr1!.breedId ?? ""
                        UserDefaults.standard.set(breedId, forKey: keyValue.dataEntrybreedId.rawValue)
                        
                    }
                }else {
                    UserDefaults.standard.set(breedId, forKey: keyValue.dataEntrybreedId.rawValue)
                }
            }
            
            if pvid == 1 {
                if breedId  == "" {
                    let inheritBreed = fetchAllDataProductBeefIdDairy(entityName: Entities.getBreedsTblEntity, breedName: (breedBtnOutlet.titleLabel?.text)!, pvid: 1)
                    if inheritBreed.count != 0 {
                        let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                        breedId = medbreedRegArr1!.breedId ?? ""
                        UserDefaults.standard.set(breedId, forKey: keyValue.dataEntrybreedId.rawValue)
                    }
                }
                else {
                    UserDefaults.standard.set(breedId, forKey: keyValue.dataEntrybreedId.rawValue)
                }
            }
            else if pvid == 3 {
                if breedId  == "" {
                    let inheritBreed = fetchAllDataProductBeefIdDairy(entityName: Entities.getBreedsTblEntity, breedName: (breedBtnOutlet.titleLabel?.text)!, pvid: 3)
                    if inheritBreed.count != 0 {
                        let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                        breedId = medbreedRegArr1!.breedId ?? ""
                        UserDefaults.standard.set(breedId, forKey: keyValue.dataEntrybreedId.rawValue)
                    }
                }
                else {
                    UserDefaults.standard.set(breedId, forKey: keyValue.dataEntrybreedId.rawValue)
                }
            }
            
            let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
            var animalID1 = UserDefaults.standard.integer(forKey: keyValue.animalId.rawValue)
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalMasterTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            if animalDataMaster.count > 0{
                
                if animalID1 == 0 {
                    animalID1 = animalID1 + 1
                    UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                }
                else {
                    animalID1 = animalID1 + 1
                    UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                    
                }
                updateOrderStatusISyncAnimalMasterAnimalId(entity: Entities.animalMasterTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text?.uppercased() ?? "", sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, tertiaryGeno: "")
              
              updateOrderStatusISyncAnimalMasterAnimalId(entity: Entities.animalMasterTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text?.uppercased() ?? "", sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, tertiaryGeno: "")
                
                let fetchDataUpdate = fetchAnimalDataAccOfficalFarmid(entityName: Entities.dataEntryAnimalAddTbl,farmId:farmIdText,anmalTag:scanAnimalText,custmerId :custmerId ?? 0)
                let fetchDataUpdate1 = fetchAnimalDataAccOfficalFarmid(entityName: Entities.animalAddTblEntity,farmId:farmIdText,anmalTag:scanAnimalText,custmerId :custmerId ?? 0)
                if fetchDataUpdate.count != 0 {
                    
                    updateDataInMasterAnimalTbl(entity: Entities.dataEntryAnimalAddTbl, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalID1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, custmerId: custmerId ?? 0, editFlagSave: true)
                    
                    updateDataInMasterAnimalTbl(entity: Entities.animalMasterTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalID1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, custmerId: custmerId ?? 0, editFlagSave: true)
                  
                  updateDataInMasterAnimalTbl(entity: Entities.animalAddTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalID1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, custmerId: custmerId ?? 0, editFlagSave: true)
                    
                }
                
                if fetchDataUpdate1.count != 0 {
                    updateDataInMasterAnimalTbl(entity: Entities.dataEntryAnimalAddTbl, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalID1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, custmerId: custmerId ?? 0, editFlagSave: true)
                    
                    updateDataInMasterAnimalTbl(entity: Entities.animalAddTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalID1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, custmerId: custmerId ?? 0, editFlagSave: true)
                    
                    updateDataInMasterAnimalTbl(entity: Entities.animalMasterTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalID1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, custmerId: custmerId ?? 0, editFlagSave: true)
                    
                }
                
            }
            else{
                
                if animalID1 == 0 {
                    animalID1 = animalID1 + 1
                    UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                    
                }
                else {
                    animalID1 = animalID1 + 1
                    UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                }
                
                let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalMasterTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"true" )
                
                if animalDataMaster.count > 0{
                    updateOrderStatusISyncAnimalMasterAnimalId(entity: Entities.animalMasterTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text?.uppercased() ?? "", sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, tertiaryGeno: "")
                    updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId ?? 0,offlineSync:false,listid: listIdGet)
                }
                else {
                    
                    saveAnimaldata(entity: Entities.animalMasterTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text?.uppercased() ?? "", sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString, animalId: animalID1, selectedBornTypeId: selectedBornTypeId,custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), specisId: SpeciesID.dairySpeciesId, earTag: "",isSyncServer:false, adhDataServer: false, listId: Int64(listIdGet), editFlagSave: false, serverAnimalId: "")
                    
                    updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId ?? 0,offlineSync:false,listid: listIdGet)
                }
            }
            
            
            let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:autoD, customerID: custmerId ?? 0)
            if data12333.count > 0{
//                if tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || tissueBtnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText {//|| tissuId == 1 || tissuId == 18 {
                    saveAnimaldata(entity: Entities.dataEntryAnimalAddTbl, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text?.uppercased() ?? "", sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString, animalId: animalID1, selectedBornTypeId: selectedBornTypeId, custId: custmerId!, specisId: SpeciesID.dairySpeciesId, earTag: "",isSyncServer:false, adhDataServer: false, listId: Int64(listIdGet), editFlagSave: false, serverAnimalId: "")
                    updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId ?? 0,offlineSync:false,listid: listIdGet)
                    
           //     }
//                else {
//
//                    let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
//
//                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
//                        UIAlertAction in
//                        self.byDefaultSetting()
//
//                    }
//                    let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
//                        UIAlertAction in
//                        deleteDataWithProduct(animalID1)
//                        deleteDataWithSubProduct(animalID1)
//                        deleteDataWithAnimal(animalID1)
//                        let animalCount =  fetchAllDataAnimalDaWithOutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderStatus:"false",listid: Int64(self.listIdGet ), custmerId: Int64(self.custmerId ?? 0), providerId: pvid)
//                        self.notificationLblCount.text = String(animalCount.count)
//                        UserDefaults.standard.set("", forKey: keyValue.dataEntryTsu.rawValue)//string(forKey: keyValue.dataEntryTsu.rawValue)
//                        self.byDefaultSetting()
//                        return
//                    }
//                    alertController.addAction(okAction)
//                    alertController.addAction(cancelAction)
//                    self.present(alertController, animated: true, completion: nil)
//                    return
//                }
            }
            else {
                saveAnimaldata(entity: Entities.dataEntryAnimalAddTbl, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text?.uppercased() ?? "", sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: tissueBtnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString, animalId: animalID1, selectedBornTypeId: selectedBornTypeId,custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), specisId: SpeciesID.dairySpeciesId, earTag: "",isSyncServer:false, adhDataServer: false, listId: Int64(listIdGet), editFlagSave: false, serverAnimalId: "")
                
                updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId ?? 0,offlineSync:false,listid: listIdGet)
                
            }
            
            message = NSLocalizedString(LocalizedStrings.animalAdded, comment: "")
            statusOrder = false
            UserDefaults.standard.removeObject(forKey: keyValue.review.rawValue)
            self.animalSucInOrder = ""
            if self.msgAnimalSucess == false {
                if self.addContiuneBtn == 1 {
                    if self.msgcheckk == true {
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.animalRecordUpdatedInList, comment: ""), duration: 2, position: .top)
                    }
                    else {
                        
                        if self.isautoPopulated == true {
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAddedSuccessfullyList, comment: ""), duration: 2, position: .top)
                        } else {
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAdded, comment: ""), duration: 2, position: .top)
                        }
                    }
                } else if self.addContiuneBtn == 2{
                    if self.msgcheckk == true {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalRecordUpdatedInList, comment: ""))
                    }
                    else{
                        if self.isautoPopulated == true {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAddedSuccessfullyList, comment: ""))
                        } else {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAdded, comment: ""))
                        }
                    }
                }else {
                    if self.msgcheckk == true {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalRecordUpdatedInList, comment: ""))
                    }
                    else{
                        if self.isautoPopulated == true {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAddedSuccessfullyList, comment: ""))
                        } else {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAdded, comment: ""))
                        }
                    }
                }
                self.msgAnimalSucess = false
            } else {
                if self.msgcheckk == true {
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.animalRecordUpdatedInList, comment: ""), duration: 2, position: .top)
                }
                else{
                    if self.isautoPopulated == true {
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAddedSuccessfullyList, comment: ""), duration: 2, position: .top)
                    }
                    else {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAdded, comment: ""))
                    }
                }
            }
            UserDefaults.standard.set(sampleName, forKey: keyValue.dataEntryTsuClear.rawValue)
            UserDefaults.standard.set(breedBtnOutlet.titleLabel?.text, forKey: keyValue.dataEntrybreedNameClear.rawValue)
            UserDefaults.standard.set(sampleName, forKey: keyValue.dataEntryTsu.rawValue)
            UserDefaults.standard.set(breedBtnOutlet.titleLabel?.text, forKey: keyValue.dataEntrybreedName.rawValue)
            
            if isBarcodeAutoIncrementedEnabled == true {
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
                
            } else {
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                
            }
            UserDefaults.standard.set("", forKey: keyValue.selectAnimalId.rawValue)
            barAutoPopu = false
            self.male_femaleBtnOutlet.setImage(UIImage(named: "LangFemale\(langCode)"), for: .normal)
            genderToggleFlag = 0
            genderString = ButtonTitles.femaleText.localized
            etBtn.removeAll()
            etBttn.layer.borderWidth = 0.5
            singleBttn.layer.borderWidth = 0.5
            multipleBirthBttn.layer.borderWidth = 0.5
            scanAnimalTagText.text = ""
            scanBarcodeText.text = ""
            farmIdTextField.text = ""
            
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            
            let animalCount =  fetchAllDataAnimalDaWithOutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderStatus:"false",listid: Int64(self.listIdGet ), custmerId: Int64(custmerId ?? 0), providerId: pvid)
            notificationLblCount.text = String(animalCount.count)
            
            let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
            let formatter = DateFormatter()
            
            if dateStr == "MM" {
                formatter.dateFormat = DateFormatters.MMddyyyyFormat
            } else {
                formatter.dateFormat = DateFormatters.ddMMyyyyFormat
            }
            dateBtnOutlet.setTitle("", for: .normal)
            dateBtnOutlet.setTitle(nil, for: .normal)
            dateTextField.text = ""
            dateVale = ""
           byDefaultSetting()
           textFieldBackroungGrey()
            completionHandler(true)
        }
        
        //BARCODE INCREMENTAL
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
            UserDefaults.standard.set(incrementalBarCode, forKey: keyValue.barcodeIncremental.rawValue)
        }
        incrementalBarCode = ""
    }
    
    func byDefaultSetting(){
        
        let dateformt = DateFormatter()
        let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        if dateStr == "MM" {
            dateformt.dateFormat = DateFormatters.MMddyyyyFormat
        } else {
            dateformt.dateFormat = DateFormatters.ddMMyyyyFormat
        }
        animalId1 = 0
        idAnimal = 0
        isUpdate = false
        msgUpatedd = false
        barAutoPopu = false
        self.msgcheckk = false
        self.isautoPopulated = false
        dataAutoPopulatedBool =  false
        farmIDBoolEntryTag = false
        farmIDBoolEntry = false
        farmIDBoolEntrySecond = false
        dateBtnOutlet.setTitleColor(UIColor.gray, for: .normal)
        breedBtnOutlet.setTitleColor(UIColor.gray, for: .normal)
        dateOfBirthLbl.textColor = UIColor.gray
        etBttn.layer.borderWidth = 0.5
        singleBttn.layer.borderWidth = 0.5
        multipleBirthBttn.layer.borderWidth = 0.5
        cloneOutlet.layer.borderWidth = 0.5
        SplitEmbryoOutlet.layer.borderWidth = 0.5
        internalBtnOulet.layer.borderWidth = 0.5
        nationalHerdIdTextField.layer.borderWidth = 0.5
        sireIAuTextField.layer.borderWidth = 0.5
        officalTagView.layer.borderColor = UIColor.gray.cgColor
        cloneOutlet.layer.borderColor = UIColor.gray.cgColor
        SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
        etBttn.layer.borderColor = UIColor.gray.cgColor
        singleBttn.layer.borderColor = UIColor.gray.cgColor
        multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
        farmIdView.layer.borderColor = UIColor.gray.cgColor
        barcodeView.layer.borderColor = UIColor.gray.cgColor
        permanentIDTextField.layer.borderColor = UIColor.gray.cgColor
        sireIdTextField.layer.borderColor = UIColor.gray.cgColor
        damtexfield.layer.borderColor = UIColor.gray.cgColor
        internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
        nationalHerdIdTextField.layer.borderColor = UIColor.gray.cgColor
        sireIAuTextField.layer.borderColor = UIColor.gray.cgColor
        dateBtnOutlet.layer.borderColor = UIColor.gray.cgColor
        nationalHerdIdTextField.text?.removeAll()
        sireIAuTextField.text?.removeAll()
        scanBarcodeText.text?.removeAll()
        scanAnimalTagText.text?.removeAll()
        farmIdTextField.text?.removeAll()
        scanAnimalTagText.text?.removeAll()
        permanentIDTextField.text?.removeAll()
        sireIdTextField.text?.removeAll()
        damtexfield.text?.removeAll()
        if UserDefaults.standard.value(forKey: keyValue.dataEntrybreedName.rawValue) as? String == "" || UserDefaults.standard.value(forKey: keyValue.dataEntrybreedName.rawValue)  as? String == nil{
            breedBtnOutlet.setTitle("HO", for: .normal)
        }
        else {
            let breedName = UserDefaults.standard.value(forKey: keyValue.dataEntrybreedName.rawValue)  as? String
            breedBtnOutlet.setTitle(breedName, for: .normal)
        }
        self.male_femaleBtnOutlet.setImage(UIImage(named: "LangFemale\(langCode)"), for: .normal)
        genderToggleFlag = 0
        genderString = ButtonTitles.femaleText.localized
        
        if UserDefaults.standard.string(forKey: keyValue.dataEntryTsu.rawValue) == nil || UserDefaults.standard.string(forKey: keyValue.dataEntryTsu.rawValue) == ""{
            if providerName == keyValue.clarifideAHDBUK.rawValue{
                
                UserDefaults.standard.set(ButtonTitles.caisleyTSUText, forKey: keyValue.dataEntryTsu.rawValue)
            }else {
                self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue))
                for items in self.tissueArr
                {
                    let tissue = items  as? GetSampleTbl
                    let checkdefault  = tissue?.isDefault
                    
                    if pvid == 11 {
                        let country : String = UserDefaults.standard.object(forKey: keyValue.country.rawValue) as? String ?? ""
                        switch country  {
                        case countryName.Belgium.title, countryName.Luxembourg.title :
                            saveSampleNameandID(sampleNameStr: ButtonTitles.allflexTSUText, sampleID: 1)
                            self.tissueBtnOutlet.setTitle(ButtonTitles.allflexTSUText, for: .normal)
                        case countryName.Netherlands.title :
                            saveSampleNameandID(sampleNameStr: LocalizedStrings.hairString, sampleID: 4)
                            self.tissueBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.hairString, comment: ""), for: .normal)
                        default:
                            break
                        }
                    }
                    else if pvid == 8 {
                        saveSampleNameandID(sampleNameStr: LocalizedStrings.hairString, sampleID: 4)
                        self.tissueBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.hairString, comment: ""), for: .normal)
                    }else {
                        if checkdefault == true
                        {
                            saveSampleNameandID(sampleNameStr: tissue?.sampleName ?? "", sampleID: 0)
                            self.tissueBtnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
                        }
                    }
                }
            }}
        else{
            tissueBtnOutlet.setTitle(UserDefaults.standard.string(forKey: keyValue.dataEntryTsu.rawValue), for: .normal)
        }
        
        let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
        if providerName == keyValue.clarifideAHDBUK.rawValue{
            if UserDefaults.standard.string(forKey: keyValue.dataEntryTsu.rawValue) == nil || UserDefaults.standard.string(forKey: keyValue.dataEntryTsu.rawValue) == ""{
                self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue))
                for items in self.tissueArr
                {
                    let tissue = items  as? GetSampleTbl
                    let checkdefault  = tissue?.isDefault
                    if pvid == 11 {
                        let country : String = UserDefaults.standard.object(forKey: keyValue.country.rawValue) as? String ?? ""
                        switch country  {
                        case countryName.Belgium.title, countryName.Luxembourg.title :
                            saveSampleNameandID(sampleNameStr: ButtonTitles.allflexTSUText, sampleID: 1)
                            self.tissueBtnOutlet.setTitle(ButtonTitles.allflexTSUText, for: .normal)
                        case countryName.Netherlands.title :
                            saveSampleNameandID(sampleNameStr: LocalizedStrings.hairString, sampleID: 4)
                            self.tissueBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.hairString, comment: ""), for: .normal)
                        default:
                            break
                        }
                    } else if pvid == 8{
                        saveSampleNameandID(sampleNameStr: LocalizedStrings.hairString, sampleID: 4)
                        self.tissueBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.hairString, comment: ""), for: .normal)
                    }
                    else {
                        if checkdefault == true
                        {
                            saveSampleNameandID(sampleNameStr: tissue?.sampleName ?? "", sampleID: 0)
                            self.tissueBtnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
                        }
                    }
                }
            }
            
            else{
                tissueBtnOutlet.setTitle(UserDefaults.standard.string(forKey: keyValue.dataEntryTsu.rawValue), for: .normal)
            }
            
            if breedId  == "" {
                let inheritBreed = fetchAllDataProductBeefIdDairy(entityName: Entities.getBreedsTblEntity, breedName: (breedBtnOutlet.titleLabel?.text)!, pvid: 2)
                if inheritBreed.count != 0 {
                    let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                    breedId = medbreedRegArr1!.breedId ?? ""
                    UserDefaults.standard.set(breedId, forKey: keyValue.dataEntrybreedId.rawValue)
                }
            }
        }
        breedBtnOutlet.setTitleColor(.gray, for: .normal)
        tissueBtnOutlet.setTitleColor(.gray, for: .normal)
        self.selectedDate = Date()
        textFieldBackroungGrey()
        self.scrolView.contentOffset.y = 0.0
        dateBtnOutlet.titleLabel?.text = ""
        dateBtnOutlet.setTitle(nil, for: .normal)
        dateTextField.text = ""
        self.selectedBornTypeId = 1
        
        if pvid == 1 {
            if breedId  == "" {
                let inheritBreed = fetchAllDataProductBeefIdDairy(entityName: Entities.getBreedsTblEntity, breedName: (breedBtnOutlet.titleLabel?.text)!, pvid: 1)
                if inheritBreed.count != 0 {
                    let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                    breedId = medbreedRegArr1!.breedId ?? ""
                    UserDefaults.standard.set(breedId, forKey: keyValue.dataEntrybreedId.rawValue)
                }
            }
        }
        else if pvid == 3 {
            if breedId  == "" {
                let inheritBreed = fetchAllDataProductBeefIdDairy(entityName: Entities.getBreedsTblEntity, breedName: (breedBtnOutlet.titleLabel?.text)!, pvid: 3)
                if inheritBreed.count != 0 {
                    let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                    breedId = medbreedRegArr1!.breedId ?? ""
                    UserDefaults.standard.set(breedId, forKey: keyValue.dataEntrybreedId.rawValue)
                }
            }
        }
        incrementalBarcodeTitleLabel.textColor = .gray
        incrementalBarcodeButton.isEnabled = false
        self.scanAnimalTagText.becomeFirstResponder()
        self.scrolView.contentOffset.y = 0.0
        expandFormOutlet.alpha = 0.4
        expandFormOutlet.isEnabled = false
       isComingFromDataList = false
       loadedAnimalData = nil
    }
    
    func timeStamp()-> String {
        
        let time1 = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatters.MMddyyyyHHmmssFormat
        let timestamp = formatter.string(from: time1 as Date)
        lblTimeStamp = timestamp.replacingOccurrences(of: "-", with: "", options: .regularExpression)
        lblTimeStamp = lblTimeStamp.replacingOccurrences(of: ":", with: "", options: .regularExpression)
        let udid = UserDefaults.standard.value(forKey: keyValue.applicationIdentifier.rawValue)! as! String
        let sessionGUID1 =   lblTimeStamp + "_" + String(describing: autoD as Int)
        lblTimeStamp = sessionGUID1 + "_" + "iOS" + "_" + String(udid)
        return lblTimeStamp
    }
    
    func doDatePicker(){
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 40, width: self.calenderView.frame.size.width, height: 260))
        self.datePicker?.backgroundColor = UIColor.white
        self.datePicker?.datePickerMode = UIDatePicker.Mode.date
        self.datePicker.setDate(selectedDate, animated: true)
        
        if #available(iOS 14, *) {
            self.datePicker?.preferredDatePickerStyle = .wheels
        }
        calenderView.backgroundColor = UIColor.white
        calenderView.addSubview(self.datePicker)
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        self.datePicker.maximumDate = Date()
        let doneButton = UIBarButtonItem(title:  NSLocalizedString(LocalizedStrings.doneStr, comment: ""), style: .plain, target: self, action: #selector(self.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title:  NSLocalizedString("Cancel", comment: ""), style: .plain, target: self, action: #selector(self.cancelClick))
        cancelButton.tintColor = UIColor.black
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = CGRect(x: 0, y: 0, width: self.calenderView.frame.size.width, height: 40)
        self.calenderView.addSubview(toolBar)
        self.toolBar.isHidden = false
        
    }
    
    func initialNetworkCheck(){
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del = UIApplication.shared.delegate as? AppDelegate
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if NetworkStatusLbl?.text == ButtonTitles.connectedText.localized {
            networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
            offLineBtn.isEnabled = false
        }
        else {
            offLineBtn.isEnabled = true
            networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    func tableViewpop() {
        buttonbg2.frame = CGRect(x:0,y: 0,width: 1024,height: 1000)
        buttonbg2.addTarget(self, action:#selector(DataEntryOrderingAnimalVC.buttonPreddDroper), for: .touchUpInside)
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
        buttonbgAutoSuggestion.addTarget(self, action:#selector(DataEntryOrderingAnimalVC.buttonPreddDroperAutosugesstion), for: .touchUpInside)
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
        var animalMaster = NSArray()
        var animalMasterData = AnimalMaster()
        if animalIdBool == true {
            textFieldBackroungWhite()
            animalFetch = fetchAllDataWithAnimalId(entityName: Entities.dataEntryAnimalAddTbl, animalId: animalId, customerID: custmerId!)
          if animalFetch.count > 0{
            loadedAnimalData = animalFetch[0] as! DataEntryAnimaladdTbl
          }
            let data = animalFetch.object(at: 0) as! DataEntryAnimaladdTbl
            let screenRefernce = UserDefaults.standard.value(forKey:keyValue.screen.rawValue) as? String
            
            if screenRefernce == keyValue.farmId.rawValue || screenRefernce == "" {
                scanAnimalTagText.text = data.farmId
                farmIdTextField.text = data.animalTag
                farmiDValueStore = data.farmId ?? ""
                UserDefaults.standard.set(data.animalTag?.uppercased(), forKey: keyValue.selectAnimalId.rawValue)
                textFieldAnimal = data.animalTag ?? ""
                animalMaster =  fetchAnimaldataValidateAnimalwithouOrderIDAND(entityName: Entities.animalMasterTblEntity, animalTag: "", farmId: scanAnimalTagText.text!, animalbarCodeTag: scanBarcodeText.text!.uppercased(), offPermanentId: permanentIDTextField.text!.uppercased(), offDamId: damtexfield.text!.uppercased(), offsireId: sireIdTextField.text!.uppercased(),orderId:orderId,userId:userId,custmerId:custmerId ?? 0)
            } else {
                textFieldAnimal = data.farmId!
                scanAnimalTagText.text = data.animalTag
                UserDefaults.standard.set(data.animalTag?.uppercased(), forKey: keyValue.selectAnimalId.rawValue)
                farmIdTextField.text = data.farmId
                textFieldAnimal = data.animalTag ?? ""
                
                animalMaster =  fetchAnimaldataValidateAnimalwithouOrderIDAND(entityName: Entities.animalMasterTblEntity, animalTag: scanAnimalTagText.text!, farmId: "", animalbarCodeTag: scanBarcodeText.text!.uppercased(), offPermanentId: permanentIDTextField.text!.uppercased(), offDamId: damtexfield.text!.uppercased(), offsireId: sireIdTextField.text!.uppercased(),orderId:orderId,userId:userId,custmerId:custmerId ?? 0)
            }
            if animalMaster.count > 0 {
                 animalMasterData = animalMaster.object(at: 0) as! AnimalMaster

            }
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            animalId1 = Int(data.animalId)
            dataAutoPopulatedBool =  true
            
            if selctionAuProvider == true {
                if data.sireIDAU == "" {
                    
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
            
            dateBtnOutlet.titleLabel!.text = ""
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
                    formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                }
                self.selectedDate = formatter.date(from: dateBtnOutlet.titleLabel!.text!) ?? Date()
                let isGreater = Date().isSmaller(than: selectedDate)
                if isGreater == true {
                    dateBtnOutlet.setTitle("", for: .normal)
                    dateTextField.text = ""
                }
                
            } else if animalMaster.count > 0  {
                if animalMasterData.date != "" {
                    let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
                    let formatter = DateFormatter()
                    
                    if dateStr == "MM"{
                    var dateVale = ""
                    let values = animalMasterData.date!.components(separatedBy: "/")
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
                    formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                }
                self.selectedDate = formatter.date(from: dateBtnOutlet.titleLabel!.text!) ?? Date()
                let isGreater = Date().isSmaller(than: selectedDate)
                if isGreater == true {
                    dateBtnOutlet.setTitle("", for: .normal)
                    dateTextField.text = ""
                    }
                }
            }
            if data.animalbarCodeTag != "" {
                scanBarcodeText.text = data.animalbarCodeTag
                borderRedCheck = false
                barcodeflag = false
            } else if animalMaster.count > 0  {
                if animalMasterData.animalbarCodeTag != "" {
                    scanBarcodeText.text = animalMasterData.animalbarCodeTag
                    borderRedCheck = false
                    barcodeflag = false
                }
            } else {
                scanBarcodeText.text = ""
            }
          
            permanentIDTextField.text = data.offPermanentId
            
            if pvid == 3 {
                if data.offsireId != "" {
                    sireIdTextField.text = data.offsireId
                } else if animalMaster.count > 0 {
                    if animalMasterData.offsireId != "" {
                        sireIdTextField.text = animalMasterData.offsireId
                    }
                } else {
                    sireIdTextField.text = ""
                }
                
                
            } else  {
                if data.offsireId != "" {
                    sireIdTextField.text = data.offsireId
                } else if animalMaster.count > 0 {
                    if animalMasterData.offsireId != "" {
                        sireIdTextField.text = animalMasterData.offsireId
                    }
                } else {
                    sireIdTextField.text = ""
                }
                
            }
            if data.offDamId != "" {
                damtexfield.text = data.offDamId
            } else if animalMaster.count > 0 {
                if animalMasterData.offDamId != "" {
                    damtexfield.text = animalMasterData.offDamId
                }
            } else {
                damtexfield.text = ""
            }
          //  damtexfield.text = data.offDamId
            breedBtnOutlet.setTitle(data.breedName, for: .normal)
            tissueBtnOutlet.setTitleColor(.black, for: .normal)
            breedBtnOutlet.setTitleColor(.black, for: .normal)
            tissueBtnOutlet.setTitle(data.tissuName?.localized, for: .normal)
            breedId = data.breedId!
            UserDefaults.standard.set(breedId, forKey: keyValue.dataEntrybreedId.rawValue)
            
            if data.gender == ButtonTitles.maleText.localized || data.gender == "M" {
                self.male_femaleBtnOutlet.setImage(UIImage(named: "LangMale\(langCode)"), for: .normal)
                genderToggleFlag = 1
                genderString = ButtonTitles.maleText.localized
                
            } else {
                self.male_femaleBtnOutlet.setImage(UIImage(named: "LangFemale\(langCode)"), for: .normal)
                genderToggleFlag = 0
                genderString = ButtonTitles.femaleText.localized
                
            }
            checkBarcode = false
            incrementalBarcodeTitleLabel.textColor = .black
            incrementalBarcodeButton.isEnabled = true
            
            let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.dataEntryAnimalAddTbl,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
            if dataFetch.count != 0 {
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
            UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlagDataEntry.rawValue)

            
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
            
            if et == NSLocalizedString("Et", comment: ""){
                etBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                etBttn.layer.borderWidth = 2
                singleBttn.layer.borderColor = UIColor.gray.cgColor
                internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                selectedBornTypeId = 3
                
            } else if et == NSLocalizedString(LocalizedStrings.singlesText, comment: ""){
                
                singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                singleBttn.layer.borderWidth = 2
                internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                etBttn.layer.borderColor = UIColor.gray.cgColor
                selectedBornTypeId = 1
                
            }else if et == NSLocalizedString(LocalizedStrings.multipleBirthStr, comment: ""){
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
            else if et == NSLocalizedString(LocalizedStrings.cloneText, comment: ""){
                cloneOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                cloneOutlet.layer.borderWidth = 2
                internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                singleBttn.layer.borderColor = UIColor.gray.cgColor
                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                etBttn.layer.borderColor = UIColor.gray.cgColor
                selectedBornTypeId = 5
            }
            else if et == NSLocalizedString(LocalizedStrings.internalStr, comment: ""){
                internalBtnOulet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                internalBtnOulet.layer.borderWidth = 2
                cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                singleBttn.layer.borderColor = UIColor.gray.cgColor
                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                etBttn.layer.borderColor = UIColor.gray.cgColor
                selectedBornTypeId = 6
                
            }else {
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
            
            if dataEntryConflicedBack == true {
                resetIconImage.isHidden = true
                dataEntryReviewData.isHidden = true
                clearFormOutlet.isHidden = true
            } else {
                dataEntryReviewData.isHidden = false
                clearFormOutlet.isHidden = false
                resetIconImage.isHidden = false
            }
        } else {
            animalFetch = fetchAllDataWithAnimalId(entityName: Entities.animalMasterTblEntity, animalId: idAnimal, customerID: custmerId!)
            if animalFetch.count > 0 {
                let data = animalFetch.object(at: 0) as! AnimalMaster
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
                        formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                    }
                    self.selectedDate = formatter.date(from: dateBtnOutlet.titleLabel!.text!)!
                    let isGreater = Date().isSmaller(than: selectedDate)
                    if isGreater == true {
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
                saveSampleNameandID(sampleNameStr: data.tissuName ?? "", sampleID: 0)
                breedId = data.breedId!
                UserDefaults.standard.set(breedId, forKey: keyValue.dataEntrybreedId.rawValue)
                
                if data.gender == ButtonTitles.maleText.localized || data.gender == "M" {
                    self.male_femaleBtnOutlet.setImage(UIImage(named: "LangMale\(langCode)"), for: .normal)
                    genderToggleFlag = 1
                    genderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
                    
                } else {
                    self.male_femaleBtnOutlet.setImage(UIImage(named: "LangFemale\(langCode)"), for: .normal)
                    genderToggleFlag = 0
                    genderString = ButtonTitles.femaleText.localized
                }
                
                let screenRefernce = UserDefaults.standard.value(forKey:keyValue.screen.rawValue) as? String
                if screenRefernce == keyValue.farmId.rawValue || screenRefernce == ""{
                    scanAnimalTagText.text = data.farmId
                    farmIdTextField.text = data.animalTag
                    textFieldAnimal = data.animalTag!
                } else {
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
                            if naabFetch11!.count != 0 {
                                let breedIdGet = (naabFetch11![0] as? String)!
                                self.breedId = breedIdGet
                                UserDefaults.standard.set(self.breedId, forKey: keyValue.dataEntrybreedId.rawValue)
                                let breedName = codeId1.value(forKey: keyValue.alpha2.rawValue) as? NSArray
                                if naabFetch11!.count != 0 {
                                    let nameBreed = (breedName![0] as? String)!
                                    self.breedBtnOutlet.setTitle(nameBreed, for: .normal)
                                }
                            }
                        }
                    }
                }
                sireIdValidationB = false
                damIdValidationB = false
                
                if pvid == 3 {
                    sireIdValidationB = true
                    autoSuggestionStatus = true
                } else {
                    sireIdValidationB = false
                    autoSuggestionStatus = false
                    
                }
                
                checkBarcode = false
                incrementalBarcodeTitleLabel.textColor = .black
                incrementalBarcodeButton.isEnabled = true
                
                let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.dataEntryAnimalAddTbl,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
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
                
                if et == NSLocalizedString("Et", comment: ""){
                    etBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    etBttn.layer.borderWidth = 2
                    singleBttn.layer.borderColor = UIColor.gray.cgColor
                    internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                    cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 3
                }
                else if et == NSLocalizedString(LocalizedStrings.singlesText, comment: ""){
                    singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    singleBttn.layer.borderWidth = 2
                    internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                    cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                    etBttn.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 1
                }
                else if et == NSLocalizedString(LocalizedStrings.multipleBirthStr, comment: ""){
                    multipleBirthBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    multipleBirthBttn.layer.borderWidth = 2
                    internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                    singleBttn.layer.borderColor = UIColor.gray.cgColor
                    SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                    cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                    etBttn.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 2
                }
                else if et == NSLocalizedString(LocalizedStrings.splitEmbryoStr, comment: "") {
                    SplitEmbryoOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    SplitEmbryoOutlet.layer.borderWidth = 2
                    internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                    singleBttn.layer.borderColor = UIColor.gray.cgColor
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                    etBttn.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 4
                }
                else if et == NSLocalizedString(LocalizedStrings.cloneText, comment: ""){
                    cloneOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    cloneOutlet.layer.borderWidth = 2
                    internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                    singleBttn.layer.borderColor = UIColor.gray.cgColor
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                    etBttn.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 5
                }
                else if et == NSLocalizedString(LocalizedStrings.internalStr, comment: ""){
                    internalBtnOulet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    internalBtnOulet.layer.borderWidth = 2
                    cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                    singleBttn.layer.borderColor = UIColor.gray.cgColor
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                    etBttn.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 6
                } else {
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
            
            if dataEntryConflicedBack == true {
                resetIconImage.isHidden = true
                dataEntryReviewData.isHidden = true
                clearFormOutlet.isHidden = true
                
            } else {
                dataEntryReviewData.isHidden = false
                clearFormOutlet.isHidden = false
                resetIconImage.isHidden = false
            }
        }
    }
    
    func validateFirstLetter(firstLetter:Character)->String{
        let breedAr = breedCodesArray.value(forKey: keyValue.alpha2.rawValue) as! NSArray
        var finalString = String()
        for (index, item) in breedAr.enumerated() {
            let srt = item as! String
            for (ind, char) in srt.enumerated() {
                if (char == firstLetter) && ind == 0 {
                    finalString = breedAr[index] as! String
                    newString = true
                    break
                }else {
                    newString = false
                }
            }
            if newString == true {
                break
            }
            
        }
        return finalString
    }
    
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
            } else {
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
            }else {
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
                        
                    } else if get3CountryCode == "840" && (10000...003001000001).contains(Int(digitsTwelve)!)  {
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
                        
                    } else {
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
                
            } else {
                id17display(animalId: idAnimal, borderRed: true)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalRFIDId, comment: ""), duration: 2, position: .top)
            }
            
        } else {
            
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
                    } else {
                        idAnimal = breedBtnOutlet.titleLabel!.text! + providerSelectionCountryCode +  idAnimal
                        id17display(animalId: idAnimal, borderRed: false)
                    }
                } else {
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidRFIDId, comment: ""), duration: 2, position: .top)
                    id17display(animalId: idAnimal, borderRed: true)
                }
                return
                
            } else {
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCountryCode, comment: ""), duration: 2, position: .top)
                id17display(animalId: idAnimal, borderRed: true)
                return
                
            }
        }
    }
    
    func validationId17(animalId:String){
        let breedAr = breedCodesArray.value(forKey: keyValue.alpha2.rawValue) as! NSArray
        let threeCharCode = breedCodesArray.value(forKey: keyValue.threeCharCode.rawValue) as! NSArray
        countryCodesArray = fetchAllData(entityName: Entities.getCountryCodeTblEntity)
        let countryArr = countryCodesArray.value(forKey: keyValue.alphaCode.rawValue) as! NSArray
        let naabArr = naabCodesArray.value(forKey: keyValue.naabCode.rawValue) as! NSArray
        let counteryNumericArr = countryCodesArray.value(forKey: keyValue.numericCode.rawValue) as! NSArray
        if genderString == ButtonTitles.maleText.localized || genderString == "M"{
            genderFirst = "M"
        } else if genderString == ButtonTitles.femaleText.localized || genderString == "F"{
            genderFirst = "F"
        } else {
        }
        
        var idAnimal = animalId.uppercased()
        if idAnimal.isInt == true {
            rfidScanning(animalId: animalId)
        }
        else {
            let firstElement = String(idAnimal.prefix(1))
            if firstElement.isInt == true {
                
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
                
                if second.isInt == true {
                    if thirdCHAR.isInt == true {
                        if breedAr.contains(dropBreedName) {
                            if dropFive.count == 0 {
                                self.view.hideToast()
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNaabCode, comment: ""), duration: 2, position: .top)
                                id17display(animalId: idAnimal, borderRed: true)
                                return
                            }
                            if dropFive.isInt == true || dropFive == "" {
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
                            }
                            else {
                                self.view.hideToast()
                                id17display(animalId: idAnimal, borderRed: true)
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNaabCode, comment: ""), duration: 2, position: .top)
                                return
                            }
                            
                        } else {
                            
                            if dropBreedName.isInt == false && dropBreedFirstName.isInt == false{
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
                                if lastFive.isInt == true {
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
                                }else {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNaabCode, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                    
                                }
                            } else {
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
                                    
                                } else {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidRFIDId, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                    return
                                }
                            }
                        }
                    } else {
                        let fo = animalId.prefix(4).uppercased()
                        let fourChar = String(fo.dropFirst(3).uppercased())
                        if fourChar.count == 0 {
                            self.view.hideToast()
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidInput, comment: ""), duration: 2, position: .top)
                            id17display(animalId: idAnimal, borderRed: true)
                            return
                        }
                        
                        if fourChar.isInt == true {
                            let start = animalId.prefix(2).uppercased()
                            let thirddCheck = animalId.dropFirst(2)
                            let dropThird = animalId.dropFirst(3)
                            let breed = thirddCheck.prefix(1).uppercased()
                            var idFive = dropThird.uppercased()//.dropFirst(1).uppercased()
                            let ab = validateFirstLetter(firstLetter: Character(breed))
                            
                            if breedAr.contains(ab) {
                                if idFive.isInt == true {
                                    let addObject = 5 - idFive.count
                                    if idFive.count <= 5 {
                                        
                                        if addObject != 0 {
                                            for _ in 0...addObject - 1{
                                                idFive = "0" + idFive
                                            }
                                        }
                                        idAnimal = "0" + start + ab + idFive
                                        naabCodeCheck(animalId: idAnimal)
                                    }else {
                                        self.view.hideToast()
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                                        id17display(animalId: idAnimal, borderRed: true)
                                        return
                                    }
                                    
                                } else {
                                    self.view.hideToast()
                                    id17display(animalId: idAnimal, borderRed: true)
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNaabCode, comment: ""), duration: 2, position: .top)
                                    return
                                }
                                
                            } else {
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
                                }else {
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
                                
                                if idFive.isInt == true {
                                    
                                    let addObject = 5 - idFive.count
                                    if idFive.count <= 5 {
                                        
                                        if addObject != 0 {
                                            for _ in 0...addObject - 1{
                                                idFive = "0" + idFive
                                            }
                                        }
                                        idAnimal = "0" + fetchFour + idFive
                                        naabCodeCheck(animalId: idAnimal)
                                    }else {
                                        self.view.hideToast()
                                        id17display(animalId: idAnimal, borderRed: true)
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                                        return
                                    }
                                } else {
                                    self.view.hideToast()
                                    id17display(animalId: idAnimal, borderRed: true)
                                    
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNaabCode, comment: ""), duration: 2, position: .top)
                                    return
                                }
                                
                            } else {
                                if idAnimal.count >= 5 {
                                    rinvalidBreedCodeContiune(animalId: idAnimal)
                                    return
                                    
                                } else {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidBreedCode, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                    
                                    return
                                }
                                return
                            }
                        }
                    }
                    
                } else {
                    
                    if thirdCHAR.count == 0 {
                        self.view.hideToast()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNaabCode, comment: ""), duration: 2, position: .top)
                        id17display(animalId: idAnimal, borderRed: true)
                        return
                    }
                    if thirdCHAR.isInt == true {
                        let ab = validateFirstLetter(firstLetter: Character(second))
                        if breedAr.contains(ab)  {
                            var lastFive = animalId.dropFirst(2).uppercased()
                            if lastFive.isInt == true {
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
                    }
                    else {
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
                                
                            }else {
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
                
            } else {
                
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
                                        
                                    } else {
                                        let breedC = breedCodesArray.value(forKey: keyValue.alpha2.rawValue) as? NSArray
                                        let breedTwo = (breedC![indexOfA] as? String)!
                                        genderBtnChange(genderFlag: genderGet)
                                        idAnimal = breedTwo + getCountryCode + removeSeven
                                        breedBtnOutlet.setTitle(breedTwo.uppercased(), for: .normal)
                                        id17display(animalId: idAnimal, borderRed: false)
                                    }
                                    
                                } else {
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
                            
                        }else {
                            
                            self.view.hideToast()
                            id17display(animalId: idAnimal, borderRed: true)
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCountryCode, comment: ""), duration: 2, position: .top)
                            return
                        }
                        //??
                    } else {
                        if firstTwo == "XD"{
                            let breedAr = breedCodesArray.value(forKey: keyValue.alpha2.rawValue) as! NSArray
                            XDFound = breedAr.contains("XX")
                        }
                        
                        if breedAr.contains(firstTwo) || XDFound {
                            
                            let getTwoBreedCode = firstThreeElement.dropLast(1)
                            let removeThreeChar = idAnimal.dropFirst(2)
                            let countryCode = removeThreeChar.prefix(3).uppercased()
                            if countryCode.isInt == true {
                                id17FlowNumeric(animalId: idAnimal,countryCode:countryCode,breedCode:firstTwo)
                                return
                            }
                            let cc = removeThreeChar.prefix(4).uppercased()
                            let getGender = cc.dropFirst(3).uppercased()
                            if countryCode.count != 3 {
                                
                                if scanAnimalTagText.tag == 0 {
                                    officalTagView.layer.borderColor = UIColor.red.cgColor
                                    
                                } else {
                                    farmIdView.layer.borderColor = UIColor.red.cgColor
                                }
                                
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCountryCode, comment: ""), duration: 2, position: .top)
                                return
                            }
                            if countryCode == "CAN" {
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
                            if countryCode == "NZL" {
                                newZealandFlow(animalId:idAnimal)
                                return
                            }
                            if countryCode == "ITA" {
                                italyFlow(animalId: idAnimal)
                                return
                            }
                            
                            if countryArr.contains(countryCode.uppercased()) {
                                if String(getGender) == "M" || String(getGender) == "F"{
                                    
                                    var removeSeven = String(idAnimal.dropFirst(6))
                                    if removeSeven.isInt == true {
                                        let addObject = 12 - removeSeven.count
                                        if removeSeven.count <= 12 {
                                            if addObject != 0 {
                                                for _ in 0...addObject - 1{
                                                    removeSeven = "0" + removeSeven
                                                }
                                            }
                                            
                                            idAnimal = getTwoBreedCode + countryCode + removeSeven
                                            
                                            let obj = rangeCheck(animalId:  removeSeven, countryCode: countryCode.uppercased())
                                            if obj == true{
                                                breedBtnOutlet.setTitle(getTwoBreedCode.uppercased(), for: .normal)
                                                genderBtnChange(genderFlag: getGender)
                                                id17display(animalId: idAnimal, borderRed: false)
                                                
                                            } else {
                                                self.view.hideToast()
                                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimUSA, comment: ""), duration: 2, position: .top)
                                                id17display(animalId: animalId.uppercased(), borderRed: true)
                                                return
                                            }
                                            
                                            
                                        } else {
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
                                
                            } else {
                                
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
                                                
                                            }else {
                                                
                                                idAnimal = firstTwo + ob +  dropThree
                                                id17display(animalId: idAnimal, borderRed: false)
                                                
                                                return
                                            }
                                            
                                        }else {
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
            }
            else {
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
                    
                    if dropFive.isInt == true {
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
                    } else {
                        idAnimal = breedC + countryC + dropFive
                        if breedC == "XD"{
                            breedBtnOutlet.setTitle("XX", for: .normal)
                        } else {
                            breedBtnOutlet.setTitle(breedC.uppercased(), for: .normal)
                        }
                        id17display(animalId: idAnimal, borderRed: false)
                    }
                }
                else {
                    self.view.hideToast()
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                    id17display(animalId: idAnimal, borderRed: true)
                }
            }
            else {
                self.view.hideToast()
                id17display(animalId: idAnimal, borderRed: true)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
            }
        }
        else {
            let firstTwo = idAnimal.prefix(2).uppercased()
            if firstTwo == "XD"{
                let breedAr = breedCodesArray.value(forKey: keyValue.alpha2.rawValue) as! NSArray
                XDFound = breedAr.contains("XX")
            }
            if breedAr.contains(firstTwo) || XDFound {
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
                        breedBtnOutlet.setTitle(firstTwo,for: .normal)
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
                            breedBtnOutlet.setTitle(firstTwo,for: .normal)
                            idAnimal = firstTwo + providerSelectionCountryCode +  dropFirstTwo
                            id17display(animalId: idAnimal, borderRed: false)
                            return
                        }
                    }
                }
                else {
                    self.view.hideToast()
                    id17display(animalId: idAnimal, borderRed: true)
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                    return
                }
            }
            
        }
    }
    
    func genderBtnChange(genderFlag: String){
        
        if genderFlag == "M" {
            self.male_femaleBtnOutlet.setImage(UIImage(named: "LangMale\(langCode)"), for: .normal)
            genderToggleFlag = 1
            genderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
            
        } else if genderFlag == "F" {
            self.male_femaleBtnOutlet.setImage(UIImage(named: "LangFemale\(langCode)"), for: .normal)
            genderToggleFlag = 0
            genderString = ButtonTitles.femaleText.localized
            
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
        }
        else {
            self.view.makeToast(NSLocalizedString(LocalizedStrings.naabCodeNotFound, comment: ""), duration: 2, position: .top)
            id17display(animalId: idAnimal, borderRed: true)
        }
    }
    
    func id17display(animalId:String,borderRed :Bool){
        self.borderRedChange = borderRed
        let idAnimal = animalId
        
        if scanAnimalTagText.tag == 0 {
            if borderRedChange == false{
                scanAnimalTagText.text! = idAnimal.uppercased()
                UserDefaults.standard.set(idAnimal.uppercased(), forKey: keyValue.selectAnimalId.rawValue)
                scanAnimalTagText.textColor = UIColor.black
                self.view.makeToast(NSLocalizedString(LocalizedStrings.animalIDValidated, comment: ""), duration: 1, position: .top)
                borderRedChange = false
                let breedName = idAnimal.prefix(2).uppercased()
                let codeId = fetchBreedDatabreedCode(entityName: Entities.getBreedsTblEntity,provId: pvid,breedCode:breedName)
                if codeId.count != 0 {
                    let naabFetch1 = codeId.value(forKey: keyValue.breedId.rawValue) as? NSArray
                    let breedIdGet = (naabFetch1![0] as? String)!
                    breedId = breedIdGet
                }
                
                textFieldAnimal = idAnimal.uppercased()
                borderRedCheck = false
                officalTagView.layer.borderColor = UIColor.gray.cgColor
                
                if dataAutoPopulatedBool == true {
                    let bbb =  fetchAnimaldataValidateAnimalBarcodetag(entityName: Entities.dataEntryAnimalAddTbl,animalbarCodeTag:textFieldAnimal ,orderId: orderId, userId: userId, custmerId: custmerId ?? 0)
                    if bbb.count != 0 {
                        farmIDBoolEntryTag = true
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.duplicateEntryStr, comment: ""))
                    } else {
                        farmIDBoolEntryTag = false
                    }
                }
                else {
                    //dataPopulateInFocusChange()
                }
            }
            else {
                scanAnimalTagText.text! = idAnimal.uppercased()
                scanAnimalTagText.textColor = UIColor.red
                borderRedChange = true
                textFieldAnimal = ""
                borderRedCheck = true
                officalTagView.layer.borderColor = UIColor.red.cgColor
            }
        }
        else {
            if borderRedChange == false {
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
                    breedBtnOutlet.setTitle(idAnimal.prefix(2).uppercased(), for: UIControl.State.normal)
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
        if genderString == ButtonTitles.maleText.localized {
            genderFirst = "M"
        } else if genderString == ButtonTitles.femaleText.localized {
            genderFirst = "F"
        } else {
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
        
        if firstTwoBreedCode.isInt == true {
            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalId, comment: ""), duration: 2, position: .top)
            id17display(animalId: idAnimal, borderRed: true)
        }
        else {
            if firstTwoBreedCode == "XD"{
                let breedAr = breedCodesArray.value(forKey: keyValue.alpha2.rawValue) as! NSArray
                XDFound = breedAr.contains("XX")
            }
            if breedAr.contains(firstTwoBreedCode) || XDFound {
                if countryCode.isInt == true{
                    if countryArr.contains(countryCode.uppercased()) || counteryNumericArr.contains(Int(countryCode) as Any){
                        if removeFive.isInt == true {
                            let addObject = 12 - removeFive.count
                            if addObject != 0 {
                                for _ in 0...addObject - 1{
                                    removeFive = "0" + removeFive
                                }
                            }
                            idAnimal =  firstTwoBreedCode  + countryCode + removeFive
                            if firstTwoBreedCode == "XD"{
                                breedBtnOutlet.setTitle("XX", for: .normal)
                            } else {
                                breedBtnOutlet.setTitle(firstTwoBreedCode.uppercased(), for: .normal)
                            }
                            id17display(animalId: idAnimal, borderRed: false)
                        }
                        else {
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                            id17display(animalId: idAnimal, borderRed: true)
                        }
                    }
                    else {
                        id17display(animalId: idAnimal, borderRed: true)
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCountryCode, comment: ""), duration: 2, position: .top)
                    }
                }
                else {
                    if countryArr.contains(countryCode.uppercased()) || counteryNumericArr.contains(Int(countryCode) as Any){
                        if String(getGender) == "M" || String(getGender) == "F"{
                            if removeFirstSix.isInt == true {
                                let addObject = 12 - removeFirstSix.count
                                if addObject != 0 {
                                    for _ in 0...addObject - 1{
                                        removeFirstSix = "0" + removeFirstSix
                                    }
                                }
                                idAnimal =  firstTwoBreedCode  + countryCode + removeFirstSix
                                if firstTwoBreedCode == "XD"{
                                    breedBtnOutlet.setTitle("XX", for: .normal)
                                } else {
                                    breedBtnOutlet.setTitle(firstTwoBreedCode.uppercased(), for: .normal)
                                }
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
                    }
                    else {
                        id17display(animalId: idAnimal, borderRed: true)
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCountryCode, comment: ""), duration: 2, position: .top)
                    }
                }
            }
            else {
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
                                    
                                    //00000
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
                                            
                                        } else {
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
                            }
                            else {
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
                    
                    if firstThreeDrop.isInt == true {
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
                    }
                    else {
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
                            let beforeRCE = firstThreeDrop.substring(to: indexRCE!)
                            let animalCountE = firstThreeDrop.count - beforeRCE.count
                            let dropLastEl = String(firstThreeDrop.dropFirst(beforeRCE.count))
                            let dropFirstVale = String(beforeRCE.dropLast(3))
                            if dropLastEl.isInt == true && (dropFirstVale.isInt == true || dropFirstVale.count == 0 ){
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
                                }
                                else {
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                    return
                                }
                            }
                            else {
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
                                let beforeE = firstThreeDrop.substring(to: indexE!)
                                let dropElast = String(beforeE.dropLast())
                                let animalCountE = firstThreeDrop.count - beforeE.count
                                let dropLastEl = String(firstThreeDrop.dropFirst(beforeE.count))
                                if (dropElast.isInt == true || dropElast.count == 0) && (dropLastEl.isInt == true || dropLastEl.count == 0) {
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
                                    }
                                    else {
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                        id17display(animalId: idAnimal, borderRed: true)
                                        return
                                    }
                                }
                                else {
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                    return
                                }
                            }
                        }
                        else {
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                            id17display(animalId: idAnimal, borderRed: true)
                            
                        }}
                    
                    if idAnimal.contains("U"){
                        if firstThreeDrop.count > 7 {
                            let indexE = firstThreeDrop.range(of: "U", options: .forcedOrdering)?.upperBound
                            if indexE != nil{
                                let beforeE = firstThreeDrop.substring(to: indexE!)
                                let dropElast = String(beforeE.dropLast())
                                let animalCountE = firstThreeDrop.count - beforeE.count
                                let dropLastEl = String(firstThreeDrop.dropFirst(beforeE.count))
                                
                                if (dropElast.isInt == true || dropElast.count == 0) && (dropLastEl.isInt == true || dropLastEl.count == 0) {
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
                                }
                                else {
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                    return
                                }
                            }
                        }
                        else {
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                            id17display(animalId: idAnimal, borderRed: true)
                            
                        }}
                }
                
                if providerSelectionCountryCode == CountryCodes.argentina {
                    var firstThreeDrop = idAnimal
                    if idAnimal.contains("RCE"){
                        let indexRCE = firstThreeDrop.range(of: "RCE", options: .forcedOrdering)?.upperBound
                        if indexRCE != nil{
                            let beforeRCE = firstThreeDrop.substring(to: indexRCE!)
                            let animalCountE = firstThreeDrop.count - beforeRCE.count
                            let dropLastEl = String(firstThreeDrop.dropFirst(beforeRCE.count))
                            let dropFirstVale = String(beforeRCE.dropLast(3))
                            if dropLastEl.isInt == true && (dropFirstVale.isInt == true || dropFirstVale.count == 0 ){
                                
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
                                    }
                                    else {
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                        id17display(animalId: idAnimal, borderRed: true)
                                        return
                                    }
                                }
                                else {
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                    return
                                }
                            }
                            else {
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                id17display(animalId: idAnimal, borderRed: true)
                                return
                            }
                        }
                    }
                    
                    if firstThreeDrop.count >= 7 {
                        let indexE = firstThreeDrop.range(of: "E", options: .forcedOrdering)?.upperBound
                        if indexE != nil{
                            let beforeE = firstThreeDrop.substring(to: indexE!)
                            let dropElast = String(beforeE.dropLast())
                            let animalCountE = firstThreeDrop.count - beforeE.count
                            let dropLastEl = String(firstThreeDrop.dropFirst(beforeE.count))
                            if (dropElast.isInt == true || dropElast.count == 0) && (dropLastEl.isInt == true || dropLastEl.count == 0) {
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
                                    }
                                    else {
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                        id17display(animalId: idAnimal, borderRed: true)
                                        return
                                    }
                                }
                                else {
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                    return
                                }
                            }
                            else {
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
                                let beforeE = firstThreeDrop.substring(to: indexE!)
                                let dropElast = String(beforeE.dropLast())
                                let animalCountE = firstThreeDrop.count - beforeE.count
                                let dropLastEl = String(firstThreeDrop.dropFirst(beforeE.count))
                                if (dropElast.isInt == true || dropElast.count == 0) && (dropLastEl.isInt == true || dropLastEl.count == 0) {
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
                                        }
                                        else {
                                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                            id17display(animalId: idAnimal, borderRed: true)
                                            return
                                        }
                                    }
                                    else {
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                        id17display(animalId: idAnimal, borderRed: true)
                                        return
                                    }
                                }
                                else {
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                    return
                                }
                            }
                        }
                        else {
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                            id17display(animalId: idAnimal, borderRed: true)
                            
                        }}
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
                if idAnimal.isAlphanumeric == true {
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
                        
                        if remaningValue.isInt == true {
                            if countryCode == "840" || countryCode == "USA"{
                                let ob = rangeCheckReturnString(animalId: remaningValue, countryCode: countryCode)
                                idAnimal = breedBtnOutlet.titleLabel!.text! + ob +  remaningValue
                                id17display(animalId: idAnimal, borderRed: false)
                                return
                            }
                            else {
                                idAnimal = breedBtnOutlet.titleLabel!.text! + countryCode +  remaningValue
                                id17display(animalId: idAnimal, borderRed: false)
                                return
                            }
                        }
                        else {
                            idAnimal = breedBtnOutlet.titleLabel!.text! + countryCode +  remaningValue
                            id17display(animalId: idAnimal, borderRed: false)
                            return
                        }
                    }
                    else {
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                        id17display(animalId: idAnimal, borderRed: true)
                        return
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
                    }
                    else {
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                        id17display(animalId: idAnimal, borderRed: true)
                        return
                    }
                }
            }
        }
    }
    
    func rangeCheckReturnString(animalId :String,countryCode:String)-> String{
        var  animalId = String(animalId)
        let trimmedString = animalId.replacingOccurrences(of: " ", with: "")
        animalId = trimmedString
        //|| countryCode == "GBR" || countryCode == "312" || countryCode == "AUS"
        if countryCode == "840" ||  countryCode == "USA" {
            if animalId.isInt == true {
                if (003001000001) <= (Int(animalId)!){
                    return "840"
                }
                if (10000...003001000001).contains(Int(animalId)!){
                    return "USA"
                }
                
                if (10000...003001000001).contains(Int(animalId)!){
                    return "AUS"
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
        if animalId.isInt == true {
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
        if animalId.isInt == true {
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
    
    func startAnimating(){
    }
    func stopAnimating(){
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
                    self.stopAnimating()
                    if self.scanAnimalTagText.tag == 0 {
                        let trimmed = String(textStr.compactMap({ $0.isWhitespace ? nil : $0 }))
                        let test = String(trimmed.filter{!"\n\t\r(),.-[]:}{".contains($0)})
                        self.methReturn = self.ukTagReutn(animalId: test.uppercased())
                        if self.methReturn == LocalizedStrings.againClick {
                            self.scanAnimalTagText.text = ""
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
                        
                    } else {
                        let trimmed = String(textStr.compactMap({ $0.isWhitespace ? nil : $0 }))
                        let test = String(trimmed.filter{!"\n\t\r(),.-[]:}{".contains($0)})
                        self.methReturn =  self.ukTagReutn(animalId: test.uppercased())
                        if self.methReturn == LocalizedStrings.againClick {
                            self.farmIdTextField.text = ""
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
