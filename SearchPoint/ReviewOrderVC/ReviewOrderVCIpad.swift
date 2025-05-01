//
//  ReviewOrderVCIpad.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 23/02/25.
//

import Foundation
import UIKit
import CoreData
import DropDown

//MARK: REVIEW ORDER VC
class ReviewOrderVCIpad: UIViewController {
    
    //MARK: IB OUTLETS
    @IBOutlet weak var innerScrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var nominatorView: UIView!
    @IBOutlet weak var sortByTitle: UILabel!
    @IBOutlet weak var menuIconLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var infoButton1: UIButton!
    @IBOutlet weak var infoButton2: UIButton!
    @IBOutlet weak var infoButton3: UIButton!
    @IBOutlet weak var sortByBarcodeBtn: UIButton!
    @IBOutlet weak var sortByBarcodeImgView: UIImageView!
    @IBOutlet weak var sortByOfficialIDImgView: UIImageView!
    @IBOutlet weak var sortByOfficialIDBtn: UIButton!
    @IBOutlet weak var sortByFarmImgView: UIImageView!
    @IBOutlet weak var sortByFarmIDBtn: UIButton!
    @IBOutlet weak var sortByAscendingBtn: UIButton!
    @IBOutlet weak var sortByAscendingImgView: UIImageView!
    @IBOutlet weak var sortByAscendingBrazilImgView: UIImageView!
    @IBOutlet weak var sortByDescendingBrazilImgView: UIImageView!
    @IBOutlet weak var sortByDescendingBtn: UIButton!
    @IBOutlet weak var sortByDescendingImgView: UIImageView!
    @IBOutlet weak var sortByView: UIView!
    @IBOutlet weak var sortByBrazilView: UIView!
    @IBOutlet weak var sortByBrazilBarcodeBtn: UIButton!
    @IBOutlet weak var sortByBrazilBarcodeImgView: UIImageView!
    @IBOutlet weak var sortByEarTagImgView: UIImageView!
    @IBOutlet weak var sortByEarTagBtn: UIButton!
    @IBOutlet weak var agreeStackViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var placeAnOrderImgView: UIImageView!
    @IBOutlet weak var emailBtnImgView: UIImageView!
    @IBOutlet weak var AgreeBtnImgView: UIImageView!
    @IBOutlet weak var emailMeStackViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nominatorBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailMeSelectionOutlet: UIButton!
    @IBOutlet weak var billingContact: UILabel!
    @IBOutlet weak var nominatorlbl: UILabel!
    @IBOutlet weak var nominatorTitle: UILabel!
    @IBOutlet weak var providerLbl: UILabel!
    @IBOutlet weak var evaluationTitle: UILabel!
    @IBOutlet weak var submitOrderOutlet: UIButton!
    @IBOutlet weak var placeAnOrderSelectionOutlet: UIButton!
    @IBOutlet weak var placeAnotrderTitle: UILabel!
    @IBOutlet weak var emailMeEnterTtitle: UILabel!
    @IBOutlet weak var infoBtnSelectionOutlet: UIButton!
    @IBOutlet weak var customerNameLbl: UILabel!
    @IBOutlet weak var agrreLbl: UILabel!
    @IBOutlet weak var agrreLblStackView: UIStackView!
    @IBOutlet weak var billingViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var notificationLblCount: UILabel!
    @IBOutlet weak var billingTblView: UITableView!
    @IBOutlet weak var networlStatusImage: UIImageView!
    @IBOutlet weak var searchTxt: UITextField!
    @IBOutlet weak var toggleBtn: UIButton!
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBOutlet weak var OfflineBtn: UIButton!
    @IBOutlet weak var appSatatusLbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var crossBtnOutlet: UIButton!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var farmIdHideLbl: UILabel!
    @IBOutlet weak var appStatusLbl: UILabel!
    @IBOutlet weak var viewByTitle: UILabel!
    @IBOutlet weak var reviewOrderScreenTitle: UILabel!
    @IBOutlet weak var animalTitle: UILabel!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var tableViewBg: UIView!
    @IBOutlet weak var bckRoundView: UIView!

    //MARK: VARIABLES AND CONSTANTS
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
    weak var delegateCustom : objectPickfromConfilict?
    weak var dismissDelegate : DismissConflictPopUp?
    var isAgree = false
    var conficlitOrders = NSMutableArray()
    var clickOnDropDown = String()
    var attrs : [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 12),
        .foregroundColor: UIColor.blue,
        .underlineStyle: NSUnderlineStyle.single.rawValue]
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    let dropDown = DropDown()
    var set = [String]()
    var uniqueProductArray = Dictionary<String, [ProductAdonAnimalTbl]>()
    var allAnimalProductArray = [ProductAdonAnimalTbl]()
    var itemSelection = String()
    var toggleFlag : Int = 0
    var arrCombined : NSMutableArray!
    var reviewOrderListObject = ReviewOrderListVc()
    var userId = Int()
    var orderId = Int()
    var ascendingFound = true
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    let buttonbg1 = UIButton ()
    var customPopView1 :TipPopUp!
    var heartBeatViewModel:HeartBeatViewModel?
    var farmAddr = [GetBillingContact]()
    var custmerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    var tissueArr = NSArray()
    let buttonbg2 = UIButton ()
    var droperTableView  = UITableView ()
    let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
    var value = 0

    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIOnDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUIOnWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(Notification.Name(keyValue.notificationIdentifier.rawValue))
    }
    
    override func viewDidLayoutSubviews() {
        searchTxt.layer.cornerRadius = 15
    }
    
    //MARK: INITIAL UI METHODS
    func setUIOnDidLoad(){
        self.setSideMenu()
        self.sortByView.isHidden = true
        searchTxt.setLeftPaddingPoints(20.0)
        farmAddr = fetchBillingCustomer(entityName: Entities.getBillingContactEntity,customerID: self.custmerId) as! [GetBillingContact]
        heartBeatViewModel?.callGetHearBeatData()
        userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        let animaltbl = fetchRemaningSubmitOrder(entityName: Entities.animalAddTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
        
        for i in 0..<animaltbl.count{
            let data = animaltbl.object(at: i) as! AnimaladdTbl
            deleteRemaningSubmitOrderReview(entityName: Entities.productAdonAnimalTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId, aid: Int(data.animalId))
            deleteRemaningSubmitOrderReview(entityName: Entities.subProductTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId,aid: Int(data.animalId))
        }
        deleteRemaningSubmitOrder(entityName: Entities.animalAddTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.OfflineBtn.isHidden = true
        initialNetworkCheck()
        searchTxt?.delegate = self
        tableViewBg.isHidden = true
        bckRoundView.isHidden = true
      //  languageConversion(languageId: langId!)
        self.setBillingDetails()
        setTermsConditionUI()
        setSubmitOrderInitialUI()
    }
    
    func setUIOnWillAppear(){
        switch UIScreen.main.bounds.height {
        case 768:
            self.innerScrollViewHeight.constant = 600
            
        case 810:
            self.innerScrollViewHeight.constant = 600
            
        case 820:
            self.innerScrollViewHeight.constant = 600
            

        case 834:
            self.innerScrollViewHeight.constant = 600

        case 1024:
            self.innerScrollViewHeight.constant = 750

        case 1032:
            self.innerScrollViewHeight.constant = 750
        default:
            break
        }
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid)
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
        for item in animalCount  {
            let data = item as! AnimaladdTbl
            let screen  = UserDefaults.standard.value(forKey: keyValue.screen.rawValue) as? String
            if screen == keyValue.farmId.rawValue {
                let marketName = UserDefaults.standard.value(forKey: keyValue.marketName.rawValue) as? String
                if marketName == keyValue.brazilMarket.rawValue {
                    if pviduser == 1 || pviduser == 8 {
                        if data.date == "" {
                            UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                            UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlagNew.rawValue)
                            break
                        } else {
                            UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlag.rawValue)
                            UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlagNew.rawValue)
                        }
                    }
                }
                
                if pviduser == 1 || pviduser == 3 || pviduser == 10 || pviduser == 11 || pviduser == 12 {
                    if pviduser == 3 {
                        if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                            if data.date == "" {
                                UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                                UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlagNew.rawValue)
                                break
                            }
                            else {
                                UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlag.rawValue)
                                UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlagNew.rawValue)
                            }
                        }
                    }
                    if data.animalTag == "" || data.farmId == "" || data.date == ""{
                        UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                        UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlagNew.rawValue)
                        break
                    } else {
                        UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlag.rawValue)
                        UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlagNew.rawValue)
                    }
                }
            }
            else {
                if pviduser == 1 || pviduser == 3  || pviduser == 10 || pviduser == 11 || pviduser == 12 {
                    if data.farmId == "" || data.animalTag == "" || data.date == ""{
                        UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                        UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlagNew.rawValue)
                        break
                    } else {
                        UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlag.rawValue)
                        UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlagNew.rawValue)
                    }
                }
            }
            
            if pviduser == 2 {
                if  data.animalTag == "" || data.date == ""{
                    UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlagNew.rawValue)
                    break
                } else {
                    UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlag.rawValue)
                    UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlagNew.rawValue)
                }
            }
            
            if pviduser == 4  {
                if data.animalName == "" || data.date == ""{
                    UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlagNew.rawValue)
                    break
                }
                else {
                    UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlag.rawValue)
                    UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlagNew.rawValue)
                }
            }
        }
        
        if UserDefaults.standard.string(forKey: keyValue.foReviewOrderVC.rawValue) == nil || UserDefaults.standard.string(forKey: keyValue.foReviewOrderVC.rawValue) == ""{
            self.clickOnDropDown =  NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
          //  self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
            self.sortByFarmImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
            self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
            self.sortByTitle.text = self.clickOnDropDown
            if pviduser == 4 {
                self.sortByTitle.text = ButtonTitles.earTagText
                self.clickOnDropDown = NSLocalizedString(ButtonTitles.earTagText, comment: "")
              //  self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
                self.sortByEarTagImgView.image = UIImage(named: "radioSeletedBtn")
                self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
            }
            
            if pviduser == 2 {
                self.clickOnDropDown = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
               // self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
                self.sortByFarmImgView.image = UIImage(named: "radioBtn")
                self.sortByOfficialIDImgView.image = UIImage(named: "radioSeletedBtn")
                self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
                self.sortByTitle.text = self.clickOnDropDown
            }
        }
        if UserDefaults.standard.string(forKey: keyValue.foReviewOrderVC.rawValue) == keyValue.farmId.rawValue {
            self.clickOnDropDown = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
          //  self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
            self.sortByTitle.text = self.clickOnDropDown
            self.sortByFarmImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
            self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
            if pviduser == 4 {
                UserDefaults.standard.set(ButtonTitles.earTagText, forKey: keyValue.foReviewOrderVC.rawValue)
                self.sortByTitle.text = ButtonTitles.earTagText
                self.clickOnDropDown = NSLocalizedString(ButtonTitles.earTagText, comment: "")
                self.sortByEarTagImgView.image = UIImage(named: "radioSeletedBtn")
                self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
              //  self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
            }
            
            if pviduser == 2 {
                self.clickOnDropDown = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
              //  self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
                self.sortByTitle.text = self.clickOnDropDown
                self.sortByFarmImgView.image = UIImage(named: "radioBtn")
                self.sortByOfficialIDImgView.image = UIImage(named: "radioSeletedBtn")
                self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
            }
        }
        
        if UserDefaults.standard.string(forKey: keyValue.foReviewOrderVC.rawValue) == keyValue.officialId.rawValue {
            self.clickOnDropDown = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
          //  self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
            self.sortByTitle.text = self.clickOnDropDown
                    self.sortByFarmImgView.image = UIImage(named: "radioBtn")
                    self.sortByOfficialIDImgView.image = UIImage(named: "radioSeletedBtn")
                    self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
        }
        
        if UserDefaults.standard.string(forKey: keyValue.foReviewOrderVC.rawValue) == keyValue.barcode.rawValue {
            self.clickOnDropDown = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
           // self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
            self.sortByTitle.text = self.clickOnDropDown
            self.sortByFarmImgView.image = UIImage(named: "radioBtn")
            self.sortByOfficialIDImgView.image = UIImage(named: "radioBtn")
            self.sortByBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
            if pviduser == 4 {
                self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
                self.sortByEarTagImgView.image = UIImage(named: "radioBtn")
            }
            
        }
        if UserDefaults.standard.string(forKey: keyValue.foReviewOrderVC.rawValue) == ButtonTitles.earTagText {
            self.sortByTitle.text = ButtonTitles.earTagText
            self.clickOnDropDown = NSLocalizedString(ButtonTitles.earTagText, comment: "")
            self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
            self.sortByEarTagImgView.image = UIImage(named: "radioSeletedBtn")
           // self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
        }
        
        search()
        initialNetworkCheck()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        notificationLblCount.text = String(animalCount.count)
        
        for item in animalCount  {
            let data = item as! AnimaladdTbl
            if data.animalTag == "" || data.farmId == "" && pviduser != 2 || data.date == ""{
                self.conficlitOrders.add(data)
            }
        }
      NotificationCenter.default.addObserver(self, selector: #selector(self.addonsRecive(notification:)), name: Notification.Name("ReviewAddons"), object: nil)
        self.setBillingDetails()
        setTermsConditionUI()
        setSubmitOrderInitialUI()
    }
    
    //MARK: OBJC SELECTOR METHODS
    @objc  func checkForReachability(notification:Notification) {
        let del =  UIApplication.shared.delegate as? AppDelegate
        self.appSatatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if appSatatusLbl?.text == ButtonTitles.connectedText.localized {
            self.OfflineBtn.isHidden = true
            self.networlStatusImage.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else{
            appSatatusLbl?.text = ButtonTitles.notConnectedText.localized
            self.OfflineBtn.isHidden = false
            self.networlStatusImage.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    @objc func buttonbgPressedTipTerms (){
        buttonbg1.removeFromSuperview()
        customPopView1.removeFromSuperview()
    }
    
    @objc func buttonbgPressedTip1 (){
        buttonbg1.removeFromSuperview()
        customPopView1.removeFromSuperview()
    }
    
    @objc func addonsRecive(notification: Notification) {
        var animalIdN = Int()
        var productIdN = Int()
        if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as! String  == marketNameType.Beef.rawValue{
            animalIdN = notification.userInfo![keyValue.animalId.rawValue] as! Int
            productIdN = notification.userInfo![keyValue.smallProductId.rawValue] as! Int
        } else {
            animalIdN = notification.userInfo![keyValue.animalId.rawValue] as! Int
            productIdN = notification.userInfo![keyValue.smallProductId.rawValue] as! Int
        }
        let vc = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.reviewAddonsControllerVC) as! ReviewAddonsController
        vc.animalId = animalIdN
        vc.productId = productIdN
        self.navigationController?.present(vc, animated: false, completion: nil)
    }
    
    @objc func methodOfReceivedNotification(notification: Notification){
        if value == 0{
            UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
            let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
            self.hideIndicator()
            value = value + 1
        }
    }
    
    @objc func buttonbgPressedTip (){
        buttonbg1.removeFromSuperview()
        customPopView1.removeFromSuperview()
    }
    
    @objc func buttonPreddDroper() {
        buttonbg2.removeFromSuperview()
    }

    @objc func buttonbgPressed (){
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    //MARK: SIDE MENU UI METHODS
    func setSideMenu(){
        if UIDevice.current.orientation.isLandscape {
            self.sideMenuRevealWidth = 300
        }
        else {
            self.sideMenuRevealWidth = 260
            
        }
        
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapGestureRecognizer))
//        tapGestureRecognizer.numberOfTapsRequired = 1
//        tapGestureRecognizer.delegate = self
        
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
    
    func sideMenuRevealSettingsViewController() -> ReviewOrderVCIpad? {
        var viewController: UIViewController? = self
        
        if viewController != nil && viewController is ReviewOrderVCIpad {
            return viewController! as? ReviewOrderVCIpad
        }
        while (!(viewController is ReviewOrderVCIpad) && viewController?.parent != nil) {
            viewController = viewController?.parent
        }
        if viewController is ReviewOrderVCIpad {
            return viewController as? ReviewOrderVCIpad
        }
        return nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        //location is relative to the current view
        // do something with the touched point
        if touch?.view != self.sideMenuViewVC {
            sideMenuState(expanded: false)
        }
    }
    //MARK: METHODS AND FUNCTIONS
    
    func setBillingDetails(){
        if farmAddr.count > 0  {
            var abc = ""
            let filterArr = farmAddr.filter({$0.isDefault == true })
            if filterArr.count > 0{
                abc = filterArr[0].contactName ?? ""
            } else{
                let billArray =  farmAddr.filter({Int($0.billToCustId!) == self.custmerId})
                abc = billArray[0].contactName ?? ""
                UserDefaults.standard.set(billArray[0].billToCustId, forKey: keyValue.billToCustomerId.rawValue)
            }
            //   let attributeString = NSMutableAttributedString(string: abc, attributes: self.attrs)
            // billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
          
            customerNameLbl.text = abc
//            if customerNameLbl.text!.count > 28 {
//                customerNameLbl.font = customerNameLbl.font.withSize(14)
//            } else {
//                customerNameLbl.font = customerNameLbl.font.withSize(22)
//            }
            UserDefaults.standard.set(abc, forKey: keyValue.farmValue.rawValue)
        }
      
    }
    
    func setTermsConditionUI(){
        
        if ( UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool  ==  false ) || (UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool  ==  nil ) {
         //   infoBtnSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
            AgreeBtnImgView.image = UIImage(named: "Incremental_Check")
        } else {
         //   infoBtnSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
            AgreeBtnImgView.image = UIImage(named: "incrementalCheckIpad")
        }
        if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == true{
            self.infoBtnSelectionOutlet.isHidden = true
        } else {
            self.infoBtnSelectionOutlet.isHidden = false
        }
    }
    
    
    func setSubmitOrderInitialUI(){
        self.billingContact.text = NSLocalizedString(LocalizedStrings.billingContact, comment: "")
        if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) == keyValue.clarifideCDCBUS.rawValue {
            self.nominatorlbl.isHidden = false
            self.nominatorTitle.isHidden = false
            self.nominatorView.isHidden = false
        }
        else{
            self.nominatorlbl.isHidden = true
            self.nominatorTitle.isHidden = true
            self.nominatorView.isHidden = true
        }
        
        if UserDefaults.standard.value(forKey: keyValue.nominatorSave.rawValue) == nil || UserDefaults.standard.value(forKey: keyValue.nominatorSave.rawValue) as? String == ""{
            self.nominatorlbl.text = "Zoetis"
        }
        else {
            let nomi = UserDefaults.standard.value(forKey: keyValue.nominatorSave.rawValue) as? String
            let ab  = nomi!.uppercased()
            self.nominatorlbl.text = ab
        }
        self.nominatorTitle.text = ButtonTitles.nominatorText.localized
        self.evaluationTitle.text = NSLocalizedString(LocalizedStrings.providerMarkets, comment: "")
        if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String  == marketNameType.Dairy.rawValue{
            self.submitOrderOutlet.setTitle(NSLocalizedString(ButtonTitles.submitText, comment: ""), for: .normal)
         //   cell.pricingTextView.delegate = self
            let clariText = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
            let ab  = clariText!
            self.providerLbl.text = ab
//            if self.providerLbl.text!.count > 21 {
//                self.providerLbl.font = self.providerLbl.font.withSize(15)
//            } else {
//                self.providerLbl.font = self.providerLbl.font.withSize(22)
//            }
            self.delegateCustom = self
            self.dismissDelegate = self
          let pviduser1 = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
          if pviduser1 == 4 {
            let checkCartAnimal =  fetchAllDataGirlandoAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",animalTag:"", pvid: pviduser1,dob: "", animalName: "")
            if checkCartAnimal.count != 0 {
              UserDefaults.standard.setValue(true, forKey: keyValue.submitBtnFlag.rawValue)
              
            } else {
              UserDefaults.standard.setValue(false, forKey: keyValue.submitBtnFlag.rawValue)
              
            }
          } else {
            let checkCartAnimal =  fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",farmid:"",animalTag:"", pvid:pviduser1, dob: "")
            if checkCartAnimal.count != 0 {
              UserDefaults.standard.setValue(true, forKey: keyValue.submitBtnFlag.rawValue)
              
            } else {
              UserDefaults.standard.setValue(false, forKey: keyValue.submitBtnFlag.rawValue)
              
            }
          }
         
          if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == true{
            //  self.infoButton1.isHidden = true
              self.infoBtnSelectionOutlet.isHidden = true
              self.agrreLblStackView.isHidden = true
              agreeStackViewTopConstraint.constant = -70
              self.submitOrderOutlet.isHidden = false
            //  self.infoButton3.isHidden = false
            } else {
                self.submitOrderOutlet.isHidden = false
            //    self.infoButton3.isHidden = false
                self.agrreLbl.isHidden = false
            //    self.infoButton1.isHidden = false
                self.infoBtnSelectionOutlet.isHidden = false
                self.agrreLblStackView.isHidden = false
                agreeStackViewTopConstraint.constant = 20
            }
            if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
                self.placeAnOrderSelectionOutlet.isSelected = true
            } else {
                self.placeAnOrderSelectionOutlet.isSelected = false
            }
            let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
            if UserDefaults.standard.value(forKey: keyValue.submitTypeSelection.rawValue) as? String == keyValue.emailMe.rawValue || UserDefaults.standard.value(forKey: keyValue.submitTypeSelection.rawValue) as? String == "" ||  UserDefaults.standard.value(forKey: keyValue.submitTypeSelection.rawValue) as? String == nil{
                UserDefaults.standard.setValue(keyValue.emailMe.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
                UserDefaults.standard.setValue(keyValue.email.rawValue, forKey: keyValue.emailFlag.rawValue)
                if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true{
                   // self.emailMeSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                    emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                }
                else  if self.emailMeSelectionOutlet.isSelected == false{
                 //   self.emailMeSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                    emailBtnImgView.image = UIImage(named: "Incremental_Check")
                }
                if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
                //    self.placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                    placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                    
                }
                else  if self.placeAnOrderSelectionOutlet.isSelected == false{
                 //   self.placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                    placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                }
              //  self.placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                self.placeAnotrderTitle.alpha = 1.0
            }
            else {
                if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true{
                   // self.emailMeSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                    emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                }
                else  if self.emailMeSelectionOutlet.isSelected == false{
                  //  self.emailMeSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                    emailBtnImgView.image = UIImage(named: "Incremental_Check")
                }
                if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
                    //self.placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                    placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                }
                else  if self.placeAnOrderSelectionOutlet.isSelected == false{
                 //   self.placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                    placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                }
                UserDefaults.standard.setValue(keyValue.submitKey.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
                self.placeAnotrderTitle.alpha = 1
            }
            
            if pviduser == 1 || pviduser == 2 || pviduser == 3 || pviduser == 10 || pviduser == 11 || pviduser == 12 {
                if fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",farmid:"",animalTag:"",pvid: pviduser).count == 0 {
                    self.placeAnOrderSelectionOutlet.alpha = 1
                    self.placeAnotrderTitle.alpha = 1
                    if UserDefaults.standard.value(forKey: keyValue.submitTypeSelection.rawValue) as? String ==  keyValue.submitKey.rawValue{
                        if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
                           // self.placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                        }
                        else  if self.placeAnOrderSelectionOutlet.isSelected == false{
                          //  self.placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                        }
                        
                        if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true{
                          //  self.emailMeSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                        }
                        else  if self.emailMeSelectionOutlet.isSelected == false{
                          //  self.emailMeSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            emailBtnImgView.image = UIImage(named: "Incremental_Check")
                        }
                    }
                    else {
                        if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true{
                          //  self.emailMeSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                        }
                        else  if self.emailMeSelectionOutlet.isSelected == false{
                           // self.emailMeSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            emailBtnImgView.image = UIImage(named: "Incremental_Check")
                        }
                        
                        if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
                          //  self.placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                        }
                        else  if self.placeAnOrderSelectionOutlet.isSelected == false{
                           // self.placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                        }
                    }
                }
                else {
                    if pviduser == 3 {
                        if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue && UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == false{
                            self.placeAnOrderSelectionOutlet.alpha = 1
                            self.placeAnotrderTitle.alpha = 1
                        }
                        else {
                            self.placeAnOrderSelectionOutlet.alpha = 0.6
                            self.placeAnotrderTitle.alpha = 0.6
                        }
                    }
                    else {
                        if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == false && UserDefaults.standard.bool(forKey: keyValue.submitBtnFlagNew.rawValue) == true {
                            self.placeAnOrderSelectionOutlet.alpha = 1
                            self.placeAnotrderTitle.alpha = 1
                        }
                        else {
                            self.placeAnOrderSelectionOutlet.alpha = 0.6
                            self.placeAnotrderTitle.alpha = 0.6
                        }
                    }
                }
            }
            
            if pviduser == 4 || pviduser == 6 || pviduser == 8  {
                if fetchAllDataAnimalGirlando(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",animalName:"",breedRegNumber:"", dateString:"").count == 0 {
                    self.placeAnOrderSelectionOutlet.alpha = 1
                    
                    if UserDefaults.standard.value(forKey: keyValue.submitTypeSelection.rawValue) as? String ==  keyValue.submitKey.rawValue {
                        if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
                          //  self.placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                        }
                        else  if self.placeAnOrderSelectionOutlet.isSelected == false{
                          //  self.placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                        }
                        if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true{
                          //  self.emailMeSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                            
                        }
                        else  if self.emailMeSelectionOutlet.isSelected == false{
                        //    self.emailMeSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            emailBtnImgView.image = UIImage(named: "Incremental_Check")
                        }
                    }
                    else {
                        if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true{
                         //   self.emailMeSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                        }
                        else  if self.emailMeSelectionOutlet.isSelected == false{
                          //  self.emailMeSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            emailBtnImgView.image = UIImage(named: "Incremental_Check")
                        }
                        
                        if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
                           // self.placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                        }
                        else  if self.placeAnOrderSelectionOutlet.isSelected == false{
                           // self.placeAnOrderSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                        }
                        self.emailMeEnterTtitle.alpha = 1
                        self.placeAnotrderTitle.alpha = 1
                    }
                } else {
                    self.placeAnOrderSelectionOutlet.alpha = 0.6
                    self.placeAnotrderTitle.alpha = 0.6
                }
            }
        }
    }
    
    func initialNetworkCheck(){
        self.OfflineBtn.isHidden = true
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del =  UIApplication.shared.delegate as? AppDelegate
        self.appSatatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if appSatatusLbl?.text == ButtonTitles.connectedText.localized{
            self.OfflineBtn.isHidden = true
            self.networlStatusImage.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else{
            appSatatusLbl?.text = ButtonTitles.notConnectedText.localized
            self.OfflineBtn.isHidden = false
            self.networlStatusImage.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    func languageConversion(languageId :Int){
        appStatusLbl.text = NSLocalizedString(ButtonTitles.appStatusText, comment: "")
        viewByTitle.text = NSLocalizedString("View By", comment: "")
        reviewOrderScreenTitle.text = NSLocalizedString(ButtonTitles.reviewOrderText, comment: "")
        animalTitle.text = NSLocalizedString(ButtonTitles.animalText, comment: "")
        productTitle.text = NSLocalizedString(ButtonTitles.productText, comment: "")
        searchTxt.placeholder = NSLocalizedString(ButtonTitles.searchText, comment: "")
    }
 
    func search(){
        guard let fethDat =  fetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId) as? [ProductAdonAnimalTbl] else {
            return
        }
        
        var productNameArray = [String]()
        var sortedArray : [ProductAdonAnimalTbl]
        if ascendingFound{
            if UserDefaults.standard.value(forKey: keyValue.foReviewOrderVC.rawValue) as? String == keyValue.officialId.rawValue{
                sortedArray = (fethDat.sorted(by: {$0.animalTag ?? "" > $1.animalTag ?? ""}))
            }else if UserDefaults.standard.value(forKey: keyValue.foReviewOrderVC.rawValue) as? String == keyValue.barcode.rawValue{
                sortedArray = (fethDat.sorted(by: {$0.animalbarCodeTag ?? "" > $1.animalbarCodeTag ?? ""}))
            }
            else if UserDefaults.standard.value(forKey: keyValue.foReviewOrderVC.rawValue) as? String == ButtonTitles.earTagText{
                sortedArray = (fethDat.sorted(by: {$0.earTag ?? "" > $1.earTag ?? ""}))
            }else{
                
                sortedArray = (fethDat.sorted(by: {$0.farmId ?? "" > $1.farmId ?? ""}))
            }
        } else{
            if UserDefaults.standard.value(forKey: keyValue.foReviewOrderVC.rawValue) as! String == keyValue.officialId.rawValue{
                sortedArray = (fethDat.sorted(by: {$0.animalTag ?? "" < $1.animalTag ?? ""}))
            }else if UserDefaults.standard.value(forKey: keyValue.foReviewOrderVC.rawValue) as! String == keyValue.barcode.rawValue{
                sortedArray = (fethDat.sorted(by: {$0.animalbarCodeTag ?? "" < $1.animalbarCodeTag ?? ""}))
            }else if UserDefaults.standard.value(forKey: keyValue.foReviewOrderVC.rawValue) as! String == ButtonTitles.earTagText{
                sortedArray = (fethDat.sorted(by: {$0.earTag ?? "" < $1.earTag ?? ""}))
            }else{
                sortedArray = (fethDat.sorted(by: {$0.farmId ?? "" < $1.farmId ?? ""}))
            }
        }
        for object in sortedArray {
            productNameArray.append(object.productName!)
            set = Array(Set(productNameArray))
        }
        
        uniqueProductArray = Dictionary(grouping: sortedArray, by: { $0.productName! })
       
        reviewOrderListObject.set = set
        reviewOrderListObject.uniqueProductArray = uniqueProductArray
        reviewOrderListObject.itemSelection = clickOnDropDown
        reviewOrderListObject.delegateCustomNew = self
        tblView.delegate = reviewOrderListObject
        tblView.dataSource = reviewOrderListObject
        tblView.reloadData()
    }
    
    func tableViewpop() {
        buttonbg2.frame = CGRect(x:0,y: 0,width: 1024,height: 1000)
        buttonbg2.addTarget(self, action:#selector(ReviewOrderVC.buttonPreddDroper), for: .touchUpInside)
        buttonbg2.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        self.view.addSubview(buttonbg2)
        droperTableView.delegate = self
        droperTableView.dataSource = self
        droperTableView.layer.cornerRadius = 8.0
        droperTableView.layer.borderWidth = 0.5
        droperTableView.layer.borderColor =  UIColor.gray.cgColor
        buttonbg2.addSubview(droperTableView)
    }
}
