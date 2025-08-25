import UIKit

// MARK: - Beef Animal Brazil VC
class BeefAnimalBrazilVC: UIViewController,UIScrollViewDelegate{
    
    // MARK: - OUTLETS
    @IBOutlet weak var keyBoardOptionsView: UIView!
    @IBOutlet weak var keyBoardOptionsViewBottomConstrains: NSLayoutConstraint!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var closeImage1: UIImageView!
    @IBOutlet weak var closeImage2: UIImageView!
    @IBOutlet weak var appStatusLabel: UILabel!
    @IBOutlet weak var breedGenStarBlack: UIButton!
    @IBOutlet weak var genotypeMergeListBtnOulet: UIButton!
    @IBOutlet weak var nongenotypeMergeListBtnOulet: UIButton!
    @IBOutlet weak var genotypeImportFromBtnBtnOutlet: UIButton!
    @IBOutlet weak var addAnotherBtnTtile: UILabel!
    @IBOutlet weak var genotypeCrossBtnOutlet: UIButton!
    @IBOutlet weak var nongenotypeImportFromBtnBtnOutlet: UIButton!
    @IBOutlet weak var nongenotypeCrossBtnOutlet: UIButton!
    @IBOutlet weak var selectTitleLbl: UILabel!
    @IBOutlet weak var importBackroundView: UIView!
    @IBOutlet weak var importListMainView: UIView!
    @IBOutlet weak var importTblvIEW: UITableView!
    @IBOutlet weak var genotypeDateTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var dateOfLbl: UILabel!
    @IBOutlet weak var genotypeBarcodeBttn: UIButton!
    @IBOutlet weak var barcodeBttn: UIButton!
    @IBOutlet weak var genotypeView: UIView!
    @IBOutlet weak var scrollInnerView: UIView!
    @IBOutlet weak var networkStatusLbl: UILabel!
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
    @IBOutlet weak var selectBreedBtn: customButton!
    @IBOutlet weak var genstarblackBreedBtn: customButton!
    @IBOutlet weak var genotypeTissueHideLbl: UILabel!
    @IBOutlet weak var breedlablehide: UILabel!
    @IBOutlet weak var breedblackstarlablehide: UILabel!
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
    @IBOutlet weak var breeddroupdown: UIImageView!
    @IBOutlet weak var breedblackstardroupdown: UIImageView!
    @IBOutlet weak var incrementalBarcodeCheckBox: UIImageView!
    @IBOutlet weak var incrementalBarcodeTitleLabel: UILabel!
    @IBOutlet weak var incrementalBarcodeButton: UIButton!
    @IBOutlet weak var incrementalBarcodeCheckBoxGenoType: UIImageView!
    @IBOutlet weak var incrementalBarcodeTitleLabelGenoType: UILabel!
    @IBOutlet weak var incrementalBarcodeButtonGenoType: UIButton!
    @IBOutlet weak var addAnotherTtile: UIButton!
    @IBOutlet weak var continueToTtile: UIButton!
    @IBOutlet weak var genoTypeAddAnotherAnimalTtile: UIButton!
    @IBOutlet weak var continueToBtnTtile: UIButton!
    @IBOutlet weak var clearFormOutlet: UIButton!
    @IBOutlet weak var nonGenotypeclearFormOutlet: UIButton!
    
    // MARK: - VARIABLES AND CONSTANTS
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    var pvid :Int = UserDefaults.standard.integer(forKey: "BeefPvid")
    var heartBeatViewModel:HeartBeatViewModel?
    var importListArray = [DataEntryList]()
    var tempImportListArray = [DataEntryList]()
    var listNameString = String()
    var listId = Int()
    var conflictArr = [DataEntryBeefAnimaladdTbl]()
    let tapRec = UITapGestureRecognizer()
    var userId = Int()
    var orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
    var pid : GetProductTblBeef?
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    var custmerId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
    let langCode : String = UserDefaults.standard.object(forKey: "lngCode") as! String
    var checkBarcode = Bool()
    var validateDateFlag = true
    var validateRGD = false
    var genovalidateRGD = false
    var barAutoPopu = false
    var lblTimeStamp = String()
    var requiredflag = 0
    var barcodeflag = Bool()
    var genderString = String()
    var othersGenderString = String()
    var attrs : [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.init(red: 29/225, green: 131/225, blue: 174/225, alpha: 1.0),.underlineStyle: NSUnderlineStyle.single.rawValue]
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
    var genotypeOnlyAddedbreed = false
    var genoBlackStarOnlyAddedBreed = false
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
    var incrementalBarCode = ""
    var isBarcodeAutoIncrementedEnabled = false
    let orderingDataListViewModel = OrderingDataListViewModel()
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        addObserver()
        tapRec.addTarget(self, action: #selector(closeAddAnimalAndContinueOptions(tapGestureRecognizer:)))
        UserDefaults.standard.setValue(nil, forKey: "submitTypeSelection")
        importBackroundView.isHidden = true
        importListMainView.isHidden = true
        self.userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        
        dateTextField.keyboardType = .phonePad
        genotypeDateTextField.keyboardType = .phonePad
        dateTextField.borderStyle = .none
        dateTextField.delegate = self
        genotypeDateTextField.borderStyle = .none
        genotypeDateTextField.delegate = self
        
        heartBeatViewModel = HeartBeatViewModel(callBack: navigateToAnotherVc)
        heartBeatViewModel?.callGetHearBeatData()
        UserDefaults.standard.set("BR", forKey: keyValue.capsBrazil.rawValue)
        self.genotypeTextfieldLeftPadding()
        self.byDefaultSetting()
        self.genotypeByDefaultScreen()
        
        self.defaultIncrementalBarCodeSetting()
        self.defaultIncrementalBarCodeSettingGenoType()
        self.pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        
        let auto = UserDefaults.standard.bool(forKey: "autoIdBeef")
        if !auto {
            autoIncrementidtable()
            autoD = fetchFromAutoIncrement()
            timeStampString = timeStamp()
            UserDefaults.standard.set(timeStampString, forKey: "timeStamp")
            UserDefaults.standard.set(true, forKey: "autoIdBeef")
            
            let animaltbl = fetchRemaningSubmitOrder(entityName: Entities.beefAnimalAddTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            
            for i in 0..<animaltbl.count{
                let data = animaltbl.object(at: i) as! BeefAnimaladdTbl
                updateOrderStatusServerRemain(entity: "BeefAnimalMaster", aniamltag: data.animalTag!, userId: userId)
            }
            deleteRemaningSubmitOrder(entityName: Entities.beefAnimalAddTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            deleteRemaningSubmitOrder(entityName: Entities.productAdonAnimlBeefTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            deleteRemaningSubmitOrder(entityName: Entities.subProductBeefTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            
            UserDefaults.standard.set(1, forKey: keyValue.orderIdBeef.rawValue)
        }
        autoD = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        timeStampString = UserDefaults.standard.value(forKey: "timeStamp") as? String ?? ""
        
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
        notificationLblCount.text = String(animalCount.count)
        if animalCount.count == 0{
            notificationLblCount.isHidden = true
            countLbl.isHidden = true
            UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
            deleteDataWithPvidCustomerId(entityString: "MergeDataEntryList" ,providerId: Int64(UserDefaults.standard.integer(forKey: "BeefPvid")),customerId: Int64(self.custmerId))
            
            nongenotypeMergeListBtnOulet.isHidden = true
            genotypeMergeListBtnOulet.isHidden = true
            
        }
        self.navigationController?.navigationBar.isHidden = true
        
        let selectedProduct = fetchAllData(entityName: Entities.getProductBeefTblEntity)
        
        let name = "GeneSTAR\u{00ae} Black"
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
            else
            {
                UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                
            }
        }
        
        if (selectedProduct.count == 1 && isGenotypeOnlyAdded) || (selectedProduct.count == 3 && isGenotypeOnlyAdded) || (selectedProduct.count == 2 && isGenotypeOnlyAdded)
        {
            genotypeOnlyAddedbreed = true
            genoBlackStarOnlyAddedBreed = false
            genotypeScrollView.isHidden = false
            scrolView.isHidden = true
            selectBreedBtn.isHidden = false
            breeddroupdown.isHidden = false
            
        }
        else if (selectedProduct.count == 1 && isGenostarblackOnlyAdded) || (selectedProduct.count == 3 && isGenostarblackOnlyAdded) || (selectedProduct.count == 2 && isGenostarblackOnlyAdded)
        {
            genotypeOnlyAddedbreed = false
            genoBlackStarOnlyAddedBreed = true
            genotypeScrollView.isHidden = true
            scrolView.isHidden = false
            genstarblackBreedBtn.isHidden = false
            breedblackstardroupdown.isHidden = false
            
        }
        else if selectedProduct.count == 2 && (isGenostarblackOnlyAdded && isGenotypeOnlyAdded)
        {
            genotypeOnlyAddedbreed = true
            genoBlackStarOnlyAddedBreed = true
            genotypeScrollView.isHidden = false
            scrolView.isHidden = true
            selectBreedBtn.isHidden = false
            breeddroupdown.isHidden = false
            
        }
        else if selectedProduct.count == 4
        {
            genotypeOnlyAddedbreed = true
            genoBlackStarOnlyAddedBreed = true
            genotypeScrollView.isHidden = false
            scrolView.isHidden = true
            selectBreedBtn.isHidden = false
            breeddroupdown.isHidden = false
        }
        else
        {
            genotypeOnlyAddedbreed = false
            genoBlackStarOnlyAddedBreed = false
            genstarblackBreedBtn.isHidden = true
            breedblackstardroupdown.isHidden = true
            genotypeScrollView.isHidden = true
            scrolView.isHidden = false
        }
        
        if isGenotypeOnlyAdded {
            
            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                
                genotypeDateTextField.isHidden = false
            } else {
                genotypeDateTextField.isHidden = true
            }
            
            
            genotypeScrollView.isHidden = false
            scrolView.isHidden = true
            if isGenostarblackOnlyAdded && isGenotypeOnlyAdded
            {
                UserDefaults.standard.set(keyValue.genoTypeStarBlack.rawValue, forKey: keyValue.beefProduct.rawValue)
            }
            else{
                UserDefaults.standard.set(keyValue.genoTypeOnly.rawValue, forKey: keyValue.beefProduct.rawValue)
            }
            
            let dataFetc = fetchDataEnteryWithListId(entityName: Entities.beefAnimalAddTblEntity,customerId:self.custmerId ,listId:0,providerId:UserDefaults.standard.integer(forKey: "BeefPvid"),orderstatus:"false", orderiD: UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue))
            
            if dataFetc.count == 0 {
                UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
                let attributeString = NSMutableAttributedString(string: NSLocalizedString("Import My List", comment: ""), attributes: self.attrs)
                self.genotypeImportFromBtnBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                genotypeImportFromBtnBtnOutlet.isEnabled = true
                genotypeCrossBtnOutlet.isHidden = true
            } else {
                
                
                let get = dataFetc.object(at: 0) as? BeefAnimaladdTbl
                let getListid = get?.listId ?? 0
                UserDefaults.standard.set(Int64(getListid), forKey: "dataEnteryListId")
                
                let fetchName = fetchListNameAccordingToListId(entityName: Entities.dataEntryListTblEntity,customerId:custmerId,listId:getListid,providerId:UserDefaults.standard.integer(forKey: "BeefPvid") )
                
                if fetchName.count != 0{
                    
                    genotypeCrossBtnOutlet.isHidden = false
                    self.genotypeImportFromBtnBtnOutlet.isEnabled = true
                    let attributeString = NSMutableAttributedString(string: NSLocalizedString("Import My List", comment: ""), attributes: self.attrs)
                    self.genotypeImportFromBtnBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                    
                }
            }
            
            
            
            if fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid),customerId:Int64(custmerId)).count == 0 {
                genotypeMergeListBtnOulet.isHidden = true
            } else {
                genotypeMergeListBtnOulet.isHidden = false
            }
            
            let fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId,providerId:pvid)
            
            if fetchObj.count != 0 {
                
                let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                let obj = objectFetch?.listName
                let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid),customerId:Int64(custmerId)).count - 1
                
                if fetchAllMergeDta == 0 {
                    let fetchNameDisplay = String(obj ?? "")
                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                    genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                    
                } else {
                    let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                    genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                    
                }
            }
        } else {
            
            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                
                dateTextField.isHidden = false
            } else {
                dateTextField.isHidden = true
            }
            if isGenostarblackOnlyAdded
            {
                UserDefaults.standard.set(keyValue.genStarBlack.rawValue, forKey: keyValue.beefProduct.rawValue)
            }
            else
            {
                UserDefaults.standard.set(keyValue.nonGenoType.rawValue, forKey: keyValue.beefProduct.rawValue)
            }
            genotypeScrollView.isHidden = true
            scrolView.isHidden = false
            
            let dataFetc = fetchDataEnteryWithListId(entityName: Entities.beefAnimalAddTblEntity,customerId:self.custmerId ,listId:0,providerId:UserDefaults.standard.integer(forKey: "BeefPvid"),orderstatus:"false", orderiD: UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue))
            
            if dataFetc.count == 0 {
                UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
                let attributeString = NSMutableAttributedString(string: NSLocalizedString("Import My List", comment: ""), attributes: self.attrs)
                self.nongenotypeImportFromBtnBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                nongenotypeImportFromBtnBtnOutlet.isEnabled = true
                nongenotypeCrossBtnOutlet.isHidden = true
            } else {
                
                let get = dataFetc.object(at: 0) as? BeefAnimaladdTbl
                let getListid = get?.listId ?? 0
                
                let fetchName = fetchListNameAccordingToListId(entityName: Entities.dataEntryListTblEntity,customerId:custmerId,listId:getListid,providerId:UserDefaults.standard.integer(forKey: "BeefPvid") )
                UserDefaults.standard.set(Int64(getListid), forKey: "dataEnteryListId")
                
                if fetchName.count != 0{
                    nongenotypeCrossBtnOutlet.isHidden = false
                    self.nongenotypeImportFromBtnBtnOutlet.isEnabled = true
                    let attributeString = NSMutableAttributedString(string: NSLocalizedString("Import My List", comment: ""), attributes: self.attrs)
                    self.nongenotypeImportFromBtnBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                    
                }
            }
            
            
            if fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid),customerId:Int64(custmerId)).count == 0 {
                nongenotypeMergeListBtnOulet.isHidden = true
            } else {
                nongenotypeMergeListBtnOulet.isHidden = false
            }
            
            let fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId,providerId:pvid)
            
            if fetchObj.count != 0 {
                
                let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                let obj = objectFetch?.listName
                let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid),customerId:Int64(custmerId)).count - 1
                
                if fetchAllMergeDta == 0 {
                    let fetchNameDisplay = String(obj ?? "")
                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                    nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                    
                } else {
                    let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                    nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                    
                }
            }
        }
        otherBorderColor()
        self.userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        
        genotypeSetBorder()
        autoD = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        timeStampString = timeStamp()
        UserDefaults.standard.set(timeStampString, forKey: "timeStamp")
        timeStampString = UserDefaults.standard.value(forKey: "timeStamp") as? String ?? ""
        if !UserDefaults.standard.bool(forKey: "isBarCodeIncrementalClear") {
            self.isBarcodeAutoIncrementedEnabled = false
            byDefaultSetting()
            genotypeByDefaultScreen()
        }
        
        if UserDefaults.standard.integer(forKey: "BeefAnimalIdSelectionCart") > 0 {
            let temp = UserDefaults.standard.integer(forKey: "BeefAnimalIdSelectionCart")
            animalIdBool = true
            othersByDefaultBackroundWhite()
            UserDefaults.standard.set(0, forKey: "BeefAnimalIdSelectionCart")
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
        let animalCount1 =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
        if animalCount1.count == 0{
            checkUserDataListName()
        }
        self.updateCartCount()
        
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
        self.defaultIncrementalBarCodeSettingGenoType()
        removeObserver()
    }
    
    // MARK: - NavigateToBeefOrderingScreen
    func navigateToBeefOrderingScreen(screenType : Int = 1) {
        
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let pvIdBeef = UserDefaults.standard.integer(forKey: "BeefPvid")
        
        let animalArray =  beefFetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", pvid: pvIdBeef)
        
        
        let dataListAnimals : [BeefAnimaladdTbl] = animalArray as! [BeefAnimaladdTbl]
        let animals = dataListAnimals.filter({ $0.animalTag == "" || $0.animalTag == nil })
        
        if animals.count > 0 {
            
            let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message: "Animal(s) in the list do not have the barcode, Please review the cart to update the animal record(s).".localized(with: animals.count), preferredStyle: .alert)
            
            let ok = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { action in
                
                
                let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: "BeefViewAnimalVC") as? BeefViewAnimalVC
                vc!.screenBackSave = false
                vc!.productBackSave = false
                self.navigationController?.pushViewController(vc!, animated: true)
            })
            alert.addAction(ok)
            DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
            })
        } else {
            
            if screenType == 1{
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
            }
            else {
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
            }
            
            
        }
    }
    
    // MARK: - ShowAlertforwithoutBarcodeAnimal
    func showAlertforwithoutBarcodeAnimal() {
        
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let pvIdBeef = UserDefaults.standard.integer(forKey: "BeefPvid")
        
        let animalArray =  beefFetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", pvid: pvIdBeef)
        
        let dataListAnimals : [BeefAnimaladdTbl] = animalArray as! [BeefAnimaladdTbl]
        let animals = dataListAnimals.filter({ $0.animalTag == "" || $0.animalTag == nil })
        if animals.count > 0 {
            
            let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message:"Animal(s) in the list do not have the barcode, Please review the cart to update the animal record(s).".localized(with: animals.count), preferredStyle: .alert)
            
            let ok = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { action in
               
                let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: "BeefViewAnimalVC") as? BeefViewAnimalVC
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
    
    //  MARK: - OtherView
    
    func defaultIncrementalBarCodeSetting() {
        incrementalBarcodeCheckBox.image = UIImage(named: "Incremental_Check")
        UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
        incrementalBarcodeTitleLabel.text = NSLocalizedString("Incremental Barcode", comment: "")
    }
    func defaultIncrementalBarCodeSettingGenoType() {
        incrementalBarcodeCheckBoxGenoType.image = UIImage(named: "Incremental_Check")
        UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
        incrementalBarcodeTitleLabelGenoType.text = NSLocalizedString("Incremental Barcode", comment: "")
    }
    
    
    
    
    func navigateToAnotherVc(){
        //implentation deleted for now
    }
    
    @objc func closeAddAnimalAndContinueOptions(tapGestureRecognizer: UITapGestureRecognizer) {
        view1.isHidden = true
        view2.isHidden = true
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
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            DispatchQueue.main.async {
                self.keyBoardOptionsView.isHidden = false
            }
            keyBoardOptionsViewBottomConstrains.constant = keyboardHeight+20
            
            if(UserDefaults.standard.value(forKey: keyValue.scrollIsEnable.rawValue) as? Bool ?? true){
                scrolView.isScrollEnabled = true
                genotypeScrollView.isScrollEnabled = true
            }
            else {
                scrolView.isScrollEnabled = false
                genotypeScrollView.isScrollEnabled = false
            }
            
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        keyBoardOptionsView.isHidden = true
        genotypeScrollView.isScrollEnabled = true
        scrolView.isScrollEnabled = true
    }
    
    var value = 0
    @objc func methodOfReceivedNotification(notification: Notification)
    {
        
        if  value == 0
        {
            UserDefaults.standard.set("false", forKey: "FirstLogin")
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
            self.hideIndicator()
            value = value + 1
        }
        
    }
    
    
    func updateCartCount(){
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
        
        
        if animalCount.count == 0{
            notificationLblCount.isHidden = true
            countLbl.isHidden = true
        } else {
            notificationLblCount.text = String(animalCount.count)
            notificationLblCount.isHidden = false
            countLbl.isHidden = false
        }
    }
    
    func timeStamp()-> String{
        
        let time1 = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyyHH:mm:ss"
        let timestamp = formatter.string(from: time1 as Date)
        lblTimeStamp = timestamp.replacingOccurrences(of: "-", with: "", options: .regularExpression)
        lblTimeStamp = lblTimeStamp.replacingOccurrences(of: ":", with: "", options: .regularExpression)
     
        let udid = UserDefaults.standard.value(forKey: "ApplicationIdentifier")! as! String
        let sessionGUID1 =   lblTimeStamp + "_" + String(describing: autoD as Int)
        lblTimeStamp = sessionGUID1 + "_" + "iOS" + "_" + String(udid)
        return lblTimeStamp
    }
    
    func isValidDate(dateString: String) -> String {
        let dateFormatterGet = DateFormatter()
        
        let dateStr = UserDefaults.standard.value(forKey: "date") as? String
        if dateStr == "MM"{
            
            dateFormatterGet.dateFormat = "MM/dd/yyyy"
            
            
        } else {
            dateFormatterGet.dateFormat = "dd/MM/yyyy"
            
        }
        if let dateGet = dateFormatterGet.date(from: dateString) {
            
            let smallDate = dateGet.isSmallerThan(Date())
            
            if !smallDate {
                
                return "GreaterThenDate"
            }
            
            
            return "Correct Format"
        } else {
            return  "invalid format"
        }
    }
    func dataPopulateInScreen(animalId:Int){
        isautoPopulated = true
        barAutoPopu = true
        var animalFetch = NSArray()
        if !isGenotypeOnlyAdded {
            if animalIdBool {
                
                animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId: animalId, customerID: custmerId)
                let data = animalFetch.object(at: 0) as! BeefAnimaladdTbl
                let userIdForAutoPop = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                animalId1 = Int(data.animalId)
                barcodeView.layer.borderColor = UIColor.gray.cgColor
                rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                animalTextfield.layer.borderColor = UIColor.gray.cgColor
                serieTextfield.layer.borderColor = UIColor.gray.cgColor
                dateBttnOutlet.titleLabel?.text = ""
                
                UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
                self.isBarcodeAutoIncrementedEnabled = false
                incrementalBarcodeCheckBox.image = UIImage(named: "Incremental_Check")
                incrementalBarcodeButton.isEnabled = false
                incrementalBarcodeTitleLabel.textColor = .gray
                self.isBarcodeAutoIncrementedEnabled = false
                checkBarcode = false
                incrementalBarcodeTitleLabelGenoType.textColor = .gray
       
                
                let dateStr = UserDefaults.standard.value(forKey: "date") as? String
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
                            
                        } else {
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
                            
                            
                        }
                        formatter.dateFormat = "MM/dd/yyyy"
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
                        formatter.dateFormat = "dd/MM/yyyy"
                    }
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String != keyValue.defaultEntry.rawValue {
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
                tissueBttn.setTitle(data.tissuName?.localized, for: .normal)
                UserDefaults.standard.set(data.tissuName?.localized, forKey: "tissueBttn")
                
                breedId = data.breedId!
                if isGenostarblackOnlyAdded
                {
                    genstarblackBreedBtn.setTitle(data.breedName, for: .normal)
                }
                
                
                if data.gender == NSLocalizedString("Male", comment: "") || data.gender == "M" || data.gender == "Male".localized {
                    self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 1
                    genderString = NSLocalizedString("Male", comment: "")
                    UserDefaults.standard.set("M", forKey: "NonGenoGender")
                } else {
                    self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 0
                    genderString = NSLocalizedString("Female", comment: "")
                    UserDefaults.standard.set("F", forKey: "NonGenoGender")
                }
                
                
                
                tissuId = Int(data.tissuId)
                dateBttnOutlet.setTitleColor(.black, for: .normal)
                let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userIdForAutoPop,farmId: "",animalTag:genotypeScanBarcodeTextField.text!,barcodeTag:genotypeAnimalNameTextfield.text!,sireID:genotypeSerieTextfield.text ?? "",damId: genotypeRgdTextfield.text ?? "")
                
                animalIdBool = false
                
                if adata.count > 0{
                    let animal  = adata.object(at: 0) as! BeefAnimalMaster
                    idAnimal = Int(animal.animalId)
                }
            } else {
                animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimalMaster", animalId: idAnimal, customerID: custmerId)
                if animalFetch.count > 0 {
                    let  data = animalFetch.object(at: 0) as! BeefAnimalMaster
                    let userIdAnimalFetch = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                    animalId1 = Int(data.animalId)
                    
                    UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
                    
                    barcodeView.layer.borderColor = UIColor.gray.cgColor
                    rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                    rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                    animalTextfield.layer.borderColor = UIColor.gray.cgColor
                    serieTextfield.layer.borderColor = UIColor.gray.cgColor
                    
                    dateBttnOutlet.titleLabel?.text = ""
                    let dateStr = UserDefaults.standard.value(forKey: "date") as? String
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
                            formatter.dateFormat = "MM/dd/yyyy"
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
                            formatter.dateFormat = "dd/MM/yyyy"
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
                    tissueBttn.setTitle(data.tissuName?.localized, for: .normal)
                    UserDefaults.standard.set(data.tissuName?.localized, forKey: "tissueBttn")
                    
                    breedId = data.breedId!
                    if isGenostarblackOnlyAdded
                    {
                        genstarblackBreedBtn.setTitle(data.breedName, for: .normal)
                    }
                    
                    if data.gender == "Male".localized || data.gender == "M"{
                        self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                        genderToggleFlag = 1
                        genderString = NSLocalizedString("Male", comment: "")
                        UserDefaults.standard.set("M", forKey: "NonGenoGender")
                    } else {
                        genderToggleFlag = 0
                        genderString = "Female".localized
                        self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                        UserDefaults.standard.set("F", forKey: "NonGenoGender")
                    }
                    
                    tissuId = Int(data.tissuId)
                    
                    dateBttnOutlet.setTitleColor(.black, for: .normal)
                    let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userIdAnimalFetch,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
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
            genotypeByDefaultBackroundWhite()
            if animalIdBool {
                animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId: animalId, customerID: custmerId)
                let data = animalFetch.object(at: 0) as! BeefAnimaladdTbl
                let userIdAnimalFetch = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                animalId1 = Int(data.animalId)
                genotypeDOBBttn.titleLabel?.text = ""
                
                genotypeScanBarcodeTextField.layer.borderColor = UIColor.gray.cgColor
                genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
                genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                
                let dateStr = UserDefaults.standard.value(forKey: "date") as? String
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
                        } else {
                            
                            genotypeDOBBttn.setTitle(dateVale, for: .normal)
                            
                        }
                        formatter.dateFormat = "MM/dd/yyyy"
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
                        } else {
                            
                            genotypeDOBBttn.setTitle(dateVale, for: .normal)
                            
                        }
                        formatter.dateFormat = "dd/MM/yyyy"
                    }
                    
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String != keyValue.defaultEntry.rawValue {
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
                    if let primary = UserDefaults.standard.object(forKey: keyValue.primaryGenoType.rawValue)
                    {
                        priorityBreeingBtnOutlet.setTitle(primary as? String ,for: .normal)
                    } else{
                        priorityBreeingBtnOutlet.setTitle(NSLocalizedString("Select Primary Breed Genotype", comment: "") ,for: .normal)
                    }
                } else {
                    priorityBreeingBtnOutlet.setTitle(data.sireIDAU ,for: .normal)
                }
                genotypeTissueBttn.setTitleColor(.black, for: .normal)
                priorityBreeingBtnOutlet.setTitleColor(.black, for: .normal)
                genotypeTissueBttn.setTitle(data.tissuName?.localized, for: .normal)
                secondaryBreddingOutlet.setTitleColor(.black, for: .normal)
                territoryBreddingOutlet.setTitleColor(.black, for: .normal)
                if data.nationHerdAU == ""{
                    if let secondary = UserDefaults.standard.object(forKey: keyValue.secondaryGenoType.rawValue)
                    {
                        secondaryBreddingOutlet.setTitle(secondary as? String ,for: .normal)
                    } else{
                        secondaryBreddingOutlet.setTitle(NSLocalizedString("Select Secondary Breed Genotype", comment: ""), for: .normal)
                    }
                    
                } else {
                    secondaryBreddingOutlet.setTitle(data.nationHerdAU, for: .normal)
                }
                if data.tertiaryGeno == "" {
                    
                    if let  territory = UserDefaults.standard.object(forKey: keyValue.tertirayGenoType.rawValue)
                    {
                        territoryBreddingOutlet.setTitle(territory as? String ,for: .normal)
                    } else{
                        territoryBreddingOutlet.setTitle(NSLocalizedString("Select Tertiary Breed Genotype", comment: "") ,for: .normal)
                    }
                    
                } else {
                    territoryBreddingOutlet.setTitle(data.tertiaryGeno ,for: .normal)
                }
                
                UserDefaults.standard.set(data.tissuName, forKey: "genotypeTissueBttn")
                
                if data.breedName == "" {
                    if isGenostarblackOnlyAdded && isGenotypeOnlyAdded
                    {
                        if UserDefaults.standard.object(forKey: keyValue.beefBreedName.rawValue) != nil {
                            breedId = UserDefaults.standard.object(forKey: keyValue.beefBreedID.rawValue) as! String
                            selectBreedBtn.setTitle(UserDefaults.standard.object(forKey: keyValue.beefBreedName.rawValue) as? String, for: .normal)
                        } else {
                            breedId = tempbreedarraynames2[0]
                            selectBreedBtn.setTitle(tempbreedarraynames2[0], for: .normal)
                        }
                        
                    }
                    else
                    {
                        if UserDefaults.standard.object(forKey: keyValue.beefBreedName.rawValue) != nil {
                            breedId = UserDefaults.standard.object(forKey: keyValue.beefBreedID.rawValue) as! String
                            selectBreedBtn.setTitle(UserDefaults.standard.object(forKey: keyValue.beefBreedName.rawValue) as? String, for: .normal)
                        } else {
                            breedId = breedArr[0] as! String
                            selectBreedBtn.setTitle(breedArr[0] as? String, for: .normal)
                        }
                        
                    }
                }
                else
                {
                    breedId = data.breedId!
                    selectBreedBtn.setTitle(data.breedName, for: .normal)
                }
                
            
                if data.gender == "Male".localized || data.gender == "M"{
                    self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 1
                    genderString = NSLocalizedString("Male", comment: "")
                    UserDefaults.standard.set("M", forKey: "GenoGender")
                } else {
                    genderToggleFlag = 0
                    genderString = "Female".localized
                    self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    UserDefaults.standard.set("F", forKey: "NonGenoGender")
                }
                incrementalBarcodeTitleLabelGenoType.textColor = .gray
                
                
                tissuId = Int(data.tissuId)
                genotypeDOBBttn.setTitleColor(.black, for: .normal)
                
                let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userIdAnimalFetch,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
                
                animalIdBool = false
                
                if adata.count > 0{
                    let animal  = adata.object(at: 0) as! BeefAnimalMaster
                    idAnimal = Int(animal.animalId)
                }
                
            } else {
                animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimalMaster", animalId: idAnimal, customerID: custmerId)
                if animalFetch.count > 0 {
                    let  data = animalFetch.object(at: 0) as! BeefAnimalMaster
                    
                    
                    
                    let userIdAnimalFetch = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                    animalId1 = Int(data.animalId)
                    genotypeDOBBttn.titleLabel?.text = ""
                    genotypeScanBarcodeTextField.layer.borderColor = UIColor.gray.cgColor
                    genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                    
                    let dateStr = UserDefaults.standard.value(forKey: "date") as? String
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
                            formatter.dateFormat = "MM/dd/yyyy"
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
                            formatter.dateFormat = "dd/MM/yyyy"
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
                    genotypeTissueBttn.setTitle(data.tissuName?.localized, for: .normal)
                    secondaryBreddingOutlet.setTitleColor(.black, for: .normal)
                    secondaryBreddingOutlet.setTitle(data.nationHerdAU, for: .normal)
                    
                    territoryBreddingOutlet.setTitleColor(.black, for: .normal)
                    territoryBreddingOutlet.setTitle(data.tertiaryGeno, for: .normal)
                    
                    UserDefaults.standard.set(data.tissuName, forKey: "genotypeTissueBttn")
                    
                    if UserDefaults.standard.object(forKey: keyValue.beefBreedID.rawValue) != nil {
                        breedId = UserDefaults.standard.object(forKey: keyValue.beefBreedID.rawValue) as! String
                        selectBreedBtn.setTitle(UserDefaults.standard.object(forKey: keyValue.beefBreedName.rawValue) as? String, for: .normal)
                        
                    } else {
                        breedId = data.breedId!
                        selectBreedBtn.setTitle(data.breedName, for: .normal)
                    }
                
                    if data.gender == "Male".localized || data.gender == "M"{
                        self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                        genderToggleFlag = 1
                        genderString = NSLocalizedString("Male", comment: "")
                        UserDefaults.standard.set("M", forKey: "GenoGender")
                        
                    } else {
                        genderToggleFlag = 0
                        genderString = "Female".localized
                        self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                        UserDefaults.standard.set("F", forKey: "GenoGender")
                    }
                    
                    tissuId = Int(data.tissuId)
                    
                    genotypeDOBBttn.setTitleColor(.black, for: .normal)
                    let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userIdAnimalFetch,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
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
        
        let animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimalMaster", animalId: idAnimal, customerID: custmerId)
        if animalFetch.count > 0{
            statusOrder = true
            return true
        } else {
            return false
        }
        
    }
    
    
    func genotypeTextfieldLeftPadding(){
        
        genotypeScanBarcodeTextField.addPadding(.left(20))
        genotypeSerieTextfield.addPadding(.left(20))
        genotypeRgnTextfield.addPadding(.left(20))
        genotypeAnimalNameTextfield.addPadding(.left(20))
        genotypeRgdTextfield.addPadding(.left(20))
        scanBarcodeTextfield.addPadding(.left(20))
        serieTextfield.addPadding(.left(20))
        rGNTextfield.addPadding(.left(20))
        rGDTextfield.addPadding(.left(20))
        animalTextfield.addPadding(.left(20))
        self.genotypeScanBarcodeTextField.becomeFirstResponder()
    }
    //  MARK: - OtherType
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
        dateOfLbl.textColor = UIColor.black
        dobLbl.textColor = UIColor.black
        scanBarcodeTextfield.layer.backgroundColor = UIColor.white.cgColor
        serieTextfield.layer.backgroundColor = UIColor.white.cgColor
        rGNTextfield.layer.backgroundColor = UIColor.white.cgColor
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
        genstarblackBreedBtn.isEnabled = true
        maleFemaleBttn.isEnabled = true
        dateBttnOutlet.isEnabled = true
        tissueBttn.setTitleColor(.black, for: .normal)
        genstarblackBreedBtn.setTitleColor(.black, for: .normal)
        dateBttnOutlet.setTitleColor(.black, for: .normal)
        incrementalBarcodeTitleLabel.textColor = UIColor.black
        incrementalBarcodeButton.isEnabled = true
        dateTextField.isEnabled = true
        if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") && !isBeginEditing,
           let lastSavedBarCode = UserDefaults.standard.value(forKey: "barcodeIncremental") as? String{
                scanBarcodeTextfield.text = isBarcodeEndingWithNumberAndGetIncremented(lastSavedBarCode).incrementedBarCode
        }
    }
    
    func byDefaultSetting(){
        let dateformt = DateFormatter()
        let dateStr = UserDefaults.standard.value(forKey: "date") as? String
        
        if dateStr == "MM" {
            dateformt.dateFormat = "MM/dd/yyyy"
            dateTextField.placeholder = "MM/DD/YYYY"
            genotypeDateTextField.placeholder = "MM/DD/YYYY"
        } else {
            dateformt.dateFormat = "dd/MM/yyyy"
            dateTextField.placeholder = "DD/MM/YYYY"
            genotypeDateTextField.placeholder = "DD/MM/YYYY"
            
        }
        dateOfLbl.textColor = UIColor.gray
        dobLbl.textColor = UIColor.gray
        
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
        dateTextField.text?.removeAll()
        dateBttnOutlet.titleLabel?.text = ""
        
        if UserDefaults.standard.value(forKey: "NonGenoGender") as? String == "F" ||
            UserDefaults.standard.value(forKey: "NonGenoGender") as? String == nil {
            self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 0
            genderString = "Female".localized
            UserDefaults.standard.set("F", forKey: "NonGenoGender")
        } else {
            self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 1
            genderString = "Male".localized
            UserDefaults.standard.set("M", forKey: "NonGenoGender")
        }
        if UserDefaults.standard.string(forKey: "tissueBttn") == nil || UserDefaults.standard.string(forKey: "tissueBttn") == ""{
            self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: UserDefaults.standard.integer(forKey: "BeefPvid"))
            for items in self.tissueArr
            {
                let tissue = items  as? GetSampleTbl
                let checkdefault  = tissue?.isDefault
                
                if checkdefault == true
                {
                    self.tissueBttn.setTitle(tissue?.sampleName?.localized, for: .normal)
                    self.tissuId =  Int(tissue?.sampleId ?? 4)
                }
                
                
            }
            
        } else {
            tissueBttn.setTitle(UserDefaults.standard.string(forKey: "tissueBttn"), for: .normal)
        }
        
        otherbyTextfieldGray()
        self.scrolView.contentOffset.y = 0.0
        
        incrementalBarcodeTitleLabel.textColor = .gray
        incrementalBarcodeButton.isEnabled = false
        
        if isGenotypeOnlyAdded {
            self.genotypeScanBarcodeTextField.becomeFirstResponder()
        } else {
            self.scanBarcodeTextfield.becomeFirstResponder()
        }
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        breedArrblack = fetchproviderProductDataGlobal(entityName: Entities.getBreedsTblEntity, provId: pvid, productId: 24, speciesName: "")
        
        tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
        for items in tissueArr
        {
            let tissue = items  as? GetSampleTbl
            let checkdefault  = tissue?.isDefault
            
            if checkdefault == true
            {
                genotypeTissueBttn.setTitle(tissue?.sampleName?.localized, for: .normal)
                tissueBttn.setTitle(tissue?.sampleName?.localized, for: .normal)
                tissuId =  Int(tissue?.sampleId ?? 4)
            }
            
            
        }
        
        
        if isGenostarblackOnlyAdded {
            let breed = self.breedArrblack[0] as! GetBreedsTbl
            if UserDefaults.standard.object(forKey: keyValue.beefBreedName.rawValue) != nil {
                genstarblackBreedBtn.setTitle(UserDefaults.standard.object(forKey: keyValue.beefBreedName.rawValue) as? String, for: .normal)
                breedId = UserDefaults.standard.object(forKey: keyValue.beefBreedID.rawValue) as! String
                
            } else  {
                genstarblackBreedBtn.setTitle(breed.threeCharCode, for: .normal)
                breedId = breed.breedId ?? ""
            }
            
        }
        
    }
    
    func otherbyTextfieldGray(){
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
        rGNTextfield.isEnabled = false
        rGDTextfield.isEnabled = false
        animalTextfield.isEnabled = false
        dateBttnOutlet.isEnabled = false
        tissueBttn.isEnabled = false
        maleFemaleBttn.isEnabled = false
        dateBttnOutlet.isEnabled = false
        genstarblackBreedBtn.isEnabled = false
        tissueBttn.setTitleColor(.gray, for: .normal)
        genstarblackBreedBtn.setTitleColor(.gray, for: .normal)
        dateBttnOutlet.setTitleColor(.gray, for: .normal)
        dateTextField.isEnabled = false
        dateTextField.text = ""
    }
    
    func validation(){
        
        if scanBarcodeTextfield.text == ""{
            barcodeView.layer.borderColor = UIColor.red.cgColor
        }
        else {
            barcodeView.layer.borderColor = UIColor.gray.cgColor
            
        }
        
        if rGDTextfield.text == ""{
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
    
    //  MARK: - Genotype
    
    func genotypeByDefaultBackroundWhite(isBeginEditing: Bool = true){
        
        genotypeMaleFemaleBttn.isEnabled = true
        genotypeScanBarcodeView.layer.backgroundColor = UIColor.white.cgColor
        genotypeSerieTextfield.layer.backgroundColor = UIColor.white.cgColor
        genotypeRgnTextfield.layer.backgroundColor = UIColor.white.cgColor
        
        genotypeAnimalNameTextfield.layer.backgroundColor = UIColor.white.cgColor
        genotypeRgdTextfield.layer.backgroundColor = UIColor.white.cgColor
        calenderViewOutlet.layer.backgroundColor = UIColor.white.cgColor
        genotypeTissueBttn.layer.backgroundColor = UIColor.white.cgColor
        
        selectBreedBtn.layer.backgroundColor = UIColor.white.cgColor
        
        genotypeDOBBttn.layer.backgroundColor = UIColor.white.cgColor
        
        genotypeSerieTextfield.isEnabled = true
        genotypeRgnTextfield.isEnabled = true
        genotypeAnimalNameTextfield.isEnabled = true
        genotypeRgdTextfield.isEnabled = true
        calenderViewOutlet.isUserInteractionEnabled = true
        dateOfLbl.textColor = UIColor.black
        dobLbl.textColor = UIColor.black
        
        genotypeDOBBttn.isEnabled = true
        
        genotypeTissueBttn.isEnabled = true
        
        selectBreedBtn.isEnabled = true
        
        priorityBreeingBtnOutlet.isEnabled = true
        territoryBreddingOutlet.isEnabled = true
        secondaryBreddingOutlet.isEnabled = true
        priorityBreeingBtnOutlet.backgroundColor = UIColor.white
        
        secondaryBreddingOutlet.backgroundColor = UIColor.white
        territoryBreddingOutlet.backgroundColor = UIColor.white
        secondaryBreddingOutlet.setTitleColor(.black, for: .normal)
        priorityBreeingBtnOutlet.setTitleColor(.black, for: .normal)
        territoryBreddingOutlet.setTitleColor(.black, for: .normal)
        genotypeTissueBttn.setTitleColor(.black, for: .normal)
        
        selectBreedBtn.setTitleColor(.black, for: .normal)
        
        incrementalBarcodeTitleLabelGenoType.textColor = .black
        incrementalBarcodeButtonGenoType.isEnabled = true
        if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") && !isBeginEditing,
           let lastSavedBarCode = UserDefaults.standard.value(forKey: "barcodeIncremental") as? String{
            genotypeScanBarcodeTextField.text = isBarcodeEndingWithNumberAndGetIncremented(lastSavedBarCode).incrementedBarCode
        }
    }
    
    func genotypeByDefaultBackroundGray(){
        dateOfLbl.textColor = UIColor.gray
        dobLbl.textColor = UIColor.gray
        
        
        genotypeDOBBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeScanBarcodeView.layer.borderColor = UIColor.gray.cgColor
        genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
        genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
        genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
        
        calenderViewOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeSerieTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeRgnTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        genotypeAnimalNameTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeRgdTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        secondaryBreddingOutlet.setTitleColor(.gray, for: .normal)
        priorityBreeingBtnOutlet.setTitleColor(.gray, for: .normal)
        territoryBreddingOutlet.setTitleColor(.gray, for: .normal)
        genotypeTissueBttn.setTitleColor(.gray, for: .normal)
        priorityBreeingBtnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        secondaryBreddingOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        territoryBreddingOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        genotypeTissueBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        selectBreedBtn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        genotypeSerieTextfield.isEnabled = false
        genotypeRgnTextfield.isEnabled = false
        genotypeAnimalNameTextfield.isEnabled = false
        genotypeRgdTextfield.isEnabled = false
        calenderViewOutlet.isUserInteractionEnabled = false
        genotypeDOBBttn.isEnabled = false
        
        genotypeTissueBttn.isEnabled = false
        
        selectBreedBtn.isEnabled = false
        
        priorityBreeingBtnOutlet.isEnabled = false
        secondaryBreddingOutlet.isEnabled = false
        territoryBreddingOutlet.isEnabled = false
        genotypeMaleFemaleBttn.isEnabled = false
        maleFemaleBttn.isEnabled = false
        tissueBttn.isEnabled = false
        priorityBreeingBtnOutlet.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        secondaryBreddingOutlet.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        territoryBreddingOutlet.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        incrementalBarcodeTitleLabelGenoType.textColor = .gray
        incrementalBarcodeButtonGenoType.isEnabled = false
        
        self.genotypeScanBarcodeTextField.becomeFirstResponder()
        genotypeDateTextField.text = ""
    }
    
    func genotypeSetBorder(){
        genotypeTissueBttn.layer.cornerRadius = (genotypeScanBarcodeView.frame.size.height / 2)
        genotypeTissueBttn.layer.borderWidth = 0.5
        genotypeTissueBttn.layer.borderColor = UIColor.gray.cgColor
        genotypeTissueBttn.layer.masksToBounds = true
        genotypeScanBarcodeView.layer.cornerRadius = (genotypeScanBarcodeView.frame.size.height / 2)
        
        genotypeScanBarcodeView.layer.borderWidth = 0.5
        genotypeScanBarcodeView.layer.borderColor = UIColor.gray.cgColor
        genotypeScanBarcodeView.layer.masksToBounds = true
        genotypeDOBBttn.layer.cornerRadius = (genotypeDOBBttn.frame.size.height / 2)
        genotypeDOBBttn.layer.borderWidth = 0.5
        genotypeDOBBttn.layer.borderColor = UIColor.gray.cgColor
        genotypeDOBBttn.layer.masksToBounds = true
        
        selectBreedBtn.layer.cornerRadius = (genotypeDOBBttn.frame.size.height / 2)
        selectBreedBtn.layer.borderWidth = 0.5
        selectBreedBtn.layer.borderColor = UIColor.gray.cgColor
        selectBreedBtn.layer.masksToBounds = true
        
        
        
        genotypeSerieTextfield.layer.cornerRadius = (genotypeSerieTextfield.frame.size.height / 2)
        genotypeSerieTextfield.layer.borderWidth = 0.5
        
        genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
        
        genotypeSerieTextfield.layer.masksToBounds = true
        genotypeRgnTextfield.layer.cornerRadius = (genotypeRgnTextfield.frame.size.height / 2)
        genotypeRgnTextfield.layer.borderWidth = 0.5
        genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
        genotypeRgnTextfield.layer.masksToBounds = true
        genotypeAnimalNameTextfield.layer.cornerRadius = (genotypeAnimalNameTextfield.frame.size.height / 2)
        genotypeAnimalNameTextfield.layer.borderWidth = 0.5
        genotypeAnimalNameTextfield.layer.borderColor = UIColor.gray.cgColor
        genotypeAnimalNameTextfield.layer.masksToBounds = true
        
        genotypeRgdTextfield.layer.cornerRadius = (genotypeRgdTextfield.frame.size.height / 2)
        genotypeRgdTextfield.layer.borderWidth = 0.5
        genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
        genotypeRgdTextfield.layer.masksToBounds = true
        priorityBreeingBtnOutlet.layer.cornerRadius = (priorityBreeingBtnOutlet.frame.size.height / 2)
        priorityBreeingBtnOutlet.layer.borderWidth = 0.5
        priorityBreeingBtnOutlet.layer.borderColor = UIColor.gray.cgColor
        priorityBreeingBtnOutlet.layer.masksToBounds = true
        secondaryBreddingOutlet.layer.cornerRadius = (secondaryBreddingOutlet.frame.size.height / 2)
        secondaryBreddingOutlet.layer.borderWidth = 0.5
        secondaryBreddingOutlet.layer.borderColor = UIColor.gray.cgColor
        secondaryBreddingOutlet.layer.masksToBounds = true
        
        territoryBreddingOutlet.layer.cornerRadius = (territoryBreddingOutlet.frame.size.height / 2)
        territoryBreddingOutlet.layer.borderWidth = 0.5
        territoryBreddingOutlet.layer.borderColor = UIColor.gray.cgColor
        territoryBreddingOutlet.layer.masksToBounds = true
        self.genotypeScanBarcodeTextField.becomeFirstResponder()
    }
    
    func genotypeByDefaultScreen(){
        
        self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
        
        if UserDefaults.standard.value(forKey: "GenoGender") as? String == "F" || UserDefaults.standard.value(forKey: "GenoGender") as? String == nil {
            self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 0
            genderString = "Female".localized
            UserDefaults.standard.set("F", forKey: "GenoGender")
        } else {
            self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 1
            genderString = "Male".localized
            UserDefaults.standard.set("M", forKey: "GenoGender")
        }
        animalId1 = 0
        idAnimal = 0
        isUpdate = false
        barAutoPopu = false
        msgUpatedd = false
        
        self.msgcheckk = false
        
        self.isautoPopulated = false
        
        genotypeScanBarcodeTextField.text?.removeAll()
        genotypeSerieTextfield.text?.removeAll()
        genotypeRgnTextfield.text?.removeAll()
        genotypeAnimalNameTextfield.text?.removeAll()
        genotypeRgdTextfield.text?.removeAll()
        genotypeSerieTextfield.isEnabled = false
        genotypeRgnTextfield.isEnabled = false
        genotypeAnimalNameTextfield.isEnabled = false
        genotypeRgdTextfield.isEnabled = false
        calenderViewOutlet.isUserInteractionEnabled = false
        
        genotypeDOBBttn.isEnabled = false
        genotypeDOBBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeTissueBttn.isEnabled = false
        
        priorityBreeingBtnOutlet.isEnabled = false
        
        secondaryBreddingOutlet.isEnabled = false
        territoryBreddingOutlet.isEnabled = false
        
        if let primary = UserDefaults.standard.object(forKey: keyValue.primaryGenoType.rawValue)
        {
            priorityBreeingBtnOutlet.setTitle(primary as? String ,for: .normal)
        } else{
            priorityBreeingBtnOutlet.setTitle(NSLocalizedString("Select Primary Breed Genotype", comment: "") ,for: .normal)
        }
        
        if let secondary = UserDefaults.standard.object(forKey: keyValue.secondaryGenoType.rawValue)
        {
            secondaryBreddingOutlet.setTitle(secondary as? String ,for: .normal)
        } else{
            secondaryBreddingOutlet.setTitle(NSLocalizedString("Select Secondary Breed Genotype", comment: ""), for: .normal)
        }
        
        if let tertiray = UserDefaults.standard.object(forKey: keyValue.tertirayGenoType.rawValue)
        {
            territoryBreddingOutlet.setTitle(tertiray as? String ,for: .normal)
        } else{
            territoryBreddingOutlet.setTitle(NSLocalizedString("Select Tertiary Breed Genotype", comment: ""), for: .normal)
        }
        
        genotypeDOBBttn.titleLabel?.text = ""
        genotypeDOBBttn.setTitle("", for: .normal)
        maleFemaleBttn.isEnabled = false
        genotypeMaleFemaleBttn.isEnabled = false
        tissueBttn.isEnabled = false
        genotypeScanBarcodeView.layer.borderColor = UIColor.gray.cgColor
        genotypeDOBBttn.layer.borderColor = UIColor.gray.cgColor
        genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
        genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
        genotypeAnimalNameTextfield.layer.borderColor = UIColor.gray.cgColor
        genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
        priorityBreeingBtnOutlet.layer.borderColor = UIColor.gray.cgColor
        secondaryBreddingOutlet.layer.borderColor = UIColor.gray.cgColor
        territoryBreddingOutlet.layer.borderColor = UIColor.gray.cgColor
        tissueBttn.layer.borderColor = UIColor.gray.cgColor
        
        selectBreedBtn.layer.borderColor = UIColor.gray.cgColor
        
        genotypeByDefaultBackroundGray()
        self.genotypeScrollView.contentOffset.y = 0.0
        incrementalBarcodeTitleLabelGenoType.textColor = .gray
        incrementalBarcodeButtonGenoType.isEnabled = false
        self.genotypeScanBarcodeTextField.becomeFirstResponder()
        
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        breedArrblack = fetchproviderProductDataGlobal(entityName: Entities.getBreedsTblEntity, provId: pvid, productId: 24, speciesName: "")
        breedArr = fetchproviderProductDataGlobal(entityName: Entities.getBreedsTblEntity, provId: pvid, productId: 23, speciesName: "")
        tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
        for items in tissueArr
        {
            let tissue = items  as? GetSampleTbl
            let checkdefault  = tissue?.isDefault
            
            if checkdefault == true
            {
                genotypeTissueBttn.setTitle(tissue?.sampleName?.localized, for: .normal)
                tissueBttn.setTitle(tissue?.sampleName?.localized, for: .normal)
                tissuId =  Int(tissue?.sampleId ?? 4)
            }
            
            
        }
        
        
        if tempbreedarraynames1.count == 0 {
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
                if UserDefaults.standard.object(forKey: keyValue.beefBreedID.rawValue) != nil {
                    breedId = UserDefaults.standard.object(forKey: keyValue.beefBreedID.rawValue) as! String
                    selectBreedBtn.setTitle(UserDefaults.standard.object(forKey: keyValue.beefBreedName.rawValue) as? String, for: .normal)
                    
                } else {
                    selectBreedBtn.setTitle(tempbreedarraynames2[0], for: .normal)
                    breedId = tempbreedarraynames1[0]
                }
                
                
            }
            else if isGenostarblackOnlyAdded
            {
                if UserDefaults.standard.object(forKey: keyValue.beefBreedName.rawValue) != nil {
                    breedId = UserDefaults.standard.object(forKey: keyValue.beefBreedID.rawValue) as! String
                    genstarblackBreedBtn.setTitle(UserDefaults.standard.object(forKey: keyValue.beefBreedName.rawValue) as? String, for: .normal)
                    
                } else {
                    genstarblackBreedBtn.setTitle(breed.threeCharCode, for: .normal)
                    breedId = breed.breedId ?? ""
                }
            }
            else
            {
                if UserDefaults.standard.object(forKey: keyValue.beefBreedName.rawValue) != nil {
                    breedId = UserDefaults.standard.object(forKey: keyValue.beefBreedID.rawValue) as! String
                    selectBreedBtn.setTitle(UserDefaults.standard.object(forKey: keyValue.beefBreedName.rawValue) as? String, for: .normal)
                    
                } else {
                    selectBreedBtn.setTitle(breed1.threeCharCode, for: .normal)
                    breedId = breed1.breedId ?? ""
                }
                
            }
        }
        
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // This method is intentionally left empty.
        // It will be implemented in the future to handle navigation logic.
    }
    
    
    func tableViewpop() {
        
        buttonbg2.frame = CGRect(x:0,y: 0,width: 1024,height: 1000)
        
        buttonbg2.addTarget(self, action:#selector(BeefAnimalBrazilVC.buttonPreddDroper), for: .touchUpInside)
        buttonbg2.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        self.view.addSubview(buttonbg2)
        droperTableView.delegate = self
        
        droperTableView.dataSource = self
        droperTableView.layer.cornerRadius = 8.0
        droperTableView.layer.borderWidth = 0.5
        droperTableView.layer.borderColor =  UIColor.gray.cgColor
        buttonbg2.addSubview(droperTableView)
    }
    
    
    
    @objc func buttonPreddDroper() {
        
        buttonbg2.removeFromSuperview()
        
    }
    
    func genotypecontinueproduct(){
        
        let userIdGenotype = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        identify1 = true
        let data1 = fetchAllDataOrderStatus(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userIdGenotype)
        
        let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
        
        if  identyCheck == false || identyCheck == nil{
            if data1.count > 0 {
                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                    if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
                        requiredflag = 1
                    } else {
                        requiredflag = 0
                    }
                    
                }
                else{
                    requiredflag = 1
                }
                if  genotypeScanBarcodeTextField.text == "" || requiredflag == 0 {
                    
                    if genotypeScanBarcodeTextField.text != ""{
                        guard genotypeSerieTextfield.text != "", genotypeRgnTextfield.text != "" else {
                            genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                            genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor

                            CommonClass.showAlertMessage(self,
                                titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""),
                                messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                            return
                        }
                    }
                    
                    if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil {
                        
                        navigateToBeefOrderingScreen()
                        
                    } else {
                        if identyCheck == false || identyCheck == nil {
                            if  UserDefaults.standard.value(forKey: keyValue.page.rawValue) == nil {
                                self.navigateToBeefOrderingScreen()
                            }
                            else{
                                navigateToBeefOrderingScreen(screenType: 2)
                            }
                        }
                        else {
                            navigateToBeefOrderingScreen(screenType: 2)
                            
                        }
                    }
                } else {
                    
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        
                        
                        if success {
                            
                            let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                            if  identyCheck == true {
                                self.navigateToBeefOrderingScreen(screenType: 2)
                                
                                
                            }  else {
                                if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil{
                                    
                                    self.navigateToBeefOrderingScreen()
                                    
                                } else {
                                    self.navigateToBeefOrderingScreen(screenType: 2)
                                    
                                }
                            }
                        }
                    })
                }
            }
            else {
                
                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == ""{
                    requiredflag = 0
                }
                else{
                    requiredflag = 1
                }
                if  genotypeScanBarcodeTextField.text == "" || requiredflag == 0 {
                    
                    if genotypeScanBarcodeTextField.text?.count == 0 {
                        if genotypeScanBarcodeTextField.text == "" && requiredflag == 0 {
                            self.textFieldValidation()
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please add at least one animal.", comment: ""))
                            return
                        } else {
                            
                            self.textFieldValidation()
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                            return
                            
                        }
                        
                    } else {
                        
                        
                        
                        if genotypeSerieTextfield.text != "" && genotypeRgnTextfield.text != ""  {
                            
                            genotypeAddBtnCondtion(completionHandler: { (success) -> Void in
                                if success {
                                    //removed implementation for now
                                }
                            })
                        } else {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                            self.textFieldValidation()
                            
                            return
                            
                        }
                    }
                } else {
                    
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        if success{
                            if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil{
                                self.navigateToBeefOrderingScreen()
                                
                            } else {
                                self.navigateToBeefOrderingScreen(screenType: 2)
                            }
                        }
                    })
                    
                    
                }
            }
        }  else {
            
            if data1.count > 0 {
                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                    if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
                        requiredflag = 1
                    }else{
                        requiredflag = 0
                    }
                    
                }
                else{
                    requiredflag = 1
                }
                if  genotypeScanBarcodeTextField.text == "" || requiredflag == 0 {
                        navigateToBeefOrderingScreen(screenType: 2)
                }
                else{
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        if success {
                                self.navigateToBeefOrderingScreen(screenType: 2)
                        }
                    })
                }
            }
            else{
                addAnimalBtn(completionHandler: { (success) -> Void in
                    if success {
                        self.navigateToBeefOrderingScreen(screenType: 2)
                    }
                })
            }
        }
        
    }
    
    func textFieldValidation(){
        if genotypeScanBarcodeTextField.text == ""{
            genotypeScanBarcodeView.layer.borderColor = UIColor.red.cgColor
        } else {
            genotypeScanBarcodeView.layer.borderColor = UIColor.gray.cgColor
        }
        
        if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" {
            if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
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
    
    //  MARK: - OtherView
    func landIdApplangaugeConversion(){
        animalTextfield.placeholder = NSLocalizedString("Enter Animal Name", comment: "")
        dobLbl.text = NSLocalizedString("Date of Birth", comment: "")
        dateOfLbl.text = NSLocalizedString("Date of Birth", comment: "")
        maleFemaleBttn.setTitle("",for: .normal)
        rGDTextfield.placeholder = NSLocalizedString("RGD or Animal ID", comment: "")
        rGNTextfield.placeholder = NSLocalizedString("RGN", comment: "")
        serieTextfield.placeholder = NSLocalizedString("Series", comment: "")
        scanBarcodeTextfield.placeholder = NSLocalizedString("Scan/Enter Sample Barcode", comment: "")
        
        genotypeScanBarcodeTextField.placeholder = NSLocalizedString("Scan/Enter Sample Barcode", comment: "")
        genotypeSerieTextfield.placeholder = NSLocalizedString("Series", comment: "")
        genotypeRgnTextfield.placeholder = NSLocalizedString("RGN", comment: "")
        genotypeAnimalNameTextfield.placeholder = NSLocalizedString("Enter Animal Name", comment: "")
        genotypeRgdTextfield.placeholder = NSLocalizedString("RGD or Animal ID", comment: "")
        priorityBreeingBtnOutlet.setTitle(NSLocalizedString("Select Primary Breed Genotype", comment: ""),for: .normal)
        secondaryBreddingOutlet.setTitle(NSLocalizedString("Select Secondary Breed Genotype", comment: ""),for: .normal)
        territoryBreddingOutlet.setTitle(NSLocalizedString("Select Tertiary Breed Genotype", comment: ""),for: .normal)
        
        addAnotherBtnTtile.text = NSLocalizedString("Ordering Add Animal(s)", comment: "")
        addAnotherTtile.setTitle(NSLocalizedString("Add Another Animal", comment: ""), for: .normal)
        continueToTtile.setTitle(NSLocalizedString("Continue to Product Selection", comment: ""), for: .normal)
        genoTypeAddAnotherAnimalTtile.setTitle(NSLocalizedString("Add Another Animal", comment: ""), for: .normal)
        continueToBtnTtile.setTitle(NSLocalizedString("Continue to Product Selection", comment: ""), for: .normal)
        appStatusLabel.text = NSLocalizedString("App Status:", comment: "")
        selectTitleLbl.text = NSLocalizedString("Select List", comment: "")
    }
    
    func autoPop(animalData:NSArray) {
        if animalData.count > 0 {
            isautoPopulated = true
            barAutoPopu = true
            barcodeflag = false
            updateOrder = true
            let data =  animalData.lastObject as! BeefAnimalMaster
            let userIdAutoPop = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            animalId1 = Int(data.animalId)
            dateBttnOutlet.titleLabel!.text = ""
            barcodeView.layer.borderColor = UIColor.gray.cgColor
            let dateStr = UserDefaults.standard.value(forKey: "date") as? String
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
                    formatter.dateFormat = "MM/dd/yyyy"
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
                    formatter.dateFormat = "dd/MM/yyyy"
                }
                if dateBttnOutlet.titleLabel!.text != nil{
                    self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
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
            tissueBttn.setTitle(data.tissuName?.localized, for: .normal)
            UserDefaults.standard.set(data.tissuName?.localized, forKey: "tissueBttn")
            
            breedId = String(data.breedId ?? "")
            UserDefaults.standard.set(breedId, forKey: "Beefbreed")
            
            if data.gender == "Male".localized || data.gender == "M"{
                self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                genderToggleFlag = 1
                genderString = NSLocalizedString("Male", comment: "")
                UserDefaults.standard.set("F", forKey: "GenoGender")
                
            } else {
                self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                genderToggleFlag = 0
                genderString = "Female".localized
                UserDefaults.standard.set("M", forKey: "NonGenoGender")
                
            }
            
            tissuId = Int(data.tissuId)
            
            dateBttnOutlet.setTitleColor(.black, for: .normal)
            statusOrder = false
            messageCheck = false
            let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userIdAutoPop,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
            if adata.count > 0{
                let animal  = adata.object(at: 0) as! BeefAnimalMaster
                idAnimal = Int(animal.animalId)
                messageCheck = true
            }
            
            if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                requiredflag = 0
            }
            else{
                if isautoPopulated {
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
            UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
            
        }
        if animalData.count > 0 {
            isautoPopulated = true
            barAutoPopu = true
            updateOrder = true
            let data =  animalData.lastObject as! BeefAnimalMaster
            let userIdAutoPop = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            animalId1 = Int(data.animalId)
            UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
            genotypeDOBBttn.titleLabel?.text = ""
            genotypeScanBarcodeTextField.layer.borderColor = UIColor.gray.cgColor
            genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
            genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
            genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
            let dateStr = UserDefaults.standard.value(forKey: "date") as? String
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
                    formatter.dateFormat = "MM/dd/yyyy"
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
                    formatter.dateFormat = "dd/MM/yyyy"
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
            genotypeTissueBttn.setTitle(data.tissuName?.localized, for: .normal)
            secondaryBreddingOutlet.setTitleColor(.black, for: .normal)
            secondaryBreddingOutlet.setTitle(data.nationHerdAU, for: .normal)
            territoryBreddingOutlet.setTitle(data.tertiaryGeno, for: .normal)
            territoryBreddingOutlet.setTitleColor(.black, for: .normal)
            UserDefaults.standard.set(data.tissuName, forKey: "BeefInheritTsu")
            
            breedId = String(data.breedId ?? "")
            
            
            if data.gender == "Male".localized || data.gender == "M"{
                self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                genderToggleFlag = 1
                genderString = NSLocalizedString("Male", comment: "")
                UserDefaults.standard.set("M", forKey: "GenoGender")
                
            } else {
                self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                genderToggleFlag = 0
                genderString = "Female".localized
                UserDefaults.standard.set("F", forKey: "GenoGender")
                
            }
            tissuId = Int(data.tissuId)
            
            genotypeDOBBttn.setTitleColor(.black, for: .normal)
            statusOrder = false
            messageCheck = false
            let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userIdAutoPop,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
            if adata.count > 0{
                let animal  = adata.object(at: 0) as! BeefAnimalMaster
                idAnimal = Int(animal.animalId)
                messageCheck = true
            }
            if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
                    requiredflag = 1
                }else{
                    requiredflag = 0
                }
                
            }
            else{
                if isautoPopulated{
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
        
        if barcodeEnable {
            let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: "BeefAnimalMaster", animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
            if orederStatus.count > 0 {
                
                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Animal Record cannot be updated as the animal has been used for an order.", comment: ""), preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    let animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimalMaster", animalId: self.idAnimal, customerID: self.custmerId)
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
                
                if  scanBarcodeTextfield.text == "" || requiredflag == 0{
                    if  scanBarcodeTextfield.text == "" {
                        
                        
                        self.validation()
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                        completionHandler(false)
                        return
                        
                    } else if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                        self.validation()
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please enter the value in any one of these fields: Series, RGN or RGD.", comment: ""))
                        completionHandler(false)
                        return
                    }
                    
                } else {
                    if !isGenotypeOnlyAdded {
                        addBtnCondtion(completionHandler: { (success) -> Void in
                            
                            completionHandler(true)
                        })
                    }
                    
                }
            }
            else{
                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                    if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
                        requiredflag = 1
                    } else {
                        requiredflag = 0
                    }
                }
                else{
                    requiredflag = 1
                }
                if  genotypeScanBarcodeTextField.text == "" || requiredflag == 0 {
                    
                    if genotypeScanBarcodeTextField.text == "" {
                        self.textFieldValidation()
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                        completionHandler(false)
                        return
                        
                        
                    } else if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == "" {
                        
                        self.textFieldValidation()
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please enter the value in any one of these fields: Series, RGN or RGD.", comment: ""))
                        completionHandler(false)
                        return
                        
                    }
                } else {
                    genotypeAddBtnCondtion(completionHandler: { (success) -> Void in
                        
                        completionHandler(true)
                    })
                    
                }
                
            }
            
        } else {
            
            if !isGenotypeOnlyAdded {
                if rGDTextfield.text == "" {
                    requiredflag = 0
                    
                } else if serieTextfield.text != "" && rGNTextfield.text == "" || serieTextfield.text == "" && rGNTextfield.text != ""  {
                    
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
                
                if scanBarcodeTextfield.text == "" || requiredflag == 0{
                    
                    if rGDTextfield.text == "" {
                        
                        if scanBarcodeTextfield.text == ""{
                            barcodeView.layer.borderColor = UIColor.red.cgColor
                        }
                        else {
                            barcodeView.layer.borderColor = UIColor.gray.cgColor
                            
                        }
                        
                        rGDTextfield.layer.borderColor = UIColor.red.cgColor
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                        completionHandler(false)
                        return
                        
                        
                    }
                    
                    
                    if scanBarcodeTextfield.text == "" {
                        
                        self.validation()
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                        completionHandler(false)
                        return
                        
                    } else if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                        self.validation()
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please enter the value in any one of these fields: Series, RGN or RGD.", comment: ""))
                        completionHandler(false)
                        return
                    }
                    
                } else {
                    if !isGenotypeOnlyAdded {
                        addBtnCondtion(completionHandler: { (success) -> Void in
                            if success {
                                completionHandler(true)
                            }
                        })
                    }
                }
            }
            else{
                if genotypeSerieTextfield.text == "" || genotypeRgnTextfield.text == "" {
                    requiredflag = 0
                    
                } else {
                    
                    requiredflag = 1
                }
                
                if  genotypeScanBarcodeTextField.text == "" || requiredflag == 0 {
                    
                    if genotypeScanBarcodeTextField.text?.count == 0 {
                        self.textFieldValidation()
                        
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                        completionHandler(false)
                        return
                        
                    } else {
                        
                        
                        if genotypeSerieTextfield.text == "" || genotypeRgnTextfield.text == "" {
                            if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" {
                                genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                                genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                                
                                if genotypeScanBarcodeTextField.text?.count == 0 {
                                    genotypeScanBarcodeView.layer.borderColor = UIColor.red.cgColor
                                    
                                }else {
                                    genotypeScanBarcodeView.layer.borderColor = UIColor.gray.cgColor
                                    
                                }
                                
                                
                                
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                completionHandler(false)
                                return                            }
                            
                            if genotypeSerieTextfield.text == "" {
                                
                                genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                                genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                                
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                completionHandler(false)
                                return
                            }
                            if genotypeRgnTextfield.text == ""{
                                genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                                genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                                
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                completionHandler(false)
                                return
                            }
                        }
                        
                        
                        if priorityBreeingBtnOutlet.titleLabel?.text! == "Cia De Melhoramento" {
                            
                            genotypeAddBtnCondtion(completionHandler: { (success) -> Void in
                                if success {
                                    completionHandler(true)
                                }
                            })
                        } else {
                            
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please enter the value in any one of these fields: Series, RGN or RGD.", comment: ""))
                            self.textFieldValidation()
                            
                            completionHandler(false)
                            return
                            
                        }
                    }
                    
                } else {
                    genotypeAddBtnCondtion(completionHandler: { (success) -> Void in
                        if success {
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
        self.networkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if networkStatusLbl?.text == "Connected".localized {
            
            networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
            offLineBtn.isEnabled = false
        }
        else {
            offLineBtn.isEnabled = true
            networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
            
        }
    }
    @objc func checkForReachability(notification:Notification){
        
        let del = UIApplication.shared.delegate as? AppDelegate
        self.networkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if networkStatusLbl?.text == "Connected".localized {
            networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
            offLineBtn.isEnabled = false
            
        }
        else {
            networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
            offLineBtn.isEnabled = true
            
        }
    }
    
    func addBtnCondtion(completionHandler: CompletionHandler){
        
        if breedId == ""
        {
            let breed = self.breedArrblack[0] as! GetBreedsTbl
            breedId = breed.breedId ?? ""
        }
        
        if checkBarcode {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Barcode must be ending with the number to use 'Incremental barcode'.", comment: ""))
            return
        }
        var dateVale = ""
        let dateStr = UserDefaults.standard.value(forKey: "date") as? String
        
        
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
        
        if dateTextField.text?.count == 0 {
            
            
        } else {
            
            if dateTextField.text?.count == 10 {
                let validate = isValidDate(dateString: dateTextField.text ?? "")
                
                
                if validate == "Correct Format" {
                    dobView.layer.borderColor = UIColor.gray.cgColor
                    dobView.layer.borderWidth = 0.5
                    validateDateFlag = true
                } else {
                    dobView.layer.borderColor = UIColor.red.cgColor
                    validateDateFlag = false
                    if validate == "GreaterThenDate" {
                        
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Date of birth cannot be greater than current date.", comment: ""))
                        return
                    } else {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Invalid date format.", comment: ""))
                        return
                    }
                    
                }
            } else {
                dobView.layer.borderColor = UIColor.red.cgColor
                validateDateFlag = false
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Invalid date format.", comment: ""))
                return
                
            }
        }
        
        
        let userIdAddAnimal = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        
        if barcodeflag {
            let barCode = fetchAnimaldataValidateAnimalBarcodeanimalIdOrderIdEarTag(entityName: Entities.beefAnimalAddTblEntity, animalbarCodeTag: scanBarcodeTextfield.text ?? "", userId: userIdAddAnimal, animalId: animalId1,orderSatatus:"false",orderid:orderId)
            if barCode.count > 0 {
                
                barcodeView.layer.borderColor = UIColor.red.cgColor
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Sample already exists in previous order.", comment: ""))
                return
            }
        }
        let animaBarcOde = fetchAnimaldataValidateAnimalBarcodeanimalIdearTag(entityName: "BeefAnimalMaster", animalbarCodeTag: scanBarcodeTextfield.text ?? "", userId: userIdAddAnimal, animalId: animalId1,orderStatus:"true",IsDataEmail: false)
        if animaBarcOde.count > 0 {
            
            barcodeView.layer.borderColor = UIColor.red.cgColor
            
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Sample already exists in previous order", comment: ""))
            return
        }
        if  validateRGD
        {
            let rGDCheck = fetchAnimaldataValidateAnimalRGD(entityName: Entities.beefAnimalAddTblEntity, RGD: rGDTextfield.text ?? "", userId: userIdAddAnimal, animalId: animalId1, orderSatatus: "false",orderid:orderId)
            if rGDCheck.count > 0
            {
                rGDTextfield.layer.borderColor = UIColor.red.cgColor
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Sample already exists in previous order.", comment: ""))
                return
                
            }
            
        }
        let rGDCheckMasterData = fetchAnimaldataValidateAnimalRGDmaster(entityName: "BeefAnimalMaster", RGD: rGDTextfield.text ?? "",userId: userIdAddAnimal, animalId: animalId1,orderSatatus:"true",IsDataEmail: false)
        if rGDCheckMasterData.count > 0 {
            rGDTextfield.layer.borderColor = UIColor.red.cgColor
            
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Sample already exists in previous order.", comment: ""))
            return
        }
        
        let animalData = fetchAnimaldataValidateAnimalTag(entityName: Entities.beefAnimalAddTblEntity, animalTag:scanBarcodeTextfield.text!, orderId: orderId, userId: userIdAddAnimal, animalId: animalId1)
        
        if animalData.count > 0 {
            let existAnimalData = animalData.lastObject as! BeefAnimaladdTbl
            if existAnimalData.orderstatus == "true" &&
               (existAnimalData.date != dateVale ||
                existAnimalData.breedId != breedId ||
                existAnimalData.gender?.localized != genderString){
              
                    let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Animal Record cannot be updated as the animal has been used for an order.", comment: ""), preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        let animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimalMaster", animalId: self.idAnimal, customerID: self.custmerId)
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
        
        incrementalBarCode = scanBarcodeTextfield.text ?? ""
        
        if animalData.count > 0  {
            let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: "BVDV", status: "true",ordrId:orderId, customerID: custmerId)
            if data12333.count > 0 {
                if  tissueBttn.titleLabel!.text! != "Allflex (TSU)" || tissueBttn.titleLabel!.text! != "Allflex (TST)" || tissueBttn.titleLabel!.text! != "Caisley (TSU)" {
                    let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Animal cannot be updated in order as BVDV product is selected and the animal sample type is other than Allflex (TSU), Allflex (TST) or Caisely (TSU). Do you want to save animal?", comment: ""), preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: NSLocalizedString("YES", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        self.byDefaultSetting()
                        
                    }
                    let cancelAction = UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        self.byDefaultSetting()
                        return
                        
                    }
                
                    alertController.addAction(cancelAction)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                
            }else {
                let dataEntryBeefanimal = checkAnimaldataAnimalBarcodeandAnimalIdAndEarTag(entityName: "DataEntryBeefAnimaladdTbl", animalTag: scanBarcodeTextfield.text!, sireId: serieTextfield.text ?? "", animalBarCode: animalTextfield.text!, userId: 1, orderStatus: "false",providerId:UserDefaults.standard.integer(forKey: "BeefPvid")) as! [DataEntryBeefAnimaladdTbl]
                if dataEntryBeefanimal.count > 0 {
                    updateOrderStatusISyncAnimalMaster(entity: "DataEntryBeefAnimaladdTbl", animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName:genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: 1,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userIdAddAnimal,udid:timeStampString,animalId: Int(dataEntryBeefanimal[0].animalId) ,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
                }
                isUpdate = true
                updateOrderStatusISyncAnimalMaster(entity: "BeefAnimalMaster", animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userIdAddAnimal,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "" )
                
                updateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalAddTblEntity,animalTag: scanBarcodeTextfield.text ?? "", barCodetag: animalTextfield.text ?? "", date: dateVale , damId: rGDTextfield.text ?? "", sireId: serieTextfield.text ?? "" , gender: genderString,update: "true", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userIdAddAnimal,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
                
                
                
                updateOrderStatusISyncProductbr(entity: Entities.productAdonAnimlBeefTblEntity,animalTag: scanBarcodeTextfield.text!,barCodetag: animalTextfield.text!,farmId: "",orderId: orderId,userId:userIdAddAnimal,animalId:animalId1,rgd: rGDTextfield.text ?? "",rgn:rGNTextfield.text ?? "",serie: serieTextfield.text ?? "")
                updateOrderStatusISyncSubProduct(entity: Entities.subProductBeefTblEntity,animalTag: scanBarcodeTextfield.text!,barCodetag:  animalTextfield.text!,farmId: "",orderId: orderId,userId:userIdAddAnimal,animalId: animalId1)
                
                
                let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userIdAddAnimal,farmId: "",animalTag:genotypeScanBarcodeTextField.text!,barcodeTag:genotypeAnimalNameTextfield.text!,sireID:genotypeSerieTextfield.text ?? "",damId: genotypeRgdTextfield.text ?? "")
                let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userIdAddAnimal, orderStatus:"false" )
                
                if adata.count > 0{
                    
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                    byDefaultSetting()
                    
                    
                }
                
                else if animalDataMaster.count > 0 {
                    if  msgUpatedd {
                        UserDefaults.standard.set(tissueBttn.titleLabel?.text, forKey: "tissueBttnClear")
                        UserDefaults.standard.set(tissueBttn.titleLabel?.text, forKey: "tissueBttn")
                        byDefaultSetting()
                        
                    }
                    else{
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                        byDefaultSetting()
                        
                    }
                    
                }
                
                editAid = animalId1
                animalId1 = 0
                
                if identify1 {
                    let data1 = fetchAllDataOrderStatus(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userIdAddAnimal)
                    if data1.count > 0 {
                        completionHandler(true)
                        return
                    }
                }
                
                
                completionHandler(true)
                scrolView.contentOffset.y = 0.0
            }
        }
        else if isUpdate {
            
            let animalData = checkAnimaldataAnimalBarcodeandAnimalIdAndEarTag(entityName: "DataEntryBeefAnimaladdTbl", animalTag: scanBarcodeTextfield.text!, sireId: serieTextfield.text ?? "", animalBarCode: animalTextfield.text!, userId: 1, orderStatus: "false",providerId:UserDefaults.standard.integer(forKey: "BeefPvid")) as! [DataEntryBeefAnimaladdTbl]
            if animalData.count > 0 {
                updateOrderStatusISyncAnimalMaster(entity: "DataEntryBeefAnimaladdTbl", animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName:genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: 1,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userIdAddAnimal,udid:timeStampString,animalId: Int(animalData[0].animalId),isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
            }
            
            animalId1 = editAid
            updateOrderStatusISyncAnimalMaster(entity: "BeefAnimalMaster", animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName:genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userIdAddAnimal,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
            
            updateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalAddTblEntity, animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "true", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userIdAddAnimal,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
            
            
            if identify1  {
                let data1 = fetchAllDataOrderStatus(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userIdAddAnimal)
                if data1.count > 0 {
                    completionHandler(true)
                    return
                }
            }
            isautoPopulated = false
            let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userIdAddAnimal,farmId: "",animalTag:genotypeScanBarcodeTextField.text!,barcodeTag:genotypeAnimalNameTextfield.text!,sireID:genotypeSerieTextfield.text ?? "",damId: genotypeRgdTextfield.text ?? "")
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userIdAddAnimal, orderStatus:"false" )
            
            if adata.count > 0{
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                byDefaultSetting()
                
                
            }
            
            else if animalDataMaster.count > 0 {
                UserDefaults.standard.set(tissueBttn.titleLabel?.text, forKey: "tissueBttnClear")
                UserDefaults.standard.set(tissueBttn.titleLabel?.text, forKey: "tissueBttn")
                byDefaultSetting()
                
            }
            else{
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                byDefaultSetting()
                
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
            var animalID1 = UserDefaults.standard.integer(forKey: "animalId")
            
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimalMaster", animalId :animalId1,orderId:orderId,userId:userIdAddAnimal, orderStatus:"false" )
            if animalDataMaster.count > 0{
              
                animalID1 = animalID1 + 1
                UserDefaults.standard.set(animalID1, forKey: "animalId")
                    
                updateOrderStatusISyncAnimalMasterAnimalId(entity: "BeefAnimalMaster", animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userIdAddAnimal,udid:timeStampString, animalId: animalId1,animalidNew:animalID1,isSyncServer:false, adhDataServer: false, tertiaryGeno: "")
                
            }
            else{
                
                animalID1 = animalID1 + 1
                UserDefaults.standard.set(animalID1, forKey: "animalId")
                
                let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimalMaster", animalId :animalId1,orderId:orderId,userId:userIdAddAnimal, orderStatus:"true" )
                
                
                if animalDataMaster.count > 0{
                    updateOrderStatusISyncAnimalMasterAnimalId(entity: "BeefAnimalMaster", animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU:"", userId: userIdAddAnimal,udid:timeStampString, animalId: animalId1,animalidNew:animalID1,isSyncServer:false, adhDataServer: false, tertiaryGeno: "")
                    
                    
                }
                else {
                    
                    saveAnimaldataBeefInProductId(entity: "BeefAnimalMaster", animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userIdAddAnimal,udid:timeStampString, animalId: animalID1, productId: Int(pid?.productId ?? 0),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: 0, serverAnimalId: "",tertiaryGeno: "")
                    createDataList()
                }
            }
            
            
            saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "true", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userIdAddAnimal,udid:timeStampString, animalId: animalID1, productId: Int(pid?.productId ?? 0),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: 0, serverAnimalId: "",tertiaryGeno: "")
            createDataList()
            
            let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:scanBarcodeTextfield.text!,orderId:orderId,userId:userIdAddAnimal)
            
            for k in 0 ..< animalData.count{
                
                let animalId = animalData[k] as! BeefAnimaladdTbl
                
                for i in 0 ..< product.count {
                    
                    let data = product[i] as! GetProductTblBeef
                    
                    beefSaveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.offsireId ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: animalId.farmId ?? "" , orderId: autoD, orderStatus: "false", isSync: "false", userId: userIdAddAnimal,udid:timeStampString, animalId: animalID1, rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "", marketName: data.marketName ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), orderTerrms: data.orderAcceptTerms ?? "")
                    
                    let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                    if addonArr.count > 0 {
                        
                        for j in 0 ..< addonArr.count {
                            
                            let addonDat = addonArr[j] as! GetAdonTbl
                            
                            saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userIdAddAnimal,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: animalID1, custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                            
                            msgShow()
                            
                        }
                    }
                    else {
                        msgShow()
                    }
                    
                }
            }
            
            if isBarcodeAutoIncrementedEnabled {
                UserDefaults.standard.set(true, forKey: "isBarCodeIncrementalClear")
                UserDefaults.standard.set(true, forKey: "isBarCodeIncremental")
                
            } else {
                UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                
                UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
                
            }
            
            
            UserDefaults.standard.set(tissueBttn.titleLabel?.text, forKey: "tissueBttnClear")
            UserDefaults.standard.set(tissueBttn.titleLabel?.text, forKey: "tissueBttn")
            if UserDefaults.standard.value(forKey: "NonGenoGender") as? String == "F" ||
                UserDefaults.standard.value(forKey: "NonGenoGender") as? String == nil {
                self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                genderToggleFlag = 0
                genderString = "Female".localized
                UserDefaults.standard.set("F", forKey: "NonGenoGender")
            } else {
                self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                genderToggleFlag = 1
                genderString = "Male".localized
                UserDefaults.standard.set("M", forKey: "NonGenoGender")
            }
            byDefaultSetting()
            otherbyTextfieldGray()
            scanBarcodeTextfield.text = ""
         
            
            let animalCount = fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userIdAddAnimal,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
            notificationLblCount.text = String(animalCount.count)
            
            let dateStr = UserDefaults.standard.value(forKey: "date") as? String
            let formatter = DateFormatter()
            
            if dateStr == "MM"{
                formatter.dateFormat = "MM/dd/yyyy"
            }
            else {
                formatter.dateFormat = "dd/MM/yyyy"
            }
            dateBttnOutlet.titleLabel?.text = ""
            barAutoPopu = false
            dateVale = ""
            completionHandler(true)
        }
        
        if UserDefaults.standard.bool(forKey: "isBarCodeIncremental")  {
            UserDefaults.standard.set(incrementalBarCode, forKey: "barcodeIncremental")
        }
        incrementalBarCode = ""
        
        
        
        if UserDefaults.standard.bool(forKey: "isBarCodeIncremental"), let lastSavedBarCode = UserDefaults.standard.value(forKey: "barcodeIncremental") as? String {
            scanBarcodeTextfield.text = isBarcodeEndingWithNumberAndGetIncremented(lastSavedBarCode).incrementedBarCode
            
            if scanBarcodeTextfield.text?.isEmpty == false {
                othersByDefaultBackroundWhite()
            }
        }
        self.scrolView.contentOffset.y = 0.0
    }
    func msgShow()  {
        statusOrder = false
        UserDefaults.standard.removeObject(forKey: "review")
        self.animalSucInOrder = ""
        if !self.msgAnimalSucess {
            if self.addContiuneBtn == 1 {
                if self.msgcheckk  {
                    self.view.makeToast(NSLocalizedString("Animal record updated and added in order successfully.", comment: ""), duration: 1, position: .bottom)
                }
                else {
                    
                    if self.isautoPopulated {
                        self.view.makeToast(NSLocalizedString("Animal added successfully in order.", comment: ""), duration: 1, position: .bottom)
                    } else {
                        self.view.makeToast(NSLocalizedString("Animal added successfully.", comment: ""), duration: 1, position: .bottom)
                    }
                }
            } else if self.addContiuneBtn == 2{
                if self.msgcheckk  {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal record updated and added in order successfully.", comment: ""))
                }
                else{
                    if self.isautoPopulated {
                        
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal added successfully in order.", comment: ""))
                        
                    } else {
                        
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal added successfully.", comment: ""))
                    }
                }
            }else {
                if self.msgcheckk {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal record updated and added in order successfully.", comment: ""))
                }
                else{
                    if self.isautoPopulated {
                        
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal added successfully in order.", comment: ""))
                        
                    } else {
                        
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal added successfully.", comment: ""))
                    }
                }
                
            }
            self.msgAnimalSucess = false
        } else {
            if self.msgcheckk {
                self.view.makeToast(NSLocalizedString("Animal record updated and added in order successfully.", comment: ""), duration: 1, position: .bottom)
            }
            else{
                if self.isautoPopulated {
                    self.view.makeToast(NSLocalizedString("Animal added successfully in order.", comment: ""), duration: 1, position: .bottom)
                }else {
                    self.view.makeToast(NSLocalizedString("Animal added successfully.", comment: ""), duration: 1, position: .bottom)
                    
                }
            }
        }
        
        UserDefaults.standard.set(priorityBreeingBtnOutlet.titleLabel?.text, forKey: keyValue.primaryGenoType.rawValue)
        UserDefaults.standard.set(secondaryBreddingOutlet.titleLabel?.text, forKey: keyValue.secondaryGenoType.rawValue)
        UserDefaults.standard.set(territoryBreddingOutlet.titleLabel?.text, forKey: keyValue.tertirayGenoType.rawValue)
        UserDefaults.standard.set(breedId, forKey: keyValue.beefBreedID.rawValue)
        UserDefaults.standard.set(selectBreedBtn.titleLabel?.text, forKey: keyValue.beefBreedName.rawValue)
        
    }
    
    
    func genotypeAddBtnCondtion(completionHandler: CompletionHandler){
        
        if UserDefaults.standard.value(forKey: "GenoGender") as? String == "F" || UserDefaults.standard.value(forKey: "GenoGender") as? String == nil {
            self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 0
            genderString = "Female".localized
            UserDefaults.standard.set("F", forKey: "GenoGender")
        } else {
            self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 1
            genderString = "Male".localized
            UserDefaults.standard.set("M", forKey: "GenoGender")
        }
        
        var dataListDetail = [DataEntryList]()
        let listName = orderingDataListViewModel.makeListName(custmerId: custmerId, providerID: pvid)
        if listName != "" {
            dataListDetail =  fetchDatalistDetailbyName(listName: listName)
        }
        
        if breedId == ""
        {
            let breed = self.breedArr[0] as! GetBreedsTbl
            breedId = breed.breedId ?? ""
        }
        
        if checkBarcode {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Barcode must be ending with the number to use 'Incremental barcode'.", comment: ""))
            return
        }
        var dateVale = ""
        let dateStr = UserDefaults.standard.value(forKey: "date") as? String
        
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            
            dateVale = genotypeDateTextField.text ?? ""
            if dateStr == "DD"{
                dateVale = genotypeDOBBttn.titleLabel?.text ?? ""
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
            
            dateVale = genotypeDOBBttn.titleLabel?.text ?? ""
            if dateStr == "DD"{
                dateVale = genotypeDOBBttn.titleLabel?.text ?? ""
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
        
        
        if genotypeDateTextField.text?.count == 0 {
            
            
        } else {
            
            if genotypeDateTextField.text?.count == 10 {
                let validate = isValidDate(dateString: genotypeDateTextField.text ?? "")
                
                
                if validate == "Correct Format" {
                    dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
                    dateBttnOutlet.layer.borderWidth = 0.5
                    validateDateFlag = true
                } else {
                    dateBttnOutlet.layer.borderColor = UIColor.red.cgColor
                    validateDateFlag = false
                    if validate == "GreaterThenDate" {
                        
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Date of birth cannot be greater than current date.", comment: ""))
                        return
                    } else {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Invalid date format.", comment: ""))
                        return
                    }
                    
                }
            } else {
                dateBttnOutlet.layer.borderColor = UIColor.red.cgColor
                validateDateFlag = false
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Invalid date format.", comment: ""))
                return
                
            }
        }
        let userIdGenoAddCondition = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        
        
        incrementalBarCode = genotypeScanBarcodeTextField.text ?? ""
        
        if genotypeRgdTextfield.text?.count ?? 0 > 0{
            let genobarCodeRGD = fetchAnimaBarcodeValidateWithoutOrderIdRGD(entityName: "DataEntryBeefAnimaladdTbl",RGD:genotypeRgdTextfield.text ?? "",orderSatatus: "false") as! [DataEntryBeefAnimaladdTbl]
            if genobarCodeRGD.count > 0,
               dataListDetail.count > 0,
               genobarCodeRGD[0].listId != dataListDetail[0].listId {
                    genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Sample already exists in a list.", comment: ""))
                    return
            }
        }
        
        if barcodeflag {
            let barCode = fetchAnimaldataValidateAnimalBarcodeanimalIdOrderIdEarTag(entityName: Entities.beefAnimalAddTblEntity, animalbarCodeTag: genotypeScanBarcodeTextField.text ?? "", userId: userIdGenoAddCondition, animalId: animalId1,orderSatatus:"false",orderid:orderId )
            if barCode.count > 0 {
                genotypeScanBarcodeView.layer.borderColor = UIColor.red.cgColor
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Sample already exists in previous order.", comment: ""))
                return
            }
        }
        let animaBarcOde = fetchAnimaldataValidateAnimalBarcodeanimalIdearTag(entityName: "BeefAnimalMaster", animalbarCodeTag: genotypeScanBarcodeTextField.text ?? "", userId: userIdGenoAddCondition, animalId: animalId1,orderStatus:"true",IsDataEmail: false)
        if animaBarcOde.count > 0 {
            genotypeScanBarcodeView.layer.borderColor = UIColor.red.cgColor
            
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString("Sample already exists in previous order.", comment: ""))
            return
        }
        
        if genovalidateRGD && genotypeRgdTextfield.text != ""{
            
            let rGDCheck = fetchAnimaldataValidateAnimalRGD(entityName: Entities.beefAnimalAddTblEntity, RGD: genotypeRgdTextfield.text ?? "", userId: userIdGenoAddCondition, animalId: animalId1, orderSatatus: "false",orderid:orderId)
            if rGDCheck.count > 0
            {
                genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Sample already exists in previous order.", comment: ""))
                return
                
            }
            
        }
        if genotypeRgdTextfield.text?.count ?? 0 > 0 {
            let rGDCheckMasterData = fetchAnimaldataValidateAnimalRGDmaster(entityName: "BeefAnimalMaster", RGD: genotypeRgdTextfield.text ?? "",userId: userIdGenoAddCondition, animalId: animalId1,orderSatatus:"true",IsDataEmail: false)
            if rGDCheckMasterData.count > 0 {
                genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Sample already exists in previous order.", comment: ""))
                return
            }
        }
        
        let animalData = fetchAnimaldataValidateAnimalTag(entityName: Entities.beefAnimalAddTblEntity, animalTag:genotypeScanBarcodeTextField.text!, orderId: orderId, userId: userIdGenoAddCondition, animalId: animalId1)
        if animalData.count > 0 {
            let existAnimalData = animalData.lastObject as! BeefAnimaladdTbl
            if existAnimalData.orderstatus == "true" {
                if existAnimalData.date != dateVale || existAnimalData.breedId != breedId || existAnimalData.gender?.localized != genderString {
                    
                    let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Animal Record cannot be updated as the animal has been used for an order.", comment: ""), preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        let animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimalMaster", animalId: self.idAnimal, customerID: self.custmerId)
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
        }
        
        if animalData.count > 0  {
            let dataEntryBeefanimal = checkAnimaldataAnimalBarcodeandAnimalIdAndEarTag(entityName: "DataEntryBeefAnimaladdTbl", animalTag: genotypeScanBarcodeTextField.text!, sireId: genotypeSerieTextfield.text ?? "", animalBarCode:  genotypeAnimalNameTextfield.text!, userId: 1, orderStatus: "false",providerId:UserDefaults.standard.integer(forKey: "BeefPvid")) as! [DataEntryBeefAnimaladdTbl]
            if dataEntryBeefanimal.count > 0 {
                
                updateOrderStatusISyncAnimalMaster(entity: "DataEntryBeefAnimaladdTbl", animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: 1,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userIdGenoAddCondition,udid:timeStampString,animalId: Int(dataEntryBeefanimal[0].animalId),isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
                
            }
            isUpdate = true
            updateOrderStatusISyncAnimalMaster(entity: "BeefAnimalMaster", animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userIdGenoAddCondition,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
            
            updateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalAddTblEntity,animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "true", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: (priorityBreeingBtnOutlet.titleLabel!.text!), nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userIdGenoAddCondition,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
            
            
            
            updateOrderStatusISyncProductbr(entity: Entities.productAdonAnimlBeefTblEntity,animalTag: genotypeScanBarcodeTextField.text ?? "",barCodetag:  genotypeAnimalNameTextfield.text ?? "",farmId: "",orderId: orderId,userId:userIdGenoAddCondition,animalId:animalId1,rgd: genotypeRgdTextfield.text ?? "",rgn: genotypeRgnTextfield.text ?? "",serie: genotypeSerieTextfield.text ?? "")
            
            
            updateOrderStatusISyncSubProduct(entity: Entities.subProductBeefTblEntity,animalTag: genotypeScanBarcodeTextField.text!,barCodetag:  genotypeAnimalNameTextfield.text!,farmId: "",orderId: orderId,userId:userIdGenoAddCondition,animalId: animalId1)
            
            
            let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userIdGenoAddCondition,farmId: "",animalTag:genotypeScanBarcodeTextField.text!,barcodeTag:genotypeAnimalNameTextfield.text!,sireID:genotypeSerieTextfield.text ?? "",damId: genotypeRgdTextfield.text ?? "")
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userIdGenoAddCondition, orderStatus:"false" )
            
            if adata.count > 0{
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                genotypeByDefaultScreen()
                
                
            }
            
            else if animalDataMaster.count > 0 {
                if  msgUpatedd {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal record updated successfully.", comment: ""))
                    UserDefaults.standard.set(genotypeTissueBttn.titleLabel?.text, forKey: "genotypeTissueBttnClear")
                    UserDefaults.standard.set(genotypeTissueBttn.titleLabel?.text, forKey: "genotypeTissueBttn")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.genotypeByDefaultScreen()
                    }
                }
                
                let isFromCart = UserDefaults.standard.bool(forKey: "isAnimalClickedFromBeefCart")
                    if isFromCart {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal record updated successfully.", comment: ""))
                        UserDefaults.standard.set(genotypeTissueBttn.titleLabel?.text, forKey: "genotypeTissueBttnClear")
                        UserDefaults.standard.set(genotypeTissueBttn.titleLabel?.text, forKey: "genotypeTissueBttn")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.genotypeByDefaultScreen()
                        }
                    }
            }
            else{
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                genotypeByDefaultScreen()
                
            }
            
            editAid = animalId1
            animalId1 = 0
            
            if identify1 {
                let data1 = fetchAllDataOrderStatus(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userIdGenoAddCondition)
                if data1.count > 0 {
                    completionHandler(true)
                    return
                }
            }
            
            
            completionHandler(true)
            scrolView.contentOffset.y = 0.0
        }
        else if isUpdate {
            let dataEntryBeefanimal = checkAnimaldataAnimalBarcodeandAnimalIdAndEarTag(entityName: "DataEntryBeefAnimaladdTbl", animalTag: genotypeScanBarcodeTextField.text!, sireId: genotypeSerieTextfield.text ?? "", animalBarCode: genotypeAnimalNameTextfield.text!, userId: 1, orderStatus: "false",providerId:UserDefaults.standard.integer(forKey: "BeefPvid")) as! [DataEntryBeefAnimaladdTbl]
            if dataEntryBeefanimal.count > 0 {
                
                updateOrderStatusISyncAnimalMaster(entity: "DataEntryBeefAnimaladdTbl", animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: 1,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userIdGenoAddCondition,udid:timeStampString,animalId: Int(dataEntryBeefanimal[0].animalId),isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
            }
            
            animalId1 = editAid
            updateOrderStatusISyncAnimalMaster(entity: "BeefAnimalMaster", animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userIdGenoAddCondition,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
            
            updateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalAddTblEntity, animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "true", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userIdGenoAddCondition,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
            
            
            
            
            
            if identify1 {
                let data1 = fetchAllDataOrderStatus(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userIdGenoAddCondition)
                if data1.count > 0 {
                    completionHandler(true)
                    return
                }
            }
            isautoPopulated = false
            let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userIdGenoAddCondition,farmId: "",animalTag:genotypeScanBarcodeTextField.text!,barcodeTag:genotypeAnimalNameTextfield.text!,sireID:genotypeSerieTextfield.text ?? "",damId: genotypeRgdTextfield.text ?? "")
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userIdGenoAddCondition, orderStatus:"false" )
            
            if adata.count > 0{
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                genotypeByDefaultScreen()
                
                
            }
            
            else if animalDataMaster.count > 0 {
                UserDefaults.standard.set(genotypeTissueBttn.titleLabel?.text, forKey: "genotypeTissueBttnClear")
                UserDefaults.standard.set(genotypeTissueBttn.titleLabel?.text, forKey: "genotypeTissueBttn")
                
                genotypeByDefaultScreen()
                
            }
            else{
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                genotypeByDefaultScreen()
                
            }
            
            completionHandler(true)
            scrolView.contentOffset.y = 0.0
        }
        else {
            isUpdate = false
            let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
            let pid = product[0] as! GetProductTblBeef
            var animalID1 = UserDefaults.standard.integer(forKey: "animalId")
            
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimalMaster", animalId :animalId1,orderId:orderId,userId:userIdGenoAddCondition, orderStatus:"false" )
            if animalDataMaster.count > 0{
               UserDefaults.standard.set(animalID1, forKey: "animalId")
        
                updateOrderStatusISyncAnimalMasterAnimalId(entity: "BeefAnimalMaster", animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userIdGenoAddCondition,udid:timeStampString, animalId: animalId1,animalidNew:animalID1,isSyncServer:false, adhDataServer: false, tertiaryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
                
            }
            else{
                animalID1 = animalID1 + 1
                UserDefaults.standard.set(animalID1, forKey: "animalId")
                
                let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimalMaster", animalId :animalId1,orderId:orderId,userId:userIdGenoAddCondition, orderStatus:"true" )
                
                
                if animalDataMaster.count > 0{
                    updateOrderStatusISyncAnimalMasterAnimalId(entity: "BeefAnimalMaster", animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU:secondaryBreddingOutlet.titleLabel!.text!, userId: userIdGenoAddCondition,udid:timeStampString, animalId: animalId1,animalidNew:animalID1,isSyncServer:false, adhDataServer: false, tertiaryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
                }
                else {
                    
                    saveAnimaldataBeefInProductId(entity: "BeefAnimalMaster", animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userIdGenoAddCondition,udid:timeStampString, animalId: animalID1, productId: Int(pid.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: 0, serverAnimalId: "",IsEmailData: false,tertiaryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
                    
                    createDataList()
                }
            }
            
            saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "true", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userIdGenoAddCondition,udid:timeStampString, animalId: animalID1, productId: Int(pid.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: 0, serverAnimalId: "",IsEmailData: false, tertiaryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
            createDataList()
            
            
            let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:genotypeScanBarcodeTextField.text!,orderId:orderId,userId:userIdGenoAddCondition)
            
            
            for k in 0 ..< animalData.count{
                
                let animalId = animalData[k] as! BeefAnimaladdTbl
                
                for i in 0 ..< product.count {
                    
                    let data = product[i] as! GetProductTblBeef
                    beefSaveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.offsireId ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: animalId.farmId ?? "" , orderId: autoD, orderStatus: "false", isSync: "false", userId: userIdGenoAddCondition,udid:timeStampString, animalId: animalID1, rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "", marketName: data.marketName ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), orderTerrms: data.orderAcceptTerms ?? "")
                    
                    
                    
                    let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                    if addonArr.count > 0 {
                        for j in 0 ..< addonArr.count {
                            
                            let addonDat = addonArr[j] as! GetAdonTbl
                            
                            saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userIdGenoAddCondition,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: animalID1,custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                            
                            msgShow()
                        }
                    }
                    else {
                        msgShow()
                    }
                    
                }
            }
            UserDefaults.standard.set(genotypeTissueBttn.titleLabel?.text, forKey: "genotypeTissueBttnClear")
            UserDefaults.standard.set(genotypeTissueBttn.titleLabel?.text, forKey: "genotypeTissueBttn")
            genotypeByDefaultScreen()
            
            if isBarcodeAutoIncrementedEnabled  {
                UserDefaults.standard.set(true, forKey: "isBarCodeIncrementalClear")
                UserDefaults.standard.set(true, forKey: "isBarCodeIncremental")
                
            } else {
                UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                
                UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
                
            }
            genotypeScanBarcodeTextField.text = ""
                        
            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userIdGenoAddCondition,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
            notificationLblCount.text = String(animalCount.count)
            
            let dateStr = UserDefaults.standard.value(forKey: "date") as? String
            let formatter = DateFormatter()
            
            if dateStr == "MM"{
                formatter.dateFormat = "MM/dd/yyyy"
            }
            else {
                formatter.dateFormat = "dd/MM/yyyy"
            }
            
            dateVale = ""
            genotypeDOBBttn.titleLabel!.text  = ""
            genotypeDOBBttn.setTitle("", for: .normal)
            completionHandler(true)
        }
        barAutoPopu = false
        if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") {
            UserDefaults.standard.set(incrementalBarCode, forKey: "barcodeIncremental")
        }
        incrementalBarCode = ""
        
        
        if UserDefaults.standard.bool(forKey: "isBarCodeIncremental"),
           let lastSavedBarCode = UserDefaults.standard.value(forKey: "barcodeIncremental") as? String{
            genotypeScanBarcodeTextField.text = isBarcodeEndingWithNumberAndGetIncremented(lastSavedBarCode).incrementedBarCode
            if genotypeScanBarcodeTextField.text?.isEmpty == false {
                self.genotypeByDefaultBackroundWhite()
            }
        }
        
        view.endEditing(true)
        self.genotypeScrollView.contentOffset.y = 0.0
        
        UserDefaults.standard.set(priorityBreeingBtnOutlet.titleLabel?.text, forKey: keyValue.primaryGenoType.rawValue)
        UserDefaults.standard.set(secondaryBreddingOutlet.titleLabel?.text, forKey: keyValue.secondaryGenoType.rawValue)
        UserDefaults.standard.set(territoryBreddingOutlet.titleLabel?.text, forKey: keyValue.tertirayGenoType.rawValue)
        UserDefaults.standard.set(breedId, forKey: keyValue.beefBreedID.rawValue)
        UserDefaults.standard.set(selectBreedBtn.titleLabel?.text, forKey: keyValue.beefBreedName.rawValue)
    }
    
    
    func genotypeDoDatePicker(){
        self.datePicker = UIDatePicker(frame:CGRect(x: 20, y: 40, width: self.calenderView.frame.size.width, height: 260))
        self.datePicker?.backgroundColor = UIColor.white
        if langId == 2
        {
            self.datePicker?.locale = Locale(identifier: "pt")
        }
        else if langId == 3
        {
            self.datePicker?.locale = Locale(identifier: "it")
        }
        else
        {
            self.datePicker?.locale = Locale(identifier: "en")
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
        
        let doneButton = UIBarButtonItem(title: "Done".localized, style: .plain, target: self, action: #selector(self.genotypeDoneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel".localized, style: .plain, target: self, action: #selector(self.cancelClick))
        cancelButton.tintColor = UIColor.black
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = CGRect(x: 0, y: 0, width: self.calenderView.frame.size.width, height: 40)
        self.calenderView.addSubview(toolBar)
        self.toolBar.isHidden = false
        
    }
    func doDatePicker(){
        self.datePicker = UIDatePicker(frame:CGRect(x: 20, y: 40, width: self.calenderView.frame.size.width, height: 260))
        self.datePicker?.backgroundColor = UIColor.white
        if langId == 2
        {
            self.datePicker?.locale = Locale(identifier: "pt")
        }
        else if langId == 3
        {
            self.datePicker?.locale = Locale(identifier: "it")
        }
        else
        {
            self.datePicker?.locale = Locale(identifier: "en")
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
    @objc func doneClick() {
        let date = UserDefaults.standard.value(forKey: "date") as? String
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        let dateFormatter3 = DateFormatter()
        if date == "MM"{
            dateFormatter3.dateFormat = "MM/dd/yyyy"
        }
        else {
            dateFormatter3.dateFormat = "dd/MM/yyyy"
        }
        self.selectedDate = datePicker.date
        
        let selectedDateFromPicker = dateFormatter3.string(from: datePicker.date)
        dateBttnOutlet.setTitle(selectedDateFromPicker, for: .normal)
        
        self.datePicker.resignFirstResponder()
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        calenderView.isHidden = true
        calenderbkg.isHidden = true
    }
    
    @objc func genotypeDoneClick() {
        let date = UserDefaults.standard.value(forKey: "date") as? String
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        let dateFormatter3 = DateFormatter()
        if date == "MM"{
            dateFormatter3.dateFormat = "MM/dd/yyyy"
        }
        else {
            dateFormatter3.dateFormat = "dd/MM/yyyy"
        }
        self.selectedDate = datePicker.date
        
        let selectedDateFromPicker = dateFormatter3.string(from: datePicker.date)
        genotypeDOBBttn.setTitle(selectedDateFromPicker, for: .normal)
        
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
    func continueproduct(){
        
        let userIdContinue = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        identify1 = true
        let data1 = fetchAllDataOrderStatus(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userIdContinue)
        
        let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
        
        if  identyCheck == false || identyCheck == nil{
            if data1.count > 0 {
                if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                    requiredflag = 0
                }
                else{
                    requiredflag = 1
                }
                
                if  scanBarcodeTextfield.text == "" || requiredflag == 0{
                    
                    
                    if scanBarcodeTextfield.text != ""{
                        if rGDTextfield.text == "" {
                            rGDTextfield.layer.borderColor = UIColor.red.cgColor
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                        }
                    }
                    
                    
                    if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil {
                        if UserDefaults.standard.value(forKey: "On") as? String == "off"{
                            self.navigateToBeefOrderingScreen(screenType: 2)
                            
                        }
                        else {
                            navigateToBeefOrderingScreen()
                        }
                    } else {
                        if  UserDefaults.standard.value(forKey: keyValue.page.rawValue) == nil {
                            if UserDefaults.standard.value(forKey: "On") as? String == "off"{
                                self.navigateToBeefOrderingScreen(screenType: 2)
                            }
                            else {
                                navigateToBeefOrderingScreen()
                            }
                        }
                        else{
                            self.navigateToBeefOrderingScreen(screenType: 2)
                        }
                    }
                } else {
                    
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        
                        
                        if success {
                            
                            let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                            if  identyCheck == true {
                                self.navigateToBeefOrderingScreen(screenType: 2)
                                
                            }  else {
                                if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil{
                                    
                                    if UserDefaults.standard.value(forKey: "On") as? String == "off"{
                                        self.navigateToBeefOrderingScreen(screenType: 2)
                                    }
                                    else {
                                        self.navigateToBeefOrderingScreen()
                                    }
                                    
                                } else {
                                    self.navigateToBeefOrderingScreen(screenType: 2)
                                    
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
                
                if scanBarcodeTextfield.text == "" || requiredflag == 0 {
                    if scanBarcodeTextfield.text == "" && requiredflag == 0 {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please add at least one animal.", comment: ""))
                        self.validation()
                    } else {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                        self.validation()
                    }
                }
                else {
                    
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        if success {
                            if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil{
                                self.navigateToBeefOrderingScreen(screenType: 2)
                                if UserDefaults.standard.value(forKey: "On") as? String == "off"{
                                }
                                else {
                                    self.navigateToBeefOrderingScreen()
                                }
                                
                            } else {
                                self.navigateToBeefOrderingScreen(screenType: 2)
                                
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
                
                if scanBarcodeTextfield.text == "" || requiredflag == 0{
                        self.navigateToBeefOrderingScreen(screenType: 2)
                }
                else{
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        if success {
                            self.navigateToBeefOrderingScreen(screenType: 2)
                        }
                    })
                }
            }
            else{
                addAnimalBtn(completionHandler: { (success) -> Void in
                    if success {
                        self.navigateToBeefOrderingScreen(screenType: 2)
                    }
                })
            }
        }
    }
    
    // MARK: - IB ACTIONS
    @IBAction func genotypeContinueProductAction(_ sender: UIButton)
    {
        addContiuneBtn = 2
        genotypecontinueproduct()
    }
    
    
    
    @IBAction func maleBtnClick(_ sender: Any) {
        self.view.endEditing(true)
        if genderToggleFlag == 0 {
            self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 1
            genderString = NSLocalizedString("Male", comment: "")
            UserDefaults.standard.set("M", forKey: "GenoGender")
            
        } else {
            self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 0
            genderString = "Female".localized
            UserDefaults.standard.set("F", forKey: "GenoGender")
        }
        
        _ = statusOrderTrue()
        if statusOrder {
            msgAnimalSucess = true
        } else {
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    @IBAction func sideMenuAction(_ sender: UIButton) {
        
        self.sideMenuViewController?.presentRightMenuViewController()
        self.view.makeCorner(withRadius: 40)
    }
    
    @IBAction func addAction(_ sender: UIButton) {
        let tag = sender.tag
        if tag == 0 {
            view1.isHidden = false
            view2.isHidden = true
            closeImage1.addGestureRecognizer(tapRec)
        } else {
            view1.isHidden = true
            view2.isHidden = false
            closeImage2.addGestureRecognizer(tapRec)
        }
    }
    @IBAction func selectBreedTypeblackstar(_ sender: Any) {
        btnTag = 117
        view.endEditing(true)
        self.tableViewpop()
        
        let pvIdBeef = UserDefaults.standard.integer(forKey: "BeefPvid")
        breedArrblack = fetchproviderProductDataGlobal(entityName: Entities.getBreedsTblEntity, provId: pvIdBeef, productId: 24, speciesName: "")
        var yFrame = (breedblackstarlablehide.frame.minY + 130) - self.scrolView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
            case 1334:
                yFrame = (breedblackstarlablehide.frame.minY + 105) - self.scrolView.contentOffset.y
                
            case 1920, 2208:
                yFrame = (breedblackstarlablehide.frame.minY + 110) - self.scrolView.contentOffset.y
                
            case 2436:
                break
            case 2688,2796:
                break
            case 1792:
                yFrame = (breedblackstarlablehide.frame.minY + 143) - self.scrolView.contentOffset.y
                
            default:
                break
            }
        }
        droperTableView.frame = CGRect(x: genstarblackBreedBtn.frame.minX+20,y: yFrame,width: 145,height: 300)
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder {
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
        
    }
    
    @IBAction func selectBreedTypeBtnAction(_ sender: Any) {
        
        btnTag = 116
        view.endEditing(true)
        self.tableViewpop()
        
        let pvIdBeef = UserDefaults.standard.integer(forKey: "BeefPvid")
        breedArr = fetchproviderProductDataGlobal(entityName: Entities.getBreedsTblEntity, provId: pvIdBeef, productId: 23, speciesName: "")
        var yFrame = (breedlablehide.frame.minY + 130) - self.genotypeScrollView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
            case 1334:
                yFrame = (breedlablehide.frame.minY + 105) - self.genotypeScrollView.contentOffset.y
                
            case 1920, 2208:
                yFrame = (breedlablehide.frame.minY + 110) - self.genotypeScrollView.contentOffset.y
                
            case 2436:
                break
            case 2688,2796:
                break
            case 1792:
                yFrame = (breedlablehide.frame.minY + 143) - self.genotypeScrollView.contentOffset.y
                
            default:
                break
            }
        }
        droperTableView.frame = CGRect(x:selectBreedBtn.frame.minX+20,y: yFrame,width: 150,height: 300)
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder {
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
        
    }
    
    @IBAction func tissureBtnAction(_ sender: Any) {
        
        btnTag = 10
        view.endEditing(true)
        let pvIdBeef = UserDefaults.standard.integer(forKey: "BeefPvid")
        tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvIdBeef)
        self.tableViewpop()
        var yFrame = (genotypeTissueHideLbl.frame.minY + 130) - self.genotypeScrollView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .phone {
            
            switch UIScreen.main.nativeBounds.height {
                
            case 1136:
                
                break
            case 1334:
                
                yFrame = (genotypeTissueHideLbl.frame.minY + 105) - self.genotypeScrollView.contentOffset.y
            case 1920, 2208:
                
                yFrame = (genotypeTissueHideLbl.frame.minY + 113) - self.genotypeScrollView.contentOffset.y
                
            case 2436:
                
                break
                
            case 2688,2796:
                
                break
                
            case 1792:
                
                yFrame = (genotypeTissueHideLbl.frame.minY + 143) - self.genotypeScrollView.contentOffset.y
                
            default:
                
                break
                
            }
        }
        
        droperTableView.frame = CGRect(x: 30,y: yFrame,width: 150,height: 200)
        
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
        
    }
    @IBAction func prioorityBreddingAction(_ sender: Any) {
        
        btnTag = 20
        view.endEditing(true)
        priorityBreeding = fetchAllData(entityName: "GetPriorityBreeding")
        self.tableViewpop()
        var yFrame = (priorityBreddingLbl.frame.minY + 130) - self.genotypeScrollView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .phone {
            
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
            case 1334:
                yFrame = (priorityBreddingLbl.frame.minY + 110) - self.genotypeScrollView.contentOffset.y
            case 1920, 2208:
                
                yFrame = (priorityBreddingLbl.frame.minY + 120) - self.genotypeScrollView.contentOffset.y
                
            case 2436:
                break
                
            case 2688,2796:
                break
                
            case 1792:
                yFrame = (priorityBreddingLbl.frame.minY + 143) - self.genotypeScrollView.contentOffset.y
                
            default:
                
                break
            }
        }
        
        droperTableView.frame = CGRect(x: 25,y: yFrame,width: 300,height: 250)
        
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder {
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func secondayBtnAction(_ sender: Any) {
        
        btnTag = 30
        view.endEditing(true)
        
        secondaryBreeding = fetchAllData(entityName: "GetSecondaryBreedingPrograms")
        self.tableViewpop()
        
        var yFrame = (secondaryHidenLbl.frame.minY + 130) - self.genotypeScrollView.contentOffset.y
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
            case 1334:
                yFrame = (secondaryHidenLbl.frame.minY + 110) - self.genotypeScrollView.contentOffset.y
            case 1920, 2208:
                yFrame = (secondaryHidenLbl.frame.minY + 119) - self.genotypeScrollView.contentOffset.y
                
            case 2436:
                break
                
            case 2688,2796:
                break
                
            case 1792:
                yFrame = (secondaryHidenLbl.frame.minY + 143) - self.genotypeScrollView.contentOffset.y
                
            default:
                break
            }
        }
        
        droperTableView.frame = CGRect(x: 25,y: yFrame,width: 300,height: 250)
        droperTableView.reloadData()
        
        _ = statusOrderTrue()
        if statusOrder {
            msgAnimalSucess = true
        } else {
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func tertiaryButtonAction(_ sender: Any) {
        
        btnTag = 50
        view.endEditing(true)
        
        tertiaryBreeding = fetchAllData(entityName: "GetTertiaryBreedingPrograms")
        self.tableViewpop()
        
        var yFrame = (territoryHidenLbl.frame.minY + 130) - self.genotypeScrollView.contentOffset.y
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
            case 1334:
                yFrame = (territoryHidenLbl.frame.minY + 110) - self.genotypeScrollView.contentOffset.y
            case 1920, 2208:
                yFrame = (territoryHidenLbl.frame.minY + 119) - self.genotypeScrollView.contentOffset.y
                
            case 2436:
                break
                
            case 2688,2796:
                break
                
            case 1792:
                yFrame = (territoryHidenLbl.frame.minY + 143) - self.genotypeScrollView.contentOffset.y
                
            default:
                break
            }
        }
        
        droperTableView.frame = CGRect(x: 25,y: yFrame,width: 300,height: 250)
        droperTableView.reloadData()
        
        _ = statusOrderTrue()
        if statusOrder {
            msgAnimalSucess = true
        } else {
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    
    @IBAction func genotypeAddAnimalAction(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        addContiuneBtn = 1
        UserDefaults.standard.setValue("addAnotherAnimal", forKey: "isToUpdateAndAddAnimal")
        addAnimalBtn(completionHandler: { (success) -> Void in
            if self.isGenotypeOnlyAdded
            {
                self.genotypeScanBarcodeTextField.becomeFirstResponder()
            }
            else
            {
                self.scanBarcodeTextfield.becomeFirstResponder()
            }
        })
        
        
    }
    @IBAction func otherMaleBtnAction(_ sender: Any) {
        
        self.view.endEditing(true)
        if othersGenderToggleFlag == 0 {
            self.maleFemaleBttn.setImage(UIImage(named: "LangMale\(langCode)"), for: .normal)
            othersGenderToggleFlag = 1
            othersGenderString = NSLocalizedString("Male", comment: "")
            genderString = othersGenderString
            UserDefaults.standard.set("M", forKey: "NonGenoGender")
            
        } else {
            self.maleFemaleBttn.setImage(UIImage(named: "LangFemale\(langCode)"), for: .normal)
            othersGenderToggleFlag = 0
            othersGenderString = "Female".localized
            genderString = othersGenderString
            UserDefaults.standard.set("F", forKey: "NonGenoGender")
        }
        
        _ = statusOrderTrue()
        if statusOrder {
            msgAnimalSucess = true
        } else {
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    
    @IBAction func otherTissueBtnAction(_ sender: Any) {
        btnTag = 40
        view.endEditing(true)
        let pvIdBeef = UserDefaults.standard.integer(forKey: "BeefPvid")
        tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvIdBeef)
        self.tableViewpop()
        var yFrame = (tissueHideLbl.frame.minY + 130) - self.scrolView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
            case 1334:
                yFrame = (tissueHideLbl.frame.minY + 105) - self.scrolView.contentOffset.y
                
            case 1920, 2208:
                yFrame = (tissueHideLbl.frame.minY + 113) - self.scrolView.contentOffset.y
                
            case 2436:
                break
                
            case 2688,2796:
                break
                
            case 1792:
                yFrame = (tissueHideLbl.frame.minY + 143) - self.scrolView.contentOffset.y
                
            default:
                break
            }
        }
        
        droperTableView.frame = CGRect(x: 30,y: yFrame,width: 150,height: 200)
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder {
            msgAnimalSucess = true
        } else {
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
        
    }
    
    
    
    @IBAction func addAnimalAction(_ sender: UIButton) {
        self.view.endEditing(true)
        
        addContiuneBtn = 1
        UserDefaults.standard.setValue("addAnotherAnimal", forKey: "isToUpdateAndAddAnimal")
        addAnimalBtn(completionHandler: { (success) -> Void in
            
            self.scanBarcodeTextfield.becomeFirstResponder()
        })
        
    }
    
    
    @IBAction func addAnimalkeyboard(_ sender: UIButton) {
        self.view.endEditing(true)
        
        addContiuneBtn = 1
        UserDefaults.standard.setValue("addAnotherAnimal", forKey: "isToUpdateAndAddAnimal")
        addAnimalBtn(completionHandler: { (success) -> Void in
            if self.isGenotypeOnlyAdded
            {
                self.genotypeScanBarcodeTextField.becomeFirstResponder()
            }
            else
            {
                self.scanBarcodeTextfield.becomeFirstResponder()
            }
        })
    }
    @IBAction func backBtnClk(_ sender: UIButton) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func viewAnimalClick(_ sender: UIButton) {
        barcodeScreen = false
        selectedDate = Date()
        let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: "BeefViewAnimalVC") as? BeefViewAnimalVC
        vc!.screenBackSave = false
        vc!.productBackSave = false
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func offlineBtnAction(_ sender: UIButton) {
        
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(OrderingAnimalVC.buttonbgPressed), for: .touchUpInside)
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
    @IBAction func dateAction(_ sender: UIButton) {
        barcodeEnable = true
        self.view.endEditing(true)
        
        
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            
            dateTextField.isHidden = false
        }else {
            dateTextField.isHidden = true
            
            calenderView.isHidden = false
            calenderbkg.isHidden = false
            calenderView.layer.cornerRadius = 30
            calenderView.layer.masksToBounds = true
            doDatePicker()
        }
        
        
        _ = statusOrderTrue()
        if statusOrder {
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    @IBAction func genotypeDateAction(_ sender: UIButton) {
        barcodeEnable = true
        self.view.endEditing(true)
        
        
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            
            genotypeDateTextField.isHidden = false
        }else {
            genotypeDateTextField.isHidden = true
            
            
            calenderView.isHidden = false
            calenderbkg.isHidden = false
            calenderView.layer.cornerRadius = 30
            calenderView.layer.masksToBounds = true
            genotypeDoDatePicker()
        }
        
        _ = statusOrderTrue()
        if statusOrder {
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    @IBAction func incrementalBarcodeButtonAction(_ sender: UIButton) {
        
        guard !isautoPopulated
        else {
            return
        }
        
        guard scanBarcodeTextfield.text?.isEmpty == false else {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please enter barcode before selecting 'Incremental barcode'.", comment: "") )
            return
        }
        
        guard isBarcodeEndingWithNumberAndGetIncremented(scanBarcodeTextfield.text ?? "").isBarCodeEndsWithNumber else {
            if !checkBarcode{
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Barcode must be ending with the number to use 'Incremental barcode'.", comment: ""))
                
            }
            else {
                sender.isSelected = false
                incrementalBarcodeCheckBox.image = UIImage(named: "Incremental_Check")
                UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                self.isBarcodeAutoIncrementedEnabled = false
                checkBarcode = false
                
            }
            return
        }
        
        if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") {
            sender.isSelected = false
            incrementalBarcodeCheckBox.image = UIImage(named: "Incremental_Check")
            UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
            self.isBarcodeAutoIncrementedEnabled = false
            checkBarcode = false
        } else {
            sender.isSelected = true
            incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.checkImg)
            UserDefaults.standard.set(true, forKey: "isBarCodeIncremental")
            self.isBarcodeAutoIncrementedEnabled = true
            checkBarcode = false
        }
        
    }
    
    @IBAction func incrementalBarcodeButtonActionGenotype(_ sender: UIButton) {
        
        guard !isautoPopulated else {
            return
        }
        
        guard genotypeScanBarcodeTextField.text?.isEmpty == false else {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please enter barcode before selecting 'Incremental barcode'.", comment: "") )
            return
        }
        
        guard isBarcodeEndingWithNumberAndGetIncremented(genotypeScanBarcodeTextField.text ?? "").isBarCodeEndsWithNumber else {
            if !checkBarcode{
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Barcode must be ending with the number to use 'Incremental barcode'.", comment: ""))
                
            }
            else {
                sender.isSelected = false
                incrementalBarcodeCheckBoxGenoType.image = UIImage(named: "Incremental_Check")
                UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                self.isBarcodeAutoIncrementedEnabled = false
                checkBarcode = false
                
            }
            return
        }
        
        if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") {
            sender.isSelected = false
            incrementalBarcodeCheckBoxGenoType.image = UIImage(named: "Incremental_Check")
            UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
            self.isBarcodeAutoIncrementedEnabled = false
            checkBarcode = false
        } else {
            sender.isSelected = true
            incrementalBarcodeCheckBoxGenoType.image = UIImage(named: ImageNames.checkImg)
            UserDefaults.standard.set(true, forKey: "isBarCodeIncremental")
            self.isBarcodeAutoIncrementedEnabled = true
            checkBarcode = false
        }
        
    }
    @IBAction func continueProductAction(_ sender: UIButton) {
        
        addContiuneBtn = 2
        if isGenotypeOnlyAdded
        {
            genotypecontinueproduct()
        }
        else
        {
            continueproduct()
        }
    }
    
    @IBAction func barcodeAction(_ sender: UIButton) {
        barcodeScreen = true
    }
    
    @IBAction func genotypeBarcodeAction(_ sender: UIButton) {
        barcodeScreen = true
        
        let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CameraViewController") as? CameraViewController
        vc?.delegate = self
        self.present(vc!, animated: true, completion: nil)
        
    }
    
    @IBAction func clearFromAction(_ sender: Any) {
        self.view.endEditing(true)
        let pvIdBeef = UserDefaults.standard.integer(forKey: "BeefPvid")
        
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message: NSLocalizedString("Are you sure you want to reset form?", comment: ""), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("No",comment: ""), style: .default, handler: { action in
            
        })
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title:NSLocalizedString("Yes",comment: "") , style: .default, handler: { action in
            self.genotypeByDefaultScreen()
            
            
            if let breed1 = self.breedArr[0] as? GetBreedsTbl
            {
                
                self.selectBreedBtn.setTitle(breed1.threeCharCode, for: .normal)
            }
            
            let tissueName = UserDefaults.standard.string(forKey: "genotypeTissueBttnClear")
            if UserDefaults.standard.string(forKey: "genotypeTissueBttnClear") == nil || UserDefaults.standard.string(forKey: "genotypeTissueBttnClear") == ""{
                self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvIdBeef)
                for items in self.tissueArr
                {
                    let tissue = items  as? GetSampleTbl
                    let checkdefault  = tissue?.isDefault
                    
                    if checkdefault == true
                    {
                        self.genotypeTissueBttn.setTitle(tissue?.sampleName?.localized, for: .normal)
                        self.tissuId =  Int(tissue?.sampleId ?? 4)
                    }
                    
                    
                }
                
                
            } else {
                
                
                let codeId = fetchBreedDataTissueCode(entityName: Entities.getSampleTblEntity,provId: pvIdBeef,tissueName:tissueName!)
                let naabFetch1 = codeId.value(forKey: "sampleId") as? NSArray
                if naabFetch1!.count != 0 {
                    let breedIdGet = naabFetch1![0] as? Int
                    self.tissuId = breedIdGet!
                }
                self.genotypeTissueBttn.setTitle(tissueName?.localized, for: .normal)
                UserDefaults.standard.set(self.genotypeTissueBttn.titleLabel!.text, forKey: "genotypeTissueBttn")
            }
            
            
            
            let inrementCheck = UserDefaults.standard.bool(forKey: "isBarCodeIncrementalClear")
            
            if inrementCheck  {
                self.isBarcodeAutoIncrementedEnabled = true
                
                self.checkBarcode = false
                
                self.incrementalBarcodeCheckBoxGenoType.image = UIImage(named: ImageNames.checkImg)
                UserDefaults.standard.set(true, forKey: "isBarCodeIncremental")
                
                if UserDefaults.standard.bool(forKey: "isBarCodeIncremental"),
                   let lastSavedBarCode = UserDefaults.standard.value(forKey: "barcodeIncremental") as? String {
                    self.genotypeScanBarcodeTextField.text = isBarcodeEndingWithNumberAndGetIncremented(lastSavedBarCode).incrementedBarCode
                    if self.genotypeScanBarcodeTextField.text?.isEmpty == false {
                        self.genotypeByDefaultBackroundWhite()
                    }
                }
                
            } else {
                
                self.incrementalBarcodeCheckBoxGenoType.image = UIImage(named: "Incremental_Check")
                self.isBarcodeAutoIncrementedEnabled = false
            }
            
            self.genotypeScanBarcodeTextField.becomeFirstResponder()
            
            
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    @IBAction func okBtnClickImportView(_ sender: Any) {
        if listId == 0 {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("Please select list to import.", comment: "") )
            return
        }
        
        
        
        if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeOnly.rawValue || UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeStarBlack.rawValue{
            
            let animalCountCheck = fetchDataEnteryAnimalTblBeefDataBrazil(entityName: "DataEntryBeefAnimaladdTbl",customerId:self.custmerId,listId:Int64(self.listId ),providerId:UserDefaults.standard.integer(forKey: "BeefPvid"))
            
            if animalCountCheck.count == 0 {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("No animals added in the list.", comment: ""))
                importListMainView.isHidden = true
                importBackroundView.isHidden = true
                return
            }
            
            let aData =  fetchAnimaldataDairyOrderIdUserId(entityName: Entities.beefAnimalAddTblEntity, orderId: autoD, userId: userId,providerId:UserDefaults.standard.integer(forKey: "BeefPvid"))
            if aData.count > 0 {
                for k in 0 ..< aData.count{
                    let data1 = aData[k] as! BeefAnimaladdTbl
                    let earTag = data1.animalTag
                    
                    let dataEntryVALE = fetchAllDataGlobalEarTAG(entityName: "DataEntryBeefAnimaladdTbl",userId:userId,orderId:orderId,listid:Int64(listId),custmerId:Int64(custmerId),providerId:UserDefaults.standard.integer(forKey: "BeefPvid"),earTag: earTag ?? "", orderStatus: "false") as! [DataEntryBeefAnimaladdTbl]
                    
                    
                    if dataEntryVALE.count > 0 {
                        
                        self.conflictArr.append(contentsOf: dataEntryVALE)
                        
                    }
                }
                if conflictArr.count > 0 {
                    let count1 = conflictArr.count
                    let alertPrint = String(count1) + " " + NSLocalizedString("animal(s) from list already added in the order. Please select action to be performed.", comment: "")
                    
                    let alert = UIAlertController(title: listNameString, message: alertPrint, preferredStyle: .alert)
                    let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: { action in
                        
                        self.importBackroundView.isHidden = true
                        self.importListMainView.isHidden = true
                        
                    })
                    alert.addAction(cancel)
                    
                    let ok = UIAlertAction(title: NSLocalizedString("Ignore", comment: ""), style: .default, handler: { [self] action in
                        
                        let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: "DataEntryBeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId), providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                        if fetchData11.count != 0 {
                            
                            for i in 0...fetchData11.count - 1 {
                                let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                                
                                
                                
                                let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                                if fetchCountGirlando.count == 0 {
                                    
                                    saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId), productId: Int(dataGet.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: dataGet.listId, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                    
                                    createDataList()
                                    
                                    self.genotypeTissueBttn.setTitle(dataGet.tissuName ?? "", for: .normal)
                                    UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: "genotypeTissueBttn")
                                    
                                    let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                                    let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                                    
                                    for k in 0 ..< animalData.count{
                                        
                                        let animalId = animalData[k] as! BeefAnimaladdTbl
                                        
                                        for i in 0 ..< product.count {
                                            
                                            let data = product[i] as! GetProductTblBeef
                                            beefSaveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.offsireId ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"), status: "true", farmId: animalId.farmId ?? "" , orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "", marketName: data.marketName ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), orderTerrms: data.orderAcceptTerms ?? "")
                                            
                                            let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                            if addonArr.count > 0 {
                                                for j in 0 ..< addonArr.count {
                                                    
                                                    let addonDat = addonArr[j] as! GetAdonTbl
                                                    
                                                    saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                    
                                                }
                                            }
                                            else {
                                            }
                                        }
                                    }
                                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                                    notificationLblCount.text = String(animalCount.count)
                                    if animalCount.count == 0{
                                        self.notificationLblCount.isHidden = true
                                        self.countLbl.isHidden = true
                                    } else {
                                        self.notificationLblCount.isHidden = false
                                        self.countLbl.isHidden = false
                                    }
                                    self.genotypeCrossBtnOutlet.isHidden = false
                                    UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                                    UserDefaults.standard.set(Int64(dataGet.listId), forKey: "dataEnteryListId")
                                    genotypeImportFromBtnBtnOutlet.isEnabled = true
                                    self.importBackroundView.isHidden = true
                                    self.importListMainView.isHidden = true
                                    self.view.makeToast(NSLocalizedString("Animals imported into the order.", comment: ""), duration: 2, position: .top)
                                    
                                    
                                    if fetchMergeDataListId(entityName: "MergeDataEntryList",listId: Int64(dataGet.listId),customerId: Int64(self.custmerId)).count == 0 {
                                        
                                        let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId))
                                        let listObject = fetchList.object(at: 0) as? DataEntryList
                                        let listDescr = listObject?.listDesc
                                        
                                        saveMergeDataEntryList(entity: "MergeDataEntryList", customerId: Int64(self.custmerId), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                        
                                    }
                                    
                                    let fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId,providerId:pvid)
                                    if fetchObj.count != 0 {
                                        
                                        let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                        let obj = objectFetch?.listName
                                        let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid),customerId:Int64(custmerId)).count - 1
                                        
                                        if fetchAllMergeDta == 0 {
                                            let fetchNameDisplay = String(obj ?? "")
                                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                            genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                            genotypeMergeListBtnOulet.isHidden = false
                                        } else {
                                            let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                            genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                            genotypeMergeListBtnOulet.isHidden = false
                                        }
                                    }
                                    
                                }
                            }
                        }
                    })
                    alert.addAction(ok)
                    importListMainView.isHidden = true
                    importBackroundView.isHidden = true
                    
                    DispatchQueue.main.async(execute: {
                        self.present(alert, animated: true)
                    })
                    
                } else {
                    
                    let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: "DataEntryBeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId), providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                    if fetchData11.count != 0 {
                        
                        for i in 0...fetchData11.count - 1 {
                            let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                            
                            
                            
                            let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                            if fetchCountGirlando.count == 0 {
                                
                                saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId), productId: Int(dataGet.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: dataGet.listId, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                createDataList()
                                
                                self.genotypeTissueBttn.setTitle(dataGet.tissuName ?? "", for: .normal)
                                UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: "genotypeTissueBttn")
                                
                                
                                let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                                let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                                
                                for k in 0 ..< animalData.count{
                                    
                                    let animalId = animalData[k] as! BeefAnimaladdTbl
                                    
                                    for i in 0 ..< product.count {
                                        
                                        let data = product[i] as! GetProductTblBeef
                                        beefSaveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.offsireId ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"), status: "true", farmId: animalId.farmId ?? "" , orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "", marketName: data.marketName ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), orderTerrms: data.orderAcceptTerms ?? "")
                                        
                                        
                                        let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                        if addonArr.count > 0 {
                                            for j in 0 ..< addonArr.count {
                                                
                                                let addonDat = addonArr[j] as! GetAdonTbl
                                                
                                                saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                               
                                            }
                                        }
                                    }
                                }
                                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                                notificationLblCount.text = String(animalCount.count)
                                if animalCount.count == 0{
                                    self.notificationLblCount.isHidden = true
                                    self.countLbl.isHidden = true
                                } else {
                                    self.notificationLblCount.isHidden = false
                                    self.countLbl.isHidden = false
                                }
                                self.genotypeCrossBtnOutlet.isHidden = false
                                
                                UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                                UserDefaults.standard.set(Int64(dataGet.listId), forKey: "dataEnteryListId")
                                genotypeImportFromBtnBtnOutlet.isEnabled = true
                                self.importBackroundView.isHidden = true
                                self.view.makeToast(NSLocalizedString("Animals imported into the order.", comment: ""), duration: 2, position: .top)
                                
                                self.importListMainView.isHidden = true
                                
                                if fetchMergeDataListId(entityName: "MergeDataEntryList",listId: Int64(dataGet.listId),customerId: Int64(self.custmerId)).count == 0 {
                                    
                                    let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId))
                                    let listObject = fetchList.object(at: 0) as? DataEntryList
                                    let listDescr = listObject?.listDesc
                                    
                                    saveMergeDataEntryList(entity: "MergeDataEntryList", customerId: Int64(self.custmerId), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                    
                                }
                                
                                let fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId,providerId:pvid)
                                if fetchObj.count != 0 {
                                    
                                    let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                    let obj = objectFetch?.listName
                                    let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid),customerId:Int64(custmerId)).count - 1
                                    
                                    if fetchAllMergeDta == 0 {
                                        let fetchNameDisplay = String(obj ?? "")
                                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                        genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                        genotypeMergeListBtnOulet.isHidden = false
                                    } else {
                                        let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                        genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                        genotypeMergeListBtnOulet.isHidden = false
                                    }
                                }
                                
                            }
                            
                        }
                        
                    }
                }
            } else {
                
                let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: "DataEntryBeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId), providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                if fetchData11.count != 0 {
                    
                    for i in 0...fetchData11.count - 1 {
                        let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                        
                        
                        
                        let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                        if fetchCountGirlando.count == 0 {
                            
                            saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId), productId: Int(dataGet.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: dataGet.listId, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                            
                            createDataList()
                            
                            self.genotypeTissueBttn.setTitle(dataGet.tissuName ?? "", for: .normal)
                            UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: "genotypeTissueBttn")
                            
                            
                            
                            let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                            let product = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                            
                            for k in 0 ..< animalData.count{
                                
                                let animalId = animalData[k] as! BeefAnimaladdTbl
                                
                                for i in 0 ..< product.count {
                                    
                                    let data = product[i] as! GetProductTblBeef
                                    beefSaveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.offsireId ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"), status: "true", farmId: animalId.farmId ?? "" , orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "", marketName: data.marketName ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), orderTerrms: data.orderAcceptTerms ?? "")
                                    
                                    
                                    let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                    if addonArr.count > 0 {
                                        for j in 0 ..< addonArr.count {
                                            
                                            let addonDat = addonArr[j] as! GetAdonTbl
                                            
                                            saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                            
                                        }
                                    }
                                }
                            }
                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                            notificationLblCount.text = String(animalCount.count)
                            if animalCount.count == 0{
                                self.notificationLblCount.isHidden = true
                                self.countLbl.isHidden = true
                            } else {
                                self.notificationLblCount.isHidden = false
                                self.countLbl.isHidden = false
                            }
                            self.genotypeCrossBtnOutlet.isHidden = false
                            
                            UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                            UserDefaults.standard.set(Int64(dataGet.listId), forKey: "dataEnteryListId")
                            genotypeImportFromBtnBtnOutlet.isEnabled = true
                            self.importBackroundView.isHidden = true
                            self.importListMainView.isHidden = true
                            self.view.makeToast(NSLocalizedString("Animals imported into the order.", comment: ""), duration: 2, position: .top)
                            
                            if fetchMergeDataListId(entityName: "MergeDataEntryList",listId: Int64(dataGet.listId),customerId: Int64(self.custmerId)).count == 0 {
                                
                                let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId))
                                let listObject = fetchList.object(at: 0) as? DataEntryList
                                let listDescr = listObject?.listDesc
                                
                                saveMergeDataEntryList(entity: "MergeDataEntryList", customerId: Int64(self.custmerId), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                
                            }
                            
                            let fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId,providerId:pvid)
                            if fetchObj.count != 0 {
                                
                                let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                let obj = objectFetch?.listName
                                let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid),customerId:Int64(custmerId)).count - 1
                                
                                if fetchAllMergeDta == 0 {
                                    let fetchNameDisplay = String(obj ?? "")
                                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                    genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                    genotypeMergeListBtnOulet.isHidden = false
                                } else {
                                    let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                    genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                    genotypeMergeListBtnOulet.isHidden = false
                                }
                            }
                            
                        }
                    }
                }
            }
        } else {
            let animalCountCheck = fetchDataEnteryAnimalTblBeefDataBrazil(entityName: "DataEntryBeefAnimaladdTbl",customerId:self.custmerId,listId:Int64(self.listId),providerId:UserDefaults.standard.integer(forKey: "BeefPvid"))
            
            if animalCountCheck.count == 0 {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("No animals added in the list.", comment: ""))
                importListMainView.isHidden = true
                importBackroundView.isHidden = true
                return
            }
            
            let aData =  fetchAnimaldataDairyOrderIdUserId(entityName: Entities.beefAnimalAddTblEntity, orderId: autoD, userId: userId,providerId:UserDefaults.standard.integer(forKey: "BeefPvid"))
            if aData.count > 0 {
                for k in 0 ..< aData.count{
                    let data1 = aData[k] as! BeefAnimaladdTbl
                    let earTag = data1.animalTag
                    
                    let dataEntryVALE = fetchAllDataGlobalEarTAG(entityName: "DataEntryBeefAnimaladdTbl",userId:userId,orderId:orderId,listid:Int64(listId),custmerId:Int64(custmerId),providerId:UserDefaults.standard.integer(forKey: "BeefPvid"),earTag: earTag ?? "", orderStatus: "false") as! [DataEntryBeefAnimaladdTbl]
                    
                    
                    if dataEntryVALE.count > 0 {
                        
                        self.conflictArr.append(contentsOf: dataEntryVALE)
                        
                    }
                }
                if conflictArr.count > 0 {
                    let count1 = conflictArr.count
                    let alertPrint = String(count1) + " " + NSLocalizedString("animal(s) from list already added in the order. Please select action to be performed.", comment: "")
                    
                    let alert = UIAlertController(title: listNameString, message: alertPrint, preferredStyle: .alert)
                    let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: { action in
                        
                        self.importBackroundView.isHidden = true
                        self.importListMainView.isHidden = true
                        
                    })
                    alert.addAction(cancel)
                    
                    let ok = UIAlertAction(title: NSLocalizedString("Ignore", comment: ""), style: .default, handler: { [self] action in
                        
                        
                        let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: "DataEntryBeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId), providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                        if fetchData11.count != 0 {
                            
                            for i in 0...fetchData11.count - 1 {
                                let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                                
                                
                                
                                let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                                if fetchCountGirlando.count == 0 {
                                    
                                    saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId), productId: Int(dataGet.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: dataGet.listId, serverAnimalId: "",tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                    
                                    createDataList()
                                    
                                    self.tissueBttn.setTitle(dataGet.tissuName ?? "", for: .normal)
                                    UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: "tissueBttn")
                                    
                                    
                                    
                                    
                                    let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                                    let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                                    
                                    
                                    for k in 0 ..< animalData.count{
                                        
                                        let animalId = animalData[k] as! BeefAnimaladdTbl
                                        
                                        for i in 0 ..< product.count {
                                            
                                            let data = product[i] as! GetProductTblBeef
                                            
                                            beefSaveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.offsireId ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId:  Int(dataGet.providerId ), status: "true", farmId: animalId.farmId ?? "" , orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "", marketName: data.marketName ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), orderTerrms: data.orderAcceptTerms ?? "")
                                            
                                            let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                            if addonArr.count > 0 {
                                                
                                                for j in 0 ..< addonArr.count {
                                                    
                                                    let addonDat = addonArr[j] as! GetAdonTbl
                                                    
                                                    saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                    
                                                }
                                            }
                                            else {
                                            }
                                        }
                                    }
                                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                                    notificationLblCount.text = String(animalCount.count)
                                    if animalCount.count == 0{
                                        self.notificationLblCount.isHidden = true
                                        self.countLbl.isHidden = true
                                    } else {
                                        self.notificationLblCount.isHidden = false
                                        self.countLbl.isHidden = false
                                    }
                                    self.nongenotypeCrossBtnOutlet.isHidden = false
                                    UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                                    UserDefaults.standard.set(Int64(dataGet.listId), forKey: "dataEnteryListId")
                                    nongenotypeImportFromBtnBtnOutlet.isEnabled = true
                                    self.importBackroundView.isHidden = true
                                    self.importListMainView.isHidden = true
                                    self.view.makeToast(NSLocalizedString("Animals imported into the order.", comment: ""), duration: 2, position: .top)
                                    if fetchMergeDataListId(entityName: "MergeDataEntryList",listId: Int64(dataGet.listId),customerId: Int64(self.custmerId)).count == 0 {
                                        
                                        let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId))
                                        let listObject = fetchList.object(at: 0) as? DataEntryList
                                        let listDescr = listObject?.listDesc
                                        
                                        saveMergeDataEntryList(entity: "MergeDataEntryList", customerId: Int64(self.custmerId), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                        
                                    }
                                    
                                    let fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId,providerId:pvid )
                                    if fetchObj.count != 0 {
                                        
                                        let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                        let obj = objectFetch?.listName
                                        let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid),customerId:Int64(custmerId)).count - 1
                                        
                                        if fetchAllMergeDta == 0 {
                                            let fetchNameDisplay = String(obj ?? "")
                                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                            nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                            nongenotypeMergeListBtnOulet.isHidden = false
                                        } else {
                                            let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                            nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                            nongenotypeMergeListBtnOulet.isHidden = false
                                        }
                                    }
                                }
                            }
                        }
                    })
                    alert.addAction(ok)
                    importListMainView.isHidden = true
                    importBackroundView.isHidden = true
                    
                    DispatchQueue.main.async(execute: {
                        self.present(alert, animated: true)
                    })
                    
                } else {
                    
                    
                    let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: "DataEntryBeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId), providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                    if fetchData11.count != 0 {
                        
                        for i in 0...fetchData11.count - 1 {
                            let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                            
                            
                            
                            let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                            if fetchCountGirlando.count == 0 {
                                
                                saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId), productId: Int(dataGet.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: dataGet.listId, serverAnimalId: "",tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                
                                createDataList()
                                
                                self.tissueBttn.setTitle(dataGet.tissuName ?? "", for: .normal)
                                UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: "tissueBttn")
                                
                                
                                
                                let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                                let product = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                                
                                for k in 0 ..< animalData.count{
                                    
                                    let animalId = animalData[k] as! BeefAnimaladdTbl
                                    
                                    for i in 0 ..< product.count {
                                        
                                        let data = product[i] as! GetProductTblBeef
                                        
                                        beefSaveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.offsireId ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId:  Int(dataGet.providerId ), status: "true", farmId: animalId.farmId ?? "" , orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "", marketName: data.marketName ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), orderTerrms: data.orderAcceptTerms ?? "")
                                        
                                        let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                        if addonArr.count > 0 {
                                            
                                            for j in 0 ..< addonArr.count {
                                                
                                                let addonDat = addonArr[j] as! GetAdonTbl
                                                
                                                saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                              
                                            }
                                        }
                                    }
                                }
                                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                                notificationLblCount.text = String(animalCount.count)
                                if animalCount.count == 0{
                                    self.notificationLblCount.isHidden = true
                                    self.countLbl.isHidden = true
                                } else {
                                    self.notificationLblCount.isHidden = false
                                    self.countLbl.isHidden = false
                                }
                                self.nongenotypeCrossBtnOutlet.isHidden = false
                                
                                UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                                UserDefaults.standard.set(Int64(dataGet.listId), forKey: "dataEnteryListId")
                                nongenotypeImportFromBtnBtnOutlet.isEnabled = true
                                self.importBackroundView.isHidden = true
                                self.importListMainView.isHidden = true
                                self.view.makeToast(NSLocalizedString("Animals imported into the order.", comment: ""), duration: 2, position: .top)
                                if fetchMergeDataListId(entityName: "MergeDataEntryList",listId: Int64(dataGet.listId),customerId: Int64(self.custmerId)).count == 0 {
                                    
                                    let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId))
                                    let listObject = fetchList.object(at: 0) as? DataEntryList
                                    let listDescr = listObject?.listDesc
                                    
                                    saveMergeDataEntryList(entity: "MergeDataEntryList", customerId: Int64(self.custmerId), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                    
                                }
                                
                                let fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId,providerId:pvid )
                                if fetchObj.count != 0 {
                                    
                                    let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                    let obj = objectFetch?.listName
                                    let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid),customerId:Int64(custmerId)).count - 1
                                    
                                    if fetchAllMergeDta == 0 {
                                        let fetchNameDisplay = String(obj ?? "")
                                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                        nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                        nongenotypeMergeListBtnOulet.isHidden = false
                                    } else {
                                        let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                        nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                        nongenotypeMergeListBtnOulet.isHidden = false
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
            else {
                
                let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: "DataEntryBeefAnimaladdTbl", userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId), providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                if fetchData11.count != 0 {
                    
                    for i in 0...fetchData11.count - 1 {
                        let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                        
                        
                        
                        let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                        if fetchCountGirlando.count == 0 {
                            
                            saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId), productId: Int(dataGet.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: dataGet.listId, serverAnimalId: "",tertiaryGeno: dataGet.tertiaryGeno ?? "")
                            
                            createDataList()
                            
                            
                            self.tissueBttn.setTitle(dataGet.tissuName ?? "", for: .normal)
                            UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: "tissueBttn")
                            
                            
                            let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                            let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                            
                            
                            for k in 0 ..< animalData.count{
                                
                                let animalId = animalData[k] as! BeefAnimaladdTbl
                                
                                for i in 0 ..< product.count {
                                    
                                    let data = product[i] as! GetProductTblBeef
                                    
                                    beefSaveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.offsireId ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId:  Int(dataGet.providerId ), status: "true", farmId: animalId.farmId ?? "" , orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "", marketName: data.marketName ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), orderTerrms: data.orderAcceptTerms ?? "")
                                    
                                    let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                    if addonArr.count > 0 {
                                        
                                        for j in 0 ..< addonArr.count {
                                            
                                            let addonDat = addonArr[j] as! GetAdonTbl
                                            
                                            saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                         
                                        }
                                    }
                                }
                            }
                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                            notificationLblCount.text = String(animalCount.count)
                            if animalCount.count == 0{
                                self.notificationLblCount.isHidden = true
                                self.countLbl.isHidden = true
                            } else {
                                self.notificationLblCount.isHidden = false
                                self.countLbl.isHidden = false
                            }
                            self.nongenotypeCrossBtnOutlet.isHidden = false
                            UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                            UserDefaults.standard.set(Int64(dataGet.listId), forKey: "dataEnteryListId")
                            nongenotypeImportFromBtnBtnOutlet.isEnabled = true
                            self.importBackroundView.isHidden = true
                            self.importListMainView.isHidden = true
                            self.view.makeToast(NSLocalizedString("Animals imported into the order.", comment: ""), duration: 2, position: .top)
                            
                            if fetchMergeDataListId(entityName: "MergeDataEntryList",listId: Int64(dataGet.listId),customerId: Int64(self.custmerId)).count == 0 {
                                
                                let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId))
                                let listObject = fetchList.object(at: 0) as? DataEntryList
                                let listDescr = listObject?.listDesc
                                
                                saveMergeDataEntryList(entity: "MergeDataEntryList", customerId: Int64(self.custmerId), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                
                            }
                            
                            let fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId,providerId:pvid )
                            if fetchObj.count != 0 {
                                
                                let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                let obj = objectFetch?.listName
                                let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid),customerId:Int64(custmerId)).count - 1
                                
                                if fetchAllMergeDta == 0 {
                                    let fetchNameDisplay = String(obj ?? "")
                                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                    nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                    nongenotypeMergeListBtnOulet.isHidden = false
                                } else {
                                    let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                    nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                    nongenotypeMergeListBtnOulet.isHidden = false
                                }
                            }
                        }
                    }
                }
            }
        }
        self.showAlertforwithoutBarcodeAnimal()
    }
    
    @IBAction func nongenotypeMergeListBtnClick(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "AnimalMergePopUpVC") as! AnimalMergePopUpVC
        vc.delegate = self
        vc.providerId = pvid
        self.navigationController?.present(vc, animated: false, completion: nil)
        
    }
    
    
    @IBAction func genotypeImportFromBtnAction(_ sender: Any) {
        view.endEditing(true)
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int
        listId = 0
        
        if isGenostarblackOnlyAdded && isGenotypeOnlyAdded
        {
            tempImportListArray = fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:UserDefaults.standard.integer(forKey: "BeefPvid"),productType:keyValue.genoTypeStarBlack.rawValue) as! [DataEntryList]
            if tempImportListArray.count>0 {
                importListArray = orderingDataListViewModel.hideInternalDataList(tempImportListArray: tempImportListArray)
            }
            
        }
        else{
            tempImportListArray = fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:UserDefaults.standard.integer(forKey: "BeefPvid"),productType:keyValue.genoTypeOnly.rawValue) as! [DataEntryList]
            if tempImportListArray.count>0 {
                importListArray = orderingDataListViewModel.hideInternalDataList(tempImportListArray: tempImportListArray)
            }
        }
        
        
        conflictArr.removeAll()
        if importListArray.count == 0 {
            
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("No lists available for this customer.", comment: ""))
            
            importListMainView.isHidden = true
            importBackroundView.isHidden = true
            return
        }
        let data1 = fetchAllDataWithOrderID(entityName: Entities.beefAnimalAddTblEntity,orderId:orderId,userId:userId)
        if data1.count > 0{
            
            let animalStatusChck = fetchAllDataWithOrderIDStatucCheck(entityName: Entities.beefAnimalAddTblEntity,orderId:self.orderId,userId:self.userId,status:"true")
            
            if animalStatusChck.count != 0 {
                
                let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message:NSLocalizedString("Product selection will be cleared if you want to import list. Do you want to continue?", comment: "") , preferredStyle: .alert)
                
                let cancel = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
                    
                    self.importListMainView.isHidden = true
                    self.importBackroundView.isHidden = true
                    
                })
                alert.addAction(cancel)
                
                let ok = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
                    
                    if self.importListArray.count != 0 {
                        self.importListMainView.isHidden = false
                        self.importBackroundView.isHidden = false
                        self.importTblvIEW.reloadData()
                        
                    }
                })
                alert.addAction(ok)
                
                DispatchQueue.main.async(execute: {
                    self.present(alert, animated: true)
                })
                
            } else {
                
                
                
                if importListArray.count != 0 {
                    importListMainView.isHidden = false
                    importBackroundView.isHidden = false
                    importTblvIEW.reloadData()
                    genotypeCrossBtnOutlet.isHidden = false
                    
                }
            }
        } else {
            
            if importListArray.count != 0 {
                importListMainView.isHidden = false
                importBackroundView.isHidden = false
                genotypeCrossBtnOutlet.isHidden = false
                importTblvIEW.reloadData()
                
            }
            
        }
        
    }
    
    @IBAction func genotypeCrossBtnAction(_ sender: Any) {
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Removing list will remove its animals from the order as well. Do you want to continue?", comment: ""), preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
            
        })
        
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
            
            
            
            let listArray = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(self.pvid),customerId:Int64(self.custmerId))
            
            for i in 0 ..< listArray.count{
                
                let listObj = listArray[i] as! MergeDataEntryList
                
                
                let animalData =  fetchDataEnteryAnimalTbl(entityName: Entities.beefAnimalAddTblEntity, customerId: Int(listObj.customerId), listId: Int64(listObj.listId))
                
                if animalData.count > 0 {
                    
                    for i in 0 ..< animalData.count {
                        let ad = animalData[i] as! BeefAnimaladdTbl
                        deleteDataWithProductBeefDelete(Int(ad.animalId))
                        deleteDataWithSubProductAnimalId(Int(ad.animalId))
                        
                    }
                    deleteDataWithListIdDatEntry(entityString: Entities.beefAnimalAddTblEntity, listId: Int(listObj.listId), customerId:  Int(listObj.customerId),userId:self.userId)
                }
                
            }
            
            deleteDataWithPvidCustomerId(entityString: "MergeDataEntryList" ,providerId: Int64(UserDefaults.standard.integer(forKey: "BeefPvid")),customerId: Int64(self.custmerId))
            
            
            UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
            self.genotypeImportFromBtnBtnOutlet.isEnabled = true
            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
            self.notificationLblCount.text = String(animalCount.count)
            if animalCount.count == 0 {
                self.notificationLblCount.isHidden = true
                self.countLbl.isHidden = true
            } else {
                self.notificationLblCount.isHidden = false
                self.countLbl.isHidden = false
            }
            self.genotypeCrossBtnOutlet.isHidden = true
            
            if fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(self.pvid),customerId:Int64(self.custmerId)).count == 0 {
                
                self.genotypeMergeListBtnOulet.isHidden = true
            } else {
                self.genotypeMergeListBtnOulet.isHidden = false
            }
        })
        alert.addAction(ok)
        
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
        
        
    }
    
    @IBAction func nongenotypeImportFromBtnAction(_ sender: Any) {
        view.endEditing(true)
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int
        listId = 0
        if isGenostarblackOnlyAdded
        {
            tempImportListArray = fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:UserDefaults.standard.integer(forKey: "BeefPvid"),productType:keyValue.genStarBlack.rawValue) as! [DataEntryList]
            if tempImportListArray.count>0 {
                importListArray = orderingDataListViewModel.hideInternalDataList(tempImportListArray: tempImportListArray)
            }
        }
        else
        {
            tempImportListArray = fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:UserDefaults.standard.integer(forKey: "BeefPvid"),productType:keyValue.nonGenoType.rawValue) as! [DataEntryList]
            if tempImportListArray.count>0 {
                importListArray = orderingDataListViewModel.hideInternalDataList(tempImportListArray: tempImportListArray)
            }
        }
        
        
        conflictArr.removeAll()
        if importListArray.count == 0 {
            
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString("No lists available for this customer.", comment: ""))
            importListMainView.isHidden = true
            importBackroundView.isHidden = true
            return
        }
        let data1 = fetchAllDataWithOrderID(entityName: Entities.beefAnimalAddTblEntity,orderId:orderId,userId:userId)
        if data1.count > 0{
            
            let animalStatusChck = fetchAllDataWithOrderIDStatucCheck(entityName: Entities.beefAnimalAddTblEntity,orderId:self.orderId,userId:self.userId,status:"true")
            
            if animalStatusChck.count != 0 {
                
                let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Product selection will be cleared if you want to import list. Do you want to continue?", comment: ""), preferredStyle: .alert)
                let cancel = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
                    
                    self.importListMainView.isHidden = true
                    self.importBackroundView.isHidden = true
                    
                })
                alert.addAction(cancel)
                
                let ok = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
                    
                    if self.importListArray.count != 0 {
                        self.importListMainView.isHidden = false
                        self.importBackroundView.isHidden = false
                        self.importTblvIEW.reloadData()
                        self.nongenotypeCrossBtnOutlet.isHidden = false
                        
                    }
                })
                alert.addAction(ok)
                
                DispatchQueue.main.async(execute: {
                    self.present(alert, animated: true)
                })
                
            } else {
                
                if importListArray.count != 0 {
                    importListMainView.isHidden = false
                    importBackroundView.isHidden = false
                    importTblvIEW.reloadData()
                    nongenotypeCrossBtnOutlet.isHidden = false
                }
            }
        } else {
            if importListArray.count != 0 {
                importListMainView.isHidden = false
                importBackroundView.isHidden = false
                importTblvIEW.reloadData()
                nongenotypeCrossBtnOutlet.isHidden = false
                
            }
        }
    }
    
    @IBAction func nongenotypeCrossBtnAction(_ sender: Any) {
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Removing list will remove its animals from the order as well. Do you want to continue?", comment: ""), preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
            
        })
        
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
            
            let listArray = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(self.pvid),customerId:Int64(self.custmerId))
            
            for i in 0 ..< listArray.count{
                
                let listObj = listArray[i] as! MergeDataEntryList
                
                let animalData =  fetchDataEnteryAnimalTbl(entityName: Entities.beefAnimalAddTblEntity, customerId: Int(listObj.customerId), listId: Int64(listObj.listId))
                
                if animalData.count > 0 {
                    
                    for i in 0 ..< animalData.count {
                        let ad = animalData[i] as! BeefAnimaladdTbl
                        deleteDataWithProductBeefDelete(Int(ad.animalId))
                        deleteDataWithSubProductAnimalId(Int(ad.animalId))
                        
                    }
                    deleteDataWithListIdDatEntry(entityString: Entities.beefAnimalAddTblEntity, listId: Int(listObj.listId), customerId: Int(listObj.customerId),userId:self.userId)
                }
            }
            deleteDataWithPvidCustomerId(entityString: "MergeDataEntryList" ,providerId: Int64(UserDefaults.standard.integer(forKey: "BeefPvid")),customerId: Int64(self.custmerId))
            
            
            let attributeString = NSMutableAttributedString(string: NSLocalizedString("Import My List", comment: ""), attributes: self.attrs)
            self.nongenotypeImportFromBtnBtnOutlet.setAttributedTitle(attributeString, for: .normal)
            
            UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
            self.nongenotypeImportFromBtnBtnOutlet.isEnabled = true
            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
            self.notificationLblCount.text = String(animalCount.count)
            if animalCount.count == 0 {
                self.notificationLblCount.isHidden = true
                self.countLbl.isHidden = true
            } else {
                self.notificationLblCount.isHidden = false
                self.countLbl.isHidden = false
            }
            self.nongenotypeCrossBtnOutlet.isHidden = true
            
            
            if fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(self.pvid),customerId:Int64(self.custmerId)).count == 0 {
                self.nongenotypeMergeListBtnOulet.isHidden = true
            } else {
                self.nongenotypeMergeListBtnOulet.isHidden = false
            }
        })
        alert.addAction(ok)
        
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
        
    }
    
    @IBAction func cancelBtnClickImportView(_ sender: Any) {
        
        importListMainView.isHidden = true
        importBackroundView.isHidden = true
    }
    @IBAction func genotypeMergeListBtnClick(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "AnimalMergePopUpVC") as! AnimalMergePopUpVC
        vc.delegate = self
        vc.providerId = pvid
        self.navigationController?.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func nonGenotypeclearFromAction(_ sender: Any) {
        self.view.endEditing(true)
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message: NSLocalizedString("Are you sure you want to reset form?", comment: ""), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("No",comment: ""), style: .default, handler: { action in
            
        })
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title:NSLocalizedString("Yes",comment: "") , style: .default, handler: { action in
            
            self.byDefaultSetting()
            if let breed = self.breedArrblack[0] as? GetBreedsTbl
            {
                self.genstarblackBreedBtn.setTitle(breed.threeCharCode, for: .normal)
            }
            let tissueName = UserDefaults.standard.string(forKey: "tissueBttnClear")
            if UserDefaults.standard.string(forKey: "tissueBttnClear") == nil || UserDefaults.standard.string(forKey: "tissueBttnClear") == ""{
                self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                for items in self.tissueArr
                {
                    let tissue = items  as? GetSampleTbl
                    let checkdefault  = tissue?.isDefault
                    
                    if checkdefault == true
                    {
                        self.tissueBttn.setTitle(tissue?.sampleName?.localized, for: .normal)
                        self.tissuId =  Int(tissue?.sampleId ?? 4)
                    }
                    
                    
                }
                
            }
            else {
                let codeId = fetchBreedDataTissueCode(entityName: Entities.getSampleTblEntity,provId: pvid,tissueName:tissueName!)
                let naabFetch1 = codeId.value(forKey: "sampleId") as? NSArray
                if naabFetch1!.count != 0 {
                    let breedIdGet = naabFetch1![0] as? Int
                    self.tissuId = breedIdGet!
                }
                self.tissueBttn.setTitle(tissueName?.localized, for: .normal)
                UserDefaults.standard.set(self.tissueBttn.titleLabel!.text, forKey: "tissueBttn")
            }
   
            let inrementCheck = UserDefaults.standard.bool(forKey: "isBarCodeIncrementalClear")
            
            if inrementCheck  {
                self.isBarcodeAutoIncrementedEnabled = true
                
                self.incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.checkImg)
                UserDefaults.standard.set(true, forKey: "isBarCodeIncremental")
                self.checkBarcode = false
                if UserDefaults.standard.bool(forKey: "isBarCodeIncremental"), let lastSavedBarCode = UserDefaults.standard.value(forKey: "barcodeIncremental") as? String {
                    self.scanBarcodeTextfield.text = isBarcodeEndingWithNumberAndGetIncremented(lastSavedBarCode).incrementedBarCode
                    
                    if self.scanBarcodeTextfield.text?.isEmpty == false {
                        self.othersByDefaultBackroundWhite()
                    }
                }
            } else {
                
                self.incrementalBarcodeCheckBox.image = UIImage(named: "Incremental_Check")
                self.isBarcodeAutoIncrementedEnabled = false
            }
            
            self.scanBarcodeTextfield.becomeFirstResponder()
            
            
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}

extension BeefAnimalBrazilVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

extension BeefAnimalBrazilVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == importTblvIEW  {
            
            
            return importListArray.count
        }
        if btnTag == 10 {
            return self.tissueArr.count
        }else if btnTag == 116
        {
            if isGenostarblackOnlyAdded && isGenotypeOnlyAdded
            {
                return self.tempbreedarraynames2.count
            }
            else
            {
                
                return self.breedArr.count
            }
            
            
        }
        else if btnTag == 117
        {
            
            return self.breedArrblack.count
        }
        else if btnTag == 20 {
            
            return self.priorityBreeding.count
            
        } else  if btnTag == 40 {
            return self.tissueArr.count
        } else  if btnTag == 50 {
            return self.tertiaryBreeding.count
        }
        else {
            return self.secondaryBreeding.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        if tableView == importTblvIEW {
            
            let cell :ImportListCell = importTblvIEW.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ImportListCell
            
            cell.listNameLabel.text = importListArray[indexPath.row].listName
            cell.listNameDescLbl.text = importListArray[indexPath.row].listDesc
            return cell
        }
        if btnTag == 10 {
            let tissue = self.tissueArr[indexPath.row]  as! GetSampleTbl
            tissuId =  Int(tissue.sampleId)
            
            cell.textLabel?.text = tissue.sampleName?.localized
            
            
            return cell
            
        }
        else if btnTag == 116
        {
            
            
            if isGenostarblackOnlyAdded && isGenotypeOnlyAdded
            {
                cell.textLabel?.text = tempbreedarraynames2[indexPath.row]
                breedId = tempbreedarraynames1[indexPath.row]
                
                return cell
            }
            else
            {
                let breed = breedArr[indexPath.row] as! GetBreedsTbl
                cell.textLabel?.text = breed.threeCharCode
                breedId = breed.breedId!
                return cell
            }
            
            
        }
        else if btnTag == 117
        {
            
            let breed1 = breedArrblack[indexPath.row] as! GetBreedsTbl
            cell.textLabel?.text = breed1.threeCharCode
            breedId = breed1.breedId!
            return cell
            
        }
        else if btnTag == 20 {
            
            let tissue = self.priorityBreeding[indexPath.row]  as! GetPriorityBreeding
            cell.textLabel?.text = tissue.priorityBreedName
            return cell
            
        } else if btnTag == 40 {
            let tissue = self.tissueArr[indexPath.row]  as! GetSampleTbl
            tissuId =  Int(tissue.sampleId)
            
            
            cell.textLabel?.text = tissue.sampleName?.localized
            
            
            return cell
            
        } else if btnTag == 50 {
            let tissue = self.tertiaryBreeding[indexPath.row]  as! GetTertiaryBreedingPrograms
            cell.textLabel?.text = tissue.priorityBreedName
            return cell
        }
        else {
            let tissue = self.secondaryBreeding[indexPath.row]  as! GetSecondaryBreedingPrograms
            cell.textLabel?.text = tissue.priorityBreedName
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        barcodeEnable = true
        
        if tableView == importTblvIEW {
            
            let listId1 = importListArray[indexPath.row].listId
            let listName = importListArray[indexPath.row].listName
            listNameString = listName ?? ""
            listId = Int(listId1)
            
            return
        }
        if btnTag == 10 {
            let tissue = self.tissueArr[indexPath.row]  as! GetSampleTbl
            genotypeTissueBttn.setTitleColor(.black, for: .normal)
            tissuId = Int(tissue.sampleId)
            
            genotypeTissueBttn.setTitle(tissue.sampleName?.localized, for: .normal)
            
            buttonbg2.removeFromSuperview()
            
        }
        else if btnTag == 116
        {
            
            if isGenostarblackOnlyAdded && isGenotypeOnlyAdded
            {
                
                breedId = tempbreedarraynames1[indexPath.row]
                selectBreedBtn.setTitle(tempbreedarraynames2[indexPath.row], for: .normal)
                
            }
            else
            {
                let breed = self.breedArr[indexPath.row] as! GetBreedsTbl
                breedId = breed.breedId!
                selectBreedBtn.setTitleColor(.black, for: .normal)
                selectBreedBtn.setTitle(breed.threeCharCode, for: .normal)
                
            }
            
            buttonbg2.removeFromSuperview()
        }
        else if btnTag == 117
        {
            let breed1 = self.breedArrblack[indexPath.row] as! GetBreedsTbl
            breedId = breed1.breedId!
            genstarblackBreedBtn.setTitleColor(.black, for: .normal)
            genstarblackBreedBtn.setTitle(breed1.threeCharCode, for: .normal)
            buttonbg2.removeFromSuperview()
        }
        else  if btnTag == 20 {
            
            let tissue = self.priorityBreeding[indexPath.row]  as! GetPriorityBreeding
            priorityBreeingBtnOutlet.setTitleColor(.black, for: .normal)
            priorityBreeingBtnOutlet.setTitle(tissue.priorityBreedName, for: .normal)
            
            buttonbg2.removeFromSuperview()
            
        } else if btnTag == 40 {
            let tissue = self.tissueArr[indexPath.row]  as! GetSampleTbl
            tissueBttn.setTitleColor(.black, for: .normal)
            tissuId = Int(tissue.sampleId)
            tissueBttn.setTitle(tissue.sampleName?.localized, for: .normal)
            buttonbg2.removeFromSuperview()
            
        }
        else if btnTag == 50 {
            let tissue = self.tertiaryBreeding[indexPath.row]  as! GetTertiaryBreedingPrograms
            territoryBreddingOutlet.setTitleColor(.black, for: .normal)
            territoryBreddingOutlet.setTitle(tissue.priorityBreedName, for: .normal)
            
            buttonbg2.removeFromSuperview()
        }
        else {
            let tissue = self.secondaryBreeding[indexPath.row]  as! GetSecondaryBreedingPrograms
            secondaryBreddingOutlet.setTitleColor(.black, for: .normal)
            secondaryBreddingOutlet.setTitle(tissue.priorityBreedName, for: .normal)
            
            buttonbg2.removeFromSuperview()
        }
    }
}



extension BeefAnimalBrazilVC: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if !isGenotypeOnlyAdded {
            
            if (textField == animalTextfield ) {
                
                animalTextfield.returnKeyType = UIReturnKeyType.done
            } else {
                serieTextfield.returnKeyType = UIReturnKeyType.next
                scanBarcodeTextfield.returnKeyType = UIReturnKeyType.next
                rGNTextfield.returnKeyType = UIReturnKeyType.next
                rGDTextfield.returnKeyType = UIReturnKeyType.next
            }
            
            
            if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") && UserDefaults.standard.value(forKey: "barcodeIncremental") as? String == scanBarcodeTextfield.text {
                    
                    if let lastSavedBarCode = UserDefaults.standard.value(forKey: "barcodeIncremental") as? String {
                        scanBarcodeTextfield.text = isBarcodeEndingWithNumberAndGetIncremented(lastSavedBarCode).incrementedBarCode
                        
                        if scanBarcodeTextfield.text?.isEmpty == false {
                            othersByDefaultBackroundWhite()
                        }
                    }
            }
            
        } else {
            
            if (textField == genotypeAnimalNameTextfield ) {
                genotypeAnimalNameTextfield.returnKeyType = UIReturnKeyType.done
            } else {
                genotypeScanBarcodeTextField.returnKeyType = UIReturnKeyType.next
                genotypeSerieTextfield.returnKeyType = UIReturnKeyType.next
                genotypeRgnTextfield.returnKeyType = UIReturnKeyType.next
                genotypeRgdTextfield.returnKeyType = UIReturnKeyType.next
                
            }
            
            if UserDefaults.standard.bool(forKey: "isBarCodeIncremental") && UserDefaults.standard.value(forKey: "barcodeIncremental") as? String == genotypeScanBarcodeTextField.text {
                if let lastSavedBarCode = UserDefaults.standard.value(forKey: "barcodeIncremental") as? String {
                    genotypeScanBarcodeTextField.text = isBarcodeEndingWithNumberAndGetIncremented(lastSavedBarCode).incrementedBarCode
                    if genotypeScanBarcodeTextField.text?.isEmpty == false {
                        self.genotypeByDefaultBackroundWhite()
                    }
                }
            }
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == genotypeDateTextField {
            if genotypeDateTextField.text?.isEmpty == true {
                genotypeDOBBttn.layer.borderColor = UIColor.red.cgColor
                validateDateFlag = false
            }  else {
                
                if genotypeDateTextField.text?.count == 10 {
                    
                    let validate = isValidDate(dateString: genotypeDateTextField.text ?? "")
                    
                    if validate == "Correct Format" {
                        genotypeDOBBttn.layer.borderColor = UIColor.gray.cgColor
                        genotypeDOBBttn.layer.borderWidth = 0.5
                        validateDateFlag = true
                    } else {
                        genotypeDOBBttn.layer.borderColor = UIColor.red.cgColor
                        validateDateFlag = false
                    }
                    
                } else {
                    genotypeDOBBttn.layer.borderColor = UIColor.red.cgColor
                    validateDateFlag = false
                }
            }
        }
   
        if textField == dateTextField {
            if dateTextField.text!.isEmpty == true{
                dobView.layer.borderColor = UIColor.red.cgColor
                validateDateFlag = false
            }  else {
                
                if dateTextField.text?.count == 10 {
                    
                    let validate = isValidDate(dateString: dateTextField.text ?? "")
                    
                    if validate == "Correct Format" {
                        dobView.layer.borderColor = UIColor.gray.cgColor
                        dobView.layer.borderWidth = 0.5
                        validateDateFlag = true
                    } else {
                        dobView.layer.borderColor = UIColor.red.cgColor
                        validateDateFlag = false
                    }
                    
                } else {
                    dobView.layer.borderColor = UIColor.red.cgColor
                    validateDateFlag = false
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if isautoPopulated{
            if scanBarcodeTextfield.text!.count > 0 {
                othersByDefaultBackroundWhite()
            }
            else{
                otherbyTextfieldGray()
            }
        }
        if genotypeScanBarcodeTextField.text!.count > 0 {
            
            genotypeByDefaultBackroundWhite()
            
        } else {
            
            genotypeByDefaultScreen()
            
        }
        
        
        
        if (textField == self.genotypeScanBarcodeTextField) {
            
            if genotypeScanBarcodeTextField.text == ""{
                
                genotypeScanBarcodeView.layer.borderColor = UIColor.red.cgColor
                
            } else {
                
                genotypeScanBarcodeView.layer.borderColor = UIColor.gray.cgColor
                
                self.genotypeSerieTextfield.becomeFirstResponder()
                
            }
            
            self.genotypeSerieTextfield.becomeFirstResponder()
            
        }
        
        else if (textField == self.genotypeSerieTextfield) {
            requiredflag = 1
            if genotypeSerieTextfield.text == ""{
                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                    if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
                        requiredflag = 1
                    }else{
                        requiredflag = 0
                    }
                    
                }
                else{
                    requiredflag = 1
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
                
            } else {
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
            
            self.genotypeRgnTextfield.becomeFirstResponder()
            
        }
        
        else if (textField == self.genotypeRgnTextfield) {
            requiredflag = 1
            if genotypeRgnTextfield.text == ""{
                
                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                    if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
                        requiredflag = 1
                    }else{
                        requiredflag = 0
                    }
                    
                }
                else{
                    requiredflag = 1
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
            } else {
                
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
            
            self.genotypeRgdTextfield.becomeFirstResponder()
            
        }
        
        else if (textField == self.genotypeRgdTextfield) {
            requiredflag = 1
            if genotypeRgdTextfield.text == ""{
                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                    if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
                        requiredflag = 1
                    }else{
                        requiredflag = 0
                    }
                    
                }
                else{
                    requiredflag = 1
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
            } else {
                
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
            
            self.genotypeAnimalNameTextfield.becomeFirstResponder()
            
        }
        
        else if (textField == self.genotypeAnimalNameTextfield) {
            
            self.genotypeAnimalNameTextfield.resignFirstResponder()
            
        }
        if scanBarcodeTextfield.text!.count > 0 {
            
            othersByDefaultBackroundWhite()
        } else {
            
            otherbyTextfieldGray()
            
        }
        
        if (textField == self.scanBarcodeTextfield) {
            
            if scanBarcodeTextfield.text == ""{
                
                barcodeView.layer.borderColor = UIColor.red.cgColor
                
            } else {
                
                barcodeView.layer.borderColor = UIColor.gray.cgColor
                
                self.genotypeSerieTextfield.becomeFirstResponder()
                
            }
            
            self.serieTextfield.becomeFirstResponder()
            
        }
        
        else if (textField == self.serieTextfield) {
            requiredflag = 1
            if serieTextfield.text == ""{
                
                if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                    requiredflag = 0
                }
                else{
                    requiredflag = 1
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
                
            } else {
                rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                serieTextfield.layer.borderColor = UIColor.gray.cgColor
                rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                
            }
            
            self.rGNTextfield.becomeFirstResponder()
            
        }
        
        else if (textField == self.rGNTextfield) {
            requiredflag = 1
            if rGNTextfield.text == ""{
                
                if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                    requiredflag = 0
                }
                else{
                    requiredflag = 1
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
                
            } else {
                rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                serieTextfield.layer.borderColor = UIColor.gray.cgColor
                rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                rGNTextfield.layer.borderColor = UIColor.gray.cgColor
            }
            self.rGDTextfield.becomeFirstResponder()
            
        }
        
        
        
        else if (textField == self.rGDTextfield) {
            requiredflag = 1
            if rGDTextfield.text == ""{
                
                if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                    requiredflag = 0
                }
                else{
                    requiredflag = 1
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
                
            } else {
                rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                serieTextfield.layer.borderColor = UIColor.gray.cgColor
                rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                rGDTextfield.layer.borderColor = UIColor.gray.cgColor
            }
            
            self.animalTextfield.becomeFirstResponder()
        }
        
        
        
        else if (textField == self.animalTextfield) {
            self.animalTextfield.resignFirstResponder()
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if !barAutoPopu {
            barcodeflag = true
        }else {
            let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: "BeefAnimalMaster", animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
            let isTargetField = textField == genotypeSerieTextfield ||
                                textField == genotypeRgnTextfield ||
                                textField == genotypeAnimalNameTextfield ||
                                textField == genotypeRgdTextfield ||
                                textField == serieTextfield ||
                                textField == rGNTextfield ||
                                textField == rGDTextfield ||
                                textField == animalTextfield

            if orederStatus.count > 0 && isTargetField {
                barcodeEnable = true
            }
        }
        if textField == animalTextfield {
            guard range.location == 0 else {
                return true
            }
            
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
            return newString.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines).location != 0
            
        }  else if textField  == genotypeAnimalNameTextfield {
            guard range.location == 0 else {
                return true
            }
            
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
            return newString.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines).location != 0
            
        } else {
            if  (string == " ") {
                return false
            }
        }
        
        
        if textField == genotypeScanBarcodeTextField {
            self.defaultIncrementalBarCodeSettingGenoType()
            
            let currentString: NSString = genotypeScanBarcodeTextField.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            barcodeflag = true
            if self.isBarcodeAutoIncrementedEnabled {
                if isBarcodeEndingWithNumberAndGetIncremented(newString as String).isBarCodeEndsWithNumber  {
                    incrementalBarcodeCheckBoxGenoType.image = UIImage(named: ImageNames.checkImg)
                    UserDefaults.standard.set(true, forKey: "isBarCodeIncremental")
                    checkBarcode = false
                    
                } else {
                    incrementalBarcodeCheckBoxGenoType.image = UIImage(named: ImageNames.checkImg)
                    
                    UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                    checkBarcode = true
                    
                }
            }
            
        }
        if textField == genotypeRgdTextfield
        {
            let currentString: NSString = genotypeRgdTextfield.text! as NSString
            currentString.replacingCharacters(in: range, with: string)
            genovalidateRGD = true
        }
        if textField == rGDTextfield
        {
            let currentString: NSString = rGDTextfield.text! as NSString
            currentString.replacingCharacters(in: range, with: string)
            validateRGD = true
        }
        
        if textField == scanBarcodeTextfield {
            self.defaultIncrementalBarCodeSetting()
            
            let currentString: NSString = scanBarcodeTextfield.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            barcodeflag = true
            if self.isBarcodeAutoIncrementedEnabled {
                if isBarcodeEndingWithNumberAndGetIncremented(newString as String).isBarCodeEndsWithNumber  {
                    incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.checkImg)
                    UserDefaults.standard.set(true, forKey: "isBarCodeIncremental")
                    checkBarcode = false
                    
                } else {
                    incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.checkImg)
                    UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
                    checkBarcode = true
                    
                }
            }
            
        }
        
        if let char = string.cString(using: String.Encoding.utf8) {
            
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                
                if textField == scanBarcodeTextfield{
                    barcodeflag = true
                    if scanBarcodeTextfield.text!.count == 1 {
                        self.isBarcodeAutoIncrementedEnabled = false
                        incrementalBarcodeTitleLabel.textColor = .gray
                        incrementalBarcodeButton.isEnabled = false
                        incrementalBarcodeCheckBox.image = UIImage(named: "Incremental_Check")
                        
                        otherbyTextfieldGray()
                    } else {
                        othersByDefaultBackroundWhite(isBeginEditing: true)
                    }
                }
                
                if textField == genotypeScanBarcodeTextField{
                    barcodeflag = true
                    if genotypeScanBarcodeTextField.text!.count == 1 {
                        
                        self.isBarcodeAutoIncrementedEnabled = false
                        incrementalBarcodeTitleLabelGenoType.textColor = .gray
                        incrementalBarcodeButtonGenoType.isEnabled = false
                        incrementalBarcodeCheckBoxGenoType.image = UIImage(named: "Incremental_Check")
                        
                        
                        genotypeByDefaultBackroundGray()
                    } else {
                        genotypeByDefaultBackroundWhite(isBeginEditing: true)
                    }
                }
                if textField == genotypeRgdTextfield
                {
                    let currentString: NSString = genotypeRgdTextfield.text! as NSString
                    currentString.replacingCharacters(in: range, with: string)
                    genovalidateRGD = true
                }
                if textField == rGDTextfield
                {
                    let currentString: NSString = rGDTextfield.text! as NSString
                    currentString.replacingCharacters(in: range, with: string)
                    validateRGD = true
                }
                return true
            } else {
                
                if textField == genotypeScanBarcodeTextField{
                    genotypeByDefaultBackroundWhite(isBeginEditing: true)
                }
                
                if textField == scanBarcodeTextfield{
                    othersByDefaultBackroundWhite(isBeginEditing: true)
                }
            }
            if textField == genotypeDateTextField {
                
                if genotypeDateTextField.text?.count == 2 || genotypeDateTextField.text?.count == 5{
                    genotypeDateTextField.text?.append("/")
                }
                if genotypeDateTextField.text?.count == 10 {
                    return false
                }
                
            }
            
            if textField == dateTextField {
                
                if dateTextField.text?.count == 2 || dateTextField.text?.count == 5{
                    dateTextField.text?.append("/")
                }
                if dateTextField.text?.count == 10 {
                    return false
                }
            }
            
            if editIngText {
                editIngText = false
                
            }
            
            else if isUpdate {
                animalId1 = editAid
                isUpdate = false
            }
            if statusOrder {
                msgAnimalSucess = true
            }
            else{
                messageCheck = true
            }
            
            let animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimalMaster", animalId: idAnimal, customerID: custmerId)
            if animalFetch.count > 0{
                statusOrder = true
            }
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            if animalDataMaster.count > 0 {
                msgUpatedd = true
            }
            if isautoPopulated  {
                let animalData = fetchAnimaldataValidateAnimalTag(entityName: Entities.beefAnimalAddTblEntity, animalTag:scanAnimalText, orderId: orderId, userId: userId, animalId: animalId1)
                if animalData.count == 0{
                    let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimalMaster", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                    if animalDataMaster.count > 0 {
                        msgcheckk = true
                    }
                }
            }
        }
        if textField == scanBarcodeTextfield || textField == genotypeScanBarcodeTextField {
            
            let acceptableCharacters = "+?%ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
            let check  = acceptableCharacters.contains(string)
            if !check {
                return false
            }
        }
        return true
    }
    
}
extension BeefAnimalBrazilVC : SideMenuUI,objectPickCartScreen{
    func objectGetOnSelection(temp: Int) {
        
    }
    func anOptionalMethod(check :Bool){
        
        if check{
            isUpdate = false
            editIngText = false
            statusOrder = false
            animalId1 = -1
            editAid = -1
            idAnimal = 0
            isautoPopulated = false
            byDefaultSetting()
            otherbyTextfieldGray()
            msgUpatedd = false
        }}
    
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}
extension BeefAnimalBrazilVC : AnimalMergeProtocol{
    func refreshUI() {
        
        if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeOnly.rawValue || UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeStarBlack.rawValue{
            
            let animalCount = fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
            self.notificationLblCount.text = String(animalCount.count)
            if animalCount.count == 0 {
                self.notificationLblCount.isHidden = true
                self.countLbl.isHidden = true
                self.genotypeCrossBtnOutlet.isHidden = true
                self.genotypeMergeListBtnOulet.isHidden = true
                
            } else {
                self.notificationLblCount.isHidden = false
                self.countLbl.isHidden = false
                self.genotypeCrossBtnOutlet.isHidden = false
                
                self.genotypeMergeListBtnOulet.isHidden = false
            }
            
            
            let fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId,providerId:pvid)
            if fetchObj.count != 0 {
                let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                let obj = objectFetch?.listName
                let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid),customerId:Int64(custmerId)).count - 1
                
                if fetchAllMergeDta == 0 {
                    let fetchNameDisplay = String(obj ?? "")
                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                    genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                    
                } else {
                    let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                    genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                    
                }
            } else {
                let attributeString = NSMutableAttributedString(string: "", attributes: self.attrs)
                genotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                genotypeMergeListBtnOulet.isHidden = true
                genotypeCrossBtnOutlet.isHidden = true
            }
            
            
        } else {
            
            let animalCount = fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
            self.notificationLblCount.text = String(animalCount.count)
            if animalCount.count == 0 {
                self.notificationLblCount.isHidden = true
                self.countLbl.isHidden = true
                self.nongenotypeCrossBtnOutlet.isHidden = true
                self.nongenotypeMergeListBtnOulet.isHidden = true
                
            } else {
                self.notificationLblCount.isHidden = false
                self.countLbl.isHidden = false
                self.nongenotypeCrossBtnOutlet.isHidden = false
                
                self.nongenotypeMergeListBtnOulet.isHidden = false
            }
            
            
            
            
            let fetchObj = fetchListNameToCustId(entityName: "MergeDataEntryList",customerId:custmerId,providerId:pvid)
            if fetchObj.count != 0 {
                let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                let obj = objectFetch?.listName
                let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: "MergeDataEntryList",providerId: Int64(pvid),customerId:Int64(custmerId)).count - 1
                
                if fetchAllMergeDta == 0 {
                    let fetchNameDisplay = String(obj ?? "")
                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                    nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                    
                } else {
                    let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                    nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                    
                }
            }else {
                let attributeString = NSMutableAttributedString(string: "", attributes: self.attrs)
                nongenotypeMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                nongenotypeMergeListBtnOulet.isHidden = true
                nongenotypeCrossBtnOutlet.isHidden = true
            }
        }}
}

//MARK: CREATE Beef Datalist
private typealias DataListCartHelper = BeefAnimalBrazilVC
private extension DataListCartHelper {
    
    func fetchDatalistDetailbyName(listName: String) -> [DataEntryList] {
        let fetchDataEntry : [DataEntryList] = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(custmerId),listName: listName ,productName:"Beef") as! [DataEntryList]
        return fetchDataEntry
    }
    
    func checkCartanimalCount() {
        let viewAnimalArray =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid)
        if viewAnimalArray.count > 0{
            createDataList()
        }
        
    }
    func createDataList(){
        print("pvid =", pvid)
        
        
        let listName = orderingDataListViewModel.makeListName(custmerId: custmerId, providerID: pvid)
        if listName != "" {
            
            
            var animalID1 = UserDefaults.standard.integer(forKey: "listId")
            animalID1 = animalID1 + 1
            UserDefaults.standard.set(animalID1, forKey: "listId")
            self.hideIndicator()
            
            if UserDefaults.standard.value(forKey: "name") as? String == "Beef" {
                var fetchDatEntry = [DataEntryList]()
                var productType  = ""
                if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeOnly.rawValue {
                    productType = keyValue.genoTypeOnly.rawValue
                    
                }else  if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeStarBlack.rawValue {
                    productType = keyValue.genoTypeStarBlack.rawValue
                    
                }else  if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genStarBlack.rawValue {
                    productType = keyValue.genStarBlack.rawValue
                    
                }
                else {
                    productType = keyValue.nonGenoType.rawValue
                    
                }
                fetchDatEntry =  fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(custmerId),listName: listName ,productName:"Beef") as! [DataEntryList]
                
                if fetchDatEntry.count == 0 {
                    
                    saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(custmerId),listDesc: "",listId: Int64(animalID1),listName: listName ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: pvid , productType: productType, productName: "Beef")
                    
                    saveAnimalDatInList(listID: Int64(animalID1), animalID: animalID1)
                    
                } else {
                    let listIdGet = fetchDatEntry[0].listId
                    saveAnimalDatInList(listID: listIdGet, animalID: animalID1)
                }
            }
        }
    }
    
    func saveAnimalDatInList(listID:Int64,animalID:Int){
        
        
        let animals = fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid")) as! [BeefAnimaladdTbl]
        
        for data in animals {
            
            let animalData = fetchAnimaldataAnimalBarcodeandAnimalIdAndEarTag(entityName: "DataEntryBeefAnimaladdTbl", animalTag: data.animalTag ?? "", sireId: data.offsireId ?? "", animalBarCode: data.animalbarCodeTag ?? "", userId: 1, orderStatus: "false", listID: Int(listID), providerId:UserDefaults.standard.integer(forKey: "BeefPvid"))
            
            
            if animalData.count == 0 {
                saveAnimalInDataBeefAnimalGlobal(listID: listID, animalDetails: data, animalID: animalID)
            }
            
        }
        
    }
    
    
    func saveAnimalInDataBeefAnimalGlobal(listID:Int64, animalDetails:BeefAnimaladdTbl,animalID:Int) {
        
        
        saveAnimaldataBeefInProductId(entity: "DataEntryBeefAnimaladdTbl",
                                      animalTag: animalDetails.animalTag ?? "",
                                      barCodetag: animalDetails.animalbarCodeTag ?? "" ,
                                      date: animalDetails.date ?? ""  ,
                                      damId: animalDetails.offDamId ?? "",
                                      sireId: animalDetails.offsireId ?? "" ,
                                      gender: animalDetails.gender ?? "",
                                      update: "true",
                                      permanentId:animalDetails.offPermanentId ?? "",
                                      tissuName: animalDetails.tissuName ?? "",
                                      breedName: animalDetails.breedName ?? "",
                                      et: animalDetails.eT ?? "",
                                      farmId: animalDetails.farmId ?? "",
                                      orderId: 1,
                                      orderSataus:"false",
                                      breedId:animalDetails.breedId ?? "",
                                      isSync:"false",
                                      providerId: Int(animalDetails.providerId),
                                      tissuId: Int(animalDetails.tissuId),
                                      sireIDAU: animalDetails.sireIDAU ?? "",
                                      nationHerdAU: animalDetails.nationHerdAU ?? "",
                                      userId: userId,
                                      udid:animalDetails.udid ?? "",
                                      animalId: animalID,
                                      productId:Int(animalDetails.productId),
                                      custId: Int(animalDetails.custmerId),
                                      listId: listID,
                                      serverAnimalId: "",
                                      tertiaryGeno: animalDetails.tertiaryGeno ?? "")
    }
    
    
}
//MARK: Auto Import Datalist
private typealias AutoImportDataListHelper = BeefAnimalBrazilVC
private extension AutoImportDataListHelper {
    
    // MARK: AUTO IMPORT ANIMAL FROM DATALIST
    
    func checkUserDataListName(){
        let orderingDataList = OrderingDataListViewModel()
        let listName = orderingDataList.makeListName(custmerId: self.custmerId, providerID: pvid)
        let fetchDatEntry : [DataEntryList] = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.custmerId),listName:listName ,productName:"Beef") as! [DataEntryList]
        if fetchDatEntry.count > 0{
            genotypeCrossBtnOutlet.isHidden = true
            
            let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: "DataEntryBeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false",listid:Int64(fetchDatEntry.first?.listId ?? 0), custmerId: Int64(custmerId ), providerId: pvid )
            if fetchData11.count != 0 {
                
                for i in 0...fetchData11.count - 1 {
                    
                    let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                    
                    saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity,
                                                  animalTag: dataGet.animalTag ?? "",
                                                  barCodetag: dataGet.animalbarCodeTag ?? "" ,
                                                  date: dataGet.date ?? ""  ,
                                                  damId: dataGet.offDamId ?? "",
                                                  sireId: dataGet.offsireId ?? "" ,
                                                  gender: dataGet.gender ?? "",
                                                  update: "true",
                                                  permanentId:dataGet.offPermanentId ?? "",
                                                  tissuName: dataGet.tissuName ?? "",
                                                  breedName: dataGet.breedName ?? "",
                                                  et: dataGet.eT ?? "",
                                                  farmId: dataGet.farmId ?? "",
                                                  orderId: autoD,
                                                  orderSataus:"false",
                                                  breedId:dataGet.breedId ?? "",
                                                  isSync:"false",
                                                  providerId: pvid,
                                                  tissuId: Int(dataGet.tissuId),
                                                  sireIDAU: dataGet.sireIDAU ?? "",
                                                  nationHerdAU: dataGet.nationHerdAU ?? "",
                                                  userId: userId,
                                                  udid:dataGet.udid ?? "",
                                                  animalId: Int(dataGet.animalId),
                                                  productId:Int(dataGet.productId),
                                                  custId: Int(dataGet.custmerId),
                                                  listId: fetchDatEntry.first?.listId ?? 0,
                                                  serverAnimalId: "",
                                                  tertiaryGeno: dataGet.tertiaryGeno ?? "")
                    UserDefaults.standard.setValue(dataGet.breedName, forKey: "Beefbreed")
                    UserDefaults.standard.setValue(dataGet.tissuName, forKey: "Beeftsu")
                    genotypeTissueBttn.setTitle(dataGet.tissuName ?? "", for: .normal)
                    genstarblackBreedBtn.setTitle(dataGet.breedName ?? "", for: .normal)
                    autoSaveProductandsubProduct(dataGet: dataGet)
                }
            }
        }
        genotypeCrossBtnOutlet.isHidden = true
        
    }
    //MARK: AUTOSAVE Product and subProduct
    func autoSaveProductandsubProduct(dataGet:DataEntryBeefAnimaladdTbl){
        let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
        
        let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
        
        for k in 0 ..< animalData.count{
            
            let animalId = animalData[k] as! BeefAnimaladdTbl
            
            for i in 0 ..< product.count {
                
                let data = product[i] as! GetProductTblBeef
                
                saveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: animalId.farmId ?? "", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "", orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: true)
                
                let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: "BVDV", status: "true",ordrId:orderId, customerID: custmerId)
                for j in 0 ..< addonArr.count {
                    
                    let addonDat = addonArr[j] as! GetAdonTbl
                    if data12333.count > 0 {
                        if addonDat.adonName == "BVDV" {
                            saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                            updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: Int(addonDat.adonId), status: "true")
                        }
                        else {
                            saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                        }
                    }
                    else {
                        saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                    }
                    
                    statusOrder = false
                    UserDefaults.standard.removeObject(forKey: "review")
                    self.animalSucInOrder = ""
                    
                }
                
                
            }
        }
    }
}

extension BeefAnimalBrazilVC: QrScannerProtocol {
    func qrCodeScannedResult(_ qrValue: String) {
        print("scanned QR value -> \(qrValue)")
        
        if isGenotypeOnlyAdded {
            genotypeScanBarcodeTextField.text = qrValue
            genotypeByDefaultBackroundWhite()
            
        }else{
            scanBarcodeTextfield.text = qrValue
            othersByDefaultBackroundWhite()
        }
    }
}
