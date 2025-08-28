//
//  OrderProductSelectionSecondVC.swift
//  SearchPoint
//
//  Created by "" on 17/10/2019.
//  ""
//

import UIKit
import DropDown
import Alamofire


//MARK: ORDER PRODUCT SELECTION SECOND CLASS
class OrderProductSelectionSecondVC: UIViewController {
    
    //MARK: IB OUTLETS
    @IBOutlet weak var clarifideTransparentView: UIView!
    @IBOutlet weak var clariifdeView: UIView!
    @IBOutlet weak var clarifideLbl1: UILabel!
    @IBOutlet weak var clarifideLbl2: UILabel!
    @IBOutlet weak var clarifideLbl3: UILabel!
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var lable2TopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tbblView: UITableView!
    @IBOutlet weak var bvdvTransparentView: UIView!
    @IBOutlet weak var crossBtnOutlet: UIButton!
    @IBOutlet weak var billingViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var farmIdHideLbl: UILabel!
    @IBOutlet weak var toggleBtnOutlet: UIButton!
    @IBOutlet weak var farmIdDisplyOutlet: UIButton!
    @IBOutlet weak var serchTextField: UITextField!
    @IBOutlet weak var tblView:UITableView!
    @IBOutlet weak var tableViewBilling : UITableView!
    @IBOutlet weak var dropUpDownBtn: UIButton!
    @IBOutlet weak var networkStatusLbl: UILabel!
    @IBOutlet weak var networkStatusImg: UIImageView!
    @IBOutlet weak var OffLineBtn: UIButton!
    @IBOutlet weak var billingTableView: UITableView!
    @IBOutlet weak var notificationLblCount: UILabel!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var billingView: UIView!
    @IBOutlet weak var apppYTOoRDER: UILabel!
    @IBOutlet weak var sortByTitle: UILabel!
    @IBOutlet weak var bvdvSelectionConflict: UILabel!
    @IBOutlet weak var bvdvSubTilte: UILabel!
    @IBOutlet weak var okBtnOutlet: UIButton!
    @IBOutlet weak var orderProductSelectionTitle: UILabel!
    @IBOutlet weak var selectBilingContactTitle: UILabel!
    @IBOutlet weak var appStatusLbl: UILabel!
    @IBOutlet weak var billingContact: UILabel!
    @IBOutlet weak var removeBtnoutler: UIButton!
    
    //MARK: VARIABLES AND CONSTANTS
    var attrs : [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.blue,.underlineStyle: NSUnderlineStyle.single.rawValue]
    let dropDown = DropDown()
    var objApiSync = ApiSyncList()
    var arr1 = [Int:[ProductAdonAnimalTbl]]()
    var values = [Int]()
    var animaltag = [String]()
    var farmID = [String]()
    var eartag = [String]()
    var delegateCustom : objectPickCartScreen?
    var identifiy = Bool()
    var sampTypeArr = NSArray()
    var barCode = [String]()
    var selection = [[String:Any]]()
    var aTag:Int!
    var pid = Int()
    var fethData:NSArray!
    var farmIdValue = Int()
    var barCodeId = Int()
    var earTagID = Int()
    var animaId = Int()
    var clickOnDropDown = String()
    var isBillingContact = true
    var BVDVSeleted = Bool()
    var nonBVDVBaseProductFound = Bool()
    var firstTimeSeleted = Bool()
    var indexOfSelection:[IndexPath?] = [IndexPath]()
    var collViewOfselection:[UICollectionView?] = [UICollectionView]()
    var billingdelegateVC = BillingTableViewDelegate()
    var farmAddr = [GetBillingContact]()
    var userId = Int()
    var orderId = Int()
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    var heartBeatViewModel:HeartBeatViewModel?
    var pvid = Int()
    var fetchDataEntry : [DataEntryList] = []
    var listName = String()
    let orderingDatalistVM = OrderingDataListViewModel()
    var custmerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int
    var value = 0
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    
    
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
    
    //MARK: INITIAL UI METHODS
    func setUIOnDidLoad() {
        farmAddr = fetchBillingCustomer(entityName: Entities.getBillingContactEntity,customerID: self.custmerId) as! [GetBillingContact]
        pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        heartBeatViewModel?.callGetHearBeatData()
        UserDefaults.standard.set(nil, forKey: keyValue.submitTypeSelection.rawValue)
        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
        clarifideTransparentView.isHidden = true
        clariifdeView.isHidden = true
        languageConversion(languageId: langId!)
        userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        parentView.isHidden = true
        crossBtnOutlet.isHidden = true
        bvdvTransparentView.isHidden = true
        tbblView.delegate = self
        tbblView.dataSource = self
        initialNetworkCheck()
        tableViewBilling.delegate = billingdelegateVC
        tableViewBilling.dataSource = billingdelegateVC
        tableViewBilling.reloadData()
        billingdelegateVC.delegate = self
        if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
            fethData =  fetchAllDataOrderStatusIsCdcbProduct(entityName: Entities.productAdonAnimalTblEntity, ordestatus: "false",orderId: orderId,userId:userId)
        } else {
            fethData = fetchAllDataOrderStatus(entityName: Entities.productAdonAnimalTblEntity, ordestatus: "false",orderId: orderId,userId:userId)
        }
        let dataval:  [ProductAdonAnimalTbl] =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true", orderStatus: "false",orderId:orderId,userId:userId, farmId: serchTextField.text!) as! [ProductAdonAnimalTbl]
        fetchProductAdonAnimalTbl(fethData: fethData, completion: {
            
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if dataval.count > 0 {
                for i in 0..<dataval.count{
                    self.fetchAdonData(pid: Int(dataval[i].productId), animaltag: Int(dataval[i].animalId) , index: i)
                }
            }
        }
        perform(#selector(reloadTable), with: nil, afterDelay: 0.1)
        firstTimeSeleted = true
    }
    
    func setUIOnWillAppear(){
        self.getListName()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        UserDefaults.standard.set(keyValue.page.rawValue, forKey: keyValue.page.rawValue)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.navigationBar.isHidden = true
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
        
        if  UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == nil || UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == "" {
            UserDefaults.standard.set(keyValue.farmId.rawValue, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
            self.clickOnDropDown = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            
            if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                fethData =  fetchAllDataFarmIdisCdcbProduct(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:self.orderId,userId:self.userId, farmId: self.serchTextField.text!)
            }
            else {
                fethData =  fetchAllDataFarmId(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:self.orderId,userId:self.userId, farmId: self.serchTextField.text!)
            }
            
            if pviduser == 4 {
                self.clickOnDropDown = NSLocalizedString(ButtonTitles.earTagText, comment: "")
                UserDefaults.standard.set(ButtonTitles.earTagText, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
                self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
                fethData =  fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
            }
        }
        
        if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == ButtonTitles.earTagText && pviduser == 4 {
            self.clickOnDropDown = NSLocalizedString(ButtonTitles.earTagText, comment: "")
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            fethData =  fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
        }
        else{
            self.clickOnDropDown = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                fethData =  fetchAllDataFarmIdisCdcbProduct(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:self.orderId,userId:self.userId, farmId: self.serchTextField.text!)
            }
            else {
                fethData =  fetchAllDataFarmId(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:self.orderId,userId:self.userId, farmId: self.serchTextField.text!)
            }}
        
        if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == keyValue.farmId.rawValue {
            self.clickOnDropDown = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            
            if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                fethData =  fetchAllDataFarmIdisCdcbProduct(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:self.orderId,userId:self.userId, farmId: self.serchTextField.text!)
                
            } else {
                fethData =  fetchAllDataFarmId(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:self.orderId,userId:self.userId, farmId: self.serchTextField.text!)
            }
            
            if pviduser == 4  {
                self.clickOnDropDown = NSLocalizedString(ButtonTitles.earTagText, comment: "")
                UserDefaults.standard.set(ButtonTitles.earTagText, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
                self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
                fethData =  fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
            }
        }
        if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == keyValue.officialId.rawValue {
            self.clickOnDropDown = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            
            if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                self.fethData =  fetchAllDataanimalTagIsCdcbProdcut(entityName: Entities.productAdonAnimalTblEntity,asending : true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
            }
            else {
                self.fethData =  fetchAllDataanimalTag(entityName: Entities.productAdonAnimalTblEntity,asending : true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
            }
        }
        if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == keyValue.barcode.rawValue {
            self.clickOnDropDown = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                
                self.fethData =  fetchAllDataBarcOdeIsCdcbProduct(entityName: Entities.productAdonAnimalTblEntity, asending: true,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
            }
            else {
                self.fethData =  fetchAllDataBarcOde(entityName: Entities.productAdonAnimalTblEntity, asending: true,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
            }
        }
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let  orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid)
        notificationLblCount.text = String(animalCount.count)
        
        if farmAddr.count > 0  {
            var abc = ""
            let filterArr = farmAddr.filter({$0.isDefault})
            if filterArr.count > 0{
                abc = filterArr[0].contactName ?? ""
            }
            else{
                let billArray =  farmAddr.filter({Int($0.billToCustId!) == self.custmerId})
                abc = billArray[0].contactName ?? ""
                UserDefaults.standard.set(billArray[0].billToCustId, forKey: keyValue.billToCustomerId.rawValue)
            }
            DispatchQueue.main.async {
                if let cell = self.tblView.cellForRow(at: IndexPath(row: self.arr1.keys.count, section: 0) ) as? BillingCell{
                    let attributeString = NSMutableAttributedString(string: abc , attributes: self.attrs)
                    UserDefaults.standard.set(abc, forKey: keyValue.farmValue.rawValue)
                    
                    cell.billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                    self.tblView.reloadData()
                }
                else {
                    let cell = self.tblView.cellForRow(at: IndexPath(row: self.arr1.keys.count, section: 0) ) as? BillingCell
                    let attributeString = NSMutableAttributedString(string: abc , attributes: self.attrs)
                    UserDefaults.standard.set(abc, forKey: keyValue.farmValue.rawValue)
                    cell?.billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                    self.tblView.reloadData()
                }
            }
        }
        initialNetworkCheck()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        transparentView.isHidden = true
        billingView.isHidden = true
    }
    
    //MARK: METHODS AND FUNCTIONS
    
    func deleteAnimal(productArray : [ProductAdonAnimalTbl], cartAnimalArray : [AnimaladdTbl]){
        var uniqueArray = AnimaladdTbl()
        for i in 0...cartAnimalArray.count - 1  {
            
            let animalDetail = cartAnimalArray[i]
            if !productArray.contains(where: { $0.animalId == animalDetail.animalId}) {
                uniqueArray = animalDetail
                updateAdhAnimalDataforCart(entity: Entities.animalMasterTblEntity, officialID: uniqueArray.animalTag ?? "", barCode: uniqueArray.animalbarCodeTag ?? "", isADHCart: false)
                deleteDataWithProduct(Int(uniqueArray.animalId))
                deleteDataWithSubProduct(Int(uniqueArray.animalId))
                deleteDataWithAnimal(Int(uniqueArray.animalId))
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
                updateProductTablDataaid(entity: Entities.getProductTblEntity, status: "false")
                let fethData =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId, farmId:"")
                for pName in fethData as? [ProductAdonAnimalTbl] ?? [] {
                    updateProductTablaid(entity:Entities.getProductTblEntity,productId:
                                            Int(pName.productId),status: "true")
                }
            }
            
            
        }
        
        print(uniqueArray)
        
        
    }
    
    func languageConversion(languageId :Int){
        okBtnOutlet.setTitle(NSLocalizedString("Ok", comment: ""), for: .normal)
        bvdvSelectionConflict.text = NSLocalizedString(ButtonTitles.bvdvSelectionConflict, comment: "")
        bvdvSubTilte.text = NSLocalizedString(ButtonTitles.bvdvProdSelection, comment: "")
        selectBilingContactTitle.text = NSLocalizedString(ButtonTitles.selectBillingContactText, comment: "")
        removeBtnoutler.setTitle(NSLocalizedString(LocalizedStrings.removeAllStr, comment: ""), for: .normal)
        orderProductSelectionTitle.text = NSLocalizedString(ButtonTitles.orderProdSelectiontext, comment: "")
        appStatusLbl.text = NSLocalizedString(ButtonTitles.appStatusText, comment: "")
        sortByTitle.text = NSLocalizedString(ButtonTitles.sortByText, comment: "")
        apppYTOoRDER.text = ButtonTitles.applyToEntireOrder.localized
        serchTextField.placeholder = NSLocalizedString(ButtonTitles.searchText, comment: "")
    }
    
    func initialNetworkCheck(){
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del =  UIApplication.shared.delegate as? AppDelegate
        self.networkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if networkStatusLbl?.text == ButtonTitles.connectedText.localized{
            self.OffLineBtn.isHidden = true
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else{
            self.OffLineBtn.isHidden = false
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    func checkedSampletype(indexPath: IndexPath,userId :Int,orderId: Int, collectionViewTag: Int)-> Bool{
        aTag = Int(arr1[values[collectionViewTag]]![0].animalId)
        for i in 0..<self.selection.count{
            if let value = self.selection[i][keyValue.animalId.rawValue] as? Int, value  == self.aTag{
                let adonId = ( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).adonName
                if adonId == LocalizedStrings.bvdvAddOnId {
                    let dataSample : [AnimaladdTbl] = fetchAllDataAnimalDataSampleTypeWithAnimalId(entityName: Entities.animalAddTblEntity, sampleType1: ButtonTitles.caisleyTSUText, sampleType2: ButtonTitles.allflexTSUText, sampleType3: ButtonTitles.allflexTSTText, atAg: aTag,pvid: pvid) as! [AnimaladdTbl]
                    if dataSample.count > 0 {
                        let msg =  AlertMessagesStrings.pleaseUpdateSampleType.localized(with: dataSample.count)
                        let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: msg, preferredStyle: .alert)
                        
                        let okAction = UIAlertAction(title: NSLocalizedString("Continue", comment: ""), style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            for i in 0 ..< dataSample.count{
                                let animalTag : String = dataSample[i].animalTag ?? ""
                                let animalBarcodeTag = dataSample[i].animalbarCodeTag
                                let animalId = Int(dataSample[i].animalId)
                                updateAdhAnimalDataforCart(entity: Entities.animalMasterTblEntity, officialID: animalTag , barCode: animalBarcodeTag ?? "", isADHCart: false)
                                deleteDataWithProduct(animalId)
                                deleteDataWithSubProduct(animalId)
                                deleteDataWithAnimal(animalId)
                                self.deleteSigalAnimalFromList(animalTagStr: animalTag)
                                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                                let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
                                updateProductTablDataaid(entity: Entities.getProductTblEntity, status: "false")
                                let fethData =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId, farmId:"")
                                for pName in fethData as? [ProductAdonAnimalTbl] ?? [] {
                                    updateProductTablaid(entity:Entities.getProductTblEntity,productId:
                                                            Int(pName.productId),status: "true")
                                }
                            }
                            if self.pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                                self.fethData =  fetchAllDataOrderStatusIsCdcbProduct(entityName: Entities.productAdonAnimalTblEntity, ordestatus: "false",orderId: orderId,userId:userId)
                            }
                            else {
                                self.fethData = fetchAllDataOrderStatus(entityName: Entities.productAdonAnimalTblEntity, ordestatus: "false",orderId: orderId,userId:userId)
                            }
                            
                            let dataval =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true", orderStatus: "false",orderId:orderId,userId:userId, farmId: self.serchTextField.text!)
                            self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
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
                            
                            self.perform(#selector(self.reloadTable), with: nil, afterDelay: 0.1)
                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid)
                            self.notificationLblCount.text = String(animalCount.count)
                            self.view.makeToast(LocalizedStrings.animalsRemovedFromOrder.localized(with: dataSample.count), duration: 1, position: .bottom)
                            if animalCount.count == 0 {
                                self.createListNameAndCheckifExist()
                                deleteDataProduct(entityName:Entities.animalAddTblEntity,status:"false")
                                deleteDataProduct(entityName:Entities.productAdonAnimalTblEntity,status:"false")
                                deleteDataProduct(entityName:Entities.subProductTblEntity, status: "false")
                                UserDefaults.standard.removeObject(forKey: keyValue.identifyStore.rawValue)
                                UserDefaults.standard.removeObject(forKey: keyValue.productCount.rawValue)
                                UserDefaults.standard.set(nil, forKey: keyValue.onKey.rawValue)
                                UserDefaults.standard.set(nil, forKey: keyValue.page.rawValue)
                                UserDefaults.standard.removeObject(forKey: keyValue.breed.rawValue)
                                updateProductTablStatus(entity: Entities.getProductTblEntity)
                                updateProductTablStatus(entity: Entities.getAdonTblEntity)
                                UserDefaults.standard.set("False", forKey: keyValue.isAuSelected.rawValue)
                                UserDefaults.standard.set(nil, forKey: keyValue.tsuKey.rawValue)
                                UserDefaults.standard.setValue(nil, forKey: keyValue.dataEntryListName.rawValue)
                                UserDefaults.standard.set(false, forKey: keyValue.bvdvSelected.rawValue)
                                if self.pvid == 4 {
                                    UserDefaults.standard.set(LocalizedStrings.hairString.localized, forKey: keyValue.girlandoSampleType.rawValue)
                                }
                                
                                UserDefaults.standard.set(nil, forKey: keyValue.girlandoSampleTypeClear.rawValue)
                                UserDefaults.standard.set(nil, forKey: keyValue.submitTypeSelection.rawValue)
                                UserDefaults.standard.set(nil, forKey: keyValue.breedNameClear.rawValue)
                                UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlag.rawValue)
                                UserDefaults.standard.set(nil, forKey: keyValue.tsuClear.rawValue)
                                UserDefaults.standard.removeObject(forKey: keyValue.pidKey.rawValue)
                                UserDefaults.standard.removeObject(forKey: keyValue.bvdvValidation.rawValue)
                                UserDefaults.standard.removeObject(forKey: keyValue.capsBreedName.rawValue)
                                UserDefaults.standard.removeObject(forKey: keyValue.submitBtnFlag.rawValue)
                                UserDefaults.standard.removeObject(forKey: keyValue.isAgreeForSubmit.rawValue)
                                UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
                                UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
                                UserDefaults.standard.set("", forKey: keyValue.emailFlag.rawValue)
                                UserDefaults.standard.set("", forKey: keyValue.submitFlag.rawValue)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
                                }
                            }
                        }
                        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                            UIAlertAction in
                        }
                        
                        alertController.addAction(okAction)
                        alertController.addAction(cancelAction)
                        self.present(alertController, animated: true, completion: nil)
                        return true
                    }
                    return false
                }
                return false
            }
        }
        return false
    }
    
    func updateSelectionofAddonPrduct(adonId:String,userId: Int, orderId: Int, indexPath: IndexPath, i: Int,_ collectionView: UICollectionView){
        let data =  fetchSubProductDataStatusUpdateDairy(productId:Int(( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).adonId), animalTag:self.aTag!, status: "true", orderId: orderId,userId:userId)
        if data.count > 0{
            let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
            if providerName == keyValue.auDairyProducts.rawValue{
                if adonId == LocalizedStrings.clarifideCDCB || adonId == LocalizedStrings.clarifidePlusCDCBAddOnId{
                    let clarifide =  fetchSubProductDataStatusUpdateDairychkpValidation(productId: LocalizedStrings.clarifideCDCB, animalId: self.aTag!, status: "false" ,orderId :orderId, userId: userId)
                    
                    let clarifidPlus =  fetchSubProductDataStatusUpdateDairychkpValidation(productId: LocalizedStrings.clarifidePlusCDCBAddOnId, animalId: self.aTag!, status: "false" ,orderId :orderId, userId: userId)
                    if clarifidPlus.count > 0 {
                        updateAdonDataDairyFalseClarifide(entity: Entities.subProductTblEntity, adonId: LocalizedStrings.clarifideCDCB, status: "false", animaltag: self.aTag! ,orderId :orderId, userId: userId)
                        updateAdoonTablClarifide(entity: Entities.getAdonTblEntity, AdonId: LocalizedStrings.clarifideCDCB, status: "false",productId: self.pid)
                        
                    }
                    if clarifide.count > 0 {
                        updateAdonDataDairyFalseClarifide(entity: Entities.subProductTblEntity, adonId: LocalizedStrings.clarifidePlusCDCBAddOnId, status: "false", animaltag: self.aTag! ,orderId :orderId, userId: userId)
                        updateAdoonTablClarifide(entity: Entities.getAdonTblEntity, AdonId: LocalizedStrings.clarifidePlusCDCBAddOnId, status: "false",productId: self.pid)
                    }
                }
            }
            if adonId == LocalizedStrings.bvdvAddOnId{
                self.BVDVSeleted = false
                UserDefaults.standard.set(false, forKey: keyValue.bvdvSelected.rawValue)
            }
            
            updateAdonDataDairy(entity: Entities.subProductTblEntity, adonId: Int(( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).adonId), status: "false", animaltag: self.aTag!, orderId: orderId, userId: userId)
            updateAdoonTabl(entity: Entities.getAdonTblEntity, AdonId: Int(( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).adonId), status: "false",productId:Int(( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).productId))
        }
        
        else{
            let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
            if providerName == keyValue.auDairyProducts.rawValue{
                if adonId == LocalizedStrings.clarifideCDCB || adonId == LocalizedStrings.clarifidePlusCDCBAddOnId{
                    let clarifide =  fetchSubProductDataStatusUpdateDairychkpValidation(productId: LocalizedStrings.clarifideCDCB, animalId: self.aTag!, status: "false" ,orderId :orderId, userId: userId)
                    let clarifidPlus =  fetchSubProductDataStatusUpdateDairychkpValidation(productId: LocalizedStrings.clarifidePlusCDCBAddOnId, animalId: self.aTag!, status: "false" ,orderId :orderId, userId: userId)
                    
                    if clarifidPlus.count > 0 {
                        updateAdonDataDairyFalseClarifide(entity: Entities.subProductTblEntity, adonId: LocalizedStrings.clarifideCDCB, status: "false", animaltag: self.aTag! ,orderId :orderId, userId: userId)
                        updateAdoonTablClarifide(entity: Entities.getAdonTblEntity, AdonId: LocalizedStrings.clarifideCDCB, status: "false",productId: self.pid)
                    }
                    
                    if clarifide.count > 0 {
                        updateAdonDataDairyFalseClarifide(entity: Entities.subProductTblEntity, adonId: LocalizedStrings.clarifidePlusCDCBAddOnId, status: "false", animaltag: self.aTag! ,orderId :orderId, userId: userId)
                        updateAdoonTablClarifide(entity: Entities.getAdonTblEntity, AdonId: LocalizedStrings.clarifidePlusCDCBAddOnId, status: "false",productId: self.pid)
                    }
                }
            }
            if adonId == LocalizedStrings.bvdvAddOnId{
                self.BVDVSeleted = true
                UserDefaults.standard.set(true, forKey: keyValue.bvdvSelected.rawValue)
            }
            updateAdonDataDairy(entity: Entities.subProductTblEntity, adonId: Int(( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).adonId), status: "true", animaltag: self.aTag!, orderId: orderId, userId: userId)
            updateAdoonTabl(entity: Entities.getAdonTblEntity, AdonId: Int(( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).adonId), status: "true",productId:Int(( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).productId))
            
        }
        if self.pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
            self.fethData = fetchAllDataOrderStatusIsCdcbProduct(entityName: Entities.productAdonAnimalTblEntity, ordestatus: "false",orderId: orderId,userId:userId)
        }
        else {
            self.fethData = fetchAllDataOrderStatus(entityName: Entities.productAdonAnimalTblEntity, ordestatus: "false",orderId: orderId,userId:userId)
            
        }
        let dataval =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true", orderStatus: "false",orderId:orderId,userId:userId, farmId: self.serchTextField.text!)
        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
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
        
        self.perform(#selector(self.reloadTable), with: nil, afterDelay: 0.1)
        collectionView.reloadData()
        
    }
    func isSelectedBaseProductCompatiablewithBVDV(indexPath: IndexPath,userId :Int,orderId: Int, collectionViewTag: Int, _ collectionView: UICollectionView)  {
        for i in 0..<self.selection.count{
            if let value = self.selection[i]["animalId"] as? Int, value  == self.aTag{
                let adonId = ( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).adonName
                if adonId == "BVDV" {
                 
                    var BvdvSubProductfound = Bool()
                    if UserDefaults.standard.bool(forKey: "BVDVSeleted"){
                        BvdvSubProductfound = true
                        let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: "BVDV will be applied to the entire order.".localized, preferredStyle: .alert)
                        
                        let okAction = UIAlertAction(title: NSLocalizedString("Continue", comment: ""), style: UIAlertAction.Style.default) {
                            
                            UIAlertAction in
                            self.updateSelectionofAddonPrduct(adonId: adonId ?? "", userId: userId, orderId: orderId, indexPath: indexPath, i: i, collectionView)
                        }
                        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            print(LocalizedStrings.cancelPressed)
                        }
                        
                        alertController.addAction(okAction)
                        alertController.addAction(cancelAction)
                        self.present(alertController, animated: true, completion: nil)
                    }else {
                        let dataval =  fetchAllDataFarmIdStatus(entityName: "ProductAdonAnimalTbl", asending: true, status: "true", orderStatus: "false",orderId:orderId,userId:userId, farmId: self.serchTextField.text!) as! [ProductAdonAnimalTbl]
                        for dataV in dataval {
                            let data12333 =  fetchProductAdonDataBVDV(entityName: "SubProductTbl", adonId:"BVDV",ordrId:orderId, productId: Int(dataV.productId))
                            if data12333.count == 0{
                                BvdvSubProductfound = false
                                break
                            } else {
                                BvdvSubProductfound = true
                            }
                            
                        }
                    }
                    if !BvdvSubProductfound{
                        let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: "BVDV must be applied to the entire order. The product(s) you selected is not compatible with BVDV as an add-on. Please change the base product or remove animals from order.".localized, preferredStyle: .alert)
                        
                        let okAction = UIAlertAction(title: NSLocalizedString("Continue", comment: ""), style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            
                            let data =  fetchSubProductDataStatusUpdateDairy(productId:Int(( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).adonId), animalTag:self.aTag!, status: "true", orderId: orderId,userId:userId)
                            
                            if data.count > 0{
                                let providerName = UserDefaults.standard.value(forKey: "ProviderName") as? String
                                if providerName == keyValue.auDairyProducts.rawValue{
                                    
                                    if adonId == LocalizedStrings.clarifideCDCB || adonId == LocalizedStrings.clarifidePlusCDCBAddOnId{
                                        let clarifide =  fetchSubProductDataStatusUpdateDairychkpValidation(productId: LocalizedStrings.clarifideCDCB, animalId: self.aTag!, status: "false" ,orderId :orderId, userId: userId)
                                        
                                        let clarifidPlus =  fetchSubProductDataStatusUpdateDairychkpValidation(productId: LocalizedStrings.clarifidePlusCDCBAddOnId, animalId: self.aTag!, status: "false" ,orderId :orderId, userId: userId)
                                        if clarifidPlus.count > 0 {
                                            updateAdonDataDairyFalseClarifide(entity: "SubProductTbl", adonId: LocalizedStrings.clarifideCDCB, status: "false", animaltag: self.aTag! ,orderId :orderId, userId: userId)
                                            updateAdoonTablClarifide(entity: "GetAdonTbl", AdonId: LocalizedStrings.clarifideCDCB, status: "false",productId: self.pid)
                                            
                                        }
                                        if clarifide.count > 0 {
                                            updateAdonDataDairyFalseClarifide(entity: "SubProductTbl", adonId: LocalizedStrings.clarifidePlusCDCBAddOnId, status: "false", animaltag: self.aTag! ,orderId :orderId, userId: userId)
                                            updateAdoonTablClarifide(entity: "GetAdonTbl", AdonId: LocalizedStrings.clarifidePlusCDCBAddOnId, status: "false",productId: self.pid)
                                            
                                        }
                                    }
                                }
                                
                                UserDefaults.standard.set(false, forKey: "BVDVSeleted")
                                updateAdonDataDairy(entity: "SubProductTbl", adonId: Int(( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).adonId), status: "false", animaltag: self.aTag!, orderId: orderId, userId: userId)
                                updateAdoonTabl(entity: "GetAdonTbl", AdonId: Int(( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).adonId), status: "false",productId:Int(( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).productId))
                                
                            }
                            else{
                                
                                let providerName = UserDefaults.standard.value(forKey: "ProviderName") as? String
                                if providerName == keyValue.auDairyProducts.rawValue{
                                    
                                    if adonId == LocalizedStrings.clarifideCDCB || adonId == LocalizedStrings.clarifidePlusCDCBAddOnId{
                                        let clarifide =  fetchSubProductDataStatusUpdateDairychkpValidation(productId: LocalizedStrings.clarifideCDCB, animalId: self.aTag!, status: "false" ,orderId :orderId, userId: userId)
                                        
                                        let clarifidPlus =  fetchSubProductDataStatusUpdateDairychkpValidation(productId: LocalizedStrings.clarifidePlusCDCBAddOnId, animalId: self.aTag!, status: "false" ,orderId :orderId, userId: userId)
                                        if clarifidPlus.count > 0 {
                                            updateAdonDataDairyFalseClarifide(entity: "SubProductTbl", adonId: LocalizedStrings.clarifideCDCB, status: "false", animaltag: self.aTag! ,orderId :orderId, userId: userId)
                                            updateAdoonTablClarifide(entity: "GetAdonTbl", AdonId: LocalizedStrings.clarifideCDCB, status: "false",productId: self.pid)
                                            
                                        }
                                        if clarifide.count > 0 {
                                            updateAdonDataDairyFalseClarifide(entity: "SubProductTbl", adonId: LocalizedStrings.clarifidePlusCDCBAddOnId, status: "false", animaltag: self.aTag! ,orderId :orderId, userId: userId)
                                            updateAdoonTablClarifide(entity: "GetAdonTbl", AdonId: LocalizedStrings.clarifidePlusCDCBAddOnId, status: "false",productId: self.pid)
                                            
                                        }
                                    }
                                }
                                UserDefaults.standard.set(true, forKey: "BVDVSeleted")
                                updateAdonDataDairy(entity: "SubProductTbl", adonId: Int(( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).adonId), status: "true", animaltag: self.aTag!, orderId: orderId, userId: userId)
                                updateAdoonTabl(entity: "GetAdonTbl", AdonId: Int(( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).adonId), status: "true",productId:Int(( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).productId))
                            }
                            if self.pvid == 3 && UserDefaults.standard.value(forKey: "isAuSelected") as? String == "NoNeedAuPopUp" {
                                
                                self.fethData = fetchAllDataOrderStatusIsCdcbProduct(entityName: "ProductAdonAnimalTbl", ordestatus: "false",orderId: orderId,userId:userId)
                                
                            }else {
                                
                                self.fethData = fetchAllDataOrderStatus(entityName: "ProductAdonAnimalTbl", ordestatus: "false",orderId: orderId,userId:userId)
                                
                            }
                            let dataval =  fetchAllDataFarmIdStatus(entityName: "ProductAdonAnimalTbl", asending: true, status: "true", orderStatus: "false",orderId:orderId,userId:userId, farmId: self.serchTextField.text!) as!  [ProductAdonAnimalTbl]
                            
                            if dataval.count > 0 {
                                for i in 0..<dataval.count{
                                    self.fetchAdonData(pid: Int(dataval[i].productId), animaltag: Int(dataval[i].animalId) , index: i)
                                }
                            }
                            
                            
                            self.perform(#selector(self.reloadTable), with: nil, afterDelay: 0.1)
                            collectionView.reloadData()
                            self.nonBVDVBaseProductFound = false
                            
                        }
                        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            print(LocalizedStrings.cancelPressed)
                        }
                        
                        alertController.addAction(okAction)
                        alertController.addAction(cancelAction)
                        self.present(alertController, animated: true, completion: nil)
                    } else  {
                        let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: "BVDV will be applied to the entire order.".localized, preferredStyle: .alert)
                        
                        let okAction = UIAlertAction(title: NSLocalizedString("Continue", comment: ""), style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            self.updateSelectionofAddonPrduct(adonId: adonId ?? "", userId: userId, orderId: orderId, indexPath: indexPath, i: i, collectionView)
                            
                        }
                        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            print(LocalizedStrings.cancelPressed)
                        }
                        
                        alertController.addAction(okAction)
                        alertController.addAction(cancelAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    break
                } else {
                    self.updateSelectionofAddonPrduct(adonId: adonId ?? "", userId: userId, orderId: orderId, indexPath: indexPath, i: i, collectionView)
                }
            }
        }
    }
    
    //MARK: FETCH PRODUCT ADD ON FROM ANIMAL TABLE
    func fetchProductAdonAnimalTbl(fethData:NSArray,completion: @escaping ()->()){
        values.removeAll()
        barCode.removeAll()
        farmID.removeAll()
        eartag.removeAll()
        animaltag.removeAll()
        arr1.removeAll()
        for value in fethData{
            if let item = value as? ProductAdonAnimalTbl{
                if values.contains(Int(item.animalId)){
                    arr1[Int(item.animalId)]?.append(item)
                } else {
                    values.append(Int(item.animalId))
                    farmID.append(item.farmId ?? "")
                    eartag.append(item.earTag ?? "")
                    barCode.append(item.animalbarCodeTag ?? "")
                    animaltag.append(item.animalTag ?? "")
                    arr1[Int(item.animalId)] = [ProductAdonAnimalTbl]()
                    arr1[Int(item.animalId)]?.append(item)
                }
            }
        }
        reloadTable()
        completion()
    }
    
    func fetchProductAdonAnimalTblForCollectionView(fethData:NSArray,completion: @escaping ()->()){
        values.removeAll()
        barCode.removeAll()
        farmID.removeAll()
        eartag.removeAll()
        animaltag.removeAll()
        arr1.removeAll()
        for value in fethData{
            if let item = value as? ProductAdonAnimalTbl{
                if values.contains(Int(item.animalId)){
                    arr1[Int(item.animalId)]?.append(item)
                } else {
                    values.append(Int(item.animalId))
                    farmID.append(item.farmId ?? "")
                    eartag.append(item.earTag ?? "")
                    
                    barCode.append(item.animalbarCodeTag ?? "")
                    animaltag.append(item.animalTag ?? "")
                    arr1[Int(item.animalId)] = [ProductAdonAnimalTbl]()
                    arr1[Int(item.animalId)]?.append(item)
                }
            }
        }
        completion()
    }
    
    func fetchAdonData(pid:Int, animaltag:Int, index:Int) {
        
        let data = fetchSubProductDataDairy(productId: Int(pid),animalTag: animaltag,orderId:orderId,userId:userId) as? [SubProductTbl]
        var found = false
        
        for i in 0..<selection.count{
            if let value = (selection[i]["animalId"]) as? Int, value  == animaltag{
                selection[i]["animalId"] = animaltag
                selection[i]["addon"] = data
                selection[i]["row"] = index
                found = true
                break
            }
        }
        if found ==  false && data!.count > 0{
            selection.append (["animalId":animaltag,"addon":data as Any,"row":index])
            
        }
        if UserDefaults.standard.bool(forKey: "BVDVSeleted") {
            
            let productArray =  fetchAllDataFarmIdStatus(entityName: "ProductAdonAnimalTbl", asending: true, status: "true", orderStatus: "false",orderId:orderId,userId:userId, farmId: serchTextField.text!) as! [ProductAdonAnimalTbl]
            let providerName = UserDefaults.standard.value(forKey: "ProviderName") as? String
            
            for item in productArray{
                let PName = item.productName
                let pid = item.productId
                let animalID = item.animalId
                switch providerName {
                case keyValue.auDairyProducts.rawValue:
                    if PName == LocalizedStrings.providerClarifidePlusUpgrade  || PName == "CLARIFIDE DataGene Upgrade" ||  PName == LocalizedStrings.providerClarifideCDCBUpgrade {
                        unselectNonBVDVProduct(productID: Int(pid), animalId: Int(animalID))
                    }
                case "CLARIFIDE AHDB (UK)" :
                    if PName == LocalizedStrings.providerClarifidePlusUpgrade || PName == LocalizedStrings.providerClarifideCDCBUpgrade || PName == "CLARIFIDE AHDB Upgrade"{
                        
                        unselectNonBVDVProduct(productID: Int(pid), animalId: Int(animalID))
                        
                    }
                default:
                    if PName == LocalizedStrings.providerClarifidePlusUpgrade  || PName == "CLARIFIDE DataGene Upgrade" ||  PName == LocalizedStrings.providerClarifideCDCBUpgrade {
                        unselectNonBVDVProduct(productID: Int(pid), animalId: Int(animalID))
                        
                    }
                }
            }
        }
        reloadTable()
    }
    
    func fetchAdonData(indexPath:IndexPath, collectionView:UICollectionView) {
        if  collectionView.tag < values.count {
            if arr1[values[collectionView.tag]]!.count > indexPath.row {
                pid = Int(arr1[values[collectionView.tag]]![indexPath.row].productId)
                aTag = Int(arr1[values[collectionView.tag]]![indexPath.row].animalId)
                let data = fetchSubProductDataDairy(productId: Int(pid),animalTag: aTag!,orderId:orderId,userId:userId) as? [SubProductTbl]
                var found = false
                
                for i in 0..<selection.count{
                    if let value = (selection[i][keyValue.animalId.rawValue]) as? Int, value  == aTag{
                        selection[i][keyValue.animalId.rawValue] = aTag
                        selection[i]["addon"] = data
                        selection[i]["row"] = collectionView.tag
                        found = true
                        break
                    }
                }
                if found ==  false && data!.count > 0{
                    selection.append ([keyValue.animalId.rawValue:aTag as Any,"addon":data as Any,"row":collectionView.tag])
                }
            }
        }
        reloadTable()
    }
    func unselectNonBVDVProduct(productID: Int, animalId: Int)
    {
        let data12333 = fetchSubProductDataDairy(productId: Int(productID),animalTag: Int(animalId), orderId: orderId,userId:userId) as! [SubProductTbl]
        if data12333.count == 0{
            updateProductTablaid(entity: "ProductAdonAnimalTbl", productId: Int(productID), status: "false")
        }
        for _ in 0..<data12333.count{
            
            let subproductData = fetchSubProductDataDairy(productId: Int(productID),animalTag: Int(animalId),orderId:orderId,userId:userId) as? [SubProductTbl]
            for i in 0..<(subproductData?.count ?? 0){
                updateAdonDataSingle(entity: "GetAdonTbl", adonId: Int(subproductData?[i].adonId ?? 0) , status: "false")
                updateAdonDataSingleanimalId(entity: "SubProductTbl", pid:Int(productID),adonId: Int(subproductData?[i].adonId ?? 0) , status: "false", animalId:Int(subproductData?[i].animalId ?? 0),ordeId:orderId,userId: userId)
            }
            for i in 0..<self.selection.count{
                if let value = self.selection[i]["animalId"] as? Int, value  == animalId{
                    self.selection.remove(at: i)
                    break
                }
            }
            
        }
    }
    
    //MARK: OBJC SELECTOR METHODS
    @objc func reloadTable(){
        tblView.delegate = self
        tblView.dataSource = self
        tblView.reloadData()
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
    
    @objc func deleteButton(_ sender : UIButton){}
    
    @objc func openPopUp(_ sender: UIButton){
        let vc = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.commanInfoPopUpControllerVC) as! CommanInfoPopUpController
        vc.stringGetThroughArray = ButtonTitles.betaCaseinA2Bundled.localized
        self.navigationController?.present(vc, animated: false, completion: nil)
    }
    
    @objc func buttonClicked(sender:UIButton) {
        clarifideTransparentView.isHidden = false
        clariifdeView.isHidden = false
        clarifideTransparentView.frame = self.view.frame
    }
    
    @objc  func checkForReachability(notification:Notification){
        let del =  UIApplication.shared.delegate as? AppDelegate
        
        self.networkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if networkStatusLbl?.text == ButtonTitles.connectedText.localized{
            self.OffLineBtn.isHidden = true
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else{
            self.OffLineBtn.isHidden = false
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    @objc func buttonbgPressed (){
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

//MARK: TEXTFIELD DELEGATE
extension OrderProductSelectionSecondVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let currentString: NSString = serchTextField.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        tblView.isHidden = false
        
        if newString != ""{
            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: ""){
                let fetchcustRep =   fetchAllDataFarmId(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:orderId,userId:userId, farmId: newString as String)
                if fetchcustRep.count > 0 {
                    fetchProductAdonAnimalTbl(fethData: fetchcustRep, completion: {})
                }
                else{
                    arr1.removeAll()
                    reloadTable()
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 1, position: .center)
                }
            }
            
            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: ""){
                let fetchcustRep =   fetchAllDataanimalTag(entityName: Entities.productAdonAnimalTblEntity,asending : true,orderId:orderId,userId:userId, animalTag: newString as String)
                if fetchcustRep.count > 0 {
                    fetchProductAdonAnimalTbl(fethData: fetchcustRep, completion: {})
                }
                else{
                    arr1.removeAll()
                    reloadTable()
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 1, position: .center)
                }
            }
            
            if clickOnDropDown == ButtonTitles.barcodeText{
                let fetchcustRep =    fetchAllDataBarcOde(entityName: Entities.productAdonAnimalTblEntity, asending: true,orderId:orderId,userId:userId, barcode: newString as String)
                if fetchcustRep.count > 0 {
                    fetchProductAdonAnimalTbl(fethData: fetchcustRep, completion: {})
                }
                else{
                    arr1.removeAll()
                    reloadTable()
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 1, position: .center)
                }
            }
            if clickOnDropDown == ButtonTitles.earTagText{
                let fetchcustRep =    fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity, asending: true, orderId: orderId, userId: userId, animalTag:  newString as String)
                if fetchcustRep.count > 0 {
                    fetchProductAdonAnimalTbl(fethData: fetchcustRep, completion: {})
                }
                else{
                    arr1.removeAll()
                    reloadTable()
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 1, position: .center)
                }
            }
        }
        else{
            dropUpDownBtn.setImage(UIImage(named: ImageNames.imageImg), for: .normal)
            fethData =   fetchAllDataOrderStatus(entityName: Entities.productAdonAnimalTblEntity, ordestatus: "false",orderId:orderId,userId:userId)
            fetchProductAdonAnimalTbl(fethData: fethData, completion: {})
            reloadTable()
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: BILLING DELEGATE EXTENSION
extension OrderProductSelectionSecondVC : BillingDelegate {
    func updateUI(selectedBillingCustomer:GetBillingContact) {
        DispatchQueue.main.async {
            if let cell = self.tblView.cellForRow(at: IndexPath(row: self.arr1.keys.count, section: 0) ) as? BillingCell{
                let filterArr = self.farmAddr.filter({$0.isDefault })
                if filterArr.count > 0{
                    updateBillingCustomer(entity: Entities.getBillingContactEntity, customerID: self.custmerId, isDefault: false, billcustomerId: filterArr[0].billToCustId ?? "0", billcustomerName: filterArr[0].contactName ?? "")
                    
                }
                UserDefaults.standard.set(selectedBillingCustomer.contactName, forKey: keyValue.farmValue.rawValue)
                UserDefaults.standard.set(selectedBillingCustomer.billToCustId, forKey: keyValue.billToCustomerId.rawValue)
                updateBillingCustomer(entity: Entities.getBillingContactEntity, customerID: self.custmerId, isDefault: true, billcustomerId: selectedBillingCustomer.billToCustId ?? "0", billcustomerName: selectedBillingCustomer.contactName ?? "")
                self.farmAddr = fetchBillingCustomer(entityName: Entities.getBillingContactEntity,customerID: self.custmerId) as! [GetBillingContact]
                
                let attributeString = NSMutableAttributedString(string: selectedBillingCustomer.contactName ?? "", attributes: self.attrs)
                cell.billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
            }
            self.transparentView.isHidden = true
            self.billingView.isHidden = true
        }
    }
    
    func updateUIForButtonTitle() {
        DispatchQueue.main.async {
            if let cell = self.tblView.cellForRow(at: IndexPath(row: self.arr1.keys.count, section: 0) ) as? BillingCell{
                let attributeString = NSMutableAttributedString(string: (UserDefaults.standard.value(forKey: keyValue.farmValue.rawValue) as! String), attributes: self.attrs)
                cell.billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                
            }
            self.transparentView.isHidden = true
            self.billingView.isHidden = true
        }
    }
}
