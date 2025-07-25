//
//  BeefAnimalNZ_VC.swift
//  SearchPoint
//
//  Created by "" on 08/03/20.
//Entities.dataEntryBeefAnimalAddTblEntity

import UIKit
import Vision
import VisionKit

// MARK: - TEXTFIELD DELEGATE
class DataEntryBeefAnimalNZ_VC: UIViewController,VNDocumentCameraViewControllerDelegate  {
    
    // MARK: - OUTLETS
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var damREGBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var damREGHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var damREGTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var sireRegHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sireRegTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var animalNameHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var animalNameTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nzAngusHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nzAngusTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var breedRegHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var breedRegTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var breedBtnHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var breedBtnTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var dobViewHeightConsraint: NSLayoutConstraint!
    @IBOutlet weak var maleFemaleHeightConstrant: NSLayoutConstraint!
    @IBOutlet weak var tissueBtnHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tissueImageIcon: UIImageView!
    @IBOutlet weak var expandFormOutlet: UIButton!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var closeImage1: UIImageView!
    @IBOutlet weak var closeImage2: UIImageView!
    @IBOutlet weak var keyBoardOptionsView: UIView!
    @IBOutlet weak var keyBoardOptionsViewBottomConstrains: NSLayoutConstraint!
    @IBOutlet weak var clearFormOutlet: UIButton!
    @IBOutlet weak var backNavigateToLiSToUTLET: customButton!
    @IBOutlet weak var scanAnimalTagTextField: UITextField!
    @IBOutlet weak var dobTitleLbl: UILabel!
    @IBOutlet weak var orderingAddAnimaltitleLbl: UILabel!
    @IBOutlet weak var scanBarcodeTextfield: UITextField!
    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var appstatusLbl: UILabel!
    @IBOutlet weak var continueBttn: UIButton!
    @IBOutlet weak var addanimalBttn: UIButton!
    @IBOutlet weak var breedRegLbl: UILabel!
    @IBOutlet weak var breedRegAssociationBttn: customButton!
    @IBOutlet weak var earTagView: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var breedRegTextfield: UITextField!
    @IBOutlet weak var dateBttnOutlet: UIButton!
    @IBOutlet weak var breedBtnOutlet: customButton!
    @IBOutlet weak var male_femaleBttnOutlet: UIButton!
    @IBOutlet weak var tissueBttnOutlet: customButton!
    @IBOutlet weak var tissueLbl: UILabel!
    @IBOutlet weak var breedLbl: UILabel!
    @IBOutlet weak var countLbl: UIButton!
    @IBOutlet weak var notificationLblCount: UILabel!
    @IBOutlet weak var scrollInnerView: UIView!
    @IBOutlet weak var animalNameTextfield: UITextField!
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var calenderbkg: UIView!
    @IBOutlet weak var NetworkStatusLbl: UILabel!
    @IBOutlet weak var offLineBtn: UIButton!
    @IBOutlet weak var networkStatusImg: UIImageView!
    @IBOutlet weak var sireRegTextfield: UITextField!
    @IBOutlet weak var barcodeView: UIView!
    @IBOutlet weak var damRegTextfield: UITextField!
    @IBOutlet weak var dateBtnOutlet: UIView!
    @IBOutlet weak var incrementalBarcodeCheckBox: UIImageView!
    @IBOutlet weak var incrementalBarcodeTitleLabel: UILabel!
    @IBOutlet weak var incrementalBarcodeButton: UIButton!
    @IBOutlet weak var breedDropDownIcon: UIImageView!
    @IBOutlet weak var angusDropDownIcon: UIImageView!
    
    // MARK: - VARIABLES AND CONSTANTS
    var listIdGet = Int()
    var listName = String()
    let tapRec = UITapGestureRecognizer()
    var validateDateFlag = true
    var barAutoPopu = false
    var request = VNRecognizeTextRequest(completionHandler: nil)
    var methReturn = String()
    var checkBarcode = Bool()
    var providerSelectionCountryCode = String()
    var barcodeEnable = Bool()
    var timeStampString = String()
    var lblTimeStamp = String()
    var barcodeflag = Bool()
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
    var addContiuneBtn = Int()
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
    var dataEntryConflicedBack = Bool()
    var dateComp = Int()
    let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
    var orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    var custmerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
    var attrs : [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.blue,.underlineStyle: NSUnderlineStyle.single.rawValue]
    var incrementalBarCode = ""
    var isBarcodeAutoIncrementedEnabled = false
    var checkboxPerfernceSave = Bool()
    let langCode : String = UserDefaults.standard.object(forKey: keyValue.lngCode.rawValue) as! String
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
    var heartBeatViewModel:HeartBeatViewModel?
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIOnDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUIOnWillAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.defaultIncrementalBarCodeSetting()
        removeObserver()
    }
    
    // MARK: - METHODS AND FUNCTIONS
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
    
    func landIdApplangaugeConversion(langid:Int){
        if langId == 2 {
            scanAnimalTagTextField.placeholder = ButtonTitles.tatuagemAnimalText
        }
        scanBarcodeTextfield.placeholder = NSLocalizedString(ButtonTitles.enterSampleBarcode, comment: "")
        breedRegTextfield.placeholder = NSLocalizedString(ButtonTitles.enterBreedRegNumber, comment: "")
        animalNameTextfield.placeholder = NSLocalizedString(ButtonTitles.enterAnimalName, comment: "")
        sireRegTextfield.placeholder = NSLocalizedString(ButtonTitles.enterSireRegNumber, comment: "")
        damRegTextfield.placeholder = NSLocalizedString(ButtonTitles.entireDamRegNumber, comment: "")
        dobTitleLbl.text = NSLocalizedString(ButtonTitles.dateOfBirthText, comment: "")
        orderingAddAnimaltitleLbl.text = NSLocalizedString(ButtonTitles.addAnimalText, comment: "")
        addanimalBttn.setTitle(NSLocalizedString(ButtonTitles.addAnotherAnimalText, comment: ""), for: .normal)
        continueBttn.setTitle(NSLocalizedString(ButtonTitles.reviewDataText, comment: ""), for: .normal)
        appstatusLbl.text = NSLocalizedString(ButtonTitles.appStatusText, comment: "")
    }
    
    func dataPopulateInScreen(animalId:Int){
        isautoPopulated = true
        barAutoPopu = true
        var animalFetch = NSArray()
        
        if animalIdBool == true {
            animalFetch = fetchAllDataWithAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId: animalId, customerID: custmerId!)
            let data = animalFetch.object(at: 0) as! DataEntryBeefAnimaladdTbl
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            animalId1 = Int(data.animalId)
            self.isBarcodeAutoIncrementedEnabled = false
            UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
            earTagView.layer.borderColor = UIColor.gray.cgColor
            barcodeView.layer.borderColor = UIColor.gray.cgColor
            damRegTextfield.layer.borderColor = UIColor.gray.cgColor
            breedRegTextfield.layer.borderColor = UIColor.gray.cgColor
            animalNameTextfield.layer.borderColor = UIColor.gray.cgColor
            sireRegTextfield.layer.borderColor = UIColor.gray.cgColor
            let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
            let formatter = DateFormatter()
            if data.date != ""{
                
                if dateStr == "MM"{
                    var dateVale = ""
                    let values = data.date!.components(separatedBy: "/")
                    if values.count > 1{
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        dateVale = month + "/" + date + "/" + year
                    }
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                        dateTextField.text = dateVale
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
                    }
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                        dateTextField.text = dateVale
                    } else {
                        dateBttnOutlet.setTitle(dateVale, for: .normal)
                    }
                    formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                }
                breedRegAssociationBttn.setTitle(data.sireIDAU, for: .normal)
                if dateBttnOutlet.titleLabel!.text != nil{
                    self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                }
            }
            
            dateComp = Int(data.diffAge)
            scanAnimalTagTextField.text = data.animalTag
            scanBarcodeTextfield.text = data.animalbarCodeTag
            breedRegTextfield.text = data.offPermanentId
            sireRegTextfield.text = data.offsireId
            damRegTextfield.text = data.offDamId
            animalNameTextfield.text  = data.eT
            breedBtnOutlet.setTitle(data.breedName, for: .normal)
            tissueBttnOutlet.setTitleColor(.black, for: .normal)
            breedBtnOutlet.setTitleColor(.black, for: .normal)
            tissueBttnOutlet.setTitle(data.tissuName, for: .normal)
            UserDefaults.standard.set(data.tissuName, forKey: keyValue.dataEntryNZBeeftsu.rawValue)
            breedId = data.breedId!
            UserDefaults.standard.set(data.breedName, forKey: keyValue.NZBeefbreed.rawValue)
            
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
            let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId ?? "",animalTag:data.animalTag ?? "",barcodeTag:data.animalbarCodeTag!)
            animalIdBool = false
            
            if adata.count > 0{
                let animal  = adata.object(at: 0) as! BeefAnimalMaster
                idAnimal = Int(animal.animalId)
            }
        }
        else {
            animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal, customerID: custmerId!)
            if animalFetch.count > 0 {
                let  data = animalFetch.object(at: 0) as! BeefAnimalMaster
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                animalId1 = Int(data.animalId)
                breedRegAssociationBttn.setTitle(data.sireIDAU, for: .normal)
                earTagView.layer.borderColor = UIColor.gray.cgColor
                barcodeView.layer.borderColor = UIColor.gray.cgColor
                damRegTextfield.layer.borderColor = UIColor.gray.cgColor
                breedRegTextfield.layer.borderColor = UIColor.gray.cgColor
                animalNameTextfield.layer.borderColor = UIColor.gray.cgColor
                sireRegTextfield.layer.borderColor = UIColor.gray.cgColor
                let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
                let formatter = DateFormatter()
                if data.date != ""{
                    
                    if dateStr == "MM"{
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        if values.count > 1{
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = month + "/" + date + "/" + year
                        }
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            dateTextField.text = dateVale
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
                        }
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            dateTextField.text = dateVale
                        } else {
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
                        }
                        formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                    }
                    self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                }
                animalNameTextfield.text  = data.eT
                scanAnimalTagTextField.text = data.animalTag
                scanBarcodeTextfield.text = data.animalbarCodeTag
                breedRegTextfield.text = data.offPermanentId
                sireRegTextfield.text = data.offsireId
                damRegTextfield.text = data.offDamId
                breedBtnOutlet.setTitle(data.breedName, for: .normal)
                tissueBttnOutlet.setTitleColor(.black, for: .normal)
                breedBtnOutlet.setTitleColor(.black, for: .normal)
                tissueBttnOutlet.setTitle(data.tissuName, for: .normal)
                UserDefaults.standard.set(data.tissuName, forKey: keyValue.dataEntryNZBeeftsu.rawValue)
                breedId = data.breedId!
                UserDefaults.standard.set(breedId, forKey: keyValue.NZBeefbreed.rawValue)
                
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
    
    func timeStamp()-> String{
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
    
    func byDefaultSetting() {
        let dateformt = DateFormatter()
        let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        if dateStr == "MM" {
            dateformt.dateFormat = DateFormatters.MMddyyyyFormat
            dateTextField.placeholder = DateFormatters.MMDDYYYYFormat
        }
        else {
            dateformt.dateFormat = DateFormatters.ddMMyyyyFormat
            dateTextField.placeholder = DateFormatters.DDMMYYYYFormat
        }
        dobTitleLbl.textColor = UIColor.gray
        expandFormOutlet.alpha = 0.4
        expandFormOutlet.isEnabled = false
        dateBttnOutlet.setTitle("", for: .normal)
        dateBttnOutlet.setTitle(nil, for: .normal)
        dateTextField.text = ""
        animalId1 = 0
        idAnimal = 0
        dateComp = 0
        isUpdate = false
        msgUpatedd = false
        barAutoPopu = false
        self.msgcheckk = false
        self.isautoPopulated = false
        dateBttnOutlet.setTitleColor(UIColor.gray, for: .normal)
        breedBtnOutlet.setTitleColor(UIColor.gray, for: .normal)
        breedRegAssociationBttn.setTitleColor(UIColor.gray, for: .normal)
        breedRegAssociationBttn.layer.borderWidth = 0.5
        tissueBttnOutlet.layer.borderWidth = 0.5
        breedBtnOutlet.layer.borderWidth = 0.5
        earTagView.layer.borderColor = UIColor.gray.cgColor
        damRegTextfield.layer.borderColor = UIColor.gray.cgColor
        sireRegTextfield.layer.borderColor = UIColor.gray.cgColor
        breedRegTextfield.layer.borderColor = UIColor.gray.cgColor
        animalNameTextfield.layer.borderColor = UIColor.gray.cgColor
        breedBtnOutlet.layer.borderColor = UIColor.gray.cgColor
        breedRegAssociationBttn.layer.borderColor = UIColor.gray.cgColor
        dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
        barcodeView.layer.borderColor = UIColor.gray.cgColor
        scanAnimalTagTextField.text?.removeAll()
        scanBarcodeTextfield.text?.removeAll()
        damRegTextfield.text?.removeAll()
        sireRegTextfield.text?.removeAll()
        breedRegTextfield.text?.removeAll()
        animalNameTextfield.text?.removeAll()
        breedBtnOutlet.setTitle(ButtonTitles.ANGAngusText, for: .normal)
        tissueBttnOutlet.setTitle(ButtonTitles.allflexTSUText, for: .normal)
        self.male_femaleBttnOutlet.setImage(UIImage(named: "LangFemale\(langCode)"), for: .normal)
        genderToggleFlag = 0
        genderString = ButtonTitles.femaleText.localized
        UserDefaults.standard.set(ButtonTitles.allflexTSUText, forKey: keyValue.tissueIdSaveLast.rawValue)
        breedBtnOutlet.setTitleColor(.gray, for: .normal)
        tissueBttnOutlet.setTitleColor(.gray, for: .normal)
        breedRegAssociationBttn.setTitleColor(.gray, for: .normal)
        textFieldBackroungGrey()
        self.scrolView.contentOffset.y = 0.0
        
        if UserDefaults.standard.string(forKey: keyValue.dataEntryNZBeeftsu.rawValue) == nil || UserDefaults.standard.string(forKey: keyValue.dataEntryNZBeeftsu.rawValue) == "" {
            tissueBttnOutlet.setTitle(ButtonTitles.allflexTSUText, for: .normal)
            tissuId = 1
        }
        else{
            tissueBttnOutlet.setTitle(UserDefaults.standard.string(forKey: keyValue.dataEntryNZBeeftsu.rawValue), for: .normal)
        }
        
        if UserDefaults.standard.string(forKey: keyValue.NZBeefbreed.rawValue) == nil{
            breedBtnOutlet.setTitle(ButtonTitles.ANGText, for: .normal)
            breedId  = "d352c4c2-2ff9-451a-9c00-4f0f5604b387"
        }
        else{
            breedBtnOutlet.setTitle(UserDefaults.standard.string(forKey: keyValue.NZBeefbreed.rawValue), for: .normal)
        }
        
        if breedId  == "" {
            let inheritBreed = fetchAllDataProductBeefIdNz(entityName: Entities.getBreedsTblEntity, breedName: (breedBtnOutlet.titleLabel?.text) ?? "", pvid: 7)
            if inheritBreed.count != 0 {
                let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                breedId = medbreedRegArr1!.breedId ?? ""
            }
        }
        incrementalBarcodeTitleLabel.textColor = UIColor.gray
        incrementalBarcodeButton.isEnabled = false
        incrementalBarcodeCheckBox.alpha = 0.6
        incrementalBarcodeTitleLabel.alpha = 0.6
        self.scanAnimalTagTextField.becomeFirstResponder()
    }
    
    func textFieldBackroungGrey(){
        dobTitleLbl.textColor = UIColor.gray
        expandFormOutlet.alpha = 0.4
        expandFormOutlet.isEnabled = false
        dateBttnOutlet.setTitleColor(.gray, for: .normal)
        tissueBttnOutlet.setTitleColor(.gray, for: .normal)
        breedBtnOutlet.setTitleColor(.gray, for: .normal)
        breedRegAssociationBttn.setTitleColor(.gray, for: .normal)
        male_femaleBttnOutlet.isEnabled = false
        dateBttnOutlet.isEnabled = false
        tissueBttnOutlet.isEnabled = false
        breedRegAssociationBttn.isEnabled = false
        scanBarcodeTextfield.isEnabled = false
        damRegTextfield.isEnabled = false
        sireRegTextfield.isEnabled = false
        breedRegTextfield.isEnabled = false
        animalNameTextfield.isEnabled = false
        breedBtnOutlet.isEnabled = false
        dateBttnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        damRegTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        sireRegTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        barcodeView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        breedRegTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        animalNameTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        breedBtnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        tissueBttnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        breedRegAssociationBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        dateBttnOutlet.setTitle("", for: .normal)
        dateBttnOutlet.setTitle(nil, for: .normal)
        dateTextField.isEnabled = false
        incrementalBarcodeTitleLabel.textColor = UIColor.gray
        incrementalBarcodeButton.isEnabled = false
        incrementalBarcodeCheckBox.alpha = 0.6
        incrementalBarcodeTitleLabel.alpha = 0.6
        self.scanAnimalTagTextField.becomeFirstResponder()
    }
    
    func textFieldBackroungWhite(){
        dateBttnOutlet.setTitleColor(.black, for: .normal)
        breedBtnOutlet.setTitleColor(UIColor.black, for: .normal)
        tissueBttnOutlet.setTitleColor(UIColor.black, for: .normal)
        dobTitleLbl.textColor = UIColor.black
        expandFormOutlet.alpha = 1
        expandFormOutlet.isEnabled = true
        breedRegAssociationBttn.setTitleColor(UIColor.black, for: .normal)
        male_femaleBttnOutlet.isEnabled = true
        dateBttnOutlet.isEnabled = true
        male_femaleBttnOutlet.isEnabled = true
        tissueBttnOutlet.isEnabled = true
        breedRegAssociationBttn.isEnabled = true
        scanBarcodeTextfield.isEnabled = true
        damRegTextfield.isEnabled = true
        sireRegTextfield.isEnabled = true
        breedRegTextfield.isEnabled = true
        animalNameTextfield.isEnabled = true
        breedBtnOutlet.isEnabled = true
        breedRegAssociationBttn.backgroundColor = UIColor.white
        barcodeView.backgroundColor = UIColor.white
        barcodeView.backgroundColor = UIColor.white
        damRegTextfield.backgroundColor = UIColor.white
        tissueBttnOutlet.backgroundColor = UIColor.white
        sireRegTextfield.backgroundColor = UIColor.white
        breedRegTextfield.backgroundColor = UIColor.white
        animalNameTextfield.backgroundColor = UIColor.white
        breedBtnOutlet.backgroundColor = UIColor.white
        tissueBttnOutlet.backgroundColor = UIColor.white
        dateBttnOutlet.backgroundColor = UIColor.white
        dateTextField.isEnabled = true
        
        if isautoPopulated == false {
            incrementalBarcodeTitleLabel.textColor = UIColor.black
            incrementalBarcodeButton.isEnabled = true
            incrementalBarcodeCheckBox.alpha = 1
            incrementalBarcodeTitleLabel.alpha = 1
            if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
                if let lastSavedBarCode = UserDefaults.standard.value(forKey: keyValue.barcodeIncremental.rawValue) as? String {
                    scanBarcodeTextfield.text = isBarCodeEndsWithNumber_GetIncrementedBarCode(lastSavedBarCode).incrementedBarCode
                }
            }
        }
        else {
            incrementalBarcodeTitleLabel.textColor = UIColor.gray
            incrementalBarcodeButton.isEnabled = false
            incrementalBarcodeCheckBox.alpha = 0.6
            incrementalBarcodeTitleLabel.alpha = 0.6
        }
    }
    
    func doDatePicker(){
        self.datePicker = UIDatePicker(frame:CGRect(x: 20, y: 40, width: self.calenderView.frame.size.width, height: 260))
        self.datePicker?.backgroundColor = UIColor.white
        if langId == 2{
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
    
    func checkAge(date : Date)->Int{
        let birthday = date
        let now = Date()
        let calender = Calendar.current
        let ageComponents = calender.dateComponents([.day], from: birthday, to: now)
        let age = ageComponents.day
        return age!
    }
    
    func autoPop(animalData:NSArray) {
        if animalData.count > 0 {
            isautoPopulated = true
            textFieldBackroungWhite()
            barAutoPopu = true
            barcodeflag = false
            updateOrder = true
            let data =  animalData.lastObject as! BeefAnimalMaster
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            animalId1 = Int(data.animalId)
            dateBttnOutlet.titleLabel!.text = ""
            earTagView.layer.borderColor = UIColor.gray.cgColor
            barcodeView.layer.borderColor = UIColor.gray.cgColor
            breedRegTextfield.layer.borderColor = UIColor.gray.cgColor
            let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
            let formatter = DateFormatter()
            if data.date != ""{
                
                if dateStr == "MM"{
                    var dateVale = ""
                    let values = data.date!.components(separatedBy: "/")
                    if values.count > 1 {
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        dateVale = month + "/" + date + "/" + year
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            dateTextField.text = dateVale
                        } else {
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
                        }                    }
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
                        
                    }
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                        dateTextField.text = dateVale
                    } else {
                        dateBttnOutlet.setTitle(dateVale, for: .normal)
                    }
                    formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                }
                
                if dateBttnOutlet.titleLabel!.text != nil{
                    self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                }
                else{
                    self.selectedDate = Date()
                }
            }
            breedRegTextfield.text = data.offPermanentId
            sireRegTextfield.text = data.offsireId
            damRegTextfield.text = data.offDamId
            animalNameTextfield.text  = data.eT
            breedBtnOutlet.setTitle(data.breedName, for: .normal)
            tissueBttnOutlet.setTitleColor(.black, for: .normal)
            breedBtnOutlet.setTitleColor(.black, for: .normal)
            tissueBttnOutlet.setTitle(data.tissuName, for: .normal)
            UserDefaults.standard.set(data.tissuName, forKey: keyValue.dataEntryNZBeeftsu.rawValue)
            breedRegAssociationBttn.setTitle(data.sireIDAU, for: .normal)
            breedId = data.breedId!
            UserDefaults.standard.set(data.breedName, forKey: keyValue.NZBeefbreed.rawValue)
            
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
            
            let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
            if dataFetch.count == 0 {
                incrementalBarcodeTitleLabel.textColor = .black
                incrementalBarcodeTitleLabel.alpha = 1
                incrementalBarcodeCheckBox.alpha = 1
                incrementalBarcodeButton.isEnabled = true
            } else {
                if data.orderstatus == "true"{
                    checkBarcode = false
                    incrementalBarcodeTitleLabel.textColor = .black
                    incrementalBarcodeButton.isEnabled = true
                    incrementalBarcodeTitleLabel.alpha = 1
                    incrementalBarcodeCheckBox.alpha = 1
                } else {
                    scanBarcodeTextfield.text = data.animalbarCodeTag
                    UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                    self.isBarcodeAutoIncrementedEnabled = false
                    incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                    incrementalBarcodeButton.isEnabled = false
                    incrementalBarcodeTitleLabel.textColor = .gray
                    checkBarcode = false
                    incrementalBarcodeTitleLabel.alpha = 0.6
                    incrementalBarcodeCheckBox.alpha = 0.6
                }
            }
            
            tissuId = Int(data.tissuId)
            dateBttnOutlet.setTitleColor(.black, for: .normal)
            statusOrder = false
            messageCheck = false
            let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId ?? "",animalTag:data.animalTag ?? "",barcodeTag:data.animalbarCodeTag ?? "")
            if adata.count > 0{
                let animal  = adata.object(at: 0) as! BeefAnimalMaster
                idAnimal = Int(animal.animalId)
                messageCheck = true
            }
        }
    }
    
    func addAnimalBtn(completionHandler: @escaping CompletionHandler){
        if barcodeEnable == true {
            let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId!)
            if orederStatus.count > 0 {
                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalAlreadyUsedStr, comment: ""), preferredStyle: .alert)
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId: self.idAnimal,customerID: self.custmerId!)
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
            if scanAnimalTagTextField.text == "" || scanBarcodeTextfield.text == "" || breedRegTextfield.text == "" {
                self.validation()
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                completionHandler(false)
                return
            }
            else {
                addBtnCondtion(completionHandler: { (success) -> Void in
                    if success == true{
                        dateBttnOutlet.setTitle("", for: .normal)
                        dateTextField.text = ""
                        
                        dateBttnOutlet.titleLabel?.text = ""
                        completionHandler(true)
                    }
                })
            }
        }
        else {
            if scanAnimalTagTextField.text == "" || scanBarcodeTextfield.text == "" || breedRegTextfield.text == "" {
                self.validation()
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                completionHandler(false)
                return
            } else {
                
                addBtnCondtion(completionHandler: { (success) -> Void in
                    if success == true{
                        completionHandler(true)
                    }
                })
            }
        }
        if notificationLblCount.text != "0"{
            countLbl.isHidden = false
            notificationLblCount.isHidden = false
        }
    }
    
    func addBtnCondtion(completionHandler: CompletionHandler){
        if checkBarcode == true {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.barcodeMustEndWithNumAlert, comment: ""))
            return
        }
        
        var dateVale = ""
        let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            dateVale = dateTextField.text ?? ""
        }
        else {
            dateVale = dateBttnOutlet.titleLabel?.text ?? ""
        }
        let codeId = fetchBreedDataTissueCode(entityName: Entities.getSampleTblEntity,provId:self.pvid,tissueName:(tissueBttnOutlet.titleLabel?.text!)!)
        let naabFetch1 = codeId.value(forKey: keyValue.sampleId.rawValue) as? NSArray
        if naabFetch1!.count != 0 {
            let breedIdGet = naabFetch1![0] as? Int
            self.tissuId = breedIdGet!
        }
        
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            dateVale = dateTextField.text ?? ""
            if dateVale != "" {
                if dateStr == "DD"{
                    dateVale = dateBttnOutlet.titleLabel?.text ?? ""
                }
                else {
                    let values = dateVale.components(separatedBy: "/")
                    let date = values[0]
                    let month = values[1]
                    let year = values[2]
                    dateVale = month + "/" + date + "/" + year
                }
            }
        }
        else {
            if dateVale != "" {
                if dateStr == "DD"{
                    dateVale = dateBttnOutlet.titleLabel?.text ?? ""
                } else {
                    
                    let values = dateVale.components(separatedBy: "/")
                    let date = values[0]
                    let month = values[1]
                    let year = values[2]
                    dateVale = month + "/" + date + "/" + year
                }
            }
        }
        if dateTextField.text?.count == 0 {
            
            
        }
        else {
            if dateTextField.text?.count == 10 {
                let validate = isValidDate(dateString: dateTextField.text ?? "")
                if validate == LocalizedStrings.correctFormatStr{
                    dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
                    dateBttnOutlet.layer.borderWidth = 0.5
                    validateDateFlag = true
                }
                else {
                    dateBttnOutlet.layer.borderColor = UIColor.red.cgColor
                    validateDateFlag = false
                    if validate == LocalizedStrings.greaterThenDateStr {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.dobSmallerthanCurrDate, comment: ""))
                        
                    } else {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
                    }
                    return
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
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        if  barcodeflag == true {
            let barCode = fetchAnimaldataValidateAnimalBarcodeanimalIdOrderId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalbarCodeTag: scanBarcodeTextfield.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"false",orderid:orderId, custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),IsDataEmail: false)
            if barCode.count > 0 {
                validation()
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sampleAlreadyExists, comment: ""))
                barcodeView.layer.borderColor = UIColor.red.cgColor
                return
            }
        }
        let animaBarcOde = fetchAnimaldataValidateAnimalBarcodeanimalId(entityName: Entities.beefAnimalMasterTblEntity, animalbarCodeTag: scanBarcodeTextfield.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"true", custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),IsDataEmail: false)
        if animaBarcOde.count > 0 {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sampleAlreadyExists, comment: ""))
            barcodeView.layer.borderColor = UIColor.red.cgColor
            return
        }
        let animalData = fetchAnimaldataValidateAnimalTagDataEntry(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: scanAnimalTagTextField.text ?? "",listId: listIdGet , custmerId: custmerId ?? 0)
        incrementalBarCode = scanBarcodeTextfield.text ?? ""
        
        if animalData.count > 0  {
            isUpdate = true
            updateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalMasterTblEntity, animalTag: scanAnimalTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "false", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: (breedRegAssociationBttn.titleLabel?.text!)!, nationHerdAU: "", userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
            
            updateOrderStatusISyncAnimalMasterNZ(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: scanAnimalTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "true", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: (breedRegAssociationBttn.titleLabel?.text!)!, nationHerdAU: "", userId: userId,udid:timeStampString,animalId: animalId1, diffDate: dateComp)
            
            
            updateOrderStatusISyncProduct(entity: Entities.productAdonAnimlBeefTblEntity,animalTag: scanAnimalTagTextField.text!,barCodetag:  scanBarcodeTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId:animalId1)
            updateOrderStatusISyncSubProduct(entity: Entities.subProductBeefTblEntity,animalTag: scanAnimalTagTextField.text!,barCodetag:  scanBarcodeTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId: animalId1)
            
            let fetchDataUpdate = fetchAnimalDataAccEarTag(entityName: Entities.beefAnimalAddTblEntity,animalTag:scanAnimalTagTextField.text ?? "",custmerId :Int64(custmerId ?? 0),providerid:pvid,productId:25)
            print(fetchDataUpdate)
            
            if fetchDataUpdate.count != 0 {
                updateOrderInfoBeefNZ(entity: Entities.beefAnimalAddTblEntity,animalTag: scanAnimalTagTextField.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,permanentId: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text! ,breedName: breedBtnOutlet.titleLabel!.text! ,et: animalNameTextfield.text ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:breedRegAssociationBttn.titleLabel?.text ?? "",nationHerdAU:"",userId:userId,udid: timeStampString,diffDate:dateComp,productId:25,custmerId:Int64(custmerId ?? 0), editFlagSave: true)
                
                updateOrderInfoBeefNZ(entity: Entities.beefAnimalMasterTblEntity,animalTag: scanAnimalTagTextField.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,permanentId: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text! ,breedName: breedBtnOutlet.titleLabel!.text! ,et: animalNameTextfield.text ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:breedRegAssociationBttn.titleLabel?.text ?? "",nationHerdAU:"",userId:userId,udid: timeStampString,diffDate:dateComp,productId:25,custmerId:Int64(custmerId ?? 0), editFlagSave: true)
            }
            
            let fetchDataUpdateDataEntry = fetchAnimalDataAccEarTag(entityName: Entities.dataEntryBeefAnimalAddTblEntity,animalTag:scanAnimalTagTextField.text ?? "",custmerId :Int64(custmerId ?? 0),providerid:pvid,productId:25)
            if fetchDataUpdateDataEntry.count != 0 {
                updateOrderInfoBeefNZ(entity: Entities.dataEntryBeefAnimalAddTblEntity,animalTag: scanAnimalTagTextField.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,permanentId: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text! ,breedName: breedBtnOutlet.titleLabel!.text! ,et: animalNameTextfield.text ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:breedRegAssociationBttn.titleLabel?.text ?? "",nationHerdAU:"",userId:userId,udid: timeStampString,diffDate:dateComp,productId:25,custmerId:Int64(custmerId ?? 0), editFlagSave: true)
                
                updateOrderInfoBeefNZ(entity: Entities.beefAnimalMasterTblEntity,animalTag: scanAnimalTagTextField.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,permanentId: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text! ,breedName: breedBtnOutlet.titleLabel!.text! ,et: animalNameTextfield.text ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:breedRegAssociationBttn.titleLabel?.text ?? "",nationHerdAU:"",userId:userId,udid: timeStampString,diffDate:dateComp,productId:25,custmerId:Int64(custmerId ?? 0), editFlagSave: true)
            }
            
            let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: "",animalTag:scanAnimalTagTextField.text!,barcodeTag:scanBarcodeTextfield.text!)
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            
            if adata.count > 0{
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                byDefaultSetting()
            }
            
            else if animalDataMaster.count > 0 {
                if  msgUpatedd == true{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalRecordUpdated, comment: ""))
                    UserDefaults.standard.set(tissueBttnOutlet.titleLabel?.text, forKey: keyValue.dataEntryNZBeeftsu.rawValue)
                    UserDefaults.standard.set(tissueBttnOutlet.titleLabel?.text, forKey: keyValue.dataEntryNZBeeftsuClear.rawValue)
                    byDefaultSetting()
                }
                else{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                    byDefaultSetting()
                }
            }
            
            editAid = animalId1
            animalId1 = 0
            
            if identify1 == true {
                let data1 = fetchAllDataOrderStatus(entityName: Entities.dataEntryBeefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
                if data1.count > 0 {
                    completionHandler(true)
                    return
                }
            }
            completionHandler(true)
            scrolView.contentOffset.y = 0.0
        }
        else if isUpdate == true {
            animalId1 = editAid
            updateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalMasterTblEntity, animalTag: scanAnimalTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "false", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: (breedRegAssociationBttn.titleLabel?.text!)!, nationHerdAU: "", userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
            
            updateOrderStatusISyncAnimalMasterNZ(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: scanAnimalTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "true", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: (breedRegAssociationBttn.titleLabel?.text!)!, nationHerdAU: "", userId: userId,udid:timeStampString,animalId: animalId1,diffDate: dateComp)
            
            if identify1 == true {
                let data1 = fetchAllDataOrderStatus(entityName: Entities.dataEntryBeefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
                if data1.count > 0 {
                    completionHandler(true)
                    return
                }
            }
            isautoPopulated = false
            let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: "",animalTag:scanAnimalTagTextField.text!,barcodeTag:scanBarcodeTextfield.text!)
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            if adata.count > 0{
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                byDefaultSetting()
            }
            else if animalDataMaster.count > 0 {
                if  msgUpatedd == true{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalRecordUpdated, comment: ""))
                    UserDefaults.standard.set(tissueBttnOutlet.titleLabel?.text, forKey: keyValue.dataEntryNZBeeftsu.rawValue)
                    UserDefaults.standard.set(tissueBttnOutlet.titleLabel?.text, forKey: keyValue.dataEntryNZBeeftsuClear.rawValue)
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
            let pid = product.object(at: 0) as! GetProductTblBeef
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
                
                updateOrderStatusISyncAnimalMasterAnimalId(entity: Entities.beefAnimalMasterTblEntity, animalTag: scanAnimalTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "false", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: (breedRegAssociationBttn.titleLabel?.text!)!, nationHerdAU: "", userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1,isSyncServer:false, adhDataServer: false, tertiaryGeno: "")
                
                let fetchDataUpdate = fetchAnimalDataAccEarTag(entityName: Entities.beefAnimalAddTblEntity,animalTag:scanAnimalTagTextField.text ?? "",custmerId :Int64(custmerId ?? 0),providerid:pvid,productId:25)
                
                if fetchDataUpdate.count != 0 {
                    updateOrderInfoBeefNZ(entity: Entities.beefAnimalAddTblEntity,animalTag: scanAnimalTagTextField.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,permanentId: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text! ,breedName: breedBtnOutlet.titleLabel!.text! ,et: animalNameTextfield.text ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:breedRegAssociationBttn.titleLabel?.text ?? "",nationHerdAU:"",userId:userId,udid: timeStampString,diffDate:dateComp,productId:25,custmerId:Int64(custmerId ?? 0), editFlagSave: true)
                }
                
                let fetchDataUpdateDataEntry = fetchAnimalDataAccEarTag(entityName: Entities.dataEntryBeefAnimalAddTblEntity,animalTag:scanAnimalTagTextField.text ?? "",custmerId :Int64(custmerId ?? 0),providerid:pvid,productId:25)
                if fetchDataUpdateDataEntry.count != 0 {
                    updateOrderInfoBeefNZ(entity: Entities.dataEntryBeefAnimalAddTblEntity,animalTag: scanAnimalTagTextField.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,permanentId: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text! ,breedName: breedBtnOutlet.titleLabel!.text! ,et: animalNameTextfield.text ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:breedRegAssociationBttn.titleLabel?.text ?? "",nationHerdAU:"",userId:userId,udid: timeStampString,diffDate:dateComp,productId:25,custmerId:Int64(custmerId ?? 0), editFlagSave: true)
                    
                    updateOrderInfoBeefNZ(entity: Entities.beefAnimalMasterTblEntity,animalTag: scanAnimalTagTextField.text ?? "",date: dateVale,damId: damRegTextfield.text ?? "",sireId: sireRegTextfield.text ?? "",gender: genderString,permanentId: breedRegTextfield.text ?? "",tissuName: tissueBttnOutlet.titleLabel!.text! ,breedName: breedBtnOutlet.titleLabel!.text! ,et: animalNameTextfield.text ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:breedRegAssociationBttn.titleLabel?.text ?? "",nationHerdAU:"",userId:userId,udid: timeStampString,diffDate:dateComp,productId:25,custmerId:Int64(custmerId ?? 0), editFlagSave: true)
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
                    updateOrderStatusISyncAnimalMasterAnimalId(entity: Entities.beefAnimalMasterTblEntity, animalTag: scanAnimalTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "false", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: (breedRegAssociationBttn.titleLabel?.text!)!, nationHerdAU:"", userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1,isSyncServer:false, adhDataServer: false, tertiaryGeno: "")
                }
                else {
                    saveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: scanAnimalTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "true", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel?.text ?? "", et: animalNameTextfield.text!, farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: (breedRegAssociationBttn.titleLabel?.text!)!, nationHerdAU: "", userId: userId,udid:timeStampString, animalId: animalID1,productId: Int(pid.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listIdGet), serverAnimalId: "", tertiaryGeno: "")
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAdded, comment: ""), duration: 1, position: .bottom)
                }
            }
            
            let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true", ordrId: autoD, customerID: custmerId ?? 0)
            if data12333.count > 0{
                if dateComp >= 35{
                    if tissueBttnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || tissueBttnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || tissueBttnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                        if dateVale == "" {
                            dateComp = 0
                        }
                        saveAnimaldatawithAge(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: scanAnimalTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "true", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: (breedRegAssociationBttn.titleLabel?.text!)!, nationHerdAU: "", userId: userId,udid:timeStampString, animalId: animalID1, age:dateComp,productId: Int(pid.productId), samconflict: "", ageConf: "", bothConf: "" ,custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listIdGet), serverAnimalId: "")
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAdded, comment: ""), duration: 1, position: .bottom)
                    }
                    else {
                        let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            self.byDefaultSetting()
                            
                        }
                        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            UserDefaults.standard.set("", forKey: keyValue.dataEntryNZBeeftsu.rawValue)
                            deleteDataWithProductwithEntity(animalID1,entity: Entities.productAdonAnimlBeefTblEntity)
                            deleteDataWithProductwithEntity(animalID1, entity: Entities.subProductBeefTblEntity)
                            deleteDataWithProductwithEntity(animalID1, entity: Entities.dataEntryBeefAnimalAddTblEntity)
                            let animalCount = fetchDataEnteryAnimalTblBeefData(entityName: Entities.dataEntryBeefAnimalAddTblEntity,customerId:self.custmerId ?? 0,listId:Int64(self.listIdGet ),productId:25) as!  [DataEntryBeefAnimaladdTbl]
                            self.notificationLblCount.text = String(animalCount.count)
                            self.byDefaultSetting()
                            return
                        }
                        alertController.addAction(okAction)
                        alertController.addAction(cancelAction)
                        self.present(alertController, animated: true, completion: nil)
                        return
                    }
                }
                else{
                    let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCantBeAddedAge35, comment: ""), preferredStyle: .alert)
                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        self.byDefaultSetting()
                    }
                    let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        deleteDataWithProductwithEntity(animalID1,entity: Entities.productAdonAnimlBeefTblEntity)
                        deleteDataWithProductwithEntity(animalID1, entity: Entities.subProductBeefTblEntity)
                        deleteDataWithProductwithEntity(animalID1, entity: Entities.dataEntryBeefAnimalAddTblEntity)
                        let animalCount = fetchDataEnteryAnimalTblBeefData(entityName: Entities.dataEntryBeefAnimalAddTblEntity,customerId:self.custmerId ?? 0,listId:Int64(self.listIdGet ),productId:25) as!  [DataEntryBeefAnimaladdTbl]
                        self.notificationLblCount.text = String(animalCount.count)
                        self.byDefaultSetting()
                        return
                    }
                    
                    alertController.addAction(okAction)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
            }
            else {
                if dateVale == "" {
                    dateComp = 0
                }
                
                saveAnimaldatawithAge(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: scanAnimalTagTextField.text!, barCodetag: scanBarcodeTextfield.text!, date: dateVale , damId: damRegTextfield.text!, sireId: sireRegTextfield.text ?? "" , gender: genderString,update: "true", permanentId:breedRegTextfield.text!, tissuName: tissueBttnOutlet.titleLabel!.text!, breedName: breedBtnOutlet.titleLabel!.text!, et: animalNameTextfield.text!, farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: (breedRegAssociationBttn.titleLabel?.text!)!, nationHerdAU: "", userId: userId,udid:timeStampString, animalId: animalID1, age:dateComp,productId :Int(pid.productId), samconflict: "", ageConf: "", bothConf: "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listIdGet), serverAnimalId: "")
                self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAdded, comment: ""), duration: 1, position: .bottom)
            }
            
            UserDefaults.standard.set(tissueBttnOutlet.titleLabel?.text, forKey: keyValue.dataEntryNZBeeftsu.rawValue)
            UserDefaults.standard.set(tissueBttnOutlet.titleLabel?.text, forKey: keyValue.dataEntryNZBeeftsuClear.rawValue)
            
            if isBarcodeAutoIncrementedEnabled == true {
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
                
            } else {
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
            }
            
            self.male_femaleBttnOutlet.setImage(UIImage(named: "LangFemale\(langCode)"), for: .normal)
            byDefaultSetting()
            textFieldBackroungGrey()
            genderToggleFlag = 0
            genderString = ButtonTitles.femaleText.localized
            scanAnimalTagTextField.text = ""
            scanBarcodeTextfield.text = ""
            barAutoPopu = false
            let animalCount = fetchDataEnteryAnimalTblBeefData(entityName: Entities.dataEntryBeefAnimalAddTblEntity,customerId:self.custmerId ?? 0,listId:Int64(self.listIdGet ),productId:25) as!  [DataEntryBeefAnimaladdTbl]
            notificationLblCount.text = String(animalCount.count)
            let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
            let formatter = DateFormatter()
            
            if dateStr == "MM"{
                formatter.dateFormat = DateFormatters.MMddyyyyFormat
            }
            else {
                formatter.dateFormat = DateFormatters.ddMMyyyyFormat
            }
            dateTextField.text = ""
            dateBttnOutlet.setTitle("", for: .normal)
            dateBttnOutlet.setTitle(nil, for: .normal)
            completionHandler(true)
        }
        dateVale = ""
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
            UserDefaults.standard.set(incrementalBarCode, forKey: keyValue.barcodeIncremental.rawValue)
        }
        incrementalBarCode = ""
    }
    
    func tableViewpop() {
        buttonbg2.frame = CGRect(x:0,y: 0,width: 1024,height: 1000)
        buttonbg2.addTarget(self, action:#selector(self.buttonPreddDroper), for: .touchUpInside)
        buttonbg2.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        self.view.addSubview(buttonbg2)
        droperTableView.delegate = self
        droperTableView.dataSource = self
        droperTableView.layer.cornerRadius = 8.0
        droperTableView.layer.borderWidth = 0.5
        droperTableView.layer.borderColor =  UIColor.gray.cgColor
        buttonbg2.addSubview(droperTableView)
    }
    
    
    func statusOrderTrue() -> Bool{
        let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal,customerID: custmerId!)
        if animalFetch.count > 0{
            statusOrder = true
            return true
        }else{
            return false
        }
        
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
    
    func pageLoading() {
        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
        if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil {
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
        }
        else {
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
        }
    }
    
    func validation() {
        if scanAnimalTagTextField.text == ""{
            earTagView.layer.borderColor = UIColor.red.cgColor
        }
        else {
            earTagView.layer.borderColor = UIColor.gray.cgColor
        }
        
        if scanBarcodeTextfield.text == ""{
            barcodeView.layer.borderColor = UIColor.red.cgColor
        }
        else {
            barcodeView.layer.borderColor = UIColor.gray.cgColor
        }
        
        if breedRegTextfield.text == ""{
            breedRegTextfield.layer.borderColor = UIColor.red.cgColor
        }
        else {
            breedRegTextfield.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    func setUpGallary(){
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
                    print("No candidate")
                    continue
                }
                textStr += "\n\(topCandidate.string)"
                DispatchQueue.main.async {
                    let trimmed = (textStr.compactMap({ $0.isWhitespace ? nil : $0 }))
                    let test = String(trimmed.filter{!"\n\t\r(),.-[]:}{".contains($0)})
                    self.methReturn = self.ukTagReutn(animalId: test.uppercased())
                    if self.methReturn == LocalizedStrings.againClick {
                        self.scanAnimalTagTextField.text = ""
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
                            
                            self.scanAnimalTagTextField.text = test
                            self.dataPopulateInFocusChange()
                            self.textFieldBackroungWhite()
                        })
                        
                        alert.addAction(OKAction)
                        alert.addAction(cancelAction)
                        alert.addAction(thirdAction)
                        self.present(alert, animated: true, completion: nil)
                        return
                    }
                    self.scanAnimalTagTextField.text = self.methReturn
                    self.dataPopulateInFocusChange()
                    self.textFieldBackroungWhite()
                    
                    
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
        if stringResult == true {
            let trimmedString = String(idAnimal.compactMap({ $0.isWhitespace ? nil : $0 }))
            let test = String(trimmedString.filter{!"\n\t\r(),.-[]:}{".contains($0)})
            
            let dropTwelveElement = test.suffix(12).uppercased()
            let totalString =  dropTwelveElement
            return totalString
        }
        else {
            let stringResultUS = idAnimal.contains("US")
            let stringResult840 = idAnimal.contains(LocalizedStrings.eightFortyCountryCode)
            if stringResultUS == true && stringResult840 == true {
                let trimmedString = String(idAnimal.compactMap({ $0.isWhitespace ? nil : $0 }))
                let test = String(trimmedString.filter{!"\n\t\r(),.-[]:}{".contains($0)})
                if test.count < 15 {
                    print("count")
                    return LocalizedStrings.againClick
                }
                else {
                    guard let range: Range<String.Index> = test.range(of: LocalizedStrings.eightFortyCountryCode) else {
                        return LocalizedStrings.againClick
                        
                    }
                    let index: Int = test.distance(from: test.startIndex, to: range.lowerBound)
                    print(index)
                    let countt = index + 14
                    if test.count < countt {
                        return LocalizedStrings.againClick
                    }
                    else {
                        let indexGet = test.subString(from: index, to: index + 14)
                        print(indexGet)
                        return indexGet
                    }
                }
            } else {
                return LocalizedStrings.againClick
            }
        }
        return LocalizedStrings.againClick
    }
    
    func defaultIncrementalBarCodeSetting() {
        incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
        incrementalBarcodeTitleLabel.text = NSLocalizedString(ButtonTitles.incrementalBarcodeText, comment: "")
    }
}
