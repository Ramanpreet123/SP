
//
//  OrderingDefaultsVC.swift
//  SearchPoint
//
//  Created by "" on 01/10/2019.
//  ""

import UIKit
import Alamofire

// MARK: - ORDERING DEFAULTS VC
class OrderingDefaultsVC: UIViewController ,offlineCustomView1 {
    
    // MARK: - OUTLETS
    @IBOutlet weak var datePickerViewOutlet: NSLayoutConstraint!
    @IBOutlet weak var keyBaordSepratorView: UIImageView!
    @IBOutlet weak var keyBoardTopView: NSLayoutConstraint!
    @IBOutlet weak var btn_KeyboardInfo: UIButton!
    @IBOutlet weak var btnSwitch: UISwitch!
    @IBOutlet weak var datePickerLabel: UILabel!
    @IBOutlet weak var manualEnteryLabel: UILabel!
    @IBOutlet weak var dateOfBirthTile: UILabel!
    @IBOutlet weak var ocrBackroundBtnOutlet: UIButton!
    @IBOutlet weak var sampleTagsTitle: UILabel!
    @IBOutlet weak var scannerViewShow: UIView!
    @IBOutlet weak var ocrInfoBtnOutle: UIButton!
    @IBOutlet weak var ocrBtnOutlet: UIButton!
    @IBOutlet weak var tblViewhRIGHTcON: NSLayoutConstraint!
    @IBOutlet weak var selctProductLbl: UILabel!
    @IBOutlet weak var providerTitleLbl: UILabel!
    @IBOutlet weak var productTblView: UITableView!
    @IBOutlet weak var primarlyHeightConst: NSLayoutConstraint!
    @IBOutlet weak var continueOrderBttn: UIButton!
    @IBOutlet weak var speciesCollectionView: UICollectionView!
    @IBOutlet weak var evalutionProviderCV: UICollectionView!
    @IBOutlet weak var calendarViewBkg: UIView!
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var farmIdBttn: UIButton!
    @IBOutlet weak var rfidBttn: UIButton!
    @IBOutlet weak var billingView: UIView!
    @IBOutlet weak var networkStatusImg: UIImageView!
    @IBOutlet weak var nominatorHeightConst: NSLayoutConstraint!
    @IBOutlet weak var speciesCollectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var primarlyBasedView: UIView!
    @IBOutlet weak var NetworkStatusLbl: UILabel!
    @IBOutlet weak var keyBaordFullView: UIView!
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var marketView: UIView!
    @IBOutlet weak var menuBttn: UIButton!
    @IBOutlet weak var marketTipYopOutlet: customButton!
    @IBOutlet weak var dateBtnOutlet: customButton!
    @IBOutlet weak var date1BtnOutlet: customButton!
    @IBOutlet weak var offLineBtn: UIButton!
    @IBOutlet weak var holsteinBtnOutlet: customButton!
    @IBOutlet weak var zoetisBtnOutlet: customButton!
    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var evalutionProvideOutlet: customButton!
    @IBOutlet weak var idScannerTitle: UILabel!
    @IBOutlet weak var scannerSepratorBar: UIImageView!
    @IBOutlet weak var scannerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var keyBoardViewHeight: NSLayoutConstraint!
    @IBOutlet weak var keyboardTtile: UILabel!
    @IBOutlet weak var keyboardSepratorTitle: UIImageView!
    @IBOutlet weak var providerCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var productDoneClick: UIButton!
    @IBOutlet weak var alphaNumericbtnOutler: customButton!
    @IBOutlet weak var numericKeyBoardBtnOutle: customButton!
    @IBOutlet weak var ocrViewShow: UIView!
    @IBOutlet weak var ocrCollectionView: UICollectionView!
    @IBOutlet weak var primaryBasedOutlet: customButton!
    @IBOutlet weak var rfidBtnOutlet: customButton!
    @IBOutlet weak var datePickerEntryOutlet: UIButton!
    @IBOutlet weak var defaultEntryModeOutlet: UIButton!

    // MARK: - VARIABLES AND CONSTANTS
    var isGenotypeOnlyAdded = false
    var isGenostarblackOnlyAdded = false
    var imageArray = ["tag_1","tag_3"]
    var productName = String()
    var didselectTouched = false
    var productPopupFlag = 0
    var brazilProduct = [String]()
    var productArr = NSArray()
    var productSelected  =  [GetProductTbl]()
    var ScreenDef = String()
    var switchFromDairy = Bool()
    var byDefaultProvider = keyValue.clarifideCDCBUS.rawValue
    var specname = String()
    var orderSlideTag : Int?
    var sampleArr = NSMutableArray()
    var breedArr  = NSMutableArray()
    var providerVM: GetProviderViewModel?
    var breedVM: GetBreedViewModel?
    var speciesVM: GetSpeciesViewModel?
    var marketVM :GetMarketsViewModel?
    var productVM :GetProductsViewModel?
    var nominatorsVM :GetNominatorsViewModel?
    var speciesArray = [GetSpeciesTbl]()
    var providerId = Int()
    var dataModel:LoginModel?
    let custId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
    let dateFormatter = DateFormatter()
    let locale = NSLocale.current
    var datePicker : UIDatePicker!
    let toolBar = UIToolbar()
    var isSelectedArray = [Bool]()
    let buttonbg1 = UIButton ()
    var customPopView1 :TipPopUp!
    var editflag :Int?
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as! Int
    var inheritInfoButtonFrame = CGFloat.zero
    var customerOrderSetting = CustomerOrderSetting()
    var speiecCountCheck = NSArray()
    var provideCountCheck = [GetProviderTbl]()
    var getListProvider  = [GetProviderTbl]()
    var customerProviders = [GetProviderTbl]()
    var customerMarkets = [CustomerMarkets]()
    let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
    var fetchDataEntry : [DataEntryList] = []
    var listName = String()
    let orderingDatalistVM = OrderingDataListViewModel()
    let pvidDairy = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
    var value = 0
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    
    // MARK: - VIEW LIFE CYCLE
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
    
    // MARK: - METHODS AND FUNCTIONS
    func getMarketsForCurrentCustomer() {
        if let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int {
            let markets = fetchAllDataWithCustomerID(entityName: Entities.customerMarketsTblEntity, customerId: currentCustomerId)
            self.customerMarkets = markets as? [CustomerMarkets] ?? []
            
        }
    }
   
    func providerEvaliuater(arr:[GetProviderTbl]) -> [GetProviderTbl] {
        getListProvider.removeAll()
        for provider in arr {
            var providersForCustomerMarkets = [Int]()
            for markets in customerMarkets {
                let evaluationMarkets = fetchEvaluationMarkets(entityName: Entities.evaluationMarketsTblEntity, marketId: markets.marketId ?? "", speciesId: provider.speciesId ?? "")
                
                for market in evaluationMarkets as? [EvaluationMarkets] ?? [] {
                    let providers = fetchEvaluationProvider(entityName: Entities.getProviderTblEntity, providerId: Int(market.providerID))
                    
                    for provider in providers as? [GetProviderTbl] ?? [] {
                        providersForCustomerMarkets.append(Int(provider.providerId))
                    }
                }
            }
            
            if providersForCustomerMarkets.contains(Int(provider.providerId)) {
                getListProvider.append(provider)
            }
        }
        return getListProvider
    }

    func initialNetworkCheck(){
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del =  UIApplication.shared.delegate as? AppDelegate
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if NetworkStatusLbl?.text == NSLocalizedString(ButtonTitles.connectedText, comment: "") {
            self.offLineBtn.isUserInteractionEnabled = false
            networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else {
            networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
            self.offLineBtn.isUserInteractionEnabled = true
        }
    }

    func crossBtn() {
        buttonbg1.removeFromSuperview()
        customPopView1.removeFromSuperview()
    }
    
    func addBeefProducts() {
        UserDefaults.standard.set(true, forKey: keyValue.identifyStore.rawValue)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        deleteDataProduct(entityName:Entities.productAdonAnimlBeefTblEntity,status:"false")
        deleteDataProduct(entityName:Entities.subProductBeefTblEntity, status: "false")
        deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
        deleteRecordFromDatabase(entityName: Entities.offlineOrderBeefTblEntity)
        deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
        let animalData = fetchAllDataOrderStatus(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false",orderId:1,userId:1) as! [BeefAnimaladdTbl]
        updateProductTablStatus(entity: Entities.getProductBeefTblEntity)
        updateProductTablStatus(entity: Entities.getAdonTblEntity)
        
        for product in self.productArr as? [GetProductTbl] ?? [] {
            product.isAdded = "true"
            if pvid == 13 {
                saveProductSaveBeef(entity: Entities.getProductBeefTblEntity, productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId ?? "", status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
            } else{
                saveProductSaveBeef(entity: Entities.getProductBeefTblEntity, productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId ?? "", status:"false", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
            }
        }
        
        let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
        
        for k in 0 ..< animalData.count{
            let animalId = animalData[k] as! BeefAnimaladdTbl
            
            for i in 0 ..< product.count {
                
                let data = product[i] as! GetProductTblBeef
                
                if pvid == 13 {
                    saveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: animalId.farmId ?? "", orderId: 1, orderStatus: "false", isSync: "false", userId: userId,udid:"", animalId: Int(animalId.animalId), marketName: data.marketName ?? "", orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: true)
                } else{
                    saveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: animalId.farmId ?? "", orderId: 1, orderStatus: "false", isSync: "false", userId: userId,udid:"", animalId: Int(animalId.animalId), marketName: data.marketName ?? "", orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: true)
                }
                
                
                let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                
                for j in 0 ..< addonArr.count {
                    let addonDat = addonArr[j] as! GetAdonTbl
                    
                    saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: 1, orderStatus: "false", isSync: "false", userId: userId,udid:"", farmId: animalId.farmId ?? "", animalId: Int(animalId.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                }
            }
        }
    }
    
    func addProduct() {
        let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        deleteDataProduct(entityName:Entities.productAdonAnimalTblEntity,status:"false")
        deleteDataProduct(entityName:Entities.subProductTblEntity, status: "false")
        UserDefaults.standard.removeObject(forKey: keyValue.identifyStore.rawValue)
        UserDefaults.standard.removeObject(forKey: keyValue.productCount.rawValue)
        UserDefaults.standard.removeObject(forKey: keyValue.breed.rawValue)
        UserDefaults.standard.removeObject(forKey: keyValue.bvdvValidation.rawValue)
        UserDefaults.standard.set(nil, forKey: "On")
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        
        updateProductTablStatus(entity: Entities.getProductTblEntity)
        updateProductTablStatus(entity: Entities.getAdonTblEntity)
        
        let animalArr1 = fetchAllDataOrderStatus(entityName: Entities.animalAddTblEntity,ordestatus: "false",orderId:orderId,userId:userId)
        if animalArr1.count > 0 {
            for k in 0 ..< animalArr1.count {
                let  breedId1  = animalArr1[k] as! AnimaladdTbl
                let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: pvid, breedId: breedId1.breedId!)
                let productCount = UserDefaults.standard.integer(forKey: keyValue.productCount.rawValue)
                if productCount == 0{
                    UserDefaults.standard.set(breedId1.breedId, forKey: keyValue.breed.rawValue)
                }
                UserDefaults.standard.set(true, forKey: keyValue.identifyStore.rawValue)
                
                
                UserDefaults.standard.set( product.count, forKey: keyValue.productCount.rawValue)
                var animalID = UserDefaults.standard.integer(forKey: keyValue.animalId.rawValue)
                for i in 0 ..< product.count{
                    let data = product[i] as! GetProductTbl
                    
                    saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: breedId1.animalTag ?? "" , barCodetag: breedId1.animalbarCodeTag ?? "",mkdId: data.marketId! , productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: breedId1.farmId!, orderId: Int(breedId1.orderId), orderStatus: "false",isSync:"false", userId: userId,udid:breedId1.udid!, animalId: Int(breedId1.animalId), marketName: breedId1.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),isCdcbProduct: data.isCdcbProduct)
                    
                    let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                    for j in 0 ..< addonArr.count{
                        let addonDat = addonArr[j] as! GetAdonTbl
                        
                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag:  breedId1.animalTag ?? "", barCodetag: breedId1.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(breedId1.orderId), orderStatus: "false",isSync:"false", userId: userId,udid:breedId1.udid!, farmId: breedId1.farmId!, animalId: Int(breedId1.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                    }
                }
            }
        }
    }
}

// MARK: - COLLECTIONVIEW DATASOURCE AND DELEGATE
extension OrderingDefaultsVC: UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return speiecCountCheck.count
        }
        else {
            return getListProvider.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1{
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: "species", for: indexPath) as! SpeciesCollectionViewCell
            let data = speiecCountCheck[indexPath.row] as! GetSpeciesTbl
            let spName = UserDefaults.standard.value(forKey: "name") as? String
            item.speciesBttn.setTitle(NSLocalizedString("\(data.speciesName ?? "")", comment: ""), for: .normal )
            item.speciesBttn.addTarget(self, action: #selector(OrderingDefaultsVC.specisButton(_:)) , for: .touchUpInside )
            item.speciesBttn.tag = indexPath.row
            
            if data.speciesName ?? ""  == spName{
                item.speciesBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                item.speciesBttn.isUserInteractionEnabled = true
                item.speciesBttn.layer.borderWidth = 2
            }
            else {
                item.speciesBttn.layer.borderColor = UIColor.gray.cgColor
                item.speciesBttn.layer.borderWidth = 1
            }
            
            if indexPath.row == 2 {
                item.speciesBttn.layer.borderColor = UIColor.gray.cgColor
                item.speciesBttn.layer.borderWidth = 1
                item.speciesBttn.alpha = 0.3
            } else {
                item.speciesBttn.alpha = 1
            }
            return item
        }
        else  {
            marketTipYopOutlet.isHidden = false
            let spName = UserDefaults.standard.value(forKey: "name") as? String
            
            if spName == "Dairy" {
                let item = evalutionProviderCV.dequeueReusableCell(withReuseIdentifier: "provider", for: indexPath) as! EvaluationProviderViewCell
                if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) == keyValue.clarifideCDCBUS.rawValue{
                    nominatorHeightConst.constant = 100
                    
                }
                else  if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) == keyValue.clarifideCDCBBR.rawValue{
                    nominatorHeightConst.constant = 100
                    
                }else {
                    nominatorHeightConst.constant = 0
                }
                
                item.EcalutionProviderBttn.tag = indexPath.row
                let arrData = getListProvider[indexPath.row] as! GetProviderTbl
                item.EcalutionProviderBttn.setTitle("\(arrData.providerName!)", for: .normal )
                item.EcalutionProviderBttn.setTitleColor(UIColor.gray, for: .normal)
                item.EcalutionProviderBttn.titleLabel?.lineBreakMode = .byWordWrapping
                
                if getListProvider.count == 1 || getListProvider.count == 2 {
                    providerCollectionViewHeight.constant = 70
                } else if getListProvider.count == 0 {
                    providerCollectionViewHeight.constant = 0
                }else {
                    providerCollectionViewHeight.constant = 140
                }
                //Evaluation Provider issue
                var pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
                if pvid ==  nil || pvid == 0{
                    UserDefaults.standard.setValue(getListProvider[0].providerId, forKey: keyValue.providerID.rawValue)
                    pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
                }
                
                if pvid == arrData.providerId{
                    item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    item.EcalutionProviderBttn.layer.borderWidth = 2
                    let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
                    UserDefaults.standard.set(arrData.providerName, forKey: keyValue.providerName.rawValue)
                    
                }
                
                else {
                    item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                    item.EcalutionProviderBttn.backgroundColor = UIColor.white
                    item.EcalutionProviderBttn.layer.borderWidth = 1
                }
  
                item.EcalutionProviderBttn.addTarget(self, action: #selector(OrderingDefaultsVC.providerButton(_:)) , for: .touchUpInside )
                return item
                
            } else {
                let item = evalutionProviderCV.dequeueReusableCell(withReuseIdentifier: "provider", for: indexPath) as! EvaluationProviderViewCell
                item.EcalutionProviderBttn.tag = indexPath.row
                item.isUserInteractionEnabled = true
                let arrData = getListProvider[indexPath.row] as? GetProviderTbl
                item.EcalutionProviderBttn.setTitle("\(arrData!.providerName!)", for: .normal )
                item.EcalutionProviderBttn.setTitleColor(UIColor.gray, for: .normal)
                var isProviderIdfoundInMarket = false
                
                if getListProvider.count == 1 || getListProvider.count == 2 {
                    providerCollectionViewHeight.constant = 70
                } else if getListProvider.count == 0 {
                    providerCollectionViewHeight.constant = 0
                    
                }else {
                    providerCollectionViewHeight.constant = 140
                }
                
                var pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
                if pvid ==  nil || pvid == 0{
                    UserDefaults.standard.setValue(getListProvider[0].providerId, forKey: keyValue.beefPvid.rawValue)
                    pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
                }
                if pvid == arrData!.providerId {
                    item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    item.EcalutionProviderBttn.layer.borderWidth = 2
                } else {
                    item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                    item.EcalutionProviderBttn.backgroundColor = UIColor.white
                    item.EcalutionProviderBttn.layer.borderWidth = 1
                }
                if pvid == 5 {
                    marketTipYopOutlet.isHidden = true
                }
                
                item.EcalutionProviderBttn.addTarget(self, action: #selector(OrderingDefaultsVC.providerButton(_:)) , for: .touchUpInside )
                return item
            }
        }
    }
  
}

// MARK: - OFFLINE CUSTOM VIEW EXTENSION
extension OrderingDefaultsVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
}

// MARK: - SIDE MENU UI EXTENSION
extension OrderingDefaultsVC : SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}

// MARK: - TABLEVIEW DATASOURCE AND DELEGATES
extension OrderingDefaultsVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.beefProductTVCIdentifier, for: indexPath) as! BeefProductsTableViewCell
        let product =  self.productArr.object(at: indexPath.row) as! GetProductTbl
        
        if product.productName == keyValue.genoTypeOnly.rawValue
        {
            var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
            if langId == 2{
                cell.productName.text = keyValue.genotipagem.rawValue
            }
            else
            {
                cell.productName.text = product.productName
            }
        }
        else
        {
            cell.productName.text = product.productName
        }
        cell.radioBttn.isUserInteractionEnabled = false
        cell.iiBttn.isHidden = true
        
        
        if product.productId == 20 {
            cell.iiBttn.isHidden = false
            self.inheritInfoButtonFrame = cell.iiBttn.center.x - cell.iiBttn.frame.size.width / 2
            cell.iiBttn.addTarget(self, action: #selector(self.marketTipPop), for: .touchUpInside)
        }
        
        //for Global
        if pvid == 5 {
            
            tblViewhRIGHTcON.constant = 140
            if product.isAdded == "true" {
                
                cell.radioBttn.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
            } else{
                cell.radioBttn.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
            }
            
            cell.isUserInteractionEnabled = true
            cell.radioBttn.alpha = 1
            cell.alpha = 1
            cell.productName.alpha = 1
            
            if UserDefaults.standard.integer(forKey: keyValue.isGlobalHD50DisabledForBrazil.rawValue) == 1 && indexPath.row == 0 {
                
                cell.isUserInteractionEnabled = false
                cell.radioBttn.alpha = 0.2
                cell.alpha = 0.2
                cell.productName.alpha = 0.2
            }
            else {
                cell.isUserInteractionEnabled = true
                cell.radioBttn.alpha = 1
                cell.alpha = 1
                cell.productName.alpha = 1
            }
            
            
            
            if UserDefaults.standard.integer(forKey: keyValue.isInhertDisabledForBrazil.rawValue) == 1 && indexPath.row == 1 {
                cell.isUserInteractionEnabled = false
                cell.radioBttn.alpha = 0.2
                cell.alpha = 0.2
                cell.productName.alpha = 0.2
            }
            
            
        }
        
        //for brazil
        if pvid == 6 {
            tblViewhRIGHTcON.constant = 188
            
            if product.isAdded == "true" {
                cell.radioBttn.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
            } else{
                cell.radioBttn.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
            }
            
            cell.isUserInteractionEnabled = true
            cell.radioBttn.alpha = 1
            cell.alpha = 1
            cell.productName.alpha = 1
        }
        
        //for Newzealand
        if pvid == 7 {
            if product.isAdded == "true" {
                cell.radioBttn.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
            } else{
                cell.radioBttn.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
            }
        }
        
        return cell
    }
    
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pid =   UserDefaults.standard.integer(forKey: keyValue.bfProductId.rawValue)
        let  pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        let product =  self.productArr.object(at: indexPath.row) as! GetProductTbl
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        var data = fetchAllDataWithOrderIDWithBeef(entityName: Entities.beefAnimalAddTblEntity,pid:pid,userId:userId)
        
        var  strmsg = String()
        if data.count > 0{
            if pvid != 6{
                
                if pid == product.productId {
                    strmsg = AlertMessagesStrings.removeProductSelection
                }else{
                    strmsg = AlertMessagesStrings.changeProductSelection
                }
                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: strmsg, preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    self.didselectTouched = true
                    UserDefaults.standard.set(true, forKey: keyValue.showbeefInheritTable.rawValue)
                    if UserDefaults.standard.string(forKey: "name") == marketNameType.Beef.rawValue {
                        let  pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
                        
                        if pvid == 5 || pvid == 13 {
                            //for Global
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                if product.isAdded == "true" {
                                    deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                                    deleteRecordFromDatabase(entityName: Entities.productAdonAnimlBeefTblEntity)
                                    deleteRecordFromDatabase(entityName: Entities.subProductBeefTblEntity)
                                    deleteRecordFromDatabase(entityName: Entities.offlineOrderBeefTblEntity)
                                    UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                                    if pvid == 5{
                                        saveProductSaveBeef(entity: Entities.getProductBeefTblEntity, productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"false", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                                    } else {
                                        saveProductSaveBeef(entity: Entities.getProductBeefTblEntity, productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                                    }
                                }
                            }
                        }
                        
                        if pvid == 6 {
                            //for Brazil
                            deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                            
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                if product.isAdded == "true" {
                                    UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                                } else {
                                    deleteDataWithProductBeef(entityName: Entities.getProductBeefTblEntity, productId: Int(product.productId))
                                }
                            }
                        }
                        
                        if pvid == 7 {
                            //for Newzealand
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                if product.isAdded == "true" {
                                    deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                                    deleteRecordFromDatabase(entityName: Entities.beefAnimalAddTblEntity)
                                    deleteRecordFromDatabase(entityName: Entities.productAdonAnimlBeefTblEntity)
                                    deleteRecordFromDatabase(entityName: Entities.subProductBeefTblEntity)
                                    UserDefaults.standard.set(Int(product.productId), forKey: keyValue.bfProductId.rawValue)
                                    saveProductSaveBeef(entity: Entities.getProductBeefTblEntity, productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: product.breedId ?? "", mkId: product.marketId!, status:"true", isAdded: "true", orderAcceptTerms: product.orderAcceptTerms ?? "", pricing: product.pricing ?? "")
                                }
                            }
                        }
                    }
                    
                    
                    
                    
                    if pvid == 5 || pvid == 13{
                        //for global
                        
                        if let  products = self.productArr as? [GetProductTbl] {
                            for product in products {
                                product.isAdded = "false"
                                
                                UserDefaults.standard.set(product.productId, forKey: keyValue.chpid.rawValue)
                            }
                            products[indexPath.row].isAdded = "true"
                            
                        }
                        if UserDefaults.standard.string(forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue) == keyValue.rgn.rawValue || UserDefaults.standard.string(forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue) == keyValue.rgd.rawValue ||  UserDefaults.standard.bool(forKey: keyValue.series.rawValue) == true{
                            
                            UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue)
                            UserDefaults.standard.set(false, forKey: keyValue.brazilBarcode.rawValue)
                            UserDefaults.standard.set(false, forKey: keyValue.series.rawValue)
                        }
                        if UserDefaults.standard.bool(forKey: keyValue.brazilBarcode.rawValue) == true {
                            UserDefaults.standard.set(false, forKey: keyValue.brazilBarcode.rawValue)
                            UserDefaults.standard.set(keyValue.barcode.rawValue, forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue)
                        }
                        if UserDefaults.standard.string(forKey: keyValue.inheritFOReviewOrderVC.rawValue) == keyValue.rgn.rawValue || UserDefaults.standard.string(forKey: keyValue.inheritFOReviewOrderVC.rawValue) == keyValue.rgd.rawValue ||  UserDefaults.standard.bool(forKey: keyValue.seriesReviewVC.rawValue) == true{
                            
                            UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.inheritFOReviewOrderVC.rawValue)
                            UserDefaults.standard.set(false, forKey: keyValue.brazilBarcodeReviewVC.rawValue)
                            UserDefaults.standard.set(false, forKey: keyValue.seriesReviewVC.rawValue)
                        }
                        if UserDefaults.standard.bool(forKey:keyValue.brazilBarcodeReviewVC.rawValue) == true {
                            UserDefaults.standard.set(false, forKey: keyValue.brazilBarcodeReviewVC.rawValue)
                            UserDefaults.standard.set(keyValue.barcode.rawValue, forKey: keyValue.inheritFOReviewOrderVC.rawValue)
                        }
                        
                        UserDefaults.standard.set(product.productId, forKey: keyValue.beefProductID.rawValue)
                        self.productTblView.reloadData()
                    }
                    
                    if pvid == 6 {
                        //for brazil
                        
                        if let  products = self.productArr as? [GetProductTbl] {
                            for product in products {
                                product.isAdded = "false"
                            }
                            products[indexPath.row].isAdded = "false"
                            
                        }
                        self.brazilProduct.append(product.productName!)
                        UserDefaults.standard.set(product.productId, forKey: keyValue.beefProductID.rawValue)
                        UserDefaults.standard.set(product.productId, forKey: keyValue.chpid.rawValue)
                        UserDefaults.standard.set(self.brazilProduct, forKey: keyValue.brazilProduct.rawValue)
                        
                        if UserDefaults.standard.string(forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue) == keyValue.barcode.rawValue {
                            UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue)
                            UserDefaults.standard.set(true, forKey: keyValue.brazilBarcode.rawValue)
                        }
                        if UserDefaults.standard.string(forKey: keyValue.inheritFOReviewOrderVC.rawValue) == keyValue.barcode.rawValue {
                            UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.inheritFOReviewOrderVC.rawValue)
                            UserDefaults.standard.set(true, forKey: keyValue.brazilBarcodeReviewVC.rawValue)
                        }
                        self.productTblView.reloadData()
                    }
                    
                    if pvid == 7 {
                        //for Newzealand
                        
                        if let  products = self.productArr as? [GetProductTbl] {
                            for product in products {
                                product.isAdded = "false"
                                UserDefaults.standard.set(product.productId, forKey: keyValue.chpid.rawValue)
                            }
                            
                            if UserDefaults.standard.string(forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue) == keyValue.rgn.rawValue || UserDefaults.standard.string(forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue) == keyValue.rgd.rawValue ||  UserDefaults.standard.bool(forKey: keyValue.series.rawValue) == true{
                                UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue)
                                UserDefaults.standard.set(false, forKey: keyValue.brazilBarcode.rawValue)
                                UserDefaults.standard.set(false, forKey: keyValue.series.rawValue)
                            }
                            if UserDefaults.standard.bool(forKey:keyValue.brazilBarcode.rawValue) == true {
                                UserDefaults.standard.set(false, forKey: keyValue.brazilBarcode.rawValue)
                                UserDefaults.standard.set(keyValue.barcode.rawValue, forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue)
                            }
                            if UserDefaults.standard.string(forKey: keyValue.inheritFOReviewOrderVC.rawValue) == keyValue.rgn.rawValue || UserDefaults.standard.string(forKey: keyValue.inheritFOReviewOrderVC.rawValue) == keyValue.rgd.rawValue ||  UserDefaults.standard.bool(forKey: keyValue.seriesReviewVC.rawValue) == true{
                                
                                UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.inheritFOReviewOrderVC.rawValue)
                                UserDefaults.standard.set(false, forKey: keyValue.brazilBarcodeReviewVC.rawValue)
                                UserDefaults.standard.set(false, forKey: keyValue.seriesReviewVC.rawValue)
                            }
                            if UserDefaults.standard.bool(forKey:keyValue.brazilBarcodeReviewVC.rawValue) == true {
                                UserDefaults.standard.set(false, forKey: keyValue.brazilBarcodeReviewVC.rawValue)
                                UserDefaults.standard.set(keyValue.barcode.rawValue, forKey: keyValue.inheritFOReviewOrderVC.rawValue)
                            }
                            UserDefaults.standard.set(product.productId, forKey: keyValue.beefProductID.rawValue)
                            products[indexPath.row].isAdded = "true"
                        }
                        
                        self.productTblView.reloadData()
                    }
                }
                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                }
                
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
            else{
                self.didselectTouched = true
                if pvid == 6 {
                    //for brazil
                    
                    if let  products = productArr as? [GetProductTbl] {
                        if products[indexPath.row].isAdded == "true" {
                            products[indexPath.row].isAdded = "false"
                        } else {
                            products[indexPath.row].isAdded = "true"
                        }
                    }
                    brazilProduct.append(product.productName!)
                    UserDefaults.standard.set(product.productId, forKey: keyValue.beefProductID.rawValue)
                    UserDefaults.standard.set(product.productId, forKey: keyValue.chpid.rawValue)
                    UserDefaults.standard.set(brazilProduct, forKey: keyValue.brazilProduct.rawValue)
                    
                    if UserDefaults.standard.string(forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue) == keyValue.barcode.rawValue {
                        UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue)
                        UserDefaults.standard.set(true, forKey: keyValue.brazilBarcode.rawValue)
                    }
                    if UserDefaults.standard.string(forKey: keyValue.inheritFOReviewOrderVC.rawValue) == keyValue.barcode.rawValue {
                        UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.inheritFOReviewOrderVC.rawValue)
                        UserDefaults.standard.set(true, forKey: keyValue.brazilBarcodeReviewVC.rawValue)
                    }
                    productTblView.reloadData()
                }
            }
        }else{
            self.didselectTouched = true
            if pvid == 5 || pvid == 13{
                //for global
                UserDefaults.standard.set(true, forKey: keyValue.showbeefInheritTable.rawValue)
                if let  products = productArr as? [GetProductTbl] {
                    for product in products {
                        product.isAdded = "false"
                        
                        UserDefaults.standard.set(product.productId, forKey: keyValue.chpid.rawValue)
                    }
                    products[indexPath.row].isAdded = "true"
                    
                }
                if UserDefaults.standard.string(forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue) == keyValue.rgn.rawValue || UserDefaults.standard.string(forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue) == keyValue.rgd.rawValue ||  UserDefaults.standard.bool(forKey: keyValue.series.rawValue) == true{
                    
                    UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.brazilBarcode.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.series.rawValue)
                }
                if UserDefaults.standard.bool(forKey: keyValue.brazilBarcode.rawValue) == true {
                    UserDefaults.standard.set(false, forKey: keyValue.brazilBarcode.rawValue)
                    UserDefaults.standard.set(keyValue.barcode.rawValue, forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue)
                }
                if UserDefaults.standard.string(forKey: keyValue.inheritFOReviewOrderVC.rawValue) == keyValue.rgn.rawValue || UserDefaults.standard.string(forKey: keyValue.inheritFOReviewOrderVC.rawValue) == keyValue.rgd.rawValue ||  UserDefaults.standard.bool(forKey: keyValue.seriesReviewVC.rawValue) == true{
                    
                    UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.inheritFOReviewOrderVC.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.brazilBarcodeReviewVC.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.seriesReviewVC.rawValue)
                }
                if UserDefaults.standard.bool(forKey:keyValue.brazilBarcodeReviewVC.rawValue) == true {
                    UserDefaults.standard.set(false, forKey: keyValue.brazilBarcodeReviewVC.rawValue)
                    UserDefaults.standard.set(keyValue.barcode.rawValue, forKey: keyValue.inheritFOReviewOrderVC.rawValue)
                }
                UserDefaults.standard.set(product.productId, forKey: keyValue.beefProductID.rawValue)
                productTblView.reloadData()
            }
            
            if pvid == 6 {
                //for brazil
                
                if let  products = productArr as? [GetProductTbl] {
                    if products[indexPath.row].isAdded == "true" {
                        products[indexPath.row].isAdded = "false"
                    } else {
                        products[indexPath.row].isAdded = "true"
                    }
                }
                brazilProduct.append(product.productName!)
                UserDefaults.standard.set(product.productId, forKey: keyValue.beefProductID.rawValue)
                UserDefaults.standard.set(product.productId, forKey: keyValue.chpid.rawValue)
                UserDefaults.standard.set(brazilProduct, forKey: keyValue.brazilProduct.rawValue)
                
                if UserDefaults.standard.string(forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue) == keyValue.barcode.rawValue {
                    UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue)
                    UserDefaults.standard.set(true, forKey: keyValue.brazilBarcode.rawValue)
                }
                if UserDefaults.standard.string(forKey: keyValue.inheritFOReviewOrderVC.rawValue) == keyValue.barcode.rawValue {
                    UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.inheritFOReviewOrderVC.rawValue)
                    UserDefaults.standard.set(true, forKey: keyValue.brazilBarcodeReviewVC.rawValue)
                }
                productTblView.reloadData()
            }
            
            if pvid == 7 {
                //for Newzealand
                
                if let  products = productArr as? [GetProductTbl] {
                    for product in products {
                        product.isAdded = "false"
                        UserDefaults.standard.set(product.productId, forKey: keyValue.chpid.rawValue)
                    }
                    
                    if UserDefaults.standard.string(forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue) == keyValue.rgn.rawValue || UserDefaults.standard.string(forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue) == keyValue.rgd.rawValue ||  UserDefaults.standard.bool(forKey: keyValue.series.rawValue) == true{
                        UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue)
                        UserDefaults.standard.set(false, forKey: keyValue.brazilBarcode.rawValue)
                        UserDefaults.standard.set(false, forKey: keyValue.series.rawValue)
                    }
                    if UserDefaults.standard.bool(forKey:keyValue.brazilBarcode.rawValue) == true {
                        UserDefaults.standard.set(false, forKey: keyValue.brazilBarcode.rawValue)
                        UserDefaults.standard.set(keyValue.barcode.rawValue, forKey: keyValue.inheritFOSampleTrackingDetailVC.rawValue)
                    }
                    if UserDefaults.standard.string(forKey: keyValue.inheritFOReviewOrderVC.rawValue) == keyValue.rgn.rawValue || UserDefaults.standard.string(forKey: keyValue.inheritFOReviewOrderVC.rawValue) == keyValue.rgd.rawValue ||  UserDefaults.standard.bool(forKey: keyValue.seriesReviewVC.rawValue) == true{
                        
                        UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.inheritFOReviewOrderVC.rawValue)
                        UserDefaults.standard.set(false, forKey: keyValue.brazilBarcodeReviewVC.rawValue)
                        UserDefaults.standard.set(false, forKey: keyValue.seriesReviewVC.rawValue)
                    }
                    if UserDefaults.standard.bool(forKey:keyValue.brazilBarcodeReviewVC.rawValue) == true {
                        UserDefaults.standard.set(false, forKey: keyValue.brazilBarcodeReviewVC.rawValue)
                        UserDefaults.standard.set(keyValue.barcode.rawValue, forKey: keyValue.inheritFOReviewOrderVC.rawValue)
                    }
                    UserDefaults.standard.set(product.productId, forKey: keyValue.beefProductID.rawValue)
                    products[indexPath.row].isAdded = "true"
                }
                
                productTblView.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

// MARK: - INHERIT QUESTIONNAIRE DELEGATE
extension OrderingDefaultsVC: InheritQuestionaireControllerDelegate {
    func inheritQuestionaireControllerDismissed() {
        if UserDefaults.standard.value(forKey: keyValue.settingDone.rawValue) == nil || UserDefaults.standard.value(forKey: keyValue.settingDone.rawValue) as? String == ""{
            UserDefaults.standard.set("true", forKey: keyValue.settingDone.rawValue)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.beefAnimalGlobalHD50KVC) as! BeefAnimalGlobalHD50KVC
            self.navigationController?.pushViewController(newViewController, animated: false)
        }
        else {
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC) as! DashboardVC
            self.navigationController?.pushViewController(newViewController, animated: false)
        }
    }
}


// MARK: - GET,CREATE AND DELETE LIST
extension OrderingDefaultsVC{
    func getListName()  {
        listName = orderingDatalistVM.makeListName(custmerId: custId , providerID: pvidDairy)
        fetchDataEntry  = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.custId ),listName:listName ,productName:marketNameType.Beef.rawValue) as! [DataEntryList]
        
    }
    func createListNameAndCheckifExist(){
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        getListName()
        if fetchDataEntry.count > 0 {
            
            deleteList(listName: listName, customerId: Int64(custId ),listID: Int(fetchDataEntry[0].listId))
            deleteDataWithListIdDatEntry(entityString: Entities.dataEntryAnimalAddTbl, listId: Int(fetchDataEntry[0].listId), customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userId:userId)
            
            deleteDataWithListId(entityString: Entities.dataEntryListTblEntity, listId: Int64(fetchDataEntry[0].listId), customerId: Int(custId ),userId:userId )
        }
        
    }
    func updateProviderId() {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        updateProductTablDataaid(entity: Entities.getProductTblEntity, status: "false")
        let fethData =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId, farmId:"")
        for pName in fethData as? [ProductAdonAnimalTbl] ?? [] {
            updateProductTablaid(entity:Entities.getProductTblEntity,productId:
                                    Int(pName.productId),status: "true")
        }
        
        let animaltbl = fetchAllDataOrderStatus(entityName: Entities.animalAddTblEntity,ordestatus: "false",orderId:orderId,userId:userId) as! [AnimaladdTbl]
        for _ in animaltbl {
            updateProviderIDAnimal(entityName: Entities.animalAddTblEntity, ordestatus: "false", providerId: pvid, orderId: orderId, userId: userId)
            
        }
    }
    
    func updateBeefProviderId() {
        UserDefaults.standard.set(false, forKey: keyValue.beefBVDVSeleted.rawValue)
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        self.createListNameAndCheckifExist()
        updateProductTablDataaid(entity: Entities.getProductBeefTblEntity, status: "false")
        let fethData =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimlBeefTblEntity, asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId, farmId:"")
        for pName in fethData as? [ProductAdonAnimlTbLBeef] ?? [] {
            updateProductTablaid(entity:Entities.getProductBeefTblEntity,productId:
                                    Int(pName.productId),status: "true")
        }
        
        let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
        let animaltbl = fetchAllDataOrderStatus(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false",orderId:1,userId:1) as! [BeefAnimaladdTbl]
        
        for k in 0 ..< animaltbl.count{
            let earTag = animaltbl[k].animalTag
            let eid = animaltbl[k].sireIDAU
            let existingPvid = animaltbl[k].providerId
            let barCode = animaltbl[k].animalbarCodeTag
            switch existingPvid {
            case 5:
                updateBeefAnimalProviderID_AnimalTag_Sireid(entityName: Entities.beefAnimalAddTblEntity, ordestatus: "false", providerId: pvid, orderId: 1, userId: 1, earTag: eid ?? "", sireIDAU: earTag ?? "",barCode: barCode ?? "")
            case 13:
                updateBeefAnimalProviderID_AnimalTag_Sireid(entityName: Entities.beefAnimalAddTblEntity, ordestatus: "false", providerId: pvid, orderId: 1, userId: 1, earTag: eid ?? "", sireIDAU: earTag ?? "", barCode: barCode ?? "")
            default:
                updateProviderIDAnimal(entityName: Entities.beefAnimalAddTblEntity, ordestatus: "false", providerId: pvid, orderId: 1, userId: 1)
            }
        }
    }
    
  
    func deleteList(listName: String, customerId: Int64, listID: Int) {
        
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict = [LocalizedStrings.authorizationHeader.localized: accessToken!,LocalizedStrings.contentType.localized : LocalizedStrings.formURLEncoded]
        var header = HTTPHeaders(headerDict )
        
        let urlString = Configuration.Dev(packet: ApiKeys.deleteList.rawValue).getUrl()
        let parameters : [String: Any] = ["customerId": customerId,"listName":listName]
        
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = headerDict
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType.localized)
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
