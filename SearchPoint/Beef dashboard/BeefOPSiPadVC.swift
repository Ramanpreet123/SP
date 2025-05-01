//
//  BeefOPSiPadVC.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 03/02/25.
//

import Foundation
import UIKit
import CoreData
import Alamofire

class BeefOPSiPadVC: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate,offlineCustomView1,UIScrollViewDelegate{
    func crossBtn() {
        buttonbg1.removeFromSuperview()
        customPopView1.removeFromSuperview()
    }
    @IBOutlet weak var applyToEntireView: UIView!
    @IBOutlet weak var scrollViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuIconLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var addOnCollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var productCollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var customerNameLbl: UILabel!
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var crossBtnOutlet: UIButton!
    @IBOutlet weak var parentTblView: UITableView!
    @IBOutlet weak var parentViewAlert: UIView!
  var fetchDataEntry : [DataEntryList] = []
  var listName = String()
  let orderingDatalistVM = OrderingDataListViewModel()
  var objApiSync = ApiSyncList()
  
    let buttonbg1 = UIButton ()
    var delegateCustom : objectPickCartScreen?
    @IBOutlet weak var marketView: UIButton!
    
    @IBOutlet weak var sbcontact: UILabel!
    @IBOutlet weak var billingContactLbl: UILabel!
    var customPopView1 :TipPopUp!
    @IBOutlet weak var addOnLbl: UILabel!
    @IBOutlet weak var oPSScreenTitle: UILabel!
    @IBOutlet weak var applyEntireLbl: UILabel!
    //var delegateCustom : objectPickCartScreen?
    @IBOutlet weak var billingTbleView: UITableView!
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var billingViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var scrollview1: UIScrollView!
    @IBOutlet weak var nominatorTitle: UILabel!
    @IBOutlet weak var evaluationLbl: UILabel!
    @IBOutlet weak var notificationLblCount: UILabel!
    @IBOutlet weak var viewHeights: NSLayoutConstraint!
    @IBOutlet weak var billingView: UIView!
    @IBOutlet weak var lastViewHeight: NSLayoutConstraint!
    @IBOutlet weak var evaluationHeightConst: NSLayoutConstraint!
    @IBOutlet weak var editBttn: customButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var bvdvSelectionTitle: UILabel!
    @IBOutlet weak var removeBtnOutlet: UIButton!
    @IBOutlet weak var toggleBtnOutlet: UIButton!
    @IBOutlet weak var bvdvSelectionSubtitle: UILabel!
    @IBOutlet weak var nominatorHeightConst: NSLayoutConstraint!
    @IBOutlet weak var transparentView: UIView!
    var farmAddr = [GetBillingContact]()
    var attrs : [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 12),
        .foregroundColor: UIColor.blue,
        .underlineStyle: NSUnderlineStyle.single.rawValue]
    
    
    @IBOutlet weak var lastView: UIView!
    
    var sampTypeArr = NSMutableArray()
    var bothCom = NSMutableArray()
    var ageCom = NSMutableArray()
    var TempArrsam = NSMutableArray()
    var TempArrage = NSMutableArray()
    
    var arr = NSArray()
    var breedId = String()
    var productArr  = NSArray()
    var infoArr  = NSArray()
    var data1 = NSArray()
    var productId = Int()
    var productname = String()
    var mkId : Int?
    var isBillingContact = true
    var scrollValue = 0
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var statusBtn: UIButton!
    @IBOutlet weak var connectionImg: UIImageView!
    @IBOutlet weak var billingBtnOutlet: UIButton!
    var selectedCellIndex = Int()
    @IBOutlet weak var nominatorLbl: UILabel!
    @IBOutlet weak var clarifideLbl: UILabel!
    @IBOutlet weak var reviewBttn: UIButton!
    @IBOutlet weak var colView1HeightConstraints:NSLayoutConstraint!
    @IBOutlet weak var applyToOrderViewHeightConstraints:NSLayoutConstraint!
    @IBOutlet weak var collView1: UICollectionView!
    @IBOutlet weak var colView2HeightConstraints:NSLayoutConstraint!
    @IBOutlet weak var collView2: UICollectionView!
    var langId = UserDefaults.standard.value(forKey: "lngId") as? Int
    
   let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
   let userId = UserDefaults.standard.integer(forKey: "userId")
    
    @IBOutlet weak var appStatusLbl: UILabel!
    
  var custmerId = UserDefaults.standard.value(forKey: "currentActiveCustomerId") as! Int
    
    var starterArray = [String]()
    var dishesArray = [String]()
    var desertArray = [String]()
    
    
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
        //  hideIndicator()
        // self.view.isUserInteractionEnabled = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSideMenu()
       farmAddr = fetchBillingCustomer(entityName: "GetBillingContact",customerID: self.custmerId) as! [GetBillingContact]
        //   self.view.isUserInteractionEnabled = false
        //  showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
        heartBeatViewModel = HeartBeatViewModel(callBack: navigateToAnotherVc)
        heartBeatViewModel?.callGetHearBeatData()
        UserDefaults.standard.setValue(nil, forKey: "submitTypeSelection")
        UserDefaults.standard.removeObject(forKey: "isAnimalClickedFromBeefCart")
        UserDefaults.standard.removeObject(forKey: "isToUpdateAndAddAnimal")
        
        
        parentViewAlert.isHidden = true
        crossBtnOutlet.isHidden = true
        UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
        
        
        landIdApplangaugeConversion()
        scrollview1.delegate = self
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.navigationBar.isHidden = true
        collView1.delegate = self
        collView1.dataSource = self
        collView2.delegate = self
        collView2.dataSource = self
       
        
        arr  =  fetchproviderProductDataBeef(entityName: "GetProductTblBeef",provId:pvid )
    
        breedId =  UserDefaults.standard.value(forKey: "breed") as? String ?? ""
        let data1 = fetchAllDataWithOrderID(entityName: "BeefAnimaladdTbl",orderId:orderId,userId:userId)
        if pvid == 6 {
            updateProducDataBr(entity: "ProductAdonAnimlTbLBeef", status: "false", orderId: orderId,userId:userId)
            // let productNameArr =  fetchAllDataFarmIdStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true", orderStatus: "false",orderId:orderId,userId:userId, farmId: "")
            let fetchPid = fetchAllProductlistBreedBeef(entityName: "GetProductTblBeef", status: "true",providerId:pvid,breedId:breedId)
            if fetchPid.count > 0 {
                let pid = fetchPid [0] as! GetProductTblBeef
                for pName in data1 as? [BeefAnimaladdTbl] ?? [] {
                    for pdName2 in arr as? [GetProductTblBeef] ?? [] {
                        if pdName2.status == "true" {
                            updateProducData(entity: "ProductAdonAnimlTbLBeef", productID: Int(pdName2.productId), status: "true", animalTag: pName.animalTag ?? "", orderId: orderId,userId:userId, completionHandler: { (success) -> Void in
                                
                                if success {
                                    
                                    
                                    
                                }
                                
                            })
                        }
                    }
                    
                }
                
            }
            
            //collView1.reloadData()
        }
        else {
            //arr  =  fetchproviderProductDataBeef(entityName: "GetProductTblBeef",provId:pvid )
            let fetchPid = fetchAllProductlistBreedBeef(entityName: "GetProductTblBeef", status: "true",providerId:pvid,breedId:breedId) as! [GetProductTblBeef]
            if fetchPid.count > 0 {
              for product in fetchPid {
                let pid = product as! GetProductTblBeef
                updateProducDataSingle(entity: "ProductAdonAnimlTbLBeef", productID:Int(pid.productId), status: "true")
                let fetchadon = fetchAllAdonSingle(entityName:"GetAdonTbl" , status: "true", productId: Int(pid.productId))
                let fetchadon12 = fetchAllAdonSingleBeefAdonlist(entityName:"SubProductTblBeef" , status: "true", productId: Int(pid.productId),orderId:orderId)
                if fetchadon.count > 0{
                  for i in 0 ..< fetchadon12.count {
                    let adonId  = fetchadon12.object(at: i) as! SubProductTblBeef
                    updateAdonDataSingle(entity: "GetAdonTbl", adonId: Int(adonId.adonId) , status: "true")
                  }
                  productArr = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(pid.productId))
                  
                  
                  for j in 0 ..< data1.count {
                    let animaldata = data1[j] as! BeefAnimaladdTbl
                    
                    for k in 0 ..< productArr.count{
                      let adonId  = productArr.object(at: k) as! GetAdonTbl
                      if adonId.status == "true" {
                        updateAdonData(entity: "SubProductTblBeef", adonId: Int(adonId.adonId), status: "true", animaltag: animaldata.animalTag ?? "",orderId :orderId, userId: userId)
                      }
                    }
                  }
                }
                
                
                else {
                  updateProductTablevaleeSinglee(entity: "GetAdonTbl", productId: Int(pid.productId), status: "false")
                  //            for i in 0 ..< fetchadon12.count{
                  //                let adonId  = fetchadon.object(at: i) as! GetAdonTbl
                  //                updateAdonDataSingle(entity: "SubProductTbl", adonId: Int(adonId.adonId) , status: "true")
                  productArr = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(pid.productId))
                }
              }
            }
        }
        
        if UserDefaults.standard.value(forKey: "farmValue") as? String == nil{
         //   billingBtnOutlet.setTitle("N/A", for: .normal)
            customerNameLbl.text = "N/A"
        }
        else {
         //   billingBtnOutlet.setTitle(UserDefaults.standard.value(forKey: "farmValue") as? String, for: .normal)
            customerNameLbl.text = UserDefaults.standard.value(forKey: "farmValue") as? String
        }
        self.parentTblView.estimatedRowHeight = 100
        self.parentTblView.rowHeight = UITableView.automaticDimension
        
        parentTblView.sectionHeaderHeight = UITableView.automaticDimension
        parentTblView.estimatedSectionHeaderHeight = 100;
       self.getListName()
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
    
    func sideMenuRevealSettingsViewController() -> BeefOPSiPadVC? {
        var viewController: UIViewController? = self
        
        if viewController != nil && viewController is BeefOPSiPadVC {
            return viewController! as? BeefOPSiPadVC
        }
        while (!(viewController is BeefOPSiPadVC) && viewController?.parent != nil) {
            viewController = viewController?.parent
        }
        if viewController is BeefOPSiPadVC {
            return viewController as? BeefOPSiPadVC
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
    
    
    func landIdApplangaugeConversion(){
//       
//            applyEntireLbl.text = NSLocalizedString("Apply to Entire Order", comment: "")
//            appStatusLbl.text = NSLocalizedString("App Status:", comment: "")
//            oPSScreenTitle.text = NSLocalizedString("Ordering Product Selection(s)", comment: "")
//            addOnLbl.text = NSLocalizedString("Add-On Products".localized, comment: "")
//            reviewBttn.setTitle(NSLocalizedString("Review Order", comment: ""), for: .normal)
//            billingContactLbl.text = NSLocalizedString("Billing Contact:", comment: "")
//            sbcontact.text = NSLocalizedString("Select Billing Contact", comment: "")
//            bvdvSelectionTitle.text = NSLocalizedString("BVDV Selection Conflict", comment: "")
//            removeBtnOutlet.setTitle(NSLocalizedString("Remove All", comment: ""), for: .normal)
//            bvdvSelectionSubtitle.text = NSLocalizedString("BVDV product selection cannot be done as: ", comment: "")
    }
    override func viewDidLayoutSubviews() {
//        reviewBttn.layer.cornerRadius = reviewBttn.frame.height/2
////        clarifideLbl.layer.cornerRadius = clarifideLbl.frame.height/2
////        nominatorLbl.layer.cornerRadius = nominatorLbl.frame.height/2
//        colView1HeightConstraints.constant = collView1.contentSize.height
//        if UserDefaults.standard.string(forKey: "providerNameUS") != "CLARIFIDE CDCB (US)" {
//            lastViewHeight.constant = 100
//            
//        } else {
//            
//            lastViewHeight.constant = 100
//            
//          
//        }
        
    }
    
    @IBAction func viewAnimalClick(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "BeefPlaceAnOrder", bundle: Bundle.main).instantiateViewController(withIdentifier: "BeefViewAnimalVCiPad") as? BeefViewAnimalVCiPad
        vc!.screenBackSave = false
        vc!.productBackSave = false
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if  collectionView.tag == 1{
            return arr.count
            
        }
        else {
            return productArr.count
        }
    }
    
    override func viewWillLayoutSubviews() {
       
      //  scrollValue = Int(lastView.frame.height + editBttn.frame.height )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
//        if UserDefaults.standard.string(forKey: "providerNameUS") == "CLARIFIDE CDCB (US)" {
//            
//            nominatorLbl.isHidden = false
//            nominatorTitle.isHidden = false
//        }
//        else{
//            nominatorLbl.isHidden = true
//            nominatorTitle.isHidden = true
//        }
        
        if self.productArr.count > 0{
            
            self.collectionViewHeightConstraint.constant = 350
            self.hideIndicator()
            
        }
        else{
            if arr.count <= 3 {
                self.collectionViewHeightConstraint.constant = 160
            } else {
                self.collectionViewHeightConstraint.constant = 210
            }
            
            self.hideIndicator()
            
        }
        
        
    }
    @objc func buttonbgPressedTip (){
        buttonbg1.removeFromSuperview()
        customPopView1.removeFromSuperview()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView!) {
       
        var strDeviceType = ""
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                strDeviceType = "iPhone 5 or 5S or 5C"
            case 1334:
                strDeviceType = "iPhone 6/6S/7/8"
                
                if  UserDefaults.standard.string(forKey: "beefProduct") == "Genotype Only"{
                    scrollview1.contentSize.height = 420
                }
                else if  UserDefaults.standard.string(forKey: "beefProduct") == "Global HD50K"{
                    scrollview1.contentSize.height = 770
                }
                else if  UserDefaults.standard.string(forKey: "beefProduct") == "INHERIT"{
                    scrollview1.contentSize.height = 420
                }
                else if  UserDefaults.standard.string(forKey: "beefProduct") == "Non-Genotype"{
                    scrollview1.contentSize.height = 420
                }
                else {
                    // NZ
                    scrollview1.contentSize.height = 710
                }
                
                
            case 1920, 2208:
                strDeviceType = "iPhone 6+/6S+/7+/8+"
                // scrollview1.contentSize.height = 720
                
                if  UserDefaults.standard.string(forKey: "beefProduct") == "Genotype Only"{
                    scrollview1.contentSize.height = 420
                }
                else if  UserDefaults.standard.string(forKey: "beefProduct") == "Global HD50K"{
                    scrollview1.contentSize.height = 770
                }
                else if  UserDefaults.standard.string(forKey: "beefProduct") == "INHERIT"{
                    scrollview1.contentSize.height = 420
                }
                else if  UserDefaults.standard.string(forKey: "beefProduct") == "Non-Genotype"{
                    scrollview1.contentSize.height = 420
                }
                else {
                    // NZ
                    scrollview1.contentSize.height = 770
                }
                
            case 2436:
                strDeviceType = "iPhone X"
                
                if  UserDefaults.standard.string(forKey: "beefProduct") == "Genotype Only"{
                    scrollview1.contentSize.height = 420
                }
                else if  UserDefaults.standard.string(forKey: "beefProduct") == "Global HD50K"{
                    scrollview1.contentSize.height = 770
                }
                else if  UserDefaults.standard.string(forKey: "beefProduct") == "INHERIT"{
                    scrollview1.contentSize.height = 420
                }
                else if  UserDefaults.standard.string(forKey: "beefProduct") == "Non-Genotype"{
                    scrollview1.contentSize.height = 420
                }
                else {
                    // NZ
                    scrollview1.contentSize.height = 800
                }
                
                
                
                
            //  scrollview1.contentSize.height = 770
           case 2688,2796:
                strDeviceType = "iPhone Xs Max"
                scrollview1.contentSize.height = 800
            case 1792:
                scrollview1.contentSize.height = 870
                strDeviceType = "iPhone Xr"
            default:
                strDeviceType = "unknown"
            }
        }
        
        
    }
    @IBAction func marketTipPopClick(_ sender: UIButton) {
      if productId == 20{
        
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(self.buttonbgPressedTip), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view.addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed("TipPopUp") as? TipPopUp
        customPopView1.arrow_left.isHidden = true
        var yFrame = (marketView.layer.frame.minY  + 100) - self.scrollview1.contentOffset.y
        var strDeviceType = ""
      //  if langId  == 1{
//          if UIDevice().userInterfaceIdiom == .phone {
//            switch UIScreen.main.nativeBounds.height {
//            case 1136:
//              strDeviceType = "iPhone 5 or 5S or 5C"
//            case 1334:
//              strDeviceType = "iPhone 6/6S/7/8"
//              yFrame = (marketView.layer.frame.minY + 143 + 132) - self.scrollview1.contentOffset.y
//            case 1920, 2208:
//              strDeviceType = "iPhone 6+/6S+/7+/8+"
//              yFrame = (marketView.layer.frame.minY + 150 + 140) - self.scrollview1.contentOffset.y
//              
//            case 2436:
//              strDeviceType = "iPhone X"
//              yFrame = (marketView.layer.frame.minY + 158 + 144) - self.scrollview1.contentOffset.y
//           case 2688,2796,2556:
//              strDeviceType = "iPhone Xs Max"
//              yFrame = (marketView.layer.frame.minY + 158 + 120) - self.scrollview1.contentOffset.y
//            case 1792:
//              yFrame = (marketView.layer.frame.minY + 158 + 160) - self.scrollview1.contentOffset.y
//              strDeviceType = "iPhone Xr"
//            default:
//              strDeviceType = "unknown"
//            }
//          }
//          customPopView1.frame = CGRect(x:20,y: yFrame + 130  ,width: screenSize.width - 80, height: 110)
//          
//        } else if langId  == 2{
//          if UIDevice().userInterfaceIdiom == .phone {
//            switch UIScreen.main.nativeBounds.height {
//            case 1136:
//              strDeviceType = "iPhone 5 or 5S or 5C"
//            case 1334:
//              strDeviceType = "iPhone 6/6S/7/8"
//              yFrame = (marketView.layer.frame.minY + 133 + 127) - self.scrollview1.contentOffset.y
//            case 1920, 2208:
//              strDeviceType = "iPhone 6+/6S+/7+/8+"
//              yFrame = (marketView.layer.frame.minY + 140 + 140) - self.scrollview1.contentOffset.y
//              
//            case 2436:
//              strDeviceType = "iPhone X"
//              yFrame = (marketView.layer.frame.minY + 148 + 131) - self.scrollview1.contentOffset.y
//           case 2688,2796:
//              strDeviceType = "iPhone Xs Max"
//              yFrame = (marketView.layer.frame.minY + 148 + 120) - self.scrollview1.contentOffset.y
//            case 1792:
//              yFrame = (marketView.layer.frame.minY + 148 + 150) - self.scrollview1.contentOffset.y
//              strDeviceType = "iPhone Xr"
//            default:
//              strDeviceType = "unknown"
//            }
//          }
//          
//          customPopView1.frame = CGRect(x:78,y: yFrame  ,width: screenSize.width - 110, height: 120)
//          
//          
//        }
          
          if UIDevice().userInterfaceIdiom == .pad {
              switch UIScreen.main.bounds.height {
              case 768:
                  yFrame = (marketView.layer.frame.minY + 158 + 120) - self.scrollview1.contentOffset.y
                  
              case 810:
                  yFrame = (marketView.layer.frame.minY + 158 + 120) - self.scrollview1.contentOffset.y
                  
              case 820:
                  if UIScreen.main.nativeBounds.height == 2360.0 {
                      yFrame = (marketView.layer.frame.minY + 158 + 120) - self.scrollview1.contentOffset.y
                  } else {
                      yFrame = (marketView.layer.frame.minY + 158 + 120) - self.scrollview1.contentOffset.y
                  }
                  

              case 834:
                  if UIScreen.main.nativeBounds.height == 2224.0 {
                      yFrame = (marketView.layer.frame.minY + 158 + 120) - self.scrollview1.contentOffset.y
                  } else {
                      yFrame = (marketView.layer.frame.minY + 158 + 120) - self.scrollview1.contentOffset.y
                  }

              case 1024:
                  yFrame = (marketView.layer.frame.minY + 158 + 120) - self.scrollview1.contentOffset.y

              case 1032:
                  yFrame = (marketView.layer.frame.minY + 158 + 120) - self.scrollview1.contentOffset.y

              default:
                  break
              }
          }
        
          customPopView1.frame = CGRect(x:100,y: yFrame + 175  ,width: 280, height: 120)
        
        customPopView1.elipseImage2.isHidden = true
        customPopView1.elipseImage1.isHidden = true
        customPopView1.textLbl2.isHidden = true
        customPopView1.textLabel1.text =  NSLocalizedString("PAP and #Profit Indexes are only available for INHERIT select. These add-ons will automatically be excluded on males (INHERIT connect).", comment: "")
        
        customPopView1.delegate = self
        customPopView1.layer.borderColor = UIColor.blue.cgColor
        customPopView1.layer.borderWidth = 1
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1.addSubview(customPopView1)
      }
    }
    @IBAction func switchToggleAction(_ sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if(appDelegate.switchFlag == 0) {
            let storyboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: Bundle.main)
       
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefOPSSecondVCIpad")), animated: true)
        }
    }
    
    @IBAction func backBtnClk(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        if collectionView.tag == 1 {
            
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: "orderProductSelection", for: indexPath) as! OrdingProductSelectionCollectionViewCell
            item.clipsToBounds = true
         //   item.layer.masksToBounds = true
         //   item.layoutIfNeeded()
           // item.layer.cornerRadius = (item.frame.size.height / 2)
          //  item.Lbl.layer.cornerRadius =  item.Lbl.frame.size.height/2
            let data = arr[indexPath.item] as! GetProductTblBeef
            item.Lbl.text = data.productName //"INHERIT Select"
            
            item.Lbl.layoutIfNeeded()
            item.Lbl.layer.masksToBounds = true
          
            if data.status == "true"{
                self.productname = data.productName!
                self.productId = Int(data.productId)
                item.Lbl.backgroundColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1)
                item.Lbl.layer.borderColor =  UIColor.clear.cgColor
                item.Lbl.textColor = UIColor.white
            }
            else{
                item.Lbl.backgroundColor = UIColor.white
                item.Lbl.textColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1)
                item.Lbl.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor
            }
           
            return item
            
        } else {
            
            let item = collView2.dequeueReusableCell(withReuseIdentifier: "SecondCV", for: indexPath) as! OrderProductCell
            item.clipsToBounds = true
          //  item.layer.masksToBounds = true
        //    item.layoutIfNeeded()
        //    item.layer.cornerRadius = 27 //(item.frame.size.height / 2)
         //   item.Lbl.layer.cornerRadius =  27//item.Lbl.frame.size.height/
          //  item.Lbl.layer.masksToBounds = true
           // item.Lbl.layoutIfNeeded()
            if productArr.count > 0 {
                let data = productArr[indexPath.item] as! GetAdonTbl
                if data.status == "true" {
                    item.Lbl.backgroundColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1)
                    item.Lbl.layer.borderColor =  UIColor.clear.cgColor
                    item.Lbl.textColor = UIColor.white
                    
                }
                else{
                    item.Lbl.backgroundColor = UIColor.white
                    item.Lbl.textColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1)
                    item.Lbl.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor
                }
                
                item.Lbl.text = data.adonName
              if data.productId == 20 {
                marketView.isHidden = false
              } else {
                marketView.isHidden = true
              }
                if langId == 1 {
                    
                    if data.textValueEnglish == "" {
                        item.infoBtnOutlet.isHidden = true
                        //marketView.isHidden = true
                    } else {
                        item.infoBtnOutlet.isHidden = false
                      //marketView.isHidden = false
                    }
                    
                } else if langId == 2 {
                    
                    if data.textValuePortugese == "" {
                        item.infoBtnOutlet.isHidden = true
                       // marketView.isHidden = true
                    } else {
                        item.infoBtnOutlet.isHidden = false
                     // marketView.isHidden = false
                    }
                }
               else if langId == 3 {
                  
                  if data.textValueItalian == "" {
                      item.infoBtnOutlet.isHidden = true
                    marketView.isHidden = true
                  } else {
                      item.infoBtnOutlet.isHidden = false
                     marketView.isHidden = false
                  }
              }
                
                item.infoBtnOutlet.tag = indexPath.item
                item.infoBtnOutlet.addTarget(self, action: #selector(openPopUp(_:)), for: .touchUpInside)
                
            }
            
            return item
        }
    }
    
    @objc func openPopUp(_ sender: UIButton){
        
        let arrayGet = self.productArr[sender.tag] as! GetAdonTbl
        let textValueEnglish = arrayGet.value(forKey: "textValueEnglish") as? String
        let textValuePortugese = arrayGet.value(forKey: "textValuePortugese") as? String
        let textValueItalian = arrayGet.value(forKey: "textValueItalian") as? String
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        if langId == 1{
            let vc = storyboard.instantiateViewController(withIdentifier: "CommanInfoPopUpController") as! CommanInfoPopUpController
            vc.stringGetThroughArray = textValueEnglish ?? ""
            self.navigationController?.present(vc, animated: false, completion: nil)
        } else if langId == 3{
          let vc = storyboard.instantiateViewController(withIdentifier: "CommanInfoPopUpController") as! CommanInfoPopUpController
          vc.stringGetThroughArray = textValueItalian ?? ""
          self.navigationController?.present(vc, animated: false, completion: nil)
      }
          else {
            let vc = storyboard.instantiateViewController(withIdentifier: "CommanInfoPopUpController") as! CommanInfoPopUpController
            vc.stringGetThroughArray = textValuePortugese ?? ""
            self.navigationController?.present(vc, animated: false, completion: nil)
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView.tag == 1 {
            return CGSize(width: 280, height: 60)
        } else {
            return CGSize(width: 222, height: 60)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func reloadAddOns(collectionView: UICollectionView,indexPath: IndexPath){
        
        let userId = UserDefaults.standard.integer(forKey: "userId")
        
        let orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
        showIndicator(self.view, withTitle: NSLocalizedString("Updating..", comment: ""), and: "")
        
        let data = arr[indexPath.item] as! GetProductTblBeef
        
        let pId = data.productId
        
        
        productId = Int(pId)
      if productId == 20 {
          marketView.isHidden = false
      } else {
          marketView.isHidden = true
      }
        
        productname = data.productName ?? ""
        
        UserDefaults.standard.integer(forKey: "pid")
        
        //        let  productId1 = UserDefaults.standard.integer(forKey: "pdId")
        //
        if UserDefaults.standard.value(forKey: "Brazil") as? String != "BR" {
            let data12333 =  fetchProductAdonDataStatus(entityName: "GetProductTblBeef", prodId: productId, status: "true")
            if data12333.count > 0{
                collView1.reloadData()
                collView2.reloadData()
                self.hideIndicator()
                return
            }
        }
        else{
           
        }
        
        
        UserDefaults.standard.set(productId, forKey: "pid")
        
        UserDefaults.standard.set(productId, forKey: "pdId")
        
        productArr = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(pId))
        
        let data1 = fetchAllDataWithOrderID(entityName: "BeefAnimaladdTbl",orderId:orderId,userId:userId)
        
        let item = collectionView.cellForItem(at: indexPath) as! OrdingProductSelectionCollectionViewCell
        
        item.Lbl.backgroundColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1)
        
        item.Lbl.textColor = UIColor.white
        
        for i in 0 ..< data1.count{
            
            let animaldata = data1[i] as! BeefAnimaladdTbl
            if UserDefaults.standard.value(forKey: "Brazil") as? String == "BR" {
                
                let data =   fetchSubProductDataBeef(entityName: "ProductAdonAnimlTbLBeef", productId: productId, animalTag: animaldata.animalTag!, orderId: orderId, userId: userId)
                
                if data.count == 0 {
                    
                    hideIndicator()
                    return
                }
                deleteDuplicateProductIds(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true", orderStatus: "false",orderId:orderId,userId:userId, farmId: animaldata.animalTag!)
                let dataval =  fetchAllDataFarmIdStatusCheck(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true", orderStatus: "false",orderId:orderId,userId:userId, farmId: animaldata.animalTag!)
                if dataval.count == 1{
                    let datValue = dataval.object(at: 0) as! ProductAdonAnimlTbLBeef
                    if datValue.productId == pId{
                        self.hideIndicator()
                        
                        return
                    }
                    
                }
                let statusCheck = data.object(at: 0) as! ProductAdonAnimlTbLBeef
                if statusCheck.status == "true" {
                    updateProducData(entity: "ProductAdonAnimlTbLBeef", productID: productId, status: "false", animalTag: animaldata.animalTag ?? "", orderId: orderId,userId:userId, completionHandler: { (success) -> Void in
                        
                        
                        
                        // When download completes,control flow goes here.
                        
                        if success {
                            
                            // download success
                            
                            updateProductTabl(entity: "GetProductTblBeef", productId: Int(pId), status: "false",completionHandler: { (success) -> Void in
                                
                                
                                
                                // When download completes,control flow goes here.
                                
                                if success {
                                    
                                    // download success
                                    
                                    
                                    
                                }
                                
                            })
                            
                        }
                        
                    })
                }
                else {
                    updateProducData(entity: "ProductAdonAnimlTbLBeef", productID: productId, status: "true", animalTag: animaldata.animalTag ?? "", orderId: orderId,userId:userId, completionHandler: { (success) -> Void in
                        
                        
                        
                        // When download completes,control flow goes here.
                        
                        if success {
                            
                            // download success
                            
                            updateProductTabl(entity: "GetProductTblBeef", productId: Int(pId), status: "true",completionHandler: { (success) -> Void in
                                
                                
                                
                                // When download completes,control flow goes here.
                                
                                if success {
                                    
                                    // download success
                                    
                                    
                                    
                                }
                                
                            })
                            
                        }
                        
                    })
                }
                
                
            }
            
            else {
//              if pvid ==  5 {
//                let beefAnimal = fetchAllDataWithOrderID(entityName: "BeefAnimaladdTbl",orderId:orderId,userId:userId) as! [BeefAnimaladdTbl]
//                for animal in beefAnimal {
//
//                  updateProducDataSingleanimalId(entity: "BeefAnimaladdTbl", productID:productId, status: "true", animalId: Int(animal.animalId),orderId:orderId,userId: userId)
//
////                  saveProductAdonTbl(entity: "ProductAdonAnimlTbLBeef", animalTag: animal.animalTag ?? "", barCodetag: animal.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: animal.farmId ?? "", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:"", animalId: Int(dataGet.animalId), marketName: data.marketName ?? "", orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"), isCdcbProduct: true)
//                }
//              }
              
                updateAnimalTblData(entity: "BeefAnimaladdTbl", status:"true", animalTag: animaldata.animalTag ?? "", orderId: orderId, userId: userId,completionHandler: { (success) -> Void in
                    
                    if success {
                        
                        // download success
                        
                        updateAnimalTblData(entity: "ProductAdonAnimlTbLBeef", status: "false", animalTag: animaldata.animalTag ?? "", orderId: orderId, userId: userId,completionHandler: { (success) -> Void in
                            
                            
                            
                            if success {
                                
                                // download success
                                
                                
                                
                                updateAnimalTblData(entity: "SubProductTblBeef", status: "false", animalTag: animaldata.animalTag ?? "", orderId: orderId, userId: userId, completionHandler: { (success) -> Void in
                                    
                                    
                                    
                                    // When download completes,control flow goes here.
                                    
                                    if success {
                                        
                                        // download success
                                        
                                        updateProductTablData(entity: "GetProductTblBeef", status: "false", completionHandler: { (success) -> Void in
                                            
                                            
                                            
                                            // When download completes,control flow goes here.
                                            
                                            if success {
                                                
                                                
                                                
                                                updateProductTablData(entity: "GetAdonTbl", status: "false",completionHandler: { (success) -> Void in
                                                    
                                                    
                                                    
                                                    // When download completes,control flow goes here.
                                                    
                                                    if success {
                                                        
                                                        // download success
                                                        
                                                        
                                                        
                                                        updateProducData(entity: "ProductAdonAnimlTbLBeef", productID: productId, status: "true", animalTag: animaldata.animalTag ?? "", orderId: orderId,userId:userId, completionHandler: { (success) -> Void in
                                                            
                                                            
                                                            
                                                            // When download completes,control flow goes here.
                                                            
                                                            if success {
                                                                
                                                                // download success
                                                                
                                                                updateProductTabl(entity: "GetProductTblBeef", productId: Int(pId), status: "true",completionHandler: { (success) -> Void in
                                                                    
                                                                    
                                                                    
                                                                    // When download completes,control flow goes here.
                                                                    
                                                                    if success {
                                                                        
                                                                        // download success
                                                                        
                                                                        
                                                                        
                                                                    }
                                                                    
                                                                })
                                                                
                                                            }
                                                            
                                                        })
                                                        
                                                    }
                                                    
                                                })
                                                
                                            }
                                            
                                        })
                                        
                                        
                                        
                                    }
                                    
                                })
                                
                            }
                            
                        })
                    }
                    
                })
                
            }
            
            // let fetchproduct = fetchAllData(entityName: "ProductAdonAnimalTbl")
            
        }
        
        collView1.reloadData()
        collView2.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            
            if self.productArr.count > 0{
                
            //    self.colView2HeightConstraints.constant = self.collView2.contentSize.height + 50
                self.collectionViewHeightConstraint.constant = 350
                self.hideIndicator()
                
            }
            else{
                if self.arr.count <= 3 {
                    self.collectionViewHeightConstraint.constant = 160
                } else {
                    self.collectionViewHeightConstraint.constant = 210
                }
              //  self.colView2HeightConstraints.constant = self.collView2.contentSize.height
                self.hideIndicator()
                
            }
            //   self.collView1.reloadData()
            self.collView2.reloadData()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let userId = UserDefaults.standard.integer(forKey: "userId")
        
        let orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
   
        if collectionView.tag == 1{
            //                   if UserDefaults.standard.value(forKey: "Brazil") as? String == "BR" {
            //                let dataval =  fetchAllDataFarmIdStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true", orderStatus: "false",orderId:orderId,userId:userId, farmId: "")
            //                           if dataval.count == 1{
            //                               return
            //                           }
            //                }
            reloadAddOns(collectionView: collectionView, indexPath: indexPath)
            
            
        }
        
        else{
            
            let pid = UserDefaults.standard.integer(forKey: "pid")
            
            let prod = productArr[indexPath.item] as! GetAdonTbl
            let beefPvid = UserDefaults.standard.integer(forKey: "BeefPvid")
            let adonId = prod.adonName
            if adonId == "BVDV" {
             
                if beefPvid == 7 {
                    //  if UserDefaults.standard.value(forKey: "screenBeef") as? String == "NZ"{
                  sampTypeArr = fetchAllDataAnimalDataBeefSampleType(entityName: "BeefAnimaladdTbl", sampleType1: "Caisley (TSU)", sampleType2: "Allflex (TSU)",sampleType3: "Allflex (TST)",orderId: orderId, pvid: beefPvid).mutableCopy() as! NSMutableArray
                    bothCom = fetchAllDataAnimalDataBeefSampleTypewithAge(entityName: "BeefAnimaladdTbl", sampleType1: "Caisley (TSU)", sampleType2: "Allflex (TSU)",sampleType3: "Allflex (TST)", age: 35, orderId: orderId).mutableCopy() as! NSMutableArray
                    ageCom =   fetchAllDataAnimalDataBeefSampleTypeAnimaTagNZ(entityName: "BeefAnimaladdTbl", aTag: 35,orderId:orderId).mutableCopy() as! NSMutableArray
                    
                    if bothCom.count > 0 {
                        
                        for i in 0 ..< self.bothCom.count{
                            let animaldata = self.bothCom[i] as! BeefAnimaladdTbl
                            for j in 0 ..< self.sampTypeArr.count{
                                let animaldata1 = self.sampTypeArr[j] as! BeefAnimaladdTbl
                                if animaldata.animalTag == animaldata1.animalTag{
                                    sampTypeArr.removeObject(at: j)
                                    
                                    break
                                }
                            }
                            
                        }
                        
                        for  k in 0 ..< self.bothCom.count{
                            let animaldata = self.bothCom[k] as! BeefAnimaladdTbl
                            for l in 0 ..< self.ageCom.count{
                                let animaldata1 = self.ageCom[l] as! BeefAnimaladdTbl
                                if animaldata.animalTag == animaldata1.animalTag{
                                    ageCom.removeObject(at: l)
                                    
                                    break
                                }
                            }
                            
                        }
                        
                    }
                    
                    if sampTypeArr.count > 0 || bothCom.count > 0 || ageCom.count > 0{
                        crossBtnOutlet.isHidden = false
                        self.parentViewAlert.isHidden = false
                        self.transparentView.isHidden = false
                        parentTblView.reloadData()
                        
                        
                    }
                    else {
                        self.parentViewAlert.isHidden = true
                        self.transparentView.isHidden = true
                        //else {
                        
                        let data1 = fetchAllDataWithOrderID(entityName: "BeefAnimaladdTbl",orderId:orderId,userId:userId)
                        let item = collectionView.cellForItem(at: indexPath) as! OrderProductCell
                        
                        item.Lbl.backgroundColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1)
                        
                        item.Lbl.textColor = UIColor.white
                        
                        for i in 0 ..< data1.count{
                            
                            let animaldata = data1[i] as! BeefAnimaladdTbl
                            
                            
                            let data =   fetchSubProductDataStatusUpdateBeef(entityName: "SubProductTblBeef",productId:Int(prod.adonId), animalTag: animaldata.animalTag ?? "", status: "true",orderId: orderId ,userId: userId)
                            
                            if data.count > 0{
                              UserDefaults.standard.set(false, forKey: "BeefBVDVSeleted")
                                updateAdonData(entity: "SubProductTblBeef", adonId: Int(prod.adonId), status: "false", animaltag: animaldata.animalTag ?? "",orderId :orderId, userId: userId)
                                
                                updateAdoonTabl(entity: "GetAdonTbl", AdonId: Int(prod.adonId), status: "false",productId: Int(prod.productId))
                                
                                self.productArr = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(prod.productId))
                                
                               
                            }
                            else{
                              UserDefaults.standard.set(true, forKey: "BeefBVDVSeleted")
                                updateAdonData(entity: "SubProductTblBeef", adonId: Int(prod.adonId), status: "true", animaltag: animaldata.animalTag ?? "" ,orderId :orderId, userId: userId)
                                
                                updateAdoonTabl(entity: "GetAdonTbl", AdonId: Int(prod.adonId), status: "true",productId: Int(prod.productId))
                                
                                self.productArr = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(prod.productId))
                                
                            }
                        }
                        self.collView2.reloadData()
                        //}
                    }
                }
                else {
                  sampTypeArr = fetchAllDataAnimalDataBeefSampleType(entityName: "BeefAnimaladdTbl", sampleType1: "Caisley (TSU)", sampleType2: "Allflex (TSU)",sampleType3: "Allflex (TST)",orderId: orderId, pvid: beefPvid).mutableCopy() as! NSMutableArray
                    if sampTypeArr.count > 0 {
                        self.parentViewAlert.isHidden = false
                        self.transparentView.isHidden = false
                        crossBtnOutlet.isHidden = false
                        
                        parentTblView.reloadData()
                        
                    }
                    else {
                        
                        //else {
                        let data1 = fetchAllDataWithOrderID(entityName: "BeefAnimaladdTbl",orderId:orderId,userId:userId)
                        let item = collectionView.cellForItem(at: indexPath) as! OrderProductCell
                        
                        item.Lbl.backgroundColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1)
                        
                        item.Lbl.textColor = UIColor.white
                        
                        for i in 0 ..< data1.count{
                            
                            let animaldata = data1[i] as! BeefAnimaladdTbl
                            
                            
                            let data =   fetchSubProductDataStatusUpdateBeef(entityName: "SubProductTblBeef",productId:Int(prod.adonId), animalTag: animaldata.animalTag ?? "", status: "true",orderId: orderId ,userId: userId)
                            
                            if data.count > 0{
                              UserDefaults.standard.set(false, forKey: "BeefBVDVSeleted")
                                updateAdonData(entity: "SubProductTblBeef", adonId: Int(prod.adonId), status: "false", animaltag: animaldata.animalTag ?? "",orderId :orderId, userId: userId)
                                
                                updateAdoonTabl(entity: "GetAdonTbl", AdonId: Int(prod.adonId), status: "false",productId: Int(prod.productId))
                                
                                self.productArr = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(prod.productId))
                                
                               
                            }
                            else{
                              UserDefaults.standard.set(true, forKey: "BeefBVDVSeleted")
                                updateAdonData(entity: "SubProductTblBeef", adonId: Int(prod.adonId), status: "true", animaltag: animaldata.animalTag ?? "" ,orderId :orderId, userId: userId)
                                
                                updateAdoonTabl(entity: "GetAdonTbl", AdonId: Int(prod.adonId), status: "true",productId: Int(prod.productId))
                                
                                self.productArr = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(prod.productId))
                                
                            }
                        }
                        self.collView2.reloadData()
                        //}
                    }
                }
            }
            else{
                let data1 = fetchAllDataWithOrderID(entityName: "BeefAnimaladdTbl",orderId:orderId,userId:userId)
                for i in 0 ..< data1.count{
                    
                    let animaldata = data1[i] as! BeefAnimaladdTbl
                    
                    
                    let data =   fetchSubProductDataStatusUpdateBeef(entityName: "SubProductTblBeef",productId:Int(prod.adonId), animalTag: animaldata.animalTag ?? "", status: "true",orderId: orderId ,userId: userId)
                    
                    if data.count > 0{
                        
                        updateAdonData(entity: "SubProductTblBeef", adonId: Int(prod.adonId), status: "false", animaltag: animaldata.animalTag ?? "",orderId :orderId, userId: userId)
                        
                        updateAdoonTabl(entity: "GetAdonTbl", AdonId: Int(prod.adonId), status: "false",productId: Int(prod.productId))
                        
                        self.productArr = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(prod.productId))
                        
                        
                    }
                    else{
                        
                        updateAdonData(entity: "SubProductTblBeef", adonId: Int(prod.adonId), status: "true", animaltag: animaldata.animalTag ?? "" ,orderId :orderId, userId: userId)
                        
                        updateAdoonTabl(entity: "GetAdonTbl", AdonId: Int(prod.adonId), status: "true",productId: Int(prod.productId))
                        
                        self.productArr = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(prod.productId))
                        
                    }
                }
                self.collView2.reloadData()
            }
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 75
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == parentTblView {
            
            if section == 0 {
                if sampTypeArr.count == 0{
                    return 0
                }
                
            }
            else if section == 1 {
                
                if bothCom.count == 0{
                    return 0
                }
                
            }
            else {
                
                
                if ageCom.count == 0{
                    return 0
                }
                
            }
            return 100.0
            
        }
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 0))
        
        var label = UILabel()
        label.textColor = UIColor.white
        
        // label.font = label.font.withSize(14)
        label = UILabel(frame: CGRect(x: 15, y: 1, width: 445, height: 100))
        label.font = UIFont.boldSystemFont(ofSize: 22.0)
        label.numberOfLines = 3
        headerView.addSubview(label)
        
        
        if tableView == parentTblView {
            
            if section == 0 {
                if sampTypeArr.count == 0 {
                    label.numberOfLines = 0
                    self.parentTblView.estimatedRowHeight = 0
                    self.parentTblView.rowHeight = UITableView.automaticDimension
                    
                    parentTblView.sectionHeaderHeight = UITableView.automaticDimension
                    parentTblView.estimatedSectionHeaderHeight = 0
                    
                    
                } else {
                    
                    if sampTypeArr.count == 1 {
                          label.text = "Animal in order has sample type other than Allflex (TSU), Allflex (TST) or Caisley (TSU)".localized(with: sampTypeArr.count)
                            
                    } else {
                          label.text = "Animals in order have sample type other than Allflex (TSU), Allflex (TST) or Caisley (TSU)".localized(with: sampTypeArr.count)
                        
                    }}
            }
            else if section == 1 {
                
                if bothCom.count == 0 {
                    label.numberOfLines = 0
                    
                    self.parentTblView.estimatedRowHeight = 0
                    self.parentTblView.rowHeight = UITableView.automaticDimension
                    
                    parentTblView.sectionHeaderHeight = UITableView.automaticDimension
                    parentTblView.estimatedSectionHeaderHeight = 0
                    
                } else {
                    
                    if bothCom.count == 1 {
                    
                          label.text =  "Animal in order has sample type other than Allflex (TSU), Allflex (TST) or Caisley (TSU) and age less than 35 days.".localized(with: bothCom.count)
                        
                    } else {
                        
                      label.text =  "Animal in order have sample type other than Allflex (TSU), Allflex (TST) or Caisley (TSU) and age less than 35 days.".localized(with: bothCom.count)
  
                    }
                }
            }
            else {
                
                if ageCom.count == 0 {
                    label.numberOfLines = 0
                    self.parentTblView.estimatedRowHeight = 0
                    self.parentTblView.rowHeight = UITableView.automaticDimension
                    
                    parentTblView.sectionHeaderHeight = UITableView.automaticDimension
                    parentTblView.estimatedSectionHeaderHeight = 0
                    
                } else {
                    
                    if ageCom.count == 1 {
                        
                       
                      label.text =  " Animal in order has age less than 35 days".localized(with: ageCom.count)
                        
                    } else  {
                      label.text =  " Animal in order have age less than 35 days".localized(with: ageCom.count)
                            
                            
                        }
                        
                        
                    }
                    
                    
                    
                }
            }
        
        
        
        
        
        return headerView
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == parentTblView {
            
            if section == 0 {
                if sampTypeArr.count == 0 {
                    return ""
                } else {
                    
                    if sampTypeArr.count == 1 {
                         
                          return "Animal in order has sample type other than Allflex (TSU), Allflex (TST) or Caisley (TSU)".localized(with: sampTypeArr.count)
                            
                            
                        
                    } else {
                        
                      return "Animal in order have sample type other than Allflex (TSU), Allflex (TST) or Caisley (TSU)".localized(with: sampTypeArr.count)
                       
                    }
                    
                    //   return "\(sampTypeArr.count)"  + NSLocalizedString("Animal in order has sample type other than Allflex (TSU), Allflex (TST) or Caisley (TSU)", comment: "")
                    
                }
            }
            else if section == 1 {
                
                if bothCom.count == 0 {
                    return ""
                } else {
                    
                    
                    if bothCom.count == 1 {
                        
                        
                      return "Animal in order has sample type other than Allflex (TSU), Allflex (TST) or Caisley (TSU) and age less than 35 days.".localized(with: bothCom.count)
                        
                    } else {
                        
                        
                      return "Animal in order have sample type other than Allflex (TSU), Allflex (TST) or Caisley (TSU) and age less than 35 days.".localized(with: bothCom.count)
                        
                    }
                    
                    
                    
                    
                    
                }
            }
            else {
                
                if ageCom.count == 0 {
                    return ""
                } else {
                    
                    
                    if ageCom.count == 1{
                      return " Animal in order has age less than 35 days".localized(with: ageCom.count)
                        
                    } else  {
                      return " Animal in order have age less than 35 days".localized(with: ageCom.count)
                    }
                }
            }}
        return ""
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == parentTblView {
            
            return 3
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == parentTblView {
            
            if section == 0 {
                if sampTypeArr.count == 0 {
                    return 0
                }
                else {
                    return sampTypeArr.count
                }
            }
            else if section == 1 {
                if bothCom.count == 0 {
                    return 0
                }
                else {
                    
                    return bothCom.count
                }
            }
            else {
                
                if  ageCom.count == 0 {
                    return 0
                }
                else {
                    
                    return ageCom.count
                }
                
            }
            
        }
        
        return farmAddr.count
    }
    
    
    var radioBtnBool :Bool?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if tableView == parentTblView {
            
            if indexPath.section == 0 {
                let cell1: ListingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "StarterCell") as! ListingTableViewCell
                let datavale  = sampTypeArr[indexPath.row] as! BeefAnimaladdTbl
                cell1.firstAnimalTag?.text = datavale.animalTag
                cell1.firstBarcode?.text = datavale.animalbarCodeTag
                cell1.titleBarcode?.text = NSLocalizedString("Barcode", comment: "")
                cell1.earTagLbl?.text = NSLocalizedString("Ear Tag", comment: "")
                
                return cell1
                
            }
            else if indexPath.section == 1 {
                let cell1: ListingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DishesCell") as! ListingTableViewCell
                let datavale  = bothCom[indexPath.row] as! BeefAnimaladdTbl
                cell1.secondAnimalTag?.text = datavale.animalTag
                cell1.secondBarcode?.text = datavale.animalbarCodeTag
                
                return cell1
                
            }
            else {
                let cell1: ListingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DesertsCell") as! ListingTableViewCell
                let datavale  = ageCom[indexPath.row] as! BeefAnimaladdTbl
                cell1.thirdAnimalTag?.text = datavale.animalTag
                cell1.thirdBarcode?.text = datavale.animalbarCodeTag
                if UserDefaults.standard.integer(forKey: "BeefPvid") == 7 {
                    cell1.thirdEartagTitleLbl?.text = "Animal Tag"
                }
                
                
                return cell1
                
            }
        }
        
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "billing", for: indexPath) as? BillingTableViewCell
            
            cell?.selectionStyle = .none
            
            if farmAddr[indexPath.row].contactName! == UserDefaults.standard.value(forKey: "farmValue") as? String{
                
                cell?.radioBtnOutlet.setImage(UIImage(named: "radioSeletedBtn"), for: .normal)
                
            }
            
            else{
                cell?.radioBtnOutlet.setImage(UIImage(named: "radioBtn"), for: .normal)
                
            }
            
            cell?.AddrLbl.text = farmAddr[indexPath.row].contactName
           
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == parentTblView {
            if indexPath.section == 0 {
                let animalVal  =  sampTypeArr[indexPath.row] as! BeefAnimaladdTbl
                self.delegateCustom?.objectGetOnSelection(temp: Int(animalVal.animalId))
                UserDefaults.standard.set(Int(animalVal.animalId), forKey: "BeefAnimalIdSelectionCart")
                
                //    }
                if UserDefaults.standard.integer(forKey: "BeefPvid") == 5  {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "BeefAnimalGlobalHD50KVC") as! BeefAnimalGlobalHD50KVC
                    navigationController?.pushViewController(vc,animated: false)
                }
                else if UserDefaults.standard.integer(forKey: "BeefPvid") == 6{
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "BeefAnimalBrazilVC") as! BeefAnimalBrazilVC
                    navigationController?.pushViewController(vc,animated: false)
                }
                else {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "BeefAnimalNZ_VC") as! BeefAnimalNZ_VC
                    navigationController?.pushViewController(vc,animated: false)
                }
            }
            else if indexPath.section == 1 {
                let animalVal  =  bothCom[indexPath.row] as! BeefAnimaladdTbl
                self.delegateCustom?.objectGetOnSelection(temp: Int(animalVal.animalId))
                UserDefaults.standard.set(Int(animalVal.animalId), forKey: "BeefAnimalIdSelectionCart")
                
                //    }
                if UserDefaults.standard.integer(forKey: "BeefPvid") == 5  {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "BeefAnimalGlobalHD50KVC") as! BeefAnimalGlobalHD50KVC
                    navigationController?.pushViewController(vc,animated: false)
                }
                else if UserDefaults.standard.integer(forKey: "BeefPvid") == 6{
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "BeefAnimalBrazilVC") as! BeefAnimalBrazilVC
                    navigationController?.pushViewController(vc,animated: false)
                }
                else {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "BeefAnimalNZ_VC") as! BeefAnimalNZ_VC
                    navigationController?.pushViewController(vc,animated: false)
                }
            }
            else {
                let animalVal  =  ageCom[indexPath.row] as! BeefAnimaladdTbl
                self.delegateCustom?.objectGetOnSelection(temp: Int(animalVal.animalId))
                UserDefaults.standard.set(Int(animalVal.animalId), forKey: "BeefAnimalIdSelectionCart")
                
                //    }
                if UserDefaults.standard.integer(forKey: "BeefPvid") == 5  {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "BeefAnimalGlobalHD50KVC") as! BeefAnimalGlobalHD50KVC
                    navigationController?.pushViewController(vc,animated: false)
                }
                else if UserDefaults.standard.integer(forKey: "BeefPvid") == 6{
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "BeefAnimalBrazilVC") as! BeefAnimalBrazilVC
                    navigationController?.pushViewController(vc,animated: false)
                }
                else {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "BeefAnimalNZ_VC") as! BeefAnimalNZ_VC
                    navigationController?.pushViewController(vc,animated: false)
                }
            }
        }else {
           
            UserDefaults.standard.set(farmAddr[indexPath.row].contactName, forKey: "farmValue")
            UserDefaults.standard.set(farmAddr[indexPath.row].billToCustId, forKey: "billToCustomerId")
            
          let filterArr = farmAddr.filter({$0.isDefault == true })
          if filterArr.count > 0{
            updateBillingCustomer(entity: "GetBillingContact", customerID: self.custmerId, isDefault: false, billcustomerId: filterArr[0].billToCustId ?? "0", billcustomerName: filterArr[0].contactName ?? "")
            
          }
            UserDefaults.standard.set(farmAddr[indexPath.row].contactName, forKey: "farmValue")
            UserDefaults.standard.set(farmAddr[indexPath.row].billToCustId, forKey: "billToCustomerId")
          
          updateBillingCustomer(entity: "GetBillingContact", customerID: self.custmerId, isDefault: true, billcustomerId: farmAddr[indexPath.row].billToCustId ?? "0", billcustomerName: farmAddr[indexPath.row].contactName ?? "")
          
          farmAddr = fetchBillingCustomer(entityName: "GetBillingContact",customerID: self.custmerId) as! [GetBillingContact]
          
            let attributeString = NSMutableAttributedString(string: farmAddr[indexPath.row].contactName ?? "", attributes: self.attrs)
          //  billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
            customerNameLbl.text = farmAddr[indexPath.row].contactName ?? ""
            transparentView.isHidden = true
            billingView.isHidden = true
            tableView.reloadData()
        }
    }
  func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
    return "Delete".localized
  }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
        if tableView == parentTblView {
            let refreshAlert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Are you sure you want to remove the animal from the order?", comment: ""), preferredStyle: UIAlertController.Style.alert)
            
          refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
             
          }))
            
            refreshAlert.addAction(UIAlertAction(title:NSLocalizedString("YES", comment: "") , style: .default, handler: { (action: UIAlertAction!) in
              
                
                if editingStyle == .delete {
                    if indexPath.section == 0 {
                        
                        let animalVal  =  self.sampTypeArr[indexPath.row] as! BeefAnimaladdTbl
                        BeefDeleteDataWithProduct((Int(animalVal.animalId)))
                        beefDeleteDataWithSubProduct((Int(animalVal.animalId)))
                        beefDeleteDataWithAnimal((Int(animalVal.animalId)))
                        // }
                        
                        
                        let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                        self.notificationLblCount.text = String(animalCount.count)
                        
                        self.view.makeToast(NSLocalizedString("Animal removed from the order successfully", comment: ""), duration: 1, position: .bottom)
                        
                        if self.sampTypeArr.count == 0 {
                            
                            
                        } else {
                            
                            
                        }
                    }
                    
                    else if indexPath.section == 1 {
                        
                        let animalVal  =  self.bothCom[indexPath.row] as! BeefAnimaladdTbl
                        BeefDeleteDataWithProduct(Int(animalVal.animalId))
                        beefDeleteDataWithSubProduct(Int(animalVal.animalId))
                        beefDeleteDataWithAnimal(Int(animalVal.animalId))
                        // }
                        
                        
                        let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                        self.notificationLblCount.text = String(animalCount.count)
                        
                        self.view.makeToast(NSLocalizedString("Animal removed from the order successfully", comment: ""), duration: 1, position: .bottom)
                        
                        if self.bothCom.count == 0 {
                            //                           deleteDataProduct(entityName:"BeefAnimaladdTbl",status:"false")
                            //                           deleteDataProduct(entityName:"ProductAdonAnimlTbLBeef",status:"false")
                            //                           deleteDataProduct(entityName:"SubProductTblBeef", status: "false")
                            //                           UserDefaults.standard.removeObject(forKey: "identifyStore")
                            //                           UserDefaults.standard.removeObject(forKey: "productCount")
                            //                           UserDefaults.standard.set(nil, forKey: "On")
                            //                           UserDefaults.standard.set(nil, forKey: "page")
                            //                           UserDefaults.standard.removeObject(forKey: "breed")
                            //                           updateProductTablStatus(entity: "GetProductTblBeef")
                            //                           updateProductTablStatus(entity: "GetAdonTbl")
                            //                           UserDefaults.standard.removeObject(forKey: "pid")
                            //                            UserDefaults.standard.set(true, forKey: "showbeefproductTbl")
                            //
                            
                            
                        } else {
                            
                            
                        }
                    }
                    else  {
                        
                        let animalVal  =  self.ageCom[indexPath.row] as! BeefAnimaladdTbl
                        BeefDeleteDataWithProduct(Int(animalVal.animalId))
                        beefDeleteDataWithSubProduct(Int(animalVal.animalId))
                        beefDeleteDataWithAnimal(Int(animalVal.animalId))
                        // }
                        let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                        self.notificationLblCount.text = String(animalCount.count)
                        
                        
                        
                        self.view.makeToast(NSLocalizedString("Animal removed from the order successfully", comment: ""), duration: 1, position: .bottom)
                        
                        if self.ageCom.count == 0 {
                            
                            
                        } else {
                            
                            
                        }
                    }
                    
                    
                    // self.bckBtnOutlet.isEnabled = true
                    self.sampTypeArr.removeAllObjects()
                    self.bothCom.removeAllObjects()
                    self.ageCom.removeAllObjects()
                    if UserDefaults.standard.value(forKey: "screenBeef") as? String == "NZ"{
                      self.sampTypeArr = fetchAllDataAnimalDataBeefSampleType(entityName: "BeefAnimaladdTbl", sampleType1: "Caisley (TSU)", sampleType2: "Allflex (TSU)",sampleType3: "Allflex (TST)",orderId: orderId, pvid: self.pvid).mutableCopy() as! NSMutableArray
                        self.bothCom = fetchAllDataAnimalDataBeefSampleTypewithAge(entityName: "BeefAnimaladdTbl", sampleType1: "Caisley (TSU)", sampleType2: "Allflex (TSU)",sampleType3: "Allflex (TST)", age: 35, orderId: orderId).mutableCopy() as! NSMutableArray
                        self.ageCom =   fetchAllDataAnimalDataBeefSampleTypeAnimaTagNZ(entityName: "BeefAnimaladdTbl", aTag: 35,orderId:orderId).mutableCopy() as! NSMutableArray
                        
                        if self.bothCom.count > 0 {
                            
                            for i in 0 ..< self.bothCom.count{
                                let animaldata = self.bothCom[i] as! BeefAnimaladdTbl
                                for j in 0 ..< self.sampTypeArr.count{
                                    let animaldata1 = self.sampTypeArr[j] as! BeefAnimaladdTbl
                                    if animaldata.animalTag == animaldata1.animalTag{
                                        self.sampTypeArr.removeObject(at: j)
                                       
                                        break
                                    }
                                }
                                
                            }
                            
                            for  k in 0 ..< self.bothCom.count{
                                let animaldata = self.bothCom[k] as! BeefAnimaladdTbl
                                for l in 0 ..< self.ageCom.count{
                                    let animaldata1 = self.ageCom[l] as! BeefAnimaladdTbl
                                    if animaldata.animalTag == animaldata1.animalTag{
                                        self.ageCom.removeObject(at: l)
                                      
                                        break
                                    }
                                }
                                
                            }
                            
                        }
                        if self.sampTypeArr.count == 0 && self.bothCom.count == 0 && self.ageCom.count == 0 {
                            self.parentViewAlert.isHidden = true
                            
                            self.transparentView.isHidden = true
                            self.crossBtnOutlet.isHidden = true
                            
                        }
                        self.parentTblView.reloadData()
                        let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                        if animalCount.count == 0 {
                            UserDefaults.standard.set(false, forKey: "isAggreForSubmit")
                            deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                           // deleteRecordFromDatabase(entityName: "BeefAnimaladdTbl")
                            deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
                            deleteRecordFromDatabase(entityName: "SubProductTblBeef")
                            deleteRecordFromDatabase(entityName: "SelectedQuestionaire")
                        
                            let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
                        }
                    }
                    else {
                      self.sampTypeArr = fetchAllDataAnimalDataBeefSampleType(entityName: "BeefAnimaladdTbl", sampleType1: "Caisley (TSU)", sampleType2: "Allflex (TSU)",sampleType3: "Allflex (TST)",orderId: orderId, pvid: self.pvid).mutableCopy() as! NSMutableArray
                        
                        if self.sampTypeArr.count == 0{
                            self.parentViewAlert.isHidden = true
                            self.transparentView.isHidden = true
                            self.crossBtnOutlet.isHidden = true
                        }
                        self.parentTblView.reloadData()
                        let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                        if animalCount.count == 0 {
                            UserDefaults.standard.set(false, forKey: "isAggreForSubmit")
                            deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                            deleteRecordFromDatabase(entityName: "BeefAnimaladdTbl")
                            deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
                            deleteRecordFromDatabase(entityName: "SubProductTblBeef")
                            deleteRecordFromDatabase(entityName: "SelectedQuestionaire")
                            UserDefaults.standard.set(nil, forKey: "Beeftsu")
                            UserDefaults.standard.set(nil, forKey: "InheritBeefbreed")
                            UserDefaults.standard.set(nil, forKey: "BeefInheritTsu")
                            UserDefaults.standard.set(true, forKey: "showbeefproductTbl")
                         
                            let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
                        }
                    }
                    
                    
                    
                }
                else if editingStyle == .insert {
                    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
                }
            }))
            
           
            
            present(refreshAlert, animated: true, completion: nil)
            
        }
        
    }
    @IBAction func removeAllAction(_ sender: Any) {
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
        let refreshAlert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Are you sure you want to remove all animals in conflict from the order?", comment: ""), preferredStyle: UIAlertController.Style.alert)
        
      refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
          
      }))
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("YES", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
           
            self.view.makeToast(NSLocalizedString("All animals in conflict from the order has been cleared successfully", comment: ""), duration: 10, position: .center)
            if UserDefaults.standard.value(forKey: "screenBeef") as? String == "NZ"{
                
                if self.sampTypeArr.count > 0 {
                    
                    for i in 0 ..< self.sampTypeArr.count{
                      
                        let animalVal  =  self.sampTypeArr[i] as! BeefAnimaladdTbl
                       BeefDeleteDataWithProduct(Int(animalVal.animalId))
                        beefDeleteDataWithSubProduct(Int(animalVal.animalId))
                        beefDeleteDataWithAnimal(Int(animalVal.animalId))
                      self.deleteSigalAnimalFromList(animalbarCode: animalVal.animalbarCodeTag ?? "")
                    }
                }
                if self.bothCom.count > 0 {
                    
                    for i in 0 ..< self.bothCom.count{
                        let animalVal  =  self.bothCom[i] as! BeefAnimaladdTbl
                        BeefDeleteDataWithProduct(Int(animalVal.animalId))
                        beefDeleteDataWithSubProduct(Int(animalVal.animalId))
                        beefDeleteDataWithAnimal(Int(animalVal.animalId))
                      self.deleteSigalAnimalFromList(animalbarCode: animalVal.animalbarCodeTag ?? "")
                    }
                }
                if self.ageCom.count > 0 {
                    
                    for i in 0 ..< self.ageCom.count{
                        let animalVal  =  self.ageCom[i] as! BeefAnimaladdTbl
                        BeefDeleteDataWithProduct(Int(animalVal.animalId))
                        beefDeleteDataWithSubProduct(Int(animalVal.animalId))
                        beefDeleteDataWithAnimal(Int(animalVal.animalId))
                      self.deleteSigalAnimalFromList(animalbarCode: animalVal.animalbarCodeTag ?? "")
                    }
                }
                
                
                self.sampTypeArr.removeAllObjects()
                self.bothCom.removeAllObjects()
                self.ageCom.removeAllObjects()
                
              self.sampTypeArr = fetchAllDataAnimalDataBeefSampleType(entityName: "BeefAnimaladdTbl", sampleType1: "Caisley (TSU)", sampleType2: "Allflex (TSU)",sampleType3: "Allflex (TST)",orderId: orderId, pvid: self.pvid).mutableCopy() as! NSMutableArray
                self.bothCom = fetchAllDataAnimalDataBeefSampleTypewithAge(entityName: "BeefAnimaladdTbl", sampleType1: "Caisley (TSU)", sampleType2: "Allflex (TSU)",sampleType3: "Allflex (TST)", age: 35, orderId: orderId).mutableCopy() as! NSMutableArray
                self.ageCom =   fetchAllDataAnimalDataBeefSampleTypeAnimaTagNZ(entityName: "BeefAnimaladdTbl", aTag: 35,orderId:orderId).mutableCopy() as! NSMutableArray
                
                if self.bothCom.count > 0 {
                    
                    for i in 0 ..< self.bothCom.count{
                        let animaldata = self.bothCom[i] as! BeefAnimaladdTbl
                        for j in 0 ..< self.sampTypeArr.count{
                            let animaldata1 = self.sampTypeArr[j] as! BeefAnimaladdTbl
                            if animaldata.animalTag == animaldata1.animalTag{
                                self.sampTypeArr.removeObject(at: j)
                               
                                break
                            }
                        }
                        
                    }
                    
                    for  k in 0 ..< self.bothCom.count{
                        let animaldata = self.bothCom[k] as! BeefAnimaladdTbl
                        for l in 0 ..< self.ageCom.count{
                            let animaldata1 = self.ageCom[l] as! BeefAnimaladdTbl
                            if animaldata.animalTag == animaldata1.animalTag{
                                self.ageCom.removeObject(at: l)
                              
                                break
                            }
                        }
                        
                    }
                    
                }
                
                
                
                
                if self.sampTypeArr.count == 0 && self.bothCom.count == 0 && self.ageCom.count == 0 {
                    self.parentViewAlert.isHidden = true
                    
                    self.transparentView.isHidden = true
                    self.crossBtnOutlet.isHidden = true
                    
                }
            }
            else {
                if self.sampTypeArr.count > 0 {
                    
                    for i in 0 ..< self.sampTypeArr.count{
                        let animalVal  =  self.sampTypeArr[i] as! BeefAnimaladdTbl
                        BeefDeleteDataWithProduct(Int(animalVal.animalId))
                        beefDeleteDataWithSubProduct(Int(animalVal.animalId))
                        beefDeleteDataWithAnimal(Int(animalVal.animalId))
                        self.deleteSigalAnimalFromList(animalbarCode: animalVal.animalbarCodeTag ?? "")
                    }
                }
              self.sampTypeArr = fetchAllDataAnimalDataBeefSampleType(entityName: "BeefAnimaladdTbl", sampleType1: "Caisley (TSU)", sampleType2: "Allflex (TSU)",sampleType3: "Allflex (TST)",orderId: orderId, pvid: self.pvid).mutableCopy() as! NSMutableArray
                
                
                if self.sampTypeArr.count == 0  {
                    self.parentViewAlert.isHidden = true
                    self.transparentView.isHidden = true
                    self.crossBtnOutlet.isHidden = true
                    
                }
            }
            
            //            deleteDataProduct(entityName:"BeefAnimaladdTbl",status:"false")
            //            deleteDataProduct(entityName:"ProductAdonAnimlTbLBeef",status:"false")
            //            deleteDataProduct(entityName:"SubProductTblBeef", status: "false")
            //            UserDefaults.standard.removeObject(forKey: "identifyStore")
            //            UserDefaults.standard.removeObject(forKey: "productCount")
            //            UserDefaults.standard.set(nil, forKey: "On")
            //            UserDefaults.standard.set(nil, forKey: "page")
            //            UserDefaults.standard.removeObject(forKey: "breed")
            //            updateProductTablStatus(entity: "GetProductTblBeef")
            //            updateProductTablStatus(entity: "GetAdonTbl")
            //            UserDefaults.standard.removeObject(forKey: "pid")
            //            UserDefaults.standard.set(nil, forKey: "tsu")
            //             UserDefaults.standard.set(true, forKey: "showbeefproductTbl")
            //           // self.tblView.isHidden = true
            //            self.notificationLblCount.text = "0"
            //            //self.bckBtnOutlet.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                //if
                let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                self.notificationLblCount.text = String(animalCount.count)
                if animalCount.count == 0 {
                    UserDefaults.standard.set(false, forKey: "isAggreForSubmit")
                    deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                   // deleteRecordFromDatabase(entityName: "BeefAnimaladdTbl")
                    deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
                    deleteRecordFromDatabase(entityName: "SubProductTblBeef")
                    deleteRecordFromDatabase(entityName: "SelectedQuestionaire")
                    UserDefaults.standard.removeObject(forKey: "Beefbreed")
                    UserDefaults.standard.set(nil, forKey: "Beeftsu")
                    UserDefaults.standard.set(nil, forKey: "InheritBeefbreed")
                    UserDefaults.standard.set(nil, forKey: "BeefInheritTsu")
                    UserDefaults.standard.set(true, forKey: "showbeefproductTbl")
                   UserDefaults.standard.set(false, forKey: "BeefBVDVSeleted")
                 
                    let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
                }
                
            }
        }))
        
        
        //self.bckBtnOutlet.isEnabled = true
        
        present(refreshAlert, animated: true, completion: nil)
        
        
    }
    @IBAction func crossBtnAction(_ sender: Any) {
        transparentView.isHidden = true
        crossBtnOutlet.isHidden = true
        parentViewAlert.isHidden = true
    }
    @IBAction func editBtnAction(_ sender: Any) {
        
        //  UserDefaults.standard.set("true", forKey: "settingDone")
        UserDefaults.standard.set(1, forKey: "orderSlideTag")
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "OrderingDefaultsVC") as! OrderingDefaultsVC
        viewController.editflag = 0
        self.navigationController?.pushViewController(viewController, animated: false)
        
    }
    @IBAction func menuBtnClk(_ sender: UIButton) {
        
//        self.view.makeCorner(withRadius: 40)
//        self.sideMenuViewController?.presentRightMenuViewController()
        self.sideMenuRevealSettingsViewController()?.revealSideMenu()
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
    let beefPvid =  UserDefaults.standard.integer(forKey: "BeefPvid")
      if beefPvid == 5 {
       // applyEntireLbl.isHidden = true
          applyToEntireView.isHidden = true
          self.scrollViewTopConstraint.constant = 0
//        toggleBtnOutlet.isHidden = true
//        applyToOrderViewHeightConstraints.constant = 10
      }

       
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
              

        let userId = UserDefaults.standard.integer(forKey: "userId")
        let orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
        
        
    
        
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
        notificationLblCount.text = String(animalCount.count)
        
                
        if customerNameLbl.text != "N/A"{
            let attributeString = NSMutableAttributedString(string: (UserDefaults.standard.value(forKey: "farmValue") as! String), attributes: self.attrs)
            //billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
            customerNameLbl.text = (UserDefaults.standard.value(forKey: "farmValue")) as! String
            
        }
        
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
        
        let attributeString = NSMutableAttributedString(string: abc, attributes: self.attrs)
     //   billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                customerNameLbl.text = abc
        UserDefaults.standard.set(abc, forKey: "farmValue")
        
      }
        

        var clariText = UserDefaults.standard.value(forKey: "ProviderName") as? String
        
   //   clarifideLbl.text = "     " + (clariText ?? "")
        if UserDefaults.standard.value(forKey: "NominatorSave") == nil || UserDefaults.standard.value(forKey: "NominatorSave") as? String == ""{
            
      //    nominatorLbl.text = "     Zoetis".uppercased()
        } else {
            
            var nomi = UserDefaults.standard.value(forKey: "NominatorSave") as? String
       //   nominatorLbl.text = "     " + (nomi?.uppercased() ?? "")
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//            if self.productArr.count == 0{
//                self.colView2HeightConstraints.constant = self.collView2.contentSize.height
//            }
//            else{
//                self.colView2HeightConstraints.constant = self.collView2.contentSize.height + 50
//            }
            if self.productArr.count == 0{
                if self.arr.count <= 3 {
                    self.collectionViewHeightConstraint.constant = 160
                } else {
                    self.collectionViewHeightConstraint.constant = 210
                }
            }
            else{
                self.collectionViewHeightConstraint.constant = 350
            }
            
        }
        DispatchQueue.main.async {
            self.collView2.reloadData()
        }
//        clarifideLbl.layer.cornerRadius = (clarifideLbl.frame.height)/2
//        clarifideLbl.layer.masksToBounds = true
//        nominatorLbl.layer.cornerRadius = (nominatorLbl.frame.height)/2
//        nominatorLbl.layer.masksToBounds = true
//        reviewBttn.layer.cornerRadius = (reviewBttn.frame.height)/2
//        reviewBttn.layer.masksToBounds = true
        
        self.navigationController?.navigationBar.isHidden = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        initialNetworkCheck()
        self.navigationController?.navigationBar.isHidden = true
        transparentView.isHidden = true
        billingView.isHidden = true
        collView1.reloadData()
    }
    
    @objc  func checkForReachability(notification:Notification){
        
        let del =  UIApplication.shared.delegate as? AppDelegate
        
        self.statusText?.text = NSLocalizedString((del?.status)!, comment: "")
        
      if statusText?.text == "Connected".localized
        {
            self.statusBtn.isHidden = true
            self.connectionImg.image = UIImage(named: "status_online_sign")
        }
        else{
            
            self.statusBtn.isHidden = false
            self.connectionImg.image = UIImage(named: "status_offline")
            
        }
        
    }
    
    
    @IBAction func billingClick(_ sender: UIButton) {
        
    if customerNameLbl.text == "N/A"{
            transparentView.isHidden = true
            billingView.isHidden = true
            isBillingContact = true
        }else {
            transparentView.isHidden = false
            billingView.isHidden = false
            isBillingContact = false
            // billingTbleView.reloadData()
            
        //    billingViewHeightConst.constant = billingTbleView.contentSize.height + 100
            billingTbleView.reloadData()
            
        }
    }
    
    
    
    func initialNetworkCheck()
    {
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        
        let del =  UIApplication.shared.delegate as? AppDelegate
        
        self.statusText?.text = NSLocalizedString((del?.status)!, comment: "")
        
      if statusText?.text == "Connected".localized
        {
            self.statusBtn.isHidden = true
            self.connectionImg.image = UIImage(named: "status_online_sign")
        }
        else{
            self.statusBtn.isHidden = false
            self.connectionImg.image = UIImage(named: "status_offline")
            
        }
    }
    
    @IBAction func crossClick(_ sender: UIButton) {
        transparentView.isHidden = true
        billingView.isHidden = true
        
        
    }
    @IBAction func reviewOrderAction(_ sender: UIButton) {
      
        
        let userId1 = UserDefaults.standard.integer(forKey: "userId")
       // var orderId1 = UserDefaults.standard.integer(forKey: "orderId")
        UserDefaults.standard.set(false, forKey: "isAggreForSubmit")
        
        let currentCustomerId = UserDefaults.standard.value(forKey: "currentActiveCustomerId") as? Int
        let orderIdBeef = UserDefaults.standard.integer(forKey: "orderIdBeef")

       // sender.isSelected = true
        
        
       
       if UserDefaults.standard.string(forKey: "BrazilGenotype") == "Genotype"
       {
        UserDefaults.standard.set(true, forKey: "beefplaceordercheck")
           UserDefaults.standard.set(true, forKey: "addDealerCodeCheck")

        UserDefaults.standard.set(false, forKey: "beefemailcheckvalue")
       }
        else
       {
        
        
        var fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: "BeefAnimaladdTbl",orderId:orderIdBeef,userId:userId1,customerId:currentCustomerId ?? 0,date:"")
        if fetchAnimalTbl.count == 0
        {
            UserDefaults.standard.set(true, forKey: "beefplaceordercheck")
            UserDefaults.standard.set(true, forKey: "addDealerCodeCheck")

            UserDefaults.standard.set(false, forKey: "beefemailcheckvalue")
        }
        else
        {
            UserDefaults.standard.set(false, forKey: "beefplaceordercheck")
            UserDefaults.standard.set(true, forKey: "beefemailcheckvalue")
            UserDefaults.standard.set(false, forKey: "addDealerCodeCheck")

        }
       }
        
     
//         if fetchAnimalTbl.count == 0
//         {
//        UserDefaults.standard.set(false, forKey: "checkvalue")
//         }
//        else
//         {
//            UserDefaults.standard.set(true, forKey: "checkvalue")
//         }
        
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
        if billingBtnOutlet.titleLabel?.text == "N/A"{
            transparentView.isHidden = false
            billingView.isHidden = false
            isBillingContact = false
        }
        else{
            transparentView.isHidden = true
            billingView.isHidden = true
            isBillingContact = true
            // UserDefaults.standard.set(true, forKey: "review")
            let fethData =  BeefFetchproductData(status: "true", orderStatus: "false", orderId: orderId,userId:userId)
            if fethData.count > 0{
                let storyBoard: UIStoryboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "BeefReviewOrderVCIpad") as! BeefReviewOrderVCIpad
                self.navigationController?.pushViewController(newViewController, animated: false)
                
            } else {
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please select the product.", comment: ""))
                
            }
        }
        
    }
    
    @IBAction func statusBtnAction(_ sender: UIButton) {
        
        //  UserDefaults.standard.set(true, forKey: "userlogin")
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OffLineRestrictionVC") as! OffLineRestrictionVC
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
        
        
    }
    
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    
      @IBAction func offlineBtnAction(_ sender: UIButton) {
        
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(OrderingProductSelectionVC.buttonbgPressed), for: .touchUpInside)
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
extension BeefOPSiPadVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
}

extension BeefOPSiPadVC : SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}


private typealias DeleteDataListHelper = BeefOPSiPadVC
extension DeleteDataListHelper {
   func getListName()  {
     listName = orderingDatalistVM.makeListName(custmerId: custmerId ?? 0, providerID: pvid)
     if pvid == 6 {
       var productType  = ""
           if UserDefaults.standard.string(forKey: "beefProduct") == "Genotype Only" {
             productType = "Genotype Only"
            
           }else  if UserDefaults.standard.string(forKey: "beefProduct") == "GenotypeStarblack" {
             productType = "GenotypeStarblack"
             
           }else  if UserDefaults.standard.string(forKey: "beefProduct") == "GenStarblack" {
             productType = "GenStarblack"
             
           }
           else {
             productType = "Non-Genotype"
             
           }
       fetchDataEntry =  fetchAllDataEnteryList(entityName: "DataEntryList",customerId:Int64(custmerId ?? 0),listName: listName ,productName:"Beef") as! [DataEntryList]
       
       
     } else {
       fetchDataEntry  = fetchAllDataEnteryList(entityName: "DataEntryList",customerId:Int64(self.custmerId ?? 0),listName:listName ,productName:"Beef") as! [DataEntryList]
     }
    
  }
  func deleteSigalAnimalFromList(animalbarCode :String) {
    
    if fetchDataEntry.count > 0 {
      let fetchAllDatalistAnimals =  fetchAllDataAnimalDaWithOutOrderId(entityName: "DataEntryBeefAnimaladdTbl", userId: userId,orderStatus:"false",listid:Int64(fetchDataEntry[0].listId), custmerId: Int64(custmerId ), providerId: pvid) as! [DataEntryBeefAnimaladdTbl]
      
      
      if fetchAllDatalistAnimals.count > 0{
        let filterdatalistAnimal = fetchAllDatalistAnimals.filter({ $0.animalbarCodeTag == animalbarCode})
        if filterdatalistAnimal.count > 0 {
          let animalVal = filterdatalistAnimal[0]
          if !Connectivity.isConnectedToInternet() {
            saveDeletedDataListAnimal(entity: "DataEntryOfflineDeletedAnimal", animalID: Int(animalVal.animalId), listID: Int(fetchDataEntry[0].listId), customerID: Int64(UserDefaults.standard.integer(forKey: "currentActiveCustomerId")), serverAnimalID: animalVal.serverAnimalId ?? "", speciesID: "151e2230-9a01-4828-a105-d87a92b5be2f")
          }
          self.objApiSync.postListDataDeleteBeef(listId:fetchDataEntry[0].listId,custmerId:Int64(UserDefaults.standard.integer(forKey: "currentActiveCustomerId")), clearOrder: false, animalId: Int(animalVal.animalId))
          deleteAnimalfromdataEntry(enitityName:Entities.dataEntryBeefAnimalAddTblEntity, Int(animalVal.animalId), listId: Int(animalVal.listId))
         // beefDeleteDataWithAnimalDataEntry(Int(animalVal.animalId))
        }
      }
    }
  }
  
  func createListNameAndCheckifExist(){
   
    if fetchDataEntry.count > 0 {
      self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
      self.view.isUserInteractionEnabled = false
      deleteList(listName: listName, customerId: Int64(custmerId ?? 0),listID: Int(fetchDataEntry[0].listId))
    }
    
  }
  func deleteList(listName: String, customerId: Int64, listID: Int) {
  
      let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
     // let accessToken = appDelegate?.keychain_valueForKey("accessToken") as? String
   let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String
      let headerDict = ["Authorization": accessToken!,"Content-Type" : "application/x-www-form-urlencoded"]
      var header = HTTPHeaders(headerDict ?? ["Content-Type": "application/x-www-form-urlencoded","Accept": "application/json"])
      
      let urlString = Configuration.Dev(packet: ApiKeys.deleteList.rawValue).getUrl()
      let parameters : [String: Any] = ["customerId": customerId,"listName":listName]
      
      var request = URLRequest(url: URL(string: urlString)! )
      request.httpMethod = "DELETE"
      request.allHTTPHeaderFields = headerDict
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      do {
          request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
      } catch let error {
          print(error.localizedDescription)
      }
      
      AF.request(request as URLRequestConvertible).responseJSON { response in
          let statusCode =  response.response?.statusCode
          if statusCode == 200 {
            //  var messageBundle = listName + " list for Customer " + "\(customerId)" + " has been deleted"
          //  CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString(messageBundle, comment: ""))
            //  self.view.makeToast(NSLocalizedString("List deleted successfully.", comment: ""), duration: 2, position: .bottom)
            self.hideIndicator()
            self.view.isUserInteractionEnabled = true
            deleteDataWithListIdDatEntry(entityString: "DataEntryBeefAnimaladdTbl", listId: Int(listID), customerId: Int(customerId ),userId:1)
           
            deleteDataWithListId(entityString: "DataEntryList", listId: Int64(listID), customerId: Int(customerId ),userId:1)
          }
          
          
      }
  }
}
