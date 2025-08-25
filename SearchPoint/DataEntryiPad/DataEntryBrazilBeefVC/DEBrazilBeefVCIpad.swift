//
//  DEBrazilBeefVCIpad.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 26/03/25.
//

import Foundation
import UIKit

// MARK: - CLASS
class DEBrazilBeefVCIpad: UIViewController,UIScrollViewDelegate {
    
    // MARK: - OUTLETS
    @IBOutlet weak var nonGenoInnerScrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var genotypeInnerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var genoResetButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var genoAddAnimalStackTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nonGenoAddAnimalStackTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var resetButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var nonGenoAnimalNameHeaderView: UIView!
    @IBOutlet weak var nonGenoGenderHeaderView: UIView!
    @IBOutlet weak var nonGenoGenderDOBStackTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nonGenderDOBStackView: UIStackView!
    @IBOutlet weak var nonGenoBreedTypeStackView: UIStackView!
    @IBOutlet weak var breedTypeHeaderView: UIView!
    @IBOutlet weak var menuIconLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var nonGenoSeriesView: UIView!
    @IBOutlet weak var nonGenoBarcodeView: UIView!
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var nonGenoRGNView: UIView!
    @IBOutlet weak var nonGenoRGDView: UIView!
    @IBOutlet weak var nonGenoAnimalNameView: UIView!
    @IBOutlet weak var nonGenoSampleTypeView: UIView!
    @IBOutlet weak var nonGenoGenderView: UIView!
    @IBOutlet weak var nonGenoBreedTypeView: UIView!
    @IBOutlet weak var GenoSeriesView: UIView!
    @IBOutlet weak var GenoRGNView: UIView!
    @IBOutlet weak var GenoRGDView: UIView!
    @IBOutlet weak var GenoAnimalNameView: UIView!
    @IBOutlet weak var GenoSampleTypeView: UIView!
    @IBOutlet weak var GenoGenderView: UIView!
    @IBOutlet weak var GenoBreedTypeView: UIView!
    @IBOutlet weak var genoPrimaryBreedView: UIView!
    @IBOutlet weak var genoSecondaryBreedView: UIView!
    @IBOutlet weak var genoTeritiaryBreedView: UIView!
    @IBOutlet weak var genoPrimaryHeaderView: UIView!
    @IBOutlet weak var genoSecondaryHeaderView: UIView!
    @IBOutlet weak var genoTeritiaryHeaderView: UIView!
    @IBOutlet weak var genoAnimalNameHeaderView: UIView!
    @IBOutlet weak var genoBreedTypeHeaderView: UIView!
    @IBOutlet weak var genoGenderHeaderView: UIView!
    @IBOutlet weak var genoSecAndTerStackView: UIStackView!
    @IBOutlet weak var genoPrimaryStackView: UIStackView!
    @IBOutlet weak var genoGenderAndBreedStackView: UIStackView!
    @IBOutlet weak var keyBoardOptionsView: UIView!
    @IBOutlet weak var keyBoardOptionsViewBottomConstrains: NSLayoutConstraint!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var closeImage1: UIImageView!
    @IBOutlet weak var closeImage2: UIImageView!
    @IBOutlet weak var selectBreedBtn: UIButton!
    @IBOutlet weak var genstarblackBreedBtn: UIButton!
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
    @IBOutlet weak var priorityBreeingBtnOutlet: UIButton!
    @IBOutlet weak var secondaryBreddingOutlet: UIButton!
    @IBOutlet weak var territoryBreddingOutlet: UIButton!
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
    var sideMenuViewVC: SideMenuVC!
    var sideMenuShadowView: UIView!
    var sideMenuRevealWidth: CGFloat = 300
    let paddingForRotation: CGFloat = 150
    var isExpanded: Bool = false
    var draggingIsEnabled: Bool = false
    var panBaseLocation: CGFloat = 0.0
    var gestureEnabled: Bool = true
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var revealSideMenuOnTop: Bool = true
    var changeColorToRed = false
    var genderArray = ["Female","Male"]
    var viewsArray = [UIView]()
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
        self.setSideMenu()
        dateTextField.setLeftPaddingPoints(20.0)
        genotypeDateTextField.setLeftPaddingPoints(20.0)
        scanBarcodeTextfield.layer.cornerRadius = 15
        scanBarcodeTextfield.clipsToBounds = true
        genotypeScanBarcodeTextField.layer.cornerRadius = 15
        genotypeScanBarcodeTextField.clipsToBounds = true
        serieTextfield.layer.cornerRadius = 15
        serieTextfield.clipsToBounds = true
        rGNTextfield.layer.cornerRadius = 15
        rGNTextfield.clipsToBounds = true
        rGDTextfield.layer.cornerRadius = 15
        rGDTextfield.clipsToBounds = true
        animalTextfield.layer.cornerRadius = 15
        animalTextfield.clipsToBounds = true
        tissueBttn.layer.cornerRadius = 15
        tissueBttn.clipsToBounds = true
        maleFemaleBttn.layer.cornerRadius = 15
        maleFemaleBttn.clipsToBounds = true
        genstarblackBreedBtn.layer.cornerRadius = 15
        genstarblackBreedBtn.clipsToBounds = true
        genotypeSerieTextfield.layer.cornerRadius = 15
        genotypeSerieTextfield.clipsToBounds = true
        genotypeRgnTextfield.layer.cornerRadius = 15
        genotypeRgnTextfield.clipsToBounds = true
        genotypeRgdTextfield.layer.cornerRadius = 15
        genotypeRgdTextfield.clipsToBounds = true
        genotypeAnimalNameTextfield.layer.cornerRadius = 15
        genotypeAnimalNameTextfield.clipsToBounds = true
        genotypeTissueBttn.layer.cornerRadius = 15
        genotypeTissueBttn.clipsToBounds = true
        genotypeMaleFemaleBttn.layer.cornerRadius = 15
        genotypeMaleFemaleBttn.clipsToBounds = true
        selectBreedBtn.layer.cornerRadius = 15
        selectBreedBtn.clipsToBounds = true
        priorityBreeingBtnOutlet.layer.cornerRadius = 15
        priorityBreeingBtnOutlet.clipsToBounds = true
        secondaryBreddingOutlet.layer.cornerRadius = 15
        secondaryBreddingOutlet.clipsToBounds = true
        territoryBreddingOutlet.layer.cornerRadius = 15
        territoryBreddingOutlet.clipsToBounds = true
        addObserver()
        tapRec.addTarget(self, action: #selector(closeAddAnimalAndContinueOptions(tapGestureRecognizer:)))
        UserDefaults.standard.setValue(nil, forKey: keyValue.submitTypeSelection.rawValue)
        listIdGet = UserDefaults.standard.integer(forKey: keyValue.listIdSaveOnSelection.rawValue)
        listName = UserDefaults.standard.object(forKey: keyValue.listNameSaveOnSelection.rawValue) as? String ?? ""
        dateTextField.keyboardType = .phonePad
        genotypeDateTextField.keyboardType = .phonePad
        dateTextField.borderStyle = .none
        dateTextField.delegate = self
        genotypeDateTextField.borderStyle = .none
        genotypeDateTextField.delegate = self
        heartBeatViewModel?.callGetHearBeatData()
        UserDefaults.standard.set(keyValue.brazilMarket.rawValue, forKey: keyValue.capsBrazil.rawValue)
        self.GenotypetextfieldLeftPadding()
        self.defaultIncrementalBarCodeSetting()
        self.defaultIncrementalBarCodeSetting_GenoType()
        otherBorderColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUIOnWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isGenotypeOnlyAdded {
            if !changeColorToRed {
                self.genotypeScanBarcodeTextField.becomeFirstResponder()
                self.genotypeScanBarcodeTextField.backgroundColor = .white
            }
            
        } else {
            if !changeColorToRed {
                self.scanBarcodeTextfield.becomeFirstResponder()
                self.scanBarcodeTextfield.backgroundColor = .white
            }
            
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
            self.cartView.isHidden = true
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
            
        }
        else if (selectedProduct.count == 1 && isGenostarblackOnlyAdded) || (selectedProduct.count == 3 && isGenostarblackOnlyAdded) || (selectedProduct.count == 2 && isGenostarblackOnlyAdded)
        {
            genotypeScrollView.isHidden = true
            scrolView.isHidden = false
            genstarblackBreedBtn.isHidden = false
            nonGenoBreedTypeView.isHidden = false
            breedTypeHeaderView.isHidden = false
            nonGenoBreedTypeStackView.isHidden = false
            nonGenoGenderDOBStackTopConstraint.constant = 30.0
            
        }
        else if selectedProduct.count == 2 && (isGenostarblackOnlyAdded  && isGenotypeOnlyAdded )
        {
            genotypeScrollView.isHidden = false
            scrolView.isHidden = true
            selectBreedBtn.isHidden = false
        }
        else if selectedProduct.count == 4
        {
            genotypeScrollView.isHidden = false
            scrolView.isHidden = true
            selectBreedBtn.isHidden = false
        }
        else
        {
            genstarblackBreedBtn.isHidden = true
            nonGenoBreedTypeView.isHidden = true
            breedTypeHeaderView.isHidden = true
            nonGenoBreedTypeStackView.isHidden = true
            nonGenoGenderDOBStackTopConstraint.constant = 130.0
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
            if isGenostarblackOnlyAdded && isGenotypeOnlyAdded
            {
                UserDefaults.standard.set(keyValue.genoTypeStarBlack.rawValue, forKey: keyValue.beefProduct.rawValue)
            }
            else{
                UserDefaults.standard.set(keyValue.genoTypeOnly.rawValue, forKey: keyValue.beefProduct.rawValue)
            }
            if !UserDefaults.standard.bool(forKey: keyValue.expandView.rawValue) {
                genoTypeExpandFormBtn.setTitle(LocalizedStrings.expandFormStr, for: .normal)
                genoTypeExpandFormBtn.setImage(UIImage(named:"downiPad"), for: .normal)
                genoGenderAndBreedStackView.isHidden = true
                genoGenderHeaderView.isHidden = true
                genoBreedTypeHeaderView.isHidden = true
                genoPrimaryStackView.isHidden = true
                genoAnimalNameHeaderView.isHidden = true
                genoPrimaryHeaderView.isHidden = true
                genoSecAndTerStackView.isHidden = true
                genoSecondaryHeaderView.isHidden = true
                genoTeritiaryHeaderView.isHidden = true
                genoResetButtonBottomConstraint.constant = 175
                genoAddAnimalStackTopConstraint.constant = 40
                genotypeInnerViewHeight.constant = 900
                
                
            }
            else {
                genoTypeExpandFormBtn.setTitle(LocalizedStrings.collapseFormStr, for: .normal)
                genoTypeExpandFormBtn.setImage(UIImage(named:"collapseArrowiPad"), for: .normal)
                genoGenderAndBreedStackView.isHidden = false
                genoGenderHeaderView.isHidden = false
                genoBreedTypeHeaderView.isHidden = false
                genoPrimaryStackView.isHidden = false
                genoAnimalNameHeaderView.isHidden = false
                genoPrimaryHeaderView.isHidden = false
                genoSecAndTerStackView.isHidden = false
                genoSecondaryHeaderView.isHidden = false
                genoTeritiaryHeaderView.isHidden = false
                genoResetButtonBottomConstraint.constant = 41
                genoAddAnimalStackTopConstraint.constant = 350
                genotypeInnerViewHeight.constant = 1076
                
            }
        }
        else {
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
            
            if !UserDefaults.standard.bool(forKey: keyValue.expandView.rawValue) {
                nonGenoExpandOutlet.setTitle(LocalizedStrings.expandFormStr, for: .normal)
                nonGenoExpandOutlet.setImage(UIImage(named:"downiPad"), for: .normal)
                genstarblackBreedBtn.isHidden = true
                breedTypeHeaderView.isHidden = true
                nonGenoBreedTypeStackView.isHidden = true
                nonGenoGenderHeaderView.isHidden = true
                nonGenderDOBStackView.isHidden = true
                nonGenoAnimalNameHeaderView.isHidden = true
                resetButtonBottomConstraint.constant = 50
                nonGenoAddAnimalStackTopConstraint.constant = 40
                nonGenoInnerScrollViewHeight.constant = 777
                
                
            }
            else {
                nonGenoExpandOutlet.setTitle(LocalizedStrings.collapseFormStr, for: .normal)
                nonGenoExpandOutlet.setImage(UIImage(named:"collapseArrowiPad"), for: .normal)
                nonGenoGenderHeaderView.isHidden = false
                nonGenderDOBStackView.isHidden = false
                nonGenoAnimalNameHeaderView.isHidden = false
                resetButtonBottomConstraint.constant = 47
                nonGenoAddAnimalStackTopConstraint.constant = 250
                nonGenoInnerScrollViewHeight.constant = 977
                
                if isGenostarblackOnlyAdded
                {
                    genstarblackBreedBtn.isHidden = false
                    breedTypeHeaderView.isHidden = false
                    nonGenoBreedTypeStackView.isHidden = false
                }
                else
                {
                    genstarblackBreedBtn.isHidden = true
                    breedTypeHeaderView.isHidden = true
                    nonGenoBreedTypeStackView.isHidden = true
                }
            }
        }
        otherBorderColor()
        genotypeSetBorder()
        autoD = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        timeStampString = timeStamp()
        UserDefaults.standard.set(timeStampString, forKey: keyValue.timeStamp.rawValue)
        timeStampString = UserDefaults.standard.value(forKey: keyValue.timeStamp.rawValue) as? String ?? ""
        if !UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncrementalClear.rawValue) {
            self.isBarcodeAutoIncrementedEnabled = false
            
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
            if !changeColorToRed {
                self.genotypeScanBarcodeTextField.becomeFirstResponder()
                self.genotypeScanBarcodeTextField.backgroundColor = .white
            }
            
        } else {
            if !changeColorToRed {
                self.scanBarcodeTextfield.becomeFirstResponder()
                self.scanBarcodeTextfield.backgroundColor = .white
            }
            
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
            self.maleFemaleBttn.setTitle("Female", for: .normal)
            genderToggleFlag = 0
            UserDefaults.standard.set("F", forKey: "DENonGenoGender")
            genderString = "Female"
        } else {
            self.maleFemaleBttn.setTitle("Male", for: .normal)
            genderToggleFlag = 1
            UserDefaults.standard.set("M", forKey: "DENonGenoGender")
            genderString = "Male"
        }
        
        if UserDefaults.standard.value(forKey: "DEGenoGender") as? String == "F" ||  UserDefaults.standard.value(forKey: "DEGenoGender") as? String == nil {
            self.genotypeMaleFemaleBttn.setTitle("Female", for: .normal)
            genderToggleFlag = 0
            UserDefaults.standard.set("F", forKey: "DEGenoGender")
            genderString = "Female"
        } else {
            self.genotypeMaleFemaleBttn.setTitle("Male", for: .normal)
            genderToggleFlag = 1
            UserDefaults.standard.set("M", forKey: "DEGenoGender")
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
            if !smallDate {
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
            if animalIdBool  {
                animalFetch = fetchAllDataWithAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId: animalId, customerID: custmerId!)
                let data = animalFetch.object(at: 0) as! DataEntryBeefAnimaladdTbl
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                animalId1 = Int(data.animalId)
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
                    dobLbl.text = ""
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
                    self.maleFemaleBttn.setTitle("Male", for: .normal)
                    genderToggleFlag = 1
                    genderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
                    UserDefaults.standard.set("M", forKey: "DENonGenoGender")
                }
                else {
                    self.maleFemaleBttn.setTitle("Female", for: .normal)
                    genderToggleFlag = 0
                    genderString = ButtonTitles.femaleText.localized
                    UserDefaults.standard.set("F", forKey: "DENonGenoGender")
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
                    
                    dateBttnOutlet.titleLabel?.text = ""
                    let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
                    let formatter = DateFormatter()
                    if data.date != ""{
                        dobLbl.text = ""
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
                        self.maleFemaleBttn.setTitle("Male", for: .normal)
                        genderToggleFlag = 1
                        genderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
                        UserDefaults.standard.set("M", forKey: "DENonGenoGender")
                    }
                    else {
                        self.maleFemaleBttn.setTitle("Female", for: .normal)
                        genderToggleFlag = 0
                        genderString = ButtonTitles.femaleText.localized
                        UserDefaults.standard.set("F", forKey: "DENonGenoGender")
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
            if animalIdBool  {
                animalFetch = fetchAllDataWithAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId: animalId, customerID: custmerId!)
                let data = animalFetch.object(at: 0) as! DataEntryBeefAnimaladdTbl
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                animalId1 = Int(data.animalId)
                genotypeDOBBttn.titleLabel?.text = ""
                
                let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
                let formatter = DateFormatter()
                if data.date != "" {
                    dateOfLbl.text = ""
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
                    self.genotypeMaleFemaleBttn.setTitle("Male", for: .normal)
                    genderToggleFlag = 1
                    genderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
                    UserDefaults.standard.set("M", forKey: "DEGenoGender")
                }
                else {
                    self.maleFemaleBttn.setTitle("Female", for: .normal)
                    genderToggleFlag = 0
                    genderString = ButtonTitles.femaleText.localized
                    UserDefaults.standard.set("F", forKey: "DENonGenoGender")
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
                        dateOfLbl.text = ""
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
                        self.genotypeMaleFemaleBttn.setTitle("Male", for: .normal)
                        genderToggleFlag = 1
                        genderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
                        UserDefaults.standard.set("M", forKey: "DEGenoGender")
                    }
                    else {
                        self.maleFemaleBttn.setTitle("Female", for: .normal)
                        genderToggleFlag = 0
                        genderString = ButtonTitles.femaleText.localized
                        UserDefaults.standard.set("F", forKey: "DENonGenoGender")
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
     // removed the code for ipad
    }
    
    func othersByDefaultBackroundWhite(isBeginEditing: Bool = false){
        nonGenoExpandOutlet.alpha = 1
        nonGenoExpandOutlet.isEnabled = true
        genoTypeExpandFormBtn.alpha = 1
        genoTypeExpandFormBtn.isEnabled = true
        scanBarcodeTextfield.layer.backgroundColor = UIColor.white.cgColor
        serieTextfield.backgroundColor = .white
        maleFemaleBttn.backgroundColor = UIColor.white
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
        genotypeMaleFemaleBttn.setTitleColor(.black, for: .normal)
        dateBttnOutlet.setTitleColor(.black, for: .normal)
        incrementalBarcodeTitleLabel.textColor = UIColor.black
        incrementalBarcodeButton.isEnabled = true
        dateTextField.isEnabled = true
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) && !isBeginEditing {
            if let lastSavedBarCode = UserDefaults.standard.value(forKey: keyValue.barcodeIncremental.rawValue) as? String {
                scanBarcodeTextfield.text = isBarcodeEndingWithNumberAndGetIncremented(lastSavedBarCode).incrementedBarCode
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
        if UserDefaults.standard.value(forKey: "DENonGenoGender") as? String == "F" ||
            UserDefaults.standard.value(forKey: "DENonGenoGender") as? String == nil {
            self.maleFemaleBttn.setTitle("Female", for: .normal)
            genderToggleFlag = 0
            genderString = ButtonTitles.femaleText.localized
            UserDefaults.standard.set("F", forKey: "DENonGenoGender")
        } else {
            self.maleFemaleBttn.setTitle("Male", for: .normal)
            genderToggleFlag = 0
            genderString = ButtonTitles.maleText.localized
            UserDefaults.standard.set("M", forKey: "DENonGenoGender")
        }
        
        if isGenotypeOnlyAdded {
            if !changeColorToRed {
                self.genotypeScanBarcodeTextField.becomeFirstResponder()
                self.genotypeScanBarcodeTextField.backgroundColor = .white
            }
            
        } else {
            if !changeColorToRed {
                self.scanBarcodeTextfield.becomeFirstResponder()
                self.scanBarcodeTextfield.backgroundColor = .white
            }
            
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
        if isGenotypeOnlyAdded {
            
            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                
                genotypeDateTextField.isHidden = false
                dateOfLbl.isHidden = true
            } else {
                genotypeDateTextField.isHidden = true
                dateOfLbl.isHidden = false
            }
        } else {
            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                dateTextField.isHidden = false
                dobLbl.isHidden = true
            } else {
                dateTextField.isHidden = true
                dobLbl.isHidden = false
            }
        }
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
        if UserDefaults.standard.value(forKey: "DENonGenoGender") as? String == "F" ||
            UserDefaults.standard.value(forKey: "DENonGenoGender") as? String == nil {
            self.maleFemaleBttn.setTitle("Female", for: .normal)
            genderToggleFlag = 0
            genderString = ButtonTitles.femaleText.localized
            UserDefaults.standard.set("F", forKey: "DENonGenoGender")
        } else {
            self.maleFemaleBttn.setTitle("Male", for: .normal)
            genderToggleFlag = 0
            genderString = ButtonTitles.maleText.localized
            UserDefaults.standard.set("M", forKey: "DENonGenoGender")
        }
       
        self.scrolView.contentOffset.y = 0.0
        incrementalBarcodeTitleLabel.textColor = .gray
        incrementalBarcodeButton.isEnabled = false
        if isGenotypeOnlyAdded {
            if !changeColorToRed {
                self.genotypeScanBarcodeTextField.becomeFirstResponder()
                self.genotypeScanBarcodeTextField.backgroundColor = .white
            }
            
        } else {
            if !changeColorToRed {
                self.scanBarcodeTextfield.becomeFirstResponder()
                self.scanBarcodeTextfield.backgroundColor = .white
            }
            
        }
    }
    
    func OtherbyTextfieldGray(){
        nonGenoExpandOutlet.alpha = 0.4
        nonGenoExpandOutlet.isEnabled = true
        genoTypeExpandFormBtn.alpha = 0.4
        genoTypeExpandFormBtn.isEnabled = true
        
        serieTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        rGNTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        rGDTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        animalTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        dateBttnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        dobView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        tissueBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genstarblackBreedBtn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        maleFemaleBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
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
        maleFemaleBttn.setTitleColor(.gray, for: .normal)
        dateBttnOutlet.setTitleColor(.gray, for: .normal)
        genstarblackBreedBtn.setTitleColor(.gray, for: .normal)
        dateTextField.isEnabled = false
        dateTextField.text = ""
    }
    
    func validation(){
        
        if  rGDTextfield.text == ""{
            requiredflag = 0
            rGDTextfield.layer.borderColor = UIColor.red.cgColor
            nonGenoRGDView.layer.borderColor = UIColor.red.cgColor
        }
        if requiredflag == 1{
            serieTextfield.layer.borderColor = UIColor.gray.cgColor
            rGNTextfield.layer.borderColor = UIColor.gray.cgColor
            rGDTextfield.layer.borderColor = UIColor.gray.cgColor
        }
        else{
            rGDTextfield.layer.borderColor = UIColor.red.cgColor
            nonGenoRGDView.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    func tableViewpop() {
        buttonbg2.frame = CGRect(x:0,y: 0,width: self.view.frame.width,height: self.view.frame.height)
        buttonbg2.addTarget(self, action:#selector(DEBrazilBeefVCIpad.buttonPreddDroper), for: .touchUpInside)
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
            GenoSeriesView.layer.borderColor = UIColor.red.cgColor
            GenoRGNView.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    func landIdApplangaugeConversion(){
        animalTextfield.placeholder = NSLocalizedString(ButtonTitles.enterAnimalName, comment: "")
        dobLbl.text = ButtonTitles.selectdateText.localized
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
        genotypeScanBarcodeTextField.placeholder = NSLocalizedString(ButtonTitles.enterSampleBarcode, comment: "")
        genotypeSerieTextfield.placeholder = NSLocalizedString(LocalizedStrings.seriesText, comment: "")
        genotypeRgnTextfield.placeholder = NSLocalizedString(LocalizedStrings.RGNText, comment: "")
        genotypeAnimalNameTextfield.placeholder = NSLocalizedString(ButtonTitles.enterAnimalName, comment: "")
        genotypeRgdTextfield.placeholder = NSLocalizedString(LocalizedStrings.RGDorAnimalIDText, comment: "")
        priorityBreeingBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectPrimaryBreed, comment: ""),for: .normal)
        secondaryBreddingOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectSecondaryBreed, comment: ""),for: .normal)
        territoryBreddingOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectTertiaryBreed, comment: ""),for: .normal)
        dateOfLbl.text = NSLocalizedString(ButtonTitles.selectdateText, comment: "")
        //BELOW CODE IS COMMENTED FOR FUTURE CHANGES
        
        //      appStatusTitleLbl.text = NSLocalizedString(ButtonTitles.appStatusText, comment: "")
        //  nonGenoReviewTtilt.setTitle(NSLocalizedString(ButtonTitles.reviewDataText, comment: ""), for: .normal)
        //    addAnpthertITLE.setTitle(NSLocalizedString(ButtonTitles.addAnotherAnimalText, comment: ""), for: .normal)
        //  reviewBtnTitle.setTitle(NSLocalizedString(ButtonTitles.reviewDataText, comment: ""), for: .normal)
        //     addAnotherBtnTtile.setTitle(NSLocalizedString(ButtonTitles.addAnotherAnimalText, comment: ""), for: .normal)
        //    bckBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.backBtnText, comment: ""), for: .normal)
        //    nonGenoBckBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.backBtnText, comment: ""), for: .normal)
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
                dobLbl.text = ""
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
                    }
                    else {
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
                    }
                    else {
                        dateBttnOutlet.setTitle(dateVale, for: .normal)
                    }
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
                self.maleFemaleBttn.setTitle("Male", for: .normal)
                genderToggleFlag = 1
                genderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
                UserDefaults.standard.set("M", forKey: "DENonGenoGender")
                
            }
            else {
                self.maleFemaleBttn.setTitle("Female", for: .normal)
                genderToggleFlag = 0
                genderString = ButtonTitles.femaleText.localized
                UserDefaults.standard.set("F", forKey: "DENonGenoGender")
                
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
                nonGenoSeriesView.layer.borderColor = UIColor.red.cgColor
                nonGenoRGNView.layer.borderColor = UIColor.red.cgColor
                nonGenoRGDView.layer.borderColor = UIColor.red.cgColor
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
                
                self.genotypeMaleFemaleBttn.setTitle("Male", for: .normal)
                genderToggleFlag = 1
                genderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
                UserDefaults.standard.set("M", forKey: "DEGenoGender")
                
            }
            else {
                self.maleFemaleBttn.setTitle("Female", for: .normal)
                genderToggleFlag = 0
                genderString = ButtonTitles.femaleText.localized
                UserDefaults.standard.set("F", forKey: "DENonGenoGender")
                
            }
            tissuId = Int(data.tissuId)
            genotypeDOBBttn.setTitleColor(.black, for: .normal)
            statusOrder = false
            messageCheck = false
            let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
            if adata.count > 0{
                let animal  = adata.object(at: 0) as! BeefAnimalMaster
                idAnimal = Int(animal.animalId)
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
                if isautoPopulated {
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
                GenoSeriesView.layer.borderColor = UIColor.red.cgColor
                GenoRGNView.layer.borderColor = UIColor.red.cgColor
                GenoRGDView.layer.borderColor = UIColor.red.cgColor
            }
        }
    }
    
    func addAnimalBtn(completionHandler: @escaping CompletionHandler){
        if breedId == ""
        {
            let breed = self.breedArrblack[0] as! GetBreedsTbl
            breedId = breed.breedId ?? ""
        }
        
        if barcodeEnable  {
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
                        nonGenoSeriesView.layer.borderColor = UIColor.red.cgColor
                        nonGenoRGNView.layer.borderColor = UIColor.red.cgColor
                        
                    } else{
                        serieTextfield.layer.borderColor = UIColor.gray.cgColor
                        rGNTextfield.layer.borderColor = UIColor.red.cgColor
                        nonGenoRGNView.layer.borderColor = UIColor.red.cgColor
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
                        nonGenoRGDView.layer.borderColor = UIColor.red.cgColor
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
                }
                else{
                    requiredflag = 1
                }
                if requiredflag == 0 {
                    if genotypeSerieTextfield.text == "" || genotypeRgnTextfield.text == "" {
                        if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" {
                            genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                            genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                            GenoSeriesView.layer.borderColor = UIColor.red.cgColor
                            GenoRGNView.layer.borderColor = UIColor.red.cgColor
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                            completionHandler(false)
                            return
                        }
                        
                        if genotypeSerieTextfield.text == "" {
                            genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                            GenoSeriesView.layer.borderColor = UIColor.red.cgColor
                            genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                            completionHandler(false)
                            return
                        }
                        
                        if genotypeRgnTextfield.text == ""{
                            genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                            genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                            GenoRGNView.layer.borderColor = UIColor.red.cgColor
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                            completionHandler(false)
                            return
                        }
                    }
                    
                    if priorityBreeingBtnOutlet.titleLabel?.text! == ButtonTitles.ciadeMelhoramentoText {
                        genotypeAddBtnCondtion(completionHandler: { (success) -> Void in
                            if success {
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
            self.cartView.isHidden = false
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
        
        if UserDefaults.standard.value(forKey: "DENonGenoGender") as? String == "F" || UserDefaults.standard.value(forKey: "DENonGenoGender") == nil {
            self.maleFemaleBttn.setTitle("Female", for: .normal)
            genderToggleFlag = 0
            genderString = ButtonTitles.femaleText.localized
            UserDefaults.standard.set("F", forKey: "DENonGenoGender")
        } else {
            self.maleFemaleBttn.setTitle("Male", for: .normal)
            genderToggleFlag = 1
            genderString = ButtonTitles.maleText.localized
            UserDefaults.standard.set("M", forKey: "DENonGenoGender")
        }
        
        
        if checkBarcode  {
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
        if  barcodeflag  && scanBarcodeTextfield.text != "" {
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
                if  msgUpatedd {
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
            updateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalMasterTblEntity, animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName:genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
            
            updateOrderStatusISyncAnimalMaster(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "true", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: genstarblackBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true,territoryGeno: "")
            
            if identify1  {
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
                if  msgUpatedd {
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
            
            msgShow()
            if isBarcodeAutoIncrementedEnabled  {
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
            }
            else {
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
            }
            
            UserDefaults.standard.set(tissueBttn.titleLabel?.text, forKey: keyValue.dataEntrytissueBttnClear.rawValue)
            UserDefaults.standard.set(tissueBttn.titleLabel?.text, forKey: keyValue.dataEntrytissueBttn.rawValue)
            byDefaultSetting()
            resetAllField()
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
        
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue)  {
            UserDefaults.standard.set(incrementalBarCode, forKey: keyValue.barcodeIncremental.rawValue)
        }
        incrementalBarCode = ""
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue)  {
            if let lastSavedBarCode = UserDefaults.standard.value(forKey: keyValue.barcodeIncremental.rawValue) as? String {
                scanBarcodeTextfield.text = isBarcodeEndingWithNumberAndGetIncremented(lastSavedBarCode).incrementedBarCode
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
        if !self.msgAnimalSucess {
            if self.addContiuneBtn == 1 {
                if self.msgcheckk  {
                    self.view.makeToast(NSLocalizedString(AlertMessagesStrings.animalRecordUpdatedAdded, comment: ""), duration: 1, position: .bottom)
                }
                else {
                    if self.isautoPopulated  {
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAddedSuccessfully, comment: ""), duration: 1, position: .bottom)
                    } else {
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAdded, comment: ""), duration: 1, position: .bottom)
                    }
                }
            }
            else if self.addContiuneBtn == 2{
                if self.msgcheckk  {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalRecordUpdatedAdded, comment: ""))
                }
                else{
                    if self.isautoPopulated  {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAddedSuccessfully, comment: ""))
                    }
                    else {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAdded, comment: ""))
                    }
                }
            }
            else {
                if self.msgcheckk  {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalRecordUpdatedAdded, comment: ""))
                }
                else{
                    if self.isautoPopulated  {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAddedSuccessfully, comment: ""))
                        
                    } else {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAdded, comment: ""))
                    }
                }
            }
            self.msgAnimalSucess = false
        }
        else {
            if self.msgcheckk  {
                self.view.makeToast(NSLocalizedString(AlertMessagesStrings.animalRecordUpdatedAdded, comment: ""), duration: 1, position: .bottom)
            }
            else{
                if self.isautoPopulated  {
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
    
    func continueproduct(){
        let storyboard = UIStoryboard(name: "DataEntryBeefiPad", bundle: Bundle.main)
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
                            nonGenoRGDView.layer.borderColor = UIColor.red.cgColor
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                            return
                        }
                    }
                    if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil {
                        if UserDefaults.standard.value(forKey: keyValue.onKey.rawValue) as? String == "off"{
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                            saveBreedSociety()
                        }
                        else {
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                            saveBreedSociety()
                        }
                    }
                    else {
                        if  UserDefaults.standard.value(forKey: keyValue.page.rawValue) == nil {
                            if UserDefaults.standard.value(forKey: keyValue.onKey.rawValue) as? String == "off"{
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                                saveBreedSociety()
                            }
                            else {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                                saveBreedSociety()
                            }
                        }
                        else{
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                            saveBreedSociety()
                        }
                    }
                } else {
                    
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        if success {
                            let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                            if  identyCheck == true {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                                self.saveBreedSociety()
                            }
                            else {
                                if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil{
                                    
                                    if UserDefaults.standard.value(forKey: keyValue.onKey.rawValue) as? String == "off"{
                                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                                        self.saveBreedSociety()
                                    }
                                    else {
                                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                                        self.saveBreedSociety()
                                    }
                                }
                                else {
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
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
                        if success {
                            if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil{
                                if UserDefaults.standard.value(forKey: keyValue.onKey.rawValue) as? String == "off"{
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                                    self.saveBreedSociety()
                                }
                                else {
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                                    self.saveBreedSociety()
                                }
                            }
                            else {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
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
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                        self.saveBreedSociety()
                    }
                    else {
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                        self.saveBreedSociety()
                    }
                }
                else{
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        if success {
                            let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                            if  identyCheck == true {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                                self.saveBreedSociety()
                            }
                            else {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                                self.saveBreedSociety()
                            }
                        }
                    })
                }
            }
            
            else{
                addAnimalBtn(completionHandler: { (success) -> Void in
                    if success {
                        let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                        if  identyCheck == true {
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                            self.saveBreedSociety()
                        }
                        else {
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
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
    
    func changeViewColorToBlack(view : [UIView], color : CGColor) {
        for value in view {
            value.layer.borderColor = color
        }
        if changeColorToRed == true {
            
            if rGDTextfield.text == "" {
                nonGenoRGDView.layer.borderColor = UIColor.red.cgColor
            }
            
            if genotypeSerieTextfield.text == "" {
                GenoSeriesView.layer.borderColor = UIColor.red.cgColor
            }
            if genotypeRgnTextfield.text == "" {
                GenoRGNView.layer.borderColor = UIColor.red.cgColor
            }
            
            if genotypeScanBarcodeTextField.text == "" {
                genotypeScanBarcodeView.layer.borderColor = UIColor.red.cgColor
            }
            
            
        }
    }
    
    //MARK: SIDE MENU UI METHODS
    func setSideMenu(){
        if UIDevice.current.orientation.isLandscape {
            self.sideMenuRevealWidth = 300
        }
        else {
            self.sideMenuRevealWidth = 260
            
        }
        
        
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewVC = storyboard.instantiateViewController(withIdentifier: "SideMenuVC") as? SideMenuVC
        view.insertSubview(self.sideMenuViewVC!.view, at: self.revealSideMenuOnTop ? 1 : 0)
        addChild(self.sideMenuViewVC!)
        self.sideMenuViewVC!.didMove(toParent: self)
        self.sideMenuViewVC.view.backgroundColor = UIColor.white
   
        self.sideMenuViewVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        if self.revealSideMenuOnTop {
            self.sideMenuTrailingConstraint = self.sideMenuViewVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -self.sideMenuRevealWidth - self.paddingForRotation)
            self.sideMenuTrailingConstraint.isActive = true
        }
        NSLayoutConstraint.activate([
            self.sideMenuViewVC.view.widthAnchor.constraint(equalToConstant: self.sideMenuRevealWidth),
            self.sideMenuViewVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.sideMenuViewVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            self.sideMenuViewVC.searchpointImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 42.0)
        ])
    }
    
    func animateShadow(targetPosition: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            self.sideMenuShadowView.alpha = (targetPosition == 0) ? 0.6 : 0.0
        }
    }
    @IBAction func menuBtnClk(_ sender: UIButton) {
        self.sideMenuRevealSettingsViewController()?.revealSideMenu()
        
    }
    @IBAction open func revealSideMenu() {
        self.sideMenuState(expanded: self.isExpanded ? false : true)
    }
    
    func sideMenuState(expanded: Bool) {
        if expanded {
            if UIDevice.current.orientation.isLandscape {
                self.menuIconLeadingConstraint.constant = 320
                print("Landscape")
            } else {
                self.menuIconLeadingConstraint.constant = 270
                print("Portrait")
            }
            
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? 0 : self.sideMenuRevealWidth) { _ in
                self.isExpanded = true
                
            }
         
        }
        else {
            self.menuIconLeadingConstraint.constant = 30
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? (-self.sideMenuRevealWidth - self.paddingForRotation) : 0) { _ in
                self.isExpanded = false
                
            }
          
        }
    }
    
    func animateSideMenu(targetPosition: CGFloat, completion: @escaping (Bool) -> ()) {
        self.view.bringSubviewToFront(self.sideMenuViewVC.view)
        self.sideMenuViewVC.tblView.reloadData()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .layoutSubviews, animations: {
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = targetPosition
                self.view.layoutIfNeeded()
            }
            else {
                self.view.subviews[1].frame.origin.x = targetPosition
            }
        }, completion: completion)
    }
    
    func sideMenuRevealSettingsViewController() -> DEBrazilBeefVCIpad? {
        var viewController: UIViewController? = self
        
        if viewController != nil && viewController is DEBrazilBeefVCIpad {
            return viewController! as? DEBrazilBeefVCIpad
        }
        while (!(viewController is DEBrazilBeefVCIpad) && viewController?.parent != nil) {
            viewController = viewController?.parent
        }
        if viewController is DEBrazilBeefVCIpad {
            return viewController as? DEBrazilBeefVCIpad
        }
        return nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
     
        if touch?.view != self.sideMenuViewVC {
            sideMenuState(expanded: false)
        }
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
            keyBoardOptionsViewBottomConstrains.constant = keyboardHeight-64
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
     
    }
    
    
    @objc func methodOfReceivedNotification(notification: Notification)
    {
        UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
        let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
        self.hideIndicator()
        
    }
    
    @objc func buttonPreddDroper() {
        buttonbg2.removeFromSuperview()
        
        self.nonGenoGenderView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
        self.nonGenoSampleTypeView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
        self.nonGenoBreedTypeView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
        
        self.GenoGenderView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
        self.GenoSampleTypeView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
        self.GenoBreedTypeView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
        self.setShadowForUIView(view: nonGenoGenderView, removeShadow: true)
        self.setShadowForUIView(view: nonGenoSampleTypeView, removeShadow: true)
        self.setShadowForUIView(view: nonGenoBreedTypeView, removeShadow: true)
        self.setShadowForUIView(view: GenoGenderView, removeShadow: true)
        self.setShadowForUIView(view: GenoSampleTypeView, removeShadow: true)
        self.setShadowForUIView(view: GenoBreedTypeView, removeShadow: true)
        self.setShadowForUIView(view: genoPrimaryBreedView, removeShadow: true)
        self.setShadowForUIView(view: genoSecondaryBreedView, removeShadow: true)
        self.setShadowForUIView(view: genoTeritiaryBreedView, removeShadow: true)
        
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
        dobLbl.isHidden = true
        dateOfLbl.isHidden = true
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
        dobLbl.isHidden = true
        dateOfLbl.isHidden = true
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
