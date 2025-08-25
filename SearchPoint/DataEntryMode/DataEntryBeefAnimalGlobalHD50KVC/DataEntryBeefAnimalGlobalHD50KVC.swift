
//""
//  BeefAnimalGlobalHD50KVC.swift
//  SearchPoint
//
//  Created by "" on 06/03/20.
//

import UIKit
import Toast_Swift
import Vision
import VisionKit
import CoreBluetooth

// MARK: - CLASS
class DataEntryBeefAnimalGlobalHD50KVC : UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate,VNDocumentCameraViewControllerDelegate {
    
    
    // MARK: - OUTLETS
    @IBOutlet weak var keyBoardOptionsView: UIView!
    @IBOutlet weak var keyBoardOptionsViewBottomConstrains: NSLayoutConstraint!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var closeImage1: UIImageView!
    @IBOutlet weak var closeImage2: UIImageView!
    @IBOutlet weak var globalDobView: UIView!
    @IBOutlet weak var inheritEidHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var inheritEidBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var inheritSecondaryHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var inheritSecondaryBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tissueInehritDropIMage: UIImageView!
    @IBOutlet weak var inheritRegAssoImage: UIImageView!
    @IBOutlet weak var sireYearOfBirthCalende: UIImageView!
    @IBOutlet weak var damYearOfBirthCalende: UIImageView!
    @IBOutlet weak var maleFemaleTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var maleFemaleHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var inheritBreedTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var inheritBreedHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var inheritDobHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var inheritRegAssTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var inheritRegAssHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var inheritBreedRegNumberTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var inheritBreedRegNumberHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var inheritSireRegNumberTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var inheritSireRegNumberHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var inheritSireRegAssoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var inheritsireRegAssoHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var inheritSireYearBirthTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var inheritSireYearBirthHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var inheritDamIdTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var inheritDamIdHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var inheritDamYearBirthTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var inheritDamYearBirthHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var inheritExpandBtnOutlet: UIButton!
    @IBOutlet weak var inheritBreedDropDown: UIImageView!
    @IBOutlet weak var damRegAssoHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var damRegAssoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var damRegNumberHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var damRegNumberTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var sireRegAssoHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sireRegAssoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var sireRegNumberHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sireRegNumberTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var animalNameHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var animalNameTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var breedAssocationHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var breedAssocationTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var breedRegNumberHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var breedRegNumberTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var breedBtnHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var breedBtnTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var dobHeighConstraint: NSLayoutConstraint!
    @IBOutlet weak var tissueHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var maleFemailHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var expanBtnOutlet: UIButton!
    @IBOutlet weak var globalTissueDropDownArroe: UIImageView!
    @IBOutlet weak var globalBreedDropDownArroe: UIImageView!
    @IBOutlet weak var globalBreedAssDropDownArroe: UIImageView!
    @IBOutlet weak var globalsireREgDropDownArroe: UIImageView!
    @IBOutlet weak var globalDamRegDropDownArroe: UIImageView!
    @IBOutlet weak var inheritDateTextField: UITextField!
    @IBOutlet weak var globalDateTextField: UITextField!
    @IBOutlet weak var ocrBtnOutlet: UIButton!
    @IBOutlet weak var globalOcrBtnOutlet: UIButton!
    @IBOutlet weak var appStatusLbl: UILabel!
    @IBOutlet weak var orderingTitleLbl: UILabel!
    @IBOutlet weak var inheritbarcodeBttn: UIButton!
    @IBOutlet weak var barcodeBtn: UIButton!
    @IBOutlet weak var inheritDobLbl: UILabel!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var scanEarTagTextField: UITextField!
    @IBOutlet weak var continueBttn: UIButton!
    @IBOutlet weak var inheritAddBttn: UIButton!
    @IBOutlet weak var inheritContinueBttn: UIButton!
    @IBOutlet weak var addbttn: UIButton!
    @IBOutlet weak var scanBarcodeTextfield: UITextField!
    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var countLbl: UIButton!
    @IBOutlet weak var notificationLblCount: UILabel!
    @IBOutlet weak var inheritTissueHideLbl: UILabel!
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var calenderbkg: UIView!
    @IBOutlet weak var damRegLbl: UILabel!
    @IBOutlet weak var sireRegLbl: UILabel!
    @IBOutlet weak var breedLbl: UILabel!
    @IBOutlet weak var earTagView: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var breedRegTextfield: UITextField!
    @IBOutlet weak var dateBttnOutlet: UIButton!
    @IBOutlet weak var breedBtnOutlet: customButton!
    @IBOutlet weak var male_femaleBttnOutlet: UIButton!
    @IBOutlet weak var tissueBttnOutlet: customButton!
    @IBOutlet weak var tissueLbl: UILabel!
    @IBOutlet weak var inheritScrollView: UIScrollView!
    @IBOutlet weak var inheritRegistrationLbl: UILabel!
    @IBOutlet weak var breedRegLbl: UILabel!
    @IBOutlet weak var NetworkStatusLbl: UILabel!
    @IBOutlet weak var offLineBtn: UIButton!
    @IBOutlet weak var networkStatusImg: UIImageView!
    @IBOutlet weak var breedRegBttn: UIButton!
    @IBOutlet weak var inheritBreedLbl: UILabel!
    @IBOutlet weak var scrollInnerView: UIView!
    @IBOutlet weak var animalNameTextfield: UITextField!
    @IBOutlet weak var sireRegDropdownOutlet: customButton!
    @IBOutlet weak var damRegDropdownOutlet: customButton!
    @IBOutlet weak var sireRegTextfield: UITextField!
    @IBOutlet weak var barcodeView: UIView!
    @IBOutlet weak var damRegTextfield: UITextField!
    @IBOutlet weak var inheritEarTagView: UIView!
    @IBOutlet weak var inheritBarcodeView: UIView!
    @IBOutlet weak var inheritBarcodeTextfield: UITextField!
    @IBOutlet weak var inheritEarTagTextfield: UITextField!
    @IBOutlet weak var inheritTissueBttn: customButton!
    @IBOutlet weak var inheritEIDTextfield: UITextField!
    @IBOutlet weak var inheritSecondaryIdTextfield: UITextField!
    @IBOutlet weak var inheritBreedBttn: customButton!
    @IBOutlet weak var inheritDobBttn: UIButton!
    @IBOutlet weak var inheritMaleFemaleBttn: UIButton!
    @IBOutlet weak var inheritBreedRegTextfield: UITextField!
    @IBOutlet weak var inheritRegAssociationBttn: customButton!
    @IBOutlet weak var inheritDamYobBttn: UITextField!
    @IBOutlet weak var inheritDamIdTextfield: UITextField!
    @IBOutlet weak var inheritSireRegTextfield: UITextField!
    @IBOutlet weak var inheritSireYobBttn: UITextField!
    @IBOutlet weak var inheritAddBttnView: UIView!
    @IBOutlet weak var inheritDObView: UIView!
    @IBOutlet weak var incrementalBarcodeCheckBoxInherit: UIImageView!
    @IBOutlet weak var incrementalBarcodeTitleLabelInherit: UILabel!
    @IBOutlet weak var incrementalBarcodeButtonInherit: UIButton!
    @IBOutlet weak var incrementalBarcodeCheckBoxGlobal: UIImageView!
    @IBOutlet weak var incrementalBarcodeTitleLabelGlobal: UILabel!
    @IBOutlet weak var incrementalBarcodeButtonGlobal: UIButton!
    @IBOutlet weak var pairedTableView: UITableView!
    @IBOutlet weak var pairedDeviceView: UIView!
    @IBOutlet weak var pairedBackroundView: UIView!
    @IBOutlet weak var pairedDeviceTitle: UILabel!
    @IBOutlet weak var globalClearFormOutlet: UIButton!
    @IBOutlet weak var inheritClearFormOutlet: UIButton!
    @IBOutlet weak var inheritResetIconImage: UIImageView!
    @IBOutlet weak var inheriSireRedOutlet: customButton!
    @IBOutlet weak var inheritRegHideLbl: UILabel!
    @IBOutlet weak var inheritSireRegdropdownImg: UIImageView!
    @IBOutlet weak var inheritEIDView: UIView!
    
    // MARK: - VARIABLES AND CONSTANTS
    var isAnimalComingFromCart = Bool()
    var autoPopulateAnimalData : DataEntryBeefAnimaladdTbl?
    let beefPvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
    let tapRec = UITapGestureRecognizer()
    var listIdGet = Int()
    var listName = String()
    var request = VNRecognizeTextRequest(completionHandler: nil)
    var validateDateFlag = true
    var attrs : [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.blue,.underlineStyle: NSUnderlineStyle.single.rawValue]
    var checkBarcode = Bool()
    var barAutoPopu =  false
    var timeStampString = String()
    var lblTimeStamp = String()
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
    var animalIdBool = Bool()
    let buttonbg2 = UIButton ()
    var breedArr = NSArray()
    var breedRegArr = NSArray()
    var breedId = String()
    var tissuId = Int()
    var animalId1 = Int()
    var inheritAnimalId1 = Int()
    var tissueArr = NSArray()
    var btnTag = Int()
    var pid : GetProductTblBeef?
    var identify = Bool()
    var identify1 = Bool()
    var msgcheckk  = Bool()
    var isautoPopulated = false
    var ocrFound = false
    var statusOrder = Bool()
    var updateOrder = Bool()
    var editIngText = Bool()
    var autoD = Int()
    var editAid = Int()
    var messageCheck = Bool()
    var msgAnimalSucess = Bool()
    var yearPublic = Calendar.current.component(.year, from: Date())
    var barcodeflag = Bool()
    var datePicker : UIDatePicker!
    var selectedDate = Date()
    var InheritSelectedDate = Date()
    var InheritSireSelectedDate = Date()
    var InheritDamSelectedDate = Date()
    let toolBar = UIToolbar()
    var droperTableView  = UITableView ()
    var genderString = String()
    var inheritGenderString = String()
    var genderToggleFlag : Int = 0
    var inheritGenderToggleFlag : Int = 0
    var sireRegArr = NSArray()
    var damRegArr = NSArray()
    var inheritBreedArr = NSArray()
    var inheritTissueArr = NSArray()
    var inheritRegArr = NSArray()
    var addContiuneBtn = Int()
    var userId = Int()
    var orderId = Int()
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    var custmerId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
    var incrementalBarCode = ""
    var isBarcodeAutoIncrementedEnabled = false
    let langCode : String = UserDefaults.standard.object(forKey: keyValue.lngCode.rawValue) as! String
    var defaltscreen = String()
    var arrNearbyDevice : [CBPeripheral] = [] {
        didSet{
            pairedTableView?.reloadData()
        }
    }
    var heartBeatViewModel:HeartBeatViewModel?
    var methReturn = String()
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    var barcodeEnable = Bool()
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIOnDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUIOnWillAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.defaultIncrementalBarCodeSetting_Inherit()
        self.defaultIncrementalBarCodeSetting_Global()
        removeObserver()
    }
    
    override func viewDidLayoutSubviews() {
        let lastView : UIView! = inheritScrollView.subviews[0].subviews.last!
        let height = lastView.frame.size.height
        let pos = lastView.frame.origin.y
        let sizeOfContent = height + pos + 20
        inheritScrollView.contentSize.height = sizeOfContent
    }
    
    // MARK: - METHODS AND FUNCTIONS
    func defaultIncrementalBarCodeSetting_Inherit() {
        incrementalBarcodeCheckBoxInherit.image = UIImage(named: ImageNames.incrementalCheckImg)
        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
        incrementalBarcodeTitleLabelInherit.text = NSLocalizedString(ButtonTitles.incrementalBarcodeText, comment: "")
    }
    
    func defaultIncrementalBarCodeSetting_Global() {
        UserDefaults.standard.set(nil, forKey: keyValue.barcodeIncremental.rawValue)
        incrementalBarcodeCheckBoxGlobal.image = UIImage(named: ImageNames.incrementalCheckImg)
        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
        incrementalBarcodeTitleLabelGlobal.text = NSLocalizedString(ButtonTitles.incrementalBarcodeText, comment: "")
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification , object: nil)
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
    
    func dataPopulateInScreen(animalId:Int){
        isautoPopulated = true
        barAutoPopu = true
        var animalFetch = NSArray()
        if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
            if animalIdBool  {
                animalFetch = fetchAllDataWithAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId: animalId, customerID: custmerId)
                let data = animalFetch.object(at: 0) as! DataEntryBeefAnimaladdTbl
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                animalId1 = Int(data.animalId)
                let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                if dataFetch.count == 0 {
                    scanBarcodeTextfield.text = ""
                    incrementalBarcodeTitleLabelGlobal.textColor = .black
                    incrementalBarcodeTitleLabelGlobal.alpha = 1
                    incrementalBarcodeCheckBoxGlobal.alpha = 1
                    self.isBarcodeAutoIncrementedEnabled = false
                    incrementalBarcodeButtonGlobal.isEnabled = true
                    incrementalBarcodeCheckBoxGlobal.image = UIImage(named: ImageNames.incrementalCheckImg)
                }
                else {
                    if data.orderstatus == "true"{
                        checkBarcode = false
                        incrementalBarcodeTitleLabelGlobal.textColor = .black
                        incrementalBarcodeButtonGlobal.isEnabled = true
                        incrementalBarcodeTitleLabelGlobal.alpha = 1
                        incrementalBarcodeCheckBoxGlobal.alpha = 1
                    }
                    else{
                        scanBarcodeTextfield.text = data.animalbarCodeTag
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                        self.isBarcodeAutoIncrementedEnabled = false
                        incrementalBarcodeCheckBoxGlobal.image = UIImage(named: ImageNames.incrementalCheckImg)
                        incrementalBarcodeButtonGlobal.isEnabled = false
                        incrementalBarcodeTitleLabelGlobal.textColor = .gray
                        checkBarcode = false
                        incrementalBarcodeTitleLabelGlobal.alpha = 0.6
                        incrementalBarcodeCheckBoxGlobal.alpha = 0.6
                    }
                }
                
                earTagView.layer.borderColor = UIColor.gray.cgColor
                barcodeView.layer.borderColor = UIColor.gray.cgColor
                damRegTextfield.layer.borderColor = UIColor.gray.cgColor
                breedRegTextfield.layer.borderColor = UIColor.gray.cgColor
                animalNameTextfield.layer.borderColor = UIColor.gray.cgColor
                sireRegTextfield.layer.borderColor = UIColor.gray.cgColor
                dateBttnOutlet.titleLabel?.text = ""
                
                let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
                let formatter = DateFormatter()
                if data.date != "" {
                    if dateStr == "MM"{
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        if values.count > 1{
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = month + "/" + date + "/" + year
                            yearPublic = Int(year)!
                            
                        }
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            globalDateTextField.text = dateVale
                        } else {
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
                        }
                        formatter.dateFormat = DateFormatters.MMddyyyyFormat
                    }
                    else {
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        if values.count > 1{
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = date + "/" + month + "/" + year
                            yearPublic = Int(year)!
                            
                        }
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            globalDateTextField.text = dateVale
                        } else {
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
                        }
                        formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                    }
                    
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String != keyValue.defaultEntry.rawValue {
                        if dateBttnOutlet.titleLabel!.text != nil {
                            self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                        }
                    }
                }
                scanEarTagTextField.text = data.animalTag
                scanBarcodeTextfield.text = data.animalbarCodeTag
                breedRegTextfield.text = data.offPermanentId
                sireRegTextfield.text = data.offsireId
                damRegTextfield.text = data.offDamId
                animalNameTextfield.text  = data.eT
                if data.breedName == LocalizedStrings.breedNameX{
                    breedBtnOutlet.setTitle("XX", for: .normal)
                } else {
                    breedBtnOutlet.setTitle(data.breedName, for: .normal)
                }
                breedBtnOutlet.setTitle(data.breedName, for: .normal)
                tissueBttnOutlet.setTitleColor(.black, for: .normal)
                breedBtnOutlet.setTitleColor(.black, for: .normal)
                tissueBttnOutlet.setTitle(data.tissuName, for: .normal)
                UserDefaults.standard.set(data.tissuName, forKey: keyValue.dataEntryBeeftsu.rawValue)
                breedRegBttn.setTitle(data.farmId, for: .normal)
                breedRegBttn.setTitleColor(.black, for: .normal)
                
                if data.sireIDAU != ""{
                    sireRegDropdownOutlet.setTitle(data.sireIDAU, for: .normal)
                    sireRegDropdownOutlet.setTitleColor(.black, for: .normal)
                }
                else {
                    sireRegDropdownOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectSireReg, comment: ""), for: .normal)
                }
                
                if data.nationHerdAU != ""{
                    damRegDropdownOutlet.setTitle(data.nationHerdAU, for: .normal)
                    damRegDropdownOutlet.setTitleColor(.black, for: .normal)
                }
                else {
                    damRegDropdownOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectDamReg, comment: ""), for: .normal)
                }
                sireRegDropdownOutlet.setTitleColor(.black, for: .normal)
                damRegDropdownOutlet.setTitleColor(.black, for: .normal)
                breedRegBttn.backgroundColor = .white
                sireRegDropdownOutlet.backgroundColor = .white
                damRegDropdownOutlet.backgroundColor = .white
                breedId = data.breedId!
                UserDefaults.standard.set(data.breedName, forKey: keyValue.dataEntryBeefbreed.rawValue)
                
                if data.gender == ButtonTitles.maleText.localized || data.gender == "M"{
                    self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 1
                    genderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
                }
                else {
                    self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 0
                    genderString = ButtonTitles.femaleText.localized
                }
                
                tissuId = Int(data.tissuId)
                dateBttnOutlet.setTitleColor(.black, for: .normal)
                let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId ?? "",animalTag:data.animalTag ?? "",barcodeTag:data.animalbarCodeTag ?? "")
                animalIdBool = false
                if adata.count > 0{
                    let animal  = adata.object(at: 0) as! BeefAnimalMaster
                    idAnimal = Int(animal.animalId)
                }
            }
            else {
                animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal, customerID: custmerId)
                if animalFetch.count > 0 {
                    let  data = animalFetch.object(at: 0) as! BeefAnimalMaster
                    let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                    animalId1 = Int(data.animalId)
                    earTagView.layer.borderColor = UIColor.gray.cgColor
                    barcodeView.layer.borderColor = UIColor.gray.cgColor
                    damRegTextfield.layer.borderColor = UIColor.gray.cgColor
                    breedRegTextfield.layer.borderColor = UIColor.gray.cgColor
                    animalNameTextfield.layer.borderColor = UIColor.gray.cgColor
                    sireRegTextfield.layer.borderColor = UIColor.gray.cgColor
                    dateBttnOutlet.titleLabel?.text = ""
                    let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
                    let formatter = DateFormatter()
                    if data.date != "" {
                        
                        if dateStr == "MM"{
                            var dateVale = ""
                            let values = data.date!.components(separatedBy: "/")
                            if values.count > 1{
                                let date = values[0]
                                let month = values[1]
                                let year = values[2]
                                dateVale = month + "/" + date + "/" + year
                                yearPublic = Int(year)!
                                
                            }
                            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                                globalDateTextField.text = dateVale
                            } else {
                                dateBttnOutlet.setTitle(dateVale, for: .normal)
                            }
                            formatter.dateFormat = DateFormatters.MMddyyyyFormat
                        }
                        else {
                            var dateVale = ""
                            let values = data.date!.components(separatedBy: "/")
                            if values.count > 1{
                                let date = values[0]
                                let month = values[1]
                                let year = values[2]
                                dateVale = date + "/" + month + "/" + year
                                yearPublic = Int(year)!
                                
                            }
                            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                                globalDateTextField.text = dateVale
                            } else {
                                dateBttnOutlet.setTitle(dateVale, for: .normal)
                            }
                            formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                        }
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String != keyValue.defaultEntry.rawValue {
                            if dateBttnOutlet.titleLabel!.text != nil {
                                self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                            }
                        }
                    }
                    scanEarTagTextField.text = data.animalTag
                    scanBarcodeTextfield.text = data.animalbarCodeTag
                    breedRegTextfield.text = data.offPermanentId
                    sireRegTextfield.text = data.offsireId
                    damRegTextfield.text = data.offDamId
                    if data.breedName == LocalizedStrings.breedNameX{
                        breedBtnOutlet.setTitle("XX", for: .normal)
                    } else {
                        breedBtnOutlet.setTitle(data.breedName, for: .normal)
                    }
                    breedBtnOutlet.setTitle(data.breedName, for: .normal)
                    tissueBttnOutlet.setTitleColor(.black, for: .normal)
                    breedBtnOutlet.setTitleColor(.black, for: .normal)
                    tissueBttnOutlet.setTitle(data.tissuName, for: .normal)
                    UserDefaults.standard.set(data.tissuName, forKey: keyValue.dataEntryBeeftsu.rawValue)
                    breedRegBttn.setTitle(data.farmId, for: .normal)
                    breedRegBttn.setTitleColor(.black, for: .normal)
                    sireRegDropdownOutlet.setTitleColor(.black, for: .normal)
                    
                    if data.sireIDAU != ""{
                        sireRegDropdownOutlet.setTitle(data.sireIDAU, for: .normal)
                        sireRegDropdownOutlet.setTitleColor(.black, for: .normal)
                    }
                    else {
                        sireRegDropdownOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectSireReg, comment: ""), for: .normal)
                    }
                    
                    if data.nationHerdAU != ""{
                        damRegDropdownOutlet.setTitle(data.nationHerdAU, for: .normal)
                        damRegDropdownOutlet.setTitleColor(.black, for: .normal)
                    }
                    else {
                        damRegDropdownOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectDamReg, comment: ""), for: .normal)
                    }
                    
                    damRegDropdownOutlet.setTitleColor(.black, for: .normal)
                    breedRegBttn.backgroundColor = .white
                    sireRegDropdownOutlet.backgroundColor = .white
                    damRegDropdownOutlet.backgroundColor = .white
                    breedId = data.breedId!
                    UserDefaults.standard.set(data.breedName, forKey: keyValue.dataEntryBeefbreed.rawValue)
                    if data.gender == ButtonTitles.maleText.localized || data.gender == "M"{
                        self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                        genderToggleFlag = 1
                        genderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
                    }
                    else {
                        self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                        genderToggleFlag = 0
                        genderString = ButtonTitles.femaleText.localized
                        
                    }
                    
                    tissuId = Int(data.tissuId)
                    dateBttnOutlet.setTitleColor(.black, for: .normal)
                    let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId ?? "",animalTag:data.animalTag ?? "",barcodeTag:data.animalbarCodeTag ?? "")
                    animalIdBool = false
                    if adata.count > 0{
                        let animal  = adata.object(at: 0) as! BeefAnimalMaster
                        idAnimal = Int(animal.animalId)
                        statusOrder = true
                    }
                }
            }
        }
        else{
            inherittextFieldBackroungWhite()
            if animalIdBool {
                animalFetch = fetchAllDataWithAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId: animalId, customerID: custmerId)
                let data = animalFetch.object(at: 0) as! DataEntryBeefAnimaladdTbl
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                animalId1 = Int(data.animalId)
                inheritEarTagView.layer.borderColor = UIColor.gray.cgColor
                inheritBarcodeView.layer.borderColor = UIColor.gray.cgColor
                inheritDamIdTextfield.layer.borderColor = UIColor.gray.cgColor
                inheritBreedRegTextfield.layer.borderColor = UIColor.gray.cgColor
                inheritSireRegTextfield.layer.borderColor = UIColor.gray.cgColor
                let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
                let formatter = DateFormatter()
                if data.date != "" {
                    if dateStr == "MM"{
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        if values.count > 1{
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = month + "/" + date + "/" + year
                            yearPublic = Int(year)!
                        }
                        
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            inheritDateTextField.text = dateVale
                        } else {
                            inheritDobBttn.setTitle(dateVale, for: .normal)
                        }
                        formatter.dateFormat = DateFormatters.MMddyyyyFormat
                    }
                    else {
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        if values.count > 1{
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = date + "/" + month + "/" + year
                            yearPublic = Int(year)!
                            
                        }
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            inheritDateTextField.text = dateVale
                        } else {
                            inheritDobBttn.setTitle(dateVale, for: .normal)
                        }
                        formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                    }
                    
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String != keyValue.defaultEntry.rawValue {
                        if inheritDobBttn.titleLabel!.text == nil {
                            self.InheritSelectedDate = Date()
                        }
                        else{
                            self.InheritSelectedDate = formatter.date(from: inheritDobBttn.titleLabel!.text!)!
                        }
                    }
                }
                inheritEIDTextfield.text = data.sireIDAU
                inheritSecondaryIdTextfield.text = data.nationHerdAU
                inheritEarTagTextfield.text = data.animalTag
                inheritBarcodeTextfield.text = data.animalbarCodeTag
                inheritBreedRegTextfield.text = data.offPermanentId
                inheritSireRegTextfield.text = data.offsireId
                inheritDamIdTextfield.text = data.offDamId
                if data.breedName == LocalizedStrings.breedNameX{
                    inheritBreedBttn.setTitle("XX", for: .normal)
                } else {
                    inheritBreedBttn.setTitle(data.breedName, for: .normal)
                }
                if data.sireYOB == "0" {
                    inheritSireYobBttn.text = ""
                } else {
                    inheritSireYobBttn.text = data.sireYOB
                }
                
                if data.damYOB == "0" {
                    inheritDamYobBttn.text = ""
                } else {
                    inheritDamYobBttn.text = data.damYOB
                }
                
                inheriSireRedOutlet.setTitle(data.sireRegAssocation, for: .normal)
                inheritTissueBttn.setTitleColor(.black, for: .normal)
                inheritTissueBttn.setTitle(data.tissuName?.localized, for: .normal)
                UserDefaults.standard.set(data.tissuName?.localized, forKey: keyValue.dataEntryBeefInheritTsu.rawValue)
                
                let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                if dataFetch.count == 0 {
                    inheritBarcodeTextfield.text = ""
                    incrementalBarcodeTitleLabelInherit.textColor = .black
                    incrementalBarcodeTitleLabelInherit.alpha = 1
                    incrementalBarcodeCheckBoxInherit.alpha = 1
                    self.isBarcodeAutoIncrementedEnabled = false
                    incrementalBarcodeButtonInherit.isEnabled = true
                    incrementalBarcodeCheckBoxInherit.image = UIImage(named: ImageNames.incrementalCheckImg)
                }
                else {
                    if data.orderstatus == "true"{
                        checkBarcode = false
                        incrementalBarcodeTitleLabelInherit.textColor = .black
                        incrementalBarcodeButtonInherit.isEnabled = true
                        incrementalBarcodeTitleLabelInherit.alpha = 1
                        incrementalBarcodeCheckBoxInherit.alpha = 1
                    }
                    else {
                        inheritBarcodeTextfield.text = data.animalbarCodeTag
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                        self.isBarcodeAutoIncrementedEnabled = false
                        incrementalBarcodeCheckBoxInherit.image = UIImage(named: ImageNames.incrementalCheckImg)
                        incrementalBarcodeButtonInherit.isEnabled = false
                        incrementalBarcodeTitleLabelInherit.textColor = .gray
                        checkBarcode = false
                        incrementalBarcodeTitleLabelInherit.alpha = 0.6
                        incrementalBarcodeCheckBoxInherit.alpha = 0.6
                    }
                }
                
                inheritRegAssociationBttn.setTitle(data.eT, for: .normal)
                breedId = data.breedId!
                UserDefaults.standard.set(data.breedName, forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
                
                if data.gender == ButtonTitles.maleText.localized || data.gender == "M"{
                    self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                    inheritGenderToggleFlag = 1
                    inheritGenderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
                }
                else {
                    self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    inheritGenderToggleFlag = 0
                    inheritGenderString = ButtonTitles.femaleText.localized
                }
                
                if data.eT == "" || data.eT == nil {
                    inheritRegAssociationBttn.setTitle(NSLocalizedString(LocalizedStrings.selectBreedAssc, comment: ""), for: .normal)
                }
                if data.sireRegAssocation == nil || data.sireRegAssocation == "" {
                    inheriSireRedOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectSireReg, comment: ""), for: .normal)
                }
                
                tissuId = Int(data.tissuId)
                inheritDobBttn.setTitleColor(.black, for: .normal)
                let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag ?? "",barcodeTag:data.animalbarCodeTag!)
                animalIdBool = false
                if adata.count > 0{
                    let animal  = adata.object(at: 0) as! BeefAnimalMaster
                    idAnimal = Int(animal.animalId)
                }
            }
            else {
                animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal, customerID: custmerId)
                if animalFetch.count > 0 {
                    let  data = animalFetch.object(at: 0) as! BeefAnimalMaster
                    let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                    animalId1 = Int(data.animalId)
                    inheritEarTagView.layer.borderColor = UIColor.gray.cgColor
                    inheritBarcodeView.layer.borderColor = UIColor.gray.cgColor
                    inheritDamIdTextfield.layer.borderColor = UIColor.gray.cgColor
                    inheritBreedRegTextfield.layer.borderColor = UIColor.gray.cgColor
                    inheritSireRegTextfield.layer.borderColor = UIColor.gray.cgColor
                    let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
                    let formatter = DateFormatter()
                    if data.date != "" {
                        
                        if dateStr == "MM"{
                            var dateVale = ""
                            let values = data.date!.components(separatedBy: "/")
                            if values.count > 1{
                                let date = values[0]
                                let month = values[1]
                                let year = values[2]
                                dateVale = month + "/" + date + "/" + year
                                yearPublic = Int(year)!
                            }
                            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                                inheritDateTextField.text = dateVale
                            } else {
                                inheritDobBttn.setTitle(dateVale, for: .normal)
                            }
                            formatter.dateFormat = DateFormatters.MMddyyyyFormat
                        }
                        else {
                            var dateVale = ""
                            let values = data.date!.components(separatedBy: "/")
                            if values.count > 1{
                                let date = values[0]
                                let month = values[1]
                                let year = values[2]
                                dateVale = date + "/" + month + "/" + year
                                yearPublic = Int(year)!
                                
                            }
                            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                                inheritDateTextField.text = dateVale
                            } else {
                                inheritDobBttn.setTitle(dateVale, for: .normal)
                            }
                            formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                        }
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            
                        }else {
                            if inheritDobBttn.titleLabel!.text == nil {
                                self.InheritSelectedDate = Date()
                            }
                            else{
                                self.InheritSelectedDate = formatter.date(from: inheritDobBttn.titleLabel!.text!)!
                            }
                        }
                    }
                    inheritEIDTextfield.text = data.sireIDAU
                    inheritSecondaryIdTextfield.text = data.nationHerdAU
                    inheritEarTagTextfield.text = data.animalTag
                    inheritBarcodeTextfield.text = data.animalbarCodeTag
                    inheritBreedRegTextfield.text = data.offPermanentId
                    inheritSireRegTextfield.text = data.offsireId
                    inheritDamIdTextfield.text = data.offDamId
                    if data.breedName == LocalizedStrings.breedNameX{
                        inheritBreedBttn.setTitle("XX", for: .normal)
                    } else {
                        inheritBreedBttn.setTitle(data.breedName, for: .normal)
                    }
                    if data.sireYOB == "0" {
                        inheritSireYobBttn.text = ""
                    }
                    else {
                        inheritSireYobBttn.text = data.sireYOB
                    }
                    
                    if data.damYOB == "0" {
                        inheritDamYobBttn.text = ""
                    }
                    else {
                        inheritDamYobBttn.text = data.damYOB
                    }
                    
                    inheriSireRedOutlet.setTitle(data.sireRegAssocation, for: .normal)
                    inheritTissueBttn.setTitleColor(.black, for: .normal)
                    inheritBreedBttn.setTitleColor(.black, for: .normal)
                    inheritTissueBttn.setTitle(data.tissuName?.localized, for: .normal)
                    UserDefaults.standard.set(data.tissuName?.localized, forKey: keyValue.dataEntryBeefInheritTsu.rawValue)
                    breedId = data.breedId!
                    UserDefaults.standard.set(data.breedName, forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
                    inheritRegAssociationBttn.setTitle(data.eT, for: .normal)
                    if data.gender == ButtonTitles.maleText.localized || data.gender == "M"{
                        self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                        inheritGenderToggleFlag = 1
                        inheritGenderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
                    }
                    else {
                        self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                        inheritGenderToggleFlag = 0
                        inheritGenderString = ButtonTitles.femaleText.localized
                        
                    }
                    tissuId = Int(data.tissuId)
                    inheritDobBttn.setTitleColor(.black, for: .normal)
                    let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
                    animalIdBool = false
                    if data.eT == "" || data.eT == nil {
                        inheritRegAssociationBttn.setTitle(NSLocalizedString(LocalizedStrings.selectBreedAssc, comment: ""), for: .normal)
                    }
                    if data.sireRegAssocation == nil || data.sireRegAssocation == "" {
                        inheriSireRedOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectSireReg, comment: ""), for: .normal)
                    }
                    if adata.count > 0{
                        let animal  = adata.object(at: 0) as! BeefAnimalMaster
                        idAnimal = Int(animal.animalId)
                        statusOrder = true
                    }
                }
            }
        }
    }
    
    func isValidDate(dateString: String) -> String {
        let dateFormatterGet = DateFormatter()
        let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        if dateStr == "MM"{
            dateFormatterGet.dateFormat = DateFormatters.MMddyyyyFormat
        }
        else {
            dateFormatterGet.dateFormat = DateFormatters.ddMMyyyyFormat
        }
        if let dateGet = dateFormatterGet.date(from: dateString) {
            let smallDate = dateGet.isSmallerThan(Date())
            print(smallDate)
            if !smallDate  {
                return LocalizedStrings.greaterThenDateStr
            }
            return LocalizedStrings.correctFormatStr
        }
        else {
            return  LocalizedStrings.invalidFormatStr
        }
    }
    
    func doDatePicker(){
        self.datePicker = UIDatePicker(frame:CGRect(x: 20, y: 40, width: self.calenderView.frame.size.width, height: 260))
        self.datePicker?.backgroundColor = UIColor.white
        if langId == 2
        {
            self.datePicker?.locale = Locale(identifier: Languages.portuguese)
        }
        else if langId == 3
        {
            self.datePicker?.locale = Locale(identifier: Languages.italian)
        }
        else
        {
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
    
    func landIdApplangaugeConversion(langid:Int){
        inheritEarTagTextfield.placeholder = NSLocalizedString(ButtonTitles.earTagText, comment: "")
        scanBarcodeTextfield.placeholder = NSLocalizedString(ButtonTitles.insertSampleBarcode, comment: "")
        inheritEIDTextfield.placeholder = NSLocalizedString(ButtonTitles.enterEIDText, comment: "")
        inheritSecondaryIdTextfield.placeholder = NSLocalizedString(ButtonTitles.enterSecondaryId, comment: "")
        dobLbl.text = NSLocalizedString(ButtonTitles.dateOfBirthText, comment: "")
        inheritDobLbl.text = NSLocalizedString(ButtonTitles.dateOfBirthText, comment: "")
        inheritRegAssociationBttn.setTitle( NSLocalizedString(LocalizedStrings.selectBreedAssc, comment: ""),for: .normal)
        inheritBreedRegTextfield.placeholder = NSLocalizedString(ButtonTitles.enterBreedRegNumber, comment: "")
        inheritDamIdTextfield.placeholder = NSLocalizedString(ButtonTitles.enterDamIDText, comment: "")
        inheritSireRegTextfield.placeholder = NSLocalizedString(ButtonTitles.enterSireRegNumber, comment: "")
        inheritBarcodeTextfield.placeholder = NSLocalizedString(ButtonTitles.insertSampleBarcode, comment: "")
        inheritRegAssociationBttn.setTitle(LocalizedStrings.selectBreedAssc, for: .normal)
        inheritSireYobBttn.placeholder = NSLocalizedString(ButtonTitles.SireYOB, comment: "")
        inheritDamYobBttn.placeholder = NSLocalizedString(ButtonTitles.DamYOBText, comment: "")
        inheritAddBttn.setTitle(NSLocalizedString(ButtonTitles.addAnotherAnimalText, comment: ""),for: .normal)
        addbttn.setTitle(NSLocalizedString(ButtonTitles.addAnotherAnimalText, comment: ""),for: .normal)
        continueBttn.setTitle(NSLocalizedString(ButtonTitles.reviewDataText, comment: ""),for: .normal)
        inheritContinueBttn.setTitle(NSLocalizedString(ButtonTitles.reviewDataText, comment: ""),for: .normal)
        scanEarTagTextField.placeholder = NSLocalizedString(ButtonTitles.earTagText, comment: "")
        breedRegTextfield.placeholder = NSLocalizedString(ButtonTitles.enterBreedRegNumber, comment: "")
        breedRegBttn.setTitle(NSLocalizedString(LocalizedStrings.selectBreedAssc, comment: ""), for: .normal)
        animalNameTextfield.placeholder = NSLocalizedString(ButtonTitles.enterAnimalName, comment: "")
        sireRegTextfield.placeholder = NSLocalizedString(ButtonTitles.enterSireRegNumber, comment: "")
        damRegTextfield.placeholder =  NSLocalizedString(ButtonTitles.entireDamRegNumber, comment: "")
        sireRegDropdownOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectSireReg, comment: ""),for: .normal)
        damRegDropdownOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectDamReg, comment: ""),for: .normal)
        appStatusLbl.text = NSLocalizedString(ButtonTitles.appStatusText, comment: "")
        orderingTitleLbl.text = NSLocalizedString(ButtonTitles.addAnimalText, comment: "")
    }
    
    func addAnimalBtn(completionHandler: @escaping CompletionHandler){
        
        if barcodeEnable  {
            let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
            if orederStatus.count > 0 {
                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalAlreadyUsedStr, comment: ""), preferredStyle: .alert)
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId: self.idAnimal, customerID: self.custmerId)
                    self.autoPop(animalData: animalFetch)
                    self.barcodeEnable = false
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                statusOrder = false
                self.scrolView.contentOffset.y = 0.0
                return
            }
        }
        
        let selctionAuProvider = UserDefaults.standard.value(forKey: keyValue.clickAuProvider.rawValue) as? Bool
        if selctionAuProvider == true {
            if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
                if scanEarTagTextField.text == "" || (breedRegTextfield.text != "" && breedRegBttn.titleLabel!.text == NSLocalizedString(LocalizedStrings.selectBreedAssc, comment:  "")) || (sireRegTextfield.text != "" && sireRegDropdownOutlet.titleLabel!.text == NSLocalizedString(LocalizedStrings.selectSireReg, comment: "")) || (damRegTextfield.text != "" && damRegDropdownOutlet.titleLabel!.text == NSLocalizedString(LocalizedStrings.selectDamReg, comment: "")) {
                    self.validation()
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                    completionHandler(false)
                    return
                }
                else {
                    if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
                        addBtnCondtion(completionHandler: { (success) -> Void in
                            completionHandler(true)
                        })
                    }
                }
            }
            else{
                if inheritEarTagTextfield.text == ""{
                    self.inheritValidation()
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                    completionHandler(false)
                    return
                }
                else {
                    if inheritSireRegTextfield.text != ""{
                        if inheriSireRedOutlet.titleLabel?.text != NSLocalizedString(LocalizedStrings.selectSireReg, comment: "") {
                            inheriSireRedOutlet.layer.borderColor = UIColor.gray.cgColor
                        }
                        else {
                            inheriSireRedOutlet.layer.borderColor = UIColor.red.cgColor
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                            return
                        }
                    }
                    
                    if inheritSireYobBttn.text?.count ?? 0 > 0 {
                        let inheritSireYob = Int(inheritSireYobBttn.text ?? "") ?? 0
                        if inheritSireYobBttn.text!.count < 4 {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidYear, comment: ""))
                            inheritSireYobBttn.layer.borderColor = UIColor.red.cgColor
                            return
                        }
                        
                        if inheritSireYob > yearPublic {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.SireYOBSmallerThanYOB, comment: ""))
                            inheritSireYobBttn.layer.borderColor = UIColor.red.cgColor
                            return
                        }
                        else {
                            inheritSireYobBttn.layer.borderColor = UIColor.gray.cgColor
                        }
                    }
                    if inheritDamYobBttn.text?.count ?? 0 > 0 {
                        let inheritDamYob:Int = Int(inheritDamYobBttn.text ?? "") ?? 0
                        if inheritDamYobBttn.text!.count < 4 {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidYear, comment: ""))
                            inheritDamYobBttn.layer.borderColor = UIColor.red.cgColor
                            return
                        }
                        
                        if inheritDamYob > yearPublic {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.DamYOBSmallerThanYOB, comment: ""))
                            inheritDamYobBttn.layer.borderColor = UIColor.red.cgColor
                            return
                        }
                        else {
                            inheritDamYobBttn.layer.borderColor = UIColor.gray.cgColor
                        }
                    }
                    inheritAddBtnCondtion(completionHandler: { (success) -> Void in
                        completionHandler(true)
                    })
                }
            }
        }
        else {
            if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
                if scanEarTagTextField.text == "" || (breedRegTextfield.text != "" && breedRegBttn.titleLabel!.text == NSLocalizedString(LocalizedStrings.selectBreedAssc, comment:  "")) || (sireRegTextfield.text != "" && sireRegDropdownOutlet.titleLabel!.text == NSLocalizedString(LocalizedStrings.selectSireReg, comment: "")) || (damRegTextfield.text != "" && damRegDropdownOutlet.titleLabel!.text == NSLocalizedString(LocalizedStrings.selectDamReg, comment: "")){
                    self.validation()
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                    completionHandler(false)
                    return
                } else {
                    if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
                        addBtnCondtion(completionHandler: { (success) -> Void in
                            if success {
                                completionHandler(true)
                            }
                        })
                    }
                }
            }
            
            else{
                if inheritEarTagTextfield.text == "" {
                    self.inheritValidation()
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                    completionHandler(false)
                    return
                }
                else {
                    if inheritSireRegTextfield.text != ""{
                        if inheriSireRedOutlet.titleLabel?.text != NSLocalizedString(LocalizedStrings.selectSireReg, comment: "") {
                            inheriSireRedOutlet.layer.borderColor = UIColor.gray.cgColor
                        }
                        else {
                            inheriSireRedOutlet.layer.borderColor = UIColor.red.cgColor
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                            return
                        }
                    }
                    
                    if inheritSireYobBttn.text?.count ?? 0 > 0 {
                        let inheritSireYob = Int(inheritSireYobBttn.text ?? "") ?? 0
                        if inheritSireYobBttn.text!.count < 4 {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidYear, comment: ""))
                            inheritSireYobBttn.layer.borderColor = UIColor.red.cgColor
                            return
                        }
                        if inheritSireYob > yearPublic {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.SireYOBSmallerThanYOB, comment: ""))
                            inheritSireYobBttn.layer.borderColor = UIColor.red.cgColor
                            return
                        }
                        else {
                            inheritSireYobBttn.layer.borderColor = UIColor.gray.cgColor
                        }
                    }
                    if inheritDamYobBttn.text?.count ?? 0 > 0 {
                        let inheritDamYob:Int = Int(inheritDamYobBttn.text ?? "") ?? 0
                        if inheritDamYobBttn.text!.count < 4 {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidYear, comment: ""))
                            inheritDamYobBttn.layer.borderColor = UIColor.red.cgColor
                            return
                        }
                        if inheritDamYob > yearPublic {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.DamYOBSmallerThanYOB, comment: ""))
                            inheritDamYobBttn.layer.borderColor = UIColor.red.cgColor
                            return
                        }
                        else {
                            inheritDamYobBttn.layer.borderColor = UIColor.gray.cgColor
                        }
                    }
                    
                    inheritAddBtnCondtion(completionHandler: { (success) -> Void in
                        if success {
                            inheritDobBttn.setTitle("", for: .normal)
                            inheritDobBttn.titleLabel?.text = ""
                            inheritSireYobBttn.layer.borderColor = UIColor.gray.cgColor
                            inheritDamYobBttn.layer.borderColor = UIColor.gray.cgColor
                            
                            completionHandler(true)
                        }
                    })
                }
            }
        }
        if notificationLblCount.text != "0"{
            countLbl.isHidden = false
            notificationLblCount.isHidden = false
        }
    }
    
    func autoPop(animalData:NSArray) {
        
        if animalData.count > 0 {
            isautoPopulated = true
            barAutoPopu = true
            textFieldBackroungWhite()
            updateOrder = true
            let data =  animalData.lastObject as! BeefAnimalMaster
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            animalId1 = Int(data.animalId)
            earTagView.layer.borderColor = UIColor.gray.cgColor
            barcodeView.layer.borderColor = UIColor.gray.cgColor
            let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
            let formatter = DateFormatter()
            dateBttnOutlet.titleLabel?.text = ""
            
            if data.date != "" {
                if dateStr == "MM"{
                    var dateVale = ""
                    let values = data.date!.components(separatedBy: "/")
                    if values.count > 1 {
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        dateVale = month + "/" + date + "/" + year
                        yearPublic = Int(year)!
                        
                    }
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                        globalDateTextField.text = dateVale
                    } else {
                        dateBttnOutlet.setTitle(dateVale, for: .normal)
                    }
                    formatter.dateFormat = DateFormatters.MMddyyyyFormat
                }
                else {
                    var dateVale = ""
                    let values = data.date!.components(separatedBy: "/")
                    if values.count > 1 {
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        dateVale = date + "/" + month + "/" + year
                        yearPublic = Int(year)!
                        
                    }
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                        globalDateTextField.text = dateVale
                    } else {
                        dateBttnOutlet.setTitle(dateVale, for: .normal)
                    }
                    formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                }
                if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String != keyValue.defaultEntry.rawValue {
                    if dateBttnOutlet.titleLabel!.text == nil {
                    }
                    else{
                        self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                    }
                }
            }
            
            scanEarTagTextField.text = data.animalTag
            barcodeflag = false
            breedRegTextfield.text = data.offPermanentId
            sireRegTextfield.text = data.offsireId
            damRegTextfield.text = data.offDamId
            animalNameTextfield.text  = data.eT
            breedBtnOutlet.setTitle(data.breedName, for: .normal)
            tissueBttnOutlet.setTitleColor(.black, for: .normal)
            breedBtnOutlet.setTitleColor(.black, for: .normal)
            tissueBttnOutlet.setTitle(data.tissuName, for: .normal)
            UserDefaults.standard.set(data.tissuName, forKey: keyValue.dataEntryBeeftsu.rawValue)
            
            if data.farmId != ""{
                breedRegBttn.setTitle(data.farmId, for: .normal)
                breedRegBttn.setTitleColor(.black, for: .normal)
            }
            if data.sireIDAU != ""{
                sireRegDropdownOutlet.setTitle(data.sireIDAU, for: .normal)
                sireRegDropdownOutlet.setTitleColor(.black, for: .normal)
            }
            if data.nationHerdAU != ""{
                damRegDropdownOutlet.setTitle(data.nationHerdAU, for: .normal)
                damRegDropdownOutlet.setTitleColor(.black, for: .normal)
            }
            breedRegBttn.backgroundColor = .white
            sireRegDropdownOutlet.backgroundColor = .white
            damRegDropdownOutlet.backgroundColor = .white
            breedId = data.breedId!
            
            UserDefaults.standard.set(data.breedName, forKey: keyValue.dataEntryBeefbreed.rawValue)
            
            if data.gender == ButtonTitles.maleText.localized || data.gender == "M"{
                self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                genderToggleFlag = 1
                genderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
                
            } else {
                self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                genderToggleFlag = 0
                genderString = ButtonTitles.femaleText.localized
                
            }
            
            let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
            if dataFetch.count == 0 {
                incrementalBarcodeTitleLabelGlobal.textColor = .black
                incrementalBarcodeTitleLabelGlobal.alpha = 1
                incrementalBarcodeCheckBoxGlobal.alpha = 1
                incrementalBarcodeButtonGlobal.isEnabled = true
            } else {
                if data.orderstatus == "true"{
                    checkBarcode = false
                    incrementalBarcodeTitleLabelGlobal.textColor = .black
                    incrementalBarcodeButtonGlobal.isEnabled = true
                    incrementalBarcodeTitleLabelGlobal.alpha = 1
                    incrementalBarcodeCheckBoxGlobal.alpha = 1
                } else {
                    scanBarcodeTextfield.text = data.animalbarCodeTag
                    UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                    self.isBarcodeAutoIncrementedEnabled = false
                    incrementalBarcodeCheckBoxGlobal.image = UIImage(named: ImageNames.incrementalCheckImg)
                    incrementalBarcodeButtonGlobal.isEnabled = false
                    incrementalBarcodeTitleLabelGlobal.textColor = .gray
                    checkBarcode = false
                }}
            
            
            tissuId = Int(data.tissuId)
            dateBttnOutlet.setTitleColor(.black, for: .normal)
            statusOrder = false
            messageCheck = false
            let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
            if adata.count > 0{
                let animal  = adata.object(at: 0) as! BeefAnimalMaster
                idAnimal = Int(animal.animalId)
                messageCheck = true
            }
        }
        
        if animalData.count > 0 {
            isautoPopulated = true
            barAutoPopu = true
            inherittextFieldBackroungWhite()
            updateOrder = true
            let data =  animalData.lastObject as! BeefAnimalMaster
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            animalId1 = Int(data.animalId)
            barcodeflag = false
            inheritEarTagView.layer.borderColor = UIColor.gray.cgColor
            inheritBarcodeView.layer.borderColor = UIColor.gray.cgColor
            let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
            let formatter = DateFormatter()
            inheritDobBttn.titleLabel?.text = ""
            
            if data.date != "" {
                
                if dateStr == "MM"{
                    var dateVale = ""
                    let values = data.date!.components(separatedBy: "/")
                    if values.count > 1{
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        dateVale = month + "/" + date + "/" + year
                        yearPublic = Int(year)!
                    }
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                        inheritDateTextField.text = dateVale
                    } else {
                        inheritDobBttn.setTitle(dateVale, for: .normal)
                    }
                    formatter.dateFormat = DateFormatters.MMddyyyyFormat
                }
                else {
                    var dateVale = ""
                    let values = data.date!.components(separatedBy: "/")
                    
                    if values.count > 1{
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        dateVale = date + "/" + month + "/" + year
                        yearPublic = Int(year)!
                        
                    }
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                        inheritDateTextField.text = dateVale
                    } else {
                        inheritDobBttn.setTitle(dateVale, for: .normal)
                    }
                    formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                }}
            
            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String != keyValue.defaultEntry.rawValue {
                if inheritDobBttn.titleLabel!.text == nil {
                    self.InheritSelectedDate = Date()
                }
                else{
                    self.InheritSelectedDate = formatter.date(from: inheritDobBttn.titleLabel!.text!)!
                }
            }
            
            if data.orderstatus == "false"{
                inheritBarcodeTextfield.text = data.animalbarCodeTag
            }
            inheritEarTagTextfield.text = data.animalTag
            inheritBreedRegTextfield.text = data.offPermanentId
            inheritSireRegTextfield.text = data.offsireId
            inheritDamIdTextfield.text = data.offDamId
            inheriSireRedOutlet.setTitle(data.sireRegAssocation, for: .normal)
            inheritBreedBttn.setTitle(data.breedName, for: .normal)
            inheritTissueBttn.setTitleColor(.black, for: .normal)
            inheritBreedBttn.setTitleColor(.black, for: .normal)
            inheritTissueBttn.setTitle(data.tissuName?.localized, for: .normal)
            UserDefaults.standard.set(data.tissuName?.localized, forKey: keyValue.dataEntryBeefInheritTsu.rawValue)
            
            if data.sireYOB == "0" {
                inheritSireYobBttn.text = ""
            } else {
                
                inheritSireYobBttn.text = data.sireYOB
            }
            if data.damYOB == "0" {
                inheritDamYobBttn.text = ""
            } else {
                
                inheritDamYobBttn.text = data.damYOB
            }
            
            breedId = data.breedId!
            UserDefaults.standard.set(data.breedName, forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
            inheritEIDTextfield.text = data.sireIDAU
            inheritSecondaryIdTextfield.text = data.nationHerdAU
            inheritRegAssociationBttn.setTitle(data.eT, for: .normal)
            if data.gender == ButtonTitles.maleText.localized || data.gender == "M"{
                self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                inheritGenderToggleFlag = 1
                inheritGenderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
                
            } else {
                self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                inheritGenderToggleFlag = 0
                inheritGenderString = ButtonTitles.femaleText.localized
                
            }
            
            tissuId = Int(data.tissuId)
            inheritDobBttn.setTitleColor(.black, for: .normal)
            statusOrder = false
            messageCheck = false
            let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
            if adata.count > 0{
                let animal  = adata.object(at: 0) as! BeefAnimalMaster
                idAnimal = Int(animal.animalId)
                messageCheck = true
            }
        }
        
    }
    
    func addBtnCondtion(completionHandler: CompletionHandler){
        if checkBarcode  {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.barcodeMustEndWithNumAlert, comment: ""))
            return
        }
        
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        if  barcodeflag  {
            
            if scanBarcodeTextfield.text != "" {
                let barCode = fetchAnimaldataValidateAnimalBarcodeanimalIdOrderId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalbarCodeTag: scanBarcodeTextfield.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"false",orderid:orderId, custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue) )
                
                if barCode.count > 0   {
                    barcodeView.layer.borderColor = UIColor.red.cgColor
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sampleAlreadyExists, comment: ""))
                    return
                }
            }
        }
        
        let inheritBreed = fetchAllDataProductBeefId(entityName: Entities.getBreedsTblEntity, breedName: (self.breedBtnOutlet.titleLabel?.text!)!, productId: 19)
        if inheritBreed.count != 0 {
            let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
            self.breedId = medbreedRegArr1!.breedId ?? ""
        }
        
        let codeId = fetchBreedDataTissueCode(entityName: Entities.getSampleTblEntity, provId: pvid, tissueName: (tissueBttnOutlet.titleLabel?.text)!)
        
        let naabFetch1 = codeId.value(forKey: keyValue.sampleId.rawValue) as? NSArray
        if naabFetch1!.count == 0 {
            
        } else {
            let tissuId = naabFetch1![0] as? Int
            self.tissuId = tissuId!
        }
        
        if scanBarcodeTextfield.text != "" {
            let animaBarcOde = fetchAnimaldataValidateAnimalBarcodeanimalId(entityName: Entities.beefAnimalMasterTblEntity, animalbarCodeTag: scanBarcodeTextfield.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"true", custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),IsDataEmail: false)
            if animaBarcOde.count > 0  {
                barcodeView.layer.borderColor = UIColor.red.cgColor
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sampleAlreadyExists, comment: ""))
                return
            }
        }
        
        var breedReg = ""
        if breedRegBttn.titleLabel?.text == nil {
            breedReg = ""
        }
        else{
            breedReg = breedRegBttn.titleLabel!.text!
        }
        var sireReg = ""
        if sireRegDropdownOutlet.titleLabel?.text == nil {
            sireReg = ""
        }
        else{
            sireReg = sireRegDropdownOutlet.titleLabel!.text!
        }
        var damReg = ""
        if damRegDropdownOutlet.titleLabel?.text == nil {
            damReg = ""
        }
        else{
            damReg = damRegDropdownOutlet.titleLabel!.text!
        }
        var dateVale = ""
        let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            dateVale = globalDateTextField.text ?? ""
            if dateStr == "DD"{
                dateVale = globalDateTextField.text ?? ""
            }
            else {
                if dateVale != ""{
                    let values = dateVale.components(separatedBy: "/")
                    let date = values[0]
                    let month = values[1]
                    let year = values[2]
                    dateVale = month + "/" + date + "/" + year
                }
            }
        } else {
            dateVale = dateBttnOutlet.titleLabel?.text ?? ""
            if dateStr == "DD"{
                dateVale = dateBttnOutlet.titleLabel?.text ?? ""
            }
            else {
                if dateVale != ""{
                    let values = dateVale.components(separatedBy: "/")
                    let date = values[0]
                    let month = values[1]
                    let year = values[2]
                    dateVale = month + "/" + date + "/" + year
                }
            }
        }
        
        if globalDateTextField.text?.count != 0 {
            if globalDateTextField.text?.count == 10 {
                let validate = isValidDate(dateString: globalDateTextField.text ?? "")
                if validate == LocalizedStrings.correctFormatStr {
                    dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
                    dateBttnOutlet.layer.borderWidth = 0.5
                    validateDateFlag = true
                } else {
                    dateBttnOutlet.layer.borderColor = UIColor.red.cgColor
                    validateDateFlag = false
                    if validate == LocalizedStrings.greaterThenDateStr {
                        
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.dobSmallerthanCurrDate, comment: ""))
                        return
                    } else {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
                        return
                    }
                    
                }
            }
            else {
                dateBttnOutlet.layer.borderColor = UIColor.red.cgColor
                validateDateFlag = false
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
                return
            }
        }
        
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        incrementalBarCode = scanBarcodeTextfield.text ?? ""
        let animalData = fetchAnimaldataValidateAnimalTagDataEntry(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: scanEarTagTextField.text!,listId: listIdGet , custmerId: custmerId )
        
        if animalData.count > 0  {
            isUpdate = true
            updateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalMasterTblEntity, animalTag: scanEarTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "false", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true,territoryGeno: "")
            
            updateOrderStatusISyncAnimalMaster(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: scanEarTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "true", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
            
            let fetchDataUpdate = fetchAnimalDataAccEarTag(entityName: Entities.beefAnimalAddTblEntity,animalTag:scanEarTagTextField.text ?? "",custmerId :Int64(custmerId ),providerid:pvid,productId:19)
            let fetchDataUpdate1 = fetchAnimalDataAccEarTag(entityName: Entities.dataEntryBeefAnimalAddTblEntity,animalTag:scanEarTagTextField.text ?? "",custmerId :Int64(custmerId ),providerid:pvid,productId:19)
            
            if fetchDataUpdate.count != 0 {
                updateOrderInfoBeefGlobal(entity: Entities.beefAnimalAddTblEntity,animalTag: scanEarTagTextField.text ?? "",barCodetag: scanBarcodeTextfield.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,permanentId: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text ?? "",breedName: breedBtnOutlet.titleLabel!.text ?? "",et: animalNameTextfield.text ?? "",farmId: breedReg,orderId: autoD,breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:sireReg,nationHerdAU:damReg,userId:userId,productId:19,custmerId:Int64(custmerId ), editFlagSave: true)
                
                updateOrderInfoBeefGlobal(entity: Entities.beefAnimalMasterTblEntity,animalTag: scanEarTagTextField.text ?? "",barCodetag: scanBarcodeTextfield.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,permanentId: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text ?? "",breedName: breedBtnOutlet.titleLabel!.text ?? "",et: animalNameTextfield.text ?? "",farmId: breedReg,orderId: autoD,breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:sireReg,nationHerdAU:damReg,userId:userId,productId:19,custmerId:Int64(custmerId ), editFlagSave: true)
                
                updateOrderInfoBeefGlobal(entity: Entities.dataEntryBeefAnimalAddTblEntity,animalTag: scanEarTagTextField.text ?? "",barCodetag: scanBarcodeTextfield.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,permanentId: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text ?? "",breedName: breedBtnOutlet.titleLabel!.text ?? "",et: animalNameTextfield.text ?? "",farmId: breedReg,orderId: autoD,breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:sireReg,nationHerdAU:damReg,userId:userId,productId:19,custmerId:Int64(custmerId ), editFlagSave: true)
            }
            
            if fetchDataUpdate1.count != 0 {
                updateOrderInfoBeefGlobal(entity: Entities.beefAnimalMasterTblEntity,animalTag: scanEarTagTextField.text ?? "",barCodetag: scanBarcodeTextfield.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,permanentId: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text ?? "",breedName: breedBtnOutlet.titleLabel!.text ?? "",et: animalNameTextfield.text ?? "",farmId: breedReg,orderId: autoD,breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:sireReg,nationHerdAU:damReg,userId:userId,productId:19,custmerId:Int64(custmerId ), editFlagSave: true)
                
                updateOrderInfoBeefGlobal(entity: Entities.dataEntryBeefAnimalAddTblEntity,animalTag: scanEarTagTextField.text ?? "",barCodetag: scanBarcodeTextfield.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,permanentId: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text ?? "",breedName: breedBtnOutlet.titleLabel!.text ?? "",et: animalNameTextfield.text ?? "",farmId: breedReg,orderId: autoD,breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:sireReg,nationHerdAU:damReg,userId:userId,productId:19,custmerId:Int64(custmerId ), editFlagSave: true)
            }
            
            updateOrderStatusISyncProduct(entity: Entities.productAdonAnimlBeefTblEntity,animalTag: scanEarTagTextField.text!,barCodetag:  scanBarcodeTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId:animalId1)
            updateOrderStatusISyncSubProduct(entity: Entities.subProductBeefTblEntity,animalTag: scanEarTagTextField.text!,barCodetag:  scanBarcodeTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId: animalId1)
            
            let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: "",animalTag:scanEarTagTextField.text!,barcodeTag:scanBarcodeTextfield.text!)
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            
            if adata.count > 0{
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                byDefaultSetting()
            }
            
            else if animalDataMaster.count > 0 {
                if  msgUpatedd {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalRecordUpdated, comment: ""))
                    UserDefaults.standard.setValue(breedBtnOutlet.titleLabel?.text, forKey: keyValue.dataEntryBeefbreedClear.rawValue)
                    UserDefaults.standard.setValue(tissueBttnOutlet.titleLabel?.text, forKey: keyValue.dataEntryBeeftsuClear.rawValue)
                    UserDefaults.standard.set(tissueBttnOutlet.titleLabel?.text, forKey: keyValue.dataEntryBeeftsu.rawValue)
                    UserDefaults.standard.set(breedBtnOutlet.titleLabel?.text, forKey: keyValue.dataEntryBeefbreed.rawValue)
                    
                    byDefaultSetting()
                    
                }
                else{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                    byDefaultSetting()
                }
            }
            editAid = animalId1
            animalId1 = 0
            
            if identify1  {
                let data1 = fetchAllDataOrderStatus(entityName: Entities.dataEntryBeefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
                if data1.count > 0 {
                    completionHandler(true)
                    return
                }
            }
            completionHandler(true)
            scrolView.contentOffset.y = 0.0
        }
        else if isUpdate  {
            animalId1 = editAid
            updateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalMasterTblEntity, animalTag: scanEarTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "false", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
            
            updateOrderStatusISyncAnimalMaster(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: scanEarTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "true", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
            
            if identify1  {
                let data1 = fetchAllDataOrderStatus(entityName: Entities.dataEntryBeefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
                if data1.count > 0 {
                    completionHandler(true)
                    return
                }
            }
            isautoPopulated = false
            let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: "",animalTag:scanEarTagTextField.text!,barcodeTag:scanBarcodeTextfield.text!)
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            
            if adata.count > 0{
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                byDefaultSetting()
            }
            
            else if animalDataMaster.count > 0 {
                if  msgUpatedd {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalRecordUpdated, comment: ""))
                    UserDefaults.standard.setValue(breedBtnOutlet.titleLabel?.text, forKey: keyValue.dataEntryBeefbreedClear.rawValue)
                    UserDefaults.standard.setValue(tissueBttnOutlet.titleLabel?.text, forKey: keyValue.dataEntryBeeftsuClear.rawValue)
                    UserDefaults.standard.set(tissueBttnOutlet.titleLabel?.text, forKey: keyValue.dataEntryBeeftsu.rawValue)
                    UserDefaults.standard.set(breedBtnOutlet.titleLabel?.text, forKey: keyValue.dataEntryBeefbreed.rawValue)
                    byDefaultSetting()
                }
                else{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                    byDefaultSetting()
                }
            }
            completionHandler(true)
            scrolView.contentOffset.y = 0.0
        }
        else {
            isUpdate = false
            let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
            let pid = product[0] as! GetProductTblBeef
            var animalID1 = UserDefaults.standard.integer(forKey: keyValue.animalId.rawValue)
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            if animalDataMaster.count > 0{
                
                if animalID1 == 0 {
                    animalID1 = animalID1 + 1
                    UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                }
                else {
                    animalID1 = animalID1 + 1
                    UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                }
                
                updateOrderStatusISyncAnimalMasterAnimalId(entity: Entities.beefAnimalMasterTblEntity, animalTag: scanEarTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "false", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1,isSyncServer:false, adhDataServer: false, tertiaryGeno: "")
                
                let fetchDataUpdate = fetchAnimalDataAccEarTag(entityName: Entities.beefAnimalAddTblEntity,animalTag:scanEarTagTextField.text ?? "",custmerId :Int64(custmerId ),providerid:pvid,productId:19)
                let fetchDataUpdate1 = fetchAnimalDataAccEarTag(entityName: Entities.dataEntryBeefAnimalAddTblEntity,animalTag:scanEarTagTextField.text ?? "",custmerId :Int64(custmerId ),providerid:pvid,productId:19)
                
                if fetchDataUpdate.count != 0 {
                    updateOrderInfoBeefGlobal(entity: Entities.beefAnimalAddTblEntity,animalTag: scanEarTagTextField.text ?? "",barCodetag: scanBarcodeTextfield.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,permanentId: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text ?? "",breedName: breedBtnOutlet.titleLabel!.text ?? "",et: animalNameTextfield.text ?? "",farmId: breedReg,orderId: autoD,breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:sireReg,nationHerdAU:damReg,userId:userId,productId:19,custmerId:Int64(custmerId ), editFlagSave: true)
                    
                    updateOrderInfoBeefGlobal(entity: Entities.beefAnimalMasterTblEntity,animalTag: scanEarTagTextField.text ?? "",barCodetag: scanBarcodeTextfield.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,permanentId: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text ?? "",breedName: breedBtnOutlet.titleLabel!.text ?? "",et: animalNameTextfield.text ?? "",farmId: breedReg,orderId: autoD,breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:sireReg,nationHerdAU:damReg,userId:userId,productId:19,custmerId:Int64(custmerId ), editFlagSave: true)
                    
                    updateOrderInfoBeefGlobal(entity: Entities.dataEntryBeefAnimalAddTblEntity,animalTag: scanEarTagTextField.text ?? "",barCodetag: scanBarcodeTextfield.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,permanentId: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text ?? "",breedName: breedBtnOutlet.titleLabel!.text ?? "",et: animalNameTextfield.text ?? "",farmId: breedReg,orderId: autoD,breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:sireReg,nationHerdAU:damReg,userId:userId,productId:19,custmerId:Int64(custmerId ), editFlagSave: true)
                }
                
                if fetchDataUpdate1.count != 0 {
                    updateOrderInfoBeefGlobal(entity: Entities.beefAnimalMasterTblEntity,animalTag: scanEarTagTextField.text ?? "",barCodetag: scanBarcodeTextfield.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,permanentId: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text ?? "",breedName: breedBtnOutlet.titleLabel!.text ?? "",et: animalNameTextfield.text ?? "",farmId: breedReg,orderId: autoD,breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:sireReg,nationHerdAU:damReg,userId:userId,productId:19,custmerId:Int64(custmerId ), editFlagSave: true)
                    
                    updateOrderInfoBeefGlobal(entity: Entities.dataEntryBeefAnimalAddTblEntity,animalTag: scanEarTagTextField.text ?? "",barCodetag: scanBarcodeTextfield.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,permanentId: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text ?? "",breedName: breedBtnOutlet.titleLabel!.text ?? "",et: animalNameTextfield.text ?? "",farmId: breedReg,orderId: autoD,breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:sireReg,nationHerdAU:damReg,userId:userId,productId:19,custmerId:Int64(custmerId ), editFlagSave: true)
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
                
                let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"true" )
                
                if animalDataMaster.count > 0{
                    updateOrderStatusISyncAnimalMasterAnimalId(entity: Entities.beefAnimalMasterTblEntity, animalTag: scanEarTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "false", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1,isSyncServer:false, adhDataServer: false, tertiaryGeno: "")
                    updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId,offlineSync:false,listid: listIdGet)
                }
                else {
                    
                    saveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: scanEarTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "false", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString, animalId: animalID1,productId:Int(pid.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listIdGet), serverAnimalId: "", tertiaryGeno: "")
                    updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId,offlineSync:false,listid: listIdGet)
                }
            }
            
            let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:orderId, customerID: custmerId)
            if data12333.count > 0{
                saveAnimaldataBeefInProductId(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: scanEarTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "true", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString, animalId: animalID1,productId:Int(pid.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listIdGet), serverAnimalId: "", tertiaryGeno: "")
                updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId,offlineSync:false,listid: listIdGet)
              
            }
            else {
                saveAnimaldataBeefInProductId(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: scanEarTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "true", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId: breedReg, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: sireReg, nationHerdAU:  damReg, userId: userId,udid:timeStampString, animalId: animalID1,productId:Int(pid.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listIdGet), serverAnimalId: "", tertiaryGeno: "")
                updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId,offlineSync:false,listid: listIdGet)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAdded, comment: ""), duration: 2, position: .bottom)
            }
            
            UserDefaults.standard.setValue(breedBtnOutlet.titleLabel?.text, forKey: keyValue.dataEntryBeefbreedClear.rawValue)
            UserDefaults.standard.setValue(tissueBttnOutlet.titleLabel?.text, forKey: keyValue.dataEntryBeeftsuClear.rawValue)
            UserDefaults.standard.set(tissueBttnOutlet.titleLabel?.text, forKey: keyValue.dataEntryBeeftsu.rawValue)
            UserDefaults.standard.set(breedBtnOutlet.titleLabel?.text, forKey: keyValue.dataEntryBeefbreed.rawValue)
            
            if isBarcodeAutoIncrementedEnabled  {
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
            }
            else {
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
            }
            
            self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            byDefaultSetting()
            textFieldBackroungGrey()
            genderToggleFlag = 0
            genderString = ButtonTitles.femaleText.localized
            barAutoPopu = false
            dateVale = ""
            scanEarTagTextField.text = ""
            scanBarcodeTextfield.text = ""
            
            if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
                let animalCount = beefFetchAllDataWithListId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,orderStatus:"false",pvid :self.beefPvid,listid:Int64(self.listIdGet),custmerId:Int64(self.custmerId))
                notificationLblCount.text = String(animalCount.count)
                if animalCount.count == 0{
                    notificationLblCount.isHidden = true
                    countLbl.isHidden = true
                }else {
                    notificationLblCount.isHidden = false
                    countLbl.isHidden = false
                }
            }
            else {
                let animalCount = beefFetchAllDataWithListId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,orderStatus:"false",pvid :self.beefPvid,listid:Int64(self.listIdGet),custmerId:Int64(self.custmerId))
                notificationLblCount.text = String(animalCount.count)
                if animalCount.count == 0{
                    notificationLblCount.isHidden = true
                    countLbl.isHidden = true
                }
                else {
                    notificationLblCount.isHidden = false
                    countLbl.isHidden = false
                }
            }
            
            let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
            let formatter = DateFormatter()
            if dateStr == "MM"{
                formatter.dateFormat = DateFormatters.MMddyyyyFormat
            }
            else {
                formatter.dateFormat = DateFormatters.ddMMyyyyFormat
            }
            
            inheritDobBttn.setTitle(nil, for: .normal)
            dateBttnOutlet.setTitle(nil, for: .normal)
            dateVale = ""
            dateBttnOutlet.titleLabel?.text = ""
            completionHandler(true)
        }
        
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) {
            UserDefaults.standard.set(incrementalBarCode, forKey: keyValue.barcodeIncremental.rawValue)
        }
        incrementalBarCode = ""
    }
    
    func validation() {
        if scanEarTagTextField.text == ""{
            earTagView.layer.borderColor = UIColor.red.cgColor
        }
        else {
            earTagView.layer.borderColor = UIColor.gray.cgColor
        }
        
        if breedRegTextfield.text == ""{
            breedRegBttn.layer.borderColor = UIColor.gray.cgColor
        }
        else{
            if breedRegBttn.titleLabel?.text != NSLocalizedString(LocalizedStrings.selectBreedAssc, comment:  "") {
                breedRegBttn.layer.borderColor = UIColor.gray.cgColor
            }else{
                breedRegBttn.layer.borderColor = UIColor.red.cgColor
            }
        }
        if sireRegTextfield.text == ""{
            sireRegDropdownOutlet.layer.borderColor = UIColor.gray.cgColor
        }
        else{
            if sireRegDropdownOutlet.titleLabel?.text != NSLocalizedString(LocalizedStrings.selectSireReg, comment: "") {
                sireRegDropdownOutlet.layer.borderColor = UIColor.gray.cgColor
            }else{
                sireRegDropdownOutlet.layer.borderColor = UIColor.red.cgColor
            }
        }
        if damRegTextfield.text == ""{
            damRegDropdownOutlet.layer.borderColor = UIColor.gray.cgColor
        }
        else{
            if damRegDropdownOutlet.titleLabel?.text != NSLocalizedString(LocalizedStrings.selectDamReg, comment: "") {
                damRegDropdownOutlet.layer.borderColor = UIColor.gray.cgColor
            }else{
                damRegDropdownOutlet.layer.borderColor = UIColor.red.cgColor
            }
        }
    }
    
    func statusOrderTrue() -> Bool{
        let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal, customerID: custmerId)
        if animalFetch.count > 0{
            statusOrder = true
            return true
        }else{
            return false
        }
    }
    
    func byDefaultSetting(){
        dobLbl.textColor = UIColor.gray
        inheritDobLbl.textColor = UIColor.gray
        let dateformt = DateFormatter()
        let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        if dateStr == "MM" {
            dateformt.dateFormat = DateFormatters.MMddyyyyFormat
            globalDateTextField.placeholder = DateFormatters.MMDDYYYYFormat
        }
        else {
            dateformt.dateFormat = DateFormatters.ddMMyyyyFormat
            globalDateTextField.placeholder = DateFormatters.DDMMYYYYFormat
        }
        
        expanBtnOutlet.alpha = 0.4
        expanBtnOutlet.isEnabled = false
        inheritExpandBtnOutlet.alpha = 0.4
        inheritExpandBtnOutlet.isEnabled = false
        inheriSireRedOutlet.isEnabled = false
        animalId1 = 0
        idAnimal = 0
        isUpdate = false
        msgUpatedd = false
        self.msgcheckk = false
        barAutoPopu = false
        self.isautoPopulated = false
        dateBttnOutlet.setTitleColor(UIColor.gray, for: .normal)
        breedBtnOutlet.setTitleColor(UIColor.gray, for: .normal)
        dateBttnOutlet.setTitle( "", for: .normal)
        sireRegDropdownOutlet.layer.borderWidth = 0.5
        damRegDropdownOutlet.layer.borderWidth = 0.5
        tissueBttnOutlet.layer.borderWidth = 0.5
        breedBtnOutlet.layer.borderWidth = 0.5
        breedRegBttn.layer.borderWidth = 0.5
        breedRegBttn.layer.borderColor = UIColor.gray.cgColor
        damRegTextfield.layer.borderColor = UIColor.gray.cgColor
        sireRegTextfield.layer.borderColor = UIColor.gray.cgColor
        breedRegTextfield.layer.borderColor = UIColor.gray.cgColor
        animalNameTextfield.layer.borderColor = UIColor.gray.cgColor
        breedBtnOutlet.layer.borderColor = UIColor.gray.cgColor
        dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
        damRegDropdownOutlet.layer.borderColor = UIColor.gray.cgColor
        sireRegDropdownOutlet.layer.borderColor = UIColor.gray.cgColor
        dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
        barcodeView.layer.borderColor = UIColor.gray.cgColor
        earTagView.layer.borderColor = UIColor.gray.cgColor
        scanEarTagTextField.text?.removeAll()
        scanBarcodeTextfield.text?.removeAll()
        damRegTextfield.text?.removeAll()
        sireRegTextfield.text?.removeAll()
        breedRegTextfield.text?.removeAll()
        animalNameTextfield.text?.removeAll()
        self.selectedDate = Date()
        breedBtnOutlet.setTitle(ButtonTitles.ANGText, for: .normal)
        breedRegBttn.setTitle(NSLocalizedString(LocalizedStrings.selectBreedAssc, comment:  "") , for: .normal)
        sireRegDropdownOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectSireReg, comment: ""), for: .normal)
        damRegDropdownOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectDamReg, comment: ""), for: .normal)
        self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
        genderToggleFlag = 0
        genderString = ButtonTitles.femaleText.localized
        
        breedBtnOutlet.setTitleColor(.gray, for: .normal)
        tissueBttnOutlet.setTitleColor(.gray, for: .normal)
        textFieldBackroungGrey()
        self.scrolView.contentOffset.y = 0.0
        if UserDefaults.standard.string(forKey: keyValue.dataEntryBeeftsu.rawValue) == nil{
            self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
            for items in self.tissueArr
            {
                let tissue = items  as? GetSampleTbl
                let checkdefault  = tissue?.isDefault
                
                if checkdefault == true
                {
                    self.tissueBttnOutlet.setTitle(tissue?.sampleName, for: .normal)
                    self.tissuId =  Int(tissue?.sampleId ?? 1)
                }
            }
        }
        else {
            tissueBttnOutlet.setTitle(UserDefaults.standard.string(forKey: keyValue.dataEntryBeeftsu.rawValue), for: .normal)
        }
        
        if UserDefaults.standard.string(forKey: keyValue.dataEntryBeefbreed.rawValue) == nil{
            breedBtnOutlet.setTitle(ButtonTitles.ANGText, for: .normal)
            let inheritBreed = fetchAllDataProductBeefId(entityName: Entities.getBreedsTblEntity, breedName: (breedBtnOutlet.titleLabel?.text!)!, productId: 19)
            if inheritBreed.count != 0 {
                let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                breedId = medbreedRegArr1!.breedId ?? ""
            }
        }
        else{
            breedBtnOutlet.setTitle(UserDefaults.standard.string(forKey: keyValue.dataEntryBeefbreed.rawValue), for: .normal)
        }
        inheritDobBttn.setTitle("", for: .normal)
        inheritDobBttn.setTitle(nil, for: .normal)
        incrementalBarcodeTitleLabelGlobal.textColor = .gray
        incrementalBarcodeButtonGlobal.isEnabled = false
        incrementalBarcodeCheckBoxGlobal.alpha = 0.6
        incrementalBarcodeTitleLabelGlobal.alpha = 0.6
        
        if breedId  == "" {
            let inheritBreed = fetchAllDataProductBeefId(entityName: Entities.getBreedsTblEntity, breedName: breedBtnOutlet.titleLabel?.text ?? "", productId: 19)
            if inheritBreed.count != 0 {
                let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                breedId = medbreedRegArr1!.breedId ?? ""
            }
        }
        
        dateBttnOutlet.setTitle("", for: .normal)
        self.scanEarTagTextField.becomeFirstResponder()
    }
    
    func textFieldBackroungGrey(){
        dobLbl.textColor = UIColor.gray
        inheritDobLbl.textColor = UIColor.gray
        expanBtnOutlet.alpha = 0.4
        expanBtnOutlet.isEnabled = false
        inheritExpandBtnOutlet.alpha = 0.4
        inheritExpandBtnOutlet.isEnabled = false
        dateBttnOutlet.setTitleColor(.gray, for: .normal)
        tissueBttnOutlet.setTitleColor(.gray, for: .normal)
        breedBtnOutlet.setTitleColor(.gray, for: .normal)
        breedRegBttn.setTitleColor(.gray, for: .normal)
        sireRegDropdownOutlet.setTitleColor(UIColor.gray, for: .normal)
        damRegDropdownOutlet.setTitleColor(UIColor.gray, for: .normal)
        male_femaleBttnOutlet.isEnabled = false
        dateBttnOutlet.isEnabled = false
        tissueBttnOutlet.isEnabled = false
        breedBtnOutlet.isEnabled = false
        breedRegBttn.isEnabled = false
        scanBarcodeTextfield.isEnabled = false
        damRegTextfield.isEnabled = false
        sireRegTextfield.isEnabled = false
        breedRegTextfield.isEnabled = false
        sireRegDropdownOutlet.isEnabled = false
        animalNameTextfield.isEnabled = false
        damRegDropdownOutlet.isEnabled = false
        barcodeBtn.isEnabled = false
        breedBtnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        dateBttnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        scanBarcodeTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        damRegTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        sireRegTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        barcodeView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        breedRegTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        animalNameTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        breedBtnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        tissueBttnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        sireRegDropdownOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        damRegDropdownOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        breedRegBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        dateBttnOutlet.setTitle("", for: .normal)
        globalDateTextField.text = ""
        dateBttnOutlet.setTitle(nil, for: .normal)
        self.scanEarTagTextField.becomeFirstResponder()
        globalDateTextField.isEnabled = false
    }
    
    func textFieldBackroungWhite(){
        expanBtnOutlet.alpha = 1
        expanBtnOutlet.isEnabled = true
        inheritExpandBtnOutlet.alpha = 1
        inheritExpandBtnOutlet.isEnabled = true
        dobLbl.textColor = UIColor.black
        inheritDobLbl.textColor = UIColor.black
        dateBttnOutlet.setTitleColor(.black, for: .normal)
        breedBtnOutlet.setTitleColor(UIColor.black, for: .normal)
        tissueBttnOutlet.setTitleColor(UIColor.black, for: .normal)
        sireRegDropdownOutlet.setTitleColor(UIColor.black, for: .normal)
        damRegDropdownOutlet.setTitleColor(UIColor.black, for: .normal)
        breedRegBttn.setTitleColor(UIColor.black, for: .normal)
        dateBttnOutlet.isEnabled = true
        damRegDropdownOutlet.isEnabled = true
        male_femaleBttnOutlet.isEnabled = true
        tissueBttnOutlet.isEnabled = true
        breedBtnOutlet.isEnabled = true
        barcodeBtn.isEnabled = true
        scanBarcodeTextfield.isEnabled = true
        damRegTextfield.isEnabled = true
        sireRegTextfield.isEnabled = true
        breedRegTextfield.isEnabled = true
        animalNameTextfield.isEnabled = true
        breedRegBttn.isEnabled = true
        tissueBttnOutlet.isEnabled = true
        sireRegDropdownOutlet.isEnabled = true
        breedRegBttn.backgroundColor = .white
        sireRegDropdownOutlet.backgroundColor = .white
        damRegDropdownOutlet.backgroundColor = .white
        barcodeView.backgroundColor = UIColor.white
        scanBarcodeTextfield.backgroundColor = UIColor.white
        damRegTextfield.backgroundColor = UIColor.white
        tissueBttnOutlet.backgroundColor = UIColor.white
        sireRegTextfield.backgroundColor = UIColor.white
        breedRegTextfield.backgroundColor = UIColor.white
        animalNameTextfield.backgroundColor = UIColor.white
        breedBtnOutlet.backgroundColor = UIColor.white
        tissueBttnOutlet.backgroundColor = UIColor.white
        dateBttnOutlet.backgroundColor = UIColor.white
        globalDateTextField.isEnabled = true
        if !isautoPopulated  {
            incrementalBarcodeTitleLabelGlobal.textColor = .black
            incrementalBarcodeButtonGlobal.isEnabled = true
            incrementalBarcodeCheckBoxGlobal.alpha = 1
            incrementalBarcodeTitleLabelGlobal.alpha = 1
            if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) {
                if let lastSavedBarCode = UserDefaults.standard.value(forKey: keyValue.barcodeIncremental.rawValue) as? String {
                    scanBarcodeTextfield.text = isBarcodeEndingWithNumberAndGetIncremented(lastSavedBarCode).incrementedBarCode
                }
            }
        }
        else {
            incrementalBarcodeTitleLabelGlobal.textColor = .gray
            incrementalBarcodeButtonGlobal.isEnabled = true
            incrementalBarcodeCheckBoxGlobal.alpha = 0.6
            incrementalBarcodeTitleLabelGlobal.alpha = 0.6
        }
    }
    
    func tableViewpop() {
        buttonbg2.frame = CGRect(x:0,y: 0,width: 1024,height: 1000)
        buttonbg2.addTarget(self, action:#selector(DataEntryBeefAnimalGlobalHD50KVC.buttonPreddDroper), for: .touchUpInside)
        buttonbg2.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        self.view.addSubview(buttonbg2)
        droperTableView.delegate = self
        droperTableView.dataSource = self
        droperTableView.layer.cornerRadius = 8.0
        droperTableView.layer.borderWidth = 0.5
        droperTableView.layer.borderColor =  UIColor.gray.cgColor
        buttonbg2.addSubview(droperTableView)
    }
    
    private func startAnimating(){
    }
    private func stopAnimating(){
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
                    self.stopAnimating()
                    if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
                        
                        let trimmed = (textStr.compactMap({ $0.isWhitespace ? nil : $0 }))
                        let test = String(trimmed.filter{!"\n\t\r(),.-[]:}{/".contains($0)})
                        self.methReturn = self.ukTagReutn(animalId: test.uppercased())
                        if self.methReturn == LocalizedStrings.againClick {
                            
                            self.scanEarTagTextField.text = ""
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
                                
                                self.scanEarTagTextField.text = test
                                self.dataPopulateInFocusChange()
                                self.textFieldBackroungWhite()
                            })
                            
                            alert.addAction(OKAction)
                            alert.addAction(cancelAction)
                            alert.addAction(thirdAction)
                            self.present(alert, animated: true, completion: nil)
                            
                            return
                        }
                        self.scanEarTagTextField.text = self.methReturn
                        self.dataPopulateInFocusChange()
                        self.textFieldBackroungWhite()
                    }
                    else {
                        let trimmed = (textStr.compactMap({ $0.isWhitespace ? nil : $0 }))
                        let test = String(trimmed.filter{!"\n\t\r(),.-[]:}{".contains($0)})
                        self.methReturn = self.ukTagReutn(animalId: test.uppercased())
                        if self.methReturn == LocalizedStrings.againClick {
                            
                            self.inheritEarTagTextfield.text = ""
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
                                self.inheritEarTagTextfield.text = test
                                self.inherittextFieldBackroungWhite()
                                self.dataPopulateInFocusChange()
                            })
                            
                            alert.addAction(OKAction)
                            alert.addAction(cancelAction)
                            alert.addAction(thirdAction)
                            self.present(alert, animated: true, completion: nil)
                            return
                        }
                        self.inheritEarTagTextfield.text = self.methReturn
                        self.inherittextFieldBackroungWhite()
                        self.dataPopulateInFocusChange()
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
    
    func ukTagReutn(animalId:String)-> String{
        let idAnimal = animalId.uppercased()
        let stringResult = idAnimal.contains("UK")
        if stringResult  {
            let trimmedString = String(idAnimal.compactMap({ $0.isWhitespace ? nil : $0 }))
            let test = String(trimmedString.filter{!"\n\t\r(),.-[]:}{".contains($0)})
            let dropTwelveElement = test.suffix(12).uppercased()
            let totalString =  dropTwelveElement
            return totalString
        }
        else {
            let stringResultUS = idAnimal.contains("US")
            let stringResult840 = idAnimal.contains(LocalizedStrings.eightFortyCountryCode)
            
            if stringResultUS  && stringResult840  {
                let trimmedString = String(idAnimal.compactMap({ $0.isWhitespace ? nil : $0 }))
                let test = String(trimmedString.filter{!"\n\t\r(),.-[]:}{".contains($0)})
                if test.count < 15 {
                    return LocalizedStrings.againClick
                }
                else {
                    guard let range: Range<String.Index> = test.range(of: LocalizedStrings.eightFortyCountryCode) else {
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
    
    // MARK: - IMAGEPICKER CONTROLLER DELEGATE
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true, completion: nil)
        startAnimating()
        if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
            self.scanEarTagTextField.text = ""
        } else {
            self.inheritEarTagTextfield.text = ""
        }
        
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        setVisionTextRecognizeImage(image: image)
    }
}
