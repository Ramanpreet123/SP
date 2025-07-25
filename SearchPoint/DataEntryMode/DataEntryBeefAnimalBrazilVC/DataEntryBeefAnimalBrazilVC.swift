


import UIKit

// MARK: - CLASS
class DataEntryBeefAnimalBrazilVC: UIViewController,UIScrollViewDelegate {
    
    // MARK: - OUTLETS
    @IBOutlet weak var keyBoardOptionsView: UIView!
    @IBOutlet weak var keyBoardOptionsViewBottomConstrains: NSLayoutConstraint!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var closeImage1: UIImageView!
    @IBOutlet weak var closeImage2: UIImageView!
    @IBOutlet weak var selectBreedBtn: customButton!
    @IBOutlet weak var genstarblackBreedBtn: customButton!
    @IBOutlet weak var genstardropdown: UIImageView!
    @IBOutlet weak var selectbreeddropdown: UIImageView!
    @IBOutlet weak var breedlablehide: UILabel!
    @IBOutlet weak var breedblackstarlablehide: UILabel!
    @IBOutlet weak var nonGenoExpandOutlet: UIButton!
    @IBOutlet weak var nonGenoAnimalNameHeight: NSLayoutConstraint!
    @IBOutlet weak var nonGenoAnimalNameTop: NSLayoutConstraint!
    @IBOutlet weak var nonGenoDobHeight: NSLayoutConstraint!
    @IBOutlet weak var nonGenoDobTop: NSLayoutConstraint!
    @IBOutlet weak var nonGenoCalnederIcon: UIImageView!
    @IBOutlet weak var tissueImageDown: UIImageView!
    @IBOutlet weak var genoTypeSecondaryBreedHeight: NSLayoutConstraint!
    @IBOutlet weak var genoTypeSecondaryBrTop: NSLayoutConstraint!
    @IBOutlet weak var genoTypePriorityBreedHeight: NSLayoutConstraint!
    @IBOutlet weak var genoTypePriorityBrTop: NSLayoutConstraint!
    @IBOutlet weak var genoTypeAnimalNameHeight: NSLayoutConstraint!
    @IBOutlet weak var genoTypeAnimalNameTop: NSLayoutConstraint!
    @IBOutlet weak var genoTypeCalendeViewHeight: NSLayoutConstraint!
    @IBOutlet weak var genoTypeCalendeViewTop: NSLayoutConstraint!
    @IBOutlet weak var genoTypeCalenderImage: UIImageView!
    @IBOutlet weak var genoTypePriorityBreedingDropDown: UIImageView!
    @IBOutlet weak var genoTypeSecondaryBreedingDropDown: UIImageView!
    @IBOutlet weak var genoTypeTerritoryBreedingDropDown: UIImageView!
    @IBOutlet weak var genoTypeExpandFormBtn: UIButton!
    @IBOutlet weak var tissueDropDownImage: UIImageView!
    @IBOutlet weak var genotypeDateTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var dateOfLbl: UILabel!
    @IBOutlet weak var genotypeBarcodeBttn: UIButton!
    @IBOutlet weak var barcodeBttn: UIButton!
    @IBOutlet weak var genotypeView: UIView!
    @IBOutlet weak var scrollInnerView: UIView!
    @IBOutlet weak var NetworkStatusLbl: UILabel!
    @IBOutlet weak var offLineBtn: UIButton!
    @IBOutlet weak var networkStatusImg: UIImageView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var genotypeScrollView: UIScrollView!
    @IBOutlet weak var barcodeView: UIView!
    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var scanBarcodeTextfield: UITextField!
    @IBOutlet weak var serieTextfield: UITextField!
    @IBOutlet weak var rGNTextfield: UITextField!
    @IBOutlet weak var rGDTextfield: UITextField!
    @IBOutlet weak var tissueHideLbl: UILabel!
    @IBOutlet weak var tissueBttn: customButton!
    @IBOutlet weak var maleFemaleBttn: UIButton!
    @IBOutlet weak var dateBttnOutlet: UIButton!
    @IBOutlet weak var animalTextfield: UITextField!
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var calenderbkg: UIView!
    @IBOutlet weak var dobView: UIView!
    @IBOutlet weak var genotypeScanBarcodeView: UIView!
    @IBOutlet weak var genotypeScanBarcodeTextField: UITextField!
    @IBOutlet weak var genotypeSerieTextfield: UITextField!
    @IBOutlet weak var genotypeRgnTextfield: UITextField!
    @IBOutlet weak var genotypeTissueBttn: customButton!
    @IBOutlet weak var genotypeDOBBttn: UIButton!
    @IBOutlet weak var genotypeAnimalNameTextfield: UITextField!
    @IBOutlet weak var genotypeMaleFemaleBttn: UIButton!
    @IBOutlet weak var genotypeTissueHideLbl: UILabel!
    @IBOutlet weak var genotypeRgdTextfield: UITextField!
    @IBOutlet weak var calenderViewOutlet: UIView!
    @IBOutlet weak var priorityBreeingBtnOutlet: customButton!
    @IBOutlet weak var secondaryBreddingOutlet: customButton!
    @IBOutlet weak var territoryBreddingOutlet: customButton!
    @IBOutlet weak var secondaryHidenLbl: UILabel!
    @IBOutlet weak var priorityBreddingLbl: UILabel!
    @IBOutlet weak var territoryHidenLbl: UILabel!
    @IBOutlet weak var notificationLblCount: UILabel!
    @IBOutlet weak var countLbl: UIButton!
    @IBOutlet weak var incrementalBarcodeCheckBox: UIImageView!
    @IBOutlet weak var incrementalBarcodeTitleLabel: UILabel!
    @IBOutlet weak var incrementalBarcodeButton: UIButton!
    @IBOutlet weak var incrementalBarcodeCheckBoxGenoType: UIImageView!
    @IBOutlet weak var incrementalBarcodeTitleLabelGenoType: UILabel!
    @IBOutlet weak var incrementalBarcodeButtonGenoType: UIButton!
    @IBOutlet weak var reviewBtnTitle: UIButton!
    @IBOutlet weak var addAnotherBtnTtile: UIButton!
    @IBOutlet weak var appStatusTitleLbl: UILabel!
    @IBOutlet weak var addAnimalTtilte: UILabel!
    @IBOutlet weak var bckBtnOutlet: customButton!
    @IBOutlet weak var nonGenoBckBtnOutlet: customButton!
    @IBOutlet weak var addAnpthertITLE: UIButton!
    @IBOutlet weak var nonGenoReviewTtilt: UIButton!
    @IBOutlet weak var clearFormOutlet: UIButton!
    @IBOutlet weak var nonGenotypeclearFormOutlet: UIButton!
    
    // MARK: - VARIABLES AND CONSTANTS
    let tapRec = UITapGestureRecognizer()
    var checkBarcode = Bool()
    var validateDateFlag = true
    var barAutoPopu = false
    var lblTimeStamp = String()
    var requiredflag = 0
    var  barcodeflag = Bool()
    var genderString = String()
    var othersGenderString = String()
    var attrs : [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.blue,.underlineStyle: NSUnderlineStyle.single.rawValue]
    var selectedDate = Date()
    var btnTag = Int()
    var barcodeEnable = Bool()
    var priorityBreeding = NSArray()
    var secondaryBreeding = NSArray()
    var tertiaryBreeding = NSArray()
    var tissueArr = NSArray()
    let buttonbg2 = UIButton ()
    var droperTableView  = UITableView ()
    var datePicker : UIDatePicker!
    var genderToggleFlag : Int = 0
    var timeStampString = String()
    var othersGenderToggleFlag : Int = 0
    var addContiuneBtn = Int()
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
    var isGenotypeOnlyAdded = false
    var isGenostarblackOnlyAdded = false
    var animalIdBool = Bool()
    var breedArr = NSArray()
    var breedArrblack = NSArray()
    var commomNamebreed = NSArray()
    var commomNamethreecode = NSArray()
    var commomNamebreedID = NSArray()
    var tempbreedblackname = [String]()
    var tempbreedblackname1 = [String]()
    var tempbreedblackname2 = [String]()
    var tempbreedarraynames = [String]()
    var tempbreedarraynames1 = [String]()
    var tempbreedarraynames2 = [String]()
    var breedRegArr = NSArray()
    var breedId = String()
    var tissuId = Int()
    var animalId1 = Int()
    var pid :GetProductTblBeef?
    let toolBar = UIToolbar()
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
    let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
    let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    var custmerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
    let langCode : String = UserDefaults.standard.object(forKey: keyValue.lngCode.rawValue) as! String
    var incrementalBarCode = ""
    var isBarcodeAutoIncrementedEnabled = false
    var heartBeatViewModel:HeartBeatViewModel?
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    var listIdGet = Int()
    var listName = String()
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        addObserver()
        tapRec.addTarget(self, action: #selector(closeAddAnimalAndContinueOptions(tapGestureRecognizer:)))
        UserDefaults.standard.setValue(nil, forKey: keyValue.submitTypeSelection.rawValue)
        listIdGet = UserDefaults.standard.integer(forKey: keyValue.listIdSaveOnSelection.rawValue)
        listName = UserDefaults.standard.object(forKey: keyValue.listNameSaveOnSelection.rawValue) as! String
        dateTextField.keyboardType = .phonePad
        genotypeDateTextField.keyboardType = .phonePad
        dateTextField.borderStyle = .none
        dateTextField.delegate = self
        genotypeDateTextField.borderStyle = .none
        genotypeDateTextField.delegate = self
        heartBeatViewModel?.callGetHearBeatData()
        UserDefaults.standard.set(keyValue.brazilMarket.rawValue, forKey: keyValue.capsBrazil.rawValue)
        self.GenotypetextfieldLeftPadding()
        //merged
//        if isGenotypeOnlyAdded == true {
//            self.GenotypebyDefaultScreen()
//        } else {
//            self.byDefaultSetting()
//        }
        self.defaultIncrementalBarCodeSetting()
        self.defaultIncrementalBarCodeSetting_GenoType()
        otherBorderColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUIOnWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isGenotypeOnlyAdded {
            self.genotypeScanBarcodeTextField.becomeFirstResponder()
        } else {
            self.scanBarcodeTextfield.becomeFirstResponder()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.defaultIncrementalBarCodeSetting()
        self.defaultIncrementalBarCodeSetting_GenoType()
        removeObserver()
    }
    
    // MARK: - INITIAL UI AND OTHER METHODS
    func setUIOnWillAppear(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        let attributeString = NSMutableAttributedString(string: NSLocalizedString("Reset", comment: ""), attributes: self.attrs)
        clearFormOutlet.setAttributedTitle(attributeString, for: .normal)
        nonGenotypeclearFormOutlet.setAttributedTitle(attributeString, for: .normal)
        initialNetworkCheck()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        calenderView.isHidden = true
        calenderbkg.isHidden = true
        landIdApplangaugeConversion()
        let animalCount = fetchDataEnteryAnimalTblBeefDataBrazil(entityName: Entities.dataEntryBeefAnimalAddTblEntity,customerId:self.custmerId ?? 0,listId:Int64(self.listIdGet ),providerId:UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
        notificationLblCount.text = String(animalCount.count)
        if animalCount.count == 0{
            notificationLblCount.isHidden = true
            countLbl.isHidden = true
        }
        self.navigationController?.navigationBar.isHidden = true
        let selectedProduct = fetchAllData(entityName: Entities.getProductBeefTblEntity)
        let name = keyValue.geneStarBlack.rawValue
        for product in selectedProduct as? [GetProductTblBeef] ?? [] {
            if product.productName?.uppercased() == keyValue.genoTypeOnly.rawValue.uppercased() {
                UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                isGenotypeOnlyAdded = true
            }
            else if product.productName == name
            {
                UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                self.isGenostarblackOnlyAdded = true
            }
            else{
                UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                
            }
        }
        if (selectedProduct.count == 1 && isGenotypeOnlyAdded) || (selectedProduct.count == 3 && isGenotypeOnlyAdded) || (selectedProduct.count == 2 && isGenotypeOnlyAdded)
        {
            genotypeScrollView.isHidden = false
            scrolView.isHidden = true
            selectBreedBtn.isHidden = false
            selectbreeddropdown.isHidden = false
            
        }
        else if (selectedProduct.count == 1 && isGenostarblackOnlyAdded) || (selectedProduct.count == 3 && isGenostarblackOnlyAdded) || (selectedProduct.count == 2 && isGenostarblackOnlyAdded)
        {
            genotypeScrollView.isHidden = true
            scrolView.isHidden = false
            genstarblackBreedBtn.isHidden = false
            genstardropdown.isHidden = false
            
        }
        else if selectedProduct.count == 2 && (isGenostarblackOnlyAdded == true && isGenotypeOnlyAdded == true)
        {
            genotypeScrollView.isHidden = false
            scrolView.isHidden = true
            selectBreedBtn.isHidden = false
            selectbreeddropdown.isHidden = false
        }
        else if selectedProduct.count == 4
        {
            genotypeScrollView.isHidden = false
            scrolView.isHidden = true
            selectBreedBtn.isHidden = false
            selectbreeddropdown.isHidden = false
        }
        else
        {
            genstarblackBreedBtn.isHidden = true
            genstardropdown.isHidden = true
            genotypeScrollView.isHidden = true
            scrolView.isHidden = false
            otherBorderColor()
        }
        if isGenotypeOnlyAdded {
            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                genotypeDateTextField.isHidden = false
            } else {
                genotypeDateTextField.isHidden = true
            }
            genotypeScrollView.isHidden = false
            scrolView.isHidden = true
            if isGenostarblackOnlyAdded == true && isGenotypeOnlyAdded == true
            {
                UserDefaults.standard.set(keyValue.genoTypeStarBlack.rawValue, forKey: keyValue.beefProduct.rawValue)
            }
            else{
                UserDefaults.standard.set(keyValue.genoTypeOnly.rawValue, forKey: keyValue.beefProduct.rawValue)
            }
            if UserDefaults.standard.bool(forKey: keyValue.expandView.rawValue) == false {
                let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.expandFormStr, comment: ""), attributes: self.attrs)
                genoTypeExpandFormBtn.setAttributedTitle(attributeString, for: .normal)
                genoTypeSecondaryBreedHeight.constant = 0
                genoTypeSecondaryBrTop.constant = 0
                genoTypePriorityBreedHeight.constant = 0
                genoTypePriorityBrTop.constant = 0
                genoTypeAnimalNameHeight.constant = 0
                genoTypeAnimalNameTop.constant = 0
                genoTypePriorityBreedingDropDown.isHidden = true
                genoTypeSecondaryBreedingDropDown.isHidden = true
                genotypeTissueBttn.isHidden = false
                priorityBreeingBtnOutlet.isHidden = true
                secondaryBreddingOutlet.isHidden = true
                territoryBreddingOutlet.isHidden = true
                genotypeMaleFemaleBttn.isHidden = true
                tissueDropDownImage.isHidden = false
                selectBreedBtn.isHidden = true
                selectbreeddropdown.isHidden = true
            }
            else {
                let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.collapseFormStr, comment: ""), attributes: self.attrs)
                genoTypeExpandFormBtn.setAttributedTitle(attributeString, for: .normal)
            }
        }
        else {
            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                dateTextField.isHidden = false
            } else {
                dateTextField.isHidden = true
            }
            
            if isGenostarblackOnlyAdded == true
            {
                UserDefaults.standard.set(keyValue.genStarBlack.rawValue, forKey: keyValue.beefProduct.rawValue)
            }
            else
            {
                UserDefaults.standard.set(keyValue.nonGenoType.rawValue, forKey: keyValue.beefProduct.rawValue)
            }
            genotypeScrollView.isHidden = true
            scrolView.isHidden = false
            
            if UserDefaults.standard.bool(forKey: keyValue.expandView.rawValue) == false {
                let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.expandFormStr, comment: ""), attributes: self.attrs)
                nonGenoExpandOutlet.setAttributedTitle(attributeString, for: .normal)
                nonGenoAnimalNameHeight.constant = 0
                nonGenoAnimalNameTop.constant = 0
                maleFemaleBttn.isHidden = true
                tissueImageDown.isHidden = false
                tissueBttn.isHidden = false
                genstarblackBreedBtn.isHidden = true
                genstardropdown.isHidden = true
            }
            else {
                let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.collapseFormStr, comment: ""), attributes: self.attrs)
                nonGenoExpandOutlet.setAttributedTitle(attributeString, for: .normal)
            }
        }
        otherBorderColor()
        genotypeSetBorder()
        autoD = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        timeStampString = timeStamp()
        UserDefaults.standard.set(timeStampString, forKey: keyValue.timeStamp.rawValue)
        timeStampString = UserDefaults.standard.value(forKey: keyValue.timeStamp.rawValue) as? String ?? ""
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncrementalClear.rawValue) == false {
            self.isBarcodeAutoIncrementedEnabled = false
            //merged
//            if isGenotypeOnlyAdded == true {
//                self.GenotypebyDefaultScreen()
//            }
//            else {
//                self.byDefaultSetting()
//            }
        }
        if UserDefaults.standard.integer(forKey: keyValue.beefAnimalIdSelectionCart.rawValue) > 0 {
            let temp = UserDefaults.standard.integer(forKey: keyValue.beefAnimalIdSelectionCart.rawValue)
            animalIdBool = true
            othersByDefaultBackroundWhite()
            UserDefaults.standard.set(0, forKey: keyValue.beefAnimalIdSelectionCart.rawValue)
            dataPopulateInScreen(animalId: temp)
            isautoPopulated = true
            barAutoPopu = true
            messageCheck = true
        }
        
        if isGenotypeOnlyAdded {
            self.genotypeScanBarcodeTextField.becomeFirstResponder()
        } else {
            self.scanBarcodeTextfield.becomeFirstResponder()
        }
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        breedArrblack = fetchproviderProductDataGlobal(entityName: Entities.getBreedsTblEntity, provId: pvid, productId: 24, speciesName: "")
        breedArr = fetchproviderProductDataGlobal(entityName: Entities.getBreedsTblEntity, provId: pvid, productId: 23, speciesName: "")
        tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
        for items in tissueArr
        {
            let tissue = items  as? GetSampleTbl
            let checkdefault  = tissue?.isDefault
            
            if checkdefault == true
            {
                genotypeTissueBttn.setTitle(tissue?.sampleName, for: .normal)
                tissueBttn.setTitle(tissue?.sampleName, for: .normal)
            }
        }
        let breed = self.breedArrblack[0] as! GetBreedsTbl
        let breed1 = self.breedArr[0] as! GetBreedsTbl
        
        if breedArrblack.count != 0 {
            for i in 0 ..< breedArrblack.count{
                let obj = breedArrblack[i] as! GetBreedsTbl
                tempbreedblackname.append(obj.breedName ?? "")
                
            }
        }
        if breedArr.count != 0 {
            for i in 0 ..< breedArr.count{
                let obj = breedArr[i] as! GetBreedsTbl
                tempbreedarraynames.append(obj.breedName ?? "")
                
            }
        }
        
        commomNamebreed = tempbreedblackname.filter{ tempbreedarraynames.contains($0) } as NSArray
        if commomNamebreed.count != 0 {
            for i in 0 ..< breedArr.count{
                let obj = breedArr[i] as! GetBreedsTbl
                if commomNamebreed.contains(obj.breedName as Any)
                {
                    tempbreedarraynames1.append(obj.breedId ?? "")
                    tempbreedarraynames2.append(obj.threeCharCode ?? "")
                }
            }
        }
        
        if isGenotypeOnlyAdded && isGenostarblackOnlyAdded
        {
            selectBreedBtn.setTitle(tempbreedarraynames2[0], for: .normal)
        }
        else
        {
            selectBreedBtn.setTitle(breed1.threeCharCode, for: .normal)
            
        }
        othersByDefaultBackroundWhite()
        genstarblackBreedBtn.setTitle(breed.threeCharCode, for: .normal)
        if UserDefaults.standard.value(forKey: "DENonGenoGender") as? String == "F" ||  UserDefaults.standard.value(forKey: "DENonGenoGender") as? String == nil {
            self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 0
            UserDefaults.standard.set("F", forKey: "DENonGenoGender")
            genderString = "Female"
        } else {
            self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 1
            UserDefaults.standard.set("M", forKey: "DENonGenoGender")
            genderString = "Male"
        }
    }
    
    func defaultIncrementalBarCodeSetting() {
        incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
        incrementalBarcodeTitleLabel.text = NSLocalizedString(ButtonTitles.incrementalBarcodeText, comment: "")
    }
    func defaultIncrementalBarCodeSetting_GenoType() {
        incrementalBarcodeCheckBoxGenoType.image = UIImage(named: ImageNames.incrementalCheckImg)
        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
        incrementalBarcodeTitleLabelGenoType.text = NSLocalizedString(ButtonTitles.incrementalBarcodeText, comment: "")
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
    
    func timeStamp()-> String{
        let time1 = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatters.MMddyyyyHHmmssFormat
        let timestamp = formatter.string(from: time1 as Date)
        lblTimeStamp = timestamp.replacingOccurrences(of: "-", with: "", options: .regularExpression)
        lblTimeStamp = lblTimeStamp.replacingOccurrences(of: ":", with: "", options: .regularExpression)
        let string = lblTimeStamp as String
        let charset = CharacterSet(charactersIn: "i")
        if string.rangeOfCharacter(from: charset) != nil {
        }
        let udid = UserDefaults.standard.value(forKey: keyValue.applicationIdentifier.rawValue)! as! String
        let sessionGUID1 =   lblTimeStamp + "_" + String(describing: autoD as Int)
        lblTimeStamp = sessionGUID1 + "_" + "iOS" + "_" + String(udid)
        return lblTimeStamp
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
            if smallDate == false {
                return LocalizedStrings.greaterThenDateStr
            }
            return LocalizedStrings.correctFormatStr
        }
        else {
            return  LocalizedStrings.invalidFormatStr
        }
    }
    
    func dataPopulateInScreen(animalId:Int){
        isautoPopulated = true
        barAutoPopu = true
        var animalFetch = NSArray()
        if !isGenotypeOnlyAdded {
            othersByDefaultBackroundWhite()
            if animalIdBool == true {
                animalFetch = fetchAllDataWithAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId: animalId, customerID: custmerId!)
                let data = animalFetch.object(at: 0) as! DataEntryBeefAnimaladdTbl
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                animalId1 = Int(data.animalId)
                barcodeView.layer.borderColor = UIColor.gray.cgColor
                rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                animalTextfield.layer.borderColor = UIColor.gray.cgColor
                serieTextfield.layer.borderColor = UIColor.gray.cgColor
                dateBttnOutlet.titleLabel?.text = ""
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                self.isBarcodeAutoIncrementedEnabled = false
                incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                incrementalBarcodeButton.isEnabled = false
                incrementalBarcodeTitleLabel.textColor = .gray
                self.isBarcodeAutoIncrementedEnabled = false
                checkBarcode = false
                incrementalBarcodeTitleLabelGenoType.textColor = .gray
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
                            
                        }
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            dateTextField.text = dateVale
                        }
                        else {
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
                        }
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            dateTextField.text = dateVale
                        }
                        else {
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
                        }
                        formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                    }
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                    }
                    else {
                        if dateBttnOutlet.titleLabel!.text != nil{
                            self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                        }
                        else{
                            self.selectedDate = Date()
                        }
                    }
                }
                scanBarcodeTextfield.text = data.animalTag
                rGNTextfield.text = data.offPermanentId
                serieTextfield.text = data.offsireId
                rGDTextfield.text = data.offDamId
                tissueBttn.setTitleColor(.black, for: .normal)
                animalTextfield.text = data.animalbarCodeTag
                tissueBttn.setTitle(data.tissuName, for: .normal)
                UserDefaults.standard.set(data.tissuName, forKey: keyValue.dataEntrytissueBttn.rawValue)
                breedId = data.breedId!
                if data.gender == ButtonTitles.maleText.localized || data.gender == "M"{
                    self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 1
                    genderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
                }
                else {
                    self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 0
                    genderString = ButtonTitles.femaleText.localized
                }
                tissuId = Int(data.tissuId)
                dateBttnOutlet.setTitleColor(.black, for: .normal)
                let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
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
                    UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                    barcodeView.layer.borderColor = UIColor.gray.cgColor
                    rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                    rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                    animalTextfield.layer.borderColor = UIColor.gray.cgColor
                    serieTextfield.layer.borderColor = UIColor.gray.cgColor
                    dateBttnOutlet.titleLabel?.text = ""
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
                            }
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
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
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
                            formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                        }
                        if dateBttnOutlet.titleLabel!.text != nil{
                            self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                        }
                        else{
                            self.selectedDate = Date()
                        }
                    }
                    scanBarcodeTextfield.text = data.animalTag
                    rGNTextfield.text = data.offPermanentId
                    serieTextfield.text = data.offsireId
                    rGDTextfield.text = data.offDamId
                    tissueBttn.setTitleColor(.black, for: .normal)
                    animalTextfield.text = data.animalbarCodeTag
                    tissueBttn.setTitle(data.tissuName, for: .normal)
                    UserDefaults.standard.set(data.tissuName, forKey: keyValue.dataEntrytissueBttn.rawValue)
                    breedId = data.breedId!
                    
                    if data.gender == ButtonTitles.maleText.localized || data.gender == "M"{
                        self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                        genderToggleFlag = 1
                        genderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
                    }
                    else {
                        self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                        genderToggleFlag = 0
                        genderString = ButtonTitles.femaleText.localized
                    }
                    
                    tissuId = Int(data.tissuId)
                    dateBttnOutlet.setTitleColor(.black, for: .normal)
                    let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
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
            if animalIdBool == true {
                animalFetch = fetchAllDataWithAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId: animalId, customerID: custmerId!)
                let data = animalFetch.object(at: 0) as! DataEntryBeefAnimaladdTbl
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                animalId1 = Int(data.animalId)
                genotypeDOBBttn.titleLabel?.text = ""
                //1.10
//                genotypeScanBarcodeTextField.layer.borderColor = UIColor.gray.cgColor
//                genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
//                genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
//                genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
                let formatter = DateFormatter()
                if data.date != "" {
                    if dateStr == "MM"{
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        if values.count > 1 {
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = month + "/" + date + "/" + year
                        }
                        
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            genotypeDateTextField.text = dateVale
                        }
                        else {
                            genotypeDOBBttn.setTitle(dateVale, for: .normal)
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
                        }
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            genotypeDateTextField.text = dateVale
                        }
                        else {
                            genotypeDOBBttn.setTitle(dateVale, for: .normal)
                            
                        }
                        formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                    }
                    
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                    }
                    else {
                        if genotypeDOBBttn.titleLabel!.text != nil{
                            self.selectedDate = formatter.date(from: genotypeDOBBttn.titleLabel!.text!)!
                        }
                        else{
                            self.selectedDate = Date()
                        }
                    }
                }
                genotypeScanBarcodeTextField.text = data.animalTag
                genotypeRgnTextfield.text = data.offPermanentId
                genotypeSerieTextfield.text = data.offsireId
                genotypeRgdTextfield.text = data.offDamId
                genotypeAnimalNameTextfield.text = data.animalbarCodeTag
                if data.sireIDAU == "" {
                    if let primary = UserDefaults.standard.object(forKey: keyValue.dataListPrimaryGenoType.rawValue)
                    {
                        priorityBreeingBtnOutlet.setTitle(primary as? String ,for: .normal)
                    } else{
                        priorityBreeingBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectPrimaryBreed, comment: "") ,for: .normal)
                    }
                } else {
                    priorityBreeingBtnOutlet.setTitle(data.sireIDAU ,for: .normal)
                }
                genotypeTissueBttn.setTitleColor(.black, for: .normal)
                priorityBreeingBtnOutlet.setTitleColor(.black, for: .normal)
                genotypeTissueBttn.setTitle(data.tissuName, for: .normal)
                secondaryBreddingOutlet.setTitleColor(.black, for: .normal)
                territoryBreddingOutlet.setTitleColor(.black, for: .normal)
                
                if data.nationHerdAU == ""{
                    if let secondary = UserDefaults.standard.object(forKey: keyValue.dataListSecondaryGenoType.rawValue)
                    {
                        secondaryBreddingOutlet.setTitle(secondary as? String ,for: .normal)
                    } else{
                        secondaryBreddingOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectSecondaryBreed, comment: ""), for: .normal)
                    }
                }
                else {
                    secondaryBreddingOutlet.setTitle(data.nationHerdAU, for: .normal)
                }
                if data.tertiaryGeno == "" {
                    
                    if let  territory = UserDefaults.standard.object(forKey: keyValue.dataListTertirayGenoType.rawValue)
                    {
                        territoryBreddingOutlet.setTitle(territory as? String ,for: .normal)
                    } else{
                        territoryBreddingOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectTertiaryBreed, comment: "") ,for: .normal)
                    }
                }
                else {
                    territoryBreddingOutlet.setTitle(data.tertiaryGeno ,for: .normal)
                }
                
                UserDefaults.standard.set(data.tissuName, forKey: keyValue.dataEntrygenotypeTissueBttn.rawValue)
                breedId = data.breedId!
                UserDefaults.standard.set(data.sireIDAU, forKey: keyValue.priorityBreedName.rawValue)
                if data.gender == ButtonTitles.maleText.localized || data.gender == "M"{
                    self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 1
                    genderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
                }
                else {
                    self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 0
                    genderString = ButtonTitles.femaleText.localized
                }
                incrementalBarcodeTitleLabelGenoType.textColor = .gray
                tissuId = Int(data.tissuId)
                genotypeDOBBttn.setTitleColor(.black, for: .normal)
                let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
                animalIdBool = false
                
                if adata.count > 0{
                    let animal  = adata.object(at: 0) as! BeefAnimalMaster
                    idAnimal = Int(animal.animalId)
                }
                
            } else {
                animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal, customerID: custmerId!)
                if animalFetch.count > 0 {
                    let  data = animalFetch.object(at: 0) as! BeefAnimalMaster
                    let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                    animalId1 = Int(data.animalId)
                    genotypeDOBBttn.titleLabel?.text = ""
                    genotypeScanBarcodeTextField.layer.borderColor = UIColor.gray.cgColor
                    genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                    let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
                    let formatter = DateFormatter()
                    if data.date != "" {
                        
                        if dateStr == "MM"{
                            var dateVale = ""
                            let values = data.date!.components(separatedBy: "/")
                            if values.count > 1 {
                                let date = values[0]
                                let month = values[1]
                                let year = values[2]
                                dateVale = month + "/" + date + "/" + year
                            }
                            genotypeDOBBttn.setTitle(dateVale, for: .normal)
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
                            genotypeDOBBttn.setTitle(dateVale, for: .normal)
                            formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                        }
                        if genotypeDOBBttn.titleLabel!.text != nil{
                            self.selectedDate = formatter.date(from: genotypeDOBBttn.titleLabel!.text!)!
                            
                        }
                        else{
                            self.selectedDate = Date()
                        }
                    }
                    genotypeScanBarcodeTextField.text = data.animalTag
                    genotypeRgnTextfield.text = data.offPermanentId
                    genotypeSerieTextfield.text = data.offsireId
                    genotypeRgdTextfield.text = data.offDamId
                    genotypeAnimalNameTextfield.text = data.animalbarCodeTag
                    priorityBreeingBtnOutlet.setTitle(data.sireIDAU ,for: .normal)
                    genotypeTissueBttn.setTitleColor(.black, for: .normal)
                    priorityBreeingBtnOutlet.setTitleColor(.black, for: .normal)
                    genotypeTissueBttn.setTitle(data.tissuName, for: .normal)
                    secondaryBreddingOutlet.setTitleColor(.black, for: .normal)
                    secondaryBreddingOutlet.setTitle(data.nationHerdAU, for: .normal)
                    territoryBreddingOutlet.setTitleColor(.black, for: .normal)
                    territoryBreddingOutlet.setTitle(data.tertiaryGeno, for: .normal)
                    UserDefaults.standard.set(data.tissuName, forKey: keyValue.dataEntrygenotypeTissueBttn.rawValue)
                    breedId = data.breedId!
                    UserDefaults.standard.set(data.sireIDAU, forKey: keyValue.priorityBreedName.rawValue)
                    if data.gender == ButtonTitles.maleText.localized || data.gender == "M"{
                        self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                        genderToggleFlag = 1
                        genderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
                    }
                    else {
                        self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                        genderToggleFlag = 0
                        genderString = ButtonTitles.femaleText.localized
                        
                    }
                    
                    tissuId = Int(data.tissuId)
                    genotypeDOBBttn.setTitleColor(.black, for: .normal)
                    let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
                    animalIdBool = false
                    if adata.count > 0{
                        let animal  = adata.object(at: 0) as! BeefAnimalMaster
                        idAnimal = Int(animal.animalId)
                        statusOrder = true
                    }
                }
            }
        }
    }
    
    func statusOrderTrue() -> Bool{
        let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal, customerID: custmerId!)
        if animalFetch.count > 0{
            statusOrder = true
            return true
        } else {
            return false
        }
    }
    
    func otherBorderColor(){
        serieTextfield.layer.cornerRadius = (serieTextfield.frame.size.height / 2)
        serieTextfield.layer.borderWidth = 0.5
        serieTextfield.layer.borderColor = UIColor.gray.cgColor
        serieTextfield.layer.masksToBounds = true
        rGNTextfield.layer.cornerRadius = (rGNTextfield.frame.size.height / 2)
        rGNTextfield.layer.borderWidth = 0.5
        rGNTextfield.layer.borderColor = UIColor.gray.cgColor
        rGNTextfield.layer.masksToBounds = true
        rGDTextfield.layer.cornerRadius = (rGDTextfield.frame.size.height / 2)
        rGDTextfield.layer.borderWidth = 0.5
        rGDTextfield.layer.borderColor = UIColor.gray.cgColor
        rGDTextfield.layer.masksToBounds = true
        animalTextfield.layer.cornerRadius = (animalTextfield.frame.size.height / 2)
        animalTextfield.layer.borderWidth = 0.5
        animalTextfield.layer.borderColor = UIColor.gray.cgColor
        animalTextfield.layer.masksToBounds = true
        barcodeView.layer.cornerRadius = (barcodeView.frame.size.height / 2)
        barcodeView.layer.borderWidth = 0.5
        barcodeView.layer.borderColor = UIColor.gray.cgColor
        barcodeView.layer.masksToBounds = true
        dobView.layer.cornerRadius = (dobView.frame.size.height / 2)
        dobView.layer.borderWidth = 0.5
        dobView.layer.borderColor = UIColor.gray.cgColor
        dobView.layer.masksToBounds = true
        tissueBttn.layer.borderWidth = 0.5
        tissueBttn.layer.borderColor = UIColor.gray.cgColor
        genstarblackBreedBtn.layer.borderWidth = 0.5
        genstarblackBreedBtn.layer.borderColor = UIColor.gray.cgColor
    }
    
    func othersByDefaultBackroundWhite(isBeginEditing: Bool = false){
        nonGenoExpandOutlet.alpha = 1
        nonGenoExpandOutlet.isEnabled = true
        genoTypeExpandFormBtn.alpha = 1
        genoTypeExpandFormBtn.isEnabled = true
        dateOfLbl.textColor = UIColor.black
        dobLbl.textColor = UIColor.black
        scanBarcodeTextfield.layer.backgroundColor = UIColor.white.cgColor
        serieTextfield.backgroundColor = .white
        rGNTextfield.backgroundColor = .white
        rGDTextfield.layer.backgroundColor = UIColor.white.cgColor
        animalTextfield.layer.backgroundColor = UIColor.white.cgColor
        dateBttnOutlet.layer.backgroundColor = UIColor.white.cgColor
        tissueBttn.layer.backgroundColor = UIColor.white.cgColor
        genstarblackBreedBtn.layer.backgroundColor = UIColor.white.cgColor
        serieTextfield.isEnabled = true
        rGNTextfield.isEnabled = true
        rGDTextfield.isEnabled = true
        animalTextfield.isEnabled = true
        dateBttnOutlet.isEnabled = true
        tissueBttn.isEnabled = true
        maleFemaleBttn.isEnabled = true
        dateBttnOutlet.isEnabled = true
        genstarblackBreedBtn.isEnabled = true
        genstarblackBreedBtn.setTitleColor(.black, for: .normal)
        tissueBttn.setTitleColor(.black, for: .normal)
        dateBttnOutlet.setTitleColor(.black, for: .normal)
        incrementalBarcodeTitleLabel.textColor = UIColor.black
        incrementalBarcodeButton.isEnabled = true
        dateTextField.isEnabled = true
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true && isBeginEditing == false {
            if let lastSavedBarCode = UserDefaults.standard.value(forKey: keyValue.barcodeIncremental.rawValue) as? String {
                scanBarcodeTextfield.text = isBarCodeEndsWithNumber_GetIncrementedBarCode(lastSavedBarCode).incrementedBarCode
            }
        }
    }
    func resetAllField () {
        let dateformt = DateFormatter()
        let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        if dateStr == "MM" {
            dateformt.dateFormat = DateFormatters.MMddyyyyFormat
            dateTextField.placeholder = DateFormatters.MMDDYYYYFormat
            genotypeDateTextField.placeholder = DateFormatters.MMDDYYYYFormat
        } else {
            dateformt.dateFormat = DateFormatters.ddMMyyyyFormat
            dateTextField.placeholder = DateFormatters.DDMMYYYYFormat
            genotypeDateTextField.placeholder = DateFormatters.DDMMYYYYFormat
            
        }
        dateBttnOutlet.setTitle("", for: .normal)
//        self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
//        genderToggleFlag = 0
//        genderString = ButtonTitles.femaleText.localized
        if UserDefaults.standard.value(forKey: "DENonGenoGender") as? String == "F" ||  UserDefaults.standard.value(forKey: "DENonGenoGender") as? String == nil {
            self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 0
            UserDefaults.standard.set("F", forKey: "DENonGenoGender")
            genderString = "Female"
        } else {
            self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 1
            UserDefaults.standard.set("M", forKey: "DENonGenoGender")
            genderString = "Male"
        }
        if isGenotypeOnlyAdded {
            self.genotypeScanBarcodeTextField.becomeFirstResponder()
        } else {
            self.scanBarcodeTextfield.becomeFirstResponder()
        }
        scanBarcodeTextfield.text?.removeAll()
        serieTextfield.text?.removeAll()
        rGNTextfield.text?.removeAll()
        rGDTextfield.text?.removeAll()
        animalTextfield.text?.removeAll()
    }
    
    func byDefaultSetting(){
        let dateformt = DateFormatter()
        let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        
        if dateStr == "MM" {
            dateformt.dateFormat = DateFormatters.MMddyyyyFormat
            dateTextField.placeholder = DateFormatters.MMDDYYYYFormat
            genotypeDateTextField.placeholder = DateFormatters.MMDDYYYYFormat
        } else {
            dateformt.dateFormat = DateFormatters.ddMMyyyyFormat
            dateTextField.placeholder = DateFormatters.DDMMYYYYFormat
            genotypeDateTextField.placeholder = DateFormatters.DDMMYYYYFormat
            
        }
        dateOfLbl.textColor = UIColor.gray
        dobLbl.textColor = UIColor.gray
        nonGenoExpandOutlet.alpha = 0.4
        nonGenoExpandOutlet.isEnabled = true
        genoTypeExpandFormBtn.alpha = 0.4
        genoTypeExpandFormBtn.isEnabled = true
        animalId1 = 0
        idAnimal = 0
        isUpdate = false
        msgUpatedd = false
        self.msgcheckk = false
        self.isautoPopulated = false
        barAutoPopu = false
        selectBreedBtn.setTitleColor(UIColor.gray, for: .normal)
        dateBttnOutlet.setTitleColor(UIColor.gray, for: .normal)
        dateBttnOutlet.setTitle("", for: .normal)
        serieTextfield.layer.borderColor = UIColor.gray.cgColor
        rGNTextfield.layer.borderColor = UIColor.gray.cgColor
        rGDTextfield.layer.borderColor = UIColor.gray.cgColor
        animalTextfield.layer.borderColor = UIColor.gray.cgColor
        dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
        dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
        scanBarcodeTextfield.text?.removeAll()
        serieTextfield.text?.removeAll()
        rGNTextfield.text?.removeAll()
        rGDTextfield.text?.removeAll()
        animalTextfield.text?.removeAll()
//        self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
//        genderToggleFlag = 0
//        genderString = ButtonTitles.femaleText.localized
        
        if UserDefaults.standard.value(forKey: "DENonGenoGender") as? String == "F" ||  UserDefaults.standard.value(forKey: "DENonGenoGender") as? String == nil {
            self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 0
            UserDefaults.standard.set("F", forKey: "DENonGenoGender")
            genderString = "Female"
        } else {
            self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 1
            UserDefaults.standard.set("M", forKey: "DENonGenoGender")
            genderString = "Male"
        }
        
        //merged
        //OtherbyTextfieldGray()
        self.scrolView.contentOffset.y = 0.0
        incrementalBarcodeTitleLabel.textColor = .gray
        incrementalBarcodeButton.isEnabled = false
        if isGenotypeOnlyAdded {
            self.genotypeScanBarcodeTextField.becomeFirstResponder()
        } else {
            self.scanBarcodeTextfield.becomeFirstResponder()
        }
    }
    
    func OtherbyTextfieldGray(){
        nonGenoExpandOutlet.alpha = 0.4
        nonGenoExpandOutlet.isEnabled = true
        genoTypeExpandFormBtn.alpha = 0.4
        genoTypeExpandFormBtn.isEnabled = true
        dobLbl.textColor = UIColor.gray
        dateOfLbl.textColor = UIColor.gray
        barcodeView.layer.borderColor = UIColor.gray.cgColor
        serieTextfield.layer.borderColor = UIColor.gray.cgColor
        rGNTextfield.layer.borderColor = UIColor.gray.cgColor
        rGDTextfield.layer.borderColor = UIColor.gray.cgColor
        serieTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        rGNTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        rGDTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        animalTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        dateBttnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        dobView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        tissueBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genstarblackBreedBtn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        serieTextfield.isEnabled = false
        genstarblackBreedBtn.isEnabled = false
        rGNTextfield.isEnabled = false
        rGDTextfield.isEnabled = false
        animalTextfield.isEnabled = false
        dateBttnOutlet.isEnabled = false
        tissueBttn.isEnabled = false
        maleFemaleBttn.isEnabled = false
        dateBttnOutlet.isEnabled = false
        tissueBttn.setTitleColor(.gray, for: .normal)
        dateBttnOutlet.setTitleColor(.gray, for: .normal)
        genstarblackBreedBtn.setTitleColor(.gray, for: .normal)
        dateTextField.isEnabled = false
        dateTextField.text = ""
    }
    
    func validation(){
        
        if  rGDTextfield.text == ""{
            requiredflag = 0
            rGDTextfield.layer.borderColor = UIColor.red.cgColor
        }
        if requiredflag == 1{
            serieTextfield.layer.borderColor = UIColor.gray.cgColor
            rGNTextfield.layer.borderColor = UIColor.gray.cgColor
            rGDTextfield.layer.borderColor = UIColor.gray.cgColor
        }
        else{
            rGDTextfield.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    func tableViewpop() {
        buttonbg2.frame = CGRect(x:0,y: 0,width: 1024,height: 1000)
        buttonbg2.addTarget(self, action:#selector(DataEntryBeefAnimalBrazilVC.buttonPreddDroper), for: .touchUpInside)
        buttonbg2.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        self.view.addSubview(buttonbg2)
        droperTableView.delegate = self
        droperTableView.dataSource = self
        droperTableView.layer.cornerRadius = 8.0
        droperTableView.layer.borderWidth = 0.5
        droperTableView.layer.borderColor =  UIColor.gray.cgColor
        buttonbg2.addSubview(droperTableView)
    }
    
    func textFieldValidation(){
        genotypeScanBarcodeView.layer.borderColor = UIColor.gray.cgColor
        if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
            if priorityBreeingBtnOutlet.titleLabel?.text  == ButtonTitles.ciadeMelhoramentoText{
                requiredflag = 1
            }else{
                requiredflag = 0
            }
        }
        
        if requiredflag == 1 {
            genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
            genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
        } else {
            genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
            genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    func landIdApplangaugeConversion(){
        animalTextfield.placeholder = NSLocalizedString(ButtonTitles.enterAnimalName, comment: "")
        dobLbl.text = ButtonTitles.dateOfBirthText.localized
        maleFemaleBttn.setTitle("",for: .normal)
        self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
        for items in self.tissueArr
        {
            let tissue = items  as? GetSampleTbl
            let checkdefault  = tissue?.isDefault
            
            if checkdefault == true
            {
                self.tissueBttn.setTitle(tissue?.sampleName, for: .normal)
                self.tissuId =  Int(tissue?.sampleId ?? 4)
            }
        }
        
        rGDTextfield.placeholder = NSLocalizedString(LocalizedStrings.RGDorAnimalIDText, comment: "")
        rGNTextfield.placeholder = NSLocalizedString(LocalizedStrings.RGNText, comment: "")
        serieTextfield.placeholder = NSLocalizedString(LocalizedStrings.seriesText, comment: "")
        scanBarcodeTextfield.placeholder = NSLocalizedString(ButtonTitles.enterSampleBarcode, comment: "")
        addAnimalTtilte.text = NSLocalizedString(ButtonTitles.addAnimalText, comment: "")
        genotypeScanBarcodeTextField.placeholder = NSLocalizedString(ButtonTitles.enterSampleBarcode, comment: "")
        genotypeSerieTextfield.placeholder = NSLocalizedString(LocalizedStrings.seriesText, comment: "")
        genotypeRgnTextfield.placeholder = NSLocalizedString(LocalizedStrings.RGNText, comment: "")
        genotypeAnimalNameTextfield.placeholder = NSLocalizedString(ButtonTitles.enterAnimalName, comment: "")
        genotypeRgdTextfield.placeholder = NSLocalizedString(LocalizedStrings.RGDorAnimalIDText, comment: "")
        priorityBreeingBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectPrimaryBreed, comment: ""),for: .normal)
        secondaryBreddingOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectSecondaryBreed, comment: ""),for: .normal)
        territoryBreddingOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectTertiaryBreed, comment: ""),for: .normal)
        dateOfLbl.text = NSLocalizedString(ButtonTitles.dateOfBirthText, comment: "")
        appStatusTitleLbl.text = NSLocalizedString(ButtonTitles.appStatusText, comment: "")
        nonGenoReviewTtilt.setTitle(NSLocalizedString(ButtonTitles.reviewDataText, comment: ""), for: .normal)
        addAnpthertITLE.setTitle(NSLocalizedString(ButtonTitles.addAnotherAnimalText, comment: ""), for: .normal)
        reviewBtnTitle.setTitle(NSLocalizedString(ButtonTitles.reviewDataText, comment: ""), for: .normal)
        addAnotherBtnTtile.setTitle(NSLocalizedString(ButtonTitles.addAnotherAnimalText, comment: ""), for: .normal)
        bckBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.backBtnText, comment: ""), for: .normal)
        nonGenoBckBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.backBtnText, comment: ""), for: .normal)
    }
    
    func autoPop(animalData:NSArray) {
        if animalData.count > 0 {
            isautoPopulated = true
            barAutoPopu = true
            barcodeflag = false
            updateOrder = true
            let data =  animalData.lastObject as! BeefAnimalMaster
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            animalId1 = Int(data.animalId)
            dateBttnOutlet.titleLabel!.text = ""
            barcodeView.layer.borderColor = UIColor.gray.cgColor
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
                    }
                    dateBttnOutlet.setTitle(dateVale, for: .normal)
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
                    dateBttnOutlet.setTitle(dateVale, for: .normal)
                    formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                }
                if dateBttnOutlet.titleLabel!.text != nil{
                    self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                }
                else{
                }
            }
            if data.orderstatus == "false"{
                scanBarcodeTextfield.text =  data.animalTag
            }
            rGNTextfield.text = data.offPermanentId
            serieTextfield.text = data.offsireId
            rGDTextfield.text = data.offDamId
            tissueBttn.setTitleColor(.black, for: .normal)
            animalTextfield.text = data.animalbarCodeTag
            tissueBttn.setTitle(data.tissuName, for: .normal)
            UserDefaults.standard.set(data.tissuName, forKey: keyValue.dataEntrytissueBttn.rawValue)
            breedId = String(data.breedId ?? "")
            UserDefaults.standard.set(breedId, forKey: keyValue.dataEntryBeefbreed.rawValue)
            
            if data.gender == ButtonTitles.maleText.localized || data.gender == "M" {
                self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                genderToggleFlag = 1
                genderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
            }
            else {
                self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                genderToggleFlag = 0
                genderString = ButtonTitles.femaleText.localized
            }
            
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
            
            if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                requiredflag = 0
            }
            else{
                if isautoPopulated == true{
                    requiredflag = 1
                }
                else{
                    requiredflag = 0
                }
            }
            if requiredflag == 1{
                serieTextfield.layer.borderColor = UIColor.gray.cgColor
                rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                rGDTextfield.layer.borderColor = UIColor.gray.cgColor
            }
            else{
                serieTextfield.layer.borderColor = UIColor.red.cgColor
                rGNTextfield.layer.borderColor = UIColor.red.cgColor
                rGDTextfield.layer.borderColor = UIColor.red.cgColor
            }
            UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
            
        }
        if animalData.count > 0 {
            isautoPopulated = true
            barAutoPopu = true
            updateOrder = true
            let data =  animalData.lastObject as! BeefAnimalMaster
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            animalId1 = Int(data.animalId)
            UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
            genotypeDOBBttn.titleLabel?.text = ""
            genotypeScanBarcodeTextField.layer.borderColor = UIColor.gray.cgColor
            genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
            genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
            genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
            let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
            let formatter = DateFormatter()
            if data.date != "" {
                if dateStr == "MM"{
                    var dateVale = ""
                    let values = data.date!.components(separatedBy: "/")
                    if values.count > 1 {
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        dateVale = month + "/" + date + "/" + year
                    }
                    genotypeDOBBttn.setTitle(dateVale, for: .normal)
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
                    genotypeDOBBttn.setTitle(dateVale, for: .normal)
                    formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                }
                if  genotypeDOBBttn.titleLabel!.text != nil {
                    if  genotypeDOBBttn.titleLabel?.text != "" && formatter.date(from: genotypeDOBBttn.titleLabel?.text ?? "") != nil {
                        self.selectedDate = formatter.date(from: genotypeDOBBttn.titleLabel?.text ?? "")!
                    }
                }
                else{
                    self.selectedDate = Date()
                }
            }
            if data.orderstatus == "false"{
                genotypeScanBarcodeTextField.text = data.animalTag
            }
            
            genotypeRgnTextfield.text = data.offPermanentId
            genotypeSerieTextfield.text = data.offsireId
            genotypeRgdTextfield.text = data.offDamId
            genotypeAnimalNameTextfield.text = data.animalbarCodeTag
            priorityBreeingBtnOutlet.setTitle(data.sireIDAU ,for: .normal)
            genotypeTissueBttn.setTitleColor(.black, for: .normal)
            priorityBreeingBtnOutlet.setTitleColor(.black, for: .normal)
            genotypeTissueBttn.setTitle(data.tissuName, for: .normal)
            secondaryBreddingOutlet.setTitleColor(.black, for: .normal)
            secondaryBreddingOutlet.setTitle(data.nationHerdAU, for: .normal)
            territoryBreddingOutlet.setTitleColor(.black, for: .normal)
            territoryBreddingOutlet.setTitle(data.tertiaryGeno, for: .normal)
            UserDefaults.standard.set(data.tissuName, forKey: keyValue.dataEntryBeefInheritTsu.rawValue)
            breedId = String(data.breedId ?? "")
            UserDefaults.standard.set(data.sireIDAU, forKey: keyValue.priorityBreedName.rawValue)
            if data.gender == ButtonTitles.maleText.localized || data.gender == "M"{
                
                self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                genderToggleFlag = 1
                genderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
            }
            else {
                self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                genderToggleFlag = 0
                genderString = ButtonTitles.femaleText.localized
            }
            tissuId = Int(data.tissuId)
            genotypeDOBBttn.setTitleColor(.black, for: .normal)
            statusOrder = false
            messageCheck = false
            let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
            if adata.count > 0{
                let animal  = adata.object(at: 0) as! BeefAnimalMaster
                idAnimal = Int(animal.animalId)
                //statusOrder = true
                messageCheck = true
            }
            if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                if priorityBreeingBtnOutlet.titleLabel?.text  == ButtonTitles.ciadeMelhoramentoText{
                    requiredflag = 1
                }else{
                    requiredflag = 0
                }
            }
            else{
                if isautoPopulated == true{
                    requiredflag = 1
                }
                else{
                    requiredflag = 0
                }
            }
            if requiredflag == 1{
                genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
            }
            else{
                genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
            }
        }
    }
    
    func addAnimalBtn(completionHandler: @escaping CompletionHandler){
        if breedId == ""
        {
            let breed = self.breedArrblack[0] as! GetBreedsTbl
            breedId = breed.breedId ?? ""
        }
        
        if barcodeEnable == true {
            let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId!)
            if orederStatus.count > 0 {
                
                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalAlreadyUsedStr, comment: ""), preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId: self.idAnimal, customerID: self.custmerId!)
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
            if !isGenotypeOnlyAdded {
                if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                    requiredflag = 0
                }
                else{
                    requiredflag = 1
                }
                
                if requiredflag == 0{
                    if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                        self.validation()
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.enterValueInSeries, comment: ""))
                        completionHandler(false)
                        return
                    }
                }
                else {
                    if !isGenotypeOnlyAdded {
                        addBtnCondtion(completionHandler: { (success) -> Void in
                            print("--> success")
                            completionHandler(true)
                        })
                    }
                }
            }
            else{
                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                    if priorityBreeingBtnOutlet.titleLabel?.text  == ButtonTitles.ciadeMelhoramentoText{
                        requiredflag = 1
                    }else{
                        requiredflag = 0
                    }
                }
                else{
                    requiredflag = 1
                }
                if requiredflag == 0 {
                    if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == "" {
                        self.textFieldValidation()
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.enterValueInSeries, comment: ""))
                        completionHandler(false)
                        return
                    }
                }
                else {
                    genotypeAddBtnCondtion(completionHandler: { (success) -> Void in
                        completionHandler(true)
                    })
                }
            }
        }
        
        else {
            if !isGenotypeOnlyAdded {
                if rGDTextfield.text == "" {
                    requiredflag = 0
                }
                else if serieTextfield.text != "" && rGNTextfield.text == "" || serieTextfield.text == "" && rGNTextfield.text != ""  {
                    requiredflag = 0
                    if serieTextfield.text == "" {
                        serieTextfield.layer.borderColor = UIColor.red.cgColor
                        rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                        
                    } else{
                        serieTextfield.layer.borderColor = UIColor.gray.cgColor
                        rGNTextfield.layer.borderColor = UIColor.red.cgColor
                    }
                    if rGDTextfield.text != ""{
                        rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                    }
                }
                else {
                    requiredflag = 1
                }
                
                if requiredflag == 0{
                    if rGDTextfield.text == "" {
                        rGDTextfield.layer.borderColor = UIColor.red.cgColor
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                        completionHandler(false)
                        return
                    }
                    if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                        self.validation()
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.enterValueInSeries, comment: ""))
                        completionHandler(false)
                        return
                    }
                }
                else {
                    if !isGenotypeOnlyAdded {
                        addBtnCondtion(completionHandler: { (success) -> Void in
                            if success == true{
                                completionHandler(true)
                            }
                        })
                    }
                }
            }
            else{
                if genotypeSerieTextfield.text == "" || genotypeRgnTextfield.text == "" {
                    requiredflag = 0
                }
                else{
                    requiredflag = 1
                }
                if requiredflag == 0 {
                    if genotypeSerieTextfield.text == "" || genotypeRgnTextfield.text == "" {
                        if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" {
                            genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                            genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                            completionHandler(false)
                            return
                        }
                        
                        if genotypeSerieTextfield.text == "" {
                            genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                            genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                            completionHandler(false)
                            return
                        }
                        
                        if genotypeRgnTextfield.text == ""{
                            genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                            genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                            completionHandler(false)
                            return
                        }
                    }
                    
                    if priorityBreeingBtnOutlet.titleLabel?.text! == ButtonTitles.ciadeMelhoramentoText {
                        genotypeAddBtnCondtion(completionHandler: { (success) -> Void in
                            if success == true{
                                completionHandler(true)
                            }
                        })
                    } else {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.enterValueInSeries, comment: ""))
                        self.textFieldValidation()
                        completionHandler(false)
                        return
                    }
                }
                else {
                    genotypeAddBtnCondtion(completionHandler: { (success) -> Void in
                        if success == true{
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
    
    func addBtnCondtion(completionHandler: CompletionHandler){
        if checkBarcode == true {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.barcodeMustEndWithNumAlert, comment: ""))
            return
        }
        var dateVale = ""
        let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            dateVale = dateTextField.text ?? ""
            if dateStr == "DD"{
                dateVale = dateTextField.text ?? ""
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
        else {
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
        if dateTextField.text!.count == 0{
            
        }
        else {
            if dateTextField.text?.count == 10 {
                let validate = isValidDate(dateString: dateTextField.text ?? "")
                print(validate)
                
                if validate == LocalizedStrings.correctFormatStr {
                    dobView.layer.borderColor = UIColor.gray.cgColor
                    dobView.layer.borderWidth = 0.5
                    validateDateFlag = true
                } else {
                    dobView.layer.borderColor = UIColor.red.cgColor
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
            } else {
                dobView.layer.borderColor = UIColor.red.cgColor
                validateDateFlag = false
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
                return
                
            }
        }
        
        if scanBarcodeTextfield.text != ""{
            let barCode = fetchAnimaBarcodeValidateWithoutOrderId(entityName: Entities.beefAnimalAddTblEntity,animalbarCodeTag:scanBarcodeTextfield.text ?? "",orderSatatus: "false")
            if barCode.count > 0 {
                barcodeView.layer.borderColor = UIColor.red.cgColor
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.barcodeAlreadyUsed, comment: ""))
                return
            }
        }
        
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        if  barcodeflag == true && scanBarcodeTextfield.text != "" {
            let barCode = fetchAnimaldataValidateAnimalBarcodeanimalIdOrderIdEarTag(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalbarCodeTag: scanBarcodeTextfield.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"false",orderid:orderId)
            if barCode.count > 0 {
                barcodeView.layer.borderColor = UIColor.red.cgColor
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sampleAlreadyExists, comment: ""))
                return
            }
        }
        
        let animaBarcOde =  fetchAnimaldataValidateAnimalBarcodeanimalIdearTag(entityName: Entities.beefAnimalMasterTblEntity, animalbarCodeTag: scanBarcodeTextfield.text ?? "", sireId: serieTextfield.text ?? "", animalBarCode:animalTextfield.text ?? "" , userId: userId, animalId: animalId1, orderStatus: "true",IsDataEmail: false)
        if animaBarcOde.count > 0 {
            barcodeView.layer.borderColor = UIColor.red.cgColor
            
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sampleAlreadyExists, comment: ""))
            return
        }
        
        let animalData = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId: animalId1, orderId: orderId, userId: userId, orderStatus: "false")
        incrementalBarCode = scanBarcodeTextfield.text ?? ""
        
        if animalData.count > 0  {
            isUpdate = true
            updateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalMasterTblEntity, animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
            
            updateOrderStatusISyncAnimalMaster(entity: Entities.dataEntryBeefAnimalAddTblEntity,animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "true", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
            
            updateOrderStatusISyncProduct(entity: Entities.productAdonAnimlBeefTblEntity,animalTag: scanBarcodeTextfield.text!,barCodetag:  animalTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId:animalId1)
            updateOrderStatusISyncSubProduct(entity: Entities.subProductBeefTblEntity,animalTag: scanBarcodeTextfield.text!,barCodetag:  animalTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId: animalId1)
            
            let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: "",animalTag:scanBarcodeTextfield.text!,barcodeTag:animalTextfield.text!)
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            
            if adata.count > 0{
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
            }
            
            else if animalDataMaster.count > 0 {
                if  msgUpatedd == true{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalRecordUpdated, comment: ""))
                    UserDefaults.standard.set(tissueBttn.titleLabel?.text, forKey: keyValue.dataEntrytissueBttnClear.rawValue)
                    UserDefaults.standard.set(tissueBttn.titleLabel?.text, forKey: keyValue.dataEntrytissueBttn.rawValue)
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
            updateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalMasterTblEntity, animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName:genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
            
            updateOrderStatusISyncAnimalMaster(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "true", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true,territoryGeno: "")
            
            if identify1 == true {
                let data1 = fetchAllDataOrderStatus(entityName: Entities.dataEntryBeefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
                if data1.count > 0 {
                    completionHandler(true)
                    return
                }
            }
            
            isautoPopulated = false
            let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: "",animalTag:scanBarcodeTextfield.text!,barcodeTag:animalTextfield.text!)
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            
            if adata.count > 0{
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                byDefaultSetting()
            }
            
            else if animalDataMaster.count > 0 {
                if  msgUpatedd == true{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalRecordUpdated, comment: ""))
                    UserDefaults.standard.set(tissueBttn.titleLabel?.text, forKey: keyValue.dataEntrytissueBttnClear.rawValue)
                    UserDefaults.standard.set(tissueBttn.titleLabel?.text, forKey: keyValue.dataEntrytissueBttn.rawValue)
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
            if product.count > 0 {
                pid = product[0] as? GetProductTblBeef
            }
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
                updateOrderStatusISyncAnimalMasterAnimalId(entity: Entities.beefAnimalMasterTblEntity, animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1,isSyncServer:false, adhDataServer: false, tertiaryGeno: "")
                updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId ?? 0,offlineSync:false,listid: listIdGet)
                
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
                    updateOrderStatusISyncAnimalMasterAnimalId(entity: Entities.beefAnimalMasterTblEntity, animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU:"", userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1,isSyncServer:false, adhDataServer: false, tertiaryGeno: "")
                    updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId ?? 0,offlineSync:false,listid: listIdGet)
                }
                else {
                    saveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userId,udid:timeStampString, animalId: animalID1, productId: Int(pid?.productId ?? 0),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listIdGet), serverAnimalId: "", tertiaryGeno: "")
                    updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId ?? 0,offlineSync:false,listid: listIdGet)
                }
            }
            
            saveAnimaldataBeefInProductId(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "true", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userId,udid:timeStampString, animalId: animalID1, productId: Int(pid?.productId ?? 0),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listIdGet), serverAnimalId: "", tertiaryGeno: "")
            updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId ?? 0,offlineSync:false,listid: listIdGet)
            
            //mreged
            let animalData = fetchAnimaldata(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalTag:scanBarcodeTextfield.text!,orderId:orderId,userId:userId)
            let productCount = UserDefaults.standard.integer(forKey: keyValue.productCount.rawValue)
            
            msgShow()
            if isBarcodeAutoIncrementedEnabled == true {
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
            }
            else {
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
            }
            
            UserDefaults.standard.set(tissueBttn.titleLabel?.text, forKey: keyValue.dataEntrytissueBttnClear.rawValue)
            UserDefaults.standard.set(tissueBttn.titleLabel?.text, forKey: keyValue.dataEntrytissueBttn.rawValue)
           // self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            if UserDefaults.standard.value(forKey: "DENonGenoGender") as? String == "F" ||  UserDefaults.standard.value(forKey: "DENonGenoGender") as? String == nil {
                self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                genderToggleFlag = 0
                UserDefaults.standard.set("F", forKey: "DENonGenoGender")
                genderString = "Female"
            } else {
                self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                genderToggleFlag = 1
                UserDefaults.standard.set("M", forKey: "DENonGenoGender")
                genderString = "Male"
            }
            byDefaultSetting()
            resetAllField()
            genderToggleFlag = 0
            genderString = ButtonTitles.femaleText.localized
            scanBarcodeTextfield.text = ""
            let animalCount = fetchDataEnteryAnimalTblBeefDataBrazil(entityName: Entities.dataEntryBeefAnimalAddTblEntity,customerId:self.custmerId ?? 0,listId:Int64(self.listIdGet ),providerId:UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
            notificationLblCount.text = String(animalCount.count)
            let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
            let formatter = DateFormatter()
            
            if dateStr == "MM"{
                formatter.dateFormat = DateFormatters.MMddyyyyFormat
            }
            else {
                formatter.dateFormat = DateFormatters.ddMMyyyyFormat
            }
            dateBttnOutlet.titleLabel?.text = ""
            barAutoPopu = false
            dateVale = ""
            completionHandler(true)
        }
        
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
            UserDefaults.standard.set(incrementalBarCode, forKey: keyValue.barcodeIncremental.rawValue)
        }
        incrementalBarCode = ""
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
            if let lastSavedBarCode = UserDefaults.standard.value(forKey: keyValue.barcodeIncremental.rawValue) as? String {
                scanBarcodeTextfield.text = isBarCodeEndsWithNumber_GetIncrementedBarCode(lastSavedBarCode).incrementedBarCode
                if scanBarcodeTextfield.text?.isEmpty == false {
                    othersByDefaultBackroundWhite()
                }
            }
        }
        self.scrolView.contentOffset.y = 0.0
    }
    
    func msgShow()  {
        statusOrder = false
        UserDefaults.standard.removeObject(forKey: keyValue.review.rawValue)
        self.animalSucInOrder = ""
        if self.msgAnimalSucess == false {
            if self.addContiuneBtn == 1 {
                if self.msgcheckk == true {
                    self.view.makeToast(NSLocalizedString(AlertMessagesStrings.animalRecordUpdatedAdded, comment: ""), duration: 1, position: .bottom)
                }
                else {
                    if self.isautoPopulated == true {
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAddedSuccessfully, comment: ""), duration: 1, position: .bottom)
                    } else {
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAdded, comment: ""), duration: 1, position: .bottom)
                    }
                }
            }
            else if self.addContiuneBtn == 2{
                if self.msgcheckk == true {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalRecordUpdatedAdded, comment: ""))
                }
                else{
                    if self.isautoPopulated == true {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAddedSuccessfully, comment: ""))
                    }
                    else {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAdded, comment: ""))
                    }
                }
            }
            else {
                if self.msgcheckk == true {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalRecordUpdatedAdded, comment: ""))
                }
                else{
                    if self.isautoPopulated == true {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAddedSuccessfully, comment: ""))
                        
                    } else {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAdded, comment: ""))
                    }
                }
            }
            self.msgAnimalSucess = false
        }
        else {
            if self.msgcheckk == true {
                self.view.makeToast(NSLocalizedString(AlertMessagesStrings.animalRecordUpdatedAdded, comment: ""), duration: 1, position: .bottom)
            }
            else{
                if self.isautoPopulated == true {
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAddedSuccessfully, comment: ""), duration: 1, position: .bottom)
                }else {
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAdded, comment: ""), duration: 1, position: .bottom)
                    
                }
            }
        }
        UserDefaults.standard.set(priorityBreeingBtnOutlet.titleLabel?.text, forKey: keyValue.dataListPrimaryGenoType.rawValue)
        UserDefaults.standard.set(secondaryBreddingOutlet.titleLabel?.text, forKey: keyValue.dataListSecondaryGenoType.rawValue)
        UserDefaults.standard.set(territoryBreddingOutlet.titleLabel?.text, forKey: keyValue.dataListTertirayGenoType.rawValue)
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
    
    func continueproduct(){
        identify1 = true
        let data1 = fetchDataEnteryAnimalTblBeefDataBrazil(entityName: Entities.dataEntryBeefAnimalAddTblEntity,customerId:self.custmerId ?? 0,listId:Int64(self.listIdGet ),providerId:UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
        let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
        
        if identyCheck == false || identyCheck == nil{
            if data1.count > 0 {
                if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                    requiredflag = 0
                }
                else{
                    requiredflag = 1
                }
                if requiredflag == 0{
                    if scanBarcodeTextfield.text != ""{
                        if rGDTextfield.text != "" {
                            rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                        }
                        else {
                            rGDTextfield.layer.borderColor = UIColor.red.cgColor
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                            return
                        }
                    }
                    if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil {
                        if UserDefaults.standard.value(forKey: keyValue.onKey.rawValue) as? String == "off"{
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                            saveBreedSociety()
                        }
                        else {
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                            saveBreedSociety()
                        }
                    }
                    else {
                        if  UserDefaults.standard.value(forKey: keyValue.page.rawValue) == nil {
                            if UserDefaults.standard.value(forKey: keyValue.onKey.rawValue) as? String == "off"{
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                                saveBreedSociety()
                            }
                            else {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                                saveBreedSociety()
                            }
                        }
                        else{
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                            saveBreedSociety()
                        }
                    }
                } else {
                    
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        if success == true{
                            let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                            if  identyCheck == true {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                                self.saveBreedSociety()
                            }
                            else {
                                if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil{
                                    
                                    if UserDefaults.standard.value(forKey: keyValue.onKey.rawValue) as? String == "off"{
                                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                                        self.saveBreedSociety()
                                    }
                                    else {
                                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                                        self.saveBreedSociety()
                                    }
                                }
                                else {
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                                    self.saveBreedSociety()
                                }
                            }
                        }
                    })
                }
            }
            else {
                if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == "" {
                    requiredflag = 0
                }
                else{
                    requiredflag = 1
                }
                
                if requiredflag == 0 {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                    self.validation()
                }
                else {
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        if success == true{
                            if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil{
                                if UserDefaults.standard.value(forKey: keyValue.onKey.rawValue) as? String == "off"{
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                                    self.saveBreedSociety()
                                }
                                else {
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                                    self.saveBreedSociety()
                                }
                            }
                            else {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController:
                                                                                                                self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                                self.saveBreedSociety()
                            }
                        }
                    })
                }
            }
        }
        else {
            if data1.count > 0 {
                if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                    requiredflag = 0
                }
                else{
                    requiredflag = 1
                }
                
                if  requiredflag == 0{
                    let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                    if  identyCheck == true {
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                        self.saveBreedSociety()
                    }
                    else {
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                        self.saveBreedSociety()
                    }
                }
                else{
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        if success == true{
                            let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                            if  identyCheck == true {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                                self.saveBreedSociety()
                            }
                            else {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                                self.saveBreedSociety()
                            }
                        }
                    })
                }
            }
            
            else{
                addAnimalBtn(completionHandler: { (success) -> Void in
                    if success == true{
                        let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                        if  identyCheck == true {
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                            self.saveBreedSociety()
                        }
                        else {
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                            self.saveBreedSociety()
                            
                        }
                    }
                })
            }
        }
    }
    
    func saveBreedSociety()  {
        UserDefaults.standard.set(priorityBreeingBtnOutlet.titleLabel?.text, forKey: keyValue.dataListPrimaryGenoType.rawValue)
        UserDefaults.standard.set(secondaryBreddingOutlet.titleLabel?.text, forKey: keyValue.dataListSecondaryGenoType.rawValue)
        UserDefaults.standard.set(territoryBreddingOutlet.titleLabel?.text, forKey: keyValue.dataListTertirayGenoType.rawValue)
        UserDefaults.standard.set(breedId, forKey: keyValue.dataBeefBreedID.rawValue)
        UserDefaults.standard.set(selectBreedBtn.titleLabel?.text , forKey: keyValue.dataBeefBreedName.rawValue)
    }
    
    // MARK: - OBJC SELECTOR METHODS
    @objc func closeAddAnimalAndContinueOptions(tapGestureRecognizer: UITapGestureRecognizer) {
        view1.isHidden = true
        view2.isHidden = true
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            DispatchQueue.main.async {
                self.keyBoardOptionsView.isHidden = false
            }
            keyBoardOptionsViewBottomConstrains.constant = keyboardHeight+20
            addAnpthertITLE.isHidden = true
            nonGenoReviewTtilt.isHidden = true
            if(UserDefaults.standard.value(forKey: keyValue.scrollIsEnable.rawValue) as? Bool ?? true){
                scrolView.isScrollEnabled = true
            }
            else {
                scrolView.isScrollEnabled = false
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        keyBoardOptionsView.isHidden = true
        addAnpthertITLE.isHidden = false
        nonGenoReviewTtilt.isHidden = false
        genotypeScrollView.isScrollEnabled = true
        scrolView.isScrollEnabled = true
    }
    
    
    @objc func methodOfReceivedNotification(notification: Notification)
    {
        UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
        let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
        self.hideIndicator()
        
    }
    
    @objc func buttonPreddDroper() {
        buttonbg2.removeFromSuperview()
        
    }
    
    @objc func checkForReachability(notification:Notification){
        let del = UIApplication.shared.delegate as? AppDelegate
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if NetworkStatusLbl?.text == ButtonTitles.connectedText.localized {
            networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
            offLineBtn.isEnabled = false
        }
        else {
            networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
            offLineBtn.isEnabled = true
        }
    }
    
    @objc func doneClick() {
        let date = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        let dateFormatter3 = DateFormatter()
        if date == "MM"{
            dateFormatter3.dateFormat = DateFormatters.MMddyyyyFormat
        }
        else {
            dateFormatter3.dateFormat = DateFormatters.ddMMyyyyFormat
        }
        self.selectedDate = datePicker.date
        
        let selectedDate = dateFormatter3.string(from: datePicker.date)
        dateBttnOutlet.setTitle(selectedDate, for: .normal)
        self.datePicker.resignFirstResponder()
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        calenderView.isHidden = true
        calenderbkg.isHidden = true
    }
    
    @objc func genotypeDoneClick() {
        let date = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        let dateFormatter3 = DateFormatter()
        if date == "MM"{
            dateFormatter3.dateFormat = DateFormatters.MMddyyyyFormat
        }
        else {
            dateFormatter3.dateFormat = DateFormatters.ddMMyyyyFormat
        }
        self.selectedDate = datePicker.date
        let selectedDate = dateFormatter3.string(from: datePicker.date)
        genotypeDOBBttn.setTitle(selectedDate, for: .normal)
        self.datePicker.resignFirstResponder()
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        calenderView.isHidden = true
        calenderbkg.isHidden = true
        genotypeDOBBttn.setTitleColor(.black, for: .normal)
    }
    
    @objc func cancelClick() {
        calenderView.isHidden = true
        calenderbkg.isHidden = true
        datePicker.isHidden = true
        self.toolBar.isHidden = true
    }
}
