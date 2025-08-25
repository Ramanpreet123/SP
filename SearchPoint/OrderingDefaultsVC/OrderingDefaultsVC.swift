
//
//  OrderingDefaultsVC.swift
//  SearchPoint
//
//  Created by "" on 01/10/2019.
//  ""
// Beef - product Grouping

import UIKit
import Alamofire
import Gigya
import GigyaTfa
import GigyaAuth

class OrderingDefaultsVC: UIViewController ,offlineCustomView1 {
    var isGenotypeOnlyAdded = false
    let gigya =  Gigya.sharedInstance(GigyaAccount.self)
    @IBOutlet weak var bioMetricSwitch: UISwitch!
    var isGenostarblackOnlyAdded = false
    @IBOutlet weak var datePickerViewOutlet: NSLayoutConstraint!
    
    @IBOutlet weak var bioMetricView: UIView!
    @IBOutlet weak var keyBaordSepratorView: UIImageView!
    @IBOutlet weak var keyBoardTopView: NSLayoutConstraint!
    @IBOutlet weak var btn_KeyboardInfo: UIButton!
    @IBOutlet weak var btnSwitch: UISwitch!
    @IBOutlet weak var datePickerLabel: UILabel!
    
    @IBOutlet weak var manualEnteryLabel: UILabel!
    @IBOutlet weak var dateOfBirthTile: UILabel!
    
    @IBOutlet weak var ocrBackroundBtnOutlet: UIButton!
    @IBOutlet weak var sampleTagsTitle: UILabel!
    @IBOutlet weak var scannerViewShow: UIView!
    @IBOutlet weak var ocrInfoBtnOutle: UIButton!
    var imageArray = ["tag_1","tag_3"]
    @IBOutlet weak var ocrBtnOutlet: UIButton!
    @IBOutlet weak var tblViewhRIGHTcON: NSLayoutConstraint!
    var productName = String()
    var didselectTouched = false
    @IBOutlet weak var selctProductLbl: UILabel!
    @IBOutlet weak var providerTitleLbl: UILabel!
    @IBOutlet weak var productTblView: UITableView!
    var productPopupFlag = 0
    @IBOutlet weak var primarlyHeightConst: NSLayoutConstraint!
    @IBOutlet weak var continueOrderBttn: UIButton!
    @IBOutlet weak var speciesCollectionView: UICollectionView!
    @IBOutlet weak var evalutionProviderCV: UICollectionView!
    @IBOutlet weak var calendarViewBkg: UIView!
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var farmIdBttn: UIButton!
    @IBOutlet weak var rfidBttn: UIButton!
    var brazilProduct = [String]()
    @IBOutlet weak var billingView: UIView!
    var productArr = NSArray()
    var productSelected  =  [GetProductTbl]()
    var ScreenDef = String()
    var switchFromDairy = Bool()
    @IBOutlet weak var networkStatusImg: UIImageView!
    var byDefaultProvider = "CLARIFIDE CDCB (US)"
    @IBOutlet weak var nominatorHeightConst: NSLayoutConstraint!
    @IBOutlet weak var speciesCollectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var primarlyBasedView: UIView!
    @IBOutlet weak var NetworkStatusLbl: UILabel!
    
    @IBOutlet weak var keyBaordFullView: UIView!
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var marketView: UIView!
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
    @IBOutlet weak var menuBttn: UIButton!
    var dataModel:LoginModel?
    
    @IBOutlet weak var marketTipYopOutlet: customButton!
    let custId = UserDefaults.standard.integer(forKey: "currentActiveCustomerId")
    
    @IBOutlet weak var dateBtnOutlet: customButton!
    @IBOutlet weak var date1BtnOutlet: customButton!
    @IBOutlet weak var offLineBtn: UIButton!
    @IBOutlet weak var holsteinBtnOutlet: customButton!
    @IBOutlet weak var zoetisBtnOutlet: customButton!
    let dateFormatter = DateFormatter()
    let locale = NSLocale.current
    var datePicker : UIDatePicker!
    let toolBar = UIToolbar()
    var isSelectedArray = [Bool]()
    
    let buttonbg1 = UIButton ()
    var customPopView1 :TipPopUp!
    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var evalutionProvideOutlet: customButton!
    var editflag :Int?
    var langId = UserDefaults.standard.value(forKey: "lngId") as! Int
    var inheritInfoButtonFrame = CGFloat.zero
    var customerOrderSetting = CustomerOrderSetting()
    var speiecCountCheck = NSArray()
    var provideCountCheck = [GetProviderTbl]()
    var getListProvider  = [GetProviderTbl]()
    var customerProviders = [GetProviderTbl]()
    
    var customerMarkets = [CustomerMarkets]()
    let userId = UserDefaults.standard.integer(forKey: "userId")
    @IBOutlet weak var idScannerTitle: UILabel!
    @IBOutlet weak var scannerSepratorBar: UIImageView!
    
    @IBOutlet weak var scannerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var keyBoardViewHeight: NSLayoutConstraint!
    @IBOutlet weak var keyboardTtile: UILabel!
    @IBOutlet weak var keyboardSepratorTitle: UIImageView!
    
    var fetchDataEntry : [DataEntryList] = []
    var listName = String()
    let orderingDatalistVM = OrderingDataListViewModel()
    @IBOutlet weak var providerCollectionViewHeight: NSLayoutConstraint!
    
    func getMarketsForCurrentCustomer() {
        if let currentCustomerId = UserDefaults.standard.value(forKey: "currentActiveCustomerId") as? Int {
            let markets = fetchAllDataWithCustomerID(entityName: "CustomerMarkets", customerId: currentCustomerId)
            self.customerMarkets = markets as? [CustomerMarkets] ?? []
            
        }
    }
    let pvidDairy = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if(UserDefaults.standard.value(forKey: "scrollIsEnable") as? Bool ?? true){
            btnSwitch.isOn = true
        }
        else{
            btnSwitch.isOn = false
        }
        btnSwitch.addTarget(self, action: #selector(switchScrollChanged), for: UIControl.Event.valueChanged)
        holsteinBtnOutlet.isHidden = true
        if UIDevice().userInterfaceIdiom == .phone {
            ocrViewShow.isHidden = true
            ocrBackroundBtnOutlet.isHidden = true
            calendarViewBkg.isHidden = true
        }
        
        getMarketsForCurrentCustomer()
        
        UserDefaults.standard.set( 1, forKey: "SpeciesId")
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        date1BtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
        
        
        let datevalue = UserDefaults.standard.value(forKey: "date") as? String
        if datevalue == "MM"{
            dateBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            date1BtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
            date1BtnOutlet.layer.borderWidth = 1
            dateBtnOutlet.layer.borderWidth = 2
        }
        else if datevalue == "DD" {
            date1BtnOutlet.layer.borderColor =  UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            dateBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
            
            date1BtnOutlet.layer.borderWidth = 2
            
            dateBtnOutlet.layer.borderWidth = 1
        } else {
            dateBtnOutlet.layer.borderWidth = 2
            
        }
        
        self.speiecCountCheck = fetchSpeciesAllData(entityName: "GetSpeciesTbl")
        if UserDefaults.standard.value(forKey: "name") as? String == "CLARIFIDE CDCB (US)" {
            UserDefaults.standard.setValue("Dairy", forKey: "name")
        }
        if UserDefaults.standard.value(forKey: "name") as? String == "Dairy" ||  UserDefaults.standard.value(forKey: "name") as? String == nil  {
            self.provideCountCheck = fetchdataOfProvider(specisId: "074dc82b-2b82-4ee6-99c6-f9691937394d") as! [GetProviderTbl]
            getListProvider = providerEvaliuater(arr: provideCountCheck)
            if getListProvider.count == 0 {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("No associated evaluation provider found for this customer in the app.", comment: ""))
                marketView.isHidden = true
                providerTitleLbl.isHidden = true
            } else {
                if UIDevice().userInterfaceIdiom == .phone {
                    marketView.isHidden = false
                    providerTitleLbl.isHidden = false
                }
                
            }
            
        }
        
        else if UserDefaults.standard.value(forKey: "name") as? String == "Beef" {
            
            self.provideCountCheck = fetchdataOfProvider(specisId: "151e2230-9a01-4828-a105-d87a92b5be2f") as! [GetProviderTbl]
            
            getListProvider = providerEvaliuater(arr: provideCountCheck)
            if getListProvider.count == 0 {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("No associated product found for this customer in the app.", comment: ""))
                marketTipYopOutlet.isHidden = true
                marketView.isHidden = true
                providerTitleLbl.isHidden = true
            } else {
                marketTipYopOutlet.isHidden = true
                marketView.isHidden = true
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
                rfidBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                ocrBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                rfidBtnOutlet.layer.borderWidth = 2
                ocrBtnOutlet.layer.borderWidth = 1
            } else {
                ocrBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                rfidBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                ocrBtnOutlet.layer.borderWidth = 2
                rfidBtnOutlet.layer.borderWidth = 1
            }
            
            if pvidDairy == 2 {
                UserDefaults.standard.set("ocr", forKey: "scannerSelection")
                ocrBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                rfidBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                ocrBtnOutlet.layer.borderWidth = 2
                rfidBtnOutlet.layer.borderWidth = 1
                
                
            }
            
            else {
                UserDefaults.standard.set("rfid", forKey: "scannerSelection")
                rfidBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                ocrBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                rfidBtnOutlet.layer.borderWidth = 2
                ocrBtnOutlet.layer.borderWidth = 1
                
            }
            
            
            if pvidDairy == 3{
                numericKeyBoardBtnOutle.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                alphaNumericbtnOutler.layer.borderColor = UIColor.lightGray.cgColor
                numericKeyBoardBtnOutle.layer.borderWidth = 2
                alphaNumericbtnOutler.layer.borderWidth = 1
                UserDefaults.standard.set("Numeric", forKey: "keyboardSelection")
                
            } else {
                alphaNumericbtnOutler.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                numericKeyBoardBtnOutle.layer.borderColor = UIColor.lightGray.cgColor
                alphaNumericbtnOutler.layer.borderWidth = 2
                numericKeyBoardBtnOutle.layer.borderWidth = 1
                
                UserDefaults.standard.set("alphaNumeric", forKey: "keyboardSelection")
            }
            
            UserDefaults.standard.set("pickerMode", forKey: "defaultDatePicker")
            self.datePickerEntryOutlet.setImage(UIImage(named: "Filled"), for: .normal)
            self.defaultEntryModeOutlet.setImage(UIImage(named: "empty"), for: .normal)
            
        } else {
            
            let fetchDat = fetchSettingData.object(at: 0) as? OrderSettings
            let fetchDat1 = fetchDat?.scannerSelection
            let beefScanner = fetchDat?.beefUSscannerSelection
            let keyboardSelection = fetchDat?.keyboardSelection
            let defaultDatePicker = fetchDat?.defaultDatePicker
            if fetchDat?.speciesName == "Dairy" && fetchDat?.providerName == "US Dairy Products"{
                UserDefaults.standard.set(fetchDat1, forKey: "scannerSelection")
                if fetchDat1 == "ocr"  {
                    ocrBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    rfidBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                    ocrBtnOutlet.layer.borderWidth = 2
                    rfidBtnOutlet.layer.borderWidth = 1
                    UserDefaults.standard.set("ocr", forKey: "scannerSelection")
                }
                
                else {
                    rfidBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    ocrBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                    rfidBtnOutlet.layer.borderWidth = 2
                    ocrBtnOutlet.layer.borderWidth = 1
                    UserDefaults.standard.set("rfid", forKey: "scannerSelection")
                }
                
            } else if (fetchDat?.speciesName == "Beef" && fetchDat?.providerName == "US Dairy Products") || (fetchDat?.speciesName == "Beef" && fetchDat?.providerName == "CLARIFIDE CDCB (US)")  {
                if beefScanner == "ocr" && fetchDat?.providerName == "US Dairy Products" {
                    ocrBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    rfidBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                    ocrBtnOutlet.layer.borderWidth = 2
                    rfidBtnOutlet.layer.borderWidth = 1
                    UserDefaults.standard.set("ocr", forKey: "beefScannerSelection")
                } else {
                    rfidBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    ocrBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                    rfidBtnOutlet.layer.borderWidth = 2
                    ocrBtnOutlet.layer.borderWidth = 1
                    UserDefaults.standard.set("rfid", forKey: "beefScannerSelection")
                }
            }
            
            else if pvidDairy == 2 {
                UserDefaults.standard.set("ocr", forKey: "scannerSelection")
                ocrBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                rfidBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                ocrBtnOutlet.layer.borderWidth = 2
                rfidBtnOutlet.layer.borderWidth = 1
                
                
            } else {
                UserDefaults.standard.set("rfid", forKey: "scannerSelection")
                rfidBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                ocrBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                rfidBtnOutlet.layer.borderWidth = 2
                ocrBtnOutlet.layer.borderWidth = 1
                UserDefaults.standard.set("rfid", forKey: "scannerSelection")
                
            }
    
            if defaultDatePicker == "defaultEntry" {
                
                UserDefaults.standard.set("defaultEntry", forKey: "defaultDatePicker")
                self.defaultEntryModeOutlet.setImage(UIImage(named: "Filled"), for: .normal)
                self.datePickerEntryOutlet.setImage(UIImage(named: "empty"), for: .normal)
                
            } else {
                
                UserDefaults.standard.set("pickerMode", forKey: "defaultDatePicker")
                self.datePickerEntryOutlet.setImage(UIImage(named: "Filled"), for: .normal)
                self.defaultEntryModeOutlet.setImage(UIImage(named: "empty"), for: .normal)
                
            }
            
            
            if keyboardSelection == "alphaNumeric" {
                alphaNumericbtnOutler.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                numericKeyBoardBtnOutle.layer.borderColor = UIColor.lightGray.cgColor
                alphaNumericbtnOutler.layer.borderWidth = 2
                numericKeyBoardBtnOutle.layer.borderWidth = 1
                
                UserDefaults.standard.set("alphaNumeric", forKey: "keyboardSelection")
                
            } else if keyboardSelection == "Numeric" {
                
                numericKeyBoardBtnOutle.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                alphaNumericbtnOutler.layer.borderColor = UIColor.lightGray.cgColor
                numericKeyBoardBtnOutle.layer.borderWidth = 2
                alphaNumericbtnOutler.layer.borderWidth = 1
                UserDefaults.standard.set("Numeric", forKey: "keyboardSelection")
                
            } else {
                
                if pvidDairy == 3{
                    numericKeyBoardBtnOutle.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    alphaNumericbtnOutler.layer.borderColor = UIColor.lightGray.cgColor
                    numericKeyBoardBtnOutle.layer.borderWidth = 2
                    alphaNumericbtnOutler.layer.borderWidth = 1
                    UserDefaults.standard.set("Numeric", forKey: "keyboardSelection")
                    
                } else {
                    alphaNumericbtnOutler.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    numericKeyBoardBtnOutle.layer.borderColor = UIColor.lightGray.cgColor
                    alphaNumericbtnOutler.layer.borderWidth = 2
                    numericKeyBoardBtnOutle.layer.borderWidth = 1
                    UserDefaults.standard.set("alphaNumeric", forKey: "keyboardSelection")
                    
                    
                }
            }
        }
        
        if UIDevice().userInterfaceIdiom == .phone {
            idScannerTitle.text = "Select Scanner Type".localized
            
            sampleTagsTitle.text = NSLocalizedString("Sample Tags", comment: "")
            keyboardTtile.text = NSLocalizedString("Select keyboard for On-Farm ID", comment: "")
            
            rfidBtnOutlet.setTitle(NSLocalizedString("RFID Scanner", comment: ""), for: .normal)
            
            alphaNumericbtnOutler.setTitle(NSLocalizedString("Alphanumeric", comment: ""), for: .normal)
            numericKeyBoardBtnOutle.setTitle(NSLocalizedString("Numeric", comment: ""), for: .normal)
            ocrBtnOutlet.setTitle(NSLocalizedString("Mobile camera (OCR)", comment: ""), for: .normal)
            dateOfBirthTile.text = NSLocalizedString("Date of Birth Input Mode", comment: "")
            datePickerLabel.text = NSLocalizedString("Date Picker", comment: "")
            manualEnteryLabel.text = NSLocalizedString("Manual Entry", comment: "")
            selctProductLbl.text = NSLocalizedString("Select Product(s)", comment: "")
            productDoneClick.setTitle(NSLocalizedString("Done", comment: ""), for: .normal)
        }
    }
    
    
    @IBAction func actionBtnIKeyBoardnfo(_ sender: Any) {
        
        
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(OrderingDefaultsVC.buttonbgPressedTip), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view .addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed("TipPopUp") as? TipPopUp
        
        if langId == 1{
            
            var yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 18) -  self.scrolView.contentOffset.y
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 1136:
                    break
                case 1334:
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 8) -  self.scrolView.contentOffset.y
                    
                case 1920, 2208:
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 18) -  self.scrolView.contentOffset.y
                    
                case 2436:
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 24) -  self.scrolView.contentOffset.y
                    
                case 2688,2796:
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 38) -  self.scrolView.contentOffset.y
                    
                case 1792:
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 38) -  self.scrolView.contentOffset.y
                    
                default:
                    break
                }
            }
            
            customPopView1.elipseImage2.isHidden = true
            customPopView1.elipseImage1.isHidden = false
            customPopView1.textLbl2.isHidden = false
            customPopView1.textLabel1.isHidden = false
            
            if(self.keyBoardViewHeight.constant == 90){
                customPopView1.frame = CGRect(x: 52,y: yFrame+20 ,width: 310, height: 120)
            }
            else{
                customPopView1.frame = CGRect(x: 52,y: yFrame+120 ,width: 310, height: 120)
            }
            
            customPopView1.textLabel1.text = NSLocalizedString("When enabled, keyboard will be persisted while screen scrolling and when disabled, keyboard will close while scrolling the screen.", comment: "")
            customPopView1.textLbl2.isHidden = true
            customPopView1.arrow_left.isHidden = true
            customPopView1.arrow_Top.frame = CGRect(x: btn_KeyboardInfo.frame.minX - 45 , y: -24, width: 26, height: 26)
            customPopView1.delegate = self
            customPopView1.layer.borderColor = UIColor.blue.cgColor
            customPopView1.layer.borderWidth = 1
            customPopView1.layer.cornerRadius = 8
            customPopView1.layer.borderWidth = 3
            customPopView1.layer.borderColor =  UIColor.clear.cgColor
            self.buttonbg1.addSubview(customPopView1)
        }else {
            var yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 18) -  self.scrolView.contentOffset.y
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 1136:
                    break
                case 1334:
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 8) -  self.scrolView.contentOffset.y
                    
                case 1920, 2208:
                    break
                case 2436:
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 24) -  self.scrolView.contentOffset.y
                    
                case 2688,2796:
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 3621) -  self.scrolView.contentOffset.y
                    
                case 1792:
                    yFrame = (keyBaordFullView.layer.frame.minY + 11 + 133 + 36) -  self.scrolView.contentOffset.y
                    
                default:
                    break
                }
            }
            
            
            
            customPopView1.elipseImage2.isHidden = true
            customPopView1.elipseImage1.isHidden = false
            customPopView1.textLbl2.isHidden = false
            customPopView1.textLabel1.isHidden = false
            if(self.keyBoardViewHeight.constant == 90){
                customPopView1.frame = CGRect(x: 52,y: yFrame+20 ,width: 310, height: 120)
            }
            else{
                customPopView1.frame = CGRect(x: 52,y: yFrame+120 ,width: 310, height: 120)
            }
            customPopView1.textLabel1.text =  NSLocalizedString("When enabled, keyboard will be persisted while screen scrolling and when disabled, keyboard will close while scrolling the screen.", comment: "")
            customPopView1.textLbl2.isHidden = true
            customPopView1.arrow_left.isHidden = true
            customPopView1.arrow_Top.frame = CGRect(x: btn_KeyboardInfo.frame.minX - 45 , y: -24, width: 26, height: 26)
            customPopView1.delegate = self
            customPopView1.layer.borderColor = UIColor.blue.cgColor
            customPopView1.layer.borderWidth = 1
            customPopView1.layer.cornerRadius = 8
            customPopView1.layer.borderWidth = 3
            customPopView1.layer.borderColor =  UIColor.clear.cgColor
            self.buttonbg1.addSubview(customPopView1)
        }
        
        
    }
    
    @objc func switchScrollChanged(mySwitch: UISwitch) {
        if(!mySwitch.isOn){
            UserDefaults.standard.set(false, forKey: "scrollIsEnable")
        }
        else{
            UserDefaults.standard.set(true, forKey: "scrollIsEnable")
        }
        
    }
    
    @IBOutlet weak var productDoneClick: UIButton!
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
    
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AppHelpImagesVC") as? AppHelpImagesVC
        vc?.module = "Place an Order: Ordering Defaults".localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
    }
    
    
    @IBOutlet weak var alphaNumericbtnOutler: customButton!
    @IBAction func alphaNumericKeyboardAction(_ sender: Any) {
        alphaNumericbtnOutler.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        numericKeyBoardBtnOutle.layer.borderColor = UIColor.lightGray.cgColor
        alphaNumericbtnOutler.layer.borderWidth = 2
        numericKeyBoardBtnOutle.layer.borderWidth = 1
        UserDefaults.standard.set("alphaNumeric", forKey: "keyboardSelection")
    }
    
    @IBOutlet weak var numericKeyBoardBtnOutle: customButton!
    @IBAction func numericKeyBoardAction(_ sender: Any) {
        numericKeyBoardBtnOutle.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        alphaNumericbtnOutler.layer.borderColor = UIColor.lightGray.cgColor
        numericKeyBoardBtnOutle.layer.borderWidth = 2
        alphaNumericbtnOutler.layer.borderWidth = 1
        UserDefaults.standard.set("Numeric", forKey: "keyboardSelection")
    }
    
    @IBAction func donePopUpClick(_ sender: Any) {
        let userId = UserDefaults.standard.integer(forKey: "userId")
        
        UserDefaults.standard.set(nil, forKey: "On")
        let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        
        UserDefaults.standard.set(nil, forKey: "page")
        
        if  didselectTouched {
            UserDefaults.standard.set(false, forKey: "showbeefproductTbl")
            if pvid == 5 {
                deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
                deleteRecordFromDatabase(entityName: "SubProductTblBeef")
                deleteRecordFromDatabase(entityName: "OfflineOrderBeef")
                for product in self.productArr as? [GetProductTbl] ?? [] {
                    if pvid == 5 {
                        saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"false", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                    } else {
                        if product.isAdded == "true" {
                            
                            UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                            saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                        }
                    }
                    
                }
            }
            if pvid == 6 {
                deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                deleteRecordFromDatabase(entityName: "BeefAnimaladdTbl")
                deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
                deleteRecordFromDatabase(entityName: "OfflineOrderBeef")
                for product in self.productArr as? [GetProductTbl] ?? [] {
                    if product.isAdded == "true" {
                        UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                        saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                        
                    }
                    else {
                        deleteDataWithProductBeef(entityName: "GetProductTblBeef", productId: Int(product.productId))
                    }
                    
                }
                let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                let  orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
                
                let animalData =  beefFetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", pvid: pvid)
                if animalData.count > 0 {
                    
                    
                    let product  = fetchAllData(entityName: "GetProductTblBeef")
                    
                    for k in 0 ..< animalData.count{
                        
                        let animalId = animalData[k] as! BeefAnimaladdTbl
                        
                        for i in 0 ..< product.count {
                            
                            let data = product[i] as! GetProductTblBeef
                            
                            beefSaveProductAdonTbl(entity: "ProductAdonAnimlTbLBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: animalId.farmId ?? "" , orderId: Int(animalId.orderId), orderStatus: "false", isSync: "false", userId: userId,udid:animalId.udid ?? "", animalId:  Int(animalId.animalId), rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "", marketName: data.marketName ?? "",custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"), orderTerrms: data.orderAcceptTerms ?? "")
                            
                        }
                    }
                }
                let selectedProduct = fetchAllData(entityName: "GetProductTblBeef")
                let name = "GeneSTAR\u{00ae} Black"
                for product in selectedProduct as? [GetProductTblBeef] ?? [] {
                    if product.productName?.uppercased() == "Genotype Only".uppercased() {
                        UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                        isGenotypeOnlyAdded = true
                    }
                    else if product.productName == name
                    {
                        UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                        self.isGenostarblackOnlyAdded = true
                    }
                    else
                    {
                        UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                        
                    }
                }
                
                
                if isGenotypeOnlyAdded
                {
                    if isGenostarblackOnlyAdded  && isGenotypeOnlyAdded
                    {
                        UserDefaults.standard.set("GenotypeStarblack", forKey: "beefProduct")
                    }
                    else{
                        UserDefaults.standard.set("Genotype Only", forKey: "beefProduct")
                    }
                    
                }
                else {
                    if isGenostarblackOnlyAdded
                    {
                        UserDefaults.standard.set("GenStarblack", forKey: "beefProduct")
                    }
                    else
                    {
                        UserDefaults.standard.set("Non-Genotype", forKey: "beefProduct")
                    }
                }
            }
        }
        
        let fetchPid = fetchAllData(entityName: "GetProductTblBeef")
        if fetchPid.count > 0 {
            if let productTblBeef = fetchPid[0] as? GetProductTblBeef {
                if UserDefaults.standard.value(forKey: "settingDone") == nil || UserDefaults.standard.value(forKey: "settingDone") as? String == ""{
                    if UserDefaults.standard.string(forKey: "name") == "Beef"{
                        let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                        if pvid == 13 {
                            UserDefaults.standard.set("true", forKey: "settingDone")
                        }
                        if pvid == 5 {
                            UserDefaults.standard.set("true", forKey: "settingDone")
                            if productTblBeef.productId == 20 {
                                UserDefaults.standard.set(true, forKey: "showbeefInheritTable")
                                UserDefaults.standard.set("INHERIT", forKey: "beefProduct")
                                
                            }
                            else{
                                UserDefaults.standard.set("Global HD50K", forKey: "beefProduct")
                            }
                            
                            UserDefaults.standard.set("true", forKey: "settingDone")
                            
                            if UserDefaults.standard.value(forKey: "dataEntryScreenSave") as? String == "dataEntry" {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DataEntryModeHelpVC")), animated: true)
                                
                            }else {
                                
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalGlobalHD50KVC")), animated: true)
                            }
                        }
                        if pvid == 6{
                            
                            UserDefaults.standard.set("true", forKey: "settingDone")
                            if UserDefaults.standard.value(forKey: "dataEntryScreenSave") as? String == "dataEntry" {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DataEntryModeHelpVC")), animated: true)
                                
                            }else {
                                
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalBrazilVC")), animated: true)
                            }}
                        if pvid == 7{
                            
                            UserDefaults.standard.set("true", forKey: "settingDone")
                            if UserDefaults.standard.value(forKey: "dataEntryScreenSave") as! String == "dataEntry" {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DataEntryModeHelpVC")), animated: true)
                                
                            }else {
                                
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalNZ_VC")), animated: true)
                            }}
                    }
                    
                    
                    
                } else {
                    if UserDefaults.standard.string(forKey: "name") == "Dairy"{
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
                    }
                    if UserDefaults.standard.string(forKey: "name") == "Beef"{
                        let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                        if pvid == 5 {
                            
                            if productTblBeef.productId == 20 {
                                UserDefaults.standard.set(true, forKey: "showbeefInheritTable")
                                UserDefaults.standard.set("INHERIT", forKey: "beefProduct")
                                
                            }
                            else {
                                UserDefaults.standard.set("Global HD50K", forKey: "beefProduct")
                            }
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
                            
                        }
                        if pvid == 6{
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
                        }
                        if pvid == 7{
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
                        }
                    }
                }
            }
            calendarViewBkg.isHidden = true
            billingView.isHidden = true
        } else {
            if pvid == 6 {
                deleteRecordFromDatabase(entityName: "GetProductTblBeef")
            }else{
                deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                deleteRecordFromDatabase(entityName: "BeefAnimaladdTbl")
                deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
                deleteRecordFromDatabase(entityName: "SubProductTblBeef")
                deleteRecordFromDatabase(entityName: "OfflineOrderBeef")
            }
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please select the product(s)", comment: ""))
        }
    }
    
    @IBAction func backBtnClk(_ sender: UIButton) {
        self.customerOrderSetting.saveCustomerSetting()
        
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
    }
    
    @IBAction func dateAction(_ sender: UIButton) {
        UserDefaults.standard.set("MM", forKey: "date")
        dateBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        dateBtnOutlet.layer.borderWidth = 2
        date1BtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
        date1BtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        date1BtnOutlet.layer.borderWidth = 1
        
    }
    
    @IBAction func dateAction1(_ sender: UIButton) {
        UserDefaults.standard.set("DD", forKey: "date")
        date1BtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        dateBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
        date1BtnOutlet.layer.borderWidth = 2
        dateBtnOutlet.layer.borderWidth = 1
        dateBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        
    }
    
    @IBAction func zoetisBtnAction(_ sender: Any) {
        UserDefaults.standard.set("Zoetis", forKey: "NominatorSave")
        zoetisBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        holsteinBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
        zoetisBtnOutlet.layer.borderWidth = 2
        holsteinBtnOutlet.layer.borderWidth = 1
    }
    
    
    @IBAction func holsteinBtnAction(_ sender: Any) {
        UserDefaults.standard.set("Holstein USA", forKey: "NominatorSave")
        holsteinBtnOutlet.layer.borderColor =    UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        zoetisBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
        zoetisBtnOutlet.layer.borderWidth = 1
        holsteinBtnOutlet.layer.borderWidth = 2
    }
    
    @IBAction func continueToOrderBtnClk(_ sender: UIButton) {
        
        if UserDefaults.standard.value(forKey: "name") as? String  == "Beef"{
            if (UserDefaults.standard.integer(forKey:"BeefPvid") as? Int)! == 0 {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr:NSLocalizedString("Please select a product grouping.", comment: "") )
                return
            }
        } else {
            if (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue) as? Int)! == 0 {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr:NSLocalizedString("Please select an evaluation provider.", comment: "") )
                return
            }
        }
        
        if UserDefaults.standard.value(forKey: "NominatorSave") == nil || UserDefaults.standard.value(forKey: "NominatorSave") as? String == ""{
            UserDefaults.standard.set("Zoetis", forKey: "NominatorSave")
        }
        UserDefaults.standard.set("true", forKey: "settingDefault")
        
        if UserDefaults.standard.value(forKey: "settingDone") == nil || UserDefaults.standard.value(forKey: "settingDone") as? String == ""{
            
            if UserDefaults.standard.string(forKey: "name") == "Dairy"{
                UserDefaults.standard.set("true", forKey: "settingDone")
                let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue) as? Int)!
                
                if UserDefaults.standard.value(forKey: "dataEntryScreenSave") as? String == "dataEntry" {
                    
                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DataEntryModeHelpVC")), animated: true)
                    
                    
                } else {
                    
                    if pviduser == 4 {
                        
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "OrderingAnimalVCGirlando")), animated: true)
                    } else {
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "OrderingAnimalVC")), animated: true)
                    }
                }
                
            }
            if UserDefaults.standard.string(forKey: "name") == "Beef" {
                
                guard UserDefaults.standard.integer(forKey: "BeefPvid") != 0 else {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr:NSLocalizedString("Please select a product grouping.", comment: "") )
                    return
                }
                let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                
                UserDefaults.standard.set("true", forKey: "settingDone")
                if pvid == 5 {
                    self.productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: pvid)
                    deleteRecordFromDatabase(entityName: "SelectedQuestionaire")
                    UserDefaults.standard.set(true, forKey: "showbeefInheritTable")
                    UserDefaults.standard.set(true, forKey: "showbeefInheritTable")
                    if let  products = productArr as? [GetProductTbl] {
                        for product in products {
                            product.isAdded = "true"
                            
                            UserDefaults.standard.set(product.productId, forKey: "chpid")
                        }
                        
                    }
                    deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                    
                    for product in self.productArr as? [GetProductTbl] ?? [] {
                        
                        UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                        saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"false", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                    }
                    UserDefaults.standard.set("INHERIT", forKey: "beefProduct")
                    if productPopupFlag == 0{
                        let fetchPid = fetchAllData(entityName: "GetProductTblBeef") as! [GetProductTblBeef]
                        if fetchPid.count > 0 {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                let foundProductName = fetchPid.filter{$0.productName?.uppercased() == product.productName?.uppercased() }
                                if foundProductName.count > 0 {
                                    product.isAdded = foundProductName[0].isAdded
                                } else {
                                    product.isAdded = "false"
                                }
                            }
                        }
                        else {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                product.isAdded = "false"
                            }
                        }
                        
                        if UserDefaults.standard.value(forKey: "dataEntryScreenSave") as! String == "dataEntry" {
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DataEntryModeHelpVC")), animated: true)
                            
                        }else {
                            
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalGlobalHD50KVC")), animated: true)
                        }
                        productTblView.reloadData()
                        
                    } else {
                        productPopupFlag = 0
                        
                        if UserDefaults.standard.value(forKey: "dataEntryScreenSave") as! String == "dataEntry" {
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DataEntryModeHelpVC")), animated: true)
                            
                        }else {
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalGlobalHD50KVC")), animated: true)
                        }
                    }
                }
                if pvid == 13 {
                    self.productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: pvid)
                    deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                    
                    deleteRecordFromDatabase(entityName: "SelectedQuestionaire")
                    if let  products = productArr as? [GetProductTbl] {
                        for product in products {
                            product.isAdded = "true"
                            
                            UserDefaults.standard.set(product.productId, forKey: "chpid")
                        }
                        
                    }
                    
                    for product in self.productArr as? [GetProductTbl] ?? [] {
                        if product.isAdded == "true" {
                            
                            UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                            saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: "87c30632-8da0-4f86-8d94-46da17c520dd", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                        }
                    }
                    
                    if productPopupFlag == 0{
                        let fetchPid = fetchAllData(entityName: "GetProductTblBeef") as! [GetProductTblBeef]
                        if fetchPid.count > 0 {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                let foundProductName = fetchPid.filter{$0.productName?.uppercased() == product.productName?.uppercased() }
                                if foundProductName.count > 0 {
                                    product.isAdded = foundProductName[0].isAdded
                                } else {
                                    product.isAdded = "false"
                                }
                            }
                        } else {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                product.isAdded = "false"
                            }
                        }
                        
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefUSAddAnimalVC")), animated: true)
                        
                        productTblView.reloadData()
                        
                    }
                    
                }
                
                if pvid == 6 {
                    self.productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: pvid)
                    deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                    deleteRecordFromDatabase(entityName: "BeefAnimaladdTbl")
                    deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
                    deleteRecordFromDatabase(entityName: "OfflineOrderBeef")
                    for product in self.productArr as? [GetProductTbl] ?? [] {
                        if product.isAdded == "true" {
                            UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                            saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                            
                        }
                        else {
                            deleteDataWithProductBeef(entityName: "GetProductTblBeef", productId: Int(product.productId))
                        }
                        
                    }
                    if productPopupFlag == 0 {
                        let fetchPid = fetchAllData(entityName: "GetProductTblBeef") as! [GetProductTblBeef]
                        if fetchPid.count > 0 {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                product.isAdded = "false"
                            }
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                let foundProductName = fetchPid.filter{$0.productName?.uppercased() == product.productName?.uppercased() }
                                if foundProductName.count > 0 {
                                    product.isAdded = foundProductName[0].isAdded
                                } else {
                                    product.isAdded = "false"
                                }
                            }
                            
                        } else {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                product.isAdded = "false"
                            }
                        }
                        
                        productPopupFlag = 1
                        calendarViewBkg.isHidden = false
                        billingView.isHidden = false
                        productTblView.reloadData()
                        
                    } else {
                        productPopupFlag = 0
                        if UserDefaults.standard.value(forKey: "dataEntryScreenSave") as! String == "dataEntry" {
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DataEntryModeHelpVC")), animated: true)
                            
                        } else {
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalBrazilVC")), animated: true)
                        }
                    }
                }
                
                UserDefaults.standard.set("true", forKey: "beefProductAdded")
            }
            
        } else {
            UserDefaults.standard.set("true", forKey: "settingDone")
            
            if UserDefaults.standard.string(forKey: "name") == "Dairy"{
                
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
            }
            if UserDefaults.standard.string(forKey: "name") == "Beef"{
                
                guard UserDefaults.standard.integer(forKey: "BeefPvid") != 0 else {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please select a product grouping.", comment: ""))
                    return
                }
                
                UserDefaults.standard.set("true", forKey: "beefProductAdded")
                
                let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                
                if pvid == 5 {
                    self.productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: Int(pvid))
                    deleteRecordFromDatabase(entityName: "SelectedQuestionaire")
                    UserDefaults.standard.set(true, forKey: "showbeefInheritTable")
                    if let  products = productArr as? [GetProductTbl] {
                        for product in products {
                            product.isAdded = "true"
                            
                            UserDefaults.standard.set(product.productId, forKey: "chpid")
                        }
                    }
                    
                    deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                    for product in self.productArr as? [GetProductTbl] ?? [] {
                        
                        UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                        saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"false", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                    }
                    UserDefaults.standard.set("INHERIT", forKey: "beefProduct")
                    if productPopupFlag == 0 {
                        let fetchPid = fetchAllData(entityName: "GetProductTblBeef") as! [GetProductTblBeef]
                        if fetchPid.count > 0 {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                let foundProductName = fetchPid.filter{$0.productName?.uppercased() == product.productName?.uppercased() }
                                if foundProductName.count > 0 {
                                    product.isAdded = foundProductName[0].isAdded
                                } else {
                                    product.isAdded = "false"
                                }
                            }
                        } else {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                product.isAdded = "false"
                            }
                        }
                        
                        productPopupFlag = 1
                        productTblView.reloadData()
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
                    }
                    else{
                        productPopupFlag = 0
                        
                        if UserDefaults.standard.value(forKey: "dataEntryScreenSave") as! String == "dataEntry" {
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DataEntryModeHelpVC")), animated: true)
                            
                        }else {
                            
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalGlobalHD50KVC")), animated: true)
                        }
                    }
                }
                if pvid == 13 {
                    self.productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: pvid)
                    deleteRecordFromDatabase(entityName: "SelectedQuestionaire")
                    deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                    if let  products = productArr as? [GetProductTbl] {
                        for product in products {
                            product.isAdded = "true"
                            
                            UserDefaults.standard.set(product.productId, forKey: "chpid")
                        }
                        
                    }
                    for product in self.productArr as? [GetProductTbl] ?? [] {
                        if product.isAdded == "true" {
                            UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                            saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                        }
                    }
                    UserDefaults.standard.set("INHERIT", forKey: "beefProduct")
                    if productPopupFlag == 0 {
                        let fetchPid = fetchAllData(entityName: "GetProductTblBeef") as! [GetProductTblBeef]
                        if fetchPid.count > 0 {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                let foundProductName = fetchPid.filter{$0.productName?.uppercased() == product.productName?.uppercased() }
                                if foundProductName.count > 0 {
                                    product.isAdded = foundProductName[0].isAdded
                                } else {
                                    product.isAdded = "false"
                                }
                            }
                        } else {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                product.isAdded = "false"
                            }
                        }
                        
                        productPopupFlag = 1
                        productTblView.reloadData()
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
                    }
                    else{
                        productPopupFlag = 0
                        
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefUSAddAnimalVC")), animated: true)
                    }
                }
                
                
                if pvid == 6 {
                    self.productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: pvid)
                    
                    if productPopupFlag == 0 {
                        deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                        for product in self.productArr as? [GetProductTbl] ?? [] {
                            if product.isAdded == "true" {
                                
                                UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                                saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                            }
                        }
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
                    } else {
                        productPopupFlag = 0
                        if UserDefaults.standard.value(forKey: "dataEntryScreenSave") as! String == "dataEntry" {
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DataEntryModeHelpVC")), animated: true)
                            
                        } else {
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalBrazilVC")), animated: true)
                        }}
                }
                
                if pvid == 7 {
                    self.productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: pvid)
                    if productPopupFlag == 0 {
                        
                        for product in self.productArr as? [GetProductTbl] ?? [] {
                            product.isAdded = "true"
                        }
                        
                        for product in self.productArr as? [GetProductTbl] ?? [] {
                            if product.isAdded == "true" {
                                deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                                UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                                saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                            }
                        }
                        
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
                        
                    } else {
                        productPopupFlag = 0
                        if UserDefaults.standard.value(forKey: "dataEntryScreenSave") as! String == "dataEntry" {
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DataEntryModeHelpVC")), animated: true)
                            
                        }else {
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalNZ_VC")), animated: true)
                        }}
                }
            }
        }
        self.customerOrderSetting.saveCustomerSetting()
    }
    
    
    @IBAction func sideMenuAction(_ sender: UIButton) {
        self.customerOrderSetting.saveCustomerSetting()
        self.sideMenuViewController?.presentRightMenuViewController()
        self.view.makeCorner(withRadius: 40)
    }
    var value = 0
    @objc func methodOfReceivedNotification(notification: Notification)
    {
        
        if value == 0
        {
            UserDefaults.standard.set("false", forKey: "FirstLogin")
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
            self.hideIndicator()
            value = value + 1
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(Notification.Name("NotificationIdentifier"))
    }
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        
        if UIDevice().userInterfaceIdiom == .phone {
            calendarViewBkg.isHidden = true
            productTblView.delegate = self
            productTblView.dataSource = self
            initialNetworkCheck()
            billingView.isHidden = true
        }
        
        let screen  = UserDefaults.standard.value(forKey: "screen") as? String
        if screen == "farmid"{
            farmIdBttn.layer.borderColor =  UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            rfidBttn.layer.borderColor = UIColor.lightGray.cgColor
            farmIdBttn.layer.borderWidth = 2
            rfidBttn.layer.borderWidth = 1
        }
        
        else if  screen == "officialid"{
            farmIdBttn.layer.borderWidth = 1
            rfidBttn.layer.borderWidth = 2
            farmIdBttn.layer.borderColor =    UIColor.lightGray.cgColor
            rfidBttn.layer.borderColor =  UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
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
                        
                        
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderingAnimalVC") as! OrderingAnimalVC
                        self.navigationController?.pushViewController(newViewController, animated: false)
                    }}}
        }
        
        
        for _ in 0 ..< provideCountCheck.count{
            isSelectedArray.append(false)
        }
        
        self.navigationController?.navigationBar.isHidden = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        
        
        let checkValue = UserDefaults.standard.value(forKey: "settingDone") as? String
        if checkValue == "true" {
            continueOrderBttn.setTitle(NSLocalizedString("Done", comment: ""), for: .normal)
            screenTitle.text = NSLocalizedString("Settings", comment: "")
        }
        else {
            continueOrderBttn.setTitle(NSLocalizedString("Continue to Ordering", comment: ""), for: .normal)
            screenTitle.text = NSLocalizedString("Ordering Defaults", comment: "")
        }
        
        
        let zoeties = UserDefaults.standard.value(forKey: "NominatorSave") as? String
        
        if zoeties == nil || zoeties == "Zoetis" || zoeties == ""{
            zoetisBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            holsteinBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
            zoetisBtnOutlet.layer.borderWidth = 2
            holsteinBtnOutlet.layer.borderWidth = 1
        }
        else{
            holsteinBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            zoetisBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
            zoetisBtnOutlet.layer.borderWidth = 1
            holsteinBtnOutlet.layer.borderWidth = 2
        }
        
        if UserDefaults.standard.string(forKey: "providerNameUS") == nil {
            byDefaultProvider = "CLARIFIDE CDCB (US)"
        }
        else{
            
            byDefaultProvider = UserDefaults.standard.string(forKey: "providerNameUS")!
            if byDefaultProvider == "CLARIFIDE Girolando (BR)"
            {
                UserDefaults.standard.set(4, forKey: keyValue.providerID.rawValue)
            }
        }
        if UserDefaults.standard.string(forKey: "name") == nil{
            UserDefaults.standard.set("Dairy", forKey: "name")
        }
        getListProvider = providerEvaliuater(arr: provideCountCheck)
        
        
        if UserDefaults.standard.string(forKey: "name") == "Dairy"{
            
            
            if  UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 1 ||  UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 2 ||  UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 3 || UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 8 || UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 10 || UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 11 || UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 12 {
                
                self.keyBaordSepratorView.isHidden = true
                self.keyBoardViewHeight.constant = 200
                self.scannerViewHeight.constant = 100
                keyboardTtile.isHidden = false
                keyboardSepratorTitle.isHidden = false
                keyboardTtile.isHidden = false
                keyboardSepratorTitle.isHidden = false
                alphaNumericbtnOutler.isHidden = false
                idScannerTitle.isHidden = false
                scannerSepratorBar.isHidden = false
                numericKeyBoardBtnOutle.isHidden = false
                ocrBtnOutlet.isHidden = false
                rfidBtnOutlet.isHidden = false
                ocrInfoBtnOutle.isHidden = false
                
                if getListProvider.count == 0 {
                    marketTipYopOutlet.isHidden = true
                    marketView.isHidden = true
                    providerTitleLbl.isHidden = true
                } else {
                    marketTipYopOutlet.isHidden = false
                    marketView.isHidden = false
                    providerTitleLbl.isHidden = false
                }
                
                if UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 11 {
                    primarlyHeightConst.constant = 0
                    nominatorHeightConst.constant = 100
                    
                } else if UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 2{
                    primarlyHeightConst.constant = 0
                }
                
                else {
                    primarlyHeightConst.constant = 156
                }
            }else {
                self.keyBaordSepratorView.isHidden = false
                self.keyBoardViewHeight.constant = 90
                self.keyBoardTopView.constant = 5
                keyboardSepratorTitle.isHidden = false
                self.scannerViewHeight.constant = 0
                keyboardTtile.isHidden = true
                
                keyboardTtile.isHidden = true
                
                ocrInfoBtnOutle.isHidden = true
                primarlyHeightConst.constant = 0
                alphaNumericbtnOutler.isHidden = true
                idScannerTitle.isHidden = true
                scannerSepratorBar.isHidden = true
                numericKeyBoardBtnOutle.isHidden = true
                ocrBtnOutlet.isHidden = true
                rfidBtnOutlet.isHidden = true
                
                if getListProvider.count == 0 {
                    marketTipYopOutlet.isHidden = true
                    marketView.isHidden = true
                    providerTitleLbl.isHidden = true
                } else {
                    marketTipYopOutlet.isHidden = false
                    marketView.isHidden = false
                    providerTitleLbl.isHidden = false
                }
                
            }
            
            if UserDefaults.standard.string(forKey: "providerNameUS") == "CLARIFIDE CDCB (US)" || UserDefaults.standard.string(forKey: "providerNameUS") == "US Dairy Products" {
                nominatorHeightConst.constant = 100
                
            }else  if UserDefaults.standard.string(forKey: "providerNameUS") == "CLARIFIDE CDCB (BR)"{
                nominatorHeightConst.constant = 100
                
            }
            else  if UserDefaults.standard.string(forKey: "ProviderName") == "CLARIFIDE CDCB (IT)" || UserDefaults.standard.string(forKey: "ProviderName") == "CLARIFIDE CDCB (BeNeLux)" || UserDefaults.standard.string(forKey: "ProviderName") == "CLARIFIDE CDCB (CAN)" {
                nominatorHeightConst.constant = 100
            }
            else{
                nominatorHeightConst.constant = 0
            }
            providerTitleLbl.text = NSLocalizedString("Evaluation Provider/Market", comment: "")
            marketView.isHidden = false
            primaryBasedOutlet.isHidden = false
            productTblView.reloadData()
        }
        else{
            
            marketView.isHidden = false
            primaryBasedOutlet.isHidden = true
            providerTitleLbl.text = NSLocalizedString("Product Groupings", comment: "")
            let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
            productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: pvid)
            primarlyHeightConst.constant = 0
            nominatorHeightConst.constant = 0
            productTblView.reloadData()
            self.keyBaordSepratorView.isHidden = false
            self.keyBoardViewHeight.constant = 90
            self.keyBoardTopView.constant = 5
            keyboardSepratorTitle.isHidden = false
            self.scannerViewHeight.constant = 0
            keyboardTtile.isHidden = true
            
            alphaNumericbtnOutler.isHidden = true
            idScannerTitle.isHidden = true
            scannerSepratorBar.isHidden = true
            numericKeyBoardBtnOutle.isHidden = true
            ocrBtnOutlet.isHidden = true
            rfidBtnOutlet.isHidden = true
            ocrInfoBtnOutle.isHidden = true
            if getListProvider.count == 0 {
                marketTipYopOutlet.isHidden = true
                marketView.isHidden = true
                providerTitleLbl.isHidden = true
            } else {
                marketTipYopOutlet.isHidden = true
                marketView.isHidden = true
                providerTitleLbl.isHidden = false
            }
            
            if UserDefaults.standard.integer(forKey:"BeefPvid") == 13 || UserDefaults.standard.integer(forKey:"BeefPvid") == 5 && (UserDefaults.standard.string(forKey: "providerNameUS") == "CLARIFIDE CDCB (US)" || UserDefaults.standard.string(forKey: "providerNameUS") == "US Dairy Products")  {
                self.scannerViewHeight.constant = 100
                idScannerTitle.isHidden = false
                rfidBtnOutlet.isHidden = false
                ocrBtnOutlet.isHidden = false
                ocrInfoBtnOutle.isHidden = false
                if UserDefaults.standard.object(forKey: "beefScannerSelection") as? String == "ocr"{
                    ocrBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    rfidBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                    ocrBtnOutlet.layer.borderWidth = 2
                    rfidBtnOutlet.layer.borderWidth = 1
                } else {
                    rfidBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    ocrBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                    rfidBtnOutlet.layer.borderWidth = 2
                    ocrBtnOutlet.layer.borderWidth = 1
                }
            } else {
                self.scannerViewHeight.constant = 0
                idScannerTitle.isHidden = true
                rfidBtnOutlet.isHidden = true
                ocrBtnOutlet.isHidden = true
                ocrInfoBtnOutle.isHidden = true
            }
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
    
    @IBAction func farmIDAction(_ sender: UIButton) {
        farmIdBttn.layer.borderColor =  UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        rfidBttn.layer.borderColor = UIColor.lightGray.cgColor
        ScreenDef = "farmid"
        UserDefaults.standard.set(ScreenDef, forKey: "screen")
        
        UserDefaults.standard.set(ScreenDef, forKey: "FOReviewOrderVC")
        UserDefaults.standard.set(ScreenDef, forKey: "FOSampleTrackingDetailVC")
        farmIdBttn.layer.borderWidth = 2
        rfidBttn.layer.borderWidth = 1
    }
    @IBOutlet weak var ocrViewShow: UIView!
    
    @IBOutlet weak var ocrCollectionView: UICollectionView!
    
    @IBAction func ocrInfoCrossBtnAction(_ sender: UIButton) {
        
        
        ocrViewShow.isHidden = true
        ocrBackroundBtnOutlet.isHidden = true
        
    }
    @IBAction func ocrInfoPopAction(_ sender: UIButton) {
        self.ocrViewShow.isHidden = false
        ocrBackroundBtnOutlet.isHidden = false
        ocrViewShow.layer.cornerRadius = 13
    }
    
    @IBAction func ocrBackRoundInfoBtn(_ sender: UIButton) {
        ocrViewShow.isHidden = true
        ocrBackroundBtnOutlet.isHidden = true
    }
    
    @objc func buttonbgPressedTipInof (){
        buttonbg1.removeFromSuperview()
    }
    
    @IBAction func rfidAction(_ sender: UIButton) {
        ScreenDef = "officialid"
        UserDefaults.standard.set(ScreenDef, forKey: "screen")
        UserDefaults.standard.set(ScreenDef, forKey: "FOSampleTrackingDetailVC")
        UserDefaults.standard.set(ScreenDef, forKey: "FOReviewOrderVC")
        
        farmIdBttn.layer.borderColor =    UIColor.lightGray.cgColor
        rfidBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        farmIdBttn.layer.borderWidth = 1
        rfidBttn.layer.borderWidth = 2
        
    }
    
    @IBAction func marketTipPopClick(_ sender: UIButton) {
        
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(OrderingDefaultsVC.buttonbgPressedTip), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view.addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed("TipPopUp") as? TipPopUp
        customPopView1.arrow_left.isHidden = true
        
        var yFrame = (marketView.layer.frame.minY + 148) - self.scrolView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
            case 1334:
                yFrame = (marketView.layer.frame.minY + 148 - 7 + 3) - self.scrolView.contentOffset.y
            case 1920, 2208:
                yFrame = (marketView.layer.frame.minY + 148 - 7 + 15) - self.scrolView.contentOffset.y
                
            case 2436:
                yFrame = (marketView.layer.frame.minY + 148 + 15) - self.scrolView.contentOffset.y
            case 2688,2796:
                yFrame = (marketView.layer.frame.minY + 148 + 27) - self.scrolView.contentOffset.y
            case 1792:
                yFrame = (marketView.layer.frame.minY + 148 + 27) - self.scrolView.contentOffset.y
            default:
                break
            }
        }
        
        
        customPopView1.elipseImage2.isHidden = true
        customPopView1.elipseImage1.isHidden = true
        customPopView1.textLbl2.isHidden = true
        customPopView1.frame = CGRect(x: 39,y: yFrame  ,width: screenSize.width - 80, height: 155)
        customPopView1.textLabel1.text =  NSLocalizedString("This is the genetic evaluation body that will provide your genomic test results. This will be selected by default based upon your market, but may be switched if required to order an evaluation from a different provider. There are restrictions on being able to change this setting.", comment: "")
        customPopView1.arrow_Top.frame = CGRect(x: marketView.layer .frame.minX - 32 , y: -24, width: 26, height: 26)
        
        customPopView1.delegate = self
        customPopView1.layer.borderColor = UIColor.blue.cgColor
        customPopView1.layer.borderWidth = 1
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1.addSubview(customPopView1)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView!) {
        // This method is  left empty because of no use, will delete later
    }
    
    
    @IBOutlet weak var primaryBasedOutlet: customButton!
    
    @IBAction func primarlyBasedTipPopClock(_ sender: UIButton) {
        
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(OrderingDefaultsVC.buttonbgPressedTip), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view .addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed("TipPopUp") as? TipPopUp
        
        var yFrame = (primarlyBasedView.layer.frame.minY + 11 + 133 + 18) -  self.scrolView.contentOffset.y
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
            case 1334:
                yFrame = (primarlyBasedView.layer.frame.minY + 11 + 133 + 8) -  self.scrolView.contentOffset.y
                
            case 1920, 2208:
                yFrame = (primarlyBasedView.layer.frame.minY + 11 + 133 + 18) -  self.scrolView.contentOffset.y
                
            case 2436:
                yFrame = (primarlyBasedView.layer.frame.minY + 11 + 133 + 24) -  self.scrolView.contentOffset.y
                
            case 2688,2796:
                yFrame = (primarlyBasedView.layer.frame.minY + 11 + 133 + 38) -  self.scrolView.contentOffset.y
                
            case 1792:
                yFrame = (primarlyBasedView.layer.frame.minY + 11 + 133 + 38) -  self.scrolView.contentOffset.y
                
            default:
                break
            }
        }
        
        
        customPopView1.elipseImage2.isHidden = false
        customPopView1.elipseImage1.isHidden = false
        customPopView1.textLbl2.isHidden = false
        customPopView1.textLabel1.isHidden = false
        
        customPopView1.frame = CGRect(x: 52,y: yFrame ,width: 310, height: 133)
        customPopView1.textLabel1.text = NSLocalizedString("On-Farm ID can be the Herd Management #.", comment: "")
        customPopView1.textLbl2.text = NSLocalizedString("Official ID can be an Official RFID Tag, Unique Metal Ear Tag, Breed Registration#.", comment: "")
        customPopView1.arrow_left.isHidden = true
        customPopView1.arrow_Top.frame = CGRect(x: primaryBasedOutlet.frame.minX - 45 , y: -24, width: 26, height: 26)
        customPopView1.delegate = self
        customPopView1.layer.borderColor = UIColor.blue.cgColor
        customPopView1.layer.borderWidth = 1
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1.addSubview(customPopView1)
    }
    
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
    
    
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    
    @IBAction func offlineBtnAction(_ sender: UIButton) {
        
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(OrderingDefaultsVC.buttonbgPressed), for: .touchUpInside)
        buttonbg.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view .addSubview(buttonbg)
        customPopView = OfflinePopUp.loadFromNibNamed("OfflinePopUp") as? OfflinePopUp
        customPopView.delegate = self
        customPopView.frame = CGRect(x: 30,y: 160,width: screenSize.width - 30,height: screenSize.height/1.7)
        
        customPopView.center = view.center
        customPopView.layer.cornerRadius = 8
        customPopView.layer.borderWidth = 3
        customPopView.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg .addSubview(customPopView)
        
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        productPopupFlag = 0
        calendarViewBkg.isHidden = true
        billingView.isHidden = true
        let fetchPid = fetchAllData(entityName: "GetProductTblBeef")
        if fetchPid.count == 0 {
            UserDefaults.standard.set(true, forKey: "showbeefproductTbl")
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
    
    
    
    @IBAction func ocrBtnAction(_ sender: Any) {
        let spName = UserDefaults.standard.value(forKey: "name") as? String
        if spName != "Dairy" {
            if UserDefaults.standard.integer(forKey:"BeefPvid") == 13 || UserDefaults.standard.integer(forKey:"BeefPvid") == 5 {
                UserDefaults.standard.set("ocr", forKey: "beefScannerSelection")
            }
        }else {
            UserDefaults.standard.set("ocr", forKey: "scannerSelection")
        }
        
        ocrBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        rfidBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
        ocrBtnOutlet.layer.borderWidth = 2
        rfidBtnOutlet.layer.borderWidth = 1
        
    }
    
    @IBOutlet weak var rfidBtnOutlet: customButton!
    
    @IBAction func rfidBtnAction(_ sender: Any) {
        let spName = UserDefaults.standard.value(forKey: "name") as? String
        
        if UserDefaults.standard.integer(forKey:"BeefPvid") == 13 || UserDefaults.standard.integer(forKey:"BeefPvid") == 5 && spName != "Dairy" {
            UserDefaults.standard.set("rfid", forKey: "beefScannerSelection")
        } else {
            
            UserDefaults.standard.set("rfid", forKey: "scannerSelection")
        }
        
        rfidBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        ocrBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
        rfidBtnOutlet.layer.borderWidth = 2
        ocrBtnOutlet.layer.borderWidth = 1
        
    }
    
    
    
    @IBOutlet weak var datePickerEntryOutlet: UIButton!
    
    @IBAction func datePickerEntryAction(_ sender: Any) {
        
        UserDefaults.standard.set("pickerMode", forKey: "defaultDatePicker")
        self.datePickerEntryOutlet.setImage(UIImage(named: "Filled"), for: .normal)
        self.defaultEntryModeOutlet.setImage(UIImage(named: "empty"), for: .normal)
    }
    
    @IBOutlet weak var defaultEntryModeOutlet: UIButton!
    @IBAction func defaultEntryModeAction(_ sender: Any) {
        
        UserDefaults.standard.set("defaultEntry", forKey: "defaultDatePicker")
        self.defaultEntryModeOutlet.setImage(UIImage(named: "Filled"), for: .normal)
        self.datePickerEntryOutlet.setImage(UIImage(named: "empty"), for: .normal)
        
    }
    
    
    @IBAction func action_bioMetric(_ sender: UISwitch) {
        if sender.isOn {
            bioMetricSwitch.isOn = true
            gigya.biometric.optIn { (result) in
                
                switch result {
                case .success:
                    UserDefaults.standard.setValue(true, forKey: "BioMetricEnabled")
                case .failure: break
                    // Action failed
                }
            }
        }
        else {
            bioMetricSwitch.isOn = false
            gigya.biometric.optOut{ (result) in
                
                switch result {
                case .success:
                    UserDefaults.standard.setValue(false, forKey: "BioMetricEnabled")
                case .failure: break
                    // Action failed
                }
            }
            
        }
    }
}
extension OrderingDefaultsVC:offlineCustomView{
    func crossBtnCall() {
        
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
}
extension OrderingDefaultsVC: UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 1 {
            return speiecCountCheck.count
            
        }
        else {
            return getListProvider.count
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView.tag == 1{
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: "species", for: indexPath) as! SpeciesCollectionViewCell
            let data = speiecCountCheck[indexPath.row] as! GetSpeciesTbl
            let spName = UserDefaults.standard.value(forKey: "name") as? String
            
            item.speciesBttn.setTitle(NSLocalizedString("\(data.speciesName ?? "")", comment: ""), for: .normal )
            item.speciesBttn.addTarget(self, action: #selector(OrderingDefaultsVC.specisButton(_:)) , for: .touchUpInside )
            item.speciesBttn.tag = indexPath.row
            
            if data.speciesName!  == spName{
                item.speciesBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                item.speciesBttn.isUserInteractionEnabled = true
                item.speciesBttn.layer.borderWidth = 2
                item.speciesBttn.isSelected = true
            }
            else {
                item.speciesBttn.layer.borderColor = UIColor.gray.cgColor
                item.speciesBttn.layer.borderWidth = 1
                item.speciesBttn.isSelected = false
            }
            
            
            if indexPath.row == 2 {
                item.speciesBttn.layer.borderColor = UIColor.gray.cgColor
                item.speciesBttn.layer.borderWidth = 1
                item.speciesBttn.alpha = 0.3
                item.speciesBttn.isSelected = false
            } else {
                item.speciesBttn.alpha = 1
                item.speciesBttn.isSelected = true
            }
            return item
        }
        else  {
            marketTipYopOutlet.isHidden = false
            let spName = UserDefaults.standard.value(forKey: "name") as? String
            
            if spName == "Dairy" {
                let item = evalutionProviderCV.dequeueReusableCell(withReuseIdentifier: "provider", for: indexPath) as! EvaluationProviderViewCell
                
                if UserDefaults.standard.string(forKey: "providerNameUS") == "CLARIFIDE CDCB (US)" || UserDefaults.standard.string(forKey: "providerNameUS") == "US Dairy Products"{
                    nominatorHeightConst.constant = 100
                    
                }
                else  if UserDefaults.standard.string(forKey: "providerNameUS") == "CLARIFIDE CDCB (BR)"{
                    nominatorHeightConst.constant = 100
                    
                }else  {
                    nominatorHeightConst.constant = 0
                }
                
                item.EcalutionProviderBttn.tag = indexPath.row
                let arrData = getListProvider[indexPath.row]
                item.EcalutionProviderBttn.setTitle("\(arrData.providerName!)", for: .normal )
                item.EcalutionProviderBttn.setTitleColor(UIColor.gray, for: .normal)
                item.EcalutionProviderBttn.titleLabel?.lineBreakMode = .byWordWrapping
                self.provideCountCheck = fetchdataOfProvider(specisId: "074dc82b-2b82-4ee6-99c6-f9691937394d") as! [GetProviderTbl]
                getListProvider = providerEvaliuater(arr: provideCountCheck)
                
                if getListProvider.count == 1 || getListProvider.count == 2 {
                    
                    providerCollectionViewHeight.constant = 70
                } else if getListProvider.count == 0 {
                    providerCollectionViewHeight.constant = 0
                    
                }else {
                    providerCollectionViewHeight.constant = 140
                    
                }
                
                var pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
                if pvid == 0{
                    UserDefaults.standard.setValue(getListProvider[0].providerId, forKey: keyValue.providerID.rawValue)
                    pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
                }
                if pvid == arrData.providerId{
                    item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    item.EcalutionProviderBttn.layer.borderWidth = 2
                    UserDefaults.standard.set(arrData.providerName, forKey: "ProviderName")
                    
                    
                } else {
                    item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                    item.EcalutionProviderBttn.backgroundColor = UIColor.white
                    item.EcalutionProviderBttn.layer.borderWidth = 1
                    
                }
             
                item.EcalutionProviderBttn.addTarget(self, action: #selector(OrderingDefaultsVC.providerButton(_:)) , for: .touchUpInside )
                
                return item
                
            } else {
                self.provideCountCheck = fetchdataOfProvider(specisId: "151e2230-9a01-4828-a105-d87a92b5be2f") as! [GetProviderTbl]
                getListProvider = providerEvaliuater(arr: provideCountCheck)
                let item = evalutionProviderCV.dequeueReusableCell(withReuseIdentifier: "provider", for: indexPath) as! EvaluationProviderViewCell
                item.EcalutionProviderBttn.tag = indexPath.row
                item.isUserInteractionEnabled = true
                let arrData = getListProvider[indexPath.row] as? GetProviderTbl
                item.EcalutionProviderBttn.setTitle("\(arrData!.providerName!)", for: .normal )
                item.EcalutionProviderBttn.setTitleColor(UIColor.gray, for: .normal)
                
                if getListProvider.count == 1 || getListProvider.count == 2 {
                    
                    providerCollectionViewHeight.constant = 70
                } else if getListProvider.count == 0 {
                    providerCollectionViewHeight.constant = 0
                    
                }else {
                    providerCollectionViewHeight.constant = 140
                    
                }
                
                var pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                if pvid == 0{
                    UserDefaults.standard.setValue(getListProvider[0].providerId, forKey: "BeefPvid")
                    pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                }
                if pvid == arrData!.providerId {
                    item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    item.EcalutionProviderBttn.layer.borderWidth = 2
                } else {
                    item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                    item.EcalutionProviderBttn.backgroundColor = UIColor.white
                    item.EcalutionProviderBttn.layer.borderWidth = 1
                }
                if pvid == 5 {
                    marketTipYopOutlet.isHidden = true
                }
                
                item.EcalutionProviderBttn.addTarget(self, action: #selector(OrderingDefaultsVC.providerButton(_:)) , for: .touchUpInside )
                
                return item
                
            }
        }
    }
    
    
    @objc func specisButton(_ sender:UIButton) {
        
        UserDefaults.standard.set(false, forKey: "isAggreForSubmit")
        let specisObject : GetSpeciesTbl = speiecCountCheck.object(at: sender.tag) as! GetSpeciesTbl
        
        sender.titleLabel?.text = (specisObject.speciesName)?.localized
        
        if specisObject.speciesName ==  "Dairy" {
            
            if sender.layer.borderColor == UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor {
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
                let selectedDairyProvider = getListProvider.filter({$0.isDefault })
                if UserDefaults.standard.object(forKey: keyValue.providerID.rawValue) == nil {
                    if selectedDairyProvider.count > 0{
                        UserDefaults.standard.setValue(selectedDairyProvider[0].providerId, forKey: keyValue.providerID.rawValue)
                    }
                }
                marketTipYopOutlet.isHidden = false
                marketView.isHidden = false
                providerTitleLbl.isHidden = false
                
            }
            
            
            switchFromDairy = true
            marketView.isHidden = false
            primaryBasedOutlet.isHidden = false
            providerTitleLbl.text = NSLocalizedString("Evaluation Provider/Market", comment: "")
            
            if UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 1 ||  UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 2 ||  UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 3
                || UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 8 || UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 11 ||
                UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 12 ||
                UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 10{
                self.keyBoardViewHeight.constant = 200
                self.scannerViewHeight.constant = 100
                self.keyBoardTopView.constant = 115
                ocrInfoBtnOutle.isHidden = false
                self.keyBaordSepratorView.isHidden = false
                
                primarlyHeightConst.constant = 156
                keyboardTtile.isHidden = false
                keyboardSepratorTitle.isHidden = false
                alphaNumericbtnOutler.isHidden = false
                idScannerTitle.isHidden = false
                scannerSepratorBar.isHidden = false
                numericKeyBoardBtnOutle.isHidden = false
                ocrBtnOutlet.isHidden = false
                rfidBtnOutlet.isHidden = false
                if UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue ) == 2{
                    primarlyHeightConst.constant = 0
                }
            }
            else {
                self.keyBaordSepratorView.isHidden = false
                self.keyBoardViewHeight.constant = 90
                self.keyBoardTopView.constant = 5
                keyboardSepratorTitle.isHidden = false
                self.scannerViewHeight.constant = 0
                keyboardTtile.isHidden = true
                alphaNumericbtnOutler.isHidden = true
                idScannerTitle.isHidden = true
                scannerSepratorBar.isHidden = true
                numericKeyBoardBtnOutle.isHidden = true
                ocrBtnOutlet.isHidden = true
                rfidBtnOutlet.isHidden = true
                ocrBtnOutlet.isHidden = true
                rfidBtnOutlet.isHidden = true
                primarlyHeightConst.constant = 0
            }
            
            if UserDefaults.standard.string(forKey: "providerNameUS") == "CLARIFIDE CDCB (US)" || UserDefaults.standard.string(forKey: "providerNameUS") == "US Dairy Products"{
                self.nominatorHeightConst.constant = 100
                
            }
            else if  UserDefaults.standard.string(forKey: "providerNameUS") == "CLARIFIDE CDCB (BR)"{
                self.nominatorHeightConst.constant = 100
                
            }
            else {
                self.nominatorHeightConst.constant = 0
            }
            sender.isSelected = !sender.isSelected
            if sender.isSelected {
                sender.isSelected = true
                sender.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            } else {
                sender.isSelected = false
                sender.setImage(nil, for: .normal)
                sender.layer.borderColor = UIColor.lightGray.cgColor
                sender.backgroundColor = UIColor.white
            }
            for _ in 0 ..< provideCountCheck.count{
                isSelectedArray.append(false)
            }
            specname = specisObject.speciesName!
            UserDefaults.standard.set(specname, forKey: "name")
            UserDefaults.standard.set(specisObject.speciesId, forKey: "SpeciesId")
            saveSettingData(entity: "SettingTbl", specisId: specisObject.speciesId ?? "", specisName: specisObject.speciesName ?? "", providerName: "", providerId: 0, nominater: "Zoetis", fromDatae: "", toDate: "", status: "true",index: sender.tag)
            
            if UserDefaults.standard.object(forKey: "scannerSelection") as? String == "ocr"{
                ocrBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                rfidBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                ocrBtnOutlet.layer.borderWidth = 2
                rfidBtnOutlet.layer.borderWidth = 1
                UserDefaults.standard.set("ocr", forKey: "scannerSelection")
            } else {
                rfidBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                ocrBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                rfidBtnOutlet.layer.borderWidth = 2
                ocrBtnOutlet.layer.borderWidth = 1
                UserDefaults.standard.set("rfid", forKey: "scannerSelection")
            }
            
            
        }  else if specisObject.speciesName ==  "Beef" {
            if sender.layer.borderColor == UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor {
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
                
            } else {
                getListProvider = providercheck
                let selectedProvider = getListProvider.filter({$0.isDefault })
                if selectedProvider.count > 0 {
                    if UserDefaults.standard.integer(forKey:"BeefPvid") == 13 || UserDefaults.standard.integer(forKey:"BeefPvid") == 5 {
                        if UserDefaults.standard.object(forKey: "beefScannerSelection") as? String ==  nil && UserDefaults.standard.string(forKey: "ProviderName") == "US Dairy Products" {
                            UserDefaults.standard.set("ocr", forKey: "beefScannerSelection")
                        }
                    }
                }
                marketView.isHidden = true
                marketTipYopOutlet.isHidden = true
                providerTitleLbl.isHidden = false
            }
            
            self.keyBaordSepratorView.isHidden = false
            self.keyBoardViewHeight.constant = 90
            self.keyBoardTopView.constant = 5
            keyboardSepratorTitle.isHidden = false
            self.scannerViewHeight.constant = 0
            keyboardTtile.isHidden = true
            
            alphaNumericbtnOutler.isHidden = true
            idScannerTitle.isHidden = true
            scannerSepratorBar.isHidden = true
            numericKeyBoardBtnOutle.isHidden = true
            ocrBtnOutlet.isHidden = true
            
            rfidBtnOutlet.isHidden = true
            ocrInfoBtnOutle.isHidden = true
            switchFromDairy = true
            primaryBasedOutlet.isHidden = true
            providerTitleLbl.text = NSLocalizedString("Product Groupings", comment: "")
            primarlyHeightConst.constant = 0
            nominatorHeightConst.constant = 0
            sender.isSelected = !sender.isSelected
            if sender.isSelected {
                sender.isSelected = true
                sender.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            } else {
                sender.isSelected = false
                sender.setImage(nil, for: .normal)
                sender.layer.borderColor = UIColor.lightGray.cgColor
                sender.backgroundColor = UIColor.white
            }
            
            
            
            for _ in 0 ..< provideCountCheck.count{
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
                self.scannerViewHeight.constant = 100
                idScannerTitle.isHidden = false
                scannerViewShow.isHidden = false
                rfidBtnOutlet.isHidden = false
                ocrBtnOutlet.isHidden = false
                ocrInfoBtnOutle.isHidden = false
                
                if UserDefaults.standard.object(forKey: "beefScannerSelection") as? String == "ocr"{
                    ocrBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    rfidBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                    ocrBtnOutlet.layer.borderWidth = 2
                    rfidBtnOutlet.layer.borderWidth = 1
                    UserDefaults.standard.set("ocr", forKey: "beefScannerSelection")
                } else {
                    rfidBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    ocrBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
                    rfidBtnOutlet.layer.borderWidth = 2
                    ocrBtnOutlet.layer.borderWidth = 1
                    UserDefaults.standard.set("rfid", forKey: "beefScannerSelection")
                }
            }
        }
        self.evalutionProviderCV.reloadData()
        self.speciesCollectionView.reloadData()
    }
    
    
    
    @objc func providerButton(_ sender:UIButton) {
        UserDefaults.standard.removeObject(forKey: "Brazil")
        UserDefaults.standard.removeObject(forKey: "page")
        UserDefaults.standard.removeObject(forKey: "on")
        if UserDefaults.standard.string(forKey: "name") == "Dairy" {
            let userId = UserDefaults.standard.integer(forKey: "userId")
            let orderId = UserDefaults.standard.integer(forKey: "orderId")
            
            let providerObject : GetProviderTbl = self.getListProvider[sender.tag]
            let pviduser = UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue )
            
            if pviduser != providerObject.providerId {
                
                let alert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Are you sure you want to change the provider?", comment: ""),   preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default, handler: { _ in
                    
                    
                }))
                alert.addAction(UIAlertAction(title:  NSLocalizedString("Yes", comment: ""),style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
                    
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
                    let breedType = fetchBreedData(entityName: "GetBreedsTbl", provId:  Int(providerObject.providerId) )
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
                                    let arrData =    self.getListProvider[i]
                                    if pvid == arrData.providerId{
                                        item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                                        item.EcalutionProviderBttn.layer.borderWidth = 2
                                        
                                    }
                                    else{
                                        item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                                        item.EcalutionProviderBttn.backgroundColor = UIColor.white
                                        item.EcalutionProviderBttn.layer.borderWidth = 1
                                        
                                    }
                                    
                                }
                                
                            } else {
                                
                                self.isSelectedArray[sender.tag] = false
                                for i in 0 ..<  self.getListProvider.count {
                                    let myIndexPath = NSIndexPath(row: i, section: 0)
                                    let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                                    let  pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
                                    let arrData =    self.getListProvider[i]
                                    if pvid == arrData.providerId{
                                        item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                                        item.EcalutionProviderBttn.layer.borderWidth = 2
                                        
                                    } else {
                                        item.EcalutionProviderBttn.layer.borderWidth = 1
                                        item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                                        item.EcalutionProviderBttn.backgroundColor = UIColor.white
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
                                let arrData = self.getListProvider[i]
                                if pvid == arrData.providerId{
                                    item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                                    item.EcalutionProviderBttn.layer.borderWidth = 2
                                    
                                }
                                else{
                                    item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                                    item.EcalutionProviderBttn.backgroundColor = UIColor.white
                                    item.EcalutionProviderBttn.layer.borderWidth = 1
                                }
                            }
                            
                        } else {
                            
                            self.isSelectedArray[sender.tag] = false
                            for i in 0 ..<  self.getListProvider.count {
                                let myIndexPath = NSIndexPath(row: i, section: 0)
                                let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                                let  pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
                                let arrData = self.getListProvider[i]
                                if pvid == arrData.providerId{
                                    item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                                    item.EcalutionProviderBttn.layer.borderWidth = 2
                                    
                                } else {
                                    item.EcalutionProviderBttn.layer.borderWidth = 1
                                    item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                                    item.EcalutionProviderBttn.backgroundColor = UIColor.white
                                }
                            }
                        }
                        self.addProduct()
                        self.updateProviderId()
                    }
                    
                    if UserDefaults.standard.string(forKey: "providerNameUS") == "CLARIFIDE CDCB (US)" || UserDefaults.standard.string(forKey: "providerNameUS") == "US Dairy Products"{
                        self.nominatorHeightConst.constant = 100
                        
                    }else  if UserDefaults.standard.string(forKey: "providerNameUS") == "CLARIFIDE CDCB (BR)"{
                        self.nominatorHeightConst.constant = 100
                        
                    }
                    else{
                        self.nominatorHeightConst.constant = 0
                    }
                    UserDefaults.standard.set("NoNeedAuPopUp", forKey: "isAuSelected")
                    
                    
                    if providerObject.providerId == 1 || providerObject.providerId == 3 || providerObject.providerId == 8{
                        
                        self.primarlyHeightConst.constant = 156
                    } else {
                        
                        self.primarlyHeightConst.constant = 0
                    }
                    
                    if providerObject.providerId == 1 ||  providerObject.providerId == 2 || providerObject.providerId == 3 || providerObject.providerId == 8 {
                        self.scannerViewHeight.constant = 100
                        self.keyBoardViewHeight.constant = 200
                        self.keyBoardTopView.constant = 115
                        self.keyBaordSepratorView.isHidden = true
                        self.keyboardTtile.isHidden = false
                        self.keyboardSepratorTitle.isHidden = false
                        self.alphaNumericbtnOutler.isHidden = false
                        self.idScannerTitle.isHidden = false
                        self.scannerSepratorBar.isHidden = false
                        self.numericKeyBoardBtnOutle.isHidden = false
                        self.ocrBtnOutlet.isHidden = false
                        self.rfidBtnOutlet.isHidden = false
                        
                        self.ocrInfoBtnOutle.isHidden = false
                    } else{
                        self.keyBaordSepratorView.isHidden = false
                        self.keyBoardViewHeight.constant = 90
                        self.keyBoardTopView.constant = 5
                        self.keyboardSepratorTitle.isHidden = false
                        self.scannerViewHeight.constant = 0
                        self.keyboardTtile.isHidden = true
                        
                        self.alphaNumericbtnOutler.isHidden = true
                        self.idScannerTitle.isHidden = true
                        self.scannerSepratorBar.isHidden = true
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
        
            let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
            self.keyBaordSepratorView.isHidden = false
            self.keyBoardViewHeight.constant = 90
            self.keyBoardTopView.constant = 5
            self.keyboardSepratorTitle.isHidden = false
            UserDefaults.standard.removeObject(forKey: "BeefdateEntrySaveReviewPreference")
            
            UserDefaults.standard.set("GLobal", forKey: "ProviderName")
            UserDefaults.standard.set(false, forKey: "SubmitBtnFlag")
            let userId = UserDefaults.standard.integer(forKey: "userId")
            let  pvid1 = UserDefaults.standard.integer(forKey: "BeefPvid")
            if pvid1 == 13 || pvid1 == 5 {
                scannerViewHeight.constant = 100
                ocrBtnOutlet.isHidden = false
                rfidBtnOutlet.isHidden = false
            } else {
                scannerViewHeight.constant = 0
                ocrBtnOutlet.isHidden = true
                rfidBtnOutlet.isHidden = true
                
            }
            let providerObjects : GetProviderTbl = (self.getListProvider[sender.tag])
            if pvid1 != providerObjects.providerId{
                
                
                let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Are you sure you want to change the product grouping?", comment: "") , preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                    action in
                    
                    let providerObject : GetProviderTbl = self.getListProvider[sender.tag]
                    UserDefaults.standard.set(true, forKey: "showbeefInheritTable")
                    UserDefaults.standard.set(false, forKey: "isAggreForSubmit")
                    
                    if UserDefaults.standard.integer(forKey: "BeefPvid") != Int(providerObject.providerId) {
                        
                        
                        
                        if pvid == 5 || pvid ==  13{
                            let sampleType =  fetchproviderData(entityName: "GetSampleTbl", provId: Int(providerObject.providerId) )
                            var animaltbl = fetchAllDataOrderStatus(entityName: "BeefAnimaladdTbl",ordestatus: "false",orderId:1,userId:userId).mutableCopy() as! [BeefAnimaladdTbl]
                            
                            
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
                                  
                                    for i in 0 ..<  self.getListProvider.count {
                                        let myIndexPath = NSIndexPath(row: i, section: 0)
                                        let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                                        let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                                        let arrData =  self.getListProvider[i]
                                        
                                        if pvid == arrData.providerId {
                                            item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                                            item.EcalutionProviderBttn.layer.borderWidth = 2
                                            
                                        } else {
                                            item.EcalutionProviderBttn.layer.borderWidth = 1
                                            item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                                            item.EcalutionProviderBttn.backgroundColor = UIColor.white
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
                                    let arrData =  self.getListProvider[i]
                                    
                                    if pvid == arrData.providerId {
                                        item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                                        item.EcalutionProviderBttn.layer.borderWidth = 2
                                        
                                    } else {
                                        item.EcalutionProviderBttn.layer.borderWidth = 1
                                        item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                                        item.EcalutionProviderBttn.backgroundColor = UIColor.white
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
                                let arrData =  self.getListProvider[i]
                                
                                if pvid == arrData.providerId {
                                    item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                                    item.EcalutionProviderBttn.layer.borderWidth = 2
                                    
                                } else {
                                    item.EcalutionProviderBttn.layer.borderWidth = 1
                                    item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                                    item.EcalutionProviderBttn.backgroundColor = UIColor.white
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
                alertController.addAction(cancelAction)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            else {
                let providerObject : GetProviderTbl = self.getListProvider[sender.tag]
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
                        let arrData = getListProvider[i] 
                        
                        
                        if pvid == arrData.providerId {
                            item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                            item.EcalutionProviderBttn.layer.borderWidth = 2
                            
                        } else {
                            item.EcalutionProviderBttn.layer.borderWidth = 1
                            item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                            item.EcalutionProviderBttn.backgroundColor = UIColor.white
                        }
                    }
                    self.productTblView.reloadData()
                } else{
                    if switchFromDairy {
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
                            let arrData = getListProvider[i] 
                            
                            
                            if pvid == arrData.providerId {
                                item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                                item.EcalutionProviderBttn.layer.borderWidth = 2
                                
                            } else {
                                item.EcalutionProviderBttn.layer.borderWidth = 1
                                item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                                item.EcalutionProviderBttn.backgroundColor = UIColor.white
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
                                    let arrData = self.getListProvider[i] 
                                    
                                    
                                    if pvid == arrData.providerId {
                                        item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                                        item.EcalutionProviderBttn.layer.borderWidth = 2
                                        
                                    } else {
                                        item.EcalutionProviderBttn.layer.borderWidth = 1
                                        item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                                        item.EcalutionProviderBttn.backgroundColor = UIColor.white
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
    
    func addBeefProducts() {
        UserDefaults.standard.set(true, forKey: "identifyStore")
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        deleteDataProduct(entityName:"ProductAdonAnimlTbLBeef",status:"false")
        deleteDataProduct(entityName:"SubProductTblBeef", status: "false")
        deleteRecordFromDatabase(entityName: "GetProductTblBeef")
        deleteRecordFromDatabase(entityName: "OfflineOrderBeef")
        deleteRecordFromDatabase(entityName: "GetProductTblBeef")
        
        let animalData = fetchAllDataOrderStatus(entityName: "BeefAnimaladdTbl",ordestatus: "false",orderId:1,userId:1) as! [BeefAnimaladdTbl]
        
        updateProductTablStatus(entity: "GetProductTblBeef")
        updateProductTablStatus(entity: "GetAdonTbl")
        for product in self.productArr as? [GetProductTbl] ?? [] {
            product.isAdded = "true"
            if pvid == 13 {
                saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId ?? "", status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
            } else{
                saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId ?? "", status:"false", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
            }
        }
        
        let product  = fetchAllData(entityName: "GetProductTblBeef")
        for k in 0 ..< animalData.count{
            
            let animalId = animalData[k] 
            
            for i in 0 ..< product.count {
                
                let data = product[i] as! GetProductTblBeef
                
                if pvid == 13 {
                    saveProductAdonTbl(entity: "ProductAdonAnimlTbLBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: animalId.farmId ?? "", orderId: 1, orderStatus: "false", isSync: "false", userId: userId,udid:"", animalId: Int(animalId.animalId), marketName: data.marketName ?? "", orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"), isCdcbProduct: true)
                } else{
                    saveProductAdonTbl(entity: "ProductAdonAnimlTbLBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: animalId.farmId ?? "", orderId: 1, orderStatus: "false", isSync: "false", userId: userId,udid:"", animalId: Int(animalId.animalId), marketName: data.marketName ?? "", orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"), isCdcbProduct: true)
                }
                
                
                let  addonArr = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(data.productId))
                
                for j in 0 ..< addonArr.count {
                    
                    let addonDat = addonArr[j] as! GetAdonTbl
                    
                    saveSubroductTbl(entity: "SubProductTblBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: 1, orderStatus: "false", isSync: "false", userId: userId,udid:"", farmId: animalId.farmId ?? "", animalId: Int(animalId.animalId),custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                    
                }
            }
        }
    }
    
    func addProduct() {
        let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        deleteDataProduct(entityName:"ProductAdonAnimalTbl",status:"false")
        deleteDataProduct(entityName:"SubProductTbl", status: "false")
        UserDefaults.standard.removeObject(forKey: "identifyStore")
        UserDefaults.standard.removeObject(forKey: "productCount")
        UserDefaults.standard.removeObject(forKey: "breed")
        UserDefaults.standard.removeObject(forKey: "BVDVvalidation")
        UserDefaults.standard.set(nil, forKey: "On")
        
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let orderId = UserDefaults.standard.integer(forKey: "orderId")
        
        updateProductTablStatus(entity: "GetProductTbl")
        updateProductTablStatus(entity: "GetAdonTbl")
        
        let animalArr1 = fetchAllDataOrderStatus(entityName: "AnimaladdTbl",ordestatus: "false",orderId:orderId,userId:userId)
        if animalArr1.count > 0 {
            for k in 0 ..< animalArr1.count {
                let  breedId1  = animalArr1[k] as! AnimaladdTbl
                let product = fetchproviderProductDataBreedId(entityName: "GetProductTbl", provId: pvid, breedId: breedId1.breedId!)
                let productCount = UserDefaults.standard.integer(forKey: "productCount")
                if productCount == 0{
                    UserDefaults.standard.set(breedId1.breedId, forKey: "breed")
                }
                UserDefaults.standard.set(true, forKey: "identifyStore")
                
                UserDefaults.standard.set( product.count, forKey: "productCount")
                for i in 0 ..< product.count{
                    let data = product[i] as! GetProductTbl
                    
                    saveProductAdonTbl(entity: "ProductAdonAnimalTbl", animalTag: breedId1.animalTag ?? "" , barCodetag: breedId1.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: breedId1.farmId!, orderId: Int(breedId1.orderId), orderStatus: "false",isSync:"false", userId: userId,udid:breedId1.udid!, animalId: Int(breedId1.animalId), marketName: breedId1.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),isCdcbProduct: data.isCdcbProduct)
                    
                    let  addonArr = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(data.productId))
                    for j in 0 ..< addonArr.count{
                        let addonDat = addonArr[j] as! GetAdonTbl
                        
                        saveSubroductTbl(entity: "SubProductTbl", animalTag:  breedId1.animalTag ?? "", barCodetag: breedId1.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(breedId1.orderId), orderStatus: "false",isSync:"false", userId: userId,udid:breedId1.udid!, farmId: breedId1.farmId!, animalId: Int(breedId1.animalId),custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                    }
                }
                
            }
            
        }
    }
    
}


extension OrderingDefaultsVC : SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}


extension OrderingDefaultsVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        let cell = tableView.dequeueReusableCell(withIdentifier: "beefproducts", for: indexPath) as! BeefProductsTableViewCell
        let product =  self.productArr.object(at: indexPath.row) as! GetProductTbl
        
        if product.productName == "Genotype Only"
        {
            let langId = UserDefaults.standard.value(forKey: "lngId") as? Int
            if langId == 2{
                cell.productName.text = "Genotipagem"
            }
            else
            {
                cell.productName.text = product.productName
            }
        }
        else
        {
            cell.productName.text = product.productName
        }
        cell.radioBttn.isUserInteractionEnabled = false
        cell.iiBttn.isHidden = true
        
        
        if product.productId == 20 {
            cell.iiBttn.isHidden = false
            self.inheritInfoButtonFrame = cell.iiBttn.center.x - cell.iiBttn.frame.size.width / 2
            cell.iiBttn.addTarget(self, action: #selector(self.marketTipPop), for: .touchUpInside)
        }
        
        if pvid == 5 {
            
            tblViewhRIGHTcON.constant = 140
            if product.isAdded == "true" {
                
                cell.radioBttn.setImage(UIImage(named: "radioSeletedBtn"), for: .normal)
            } else{
                cell.radioBttn.setImage(UIImage(named: "radioBtn"), for: .normal)
            }
            
            cell.isUserInteractionEnabled = true
            cell.radioBttn.alpha = 1
            cell.alpha = 1
            cell.productName.alpha = 1
            
            if UserDefaults.standard.integer(forKey: "IsGlobalHD50DisabledForBrazil") == 1 && indexPath.row == 0 {
                
                cell.isUserInteractionEnabled = false
                cell.radioBttn.alpha = 0.2
                cell.alpha = 0.2
                cell.productName.alpha = 0.2
            }
            else {
                cell.isUserInteractionEnabled = true
                cell.radioBttn.alpha = 1
                cell.alpha = 1
                cell.productName.alpha = 1
            }
            
            
            
            if UserDefaults.standard.integer(forKey: "IsInhertDisabledForBrazil") == 1 && indexPath.row == 1 {
                cell.isUserInteractionEnabled = false
                cell.radioBttn.alpha = 0.2
                cell.alpha = 0.2
                cell.productName.alpha = 0.2
            }
            
        }
        
        if pvid == 6 {
            tblViewhRIGHTcON.constant = 188
            
            if product.isAdded == "true" {
                cell.radioBttn.setImage(UIImage(named: "check"), for: .normal)
            } else{
                cell.radioBttn.setImage(UIImage(named: "Uncheck"), for: .normal)
            }
            
            cell.isUserInteractionEnabled = true
            cell.radioBttn.alpha = 1
            cell.alpha = 1
            cell.productName.alpha = 1
        }
        
        return cell
    }
    
    @objc func marketTipPop() {
        
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(self.buttonbgPressedTip), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view.addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed("TipPopUp") as? TipPopUp
        customPopView1.arrow_left.isHidden = true
        
        var yFrame = CGRect(x: 50,y: 450  ,width: screenSize.width - 80, height: 137)
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
            case 1334:
                yFrame = CGRect(x: 18,y: 370  ,width: screenSize.width - 80, height: 137)
            case 1920, 2208:
                yFrame = CGRect(x: 36,y: 405  ,width: screenSize.width - 80, height: 137)
            case 2436:
                yFrame = CGRect(x: 18,y: 447  ,width: screenSize.width - 80, height: 137)
            case 2688,2796:
                yFrame = CGRect(x: 50,y: 450  ,width: screenSize.width - 80, height: 137)
            case 1792:
                yFrame = CGRect(x: 37,y: 488  ,width: screenSize.width - 80, height: 137)
            default:
                break
            }
        }
        
        customPopView1.arrow_Top.center.x = self.inheritInfoButtonFrame  + 5
        customPopView1.elipseImage2.isHidden = true
        customPopView1.elipseImage1.isHidden = true
        customPopView1.textLbl2.isHidden = true
        customPopView1.frame = yFrame
        customPopView1.textLabel1.text =  NSLocalizedString("INHERIT select will provide EPDs for replacement heifers. INHERIT connect allows for bulls to be included into the evaluation for heifer sire verification. EPDs are not provided for INHERIT connect.", comment: "")
        
        customPopView1.delegate = self
        customPopView1.layer.borderColor = UIColor.blue.cgColor
        customPopView1.layer.borderWidth = 1
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1.addSubview(customPopView1)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pid =   UserDefaults.standard.integer(forKey: "BfProductId")
        let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        let product =  self.productArr.object(at: indexPath.row) as! GetProductTbl
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let data = fetchAllDataWithOrderIDWithBeef(entityName: "BeefAnimaladdTbl",pid:pid,userId:userId)
        
        var  strmsg = String()
        if data.count > 0{
            if pvid != 6{
                
                if pid == product.productId {
                    strmsg = "Removing product selection will clear all product selections applied in order. Do you wish to continue? "
                }else{
                    strmsg = "Changing product selection will clear all animals and corresponding product selections applied in order. Do you wish to continue? "
                }
                let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: strmsg, preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    self.didselectTouched = true
                    UserDefaults.standard.set(true, forKey: "showbeefInheritTable")
                    if UserDefaults.standard.string(forKey: "name") == "Beef" {
                        let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                        
                        if pvid == 5 {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                if product.isAdded == "true" {
                                    deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                                    deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
                                    deleteRecordFromDatabase(entityName: "SubProductTblBeef")
                                    deleteRecordFromDatabase(entityName: "OfflineOrderBeef")
                                    UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                                    if pvid == 5{
                                        saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"false", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                                    } else {
                                        saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                                    }
                                }
                            }
                        }
                        
                        if pvid == 6 {
                            deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                            
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                if product.isAdded == "true" {
                                    UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                                } else {
                                    deleteDataWithProductBeef(entityName: "GetProductTblBeef", productId: Int(product.productId))
                                }
                            }
                        }
                    }
                    
                    if pvid == 5{
                        
                        if let  products = self.productArr as? [GetProductTbl] {
                            for product in products {
                                product.isAdded = "false"
                                
                                UserDefaults.standard.set(product.productId, forKey: "chpid")
                            }
                            products[indexPath.row].isAdded = "true"
                            
                        }
                        if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "rgn" || UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "rgd" ||  UserDefaults.standard.bool(forKey: "series") {
                            
                            UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
                            UserDefaults.standard.set(false, forKey: "brazilBarcode")
                            UserDefaults.standard.set(false, forKey: "series")
                        }
                        if UserDefaults.standard.bool(forKey: "brazilBarcode")  {
                            UserDefaults.standard.set(false, forKey: "brazilBarcode")
                            UserDefaults.standard.set("barcode", forKey: "InheritFOSampleTrackingDetailVC")
                        }
                        if UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "rgn" || UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "rgd" ||  UserDefaults.standard.bool(forKey: "seriesReviewVC") {
                            
                            UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
                            UserDefaults.standard.set(false, forKey: "brazilBarcodeReviewVC")
                            UserDefaults.standard.set(false, forKey: "seriesReviewVC")
                        }
                        if UserDefaults.standard.bool(forKey:"brazilBarcodeReviewVC")  {
                            UserDefaults.standard.set(false, forKey: "brazilBarcodeReviewVC")
                            UserDefaults.standard.set("barcode", forKey: "InheritFOReviewOrderVC")
                        }
                        
                        UserDefaults.standard.set(product.productId, forKey: "beefProductID")
                        self.productTblView.reloadData()
                    }
                    
                    if pvid == 6 {
                        
                        if let  products = self.productArr as? [GetProductTbl] {
                            for product in products {
                                product.isAdded = "false"
                            }
                            products[indexPath.row].isAdded = "false"
                            
                        }
                        self.brazilProduct.append(product.productName!)
                        UserDefaults.standard.set(product.productId, forKey: "beefProductID")
                        UserDefaults.standard.set(product.productId, forKey: "chpid")
                        UserDefaults.standard.set(self.brazilProduct, forKey: "brazilproduct")
                        
                        if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "barcode" {
                            UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
                            UserDefaults.standard.set(true, forKey: "brazilBarcode")
                        }
                        if UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "barcode" {
                            UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
                            UserDefaults.standard.set(true, forKey: "brazilBarcodeReviewVC")
                        }
                        self.productTblView.reloadData()
                    }
                    
                    if pvid == 7 {
                        
                        if let  products = self.productArr as? [GetProductTbl] {
                            for product in products {
                                product.isAdded = "false"
                                UserDefaults.standard.set(product.productId, forKey: "chpid")
                            }
                            
                            if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "rgn" || UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "rgd" ||  UserDefaults.standard.bool(forKey: "series") {
                                UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
                                UserDefaults.standard.set(false, forKey: "brazilBarcode")
                                UserDefaults.standard.set(false, forKey: "series")
                            }
                            if UserDefaults.standard.bool(forKey:"brazilBarcode")  {
                                UserDefaults.standard.set(false, forKey: "brazilBarcode")
                                UserDefaults.standard.set("barcode", forKey: "InheritFOSampleTrackingDetailVC")
                            }
                            if UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "rgn" || UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "rgd" ||  UserDefaults.standard.bool(forKey: "seriesReviewVC") {
                                
                                UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
                                UserDefaults.standard.set(false, forKey: "brazilBarcodeReviewVC")
                                UserDefaults.standard.set(false, forKey: "seriesReviewVC")
                            }
                            if UserDefaults.standard.bool(forKey:"brazilBarcodeReviewVC")  {
                                UserDefaults.standard.set(false, forKey: "brazilBarcodeReviewVC")
                                UserDefaults.standard.set("barcode", forKey: "InheritFOReviewOrderVC")
                            }
                            UserDefaults.standard.set(product.productId, forKey: "beefProductID")
                            products[indexPath.row].isAdded = "true"
                        }
                        
                        self.productTblView.reloadData()
                    }
                }
                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                }
                
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else{
                self.didselectTouched = true
                if pvid == 6 {
                    if let  products = productArr as? [GetProductTbl] {
                        if products[indexPath.row].isAdded == "true" {
                            products[indexPath.row].isAdded = "false"
                        } else {
                            products[indexPath.row].isAdded = "true"
                        }
                    }
                    brazilProduct.append(product.productName!)
                    UserDefaults.standard.set(product.productId, forKey: "beefProductID")
                    UserDefaults.standard.set(product.productId, forKey: "chpid")
                    UserDefaults.standard.set(brazilProduct, forKey: "brazilproduct")
                    
                    if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "barcode" {
                        UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
                        UserDefaults.standard.set(true, forKey: "brazilBarcode")
                    }
                    if UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "barcode" {
                        UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
                        UserDefaults.standard.set(true, forKey: "brazilBarcodeReviewVC")
                    }
                    productTblView.reloadData()
                }
            }
        }else{
            self.didselectTouched = true
            if pvid == 5 {
                UserDefaults.standard.set(true, forKey: "showbeefInheritTable")
                if let  products = productArr as? [GetProductTbl] {
                    for product in products {
                        product.isAdded = "false"
                        
                        UserDefaults.standard.set(product.productId, forKey: "chpid")
                    }
                    products[indexPath.row].isAdded = "true"
                    
                }
                if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "rgn" || UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "rgd" ||  UserDefaults.standard.bool(forKey: "series") {
                    
                    UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
                    UserDefaults.standard.set(false, forKey: "brazilBarcode")
                    UserDefaults.standard.set(false, forKey: "series")
                }
                if UserDefaults.standard.bool(forKey: "brazilBarcode")  {
                    UserDefaults.standard.set(false, forKey: "brazilBarcode")
                    UserDefaults.standard.set("barcode", forKey: "InheritFOSampleTrackingDetailVC")
                }
                if UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "rgn" || UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "rgd" ||  UserDefaults.standard.bool(forKey: "seriesReviewVC") {
                    
                    UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
                    UserDefaults.standard.set(false, forKey: "brazilBarcodeReviewVC")
                    UserDefaults.standard.set(false, forKey: "seriesReviewVC")
                }
                if UserDefaults.standard.bool(forKey:"brazilBarcodeReviewVC")  {
                    UserDefaults.standard.set(false, forKey: "brazilBarcodeReviewVC")
                    UserDefaults.standard.set("barcode", forKey: "InheritFOReviewOrderVC")
                }
                UserDefaults.standard.set(product.productId, forKey: "beefProductID")
                productTblView.reloadData()
            }
            
            if pvid == 6 {
                if let  products = productArr as? [GetProductTbl] {
                    if products[indexPath.row].isAdded == "true" {
                        products[indexPath.row].isAdded = "false"
                    } else {
                        products[indexPath.row].isAdded = "true"
                    }
                }
                brazilProduct.append(product.productName!)
                UserDefaults.standard.set(product.productId, forKey: "beefProductID")
                UserDefaults.standard.set(product.productId, forKey: "chpid")
                UserDefaults.standard.set(brazilProduct, forKey: "brazilproduct")
                
                if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "barcode" {
                    UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
                    UserDefaults.standard.set(true, forKey: "brazilBarcode")
                }
                if UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "barcode" {
                    UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
                    UserDefaults.standard.set(true, forKey: "brazilBarcodeReviewVC")
                }
                productTblView.reloadData()
            }
            
            if pvid == 7 {
                
                if let  products = productArr as? [GetProductTbl] {
                    for product in products {
                        product.isAdded = "false"
                        UserDefaults.standard.set(product.productId, forKey: "chpid")
                    }
                    
                    if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "rgn" || UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "rgd" ||  UserDefaults.standard.bool(forKey: "series") {
                        UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
                        UserDefaults.standard.set(false, forKey: "brazilBarcode")
                        UserDefaults.standard.set(false, forKey: "series")
                    }
                    if UserDefaults.standard.bool(forKey:"brazilBarcode")  {
                        UserDefaults.standard.set(false, forKey: "brazilBarcode")
                        UserDefaults.standard.set("barcode", forKey: "InheritFOSampleTrackingDetailVC")
                    }
                    if UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "rgn" || UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "rgd" ||  UserDefaults.standard.bool(forKey: "seriesReviewVC") {
                        
                        UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
                        UserDefaults.standard.set(false, forKey: "brazilBarcodeReviewVC")
                        UserDefaults.standard.set(false, forKey: "seriesReviewVC")
                    }
                    if UserDefaults.standard.bool(forKey:"brazilBarcodeReviewVC")  {
                        UserDefaults.standard.set(false, forKey: "brazilBarcodeReviewVC")
                        UserDefaults.standard.set("barcode", forKey: "InheritFOReviewOrderVC")
                    }
                    UserDefaults.standard.set(product.productId, forKey: "beefProductID")
                    products[indexPath.row].isAdded = "true"
                }
                
                productTblView.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}


extension OrderingDefaultsVC: InheritQuestionaireControllerDelegate {
    func inheritQuestionaireControllerDismissed() {
        if UserDefaults.standard.value(forKey: "settingDone") == nil || UserDefaults.standard.value(forKey: "settingDone") as? String == ""{
            UserDefaults.standard.set("true", forKey: "settingDone")
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "BeefAnimalGlobalHD50KVC") as! BeefAnimalGlobalHD50KVC
            self.navigationController?.pushViewController(newViewController, animated: false)
        }
        else {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
            self.navigationController?.pushViewController(newViewController, animated: false)
        }
    }
}

extension OrderingDefaultsVC{
    func getListName()  {
        listName = orderingDatalistVM.makeListName(custmerId: custId, providerID: pvidDairy)
        fetchDataEntry  = fetchAllDataEnteryList(entityName: "DataEntryList",customerId:Int64(self.custId),listName:listName ,productName:"Dairy") as! [DataEntryList]
        
    }
    func createListNameAndCheckifExist(){
        let userId = UserDefaults.standard.integer(forKey: "userId")
        getListName()
        if fetchDataEntry.count > 0 {
            deleteList(listName: listName, customerId: Int64(custId),listID: Int(fetchDataEntry[0].listId))
            deleteDataWithListIdDatEntry(entityString: "DataEntryAnimaladdTbl", listId: Int(fetchDataEntry[0].listId), customerId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),userId:userId)
            
            deleteDataWithListId(entityString: "DataEntryList", listId: Int64(fetchDataEntry[0].listId), customerId: Int(custId ),userId:userId )
        }
        
    }
    func updateProviderId() {
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let orderId = UserDefaults.standard.integer(forKey: "orderId")
        let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        updateProductTablDataaid(entity: "GetProductTbl", status: "false")
        let fethData =  fetchAllDataFarmIdStatus(entityName: "ProductAdonAnimalTbl", asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId, farmId:"")
        for pName in fethData as? [ProductAdonAnimalTbl] ?? [] {
            updateProductTablaid(entity:"GetProductTbl",productId:
                                    Int(pName.productId),status: "true")
        }
        
        let animaltbl = fetchAllDataOrderStatus(entityName: "AnimaladdTbl",ordestatus: "false",orderId:orderId,userId:userId) as! [AnimaladdTbl]
        for _ in animaltbl {
            updateProviderIDAnimal(entityName: "AnimaladdTbl", ordestatus: "false", providerId: pvid, orderId: orderId, userId: userId)
         
        }
    }
    
    func updateBeefProviderId() {
        UserDefaults.standard.set(false, forKey: "BeefBVDVSeleted")
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let orderId = UserDefaults.standard.integer(forKey: "orderId")
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        self.createListNameAndCheckifExist()
        updateProductTablDataaid(entity: "GetProductTblBeef", status: "false")
        let fethData =  fetchAllDataFarmIdStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId, farmId:"")
        for pName in fethData as? [ProductAdonAnimlTbLBeef] ?? [] {
            updateProductTablaid(entity:"GetProductTblBeef",productId:
                                    Int(pName.productId),status: "true")
        }
        
        let animaltbl = fetchAllDataOrderStatus(entityName: "BeefAnimaladdTbl",ordestatus: "false",orderId:1,userId:1) as! [BeefAnimaladdTbl]
        
        for k in 0 ..< animaltbl.count{
            let earTag = animaltbl[k].animalTag
            let eid = animaltbl[k].sireIDAU
            let existingPvid = animaltbl[k].providerId
            let barCode = animaltbl[k].animalbarCodeTag
            switch existingPvid {
            case 5:
                updateBeefAnimalProviderID_AnimalTag_Sireid(entityName: "BeefAnimaladdTbl", ordestatus: "false", providerId: pvid, orderId: 1, userId: 1, earTag: eid ?? "", sireIDAU: earTag ?? "",barCode: barCode ?? "")
            case 13:
                updateBeefAnimalProviderID_AnimalTag_Sireid(entityName: "BeefAnimaladdTbl", ordestatus: "false", providerId: pvid, orderId: 1, userId: 1, earTag: eid ?? "", sireIDAU: earTag ?? "", barCode: barCode ?? "")
            default:
                updateProviderIDAnimal(entityName: "BeefAnimaladdTbl", ordestatus: "false", providerId: pvid, orderId: 1, userId: 1)
            }
        }
    }
    func deleteList(listName: String, customerId: Int64, listID: Int) {
        
        let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String
        let headerDict = ["Authorization": accessToken!,"Content-Type" : "application/x-www-form-urlencoded"]
        
        let urlString = Configuration.Dev(packet: ApiKeys.deleteList.rawValue).getUrl()
        let parameters : [String: Any] = ["customerId": customerId,"listName":listName]
        
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = headerDict
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            if statusCode == 200 {
             
                self.hideIndicator()
                self.view.isUserInteractionEnabled = true
              
            }
        }
    }
}
