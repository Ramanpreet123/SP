//
//  OPSelectioniPadVC.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 27/01/25.
//

import Foundation
import CoreData
import Alamofire

//MARK: ORDERING PRODUCT SELECTION CLASS
class OPSelectioniPadVC: UIViewController{
    
    //MARK: IB OUTLETS
    @IBOutlet weak var addOnCollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var productCollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var nominatorView: UIView!
    @IBOutlet weak var menuIconLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var billingViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var customerNameLbl: UILabel!
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var clarifideTransparentView: UIView!
    @IBOutlet weak var lable2TopConstraint: NSLayoutConstraint!
    @IBOutlet weak var clariifdeView: UIView!
    @IBOutlet weak var billingTbleView: UITableView!
    @IBOutlet weak var customView: UIView!
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
    @IBOutlet weak var nominatorHeightConst: NSLayoutConstraint!
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var clarifideLbl1: UILabel!
    @IBOutlet weak var clarifideLbl2: UILabel!
    @IBOutlet weak var clarifideLbl3: UILabel!
    @IBOutlet weak var lastView: UIView!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var statusBtn: UIButton!
    @IBOutlet weak var connectionImg: UIImageView!
    @IBOutlet weak var billingBtnOutlet: UIButton!
    @IBOutlet weak var tbblView: UITableView!
    @IBOutlet weak var nominatorLbl: UILabel!
    @IBOutlet weak var clarifideLbl: UILabel!
    @IBOutlet weak var reviewBttn: UIButton!
    @IBOutlet weak var colView1HeightConstraints:NSLayoutConstraint!
    @IBOutlet weak var collView1: UICollectionView!
    @IBOutlet weak var colView2HeightConstraints:NSLayoutConstraint!
    @IBOutlet weak var collView2: UICollectionView!
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var clariFideOkBtn: UIButton!
    @IBOutlet weak var removeBtnOutlet: UIButton!
    @IBOutlet weak var bvdvProductSelectionTitle: UILabel!
    @IBOutlet weak var bvdvPopUpTitle: UILabel!
    @IBOutlet weak var applyToEntrieTitle: UILabel!
    @IBOutlet weak var selectBillingContact: UILabel!
    @IBOutlet weak var orderingProductSelectionTilte: UILabel!
    @IBOutlet weak var orderDefaultOutlet: UILabel!
    @IBOutlet weak var addOnProductLbl: UILabel!
    @IBOutlet weak var appStatusLbl: UILabel!
    @IBOutlet weak var billingContactLbl: UILabel!
    @IBOutlet weak var crossBtnOutlet: UIButton!
    
    
    //MARK: VARIABLES AND CONSTANTS
    var fetchDataEntry : [DataEntryList] = []
    var objApiSync = ApiSyncList()
    var listName = String()
    let orderingDatalistVM = OrderingDataListViewModel()
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    var radioBtnBool :Bool?
    var flowHeightConstraint: NSLayoutConstraint?
    let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
    var sampTypeArr = NSArray()
    var bothCom = NSMutableArray()
    var ageCom = NSMutableArray()
    var delegateCustom : objectPickCartScreen?
    var value = 0
    var custmerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int
    var farmAddr = [GetBillingContact]()
    var attrs : [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 12),
        .foregroundColor: UIColor.blue,
        .underlineStyle: NSUnderlineStyle.single.rawValue]
    let buttonbg1 = UIButton ()
    var customPopView1 :TipPopUp!
    var arr = NSArray()
    var breedId = String()
    var productArr = NSArray()
    var infoArr = NSArray()
    var data1 = NSArray()
    var productId = Int()
    var productname = String()
    var mkId : Int?
    var isBillingContact = true
    var scrollValue = 0
    var selectedCellIndex = Int()
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
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
   
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIOnDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUIOnWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setUIOnDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(Notification.Name(keyValue.notificationIdentifier.rawValue))
    }
    
    override func viewWillLayoutSubviews() {
        // scrollValue = Int(lastView.frame.height + editBttn.frame.height )
    }
    
    override func viewDidLayoutSubviews() {
        // reviewBttn.layer.cornerRadius = reviewBttn.frame.height/2
        //    clarifideLbl.layer.cornerRadius = clarifideLbl.frame.height/2
        //    nominatorLbl.layer.cornerRadius = nominatorLbl.frame.height/2
        //    colView1HeightConstraints.constant = collView1.contentSize.height
        //    if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) != keyValue.clarifideCDCBUS.rawValue {
        //      lastViewHeight.constant = 100
        //    } else {
        //      lastViewHeight.constant = 100
        //    }
    }
    
    //MARK: INITIAL UI METHODS
    func setUIOnDidLoad(){
        self.setSideMenu()
        validateBreed()
        farmAddr = fetchBillingCustomer(entityName: Entities.getBillingContactEntity,customerID: self.custmerId) as! [GetBillingContact]
        
        billingTbleView.isEditing = false
        heartBeatViewModel?.callGetHearBeatData()
        UserDefaults.standard.set(nil, forKey: keyValue.submitTypeSelection.rawValue)
        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
        clarifideLbl1.text = NSLocalizedString(LocalizedStrings.ahdbSupportedBreeds, comment: "")
        clarifideLbl2.text = NSLocalizedString(LocalizedStrings.cdcbSupportedBreeds, comment: "")
        clarifideLbl3.text = NSLocalizedString(LocalizedStrings.zoetisSupportedBreedsWithoutSpace, comment: "")
        clarifideTransparentView.isHidden = true
        clariifdeView.isHidden = true
        languageConversion(languageId: langId!)
        parentView.isHidden = true
        crossBtnOutlet.isHidden = true
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.navigationBar.isHidden = true
        collView1.delegate = self
        collView1.dataSource = self
        collView2.delegate = self
        collView2.dataSource = self
        let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        breedId =  UserDefaults.standard.value(forKey: keyValue.breed.rawValue) as? String ?? ""
        
        if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
            arr = fetchproviderProductDataBreedIdIScdcbProduct(entityName: Entities.getProductTblEntity, provId: pvid, breedId: breedId)
        } else {
            if breedId == ""{
                if pvid == 8{
                    breedId = "ea9b9e1b-cde8-4b7e-9207-5f699ad7df53"
                }
            }
            arr = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: pvid, breedId: breedId)
        }
        
        data1 = fetchAllDataWithOrderID(entityName: Entities.animalAddTblEntity,orderId:orderId,userId:userId)
        let fetchPid = fetchAllProductlistBreed(entityName: Entities.getProductTblEntity, status: "true",providerId:pvid,breedId:breedId)
        if fetchPid.count > 0 {
            let pid = fetchPid [0] as! GetProductTbl
            for j in 0 ..< data1.count {
                let animal = data1.object(at: j) as! AnimaladdTbl
                updateProducDataSingleanimalId(entity: Entities.productAdonAnimalTblEntity, productID:Int(pid.productId), status: "true", animalId: Int(animal.animalId),orderId:orderId,userId: userId)
                let fetchadon = fetchAllAdonSingle(entityName:Entities.getAdonTblEntity , status: "true", productId: Int(pid.productId))
                updateAnimalTblDataDairystatus(entity: Entities.animalAddTblEntity, status: "true", animalTag: Int(animal.animalId), orderId: orderId, userId: userId)
                
                if fetchadon.count > 0{
                    for i in 0 ..< fetchadon.count {
                        let adonId  = fetchadon.object(at: i) as! GetAdonTbl
                        updateAdonDataSingle(entity: Entities.getAdonTblEntity, adonId: Int(adonId.adonId) , status: "true")
                        updateAdonDataSingleanimalId(entity: Entities.subProductTblEntity, pid: Int(pid.productId),adonId: Int(adonId.adonId) , status: "true", animalId:Int(animal.animalId),ordeId:orderId,userId: userId)
                    }
                }
            }
            
            if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                productArr = fetchProductAdonData(entityName : Entities.getAdonTblEntity,prodId: Int(pid.productId),isCdcbProduct:false)
            }
            else {
                productArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(pid.productId))
            }
        }
        
        if UserDefaults.standard.value(forKey: keyValue.farmValue.rawValue) as? String == nil{
            //  billingBtnOutlet.setTitle("N/A", for: .normal)
            customerNameLbl.text = "N/A"
        }
        else {
            //      billingBtnOutlet.setTitle(UserDefaults.standard.value(forKey: keyValue.farmValue.rawValue) as? String, for: .normal)
            //      billingBtnOutlet.titleLabel?.numberOfLines = 2
            //      billingBtnOutlet.titleLabel?.lineBreakMode = .byWordWrapping
           
            customerNameLbl.text = UserDefaults.standard.value(forKey: keyValue.farmValue.rawValue) as? String
//            if customerNameLbl.text!.count > 28 {
//                customerNameLbl.font = customerNameLbl.font.withSize(14)
//            } else {
                customerNameLbl.font = customerNameLbl.font.withSize(22)
            
        }
    }
    
    
    func setUIOnWillAppear(){
        self.getListName()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid)
        notificationLblCount.text = String(animalCount.count)
        
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
        
        if billingBtnOutlet.titleLabel?.text != "N/A"{
            let attributeString = NSMutableAttributedString(string: (UserDefaults.standard.value(forKey: keyValue.farmValue.rawValue) as? String ?? ""), attributes: self.attrs)
            //   billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
         
            customerNameLbl.text = UserDefaults.standard.value(forKey: keyValue.farmValue.rawValue) as? String ?? ""
//            if customerNameLbl.text!.count > 17 {
//                customerNameLbl.font = customerNameLbl.font.withSize(14)
//            } else {
//                customerNameLbl.font = customerNameLbl.font.withSize(22)
//            }
        }
        let clariText = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
        if self.pvid != 12 {
            clarifideLbl.font = clarifideLbl.font.withSize(20)
        } else {
            clarifideLbl.font = clarifideLbl.font.withSize(16)
        }
        clarifideLbl.text = (clariText ?? "")
//        if self.clarifideLbl.text!.count > 21 {
//            self.clarifideLbl.font = self.clarifideLbl.font.withSize(15)
//        } else {
//            self.clarifideLbl.font = self.clarifideLbl.font.withSize(22)
//        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            //            if self.productArr.count == 0{
            //                //    self.colView2HeightConstraints.constant = self.collView2.contentSize.height
            //            }
            //            else{
            //                //  self.colView2HeightConstraints.constant = self.collView2.contentSize.height + 50
            //            }
            if self.productArr.count == 0{
                if self.arr.count <= 4 {
                    self.collectionViewHeightConstraint.constant = 150
                } else {
                    self.collectionViewHeightConstraint.constant = 210
                }
                
            }
            else{
                if self.arr.count <= 4 {
                    self.productCollViewHeight.constant = 100
                    if self.productArr.count > 5 {
                        self.addOnCollViewHeight.constant = 130
                        self.collectionViewHeightConstraint.constant = 350
                    } else {
                        self.addOnCollViewHeight.constant = 90
                        self.collectionViewHeightConstraint.constant = 310
                    }
                } else {
                    self.productCollViewHeight.constant = 162
                    if self.productArr.count > 5 {
                        self.addOnCollViewHeight.constant = 130
                        self.collectionViewHeightConstraint.constant = 440
                    } else {
                        self.addOnCollViewHeight.constant = 90
                        self.collectionViewHeightConstraint.constant = 370
                    }
                }
            }
        }
        DispatchQueue.main.async {
            self.collView2.reloadData()
        }
        //    clarifideLbl.layer.cornerRadius = (clarifideLbl.frame.height)/2
        //   clarifideLbl.layer.masksToBounds = true
        //   nominatorLbl.layer.cornerRadius = (nominatorLbl.frame.height)/2
        //   nominatorLbl.layer.masksToBounds = true
        //   reviewBttn.layer.cornerRadius = (reviewBttn.frame.height)/2
        //   reviewBttn.layer.masksToBounds = true
        self.navigationController?.navigationBar.isHidden = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        initialNetworkCheck()
        self.navigationController?.navigationBar.isHidden = true
        transparentView.isHidden = true
        billingView.isHidden = true
    }
    
    func setUIOnDidAppear(){
        UserDefaults.standard.set(nil, forKey: keyValue.page.rawValue)
        if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) == keyValue.clarifideCDCBUS.rawValue {
            nominatorLbl.isHidden = false
            nominatorTitle.isHidden = false
            nominatorView.isHidden = false
        }
        else{
            nominatorLbl.isHidden = true
            nominatorTitle.isHidden = true
            nominatorView.isHidden = true
        }
        
        if self.productArr.count == 0{
            if self.arr.count <= 4 {
                self.collectionViewHeightConstraint.constant = 150
            } else {
                self.collectionViewHeightConstraint.constant = 210
            }
            
        }
        else{
            if self.arr.count <= 4 {
                self.productCollViewHeight.constant = 100
                if self.productArr.count > 5 {
                    self.addOnCollViewHeight.constant = 130
                    self.collectionViewHeightConstraint.constant = 350
                } else {
                    self.addOnCollViewHeight.constant = 90
                    self.collectionViewHeightConstraint.constant = 310
                }
            } else {
                self.productCollViewHeight.constant = 162
                if self.productArr.count > 5 {
                    self.addOnCollViewHeight.constant = 130
                    self.collectionViewHeightConstraint.constant = 440
                } else {
                    self.addOnCollViewHeight.constant = 90
                    self.collectionViewHeightConstraint.constant = 370
                }
            }
        }
    }
    
    //MARK: METHODS AND FUNCTIONS
    func validateBreed() {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        let data1 = fetchAllDataOrderStatus(entityName: Entities.animalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
        var bredidd123 = String ()
        if data1.count > 0 {
            let breeid1 = data1.object(at: 0) as! AnimaladdTbl
            bredidd123 = breeid1.breedName ?? ""
        }
        
        if data1.count == 1 {
            let breeid1 = data1.object(at: 0) as! AnimaladdTbl
            UserDefaults.standard.set(false, forKey: keyValue.identifyStore.rawValue)
            UserDefaults.standard.set(breeid1.breedId, forKey: keyValue.breed.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.page.rawValue)
        }
        else {
            for i in 0 ..< data1.count{
                let breeid1 = data1.object(at: i) as! AnimaladdTbl
                
                if bredidd123 == breeid1.breedName {
                    UserDefaults.standard.set(false, forKey: keyValue.identifyStore.rawValue)
                    UserDefaults.standard.set(breeid1.breedId, forKey: keyValue.breed.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.page.rawValue)
                }
                else{
                    UserDefaults.standard.set(true, forKey: keyValue.identifyStore.rawValue)
                    break
                }
                bredidd123 = breeid1.breedName ?? ""
            }
        }
    }
    func languageConversion(languageId :Int){
        //    clariFideOkBtn.setTitle(NSLocalizedString(ButtonTitles.closeText, comment: ""), for: .normal)
        //   bvdvPopUpTitle.text = NSLocalizedString(ButtonTitles.bvdvSelectionConflict, comment: "")
        //    bvdvProductSelectionTitle.text = ButtonTitles.bvdvProdSelection.localized
        //    removeBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.removeAllStr, comment: ""), for: .normal)
        //   applyToEntrieTitle.text = ButtonTitles.applyToEntireOrder.localized
        //   reviewBttn.setTitle(NSLocalizedString(ButtonTitles.reviewOrderText, comment: ""), for: .normal)
        //    selectBillingContact.text = NSLocalizedString(ButtonTitles.selectBillingContactText, comment: "")
        //    orderingProductSelectionTilte.text = NSLocalizedString(ButtonTitles.orderProdSelectiontext, comment: "")
        //    orderDefaultOutlet.text = ButtonTitles.orderDefaultsText.localized
        //    evaluationLbl.text = NSLocalizedString(LocalizedStrings.providerMarkets, comment: "")
        //    editBttn.setTitle(ButtonTitles.editText.localized, for: .normal)
        //    appStatusLbl.text = NSLocalizedString(ButtonTitles.appStatusText, comment: "")
        //    addOnProductLbl.text = NSLocalizedString(ButtonTitles.addOnProdText, comment: "")
        //    billingContactLbl.text = NSLocalizedString(LocalizedStrings.billingContact, comment: "")
        //    nominatorTitle.text = ButtonTitles.nominatorText.localized
    }
    
    func reloadAddOns(collectionView: UICollectionView,indexPath: IndexPath){
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        showIndicator(self.view, withTitle: NSLocalizedString(LocalizedStrings.updatingStr, comment: ""), and: "")
        let data = arr[indexPath.item] as! GetProductTbl
        let pId = data.productId
        productId = Int(pId)
        productname = data.productName ?? ""
        UserDefaults.standard.integer(forKey: keyValue.pidKey.rawValue)
        let productId1 = UserDefaults.standard.integer(forKey: keyValue.pdId.rawValue)
        let data12333 = fetchProductAdonDataStatus(entityName: Entities.getProductTblEntity, prodId: productId, status: "true")
        if data12333.count > 0{
            collView1.reloadData()
            collView2.reloadData()
            self.hideIndicator()
            return
        }
        let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
        if providerName == keyValue.auDairyProducts.rawValue{
            if productname == LocalizedStrings.providerClarifidePlusUpgrade ||  productname == LocalizedStrings.providerClarifideDataGeneUpgrade ||  productname == LocalizedStrings.providerClarifideCDCBUpgrade{
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalsHavingClarifideCDCB, comment: ""))
                self.hideIndicator()
            }
        }
        else if providerName == keyValue.clarifideAHDBUK.rawValue{
            if  productname == LocalizedStrings.providerClarifideCDCBUpgrade || productname == LocalizedStrings.providerClarifidePlusUpgrade || productname == LocalizedStrings.providerClarifideAHDBUpgrade{
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalsHavingClarifideAHDB, comment: ""))
                self.hideIndicator()
            }
        }
        else {
            if  productname == LocalizedStrings.providerClarifidePlusUpgrade {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalsHavingClarifide, comment: ""))
                self.hideIndicator()
            }
        }
        
        UserDefaults.standard.set(productId, forKey: keyValue.pidKey.rawValue)
        UserDefaults.standard.set(productId, forKey: keyValue.pdId.rawValue)
        if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
            productArr = fetchProductAdonData(entityName : Entities.getAdonTblEntity,prodId: Int(pId),isCdcbProduct:false)
        }
        else {
            productArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(pId))
        }
        let item = collectionView.cellForItem(at: indexPath) as! OrdingProductSelectionCollectionViewCell
        item.Lbl.backgroundColor = UIColor(red: 220/255, green: 54/255, blue: 72/255, alpha: 1)
        item.Lbl.textColor = UIColor.white
        for i in 0 ..< data1.count{
            let animaldata = data1[i] as! AnimaladdTbl
            updateAnimalTblDataDairy(entity: Entities.animalAddTblEntity, status:"true", animalTag: Int(animaldata.animalId), orderId: orderId, userId: userId,completionHandler: { (success) -> Void in
                
                if success {
                    updateAnimalTblDataDairy(entity: Entities.productAdonAnimalTblEntity, status: "false", animalTag: Int(animaldata.animalId), orderId: orderId, userId: userId,completionHandler: { (success) -> Void in
                        
                        if success {
                            updateAnimalTblDataDairy(entity: Entities.subProductTblEntity, status: "false", animalTag: Int(animaldata.animalId), orderId: orderId, userId: userId, completionHandler: { (success) -> Void in
                                
                                if success {
                                    updateProductTablData(entity: Entities.getProductTblEntity, status: "false", completionHandler: { (success) -> Void in
                                        if success {
                                            updateProductTablData(entity: Entities.getAdonTblEntity, status: "false",completionHandler: { (success) -> Void in
                                                
                                                if success {
                                                    updateProducDataDairy(entity: Entities.productAdonAnimalTblEntity, productID: productId, status: "true", animalTag: Int(animaldata.animalId), orderId: orderId,userId:userId, completionHandler: { (success) -> Void in
                                                        
                                                        if success {
                                                            updateProductTabl(entity: Entities.getProductTblEntity, productId: Int(pId), status: "true",completionHandler: { (success) -> Void in
                                                                if success {
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
        collView1.reloadData()
        collView2.reloadData()
        self.hideIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if self.productArr.count == 0{
                if self.arr.count <= 4 {
                    self.collectionViewHeightConstraint.constant = 150
                } else {
                    self.collectionViewHeightConstraint.constant = 210
                }
                
            }
            else{
                if self.arr.count <= 4 {
                    self.productCollViewHeight.constant = 100
                    if self.productArr.count > 5 {
                        self.addOnCollViewHeight.constant = 130
                        self.collectionViewHeightConstraint.constant = 350
                    } else {
                        self.addOnCollViewHeight.constant = 90
                        self.collectionViewHeightConstraint.constant = 310
                    }
                } else {
                    self.productCollViewHeight.constant = 162
                    if self.productArr.count > 5 {
                        self.addOnCollViewHeight.constant = 130
                        self.collectionViewHeightConstraint.constant = 440
                    } else {
                        self.addOnCollViewHeight.constant = 90
                        self.collectionViewHeightConstraint.constant = 370
                    }
                }
            }
            self.collView1.reloadData()
            self.collView2.reloadData()
        }
    }
    
    func initialNetworkCheck(){
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del =  UIApplication.shared.delegate as? AppDelegate
        self.statusText?.text = NSLocalizedString((del?.status)!, comment: "")
        if statusText?.text == ButtonTitles.connectedText.localized{
            self.statusBtn.isHidden = true
            self.connectionImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else{
            self.statusBtn.isHidden = false
            self.connectionImg.image = UIImage(named: ImageNames.statusOfflineImg)
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
    
    func sideMenuRevealSettingsViewController() -> OPSelectioniPadVC? {
        var viewController: UIViewController? = self
        
        if viewController != nil && viewController is OPSelectioniPadVC {
            return viewController! as? OPSelectioniPadVC
        }
        while (!(viewController is OPSelectioniPadVC) && viewController?.parent != nil) {
            viewController = viewController?.parent
        }
        if viewController is OPSelectioniPadVC {
            return viewController as? OPSelectioniPadVC
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

    //MARK: OBJC SELECTOR METHODS
    @objc func buttonbgPressed (){
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
    @objc func openPopUp(_ sender: UIButton){
        let arrayGet = self.productArr[sender.tag] as! GetAdonTbl
        let textValueEnglish = arrayGet.value(forKey: keyValue.textValueEnglish.rawValue) as? String
        let textValuePortugese = arrayGet.value(forKey: keyValue.textValuePortugese.rawValue) as? String
        let textValueItalian = arrayGet.value(forKey: keyValue.textValueItalian.rawValue) as? String
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        if langId == 1 {
            let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.commanInfoPopUpControllerVC) as! CommanInfoPopUpController
            vc.stringGetThroughArray = textValueEnglish ?? ""
            self.navigationController?.present(vc, animated: false, completion: nil)
        } else if langId == 3 {
            let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.commanInfoPopUpControllerVC) as! CommanInfoPopUpController
            vc.stringGetThroughArray = textValueItalian ?? ""
            self.navigationController?.present(vc, animated: false, completion: nil)
        }
        else {
            let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.commanInfoPopUpControllerVC) as! CommanInfoPopUpController
            vc.stringGetThroughArray = textValuePortugese ?? ""
            self.navigationController?.present(vc, animated: false, completion: nil)
        }
    }
    
    @objc func InfobuttonClicked(sender: UIButton){
        let buttonRow = sender.tag
        clarifideTransparentView.isHidden = false
        clariifdeView.isHidden = false
        clarifideTransparentView.frame = self.view.frame
    }
    
    @objc func buttonbgPressedTipTerms () {
        buttonbg1.removeFromSuperview()
        customPopView1.removeFromSuperview()
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        if value == 0{
            UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
            let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
            self.hideIndicator()
            value = value + 1
        }
    }
    
    @objc func checkForReachability(notification:Notification){
        let del =  UIApplication.shared.delegate as? AppDelegate
        self.statusText?.text = NSLocalizedString((del?.status)!, comment: "")
        if statusText?.text == ButtonTitles.connectedText.localized {
            self.statusBtn.isHidden = true
            self.connectionImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else {
            self.statusBtn.isHidden = false
            self.connectionImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    
    //MARK: IB ACTIONS
    @IBAction func clarifideOkBtnAction(_ sender: Any) {
        clarifideTransparentView.isHidden = true
        clariifdeView.isHidden = true
    }
    
    @IBAction func viewAnimalClick(_ sender: Any) {
        let vc = UIStoryboard.init(name: "DairyPlaceAnOrder", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewAnimalsControlleriPadVC") as? ViewAnimalsControlleriPadVC
        vc!.screenBackSave = false
        vc!.productBackSave = false
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func switchToggleAction(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if(appDelegate.switchFlag == 0) {
            let storyboard = UIStoryboard(name: "DairyPlaceAnOrder", bundle: Bundle.main)
        
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "OPSSecondVCiPad")), animated: true)
        }
    }
    
    @IBAction func backBtnClk(_ sender: UIButton) {
    
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
        vc?.module = LocalizedStrings.addOrderingAnimalsText.localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
    }
    
    @IBAction func removeAllAction(_ sender: UIButton) {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        let refreshAlert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.removeAllAnimalsInConflict, comment: ""), preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
        }))
        
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
            self.view.makeToast(NSLocalizedString(AlertMessagesStrings.clearedAnimalsInConflict, comment: ""), duration: 0.1, position: .center)
            if self.sampTypeArr.count > 0 {
                for i in 0 ..< self.sampTypeArr.count{
                    let animalVal  =  self.sampTypeArr[i] as! AnimaladdTbl
                    deleteDataWithProduct(Int(animalVal.animalId))
                    deleteDataWithSubProduct(Int(animalVal.animalId))
                    deleteDataWithAnimal(Int(animalVal.animalId))
                    self.deleteSigalAnimalFromList(animalbarCode: animalVal.animalbarCodeTag ?? "")
                }
            }
            self.sampTypeArr = fetchAllDataAnimalDataBeefSampleType(entityName: Entities.animalAddTblEntity, sampleType1: ButtonTitles.caisleyTSUText, sampleType2: ButtonTitles.allflexTSUText,sampleType3: ButtonTitles.allflexTSTText,orderId: orderId,pvid: self.pvid).mutableCopy() as! NSMutableArray
            if self.sampTypeArr.count == 0  {
                self.parentView.isHidden = true
                self.transparentView.isHidden = true
                self.crossBtnOutlet.isHidden = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid)
                self.notificationLblCount.text = String(animalCount.count)
                if animalCount.count == 0 {
                    UserDefaults.standard.removeObject(forKey: keyValue.identifyStore.rawValue)
                    UserDefaults.standard.removeObject(forKey: keyValue.productCount.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.onKey.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.page.rawValue)
                    UserDefaults.standard.removeObject(forKey: keyValue.breed.rawValue)
                    updateProductTablStatus(entity: Entities.getProductTblEntity)
                    updateProductTablStatus(entity: Entities.getAdonTblEntity)
                    UserDefaults.standard.removeObject(forKey: keyValue.pidKey.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.girlandoSampleType.rawValue)
                    UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.tsuKey.rawValue)
                    UserDefaults.standard.set("False", forKey: keyValue.isAuSelected.rawValue)
                    UserDefaults.standard.removeObject(forKey: keyValue.bvdvValidation.rawValue)
                    UserDefaults.standard.removeObject(forKey: keyValue.capsBreedName.rawValue)
                    UserDefaults.standard.removeObject(forKey: keyValue.submitBtnFlag.rawValue)
                    UserDefaults.standard.removeObject(forKey: keyValue.isAgreeForSubmit.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.bvdvSelected.rawValue)
                  
                    let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
                }
            }
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    @IBAction func crossBtnAction(_ sender: UIButton) {
        parentView.isHidden = true
        crossBtnOutlet.isHidden = true
        transparentView.isHidden = true
    }
    
    @IBAction func editBtnAction(_ sender: Any) {
        UserDefaults.standard.set(1, forKey: keyValue.orderSlideTag.rawValue)
        let storyboard = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.orderingDefaultVC) as! OrderingDefaultsVC
        viewController.editflag = 0
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    @IBAction func menuBtnClk(_ sender: UIButton) {
        self.sideMenuRevealSettingsViewController()?.revealSideMenu()

    }
    
    @IBAction func billingClick(_ sender: UIButton) {
        if customerNameLbl.text == "N/A"{
            transparentView.isHidden = true
            billingView.isHidden = true
            isBillingContact = true
        }
        else {
            transparentView.isHidden = false
            billingView.isHidden = false
            isBillingContact = false
            var billheight = billingTbleView.contentSize.height + 100
            
            if billheight > self.view.frame.height{
                billingViewHeightConst.constant = self.view.frame.height - 100
            } else {
                billingViewHeightConst.constant = billingTbleView.contentSize.height + 100
            }
            billingTbleView.reloadData()
        }
    }
    
    @IBAction func crossClick(_ sender: UIButton) {
        transparentView.isHidden = true
        billingView.isHidden = true
    }
    
    @IBAction func reviewOrderAction(_ sender: UIButton) {
        
        UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
        var userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        if fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",farmid:"",animalTag:"", pvid: pvid).count == 0{
            UserDefaults.standard.set(false, forKey: keyValue.emailCheckValue.rawValue)
            UserDefaults.standard.set(true, forKey: keyValue.placeOrderCheck.rawValue)
        }
        else  if fetchAllDataAnimalGirlando(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",animalName:"",breedRegNumber:"", dateString:"").count == 0{
            UserDefaults.standard.set(false, forKey: keyValue.emailCheckValue.rawValue)
            UserDefaults.standard.set(true, forKey: keyValue.placeOrderCheck.rawValue)
        }
        else{
            UserDefaults.standard.set(true, forKey: keyValue.emailCheckValue.rawValue)
            UserDefaults.standard.set(false, forKey: keyValue.placeOrderCheck.rawValue)
        }
        
        if customerNameLbl.text == "N/A"{
            transparentView.isHidden = false
            billingView.isHidden = false
            isBillingContact = false
        }
        else{
            transparentView.isHidden = true
            billingView.isHidden = true
            isBillingContact = true
            let fethData =  fetchproductData(status: "true", orderStatus: "false", orderId: orderId,userId:userId)
            if fethData.count > 0{
                let storyBoard: UIStoryboard = UIStoryboard(name: "DairyPlaceAnOrder", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "ReviewOrderVCIpad") as! ReviewOrderVCIpad
                self.navigationController?.pushViewController(newViewController, animated: false)
            }
            else {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseSelectProduct, comment: ""))
            }
        }
    }
    
    @IBAction func statusBtnAction(_ sender: UIButton) {
        let popOverVC = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil).instantiateViewController(withIdentifier: ClassIdentifiers.offLineRestrictionVC) as! OffLineRestrictionVC
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    
    @IBAction func offlineBtnAction(_ sender: UIButton) {
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(OrderingProductSelectionVC.buttonbgPressed), for: .touchUpInside)
        buttonbg.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view .addSubview(buttonbg)
        customPopView = OfflinePopUp.loadFromNibNamed(ClassIdentifiers.offlineViewNib) as? OfflinePopUp
        customPopView.delegate = self
        customPopView.frame = CGRect(x: 30,y: 160,width: screenSize.width - 30,height: screenSize.height/1.7)
        customPopView.center = view.center
        customPopView.layer.cornerRadius = 8
        customPopView.layer.borderWidth = 3
        customPopView.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg .addSubview(customPopView)
    }
}


//MARK: GET, CREATE AND DELETE ANIMAL LIST
private typealias DeleteDataListHelper = OPSelectioniPadVC
extension DeleteDataListHelper  {
    func getListName()  {
        listName = orderingDatalistVM.makeListName(custmerId: custmerId , providerID: pvid)
        fetchDataEntry  = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.custmerId ),listName:listName ,productName:"Dairy") as! [DataEntryList]
        
    }
    func deleteSigalAnimalFromList(animalbarCode:String) {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        if fetchDataEntry.count > 0 {
            let fetchAllDatalistAnimals =  fetchAllDataAnimalDaWithOutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderStatus:"false",listid:Int64(fetchDataEntry[0].listId), custmerId: Int64(custmerId ), providerId: pvid) as! [DataEntryAnimaladdTbl]
            
            
            if fetchAllDatalistAnimals.count > 0{
                let filterdatalistAnimal = fetchAllDatalistAnimals.filter{$0.animalbarCodeTag == animalbarCode}
                if filterdatalistAnimal.count > 0 {
                    let animalVal = filterdatalistAnimal[0]
                    
                    deleteAnimalfromdataEntry(enitityName:Entities.dataEntryAnimalAddTbl, Int(animalVal.animalId), listId: Int(animalVal.listId))
                    //  deleteDataWithAnimaldataEntry(Int(animalVal.animalId))
                    
                    if Connectivity.isConnectedToInternet() {
                        self.objApiSync.postListDataDelete(listId: fetchDataEntry[0].listId, custmerId: Int64(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)), clearOrder: false, animalId: Int(animalVal.animalId))
                    }
                }
            }
        }
    }
    
    func createListNameAndCheckifExist(){
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        if fetchDataEntry.count > 0 {
            self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
            self.view.isUserInteractionEnabled = false
            deleteDataWithListIdDatEntry(entityString: Entities.dataEntryAnimalAddTbl, listId: Int(fetchDataEntry[0].listId), customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userId:userId)
            deleteDataWithListId(entityString: Entities.dataEntryListTblEntity, listId: Int64(Int(fetchDataEntry[0].listId)), customerId: custmerId,userId:userId )
            deleteList(listName: listName, customerId: Int64(custmerId ),listID: Int(fetchDataEntry[0].listId))
        }
    }
    
    func deleteList(listName: String, customerId: Int64, listID: Int) {
        let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String
        let headerDict = ["Authorization": accessToken!,"Content-Type" : "application/x-www-form-urlencoded"]
        var header = HTTPHeaders(headerDict )
        
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

