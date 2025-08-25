
//
//  DashboardVC.swift
//  SearchPoint
//
//  Created by "" on 30/09/2019.
//  ""
//

import UIKit
import WebKit
import MBProgressHUD
import Alamofire
import Gigya
import GigyaTfa
import GigyaAuth

// MARK: - CLASS

class DashboardVC: UIViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var productSelectionView: UIView!
    @IBOutlet weak var customerTblBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tblViewSeperator: UILabel!
    @IBOutlet weak var customerTblView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var customerContainerTrailing: NSLayoutConstraint!
    @IBOutlet weak var menuIconLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var placeAnOrder: UIButton!
    @IBOutlet weak var clockwiseSwitch: UISwitch!
    @IBOutlet weak var doneBttn: UIButton!
    @IBOutlet weak var networkViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var appHelpPercentLbl: UILabel!
    @IBOutlet weak var appHelpTitle: UILabel!
    @IBOutlet weak var appHelpView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var customertitleLbll: UILabel!
    @IBOutlet weak var selectproductLbl: UILabel!
    @IBOutlet weak var productTblView: UITableView!
    @IBOutlet weak var calendarViewBkg: UIView!
    @IBOutlet weak var billingView: UIView!
    @IBOutlet weak var hamburgerBtnOutlet: UIButton!
    @IBOutlet weak var networkStatusImg: UIImageView!
    @IBOutlet weak var menuBttn: UIButton!
    @IBOutlet weak var webView1: WKWebView!
    @IBOutlet var termsAndCondotionView: UIView!
    @IBOutlet weak var agreeBtn: UIButton!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var dashboardTitle: UILabel!
    @IBOutlet weak var NetworkStatusLbl: UILabel!
    @IBOutlet weak var offLineBtn: UIButton!
    @IBOutlet weak var tblviewHeightConstaint: NSLayoutConstraint!
    @IBOutlet weak var selectedCustomerContainerView: UIView!
    @IBOutlet weak var selectedCustomerLabel: UILabel!
    @IBOutlet weak var updateCustomerButton: UIButton!
    @IBOutlet weak var btnSampleCollector: UIButton!
    @IBOutlet weak var dataEntryModeOutlet: UIButton!
    @IBOutlet weak var infoPlaceAnOrderOutlet: UIButton!
    @IBOutlet weak var infoDataEntryOutlet: UIButton!
    @IBOutlet weak var infoActionRequiredOutlet: UIButton!
    @IBOutlet weak var infoTrackSampleOutlet: UIButton!
    @IBOutlet weak var appStatusTitle: UILabel!
    
    // MARK: - VARIABLES AND CONSTANTS
    var filteredData = [GetCustomer]()
    var customerList = [GetCustomer]()
    var sideMenuViewVC: SideMenuVC!
    var sideMenuShadowView: UIView!
    var sideMenuRevealWidth: CGFloat = 300
    let paddingForRotation: CGFloat = 150
    var isExpanded: Bool = false
    var draggingIsEnabled: Bool = false
    var panBaseLocation: CGFloat = 0.0
    var search : String = ""
    var provideCountCheckDairy = [GetProviderTbl]()
    var provideCountCheckBeef = [GetProviderTbl]()
    var getListProvider  = [GetProviderTbl]()
    var customerMarkets = [CustomerMarkets]()
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var revealSideMenuOnTop: Bool = true
    var gestureEnabled: Bool = true
    
    weak var delegate: OpenSheetViewControllerDelegate?
    var openSheetController = OpenSheetViewController()
    let gigya =  Gigya.sharedInstance(GigyaAccount.self)
    var fetchMyHerdDataDownloadCheck = [ResultMyHerdData]()
    private var labelPercentage: UILabel = UILabel()
    let progressBar = TYProgressBar()
    let shapelayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    var finalper : Double = 0.0
    var pageapi = Int()
    let percentLabel : UILabel = {
        let label = UILabel()
        label.text = "0%"
        label.textColor = UIColor.gray
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    var newcheck = Int()
    var customPopView1 :TipPopUp!
    var dashboardItemsArray = NSArray()
    var dashboardItemsImageArray = NSArray()
    var iPadTitleArray = ["PLACE AN ORDER", "DATA ENTRY MODE", "RESULTS", "ACTION REQUIRED", "TRACK SAMPLES", "CONTACT SUPPORT", ]
    var dashboardImagesIpad = NSArray()
    var customerId:Int64?
    var isGenotypeOnlyAdded = false
    var isGenostarblackOnlyAdded = false
    var brazilProduct = [String]()
    var productPopupFlag = 0
    var percentagecheckvalue = 0
    let buttonbg1 = UIButton ()
    var ausNaabCodeVM:AusNaabBullVM?
    var percentageCountStorage = 0
    var productArr = NSArray()
    var providerVM: GetProviderViewModel?
    var breedVM: GetBreedViewModel?
    var sampleM : SampleTypeViewModel?
    var speciesVM: GetSpeciesViewModel?
    var marketVM :GetMarketsViewModel?
    var productVM :GetProductsViewModel?
    var animalautoVM: AnimalAutoPopViewModel?
    var nominatorsVM: GetNominatorsViewModel?
    var addonVM: GetAddonsViewModel?
    var breedCodeVM: GetBreedCodeVM?
    var countryCodeVM: GetCountryCodeVM?
    var naabCodeVM: GetNaabCodeVM?
    var actionRequiredNinetyDays: ActionRequiredVM?
    var operationQueue = OperationQueue()
    var workItem: DispatchWorkItem?
    var mobileVersionVM:MobileVersionViewModel?
    var heartBeatViewModel:HeartBeatViewModel?
    var saveListCustomerViewModel: GetListForCustomerViewModel?
    var saveListCustomerWithTimeViewModel: GetListForCutomerWithTimeViewModel?
    var checkworkitem = Bool()
    var checkpercentage = Bool()
    var orderDetailNinetyDays: OrderDetailByPastDaysVM?
    var sampleStatusViewModel: SampleStatusViewModel?
    var animalByCustomerViewModel: AnimalByCustomerViewModel?
    var customerVM: GetCustomerViewModel?
    var PriorityBreedNameVM: GetPriorityBreedNameVM?
    var bornTypesViewModel: ProviderBornTypesViewModel?
    var transulation: Translationslanguageviewmodel?
    var breedSoceitesVM: GetBreedSocietiesVM?
    var productSelected  =  [GetProductTbl]()
    var provideCountCheck = NSArray()
    var dataModel:LoginScreenSetModel?
    var group = DispatchGroup()
    var groupnew = DispatchGroup()
    var speciesCountCheck = NSArray()
    var billingVM: GetBillingViewModel?
    var objApiSyncOffline = ApisyncOffLine()
    var offline = Bool()
    var groupapicallsyn = MyHerdResultsViewController()
    var inheritInfoButtonFrame = CGFloat.zero
    var customerOrderSetting = CustomerOrderSetting()
    var isselectedfliter = Bool()
    var pageNumberIncrese = 0
    var objApiSync = ApiSyncList()
    var saveAnimalGroupUpdatedViewModel: AnimalGroupsForCustomerUpdateVM?
    var saveResulyByPageViewModel: ResulyByPageViewModel?
    var resultMasterViewModel: ResultMasterTemplateViewModel?
    var abc = Float()
    var resultFilterViewModel: ResultFilterViewModel?
    var resultTotalViewModel: ResulttotalanimalsViewModel?
    var resultTotalViewModelupdate: Resulttotalanimalupdate?
    var totalanimalcount = Int()
    var resultProgressView = UIView()
    var appDelegate: AppDelegate?
    var attrs : [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.init(red: 29/225, green: 131/225, blue: 174/225, alpha: 1.0),.underlineStyle: NSUnderlineStyle.single.rawValue]
    var counter : Int = 0
    private let spacing:CGFloat = 15.0
    let langCode : String = UserDefaults.standard.object(forKey: keyValue.lngCode.rawValue) as! String
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    var value = 0
    let tapRec = UITapGestureRecognizer()
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    let placeOrderDesc = "Easily order veterinary products and diagnostics with accurate selection and seamless submission."
    let dataEntryDesc = "Manually enter test details with structured fields, ensuring accuracy, validation, and compliance."
    let resultDesc = "Access real-time diagnostic results for actionable insights in clinical decisions and patient care."
    let actionRequiredDesc = "Stay informed on approvals, pending actions, or flagged issues to ensure smooth diagnostics."
    let trackSampleDesc = "Monitor veterinary samples with real-time updates on processing, results, and turnaround times."
    let contactSupportDesc = "Get help with orders, tracking, results, or technical issues from Zoetis support."
    var descriptionTextArray = [String]()
    var selectedCustomer: GetCustomer?
    // MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpInitialUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: keyValue.collectorIdentifier.rawValue) {
            self.view.makeToast(NSLocalizedString(LocalizedStrings.orderSampleCollectors, comment: ""), duration: 3, position: .bottom)
            
            UserDefaults.standard.setValue(false, forKey: keyValue.collectorIdentifier.rawValue)
        }
        
        UserDefaults.standard.set("", forKey: keyValue.dataEntryScreenSave.rawValue)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        
        self.pageapi = 0
        self.setupCurrentSelectedCustomer()
        UserDefaults.standard.setValue("", forKey: keyValue.savesex.rawValue)
        UserDefaults.standard.setValue("", forKey: keyValue.todate.rawValue)
        UserDefaults.standard.setValue("", forKey: keyValue.fromdate.rawValue)
        doneBttn.setTitle(NSLocalizedString(LocalizedStrings.doneStr, comment: ""), for: .normal)
        if UIDevice().userInterfaceIdiom == .pad {
            doneBttn.layer.cornerRadius = 30
            cancelBtn.layer.cornerRadius = 30
        }
        selectproductLbl.text = NSLocalizedString(LocalizedStrings.selectProductStr, comment: "")
        if UIDevice().userInterfaceIdiom == .phone {
            updateCustomerButton.setTitle(NSLocalizedString(LocalizedStrings.updateStr, comment: ""), for: .normal)
            
        }
        dashboardTitle.text  = NSLocalizedString(LocalizedStrings.dashboardText, comment: "")
        if UIDevice().userInterfaceIdiom == .phone {
            appStatusTitle.text = NSLocalizedString(ButtonTitles.appStatusText, comment: "")
            
            let langCode : String = UserDefaults.standard.object(forKey: keyValue.lngCode.rawValue) as! String
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                dashboardItemsImageArray = ["tile1\(langCode))5c","tile2\(langCode)5c","tile3\(langCode)5c","tile4\(langCode)5c","tile5\(langCode)5c","tile6\(langCode)5c"]
                
            case 1334:
                dashboardItemsImageArray = ["tile1\(langCode)5c","tile2\(langCode)5c","tile3\(langCode)5c","tile4\(langCode)5c","tile5\(langCode)5c","tile6\(langCode)5c"]
                
            default:
                dashboardItemsImageArray = ["tile_1\(langCode)","tile_2\(langCode)","tile_3\(langCode)","tile_4\(langCode)","tile_5\(langCode)","tile_6\(langCode)"]
            }
        }
        initialNetworkCheck()
        self.navigationController?.navigationBar.isHidden = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        
        
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        self.productArr = fetchproviderProductDataBeef(entityName: Entities.getProductTblEntity, provId: pvid)
        
        productTblView.reloadData()
        calendarViewBkg.isHidden = true
        billingView.isHidden = true
        if UIDevice().userInterfaceIdiom == .pad {
            productSelectionView.isHidden = true
        }
        
        if Connectivity.isConnectedToInternet() {
            
            group.enter()
            mobileVersionVM = MobileVersionViewModel(ref: self, callBack: navigateToAnotherVcAppVersion)
            mobileVersionVM?.callGetMobileVersioN()
            NotificationCenter.default.addObserver(self,selector: #selector(applicationWillEnterForeground(_:)),name: UIApplication.willEnterForegroundNotification,
                                                   object: nil)
        }
        else
        {
            self.hideIndicator()
            self.hideIndicator()
            self.hideIndicator()
            self.view.isUserInteractionEnabled = true
        }
        
        self.checkandCompareDate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let market = UserDefaults.standard.value(forKey: keyValue.marketName.rawValue) as? String else { return }
        if market == keyValue.brazilMarket.rawValue {
            btnSampleCollector.isHidden = false
        } else {
            btnSampleCollector.isHidden = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
    
        if touch?.view != self.sideMenuViewVC {
            sideMenuState(expanded: false)
        }
    }
    
    // MARK: - UI AND OTHER METHODS
    
    func setUpInitialUI(){
        
        if UIDevice().userInterfaceIdiom == .phone {
            print("phone")
        }
        else {
            self.tblViewSeperator.isHidden = true
            self.customerTblView.isHidden = true
            self.calendarViewBkg.isHidden = true
            self.containerViewHeight.constant = 50.0
            self.customerTblBottomConstraint.constant = 0
            searchTextField.setLeftPaddingPoints(20.0)
            descriptionTextArray = [placeOrderDesc, dataEntryDesc, resultDesc, actionRequiredDesc, trackSampleDesc, contactSupportDesc]
            self.setSideMenu()
            
            self.btnSampleCollector.isHidden = true
            
            let nib = UINib(nibName: "DashboardCardCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: "DashboardCardCell")
            selectedCustomerContainerView.setupCustomerSelectionView()
            dashboardImagesIpad = [UIImage(named: "orderplaced") as Any, UIImage(named: "dataEntryiPad") as Any, UIImage(named: "resultsiPad") as Any, UIImage(named: "actionRequirediPad") as Any, UIImage(named: "trackSampleIpad") as Any, UIImage(named: "contactSupportiPad") as Any]
            
        }
        
        UserDefaults.standard.removeObject(forKey: keyValue.isAnimalClickedFromBeefCart.rawValue)
        UserDefaults.standard.removeObject(forKey: keyValue.isToUpdateAndAddAnimal.rawValue)
        showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncDataLabel, comment: ""), and: "")
        self.view.isUserInteractionEnabled = false
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.collectionView?.collectionViewLayout = layout
        let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.updateStr, comment: ""), attributes: self.attrs)
        if UIDevice().userInterfaceIdiom == .phone {
            self.updateCustomerButton.setAttributedTitle(attributeString, for: .normal)
            
        }
        UserDefaults.standard.set(true, forKey: keyValue.mustRegisterDevice.rawValue)
        UserDefaults.standard.set(nil, forKey: keyValue.submitTypeSelection.rawValue)
        
        guard let market = UserDefaults.standard.value(forKey: keyValue.marketName.rawValue) as? String else { return }
        if UIDevice().userInterfaceIdiom == .pad {
            if market == keyValue.brazilMarket.rawValue {
                btnSampleCollector.isHidden = false
            } else {
                btnSampleCollector.isHidden = true
            }
            
            btnSampleCollector.setTitle(NSLocalizedString(LocalizedStrings.orderCollectorStr, comment: ""), for: .normal)
            guard let markett = UserDefaults.standard.value(forKey: keyValue.marketName.rawValue) as? String else { return }
            if markett == keyValue.brazilMarket.rawValue {
                btnSampleCollector.isHidden = false
            } else {
                btnSampleCollector.isHidden = true
            }
        }
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.ShowToastForSampleCollector(notification:)), name: Notification.Name(keyValue.collectorIdentifier.rawValue), object: nil)
    }
    
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
        
        view.insertSubview(self.sideMenuViewVC!.view, at: self.revealSideMenuOnTop ? 2 : 0)
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
            self.sideMenuViewVC.view.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView.reloadData()
        self.setSideMenu()
        if UIDevice.current.orientation.isLandscape {
            
            print("Landscape")
        } else {
            print("Portrait")
        }
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = self.isExpanded ? 0 : (-self.sideMenuRevealWidth - self.paddingForRotation)
            }
        }
        
    }
    
    func animateShadow(targetPosition: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            self.sideMenuShadowView.alpha = (targetPosition == 0) ? 0.6 : 0.0
        }
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
    
    func appVersionSameThenMethodcall(){
        
        self.view.isUserInteractionEnabled = false
        showIndicator(self.view, withTitle: NSLocalizedString("Syncing data...", comment: ""), and: "")
        
        UserDefaults.standard.synchronize()
        UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
        UserDefaults.standard.set(nil, forKey: "barcodeIncremental")
        self.setupCurrentSelectedCustomer()
        
        objApiSyncOffline.delegeteSyncApi = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        UserDefaults.standard.set(true, forKey: "provider")
        UserDefaults.standard.set("true", forKey: "ContactSupport")
        
        
        if Connectivity.isConnectedToInternet() {
            
            speciesVM = GetSpeciesViewModel(ref: self, callBack: navigateToAnotherVcSpecies)
            
            speciesVM?.callGetSpecies()
            
            speciesCountCheck = fetchAllData(entityName: Entities.getSpeciesTblEntity)
            
            if speciesCountCheck.count == 0 {
                
                self.view.isUserInteractionEnabled = false
                showIndicator(self.view, withTitle: NSLocalizedString("Syncing data...", comment: ""), and: "")
                
                group.enter()
                customerVM = GetCustomerViewModel(ref: self, callBack: navigateToAnotherVc)
                customerVM!.callGetCustomerCode()
                group.enter()
                breedVM = GetBreedViewModel(ref: self, callBack: navigateToAnotherVc)
                breedVM?.callGetBreeds()
                group.enter()
                productVM = GetProductsViewModel(ref: self, callBack: navigateToAnotherVc)
                productVM?.callGetProducts()
                group.enter()
                providerVM = GetProviderViewModel(ref: self, callBack: navigateToAnotherVc)
                providerVM!.callGetProvider()
                group.enter()
                sampleM = SampleTypeViewModel(ref: self, callBack: navigateToAnotherVc)
                sampleM?.callsampleType()
                group.enter()
                nominatorsVM = GetNominatorsViewModel(ref: self, callBack: navigateToAnotherVc)
                nominatorsVM?.callGetNominators()
                group.enter()
                orderDetailNinetyDays = OrderDetailByPastDaysVM(ref: self, callBack: navigateToAnotherVc)
                orderDetailNinetyDays?.callOrderDetailByPastApi(days: "91")
                group.enter()
                actionRequiredNinetyDays = ActionRequiredVM(ref: self, callBack: navigateToAnotherVc)
                actionRequiredNinetyDays?.callNineteyDaysApi(days: 91)
                group.enter()
                marketVM = GetMarketsViewModel(ref: self, callBack: navigateToAnotherVc)
                marketVM?.callGetMarkets()
                
                group.enter()
                breedSoceitesVM = GetBreedSocietiesVM(ref: self, callBack: navigateToAnotherVc)
                breedSoceitesVM?.callGetSocietiesCode()
                group.enter()
                PriorityBreedNameVM = GetPriorityBreedNameVM(ref: self, callBack: navigateToAnotherVc)
                PriorityBreedNameVM?.callGetPriorityCode()
                group.enter()
                countryCodeVM = GetCountryCodeVM(ref: self, callBack: navigateToAnotherVc)
                countryCodeVM?.callGetCountryCode()
                group.enter()
                bornTypesViewModel = ProviderBornTypesViewModel(ref: self, callBack: navigateToAnotherVc)
                bornTypesViewModel?.serverCall()
                group.enter()
                naabCodeVM = GetNaabCodeVM(ref: self, callBack: navigateToAnotherVc)
                naabCodeVM?.callGetNaabCode()
                group.enter()
                sampleStatusViewModel = SampleStatusViewModel(ref: self, callBack: navigateToAnotherVc)
                sampleStatusViewModel?.callSampleStatuses()
                group.enter()
                ausNaabCodeVM = AusNaabBullVM(ref: self, callBack: navigateToAnotherVc)
                ausNaabCodeVM!.callAusNaabBull()
                group.enter()
                resultMasterViewModel = ResultMasterTemplateViewModel(ref: self, callBack: navigateToAnotherVc)
                resultMasterViewModel?.callResultMasterTemplateApi()
                group.enter()
                transulation = Translationslanguageviewmodel(ref: self, callBack: navigateToAnotherVc)
                transulation?.callTranslationslanguageApi()
                
                group.notify(queue: .main) {
                    self.view.isUserInteractionEnabled = true
                    
                    let fetchSpecies = fetchAllData(entityName: Entities.getSpeciesTblEntity)
                    let fetchGetCustomer = fetchAllData(entityName: "GetCustomer")
                    let fetchCustomerMarkets = fetchAllData(entityName: Entities.customerMarketsTblEntity)
                    let fetchBreed = fetchAllData(entityName: Entities.getBreedsTblEntity)
                    let fetchProduct = fetchAllData(entityName: Entities.getProductTblEntity)
                    _ = fetchAllData(entityName: Entities.getAdonTblEntity)
                    let fetchProvide = fetchAllData(entityName: Entities.getProviderTblEntity)
                    let fetchprovidetbl = fetchAllData(entityName: Entities.getProviderTblEntity)
                    let fetchgetsampleTbl = fetchAllData(entityName: Entities.getSampleTblEntity)
                    let fetchAusNabb = fetchAllData(entityName: "AusNaabBull")
                    let fetchBreedSocieties = fetchAllData(entityName: "GetBreedSocieties")
                    let fetchPrioirityBredding = fetchAllData(entityName: "GetPriorityBreeding")
                    let fetchSeondaryBReed = fetchAllData(entityName: "GetSecondaryBreedingPrograms")
                    
                    if fetchSpecies.count == 0 || fetchGetCustomer.count == 0 || fetchCustomerMarkets.count == 0 || fetchBreed.count == 0 || fetchProduct.count == 0 ||  fetchProvide.count == 0 || fetchprovidetbl.count == 0 || fetchgetsampleTbl.count == 0 || fetchAusNabb.count == 0 || fetchBreedSocieties.count == 0 || fetchPrioirityBredding.count == 0 || fetchSeondaryBReed.count == 0 {
                        let alert = UIAlertController(title: AlertMessagesStrings.alertString, message: "Data connection failed,please try login again. If the problem persists, please contact customer service.".localized, preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                            
                            UserDefaults.standard.set("false", forKey: "FirstLogin")
                            self.hideIndicator()
                            
                            if UIDevice().userInterfaceIdiom == .phone {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController)), animated: true)
                            } else {
                                
                                let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController)), animated: true)
                            }
                            self.sideMenuViewController!.hideMenuViewController()})
                            alert.addAction(ok)
                            DispatchQueue.main.async(execute: {
                            self.present(alert, animated: true)
                            
                        })}
                    
                    if !UserDefaults.exists(key: keyValue.currentActiveCustomerId.rawValue) || UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue) == 0 {
                        self.moveToCustomerListing()
                        
                    }
                    else {
                        let email = UserDefaults.standard.value(forKey: "userName") as? String ?? ""
                        let custmerName =  updateCustomerOrderSetting(entityName: "GetCustomer", customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),emailId:email)
                        
                        if custmerName.count > 0 {
                            let custName  = custmerName.object(at: 0) as! GetCustomer
                            
                            if UIDevice().userInterfaceIdiom == .phone {
                                self.customertitleLbll.text = NSLocalizedString("Customer: ", comment: "")
                                self.selectedCustomerLabel.text = custName.customerName
                            } else {
                                self.searchTextField.text = custName.customerName
                            }
                            
                        }
                        else {
                            self.moveToCustomerListing()
                            
                        }
                    }
                }
                
            } else {
                if (fetchAllData(entityName: "GetCustomer")).count == 0 {
                    self.view.isUserInteractionEnabled = false
                    showIndicator(self.view, withTitle: NSLocalizedString("Syncing data...", comment: ""), and: "")
                    
                    group.enter()
                    customerVM = GetCustomerViewModel(ref: self, callBack: navigateToAnotherVcForCustomer)
                    customerVM!.callGetCustomerCode()
                    
                } else {
                    
                    if fetchAllData(entityName: "GetCustomer").count == 1 {
                        if UIDevice().userInterfaceIdiom == .phone {
                            self.updateCustomerButton.isHidden = true
                        } else {
                            updateCustomerButton.setImage(UIImage(named: "editIconIpad"), for: .normal)
                        }
                        
                        
                        
                    } else {
                        
                    }
                }
                if (fetchAllData(entityName: Entities.getProductTblEntity)).count == 0 {
                    self.view.isUserInteractionEnabled = false
                    showIndicator(self.view, withTitle: NSLocalizedString("Syncing data...", comment: ""), and: "")
                    group.enter()
                    productVM = GetProductsViewModel(ref: self, callBack: navigateToAnotherVc)
                    productVM?.callGetProducts()
                    
                }
                
                
                if (fetchAllData(entityName: Entities.evaluationMarketsTblEntity)).count == 0 {
                    self.view.isUserInteractionEnabled = false
                    showIndicator(self.view, withTitle: NSLocalizedString("Syncing data...", comment: ""), and: "")
                    
                    group.enter()
                    providerVM = GetProviderViewModel(ref: self, callBack: navigateToAnotherVc)
                    providerVM!.callGetProvider()
                }
                
                if (fetchAllData(entityName: Entities.getSampleTblEntity)).count == 0 {
                    self.view.isUserInteractionEnabled = false
                    showIndicator(self.view, withTitle: NSLocalizedString("Syncing data...", comment: ""), and: "")
                    
                    group.enter()
                    sampleM = SampleTypeViewModel(ref: self, callBack: navigateToAnotherVc)
                    sampleM?.callsampleType()
                }
                
                if (fetchAllData(entityName: "GetNominatorsTbl")).count == 0 {
                    self.view.isUserInteractionEnabled = false
                    showIndicator(self.view, withTitle: NSLocalizedString("Syncing data...", comment: ""), and: "")
                    
                    group.enter()
                    nominatorsVM = GetNominatorsViewModel(ref: self, callBack: navigateToAnotherVc)
                    nominatorsVM?.callGetNominators()
                }
                
                if (fetchAllData(entityName: "GetMarketsTbl")).count == 0 {
                    self.view.isUserInteractionEnabled = false
                    showIndicator(self.view, withTitle: NSLocalizedString("Syncing data...", comment: ""), and: "")
                    
                    group.enter()
                    marketVM = GetMarketsViewModel(ref: self, callBack: navigateToAnotherVc)
                    marketVM?.callGetMarkets()
                }
                if (fetchAllData(entityName: "GetBreedSocieties")).count == 0 {
                    self.view.isUserInteractionEnabled = false
                    showIndicator(self.view, withTitle: NSLocalizedString("Syncing data...", comment: ""), and: "")
                    
                    group.enter()
                    breedSoceitesVM = GetBreedSocietiesVM(ref: self, callBack: navigateToAnotherVc)
                    
                    breedSoceitesVM?.callGetSocietiesCode()
                }
                if (fetchAllData(entityName: "GetPriorityBreeding")).count == 0 {
                    self.view.isUserInteractionEnabled = false
                    showIndicator(self.view, withTitle: NSLocalizedString("Syncing data...", comment: ""), and: "")
                    
                    group.enter()
                    PriorityBreedNameVM = GetPriorityBreedNameVM(ref: self, callBack: navigateToAnotherVc)
                    PriorityBreedNameVM?.callGetPriorityCode()
                }
                self.view.isUserInteractionEnabled = false
                showIndicator(self.view, withTitle: NSLocalizedString("Syncing data...", comment: ""), and: "")
                group.enter()
                countryCodeVM = GetCountryCodeVM(ref: self, callBack: navigateToAnotherVc)
                countryCodeVM?.callGetCountryCode()
                if (fetchAllData(entityName: "GetBornTypes")).count == 0 {
                    self.view.isUserInteractionEnabled = false
                    showIndicator(self.view, withTitle: NSLocalizedString("Syncing data...", comment: ""), and: "")
                    group.enter()
                    bornTypesViewModel = ProviderBornTypesViewModel(ref: self, callBack: navigateToAnotherVc)
                    bornTypesViewModel?.serverCall()
                }
                if (fetchAllData(entityName: "GetNaabCode")).count == 0 {
                    self.view.isUserInteractionEnabled = false
                    showIndicator(self.view, withTitle: NSLocalizedString("Syncing data...", comment: ""), and: "")
                    group.enter()
                    naabCodeVM = GetNaabCodeVM(ref: self, callBack: navigateToAnotherVc)
                    naabCodeVM?.callGetNaabCode()
                }
             
                self.view.isUserInteractionEnabled = false
                showIndicator(self.view, withTitle: NSLocalizedString("Syncing data...", comment: ""), and: "")
                group.enter()
                heartBeatViewModel = HeartBeatViewModel(ref: self, callBack: navigateToAnotherVc)
                heartBeatViewModel?.callGetHearBeatData()
                
                
                let datalistArray = fetchDataNonSyncListGet(entityName: Entities.dataEntryListTblEntity,isSyncStatus: false) as!  [DataEntryList]
                let beefPvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                for data in datalistArray{
                    let listId = data.listId
                    if beefPvid == 5 || beefPvid == 6  || beefPvid ==  7 || beefPvid == 13 {
                        self.objApiSync.postListDataBeef(listId: listId, custmerId: Int64(UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int))
                    } else {
                        self.objApiSync.postListData(listId: listId, custmerId: Int64(UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int))
                    }
                    
                }
                
                //For Dairy
                self.objApiSync.postOffineDeleteanimals(species: SpeciesID.dairySpeciesId)
                //For BEEF
                self.objApiSync.postOffineDeleteanimals(species: SpeciesID.beefSpeciesId)
                
                if fetchAllDataLastUpdatedData(entityName: "AnimalUpdatedTime",customerId:UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64 ?? 0, hittingTime: "").count == 0{
                    
                    
                    self.view.isUserInteractionEnabled = false
                    showIndicator(self.view, withTitle: NSLocalizedString("Syncing data...", comment: ""), and: "")
                    group.enter()
                    saveListCustomerViewModel = GetListForCustomerViewModel(ref: self, callBack: navigateToAnotherVc143)
                    saveListCustomerViewModel?.callListForCustomer()
                    
                } else {
                    
                    let dataFetc = fetchDataEnteryWithListIdWithoutProviderID(entityName: Entities.animalAddTblEntity,customerId:Int(UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64 ?? 0),listId:0,orderstatus:"false",orderiD:UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue))
                    
                    let dataFetcBeef = fetchDataEnteryWithListIdWithoutProviderID(entityName: Entities.beefAnimalAddTblEntity,customerId:Int(UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64 ?? 0),listId:0,orderstatus:"false",orderiD:UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue))
                    
                    if dataFetc.count == 0 && dataFetcBeef.count == 0{
                        
                        self.view.isUserInteractionEnabled = false
                        showIndicator(self.view, withTitle: NSLocalizedString("Syncing data...", comment: ""), and: "")
                        group.enter()
                        saveListCustomerWithTimeViewModel = GetListForCutomerWithTimeViewModel(ref: self, callBack: navigateToAnotherVc143)
                        saveListCustomerWithTimeViewModel?.callListForCustomer()
                    }
                }
                
                self.view.isUserInteractionEnabled = false
                showIndicator(self.view, withTitle: NSLocalizedString("Syncing data...", comment: ""), and: "")
                group.enter()
                resultFilterViewModel = ResultFilterViewModel(ref: self, callBack: navigateToAnotherVc)
                resultFilterViewModel?.callSaveListApi()
                
                
                self.view.isUserInteractionEnabled = false
                showIndicator(self.view, withTitle: NSLocalizedString("Syncing data...", comment: ""), and: "")
                group.enter()
                sampleStatusViewModel = SampleStatusViewModel(ref: self, callBack: leavegroupapi)
                sampleStatusViewModel?.callSampleStatuses()
                
                
                let yamvalue = UserDefaults.standard.value(forKey: "del")
                
                if yamvalue as? String == "abc"
                {
                    let custId =  UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
                    
                    deleteRecordFromDatabase(entityName: "ResultGroupCreate")
                    deleteRecordFromDatabase(entityName: "ResultGroupsAnimals")
                    
                    updateMyHerdDataAllStaus(entity: "ResultMyHerdData", customerId: Int64(custId), status: "inactive")
                }
                
                let newgroup = DispatchGroup()
                
                let groupArray  = addanimalfetch(entityName: "ResultGroupCreate", customerId:UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64 ?? 0)
                
                if groupArray.count > 0 {
                    showIndicator(self.view, withTitle: NSLocalizedString("Syncing data...", comment: ""), and: "")
                    for item in groupArray {
                        
                        let gid = item as? ResultGroupCreate
                        let groupid = gid?.groupServerId
                        let gobjct =  ResultAnimalServer(groupId: groupid ?? "")
                        if gobjct.animalIds.count != 0 {
                            newgroup.enter()
                            addAnimalInGroup(groupId: "", gobj: gobjct, animalIds: "")
                            { (result) in
                                newgroup.leave()
                                
                                if result
                                {
                                    // needs callback handling
                                    
                                }
                            }
                        }
                        
                        
                    }
                }
                Singleton.shared.isfilter = false
                DispatchQueue.global(qos: .background).sync {
                    self.view.isUserInteractionEnabled = false
                    self.showIndicator(self.view, withTitle: NSLocalizedString("Syncing data...", comment: ""), and: "")
                    group.enter()
                    self.saveAnimalGroupUpdatedViewModel = AnimalGroupsForCustomerUpdateVM( callBack: self.leavegroupapi)
                    self.saveAnimalGroupUpdatedViewModel?.callAnimalGroupsForCustomerUpdateApi()
                }
                
                
                if (fetchAllData(entityName: "AusNaabBull")).count == 0 {
                    self.view.isUserInteractionEnabled = false
                    showIndicator(self.view, withTitle: NSLocalizedString("Syncing data...", comment: ""), and: "")
                    
                    group.enter()
                    ausNaabCodeVM = AusNaabBullVM(ref: self, callBack: navigateToAnotherVc)
                    ausNaabCodeVM!.callAusNaabBull()
                    
                }
                if (fetchAllData(entityName: Entities.getBreedsTblEntity)).count == 0 {
                    self.view.isUserInteractionEnabled = false
                    showIndicator(self.view, withTitle: NSLocalizedString("Syncing data...", comment: ""), and: "")
                    
                    group.enter()
                    breedVM = GetBreedViewModel(ref: self, callBack: navigateToAnotherVc)
                    breedVM?.callGetBreeds()
                    
                }
                
                
                group.notify(queue: .main) {
                    
                    
                    
                    self.view.isUserInteractionEnabled = true
                    
                    if !UserDefaults.exists(key: keyValue.currentActiveCustomerId.rawValue) || UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue) == 0 {
                        self.moveToCustomerListing()
                        
                    }
                    else {
                        
                        let email = UserDefaults.standard.value(forKey: "userName") as? String ?? ""
                        let custmerName =  updateCustomerOrderSetting(entityName: "GetCustomer", customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),emailId:(email))
                        if custmerName.count > 0 {
                            let custName  = custmerName.object(at: 0) as! GetCustomer
                            if UIDevice().userInterfaceIdiom == .pad {
                                self.searchTextField.text = custName.customerName ?? ""
                            } else {
                                self.selectedCustomerLabel.text = custName.customerName ?? ""
                            }
                            if UIDevice().userInterfaceIdiom == .phone {
                                self.customertitleLbll.text = NSLocalizedString("Customer: ", comment: "")
                                
                            }
                            
                        }
                        else {
                            self.moveToCustomerListing()
                        }
                    }
                    if Connectivity.isConnectedToInternet() {
                        
                        let offSuync = UserDefaults.standard.bool(forKey: "syncoff")
                        if offSuync {
                            self.view.isUserInteractionEnabled = false
                            
                            if UserDefaults.standard.value(forKey: "name") as? String  == "Dairy"{
                                
                                if UserDefaults.standard.bool(forKey: "dairySubmitBtnFlag") {
                                    
                                    self.showIndicator(self.view, withTitle: NSLocalizedString("Submitting E-mail Order. Please wait...", comment: ""), and: "")
                                    
                                } else {
                                    
                                    self.showIndicator(self.view, withTitle: NSLocalizedString("Data Sync in Progress. Please Wait...", comment: ""), and: "")
                                    
                                }
                            } else {
                                
                                
                                
                                if UserDefaults.standard.bool(forKey:  "emailBeef") {
                                    self.showIndicator(self.view, withTitle: NSLocalizedString("Submitting E-mail Order. Please wait...", comment: ""), and: "")
                                    
                                } else {
                                    self.showIndicator(self.view, withTitle: NSLocalizedString("Data Sync in Progress. Please Wait...", comment: ""), and: "")
                                }}
                            self.objApiSyncOffline.saveAnimaldata()
                        }
                    }
                }
            }
        }else {
            self.hideIndicator()
            self.hideIndicator()
            self.hideIndicator()
            self.hideIndicator()
            self.hideIndicator()
            self.view.isUserInteractionEnabled = true
            
        }
        
        NotificationCenter.default.removeObserver(Notification.Name("Session_Expired"))
        NotificationCenter.default.addObserver(self, selector: #selector(self.sessionExpired(notification:)), name: Notification.Name("Session_Expired"), object: nil)
        
        
    }
    
    func dataEnterModeAction() {
        
        UserDefaults.standard.set(ScreenNames.dataEntry.rawValue, forKey: keyValue.dataEntryScreenSave.rawValue)
        
        if UserDefaults.standard.value(forKey: keyValue.settingDefault.rawValue) as? String == "true" {
            if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String  == marketNameType.Dairy.rawValue {
                
                let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue) as? Int)!
                if pviduser == 1 || pviduser == 2 || pviduser == 3 || pviduser == 4 || pviduser == 8 || pviduser == 10 || pviduser == 11  || pviduser == 12 {
                    if UIDevice().userInterfaceIdiom == .pad {
                        let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: nil)
                        let viewController = storyboard.instantiateViewController(withIdentifier: "DataEntryModeListiPadVC")
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: viewController), animated: true)
                        
                    } else {
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                    }
                } else {
                    if UIDevice().userInterfaceIdiom == .phone {
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.orderingDefaultVC)), animated: true)
                    } else {
                        
                        
                        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "SettingsVC")), animated: true)
                        
                    }
                    
                    return
                }
            }else {
                
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
                
                let animalCount =  fetchAllDataAnimalDatarderIdGlobal(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false")
                
                if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 5 {
                    if animalCount.count == 0 {
                        deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                        
                        for product in self.productArr as? [GetProductTbl] ?? [] {
                            if product.isAdded == "true" {
                                deleteRecordFromDatabase(entityName: Entities.selectedQuesTblEntity)
                                UserDefaults.standard.set(true, forKey: keyValue.showbeefInheritTable.rawValue)
                                let userDefault = UserDefaults.standard.integer(forKey: keyValue.bfProductId.rawValue)
                                if userDefault == Int(product.productId) {
                                    
                                }
                                else {
                                    deleteRecordFromDatabase(entityName: Entities.offlineOrderBeefTblEntity)
                                    deleteRecordFromDatabase(entityName: Entities.productAdonAnimlBeefTblEntity)
                                    deleteRecordFromDatabase(entityName: Entities.subProductBeefTblEntity)
                                }
                                
                                saveProductSaveBeef(entity: Entities.getProductBeefTblEntity, productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                                UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                            }
                        }
                    }
                    
                    
                    if animalCount.count > 0 {
                        if UserDefaults.standard.value(forKey: keyValue.dataEntryScreenSave.rawValue) as! String == ScreenNames.dataEntry.rawValue {
                            
                            
                            if UIDevice().userInterfaceIdiom == .phone {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                            } else {
                                
                                let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: Bundle.main)
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                            }
                            
                        }
                        return
                    }
                    
                    
                    if  UserDefaults.standard.bool(forKey: keyValue.showBeefProductTbl.rawValue) ||  UserDefaults.standard.value(forKey: keyValue.beefProductAdded.rawValue) as? String == "true" {
                        let fetchPid = fetchAllData(entityName: Entities.getProductBeefTblEntity) as! [GetProductTblBeef]
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
                        
                        if UserDefaults.standard.bool(forKey: keyValue.showBeefProductTbl.rawValue) || UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == nil {
                            UserDefaults.standard.set(keyValue.capsInherit.rawValue, forKey: keyValue.beefProduct.rawValue)
                            if UIDevice().userInterfaceIdiom == .phone {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                            } else {
                                
                                let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: Bundle.main)
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                            }
                            productTblView.reloadData()
                        } else {
                            if UIDevice().userInterfaceIdiom == .phone {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                            } else {
                                
                                let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: Bundle.main)
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                            }
                        }
                        
                    } else {
                        if UIDevice().userInterfaceIdiom == .phone {
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                        } else {
                            
                            let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: Bundle.main)
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                        }
                    }
                }
                else if UserDefaults.standard.integer(forKey: keyValue.beefProduct.rawValue) == 13{
                    for product in self.productArr as? [GetProductTbl] ?? [] {
                        if product.isAdded == "true" {
                            let userDefault = UserDefaults.standard.integer(forKey: keyValue.bfProductId.rawValue)
                            if userDefault == Int(product.productId) {
                                
                            }
                            else {
                                deleteRecordFromDatabase(entityName: Entities.offlineOrderBeefTblEntity)
                                deleteRecordFromDatabase(entityName: Entities.productAdonAnimlBeefTblEntity)
                                deleteRecordFromDatabase(entityName: Entities.subProductBeefTblEntity)
                            }
                            
                            saveProductSaveBeef(entity: Entities.getProductBeefTblEntity, productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                            UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                        }
                        
                    }
                    
                    
                    if  UserDefaults.standard.bool(forKey: keyValue.showbeefInheritTable.rawValue) ||  UserDefaults.standard.value(forKey: keyValue.beefProductAdded.rawValue) as? String == "true" {
                        let fetchPid = fetchAllData(entityName: Entities.getProductBeefTblEntity) as! [GetProductTblBeef]
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
                    }
                }
                
                else if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 6 {
                    if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 6 {
                        
                        if animalCount.count > 0 {
                            if UIDevice().userInterfaceIdiom == .phone {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                            } else {
                                
                                let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: Bundle.main)
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                            }
                            return
                        }
                        
                        if  UserDefaults.standard.bool(forKey: keyValue.showBeefProductTbl.rawValue) ||  UserDefaults.standard.value(forKey: keyValue.beefProductAdded.rawValue) as? String == "true" {
                            let fetchPid = fetchAllData(entityName: Entities.getProductBeefTblEntity) as! [GetProductTblBeef]
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
                                    deleteDataWithProductBeef(entityName: Entities.getProductBeefTblEntity, productId: Int(product.productId))
                                    product.isAdded = "false"
                                }
                            }
                            if UserDefaults.standard.bool(forKey: keyValue.showBeefProductTbl.rawValue)  || UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == nil{
                                self.selectedCustomerContainerView.alpha = 0.1
                                calendarViewBkg.isHidden = false
                                billingView.isHidden = false
                                if UIDevice().userInterfaceIdiom == .pad {
                                    productSelectionView.isHidden = false
                                }
                                productTblView.reloadData()
                            }else {
                                
                                if UIDevice().userInterfaceIdiom == .phone {
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                                } else {
                                    
                                    let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: Bundle.main)
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                                }
                                
                            }
                        }
                        else{
                            if UIDevice().userInterfaceIdiom == .phone {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                            } else {
                                
                                let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: Bundle.main)
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                            }
                        }
                        
                    }
                    
                } else if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 7 {
                    
                    for product in self.productArr as? [GetProductTbl] ?? [] {
                        product.isAdded = "true"
                        deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                        saveProductSaveBeef(entity: Entities.getProductBeefTblEntity, productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId ?? "", status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                    }
                    if UIDevice().userInterfaceIdiom == .phone {
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                    } else {
                        
                        let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: Bundle.main)
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                    }
                    productTblView.reloadData()
                    
                    
                }
            }
        } else {
            
            if UIDevice().userInterfaceIdiom == .phone {
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.orderingDefaultVC)), animated: true)
            } else {
                
                
                let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "SettingsVC")), animated: true)
            }
        }
    }
    
    
    
    func initialNetworkCheck() {
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        
        let del = UIApplication.shared.delegate as? AppDelegate
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if NetworkStatusLbl?.text == ButtonTitles.connectedText{
            self.offLineBtn.isUserInteractionEnabled = false
            networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else {
            self.hideIndicator()
            self.hideIndicator()
            self.hideIndicator()
            self.hideIndicator()
            self.hideIndicator()
            self.hideIndicator()
            self.hideIndicator()
            self.offLineBtn.isUserInteractionEnabled = true
            networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    func resultfliter(){
        if Connectivity.isConnectedToInternet()
        {
            let fetchObj = fetchResultFilterDataWithProductid(entityName: Entities.resultFilterDataTblEntity,customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),providerid: 1)
            
            if fetchObj.count == 0
            {
                group.leave()
                self.hideIndicator()
                self.hideIndicator()
                self.hideIndicator()
                self.hideIndicator()
                self.hideIndicator()
                self.hideIndicator()
                self.view.isUserInteractionEnabled = true
                self.collectionView.reloadData()
            }
            else
            {
                self.view.isUserInteractionEnabled = false
                showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncDataLabel, comment: ""), and: "")
                group.enter()
                resultTotalViewModel = ResulttotalanimalsViewModel(ref: self, callBack: totalanimalcountapicheck)
                resultTotalViewModel?.callTotalanimalsApi()
                self.collectionView.reloadData()
                showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncDataLabel, comment: ""), and: "")
            }
        }
        else
        {
            self.hideIndicator()
            self.hideIndicator()
            self.hideIndicator()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    func leavegroupapi()
    {
        group.leave()
        self.hideIndicator()
        self.hideIndicator()
        self.hideIndicator()
        self.hideIndicator()
        self.hideIndicator()
        self.hideIndicator()
        self.hideIndicator()
        self.hideIndicator()
        self.hideIndicator()
        self.hideIndicator()
        self.hideIndicator()
        self.hideIndicator()
        self.view.isUserInteractionEnabled = true
    }
    
    func totalanimalcountapicheck()
    {
        group.leave()
        hideIndicator()
        self.hideIndicator()
        self.hideIndicator()
        self.view.isUserInteractionEnabled = true
        
    }
    
    func savedatacallapi(){
        self.view.isUserInteractionEnabled = false
        DispatchQueue.global(qos: .background).sync {
            self.showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncResultsData, comment: ""), and: "")
            self.saveAnimalGroupUpdatedViewModel = AnimalGroupsForCustomerUpdateVM(ref: self, callBack: self.navigateToSaveAnimal)
            self.saveAnimalGroupUpdatedViewModel?.callAnimalGroupsForCustomerUpdateApi()
        }
        
    }
    
    func leave(){
        group.leave()
        self.pageapi = 1
        hideIndicator()
        hideIndicator()
        showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncResultsData, comment: ""), and: "")
        group.enter()
        saveAnimalGroupUpdatedViewModel = AnimalGroupsForCustomerUpdateVM(ref: self, callBack: navigateToAnotherVc143)
        saveAnimalGroupUpdatedViewModel?.callAnimalGroupsForCustomerUpdateApi()
        self.hideIndicator()
    }
    
    
    func orderingBtnClick() {
        
        if UserDefaults.standard.value(forKey: keyValue.settingDefault.rawValue) as? String == "true" {
            if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String  == marketNameType.Dairy.rawValue {
                
                UserDefaults.standard.set(keyValue.placeOrder.rawValue, forKey: keyValue.dataEntryScreenSave.rawValue)
                
                let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
                if pviduser == 4  {
                    
                    if UIDevice().userInterfaceIdiom == .phone {
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "OrderingAnimalVCGirlando")), animated: true)
                    } else {
                        let storyboard = UIStoryboard(name: "DairyPlaceAnOrder", bundle: Bundle.main)
                        
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "OrderingAnimalVCGirlandoIpad")), animated: true)
                    }
                    
                    
                } else if pviduser == 1 || pviduser == 2 || pviduser == 3 || pviduser == 8 || pviduser == 10 || pviduser == 11 || pviduser == 12 {
                    if UIDevice().userInterfaceIdiom == .pad {
                        let storyboard = UIStoryboard(name: "DairyPlaceAnOrder", bundle: Bundle.main)
                        
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "OrderingAnimalipadVC")), animated: true)
                    }
                    else {
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.orderingAnimalVC)), animated: true)
                    }
                    
                    
                } else {
                    if UIDevice().userInterfaceIdiom == .phone {
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.orderingDefaultVC)), animated: true)
                        
                    } else {
                        
                        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "SettingsVC")), animated: true)
                        
                    }
                    return
                }
            }
            
            if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String  == marketNameType.Beef.rawValue {
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                UserDefaults.standard.set(keyValue.placeOrder.rawValue, forKey: keyValue.dataEntryScreenSave.rawValue)
                
                if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 5 {
                    if UIDevice().userInterfaceIdiom == .phone {
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefAnimalGlobalHD50KVC)), animated: true)
                    } else {
                        
                        let storyboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: Bundle.main)
                        
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "InheritBeefVC")), animated: true)
                    }
                    
                    if animalCount.count == 0 {
                        deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                        for product in self.productArr as? [GetProductTbl] ?? [] {
                            product.isAdded = "true"
                            deleteRecordFromDatabase(entityName: Entities.selectedQuesTblEntity)
                            saveProductSaveBeef(entity: Entities.getProductBeefTblEntity, productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId ?? "", status:"false", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                        }
                    }
                    
                }
                else if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 13{
                    for product in self.productArr as? [GetProductTbl] ?? [] {
                        if product.isAdded == "true" {
                            
                            deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                            deleteRecordFromDatabase(entityName: Entities.selectedQuesTblEntity)
                            let userDefault = UserDefaults.standard.integer(forKey: keyValue.bfProductId.rawValue)
                            if userDefault == Int(product.productId) {
                                
                            }
                            else {
                                deleteRecordFromDatabase(entityName: Entities.offlineOrderBeefTblEntity)
                            }
                            
                            saveProductSaveBeef(entity: Entities.getProductBeefTblEntity, productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                            UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                        }
                        
                    }
                    if UIDevice().userInterfaceIdiom == .phone {
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefUSAddAnimalVC)), animated: true)
                    }
                    else {
                        
                        let storyboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: Bundle.main)
                        
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BlockyardBeefiPad")), animated: true)
                    }
                    
                }
                
                if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 6 {
                    
                    if animalCount.count > 0 {
                        if UIDevice().userInterfaceIdiom == .phone {
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefAnimalBrazilVC)), animated: true)
                            return
                        } else {
                            
                            let storyboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: Bundle.main)
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefAnimalBrazilVCIpad")), animated: true)
                            return
                        }
                        
                    }
                    
                    if UserDefaults.standard.bool(forKey: keyValue.showBeefProductTbl.rawValue) ||  UserDefaults.standard.value(forKey: keyValue.beefProductAdded.rawValue) as? String == "true" {
                        let fetchPid = fetchAllData(entityName: Entities.getProductBeefTblEntity) as! [GetProductTblBeef]
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
                                deleteDataWithProductBeef(entityName: Entities.getProductBeefTblEntity, productId: Int(product.productId))
                                product.isAdded = "false"
                            }
                        }
                        if UserDefaults.standard.bool(forKey: keyValue.showBeefProductTbl.rawValue)  || UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == nil{
                            calendarViewBkg.isHidden = false
                            deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                            billingView.isHidden = false
                            if UIDevice().userInterfaceIdiom == .pad {
                                productSelectionView.isHidden = false
                                self.selectedCustomerContainerView.alpha = 0.1
                            }
                           
                            productTblView.reloadData()
                            
                        } else {
                            if UIDevice().userInterfaceIdiom == .phone {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefAnimalBrazilVC)), animated: true)
                                return
                            } else {
                                
                                let storyboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: Bundle.main)
                                
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefAnimalBrazilVCIpad")), animated: true)
                                return
                            }
                        }
                    }
                    else {
                        if UIDevice().userInterfaceIdiom == .phone {
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefAnimalBrazilVC)), animated: true)
                            return
                        } else {
                            
                            let storyboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: Bundle.main)
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefAnimalBrazilVCIpad")), animated: true)
                            return
                        }
                    }
                    
                }
                if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 7 {
                    
                    for product in self.productArr as? [GetProductTbl] ?? [] {
                        product.isAdded = "true"
                        deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                        saveProductSaveBeef(entity: Entities.getProductBeefTblEntity, productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId ?? "", status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                    }
                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefAnimalNZVC)), animated: true)
                    productTblView.reloadData()
                }
                
                if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 0 {
                    if UIDevice().userInterfaceIdiom == .phone {
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.orderingDefaultVC)), animated: true)
                        return
                    } else {
                        
                        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "SettingsVC")), animated: true)
                        return
                    }
                    
                }
            }
            
        } else {
            if UIDevice().userInterfaceIdiom == .phone {
                UserDefaults.standard.set(keyValue.placeorder.rawValue, forKey: keyValue.dataEntryScreenSave.rawValue)
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.orderingDefaultVC)), animated: true)
            } else {
                UserDefaults.standard.set(keyValue.placeorder.rawValue, forKey: keyValue.dataEntryScreenSave.rawValue)
                
                let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "SettingsVC")), animated: true)
            }
            
        }
    }
    
    func ssologoutMethod()
    {
        gigya.logout() { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func resultSelection(){
        if UIDevice().userInterfaceIdiom == .phone {
            self.customerOrderSetting.saveCustomerSetting()
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.myHerdResultsVC)), animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Results", bundle: Bundle.main)
            self.customerOrderSetting.saveCustomerSetting()
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "MyHerdResultsVCiPad")), animated: true)
        }
        
    }
    
    // MARK: - NAVIGATION METHODS
    func navigateToAnotherVc(){
        group.leave()
        if UIDevice().userInterfaceIdiom == .phone {
            print("phone")
        }
        else {
            customerList = fetchAllDataCustomer(entityName: Entities.getCustomerTblEntity) as! [GetCustomer]
            self.customerTblView.isHidden = true
            self.containerViewHeight.constant = 50.0
            self.customerTblBottomConstraint.constant = 0
            self.calendarViewBkg.isHidden = true
            self.tblViewSeperator.isHidden = true
            filteredData = customerList
        }
    }
    
    func navigateToAnotherVcProduct(){
        group.leave()
    }
    
    func navigateToWithOutLeave(){
        hideIndicator()
    }
    
    func navigateToAnotherVcNinenty(){
        group.leave()
        hideIndicator()
        hideIndicator()
    }
    
    func navigateToAnotherVcAnimal(){
        group.leave()
        hideIndicator()
        hideIndicator()
        let count = UserDefaults.standard.integer(forKey: keyValue.countAnimal.rawValue)
        let curentCustId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64
        let customerSetting =  fetchAllCustomerDataSave(entityName: Entities.getDataBaseCountTbl,customerId:curentCustId!)
        
        if customerSetting.count == 0 {
            group.enter()
            self.view.isUserInteractionEnabled = false
            showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncDataLabel, comment: ""), and: "")
            animalByCustomerViewModel = AnimalByCustomerViewModel(ref: self, callBack: navigateToAnotherVcAnimalCount1)
            animalByCustomerViewModel?.callServer(start: 1, count: count)
            saveCustomerDataCount(customerId: curentCustId!,dataCount: Int64(count))
            
        } else {
            
            let countDataBase = customerSetting[0] as! GetDatabaseCount
            let checkCo = countDataBase.dataCount
            if checkCo == count {
                hideIndicator()
                hideIndicator()
                
            } else {
                group.enter()
                self.view.isUserInteractionEnabled = false
                showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncDataLabel, comment: ""), and: "")
                animalByCustomerViewModel = AnimalByCustomerViewModel(ref: self, callBack: navigateToAnotherVcAnimalCount1)
                animalByCustomerViewModel?.callServer(start: 1, count: count)
                updateCustomerDatabase(entity: Entities.getDataBaseCountTbl,dataCount: Int64(count),customerId:curentCustId!)
                
            }}
    }
    
    func navigateToAnotherVcAnimalCount1(){
        group.leave()
        hideIndicator()
        hideIndicator()
        showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncDataLabel, comment: ""), and: "")
        group.enter()
        resultFilterViewModel = ResultFilterViewModel(ref: self, callBack: navigateToAnotherFilterScreen)
        resultFilterViewModel?.callSaveListApi()
        
    }
    
    func navigateToAnotherFilterScreen(){
        group.leave()
        hideIndicator()
        hideIndicator()
        self.view.isUserInteractionEnabled = true
    }
    
    func navigateToAnotherVcSpecies(){
        hideIndicator()
    }
    func navigateToAnotherVc143(){
        group.leave()
        hideIndicator()
        self.view.isUserInteractionEnabled = true
    }
    
    func navigateToSaveAnimal(){
        group.leave()
        self.collectionView.reloadData()
        hideIndicator()
        hideIndicator()
        hideIndicator()
        hideIndicator()
        hideIndicator()
        hideIndicator()
        hideIndicator()
        hideIndicator()
        hideIndicator()
        hideIndicator()
        hideIndicator()
        self.collectionView.reloadData()
        self.view.isUserInteractionEnabled = true
        
    }
    
    func navigateToAnotherVcForCustomer(){
        group.leave()
        hideIndicator()
        if !UserDefaults.exists(key: keyValue.currentActiveCustomerId.rawValue) || UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue) == 0 {
            self.moveToCustomerListing()
            
        } else {
            let email = UserDefaults.standard.value(forKey: keyValue.userName.rawValue) as? String ?? ""
            let custmerName =  updateCustomerOrderSetting(entityName: Entities.getCustomerTblEntity, customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),emailId:email)
            if custmerName.count > 0{
                self.setupCurrentSelectedCustomer()
                let custName  = custmerName.object(at: 0) as! GetCustomer
                if UIDevice().userInterfaceIdiom == .phone {
                    self.selectedCustomerLabel.text = custName.customerName
                } else {
                    self.searchTextField.text = custName.customerName
                }
                
                
            }
            else {
                self.moveToCustomerListing()
            }
            if fetchAllData(entityName: Entities.getCustomerTblEntity).count > 1 {
                var textCount = Int()
                if UIDevice().userInterfaceIdiom == .phone {
                    textCount = selectedCustomerLabel.text?.count ?? 0
                } else {
                    textCount = searchTextField.text?.count ?? 0
                }
                if textCount != 0 {
                    
                    if UIDevice().userInterfaceIdiom == .phone {
                        self.updateCustomerButton.isHidden = false
                        self.customertitleLbll.text = NSLocalizedString(LocalizedStrings.customerTextStr, comment: "")
                        
                    } else {
                        updateCustomerButton.setImage(UIImage(named: "editIconIpad"), for: .normal)
                    }
                }
            }
            else {
                self.updateCustomerButton.isHidden = true
                if UIDevice().userInterfaceIdiom == .phone {
                    self.customertitleLbll.text = NSLocalizedString("", comment: "")
                    
                }
            }
        }
    }
    
    func navigateToAnotherVcAppVersion(){
        group.leave()
        
        let mobileVersion = fetchAllData(entityName: Entities.mobileVersionTbl)
        let version = mobileVersion[0] as? MobileVersion
        if Int(version?.versionCode ?? "") ?? 0 > 6 {
            
            let refreshAlert = UIAlertController(title:  NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message:  NSLocalizedString(LocalizedStrings.newVersionAvailable, comment: ""), preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title:  NSLocalizedString("Ok", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
                
                if let reviewURL = URL(string: LocalizedStrings.appURL), UIApplication.shared.canOpenURL(reviewURL) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(reviewURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(reviewURL)
                    }
                }
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        } else {
            
            appVersionSameThenMethodcall()
        }
    }
    
    // MARK: - OBJC SELECTORS
    @objc  func checkForReachability(notification:Notification){
        let del = UIApplication.shared.delegate as? AppDelegate
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if NetworkStatusLbl?.text == ButtonTitles.connectedText {
            self.offLineBtn.isUserInteractionEnabled = false
            networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
            if !offline {
                offline = true
            }
        } else {
            self.offLineBtn.isUserInteractionEnabled = true
            networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    @objc func buttonbgPressedTip (){
        buttonbg1.removeFromSuperview()
        customPopView1.removeFromSuperview()
    }
    
    @objc func buttonbgPressed (){
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
    @objc func marketTipPopClick() {
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(self.buttonbgPressedTip), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view.addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed(ClassIdentifiers.tipPopUpNib) as? TipPopUp
        customPopView1.arrow_left.isHidden = true
        var yFrame = CGRect(x: 50,y: 450  ,width: screenSize.width - 80, height: 137)
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
                
            case 1334:
                customPopView1.arrow_Top.frame = CGRect(x: 208 , y: -24, width: 26, height: 26)
                yFrame = CGRect(x: 50,y: 373  ,width: screenSize.width - 80, height: 137)
                customPopView1.arrow_Top.center.x = self.inheritInfoButtonFrame  - 30
                
            case 1920, 2208:
                yFrame = CGRect(x: 36,y: 405  ,width: screenSize.width - 80, height: 137)
                customPopView1.arrow_Top.center.x = self.inheritInfoButtonFrame  + 5
                
            case 2436:
                yFrame = CGRect(x: 18,y: 447  ,width: screenSize.width - 80, height: 137)
                customPopView1.arrow_Top.center.x = self.inheritInfoButtonFrame  + 5
                
            case 2688,2796:
                yFrame = CGRect(x: 50,y: 450  ,width: screenSize.width - 80, height: 137)
                customPopView1.arrow_Top.center.x = self.inheritInfoButtonFrame  + 5
                
            case 1792:
                yFrame = CGRect(x: 37,y: 488  ,width: screenSize.width - 80, height: 137)
                customPopView1.arrow_Top.center.x = self.inheritInfoButtonFrame  + 5
            default:
                break
            }
        }
        
        customPopView1.elipseImage2.isHidden = true
        customPopView1.elipseImage1.isHidden = true
        customPopView1.textLbl2.isHidden = true
        customPopView1.frame = yFrame
        customPopView1.textLabel1.text =  NSLocalizedString(LocalizedStrings.inheritConnectString, comment: "")
        customPopView1.delegate = self
        customPopView1.layer.borderColor = UIColor.blue.cgColor
        customPopView1.layer.borderWidth = 1
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1.addSubview(customPopView1)
        
    }
    
    @objc func notificationReceviedpercentage(notification: Notification) {
        let data = notification.object
        abc = data as? Float ?? 0.0
    }
    
    @objc func sessionExpired(notification: Notification) {
        guard let statusCode = notification.userInfo![LocalizedStrings.statusCodeText] as? String else { return }
        
        if statusCode == "401" || statusCode == "400"  {
            
            let refreshAlert = UIAlertController(title:  NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message:  NSLocalizedString(AlertMessagesStrings.authFailed, comment: ""), preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title:  NSLocalizedString("Ok", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
                
                UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
                self.hideIndicator()
                
                if UIDevice().userInterfaceIdiom == .phone {
                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController)), animated: true)
                } else {
                    
                    let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController)), animated: true)
                }
                self.sideMenuViewController?.hideMenuViewController()
                self.ssologoutMethod()
            }))
            present(refreshAlert, animated: true, completion: nil)
            
        }
    }
    
    @objc func applicationWillEnterForeground(_ notification: NSNotification) {
        self.view.isUserInteractionEnabled = false
        showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncDataLabel, comment: ""), and: "")
        group.enter()
        mobileVersionVM = MobileVersionViewModel(ref: self, callBack: navigateToAnotherVcAppVersion)
        mobileVersionVM?.callGetMobileVersioN()
    }
    
    @objc func methodOfReceivedNotification(notification: Notification)
    {
        if value == 0
        {
            UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
            if UIDevice().userInterfaceIdiom == .phone {
                let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
                self.navigationController?.pushViewController(newViewController, animated: true)
                self.hideIndicator()
                value = value + 1
            } else {
                
                let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                let newViewController = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
                self.navigationController?.pushViewController(newViewController, animated: true)
                self.hideIndicator()
                value = value + 1
            }
            
        }
        
    }
    
    @objc  func ShowToastForSampleCollector(notification:Notification){
        self.view.makeToast(NSLocalizedString(LocalizedStrings.orderSampleCollectors, comment: ""), duration: 15, position: .bottom)
    }
    
    @objc func updateCustomerAction(tapGestureRecognizer : UITapGestureRecognizer) {
        if UserDefaults.standard.value(forKey: keyValue.oflinesave.rawValue) as? String == keyValue.checkOffline.rawValue
        {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.changeCustomerAlert, comment: ""))
        }
        else
        {
            checkworkitem = true
            checkpercentage = false
            UserDefaults.standard.setValue(0, forKey: keyValue.pageNumber.rawValue)
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
            let orderIdBeef = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
            let  viewAnimalArray =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue))
            let beefDAta =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderIdBeef,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
            if viewAnimalArray.count > 0 || beefDAta.count > 0 {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.completeClearOrder, comment: ""))
            }
            
            else
            {
                
                updateCustomerButton.setImage(UIImage(named: "searchIconiPad"), for: .normal)
                self.searchTextField.text = ""
                self.customerTblView.isHidden = false
                self.calendarViewBkg.isHidden = false
                self.tblViewSeperator.isHidden = false
                self.containerViewHeight.constant = 501.0
                self.customerTblBottomConstraint.constant = 50.0
                self.customerTblView.reloadData()
            }
        }
    }
    
    // MARK: - IB ACTIONS
    
    @IBAction func acnNavigateToSampleCollector(_ sender: UIButton) {
        if UIDevice().userInterfaceIdiom == .phone {
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataCollectorVC)), animated: true)
        } else {
            
            let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dataCollectorVC)), animated: true)
        }
        
    }
    
    @IBAction func helpAction(_ sender: UIButton) {
        if UIDevice().userInterfaceIdiom == .phone {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
            vc?.module = LocalizedStrings.dashboardText
            vc?.modalPresentationStyle = .overFullScreen
            self.present(vc!, animated: false, completion: nil)
        }
        else {
            CommonClass.showAlertMessage(self, titleStr:AlertMessagesStrings.alertString.localized + "!", messageStr: "In progress")
        }
        
    }
    
    @IBAction func updateCustomersAction(_ sender: UIButton) {
        if UserDefaults.standard.value(forKey: keyValue.oflinesave.rawValue) as? String == keyValue.checkOffline.rawValue
        {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.changeCustomerAlert, comment: ""))
        }
        else
        {
            
            checkworkitem = true
            checkpercentage = false
            UserDefaults.standard.setValue(0, forKey: keyValue.pageNumber.rawValue)
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
            let orderIdBeef = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
            let  viewAnimalArray =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue))
            let beefDAta =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderIdBeef,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
            if viewAnimalArray.count > 0 || beefDAta.count > 0 {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.completeClearOrder, comment: ""))
            }
            
            else
            {
                
                var storyBoard = UIStoryboard()
                if UIDevice().userInterfaceIdiom == .phone {
                    storyBoard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.customersListControllerVC) as! CustomersListController
                    vc.delegate = self
                    self.navigationController?.present(vc, animated: false, completion: nil)
                    self.view.isUserInteractionEnabled = true
                }
                else {
                    
                    updateCustomerButton.setImage(UIImage(named: "searchIconiPad"), for: .normal)
                    self.searchTextField.text = ""
                    
                    self.customerTblView.isHidden = false
                    self.containerViewHeight.constant = 501.0
                    self.customerTblBottomConstraint.constant = 50.0
                    self.calendarViewBkg.isHidden = false
                    self.tblViewSeperator.isHidden = false
                    self.customerTblView.reloadData()
                }
                
            }
        }
    }
    
    @IBAction func agreeBtnClk(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: keyValue.userLogin.rawValue)
        dashboardTitle.text = NSLocalizedString(LocalizedStrings.dashboardText, comment: "")
        self.termsAndCondotionView.isHidden = true
        statusView.isHidden = false
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        productPopupFlag = 0
        calendarViewBkg.isHidden = true
        billingView.isHidden = true
        if UIDevice().userInterfaceIdiom == .pad {
            productSelectionView.isHidden = true
        }
        self.selectedCustomerContainerView.alpha = 1.0
        let fetchPid = fetchAllData(entityName: Entities.getProductBeefTblEntity)
        if fetchPid.count == 0 {
            UserDefaults.standard.set(true, forKey: keyValue.showBeefProductTbl.rawValue)
        }
    }
    
    @IBAction func donePopUpClick(_ sender: Any) {
        
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        UserDefaults.standard.set(nil, forKey: keyValue.onKey.rawValue)
        UserDefaults.standard.set(nil, forKey: keyValue.page.rawValue)
        if UserDefaults.standard.string(forKey: keyValue.name.rawValue) == marketNameType.Beef.rawValue {
            let  pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
            
            if pvid == 5 {
                //for Global
                for product in self.productArr as? [GetProductTbl] ?? [] {
                    if product.isAdded == "true" {
                        deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                        
                        let userDefault = UserDefaults.standard.integer(forKey: keyValue.bfProductId.rawValue)
                        if userDefault == Int(product.productId) {
                            
                        }
                        else {
                            deleteRecordFromDatabase(entityName: Entities.offlineOrderBeefTblEntity)
                            deleteRecordFromDatabase(entityName: Entities.productAdonAnimlBeefTblEntity)
                            deleteRecordFromDatabase(entityName: Entities.subProductBeefTblEntity)
                        }
                        
                        saveProductSaveBeef(entity: Entities.getProductBeefTblEntity, productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                        UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                    }
                    
                }
            }
            
            if pvid == 6 {
                //for Brazil
                if UserDefaults.standard.value(forKey: keyValue.dataEntryScreenSave.rawValue) as! String != ScreenNames.dataEntry.rawValue {
                    deleteRecordFromDatabase(entityName: Entities.beefAnimalAddTblEntity)
                }
                UserDefaults.standard.set("nill", forKey: keyValue.brzGenoType.rawValue)
                deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                deleteRecordFromDatabase(entityName: Entities.productAdonAnimlBeefTblEntity)
                deleteRecordFromDatabase(entityName: Entities.offlineOrderBeefTblEntity)
                deleteRecordFromDatabase(entityName: Entities.subProductBeefTblEntity)
                for product in self.productArr as? [GetProductTbl] ?? [] {
                    if product.isAdded == "true" {
                        UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                        saveProductSaveBeef(entity: Entities.getProductBeefTblEntity, productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                    }
                    else {
                        deleteDataWithProductBeef(entityName: Entities.getProductBeefTblEntity, productId: Int(product.productId))
                    }
                }
                
                let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
                let  orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
                let animalData =  beefFetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", pvid: pvid)
                
                if animalData.count > 0 {
                    let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                    
                    for k in 0 ..< animalData.count{
                        let animalId = animalData[k] as! BeefAnimaladdTbl
                        
                        for i in 0 ..< product.count {
                            
                            let data = product[i] as! GetProductTblBeef
                            beefSaveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: animalId.farmId ?? "" , orderId: Int(animalId.orderId), orderStatus: "false", isSync: "false", userId: userId,udid:animalId.udid ?? "", animalId:  Int(animalId.animalId), rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "", marketName: data.marketName ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), orderTerrms: data.orderAcceptTerms ?? "")
                            
                            
                        }
                    }
                }
                
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
                    else
                    {
                        UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                        
                    }
                }
                
                
                if isGenotypeOnlyAdded
                {
                    if isGenostarblackOnlyAdded && isGenotypeOnlyAdded
                    {
                        UserDefaults.standard.set(keyValue.genoTypeStarBlack.rawValue, forKey: keyValue.beefProduct.rawValue)
                    }
                    else{
                        UserDefaults.standard.set(keyValue.genoTypeOnly.rawValue, forKey: keyValue.beefProduct.rawValue)
                    }
                    
                }
                else {
                    if isGenostarblackOnlyAdded
                    {
                        UserDefaults.standard.set(keyValue.genStarBlack.rawValue, forKey: keyValue.beefProduct.rawValue)
                    }
                    else
                    {
                        UserDefaults.standard.set(keyValue.nonGenoType.rawValue, forKey: keyValue.beefProduct.rawValue)
                    }
                    
                }
                
            }
        }
        
        let fetchPid = fetchAllData(entityName: Entities.getProductBeefTblEntity)
        if fetchPid.count > 0 {
            if let productTblBeef = fetchPid[0] as? GetProductTblBeef {
                
                if UserDefaults.standard.string(forKey: keyValue.name.rawValue) == marketNameType.Beef.rawValue{
                    
                    let  pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
                    if pvid == 5 {
                        UserDefaults.standard.set(false, forKey: keyValue.showBeefProductTbl.rawValue)
                        UserDefaults.standard.set("true", forKey: keyValue.settingDone.rawValue)
                        if productTblBeef.productId == 20 {
                            UserDefaults.standard.set(true, forKey: keyValue.showbeefInheritTable.rawValue)
                            UserDefaults.standard.set("true", forKey: keyValue.settingDone.rawValue)
                            UserDefaults.standard.set(keyValue.capsInherit.rawValue, forKey: keyValue.beefProduct.rawValue)
                            if UserDefaults.standard.value(forKey: keyValue.dataEntryScreenSave.rawValue) as! String == ScreenNames.dataEntry.rawValue {
                                
                                if UIDevice().userInterfaceIdiom == .phone {
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                                } else {
                                    
                                    let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: Bundle.main)
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                                }
                                
                            } else {
                                
                                if UIDevice().userInterfaceIdiom == .phone {
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefAnimalGlobalHD50KVC)), animated: true)
                                } else {
                                    let storyboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: Bundle.main)
                                    
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "InheritBeefVC")), animated: true)
                                }
                            }
                        }
                        else{
                            UserDefaults.standard.set("true", forKey: keyValue.settingDone.rawValue)
                            UserDefaults.standard.set(false, forKey: keyValue.showbeefInheritTable.rawValue)
                            UserDefaults.standard.set(keyValue.globalHD50K.rawValue, forKey: keyValue.beefProduct.rawValue)
                            
                            if UserDefaults.standard.value(forKey: keyValue.dataEntryScreenSave.rawValue) as! String == ScreenNames.dataEntry.rawValue {
                                
                                if UIDevice().userInterfaceIdiom == .phone {
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                                } else {
                                    
                                    let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: Bundle.main)
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                                }
                                
                            } else {
                                deleteRecordFromDatabase(entityName: Entities.beefAnimalAddTblEntity)
                                
                                if UIDevice().userInterfaceIdiom == .phone {
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefAnimalGlobalHD50KVC)), animated: true)
                                } else {
                                    let storyboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: Bundle.main)
                                    
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "InheritBeefVC")), animated: true)
                                }
                            }
                            
                        }
                        
                    }
                    if pvid  == 13 {
                        UserDefaults.standard.set(false, forKey: keyValue.showBeefProductTbl.rawValue)
                        if productTblBeef.productId == 52 {
                            
                            UserDefaults.standard.set("true", forKey: keyValue.settingDone.rawValue)
                        }
                        
                        else{
                            UserDefaults.standard.set("true", forKey: keyValue.settingDone.rawValue)
                            UserDefaults.standard.set(false, forKey: keyValue.showbeefInheritTable.rawValue)
                        }
                        
                    }
                    if pvid == 6{
                        if UserDefaults.standard.value(forKey: keyValue.dataEntryScreenSave.rawValue) as! String == ScreenNames.dataEntry.rawValue {
                            UserDefaults.standard.set(false, forKey: keyValue.showBeefProductTbl.rawValue)
                            
                            if UIDevice().userInterfaceIdiom == .phone {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                            } else {
                                
                                let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: Bundle.main)
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeHelpVC)), animated: true)
                            }
                            
                        } else {
                            deleteRecordFromDatabase(entityName: Entities.beefAnimalAddTblEntity)
                            UserDefaults.standard.set(false, forKey: keyValue.showBeefProductTbl.rawValue)
                            if UIDevice().userInterfaceIdiom == .phone {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefAnimalBrazilVC)), animated: true)
                                return
                            } else {
                                let storyboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: Bundle.main)
                                
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefAnimalBrazilVCIpad")), animated: true)
                                
                                return
                            }
                        }}
                    if pvid == 7{
                        UserDefaults.standard.set(false, forKey: keyValue.showBeefProductTbl.rawValue)
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefAnimalNZVC)), animated: true)
                    }
                }
            }
            
            calendarViewBkg.isHidden = true
            billingView.isHidden = true
            if UIDevice().userInterfaceIdiom == .pad {
                productSelectionView.isHidden = true
            }
        } else {
            let  pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
            if pvid == 6 {
                deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
            }else{
                deleteRecordFromDatabase(entityName: Entities.offlineOrderBeefTblEntity)
                deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                deleteRecordFromDatabase(entityName: Entities.beefAnimalAddTblEntity)
                deleteRecordFromDatabase(entityName: Entities.productAdonAnimlBeefTblEntity)
                deleteRecordFromDatabase(entityName: Entities.subProductBeefTblEntity)
            }
            
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.selectProductLocalStr, comment: ""))
        }
    }
    
    @IBAction func showMenu(_ sender: UIButton) {
        self.saveResulyByPageViewModel?.timer.invalidate()
        self.workItem?.cancel()
        checkworkitem = true
        if UIDevice().userInterfaceIdiom == .phone {
            self.sideMenuViewController?.presentRightMenuViewController()
            self.view.makeCorner(withRadius: 40)
        }  else {
            self.sideMenuRevealViewController()?.revealSideMenu()
        }
    }
    
    @IBAction func offlineBtnAction(_ sender: UIButton) {
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(DashboardVC.buttonbgPressed), for: .touchUpInside)
        buttonbg.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view .addSubview(buttonbg)
        customPopView = OfflinePopUp.loadFromNibNamed(ClassIdentifiers.offlineViewNib) as? OfflinePopUp
        customPopView.delegate = self
        if UIDevice().userInterfaceIdiom == .phone {
            customPopView.frame = CGRect(x: 30,y: 160,width: screenSize.width - 30,height: screenSize.height/1.7)
            
        } else {
            customPopView.frame = CGRect(x: 30,y: 160,width: screenSize.width - 330,height: screenSize.height/1.7)
            
        }
        customPopView.center = view.center
        customPopView.layer.cornerRadius = 8
        customPopView.layer.borderWidth = 3
        customPopView.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg .addSubview(customPopView)
        
    }
}

extension DashboardVC {
    var physicalMemory: UInt64 {
        return (ProcessInfo().physicalMemory / 1024) / 1024 // in MB
    }
    
    func deviceRemainingFreeSpace() -> Int64? {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        guard
            let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: documentDirectory),
            let freeSize = systemAttributes[.systemFreeSize] as? NSNumber
        else {
            return nil
        }
        print("freeMemory = %d", (freeSize.int64Value / 1024) / 1024)
        return (freeSize.int64Value / 1024) / 1024 // in MB
    }
    func checkandCompareDate(){
        let freeSpaceValue = 500
        let date = Date()
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm"
        
        print(date)
        let dataStr =  dateFormatterGet.string(from: date)
  
        if (UserDefaults.standard.object(forKey: "LowMemoryDate") == nil){
            
            if let freespace =  deviceRemainingFreeSpace() {
                if freespace <= freeSpaceValue  {
                    UserDefaults.standard.setValue(dataStr, forKey: "LowMemoryDate")
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: LocalizedStrings.memomeryLowInfo.localized )
                    
                }
            }
        } else {
            let date = Date()
            let endDatestr = dateFormatterGet.string(from: date)
            let startValue = UserDefaults.standard.object(forKey: "LowMemoryDate")
            let startDate = dateFormatterGet.date(from: startValue as! String)!
            let endDate = dateFormatterGet.date(from: endDatestr)!
            let differenceInHours = Calendar.current.dateComponents([.hour], from: startDate, to: endDate).hour
            print(differenceInHours as Any)
            if differenceInHours ?? 0 > 24{
                UserDefaults.standard.setValue(endDatestr, forKey: "LowMemoryDate")
                if let freespace =  deviceRemainingFreeSpace() {
                    if freespace <= freeSpaceValue {
                        
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: LocalizedStrings.memomeryLowInfo.localized )
                        
                    }
                }
                
            }
        }
        
    }
}

extension DashboardVC: UIGestureRecognizerDelegate {
    @objc func TapGestureRecognizer(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if self.isExpanded {
                self.sideMenuState(expanded: false)
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.sideMenuViewVC.view))! {
            return false
        }
        return true
    }
}

extension UIViewController {
    
    func sideMenuRevealViewController() -> DashboardVC? {
        var viewController: UIViewController? = self
        
        if viewController != nil && viewController is DashboardVC {
            return viewController! as? DashboardVC
        }
        while (!(viewController is DashboardVC) && viewController?.parent != nil) {
            viewController = viewController?.parent
        }
        if viewController is DashboardVC {
            return viewController as? DashboardVC
        }
        return nil
    }
}

