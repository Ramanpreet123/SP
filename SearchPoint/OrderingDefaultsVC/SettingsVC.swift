//
//  SettingsVC.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 08/01/25.
//

import Foundation
import UIKit
import Alamofire
import Gigya
import GigyaTfa
import GigyaAuth

class SettingsVC : UIViewController {
    
    //MARK: IB OUTLETS
    @IBOutlet weak var calendarViewBkg: UIView!
    @IBOutlet weak var productGroupingView: UIView!
    @IBOutlet weak var evaluationProviderView: UIView!
    @IBOutlet weak var ocrViewShow: UIView!
    @IBOutlet weak var ocrBackroundBtnOutlet: UIButton!
    @IBOutlet weak var keyboardTitleView: UIView!
    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var productDoneClick: UIButton!
    @IBOutlet weak var productTblView: UITableView!
    @IBOutlet weak var billingView: UIView!
    @IBOutlet weak var scannerStackView: UIStackView!
    @IBOutlet weak var continueOrderBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var primarlyBasedStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var primarlybasedStackView: UIStackView!
    @IBOutlet weak var networkStatusImg: UIImageView!
    @IBOutlet weak var NetworkStatusLbl: UILabel!
    @IBOutlet weak var offLineBtn: UIButton!
    @IBOutlet weak var ocrInfoBtnOutle: UIButton!
    @IBOutlet weak var primaryBasedOutlet: UIButton!
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var dateBtnOutlet: UIButton!
    @IBOutlet weak var date1BtnOutlet: UIButton!
    @IBOutlet weak var speciesCollectionView: UICollectionView!
    @IBOutlet weak var evalutionProviderCV: UICollectionView!
    @IBOutlet weak var holsteinBtnOutlet: UIButton!
    @IBOutlet weak var zoetisBtnOutlet: UIButton!
    @IBOutlet weak var nominatorView: UIView!
    @IBOutlet weak var farmIdBttn: UIButton!
    @IBOutlet weak var rfidBttn: UIButton!
    @IBOutlet weak var primarlyBasedView: UIView!
    @IBOutlet weak var ocrBtnOutlet: UIButton!
    @IBOutlet weak var rfidBtnOutlet: UIButton!
    @IBOutlet weak var scannerViewShow: UIView!
    @IBOutlet weak var selectScannerTitleView: UIView!
    @IBOutlet weak var numericKeyBoardBtnOutle: UIButton!
    @IBOutlet weak var alphaNumericbtnOutler: UIButton!
    @IBOutlet weak var keyBoardTitleView: UIView!
    @IBOutlet weak var keyBaordFullView: UIView!
    @IBOutlet weak var btn_KeyboardInfo: UIButton!
    @IBOutlet weak var defaultModeEntryBtn: UIButton!
    @IBOutlet weak var biometricOnOutlet: UIButton!
    @IBOutlet weak var biometricOffOutlet: UIButton!
    @IBOutlet weak var menuIconLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var continueOrderBtn: UIButton!
    @IBOutlet weak var dairyBtnOutlet: UIButton!
    @IBOutlet weak var alphanumericOutlet: UIButton!
    @IBOutlet weak var rfidBtn: UIButton!
    @IBOutlet weak var farmidBtn: UIButton!
    @IBOutlet weak var persistenceOnBtn: UIButton!
    @IBOutlet weak var persistenceOffBtn: UIButton!
    @IBOutlet weak var datepickerEntryBtn: UIButton!
    @IBOutlet weak var marketTipYopOutlet: UIButton!
    @IBOutlet weak var marketView: UIView!
    @IBOutlet weak var providerTitleLbl: UILabel!
    @IBOutlet weak var menuBttn: UIButton!
    @IBOutlet weak var continueOrderBttn: UIButton!
    
    //MARK: VARIABLES AND CONSTANTS
    var evaluationProvider = String()
    var value = 0
    var ScreenDef = String()
    var sideMenuViewVC: SideMenuVC!
    var sideMenuShadowView: UIView!
    var sideMenuRevealWidth: CGFloat = 300
    let paddingForRotation: CGFloat = 150
    var isExpanded: Bool = false
    var draggingIsEnabled: Bool = false
    var panBaseLocation: CGFloat = 0.0
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var revealSideMenuOnTop: Bool = true
    var gestureEnabled: Bool = true
    let gigya =  Gigya.sharedInstance(GigyaAccount.self)
    let userId = UserDefaults.standard.integer(forKey: "userId")
    let custId = UserDefaults.standard.integer(forKey: "currentActiveCustomerId")
    var isGenotypeOnlyAdded = false
    var isGenostarblackOnlyAdded = false
    var specname = String()
    var orderSlideTag : Int?
    var sampleArr = NSMutableArray()
    var breedArr  = NSMutableArray()
    var providerVM: GetProviderViewModel?
    var breedVM: GetBreedViewModel?
    var speciesVM: GetSpeciesViewModel?
    var marketVM :GetMarketsViewModel?
    var productVM :GetProductsViewModel?
    var nominatorsVM :GetNominatorsViewModel?
    var speciesArray = [GetSpeciesTbl]()
    var providerId = Int()
    var byDefaultProvider = "CLARIFIDE CDCB (US)"
    var productArr = NSArray()
    var productSelected  =  [GetProductTbl]()
    var switchFromDairy = Bool()
    var brazilProduct = [String]()
    var productPopupFlag = 0
    var imageArray = ["tag_1","tag_3"]
    var productName = String()
    var didselectTouched = false
    var dataModel:LoginModel?
    let dateFormatter = DateFormatter()
    let locale = NSLocale.current
    var datePicker : UIDatePicker!
    let toolBar = UIToolbar()
    var isSelectedArray = [Bool]()
    var editflag :Int?
    var langId = UserDefaults.standard.value(forKey: "lngId") as! Int
    var inheritInfoButtonFrame = CGFloat.zero
    var customerOrderSetting = CustomerOrderSetting()
    var speiecCountCheck = NSArray()
    var provideCountCheck = [GetProviderTbl]()
    var getListProvider  = [GetProviderTbl]()
    var customerProviders = [GetProviderTbl]()
    var customerMarkets = [CustomerMarkets]()
    let buttonbg1 = UIButton ()
    var customPopView1 :TipPopUp!
    var fetchDataEntry : [DataEntryList] = []
    var listName = String()
    let orderingDatalistVM = OrderingDataListViewModel()
    let pvidDairy = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    var auProviderArray = [GetProviderTbl]()
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSideMenu()
        continueOrderBttn.layer.cornerRadius = 30.0
        //        self.dateBtnOutlet.backgroundColor = UIColor(red: 255/255, green: 92/255, blue: 2/255, alpha: 1.0)
        //        self.dateBtnOutlet.layer.borderColor = UIColor.clear.cgColor
        //        self.alphanumericOutlet.layer.borderColor = UIColor.clear.cgColor
        //        self.rfidBtn.layer.borderColor = UIColor.clear.cgColor
        //        self.farmidBtn.layer.borderColor = UIColor.clear.cgColor
        //        self.persistenceOnBtn.layer.borderColor = UIColor.clear.cgColor
        //        self.datepickerEntryBtn.layer.borderColor = UIColor.clear.cgColor
        //        dateBtnOutlet.titleLabel?.textColor = UIColor.white
        //        self.dairyBtnOutlet.backgroundColor = UIColor(red: 255/255, green: 92/255, blue: 2/255, alpha: 1.0)
        //        dairyBtnOutlet.titleLabel?.textColor = UIColor.white
        //        self.alphanumericOutlet.backgroundColor = UIColor(red: 255/255, green: 92/255, blue: 2/255, alpha: 1.0)
        //        alphanumericOutlet.titleLabel?.textColor = UIColor.white
        //        self.rfidBtn.backgroundColor = UIColor(red: 255/255, green: 92/255, blue: 2/255, alpha: 1.0)
        //        rfidBtn.titleLabel?.textColor = UIColor.white
        //        self.farmidBtn.backgroundColor = UIColor(red: 255/255, green: 92/255, blue: 2/255, alpha: 1.0)
        //        farmidBtn.titleLabel?.textColor = UIColor.white
        //        self.persistenceOnBtn.backgroundColor = UIColor(red: 255/255, green: 92/255, blue: 2/255, alpha: 1.0)
        //        persistenceOnBtn.titleLabel?.textColor = UIColor.white
        //        self.datepickerEntryBtn.backgroundColor = UIColor(red: 255/255, green: 92/255, blue: 2/255, alpha: 1.0)
        //        datepickerEntryBtn.titleLabel?.textColor = UIColor.white
        let bioMetricEnabled = UserDefaults.standard.value(forKey: "BioMetricEnabled") as? Bool
        if bioMetricEnabled == true {
            self.setButtonState(button: biometricOnOutlet, isOn: true)
            self.setButtonState(button: biometricOffOutlet, isOn: false)
        }
        else {
            self.setButtonState(button: biometricOffOutlet, isOn: true)
            self.setButtonState(button: biometricOnOutlet, isOn: false)
        }
        self.setUIOnDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        //location is relative to the current view
        // do something with the touched point
        if touch?.view != self.sideMenuViewVC {
            sideMenuState(expanded: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUIOnWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(Notification.Name("NotificationIdentifier"))
    }
    
    
    //MARK: UIMETHODS
    
    func setUIOnDidLoad(){
        if UIDevice().userInterfaceIdiom == .pad {
            productDoneClick.layer.cornerRadius = 30
            cancelBtn.layer.cornerRadius = 30
        }
        if(UserDefaults.standard.value(forKey: "scrollIsEnable") as? Bool ?? true){
            self.setButtonState(button: persistenceOnBtn, isOn: true)
            self.setButtonState(button: persistenceOffBtn, isOn: false)
        }
        else{
            self.setButtonState(button: persistenceOffBtn, isOn: true)
            self.setButtonState(button: persistenceOnBtn, isOn: false)
        }
        holsteinBtnOutlet.isHidden = true
        calendarViewBkg.isHidden = true
        ocrViewShow.isHidden = true
        ocrBackroundBtnOutlet.isHidden = true
        
        getMarketsForCurrentCustomer()
        UserDefaults.standard.set( 1, forKey: "SpeciesId")
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        let datevalue = UserDefaults.standard.value(forKey: "date") as? String
        if datevalue == "MM"{
            dateBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            date1BtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
            date1BtnOutlet.layer.borderWidth = 1
            dateBtnOutlet.layer.borderWidth = 2
            self.setButtonState(button: dateBtnOutlet, isOn: true)
            self.setButtonState(button: date1BtnOutlet, isOn: false)
        }
        else if datevalue == "DD" {
            self.setButtonState(button: date1BtnOutlet, isOn: true)
            self.setButtonState(button: dateBtnOutlet, isOn: false)
        } else {
            self.setButtonState(button: dateBtnOutlet, isOn: true)
            
        }
        
        self.speiecCountCheck = fetchSpeciesAllData(entityName: "GetSpeciesTbl")
        if UserDefaults.standard.value(forKey: "name") as? String == "CLARIFIDE CDCB (US)" {
            UserDefaults.standard.setValue("Dairy", forKey: "name")
        }
        
        if UserDefaults.standard.value(forKey: "name") as? String == "Dairy" ||  UserDefaults.standard.value(forKey: "name") as? String == nil  {
            self.provideCountCheck = fetchdataOfProvider(specisId: "074dc82b-2b82-4ee6-99c6-f9691937394d") as! [GetProviderTbl]
            getListProvider = providerEvaliuater(arr: provideCountCheck) as! [GetProviderTbl]
            // getListProvider
            if getListProvider.count == 0 {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("No associated evaluation provider found for this customer in the app.", comment: ""))
                marketTipYopOutlet.isHidden = true
                providerTitleLbl.isHidden = true
            } else {
                marketTipYopOutlet.isHidden = false
                providerTitleLbl.isHidden = false
            }
        }
        
        else if UserDefaults.standard.value(forKey: "name") as? String == "Beef" {
            
            self.provideCountCheck = fetchdataOfProvider(specisId: "151e2230-9a01-4828-a105-d87a92b5be2f") as! [GetProviderTbl]
            
            getListProvider = providerEvaliuater(arr: provideCountCheck) as! [GetProviderTbl]
            if getListProvider.count == 0 {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("No associated product found for this customer in the app.", comment: ""))
                marketTipYopOutlet.isHidden = true
                providerTitleLbl.isHidden = true
            } else {
                marketTipYopOutlet.isHidden = true
                providerTitleLbl.isHidden = false
            }
        }
        
        self.speciesCollectionView.delegate = self
        self.speciesCollectionView.dataSource = self
        self.speciesCollectionView.reloadData()
        self.evalutionProviderCV.delegate = self
        self.evalutionProviderCV.dataSource = self
        self.evalutionProviderCV.reloadData()
        
        if self.revealViewController() != nil {
            self.menuBttn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)), for: .touchUpInside);
            
            self.revealViewController()?.rightViewRevealWidth = 200;
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        let fetchSettingData = fetchAllOrderSetting(entityName: "OrderSettings", customerId: custId,userId:userId)
        
        if fetchSettingData.count == 0 {
            if UserDefaults.standard.string(forKey: "name") == "Dairy"{
                self.setButtonState(button: rfidBtnOutlet, isOn: true)
                self.setButtonState(button: ocrBtnOutlet, isOn: false)
            } else {
                self.setButtonState(button: ocrBtnOutlet, isOn: true)
                self.setButtonState(button: rfidBtnOutlet, isOn: false)
            }
            
            if pvidDairy == 2 {
                UserDefaults.standard.set("ocr", forKey: "scannerSelection")
                self.setButtonState(button: ocrBtnOutlet, isOn: true)
                self.setButtonState(button: rfidBtnOutlet, isOn: false)
            }
            
            else {
                UserDefaults.standard.set("rfid", forKey: "scannerSelection")
                self.setButtonState(button: rfidBtnOutlet, isOn: true)
                self.setButtonState(button: ocrBtnOutlet, isOn: false)
            }
            
            // Numeric Keyboard on farmID
            
            if pvidDairy == 3{
                self.setButtonState(button: numericKeyBoardBtnOutle, isOn: true)
                self.setButtonState(button: alphaNumericbtnOutler, isOn: false)
                UserDefaults.standard.set("Numeric", forKey: "keyboardSelection")
                
            } else {
                self.setButtonState(button: alphaNumericbtnOutler, isOn: true)
                self.setButtonState(button: numericKeyBoardBtnOutle, isOn: false)
                UserDefaults.standard.set("alphaNumeric", forKey: "keyboardSelection")
            }
            UserDefaults.standard.set("pickerMode", forKey: "defaultDatePicker")
            self.setButtonState(button: datepickerEntryBtn, isOn: true)
            self.setButtonState(button: defaultModeEntryBtn, isOn: false)
            
        } else {
            
            let fetchDat = fetchSettingData.object(at: 0) as? OrderSettings
            let fetchDat1 = fetchDat?.scannerSelection
            let beefScanner = fetchDat?.beefUSscannerSelection
            let keyboardSelection = fetchDat?.keyboardSelection
            let defaultDatePicker = fetchDat?.defaultDatePicker
            if fetchDat?.speciesName == "Dairy" && fetchDat?.providerName == "US Dairy Products"{
                UserDefaults.standard.set(fetchDat1, forKey: "scannerSelection")
                if fetchDat1 == "ocr"  {
                    self.setButtonState(button: ocrBtnOutlet, isOn: true)
                    self.setButtonState(button: rfidBtnOutlet, isOn: false)
                    UserDefaults.standard.set("ocr", forKey: "scannerSelection")
                }
                
                else {
                    self.setButtonState(button: rfidBtnOutlet, isOn: true)
                    self.setButtonState(button: ocrBtnOutlet, isOn: false)
                    UserDefaults.standard.set("rfid", forKey: "scannerSelection")
                }
                
            } else if (fetchDat?.speciesName == "Beef" && fetchDat?.providerName == "US Dairy Products") || (fetchDat?.speciesName == "Beef" && fetchDat?.providerName == "CLARIFIDE CDCB (US)")  {
                if beefScanner == "ocr" && fetchDat?.providerName == "US Dairy Products" {
                    self.setButtonState(button: ocrBtnOutlet, isOn: true)
                    self.setButtonState(button: rfidBtnOutlet, isOn: false)
                    UserDefaults.standard.set("ocr", forKey: "beefScannerSelection")
                } else {
                    self.setButtonState(button: rfidBtnOutlet, isOn: true)
                    self.setButtonState(button: ocrBtnOutlet, isOn: false)
                    UserDefaults.standard.set("rfid", forKey: "beefScannerSelection")
                }
            }
            
            else if pvidDairy == 2 {
                UserDefaults.standard.set("ocr", forKey: "scannerSelection")
                self.setButtonState(button: ocrBtnOutlet, isOn: true)
                self.setButtonState(button: rfidBtnOutlet, isOn: false)
                
            } else {
                UserDefaults.standard.set("rfid", forKey: "scannerSelection")
                self.setButtonState(button: rfidBtnOutlet, isOn: true)
                self.setButtonState(button: ocrBtnOutlet, isOn: false)
            }
            
            
            
            /// Date Picker Mode
            if defaultDatePicker == "defaultEntry" {
                UserDefaults.standard.set("defaultEntry", forKey: "defaultDatePicker")
                self.setButtonState(button: defaultModeEntryBtn, isOn: true)
                self.setButtonState(button: datepickerEntryBtn, isOn: false)
                
            } else {
                
                UserDefaults.standard.set("pickerMode", forKey: "defaultDatePicker")
                self.setButtonState(button: datepickerEntryBtn, isOn: true)
                self.setButtonState(button: defaultModeEntryBtn, isOn: false)
                
            }
            //////kEYBOARD SETTING SAVE
            
            
            if keyboardSelection == "alphaNumeric" {
                self.setButtonState(button: alphaNumericbtnOutler, isOn: true)
                self.setButtonState(button: numericKeyBoardBtnOutle, isOn: false)
                
                UserDefaults.standard.set("alphaNumeric", forKey: "keyboardSelection")
                
            } else if keyboardSelection == "Numeric" {
                
                self.setButtonState(button: numericKeyBoardBtnOutle, isOn: true)
                self.setButtonState(button: alphaNumericbtnOutler, isOn: false)
                UserDefaults.standard.set("Numeric", forKey: "keyboardSelection")
                
            } else {
                
                if pvidDairy == 3{
                    self.setButtonState(button: numericKeyBoardBtnOutle, isOn: true)
                    self.setButtonState(button: alphaNumericbtnOutler, isOn: false)
                    UserDefaults.standard.set("Numeric", forKey: "keyboardSelection")
                    
                } else {
                    self.setButtonState(button: alphaNumericbtnOutler, isOn: true)
                    self.setButtonState(button: numericKeyBoardBtnOutle, isOn: false)
                    UserDefaults.standard.set("alphaNumeric", forKey: "keyboardSelection")
                }
            }
        }
        
        if UIDevice().userInterfaceIdiom == .phone {
            //            idScannerTitle.text = "Select Scanner Type".localized
            //
            //            sampleTagsTitle.text = NSLocalizedString("Sample Tags", comment: "")
            //            keyboardTtile.text = NSLocalizedString("Select keyboard for On-Farm ID", comment: "")
            //
            //            rfidBtnOutlet.setTitle(NSLocalizedString("RFID Scanner", comment: ""), for: .normal)
            //
            //            alphaNumericbtnOutler.setTitle(NSLocalizedString("Alphanumeric", comment: ""), for: .normal)
            //            numericKeyBoardBtnOutle.setTitle(NSLocalizedString("Numeric", comment: ""), for: .normal)
            //            ocrBtnOutlet.setTitle(NSLocalizedString("Mobile camera (OCR)", comment: ""), for: .normal)
            //            dateOfBirthTile.text = NSLocalizedString("Date of Birth Input Mode", comment: "")
            //            datePickerLabel.text = NSLocalizedString("Date Picker", comment: "")
            //            manualEnteryLabel.text = NSLocalizedString("Manual Entry", comment: "")
            //            selctProductLbl.text = NSLocalizedString("Select Product(s)", comment: "")
            //            productDoneClick.setTitle(NSLocalizedString("Done", comment: ""), for: .normal)
        }
    }
    
    func setUIOnWillAppear(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        
        calendarViewBkg.isHidden = true
        productTblView.delegate = self
        productTblView.dataSource = self
        initialNetworkCheck()
        billingView.isHidden = true

        let providerName = UserDefaults.standard.value(forKey: "ProviderName") as? String
        if providerName == "CLARIFIDE AHDB (UK)"{
            var lastValue = UserDefaults.standard.value(forKey: "FOReviewOrderVC")
        }
        
        let screen  = UserDefaults.standard.value(forKey: "screen") as? String
        if screen == "farmid"{
            self.setButtonState(button: farmIdBttn, isOn: true)
            self.setButtonState(button: rfidBttn, isOn: false)
        }
        else if  screen == "officialid"{
            self.setButtonState(button: rfidBttn, isOn: true)
            self.setButtonState(button: farmIdBttn, isOn: false)
        }
        
        if UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == nil{
            UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
        }
        if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == nil{
            UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
        }
        if UserDefaults.standard.string(forKey: "FOSampleTrackingDetailVC") == nil || UserDefaults.standard.string(forKey: "FOSampleTrackingDetailVC") == ""{
            UserDefaults.standard.set("farmid", forKey: "FOSampleTrackingDetailVC")
        }
        if UserDefaults.standard.string(forKey: "FOReviewOrderVC") == nil || UserDefaults.standard.string(forKey: "FOReviewOrderVC") == ""{
            UserDefaults.standard.set("farmid", forKey: "FOReviewOrderVC")
        }
        let tag = UserDefaults.standard.integer(forKey: "orderSlideTag")
        if tag == 1{
            
        } else {
            let settingDefault = UserDefaults.standard.value(forKey: "settingDefault") as? String
            
            if settingDefault == "true" {
                
                if editflag == 0 {
                    
                } else {
                    
                    if UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue) as? Int == 0 {
                        
                    } else {
                        
//                        let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
//                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderingAnimalVC") as! OrderingAnimalVC
//                        self.navigationController?.pushViewController(newViewController, animated: false)
                    }}}
        }
        
        
        for i in 0 ..< provideCountCheck.count{
            isSelectedArray.append(false)
        }
        
        self.navigationController?.navigationBar.isHidden = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        
        
        let checkValue = UserDefaults.standard.value(forKey: "settingDone") as? String
        if checkValue == "true" {
            continueOrderBttn.titleLabel?.font = continueOrderBttn.titleLabel?.font.withSize(23)
            continueOrderBttn.setTitle(NSLocalizedString("Done", comment: ""), for: .normal)
            screenTitle.text = NSLocalizedString("Settings", comment: "")
        }
        else {
            continueOrderBttn.titleLabel?.font = continueOrderBttn.titleLabel?.font.withSize(23)

            continueOrderBttn.setTitle(NSLocalizedString("Continue to Ordering", comment: ""), for: .normal)
            screenTitle.text = NSLocalizedString("Ordering Defaults", comment: "")

        }
        
        
        let zoeties = UserDefaults.standard.value(forKey: "NominatorSave") as? String
        
        if zoeties == nil || zoeties == "Zoetis" || zoeties == ""{
            self.setButtonState(button: zoetisBtnOutlet, isOn: true)
            self.setButtonState(button: holsteinBtnOutlet, isOn: false)
        }
        else{
            self.setButtonState(button: holsteinBtnOutlet, isOn: true)
            self.setButtonState(button: zoetisBtnOutlet, isOn: false)
        }
        
        if UserDefaults.standard.string(forKey: "providerNameUS") == nil {
            // UserDefaults.standard.set("CLARIFIDE CDCB (US)", forKey: "providerNameUS")
            byDefaultProvider = "CLARIFIDE CDCB (US)"
        }
        else{
            
            byDefaultProvider = UserDefaults.standard.string(forKey: "providerNameUS")!
            if byDefaultProvider == "CLARIFIDE Girolando (BR)"
            {
                let getvaluu =  UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
                UserDefaults.standard.set(4, forKey: keyValue.providerID.rawValue)
            }
        }
        if UserDefaults.standard.string(forKey: "name") == nil{
            UserDefaults.standard.set("Dairy", forKey: "name")
        }
        getListProvider = providerEvaliuater(arr: provideCountCheck) as! [GetProviderTbl]
        
        
        if UserDefaults.standard.string(forKey: "name") == "Dairy"{
            
            
            if  UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 1 ||  UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 2 ||  UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 3 || UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 8 || UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 10 || UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 11 || UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 12 {
                
                //  self.keyBoardViewHeight.constant = 200
                //   self.scannerViewHeight.constant = 100
                self.keyBaordFullView.isHidden = false
                keyBoardTitleView.isHidden = false
                alphaNumericbtnOutler.isHidden = false
                //idScannerTitle.isHidden = false
                scannerViewShow.isHidden = false
                selectScannerTitleView.isHidden = false
                self.scannerStackView.isHidden = false
                numericKeyBoardBtnOutle.isHidden = false
                ocrBtnOutlet.isHidden = false
                rfidBtnOutlet.isHidden = false
                ocrInfoBtnOutle.isHidden = false
                self.continueOrderBottomConstraint.constant = 26.0
                self.mainViewHeightConstraint.constant = 926.0
                if getListProvider.count == 0 {
                    //CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("No associated product found for this customer in the app.", comment: ""))
                    marketTipYopOutlet.isHidden = true
                    providerTitleLbl.isHidden = true
                } else {
                    marketTipYopOutlet.isHidden = false
                    providerTitleLbl.isHidden = false
                }
                
                if UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 11 {
                    // primarlyHeightConst.constant = 0
                    self.primarlyBasedView.isHidden = true
                    self.primarlybasedStackView.isHidden = true
                    self.continueOrderBottomConstraint.constant = 66.0
                    self.mainViewHeightConstraint.constant = 831.0
                    
               //     nominatorHeightConst.constant = 100
                    nominatorView.isHidden = false
                    
                } else if UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 2{
                    //  primarlyHeightConst.constant = 0
                    self.primarlyBasedView.isHidden = true
                    self.primarlybasedStackView.isHidden = true
                    self.continueOrderBottomConstraint.constant = 66.0
                    self.mainViewHeightConstraint.constant = 831.0
                }
                
                else {
                    //  primarlyHeightConst.constant = 156
                    self.primarlyBasedView.isHidden = false
                    self.primarlybasedStackView.isHidden = false
                    self.continueOrderBottomConstraint.constant = 26.0
                    self.mainViewHeightConstraint.constant = 926.0
                }
            }else {
                //self.keyBoardViewHeight.constant = 90
                //  self.keyBoardTopView.constant = 5
                //     self.scannerViewHeight.constant = 0
                self.keyBaordFullView.isHidden = true
                keyBoardTitleView.isHidden = true
                ocrInfoBtnOutle.isHidden = true
                // primarlyHeightConst.constant = 0
                self.primarlyBasedView.isHidden = true
                self.primarlybasedStackView.isHidden = true
                self.continueOrderBottomConstraint.constant = 66.0
                self.mainViewHeightConstraint.constant = 831.0
                alphaNumericbtnOutler.isHidden = true
                //   idScannerTitle.isHidden = true
                scannerViewShow.isHidden = true
                self.scannerStackView.isHidden = true
                selectScannerTitleView.isHidden = true
                numericKeyBoardBtnOutle.isHidden = true
                ocrBtnOutlet.isHidden = true
                rfidBtnOutlet.isHidden = true
                
                if getListProvider.count == 0 {
                    //CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("No associated product found for this customer in the app.", comment: ""))
                    marketTipYopOutlet.isHidden = true
                    providerTitleLbl.isHidden = true
                } else {
                    marketTipYopOutlet.isHidden = false
                    providerTitleLbl.isHidden = false
                }
                
            }
            
            if UserDefaults.standard.string(forKey: "providerNameUS") == "CLARIFIDE CDCB (US)" || UserDefaults.standard.string(forKey: "providerNameUS") == "US Dairy Products" {
                //nominatorHeightConst.constant = 100
                nominatorView.isHidden = false
                
            }else  if UserDefaults.standard.string(forKey: "providerNameUS") == "CLARIFIDE CDCB (BR)"{
                //nominatorHeightConst.constant = 100
                nominatorView.isHidden = false
                
            }
            else  if UserDefaults.standard.string(forKey: "ProviderName") == "CLARIFIDE CDCB (IT)" || UserDefaults.standard.string(forKey: "ProviderName") == "CLARIFIDE CDCB (BeNeLux)" || UserDefaults.standard.string(forKey: "ProviderName") == "CLARIFIDE CDCB (CAN)" || UserDefaults.standard.string(forKey: "ProviderName") == "AU Dairy Products" ||
                        UserDefaults.standard.string(forKey: "ProviderName") == "US Dairy Products"{
                //      nominatorHeightConst.constant = 100
                nominatorView.isHidden = false
            }
            else{
                // nominatorHeightConst.constant = 0
                if UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 2 {
                    self.continueOrderBottomConstraint.constant = 66.0
                    self.mainViewHeightConstraint.constant = 831.0
                } else {
                    self.continueOrderBottomConstraint.constant = 106.0
                    self.mainViewHeightConstraint.constant = 736.0
                }
              
                nominatorView.isHidden = true
            }
            providerTitleLbl.text = NSLocalizedString("Evaluation Provider/Market", comment: "")
            primaryBasedOutlet.isHidden = false
            evaluationProviderView.isHidden = false
            productGroupingView.isHidden = true
            evaluationProviderView.isHidden = false
            productGroupingView.isHidden = true
             productTblView.reloadData()
        }
        else{
            
            primaryBasedOutlet.isHidden = true
            providerTitleLbl.text = NSLocalizedString("Product Groupings", comment: "")
            evaluationProviderView.isHidden = true
            productGroupingView.isHidden = false
            evaluationProviderView.isHidden = true
            productGroupingView.isHidden = false
            let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
            productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: pvid)
            // primarlyHeightConst.constant = 0
            self.primarlyBasedView.isHidden = true
            self.primarlybasedStackView.isHidden = true
            self.continueOrderBottomConstraint.constant = 66.0
            self.mainViewHeightConstraint.constant = 831.0
            //  nominatorHeightConst.constant = 0
            nominatorView.isHidden = true
              productTblView.reloadData()
            // self.keyBaordSepratorView.isHidden = false
            //  self.keyBoardViewHeight.constant = 90
            self.keyBaordFullView.isHidden = true
            //  self.keyBoardTopView.constant = 5
            // keyboardSepratorTitle.isHidden = false
            //  self.scannerViewHeight.constant = 0
            keyBoardTitleView.isHidden = true
            
            alphaNumericbtnOutler.isHidden = true
            //  idScannerTitle.isHidden = true
            scannerViewShow.isHidden = true
            selectScannerTitleView.isHidden = true
            self.scannerStackView.isHidden = true
            numericKeyBoardBtnOutle.isHidden = true
            ocrBtnOutlet.isHidden = true
            rfidBtnOutlet.isHidden = true
            ocrInfoBtnOutle.isHidden = true
            if getListProvider.count == 0 {
                marketTipYopOutlet.isHidden = true
                providerTitleLbl.isHidden = true
            } else {
                marketTipYopOutlet.isHidden = true
                providerTitleLbl.isHidden = false
            }
            
            let marketId = UserDefaults.standard.object(forKey: "currentActiveMarketId") as? String ?? ""
            if UserDefaults.standard.integer(forKey:"BeefPvid") == 13 || UserDefaults.standard.integer(forKey:"BeefPvid") == 5 && (UserDefaults.standard.string(forKey: "providerNameUS") == "CLARIFIDE CDCB (US)" || UserDefaults.standard.string(forKey: "providerNameUS") == "US Dairy Products")  {
                // self.scannerViewHeight.constant = 100
                // idScannerTitle.isHidden = false
                scannerViewShow.isHidden = false
                self.scannerStackView.isHidden = false
                selectScannerTitleView.isHidden = false
                rfidBtnOutlet.isHidden = false
                ocrBtnOutlet.isHidden = false
                ocrInfoBtnOutle.isHidden = false
                if UserDefaults.standard.object(forKey: "beefScannerSelection") as? String == "ocr"{
                    
                    self.setButtonState(button: ocrBtnOutlet, isOn: true)
                    self.setButtonState(button: rfidBtnOutlet, isOn: false)
                } else {
                    
                    self.setButtonState(button: rfidBtnOutlet, isOn: true)
                    self.setButtonState(button: ocrBtnOutlet, isOn: false)
                }
            } else {
                //  self.scannerViewHeight.constant = 0
                //       idScannerTitle.isHidden = true
                //   scannerSepratorBar.isHidden = false
                scannerViewShow.isHidden = true
                self.scannerStackView.isHidden = true
                selectScannerTitleView.isHidden = true
                self.continueOrderBottomConstraint.constant = 106.0
                self.mainViewHeightConstraint.constant = 736.0
                rfidBtnOutlet.isHidden = true
                ocrBtnOutlet.isHidden = true
                ocrInfoBtnOutle.isHidden = true
            }
        }
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
            button.backgroundColor = UIColor.clear
            button.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
            button.setTitleColor(UIColor.black, for: .normal)
            
        }
    }
    //MARK: METHODS AND FUNCTIONS
    func initialNetworkCheck(){
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        
        let del =  UIApplication.shared.delegate as? AppDelegate
        
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if NetworkStatusLbl?.text == NSLocalizedString("Connected", comment: "") {
            self.offLineBtn.isUserInteractionEnabled = false
            networkStatusImg.image = UIImage(named: "status_online_sign")
        }
        else {
            networkStatusImg.image = UIImage(named: "status_offline")
            self.offLineBtn.isUserInteractionEnabled = true
        }
    }
    
    func getMarketsForCurrentCustomer() {
        if let currentCustomerId = UserDefaults.standard.value(forKey: "currentActiveCustomerId") as? Int {
            let markets = fetchAllDataWithCustomerID(entityName: "CustomerMarkets", customerId: currentCustomerId)
            self.customerMarkets = markets as? [CustomerMarkets] ?? []
            
        }
    }
    
    func providerEvaliuater(arr:[GetProviderTbl]) -> [GetProviderTbl] {
        getListProvider.removeAll()
        for provider in arr {
            
            var providersForCustomerMarkets = [Int]()
            for markets in customerMarkets {
                
                let evaluationMarkets = fetchEvaluationMarkets(entityName: "EvaluationMarkets", marketId: markets.marketId ?? "", speciesId: provider.speciesId ?? "")
                
                for market in evaluationMarkets as? [EvaluationMarkets] ?? [] {
                    
                    let providers = fetchEvaluationProvider(entityName: "GetProviderTbl", providerId: Int(market.providerID))
                    
                    for provider in providers as? [GetProviderTbl] ?? [] {
                        providersForCustomerMarkets.append(Int(provider.providerId))
                    }
                }
            }
            
            if providersForCustomerMarkets.contains(Int(provider.providerId)) {
                getListProvider.append(provider)
            }
        }
        return getListProvider
    }
    
    //MARK: OBJC SELECTOR METHODS
    @objc func specisButton(_ sender:UIButton) {
        
        UserDefaults.standard.set(false, forKey: "isAggreForSubmit")
        let specisObject : GetSpeciesTbl = speiecCountCheck.object(at: sender.tag) as! GetSpeciesTbl
        
        //sender.titleLabel?.text = (specisObject.speciesName)?.localized
        
        if specisObject.speciesName ==  "Dairy" {
            
            //          if sender.layer.borderColor == UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor {
            //              return
            //          }
            if sender.layer.borderColor == UIColor.clear.cgColor {
                return
            }
            self.provideCountCheck = fetchdataOfProvider(specisId: "074dc82b-2b82-4ee6-99c6-f9691937394d") as! [GetProviderTbl]
            if providerEvaliuater(arr: provideCountCheck).count == 0{
                
                self.evalutionProviderCV.reloadData()
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("No associated evaluation provider found for this customer in the app.", comment: ""))
                
                
                self.provideCountCheck = fetchdataOfProvider(specisId: "151e2230-9a01-4828-a105-d87a92b5be2f") as! [GetProviderTbl]
                getListProvider = providerEvaliuater(arr: provideCountCheck)
                
                return
                
            } else {
                
                getListProvider = providerEvaliuater(arr: provideCountCheck)
            }
            if getListProvider.count == 0 {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("No associated evaluation provider found for this customer in the app.", comment: ""))
                return
                
            } else {
                let selectedDairyProvider = getListProvider.filter({$0.isDefault == true })
                if UserDefaults.standard.object(forKey: keyValue.providerID.rawValue) == nil {
                    if selectedDairyProvider.count > 0{
                        UserDefaults.standard.setValue(selectedDairyProvider[0].providerId, forKey: keyValue.providerID.rawValue)
                    }
                }
                marketTipYopOutlet.isHidden = false
                providerTitleLbl.isHidden = false
                
            }
            
            
            switchFromDairy = true
            primaryBasedOutlet.isHidden = false
            providerTitleLbl.text = NSLocalizedString("Evaluation Provider/Market", comment: "")
            evaluationProviderView.isHidden = false
            productGroupingView.isHidden = true
            if UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 1 ||  UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 2 ||  UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 3
                || UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 8 || UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 11 ||
                UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 12 ||
                UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 10{
                //   self.keyBoardViewHeight.constant = 200
                //  self.scannerViewHeight.constant = 100
                //  self.keyBoardTopView.constant = 115
                ocrInfoBtnOutle.isHidden = false
                self.keyBaordFullView.isHidden = false
                // primarlyHeightConst.constant = 156
                self.primarlyBasedView.isHidden = false
                self.primarlybasedStackView.isHidden = false
                self.continueOrderBottomConstraint.constant = 26.0
                self.mainViewHeightConstraint.constant = 926.0
                keyBoardTitleView.isHidden = false
                alphaNumericbtnOutler.isHidden = false
                // idScannerTitle.isHidden = false
                scannerViewShow.isHidden = false
                selectScannerTitleView.isHidden = false
                self.scannerStackView.isHidden = false
                numericKeyBoardBtnOutle.isHidden = false
                ocrBtnOutlet.isHidden = false
                rfidBtnOutlet.isHidden = false
                if UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 2{
                    // primarlyHeightConst.constant = 0
                    self.primarlyBasedView.isHidden = true
                    self.primarlybasedStackView.isHidden = true
                    self.continueOrderBottomConstraint.constant = 66.0
                    self.mainViewHeightConstraint.constant = 831.0
                }
            }
            else {
                //self.keyBoardViewHeight.constant = 90
                //  self.keyBoardTopView.constant = 5
                // self.scannerViewHeight.constant = 0
                self.keyBaordFullView.isHidden = true
                keyBoardTitleView.isHidden = true
                alphaNumericbtnOutler.isHidden = true
                // idScannerTitle.isHidden = true
                scannerViewShow.isHidden = true
                self.scannerStackView.isHidden = true
                selectScannerTitleView.isHidden = true
                numericKeyBoardBtnOutle.isHidden = true
                ocrBtnOutlet.isHidden = true
                rfidBtnOutlet.isHidden = true
                ocrBtnOutlet.isHidden = true
                rfidBtnOutlet.isHidden = true
                //  primarlyHeightConst.constant = 0
                self.primarlyBasedView.isHidden = true
                self.primarlybasedStackView.isHidden = true
            }
            
            if UserDefaults.standard.string(forKey: "providerNameUS") == "CLARIFIDE CDCB (US)" || UserDefaults.standard.string(forKey: "providerNameUS") == "US Dairy Products"{
                // self.nominatorHeightConst.constant = 100
                nominatorView.isHidden = false
                
            }
            else if  UserDefaults.standard.string(forKey: "providerNameUS") == "CLARIFIDE CDCB (BR)"{
                // self.nominatorHeightConst.constant = 100
                nominatorView.isHidden = false
                
            }
            else {
                // self.nominatorHeightConst.constant = 0
                nominatorView.isHidden = true
            }
            sender.isSelected = !sender.isSelected
            if sender.isSelected {
                //  sender.isSelected = true
                //          sender.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                self.setButtonState(button: sender, isOn: true)
            } else {
                //          sender.isSelected = false
                //          sender.setImage(nil, for: .normal)
                //          sender.layer.borderColor = UIColor.lightGray.cgColor
                //          sender.backgroundColor = UIColor.white
                self.setButtonState(button: sender, isOn: false)
            }
            for i in 0 ..< provideCountCheck.count{
                isSelectedArray.append(false)
            }
            specname = specisObject.speciesName!
            UserDefaults.standard.set(specname, forKey: "name")
            UserDefaults.standard.set(specisObject.speciesId, forKey: "SpeciesId")
            saveSettingData(entity: "SettingTbl", specisId: specisObject.speciesId ?? "", specisName: specisObject.speciesName ?? "", providerName: "", providerId: 0, nominater: "Zoetis", fromDatae: "", toDate: "", status: "true",index: sender.tag)
            
            if UserDefaults.standard.object(forKey: "scannerSelection") as? String == "ocr"{
                //          ocrBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                //          rfidBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                //          ocrBtnOutlet.layer.borderWidth = 2
                //          rfidBtnOutlet.layer.borderWidth = 1
                UserDefaults.standard.set("ocr", forKey: "scannerSelection")
                self.setButtonState(button: ocrBtnOutlet, isOn: true)
                self.setButtonState(button: rfidBtnOutlet, isOn: false)
            } else {
                //          rfidBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                //          ocrBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                //          rfidBtnOutlet.layer.borderWidth = 2
                //          ocrBtnOutlet.layer.borderWidth = 1
                UserDefaults.standard.set("rfid", forKey: "scannerSelection")
                self.setButtonState(button: rfidBtnOutlet, isOn: true)
                self.setButtonState(button: ocrBtnOutlet, isOn: false)
            }
            
            
        }
        
        else if specisObject.speciesName ==  "Beef" {
            
            if sender.layer.borderColor == UIColor.clear.cgColor {
                return
            }
            let marketId = UserDefaults.standard.object(forKey: "currentActiveMarketId") as? String ?? ""
            
            
            self.provideCountCheck = fetchdataOfProvider(specisId: "151e2230-9a01-4828-a105-d87a92b5be2f") as! [GetProviderTbl]
            let providercheck = providerEvaliuater(arr: provideCountCheck)
            
            if providercheck.count == 0 {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("No associated product found for this customer in the app.", comment: ""))
                self.provideCountCheck = fetchdataOfProvider(specisId: "074dc82b-2b82-4ee6-99c6-f9691937394d") as! [GetProviderTbl]
                getListProvider = providerEvaliuater(arr: provideCountCheck)
                return
                //  marketTipYopOutlet.isHidden = true
                //     marketView.isHidden = true
                //   providerTitleLbl.isHidden = true
            } else {
                getListProvider = providercheck
                let selectedProvider = getListProvider.filter({$0.isDefault == true })
                if selectedProvider.count > 0 {
                    //  UserDefaults.standard.setValue(selectedProvider[0].providerId, forKey: "BeefPvid")
                    if UserDefaults.standard.integer(forKey:"BeefPvid") == 13 || UserDefaults.standard.integer(forKey:"BeefPvid") == 5 {
                        if UserDefaults.standard.object(forKey: "beefScannerSelection") as? String ==  nil && UserDefaults.standard.string(forKey: "ProviderName") == "US Dairy Products" {
                            UserDefaults.standard.set("ocr", forKey: "beefScannerSelection")
                        }
                    }
                }
                marketTipYopOutlet.isHidden = true
                providerTitleLbl.isHidden = false
            }
            
            // self.keyBoardViewHeight.constant = 90
            
            self.keyBaordFullView.isHidden = true
            //  self.keyBoardTopView.constant = 5
            //  self.scannerViewHeight.constant = 0
            keyBoardTitleView.isHidden = true
            alphaNumericbtnOutler.isHidden = true
            // idScannerTitle.isHidden = true
            scannerViewShow.isHidden = true
            self.scannerStackView.isHidden = true
            selectScannerTitleView.isHidden = true
            numericKeyBoardBtnOutle.isHidden = true
            ocrBtnOutlet.isHidden = true
            
            rfidBtnOutlet.isHidden = true
            ocrInfoBtnOutle.isHidden = true
            switchFromDairy = true
            //marketView.isHidden = true
            primaryBasedOutlet.isHidden = true
            providerTitleLbl.text = NSLocalizedString("Product Groupings", comment: "")
            evaluationProviderView.isHidden = true
            productGroupingView.isHidden = false
            //  primarlyHeightConst.constant = 0
            self.primarlyBasedView.isHidden = true
            self.primarlybasedStackView.isHidden = true
            self.continueOrderBottomConstraint.constant = 106.0
            self.mainViewHeightConstraint.constant = 726.0
            //  nominatorHeightConst.constant = 0
            nominatorView.isHidden = true
            sender.isSelected = !sender.isSelected
            if sender.isSelected {
                //          sender.isSelected = true
                //          sender.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                self.setButtonState(button: sender, isOn: true)
            } else {
                //          sender.isSelected = false
                //          sender.setImage(nil, for: .normal)
                //          sender.layer.borderColor = UIColor.lightGray.cgColor
                //          sender.backgroundColor = UIColor.white
                self.setButtonState(button: sender, isOn: false)
            }
            
            
            
            for i in 0 ..< provideCountCheck.count{
                isSelectedArray.append(false)
            }
            specname = specisObject.speciesName!
            
            UserDefaults.standard.set(specname, forKey: "name")
            UserDefaults.standard.set( specisObject.speciesId, forKey: "SpeciesId")
            saveSettingData(entity: "SettingTbl", specisId: specisObject.speciesId ?? "", specisName: specisObject.speciesName ?? "", providerName: "", providerId: 0, nominater: "", fromDatae: "", toDate: "", status: "true",index: sender.tag)
            
            
            let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
            productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: pvid)
            
            if let  products = productArr as? [GetProductTbl] {
                for product in products {
                    product.isAdded = "false"
                }
                deleteRecordFromDatabase(entityName: "OfflineOrderBeef")
                
            }
             productTblView.reloadData()
            if UserDefaults.standard.integer(forKey:"BeefPvid") == 13  || UserDefaults.standard.integer(forKey:"BeefPvid") == 5 && marketId == "15009e40-7e3d-4653-b7bc-2be1f05915df" {
                //  self.scannerViewHeight.constant = 100
                //  idScannerTitle.isHidden = false
                scannerViewShow.isHidden = false
                self.scannerStackView.isHidden = false
                selectScannerTitleView.isHidden = false
                scannerViewShow.isHidden = false
                self.scannerStackView.isHidden = false
                rfidBtnOutlet.isHidden = false
                ocrBtnOutlet.isHidden = false
                ocrInfoBtnOutle.isHidden = false
                self.continueOrderBottomConstraint.constant = 66.0
                self.mainViewHeightConstraint.constant = 831.0
                
                if UserDefaults.standard.object(forKey: "beefScannerSelection") as? String == "ocr"{
                    //            ocrBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    //            rfidBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                    //            ocrBtnOutlet.layer.borderWidth = 2
                    //            rfidBtnOutlet.layer.borderWidth = 1
                    UserDefaults.standard.set("ocr", forKey: "beefScannerSelection")
                    self.setButtonState(button: ocrBtnOutlet, isOn: true)
                    self.setButtonState(button: rfidBtnOutlet, isOn: false)
                } else {
                    //            rfidBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    //            ocrBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                    //            rfidBtnOutlet.layer.borderWidth = 2
                    //            ocrBtnOutlet.layer.borderWidth = 1
                    UserDefaults.standard.set("rfid", forKey: "beefScannerSelection")
                    self.setButtonState(button: rfidBtnOutlet, isOn: true)
                    self.setButtonState(button: ocrBtnOutlet, isOn: false)
                }
            }
        }
        self.evalutionProviderCV.reloadData()
        self.speciesCollectionView.reloadData()
    }
    
    @objc func providerButton(_ sender:UIButton) {
        if sender.layer.borderColor == UIColor.clear.cgColor {
            return
        }
        UserDefaults.standard.removeObject(forKey: "Brazil")
        UserDefaults.standard.removeObject(forKey: "page")
        UserDefaults.standard.removeObject(forKey: "on")
        if UserDefaults.standard.string(forKey: "name") == "Dairy" {
            let userId = UserDefaults.standard.integer(forKey: "userId")
            let orderId = UserDefaults.standard.integer(forKey: "orderId")
            
            let providerObject : GetProviderTbl = self.getListProvider[sender.tag] as! GetProviderTbl
            let pviduser = UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue )
            
            if pviduser != providerObject.providerId {
                
                let alert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Are you sure you want to change the provider?", comment: ""),   preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default, handler: { _ in
                    // Cancel Action
                    
                    
                }))
                alert.addAction(UIAlertAction(title:  NSLocalizedString("Yes", comment: ""),style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
                    
                    let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
                    
                    if pvid == 8 {
                        self.evaluationProvider = "CLARIFIDE GIROLANDO (BR)"
                        UserDefaults.standard.set("CLARIFIDE GIROLANDO (BR)", forKey: "providerNameUS")
                    } else if pvid == 4 {
                        self.evaluationProvider = "CLARIFIDE CDCB (BR)"
                        UserDefaults.standard.set("CLARIFIDE CDCB (BR)", forKey: "providerNameUS")
                    }
                    
                    
                    let sampleType =  fetchproviderData(entityName: "GetSampleTbl", provId: Int(providerObject.providerId) )
                    var animaltbl = fetchAllDataOrderStatus(entityName: "AnimaladdTbl",ordestatus: "false",orderId:orderId,userId:userId).mutableCopy() as! Array<Any>
                    for i in 0 ..< sampleType.count {
                        let samType  = sampleType[i] as! GetSampleTbl
                        animaltbl = animaltbl.filter { (item) -> Bool in
                            if let value = item as? AnimaladdTbl, value.tissuName != samType.sampleName{
                                return true
                            } else {
                                return false
                            }
                        }
                    }
                    //
                    let breedType = fetchBreedData(entityName: "GetBreedsTbl", provId:  Int(providerObject.providerId) )
                    var animaltbl1 = fetchAllDataOrderStatus(entityName: "AnimaladdTbl",ordestatus: "false",orderId:orderId,userId:userId).mutableCopy() as! Array<Any>
                    //
                    for i in 0 ..< breedType.count {
                        let bredTy  = breedType[i] as! GetBreedsTbl
                        animaltbl1 = animaltbl1.filter { (item) -> Bool in
                            if let value = item as? AnimaladdTbl, value.breedId != bredTy.breedId{
                                return true
                            } else {
                                return false
                            }
                        }
                    }
                    
                    UserDefaults.standard.set(false, forKey: "ClickAuProvider")
                    
                    
                    var strinBreed = String()
                    var StringSampleType = String()
                    if animaltbl1.count > 0 || animaltbl.count > 0 {
                        if animaltbl1.count > 0{
                            strinBreed =  "Breed of \(animaltbl1.count) animal(s) not available in the selected provider."
                        }
                        else if animaltbl.count > 0{
                            StringSampleType = "Sample type of \(animaltbl.count) animal(s) not available in the selected provider."
                        }
                        
                        
                        let alert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("\(strinBreed) \(StringSampleType) Do you want to remove animal(s) from the order?",comment : ""),  preferredStyle: UIAlertController.Style.alert)
                        
                        alert.addAction(UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: UIAlertAction.Style.default, handler: { _ in
                            return
                            //self.addProduct()
                        }))
                        alert.addAction(UIAlertAction(title: NSLocalizedString("YES", comment: ""), style: UIAlertAction.Style.default,
                                                      handler: {(_: UIAlertAction!) in
                            sender.isSelected = !sender.isSelected
                            UserDefaults.standard.set(true, forKey: "is_provider_change")
                            UserDefaults.standard.set(providerObject.providerName!, forKey: "providerNameUS")
                            
                            UserDefaults.standard.set(false, forKey: "isAggreForSubmit")
                            UserDefaults.standard.removeObject(forKey: "breedName")
                            deleteRecordFromDatabase(entityName: "Saveprovider")
                            
                            saveSettingProviderData(entity: "Saveprovider", specisId: providerObject.speciesId ?? "", specisName: self.specname, providerName: providerObject.providerName! , providerId: Int(providerObject.providerId), nominater: "Zoetis", fromDatae: "", toDate: "", status: "true", index: sender.tag)
                            let fetchAray = fetchAllData(entityName: "Saveprovider")
                            let pvId = fetchAray.object(at: 0) as! Saveprovider
                            
                            self.byDefaultProvider = pvId.providerName!
                            
                            UserDefaults.standard.set(providerObject.providerName!, forKey: "ProviderName")
                            UserDefaults.standard.set(Int(providerObject.providerId), forKey: keyValue.providerID.rawValue)
                            
                            
                            for item1 in animaltbl{
                                if let value = item1 as? AnimaladdTbl{
                                    if animaltbl.count == 1 {
                                        
                                        deleteDataWithAnimalSampleType(value.tissuName!,orderstatus:"false")
                                        self.createListNameAndCheckifExist()
                                    } else {
                                        deleteDataWithAnimalSampleType(value.tissuName!,orderstatus:"false")
                                    }
                                }
                            }
                            
                            for item in animaltbl1{
                                if let value = item as? AnimaladdTbl{
                                    if animaltbl1.count == 1 {
                                        deleteDataWithAnimalBreedId(value.breedId!,orderstatus:"false")
                                        self.createListNameAndCheckifExist()
                                    } else {
                                        deleteDataWithAnimalBreedId(value.breedId!,orderstatus:"false")
                                    }
                                }
                            }
                            UserDefaults.standard.set(Int(pvId.providerId), forKey: keyValue.providerID.rawValue)
                            self.updateProviderId()
                            self.createListNameAndCheckifExist()
                            if sender.isSelected {
                                self.isSelectedArray[sender.tag] = true
                                for i in 0 ..<  self.getListProvider.count {
                                    
                                    let myIndexPath = NSIndexPath(row: i, section: 0)
                                    let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                                    let  pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
                                    let arrData =    self.getListProvider[i] as! GetProviderTbl
                                    if pvid == arrData.providerId{
//                                        item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
//                                        item.EcalutionProviderBttn.layer.borderWidth = 2
                                        self.setButtonState(button: item.EcalutionProviderBttn, isOn: true)
                                        
                                    }
                                    else{
//                                        item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
//                                        item.EcalutionProviderBttn.backgroundColor = UIColor.white
//                                        item.EcalutionProviderBttn.layer.borderWidth = 1
                                        self.setButtonState(button: item.EcalutionProviderBttn, isOn: false)

                                        
                                    }
                                    
                                }
                                
                            } else {
                                
                                self.isSelectedArray[sender.tag] = false
                                for i in 0 ..<  self.getListProvider.count {
                                    let myIndexPath = NSIndexPath(row: i, section: 0)
                                    let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                                    let  pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
                                    let arrData =    self.getListProvider[i] as! GetProviderTbl
                                    if pvid == arrData.providerId{
//                                        item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
//                                        item.EcalutionProviderBttn.layer.borderWidth = 2
                                        self.setButtonState(button: item.EcalutionProviderBttn, isOn: true)

                                        
                                    } else {
//                                        item.EcalutionProviderBttn.layer.borderWidth = 1
//                                        item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
//                                        item.EcalutionProviderBttn.backgroundColor = UIColor.white
                                        self.setButtonState(button: item.EcalutionProviderBttn, isOn: false)

                                    }
                                }
                            }
                            self.addProduct()
                            
                            
                            
                            guard let providerChange = UserDefaults.standard.bool(forKey: "is_provider_change") as? Bool else { return }
                            UserDefaults.standard.removeObject(forKey: "is_provider_change")
                            UserDefaults.standard.set(false, forKey: "isAggreForSubmit")
                            UserDefaults.standard.removeObject(forKey: "breedName")
                            
                            UserDefaults.standard.set(providerObject.providerName!, forKey: "ProviderName")
                            UserDefaults.standard.set(Int(providerObject.providerId), forKey: keyValue.providerID.rawValue)
                            UserDefaults.standard.set("", forKey: "FOReviewOrderVC")
                            UserDefaults.standard.set("", forKey: "FOSampleTrackingDetailVC")
                            UserDefaults.standard.removeObject(forKey: "dataEnteryListName")
                            UserDefaults.standard.set(false, forKey: "BVDVSeleted")
                            
                            let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
                            
                            let sampleType =  fetchproviderData(entityName: "GetSampleTbl", provId: Int(pvId.providerId)  )
                            var animaltbl = fetchAllDataOrderStatus(entityName: "AnimaladdTbl",ordestatus: "false",orderId:orderId,userId:userId).mutableCopy() as! Array<Any>
                            for i in 0 ..< sampleType.count {
                                let samType  = sampleType[i] as! GetSampleTbl
                                animaltbl = animaltbl.filter { (item) -> Bool in
                                    if let value = item as? AnimaladdTbl, value.tissuName != samType.sampleName{
                                        return true
                                    } else {
                                        return false
                                    }
                                }
                            }
                            
                            let breedType = fetchBreedData(entityName: "GetBreedsTbl", provId:  Int(pvId.providerId) )
                            var animaltbl1 = fetchAllDataOrderStatus(entityName: "AnimaladdTbl",ordestatus: "false",orderId:orderId,userId:userId).mutableCopy() as! Array<Any>
                            
                            for i in 0 ..< breedType.count {
                                let bredTy  = breedType[i] as! GetBreedsTbl
                                animaltbl1 = animaltbl1.filter { (item) -> Bool in
                                    if let value = item as? AnimaladdTbl, value.breedId != bredTy.breedId{
                                        return true
                                    } else {
                                        return false
                                    }
                                }
                            }
                            
                            if sender.tag == 3 {
                                
                            } else {
                                
                                if sender.tag == 2 {
                                    UserDefaults.standard.set(true, forKey: "ClickAuProvider")
                                    
                                } else {
                                    
                                    UserDefaults.standard.set(false, forKey: "ClickAuProvider")
                                    
                                }
                            }
                            
                        }))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    else {
                        
                        UserDefaults.standard.set(Int(providerObject.providerId), forKey: keyValue.providerID.rawValue)
                        
                        sender.isSelected = !sender.isSelected
                        UserDefaults.standard.set(true, forKey: "is_provider_change")
                        UserDefaults.standard.set(providerObject.providerName!, forKey: "providerNameUS")
                        
                        UserDefaults.standard.set(false, forKey: "isAggreForSubmit")
                        UserDefaults.standard.removeObject(forKey: "breedName")
                        deleteRecordFromDatabase(entityName: "Saveprovider")
                        
                        saveSettingProviderData(entity: "Saveprovider", specisId: providerObject.speciesId ?? "", specisName: self.specname, providerName: providerObject.providerName! , providerId: Int(providerObject.providerId), nominater: "Zoetis", fromDatae: "", toDate: "", status: "true", index: sender.tag)
                        let fetchAray = fetchAllData(entityName: "Saveprovider")
                        let pvId = fetchAray.object(at: 0) as! Saveprovider
                        
                        self.byDefaultProvider = pvId.providerName!
                        
                        UserDefaults.standard.set(providerObject.providerName!, forKey: "ProviderName")
                        UserDefaults.standard.set(Int(providerObject.providerId), forKey: keyValue.providerID.rawValue)
                        
                        if  sender.isSelected {
                            self.isSelectedArray[sender.tag] = true
                            for i in 0 ..<  self.getListProvider.count {
                                
                                let myIndexPath = NSIndexPath(row: i, section: 0)
                                let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                                let  pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
                                let arrData =    self.getListProvider[i] as! GetProviderTbl
                                if pvid == arrData.providerId{
//                                    item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
//                                    item.EcalutionProviderBttn.layer.borderWidth = 2
                                    self.setButtonState(button: item.EcalutionProviderBttn, isOn: true)

                                    
                                }
                                else{
//                                    item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
//                                    item.EcalutionProviderBttn.backgroundColor = UIColor.white
//                                    item.EcalutionProviderBttn.layer.borderWidth = 1
                                    self.setButtonState(button: item.EcalutionProviderBttn, isOn: false)

                                }
                            }
                            
                        } else {
                            
                            self.isSelectedArray[sender.tag] = false
                            for i in 0 ..<  self.getListProvider.count {
                                let myIndexPath = NSIndexPath(row: i, section: 0)
                                let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                                let  pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
                                let arrData =    self.getListProvider[i] as! GetProviderTbl
                                if pvid == arrData.providerId{
//                                    item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
//                                    item.EcalutionProviderBttn.layer.borderWidth = 2
                                    self.setButtonState(button: item.EcalutionProviderBttn, isOn: true)

                                    
                                } else {
//                                    item.EcalutionProviderBttn.layer.borderWidth = 1
//                                    item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
//                                    item.EcalutionProviderBttn.backgroundColor = UIColor.white
                                    self.setButtonState(button: item.EcalutionProviderBttn, isOn: false)

                                }
                            }
                        }
                        self.addProduct()
                        self.updateProviderId()
                    }
                    
                    if UserDefaults.standard.string(forKey: "providerNameUS") == "CLARIFIDE CDCB (US)" || UserDefaults.standard.string(forKey: "providerNameUS") == "US Dairy Products"{
                        //  self.nominatorHeightConst.constant = 100
                        self.nominatorView.isHidden = false
                        
                    }else  if UserDefaults.standard.string(forKey: "providerNameUS") == "CLARIFIDE CDCB (BR)"{
                        //  self.nominatorHeightConst.constant = 100
                        self.nominatorView.isHidden = false
                        
                    }
                    else{
                        //  self.nominatorHeightConst.constant = 0
                        self.nominatorView.isHidden = true
                    }
                    UserDefaults.standard.set("NoNeedAuPopUp", forKey: "isAuSelected")
                    
                    
                    if providerObject.providerId == 1 || providerObject.providerId == 3 || providerObject.providerId == 8{
                        
                        //  self.primarlyHeightConst.constant = 156
                        self.primarlyBasedView.isHidden = false
                        self.primarlybasedStackView.isHidden = false
                        self.continueOrderBottomConstraint.constant = 26.0
                        self.mainViewHeightConstraint.constant = 926.0
                    } else {
                        
                        // self.primarlyHeightConst.constant = 0
                        self.primarlyBasedView.isHidden = true
                        self.primarlybasedStackView.isHidden = true
                        self.continueOrderBottomConstraint.constant = 106.0
                        self.mainViewHeightConstraint.constant = 736.0
                    }
                    
                    if providerObject.providerId == 1 ||  providerObject.providerId == 2 || providerObject.providerId == 3 || providerObject.providerId == 8 {
                        //   self.scannerViewHeight.constant = 100
                        //   self.keyBoardViewHeight.constant = 200
                        //  self.keyBoardTopView.constant = 115
                        self.keyBaordFullView.isHidden = false
                        self.keyBoardTitleView.isHidden = false
                        self.alphaNumericbtnOutler.isHidden = false
                        //  self.idScannerTitle.isHidden = false
                        self.scannerViewShow.isHidden = false
                        self.scannerStackView.isHidden = false
                        self.selectScannerTitleView.isHidden = false
                        self.numericKeyBoardBtnOutle.isHidden = false
                        self.ocrBtnOutlet.isHidden = false
                        self.rfidBtnOutlet.isHidden = false
                        self.ocrInfoBtnOutle.isHidden = false
                    } else{
                        //self.keyBoardViewHeight.constant = 90
                        //  self.keyBoardTopView.constant = 5
                        // self.scannerViewHeight.constant = 0
                        self.keyBaordFullView.isHidden = true
                        self.keyBoardTitleView.isHidden = true
                        
                        self.alphaNumericbtnOutler.isHidden = true
                        //self.idScannerTitle.isHidden = true
                        self.scannerViewShow.isHidden = true
                        self.scannerStackView.isHidden = true
                        self.selectScannerTitleView.isHidden = true
                        self.numericKeyBoardBtnOutle.isHidden = true
                        self.ocrBtnOutlet.isHidden = true
                        self.rfidBtnOutlet.isHidden = true
                        self.ocrInfoBtnOutle.isHidden = true
                    }
                    
                }))
                self.present(alert, animated: true, completion: nil)
                
            } else {
                
                sender.isSelected = !sender.isSelected
                UserDefaults.standard.set(true, forKey: "is_provider_change")
                UserDefaults.standard.set(providerObject.providerName!, forKey: "providerNameUS")
                
                UserDefaults.standard.set(false, forKey: "isAggreForSubmit")
                UserDefaults.standard.removeObject(forKey: "breedName")
                deleteRecordFromDatabase(entityName: "Saveprovider")
                
                saveSettingProviderData(entity: "Saveprovider", specisId: providerObject.speciesId ?? "", specisName: specname, providerName: providerObject.providerName! , providerId: Int(providerObject.providerId), nominater: "Zoetis", fromDatae: "", toDate: "", status: "true", index: sender.tag)
                let fetchAray = fetchAllData(entityName: "Saveprovider")
                let pvId = fetchAray.object(at: 0) as! Saveprovider
                
                self.byDefaultProvider = pvId.providerName!
                
                UserDefaults.standard.set(providerObject.providerName!, forKey: "ProviderName")
                UserDefaults.standard.set(Int(providerObject.providerId), forKey: keyValue.providerID.rawValue)
            }
        } else {
            //"Beef"
            let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
            //  self.keyBoardViewHeight.constant = 90
            self.keyBaordFullView.isHidden = true
            //  self.keyBoardTopView.constant = 5
            UserDefaults.standard.removeObject(forKey: "BeefdateEntrySaveReviewPreference")
            
            UserDefaults.standard.set("GLobal", forKey: "ProviderName")
            UserDefaults.standard.set(false, forKey: "SubmitBtnFlag")
            let pid =   UserDefaults.standard.integer(forKey: "BfProductId")
            let pid1 =   UserDefaults.standard.integer(forKey: "chpid")
            let userId = UserDefaults.standard.integer(forKey: "userId")
            let data = fetchAllDataWithOrderIDWithBeef(entityName: "BeefAnimaladdTbl",pid:pid,userId:userId)
            let  pvid1 = UserDefaults.standard.integer(forKey: "BeefPvid")
            if pvid1 == 13 || pvid1 == 5 {
                // scannerViewHeight.constant = 100
                ocrBtnOutlet.isHidden = false
                rfidBtnOutlet.isHidden = false
            } else {
                // scannerViewHeight.constant = 0
                ocrBtnOutlet.isHidden = true
                rfidBtnOutlet.isHidden = true
                
            }
            let providerObjects : GetProviderTbl = (self.getListProvider[sender.tag] as! GetProviderTbl)
            
            if pvid1 != providerObjects.providerId{
                
                
                let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Are you sure you want to change the product grouping?", comment: "") , preferredStyle: .alert)
                
                // Create the actions
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                    action in
                    
                    let providerObject : GetProviderTbl = self.getListProvider[sender.tag] as! GetProviderTbl
                    UserDefaults.standard.set(true, forKey: "showbeefInheritTable")
                    UserDefaults.standard.set(false, forKey: "isAggreForSubmit")
                    
                    if UserDefaults.standard.integer(forKey: "BeefPvid") != Int(providerObject.providerId) {
                        
                        
                        
                        if pvid == 5 || pvid ==  13{
                            let sampleType =  fetchproviderData(entityName: "GetSampleTbl", provId: Int(providerObject.providerId) )
                            let breedType = fetchBreedData(entityName: "GetBreedsTbl", provId:  Int(providerObject.providerId) )
                            var animaltbl = fetchAllDataOrderStatus(entityName: "BeefAnimaladdTbl",ordestatus: "false",orderId:1,userId:userId).mutableCopy() as! [BeefAnimaladdTbl]
                            
                            var animaltbl1 = fetchAllDataOrderStatus(entityName: "BeefAnimaladdTbl",ordestatus: "false",orderId:1,userId:userId).mutableCopy() as! [BeefAnimaladdTbl]
                            //
                            for i in 0 ..< sampleType.count {
                                let samType  = sampleType[i] as! GetSampleTbl
                                animaltbl = animaltbl.filter { (item) -> Bool in
                                    if let value = item as? BeefAnimaladdTbl, value.tissuName != samType.sampleName{
                                        return true
                                    } else {
                                        return false
                                    }
                                }
                            }
                            
                            var strinBreed = String()
                            var StringSampleType = String()
                            
                            if animaltbl.count > 0{
                                StringSampleType = "Sample type of \(animaltbl.count) animal(s) not available in the selected provider."
                                
                                let alert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("\(StringSampleType) Do you want to remove animal(s) from the order?",comment : ""),  preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: UIAlertAction.Style.default, handler: {_ in
                                    return
                                }))
                                
                                alert.addAction(UIAlertAction(title: NSLocalizedString("YES", comment: ""), style:UIAlertAction.Style.default, handler: {(_: UIAlertAction!) in
                                    
                                    UserDefaults.standard.set(Int(providerObject.providerId), forKey: "BeefPvid")
                                    deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
                                    deleteRecordFromDatabase(entityName: "SubProductTblBeef")
                                    
                                    self.productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: Int(providerObject.providerId))
                                    
                                    self.productPopupFlag = 0
                                    
                                    //                  self.updateBeefProviderId()
                                    //                  self.addBeefProducts()
                                    for i in 0 ..<  self.getListProvider.count {
                                        let myIndexPath = NSIndexPath(row: i, section: 0)
                                        let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                                        let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                                        let arrData =  self.getListProvider[i] as! GetProviderTbl
                                        
                                        if pvid == arrData.providerId {
                                            //                                            item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                                            //                                            item.EcalutionProviderBttn.layer.borderWidth = 2
                                            self.setButtonState(button: item.EcalutionProviderBttn, isOn: true)
                                            
                                        } else {
                                            //                                            item.EcalutionProviderBttn.layer.borderWidth = 1
                                            //                                            item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                                            //                                            item.EcalutionProviderBttn.backgroundColor = UIColor.white
                                            self.setButtonState(button: item.EcalutionProviderBttn, isOn: false)
                                            
                                        }
                                    }
                                        self.productTblView.reloadData()
                                    
                                    
                                    UserDefaults.standard.removeObject(forKey: "beefProduct")
                                    if let  products = self.productArr as? [GetProductTbl] {
                                        for product in products {
                                            product.isAdded = "false"
                                        }
                                    }
                                    deleteRecordFromDatabase(entityName: "OfflineOrderBeef")
                                    deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                                    sender.isSelected = !sender.isSelected
                                    UserDefaults.standard.set(true, forKey: "is_provider_change")
                                    UserDefaults.standard.set(false, forKey: "isAggreForSubmit")
                                    UserDefaults.standard.removeObject(forKey: "breedName")
                                    deleteRecordFromDatabase(entityName: "Saveprovider")
                                    
                                    saveSettingProviderData(entity: "Saveprovider", specisId: providerObject.speciesId ?? "", specisName: self.specname, providerName: providerObject.providerName! , providerId: Int(providerObject.providerId), nominater: "Zoetis", fromDatae: "", toDate: "", status: "true", index: sender.tag)
                                    let fetchAray = fetchAllData(entityName: "Saveprovider")
                                    let pvId = fetchAray.object(at: 0) as! Saveprovider
                                    
                                    self.byDefaultProvider = pvId.providerName!
                                    
                                    for item1 in animaltbl{
                                        if let value = item1 as? BeefAnimaladdTbl{
                                            if animaltbl.count == 1 {
                                                
                                                deleteDataWithAnimalSampleTypeforBeef(value.tissuName!,orderstatus:"false")
                                                // self.createListNameAndCheckifExist()
                                            } else {
                                                deleteDataWithAnimalSampleTypeforBeef(value.tissuName!,orderstatus:"false")
                                            }
                                        }
                                    }
                                    UserDefaults.standard.set(Int(pvId.providerId), forKey: keyValue.providerID.rawValue)
                                    self.updateBeefProviderId()
                                    self.addBeefProducts()
                                    self.createListNameAndCheckifExist()
                                    
                                    
                                }))
                                
                                //  alert.addAction(cancelAction)
                                self.present(alert, animated: true, completion: nil)
                            } else {
                                deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
                                deleteRecordFromDatabase(entityName: "SubProductTblBeef")
                                UserDefaults.standard.set(Int(providerObject.providerId), forKey: "BeefPvid")
                                
                                self.productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: Int(providerObject.providerId))
                                
                                self.productPopupFlag = 0
                                
                                self.updateBeefProviderId()
                                self.addBeefProducts()
                                for i in 0 ..<  self.getListProvider.count {
                                    let myIndexPath = NSIndexPath(row: i, section: 0)
                                    let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                                    let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                                    let arrData =  self.getListProvider[i] as! GetProviderTbl
                                    
                                    if pvid == arrData.providerId {
                                        //                                        item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                                        //                                        item.EcalutionProviderBttn.layer.borderWidth = 2
                                        self.setButtonState(button: item.EcalutionProviderBttn, isOn: true)
                                        
                                        
                                    } else {
                                        //                                        item.EcalutionProviderBttn.layer.borderWidth = 1
                                        //                                        item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                                        //                                        item.EcalutionProviderBttn.backgroundColor = UIColor.white
                                        self.setButtonState(button: item.EcalutionProviderBttn, isOn: false)
                                        
                                    }
                                }
                                    self.productTblView.reloadData()
                            }
                        } else {
                            deleteRecordFromDatabase(entityName: "BeefAnimaladdTbl")
                            UserDefaults.standard.set(Int(providerObject.providerId), forKey: "BeefPvid")
                            
                            self.productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: Int(providerObject.providerId))
                            
                            self.productPopupFlag = 0
                            
                            self.updateBeefProviderId()
                            self.addBeefProducts()
                            for i in 0 ..<  self.getListProvider.count {
                                let myIndexPath = NSIndexPath(row: i, section: 0)
                                let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                                let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                                let arrData =  self.getListProvider[i] as! GetProviderTbl
                                
                                if pvid == arrData.providerId {
//                                    item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
//                                    item.EcalutionProviderBttn.layer.borderWidth = 2
                                    self.setButtonState(button: item.EcalutionProviderBttn, isOn: true)
                                    
                                } else {
//                                    item.EcalutionProviderBttn.layer.borderWidth = 1
//                                    item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
//                                    item.EcalutionProviderBttn.backgroundColor = UIColor.white
                                    self.setButtonState(button: item.EcalutionProviderBttn, isOn: false)

                                }
                            }
                                self.productTblView.reloadData()
                        }
                        
                    }
                    
                }
                
                let cancelAction = UIAlertAction(title: NSLocalizedString("CANCEL", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                    return
                }
                
                // Add the actions
                alertController.addAction(cancelAction)
                alertController.addAction(okAction)
                
                // Present the controller
                self.present(alertController, animated: true, completion: nil)
                return
            }
            else {
                let providerObject : GetProviderTbl = self.getListProvider[sender.tag] as! GetProviderTbl //self.provideCountCheck.object(at: sender.tag) as! GetProviderTbl
                if UserDefaults.standard.value(forKey: "settingDone") == nil || UserDefaults.standard.value(forKey: "settingDone") as? String == ""{
                    UserDefaults.standard.set("true", forKey: "settingDone")
                    if UserDefaults.standard.integer(forKey: "BeefPvid") != Int(providerObject.providerId) {
                        UserDefaults.standard.removeObject(forKey: "beefProduct")
                        if let  products = self.productArr as? [GetProductTbl] {
                            for product in products {
                                product.isAdded = "false"
                            }
                            deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                            deleteRecordFromDatabase(entityName: "BeefAnimaladdTbl")
                            deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
                            deleteRecordFromDatabase(entityName: "SubProductTblBeef")
                            deleteRecordFromDatabase(entityName: "OfflineOrderBeef")
                        }
                    }
                    
                    UserDefaults.standard.set(Int(providerObject.providerId), forKey: "BeefPvid")
                    let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                    self.productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: pvid)
                    
                    self.productPopupFlag = 0
                    
                    for i in 0 ..<  self.getListProvider.count {
                        let myIndexPath = NSIndexPath(row: i, section: 0)
                        let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                        let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                        let arrData = getListProvider[i] as! GetProviderTbl
                        
                        
                        if pvid == arrData.providerId {
                            //                            item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                            //                            item.EcalutionProviderBttn.layer.borderWidth = 2
                            self.setButtonState(button: item.EcalutionProviderBttn, isOn: true)
                            
                            
                        } else {
                            //                            item.EcalutionProviderBttn.layer.borderWidth = 1
                            //                            item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                            //                            item.EcalutionProviderBttn.backgroundColor = UIColor.white
                            self.setButtonState(button: item.EcalutionProviderBttn, isOn: false)
                            
                        }
                    }
                      self.productTblView.reloadData()
                } else{
                    if switchFromDairy == true{
                        switchFromDairy = false
                        UserDefaults.standard.set(true, forKey: "showbeefproductTbl")
                        if UserDefaults.standard.integer(forKey: "BeefPvid") != Int(providerObject.providerId) {
                            
                            
                            UserDefaults.standard.removeObject(forKey: "beefProduct")
                            if let  products = self.productArr as? [GetProductTbl] {
                                for product in products {
                                    product.isAdded = "false"
                                }
                                deleteRecordFromDatabase(entityName: "OfflineOrderBeef")
                                deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                                deleteRecordFromDatabase(entityName: "BeefAnimaladdTbl")
                                deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
                                deleteRecordFromDatabase(entityName: "SubProductTblBeef")
                            }
                        }
                        
                        UserDefaults.standard.set(Int(providerObject.providerId), forKey: "BeefPvid")
                        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                        self.productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: pvid)
                        
                        self.productPopupFlag = 0
                        
                        for i in 0 ..< self.getListProvider.count {
                            let myIndexPath = NSIndexPath(row: i, section: 0)
                            let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                            let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                            let arrData = getListProvider[i] as! GetProviderTbl
                            
                            
                            if pvid == arrData.providerId {
                                self.setButtonState(button: item.EcalutionProviderBttn, isOn: true)
                                
                                
                            } else {
                                self.setButtonState(button: item.EcalutionProviderBttn, isOn: false)
                                
                            }
                        }
                         self.productTblView.reloadData()
                    }
                    else{
                        if UserDefaults.standard.integer(forKey: "BeefPvid") != providerObjects.providerId{
                            let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Are you sure you want to change the product grouping?", comment: "") , preferredStyle: .alert)
                            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default){
                                UIAlertAction in
                                if UserDefaults.standard.integer(forKey: "BeefPvid") != Int(providerObject.providerId) {
                                    
                                    
                                    UserDefaults.standard.removeObject(forKey: "beefProduct")
                                    if let  products = self.productArr as? [GetProductTbl] {
                                        for product in products {
                                            product.isAdded = "false"
                                        }
                                        deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                                        if pvid == 5 || pvid ==  13{
                                            
                                        } else {
                                            deleteRecordFromDatabase(entityName: "BeefAnimaladdTbl")
                                        }
                                        deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
                                        deleteRecordFromDatabase(entityName: "SubProductTblBeef")
                                        deleteRecordFromDatabase(entityName: "OfflineOrderBeef")
                                    }
                                }
                                
                                UserDefaults.standard.set(Int(providerObject.providerId), forKey: "BeefPvid")
                                let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                                self.productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: pvid)
                                
                                self.productPopupFlag = 0
                                
                                for i in 0 ..< self.getListProvider.count {
                                    let myIndexPath = NSIndexPath(row: i, section: 0)
                                    let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                                    let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                                    let arrData = self.getListProvider[i] as! GetProviderTbl
                                    
                                    
                                    if pvid == arrData.providerId {
                                        //                                        item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                                        //                                        item.EcalutionProviderBttn.layer.borderWidth = 2
                                        self.setButtonState(button: item.EcalutionProviderBttn, isOn: true)
                                        
                                        
                                    } else {
                                        //                                        item.EcalutionProviderBttn.layer.borderWidth = 1
                                        //                                        item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                                        //                                        item.EcalutionProviderBttn.backgroundColor = UIColor.white
                                        self.setButtonState(button: item.EcalutionProviderBttn, isOn: false)
                                        
                                    }
                                }
                                self.productTblView.reloadData()
                            }
                            let cancelAction = UIAlertAction(title: NSLocalizedString("CANCEL", comment: ""), style: UIAlertAction.Style.default) {
                                UIAlertAction in
                                NSLog("Cancel Pressed")
                            }
                            alertController.addAction(cancelAction)
                            alertController.addAction(okAction)
                            
                            self.present(alertController, animated: true, completion: nil)
                            return
                        }
                    }
                }
            }
        }
    }
    
    @objc func buttonbgPressed (){
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
    @objc func buttonbgPressedTip (){
        buttonbg1.removeFromSuperview()
        customPopView1.removeFromSuperview()
    }
    
    func crossBtn() {
        buttonbg1.removeFromSuperview()
        customPopView1.removeFromSuperview()
    }
    
    @objc func methodOfReceivedNotification(notification: Notification){
        
        if value == 0
        {
            UserDefaults.standard.set("false", forKey: "FirstLogin")
            let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
            self.hideIndicator()
            value = value + 1
        }
        
    }
    
    @objc  func checkForReachability(notification:Notification){
        let del =  UIApplication.shared.delegate as? AppDelegate
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if NetworkStatusLbl?.text == "Connected".localized{
            self.offLineBtn.isUserInteractionEnabled = false
            networkStatusImg.image = UIImage(named: "status_online_sign")
            
        } else {
            self.offLineBtn.isUserInteractionEnabled = false
            networkStatusImg.image = UIImage(named: "status_offline")
        }
    }
    
    @objc func buttonbgPressedTipInof (){
        buttonbg1.removeFromSuperview()
    }
    
    //MARK: SIDE MENU
    func setSideMenu(){
        if UIDevice.current.orientation.isLandscape {
            self.sideMenuRevealWidth = 300
        }
        else {
            self.sideMenuRevealWidth = 260
            
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapGestureRecognizer))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.delegate = self
        
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewVC = storyboard.instantiateViewController(withIdentifier: "SideMenuVC") as? SideMenuVC
        view.insertSubview(self.sideMenuViewVC!.view, at: self.revealSideMenuOnTop ? 1 : 0)
        addChild(self.sideMenuViewVC!)
        self.sideMenuViewVC!.didMove(toParent: self)
        self.sideMenuViewVC.view.backgroundColor = UIColor.white
        
        // Side Menu AutoLayout
        
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
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGestureRecognizer.delegate = self
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    func animateShadow(targetPosition: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            // When targetPosition is 0, which means side menu is expanded, the shadow opacity is 0.6
            self.sideMenuShadowView.alpha = (targetPosition == 0) ? 0.6 : 0.0
        }
    }
    
    // Call this Button Action from the View Controller you want to Expand/Collapse when you tap a button
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
            // Animate Shadow (Fade In)
            //  UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.6 }
        }
        else {
            self.menuIconLeadingConstraint.constant = 30
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? (-self.sideMenuRevealWidth - self.paddingForRotation) : 0) { _ in
                self.isExpanded = false
                
            }
            // Animate Shadow (Fade Out)
            //  UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.0 }
            
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
}

extension SettingsVC: UIGestureRecognizerDelegate {
    @objc func TapGestureRecognizer(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if self.isExpanded {
                self.sideMenuState(expanded: false)
            }
        }
    }
    
    // Close side menu when you tap on the shadow background view
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.sideMenuViewVC.view))! {
            return false
        }
        return true
    }
    
    // Dragging Side Menu
    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
        
        guard gestureEnabled == true else { return }
        
        let position: CGFloat = sender.translation(in: self.view).x
        let velocity: CGFloat = sender.velocity(in: self.view).x
        
        switch sender.state {
        case .began:
            
            // If the user tries to expand the menu more than the reveal width, then cancel the pan gesture
            if velocity > 0, self.isExpanded {
                sender.state = .cancelled
            }
            
            // If the user swipes right but the side menu hasn't expanded yet, enable dragging
            if velocity > 0, !self.isExpanded {
                self.draggingIsEnabled = true
            }
            // If user swipes left and the side menu is already expanded, enable dragging
            else if velocity < 0, self.isExpanded {
                self.draggingIsEnabled = true
            }
            
            if self.draggingIsEnabled {
                // If swipe is fast, Expand/Collapse the side menu with animation instead of dragging
                let velocityThreshold: CGFloat = 550
                if abs(velocity) > velocityThreshold {
                    self.sideMenuState(expanded: self.isExpanded ? false : true)
                    self.draggingIsEnabled = false
                    return
                }
                
                if self.revealSideMenuOnTop {
                    self.panBaseLocation = 0.0
                    if self.isExpanded {
                        self.panBaseLocation = self.sideMenuRevealWidth
                    }
                }
            }
            
        case .changed:
            
            // Expand/Collapse side menu while dragging
            if self.draggingIsEnabled {
                if self.revealSideMenuOnTop {
                    // Show/Hide shadow background view while dragging
                    let xLocation: CGFloat = self.panBaseLocation + position
                    let percentage = (xLocation * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth
                    
                    let alpha = percentage >= 0.6 ? 0.6 : percentage
                 //   self.sideMenuShadowView.alpha = alpha
                    
                    // Move side menu while dragging
                    if xLocation <= self.sideMenuRevealWidth {
                        self.sideMenuTrailingConstraint.constant = xLocation - self.sideMenuRevealWidth
                    }
                }
                else {
                    if let recogView = sender.view?.subviews[1] {
                        // Show/Hide shadow background view while dragging
                        let percentage = (recogView.frame.origin.x * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth
                        
                        let alpha = percentage >= 0.6 ? 0.6 : percentage
                        self.sideMenuShadowView.alpha = alpha
                        
                        // Move side menu while dragging
                        if recogView.frame.origin.x <= self.sideMenuRevealWidth, recogView.frame.origin.x >= 0 {
                            recogView.frame.origin.x = recogView.frame.origin.x + position
                            sender.setTranslation(CGPoint.zero, in: view)
                        }
                    }
                }
            }
        case .ended:
            self.draggingIsEnabled = false
            // If the side menu is half Open/Close, then Expand/Collapse with animation
            if self.revealSideMenuOnTop {
                let movedMoreThanHalf = self.sideMenuTrailingConstraint.constant > -(self.sideMenuRevealWidth * 0.5)
                self.sideMenuState(expanded: movedMoreThanHalf)
            }
            else {
                if let recogView = sender.view?.subviews[1] {
                    let movedMoreThanHalf = recogView.frame.origin.x > self.sideMenuRevealWidth * 0.5
                    self.sideMenuState(expanded: movedMoreThanHalf)
                }
            }
        default:
            break
        }
    }
    
    func sideMenuRevealSettingsViewController() -> SettingsVC? {
        var viewController: UIViewController? = self
        
        if viewController != nil && viewController is SettingsVC {
            return viewController! as? SettingsVC
        }
        while (!(viewController is SettingsVC) && viewController?.parent != nil) {
            viewController = viewController?.parent
        }
        if viewController is SettingsVC {
            return viewController as? SettingsVC
        }
        return nil
    }
}
