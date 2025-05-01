//
//  BeefReviewOrderVCIpad.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 03/03/25.
//

import Foundation
import UIKit
import CoreData
import DropDown


class BeefReviewOrderVCIpad: UIViewController,UITextFieldDelegate,objectPickCartScreen,offlineCustomView1,objectPickfromConfilict,objectPickforcellDelegate, DismissConflictPopUp {
    func updateDismissUI() {
        search()
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
      
        notificationLblCount.text = String(animalCount.count)
        tblView.reloadData()
        self.setBillingDetails()
        self.setTermsConditionUI()
        self.setSubmitOrderInitialUI()
    }
    
    func selectionObjectcell(check: Bool) {
        
        if check == true{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BeefConfilictOrdersViewController") as! BeefConfilictOrdersViewController
            vc.delegateCustom1 = self
            vc.screenName = "beefreviewVc"
            self.present(vc, animated: true, completion: nil)

          
        }
    }
    func selectionObject(check: Bool) {
        if check == true{
         
            let beefPvid = (UserDefaults.standard.integer(forKey:"BeefPvid") as? Int)!
            if beefPvid == 5 {
                let storyboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: Bundle.main)
                let secondViewController = storyboard.instantiateViewController(withIdentifier: "InheritBeefVC") as! InheritBeefVC
            self.navigationController!.pushViewController(secondViewController, animated: false)
            }
            if beefPvid == 7 {
                let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalNZ_VC") as! BeefAnimalNZ_VC
                self.navigationController!.pushViewController(secondViewController, animated: false)
            }
            if beefPvid == 6 {
                let storyboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: Bundle.main)
                let secondViewController = storyboard.instantiateViewController(withIdentifier: "BeefAnimalBrazilVCIpad") as! BeefAnimalBrazilVCIpad
                self.navigationController!.pushViewController(secondViewController, animated: false)
            }
          if beefPvid == 13 {
              let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "BlockyardBeefiPad") as! BlockyardBeefiPad
            self.navigationController!.pushViewController(secondViewController, animated: false)
          }
            
        } else {
            let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
            let secondViewController = storyboard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
            self.navigationController!.pushViewController(secondViewController, animated: false)

        }
    }
    func crossBtn() {
    }
    
    func objectGetOnSelection(temp: Int) {
    }
    
    func anOptionalMethod(check: Bool) {
    }
   var custmerId = UserDefaults.standard.value(forKey: "currentActiveCustomerId") as! Int
  var farmAddr = [GetBillingContact]()
    var isAgree = false
    let orderIdBeef = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
    weak var delegateCustom : objectPickfromConfilict?
    weak var dismissDelegate : DismissConflictPopUp?
    
    
    @IBAction func addDealerCodeBtn(_ sender: Any) {
    }
    @IBOutlet weak var sortByBrazilBarcodeBtn: UIButton!
    @IBOutlet weak var sortByBrazilBarcodeImgView: UIImageView!
    @IBOutlet weak var sortByAnimalIDBtn: UIButton!
    @IBOutlet weak var sortByAnimalIDImgView: UIImageView!
    @IBOutlet weak var sortByRGNBtn: UIButton!
    @IBOutlet weak var sortByRGNImgView: UIImageView!
    @IBOutlet weak var sortBySeriesImgView: UIImageView!
    @IBOutlet weak var sortBySeriesBtn: UIButton!
    @IBOutlet weak var sortByBrazilView: UIView!
    @IBOutlet weak var earTaglbl: UILabel!
    @IBOutlet weak var emailStackView: UIView!
    @IBOutlet weak var sortByBarcodeBtn: UIButton!
    @IBOutlet weak var sortByBarcodeImgView: UIImageView!
    @IBOutlet weak var sortByEarTagImgView: UIImageView!
    @IBOutlet weak var sortByEarTagBtn: UIButton!
    @IBOutlet weak var sortByView: UIView!
    @IBOutlet weak var addDealerCodeView: UIView!
    @IBOutlet weak var beefPlaceAnSelectionTitle: UILabel!
    @IBOutlet weak var addDealerCodeImgView: UIImageView!
    @IBOutlet weak var addDealerCodeTxtField: UITextField!
    @IBOutlet weak var addDealerCodeOutlet: UIButton!
    @IBOutlet weak var addDealerCodeLbl: UILabel!
    @IBOutlet weak var beefPlaceSelectionOutlet: UIButton!
    @IBOutlet weak var beefsubmitInfoBtn: UIButton!
    @IBOutlet weak var beefEmailSelectionOutlet: UIButton!
    @IBOutlet weak var emailMeSelectionTtile: UILabel!
    @IBOutlet weak var beefEmailMeInfoBtn: UIButton!
    @IBOutlet weak var beefinfoBtnSelectionOutlet: UIButton!
    @IBOutlet weak var agrreLblStackView: UIStackView!
    @IBOutlet weak var billingViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var submitOrderOutlet: UIButton!
    @IBOutlet weak var placeAnOrderSelectionOutlet: UIButton!
    @IBOutlet weak var placeAnotrderTitle: UILabel!
    @IBOutlet weak var emailMeEnterTtitle: UILabel!
    @IBOutlet weak var customerNameLbl: UILabel!
    @IBOutlet weak var emailMeSelectionOutlet: UIButton!
    @IBOutlet weak var billingContact: UILabel!
    @IBOutlet weak var sortByTitle: UILabel!
    @IBOutlet weak var menuIconLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var infoButton1: UIButton!
    @IBOutlet weak var infoButton2: UIButton!
    @IBOutlet weak var infoButton3: UIButton!
    @IBOutlet weak var agreeStackViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var placeAnOrderImgView: UIImageView!
    @IBOutlet weak var emailBtnImgView: UIImageView!
    @IBOutlet weak var AgreeBtnImgView: UIImageView!
    @IBOutlet weak var agrreLbl: UILabel!
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
    @IBOutlet weak var innerScrollViewHeight: NSLayoutConstraint!
    var attrs : [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 13),
        .foregroundColor: UIColor.blue,
        .underlineStyle: NSUnderlineStyle.single.rawValue]
    
    @IBOutlet weak var crossBtnOutlet: UIButton!
    @IBOutlet weak var tblView: UITableView!
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    let dropDown = DropDown()
    // Unique product name for section title in table view
    var set = [String]()
    // Unique result from product animal add on table
    var uniqueProductArray = Dictionary<String, [ProductAdonAnimlTbLBeef]>()
    var allAnimalProductArray = [ProductAdonAnimlTbLBeef]()
    var itemSelection = String()
    var toggleFlag : Int = 0
    var arrCombined : NSMutableArray!
    var reviewOrderListObject = ReviewOrderListVc()
    var langId = UserDefaults.standard.value(forKey: "lngId") as? Int
    
    var userId = Int()
    var orderId = Int()
    @IBOutlet weak var farmIdHideLbl: UILabel!
    
    var heartBeatViewModel:HeartBeatViewModel?
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
    
    
    func navigateToAnotherVc(){
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSideMenu()
        farmAddr = fetchBillingCustomer(entityName: "GetBillingContact",customerID: self.custmerId) as! [GetBillingContact]
        heartBeatViewModel = HeartBeatViewModel(callBack: navigateToAnotherVc)
        heartBeatViewModel?.callGetHearBeatData()
        userId = UserDefaults.standard.integer(forKey: "userId")
        orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
        let currentCustomerId = UserDefaults.standard.value(forKey: "currentActiveCustomerId") as? Int
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
        //search()
        tableViewBg.isHidden = true
        bckRoundView.isHidden = true
        landIdApplangaugeConversion()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.addonsRecive(notification:)), name: Notification.Name("ReviewAddonsbeef"), object: nil)
     
        let pviduser = (UserDefaults.standard.integer(forKey:"BeefPvid") as? Int)!

        if pviduser == 5 {
           if UserDefaults.standard.string(forKey: "beefProduct") == "INHERIT" {
                
           var fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: "BeefAnimaladdTbl",orderId:orderId,userId:userId,customerId:currentCustomerId ?? 0,date:"")
        
            if fetchAnimalTbl.count == 0 {
                
            }else {
                
            }
           }
            
        }
      else if pviduser == 13 {
         var fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: "BeefAnimaladdTbl",orderId:orderId,userId:userId,customerId:currentCustomerId ?? 0,date:"")
      }
    }
    func dataReload(check :Bool){
        
        if check == true{
            let storyBoard: UIStoryboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "BeefReviewOrderVCIpad") as! BeefReviewOrderVCIpad
            self.navigationController?.pushViewController(newViewController, animated: false)
        }
    }
    
    @objc func addonsRecive(notification: Notification) {
        
     var animalTag = String()
     var productIdN = Int()
     animalTag = notification.userInfo!["animalId"] as! String
     productIdN = notification.userInfo!["productId"] as! Int
        
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
    
//    viewBylbl.text = NSLocalizedString("View By", comment: "")
//    productLbl.text = NSLocalizedString("Product", comment: "")
//    animalLbl.text = NSLocalizedString("Animal", comment: "")
//    reviewOrderLbl.text = NSLocalizedString("Review Order", comment: "")
//    appStatusLbl.text = NSLocalizedString("App Status:", comment: "")
//    selectBillingLbl.text = NSLocalizedString("Select Billing Contact", comment: "")
//    searchTxt.placeholder = NSLocalizedString("Search", comment: "")
    
  }
    var value = 0
    @objc func methodOfReceivedNotification(notification: Notification)
       {
          
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
    override func viewWillAppear(_ animated: Bool) {
        
               NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        
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
            self.innerScrollViewHeight.constant = 800

        case 1032:
            self.innerScrollViewHeight.constant = 800
        default:
            break
        }
               
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
//      if pvid == 13 {
//        appHelpBtn.isHidden = false
//      } else {
//        appHelpBtn.isHidden = true
//      }
        if pvid == 5 {
            self.earTaglbl.text = "Ear Tag"
        } else {
            self.earTaglbl.text = "Unique ID"
        }
        if UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == nil{
          if pvid == 13 {
            self.clickOnDropDown = "Unique ID".localized
              self.sortByEarTagImgView.image = UIImage(named: "radioSeletedBtn")
              self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
          }
            if pvid == 7{
                self.clickOnDropDown =  NSLocalizedString("Animal Tag", comment: "")
            }
            if pvid == 5{
                self.clickOnDropDown =  NSLocalizedString("Ear Tag", comment: "")
                self.sortByEarTagImgView.image = UIImage(named: "radioSeletedBtn")
                self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
            }
            if pvid == 6{
                self.clickOnDropDown =  NSLocalizedString("Barcode", comment: "")
                self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
                self.sortBySeriesImgView.image = UIImage(named: "radioBtn")
                self.sortByAnimalIDImgView.image = UIImage(named: "radioBtn")
                self.sortByRGNImgView.image = UIImage(named: "radioBtn")
            }
        //    self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
            self.sortByTitle.text = self.clickOnDropDown
        }
        if UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "officialid" {
            UserDefaults.standard.set(true, forKey: "brazilBarcodeReviewVC")
          if pvid == 13 {
            self.clickOnDropDown = "Unique ID".localized
              self.sortByEarTagImgView.image = UIImage(named: "radioSeletedBtn")
              self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
          }
            if pvid == 7{
                self.clickOnDropDown = NSLocalizedString("Animal Tag", comment: "")
            }
            if pvid == 5{
                self.clickOnDropDown = NSLocalizedString("Ear Tag", comment: "")
                self.sortByEarTagImgView.image = UIImage(named: "radioSeletedBtn")
                self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
            }
            if pvid == 6{
                self.clickOnDropDown = NSLocalizedString("Barcode", comment: "")
                self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
                self.sortBySeriesImgView.image = UIImage(named: "radioBtn")
                self.sortByAnimalIDImgView.image = UIImage(named: "radioBtn")
                self.sortByRGNImgView.image = UIImage(named: "radioBtn")
            }
          //  self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
            self.sortByTitle.text = self.clickOnDropDown
        }
        if UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "barcode" || UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "Barcode"{
            
            var getB = UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC")
            if getB == "barcode" {
                getB = "Barcode"
            }
            
            self.sortByEarTagImgView.image = UIImage(named: "radioBtn")
            self.sortByBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
            
            self.clickOnDropDown = NSLocalizedString(getB ?? "", comment: "")
            if pvid == 6{
                self.clickOnDropDown = NSLocalizedString("Series", comment: "")
                UserDefaults.standard.set(false, forKey: "brazilBarcodeReviewVC")
                UserDefaults.standard.set(true, forKey: "seriesReviewVC")
                self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
                self.sortBySeriesImgView.image = UIImage(named: "radioSeletedBtn")
                self.sortByAnimalIDImgView.image = UIImage(named: "radioBtn")
                self.sortByRGNImgView.image = UIImage(named: "radioBtn")
            }

          //  self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
            self.sortByTitle.text = self.clickOnDropDown
        }
        if UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "rgn"{
            self.clickOnDropDown = NSLocalizedString("RGN", comment: "")
         //   self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
            self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
            self.sortBySeriesImgView.image = UIImage(named: "radioBtn")
            self.sortByAnimalIDImgView.image = UIImage(named: "radioBtn")
            self.sortByRGNImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByTitle.text = self.clickOnDropDown
        }
        if UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == "rgd"{
            self.clickOnDropDown = NSLocalizedString("RGD or Animal ID", comment: "")
            self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
            self.sortBySeriesImgView.image = UIImage(named: "radioBtn")
            self.sortByAnimalIDImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByRGNImgView.image = UIImage(named: "radioBtn")
            self.sortByTitle.text = self.clickOnDropDown
           // self.dropDownBtn.setTitle(self.clickOnDropDown, for: .normal)
        }
        
        search()
        initialNetworkCheck()
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        
        let fethData =  BeefFetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId)
        let Data = fetchAllDataOrderStatus(entityName: "BeefAnimaladdTbl", ordestatus: "false",orderId:self.orderId,userId:self.userId)
        
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
      
        notificationLblCount.text = String(animalCount.count)
        tblView.reloadData()
        self.setBillingDetails()
        self.setTermsConditionUI()
        self.setSubmitOrderInitialUI()
    }
    @IBAction func backBtnClk(_ sender: UIButton) {
     
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
        
    }
    
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
//            if customerNameLbl.text!.count > 17 {
//                customerNameLbl.font = customerNameLbl.font.withSize(16)
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
            self.beefinfoBtnSelectionOutlet.isHidden = true
        } else {
            self.beefinfoBtnSelectionOutlet.isHidden = false
        }
    }
    
    @IBAction func addDealerCodeAction(_ sender: UIButton) {
        self.addDealerCodeTxtField.delegate = self
        let placeOrderCheck = UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool
        let dealerCode = UserDefaults.standard.value(forKey: keyValue.dealerCode.rawValue) as? String
        if placeOrderCheck == true {
            if UserDefaults.standard.value(forKey: keyValue.addDealerCodeCheck.rawValue) as? Bool == true {
                sender.isSelected = false
              //  addDealerCodeOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                addDealerCodeImgView.image = UIImage(named: "incrementalCheckIpad")
                self.addDealerCodeView.isHidden = false
                UserDefaults.standard.set(false, forKey: keyValue.addDealerCodeCheck.rawValue)
              if dealerCode == "" || dealerCode == nil{
                DispatchQueue.main.async {
                    self.addDealerCodeTxtField.text = ""
                }
              }
              else {
//                self.dealerCodeView.isHidden = false
//                self.dealerCodeView.alpha = 1
//                self.dealerCodeView.isUserInteractionEnabled = true
                  self.addDealerCodeTxtField.text = ""
              }
            } else {
                sender.isSelected = true
              //  addDealerCodeOutlet.setImage(#imageLiteral(resourceName: ImageNames.unCheckImg), for: .normal)
                addDealerCodeImgView.image = UIImage(named: "Incremental_Check")
                UserDefaults.standard.set(true, forKey: keyValue.addDealerCodeCheck.rawValue)
                self.addDealerCodeView.isHidden = true
              if dealerCode == "" || dealerCode == nil{ } else{
//                self.dealerCodeView.alpha = 0.6
//                self.dealerCodeView.isUserInteractionEnabled = false
              }
            }
        }
    }
    
    @IBAction func beefInfoBtnSelection(_ sender: UIButton) {
        if UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool == true {
            sender.isSelected = false
            AgreeBtnImgView.image = UIImage(named: "Incremental_Check")
            UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
        }
        else {
            sender.isSelected = true
            AgreeBtnImgView.image = UIImage(named: "incrementalCheckIpad")
            UserDefaults.standard.set(true, forKey: keyValue.isAgreeForSubmit.rawValue)
        }
        
        isAgree = !isAgree
    }
    
    @IBAction func beefEmailMeSelectionAction(_ sender: UIButton) {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
        let orderIdBeef = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        UserDefaults.standard.setValue(keyValue.emailMe.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
        let fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: Entities.beefAnimalAddTblEntity,orderId:orderIdBeef,userId:userId,customerId:currentCustomerId ?? 0,date:"")
        
        if fetchAnimalTbl.count == 0 {
            beefPlaceAnSelectionTitle.alpha = 1
            beefPlaceSelectionOutlet.alpha = 1
            if UserDefaults.standard.value(forKey: keyValue.beefEmailCheckValue.rawValue) as? Bool == true {
                sender.isSelected = false
             //   beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                emailBtnImgView.image = UIImage(named: "Incremental_Check")
                UserDefaults.standard.set(false, forKey: keyValue.beefEmailCheckValue.rawValue)
            }
            else {
                sender.isSelected = true
            //    beefEmailSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
                emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                UserDefaults.standard.set(true, forKey: keyValue.beefEmailCheckValue.rawValue)
            }
        }
        else {
            if UserDefaults.standard.value(forKey: keyValue.beefEmailCheckValue.rawValue) as? Bool == true {
                sender.isSelected = false
                emailBtnImgView.image = UIImage(named: "Incremental_Check")
             //   beefEmailSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.unCheckImg), for: .normal)
                UserDefaults.standard.set(false, forKey: keyValue.beefEmailCheckValue.rawValue)
            }
            else {
                sender.isSelected = true
               // beefEmailSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
                emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                UserDefaults.standard.set(true, forKey: keyValue.beefEmailCheckValue.rawValue)
            }
            isAgree = !isAgree
            beefPlaceAnSelectionTitle.alpha = 0.6
            beefPlaceSelectionOutlet.alpha = 0.6
            beefEmailSelectionOutlet.alpha=1
        }
    }
    
    @IBAction func beefPlaceMeSelectionAction(_ sender: UIButton) {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.beefPvid.rawValue))
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
        let orderIdBeef = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        UserDefaults.standard.setValue(keyValue.submitKey.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
        
        if pviduser == 13 {
            UserDefaults.standard.set(false, forKey: keyValue.beefEmailCheckValue.rawValue)
            
        }
        
        if UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == true {
            sender.isSelected = false
          //  beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
            placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
          //  addDealerCodeOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
            addDealerCodeImgView.image = UIImage(named: "Incremental_Check")
            self.addDealerCodeTxtField.isHidden = true
            UserDefaults.standard.set(false, forKey: keyValue.beefPlaceOrderCheck.rawValue)
            UserDefaults.standard.set(false, forKey: keyValue.addDealerCodeCheck.rawValue)
            addDealerCodeOutlet.isEnabled = false
            addDealerCodeLbl.alpha = 0.6
            addDealerCodeOutlet.alpha = 0.6
            self.addDealerCodeView.isHidden = true
//            self.dealerCodeView.alpha = 0.6
//            self.dealerCodeView.isUserInteractionEnabled = false

        } else {
            sender.isSelected = true
           // beefPlaceSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
            placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
            UserDefaults.standard.set(true, forKey: keyValue.beefPlaceOrderCheck.rawValue)
            UserDefaults.standard.set(true, forKey: keyValue.addDealerCodeCheck.rawValue)
            addDealerCodeOutlet.isEnabled = true
            let addDealerCodeCheck = UserDefaults.standard.value(forKey: keyValue.addDealerCodeCheck.rawValue) as? Bool
            let dealerCode = UserDefaults.standard.value(forKey: keyValue.dealerCode.rawValue) as? String
            if addDealerCodeCheck == true {
              if dealerCode == "" || dealerCode == nil{
                  self.addDealerCodeView.isHidden = true
              }
              else {
                  self.addDealerCodeView.isHidden = false
                  addDealerCodeTxtField.text = dealerCode
//                self.dealerCodeView.isHidden = false
//                self.dealerCodeView.alpha = 0.6
//                self.dealerCodeView.isUserInteractionEnabled = false
              }
               
            }
           
            addDealerCodeLbl.alpha = 1
            addDealerCodeOutlet.alpha = 1
            

        }
        
        if pviduser == 5 {
         //   if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.capsInherit.rawValue || UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
                let fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: Entities.beefAnimalAddTblEntity,orderId:orderIdBeef,userId:userId,customerId:currentCustomerId ?? 0,date:"")
                
                if fetchAnimalTbl.count == 0 {
                    beefPlaceAnSelectionTitle.alpha = 1
                    beefPlaceSelectionOutlet.alpha = 1
                }
                else {
                    beefPlaceAnSelectionTitle.alpha = 0.6
                    beefPlaceSelectionOutlet.alpha = 0.6
                  //  delegateCustom?.firstLevel!(check: false)
                    self.selectionObjectCheck(check :true)
                }
                
          //  }
        } else if pviduser == 7 || pviduser == 6 || pviduser == 13{
            let fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: Entities.beefAnimalAddTblEntity,orderId:orderIdBeef,userId:userId,customerId:currentCustomerId ?? 0,date:"")
            if fetchAnimalTbl.count == 0 {
                beefPlaceAnSelectionTitle.alpha = 1
                beefPlaceSelectionOutlet.alpha = 1
            } else {
                beefPlaceAnSelectionTitle.alpha = 0.6
                beefPlaceSelectionOutlet.alpha = 0.6
                
              //  delegateCustom?.firstLevel!(check: false)
                self.selectionObjectCheck(check :true)
            }
        }
    }
    
    @IBAction func sortByBarcodeAction(_ sender: UIButton) {
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        if sortByBarcodeImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        }
        if pvid == 5 || pvid == 7 ||  pvid == 13 {
            if self.searchTxt.text != ""{
              //  if self.clickOnDropDown == NSLocalizedString("Barcode", comment: ""){
                    UserDefaults.standard.set("barcode", forKey: "InheritFOReviewOrderVC")
                    let bPredicate = NSPredicate(format: " animalbarCodeTag contains[cd] %@ || productName contains[cd] %@", self.searchTxt.text!,self.searchTxt.text!)
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
                        self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 0.8, position: .center)
                    }
              //  }
            } else {
              //  if self.clickOnDropDown == NSLocalizedString("Barcode" , comment: ""){
                    UserDefaults.standard.set("barcode", forKey: "InheritFOReviewOrderVC")
             //   }
                self.search()
                self.tblView.reloadData()
            }
        }
        self.sortByEarTagImgView.image = UIImage(named: "radioBtn")
        self.sortByBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
        self.sortByTitle.text = ButtonTitles.barcodeText
        self.sortByView.isHidden = true
        self.bckRoundView.isHidden = true
        itemSelection = "Barcode"
        reviewOrderListObject.itemSelection = itemSelection
    }
    
    @IBAction func sortByEarTagAction(_ sender: UIButton) {
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        if sortByEarTagImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        }
   
        if pvid == 5 || pvid == 7 ||  pvid == 13 {
            if self.searchTxt.text != ""{
              //  if self.clickOnDropDown == NSLocalizedString("Ear Tag", comment: "") || self.clickOnDropDown == NSLocalizedString("Official ID", comment: "") || self.clickOnDropDown == "Animal Tag".localized || self.clickOnDropDown == "Unique ID".localized {
                      UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
                      let bPredicate = NSPredicate(format: "animalTag contains[cd] %@ || productName contains[cd] %@", self.searchTxt.text!,self.searchTxt.text!)
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
                          self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 0.4, position: .center)
                      }
                //  }
            }
            else {
                if self.clickOnDropDown == NSLocalizedString("Ear Tag", comment: "") || self.clickOnDropDown == NSLocalizedString("Official ID", comment: "") || self.clickOnDropDown == "Animal Tag"{
                    UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
                }
                self.search()
                self.tblView.reloadData()
            }

        }
        
   
        self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
        self.sortByEarTagImgView.image = UIImage(named: "radioSeletedBtn")
        if pvid == 5 {
            self.sortByTitle.text = "Ear Tag"
        } else {
            self.sortByTitle.text = "Unique ID"
        }
        self.sortByView.isHidden = true
        self.bckRoundView.isHidden = true
        itemSelection = "Ear Tag"
        reviewOrderListObject.itemSelection = itemSelection
    }
    
    @IBAction func sortBySeriesAction(_ sender: UIButton) {
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        if sortBySeriesImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        }
   
        if self.searchTxt.text != ""{
            UserDefaults.standard.set(false, forKey: "brazilBarcodeReviewVC")
            UserDefaults.standard.set(true, forKey: "seriesReviewVC")
            UserDefaults.standard.set("barcode", forKey: "InheritFOReviewOrderVC")
            let bPredicate = NSPredicate(format: " animalbarCodeTag contains[cd] %@ || productName contains[cd] %@", self.searchTxt.text!,self.searchTxt.text!)
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
                self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 0.8, position: .center)
                
            }
        } else {
            UserDefaults.standard.set(false, forKey: "brazilBarcodeReviewVC")
            UserDefaults.standard.set(true, forKey: "seriesReviewVC")
            UserDefaults.standard.set("barcode", forKey: "InheritFOReviewOrderVC")
            self.search()
            self.tblView.reloadData()
        }
        
   
        self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
        self.sortBySeriesImgView.image = UIImage(named: "radioSeletedBtn")
        self.sortByAnimalIDImgView.image = UIImage(named: "radioBtn")
        self.sortByRGNImgView.image = UIImage(named: "radioBtn")
        self.sortByTitle.text = LocalizedStrings.seriesText
        self.sortByBrazilView.isHidden = true
        self.bckRoundView.isHidden = true
        itemSelection = LocalizedStrings.seriesText
        reviewOrderListObject.itemSelection = itemSelection
    }
    
    @IBAction func sortByRGNAction(_ sender: UIButton) {
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        if sortByRGNImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        }
   
        if self.searchTxt.text != ""{
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
                self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 0.8, position: .center)
                
            }
        } else {
            UserDefaults.standard.set("rgn", forKey: "InheritFOReviewOrderVC")
            self.search()
            self.tblView.reloadData()
        }
        
   
        self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
        self.sortBySeriesImgView.image = UIImage(named: "radioBtn")
        self.sortByAnimalIDImgView.image = UIImage(named: "radioBtn")
        self.sortByRGNImgView.image = UIImage(named: "radioSeletedBtn")
        self.sortByTitle.text = LocalizedStrings.RGNText
        self.sortByBrazilView.isHidden = true
        self.bckRoundView.isHidden = true
        itemSelection = LocalizedStrings.RGNText
        reviewOrderListObject.itemSelection = itemSelection
    }
    
    @IBAction func sortByAnimalIDAction(_ sender: UIButton) {
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        if sortByAnimalIDImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        }
   
        if self.searchTxt.text != ""{
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
                self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 0.8, position: .center)
                
            }
        } else {
            UserDefaults.standard.set("rgd", forKey: "InheritFOReviewOrderVC")
            self.search()
            self.tblView.reloadData()
        }
        
   
        self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
        self.sortBySeriesImgView.image = UIImage(named: "radioBtn")
        self.sortByAnimalIDImgView.image = UIImage(named: "radioSeletedBtn")
        self.sortByRGNImgView.image = UIImage(named: "radioBtn")
        self.sortByTitle.text = LocalizedStrings.RGDText
        self.sortByBrazilView.isHidden = true
        self.bckRoundView.isHidden = true
        itemSelection = LocalizedStrings.RGDText
        reviewOrderListObject.itemSelection = itemSelection
    }
    
    @IBAction func sortByBrazilBarcodeAction(_ sender: UIButton) {
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        if sortByBrazilBarcodeImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        }
   
        if self.searchTxt.text != ""{
            UserDefaults.standard.set(true, forKey: "brazilBarcodeReviewVC")
            UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
            let bPredicate = NSPredicate(format: "animalTag contains[cd] %@ || productName contains[cd] %@", self.searchTxt.text!,self.searchTxt.text!)
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
                self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 0.4, position: .center)
                
            }
        } else {
            UserDefaults.standard.set(true, forKey: "brazilBarcodeReviewVC")
            UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
            self.search()
            self.tblView.reloadData()
        }
        
   
        self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
        self.sortBySeriesImgView.image = UIImage(named: "radioBtn")
        self.sortByAnimalIDImgView.image = UIImage(named: "radioBtn")
        self.sortByRGNImgView.image = UIImage(named: "radioBtn")
        self.sortByTitle.text = ButtonTitles.barcodeText
        self.sortByBrazilView.isHidden = true
        self.bckRoundView.isHidden = true
        itemSelection = ButtonTitles.barcodeText
        reviewOrderListObject.itemSelection = itemSelection
    }
    
    
    @IBAction func dropDownBtnAction(_ sender: UIButton) {
        
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        
        if pvid != 6 {
            self.sortByView.isHidden = false
            self.sortByBrazilView.isHidden = true
        } else {
            self.sortByView.isHidden = true
            self.sortByBrazilView.isHidden = false
        }
        
        self.bckRoundView.isHidden = false

      
//        dropDown.anchorView = farmIdHideLbl
//        dropDown.direction = .bottom
//        dropDown.backgroundColor = UIColor.white
//        dropDown.separatorColor = UIColor.clear
//        dropDown.cornerRadius = 10
//        dropDown.textFont = UIFont.systemFont(ofSize: 13)
//        dropDown.cellHeight = 37
//        searchTxt.resignFirstResponder()
//        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
//      if  pvid == 13 {
//        dropDown.dataSource = [NSLocalizedString("Unique ID", comment: ""),NSLocalizedString("Barcode", comment: "")]
//      }
//        if pvid == 7{
//            dropDown.dataSource = [NSLocalizedString("Animal Tag", comment: ""), NSLocalizedString("Barcode", comment: "")]
//        }
//        if pvid == 5{
//            dropDown.dataSource = [NSLocalizedString("Ear Tag", comment: ""), NSLocalizedString("Barcode", comment: "")]
//        }
//        if pvid == 6{
//            dropDown.dataSource = [NSLocalizedString("Barcode", comment: ""), NSLocalizedString("Series", comment: ""), NSLocalizedString("RGN", comment: ""), NSLocalizedString("RGD or Animal ID", comment: "")]
//        }
//        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//          
//            self.clickOnDropDown = item
//            self.reviewOrderListObject.itemSelection =  self.clickOnDropDown
//            self.tblView.reloadData()
//            sender.setTitle(item, for: .normal)
//            sender.layer.borderColor = UIColor.gray.cgColor
//            if pvid == 5 || pvid == 7 ||  pvid == 13 {
//                
//                
//                if self.searchTxt.text != ""{
//                    
//                  if self.clickOnDropDown == NSLocalizedString("Ear Tag", comment: "") || self.clickOnDropDown == NSLocalizedString("Official ID", comment: "") || self.clickOnDropDown == "Animal Tag".localized || self.clickOnDropDown == "Unique ID".localized {
//                        UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
//                        let bPredicate = NSPredicate(format: "animalTag contains[cd] %@ || productName contains[cd] %@", self.searchTxt.text!,self.searchTxt.text!)
//                        let fetchcustRep =   BeefFetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimlTbLBeef]
//                        if fetchcustRep.count > 0 {
//                            
//                            var productNameArray = [String]()
//                            
//                            for object in fetchcustRep  {
//                                productNameArray.append(object.productName!)
//                                self.set  =  Array(Set(productNameArray))
//                            }
//                            self.uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
//                          
//                            self.reviewOrderListObject.set = self.set
//                            self.reviewOrderListObject.uniqueProductArrayBeef = self.uniqueProductArray
//                            self.tblView.reloadData()
//                            
//                        } else {
//                            self.reviewOrderListObject.set.removeAll()
//                            self.tblView.reloadData()
//                            self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 0.4, position: .center)
//                        }
//                    }
//                    if self.clickOnDropDown == NSLocalizedString("Barcode", comment: ""){
//                        UserDefaults.standard.set("barcode", forKey: "InheritFOReviewOrderVC")
//                        let bPredicate = NSPredicate(format: " animalbarCodeTag contains[cd] %@ || productName contains[cd] %@", self.searchTxt.text!,self.searchTxt.text!)
//                        let fetchcustRep =   BeefFetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimlTbLBeef]
//                        if fetchcustRep.count > 0 {
//                            
//                            var productNameArray = [String]()
//                            for object in fetchcustRep  {
//                                productNameArray.append(object.productName!)
//                                self.set  =  Array(Set(productNameArray))
//                            }
//                            self.uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
//                           
//                            self.reviewOrderListObject.set = self.set
//                            self.reviewOrderListObject.uniqueProductArrayBeef = self.uniqueProductArray
//                            self.tblView.reloadData()
//                            
//                        }else {
//                            self.reviewOrderListObject.set.removeAll()
//                            self.tblView.reloadData()
//                            self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 0.8, position: .center)
//                        }
//                    }
//                    
//                } else {
//                    if self.clickOnDropDown == NSLocalizedString("Barcode" , comment: ""){
//                        UserDefaults.standard.set("barcode", forKey: "InheritFOReviewOrderVC")
//                    }
//                    if self.clickOnDropDown == NSLocalizedString("Ear Tag", comment: "") || self.clickOnDropDown == NSLocalizedString("Official ID", comment: "") || self.clickOnDropDown == "Animal Tag"{
//                        UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
//                    }
//                    self.search()
//                    self.tblView.reloadData()
//                }
//            }
//                
//            else { //BRAZIL
//                
//                if self.searchTxt.text != ""{
//                    
//                    if self.clickOnDropDown == NSLocalizedString("Barcode" , comment: ""){
//                        UserDefaults.standard.set(true, forKey: "brazilBarcodeReviewVC")
//                        UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
//                        let bPredicate = NSPredicate(format: "animalTag contains[cd] %@ || productName contains[cd] %@", self.searchTxt.text!,self.searchTxt.text!)
//                        let fetchcustRep =   BeefFetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimlTbLBeef]
//                        if fetchcustRep.count > 0 {
//                            
//                            var productNameArray = [String]()
//                            
//                            for object in fetchcustRep  {
//                                productNameArray.append(object.productName!)
//                                self.set  =  Array(Set(productNameArray))
//                            }
//                            self.uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
//                            self.reviewOrderListObject.set = self.set
//                            self.reviewOrderListObject.uniqueProductArrayBeef = self.uniqueProductArray
//                            self.tblView.reloadData()
//                            
//                        } else {
//                            self.reviewOrderListObject.set.removeAll()
//                            self.tblView.reloadData()
//                            self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 0.4, position: .center)
//                            
//                        }
//                    }
//                    if self.clickOnDropDown == NSLocalizedString("Series", comment: "") {
//                        UserDefaults.standard.set(false, forKey: "brazilBarcodeReviewVC")
//                        UserDefaults.standard.set(true, forKey: "seriesReviewVC")
//                        UserDefaults.standard.set("barcode", forKey: "InheritFOReviewOrderVC")
//                        let bPredicate = NSPredicate(format: " animalbarCodeTag contains[cd] %@ || productName contains[cd] %@", self.searchTxt.text!,self.searchTxt.text!)
//                        let fetchcustRep =   BeefFetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimlTbLBeef]
//                        if fetchcustRep.count > 0 {
//                            
//                            var productNameArray = [String]()
//                            for object in fetchcustRep  {
//                                productNameArray.append(object.productName!)
//                                self.set  =  Array(Set(productNameArray))
//                            }
//                            self.uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
//                            self.reviewOrderListObject.set = self.set
//                            self.reviewOrderListObject.uniqueProductArrayBeef = self.uniqueProductArray
//                            self.tblView.reloadData()
//                            
//                        } else {
//                            self.reviewOrderListObject.set.removeAll()
//                            self.tblView.reloadData()
//                            self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 0.8, position: .center)
//                            
//                        }
//                    }
//                    
//                    if self.clickOnDropDown == NSLocalizedString("RGN", comment: "") {
//                        UserDefaults.standard.set("rgn", forKey: "InheritFOReviewOrderVC")
//                        let bPredicate = NSPredicate(format: " rgn contains[cd] %@ || productName contains[cd] %@", self.searchTxt.text!,self.searchTxt.text!)
//                        let fetchcustRep =   BeefFetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimlTbLBeef]
//                        if fetchcustRep.count > 0 {
//                            
//                            var productNameArray = [String]()
//                            for object in fetchcustRep  {
//                                productNameArray.append(object.productName!)
//                                self.set  =  Array(Set(productNameArray))
//                            }
//                            self.uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
//                            self.reviewOrderListObject.set = self.set
//                            self.reviewOrderListObject.uniqueProductArrayBeef = self.uniqueProductArray
//                            self.tblView.reloadData()
//                            
//                        } else {
//                            self.reviewOrderListObject.set.removeAll()
//                            self.tblView.reloadData()
//                            self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 0.8, position: .center)
//                            
//                        }
//                    }
//                    
//                    if self.clickOnDropDown == NSLocalizedString("RGD", comment: "") || self.clickOnDropDown == NSLocalizedString("RGD or Animal ID", comment: ""){
//                        UserDefaults.standard.set("rgd", forKey: "InheritFOReviewOrderVC")
//                        let bPredicate = NSPredicate(format: " rgd contains[cd] %@ || productName contains[cd] %@", self.searchTxt.text!,self.searchTxt.text!)
//                        let fetchcustRep =   BeefFetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId).filtered(using: bPredicate) as! [ProductAdonAnimlTbLBeef]
//                        if fetchcustRep.count > 0 {
//                            
//                            var productNameArray = [String]()
//                            for object in fetchcustRep  {
//                                productNameArray.append(object.productName!)
//                                self.set  =  Array(Set(productNameArray))
//                            }
//                            self.uniqueProductArray = Dictionary(grouping: fetchcustRep, by: { $0.productName! })
//                            self.reviewOrderListObject.set = self.set
//                            self.reviewOrderListObject.uniqueProductArrayBeef = self.uniqueProductArray
//                            self.tblView.reloadData()
//                            
//                        } else {
//                            self.reviewOrderListObject.set.removeAll()
//                            self.tblView.reloadData()
//                            self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 0.8, position: .center)
//                            
//                        }
//                        
//                    }
//                } else {
//                    if self.clickOnDropDown == NSLocalizedString("Series", comment: "") {
//                        UserDefaults.standard.set(false, forKey: "brazilBarcodeReviewVC")
//                        UserDefaults.standard.set(true, forKey: "seriesReviewVC")
//                        UserDefaults.standard.set("barcode", forKey: "InheritFOReviewOrderVC")
//                    }
//                    if self.clickOnDropDown == NSLocalizedString("Barcode", comment: ""){
//                        UserDefaults.standard.set(true, forKey: "brazilBarcodeReviewVC")
//                        UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
//                    }
//                    if self.clickOnDropDown == NSLocalizedString("RGN", comment: "") {
//                        UserDefaults.standard.set("rgn", forKey: "InheritFOReviewOrderVC")
//                    }
//                    if self.clickOnDropDown == NSLocalizedString("RGD", comment: "") || self.clickOnDropDown == NSLocalizedString("RGD or Animal ID", comment: ""){
//                        UserDefaults.standard.set("rgd", forKey: "InheritFOReviewOrderVC")
//                    }
//                    self.search()
//                    self.tblView.reloadData()
//                }
//            }
//        }
//        dropDown.show()
        
    }
    
    func selectionObjectCheck(check :Bool){
        if check == true{
            let storyBoard: UIStoryboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "BeefConfilictOrdersViewController") as! BeefConfilictOrdersViewController
            vc.delegateCustom1 = self
            vc.dismissDelegate = self
            vc.screenName = "BeefReviewOrderVCIpad"
            self.present(vc, animated: true, completion: nil)
          //  self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)

//            let transition = CATransition()
//            transition.duration = 0.5
//            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//            transition.type = CATransitionType.moveIn
//            transition.subtype = CATransitionSubtype.fromTop
//            navigationController?.view.layer.add(transition, forKey: nil)
//            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func termsInfoBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "iPad", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductWiseTermsController") as! ProductWiseTermsController
        self.navigationController?.present(vc, animated: false, completion: nil)
        return
    }
    
    
    func setSubmitOrderInitialUI(){
        self.searchTxt.setLeftPaddingPoints(20.0)
        self.addDealerCodeTxtField.setLeftPaddingPoints(20.0)
        self.billingContact.text = NSLocalizedString(LocalizedStrings.billingContact, comment: "")
        
        if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as! String  == marketNameType.Beef.rawValue{
            self.beefsubmitInfoBtn.isHidden = false
          //  self.beefEmailMeInfoBtn.isHidden = false
         //   self.delegateCustom = self
            let pviduser = (UserDefaults.standard.integer(forKey:keyValue.beefPvid.rawValue))
            let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
            if UserDefaults.standard.value(forKey: keyValue.submitTypeSelection.rawValue) as? String == keyValue.emailMe.rawValue || UserDefaults.standard.value(forKey: keyValue.submitTypeSelection.rawValue) as? String == "" ||  UserDefaults.standard.value(forKey: keyValue.submitTypeSelection.rawValue) as? String == nil{
                UserDefaults.standard.setValue(keyValue.emailMe.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
                
                if  UserDefaults.standard.value(forKey: keyValue.beefEmailCheckValue.rawValue) as? Bool == true{
                  //  self.beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                    emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                }
                else  if self.beefEmailSelectionOutlet.isSelected == false{
                   // self.beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                    emailBtnImgView.image = UIImage(named: "Incremental_Check")
                }
                
                if  UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == true{
                   // self.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                    placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                    self.addDealerCodeLbl.alpha = 1
                    self.addDealerCodeOutlet.alpha = 1
                    self.addDealerCodeView.isHidden = false
                }
                else  if UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == false{
                 //   self.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                    placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                    self.addDealerCodeLbl.alpha = 0.6
                    self.addDealerCodeOutlet.alpha = 0.6
                    self.addDealerCodeView.isHidden = true
                }
            }
            else {
                UserDefaults.standard.setValue(keyValue.submitKey.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
                if  UserDefaults.standard.value(forKey: keyValue.beefEmailCheckValue.rawValue) as? Bool == true{
                  //  self.beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                    emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                }
                else  if self.beefEmailSelectionOutlet.isSelected == false{
                  //  self.beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                    emailBtnImgView.image = UIImage(named: "Incremental_Check")
                }
                
                if  UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == true{
                  //  self.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                    placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                    self.addDealerCodeLbl.alpha = 1
                    self.addDealerCodeOutlet.alpha = 1
                    self.addDealerCodeView.isHidden = false
                }
                else  if UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == false{
                  //  self.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                    placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                    self.addDealerCodeLbl.alpha = 0.6
                    self.addDealerCodeOutlet.alpha = 0.6
                    self.addDealerCodeView.isHidden = true
                }
                self.beefEmailSelectionOutlet.alpha = 0.6
            }
            
            if pviduser == 13 {
                let fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: Entities.beefAnimalAddTblEntity,orderId:orderIdBeef,userId:userId,customerId:currentCustomerId ?? 0,date:"")
                
                if fetchAnimalTbl.count == 0 {
                    UserDefaults.standard.set(false, forKey: keyValue.beefEmailCheckValue.rawValue)
                    UserDefaults.standard.set(true, forKey: keyValue.beefPlaceOrderCheck.rawValue)
                    self.beefPlaceAnSelectionTitle.alpha = 1
                    self.beefPlaceSelectionOutlet.alpha = 1
                    self.beefEmailSelectionOutlet.isHidden = true
                    self.emailMeSelectionTtile.isHidden = true
                    self.emailStackView.isHidden = true
                 //   self.beefEmailMeInfoBtn.isHidden =  true
                   // self.beefEmailSelectionheightConstraint.constant = 0
               //     self.beefPlaceanOrderTopConstraint.constant = 0
                    
                    if  UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == true{
                      //  self.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                        placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                        self.addDealerCodeLbl.alpha = 1
                        self.addDealerCodeOutlet.alpha = 1
                        self.addDealerCodeView.isHidden = false
                    }
                    else  if UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == false{
                       // self.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                        placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                        self.addDealerCodeLbl.alpha = 0.6
                        self.addDealerCodeOutlet.alpha = 0.6
                        self.addDealerCodeView.isHidden = true
                    }
                }
                else {
                    self.beefPlaceAnSelectionTitle.alpha = 0.6
                    self.beefPlaceSelectionOutlet.alpha = 0.6
                    self.addDealerCodeLbl.alpha = 0.6
                    self.addDealerCodeOutlet.alpha = 0.6
                    self.addDealerCodeView.isHidden = true
                    UserDefaults.standard.set(false, forKey: keyValue.beefPlaceOrderCheck.rawValue)
                    
                    if  UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == true{
                     //   self.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                        placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                        self.addDealerCodeLbl.alpha = 1
                        self.addDealerCodeOutlet.alpha = 1
                        self.addDealerCodeView.isHidden = false
                    }
                    else  if UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == false{
                    //    self.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                        placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                        self.addDealerCodeLbl.alpha = 0.6
                        self.addDealerCodeOutlet.alpha = 0.6
                        self.addDealerCodeView.isHidden = true
                    }
                    
                    UserDefaults.standard.setValue(keyValue.emailMe.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
                //    self.beefAgreeTopConstarintt.constant = 12
                    self.beefinfoBtnSelectionOutlet.isHidden = true
             //       self.beefAgreeHeightConstraint.constant = 0
            //        self.beefPricingTextHeight.constant = 0
            //        self.beefEmailSelectionTopConstranint.constant = 0
                    self.beefEmailSelectionOutlet.isHidden = true
                    self.emailMeSelectionTtile.isHidden = true
                    self.emailStackView.isHidden = true
                  //  self.beefEmailMeInfoBtn.isHidden =  true
               //     self.termsBtnnOutlet.isHidden = true
                    self.agrreLblStackView.isHidden = true
                    self.agreeStackViewTopConstraint.constant = -70
               //     self.beefEmailSelectionheightConstraint.constant = 0
               //     self.beefPlaceanOrderTopConstraint.constant = 0
                }
            }
            
            if pviduser == 5 {
            //    if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.capsInherit.rawValue || UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue{
                    let fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: Entities.beefAnimalAddTblEntity,orderId:orderIdBeef,userId:userId,customerId:currentCustomerId ?? 0,date:"")
                    
                    if fetchAnimalTbl.count == 0 {
                        self.beefPlaceAnSelectionTitle.alpha = 1
                        self.beefPlaceSelectionOutlet.alpha = 1
                        if  UserDefaults.standard.value(forKey: keyValue.beefEmailCheckValue.rawValue) as? Bool == true{
                          //  self.beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                        }
                        else  if self.beefEmailSelectionOutlet.isSelected == false{
                         //   self.beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            emailBtnImgView.image = UIImage(named: "Incremental_Check")
                        }
                        
                        if  UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == true{
                          //  self.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                            self.addDealerCodeLbl.alpha = 1
                            self.addDealerCodeOutlet.alpha = 1
                            self.addDealerCodeView.isHidden = false
                        }
                        else  if UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == false{
                          //  self.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                            self.addDealerCodeLbl.alpha = 0.6
                            self.addDealerCodeOutlet.alpha = 0.6
                            self.addDealerCodeView.isHidden = true
                        }
                        self.agrreLblStackView.isHidden = false
                        self.agreeStackViewTopConstraint.constant = 20
                    }
                    else {
                        self.beefPlaceAnSelectionTitle.alpha = 0.6
                        self.beefPlaceSelectionOutlet.alpha = 0.6
                        self.addDealerCodeLbl.alpha = 0.6
                        self.addDealerCodeOutlet.alpha = 0.6
                        self.addDealerCodeView.isHidden = true
                        if  UserDefaults.standard.value(forKey: keyValue.beefEmailCheckValue.rawValue) as? Bool == true{
                          //  self.beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                        }
                        else  if self.beefEmailSelectionOutlet.isSelected == false{
                            //self.beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            emailBtnImgView.image = UIImage(named: "Incremental_Check")
                        }
                        
                        if  UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == true{
                         //   self.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                            self.addDealerCodeLbl.alpha = 1
                            self.addDealerCodeOutlet.alpha = 1
                            self.addDealerCodeView.isHidden = false
                        }
                        else  if UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == false{
                        //    self.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                            self.addDealerCodeLbl.alpha = 0.6
                            self.addDealerCodeOutlet.alpha = 0.6
                            self.addDealerCodeView.isHidden = true
                        }
                        
                        UserDefaults.standard.setValue(keyValue.emailMe.rawValue, forKey: keyValue.submitTypeSelection.rawValue)
                     //   self.beefAgreeTopConstarintt.constant = 12
                        self.beefinfoBtnSelectionOutlet.isHidden = true
                    //    self.beefAgreeHeightConstraint.constant = 0
                    //    self.beefPricingTextHeight.constant = 0
                    //    self.beefEmailSelectionTopConstranint.constant = 0
                       // self.termsBtnnOutlet.isHidden = true
                        self.agrreLblStackView.isHidden = true
                        self.agreeStackViewTopConstraint.constant = -70
                    }
              //  }
            }
            
            if pviduser == 7 || pviduser == 6 {
                if UserDefaults.standard.string(forKey: keyValue.brzGenoType.rawValue) == keyValue.genotypeKey.rawValue{
                    self.beefPlaceAnSelectionTitle.alpha = 1
                    self.beefPlaceSelectionOutlet.alpha = 1
                    self.addDealerCodeOutlet.alpha = 1
                    self.addDealerCodeLbl.alpha = 1
                    self.addDealerCodeView.isHidden = false
               //     self.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                    placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                //    self.beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                    emailBtnImgView.image = UIImage(named: "Incremental_Check")
                }
                else{
                    let fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: Entities.beefAnimalAddTblEntity,orderId:orderIdBeef,userId:userId,customerId:currentCustomerId ?? 0,date:"")
                    
                    if fetchAnimalTbl.count == 0 {
                        self.beefPlaceAnSelectionTitle.alpha = 1
                        self.beefPlaceSelectionOutlet.alpha = 1
                        if UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == true {
                         //   self.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                            self.addDealerCodeLbl.alpha = 1
                            self.addDealerCodeOutlet.alpha = 1
                            self.addDealerCodeView.isHidden = false
                        }
                        else  if self.beefPlaceSelectionOutlet.isSelected == false{
                         //   self.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                            self.addDealerCodeLbl.alpha = 0.6
                            self.addDealerCodeOutlet.alpha = 0.6
                            self.addDealerCodeView.isHidden = true
                        }
                        if  UserDefaults.standard.value(forKey: keyValue.beefEmailCheckValue.rawValue) as? Bool == true{
                         //   self.beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                        }
                        else  if self.beefEmailSelectionOutlet.isSelected == false{
                          //  self.beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            emailBtnImgView.image = UIImage(named: "Incremental_Check")
                        }
                        
                        self.agrreLblStackView.isHidden = false
                        self.agreeStackViewTopConstraint.constant = 20
                    }
                    else {
                        self.beefPlaceAnSelectionTitle.alpha = 0.6
                        self.beefPlaceSelectionOutlet.alpha = 0.6
                        self.addDealerCodeOutlet.alpha = 0.6
                        self.addDealerCodeLbl.alpha = 0.6
                        self.addDealerCodeView.isHidden = true
                        
                        if  UserDefaults.standard.value(forKey: keyValue.beefEmailCheckValue.rawValue) as? Bool == true{
                          //  self.beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                        }
                        else  if self.beefEmailSelectionOutlet.isSelected == false{
                         //   self.beefEmailSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            emailBtnImgView.image = UIImage(named: "Incremental_Check")
                        }
                        
                        if  UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == true{
                           // self.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                            placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                            self.addDealerCodeLbl.alpha = 1
                            self.addDealerCodeOutlet.alpha = 1
                            self.addDealerCodeView.isHidden = false
                        }
                        else  if UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == false{
                         //   self.beefPlaceSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                            placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                            self.addDealerCodeLbl.alpha = 0.6
                            self.addDealerCodeOutlet.alpha = 0.6
                            self.addDealerCodeView.isHidden = true
                        }
                   //     self.beefAgreeTopConstarintt.constant = 12
                        self.beefinfoBtnSelectionOutlet.isHidden = true
                    //    self.beefAgreeHeightConstraint.constant = 0
                    //    self.beefPricingTextHeight.constant = 0
                   //     self.beefEmailSelectionTopConstranint.constant = 0
                      //  self.termsBtnnOutlet.isHidden = true
                        self.agrreLblStackView.isHidden = true
                        self.agreeStackViewTopConstraint.constant = -70
                    }
                }
            }
        }
        
        let dealerCode = UserDefaults.standard.value(forKey: keyValue.dealerCode.rawValue) as? String
        let addDealerCodeCheck = UserDefaults.standard.value(forKey: keyValue.addDealerCodeCheck.rawValue) as? Bool
        if UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == true {
          
//            if addDealerCodeCheck == false {
//               // cell.addDealerCodeOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
//                addDealerCodeImgView.image = UIImage(named: "incrementalCheckIpad")
//                if dealerCode == "" || dealerCode == nil{
//                    
//                    self.addDealerCodeView.isHidden = true
//                    self.addDealerCodeTxtField.text = dealerCode
//                } else {
//                    self.addDealerCodeView.isHidden = true
//                    self.addDealerCodeTxtField.text = dealerCode
//                }
//
//            }
//            else {
//                addDealerCodeImgView.image = UIImage(named: "Incremental_Check")
//                if dealerCode == "" || dealerCode == nil{
//                    
//                    self.addDealerCodeView.isHidden = true
//                    self.addDealerCodeTxtField.text = dealerCode
//                } else {
//                    self.addDealerCodeView.isHidden = true
//                    self.addDealerCodeTxtField.text = dealerCode
//                }
//
////                if dealerCode == "" || dealerCode == nil{
////                    self.addDealerCodeView.isHidden = false
////                } else {
////                    cell.dealerCodeView.isHidden = false
////                    cell.dealerCodeLabel.text = dealerCode
////                    cell.dealerCodeView.alpha = 0.6
////                    cell.dealerCodeView.isUserInteractionEnabled = false
////                    cell.addDealerCodeTxtField.isHidden = true
////                }
//            }
            if dealerCode == nil || dealerCode == "" {
                self.addDealerCodeView.isHidden = true
            } else {
                self.addDealerCodeView.isHidden = false
                self.addDealerCodeTxtField.text = dealerCode
            }
           
        }
        
        else{
            addDealerCodeImgView.image = UIImage(named: "Incremental_Check")
            self.addDealerCodeView.isHidden = true
            self.addDealerCodeTxtField.text = dealerCode
           // self.addDealerCodeView.isHidden = true
//            if dealerCode == "" || dealerCode == nil{
//                
//                self.addDealerCodeView.isHidden = true
//                self.addDealerCodeTxtField.text = dealerCode
//            } else {
//                self.addDealerCodeView.isHidden = true
//                self.addDealerCodeTxtField.text = dealerCode
//            }
          
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
    
    func sideMenuRevealSettingsViewController() -> BeefReviewOrderVCIpad? {
        var viewController: UIViewController? = self
        
        if viewController != nil && viewController is BeefReviewOrderVCIpad {
            return viewController! as? BeefReviewOrderVCIpad
        }
        while (!(viewController is BeefReviewOrderVCIpad) && viewController?.parent != nil) {
            viewController = viewController?.parent
        }
        if viewController is BeefReviewOrderVCIpad {
            return viewController as? BeefReviewOrderVCIpad
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
    
    @IBAction func sortByCrossBtn(_ sender: Any) {
        
        sortByView.isHidden = true
        bckRoundView.isHidden = true
    }
    
    @IBAction func sortByBrazilCrossBtn(_ sender: Any) {
        
        sortByBrazilView.isHidden = true
        bckRoundView.isHidden = true
    }
    
    @IBAction func productAnimalToggleBtnClk(_ sender: UIButton) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "BeefOPSSelectionReviewIPadVC") as! BeefOPSSelectionReviewIPadVC
        self.navigationController?.pushViewController(newViewController, animated: false)
        
    }
    let buttonbg1 = UIButton ()
    var customPopView1 :TipPopUp!
    

    @IBAction func emailMeEnterAction(_ sender: UIButton) {
        
        if UserDefaults.standard.bool(forKey: "SubmitBtnFlag") == false {
            let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Do you want to email entered data?", comment: ""), preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("Cancel Pressed")
                
                return
            }
            // Create the actions
            let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) {
                UIAlertAction in
                UserDefaults.standard.set(true, forKey: "emailBeef")
                if Connectivity.isConnectedToInternet() {
                    self.showIndicator(self.view, withTitle: "", and: "")
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVCiPad") as! OrderSubmittedVCiPad
                    self.navigationController?.pushViewController(newViewController, animated: true)
                } else {
                    UserDefaults.standard.set(true, forKey: "emailBeef")

                    let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveVCiPad") as! OrderSaveVCiPad
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
            }
         
            alertController.addAction(cancelAction)

            // Add the actions
            alertController.addAction(okAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
        //    return
        }
        if Connectivity.isConnectedToInternet() {
            showIndicator(self.view, withTitle: "", and: "")

            let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVCiPad") as! OrderSubmittedVCiPad
            self.navigationController?.pushViewController(newViewController, animated: true)
        } else {
            UserDefaults.standard.set(true, forKey: "emailBeef")

            let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveVCiPad") as! OrderSaveVCiPad
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
        customPopView1.frame = CGRect(x: 120,y: p.origin.y + 40   ,width: 250, height: 125)
        
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
        customPopView1.frame = CGRect(x: p.origin.x - 150,y: p.origin.y +  41   ,width: 200, height: 100)
        
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
    var beefpvid = UserDefaults.standard.integer(forKey: "BeefPvid")
    
    
    if UserDefaults.standard.value(forKey: "beefplaceordercheck") as? Bool == true &&
        UserDefaults.standard.value(forKey: "beefemailcheckvalue") as? Bool == true
    {
      updateAnimalOrderEmailStatus(entity: "BeefAnimaladdTbl", IsEmailId: false)
      updateAnimalOrderEmailStatus(entity: "BeefAnimalMaster", IsEmailId: false)
      if (UserDefaults.standard.value(forKey: "isAggreForSubmit") as? Bool == false) || (UserDefaults.standard.value(forKey: "isAggreForSubmit") as? Bool == nil)
      {
        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please accept the order terms to proceed.", comment: ""))
        return
      }
      
      if Connectivity.isConnectedToInternet()
      {
        
        UserDefaults.standard.set(false, forKey: "emailBeef")
        // UserDefaults.standard.set(true, forKey: "SubmitBtnFlag")
        showIndicator(self.view, withTitle: "", and: "")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
          let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVCiPad") as! OrderSubmittedVCiPad
        newViewController.emailOrder=true
        self.navigationController?.pushViewController(newViewController, animated: true)
        
      }
      else
      {
        let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveVCiPad") as! OrderSaveVCiPad
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
        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please accept the order terms to proceed.", comment: ""))
        return
      }
      
      if Connectivity.isConnectedToInternet()
      {
        
        UserDefaults.standard.set(false, forKey: "emailBeef")
        // UserDefaults.standard.set(true, forKey: "SubmitBtnFlag")
        showIndicator(self.view, withTitle: "", and: "")
        
          let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVCiPad") as! OrderSubmittedVCiPad
          newViewController.emailOrder=true
          self.navigationController?.pushViewController(newViewController, animated: true)
        
      }
      else
      {
        let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveVCiPad") as! OrderSaveVCiPad
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
          CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please accept the order terms to proceed.", comment: ""))
          return
        }
        
        if Connectivity.isConnectedToInternet()
        {
          
          UserDefaults.standard.set(false, forKey: "emailBeef")
          // UserDefaults.standard.set(true, forKey: "SubmitBtnFlag")
          showIndicator(self.view, withTitle: "", and: "")
          
          let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVCiPad") as! OrderSubmittedVCiPad
          newViewController.emailOrder=false
          // newViewController.submitEmailFlag = submitEmailFlag
          self.navigationController?.pushViewController(newViewController, animated: true)
          
        }
        else
        {
          let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveVCiPad") as! OrderSaveVCiPad
          self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
      } else {
        updateAnimalOrderEmailStatus(entity: "BeefAnimaladdTbl", IsEmailId: true)
        updateAnimalOrderEmailStatus(entity: "BeefAnimalMaster", IsEmailId: true)
        if UserDefaults.standard.bool(forKey: "checkvalue") == false
        {
          let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Do you want to email entered data?", comment: ""), preferredStyle: .alert)
          
          let cancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("Cancel Pressed")
            
            return
          }
          // Create the actions
          let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) {
            UIAlertAction in
            UserDefaults.standard.set(true, forKey: "emailBeef")
            if Connectivity.isConnectedToInternet() {
              self.showIndicator(self.view, withTitle: "", and: "")
              
              let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVCiPad") as! OrderSubmittedVCiPad
              newViewController.emailOrder=true
              self.navigationController?.pushViewController(newViewController, animated: true)
            } else {
              let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
              let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveVCiPad") as! OrderSaveVCiPad
              self.navigationController?.pushViewController(newViewController, animated: true)
            }
          }
          
          alertController.addAction(cancelAction)
          // Add the actions
          alertController.addAction(okAction)
          
          
          // Present the controller
          self.present(alertController, animated: true, completion: nil)
          return
        }
        else
        {
          UserDefaults.standard.set(true, forKey: "emailBeef")
          if Connectivity.isConnectedToInternet()
          {
            
            // UserDefaults.standard.removeObject(forKey: "SubmitBtnFlag")
            
            showIndicator(self.view, withTitle: "", and: "")
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
              let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVCiPad") as! OrderSubmittedVCiPad
            newViewController.emailOrder=true
            // newViewController.submitEmailFlag = submitEmailFlag
            self.navigationController?.pushViewController(newViewController, animated: true)
            
          }
          else
          {
            let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveVCiPad") as! OrderSaveVCiPad
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
        
        self.sideMenuRevealSettingsViewController()?.revealSideMenu()
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
        
        if customerNameLbl.text == "N/A"{
            
            tableViewBg.isHidden = true
            bckRoundView.isHidden = true
            
        } else {
            tableViewBg.isHidden = false
            bckRoundView.isHidden = false
            
          //  billingViewHeightConst.constant = billingTblView.contentSize.height + 100
            billingTblView.reloadData()
        }
    }
    
    @IBAction func viewAnimalClick(_ sender: Any) {
        let vc = UIStoryboard.init(name: "BeefPlaceAnOrder", bundle: Bundle.main).instantiateViewController(withIdentifier: "BeefViewAnimalVCiPad") as? BeefViewAnimalVCiPad
        vc?.delegateCustom = self
        vc!.screenBackSave = false
        vc!.productBackSave = false
        self.navigationController?.pushViewController(vc!, animated: true)
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
        
        if textField == addDealerCodeTxtField {
            guard !string.isEmpty else {
                return true
            }
            let ACCEPTABLE_CHARACTERS = LocalizedStrings.alphaNumericFormat
            let check  = ACCEPTABLE_CHARACTERS.contains(string)
            if check == false {
              return false
            }
            let maxLength = 20
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.count <= maxLength
        }
        
        let currentString: NSString = searchTxt.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        tblView.isHidden = false
        // var bPredicate : NSPredicate?
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        if newString != ""{
            if pvid == 5 || pvid == 7 || pvid == 13{
              if self.clickOnDropDown == NSLocalizedString("Ear Tag", comment: "") || self.clickOnDropDown == NSLocalizedString("Official ID", comment: "") || self.clickOnDropDown == "Animal Tag".localized || self.clickOnDropDown == "Unique ID".localized{
                    let bPredicate = NSPredicate(format: "animalTag contains[cd] %@ || productName contains[cd] %@", newString,newString)
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
                        self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 0.8, position: .center)
                    }
                }
                if self.clickOnDropDown == NSLocalizedString("Barcode" , comment: ""){
                    let bPredicate = NSPredicate(format: " animalbarCodeTag contains[cd] %@ || productName contains[cd] %@", newString,newString)
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
                        self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 0.8, position: .center)
                    }
                }
            }
            else {
                
                if self.clickOnDropDown == NSLocalizedString("Barcode" , comment: ""){
                    UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
                    let bPredicate = NSPredicate(format: "animalTag contains[cd] %@ || productName contains[cd] %@", self.searchTxt.text!,self.searchTxt.text!)
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
                        self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 0.4, position: .center)
                    }
                }
                if self.clickOnDropDown == NSLocalizedString("Series", comment: "") {
                    UserDefaults.standard.set("barcode", forKey: "InheritFOReviewOrderVC")
                    let bPredicate = NSPredicate(format: " animalbarCodeTag contains[cd] %@ || productName contains[cd] %@", self.searchTxt.text!,self.searchTxt.text!)
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
                        self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 0.8, position: .center)
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
                        self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 0.8, position: .center)
                        
                        
                    }
                    
                    
                }
                
                if self.clickOnDropDown == NSLocalizedString("RGD", comment: "") || self.clickOnDropDown == NSLocalizedString("RGD or Animal ID", comment: ""){
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
                        self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 0.8, position: .center)
                        
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
        //search()
        //  tblView.reloadData()
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
extension BeefReviewOrderVCIpad:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
}
extension BeefReviewOrderVCIpad: SideMenuUI
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


extension  BeefReviewOrderVCIpad:NSFetchedResultsControllerDelegate{
    
}


extension BeefReviewOrderVCIpad :UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == billingTblView {
            
            return farmAddr.count
        }else {
            
            return self.tissueArr.count
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == billingTblView {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.billingTableViewCell, for: indexPath) as? BillingTableViewCell
            cell?.selectionStyle = .none
            let filterArr = farmAddr.filter({$0.isDefault == true })
            if filterArr.count > 0{
                if farmAddr[indexPath.row].billToCustId! == filterArr[0].billToCustId{
                    cell?.radioBtnOutlet.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
                } else {
                    cell?.radioBtnOutlet.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
                }
            } else if Int(farmAddr[indexPath.row].billToCustId!) == self.custmerId{
                cell?.radioBtnOutlet.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
                updateBillingCustomer(entity: Entities.getBillingContactEntity, customerID: self.custmerId, isDefault: true, billcustomerId: farmAddr[indexPath.row].billToCustId ?? "0", billcustomerName: farmAddr[indexPath.row].contactName ?? "")
            }
            else {
                cell?.radioBtnOutlet.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
            }
            cell?.AddrLbl.text = farmAddr[indexPath.row].contactName
            return cell!
        }
        else {
            
            let cell = UITableViewCell()
            cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
            
            cell.textLabel?.text = self.tissueArr[indexPath.row] as! String
            return cell
        }
    }
    
    // method to run when table view cell is tapped
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == billingTblView {
            
          
           let filterArr = farmAddr.filter({$0.isDefault == true })
            if filterArr.count > 0{
              updateBillingCustomer(entity: "GetBillingContact", customerID: self.custmerId, isDefault: false, billcustomerId: filterArr[0].billToCustId ?? "0", billcustomerName: filterArr[0].contactName ?? "")
              
            }
              UserDefaults.standard.set(farmAddr[indexPath.row].contactName, forKey: "farmValue")
              UserDefaults.standard.set(farmAddr[indexPath.row].billToCustId, forKey: "billToCustomerId")
            
            updateBillingCustomer(entity: "GetBillingContact", customerID: self.custmerId, isDefault: true, billcustomerId: farmAddr[indexPath.row].billToCustId ?? "0", billcustomerName: farmAddr[indexPath.row].contactName ?? "")
            
            farmAddr = fetchBillingCustomer(entityName: "GetBillingContact",customerID: self.custmerId) as! [GetBillingContact]
            customerNameLbl.text = farmAddr[indexPath.row].contactName ?? ""
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


import UIKit
 class PaddingLabel: UILabel {

    var edgeInset: UIEdgeInsets = .zero

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: edgeInset.top, left: edgeInset.left, bottom: edgeInset.bottom, right: edgeInset.right)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + edgeInset.left + edgeInset.right, height: size.height + edgeInset.top + edgeInset.bottom)
    }
}
