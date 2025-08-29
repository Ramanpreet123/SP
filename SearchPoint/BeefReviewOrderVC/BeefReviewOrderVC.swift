//
//  BeefReviewOrderVC.swift
//  SearchPoint
//
//  Created by "" on 12/03/20.
//


import UIKit
import CoreData
import DropDown


class BeefReviewOrderVC: UIViewController,UITextFieldDelegate,objectPickCartScreen,offlineCustomView1,objectPickfromConfilict,objectPickforcellDelegate {
    func selectionObjectcell(check: Bool) {
        
        if check {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BeefConfilictOrdersViewController") as! BeefConfilictOrdersViewController
            vc.delegateCustom1 = self
            vc.screenName = "beefreviewVc"
            self.present(vc, animated: true, completion: nil)
            
            
        }
    }
    func selectionObject(check: Bool) {
        if check {
            
            let beefPvid = (UserDefaults.standard.integer(forKey:"BeefPvid") as? Int)!
            if beefPvid == 5 {
                let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalGlobalHD50KVC") as! BeefAnimalGlobalHD50KVC
                self.navigationController!.pushViewController(secondViewController, animated: false)
            }
            
            else if beefPvid == 6 {
                let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalBrazilVC") as! BeefAnimalBrazilVC
                self.navigationController!.pushViewController(secondViewController, animated: false)
            }
            
            
        } else {
            
            let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
            self.navigationController!.pushViewController(secondViewController, animated: false)
            
        }
    }
    func crossBtn() {
        // Intentionally left empty.
        // This function will handle navigation to another view controller in the future.
        // Currently unused, but kept for consistency with protocol or planned implementation.
    }
    
    func objectGetOnSelection(temp: Int) {
        // Intentionally left empty.
        // This function will handle navigation to another view controller in the future.
        // Currently unused, but kept for consistency with protocol or planned implementation.
    }
    
    func anOptionalMethod(check: Bool) {
        // Intentionally left empty.
        // This function will handle navigation to another view controller in the future.
        // Currently unused, but kept for consistency with protocol or planned implementation.
    }
    var custmerId = UserDefaults.standard.value(forKey: "currentActiveCustomerId") as! Int
    var farmAddr = [GetBillingContact]()
    
  
    @IBOutlet weak var billingViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var submitBttn: UIButton!
    @IBOutlet weak var appHelpBtn: UIButton!
    @IBOutlet weak var billingTitle: UILabel!
    @IBOutlet weak var selectBillingLbl: UILabel!
    @IBOutlet weak var notificationLblCount: UILabel!
    @IBOutlet weak var billingTblView: UITableView!
    @IBOutlet weak var networlStatusImage: UIImageView!
    @IBOutlet weak var searchTxt: UITextField!
    var clickOnDropDown = String()
    @IBOutlet weak var toggleBtn: UIButton!
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBOutlet weak var OfflineBtn: UIButton!
    @IBOutlet weak var appSatatusLbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    var attrs : [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 13),
        .foregroundColor: UIColor.blue,
        .underlineStyle: NSUnderlineStyle.single.rawValue]
    
    @IBOutlet weak var crossBtnOutlet: UIButton!
    @IBOutlet weak var tblView: UITableView!
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    let dropDown = DropDown()
    var set = [String]()
    var uniqueProductArray = Dictionary<String, [ProductAdonAnimlTbLBeef]>()
    var allAnimalProductArray = [ProductAdonAnimlTbLBeef]()
    var itemSelection = String()
    var toggleFlag : Int = 0
    var arrCombined : NSMutableArray!
    var reviewOrderListObject = ReviewOrderListVc()
    var langId = UserDefaults.standard.value(forKey: "lngId") as? Int
    
    var userId = UserDefaults.standard.integer(forKey: "userId")
    var orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
    @IBOutlet weak var farmIdHideLbl: UILabel!
    
    var heartBeatViewModel:HeartBeatViewModel?
    
    func navigateToAnotherVc(){
        // Intentionally left empty.
        // This function will handle navigation to another view controller in the future.
        // Currently unused, but kept for consistency with protocol or planned implementation.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        farmAddr = fetchBillingCustomer(entityName: "GetBillingContact",customerID: self.custmerId) as! [GetBillingContact]
        heartBeatViewModel = HeartBeatViewModel(callBack: navigateToAnotherVc)
        heartBeatViewModel?.callGetHearBeatData()
        userId = UserDefaults.standard.integer(forKey: "userId")
        orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
        let animaltbl = fetchRemaningSubmitOrder(entityName: "BeefAnimaladdTbl", isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
        
        for i in 0..<animaltbl.count{
            let data = animaltbl.object(at: i) as! BeefAnimaladdTbl
            deleteRemaningSubmitOrderReview(entityName: "ProductAdonAnimlTbLBeef", isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId, aid: Int(data.animalId))
            deleteRemaningSubmitOrderReview(entityName: "SubProductTblBeef", isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId,aid: Int(data.animalId))
        }
        deleteRemaningSubmitOrder(entityName: "BeefAnimaladdTbl", isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.OfflineBtn.isHidden = true
        initialNetworkCheck()
        searchTxt?.delegate = self
        tableViewBg.isHidden = true
        bckRoundView.isHidden = true
        landIdApplangaugeConversion()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.addonsRecive(notification:)), name: Notification.Name("ReviewAddonsbeef"), object: nil)
        
    }
    func dataReload(check :Bool){
        
        if check {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "BeefReviewOrderVC") as! BeefReviewOrderVC
            self.navigationController?.pushViewController(newViewController, animated: false)
        }
    }
    
    @objc func addonsRecive(notification: Notification) {
        let animalTag = notification.userInfo!["animalId"] as! String
        let productIdN = notification.userInfo!["productId"] as! Int
        
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "ReviewAddonsController") as! ReviewAddonsController
        vc.animalTag = animalTag
        vc.productId = productIdN
        
        self.navigationController?.present(vc, animated: false, completion: nil)
        
    }
    
    @IBOutlet weak var viewBylbl: UILabel!
    @IBOutlet weak var productLbl: UILabel!
    @IBOutlet weak var animalLbl: UILabel!
    @IBOutlet weak var reviewOrderLbl: UILabel!
    @IBOutlet weak var selectBillingContact: UILabel!
    @IBOutlet weak var appStatusLbl: UILabel!
    let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
    func landIdApplangaugeConversion(){
        
        viewBylbl.text = NSLocalizedString("View By", comment: "")
        productLbl.text = NSLocalizedString("Product", comment: "")
        animalLbl.text = NSLocalizedString("Animal", comment: "")
        reviewOrderLbl.text = NSLocalizedString("Review Order", comment: "")
        appStatusLbl.text = NSLocalizedString("App Status:", comment: "")
        selectBillingLbl.text = NSLocalizedString("Select Billing Contact", comment: "")
        searchTxt.placeholder = NSLocalizedString("Search", comment: "")
        
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
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        if pvid == 13 {
            appHelpBtn.isHidden = false
        } else {
            appHelpBtn.isHidden = true
        }
        if UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == nil{
           
            if pvid == 5{
                self.clickOnDropDown =  NSLocalizedString(ButtonTitles.earTagText, comment: "")
            }
            if pvid == 6{
                self.clickOnDropDown =  NSLocalizedString("Barcode", comment: "")
            }
            self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
        }
        if UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "officialid" {
            UserDefaults.standard.set(true, forKey: "brazilBarcodeReviewVC")
           
            if pvid == 5{
                self.clickOnDropDown = NSLocalizedString(ButtonTitles.earTagText, comment: "")
            }
            if pvid == 6{
                self.clickOnDropDown = NSLocalizedString("Barcode", comment: "")
            }
            self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
            
        }
        if UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "barcode" || UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "Barcode"{
            
            var getB = UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC")
            if getB == "barcode" {
                getB = "Barcode"
            }
            
            self.clickOnDropDown = NSLocalizedString(getB ?? "", comment: "")
            if pvid == 6{
                self.clickOnDropDown = NSLocalizedString("Series", comment: "")
                UserDefaults.standard.set(false, forKey: "brazilBarcodeReviewVC")
                UserDefaults.standard.set(true, forKey: "seriesReviewVC")
            }
            
            self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
            
        }
        if UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "rgn"{
            self.clickOnDropDown = NSLocalizedString("RGN", comment: "")
            self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
        }
        if UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "rgd"{
            self.clickOnDropDown = NSLocalizedString(LocalizedStrings.RGDorAnimalIDText, comment: "")
            self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
        }
        
        search()
        initialNetworkCheck()
      
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
        
        notificationLblCount.text = String(animalCount.count)
        tblView.reloadData()
    }
    @IBAction func backBtnClk(_ sender: UIButton) {
        
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
        
    }
    
    func search(){
        guard let fethDat =  BeefFetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId) as? [ProductAdonAnimlTbLBeef] else {
            return
        }
        
        var productNameArray = [String]()
        for object in fethDat {
            productNameArray.append(object.productName!)
            set  =  Array(Set(productNameArray))
        }
        
        uniqueProductArray = Dictionary(grouping: fethDat, by: { $0.productName! })
        
        set = set.sorted(by: {$0 < $1})
        reviewOrderListObject.set = set
        reviewOrderListObject.uniqueProductArrayBeef = uniqueProductArray
        reviewOrderListObject.itemSelection = clickOnDropDown
        
        reviewOrderListObject.delegateCustomNew = self
        
        tblView.delegate = reviewOrderListObject
        tblView.dataSource = reviewOrderListObject
        tblView.reloadData()
    }
    
    @IBOutlet weak var tableViewBg: UIView!
    
    @IBOutlet weak var bckRoundView: UIView!
    @IBAction func crossBtnAct(_ sender: Any) {
        
        tableViewBg.isHidden = true
        bckRoundView.isHidden = true
    }
    
    @IBAction func productAnimalToggleBtnClk(_ sender: UIButton) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "BeefOrderProductSelectionReviewVC") as! BeefOrderProductSelectionReviewVC
        self.navigationController?.pushViewController(newViewController, animated: false)
        
    }
    let buttonbg1 = UIButton ()
    var customPopView1 :TipPopUp!
    
    @IBAction func termsInfoBtnAction(_ sender: UIButton) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "ProductWiseTermsController") as! ProductWiseTermsController
        self.navigationController?.present(vc, animated: false, completion: nil)
        return
    }
    
    @IBAction func emailMeEnterAction(_ sender: UIButton) {
        
        if !UserDefaults.standard.bool(forKey: "SubmitBtnFlag") {
            let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Do you want to email entered data?", comment: ""), preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
                UIAlertAction in
                print(LocalizedStrings.cancelPressed)
                
                return
            }
            let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) {
                UIAlertAction in
                UserDefaults.standard.set(true, forKey: "emailBeef")
                if Connectivity.isConnectedToInternet() {
                    self.showIndicator(self.view, withTitle: "", and: "")
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVC") as! OrderSubmittedVC
                    self.navigationController?.pushViewController(newViewController, animated: true)
                } else {
                    UserDefaults.standard.set(true, forKey: "emailBeef")
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveViewController") as! OrderSaveViewController
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        if Connectivity.isConnectedToInternet() {
            showIndicator(self.view, withTitle: "", and: "")
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVC") as! OrderSubmittedVC
            self.navigationController?.pushViewController(newViewController, animated: true)
        } else {
            UserDefaults.standard.set(true, forKey: "emailBeef")
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveViewController") as! OrderSaveViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
        
    }
    @IBAction func emailMeInfoBtnClick(_ sender: UIButton) {
        
        let p = sender.convert(sender.bounds,to: self.view)
        
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(self.buttonbgPressedTip1), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view.addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed("TipPopUp") as? TipPopUp
        customPopView1.arrow_left.isHidden = true
        customPopView1.arrow_Top.isHidden = false
        customPopView1.elipseImage2.isHidden = true
        customPopView1.elipseImage1.isHidden = true
        customPopView1.textLbl2.isHidden = true
        customPopView1.frame = CGRect(x: 20,y: p.origin.y + 40   ,width: screenSize.width - 109, height: 125)
        
        customPopView1.delegate = self
        customPopView1.layer.borderColor = UIColor.blue.cgColor
        customPopView1.layer.borderWidth = 1
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1.addSubview(customPopView1)
        if langId == 1 {
            customPopView1.arrow_Top.frame = CGRect(x: 186 , y: -22, width: 26, height: 26)
        } else {
            customPopView1.arrow_Top.frame = CGRect(x: 244 , y: -22, width: 26, height: 26)
        }
        customPopView1.textLabel1.text =  NSLocalizedString("This will email me with the animals, samples and product information I have entered. I can finish the order on my computer and email to Zoetis Genetics.", comment: "")
        
    }
    
    @objc func buttonbgPressedTip1 (){
        buttonbg1.removeFromSuperview()
        customPopView1.removeFromSuperview()
    }
    
    
    @IBAction func submitInfoBtnAction(_ sender: UIButton) {
        
        let p = sender.convert(sender.bounds,to: self.view)
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(self.buttonbgPressedTip12), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view.addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed("TipPopUp") as? TipPopUp
        customPopView1.arrow_left.isHidden = true
        customPopView1.arrow_Top.isHidden = false
        customPopView1.elipseImage2.isHidden = true
        customPopView1.elipseImage1.isHidden = true
        customPopView1.textLbl2.isHidden = true
        customPopView1.frame = CGRect(x: 20,y: p.origin.y +  41   ,width: screenSize.width - 100, height: 125)
        
        customPopView1.delegate = self
        customPopView1.layer.borderColor = UIColor.blue.cgColor
        customPopView1.layer.borderWidth = 1
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1.addSubview(customPopView1)
        
        if langId == 1 {
            customPopView1.arrow_Top.frame = CGRect(x: 138 , y: -22, width: 26, height: 26)
        } else {
            customPopView1.arrow_Top.frame = CGRect(x: 150 , y: -22, width: 26, height: 26)
        }
        customPopView1.textLabel1.text =  NSLocalizedString("Submit is only available if all fields are filled out for each animal submitted.", comment: "")
    }
    
    @objc func buttonbgPressedTip12 (){
        buttonbg1.removeFromSuperview()
        customPopView1.removeFromSuperview()
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        
        if UserDefaults.standard.value(forKey: "beefplaceordercheck") as? Bool == true &&
            UserDefaults.standard.value(forKey: "beefemailcheckvalue") as? Bool == true
        {
            updateAnimalOrderEmailStatus(entity: "BeefAnimaladdTbl", IsEmailId: false)
            updateAnimalOrderEmailStatus(entity: "BeefAnimalMaster", IsEmailId: false)
            if (UserDefaults.standard.value(forKey: "isAggreForSubmit") as? Bool == false) || (UserDefaults.standard.value(forKey: "isAggreForSubmit") as? Bool == nil)
            {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.acceptOrderTerms, comment: ""))
                return
            }
            
            if Connectivity.isConnectedToInternet()
            {
                
                UserDefaults.standard.set(false, forKey: "emailBeef")
                showIndicator(self.view, withTitle: "", and: "")
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVC") as! OrderSubmittedVC
                newViewController.emailOrder=true
                self.navigationController?.pushViewController(newViewController, animated: true)
                
            }
            else
            {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveViewController") as! OrderSaveViewController
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
            
        }
        
        
        else if UserDefaults.standard.value(forKey: "beefplaceordercheck") as? Bool == true &&
                    UserDefaults.standard.value(forKey: "beefemailcheckvalue") as? Bool == false
        {
            updateAnimalOrderEmailStatus(entity: "BeefAnimaladdTbl", IsEmailId: false)
            updateAnimalOrderEmailStatus(entity: "BeefAnimalMaster", IsEmailId: false)
            if (UserDefaults.standard.value(forKey: "isAggreForSubmit") as? Bool == false) || (UserDefaults.standard.value(forKey: "isAggreForSubmit") as? Bool == nil)
            {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.acceptOrderTerms, comment: ""))
                return
            }
            
            if Connectivity.isConnectedToInternet()
            {
                
                UserDefaults.standard.set(false, forKey: "emailBeef")
                showIndicator(self.view, withTitle: "", and: "")
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVC") as! OrderSubmittedVC
                newViewController.emailOrder = false
                self.navigationController?.pushViewController(newViewController, animated: true)
                
            }
            else
            {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveViewController") as! OrderSaveViewController
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
            
        }
        else if UserDefaults.standard.value(forKey: "beefplaceordercheck") as? Bool == false &&
                    UserDefaults.standard.value(forKey: "beefemailcheckvalue") as? Bool == true
        {
            if pvid == 13 {
                updateAnimalOrderEmailStatus(entity: "BeefAnimaladdTbl", IsEmailId: false)
                updateAnimalOrderEmailStatus(entity: "BeefAnimalMaster", IsEmailId: false)
                if (UserDefaults.standard.value(forKey: "isAggreForSubmit") as? Bool == false) || (UserDefaults.standard.value(forKey: "isAggreForSubmit") as? Bool == nil)
                {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.acceptOrderTerms, comment: ""))
                    return
                }
                
                if Connectivity.isConnectedToInternet()
                {
                    
                    UserDefaults.standard.set(false, forKey: "emailBeef")
                    showIndicator(self.view, withTitle: "", and: "")
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVC") as! OrderSubmittedVC
                    newViewController.emailOrder=false
                    self.navigationController?.pushViewController(newViewController, animated: true)
                    
                }
                else
                {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveViewController") as! OrderSaveViewController
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
                
            } else {
                updateAnimalOrderEmailStatus(entity: "BeefAnimaladdTbl", IsEmailId: true)
                updateAnimalOrderEmailStatus(entity: "BeefAnimalMaster", IsEmailId: true)
                if !UserDefaults.standard.bool(forKey: "checkvalue")
                {
                    let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Do you want to email entered data?", comment: ""), preferredStyle: .alert)
                    
                    let cancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        print(LocalizedStrings.cancelPressed)
                        
                        return
                    }
                    let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        UserDefaults.standard.set(true, forKey: "emailBeef")
                        if Connectivity.isConnectedToInternet() {
                            self.showIndicator(self.view, withTitle: "", and: "")
                            
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVC") as! OrderSubmittedVC
                            newViewController.emailOrder=true
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        } else {
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveViewController") as! OrderSaveViewController
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        }
                    }
                    
                    alertController.addAction(cancelAction)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                else
                {
                    UserDefaults.standard.set(true, forKey: "emailBeef")
                    if Connectivity.isConnectedToInternet(){
                        
                        showIndicator(self.view, withTitle: "", and: "")
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVC") as! OrderSubmittedVC
                        newViewController.emailOrder=true
                        self.navigationController?.pushViewController(newViewController, animated: true)
                        
                    }
                    else
                    {
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveViewController") as! OrderSaveViewController
                        self.navigationController?.pushViewController(newViewController, animated: true)
                    }
                    
                }
            }
        } else {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please select at least one checkbox to submit.", comment: ""))
            return
        }
    }
    @IBAction func leftMenuBtn(_ sender: Any) {
        
        self.view.makeCorner(withRadius: 40)
        self.sideMenuViewController?.presentRightMenuViewController()
    }
    
    override func viewDidLayoutSubviews() {
        searchTxt.layer.cornerRadius = 15
    }
    
    @IBAction func showMenu(_ sender: UIButton) {
        self.view.makeCorner(withRadius: 40)
        self.sideMenuViewController?.presentRightMenuViewController()
    }
    @IBAction func editbtnAction(_ sender: Any) {
        
        UserDefaults.standard.set(1, forKey: "orderSlideTag")
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "OrderingDefaultsVC") as! OrderingDefaultsVC
        viewController.editflag = 0
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    var tissueArr = NSArray()
    let buttonbg2 = UIButton ()
    var droperTableView  = UITableView ()
    
    
    @IBAction func billingBtnAction(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "N/A"{
            
            tableViewBg.isHidden = true
            bckRoundView.isHidden = true
            
        } else {
            tableViewBg.isHidden = false
            bckRoundView.isHidden = false
            
            billingViewHeightConst.constant = billingTblView.contentSize.height + 100
            billingTblView.reloadData()
        }
    }
    
    @IBAction func viewAnimalClick(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BeefViewAnimalVC") as? BeefViewAnimalVC
        vc?.delegateCustom = self
        vc!.screenBackSave = false
        vc!.productBackSave = false
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func dropDownBtnAction(_ sender: UIButton) {
        
        dropDown.anchorView = farmIdHideLbl
        dropDown.direction = .bottom
        dropDown.backgroundColor = UIColor.white
        dropDown.separatorColor = UIColor.clear
        dropDown.cornerRadius = 10
        dropDown.textFont = UIFont.systemFont(ofSize: 13)
        dropDown.cellHeight = 37
        searchTxt.resignFirstResponder()
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
       
        if pvid == 5{
            dropDown.dataSource = [NSLocalizedString(ButtonTitles.earTagText, comment: ""), NSLocalizedString("Barcode", comment: "")]
        }
        if pvid == 6{
            dropDown.dataSource = [NSLocalizedString("Barcode", comment: ""), NSLocalizedString("Series", comment: ""), NSLocalizedString("RGN", comment: ""), NSLocalizedString(LocalizedStrings.RGDorAnimalIDText, comment: "")]
        }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            self.clickOnDropDown = item
            self.reviewOrderListObject.itemSelection =  self.clickOnDropDown
            self.tblView.reloadData()
            sender.setTitle(item, for: .normal)
            sender.layer.borderColor = UIColor.gray.cgColor
            if pvid == 5 || pvid == 7 ||  pvid == 13 {
                
                
                if self.searchTxt.text != ""{
                    
                    if self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: "") || self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: "")   {
                        UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
                        let bPredicate = NSPredicate(format: LocalizedStrings.productNameContainsValue, self.searchTxt.text!,self.searchTxt.text!)
                        let fetchcustRep =   BeefFetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimlTbLBeef]
                        if fetchcustRep.count > 0 {
                            
                            var productNameArray = [String]()
                            
                            for object in fetchcustRep  {
                                productNameArray.append(object.productName!)
                                self.set  =  Array(Set(productNameArray))
                            }
                            self.uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
                            
                            self.reviewOrderListObject.set = self.set
                            self.reviewOrderListObject.uniqueProductArrayBeef = self.uniqueProductArray
                            self.tblView.reloadData()
                            
                        } else {
                            self.reviewOrderListObject.set.removeAll()
                            self.tblView.reloadData()
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 0.4, position: .center)
                        }
                    }
                    if self.clickOnDropDown == NSLocalizedString("Barcode", comment: ""){
                        UserDefaults.standard.set("barcode", forKey: "InheritFOReviewOrderVC")
                        let bPredicate = NSPredicate(format: LocalizedStrings.animalBarcodeTagContainsValue, self.searchTxt.text!,self.searchTxt.text!)
                        let fetchcustRep =   BeefFetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimlTbLBeef]
                        if fetchcustRep.count > 0 {
                            
                            var productNameArray = [String]()
                            for object in fetchcustRep  {
                                productNameArray.append(object.productName!)
                                self.set  =  Array(Set(productNameArray))
                            }
                            self.uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
                            
                            self.reviewOrderListObject.set = self.set
                            self.reviewOrderListObject.uniqueProductArrayBeef = self.uniqueProductArray
                            self.tblView.reloadData()
                            
                        }else {
                            self.reviewOrderListObject.set.removeAll()
                            self.tblView.reloadData()
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 0.8, position: .center)
                        }
                    }
                    
                } else {
                    if self.clickOnDropDown == NSLocalizedString("Barcode" , comment: ""){
                        UserDefaults.standard.set("barcode", forKey: "InheritFOReviewOrderVC")
                    }
                    if self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: "") || self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: "") {
                        UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
                    }
                    self.search()
                    self.tblView.reloadData()
                }
            }
            
            else {
                
                if self.searchTxt.text != ""{
                    
                    if self.clickOnDropDown == NSLocalizedString("Barcode" , comment: ""){
                        UserDefaults.standard.set(true, forKey: "brazilBarcodeReviewVC")
                        UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
                        let bPredicate = NSPredicate(format: LocalizedStrings.productNameContainsValue, self.searchTxt.text!,self.searchTxt.text!)
                        let fetchcustRep =   BeefFetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimlTbLBeef]
                        if fetchcustRep.count > 0 {
                            
                            var productNameArray = [String]()
                            
                            for object in fetchcustRep  {
                                productNameArray.append(object.productName!)
                                self.set  =  Array(Set(productNameArray))
                            }
                            self.uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
                            self.reviewOrderListObject.set = self.set
                            self.reviewOrderListObject.uniqueProductArrayBeef = self.uniqueProductArray
                            self.tblView.reloadData()
                            
                        } else {
                            self.reviewOrderListObject.set.removeAll()
                            self.tblView.reloadData()
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 0.4, position: .center)
                            
                        }
                    }
                    if self.clickOnDropDown == NSLocalizedString("Series", comment: "") {
                        UserDefaults.standard.set(false, forKey: "brazilBarcodeReviewVC")
                        UserDefaults.standard.set(true, forKey: "seriesReviewVC")
                        UserDefaults.standard.set("barcode", forKey: "InheritFOReviewOrderVC")
                        let bPredicate = NSPredicate(format: LocalizedStrings.animalBarcodeTagContainsValue, self.searchTxt.text!,self.searchTxt.text!)
                        let fetchcustRep =   BeefFetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimlTbLBeef]
                        if fetchcustRep.count > 0 {
                            
                            var productNameArray = [String]()
                            for object in fetchcustRep  {
                                productNameArray.append(object.productName!)
                                self.set  =  Array(Set(productNameArray))
                            }
                            self.uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
                            self.reviewOrderListObject.set = self.set
                            self.reviewOrderListObject.uniqueProductArrayBeef = self.uniqueProductArray
                            self.tblView.reloadData()
                            
                        } else {
                            self.reviewOrderListObject.set.removeAll()
                            self.tblView.reloadData()
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 0.8, position: .center)
                            
                        }
                    }
                    
                    if self.clickOnDropDown == NSLocalizedString("RGN", comment: "") {
                        UserDefaults.standard.set("rgn", forKey: "InheritFOReviewOrderVC")
                        let bPredicate = NSPredicate(format: " rgn contains[cd] %@ || productName contains[cd] %@", self.searchTxt.text!,self.searchTxt.text!)
                        let fetchcustRep =   BeefFetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimlTbLBeef]
                        if fetchcustRep.count > 0 {
                            
                            var productNameArray = [String]()
                            for object in fetchcustRep  {
                                productNameArray.append(object.productName!)
                                self.set  =  Array(Set(productNameArray))
                            }
                            self.uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
                            self.reviewOrderListObject.set = self.set
                            self.reviewOrderListObject.uniqueProductArrayBeef = self.uniqueProductArray
                            self.tblView.reloadData()
                            
                        } else {
                            self.reviewOrderListObject.set.removeAll()
                            self.tblView.reloadData()
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 0.8, position: .center)
                            
                        }
                    }
                    
                    if self.clickOnDropDown == NSLocalizedString("RGD", comment: "") || self.clickOnDropDown == NSLocalizedString(LocalizedStrings.RGDorAnimalIDText, comment: ""){
                        UserDefaults.standard.set("rgd", forKey: "InheritFOReviewOrderVC")
                        let bPredicate = NSPredicate(format: " rgd contains[cd] %@ || productName contains[cd] %@", self.searchTxt.text!,self.searchTxt.text!)
                        let fetchcustRep =   BeefFetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimlTbLBeef]
                        if fetchcustRep.count > 0 {
                            
                            var productNameArray = [String]()
                            for object in fetchcustRep  {
                                productNameArray.append(object.productName!)
                                self.set  =  Array(Set(productNameArray))
                            }
                            self.uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
                            self.reviewOrderListObject.set = self.set
                            self.reviewOrderListObject.uniqueProductArrayBeef = self.uniqueProductArray
                            self.tblView.reloadData()
                            
                        } else {
                            self.reviewOrderListObject.set.removeAll()
                            self.tblView.reloadData()
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 0.8, position: .center)
                            
                        }
                        
                    }
                } else {
                    if self.clickOnDropDown == NSLocalizedString("Series", comment: "") {
                        UserDefaults.standard.set(false, forKey: "brazilBarcodeReviewVC")
                        UserDefaults.standard.set(true, forKey: "seriesReviewVC")
                        UserDefaults.standard.set("barcode", forKey: "InheritFOReviewOrderVC")
                    }
                    if self.clickOnDropDown == NSLocalizedString("Barcode", comment: ""){
                        UserDefaults.standard.set(true, forKey: "brazilBarcodeReviewVC")
                        UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
                    }
                    if self.clickOnDropDown == NSLocalizedString("RGN", comment: "") {
                        UserDefaults.standard.set("rgn", forKey: "InheritFOReviewOrderVC")
                    }
                    if self.clickOnDropDown == NSLocalizedString("RGD", comment: "") || self.clickOnDropDown == NSLocalizedString(LocalizedStrings.RGDorAnimalIDText, comment: ""){
                        UserDefaults.standard.set("rgd", forKey: "InheritFOReviewOrderVC")
                    }
                    self.search()
                    self.tblView.reloadData()
                }
            }
        }
        dropDown.show()
        
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
    
    @objc func buttonPreddDroper() {
        buttonbg2.removeFromSuperview()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let currentString: NSString = searchTxt.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        tblView.isHidden = false
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        if newString != ""{
            if pvid == 5 {
                if self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: "") || self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: "")  {
                    let bPredicate = NSPredicate(format: LocalizedStrings.productNameContainsValue, newString,newString)
                    let fetchcustRep =   BeefFetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimlTbLBeef]
                    if fetchcustRep.count > 0 {
                        
                        var productNameArray = [String]()
                        for object in fetchcustRep  {
                            productNameArray.append(object.productName!)
                            set  =  Array(Set(productNameArray))
                        }
                        uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
                        reviewOrderListObject.set = set
                        reviewOrderListObject.uniqueProductArrayBeef = uniqueProductArray
                        tblView.reloadData()
                        
                    } else {
                        
                        reviewOrderListObject.set.removeAll()
                        tblView.reloadData()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 0.8, position: .center)
                    }
                }
                if self.clickOnDropDown == NSLocalizedString("Barcode" , comment: ""){
                    let bPredicate = NSPredicate(format: LocalizedStrings.animalBarcodeTagContainsValue, newString,newString)
                    let fetchcustRep =   BeefFetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimlTbLBeef]
                    if fetchcustRep.count > 0 {
                        
                        var productNameArray = [String]()
                        for object in fetchcustRep  {
                            productNameArray.append(object.productName!)
                            set  =  Array(Set(productNameArray))
                        }
                        uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
                        reviewOrderListObject.set = set
                        reviewOrderListObject.uniqueProductArrayBeef = uniqueProductArray
                        tblView.reloadData()
                        
                    } else {
                        
                        reviewOrderListObject.set.removeAll()
                        tblView.reloadData()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 0.8, position: .center)
                    }
                }
            }
            else {
                
                if self.clickOnDropDown == NSLocalizedString("Barcode" , comment: ""){
                    UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
                    let bPredicate = NSPredicate(format: LocalizedStrings.productNameContainsValue, self.searchTxt.text!,self.searchTxt.text!)
                    let fetchcustRep =   BeefFetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimlTbLBeef]
                    if fetchcustRep.count > 0 {
                        
                        var productNameArray = [String]()
                        
                        for object in fetchcustRep  {
                            productNameArray.append(object.productName!)
                            self.set  =  Array(Set(productNameArray))
                        }
                        self.uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
                        self.reviewOrderListObject.set = self.set
                        self.reviewOrderListObject.uniqueProductArrayBeef = self.uniqueProductArray
                        self.tblView.reloadData()
                        
                    } else {
                        self.reviewOrderListObject.set.removeAll()
                        self.tblView.reloadData()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 0.4, position: .center)
                    }
                }
                if self.clickOnDropDown == NSLocalizedString("Series", comment: "") {
                    UserDefaults.standard.set("barcode", forKey: "InheritFOReviewOrderVC")
                    let bPredicate = NSPredicate(format: LocalizedStrings.animalBarcodeTagContainsValue, self.searchTxt.text!,self.searchTxt.text!)
                    let fetchcustRep =   BeefFetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimlTbLBeef]
                    if fetchcustRep.count > 0 {
                        
                        var productNameArray = [String]()
                        for object in fetchcustRep  {
                            productNameArray.append(object.productName!)
                            self.set  =  Array(Set(productNameArray))
                        }
                        self.uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
                        
                        self.reviewOrderListObject.set = self.set
                        self.reviewOrderListObject.uniqueProductArrayBeef = self.uniqueProductArray
                        self.tblView.reloadData()
                        
                    } else {
                        self.reviewOrderListObject.set.removeAll()
                        self.tblView.reloadData()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 0.8, position: .center)
                    }
                }
                
                if self.clickOnDropDown == NSLocalizedString("RGN", comment: "") {
                    UserDefaults.standard.set("rgn", forKey: "InheritFOReviewOrderVC")
                    let bPredicate = NSPredicate(format: " rgn contains[cd] %@ || productName contains[cd] %@", self.searchTxt.text!,self.searchTxt.text!)
                    let fetchcustRep =   BeefFetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimlTbLBeef]
                    if fetchcustRep.count > 0 {
                        
                        var productNameArray = [String]()
                        for object in fetchcustRep  {
                            productNameArray.append(object.productName!)
                            self.set =  Array(Set(productNameArray))
                        }
                        self.uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
                        self.reviewOrderListObject.set = self.set
                        self.reviewOrderListObject.uniqueProductArrayBeef = self.uniqueProductArray
                        self.tblView.reloadData()
                        
                    } else {
                        self.reviewOrderListObject.set.removeAll()
                        self.tblView.reloadData()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 0.8, position: .center)
                        
                        
                    }
                    
                    
                }
                
                if self.clickOnDropDown == NSLocalizedString("RGD", comment: "") || self.clickOnDropDown == NSLocalizedString(LocalizedStrings.RGDorAnimalIDText, comment: ""){
                    UserDefaults.standard.set("rgd", forKey: "InheritFOReviewOrderVC")
                    let bPredicate = NSPredicate(format: " rgd contains[cd] %@ || productName contains[cd] %@", self.searchTxt.text!,self.searchTxt.text!)
                    let fetchcustRep =   BeefFetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimlTbLBeef]
                    if fetchcustRep.count > 0 {
                        
                        var productNameArray = [String]()
                        for object in fetchcustRep  {
                            productNameArray.append(object.productName!)
                            self.set  =  Array(Set(productNameArray))
                        }
                        self.uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
                        self.reviewOrderListObject.set = self.set
                        self.reviewOrderListObject.uniqueProductArrayBeef = self.uniqueProductArray
                        self.tblView.reloadData()
                        
                    } else {
                        self.reviewOrderListObject.set.removeAll()
                        self.tblView.reloadData()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 0.8, position: .center)
                        
                    }
                }
            }
            
        } else {
            search()
            tblView.reloadData()
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
        self.navigationController!.pushViewController(secondViewController, animated: false)
        
    }
    
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    
    @IBAction func offlineBtnAction(_ sender: UIButton) {
        
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(ReviewOrderVC.buttonbgPressed), for: .touchUpInside)
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
    
    @objc func buttonbgPressed (){
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AppHelpImagesVC") as? AppHelpImagesVC
        vc?.module = "Place an Order: Ordering Add Animal(s) Beef".localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
    }
    
}
extension BeefReviewOrderVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
}
extension BeefReviewOrderVC: SideMenuUI
{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
    
    
    
    @objc  func checkForReachability(notification:Notification) {
        
        let del =  UIApplication.shared.delegate as? AppDelegate
        self.appSatatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if appSatatusLbl?.text == "Connected".localized {
            self.OfflineBtn.isHidden = true
            self.networlStatusImage.image = UIImage(named: "status_online_sign")
        }
        else{
            
            appSatatusLbl?.text = "Not Connected".localized
            self.OfflineBtn.isHidden = false
            self.networlStatusImage.image = UIImage(named: "status_offline")
            
        }
    }
    
    func initialNetworkCheck(){
        
        self.OfflineBtn.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        
        let del =  UIApplication.shared.delegate as? AppDelegate
        
        self.appSatatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if appSatatusLbl?.text == "Connected".localized
        {
            
            self.OfflineBtn.isHidden = true
            
            self.networlStatusImage.image = UIImage(named: "status_online_sign")
        }
        else{
            
            appSatatusLbl?.text = "Not Connected".localized
            
            self.OfflineBtn.isHidden = false
            
            self.networlStatusImage.image = UIImage(named: "status_offline")
            
        }
    }
    
}


extension  BeefReviewOrderVC:NSFetchedResultsControllerDelegate{
    
}


extension BeefReviewOrderVC :UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == billingTblView {
            
            return farmAddr.count
        }else {
            
            return self.tissueArr.count
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == billingTblView {
            
            let cell = billingTblView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? BillingTableViewCell
            cell!.selectionStyle = .none
            let filterArr = farmAddr.filter({$0.isDefault })
            if filterArr.count > 0{
                if farmAddr[indexPath.row].billToCustId! == filterArr[0].billToCustId{
                    cell?.radioBtnReview.setImage(UIImage(named: "radioSeletedBtn"), for: .normal)
                } else {
                    cell?.radioBtnReview.setImage(UIImage(named: "radioBtn"), for: .normal)
                }
            } else if Int(farmAddr[indexPath.row].billToCustId!) == self.custmerId{
                cell?.radioBtnReview.setImage(UIImage(named: "radioSeletedBtn"), for: .normal)
                updateBillingCustomer(entity: "GetBillingContact", customerID: self.custmerId, isDefault: true, billcustomerId: farmAddr[indexPath.row].billToCustId ?? "0", billcustomerName: farmAddr[indexPath.row].contactName ?? "")
            }
            else {
                cell?.radioBtnReview.setImage(UIImage(named: "radioBtn"), for: .normal)
            }
            
            cell?.addressReviewLbl.text = farmAddr[indexPath.row].contactName
            
            return cell!
        }
        else {
            
            let cell = UITableViewCell()
            cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
            
            cell.textLabel?.text = self.tissueArr[indexPath.row] as? String
            return cell
        }
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == billingTblView {
            
            
            let filterArr = farmAddr.filter({$0.isDefault })
            if filterArr.count > 0{
                updateBillingCustomer(entity: "GetBillingContact", customerID: self.custmerId, isDefault: false, billcustomerId: filterArr[0].billToCustId ?? "0", billcustomerName: filterArr[0].contactName ?? "")
                
            }
            UserDefaults.standard.set(farmAddr[indexPath.row].contactName, forKey: "farmValue")
            UserDefaults.standard.set(farmAddr[indexPath.row].billToCustId, forKey: "billToCustomerId")
            
            updateBillingCustomer(entity: "GetBillingContact", customerID: self.custmerId, isDefault: true, billcustomerId: farmAddr[indexPath.row].billToCustId ?? "0", billcustomerName: farmAddr[indexPath.row].contactName ?? "")
            
            farmAddr = fetchBillingCustomer(entityName: "GetBillingContact",customerID: self.custmerId) as! [GetBillingContact]
            
            tableViewBg.isHidden = true
            bckRoundView.isHidden = true
            tblView.reloadData()
            billingTblView.reloadData()
            
            
        } else{
            
            let tissue = self.tissueArr[indexPath.row] as! String
            itemSelection = tissue
            dropDownBtn.setTitle(tissue, for: .normal)
            buttonbg2.removeFromSuperview()
            reviewOrderListObject.itemSelection = itemSelection
            tblView.reloadData()
            
            
        }
    }
    
}
