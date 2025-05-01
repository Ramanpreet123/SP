//
//  ReviewOrderVC.swift
//  SearchPoint
//
//  Created by "" on 07/10/2019.
//  ""
//

import UIKit
import CoreData
import DropDown

//MARK: REVIEW ORDER VC
class ReviewOrderVC: UIViewController {
    
    //MARK: IB OUTLETS
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
        languageConversion(languageId: langId!)
        
    }
    
    func setUIOnWillAppear(){
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
            self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
            if pviduser == 4 {
                self.clickOnDropDown = NSLocalizedString(ButtonTitles.earTagText, comment: "")
                self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
            }
            
            if pviduser == 2 {
                self.clickOnDropDown = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
                self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
            }
        }
        if UserDefaults.standard.string(forKey: keyValue.foReviewOrderVC.rawValue) == keyValue.farmId.rawValue {
            self.clickOnDropDown = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
            self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
            if pviduser == 4 {
                UserDefaults.standard.set(ButtonTitles.earTagText, forKey: keyValue.foReviewOrderVC.rawValue)
                self.clickOnDropDown = NSLocalizedString(ButtonTitles.earTagText, comment: "")
                self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
            }
            
            if pviduser == 2 {
                self.clickOnDropDown = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
                self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
            }
        }
        
        if UserDefaults.standard.string(forKey: keyValue.foReviewOrderVC.rawValue) == keyValue.officialId.rawValue {
            self.clickOnDropDown = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
            self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
        }
        
        if UserDefaults.standard.string(forKey: keyValue.foReviewOrderVC.rawValue) == keyValue.barcode.rawValue {
            self.clickOnDropDown = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
            self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
            
        }
        if UserDefaults.standard.string(forKey: keyValue.foReviewOrderVC.rawValue) == ButtonTitles.earTagText {
            self.clickOnDropDown = NSLocalizedString(ButtonTitles.earTagText, comment: "")
            self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
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
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
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
    
    //MARK: METHODS AND FUNCTIONS
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
        for object in fethDat {
            productNameArray.append(object.productName!)
            set = Array(Set(productNameArray))
        }
        
        uniqueProductArray = Dictionary(grouping: fethDat, by: { $0.productName! })
        set = set.sorted(by: {$0 < $1})
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
