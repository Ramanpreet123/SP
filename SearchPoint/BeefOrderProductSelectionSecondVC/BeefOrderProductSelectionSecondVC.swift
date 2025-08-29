//
//  BeefOrderProductSelectionSecondVC.swift
//  SearchPoint
//
//  Created by "" on 12/03/20.
//

import UIKit
import DropDown
import Swift_PageMenu
import Alamofire

class BeefOrderProductSelectionSecondVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextFieldDelegate,BillingDelegate {
    
    @IBOutlet weak var bilingContatctLbl: UILabel!
    @IBOutlet weak var billingViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var farmIdHideLbl: UILabel!
    var identifiy = Bool()
    @IBOutlet weak var toggleBtnOutlet: UIButton!
    @IBOutlet weak var farmIdDisplyOutlet: UIButton!
    @IBOutlet weak var serchTextField: UITextField!
    @IBOutlet weak var tblView:UITableView!
    @IBOutlet weak var tableViewBilling : UITableView!
    @IBOutlet weak var dropUpDownBtn: UIButton!
    @IBOutlet weak var networkStatusLbl: UILabel!
    @IBOutlet weak var networkStatusImg: UIImageView!
    @IBOutlet weak var OffLineBtn: UIButton!
    @IBOutlet weak var appHelpBtn: UIButton!
    var rGN_ID = 0
    var rGD_ID = 0
    @IBOutlet weak var billingTableView: UITableView!
    @IBOutlet weak var notificationLblCount: UILabel!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var billingView: UIView!
    var attrs : [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.blue,.underlineStyle: NSUnderlineStyle.single.rawValue]
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
    var barCodeId = Int()
    var animaId = Int()
    var clickOnDropDown = String()
    var isBillingContact = true
    var indexOfSelection:[IndexPath?] = [IndexPath]()
    var collViewOfselection:[UICollectionView?] = [UICollectionView]()
    var billingdelegateVC = BillingTableViewDelegate()
    var farmAddr = [GetBillingContact]()
    var userId = Int()
    var orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
    var langId = UserDefaults.standard.value(forKey: "lngId") as? Int
    
    var heartBeatViewModel:HeartBeatViewModel?
    
    var fetchDataEntry : [DataEntryList] = []
    var listName = String()
    let orderingDatalistVM = OrderingDataListViewModel()
    var objApiSync = ApiSyncList()
    let custmerId = UserDefaults.standard.value(forKey: "currentActiveCustomerId") as! Int
    let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
    
    func navigateToAnotherVc(){
       // impplementation removed
    }
    override func viewDidLoad() {
        farmAddr = fetchBillingCustomer(entityName: "GetBillingContact",customerID: self.custmerId) as! [GetBillingContact]
        super.viewDidLoad()
        
        UserDefaults.standard.setValue(nil, forKey: "submitTypeSelection")
        
        heartBeatViewModel = HeartBeatViewModel(callBack: navigateToAnotherVc)
        heartBeatViewModel?.callGetHearBeatData()
        
        landIdApplangaugeConversion()
        userId = UserDefaults.standard.integer(forKey: "userId")
        orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
        UserDefaults.standard.set(false, forKey: "isBarCodeIncrementalClear")
        
        initialNetworkCheck()
        tableViewBilling.delegate = billingdelegateVC
        tableViewBilling.dataSource = billingdelegateVC
        tableViewBilling.reloadData()
        billingdelegateVC.delegate = self
        fethData = fetchAllDataOrderStatus(entityName: "ProductAdonAnimlTbLBeef", ordestatus: "false",orderId: orderId,userId:userId)
        let dataval : [ProductAdonAnimlTbLBeef] =  fetchAllDataFarmIdStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true", orderStatus: "false",orderId:orderId,userId:userId, farmId: serchTextField.text!) as! [ProductAdonAnimlTbLBeef]
        fetchProductAdonAnimalTbl(fethData: fethData, completion: {
                 // needs handling
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if dataval.count > 0 {
                for i in 0..<dataval.count{
                    self.fetchAdonData(pid: Int(dataval[i].productId), animaltag: String(dataval[i].animalTag ?? "") , index: i)
                }
            }
        }
        
        perform(#selector(reloadTable), with: nil, afterDelay: 0.1)
        if pvid == 13 {
            appHelpBtn.isHidden = false
        } else {
            appHelpBtn.isHidden = true
        }
    }
    
    @IBOutlet weak var sortBtLbl: UILabel!
    @IBOutlet weak var orderProductSeleTitleLbl: UILabel!
    @IBOutlet weak var applyEnttireOrderLbl: UILabel!
    
    
    @IBOutlet weak var appStatusLbl: UILabel!
    func landIdApplangaugeConversion(){
        bilingContatctLbl.text = NSLocalizedString("Select Billing Contact", comment: "")
        sortBtLbl.text = NSLocalizedString("Sort By:", comment: "")
        orderProductSeleTitleLbl.text = NSLocalizedString("Ordering Product Selection(s)", comment: "")
        appStatusLbl.text = NSLocalizedString("App Status:", comment: "")
        applyEnttireOrderLbl.text = NSLocalizedString("Apply to Entire Order", comment: "")
        serchTextField.placeholder = NSLocalizedString("Search", comment: "")
    }
    
    @IBAction func viewAnimalClick(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BeefViewAnimalVC") as? BeefViewAnimalVC
        vc!.screenBackSave = false
        vc!.productBackSave = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    private func fetchProductAdonAnimalTbl(fethData:NSArray,completion: @escaping ()->()){
        values.removeAll()
        barCode.removeAll()
        farmID.removeAll()
        arr1.removeAll()
        serieArr.removeAll()
        rgdArr.removeAll()
        rgnArr.removeAll()
        for result in fethData{
            
            if let item = result as? ProductAdonAnimlTbLBeef{
                
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
    private func fetchProductAdonAnimalTblForCollectionView(fethData:NSArray,completion: @escaping ()->()){
        values.removeAll()
        barCode.removeAll()
        farmID.removeAll()
        arr1.removeAll()
        serieArr.removeAll()
        rgdArr.removeAll()
        rgnArr.removeAll()
        for result in fethData{
            if let item = result as? ProductAdonAnimlTbLBeef{
                
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
        
        completion()
        
    }
    func fetchAdonData(indexPath:IndexPath, collectionView:UICollectionView) {
        if collectionView.tag < values.count && arr1[values[collectionView.tag]]!.count > indexPath.row {
            
            pid = Int(arr1[values[collectionView.tag]]![indexPath.row].productId)
            aTag = arr1[values[collectionView.tag]]![indexPath.row].animalTag
            let data = fetchSubProductDataBeef(entityName: "SubProductTblBeef",productId: Int(pid),animalTag: aTag!,orderId:orderId,userId:userId) as? [SubProductTblBeef]
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
                selection.append (["animalTag": aTag as Any,"addon": data as Any,"row": collectionView.tag])
            }
        }
        reloadTable()
    }
    
    func fetchAdonData(pid:Int, animaltag:String, index:Int) {
        
        let data = fetchSubProductDataBeef(entityName: "SubProductTblBeef",productId: Int(pid),animalTag: animaltag, orderId:orderId, userId:userId) as? [SubProductTblBeef]
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
        if found ==  false && data!.count > 0{
            selection.append (["animalTag":animaltag,"addon":data as Any,"row":index])
        }
        
        
        reloadTable()
        
        
    }
    @objc func reloadTable(){
        
        tblView.delegate = self
        tblView.dataSource = self
        tblView.reloadData()
    }
    
    @IBAction func farmIdDropDown(_ sender: UIButton) {
        
        dropUpDownBtn.setImage(UIImage(named: "Image"), for: .normal)
        dropDown.anchorView = farmIdHideLbl
        dropDown.direction = .bottom
        dropDown.backgroundColor = UIColor.white
        dropDown.separatorColor = UIColor.clear
        dropDown.cornerRadius = 10
        dropDown.textFont = UIFont.systemFont(ofSize: 13)
        dropDown.cellHeight = 30
       
        if pvid == 5 {
            dropDown.dataSource = [ NSLocalizedString(ButtonTitles.earTagText, comment: ""), NSLocalizedString("Barcode", comment: "")]
        }
       
        if pvid == 6{
            dropDown.dataSource = [NSLocalizedString("Barcode", comment: ""), NSLocalizedString("Series", comment: ""), NSLocalizedString("RGN", comment: ""), NSLocalizedString(LocalizedStrings.RGDorAnimalIDText, comment: "")]
        }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            self.clickOnDropDown = item
            
            self.farmIdDisplyOutlet.setTitle(item, for: .normal)
            self.farmIdDisplyOutlet.layer.borderColor = UIColor.gray.cgColor
            if pvid == 5 {
                if self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: "") || self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: "") {
                    UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
                    if self.animaId == 0{
                        self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                        
                        self.fethData =  fetchAllDataanimalTag(entityName: "ProductAdonAnimlTbLBeef",asending : true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                            // Intentionally left empty.
                            // Could be used in the future for logging, analytics, or error handling.
                        })
                        self.animaId = 1
                        
                    }
                    else{
                        self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                        
                        self.fethData =  fetchAllDataanimalTag(entityName: "ProductAdonAnimlTbLBeef", asending: false,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                            // Intentionally left empty.
                            // Could be used in the future for logging, analytics, or error handling.
                        })
                        self.animaId = 0
                    }
                    
                }
                else{
                    UserDefaults.standard.set("barcode", forKey: "InheritFOSampleTrackingDetailVC")
                    if self.barCodeId == 0{
                        self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                        
                        self.fethData =  fetchAllDataBarcOde(entityName: "ProductAdonAnimlTbLBeef", asending: true,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                            // Intentionally left empty.
                            // Could be used in the future for logging, analytics, or error handling.
                        })
                        self.barCodeId = 1
                    }
                    else{
                        self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                        
                        self.fethData =  fetchAllDataBarcOde(entityName: "ProductAdonAnimlTbLBeef", asending: false,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                            // Intentionally left empty.
                            // Could be used in the future for logging, analytics, or error handling.
                        })
                        self.barCodeId = 0
                    }
                    
                }
            }
            else{
                if self.clickOnDropDown == NSLocalizedString("Barcode", comment: ""){
                    UserDefaults.standard.set(true, forKey: "brazilBarcode")
                    UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
                    if self.animaId == 0{
                        self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                        
                        self.fethData =  fetchAllDataanimalTag(entityName: "ProductAdonAnimlTbLBeef",asending : true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                            // Intentionally left empty.
                            // Could be used in the future for logging, analytics, or error handling.
                        })
                        self.animaId = 1
                        
                    }
                    else{
                        self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                        
                        self.fethData =  fetchAllDataanimalTag(entityName: "ProductAdonAnimlTbLBeef", asending: false,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                            // Intentionally left empty.
                            // Could be used in the future for logging, analytics, or error handling.
                        })
                        self.animaId = 0
                    }
                    
                }
                if self.clickOnDropDown == NSLocalizedString("Series", comment: "") {
                    UserDefaults.standard.set(false, forKey: "brazilBarcode")
                    UserDefaults.standard.set(true, forKey: "series")
                    UserDefaults.standard.set("Series", forKey: "InheritFOSampleTrackingDetailVC")
                    if self.barCodeId == 0{
                        self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                        
                        self.fethData =  fetchAllDataBarcOde(entityName: "ProductAdonAnimlTbLBeef", asending: true,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                            // Intentionally left empty.
                            // Could be used in the future for logging, analytics, or error handling.
                        })
                        self.barCodeId = 1
                    }
                    else{
                        self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                        
                        self.fethData =  fetchAllDataBarcOde(entityName: "ProductAdonAnimlTbLBeef", asending: false,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                            // Intentionally left empty.
                            // Could be used in the future for logging, analytics, or error handling.
                        })
                        self.barCodeId = 0
                    }
                    
                }
                if self.clickOnDropDown == NSLocalizedString("RGN", comment: ""){
                    UserDefaults.standard.set("rgn", forKey: "InheritFOSampleTrackingDetailVC")
                    if self.rGN_ID == 0{
                        self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                        
                        self.fethData =  fetchAllDataRGN(entityName: "ProductAdonAnimlTbLBeef", asending: true,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                            // Intentionally left empty.
                            // Could be used in the future for logging, analytics, or error handling.
                        })
                        self.rGN_ID = 1
                    }
                    else{
                        self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                        
                        self.fethData =  fetchAllDataRGN(entityName: "ProductAdonAnimlTbLBeef", asending: false,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                            // Intentionally left empty.
                            // Could be used in the future for logging, analytics, or error handling.
                        })
                        self.rGN_ID = 0
                    }
                    
                }
                
                if self.clickOnDropDown == NSLocalizedString("RGD", comment: "") || self.clickOnDropDown == NSLocalizedString(LocalizedStrings.RGDorAnimalIDText, comment: ""){
                    UserDefaults.standard.set("rgd", forKey: "InheritFOSampleTrackingDetailVC")
                    if self.rGD_ID == 0{
                        self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                        
                        self.fethData =  fetchAllDataRGD(entityName: "ProductAdonAnimlTbLBeef", asending: true,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                            // Intentionally left empty.
                            // Could be used in the future for logging, analytics, or error handling.
                        })
                        self.rGD_ID = 1
                    }
                    else{
                        self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                        
                        self.fethData =  fetchAllDataRGD(entityName: "ProductAdonAnimlTbLBeef", asending: false,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                            // Intentionally left empty.
                            // Could be used in the future for logging, analytics, or error handling.
                        })
                        self.rGD_ID = 0
                    }
                    
                }
            }
            
        }
        dropDown.show()
    }
    @IBAction func billingClick(_ sender: UIButton) {
        
        if let cell = self.tblView.cellForRow(at: IndexPath(row: self.arr1.keys.count, section: 0) ) as? BillingCell {
            if cell.billingBtnOutlet.titleLabel?.text == "N/A"{
                
                
                transparentView.isHidden = true
                billingView.isHidden = true
                isBillingContact = true
            }else {
                transparentView.isHidden = false
                billingView.isHidden = false
                isBillingContact = false
                billingViewHeightConst.constant = billingTableView.contentSize.height + 100
                billingTableView.reloadData()
                
                
            }
        }
    }
    @IBAction func backBtnClk(_ sender: UIButton) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
        
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
        if pvid == 13 {
            applyEnttireOrderLbl.isHidden = true
            toggleBtnOutlet.isHidden = true
            appHelpBtn.isHidden = false
        } else {
            applyEnttireOrderLbl.isHidden = false
            toggleBtnOutlet.isHidden = false
            appHelpBtn.isHidden = true
        }
        self.getListName()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        
        
        UserDefaults.standard.set("page", forKey: "page")
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.navigationBar.isHidden = true
        
        
        if  UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == nil {
            UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
          
            if pvid == 5{
                self.clickOnDropDown = NSLocalizedString(ButtonTitles.earTagText, comment: "")
            }
            if pvid == 6 {
                self.clickOnDropDown = NSLocalizedString("Barcode", comment: "")
            }
            
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            fethData =  fetchAllDataanimalTag(entityName: "ProductAdonAnimlTbLBeef",asending : true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
        }
    
        if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "officialid" {
            UserDefaults.standard.set(true, forKey: "brazilBarcode")
          
         
            if pvid == 5{
                self.clickOnDropDown = NSLocalizedString(ButtonTitles.earTagText, comment: "")
            }
            if pvid == 6{
                self.clickOnDropDown = NSLocalizedString("Barcode", comment: "")
            }
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            self.fethData =  fetchAllDataanimalTag(entityName: "ProductAdonAnimlTbLBeef",asending : true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
        }
        if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "barcode" {
            
            if pvid == 6{
                UserDefaults.standard.set(false, forKey: "brazilBarcode")
                UserDefaults.standard.set(true, forKey: "series")
                self.clickOnDropDown = NSLocalizedString("Series", comment: "")
            }
            else{
                self.clickOnDropDown = NSLocalizedString("Barcode", comment: "")
            }
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            self.fethData =  fetchAllDataBarcOde(entityName: "ProductAdonAnimlTbLBeef", asending: true,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
        }
        if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "rgn" {
            
            self.clickOnDropDown = NSLocalizedString("RGN", comment: "")
            
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            
            self.fethData =  fetchAllDataRGN(entityName: "ProductAdonAnimlTbLBeef", asending: true,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
        }
        if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "rgd" {
            
            self.clickOnDropDown = NSLocalizedString(LocalizedStrings.RGDorAnimalIDText, comment: "")
            
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            
            self.fethData =  fetchAllDataRGD(entityName: "ProductAdonAnimlTbLBeef", asending: true,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
        }
        if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "Series" {
            
            self.clickOnDropDown = NSLocalizedString("Series", comment: "")
            
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            
            self.fethData =  fetchAllDataRGD(entityName: "ProductAdonAnimlTbLBeef", asending: true,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
        }
        
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: UserDefaults.standard.integer(forKey: "userId"),orderId:1,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
        notificationLblCount.text = String(animalCount.count)
        
        if farmAddr.count > 0  {
            var abc = ""
            let filterArr = farmAddr.filter({$0.isDefault })
            if filterArr.count > 0{
                abc = filterArr[0].contactName ?? ""
            } else{
                let billArray =  farmAddr.filter({Int($0.billToCustId!) == self.custmerId})
                abc = billArray[0].contactName ?? ""
                UserDefaults.standard.set(billArray[0].billToCustId, forKey: "billToCustomerId")
            }
            DispatchQueue.main.async {
                if let cell = self.tblView.cellForRow(at: IndexPath(row: self.arr1.keys.count, section: 0) ) as? BillingCell{
                    let attributeString = NSMutableAttributedString(string: abc , attributes: self.attrs)
                    UserDefaults.standard.set(abc, forKey: "farmValue")
                    
                    cell.billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                    self.tblView.reloadData()
                    
                } else {
                    
                    let cell = self.tblView.cellForRow(at: IndexPath(row: self.arr1.keys.count, section: 0) ) as? BillingCell
                    let attributeString = NSMutableAttributedString(string: abc , attributes: self.attrs)
                    UserDefaults.standard.set(abc, forKey: "farmValue")
                    
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
    @IBAction func crossClick(_ sender: UIButton) {
        transparentView.isHidden = true
        billingView.isHidden = true
        
        
    }
    @IBAction func menuBtnClk(_ sender: UIButton) {
        self.view.makeCorner(withRadius: 40)
        self.sideMenuViewController?.presentRightMenuViewController()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr1.keys.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == arr1.keys.count{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BillinghCell", for: indexPath) as! BillingCell
            
            cell.reviewOrderBtnTitle.setTitle(NSLocalizedString("Review Order", comment: ""),for: .normal)
            cell.billingContactTitle.text = NSLocalizedString("Billing Contact:", comment: "")
            
            
            if UserDefaults.standard.string(forKey: "providerNameUS") != "CLARIFIDE CDCB (US)" {
             
                cell.nominatorTitle.isHidden = true
                cell.nominatorLbl.isHidden = true
                
            }else{
             
                cell.nominatorTitle.isHidden = false
                cell.nominatorLbl.isHidden = false
            }
            updateUIForButtonTitle()
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "beefOPSTableViewCell", for: indexPath) as! BeefOPSTableViewCell
        cell.barcodeTitle.text = NSLocalizedString("Barcode" , comment: "")
        cell.earTagTtitle.text = NSLocalizedString("EarTag", comment: "")
        
        if pvid == 5 {
            cell.OfficialId.text =  String(values[indexPath.row])
            cell.Barcode.text =  String(barCode[indexPath.row])
            cell.vollView.tag = indexPath.row
            cell.deleteBttn.tag = indexPath.row
            cell.deleteBttn.addTarget(nil, action: #selector(deleteButton(_:)), for: .touchUpInside)
        }
       
        if pvid == 6 {
            cell.farmidTitleBottom.constant = 10
            cell.farmIdTitle.text = NSLocalizedString("Barcode", comment: "")
            cell.farmIdColonHeight.constant = 12
            cell.OnFarmId.text =  String(values[indexPath.row])
            cell.earTagTtitle.text = NSLocalizedString("Series", comment: "")
            cell.OfficialId.text =  String(serieArr[indexPath.row])
            cell.barcodeTitle.text = NSLocalizedString("RGN", comment: "")
            cell.Barcode.text =  String(rgnArr[indexPath.row])
            cell.rgdColonheight.constant = 12
            cell.rgdTitleHeight.constant = 20
            cell.rgdLbl.text = String(rgdArr[indexPath.row])
            cell.vollView.tag = indexPath.row
            cell.deleteBttn.tag = indexPath.row
            cell.deleteBttn.addTarget(nil, action: #selector(deleteButton(_:)), for: .touchUpInside)
            
            cell.rgdOrAnimalId.text = NSLocalizedString(LocalizedStrings.RGDorAnimalIDText , comment: "")
            
            
        }
      
        cell.vollView.reloadData()
        return cell
    }
    
    @objc func deleteButton(_ sender : UIButton){
        // deleted for now
        
    }
    
    @IBAction func dropAction(_ sender: UIButton) {
        
        if pvid == 5 || pvid == 7 || pvid == 13{
            if self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: "") || self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: "")  {
                if self.animaId == 0{
                    dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                    
                    self.fethData =  fetchAllDataanimalTag(entityName: "ProductAdonAnimlTbLBeef",asending : true,orderId:orderId,userId:userId, animalTag: serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                        // Intentionally left empty.
                        // Could be used in the future for logging, analytics, or error handling.
                    })
                    self.animaId = 1
                    
                }
                else{
                    dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                    
                    self.fethData =  fetchAllDataanimalTag(entityName: "ProductAdonAnimlTbLBeef", asending: false,orderId:orderId,userId:userId, animalTag: serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                        // Intentionally left empty.
                        // Could be used in the future for logging, analytics, or error handling.
                    })
                    self.animaId = 0
                }
                
            }
            else{
                if self.barCodeId == 0{
                    dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                    
                    self.fethData =  fetchAllDataBarcOde(entityName: "ProductAdonAnimlTbLBeef", asending: true,orderId:orderId,userId:userId, barcode: serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                        // Intentionally left empty.
                        // Could be used in the future for logging, analytics, or error handling.
                    })
                    self.barCodeId = 1
                }
                else{
                    dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                    
                    self.fethData =  fetchAllDataBarcOde(entityName: "ProductAdonAnimlTbLBeef", asending: false,orderId:orderId,userId:userId, barcode: serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                        // Intentionally left empty.
                        // Could be used in the future for logging, analytics, or error handling.
                    })
                    self.barCodeId = 0
                }
                
            }
        }
        else{
            if self.clickOnDropDown == NSLocalizedString("Barcode", comment: ""){
                
                if self.animaId == 0{
                    self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                    
                    self.fethData =  fetchAllDataanimalTag(entityName: "ProductAdonAnimlTbLBeef",asending : true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                        // Intentionally left empty.
                        // Could be used in the future for logging, analytics, or error handling.
                    })
                    self.animaId = 1
                    
                }
                else{
                    self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                    
                    self.fethData =  fetchAllDataanimalTag(entityName: "ProductAdonAnimlTbLBeef", asending: false,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                        // Intentionally left empty.
                        // Could be used in the future for logging, analytics, or error handling.
                    })
                    self.animaId = 0
                }
                
            }
            if self.clickOnDropDown == NSLocalizedString("Series", comment: "") {
                
                if self.barCodeId == 0{
                    self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                    
                    self.fethData =  fetchAllDataBarcOde(entityName: "ProductAdonAnimlTbLBeef", asending: true,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                        // Intentionally left empty.
                        // Could be used in the future for logging, analytics, or error handling.
                    })
                    self.barCodeId = 1
                }
                else{
                    self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                    
                    self.fethData =  fetchAllDataBarcOde(entityName: "ProductAdonAnimlTbLBeef", asending: false,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                        // Intentionally left empty.
                        // Could be used in the future for logging, analytics, or error handling.
                    })
                    self.barCodeId = 0
                }
                
            }
            if self.clickOnDropDown == NSLocalizedString("RGN", comment: "") || self.clickOnDropDown == NSLocalizedString(LocalizedStrings.RGDorAnimalIDText, comment: ""){
                
                if self.rGN_ID == 0{
                    self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                    
                    self.fethData =  fetchAllDataRGN(entityName: "ProductAdonAnimlTbLBeef", asending: true,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                        // Intentionally left empty.
                        // Could be used in the future for logging, analytics, or error handling.
                    })
                    self.rGN_ID = 1
                }
                else{
                    self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                    
                    self.fethData =  fetchAllDataRGN(entityName: "ProductAdonAnimlTbLBeef", asending: false,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                        // Intentionally left empty.
                        // Could be used in the future for logging, analytics, or error handling.
                    })
                    self.rGN_ID = 0
                }
                
            }
            
            if self.clickOnDropDown == NSLocalizedString("RGD", comment: "") ||  self.clickOnDropDown == NSLocalizedString(LocalizedStrings.RGDorAnimalIDText, comment: ""){
                
                if self.rGD_ID == 0{
                    self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                    
                    self.fethData =  fetchAllDataRGD(entityName: "ProductAdonAnimlTbLBeef", asending: true,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                        // Intentionally left empty.
                        // Could be used in the future for logging, analytics, or error handling.
                    })
                    self.rGD_ID = 1
                }
                else{
                    self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                    
                    self.fethData =  fetchAllDataRGD(entityName: "ProductAdonAnimlTbLBeef", asending: false,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                        // Intentionally left empty.
                        // Could be used in the future for logging, analytics, or error handling.
                    })
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
        if newString != ""{
            if pvid == 5 || pvid == 7 {
                
                if self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: "") || self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: "")  {
                    
                    let fetchcustRep =   fetchAllDataanimalTag(entityName: "ProductAdonAnimlTbLBeef",asending : true,orderId:orderId,userId:userId, animalTag: newString as String)
                    if fetchcustRep.count > 0 {
                        fetchProductAdonAnimalTbl(fethData: fetchcustRep, completion: {
                            // Intentionally left empty.
                            // Could be used in the future for logging, analytics, or error handling.
                        })
                    }
                    else{
                        arr1.removeAll()
                        reloadTable()
                        
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 1, position: .center)
                    }
                }
                if clickOnDropDown == NSLocalizedString("Barcode", comment: ""){
                    let fetchcustRep =    fetchAllDataBarcOde(entityName: "ProductAdonAnimlTbLBeef", asending: true,orderId:orderId,userId:userId, barcode: newString as String)
                    if fetchcustRep.count > 0 {
                        fetchProductAdonAnimalTbl(fethData: fetchcustRep, completion: {
                            // Intentionally left empty.
                            // Could be used in the future for logging, analytics, or error handling.
                        })
                    }
                    else{
                        arr1.removeAll()
                        reloadTable()
                        
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 1, position: .center)
                    }
                }
            }
            else{
                if self.clickOnDropDown == NSLocalizedString("Barcode", comment: ""){
                    let fetchcustRep =   fetchAllDataanimalTag(entityName: "ProductAdonAnimlTbLBeef",asending : true,orderId:orderId,userId:userId, animalTag: newString as String)
                    if fetchcustRep.count > 0 {
                        fetchProductAdonAnimalTbl(fethData: fetchcustRep, completion: {
                            // Intentionally left empty.
                            // Could be used in the future for logging, analytics, or error handling.
                        })
                    }
                    else{
                        arr1.removeAll()
                        reloadTable()
                        
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 1, position: .center)
                    }
                }
                if clickOnDropDown == NSLocalizedString("Series", comment: ""){
                    let fetchcustRep =    fetchAllDataBarcOde(entityName: "ProductAdonAnimlTbLBeef", asending: true,orderId:orderId,userId:userId, barcode: newString as String)
                    if fetchcustRep.count > 0 {
                        fetchProductAdonAnimalTbl(fethData: fetchcustRep, completion: {
                            // Intentionally left empty.
                            // Could be used in the future for logging, analytics, or error handling.
                        })
                    }
                    else{
                        arr1.removeAll()
                        reloadTable()
                        
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 1, position: .center)
                    }
                }
                if clickOnDropDown == "RGN"{
                    let fetchcustRep =    fetchAllDataRGN(entityName: "ProductAdonAnimlTbLBeef", asending: true,orderId:orderId,userId:userId, barcode: newString as String)
                    if fetchcustRep.count > 0 {
                        fetchProductAdonAnimalTbl(fethData: fetchcustRep, completion: {
                            // Intentionally left empty.
                            // Could be used in the future for logging, analytics, or error handling.
                        })
                    }
                    else{
                        arr1.removeAll()
                        reloadTable()
                        
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 1, position: .center)
                    }
                }
                if clickOnDropDown == NSLocalizedString("RGD", comment: "") ||  self.clickOnDropDown == NSLocalizedString(LocalizedStrings.RGDorAnimalIDText, comment: ""){
                    let fetchcustRep =    fetchAllDataRGD(entityName: "ProductAdonAnimlTbLBeef", asending: true,orderId:orderId,userId:userId, barcode: newString as String)
                    if fetchcustRep.count > 0 {
                        fetchProductAdonAnimalTbl(fethData: fetchcustRep, completion: {
                            // Intentionally left empty.
                            // Could be used in the future for logging, analytics, or error handling.
                        })
                    }
                    else{
                        arr1.removeAll()
                        reloadTable()
                        
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.noRecordFound, comment: ""), duration: 1, position: .center)
                    }
                }
                
            }
        }
        else{
            dropUpDownBtn.setImage(UIImage(named: "Image"), for: .normal)
            fethData =   fetchAllDataOrderStatus(entityName: "ProductAdonAnimlTbLBeef", ordestatus: "false",orderId:orderId,userId:userId)
            fetchProductAdonAnimalTbl(fethData: fethData, completion: {
                // Intentionally left empty.
                // Could be used in the future for logging, analytics, or error handling.
            })
            
            reloadTable()
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == arr1.keys.count{
            
            if UserDefaults.standard.string(forKey: "providerNameUS") != "CLARIFIDE CDCB (US)" {
                return 270
                
            }else{
                return 150
            }
            
            
        }
        var addon = 0
        var data = [String:Any]()
        for result in selection{
            if (result["animalTag"] as! String) == String(values[indexPath.row]){
                data = result
            }
        }
        if let item = data["animalTag"] as? String, values[indexPath.row] == item {
                let data = data["addon"] as? [SubProductTblBeef]
                if data!.count > 0 {
                    if data!.count % 2 == 0{
                        addon = Int(40 * CGFloat(data!.count/2 )  + CGFloat(data!.count*10))
                    }else{
                        addon = Int(40 * CGFloat(data!.count/2 + 1)  + CGFloat(data!.count*10))
                    }
                    
                }
            }
        
        let count = (arr1[values[indexPath.row]]!.count)/2 + 1
        var height:CGFloat
        
        height = 40 * CGFloat(count) + 50 + CGFloat(count*20) + CGFloat(addon + 70)
        
        return height
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1{
            var data = [String:Any]()
            for result in selection{
                if (result["animalTag"] as! String) == String(values[collectionView.tag]){
                    data = result
                }
            }
            if let item  = data["animalTag"] as? String{
                if values[collectionView.tag] == item{
                    return (data["addon"] as! NSArray).count == 0 ? 0 :  (data["addon"] as! NSArray).count + 2
                }else{
                    return 0
                }
            }
            else{
                return 0
            }
        } else {
            return arr1[values[collectionView.tag]]!.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0{
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: "OPSCollectionViewCell", for: indexPath)  as! OPSCollectionViewCell
            item.layer.masksToBounds = true
            item.layoutIfNeeded()
            item.lbl.layoutIfNeeded()
            item.lbl.layer.masksToBounds = true
            item.lbl.text = arr1[values[collectionView.tag]]![indexPath.row].productName ?? ""
            item.addonInfoBtnOutlet.isHidden = true
            item.lbl.layer.borderColor = UIColor.lightGray.cgColor
            if arr1[values[collectionView.tag]]![indexPath.row].status! == "true"{
                collViewOfselection.append(collectionView)
                indexOfSelection.append(indexPath)
                item.lbl.backgroundColor = UIColor(red: 220/255, green: 54/255, blue: 72/255, alpha: 1)
                item.lbl.textColor = UIColor.white
            } else {
                
                item.lbl.backgroundColor = UIColor.white
                item.lbl.textColor = UIColor.black
            }
            
            return item
        } else {
            if indexPath.row == 0 {
                let item = collectionView.dequeueReusableCell(withReuseIdentifier: "addOnWithTitle", for: indexPath)
                item.isUserInteractionEnabled = false
                return item
            }else  if indexPath.row == 1 {
                let item = collectionView.dequeueReusableCell(withReuseIdentifier: "addOn", for: indexPath)
                item.isUserInteractionEnabled = false
                return item
            }else{
                let item = collectionView.dequeueReusableCell(withReuseIdentifier: "OPSCollectionViewCell", for: indexPath)  as! OPSCollectionViewCell
                item.layer.masksToBounds = true
                item.layoutIfNeeded()
                item.lbl.layoutIfNeeded()
                item.lbl.layer.masksToBounds = true
                var data = [String:Any]()
                for result in selection{
                    if (result["animalTag"] as! String) == String(values[collectionView.tag]){
                        data = result
                    }
                }
                item.lbl.layer.borderColor = UIColor.lightGray.cgColor
                
                
                if ((data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).adonName ?? "" == "BVDV"{
                    if UserDefaults.standard.bool(forKey: "BeefBVDVSeleted"){
                        item.lbl.backgroundColor = UIColor(red: 220/255, green: 54/255, blue: 72/255, alpha: 1)
                        item.lbl.textColor = UIColor.white
                        
                        updateAdonData(entity: "SubProductTblBeef", adonId: Int(( (data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).adonId), status: "true", animaltag: ( (data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).animalTag ?? "", orderId: orderId, userId: userId)
                        
                        updateAdoonTabl(entity: "GetAdonTbl", AdonId: Int(( (data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).adonId), status: "true",productId: Int(( (data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).productId))
                        
                        
                    }else {
                        item.lbl.backgroundColor = UIColor.white
                        item.lbl.textColor = UIColor.black
                        
                        updateAdonData(entity: "SubProductTblBeef", adonId: Int(( (data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).adonId), status: "false", animaltag: ( (data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).animalTag ?? "", orderId: orderId, userId: userId)
                        
                        updateAdoonTabl(entity: "GetAdonTbl", AdonId: Int(( (data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).adonId), status: "false",productId: Int(( (data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).productId))
                        
                    }
                    
                } else {
                    if ((data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).status! == "true" {
                        item.lbl.backgroundColor = UIColor(red: 220/255, green: 54/255, blue: 72/255, alpha: 1)
                        item.lbl.textColor = UIColor.white
                        
                    } else {
                        item.lbl.backgroundColor = UIColor.white
                        item.lbl.textColor = UIColor.black
                    }
                }
                
                if langId == 1 {
                    let englishText = ((data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).textValueEnglish ?? ""
                    if englishText == "" {
                        item.addonInfoBtnOutlet.isHidden = true
                    } else {
                        item.addonInfoBtnOutlet.isHidden = false
                    }
                } else {
                    let englishText = ((data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).textValuePortugese ?? ""
                    if englishText == "" {
                        item.addonInfoBtnOutlet.isHidden = true
                    } else {
                        item.addonInfoBtnOutlet.isHidden = false
                    }
                }
                
                item.addonInfoBtnOutlet.addTarget(self, action: #selector(openPopUp(_:)), for:.touchUpInside)
                item.lbl.text = ((data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).adonName ?? ""
                item.addonInfoBtnOutlet.tag = indexPath.item
                return item
            }
        }
    }
    
    @objc func openPopUp(_ sender: UIButton){
        
        var data = [String:Any]()
        for result in selection{
            if (result["animalTag"] as! String) == String(values[0]){
                data = result
            }
        }
        
        if langId == 1 {
            
            
            if data.count != 0 {
                
                let englishText = ((data["addon"] as! NSArray).object(at: sender.tag - 2) as! SubProductTblBeef).textValueEnglish!
                
                if englishText != ""{
                    
                    let vc = self.storyboard!.instantiateViewController(withIdentifier: "CommanInfoPopUpController") as! CommanInfoPopUpController
                    vc.stringGetThroughArray = englishText
                    self.navigationController?.present(vc, animated: false, completion: nil)
                }
            }
            
        } else {
            
            if data.count != 0 {
                
                let PortugeseText = ((data["addon"] as! NSArray).object(at: sender.tag - 2) as! SubProductTblBeef).textValuePortugese!
                if PortugeseText != ""{
                    let vc = self.storyboard!.instantiateViewController(withIdentifier: "CommanInfoPopUpController") as! CommanInfoPopUpController
                    vc.stringGetThroughArray = PortugeseText
                    self.navigationController?.present(vc, animated: false, completion: nil)
                }}
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width / 2 ) - 10, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        if UserDefaults.standard.value(forKey: "Brazil") as? String == "BR"{
            UserDefaults.standard.set("off", forKey: "On")
        }
        
        if indexPath.section == 0{
            
            pid =  Int(arr1[values[collectionView.tag]]![indexPath.row].productId)
            aTag = arr1[values[collectionView.tag]]![indexPath.row].animalTag
            
            
            if UserDefaults.standard.value(forKey: "Brazil") as? String != "BR" {
                
                
                let fethData1 =  fetchAllDataFarmIdStatusCheckdata(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId,aTag: aTag, pId: pid)
                if fethData1.count > 0 {
                    self.hideIndicator()
                    return
                }
            }
            else{
                let dataval =  fetchAllDataFarmIdStatusCheck(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true", orderStatus: "false",orderId:orderId,userId:userId, farmId: aTag)
                if dataval.count == 1{
                    let datValue = dataval.object(at: 0) as! ProductAdonAnimlTbLBeef
                    if datValue.productId == pid{
                        return
                    }
                    
                }
            }
            
            UserDefaults.standard.set(aTag, forKey: "aTag")
            UserDefaults.standard.set(pid, forKey: "pdId")
            
            let data = fetchSubProductDataBeef(entityName:"SubProductTblBeef", productId: Int(pid),animalTag: aTag!, orderId: orderId,userId:userId) as? [SubProductTblBeef]
            
            var found = false
            if data!.count > 0{
                for i in 0..<selection.count{
                    if let value = selection[i]["animalTag"] as? String, value  == aTag{
                        selection[i]["animalTag"] = aTag
                        selection[i]["addon"] = data
                        selection[i]["row"] = collectionView.tag
                        found = true
                        break
                    }
                }
                if found ==  false{
                    selection.append (["animalTag":aTag as Any,"addon":data as Any,"row":collectionView.tag])
                    
                }
            }else{
                for i in 0..<selection.count{
                    if let value = selection[i]["animalTag"] as? String, value  == aTag{
                        selection.remove(at: i)
                        break
                    }
                }
            }
            
            if UserDefaults.standard.value(forKey: "Brazil") as? String == "BR" {
                
                let data =   fetchSubProductDataBeef(entityName: "ProductAdonAnimlTbLBeef", productId: pid, animalTag: aTag, orderId: orderId, userId: userId)
                let statusCheck = data.object(at: 0) as! ProductAdonAnimlTbLBeef
                if statusCheck.status == "true" {
                    updateProducData(entity: "ProductAdonAnimlTbLBeef", productID: pid, status: "false", animalTag: aTag, orderId: orderId,userId:userId, completionHandler: { (success) -> Void in
                   
                        // When download completes,control flow goes here.
                        
                        if success {
                            // download success
                            updateProductTabl(entity: "GetProductTblBeef", productId: pid, status: "false",completionHandler: { (success) -> Void in
                                // When download completes,control flow goes here.
                              
                            })
                        }
                        
                    })
                }
                else {
                    updateProducData(entity: "ProductAdonAnimlTbLBeef", productID: pid, status: "true", animalTag: aTag, orderId: orderId,userId:userId, completionHandler: { (success) -> Void in
               
                        // When download completes,control flow goes here.
                        
                        if success {
                            
                            // download success
                            
                            updateProductTabl(entity: "GetProductTblBeef", productId: pid, status: "true",completionHandler: { (success) -> Void in
                                
                                // When download completes,control flow goes here.
                          
                            })
                            
                        }
                        
                    })
                }
                
            }
            else {
                
                updateAnimalTblData(entity: "ProductAdonAnimlTbLBeef", status: "false", animalTag: aTag, orderId: orderId, userId: userId, completionHandler: { (success) -> Void in
                    
                    if success {
                        updateProducData(entity: "ProductAdonAnimlTbLBeef", productID: Int(pid), status: "true", animalTag: aTag!,orderId: orderId, userId: userId, completionHandler: { (success) -> Void in
                            if success {
                                updateAnimalTblData(entity: "BeefAnimaladdTbl", status:"true", animalTag: aTag, orderId: orderId, userId: userId, completionHandler: { (success) -> Void in
                                    // Intentionally left empty.
                                    // Could be used in the future for logging, analytics, or error handling.
                                })
                            }
                        })
                    }
                })
            }
            
            arr1.removeAll()
          
            if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "barcode" {
                self.clickOnDropDown = NSLocalizedString("Barcode", comment: "")
                self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
                self.fethData =  fetchAllDataBarcOde(entityName: "ProductAdonAnimlTbLBeef", asending: true,orderId:self.orderId,userId:self.userId, barcode: self.serchTextField.text!)
            }
            fetchProductAdonAnimalTblForCollectionView(fethData: fethData, completion: {
                // Intentionally left empty.
                // Could be used in the future for logging, analytics, or error handling.
            })
            
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
                updateAnimalTblData(entity: "SubProductTblBeef", status: "false", animalTag: aTag,orderId: orderId, userId: userId, completionHandler: { (success) -> Void in
                    
                    if success {
                        
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
                        
                        
                    }
                })
            }
            perform(#selector(reloadTable), with: nil, afterDelay: 0.1)
            collectionView.reloadData()
        }else{
          
            aTag = arr1[values[collectionView.tag]]![0].animalTag
            for i in 0..<selection.count{
                if let value = selection[i]["animalTag"] as? String, value  == aTag{
                    
                    let adonId = ( (selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).adonName
                    
                    if adonId == "BVDV"{
                        
                        let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: "BVDV will be applied to the entire order.".localized, preferredStyle: .alert)
                        
                        let okAction = UIAlertAction(title: NSLocalizedString("Continue", comment: ""), style: UIAlertAction.Style.default) {
                            
                            UIAlertAction in
                            
                            if UserDefaults.standard.value(forKey: "screenBeef") as? String == "NZ" {
                                let ageCount =   fetchAllDataAnimalDataBeefSampleTypeAnimaTagNZ(entityName: "BeefAnimaladdTbl", aTag: 35,orderId: self.orderId)
                                if ageCount.count > 0{
                                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("BVDV product selection cannot be applied as animals in order have age less than 35 days.", comment: ""))
                                    return
                                }
                            }
                            UserDefaults.standard.set("off", forKey: "On")
                            
                            if UserDefaults.standard.bool(forKey: "BeefBVDVSeleted"){
                                updateAdonData(entity: "SubProductTblBeef", adonId: Int(( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).adonId), status: "false", animaltag: self.aTag!, orderId: self.orderId, userId: self.userId)
                                updateAdoonTabl(entity: "GetAdonTbl", AdonId: Int(( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).adonId), status: "false",productId: Int(( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).productId))
                                
                                UserDefaults.standard.set(false, forKey: "BeefBVDVSeleted")
                            }
                            else{
                                updateAdoonTabl(entity: "GetAdonTbl", AdonId: Int(( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).adonId), status: "true",productId: Int(( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).productId))
                                updateAdonData(entity: "SubProductTblBeef", adonId: Int(( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).adonId), status: "true", animaltag: String(( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).animalTag ?? ""), orderId: self.orderId, userId: self.userId)
                                
                                UserDefaults.standard.set(true, forKey: "BeefBVDVSeleted")
                            }
                            self.fethData = fetchAllDataOrderStatus(entityName: "ProductAdonAnimlTbLBeef", ordestatus: "false",orderId: self.orderId,userId:self.userId)
                            let dataval =  fetchAllDataFarmIdStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true", orderStatus: "false",orderId:self.orderId,userId:self.userId, farmId: self.serchTextField.text!)
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
                        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            print(LocalizedStrings.cancelPressed)
                        }
                        
                        alertController.addAction(okAction)
                        alertController.addAction(cancelAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                    } else {
                        UserDefaults.standard.set("off", forKey: "On")
                        let data =  fetchSubProductDataStatusUpdateBeef(entityName:"SubProductTblBeef",productId:Int(( (selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).adonId), animalTag: String(( (selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).animalTag ?? ""), status: "true", orderId: orderId,userId:userId)
                        
                        if data.count > 0{
                            updateAdonData(entity: "SubProductTblBeef", adonId: Int(( (selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).adonId), status: "false", animaltag: String(( (selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).animalTag ?? ""), orderId: orderId, userId: userId)
                            
                            updateAdoonTabl(entity: "GetAdonTbl", AdonId: Int(( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).adonId), status: "false",productId: Int(( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).productId))
                        }
                        else{
                            updateAdonData(entity: "SubProductTblBeef", adonId: Int(( (selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).adonId), status: "true", animaltag: aTag!, orderId: orderId, userId: userId)
                            
                            updateAdoonTabl(entity: "GetAdonTbl", AdonId: Int(( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).adonId), status: "true",productId: Int(( (self.selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).productId))
                        }
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
                        collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    //MARK: CHECK SAMPLE TYPE FIRST THEY ARE COMPATIABLE WITH bvdv
    func checkBeefSampletype(indexPath: IndexPath,userId :Int,orderId: Int, collectionViewTag: Int,_ collectionView: UICollectionView)-> Bool{
        aTag = arr1[values[collectionViewTag]]![0].animalTag
        for i in 0..<selection.count{
            if let value = selection[i]["animalTag"] as? String, value  == aTag{
                
                let adonId = ( (selection[i]["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).adonName
                
                if adonId == "BVDV"{
                    let dataSample : [BeefAnimaladdTbl] = fetchAnimalDataBeefSampleTypeWithAnimalId(entityName: "BeefAnimaladdTbl", sampleType1: ButtonTitles.caisleyTSUText, sampleType2: ButtonTitles.allflexTSUText, sampleType3: ButtonTitles.allflexTSTText) as! [BeefAnimaladdTbl]
                    if dataSample.count > 0 {
                        
                        let msg = "animals have the Sample Type other than Allflex (TSU), Allflex (TST) or Caisley (TSU) and the sample type is not compatible with BVDV testing. Please update the sample type or click on continue to remove all such animals from the order.".localized(with: dataSample.count)
                        
                        let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: msg, preferredStyle: .alert)
                        
                        let okAction = UIAlertAction(title: NSLocalizedString("Continue", comment: ""), style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            
                            for i in 0 ..< dataSample.count{
                                if dataSample[i].orderstatus == "false"{
                                    let animalbarCodeTag : String = dataSample[i].animalbarCodeTag ?? ""
                                    let animalId : Int = Int(dataSample[i].animalId)
                                    
                                    BeefDeleteDataWithProduct(Int(animalId))
                                    beefDeleteDataWithSubProduct(Int(animalId))
                                    beefDeleteDataWithAnimal(Int(animalId))
                                    self.deleteSigalAnimalFromList(animalbarCode: animalbarCodeTag)
                                }
                            }
                                                        
                            updateProductTablDataaid(entity: "GetProductTblBeef", status: "false")
                            let fethData =  fetchAllDataFarmIdStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true",orderStatus:"false", orderId: 1,userId:1, farmId:"")
                            for pName in fethData as? [ProductAdonAnimlTbLBeef] ?? [] {
                                updateProductTablaid(entity:"GetProductTblBeef",productId:
                                                        Int(pName.productId),status: "true")
                            }
                            
                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: 1,orderId:1,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: "BeefPvid"))
                            self.notificationLblCount.text = String(animalCount.count)
                            self.view.makeToast("animals removed from order.".localized(with: dataSample.count), duration: 1, position: .bottom)
                            
                            self.fethData = fetchAllDataOrderStatus(entityName: "ProductAdonAnimlTbLBeef", ordestatus: "false",orderId: orderId,userId:userId)
                            let dataval =  fetchAllDataFarmIdStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true", orderStatus: "false",orderId:orderId,userId:userId, farmId: self.serchTextField.text!)
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
                            
                            
                            
                            if animalCount.count == 0 {
                                self.createListNameAndCheckifExist()
                                deleteDataProduct(entityName:"BeefAnimaladdTbl",status:"false")
                                deleteDataProduct(entityName:"ProductAdonAnimlTbLBeef",status:"false")
                                deleteDataProduct(entityName:"SubProductTblBeef", status: "false")
                                UserDefaults.standard.removeObject(forKey: "identifyStore")
                                UserDefaults.standard.removeObject(forKey: "productCount")
                                UserDefaults.standard.set(nil, forKey: "On")
                                UserDefaults.standard.set(nil, forKey: "page")
                                UserDefaults.standard.set("", forKey: "NZBeeftsu")
                                UserDefaults.standard.set("", forKey: "genotypeTissueBttn")
                                updateProductTablStatus(entity: "GetProductTblBeef")
                                updateProductTablStatus(entity: "GetAdonTbl")
                                UserDefaults.standard.removeObject(forKey: "pid")
                                UserDefaults.standard.removeObject(forKey: "Beefbreed")
                                UserDefaults.standard.set(nil, forKey: "Beeftsu")
                                UserDefaults.standard.set(nil, forKey: "InheritBeefbreed")
                                UserDefaults.standard.set(nil, forKey: "BeefInheritTsu")
                                
                                UserDefaults.standard.set(nil, forKey: "InheritBeefbreedClear")
                                UserDefaults.standard.set(nil, forKey: "BeefInheritTsuClear")
                                UserDefaults.standard.set("", forKey: "NZBeeftsuClear")
                                UserDefaults.standard.setValue(nil, forKey: "BeefbreedClear")
                                UserDefaults.standard.setValue(nil, forKey: "BeeftsuClear")
                                UserDefaults.standard.removeObject(forKey: "dataEnteryListName")
                                UserDefaults.standard.removeObject(forKey: keyValue.primaryGenoType.rawValue)
                                UserDefaults.standard.removeObject(forKey: keyValue.secondaryGenoType.rawValue)
                                UserDefaults.standard.removeObject(forKey: keyValue.tertirayGenoType.rawValue)
                                UserDefaults.standard.removeObject(forKey: keyValue.dataListPrimaryGenoType.rawValue)
                                UserDefaults.standard.removeObject(forKey: keyValue.dataListSecondaryGenoType.rawValue)
                                UserDefaults.standard.removeObject(forKey: keyValue.dataListTertirayGenoType.rawValue)
                                UserDefaults.standard.removeObject(forKey: keyValue.beefBreedID.rawValue)
                                UserDefaults.standard.removeObject(forKey: keyValue.beefBreedName.rawValue)
                                UserDefaults.standard.removeObject(forKey: keyValue.dataBeefBreedID.rawValue)
                                UserDefaults.standard.removeObject(forKey: keyValue.dataBeefBreedName.rawValue)
                                UserDefaults.standard.removeObject(forKey: keyValue.GenoBeefBreedName.rawValue)
                                
                                UserDefaults.standard.set(nil, forKey: "BeefbreedClear")
                                UserDefaults.standard.set(nil, forKey: "InheritBeefbreedClear")
                                UserDefaults.standard.set(nil, forKey: "BeefInheritTsuClear")
                                UserDefaults.standard.setValue(nil, forKey: "BeefbreedClear")
                                UserDefaults.standard.setValue(nil, forKey: "BeeftsuClear")
                                UserDefaults.standard.set("", forKey: "NZBeeftsuClear")
                                UserDefaults.standard.set("", forKey: "tissueBttnClear")
                                UserDefaults.standard.set("", forKey: "genotypeTissueBttnClear")
                                
                                UserDefaults.standard.set("", forKey: "emailFlag")
                                UserDefaults.standard.set("", forKey: "submitFlag")
                                
                                UserDefaults.standard.set(true, forKey: "showbeefproductTbl")
                                deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                                deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
                                deleteRecordFromDatabase(entityName: "SubProductTblBeef")
                                deleteRecordFromDatabase(entityName: "SelectedQuestionaire")
                                UserDefaults.standard.set(false, forKey: "isAggreForSubmit")
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                    self.sideMenuViewController?.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
                                    
                                }
                            }
                            
                            
                            
                            
                        }
                        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            print(LocalizedStrings.cancelPressed)
                        }
                        
                        alertController.addAction(okAction)
                        alertController.addAction(cancelAction)
                        self.present(alertController, animated: true, completion: nil)
                        return true
                    }
                }
            }
        }
        return false
    }
    
    @IBAction func reviewOrder(_ sender: UIButton) {
        
        
        let currentCustomerId = UserDefaults.standard.value(forKey: "currentActiveCustomerId") as? Int
        let userId1 = UserDefaults.standard.integer(forKey: "userId")
        
        if UserDefaults.standard.string(forKey: "BrazilGenotype") == "Genotype"
        {
            UserDefaults.standard.set(true, forKey: "beefplaceordercheck")
            UserDefaults.standard.set(true, forKey: "addDealerCodeCheck")
            
            UserDefaults.standard.set(false, forKey: "beefemailcheckvalue")
        }
        else{
            let fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: "BeefAnimaladdTbl",orderId:orderId,userId:userId1,customerId:currentCustomerId ?? 0,date:"")
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
        
        DispatchQueue.main.async {
            if let cell = self.tblView.cellForRow(at: IndexPath(row: self.arr1.keys.count, section: 0) ) as? BillingCell {
                if cell.billingBtnOutlet.titleLabel?.text == "N/A" {
                    self.transparentView.isHidden = false
                    self.billingView.isHidden = false
                    self.isBillingContact = false
                }
                
                else{
                    UserDefaults.standard.set(true, forKey: "review")
                    let fethData =  BeefFetchproductData(status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId)
                    if self.pvid == 6 && fethData.count > 0 {
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "BeefReviewOrderVC") as! BeefReviewOrderVC
                            self.navigationController?.pushViewController(newViewController, animated: false)
                            self.isBillingContact = true
                            return
                    }
                    
                    let Data = fetchAllDataOrderStatus(entityName: "BeefAnimaladdTbl", ordestatus: "false",orderId:self.orderId,userId:self.userId)
                    
                    if fethData.count > 0{
                        
                        if fethData.count == Data.count {
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "BeefReviewOrderVC") as! BeefReviewOrderVC
                            self.navigationController?.pushViewController(newViewController, animated: false)
                            self.isBillingContact = true
                            return
                        }
                        else{
                            let count = Data.count - fethData.count
                            
                            if UserDefaults.standard.integer(forKey: "lngId") == 2{
                                let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Você não atribuiu produtos a \(count) animal (es). Você quer continuar?", comment: ""), preferredStyle: .alert)
                                
                                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "BeefOrderProductSelectionReviewVC") as! BeefOrderProductSelectionReviewVC
                                    self.navigationController?.pushViewController(newViewController, animated: false)
                                    self.isBillingContact = true
                                }
                                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    print(LocalizedStrings.cancelPressed)
                                }
                                
                                alertController.addAction(okAction)
                                alertController.addAction(cancelAction)
                                self.present(alertController, animated: true, completion: nil)
                                
                            }else{
                                
                                let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: "You have not assigned products to count animal(s). Do you want to continue?".localized(with: count), preferredStyle: .alert)
                                
                                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "BeefOrderProductSelectionReviewVC") as! BeefOrderProductSelectionReviewVC
                                    self.navigationController?.pushViewController(newViewController, animated: false)
                                    self.isBillingContact = true
                                }
                                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    print(LocalizedStrings.cancelPressed)
                                }
                                
                                alertController.addAction(cancelAction)
                                alertController.addAction(okAction)
                                self.present(alertController, animated: true, completion: nil)
                            }
                        }
                        
                    } else {
                        
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please select the product(s).", comment: ""))
                        
                    }
                    
                }
            }
            
        }
        
        
    }
    
    
    @IBAction func toggleBtnAction(_ sender: UIButton){
        
        let daata123 = fetchAllDataOrderStatus(entityName: "BeefAnimaladdTbl", ordestatus: "false",orderId:self.orderId,userId:self.userId)
        
        if daata123.count == 1 {
            
            if aTag == "" || aTag == nil {
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
                return
            }
            
            if UserDefaults.standard.value(forKey: "Brazil") as? String == "BR" {
                if daata123.count == 1 {
                    UserDefaults.standard.set(nil, forKey: "On")
                    UserDefaults.standard.set(nil, forKey: "page")
                    updateProductTablDataaid(entity: "GetProductTblBeef", status: "false")
                    let fethData1 =  fetchAllDataFarmIdStatusCheckdataBR(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId)
                    for i in 0 ..< fethData1.count{
                        let data  = fethData1[i] as! ProductAdonAnimlTbLBeef
                        updateProductTablSecononvc(entity: "GetProductTblBeef", productId: Int(data.productId), status: "true")
                    }
                 
                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
                    return
                    
                }
                if UserDefaults.standard.value(forKey: "On") as? String == "off"{
                    UserDefaults.standard.set(false, forKey: "BeefBVDVSeleted")
                    let alertController = UIAlertController(title: NSLocalizedString("Warning", comment: ""), message: NSLocalizedString(LocalizedStrings.clearAllProdSelections, comment: ""), preferredStyle: .alert)
                 
                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                        
                        UIAlertAction in
                  
                        let arr  = fetchproviderProductData(entityName: "GetProductTblBeef", provId: self.pvid)
                        
                        for i in 0 ..< arr.count{
                            
                            let data  = arr[i] as! GetProductTblBeef
                            
                            updateProductTabl(entity: "GetProductTblBeef", productId: Int(data.productId), status: "true", completionHandler: { (success) -> Void in
                                // When download completes,control flow goes here.
                            })
                            
                            updateProducDataSingle(entity: "ProductAdonAnimlTbLBeef", productID:Int(data.productId), status: "true")
                            
                            let product  = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(data.productId))
                            
                            for j in 0 ..< product.count{
                                
                                let data  = product[j] as! GetAdonTbl
                                
                                updateAdoonTabl(entity: "GetAdonTbl", AdonId: Int(data.adonId), status: "false",productId: Int(data.productId))
                                
                                updateAdonDataSingle(entity: "SubProductTblBeef", adonId: Int(data.adonId) , status: "false")
                                
                            }
                            
                        }
                        
                        updateStatusAnimal(entityName: "BeefAnimaladdTbl",ordestatus: "true",status: "true",orderId:self.orderId,userId:self.userId)
                        
                        UserDefaults.standard.set(nil, forKey: "On")
                        UserDefaults.standard.set(nil, forKey: "page")
                        UserDefaults.standard.set("", forKey: "productname")
                        
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
               
                    }
                    
                    let cancelAction = UIAlertAction(title:  NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        print(LocalizedStrings.cancelPressed)
                    }
                   
                    alertController.addAction(okAction)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                else{ self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
                    return
                }
            }
            
            if UserDefaults.standard.value(forKey: "On") as? String == "off"{
                
                
                if daata123.count == 1 {
                    UserDefaults.standard.set(nil, forKey: "On")
                    UserDefaults.standard.set(nil, forKey: "page")
                    
                    let fethData1 =  fetchAllDataFarmIdStatusCheckdata(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId,aTag: aTag ?? "", pId: pid)
                    let fethData123 =  fetchAllDataFarmIdStatusCheckdata(entityName: "SubProductTblBeef", asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId,aTag: aTag ?? "", pId: pid)
                    if fethData1.count > 0 {
                        updateProductTablevaleeSinglee(entity: "GetProductTblBeef", productId: pid, status: "false")
                        updateProductTablSecononvc(entity: "GetProductTblBeef", productId: pid, status: "true")
                        if fethData123.count > 0 {
                            updateProductTablevaleeSinglee(entity: "GetAdonTbl", productId: pid, status: "false")
                        }
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
                        return
                    }
                }
                
                else {
                    let alertController = UIAlertController(title: NSLocalizedString("Warning", comment: ""), message: NSLocalizedString(LocalizedStrings.clearAllProdSelections, comment: ""), preferredStyle: .alert)
               
                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                        
                        UIAlertAction in
                        
                        
                        let arr  = fetchproviderProductData(entityName: "GetProductTblBeef", provId: self.pvid)
                        
                        for i in 0 ..< arr.count{
                            
                            let data  = arr[i] as! GetProductTblBeef
                            
                            updateProductTabl(entity: "GetProductTblBeef", productId: Int(data.productId), status: "false", completionHandler: { (success) -> Void in
                                
                                // When download completes,control flow goes here.
                              
                            })
                            
                            updateProducDataSingle(entity: "ProductAdonAnimlTbLBeef", productID:Int(data.productId), status: "false")
                            
                            let product  = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(data.productId))
                            
                            for j in 0 ..< product.count{
                                
                                let data  = product[j] as! GetAdonTbl
                                
                                updateAdoonTabl(entity: "GetAdonTbl", AdonId: Int(data.adonId), status: "false",productId: Int(data.productId))
                                
                                updateAdonDataSingle(entity: "SubProductTblBeef", adonId: Int(data.adonId) , status: "false")
                                
                            }
                            
                        }
                        
                        updateStatusAnimal(entityName: "BeefAnimaladdTbl",ordestatus: "false",status: "true",orderId:self.orderId,userId:self.userId)
                        
                        UserDefaults.standard.set(nil, forKey: "On")
                        UserDefaults.standard.set(nil, forKey: "page")
                        UserDefaults.standard.set("", forKey: "productname")
                        
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
                  
                    }
                    
                    let cancelAction = UIAlertAction(title:  NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        print(LocalizedStrings.cancelPressed)
                    }
          
                    alertController.addAction(okAction)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            
            else {
                UserDefaults.standard.set(nil, forKey: "On")
                UserDefaults.standard.set(nil, forKey: "page")
                
                let fethData1 =  fetchAllDataFarmIdStatusCheckdata(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId,aTag: aTag ?? "", pId: pid)
                let fethData123 =  fetchAllDataFarmIdStatusCheckdata(entityName: "SubProductTblBeef", asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId,aTag: aTag ?? "", pId: pid)
                if fethData1.count > 0 {
                    updateProductTablevaleeSinglee(entity: "GetProductTblBeef", productId: pid, status: "false")
                    updateProductTablSecononvc(entity: "GetProductTblBeef", productId: pid, status: "true")
                    if fethData123.count > 0 {
                        updateProductTablevaleeSinglee(entity: "GetAdonTbl", productId: pid, status: "false")
                    }
                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
                    return
                    
                    
                }
                
            }
            
            
            
            
        }
        
        else {
            
            if aTag == "" || aTag == nil {
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
                return
            }
            
            if UserDefaults.standard.value(forKey: "Brazil") as? String == "BR" {
                if UserDefaults.standard.value(forKey: "On") as? String == "off"{
                    
                    let alertController = UIAlertController(title: NSLocalizedString("Warning", comment: ""), message: NSLocalizedString(LocalizedStrings.clearAllProdSelections, comment: ""), preferredStyle: .alert)
            
                    
                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                        
                        UIAlertAction in
              
                        let arr  = fetchproviderProductData(entityName: "GetProductTblBeef", provId: self.pvid)
                        
                        for i in 0 ..< arr.count{
                            
                            let data  = arr[i] as! GetProductTblBeef
                            
                            updateProductTabl(entity: "GetProductTblBeef", productId: Int(data.productId), status: "true", completionHandler: { (success) -> Void in
                         
                                // When download completes,control flow goes here.
                                
                            })
                            
                            updateProducDataSingle(entity: "ProductAdonAnimlTbLBeef", productID:Int(data.productId), status: "true")
                            
                            let product  = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(data.productId))
                            
                            for j in 0 ..< product.count{
                                
                                let data  = product[j] as! GetAdonTbl
                                
                                updateAdoonTabl(entity: "GetAdonTbl", AdonId: Int(data.adonId), status: "false",productId: Int(data.productId))
                                
                                updateAdonDataSingle(entity: "SubProductTblBeef", adonId: Int(data.adonId) , status: "false")
                                
                            }
                            
                        }
                        
                        updateStatusAnimal(entityName: "BeefAnimaladdTbl",ordestatus: "true",status: "true",orderId:self.orderId,userId:self.userId)
                        UserDefaults.standard.set(nil, forKey: "On")
                        UserDefaults.standard.set(nil, forKey: "page")
                        UserDefaults.standard.set("", forKey: "productname")
                        
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
                        
                        
                        
                    }
                    
                    let cancelAction = UIAlertAction(title:  NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        print(LocalizedStrings.cancelPressed)
                    }
        
                    
                    alertController.addAction(okAction)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                else{ self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
                    return
                }
            }
            
            if UserDefaults.standard.value(forKey: "On") as? String == "off"{
                
                let alertController = UIAlertController(title: NSLocalizedString("Warning", comment: ""), message: NSLocalizedString(LocalizedStrings.clearAllProdSelections, comment: ""), preferredStyle: .alert)
             
                
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                    
                    UIAlertAction in
                    
                    let arr  = fetchproviderProductData(entityName: "GetProductTblBeef", provId: self.pvid)
                    
                    for i in 0 ..< arr.count{
                        
                        let data  = arr[i] as! GetProductTblBeef
                        
                        updateProductTabl(entity: "GetProductTblBeef", productId: Int(data.productId), status: "true", completionHandler: { (success) -> Void in
                            // When download completes,control flow goes here.
                          
                        })
                        
                        updateProducDataSingle(entity: "ProductAdonAnimlTbLBeef", productID:Int(data.productId), status: "true")
                        
                        let product  = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(data.productId))
                        
                        for j in 0 ..< product.count{
                            
                            let data  = product[j] as! GetAdonTbl
                            
                            updateAdoonTabl(entity: "GetAdonTbl", AdonId: Int(data.adonId), status: "false",productId: Int(data.productId))
                            
                            updateAdonDataSingle(entity: "SubProductTblBeef", adonId: Int(data.adonId) , status: "false")
                            
                        }
                        
                    }
                    
                    updateStatusAnimal(entityName: "BeefAnimaladdTbl",ordestatus: "false",status: "true",orderId:self.orderId,userId:self.userId)
                    UserDefaults.standard.set(nil, forKey: "On")
                    UserDefaults.standard.set(nil, forKey: "page")
                    UserDefaults.standard.set("", forKey: "productname")
                    
                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
                }
                
                let cancelAction = UIAlertAction(title:  NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    print(LocalizedStrings.cancelPressed)
                }
                
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                
                UserDefaults.standard.set(nil, forKey: "On")
                UserDefaults.standard.set(nil, forKey: "page")
                
                let fethData1 =  fetchAllDataFarmIdStatusCheckdata(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId,aTag: aTag ?? "", pId: pid)
                let fethData123 =  fetchAllDataFarmIdStatusCheckdata(entityName: "SubProductTblBeef", asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId,aTag: aTag ?? "", pId: pid)
                if fethData1.count > 0 {
                    updateProductTablevaleeSinglee(entity: "GetProductTblBeef", productId: pid, status: "false")
                    updateProductTablSecononvc(entity: "GetProductTblBeef", productId: pid, status: "true")
                    if fethData123.count > 0 {
                        updateProductTablevaleeSinglee(entity: "GetAdonTbl", productId: pid, status: "false")
                    }
                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
                    return
                }
            }
        }
    }
    
    @objc  func checkForReachability(notification:Notification){
        
        let del =  UIApplication.shared.delegate as? AppDelegate
        
        self.networkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if networkStatusLbl?.text == "Connected".localized
        {
            self.OffLineBtn.isHidden = true
            self.networkStatusImg.image = UIImage(named: "status_online_sign")
        }
        else {
            
            self.OffLineBtn.isHidden = false
            self.networkStatusImg.image = UIImage(named: "status_offline")
            
        }
        
    }
    
    func initialNetworkCheck()
    {
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        
        let del =  UIApplication.shared.delegate as? AppDelegate
        
        self.networkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if networkStatusLbl?.text == "Connected".localized
        {
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
    
    func updateUI(selectedBillingCustomer: GetBillingContact) {
        DispatchQueue.main.async {
            if let cell = self.tblView.cellForRow(at: IndexPath(row: self.arr1.keys.count, section: 0) ) as? BillingCell{
                let filterArr = self.farmAddr.filter({$0.isDefault })
                if filterArr.count > 0{
                    updateBillingCustomer(entity: "GetBillingContact", customerID: self.custmerId, isDefault: false, billcustomerId: filterArr[0].billToCustId ?? "0", billcustomerName: filterArr[0].contactName ?? "")
                    
                }
                UserDefaults.standard.set(selectedBillingCustomer.contactName, forKey: "farmValue")
                UserDefaults.standard.set(selectedBillingCustomer.billToCustId, forKey: "billToCustomerId")
                
                updateBillingCustomer(entity: "GetBillingContact", customerID: self.custmerId, isDefault: true, billcustomerId: selectedBillingCustomer.billToCustId ?? "0", billcustomerName: selectedBillingCustomer.contactName ?? "")
                
                self.farmAddr = fetchBillingCustomer(entityName: "GetBillingContact",customerID: self.custmerId) as! [GetBillingContact]
                
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
                let attributeString = NSMutableAttributedString(string: (UserDefaults.standard.value(forKey: "farmValue") as? String ?? ""),
                                                                attributes: self.attrs)
                cell.billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                
            }
            self.transparentView.isHidden = true
            self.billingView.isHidden = true
        }
    }
    
    
    @IBAction func editBtnAction(_ sender: Any) {
        UserDefaults.standard.set(1, forKey: "orderSlideTag")
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "OrderingDefaultsVC")), animated: true)
    }
    
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AppHelpImagesVC") as? AppHelpImagesVC
        vc?.module = "Place an Order: Ordering Add Animal(s) Beef".localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
    }
}
extension BeefOrderProductSelectionSecondVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

extension BeefOrderProductSelectionSecondVC : SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}

private typealias DeleteBeefOrderProductDataListHelper = BeefOrderProductSelectionSecondVC
extension DeleteBeefOrderProductDataListHelper {
    func getListName()  {
        listName = orderingDatalistVM.makeListName(custmerId: custmerId, providerID: pvid)
        if pvid == 6 {
            if UserDefaults.standard.string(forKey: "beefProduct") == keyValue.genoTypeOnly.rawValue {
                
                fetchDataEntry =  fetchDataEntryListGetBeefProduct(entityName: "DataEntryList",customerId:Int64(self.custmerId),userId:userId,providerId:pvid,productType:keyValue.genoTypeOnly.rawValue) as! [DataEntryList]
                fetchDataEntry = fetchDataEntry.filter({$0.listName == listName})
            }else  if UserDefaults.standard.string(forKey: "beefProduct") == "GenotypeStarblack" {
                
                fetchDataEntry =  fetchDataEntryListGetBeefProduct(entityName: "DataEntryList",customerId:Int64(self.custmerId),userId:userId,providerId:pvid,productType:"GenotypeStarblack") as! [DataEntryList]
                fetchDataEntry = fetchDataEntry.filter({$0.listName == listName})
            }else  if UserDefaults.standard.string(forKey: "beefProduct") == "GenStarblack" {
                
                fetchDataEntry =  fetchDataEntryListGetBeefProduct(entityName: "DataEntryList",customerId:Int64(self.custmerId),userId:userId,providerId:pvid,productType:"GenStarblack") as! [DataEntryList]
                fetchDataEntry = fetchDataEntry.filter({$0.listName == listName})
            }
            else {
                
                fetchDataEntry =  fetchDataEntryListGetBeefProduct(entityName: "DataEntryList",customerId:Int64(self.custmerId),userId:userId,providerId:pvid,productType:keyValue.nonGenoType.rawValue) as! [DataEntryList]
                fetchDataEntry = fetchDataEntry.filter({$0.listName == listName})
            }
        } else {
            fetchDataEntry  = fetchAllDataEnteryList(entityName: "DataEntryList",customerId:Int64(self.custmerId),listName:listName ,productName:"Beef") as! [DataEntryList]
        }
        
    }
    func deleteSigalAnimalFromList(animalbarCode :String) {
        
        if fetchDataEntry.count > 0 {
            let fetchAllDatalistAnimals =  fetchAllDataAnimalDaWithOutOrderId(entityName: "DataEntryBeefAnimaladdTbl", userId: userId,orderStatus:"false",listid:Int64(fetchDataEntry[0].listId), custmerId: Int64(custmerId), providerId: pvid) as! [DataEntryBeefAnimaladdTbl]
            
            
            if fetchAllDatalistAnimals.count > 0{
                let filterdatalistAnimal = fetchAllDatalistAnimals.filter({ $0.animalbarCodeTag == animalbarCode})
                if filterdatalistAnimal.count > 0 {
                    let animalVal = filterdatalistAnimal[0]
                    if !Connectivity.isConnectedToInternet() {
                        saveDeletedDataListAnimal(entity: "DataEntryOfflineDeletedAnimal", animalID: Int(animalVal.animalId), listID: Int(fetchDataEntry[0].listId), customerID: Int64(UserDefaults.standard.integer(forKey: "currentActiveCustomerId")), serverAnimalID: animalVal.serverAnimalId ?? "", speciesID: SpeciesID.beefSpeciesId)
                    }
                    self.objApiSync.postListDataDeleteBeef(listId:fetchDataEntry[0].listId,custmerId:Int64(UserDefaults.standard.integer(forKey: "currentActiveCustomerId")), clearOrder: false, animalId: Int(animalVal.animalId))
                    deleteAnimalfromdataEntry(enitityName:Entities.dataEntryBeefAnimalAddTblEntity, Int(animalVal.animalId), listId: Int(animalVal.listId))
                    
                }
            }
        }
    }
    
    
    func createListNameAndCheckifExist(){
        
        if fetchDataEntry.count > 0 {
            self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
            self.view.isUserInteractionEnabled = false
            deleteList(listName: listName, customerId: Int64(custmerId),listID: Int(fetchDataEntry[0].listId))
        }
        
    }
    func deleteList(listName: String, customerId: Int64, listID: Int) {
        
        let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String
        let headerDict = ["Authorization": accessToken!,LocalizedStrings.contentType : "application/x-www-form-urlencoded"]
        
        let urlString = Configuration.Dev(packet: ApiKeys.deleteList.rawValue).getUrl()
        let parameters : [String: Any] = ["customerId": customerId,"listName":listName]
        
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = headerDict
        request.setValue("application/json", forHTTPHeaderField: LocalizedStrings.contentType)
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
                deleteDataWithListIdDatEntry(entityString: "DataEntryBeefAnimaladdTbl", listId: Int(listID), customerId: Int(customerId ),userId:1)
                
                deleteDataWithListId(entityString: "DataEntryList", listId: Int64(listID), customerId: Int(customerId ),userId:1)
            }
        }
    }
}

