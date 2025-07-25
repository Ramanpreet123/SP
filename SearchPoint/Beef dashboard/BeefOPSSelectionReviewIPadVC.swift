//
//  BeefOPSSelectionReviewIPadVC.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 03/03/25.
//

import Foundation
import UIKit
import DropDown
import MBProgressHUD
class BeefOPSSelectionReviewIPadVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextFieldDelegate,BillingDelegate,offlineCustomView1,UITextViewDelegate,objectPickfromConfilict, DismissConflictPopUp{
    func updateDismissUI() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.userId = UserDefaults.standard.integer(forKey: "userId")
        self.orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
        
        tableViewBilling.delegate = billingdelegateVC
        tableViewBilling.dataSource = billingdelegateVC
        tableViewBilling.reloadData()
        billingdelegateVC.delegate = self
        
        //      if pvid == 13 {
        //        appHelpBtn.isHidden = false
        //      } else {
        //        appHelpBtn.isHidden = true
        //      }
        
        let animaltbl = fetchRemaningSubmitOrder(entityName: "BeefAnimaladdTbl", isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
        
        for i in 0..<animaltbl.count{
            let data = animaltbl.object(at: i) as! BeefAnimaladdTbl
            deleteRemaningSubmitOrderReview(entityName: "ProductAdonAnimlTbLBeef", isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId, aid: Int(data.animalId))
            deleteRemaningSubmitOrderReview(entityName: "SubProductTblBeef", isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId,aid: Int(data.animalId))
        }
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        deleteRemaningSubmitOrder(entityName: "BeefAnimaladdTbl", isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
        
        if pvid == 5 {
            self.earTaglbl.text = "Ear Tag"
        } else {
            self.earTaglbl.text = "Unique ID"
        }
        if  UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == nil {
            UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
            if pvid == 13 {
                self.clickOnDropDown = "Unique ID".localized
            }
            if pvid == 7{
                self.clickOnDropDown = NSLocalizedString("Animal Tag", comment: "")
            }
            if pvid == 5{
                self.clickOnDropDown = NSLocalizedString("Ear Tag", comment: "")
            }
            if pvid == 6{
                self.clickOnDropDown = NSLocalizedString("Barcode", comment: "")
                self.sortBySeriesImgView.image = UIImage(named: "radioBtn")
                self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
                self.sortByRGNImgView.image = UIImage(named: "radioBtn")
                self.sortByAnimalIDImgView.image = UIImage(named: "radioBtn")
            }
            //self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            self.sortByEarTagImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
            
            fethData =   fetchAllDataanimalTagStatus(entityName: "ProductAdonAnimlTbLBeef",asending : true,status: "true", orderStatus: "false", animalTag: serchTextField.text!)
        }
        
        if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "officialid" {
            UserDefaults.standard.set(true, forKey: "brazilBarcode")
            if pvid == 13 {
                self.clickOnDropDown = "Unique ID".localized
            }
            if pvid == 7 {
                self.clickOnDropDown = NSLocalizedString("Animal Tag", comment: "")
            }
            if pvid == 5{
                self.clickOnDropDown = NSLocalizedString("Ear Tag", comment: "")
            }
            if pvid == 6{
                self.clickOnDropDown = NSLocalizedString("Barcode", comment: "")
                self.sortBySeriesImgView.image = UIImage(named: "radioBtn")
                self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
                self.sortByRGNImgView.image = UIImage(named: "radioBtn")
                self.sortByAnimalIDImgView.image = UIImage(named: "radioBtn")
            }
            //  self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            self.fethData =  fetchAllDataanimalTagStatus(entityName: "ProductAdonAnimlTbLBeef",asending : true,status: "true", orderStatus: "false", animalTag: serchTextField.text!)
            
            self.sortByEarTagImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
        }
        if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "barcode" || UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "Barcode"{
            if pvid == 5 || pvid == 7{
                var selected = UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC")
                if selected == "barcode" {
                    selected = "Barcode"
                }
                self.clickOnDropDown = NSLocalizedString(selected ?? "Ear Tag", comment: "")
                
                self.sortByEarTagImgView.image = UIImage(named: "radioBtn")
                self.sortByBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
            }
            if pvid == 6{
                UserDefaults.standard.set(false, forKey: "brazilBarcode")
                UserDefaults.standard.set(true, forKey: "series")
                self.clickOnDropDown =  NSLocalizedString("Series", comment: "")
                self.sortBySeriesImgView.image = UIImage(named: "radioBtn")
                self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
                self.sortByRGNImgView.image = UIImage(named: "radioBtn")
                self.sortByAnimalIDImgView.image = UIImage(named: "radioBtn")
            }
            if pvid == 13{
                
                self.clickOnDropDown = "Unique ID".localized
                
                self.sortByEarTagImgView.image = UIImage(named: "radioBtn")
                self.sortByBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
            }
            //  self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            self.fethData =  fetchAllDataBarcOdeStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true,status: "true", orderStatus: "false", barcode: serchTextField.text!)
        }
        if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "rgn" {
            self.clickOnDropDown =  NSLocalizedString("RGN", comment: "")
            // self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            self.sortBySeriesImgView.image = UIImage(named: "radioBtn")
            self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
            self.sortByRGNImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByAnimalIDImgView.image = UIImage(named: "radioBtn")
            self.fethData =  fetchAllDataRGNStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
            
        }
        if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "rgd" {
            self.clickOnDropDown =  NSLocalizedString("RGD or Animal ID", comment: "")
            //      self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            self.sortBySeriesImgView.image = UIImage(named: "radioBtn")
            self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
            self.sortByRGNImgView.image = UIImage(named: "radioBtn")
            self.sortByAnimalIDImgView.image = UIImage(named: "radioSeletedBtn")
            self.fethData =  fetchAllDataRGDStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
        }
        
        if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "Series" {
            
            self.clickOnDropDown =  NSLocalizedString("Series", comment: "")
            //  self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            self.sortBySeriesImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
            self.sortByRGNImgView.image = UIImage(named: "radioBtn")
            self.sortByAnimalIDImgView.image = UIImage(named: "radioBtn")
            self.fethData =  fetchAllDataRGDStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
            
            
        }
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
        
        notificationLblCount.text = String(animalCount.count)
        
        if farmAddr.count > 0  {
            var abc = ""
            let filterArr = farmAddr.filter({$0.isDefault == true })
            if filterArr.count > 0{
                abc = filterArr[0].contactName ?? ""
            } else{
                
                let billArray =  farmAddr.filter({Int($0.billToCustId!) == self.custmerId})
                abc = billArray[0].contactName ?? ""
                UserDefaults.standard.set(billArray[0].billToCustId, forKey: "billToCustomerId")
            }
            customerNameLbl.text = abc
            //          DispatchQueue.main.async {
            //              if let cell = self.tblView.cellForRow(at: IndexPath(row: self.arr1.keys.count, section: 0) ) as? BillingCell{
            //                let attributeString = NSMutableAttributedString(string: abc , attributes: self.attrs)
            //                  UserDefaults.standard.set(abc, forKey: "farmValue")
            //
            //                  cell.billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
            //                  self.tblView.reloadData()
            //
            //              } else {
            //
            //                  let cell = self.tblView.cellForRow(at: IndexPath(row: self.arr1.keys.count, section: 0) ) as? BillingCell
            //                let attributeString = NSMutableAttributedString(string: abc , attributes: self.attrs)
            //                  UserDefaults.standard.set(abc, forKey: "farmValue")
            //
            //                  cell?.billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
            //                  self.tblView.reloadData()
            //
            //
            //              }
            //          }
        }
        
        
        if farmAddr.count > 0 {
            updateUI()
        }
        
        self.setTermsConditionUI()
        self.setSubmitOrderInitialUI()
        
        if UserDefaults.standard.value(forKey: "Brazil") as? String == "BR" {
            fethData = fetchAllDataOrderStatus(entityName: "ProductAdonAnimlTbLBeef", ordestatus: "false",orderId: orderId,userId:userId)
            let dataval =  fetchAllDataFarmIdStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true", orderStatus: "false",orderId:orderId,userId:userId, farmId: serchTextField.text!) as! [ProductAdonAnimlTbLBeef]
            fetchProductAdonAnimalTbl(fethData: fethData, completion: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if dataval.count > 0 {
                        for i in 0..<dataval.count{
                            self.fetchAdonData(pid: Int(dataval[i].productId), animaltag: String(dataval[i].animalTag ?? "") , index: i)
                        }
                    }
                }
            })
            
            perform(#selector(reloadTable), with: nil, afterDelay: 0.1)
        }
        else {
            fethData =  fetchAllDataFarmIdStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId, farmId: serchTextField.text!)
            let dataval : [ProductAdonAnimlTbLBeef] =  fetchAllDataFarmIdStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true", orderStatus: "false",orderId:orderId,userId:userId, farmId: serchTextField.text!) as! [ProductAdonAnimlTbLBeef]
            
            fetchProductAdonAnimalTbl(fethData: fethData, completion: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if dataval.count > 0 {
                        for i in 0..<dataval.count{
                            self.fetchAdonData(pid: Int(dataval[i].productId), animaltag: String(dataval[i].animalTag ?? "") , index: i)
                        }
                        self.reloadTable()
                    }
                }
            })
            
            perform(#selector(reloadTable), with: nil, afterDelay: 0.1)
        }
    }
  
    func crossBtn() {
    }
    
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
    @IBOutlet weak var sortByBrazilBarcodeBtn: UIButton!
    @IBOutlet weak var sortByBrazilBarcodeImgView: UIImageView!
    @IBOutlet weak var sortByAnimalIDBtn: UIButton!
    @IBOutlet weak var sortByAnimalIDImgView: UIImageView!
    @IBOutlet weak var sortByRGNBtn: UIButton!
    @IBOutlet weak var sortByRGNImgView: UIImageView!
    @IBOutlet weak var sortBySeriesImgView: UIImageView!
    @IBOutlet weak var sortBySeriesBtn: UIButton!
    @IBOutlet weak var sortByBrazilView: UIView!
    @IBOutlet weak var sortByBeefView: UIView!
    @IBOutlet weak var sortByAscendingImgView: UIImageView!
    @IBOutlet weak var sortByDescendingBtn: UIButton!
    @IBOutlet weak var sortByDescendingImgView: UIImageView!
    @IBOutlet weak var addDealerCodeImgView: UIImageView!
    @IBOutlet weak var addDealerCodeTxtField: UITextField!
    @IBOutlet weak var addDealerCodeLabel: UILabel!
    @IBOutlet weak var addDealerCodeOutlet: UIButton!
    @IBOutlet weak var addDealerCodeView: UIView!
    @IBOutlet weak var emailStackView: UIView!
    @IBOutlet weak var beefPlaceSelectionOutlet: UIButton!
    @IBOutlet weak var beefPlaceAnSelectionTitle: UILabel!
    @IBOutlet weak var beefEmailSelectionOutlet: UIButton!
    @IBOutlet weak var selectBillingContactLbl: UILabel!
    @IBOutlet weak var bilingLLbl: UILabel!
    @IBOutlet weak var agreeLl: UILabel!
    @IBOutlet weak var beefinfoBtnSelectionOutlet: UIButton!
    @IBOutlet weak var emailMeSelectionTtile: UILabel!
    @IBOutlet weak var sortByBarcodeBtn: UIButton!
    @IBOutlet weak var menuIconLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var sortByBarcodeImgView: UIImageView!
    @IBOutlet weak var sortByEarTagImgView: UIImageView!
    @IBOutlet weak var sortByEarTagBtn: UIButton!
    @IBOutlet weak var sortByView: UIView!
    @IBOutlet weak var placeAnOrderImgView: UIImageView!
    @IBOutlet weak var placeAnOutlet: UIButton!
    @IBOutlet weak var infooBtnSubmitOutlet: UIButton!
    @IBOutlet weak var placeAnotrderTitle: UILabel!
    @IBOutlet weak var infoBtnEmailOutlet: UIButton!
    @IBOutlet weak var emailMeEnterTtitle: UILabel!
    @IBOutlet weak var emailBtnImgView: UIImageView!
    @IBOutlet weak var emailCheckOutlet: UIButton!
    @IBOutlet weak var agreeInfoBtnOutelt: UIButton!
    @IBOutlet weak var agreeStackViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var AgreeBtnImgView: UIImageView!
    @IBOutlet weak var customerNameLbl: UILabel!
    @IBOutlet weak var agrreLblStackView: UIStackView!
    @IBOutlet weak var infoBtnSelectionOutlet: UIButton!
    @IBOutlet weak var submitOrderOutlet: UIButton!
    @IBOutlet weak var farmIdHideLbl: UILabel!
    @IBOutlet weak var notificationLblCount: UILabel!
    @IBOutlet weak var billingViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var farmIdDisplyOutlet: UIButton!
    @IBOutlet weak var serchTextField: UITextField!
    @IBOutlet weak var tblView:UITableView!
    @IBOutlet weak var tableViewBilling : UITableView!
    @IBOutlet weak var dropUpDownBtn: UIButton!
    @IBOutlet weak var networkStatusLbl: UILabel!
    @IBOutlet weak var networkStatusImg: UIImageView!
    @IBOutlet weak var OffLineBtn: UIButton!
    
    @IBOutlet weak var innerScrollViewHeight: NSLayoutConstraint!
    var rGN_ID = 0
    var rGD_ID = 0
    
    let buttonbg1 = UIButton ()
    var customPopView1 :TipPopUp!
    @IBOutlet weak var earTaglbl: UILabel!
    // @IBOutlet weak var billingContactLbl: UILabel!
    @IBOutlet weak var animalLbl: UILabel!
    @IBOutlet weak var appStatusLbl: UILabel!
    @IBOutlet weak var productLbl: UILabel!
    @IBOutlet weak var reviewOrderLbl: UILabel!
    @IBOutlet weak var sortBtLbl: UILabel!
    @IBOutlet weak var appHelpBtn: UIButton!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var billingView: UIView!
    weak var delegateCustom : objectPickfromConfilict?
    weak var dismissDelegate : DismissConflictPopUp?
    var attrs : [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 12),
        .foregroundColor: UIColor.blue,
        .underlineStyle: NSUnderlineStyle.single.rawValue]
    let dropDown = DropDown()
    var arr1 = [String:[ProductAdonAnimlTbLBeef]]()
    var values = [String]()
    var farmID = [String]()
    var barCode = [String]()
    var serieArr = [String]()
    var rgdArr = [String]()
    var rgnArr = [String]()
    var selection = [[String:Any]]()
    var aTag:String!
    var pid = Int()
    var fethData:NSArray!
    var farmId = Int()
    var barCodeId = Int()
    var animaId = Int()
    var clickOnDropDown = String()
    var isBillingContact = true
    var ascendingFound = true
    // networkCheck
    var indexOfSelection:[IndexPath?] = [IndexPath]()
    var collViewOfselection:[UICollectionView?] = [UICollectionView]()
    var billingdelegateVC = BillingTableViewDelegate()
    var farmAddr = [GetBillingContact]()
    var custmerId = UserDefaults.standard.value(forKey: "currentActiveCustomerId") as! Int
    var userId = Int()
    var orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
    var langId = UserDefaults.standard.value(forKey: "lngId") as? Int
    var heartBeatViewModel:HeartBeatViewModel?
    let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
    func navigateToAnotherVc(){
    }
    func dataReload(check :Bool){
        let storyBoard: UIStoryboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "BeefOPSSelectionReviewIPadVC") as! BeefOPSSelectionReviewIPadVC
        self.navigationController?.pushViewController(newViewController, animated: false)
        
    }
    func firstLevel(check: Bool) {
        
        let currentCustomerId = UserDefaults.standard.value(forKey: "currentActiveCustomerId") as? Int
        
        let pviduser = (UserDefaults.standard.integer(forKey:"BeefPvid") as? Int)!
        
        let fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: "BeefAnimaladdTbl",orderId:orderId,userId:userId,customerId:currentCustomerId ?? 0,date:"")
        
        if fetchAnimalTbl.count != 0 {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BeefConfilictOrdersViewController") as! BeefConfilictOrdersViewController
            vc.delegateCustom1 = self
            vc.screenName = "beefproductSelectionReview"
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
            
        }}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSideMenu()
        farmAddr = fetchBillingCustomer(entityName: "GetBillingContact",customerID: self.custmerId) as! [GetBillingContact]
        UserDefaults.standard.set(1, forKey: "orderIdBeef")
        heartBeatViewModel = HeartBeatViewModel(callBack: navigateToAnotherVc)
        heartBeatViewModel?.callGetHearBeatData()
        
        let userId = UserDefaults.standard.integer(forKey: "userId")
        //let orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
        landIdApplangaugeConversion()
        
        initialNetworkCheck()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        transparentView.isHidden = true
        billingView.isHidden = true
        if UserDefaults.standard.value(forKey: "Brazil") as? String == "BR" {
            fethData = fetchAllDataOrderStatus(entityName: "ProductAdonAnimlTbLBeef", ordestatus: "false",orderId: orderId,userId:userId)
            let dataval =  fetchAllDataFarmIdStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true", orderStatus: "false",orderId:orderId,userId:userId, farmId: serchTextField.text!) as! [ProductAdonAnimlTbLBeef]
            fetchProductAdonAnimalTbl(fethData: fethData, completion: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if dataval.count > 0 {
                        for i in 0..<dataval.count{
                            self.fetchAdonData(pid: Int(dataval[i].productId), animaltag: String(dataval[i].animalTag ?? "") , index: i)
                        }
                    }
                }
            })
            
            perform(#selector(reloadTable), with: nil, afterDelay: 0.1)
        }
        else {
            fethData =  fetchAllDataFarmIdStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId, farmId: serchTextField.text!)
            let dataval : [ProductAdonAnimlTbLBeef] =  fetchAllDataFarmIdStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true", orderStatus: "false",orderId:orderId,userId:userId, farmId: serchTextField.text!) as! [ProductAdonAnimlTbLBeef]
            
            fetchProductAdonAnimalTbl(fethData: fethData, completion: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if dataval.count > 0 {
                        for i in 0..<dataval.count{
                            self.fetchAdonData(pid: Int(dataval[i].productId), animaltag: String(dataval[i].animalTag ?? "") , index: i)
                        }
                        self.reloadTable()
                    }
                }
            })
            
            perform(#selector(reloadTable), with: nil, afterDelay: 0.1)
        }
    }
    func landIdApplangaugeConversion(){
        
        
        //    animalLbl.text = NSLocalizedString("Animal", comment: "")
        //    appStatusLbl.text = NSLocalizedString("App Status:", comment: "")
        //    productLbl.text = NSLocalizedString("Product", comment: "")
        //   reviewOrderLbl.text = NSLocalizedString("Review Order", comment: "")
        //   sortBtLbl.text = NSLocalizedString("Sort By:", comment: "")
        
        serchTextField.placeholder = NSLocalizedString("Search", comment: "")
        
        
        //   selectBillingContactLbl.text = NSLocalizedString("Select Billing Contact", comment: "")
        
        
    }
    
    
    @IBAction func emailMeEnteredDataAction(_ sender: Any) {
        
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
        UserDefaults.standard.set(true, forKey: "SubmitBtnFlag")
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
    
    @IBAction func emailMeInfoAction(_ sender: UIButton) {
        
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
        customPopView1.frame = CGRect(x: 125,y: p.origin.y + 42   ,width: 250, height: 125)
        
        customPopView1.delegate = self
        customPopView1.layer.borderColor = UIColor.blue.cgColor
        customPopView1.layer.borderWidth = 1
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1.addSubview(customPopView1)
        
        if langId == 1 {
            customPopView1.arrow_Top.frame = CGRect(x: 180 , y: -22, width: 26, height: 26)
        } else {
            customPopView1.arrow_Top.frame = CGRect(x: 244 , y: -22, width: 26, height: 26)
        }
        
        customPopView1.textLabel1.text =  NSLocalizedString("This will email me with the animals, samples and product information I have entered. I can finish the order on my computer and email to Zoetis Genetics.", comment: "")
    }
    
    @objc func buttonbgPressedTip1 (){
        buttonbg1.removeFromSuperview()
        customPopView1.removeFromSuperview()
    }
    
    @IBAction func termsInfoBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "iPad", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductWiseTermsController") as! ProductWiseTermsController
        self.navigationController?.present(vc, animated: false, completion: nil)
        return
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
        customPopView1.frame = CGRect(x: p.origin.x - 150,y: p.origin.y + 42   ,width: 200, height: 100)
        
        customPopView1.delegate = self
        customPopView1.layer.borderColor = UIColor.blue.cgColor
        customPopView1.layer.borderWidth = 1
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1.addSubview(customPopView1)
        if langId == 1 {
            customPopView1.arrow_Top.frame = CGRect(x: 133 , y: -22, width: 26, height: 26)
        } else {
            customPopView1.arrow_Top.frame = CGRect(x: 150 , y: -22, width: 26, height: 26)
        }
        customPopView1.textLabel1.text =  NSLocalizedString("Submit is only available if all fields are filled out for each animal submitted.", comment: "")
    }
    
    @objc func buttonbgPressedTip12 (){
        buttonbg1.removeFromSuperview()
        customPopView1.removeFromSuperview()
    }
    
    @IBAction func backBtnClk(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
    }
    
    private func fetchProductAdonAnimalTbl(fethData:NSArray,completion: @escaping ()->()){
        values.removeAll()
        barCode.removeAll()
        farmID.removeAll()
        arr1.removeAll()
        serieArr.removeAll()
        rgdArr.removeAll()
        rgnArr.removeAll()
        for value in fethData{
            if let item = value as? ProductAdonAnimlTbLBeef{
                // fetchAdonData(pid: Int(item.productId), animaltag: item.animalTag!)
                if values.contains(item.animalTag ?? ""){
                    arr1[item.animalTag ?? ""]?.append(item)
                } else {
                    values.append(item.animalTag ?? "")
                    farmID.append(item.farmId ?? "")
                    barCode.append(item.animalbarCodeTag ?? "")
                    serieArr.append(item.animalbarCodeTag ?? "")
                    rgnArr.append(item.rgn ?? "")
                    rgdArr.append(item.rgd ?? "")
                    arr1[item.animalTag ?? ""] = [ProductAdonAnimlTbLBeef]()
                    arr1[item.animalTag ?? ""]?.append(item)
                }
            }
        }
        reloadTable()
        completion()
        
    }
    func fetchAdonData(pid:Int, animaltag:String, index:Int) {
        let data = fetchSubProductDataTrueBeef(entityName:"SubProductTblBeef",productId: Int(pid),animalTag: animaltag, status: "true",orderId:orderId,userId:userId) as! [SubProductTblBeef]
        var found = false
        
        for i in 0..<selection.count{
            if let value = (selection[i]["animalTag"]) as? String, value  == animaltag{
                selection[i]["animalTag"] = animaltag
                selection[i]["addon"] = data
                selection[i]["row"] = index
                found = true
                break
            }
        }
        if found ==  false && data.count > 0{
            selection.append (["animalTag":animaltag,"addon":data,"row":index])
        }
        
        
        reloadTable()
        
        
    }
    func fetchAdonData(indexPath:IndexPath, collectionView:UICollectionView)
    {
        
        pid =  Int(arr1[values[collectionView.tag]]![indexPath.row].productId)
        aTag = arr1[values[collectionView.tag]]![indexPath.row].animalTag
        let data = fetchSubProductDataTrueBeef(entityName:"SubProductTblBeef",productId: Int(pid),animalTag: aTag!, status: "true",orderId:orderId,userId:userId) as? [SubProductTblBeef]
        var found = false
        
        for i in 0..<selection.count{
            if let value = selection[i]["animalTag"] as? String, value  == aTag{
                selection[i]["animalTag"] = aTag
                selection[i]["addon"] = data
                selection[i]["row"] = collectionView.tag
                found = true
                break
            }
        }
        if found ==  false && data!.count > 0{
            selection.append (["animalTag":aTag,"addon":data,"row":collectionView.tag])
            
        }
        
        reloadTable()
        
    }
    @objc func reloadTable(){
        tblView.delegate = self
        tblView.dataSource = self
        tblView.reloadData()
        
    }
    
    @IBAction func billingClick(_ sender: UIButton) {
        transparentView.isHidden = false
        billingView.isHidden = false
        isBillingContact = false
        // billingViewHeightConst.constant = tableViewBilling.contentSize.height + 100
        tableViewBilling.reloadData()
        
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
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.userId = UserDefaults.standard.integer(forKey: "userId")
        self.orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
        
        tableViewBilling.delegate = billingdelegateVC
        tableViewBilling.dataSource = billingdelegateVC
        tableViewBilling.reloadData()
        billingdelegateVC.delegate = self
        
        //      if pvid == 13 {
        //        appHelpBtn.isHidden = false
        //      } else {
        //        appHelpBtn.isHidden = true
        //      }
        
        let animaltbl = fetchRemaningSubmitOrder(entityName: "BeefAnimaladdTbl", isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
        
        for i in 0..<animaltbl.count{
            let data = animaltbl.object(at: i) as! BeefAnimaladdTbl
            deleteRemaningSubmitOrderReview(entityName: "ProductAdonAnimlTbLBeef", isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId, aid: Int(data.animalId))
            deleteRemaningSubmitOrderReview(entityName: "SubProductTblBeef", isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId,aid: Int(data.animalId))
        }
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        deleteRemaningSubmitOrder(entityName: "BeefAnimaladdTbl", isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
        
        if pvid == 5 {
            self.earTaglbl.text = "Ear Tag"
        } else {
            self.earTaglbl.text = "Unique ID"
        }
        if  UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == nil {
            UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
            if pvid == 13 {
                self.clickOnDropDown = "Unique ID".localized
            }
            if pvid == 7{
                self.clickOnDropDown = NSLocalizedString("Animal Tag", comment: "")
            }
            if pvid == 5{
                self.clickOnDropDown = NSLocalizedString("Ear Tag", comment: "")
            }
            if pvid == 6{
                self.clickOnDropDown = NSLocalizedString("Barcode", comment: "")
                self.sortBySeriesImgView.image = UIImage(named: "radioBtn")
                self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
                self.sortByRGNImgView.image = UIImage(named: "radioBtn")
                self.sortByAnimalIDImgView.image = UIImage(named: "radioBtn")
            }
            //self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            self.sortByEarTagImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
            
            fethData =   fetchAllDataanimalTagStatus(entityName: "ProductAdonAnimlTbLBeef",asending : true,status: "true", orderStatus: "false", animalTag: serchTextField.text!)
        }
        
        if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "officialid" {
            UserDefaults.standard.set(true, forKey: "brazilBarcode")
            if pvid == 13 {
                self.clickOnDropDown = "Unique ID".localized
            }
            if pvid == 7 {
                self.clickOnDropDown = NSLocalizedString("Animal Tag", comment: "")
            }
            if pvid == 5{
                self.clickOnDropDown = NSLocalizedString("Ear Tag", comment: "")
            }
            if pvid == 6{
                self.clickOnDropDown = NSLocalizedString("Barcode", comment: "")
                self.sortBySeriesImgView.image = UIImage(named: "radioBtn")
                self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
                self.sortByRGNImgView.image = UIImage(named: "radioBtn")
                self.sortByAnimalIDImgView.image = UIImage(named: "radioBtn")
            }
            //  self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            self.fethData =  fetchAllDataanimalTagStatus(entityName: "ProductAdonAnimlTbLBeef",asending : true,status: "true", orderStatus: "false", animalTag: serchTextField.text!)
            
            self.sortByEarTagImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
        }
        if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "barcode" || UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "Barcode"{
            if pvid == 5 || pvid == 7{
                var selected = UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC")
                if selected == "barcode" {
                    selected = "Barcode"
                }
                self.clickOnDropDown = NSLocalizedString(selected ?? "Ear Tag", comment: "")
                
                self.sortByEarTagImgView.image = UIImage(named: "radioBtn")
                self.sortByBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
            }
            if pvid == 6{
                UserDefaults.standard.set(false, forKey: "brazilBarcode")
                UserDefaults.standard.set(true, forKey: "series")
                self.clickOnDropDown =  NSLocalizedString("Series", comment: "")
                self.sortBySeriesImgView.image = UIImage(named: "radioBtn")
                self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
                self.sortByRGNImgView.image = UIImage(named: "radioBtn")
                self.sortByAnimalIDImgView.image = UIImage(named: "radioBtn")
            }
            if pvid == 13{
                
                self.clickOnDropDown = "Unique ID".localized
                
                self.sortByEarTagImgView.image = UIImage(named: "radioBtn")
                self.sortByBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
            }
            //  self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            self.fethData =  fetchAllDataBarcOdeStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true,status: "true", orderStatus: "false", barcode: serchTextField.text!)
        }
        if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "rgn" {
            self.clickOnDropDown =  NSLocalizedString("RGN", comment: "")
            // self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            self.sortBySeriesImgView.image = UIImage(named: "radioBtn")
            self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
            self.sortByRGNImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByAnimalIDImgView.image = UIImage(named: "radioBtn")
            self.fethData =  fetchAllDataRGNStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
            
        }
        if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "rgd" {
            self.clickOnDropDown =  NSLocalizedString("RGD or Animal ID", comment: "")
            //      self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            self.sortBySeriesImgView.image = UIImage(named: "radioBtn")
            self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
            self.sortByRGNImgView.image = UIImage(named: "radioBtn")
            self.sortByAnimalIDImgView.image = UIImage(named: "radioSeletedBtn")
            self.fethData =  fetchAllDataRGDStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
        }
        
        if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "Series" {
            
            self.clickOnDropDown =  NSLocalizedString("Series", comment: "")
            //  self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            self.sortBySeriesImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
            self.sortByRGNImgView.image = UIImage(named: "radioBtn")
            self.sortByAnimalIDImgView.image = UIImage(named: "radioBtn")
            self.fethData =  fetchAllDataRGDStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
            
            
        }
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
        
        notificationLblCount.text = String(animalCount.count)
        
        if farmAddr.count > 0  {
            var abc = ""
            let filterArr = farmAddr.filter({$0.isDefault == true })
            if filterArr.count > 0{
                abc = filterArr[0].contactName ?? ""
            } else{
                
                let billArray =  farmAddr.filter({Int($0.billToCustId!) == self.custmerId})
                abc = billArray[0].contactName ?? ""
                UserDefaults.standard.set(billArray[0].billToCustId, forKey: "billToCustomerId")
            }
            customerNameLbl.text = abc
            //          DispatchQueue.main.async {
            //              if let cell = self.tblView.cellForRow(at: IndexPath(row: self.arr1.keys.count, section: 0) ) as? BillingCell{
            //                let attributeString = NSMutableAttributedString(string: abc , attributes: self.attrs)
            //                  UserDefaults.standard.set(abc, forKey: "farmValue")
            //
            //                  cell.billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
            //                  self.tblView.reloadData()
            //
            //              } else {
            //
            //                  let cell = self.tblView.cellForRow(at: IndexPath(row: self.arr1.keys.count, section: 0) ) as? BillingCell
            //                let attributeString = NSMutableAttributedString(string: abc , attributes: self.attrs)
            //                  UserDefaults.standard.set(abc, forKey: "farmValue")
            //
            //                  cell?.billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
            //                  self.tblView.reloadData()
            //
            //
            //              }
            //          }
        }
        
        
        if farmAddr.count > 0 {
            updateUI()
        }
        
        self.setTermsConditionUI()
        self.setSubmitOrderInitialUI()
        
    }
    
    @IBAction func crossClick(_ sender: UIButton) {
        transparentView.isHidden = true
        billingView.isHidden = true
    }
    
    @IBAction func sortByCrossBtn(_ sender: Any) {
        
        sortByView.isHidden = true
        transparentView.isHidden = true
    }
    
    @IBAction func viewAnimalClick(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "BeefPlaceAnOrder", bundle: Bundle.main).instantiateViewController(withIdentifier: "BeefViewAnimalVCiPad") as? BeefViewAnimalVCiPad
        vc!.screenBackSave = true
        vc!.productBackSave = false
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    var pricingLinkC = String()
    @IBAction func menuBtnClk(_ sender: UIButton) {
        self.sideMenuRevealSettingsViewController()?.revealSideMenu()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewBilling {
            return farmAddr.count
        }
        if arr1.count == 0 {
            return 1
        }
        return arr1.keys.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if arr1.count == 0 {
            let cell = UITableViewCell()
            let label = UILabel(frame: CGRect(x: tableView.frame.width/2 - 100, y: 80, width: 200, height: 21))
            label.textAlignment = .center
            label.text = "No Records Found"
            label.font = UIFont(name: "TrebuchetMS", size: 22)
            cell.contentView.addSubview(label)
            return cell
        } else {
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "OPSTableViewCell", for: indexPath) as! OPSTableViewCell
            let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
            if pvid == 13 {
                cell.barcodeTitle.text = NSLocalizedString("Barcode", comment: "")
                cell.earTagTtitle.text = NSLocalizedString("Unique ID", comment: "")
                
            } else {
                cell.barcodeTitle.text = NSLocalizedString("Barcode", comment: "")
                cell.earTagTtitle.text = NSLocalizedString("Ear Tag", comment: "")
            }
            
            if pvid == 5 || pvid == 13 {
                
                cell.OfficialId.text =  String(values[indexPath.row])
                cell.Barcode.text =  String(barCode[indexPath.row])
                //  cell.earTagTtitle.isHidden = true
                cell.farmIdTitle.isHidden = true
                cell.OnFarmId.isHidden = true
                cell.rgdOrAnimalID.isHidden = true
                cell.rgdLbl.isHidden = true
                cell.vollView.tag = indexPath.row
                
                if selection.count > 0 {
                    cell.vollView.isHidden = false
                } else {
                    cell.vollView.isHidden = true
                }
                
                cell.productTitle.text = arr1[values[indexPath.row]]?[0].productName ?? ""
            }
            
            if pvid == 6 {
                //         //   cell.farmidHeight.constant = 9
                //         //   cell.farmidTitleBottom.constant = 10
                //            cell.farmIdTitle.text = NSLocalizedString("Barcode", comment: "")
                //            cell.OnFarmId.text =  String(values[indexPath.row])
                //            cell.earTagTtitle.text = NSLocalizedString("Series", comment: "")
                //            cell.OfficialId.text =  String(serieArr[indexPath.row])
                //            cell.barcodeTitle.text = NSLocalizedString("RGN", comment: "")
                //            cell.Barcode.text =  String(rgnArr[indexPath.row])
                //
                //            cell.rgdLbl.text = String(rgdArr[indexPath.row])
                //            cell.vollView.tag = indexPath.row
                ////            cell.deleteBttn.tag = indexPath.row
                ////            cell.deleteBttn.addTarget(nil, action: #selector(deleteButton(_:)), for: .touchUpInside)
                // cell.rgdOrAnimalID.text = NSLocalizedString("RGD or Animal ID", comment: "")
                
                //     cell.farmidTitleBottom.constant = 10
                //      cell.farmIdTitle.text = NSLocalizedString("Barcode", comment: "")
                //   cell.farmIdColonHeight.constant = 12
                cell.Barcode.text =  String(values[indexPath.row])
                cell.earTagTtitle.text = NSLocalizedString("Series", comment: "")
                if String(serieArr[indexPath.row]) != ""{
                    cell.OfficialId.text = String(serieArr[indexPath.row])
                } else {
                    cell.OfficialId.text = "N/A"
                    // Or any default placeholder
                }
                // cell.OfficialId.text =  String(serieArr[indexPath.row])
                cell.farmIdTitle.text = NSLocalizedString("RGN", comment: "")
                if String(rgnArr[indexPath.row]) != ""{
                    cell.OnFarmId.text = String(rgnArr[indexPath.row])
                } else {
                    cell.OnFarmId.text = "N/A"
                    // Or any default placeholder
                }
                //    cell.OnFarmId.text =  String(rgnArr[indexPath.row])
                // cell.rgdColonheight.constant = 12
                //  cell.rgdTitleHeight.constant = 20
                if String(rgdArr[indexPath.row]) != ""{
                    cell.rgdOrAnimalID.text = String(rgdArr[indexPath.row])
                } else {
                    cell.rgdOrAnimalID.text = "N/A"
                    // Or any default placeholder
                }
                cell.vollView.tag = indexPath.row
                //                cell.deleteBttn.tag = indexPath.row
                //                cell.deleteBttn.addTarget(nil, action: #selector(deleteButton(_:)), for: .touchUpInside)
                
                // cell.rgdOrAnimalId.text = NSLocalizedString("RGD or Animal ID" , comment: "")
                cell.rgdLbl.text = NSLocalizedString("RGD or Animal ID" , comment: "")
                cell.productTitle.text = arr1[values[indexPath.row]]?[0].productName ?? ""
                
                if arr1[values[indexPath.row]]?.count == 2 {
                    cell.productTitleSecond.isHidden = false
                    cell.productTitleSecond.text = arr1[values[indexPath.row]]?[1].productName ?? ""
                }
                else if arr1[values[indexPath.row]]?.count == 3 {
                    cell.productTitleSecond.isHidden = false
                    cell.productTitleSecond.text = arr1[values[indexPath.row]]?[1].productName ?? ""
                    cell.productTitleThird.isHidden = false
                    cell.productTitleThird.text = arr1[values[indexPath.row]]?[2].productName ?? ""
                }
                else if arr1[values[indexPath.row]]?.count == 4 {
                    cell.productTitleSecond.isHidden = false
                    cell.productTitleSecond.text = arr1[values[indexPath.row]]?[1].productName ?? ""
                    cell.productTitleThird.isHidden = false
                    cell.productTitleThird.text = arr1[values[indexPath.row]]?[2].productName ?? ""
                    cell.productTitleFourth.isHidden = false
                    cell.productTitleFourth.text = arr1[values[indexPath.row]]?[3].productName ?? ""
                }
                
                if selection.count > 0 {
                    cell.vollView.isHidden = false
                } else {
                    cell.vollView.isHidden = true
                }
            }
            if pvid == 7 {
                cell.earTagTtitle.text = NSLocalizedString("Animal Tag/Tattoo", comment: "")
                cell.OfficialId.text =  String(values[indexPath.row])
                cell.Barcode.text =  String(barCode[indexPath.row])
                cell.vollView.tag = indexPath.row
                cell.deleteBttn.tag = indexPath.row
                cell.farmidHeight.constant = 0
                cell.farmidTitleBottom.constant = 25
                cell.deleteBttn.addTarget(nil, action: #selector(deleteButton(_:)), for: .touchUpInside)
            }
            cell.vollView.reloadData()
            return cell
        }
    }
    @objc func deleteButton(_ sender : UIButton){
        let animalId = (String(values[sender.tag]))
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "1"{
            
            let url =  NSURL(string: pricingLinkC ?? "") as! URL
            UIApplication.shared.open(url) { (Bool) in
                
            }
        }
        return true
    }
    
    @IBAction func dropAction(_ sender: UIButton) {
        
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        if pvid == 5 || pvid == 7 ||  pvid == 13{
            if self.clickOnDropDown == NSLocalizedString("Ear Tag", comment: "") || self.clickOnDropDown == NSLocalizedString("Official ID", comment: "") || self.clickOnDropDown == "Animal Tag".localized || self.clickOnDropDown == "Unique ID".localized
            {
                if self.animaId == 0{
                    dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                    
                    self.fethData =  fetchAllDataanimalTagStatus(entityName: "ProductAdonAnimlTbLBeef",asending : true,status: "true", orderStatus: "false", animalTag: serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                    self.animaId = 1
                }
                else{
                    dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                    
                    self.fethData =  fetchAllDataanimalTagStatus(entityName: "ProductAdonAnimlTbLBeef", asending: false,status: "true", orderStatus: "false", animalTag: serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                    self.animaId = 0
                }
            }
            else{
                if self.barCodeId == 0{
                    dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                    
                    self.fethData =  fetchAllDataBarcOdeStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true,status: "true", orderStatus: "false", barcode: serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                    self.barCodeId = 1
                }
                else {
                    dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                    
                    self.fethData =  fetchAllDataBarcOdeStatus(entityName: "ProductAdonAnimlTbLBeef", asending: false,status: "true", orderStatus: "false", barcode: serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                    self.barCodeId = 0
                }
                
            }
        }
        else {
            
            if self.clickOnDropDown == NSLocalizedString("Barcode", comment: ""){
                
                if self.animaId == 0{
                    self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                    
                    self.fethData =  fetchAllDataanimalTagStatus(entityName: "ProductAdonAnimlTbLBeef",asending : true,status: "true", orderStatus: "false", animalTag: self.serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                    self.animaId = 1
                }
                else {
                    self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                    
                    self.fethData =  fetchAllDataanimalTagStatus(entityName: "ProductAdonAnimlTbLBeef", asending: false,status: "true", orderStatus: "false", animalTag: self.serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                    self.animaId = 0
                }
                
            }
            if self.clickOnDropDown == NSLocalizedString("Series", comment: ""){
                
                if self.barCodeId == 0{
                    self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                    
                    self.fethData =  fetchAllDataBarcOdeStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                    self.barCodeId = 1
                }
                else {
                    self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                    
                    self.fethData =  fetchAllDataBarcOdeStatus(entityName: "ProductAdonAnimlTbLBeef", asending: false,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                    self.barCodeId = 0
                }
                
            }
            if self.clickOnDropDown == NSLocalizedString("RGN", comment: ""){
                
                if self.rGN_ID == 0{
                    self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                    
                    self.fethData =  fetchAllDataRGNStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                    self.rGN_ID = 1
                }
                else{
                    self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                    
                    self.fethData =  fetchAllDataRGNStatus(entityName: "ProductAdonAnimlTbLBeef", asending: false,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                    self.rGN_ID = 0
                }
                
            }
            
            if self.clickOnDropDown == NSLocalizedString("RGD", comment: "") || self.clickOnDropDown == NSLocalizedString("RGD or Animal ID", comment: ""){
                
                if self.rGD_ID == 0{
                    self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                    
                    self.fethData =  fetchAllDataRGDStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                    self.rGD_ID = 1
                }
                else{
                    self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                    
                    self.fethData =  fetchAllDataRGDStatus(entityName: "ProductAdonAnimlTbLBeef", asending: false,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                    self.rGD_ID = 0
                }
                
            }
            
        }
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let currentString: NSString = serchTextField.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        tblView.isHidden = false
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        if newString != ""{
            
            if pvid == 5 || pvid == 7 || pvid == 13 {
                if self.clickOnDropDown == NSLocalizedString("Ear Tag", comment: "")  || self.clickOnDropDown == NSLocalizedString("Official ID", comment: "") || self.clickOnDropDown == "Animal Tag" || self.clickOnDropDown == "Unique ID".localized{
                    let bPredicate: NSPredicate = NSPredicate(format: "farmId contains[cd] %@ || animalbarCodeTag contains[cd] %@ || animalTag contains[cd] %@ || productName contains[cd] %@", newString,newString,newString,newString)
                    
                    let fetchcustRep = fetchAllDataanimalTagStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true", orderStatus: "false",animalTag: newString as String).filtered(using: bPredicate) as NSArray
                    if fetchcustRep.count > 0 {
                        fetchProductAdonAnimalTbl(fethData: fetchcustRep, completion: {})
                    }
                    else{
                        // tblView.isHidden = true
                        arr1.removeAll()
                        reloadTable()
                        self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 1, position: .center)
                    }
                }
                if self.clickOnDropDown == NSLocalizedString("Barcode", comment: ""){
                    let bPredicate: NSPredicate = NSPredicate(format: "farmId contains[cd] %@ || animalbarCodeTag contains[cd] %@ || animalTag contains[cd] %@ || productName contains[cd] %@", newString,newString,newString,newString)
                    
                    let fetchcustRep = fetchAllDataBarcOdeStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true", orderStatus: "false", barcode: newString as String).filtered(using: bPredicate) as NSArray
                    if fetchcustRep.count > 0 {
                        fetchProductAdonAnimalTbl(fethData: fetchcustRep, completion: {})
                    }
                    else{
                        // tblView.isHidden = true
                        arr1.removeAll()
                        reloadTable()
                        self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 1, position: .center)
                    }
                }
            }
            else{
                
                if self.clickOnDropDown == NSLocalizedString("Barcode", comment: ""){
                    let bPredicate: NSPredicate = NSPredicate(format: "rgn contains[cd] %@ || animalbarCodeTag contains[cd] %@ || animalTag contains[cd] %@ || rgd contains[cd] %@ || productName contains[cd] %@", newString,newString,newString,newString,newString)
                    
                    let fetchcustRep = fetchAllDataanimalTagStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true", orderStatus: "false",animalTag: newString as String).filtered(using: bPredicate) as NSArray
                    if fetchcustRep.count > 0 {
                        fetchProductAdonAnimalTbl(fethData: fetchcustRep, completion: {})
                    }
                    else{
                        // tblView.isHidden = true
                        arr1.removeAll()
                        reloadTable()
                        self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 1, position: .center)
                    }
                }
                
                if self.clickOnDropDown == NSLocalizedString("Series", comment: ""){
                    let bPredicate: NSPredicate = NSPredicate(format: "rgn contains[cd] %@ || animalbarCodeTag contains[cd] %@ || animalTag contains[cd] %@ || rgd contains[cd] %@ || productName contains[cd] %@", newString,newString,newString,newString,newString)
                    
                    let fetchcustRep = fetchAllDataBarcOdeStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true", orderStatus: "false", barcode: newString as String).filtered(using: bPredicate) as NSArray
                    if fetchcustRep.count > 0 {
                        fetchProductAdonAnimalTbl(fethData: fetchcustRep, completion: {})
                    }
                    else{
                        // tblView.isHidden = true
                        arr1.removeAll()
                        reloadTable()
                        self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 1, position: .center)
                    }
                }
                
                if self.clickOnDropDown == NSLocalizedString("RGN", comment: ""){
                    let bPredicate: NSPredicate = NSPredicate(format: "rgn contains[cd] %@ || animalbarCodeTag contains[cd] %@ || animalTag contains[cd] %@ || rgd contains[cd] %@ || productName contains[cd] %@", newString,newString,newString,newString,newString)
                    
                    let fetchcustRep = fetchAllDataRGNStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true", orderStatus: "false", barcode: newString as String).filtered(using: bPredicate) as NSArray
                    if fetchcustRep.count > 0 {
                        fetchProductAdonAnimalTbl(fethData: fetchcustRep, completion: {})
                    }
                    else{
                        // tblView.isHidden = true
                        arr1.removeAll()
                        reloadTable()
                        self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 1, position: .center)
                    }
                }
                
                if self.clickOnDropDown == NSLocalizedString("RGD", comment: "") || self.clickOnDropDown == NSLocalizedString("RGD or Animal ID", comment: ""){
                    let bPredicate: NSPredicate = NSPredicate(format: "rgn contains[cd] %@ || animalbarCodeTag contains[cd] %@ || animalTag contains[cd] %@ || rgd contains[cd] %@ || productName contains[cd] %@", newString,newString,newString,newString,newString)
                    
                    let fetchcustRep = fetchAllDataRGDStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true", orderStatus: "false", barcode: newString as String).filtered(using: bPredicate) as NSArray
                    if fetchcustRep.count > 0 {
                        fetchProductAdonAnimalTbl(fethData: fetchcustRep, completion: {})
                    }
                    else{
                        // tblView.isHidden = true
                        arr1.removeAll()
                        reloadTable()
                        self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 1, position: .center)
                    }
                }
            }
        }else{
            //   self.dropUpDownBtn.setImage(UIImage(named: "Image"), for: .normal)
            
            if UserDefaults.standard.value(forKey: "Brazil") as? String == "BR" {
                fethData = fetchAllDataOrderStatus(entityName: "ProductAdonAnimlTbLBeef", ordestatus: "false",orderId: orderId,userId:userId)
                let dataval =  fetchAllDataFarmIdStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true", orderStatus: "false",orderId:orderId,userId:userId, farmId: serchTextField.text!)
                fetchProductAdonAnimalTbl(fethData: fethData, completion: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        if dataval.count > 0 {
                            for i in 0..<self.indexOfSelection.count{
                                if let index = self.indexOfSelection[i], let collView = self.collViewOfselection[i]{
                                    self.fetchAdonData(indexPath: index, collectionView: collView)
                                }
                            }
                        }
                    }
                })
                
                perform(#selector(reloadTable), with: nil, afterDelay: 0.1)
            }
            else {
                fethData = fetchAllDataFarmIdStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true", orderStatus: "false",orderId: orderId,userId:userId, farmId: newString as String)
                fetchProductAdonAnimalTbl(fethData: fethData, completion: {})
            }
            if let char = string.cString(using: String.Encoding.utf8) {
                let isBackSpace = strcmp(char, "\\b")
                if (isBackSpace == -92) {
                    if textField.text?.count == 1{
                        
                        
                    }
                }
            }
            
            reloadTable()
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //        fethData =   fetchAllDataFarmIdStatus(entityName: "ProductAdonAnimalTbl", asending: true, status: "true", orderStatus: "false")
        //        fetchProductAdonAnimalTbl(fethData: fethData, completion: {})
        textField.resignFirstResponder()
        
        return true
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == arr1.keys.count{
            
            if arr1.count == 0 {
                return 200
            }
            
            if UserDefaults.standard.value(forKey: "name") as! String  == "Beef"{
                return 350
                // return 250
                
            } else {
                if UserDefaults.standard.string(forKey: "providerNameUS") != "CLARIFIDE CDCB (US)" {
                    return 250
                    
                } else{
                    return 250
                }
                
            }
            
        }
        
        
        
        var addon = 0
        var data = [String:Any]()
        for value in selection{
            if (value["animalTag"] as! String) == String(values[indexPath.row]){
                data = value
            }
        }
        if let item = data["animalTag"] as? String{
            if values[indexPath.row] == item{
                let data = data["addon"] as? [SubProductTblBeef]
                
                var quo = data!.count/2
                let rem = data!.count % 2
                let val = quo * 40 * rem
                if quo == 0 && rem == 1{
                    quo = 1
                }
                
                
                if data!.count > 0 {
                    addon = 110
                    
                }else{
                    addon = -40
                }
            }else{
                addon = -40
            }
        }else{
            addon = -40
        }
        let count = (arr1[values[indexPath.row]]!.count)/2 + 1
        if selection.count > 0 {
            return 40 * CGFloat(count) + 90 + CGFloat(count*20) + CGFloat(addon + 100)
        }
        if pvid == 5 {
            return 40 * CGFloat(count) + 90 + CGFloat(count*20) + CGFloat(addon + 100)
            
        }
        if pvid == 6 && count == 1 {
            return 40 * CGFloat(count) + 90 + CGFloat(count*20) + CGFloat(addon + 100)
        } else {
            return 40 * CGFloat(count) + 90 + CGFloat(count*20) + CGFloat(addon + 50)
        }
        return 40 * CGFloat(count) + 90 + CGFloat(count*20) + CGFloat(addon + 50)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //   if section == 1{
        var data = [String:Any]()
        for value in selection{
            if (value["animalTag"] as! String) == String(values[collectionView.tag]){
                data = value
            }
        }
        if let item  = data["animalTag"] as? String{
            if values[collectionView.tag] == item{
                return (data["addon"] as! NSArray).count
            }else{
                return 0
            }
        }
        else{
            return 0
        }
        //  }
        //        else{
        //            return arr1[values[section]]!.count
        //        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //        if indexPath.section == 0{
        //            let item = collectionView.dequeueReusableCell(withReuseIdentifier: "OPSCollectionViewCell", for: indexPath)  as! OPSCollectionViewCell
        //            item.lbl.text = arr1[values[collectionView.tag]]![indexPath.row].productName!
        //          item.layer.masksToBounds = true
        //          item.layoutIfNeeded()
        //          item.lbl.layoutIfNeeded()
        //          item.lbl.layer.masksToBounds = true
        //            item.lbl.layer.borderColor = UIColor.lightGray.cgColor
        //            if arr1[values[collectionView.tag]]![indexPath.row].status! == "true"{
        //                collViewOfselection.append(collectionView)
        //                indexOfSelection.append(indexPath)
        //                item.lbl.backgroundColor = UIColor(red: 220/255, green: 54/255, blue: 72/255, alpha: 1)
        //                item.lbl.textColor = UIColor.white
        //            }else{
        //                item.lbl.backgroundColor = UIColor.white
        //                item.lbl.textColor = UIColor.black
        //            }
        //
        //
        //            return item
        //        }
        //        else{
        //            if indexPath.row == 0 {
        //                let item = collectionView.dequeueReusableCell(withReuseIdentifier: "addOnWithTitle", for: indexPath)
        //                return item
        //            }else  if indexPath.row == 1 {
        //                let item = collectionView.dequeueReusableCell(withReuseIdentifier: "addOn", for: indexPath)
        //                return item
        //            }
        //  else{
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "OPSCollectionViewCell", for: indexPath)  as! OPSCollectionViewCell
        item.layer.masksToBounds = true
        item.layoutIfNeeded()
        item.lbl.layoutIfNeeded()
        item.lbl.layer.masksToBounds = true
        var data = [String:Any]()
        for value in selection{
            if (value["animalTag"] as! String) == String(values[collectionView.tag]){
                data = value
            }
        }
        item.lbl.layer.borderColor = UIColor.lightGray.cgColor
        
        if ((data["addon"] as! NSArray).object(at: indexPath.row) as! SubProductTblBeef).status! == "true"{
            item.lbl.backgroundColor = UIColor(red: 191/255, green: 202/255, blue: 205/255, alpha: 1)
            item.lbl.textColor = UIColor.black
        }else{
            item.lbl.backgroundColor = UIColor.white
            item.lbl.textColor = UIColor.black
        }
        
        
        item.lbl.text = ((data["addon"] as! NSArray).object(at: indexPath.row) as! SubProductTblBeef).adonName!
        
        return item
        //  }
        //  }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // return CGSize(width: (collectionView.frame.size.width / 2 ) - 100, height: 80)
        return CGSize(width: 170, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 60.0,left: 30.0,bottom: 15.0,right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
    }
    
    @IBAction func reviewOrder(_ sender: UIButton) {
        
        DispatchQueue.main.async
        {
            
            if self.customerNameLbl.text == "N/A"
            {
                self.transparentView.isHidden = false
                self.billingView.isHidden = false
                self.isBillingContact = false
            }
            else
            {
                if UserDefaults.standard.value(forKey: "beefplaceordercheck") as? Bool == true &&
                    UserDefaults.standard.value(forKey: "beefemailcheckvalue") as? Bool == true {
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
                        self.showIndicator(self.view, withTitle: "", and: "")
                        
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
                        self.showIndicator(self.view, withTitle: "", and: "")
                        
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
                    
                }
                else if UserDefaults.standard.value(forKey: "beefplaceordercheck") as? Bool == false &&
                            UserDefaults.standard.value(forKey: "beefemailcheckvalue") as? Bool == true
                {
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
                                // newViewController.submitEmailFlag = submitEmailFlag
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
                            
                            self.showIndicator(self.view, withTitle: "", and: "")
                            
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
                else
                {
                    //                        cell.beefPlaceSelectionOutlet.setImage(UIImage(named: "Uncheckredoutline"), for: .normal)
                    //
                    //                        cell.beefEmailSelectionOutlet.setImage(UIImage(named: "Uncheckredoutline"), for: .normal)
                    
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please select at least one checkbox to submit.", comment: ""))
                    return
                }
            }
            
        }
    }
    
    
    @IBAction func toggleBtnAction(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "BeefReviewOrderVCIpad") as! BeefReviewOrderVCIpad
          self.navigationController?.pushViewController(newViewController, animated: false)
    //    self.navigationController?.popViewController(animated: false)
      //  self.navigationController?.popToViewController(newViewController, animated: false)
    }
    
    // network check
    
    @objc  func checkForReachability(notification:Notification){
        
        let del =  UIApplication.shared.delegate as? AppDelegate
        
        self.networkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if networkStatusLbl?.text == "Connected".localized {
            self.OffLineBtn.isHidden = true
            self.networkStatusImg.image = UIImage(named: "status_online_sign")
        }
        else {
            
            self.OffLineBtn.isHidden = false
            self.networkStatusImg.image = UIImage(named: "status_offline")
            
        }
        
    }
    
    func initialNetworkCheck() {
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        
        let del = UIApplication.shared.delegate as? AppDelegate
        self.networkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if networkStatusLbl?.text == "Connected".localized {
            self.OffLineBtn.isHidden = true
            self.networkStatusImg.image = UIImage(named: "status_online_sign")
        }
        else{
            self.OffLineBtn.isHidden = false
            self.networkStatusImg.image = UIImage(named: "status_offline")
            
        }
    }
    
    
    
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    
    @IBAction func offlineBtnAction(_ sender: UIButton) {
        
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(OrderProductSelectionSecondVC.buttonbgPressed), for: .touchUpInside)
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
    
    func UpdateUI(SelectedBillingCustomer: GetBillingContact) {
        DispatchQueue.main.async {
        //    if let cell = self.tblView.cellForRow(at: IndexPath(row: self.arr1.keys.count, section: 0) ) as? BillingCell{
                let filterArr = self.farmAddr.filter({$0.isDefault == true })
                if filterArr.count > 0{
                    updateBillingCustomer(entity: "GetBillingContact", customerID: self.custmerId, isDefault: false, billcustomerId: filterArr[0].billToCustId ?? "0", billcustomerName: filterArr[0].contactName ?? "")
                    
                }
                UserDefaults.standard.set(SelectedBillingCustomer.contactName, forKey: "farmValue")
                UserDefaults.standard.set(SelectedBillingCustomer.billToCustId, forKey: "billToCustomerId")
                
                updateBillingCustomer(entity: "GetBillingContact", customerID: self.custmerId, isDefault: true, billcustomerId: SelectedBillingCustomer.billToCustId ?? "0", billcustomerName: SelectedBillingCustomer.contactName ?? "")
                
                self.farmAddr = fetchBillingCustomer(entityName: "GetBillingContact",customerID: self.custmerId) as! [GetBillingContact]
                
                let attributeString = NSMutableAttributedString(string: SelectedBillingCustomer.contactName ?? "", attributes: self.attrs)
                // cell.billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                
         //   }
            self.customerNameLbl.text = SelectedBillingCustomer.contactName ?? ""
            self.transparentView.isHidden = true
            self.billingView.isHidden = true
        }
        
    }
    func updateUI() {
        DispatchQueue.main.async {
            if let cell = self.tblView.cellForRow(at: IndexPath(row: self.arr1.keys.count, section: 0) ) as? BillingCell{
                let attributeString = NSMutableAttributedString(string: (UserDefaults.standard.value(forKey: "farmValue") as! String), attributes: self.attrs)
                cell.billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                cell.delegateCustom = self
            }
            self.customerNameLbl.text = (UserDefaults.standard.value(forKey: "farmValue") as! String)
            self.transparentView.isHidden = true
            self.billingView.isHidden = true
        }
    }
    @IBAction func editBtnActon(_ sender: Any) {
        //  UserDefaults.standard.set("true", forKey: "settingDone")
        UserDefaults.standard.set(1, forKey: "orderSlideTag")
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "OrderingDefaultsVC")), animated: true)
        
    }
    
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AppHelpImagesVC") as? AppHelpImagesVC
        vc?.module = "Place an Order: Ordering Add Animal(s) Beef".localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
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
    
    func sideMenuRevealSettingsViewController() -> BeefOPSSelectionReviewIPadVC? {
        var viewController: UIViewController? = self
        
        if viewController != nil && viewController is BeefOPSSelectionReviewIPadVC {
            return viewController! as? BeefOPSSelectionReviewIPadVC
        }
        while (!(viewController is BeefOPSSelectionReviewIPadVC) && viewController?.parent != nil) {
            viewController = viewController?.parent
        }
        if viewController is BeefOPSSelectionReviewIPadVC {
            return viewController as? BeefOPSSelectionReviewIPadVC
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
    
    //MARK: IPAD CHANGES
    
    func setTermsConditionUI(){
        
        if ( UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool  ==  false ) || (UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool  ==  nil ) {
            //   infoBtnSelectionOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
            AgreeBtnImgView.image = UIImage(named: "Incremental_Check")
        } else {
            //   infoBtnSelectionOutlet.setImage(#imageLiteral(resourceName: ImageNames.checkImg), for: .normal)
            AgreeBtnImgView.image = UIImage(named: "incrementalCheckIpad")
        }
        if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == true{
            
            //      self.beefinfoBtnSelectionOutlet.isHidden = true
        } else {
            //   self.beefinfoBtnSelectionOutlet.isHidden = false
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
    
    @IBAction func beefcheckBoxBtnAction(_ sender: UIButton) {
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
            //   self.addDealerCodeTxtField.isHidden = true
            UserDefaults.standard.set(false, forKey: keyValue.beefPlaceOrderCheck.rawValue)
            UserDefaults.standard.set(false, forKey: keyValue.addDealerCodeCheck.rawValue)
            addDealerCodeOutlet.isEnabled = false
            addDealerCodeLabel.alpha = 0.6
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
            
            addDealerCodeLabel.alpha = 1
            addDealerCodeOutlet.alpha = 1
            
            
        }
        
        if pviduser == 5 {
            if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.capsInherit.rawValue || UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
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
                
            }
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
    
    func selectionObjectCheck(check :Bool){
        if check == true{
            let storyBoard: UIStoryboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "BeefConfilictOrdersViewController") as! BeefConfilictOrdersViewController
            vc.delegateCustom1 = self
            vc.dismissDelegate = self
            vc.screenName = "BeefOPSSelectionReviewIPadVC"
            self.present(vc, animated: true, completion: nil)
            // self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    
    
    func setSubmitOrderInitialUI(){
        self.serchTextField.setLeftPaddingPoints(20.0)
        self.addDealerCodeTxtField.setLeftPaddingPoints(20.0)
        let attributeString = NSMutableAttributedString(string: (UserDefaults.standard.value(forKey: "farmValue") as! String), attributes: self.attrs)
        //    cell.delegateCustom = self
        let dealerCode = UserDefaults.standard.value(forKey: keyValue.dealerCode.rawValue) as? String
        let addDealerCodeCheck = UserDefaults.standard.value(forKey: keyValue.addDealerCodeCheck.rawValue) as? Bool
        if UserDefaults.standard.value(forKey: keyValue.beefPlaceOrderCheck.rawValue) as? Bool == true {
            
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
            
        }
        if UserDefaults.standard.value(forKey: "beefplaceordercheck") as? Bool == true{
            self.beefPlaceSelectionOutlet.isSelected = true
        } else {
            self.beefPlaceSelectionOutlet.isSelected = false
        }
        let marketId = UserDefaults.standard.value(forKey: "currentActiveMarketId") as! String
        let markeData = fetchdataFromMarketId(marketId: marketId)
        if markeData.count > 0 {
            let marketnA = markeData.object(at: 0) as! GetMarketsTbl
            let pricingLink = marketnA.pricingLinkUrl
            pricingLinkC = pricingLink ?? ""
            
            UserDefaults.standard.setValue(true, forKey: "beefemailcheckvalue")
            //   self.beefEmailSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
            emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
            let attributedString = NSMutableAttributedString(string:  "For Information on list pricing of products, please visit the following web page. Pricing".localized)
            
            
            if UserDefaults.standard.value(forKey: "submitTypeSelection") as? String == "emailMe" || UserDefaults.standard.value(forKey: "submitTypeSelection") as? String == "" ||  UserDefaults.standard.value(forKey: "submitTypeSelection") as? String == nil{
                
                // cell.beefEmailSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                //UserDefaults.standard.setValue("emailMe", forKey: "submitTypeSelection")
                // UserDefaults.standard.setValue("email", forKey: "emailFlag")
                // cell.beefEmailSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                // cell.beefEmailSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                
                UserDefaults.standard.setValue("emailMe", forKey: "submitTypeSelection")
                UserDefaults.standard.setValue("email", forKey: "emailFlag")
                if  UserDefaults.standard.value(forKey: "beefemailcheckvalue") as? Bool == true
                {
                    // self.beefEmailSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                    emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                }
                else  if self.beefEmailSelectionOutlet.isSelected == false
                {
                    //cell.beefEmailSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                    emailBtnImgView.image = UIImage(named: "Incremental_Check")
                }
                if UserDefaults.standard.value(forKey: "beefplaceordercheck") as? Bool == true
                {
                    
                    //  self.beefPlaceSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                    self.addDealerCodeLabel.alpha = 1
                    self.addDealerCodeOutlet.alpha = 1
                    let dealerCode = UserDefaults.standard.value(forKey: "dealerCode") as? String
                    placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                    
                }
                else  if self.beefPlaceSelectionOutlet.isSelected == false
                {
                    //self.beefPlaceSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                    placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                    self.addDealerCodeLabel.alpha = 0.6
                    self.addDealerCodeOutlet.alpha = 0.6
                }
                
            } else {
                if  UserDefaults.standard.value(forKey: "beefemailcheckvalue") as? Bool == true
                {
                    //      self.beefEmailSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                    emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                }
                else  if self.beefEmailSelectionOutlet.isSelected == false
                {
                    //  self.beefEmailSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                    emailBtnImgView.image = UIImage(named: "Incremental_Check")
                }
                if UserDefaults.standard.value(forKey: "beefplaceordercheck") as? Bool == true
                {
                    
                    //    self.beefPlaceSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                    placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                    self.addDealerCodeLabel.alpha = 1
                    self.addDealerCodeOutlet.alpha = 1
                    let dealerCode = UserDefaults.standard.value(forKey: "dealerCode") as? String
                    
                }
                else  if self.beefPlaceSelectionOutlet.isSelected == false
                {
                    // cell.beefPlaceSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                    placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                    self.addDealerCodeLabel.alpha = 0.6
                    self.addDealerCodeOutlet.alpha = 0.6
                }
                
                
                self.beefEmailSelectionOutlet.alpha = 1
            }
            let pviduser = (UserDefaults.standard.integer(forKey:"BeefPvid") as? Int)!
            let currentCustomerId = UserDefaults.standard.value(forKey: "currentActiveCustomerId") as? Int
            if pviduser == 13 {
                
                
                var fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: "BeefAnimaladdTbl",orderId:orderId,userId:userId,customerId:currentCustomerId ?? 0,date:"")
                
                if fetchAnimalTbl.count == 0 {
                    UserDefaults.standard.set(false, forKey: "beefemailcheckvalue")
                    self.beefPlaceAnSelectionTitle.alpha = 1
                    self.beefPlaceSelectionOutlet.alpha = 1
                    self.beefEmailSelectionOutlet.isHidden = true
                    self.emailMeSelectionTtile.isHidden = true
                    self.emailStackView.isHidden = true
                    if UserDefaults.standard.value(forKey: "beefplaceordercheck") as? Bool == true
                    {
                        
                        //      self.beefPlaceSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                        placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                        self.addDealerCodeLabel.alpha = 1
                        self.addDealerCodeOutlet.alpha = 1
                        let dealerCode = UserDefaults.standard.value(forKey: "dealerCode") as? String
                        
                    }
                    else  if self.beefPlaceSelectionOutlet.isSelected == false
                    {
                        //    self.beefPlaceSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                        placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                        self.addDealerCodeLabel.alpha = 0.6
                        self.addDealerCodeOutlet.alpha = 0.6
                    }
                    if  UserDefaults.standard.value(forKey: "beefemailcheckvalue") as? Bool == true
                    {
                        //    self.beefEmailSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                        emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                    }
                    else  if self.beefEmailSelectionOutlet.isSelected == false
                    {
                        //   self.beefEmailSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                        emailBtnImgView.image = UIImage(named: "Incremental_Check")
                    }
                    
                    
                    
                } else {
                    
                    self.beefPlaceAnSelectionTitle.alpha = 0.6
                    self.beefPlaceSelectionOutlet.alpha = 0.6
                    self.beefEmailSelectionOutlet.isHidden = true
                    self.emailMeSelectionTtile.isHidden = true
                    self.emailStackView.isHidden = true
                    
                    if UserDefaults.standard.value(forKey: "beefplaceordercheck") as? Bool == true
                    {
                        
                        //  self.beefPlaceSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                        placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                        self.addDealerCodeLabel.alpha = 1
                        self.addDealerCodeOutlet.alpha = 1
                        let dealerCode = UserDefaults.standard.value(forKey: "dealerCode") as? String
                        
                    }
                    else  if self.beefPlaceSelectionOutlet.isSelected == false
                    {
                        //  self.beefPlaceSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                        placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                        self.addDealerCodeLabel.alpha = 0.6
                        self.addDealerCodeOutlet.alpha = 0.6
                    }
                    if  UserDefaults.standard.value(forKey: "beefemailcheckvalue") as? Bool == true
                    {
                        // self.beefEmailSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                        emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                    }
                    else  if self.beefEmailSelectionOutlet.isSelected == false
                    {
                        //    self.beefEmailSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                        emailBtnImgView.image = UIImage(named: "Incremental_Check")
                    }
                    //UserDefaults.standard.setValue("emailMe", forKey: "submitTypeSelection")
                    self.agrreLblStackView.isHidden = true
                    // self.beefinfoBtnSelectionOutlet.isHidden = true
                    self.agreeStackViewTopConstraint.constant = -70
                    // cell.emailMeEnterTtitle.isHidden = true
                    
                }
                
            }
            
            if pviduser == 5 {
                if UserDefaults.standard.string(forKey: "beefProduct") == "INHERIT" {
                    
                    var fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: "BeefAnimaladdTbl",orderId:orderId,userId:userId,customerId:currentCustomerId ?? 0,date:"")
                    
                    if fetchAnimalTbl.count == 0 {
                        
                        self.beefPlaceAnSelectionTitle.alpha = 1
                        self.beefPlaceSelectionOutlet.alpha = 1
                        if UserDefaults.standard.value(forKey: "beefplaceordercheck") as? Bool == true
                        {
                            
                            //  self.beefPlaceSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                            placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                            self.addDealerCodeLabel.alpha = 1
                            self.addDealerCodeOutlet.alpha = 1
                            let dealerCode = UserDefaults.standard.value(forKey: "dealerCode") as? String
                            
                        }
                        else  if self.beefPlaceSelectionOutlet.isSelected == false
                        {
                            //   self.beefPlaceSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                            placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                            self.addDealerCodeLabel.alpha = 0.6
                            self.addDealerCodeOutlet.alpha = 0.6
                        }
                        if  UserDefaults.standard.value(forKey: "beefemailcheckvalue") as? Bool == true
                        {
                            //   self.beefEmailSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                            emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                        }
                        else  if self.beefEmailSelectionOutlet.isSelected == false
                        {
                            //  self.beefEmailSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                            emailBtnImgView.image = UIImage(named: "Incremental_Check")
                        }
                        
                        self.agrreLblStackView.isHidden = false
                        self.agreeStackViewTopConstraint.constant = 20
                        
                    } else {
                        self.beefPlaceAnSelectionTitle.alpha = 0.6
                        self.beefPlaceSelectionOutlet.alpha = 0.6
                        if UserDefaults.standard.value(forKey: "beefplaceordercheck") as? Bool == true
                        {
                            
                            //    self.beefPlaceSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                            placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                            self.addDealerCodeLabel.alpha = 1
                            self.addDealerCodeOutlet.alpha = 1
                            let dealerCode = UserDefaults.standard.value(forKey: "dealerCode") as? String
                            
                        }
                        else  if self.beefPlaceSelectionOutlet.isSelected == false
                        {
                            //  self.beefPlaceSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                            placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                            self.addDealerCodeLabel.alpha = 0.6
                            self.addDealerCodeOutlet.alpha = 0.6
                        }
                        if  UserDefaults.standard.value(forKey: "beefemailcheckvalue") as? Bool == true
                        {
                            //  self.beefEmailSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                            emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                        }
                        else  if self.beefEmailSelectionOutlet.isSelected == false
                        {
                            //   self.beefEmailSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                            emailBtnImgView.image = UIImage(named: "Incremental_Check")
                        }
                        UserDefaults.standard.setValue("emailMe", forKey: "submitTypeSelection")
                        self.agreeStackViewTopConstraint.constant = -70
                        self.agrreLblStackView.isHidden = true
                        //self.beefinfoBtnSelectionOutlet.isHidden = true
                        
                    }
                }
            }
            if pviduser == 7 || pviduser == 6{
                
                if UserDefaults.standard.string(forKey: "BrazilGenotype") == "Genotype"
                {
                    self.beefPlaceAnSelectionTitle.alpha = 1
                    self.beefPlaceSelectionOutlet.alpha = 1
                    self.addDealerCodeOutlet.alpha = 1
                    self.addDealerCodeLabel.alpha = 1
                    self.beefPlaceSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                    self.beefEmailSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                }
                else
                {
                    var fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: "BeefAnimaladdTbl",orderId:orderId,userId:userId,customerId:currentCustomerId ?? 0,date:"")
                    
                    if fetchAnimalTbl.count == 0 {
                        
                        self.beefPlaceAnSelectionTitle.alpha = 1
                        self.beefPlaceSelectionOutlet.alpha = 1
                        
                        if UserDefaults.standard.value(forKey: "beefplaceordercheck") as? Bool == true
                        {
                            
                            //     self.beefPlaceSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                            placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                            self.addDealerCodeLabel.alpha = 1
                            self.addDealerCodeOutlet.alpha = 1
                            let dealerCode = UserDefaults.standard.value(forKey: "dealerCode") as? String
                            
                        }
                        else  if self.beefPlaceSelectionOutlet.isSelected == false
                        {
                            //  self.beefPlaceSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                            placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                            self.addDealerCodeLabel.alpha = 0.6
                            self.addDealerCodeOutlet.alpha = 0.6
                        }
                        if  UserDefaults.standard.value(forKey: "beefemailcheckvalue") as? Bool == true
                        {
                            //   self.beefEmailSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                            emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                        }
                        else  if self.beefEmailSelectionOutlet.isSelected == false
                        {
                            // self.beefEmailSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                            emailBtnImgView.image = UIImage(named: "Incremental_Check")
                        }
                        
                        self.agrreLblStackView.isHidden = false
                        self.agreeStackViewTopConstraint.constant = 20
                        
                    } else {
                        self.beefPlaceAnSelectionTitle.alpha = 0.6
                        self.beefPlaceSelectionOutlet.alpha = 0.6
                        
                        
                        if UserDefaults.standard.value(forKey: "beefplaceordercheck") as? Bool == true
                        {
                            
                            //   self.beefPlaceSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                            placeAnOrderImgView.image = UIImage(named: "incrementalCheckIpad")
                            self.addDealerCodeLabel.alpha = 1
                            self.addDealerCodeOutlet.alpha = 1
                            let dealerCode = UserDefaults.standard.value(forKey: "dealerCode") as? String
                            
                        }
                        else  if self.beefPlaceSelectionOutlet.isSelected == false
                        {
                            // self.beefPlaceSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                            placeAnOrderImgView.image = UIImage(named: "Incremental_Check")
                            self.addDealerCodeLabel.alpha = 0.6
                            self.addDealerCodeOutlet.alpha = 0.6
                        }
                        if  UserDefaults.standard.value(forKey: "beefemailcheckvalue") as? Bool == true
                        {
                            //      self.beefEmailSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                            emailBtnImgView.image = UIImage(named: "incrementalCheckIpad")
                        }
                        else  if self.beefEmailSelectionOutlet.isSelected == false
                        {
                            // self.beefEmailSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                            emailBtnImgView.image = UIImage(named: "Incremental_Check")
                        }
                        
                        UserDefaults.standard.setValue("emailMe", forKey: "submitTypeSelection")
                        self.agrreLblStackView.isHidden = true
                        self.agreeStackViewTopConstraint.constant = -70
                        //   self.beefinfoBtnSelectionOutlet.isHidden = true
                        
                        
                    }
                }
            }
        }
        
        self.beefPlaceAnSelectionTitle.text = "Place an Order".localized
        self.emailMeSelectionTtile.text = "E-Mail Me Entered Data".localized
        self.bilingLLbl.text = NSLocalizedString("Billing Contact", comment: "")
        let pviduser = (UserDefaults.standard.integer(forKey:"BeefPvid") as? Int)!
        if pviduser == 13 && UserDefaults.standard.value(forKey: "name") as? String  == "Beef" {
            //   self.submitOrderAction.setTitle("Submit Order to Blockyard".localized, for: .normal)
        }else {
            //   self.submitOrderAction.setTitle(NSLocalizedString("Submit", comment: ""), for: .normal)
        }
        
        self.agreeLl.text = "I agree to the Acceptance and Authorization, Warranty and Indemnification and Data Usage Policies.".localized
        
        // self.billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
        if UserDefaults.standard.value(forKey: "name") as! String  == "Beef"{
            //  self.beefsubmitInfoBtn.isHidden = false
        }
        customerNameLbl.text = (UserDefaults.standard.value(forKey: "farmValue") as! String)
        
        
    }
    @IBAction func sortAscendingAction(_ sender: UIButton) {
        if sender.tag == 100{
            ascendingFound = false
            self.sortByAscendingImgView.image = UIImage(named: "radioBtn")
            self.sortByDescendingImgView.image = UIImage(named: "radioSeletedBtn")
        }
        else {
            ascendingFound = true
            self.sortByAscendingImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByDescendingImgView.image = UIImage(named: "radioBtn")
        }
    }
    @IBAction private func sortDoneAction(_ sender: Any) {
        if  (UserDefaults.standard.object(forKey: "InheritFOSampleTrackingDetailVC") as? String == "officialid"){
            if self.animaId == 0{
                // self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                
                self.fethData =  fetchAllDataanimalTagStatus(entityName: "ProductAdonAnimlTbLBeef",asending : ascendingFound,status: "true", orderStatus: "false", animalTag: self.serchTextField.text!)
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                self.animaId = 1
            }
            else{
                //  self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                
                self.fethData =  fetchAllDataanimalTagStatus(entityName: "ProductAdonAnimlTbLBeef", asending: ascendingFound,status: "true", orderStatus: "false", animalTag: self.serchTextField.text!)
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                self.animaId = 0
            }
            self.sortByView.isHidden = true
            self.transparentView.isHidden = true
        } else if (UserDefaults.standard.object(forKey: "InheritFOSampleTrackingDetailVC") as? String == "barcode"){
            if self.barCodeId == 0{
                //  self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                
                self.fethData =  fetchAllDataBarcOdeStatus(entityName: "ProductAdonAnimlTbLBeef", asending: ascendingFound,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                self.barCodeId = 1
            }
            else{
                //      self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                
                self.fethData =  fetchAllDataBarcOdeStatus(entityName: "ProductAdonAnimlTbLBeef", asending: ascendingFound,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                self.barCodeId = 0
            }
            // }
            
           
            
        }
        else if (UserDefaults.standard.object(forKey: "InheritFOSampleTrackingDetailVC") as? String == "rgn"){
            if self.rGN_ID == 0{
                //  self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                
                self.fethData =  fetchAllDataRGNStatus(entityName: "ProductAdonAnimlTbLBeef", asending: ascendingFound,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                self.rGN_ID = 1
            }
            else{
                //  self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                
                self.fethData =  fetchAllDataRGNStatus(entityName: "ProductAdonAnimlTbLBeef", asending: ascendingFound,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                self.rGN_ID = 0
            }
        }
        else if (UserDefaults.standard.object(forKey: "InheritFOSampleTrackingDetailVC") as? String == "rgd"){
            if self.rGD_ID == 0{
           //     self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                
                self.fethData =  fetchAllDataRGDStatus(entityName: "ProductAdonAnimlTbLBeef", asending: ascendingFound,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                self.rGD_ID = 1
            }
            else{
          //      self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                
                self.fethData =  fetchAllDataRGDStatus(entityName: "ProductAdonAnimlTbLBeef", asending: ascendingFound,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                self.rGD_ID = 0
            }
        }
        self.sortByView.isHidden = true
        self.transparentView.isHidden = true
    }
    
    @IBAction func sortByEarTagAction(_ sender: UIButton) {
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        if sortByEarTagImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        } else{
            self.sortByEarTagImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByBarcodeImgView.image = UIImage(named: "radioBtn")
            UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
        }
        
    }
    
    @IBAction func sortByBarcodeAction(_ sender: UIButton) {
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        if sortByBarcodeImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        } else {
            self.sortByEarTagImgView.image = UIImage(named: "radioBtn")
            self.sortByBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
            UserDefaults.standard.set("barcode", forKey: "InheritFOSampleTrackingDetailVC")
        }
        // if pvid == 5 || pvid == 7 || pvid == 13{
       
        
    }
    
    @IBAction func sortByBrazilCrossBtn(_ sender: Any) {
        
        sortByBrazilView.isHidden = true
        transparentView.isHidden = true
    }
    
    @IBAction func sortBySeriesAction(_ sender: Any) {
        if sortBySeriesImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        } else {
            self.sortBySeriesImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
            self.sortByRGNImgView.image = UIImage(named: "radioBtn")
            self.sortByAnimalIDImgView.image = UIImage(named: "radioBtn")
            
            UserDefaults.standard.set(false, forKey: "brazilBarcode")
            UserDefaults.standard.set(true, forKey: "series")
            UserDefaults.standard.set("barcode", forKey: "InheritFOSampleTrackingDetailVC")
        }
          
         
        }
    
    @IBAction func sortByRGNAction(_ sender: Any) {
        if sortByRGNImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        } else {
            self.sortBySeriesImgView.image = UIImage(named: "radioBtn")
            self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
            self.sortByRGNImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByAnimalIDImgView.image = UIImage(named: "radioBtn")
            UserDefaults.standard.set("rgn", forKey: "InheritFOSampleTrackingDetailVC")
        }
       
        if self.rGN_ID == 0{
          //  self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
            
            self.fethData =  fetchAllDataRGNStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
            self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
            self.rGN_ID = 1
        }
        else{
          //  self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
            
            self.fethData =  fetchAllDataRGNStatus(entityName: "ProductAdonAnimlTbLBeef", asending: false,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
            self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
            self.rGN_ID = 0
        }
        
           
         
        }
    
    @IBAction func sortByAnimalIDAction(_ sender: Any) {
        if sortByAnimalIDImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        } else {
            self.sortBySeriesImgView.image = UIImage(named: "radioBtn")
            self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioBtn")
            self.sortByRGNImgView.image = UIImage(named: "radioBtn")
            self.sortByAnimalIDImgView.image = UIImage(named: "radioSeletedBtn")
            UserDefaults.standard.set("rgd", forKey: "InheritFOSampleTrackingDetailVC")
        }
        
        
          
          
        }
    
    @IBAction func sortByBrazilBarcodeAction(_ sender: Any) {
        if sortByBrazilBarcodeImgView.image == UIImage(named: "radioSeletedBtn") {
            return
        }
        UserDefaults.standard.set(true, forKey: "brazilBarcode")
        UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
        if self.animaId == 0{
          //  self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
            
            self.fethData =  fetchAllDataanimalTagStatus(entityName: "ProductAdonAnimlTbLBeef",asending : true,status: "true", orderStatus: "false", animalTag: self.serchTextField.text!)
            self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
            self.animaId = 1
        }
        else{
         //   self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
            
            self.fethData =  fetchAllDataanimalTagStatus(entityName: "ProductAdonAnimlTbLBeef", asending: false,status: "true", orderStatus: "false", animalTag: self.serchTextField.text!)
            self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
            self.animaId = 0
        }

        
            self.sortBySeriesImgView.image = UIImage(named: "radioBtn")
            self.sortByBrazilBarcodeImgView.image = UIImage(named: "radioSeletedBtn")
            self.sortByRGNImgView.image = UIImage(named: "radioBtn")
            self.sortByAnimalIDImgView.image = UIImage(named: "radioBtn")
          
        }
    
    @IBAction func farmIdDropDown(_ sender: UIButton) {
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        if pvid == 6 {
            self.sortByBeefView.isHidden = true
            self.sortByBrazilView.isHidden = false
        } else {
            self.sortByBeefView.isHidden = false
            self.sortByBrazilView.isHidden = true
        }
        self.sortByView.isHidden = false
        self.transparentView.isHidden = false
        //  serchTextField.text = ""
        //        serchTextField.resignFirstResponder()
        //        dropUpDownBtn.setImage(UIImage(named: "Image"), for: .normal)
        //        dropDown.anchorView = farmIdHideLbl
        //        dropDown.direction = .bottom
        //        dropDown.backgroundColor = UIColor.white
        //        dropDown.separatorColor = UIColor.clear
        //        dropDown.cornerRadius = 10
        //        dropDown.textFont = UIFont.systemFont(ofSize: 13)
        //        dropDown.cellHeight = 37
        //        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        //      if pvid == 13 {
        //        dropDown.dataSource  = ["Unique ID".localized, NSLocalizedString("Barcode", comment: "")]
        //      }
        //        if pvid == 7 {
        //            dropDown.dataSource = [ NSLocalizedString("Animal Tag", comment: ""), NSLocalizedString("Barcode", comment: "")]
        //        }
        //        if pvid  == 5{
        //            dropDown.dataSource = [ NSLocalizedString("Ear Tag", comment: ""), NSLocalizedString("Barcode", comment: "")]
        //        }
        //        if pvid == 6{
        //            dropDown.dataSource = [NSLocalizedString("Barcode", comment: ""), NSLocalizedString("Series", comment: ""), NSLocalizedString("RGN", comment: ""), NSLocalizedString("RGD or Animal ID", comment: "")]
        //        }
        //        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
        //
        //
        //            self.clickOnDropDown = item
        //
        //            self.farmIdDisplyOutlet.setTitle(item, for: .normal)
        //            self.farmIdDisplyOutlet.layer.borderColor = UIColor.gray.cgColor
        //
        //            if pvid == 5 || pvid == 7 || pvid == 13{
        //              if self.clickOnDropDown == NSLocalizedString("Ear Tag", comment: "") || self.clickOnDropDown == NSLocalizedString("Official ID", comment: "") || self.clickOnDropDown == "Animal Tag".localized || self.clickOnDropDown == "Unique ID".localized {
        //                    UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
        //                    if self.animaId == 0{
        //                        self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
        //
        //                        self.fethData =  fetchAllDataanimalTagStatus(entityName: "ProductAdonAnimlTbLBeef",asending : true,status: "true", orderStatus: "false", animalTag: self.serchTextField.text!)
        //                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
        //                        self.animaId = 1
        //                    }
        //                    else{
        //                        self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
        //
        //                        self.fethData =  fetchAllDataanimalTagStatus(entityName: "ProductAdonAnimlTbLBeef", asending: false,status: "true", orderStatus: "false", animalTag: self.serchTextField.text!)
        //                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
        //                        self.animaId = 0
        //                    }
        //
        //                }
        //                else{
        //                    UserDefaults.standard.set("barcode", forKey: "InheritFOSampleTrackingDetailVC")
        //                    if self.barCodeId == 0{
        //                        self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
        //
        //                        self.fethData =  fetchAllDataBarcOdeStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
        //                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
        //                        self.barCodeId = 1
        //                    }
        //                    else{
        //                        self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
        //
        //                        self.fethData =  fetchAllDataBarcOdeStatus(entityName: "ProductAdonAnimlTbLBeef", asending: false,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
        //                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
        //                        self.barCodeId = 0
        //                    }
        //
        //                }
        //            }
        //            else{
        //                if self.clickOnDropDown == NSLocalizedString("Barcode", comment: ""){
        //                    UserDefaults.standard.set(true, forKey: "brazilBarcode")
        //                    UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
        //                    if self.animaId == 0{
        //                        self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
        //
        //                        self.fethData =  fetchAllDataanimalTagStatus(entityName: "ProductAdonAnimlTbLBeef",asending : true,status: "true", orderStatus: "false", animalTag: self.serchTextField.text!)
        //                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
        //                        self.animaId = 1
        //                    }
        //                    else{
        //                        self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
        //
        //                        self.fethData =  fetchAllDataanimalTagStatus(entityName: "ProductAdonAnimlTbLBeef", asending: false,status: "true", orderStatus: "false", animalTag: self.serchTextField.text!)
        //                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
        //                        self.animaId = 0
        //                    }
        //
        //                }
        //                if self.clickOnDropDown ==  NSLocalizedString("Series", comment: ""){
        //                    UserDefaults.standard.set(false, forKey: "brazilBarcode")
        //                    UserDefaults.standard.set(true, forKey: "series")
        //                    UserDefaults.standard.set("barcode", forKey: "InheritFOSampleTrackingDetailVC")
        //                    if self.barCodeId == 0{
        //                        self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
        //
        //                        self.fethData =  fetchAllDataBarcOdeStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
        //                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
        //                        self.barCodeId = 1
        //                    }
        //                    else{
        //                        self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
        //
        //                        self.fethData =  fetchAllDataBarcOdeStatus(entityName: "ProductAdonAnimlTbLBeef", asending: false,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
        //                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
        //                        self.barCodeId = 0
        //                    }
        //
        //                }
        //                if self.clickOnDropDown == NSLocalizedString("RGN", comment: ""){
        //                    UserDefaults.standard.set("rgn", forKey: "InheritFOSampleTrackingDetailVC")
        //                    if self.rGN_ID == 0{
        //                        self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
        //
        //                        self.fethData =  fetchAllDataRGNStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
        //                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
        //                        self.rGN_ID = 1
        //                    }
        //                    else{
        //                        self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
        //
        //                        self.fethData =  fetchAllDataRGNStatus(entityName: "ProductAdonAnimlTbLBeef", asending: false,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
        //                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
        //                        self.rGN_ID = 0
        //                    }
        //
        //                }
        //
        //                if self.clickOnDropDown == NSLocalizedString("RGD", comment: "") || self.clickOnDropDown == NSLocalizedString("RGD or Animal ID", comment: ""){
        //                    UserDefaults.standard.set("rgd", forKey: "InheritFOSampleTrackingDetailVC")
        //                    if self.rGD_ID == 0{
        //                        self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
        //
        //                        self.fethData =  fetchAllDataRGDStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
        //                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
        //                        self.rGD_ID = 1
        //                    }
        //                    else{
        //                        self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
        //
        //                        self.fethData =  fetchAllDataRGDStatus(entityName: "ProductAdonAnimlTbLBeef", asending: false,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
        //                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
        //                        self.rGD_ID = 0
        //                    }
        //
        //                }
        //            }
        //        }
        //        dropDown.show()
    }
    
}
extension BeefOPSSelectionReviewIPadVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
}

extension BeefOPSSelectionReviewIPadVC : SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}
