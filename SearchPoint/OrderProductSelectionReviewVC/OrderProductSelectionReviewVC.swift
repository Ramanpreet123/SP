////
////  OrderProductSelectionSecondVC.swift
////  SearchPoint
////
////  Created by "" on 17/10/2019.
////  ""
////
//

import UIKit
import DropDown
import MBProgressHUD
class OrderProductSelectionReviewVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextFieldDelegate,BillingDelegate ,offlineCustomView1,UITextViewDelegate,objectPickfromConfilict{
    func crossBtn() {
        // Intentionally left empty.
        // This function will handle navigation to another view controller in the future.
        // Currently unused, but kept for consistency with protocol or planned implementation.
    }
    func firstLevel(check: Bool) {
        
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue) as? Int)!
        
        
        if pviduser == 1 || pviduser == 2 || pviduser == 3 || pviduser == 10  || pviduser == 11 || pviduser == 12{
            
            if fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",farmid:"",animalTag:"", pvid: pviduser).count != 0 {
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ConfilictOrdersViewController") as! ConfilictOrdersViewController
                vc.delegateCustom1 = self
                vc.screenName = "productSelectionReview"
                self.present(vc, animated: true, completion: nil)
            }}
        
        if pviduser == 4 || pviduser == 6 || pviduser == 8{
            
            if fetchAllDataAnimalGirlando(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",animalName:"",breedRegNumber:"", dateString: "").count != 0 {
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ConfilictOrdersViewController") as! ConfilictOrdersViewController
                vc.delegateCustom1 = self
                vc.screenName = "productSelectionReview"
                self.present(vc, animated: true, completion: nil)
            }}
    }
    func selectionObject(check: Bool) {
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue) as? Int)!
        if pviduser == 4 {
            
            if check{
                let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "OrderingAnimalVCGirlando") as! OrderingAnimalVCGirlando
                navigationController?.pushViewController(vc,animated: false)
                
            } else {
                
                let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC) as! DashboardVC
                self.navigationController!.pushViewController(secondViewController, animated: false)
                
            }
        }else {
            if check {
                let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.orderingAnimalVC) as! OrderingAnimalVC
                navigationController?.pushViewController(vc,animated: false)
                
            } else {
                
                let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC) as! DashboardVC
                self.navigationController!.pushViewController(secondViewController, animated: false)
                
            }}
    }
    func dataReload(check :Bool){
        if check {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ReviewOrderVC") as! ReviewOrderVC
            self.navigationController?.pushViewController(newViewController, animated: false)
            
        } else {
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderProductSelectionReviewVC") as! OrderProductSelectionReviewVC
            self.navigationController?.pushViewController(newViewController, animated: false)
            
            
            
        }
        
    }
    @IBOutlet weak var reviewOrderTitle: UILabel!
    @IBOutlet weak var sortByTitle: UILabel!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var animalTitle: UILabel!
    @IBOutlet weak var appStatusLbl: UILabel!
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    var pricingLinkC :String?
    
    var earTagID = Int()
    
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
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var billingView: UIView!
    var attrs : [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 12),
        .foregroundColor: UIColor.blue,
        .underlineStyle: NSUnderlineStyle.single.rawValue]
    let dropDown = DropDown()
    var arr1 = [Int:[ProductAdonAnimalTbl]]()
    var values = [Int]()
    var farmID = [String]()
    var earTag = [String]()
    var barCode = [String]()
    var animaltag = [String]()
    var selection = [[String:Any]]()
    var aTag:Int!
    var pid = Int()
    var fethData:NSArray!
    var farmIdValue = Int()
    var barCodeId = Int()
    var animaId = Int()
    var clickOnDropDown = String()
    var isBillingContact = true
    var indexOfSelection:[IndexPath?] = [IndexPath]()
    var collViewOfselection:[UICollectionView?] = [UICollectionView]()
    var billingdelegateVC = BillingTableViewDelegate()
    var userId = Int()
    var orderId = Int()
    var pviduser = Int()
    var custmerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int
    var farmAddr = [GetBillingContact]()
    override func viewDidLoad() {
        farmAddr = fetchBillingCustomer(entityName: "GetBillingContact",customerID: self.custmerId) as! [GetBillingContact]
        languageConversion(languageId: langId!)
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        
        pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue) as? Int)!
        
        
        initialNetworkCheck()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        transparentView.isHidden = true
        billingView.isHidden = true
        
        let dataval:  [ProductAdonAnimalTbl] =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true", orderStatus: "false",orderId:orderId,userId:userId, farmId: serchTextField.text!) as! [ProductAdonAnimalTbl]
        
        fethData =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId, farmId: serchTextField.text!)
        fetchProductAdonAnimalTbl(fethData: fethData, completion: {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                
                for i in 0..<dataval.count{
                    self.fetchAdonData(pid: Int(dataval[i].productId), animaltag: Int(dataval[i].animalId) , index: i)
                    
                }
            }
        })
        
        perform(#selector(reloadTable), with: nil, afterDelay: 0.1)
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: pviduser)
        notificationLblCount.text = String(animalCount.count)
        
    }
    func languageConversion(languageId :Int){
        appStatusLbl.text = NSLocalizedString("App Status:", comment: "")
        sortByTitle.text =  NSLocalizedString("Sort By:", comment: "")
        reviewOrderTitle.text = NSLocalizedString("Review Order", comment: "")
        animalTitle.text = NSLocalizedString("Animal", comment: "")
        productTitle.text = NSLocalizedString("Product", comment: "")
        serchTextField.placeholder = NSLocalizedString("Search", comment: "")
    }
    
  
    @IBAction func backBtnClk(_ sender: UIButton) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
        
    }
    
    private func fetchProductAdonAnimalTbl(fethData:NSArray,completion: @escaping ()->()){
        values.removeAll()
        barCode.removeAll()
        farmID.removeAll()
        earTag.removeAll()
        arr1.removeAll()
        animaltag.removeAll()
        for value in fethData{
            if let item = value as? ProductAdonAnimalTbl{
                
                if values.contains(Int(item.animalId)){
                    arr1[Int(item.animalId)]?.append(item)
                } else {
                    values.append(Int(item.animalId))
                    farmID.append(item.farmId ?? "")
                    earTag.append(item.earTag ?? "")
                    
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
    func fetchAdonData(pid:Int, animaltag:Int, index:Int) {
        
        let data = fetchSubProductDataDairyreview(productId: Int(pid),animalTag: animaltag,orderId:orderId,userId:userId, status: "true") as? [SubProductTbl]
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
        
        
        reloadTable()
        
        
    }
    func fetchAdonData(indexPath:IndexPath, collectionView:UICollectionView) {
        if  collectionView.tag < values.count {
            
            if arr1[values[collectionView.tag]]!.count > indexPath.row {
                
                pid = Int(arr1[values[collectionView.tag]]![indexPath.row].productId)
                aTag = Int(arr1[values[collectionView.tag]]![indexPath.row].animalId)
                let data = fetchSubProductDataDairyreview(productId: Int(pid),animalTag: aTag!,orderId:orderId,userId:userId, status: "true") as? [SubProductTbl]
                var found = false
                
                for i in 0..<selection.count{
                    if let value = (selection[i]["animalId"]) as? Int, value  == aTag{
                        selection[i]["animalId"] = aTag
                        selection[i]["addon"] = data
                        selection[i]["row"] = collectionView.tag
                        found = true
                        break
                    }
                }
                if found ==  false && data!.count > 0{
                    selection.append (["animalId":aTag as Any,"addon":data as Any,"row":collectionView.tag])
                }
            }
        }
        reloadTable()
        
        
    }
    @objc func reloadTable(){
        
        tblView.delegate = self
        tblView.dataSource = self
        tblView.reloadData()
    }
    
    @IBAction func farmIdDropDown(_ sender: UIButton) {
        
        serchTextField.resignFirstResponder()
        dropUpDownBtn.setImage(UIImage(named: "Image"), for: .normal)
        dropDown.anchorView = farmIdHideLbl
        dropDown.direction = .bottom
        dropDown.backgroundColor = UIColor.white
        dropDown.separatorColor = UIColor.clear
        dropDown.cornerRadius = 10
        dropDown.textFont = UIFont.systemFont(ofSize: 13)
        dropDown.cellHeight = 30
        
        dropDown.dataSource = [ NSLocalizedString(LocalizedStrings.onFarmIdText, comment: ""),NSLocalizedString(LocalizedStrings.officialIDText, comment: ""), NSLocalizedString("Barcode", comment: "")]
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue) as? Int)!
        
        if pviduser == 4 {
            dropDown.dataSource = [ NSLocalizedString(ButtonTitles.earTagText, comment: ""),NSLocalizedString("Barcode", comment: "")]
            
        }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            
            self.clickOnDropDown = item
            
            self.farmIdDisplyOutlet.setTitle(item, for: .normal)
            self.farmIdDisplyOutlet.layer.borderColor = UIColor.gray.cgColor
            
            
            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: ""){
                UserDefaults.standard.set(keyValue.farmId.rawValue, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
                if self.farmIdValue == 0{
                    
                    self.fethData =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity,asending:true,status: "true", orderStatus: "false", orderId: self.orderId, userId: self.userId, farmId: self.serchTextField.text!)
                    
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                        // Intentionally left empty.
                        // Could be used in the future for logging, analytics, or error handling.
                    })
                    
                    self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                    self.farmIdValue = 1
                    
                }
                else{
                    self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                    
                    self.fethData =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity,asending:false,status: "true", orderStatus: "false", orderId: self.orderId,userId:self.userId, farmId: self.serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                        // Intentionally left empty.
                        // Could be used in the future for logging, analytics, or error handling.
                    })
                    self.farmIdValue = 0
                }
                
            }
            
            else if self.clickOnDropDown == ButtonTitles.earTagText || self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: ""){
                UserDefaults.standard.set(ButtonTitles.earTagText, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
                if self.earTagID == 0{
                    self.earTagID = 1
                    self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                    
                    self.fethData =  fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity,asending : true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                        // Intentionally left empty.
                        // Could be used in the future for logging, analytics, or error handling.
                    })
                }
                else{
                    self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                    self.earTagID = 0
                    self.fethData =  fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity,asending : false,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                        // Intentionally left empty.
                        // Could be used in the future for logging, analytics, or error handling.
                    })
                }
            }
            else if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: ""){
                UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
                if self.animaId == 0{
                    self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                    
                    self.fethData =  fetchAllDataanimalTagStatus(entityName: Entities.productAdonAnimalTblEntity,asending : true,status: "true", orderStatus: "false", animalTag: self.serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                        // Intentionally left empty.
                        // Could be used in the future for logging, analytics, or error handling.
                    })
                    self.animaId = 1
                }
                else{
                    self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                    
                    self.fethData =  fetchAllDataanimalTagStatus(entityName: Entities.productAdonAnimalTblEntity, asending: false,status: "true", orderStatus: "false", animalTag: self.serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                        // Intentionally left empty.
                        // Could be used in the future for logging, analytics, or error handling.
                    })
                    self.animaId = 0
                }
                
            }
            else{
                UserDefaults.standard.set(keyValue.barcode.rawValue, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
                if self.barCodeId == 0{
                    self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                    
                    self.fethData =  fetchAllDataBarcOdeStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                        // Intentionally left empty.
                        // Could be used in the future for logging, analytics, or error handling.
                    })
                    self.barCodeId = 1
                }
                else{
                    self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                    
                    self.fethData =  fetchAllDataBarcOdeStatus(entityName: Entities.productAdonAnimalTblEntity, asending: false,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
                    self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                        // Intentionally left empty.
                        // Could be used in the future for logging, analytics, or error handling.
                    })
                    self.barCodeId = 0
                }
                
            }
        }
        dropDown.show()
    }
    @IBAction func billingClick(_ sender: UIButton) {
        transparentView.isHidden = false
        billingView.isHidden = false
        isBillingContact = false
        billingViewHeightConst.constant = tableViewBilling.contentSize.height + 100
        tableViewBilling.reloadData()
        
    }
    var value = 0
    @objc func methodOfReceivedNotification(notification: Notification)
    {
        
        if value == 0
        {
            UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
            self.hideIndicator()
            value = value + 1
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(Notification.Name(keyValue.notificationIdentifier.rawValue))
    }
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        self.userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        
        self.orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        
        
        
        tableViewBilling.delegate = billingdelegateVC
        
        tableViewBilling.dataSource = billingdelegateVC
        
        tableViewBilling.reloadData()
        
        billingdelegateVC.delegate = self
        
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: pviduser)
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue) as? Int)!
        
        for item in animalCount  {
            
            let data = item as! AnimaladdTbl
            let screen  = UserDefaults.standard.value(forKey: keyValue.screen.rawValue) as? String
            
            if screen == keyValue.farmId.rawValue {
                
                let marketName = UserDefaults.standard.value(forKey: "marketName") as? String
                
                if marketName == "BR" {
                    if pviduser == 1 {
                        if data.date == "" {
                            UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                            UserDefaults.standard.set(false, forKey: "SubmitBtnFlagNew")
                            break
                        } else {
                            
                            UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlag.rawValue)
                            UserDefaults.standard.set(true, forKey: "SubmitBtnFlagNew")
                        }
                        
                    }
                }
                if pviduser == 1 ||  pviduser == 2 || pviduser == 3 || pviduser == 10  || pviduser == 11 || pviduser == 12 {
                    
                    if pviduser == 3 {
                        if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                            
                            if data.date == "" {
                                UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                                UserDefaults.standard.set(false, forKey: "SubmitBtnFlagNew")
                                break
                            } else {
                                
                                UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlag.rawValue)
                                UserDefaults.standard.set(true, forKey: "SubmitBtnFlagNew")
                            }
                            
                        }
                    }
                    if data.animalTag == "" || data.farmId == "" || data.date == ""{
                        
                        UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                        UserDefaults.standard.set(false, forKey: "SubmitBtnFlagNew")
                        break
                    } else {
                        UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlag.rawValue)
                        UserDefaults.standard.set(true, forKey: "SubmitBtnFlagNew")
                    }
                }
            }
            
            else {
                if pviduser == 1 ||  pviduser == 2 || pviduser == 3 || pviduser == 10  || pviduser == 11 || pviduser == 12 {
                    
                    if data.farmId == "" || data.animalTag == "" || data.date == ""{
                        
                        UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                        UserDefaults.standard.set(false, forKey: "SubmitBtnFlagNew")
                        break
                    } else {
                        
                        UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlag.rawValue)
                        UserDefaults.standard.set(true, forKey: "SubmitBtnFlagNew")
                        
                    }}
            }
            if pviduser == 4 {
                
                if data.animalName == "" ||  data.date == ""{
                    UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                    UserDefaults.standard.set(false, forKey: "SubmitBtnFlagNew")
                    break
                } else {
                    UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlag.rawValue)
                    UserDefaults.standard.set(true, forKey: "SubmitBtnFlagNew")
                }
            }
            
        }
        
        
        if  UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == nil || UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == ""{
            
            UserDefaults.standard.set(keyValue.farmId.rawValue, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
            
            self.clickOnDropDown = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
            
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            
            fethData =   fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity,asending:true,status: "true", orderStatus: "false", orderId: orderId, userId: userId, farmId: serchTextField.text!)
            
            
            if pviduser == 4 {
                
                UserDefaults.standard.set(ButtonTitles.earTagText, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
                
                self.clickOnDropDown = NSLocalizedString(ButtonTitles.earTagText, comment: "")
                
                self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
                
                fethData =  fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
                
            }
            
        }
        
        if pviduser == 4 {
            
            self.clickOnDropDown = NSLocalizedString(ButtonTitles.earTagText, comment: "")
            
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            
            fethData =  fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
            
        }else{
            
            self.clickOnDropDown = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
            
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            
            fethData =   fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity,asending:true,status: "true", orderStatus: "false", orderId: orderId, userId: userId, farmId: serchTextField.text!)
            
        }
        
        if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == keyValue.farmId.rawValue {
            
            self.clickOnDropDown = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
            
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            
            fethData =   fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity,asending:true,status: "true", orderStatus: "false", orderId: orderId, userId: userId, farmId: serchTextField.text!)
            
            if pviduser == 4 {
                
                UserDefaults.standard.set(ButtonTitles.earTagText, forKey: keyValue.fOSampleTrackingDetailVC.rawValue)
                
                self.clickOnDropDown = NSLocalizedString(ButtonTitles.earTagText, comment: "")
                
                self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
                
                fethData =  fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity,asending:true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
                
                
                
            }
            
        }
        
        if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == keyValue.officialId.rawValue {
            
            self.clickOnDropDown = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
            
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            
            self.fethData =  fetchAllDataanimalTagStatus(entityName: Entities.productAdonAnimalTblEntity,asending : true,status: "true", orderStatus: "false", animalTag: serchTextField.text!)
            
        }
        
        if UserDefaults.standard.string(forKey: keyValue.fOSampleTrackingDetailVC.rawValue) == keyValue.barcode.rawValue {
            
            self.clickOnDropDown =  NSLocalizedString("Barcode", comment: "")
            
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            
            self.fethData =  fetchAllDataBarcOdeStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true,status: "true", orderStatus: "false", barcode: serchTextField.text!)
            
        }
        
        
        
        
        
        DispatchQueue.main.async {
            
            if let cell = self.tblView.cellForRow(at: IndexPath(row: self.arr1.keys.count, section: 0) ) as? BillingCell{
                
                cell.delegateCustom = self
                if UserDefaults.standard.value(forKey: "name") as? String  == "Dairy"{
                    
                    cell.emailOrderBtnOutlet.setTitle(NSLocalizedString(ButtonTitles.emailEnteredData, comment: ""), for: .normal)
                    cell.pricingTextView.delegate = self
                    cell.submitOrderOutlet.setTitle(NSLocalizedString("Submit", comment: ""), for: .normal)
                    if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) {
                        
                        cell.infoBtnSelectionOutlet.isHidden = true
                        cell.agreeLblHeightConsraint.constant = 0
                        cell.agreeTopConstraint.constant = 0
                        cell.pricingHEIGHTconstraint.constant = 0
                        cell.pricingTextView.isHidden = true
                        cell.submitOrderOutlet.isHidden = true
                        cell.infooBtnSubmitOutlet.isHidden = false
                        
                        cell.agreeInfoBtnOutelt.isHidden = true
                        cell.infoBtnSelectionOutlet.isHidden = false
                        cell.agreeLl.isHidden = true
                        
                    } else {
                        cell.agreeLblHeightConsraint.constant = 10
                        cell.infoBtnSelectionOutlet.isHidden = false
                        cell.pricingHEIGHTconstraint.constant = 0
                        cell.pricingTextView.isHidden = true
                        cell.submitOrderOutlet.isHidden = false
                        cell.infooBtnSubmitOutlet.isHidden = false
                        cell.agreeTopConstraint.constant = 45
                        cell.infoBtnSelectionOutlet.isHidden = false
                        cell.agreeInfoBtnOutelt.isHidden = false
                        cell.agreeLl.isHidden = false
                    }
     
                    if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) == keyValue.clarifideCDCBUS.rawValue {
                        cell.nominatorLbl.isHidden = false
                        cell.nominatorTitle.isHidden = false
                    }
                    
                    else{
                        cell.nominatorLbl.isHidden = true
                        cell.nominatorTitle.isHidden = true
                    }
                }
                
                let attributeString = NSMutableAttributedString(string: (UserDefaults.standard.value(forKey: "farmValue") as! String), attributes: self.attrs)
                
                cell.billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
            }
        }
        
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
                    let attributeString = NSMutableAttributedString(string: abc, attributes: self.attrs)
                    UserDefaults.standard.set(abc, forKey: "farmValue")
                    
                    cell.billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                    self.tblView.reloadData()
                    
                } else {
                    
                    let cell = self.tblView.cellForRow(at: IndexPath(row: self.arr1.keys.count, section: 0) ) as? BillingCell
                    let attributeString = NSMutableAttributedString(string: abc, attributes: self.attrs)
                    UserDefaults.standard.set(abc, forKey: "farmValue")
                    
                    cell?.billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                    self.tblView.reloadData()
                    
                    
                }
            }
        }
        
    }
    
    @IBAction func crossClick(_ sender: UIButton) {
        
        transparentView.isHidden = true
        billingView.isHidden = true
    }
    
    @IBAction func helpAction(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
        vc?.module = LocalizedStrings.addOrderingAnimalsText.localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
        
    }
    
    @IBAction func viewAnimalClick(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.viewAnimalsControllerVC) as? ViewAnimalsController
        vc!.screenBackSave = true
        vc!.productBackSave = false
        self.navigationController?.pushViewController(vc!, animated: true)
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
            let attributeString = NSMutableAttributedString(string: (UserDefaults.standard.value(forKey: "farmValue") as! String), attributes: self.attrs)
            cell.billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
            cell.delegateCustom = self
            let marketId = UserDefaults.standard.value(forKey: keyValue.currentActiveMarketId.rawValue) as! String
            let markeData = fetchdataFromMarketId(marketId: marketId)
            if markeData.count > 0 {
                
                let marketnA = markeData.object(at: 0) as! GetMarketsTbl
                let pricingLink = marketnA.pricingLinkUrl
                pricingLinkC = pricingLink
                
                let attributedString = NSMutableAttributedString(string:  "For Information on list pricing of products, please visit the following web page. Pricing".localized)
                cell.pricingTextView.linkTextAttributes = [
                    .foregroundColor: UIColor.blue,
                    .underlineStyle: NSUnderlineStyle.single.rawValue
                ]
                attributedString.addAttribute(.link, value: "1", range: NSRange(location: 82, length: 7))
                cell.pricingTextView.attributedText = attributedString
                cell.pricingTextView.isHidden = true
                
                
            }
            
            if UserDefaults.standard.value(forKey: "name") as? String  == "Dairy"{
                cell.emailOrderBtnOutlet.setTitle(NSLocalizedString(ButtonTitles.emailEnteredData, comment: ""), for: .normal)
                
                cell.submitOrderOutlet.setTitle(NSLocalizedString("Submit", comment: ""), for: .normal)
                
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
                
                
                if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) {
                    
                    cell.pricingHEIGHTconstraint.constant = 0
                    cell.agreeTopConstraint.constant = 0
                    cell.agreeInfoBtnOutelt.isHidden = true
                    cell.infoBtnSelectionOutlet.isHidden = true
                    cell.agreeLl.isHidden = false
                    cell.submitOrderOutlet.isHidden = false
                    cell.infooBtnSubmitOutlet.isHidden = false
                    cell.agreeLblHeightConsraint.constant = 0
                    
                } else {
                    cell.agreeLblHeightConsraint.constant = 10
                    
                    cell.pricingHEIGHTconstraint.constant = 0
                    
                    cell.submitOrderOutlet.isHidden = false
                    cell.infooBtnSubmitOutlet.isHidden = false
                    cell.agreeTopConstraint.constant = 45
                    cell.infoBtnSelectionOutlet.isHidden = false
                    cell.agreeInfoBtnOutelt.isHidden = false
                    cell.agreeLl.isHidden = false
                }
                
                
                if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) == keyValue.clarifideCDCBUS.rawValue {
                    cell.nominatorLbl.isHidden = false
                    cell.nominatorTitle.isHidden = false
                }
                else{
                    cell.nominatorLbl.isHidden = true
                    cell.nominatorTitle.isHidden = true
                }
                
                
            }
            
            cell.billingContactLbl.text = NSLocalizedString("Billing Contact:", comment: "")
            cell.agreeLl.text = "I agree to the Acceptance and Authorization, Warranty and Indemnification and Data Usage Policies.".localized
            cell.orderDefaultTtile.text = "Order Defaults".localized
            cell.evaluationTitle.text = NSLocalizedString("Evaluation Provider/Market", comment: "")
            cell.editBtnOutlet.setTitle("Edit".localized, for: .normal)
            
            cell.nominatorTitle.text = "Nominator".localized
            cell.placeAnotrderTitle.text = "Place an Order".localized
            cell.emailMeEnterTtitle.text = ButtonTitles.emailEnteredData.localized
            
            
            
            if UserDefaults.standard.value(forKey: "submitTypeSelection") as? String == "emailMe" || UserDefaults.standard.value(forKey: "submitTypeSelection") as? String == "" ||  UserDefaults.standard.value(forKey: "submitTypeSelection") as? String == nil{
                
                UserDefaults.standard.setValue("emailMe", forKey: "submitTypeSelection")
                UserDefaults.standard.setValue("email", forKey: "emailFlag")
                if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true
                {
                    cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                }
                else  if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == false
                {
                    cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                }
                if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
                    
                    cell.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                }
                else  if !cell.placeAnOutlet.isSelected
                {
                    cell.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                }
                
                
                
            } else {
                
                
                if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true
                {
                    cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                }
                else  if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == false
                {
                    cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                }
                if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
                    
                    cell.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                }
                else  if !cell.placeAnOutlet.isSelected
                {
                    cell.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                }
                UserDefaults.standard.setValue("submit", forKey: "submitTypeSelection")
                cell.emailMeEnterTtitle.alpha = 1
                
                
            }
            if pviduser == 1 || pviduser == 2 || pviduser == 3 || pviduser == 10  || pviduser == 11 || pviduser == 12 {
                
                if fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",farmid:"",animalTag:"", pvid: pviduser).count == 0 {
                    cell.placeAnOutlet.alpha = 1
                    cell.emailMeEnterTtitle.alpha = 1
                    if UserDefaults.standard.value(forKey: "submitTypeSelection") as? String ==  "submit" {
                        if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
                            
                            cell.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                        }
                        else  if !cell.placeAnOutlet.isSelected
                        {
                            cell.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                        }
                        
                        if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true
                        {
                            cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                        }
                        else  if !cell.emailCheckOutlet.isSelected
                        {
                            cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                        }
                        
                        
                    } else {
                        if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true
                        {
                            cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                        }
                        else  if !cell.emailCheckOutlet.isSelected
                        {
                            cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                        }
                        if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true {
                            
                            cell.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                        }
                        else  if !cell.placeAnOutlet.isSelected
                        {
                            cell.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                        }
                        
                        
                    }
                } else {
                    if pviduser == 3 {
                        if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue && !UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) && UserDefaults.standard.bool(forKey: "SubmitBtnFlagNew"){
                            cell.placeAnOutlet.alpha = 1
                            cell.emailMeEnterTtitle.alpha = 1
                            
                        }else {
                            cell.placeAnOutlet.alpha = 0.6
                            cell.emailMeEnterTtitle.alpha = 0.6
                            
                        }
                        
                    }else {
                        if !UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) && UserDefaults.standard.bool(forKey: "SubmitBtnFlagNew") {
                            cell.placeAnOutlet.alpha = 1
                            cell.emailMeEnterTtitle.alpha = 1
                            
                        }else {
                            cell.placeAnOutlet.alpha = 0.6
                            cell.placeAnotrderTitle.alpha = 0.6
                        }}
                    
                    
                }
            }
            if pviduser == 4 || pviduser == 6 || pviduser == 8 {
                
                if fetchAllDataAnimalGirlando(entityName: Entities.animalAddTblEntity,userId:userId,orderId:orderId,orderStatus:"false",animalName:"",breedRegNumber:"", dateString: "").count == 0 {
                    
                    cell.placeAnOutlet.alpha = 1
                    
                    if UserDefaults.standard.value(forKey: "submitTypeSelection") as? String ==  "submit" {
                        if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true
                        {
                            
                            cell.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                        }
                        else  if !cell.placeAnOutlet.isSelected
                        {
                            cell.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                        }
                        if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true
                        {
                            cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                        }
                        else  if !cell.emailCheckOutlet.isSelected
                        {
                            cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                        }
                        
                    }else {
                        
                        if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true
                        {
                            
                            cell.placeAnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                        }
                        else  if !cell.placeAnOutlet.isSelected
                        {
                            cell.placeAnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                        }
                        if  UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true
                        {
                            cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
                        }
                        else  if !cell.emailCheckOutlet.isSelected
                        {
                            cell.emailCheckOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
                        }
                        
                    }
                    
                    
                } else {
                    cell.emailMeEnterTtitle.alpha = 1
                    cell.placeAnotrderTitle.alpha = 0.6
                    
                }
                
            }
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OPSTableViewCell", for: indexPath) as! OPSTableViewCell
        cell.OfficialId.text =  String(animaltag[indexPath.row])
        cell.OnFarmId.text =  String(farmID[indexPath.row])
        cell.Barcode.text = String(barCode[indexPath.row])
        cell.vollView.tag = indexPath.row
        cell.deleteBttn.tag = indexPath.row
        cell.deleteBttn.addTarget(nil, action: #selector(deleteButton(_:)), for: .touchUpInside)
        cell.vollView.reloadData()
        
        cell.onFarmIDTitle.text = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
        cell.officalIdTitle.text = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
        cell.barcodeTitleleft.text  = NSLocalizedString("Barcode", comment: "")
        
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue) as? Int)!
        
        if pviduser == 4 {
            cell.OfficialId.text = String(barCode[indexPath.row])
            cell.Barcode.isHidden = true
            cell.barcodeTitleleft.isHidden = true
            cell.thirdColonLbl.isHidden = true
            cell.OnFarmId.text =  String(earTag[indexPath.row])
            cell.onFarmIDTitle.text = NSLocalizedString(ButtonTitles.earTagText, comment: "")
            cell.officalIdTitle.text = NSLocalizedString("Barcode", comment: "")
            
        }else{
            cell.Barcode.isHidden = false
            cell.barcodeTitleleft.isHidden = false
            cell.thirdColonLbl.isHidden = false
            
        }
        
        return cell
    }
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "1"{
            
            let url =  NSURL(string: pricingLinkC ?? "")! as URL
            UIApplication.shared.open(url) { (Bool) in
                print("Open pricing link")
            }
        }
        return true
    }
    @objc func deleteButton(_ sender : UIButton){
        // removed for now
        
    }
    @objc func pricingBtnClick(_ sender:UIButton) {
        
        guard let url = URL(string: pricingLinkC!) else { return }
        UIApplication.shared.open(url)
        
    }
    @IBAction func dropAction(_ sender: UIButton) {
        
        if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: ""){
            if self.farmIdValue == 0{
                
                self.fethData =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity,asending:true,status: "true", orderStatus: "false", orderId: orderId, userId: userId, farmId: serchTextField.text!)
                
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                    // Intentionally left empty.
                    // Could be used in the future for logging, analytics, or error handling.
                })
                
                dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                self.farmIdValue = 1
                
            }
            else{
                dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                
                self.fethData =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity,asending:false,status: "true", orderStatus: "false", orderId: orderId,userId:userId, farmId: serchTextField.text!)
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                    // Intentionally left empty.
                    // Could be used in the future for logging, analytics, or error handling.
                })
                self.farmIdValue = 0
            }
            
        }
        else if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: ""){
            if self.animaId == 0{
                dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                
                self.fethData =  fetchAllDataanimalTagStatus(entityName: Entities.productAdonAnimalTblEntity,asending : true,status: "true", orderStatus: "false", animalTag: serchTextField.text!)
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                    // Intentionally left empty.
                    // Could be used in the future for logging, analytics, or error handling.
                })
                self.animaId = 1
            }
            else{
                dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                
                self.fethData =  fetchAllDataanimalTagStatus(entityName: Entities.productAdonAnimalTblEntity, asending: false,status: "true", orderStatus: "false", animalTag: serchTextField.text!)
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                    // Intentionally left empty.
                    // Could be used in the future for logging, analytics, or error handling.
                })
                self.animaId = 0
            }
            
        }
        
        else if self.clickOnDropDown == ButtonTitles.earTagText || self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: ""){
            
            if self.earTagID == 0{
                self.earTagID = 1
                self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                
                self.fethData =  fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity,asending : true,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                    // Intentionally left empty.
                    // Could be used in the future for logging, analytics, or error handling.
                })
            }
            else{
                self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                self.earTagID = 0
                self.fethData =  fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity,asending : false,orderId:self.orderId,userId:self.userId, animalTag: self.serchTextField.text!)
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                    // Intentionally left empty.
                    // Could be used in the future for logging, analytics, or error handling.
                })
            }
        }
        else{
            if self.barCodeId == 0{
                dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                
                self.fethData =  fetchAllDataBarcOdeStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true,status: "true", orderStatus: "false", barcode: serchTextField.text!)
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                    // Intentionally left empty.
                    // Could be used in the future for logging, analytics, or error handling.
                })
                self.barCodeId = 1
            }
            else{
                dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                
                self.fethData =  fetchAllDataBarcOdeStatus(entityName: Entities.productAdonAnimalTblEntity, asending: false,status: "true", orderStatus: "false", barcode: serchTextField.text!)
                self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {
                    // Intentionally left empty.
                    // Could be used in the future for logging, analytics, or error handling.
                })
                self.barCodeId = 0
            }
            
        }
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let currentString: NSString = serchTextField.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        tblView.isHidden = false
        if newString != ""{
            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "") {
                
                let fetchcustRep = fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true", orderStatus: "false",orderId: orderId,userId:userId, farmId: newString as String) as NSArray
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
            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: ""){
                let bPredicate: NSPredicate = NSPredicate(format: "farmId contains[cd] %@ || animalbarCodeTag contains[cd] %@ || animalTag contains[cd] %@ || productName contains[cd] %@", newString,newString,newString,newString)
                
                let fetchcustRep = fetchAllDataanimalTagStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true", orderStatus: "false",animalTag: newString as String).filtered(using: bPredicate) as NSArray
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
            if self.clickOnDropDown == NSLocalizedString("Barcode", comment: "")  {
                let bPredicate: NSPredicate = NSPredicate(format: "farmId contains[cd] %@ || animalbarCodeTag contains[cd] %@ || animalTag contains[cd] %@ || productName contains[cd] %@", newString,newString,newString,newString)
                
                let fetchcustRep = fetchAllDataBarcOdeStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true", orderStatus: "false", barcode: newString as String).filtered(using: bPredicate) as NSArray
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
            if clickOnDropDown == ButtonTitles.earTagText{
                let fetchcustRep =    fetchAllDataEarTag(entityName: Entities.productAdonAnimalTblEntity, asending: true, orderId: orderId, userId: userId, animalTag:  newString as String)
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
        }else{
            self.dropUpDownBtn.setImage(UIImage(named: "Image"), for: .normal)
            fethData = fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true", orderStatus: "false",orderId: orderId,userId:userId, farmId: newString as String)
            fetchProductAdonAnimalTbl(fethData: fethData, completion: {
                // Intentionally left empty.
                // Could be used in the future for logging, analytics, or error handling.
            })
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
        textField.resignFirstResponder()
        
        return true
    }
    var tblHeghtFrame  = CGFloat()
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == arr1.keys.count{
            if UserDefaults.standard.string(forKey: keyValue.providerNameUS.rawValue) != keyValue.clarifideCDCBUS.rawValue {
                return 460
                
            } else{
                
                return 450
            }
        }
        
        
        
        var addon = 0
        var data = [String:Any]()
        for value in selection{
            if value["animalId"] as? Int == values[indexPath.row]{
                data = value
            }
        }
        if let item = data["animalId"] as? Int{
            if values[indexPath.row] == item{
                let data = data["addon"] as? [SubProductTbl]
                
                var quo = data!.count/2
                let rem = data!.count % 2
                let val = quo * 40 * rem
                if quo == 0 && rem == 1{
                    quo = 1
                }
                
                
                if data!.count > 0 {
                    addon = Int(40 * CGFloat(quo) + 30) + val
                    
                }else{
                    addon = -20
                }
            }else{
                addon = -20
            }
        }else{
            addon = -20
        }
        let count = (arr1[values[indexPath.row]]!.count)/2 + 1
        
        print(40 * CGFloat(count) + 30 + CGFloat(count*20) + CGFloat(addon + 100))
        tblHeghtFrame = (40 * CGFloat(count) + 30 + CGFloat(count*20) + CGFloat(addon + 100))
        return 40 * CGFloat(count) + 30 + CGFloat(count*20) + CGFloat(addon + 100)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1{
            var data = [String:Any]()
            for value in selection{
                if (value["animalId"] as? Int) == values[collectionView.tag]{
                    data = value
                }
            }
            if let item  = data["animalId"] as? Int{
                if values[collectionView.tag] == item{
                    return (data["addon"] as! NSArray).count + 2
                }else{
                    return 0
                }
            }
            else{
                return 0
            }
        }else{
            return arr1[values[section]]!.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0{
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: "OPSCollectionViewCell", for: indexPath)  as! OPSCollectionViewCell
            item.layer.masksToBounds = true
            item.layoutIfNeeded()
            item.lbl.layoutIfNeeded()
            item.lbl.layer.masksToBounds = true
            item.lbl.text = arr1[values[collectionView.tag]]?[indexPath.row].productName ?? ""
            
            item.lbl.layer.borderColor = UIColor.lightGray.cgColor
            if arr1[values[collectionView.tag]]![indexPath.row].status! == "true"{
                collViewOfselection.append(collectionView)
                indexOfSelection.append(indexPath)
                item.lbl.backgroundColor = UIColor(red: 220/255, green: 54/255, blue: 72/255, alpha: 1)
                item.lbl.textColor = UIColor.white
            }else{
                item.lbl.backgroundColor = UIColor.white
                item.lbl.textColor = UIColor.black
            }
            return item
        }else{
            if indexPath.row == 0 {
                let item = collectionView.dequeueReusableCell(withReuseIdentifier: "addOnWithTitle", for: indexPath)
                return item
            }else  if indexPath.row == 1 {
                let item = collectionView.dequeueReusableCell(withReuseIdentifier: "addOn", for: indexPath)
                return item
            }else{
                let item = collectionView.dequeueReusableCell(withReuseIdentifier: "OPSCollectionViewCell", for: indexPath)  as! OPSCollectionViewCell
                item.layer.masksToBounds = true
                item.layoutIfNeeded()
                item.lbl.layoutIfNeeded()
                item.lbl.layer.masksToBounds = true
                var data = [String:Any]()
                for value in selection{
                    if (value["animalId"] as? Int) == values[collectionView.tag]{
                        data = value
                    }
                }
                item.lbl.layer.borderColor = UIColor.lightGray.cgColor
                
                if ((data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).status! == "true"{
                    item.lbl.backgroundColor = UIColor(red: 220/255, green: 54/255, blue: 72/255, alpha: 1)
                    item.lbl.textColor = UIColor.white
                }else{
                    item.lbl.backgroundColor = UIColor.white
                    item.lbl.textColor = UIColor.black
                }
                
                
                item.lbl.text = ((data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTbl).adonName!
                
                return item
            }
        }
    }
    
    
    
    let buttonbg1 = UIButton ()
    var customPopView1 :TipPopUp!
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width / 2 ) - 10, height: 40)
    }
    
    @IBAction func emailBtnInfo(_ sender: UIButton) {
        
        let p = sender.convert(sender.bounds,to: self.view)
        
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(self.buttonbgPressedTip1), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view.addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed(ClassIdentifiers.tipPopUpNib) as? TipPopUp
        customPopView1.arrow_left.isHidden = true
        customPopView1.arrow_Top.isHidden = false
        customPopView1.elipseImage2.isHidden = true
        customPopView1.elipseImage1.isHidden = true
        customPopView1.textLbl2.isHidden = true
        customPopView1.frame = CGRect(x: 30,y: p.origin.y + 44   ,width: screenSize.width - 109, height: 125)
        
        customPopView1.delegate = self
        customPopView1.layer.borderColor = UIColor.blue.cgColor
        customPopView1.layer.borderWidth = 1
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1.addSubview(customPopView1)
        if langId == 1 {
            customPopView1.arrow_Top.frame = CGRect(x: 168 , y: -22, width: 26, height: 26)
        }else {
            customPopView1.arrow_Top.frame = CGRect(x: 228 , y: -22, width: 26, height: 26)
            
        }
        
        customPopView1.textLabel1.text =  NSLocalizedString("This will email me with the animals, samples and product information I have entered. I can finish the order on my computer and email to Zoetis Genetics.", comment: "")
        
        
    }
    @IBAction func conflictOrderAction(_ sender: Any) {
        if fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:self.userId,orderId:self.orderId,orderStatus:"false",farmid:"",animalTag:"", pvid: pviduser).count == 0 {
            
            
        } else {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ConfilictOrdersViewController") as! ConfilictOrdersViewController
            vc.delegateCustom1 = self
            vc.screenName = "productSelectionReview"
            self.present(vc, animated: true, completion: nil)
            
        }}
    
    @objc func buttonbgPressedTip1 (){
        buttonbg1.removeFromSuperview()
        customPopView1.removeFromSuperview()
    }
    @IBAction func edirOrderBtnAction(_ sender: UIButton) {
        
        if !UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) {
            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Do you want to email entered data?", comment: ""), preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                print(LocalizedStrings.cancelPressed)
                
                return
            }
            // Create the actions
            let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) {
                UIAlertAction in
                UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                if Connectivity.isConnectedToInternet() {
                    self.showIndicator(self.view, withTitle: "", and: "")
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVC") as! OrderSubmittedVC
                    self.navigationController?.pushViewController(newViewController, animated: true)
                } else {
                    let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveViewController") as! OrderSaveViewController
                    self.navigationController?.pushViewController(newViewController, animated: true)
                }
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
        if Connectivity.isConnectedToInternet() {
            showIndicator(self.view, withTitle: "", and: "")
            
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVC") as! OrderSubmittedVC
            self.navigationController?.pushViewController(newViewController, animated: true)
        } else {
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveViewController") as! OrderSaveViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
    }
    
    @IBAction func termsBtnInfo(_ sender: UIButton) {
        
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "ProductWiseTermsController") as! ProductWiseTermsController
        self.navigationController?.present(vc, animated: false, completion: nil)
        return
        
    }
    
    
    @IBAction func infoIconAction(_ sender: UIButton) {
        
        let p = sender.convert(sender.bounds,to: self.view)
        
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(self.buttonbgPressedTip), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view.addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed(ClassIdentifiers.tipPopUpNib) as? TipPopUp
        customPopView1.arrow_left.isHidden = true
        customPopView1.arrow_Top.isHidden = false
        customPopView1.elipseImage2.isHidden = true
        customPopView1.elipseImage1.isHidden = true
        customPopView1.textLbl2.isHidden = true
        customPopView1.frame = CGRect(x: 30,y: p.origin.y + 42   ,width: screenSize.width - 109, height: 100)
        
        customPopView1.delegate = self
        customPopView1.layer.borderColor = UIColor.blue.cgColor
        customPopView1.layer.borderWidth = 1
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1.addSubview(customPopView1)
        
        if langId == 1 {
            customPopView1.arrow_Top.frame = CGRect(x: 121 , y: -22, width: 26, height: 26)
        } else {
            customPopView1.arrow_Top.frame = CGRect(x: 133 , y: -22, width: 26, height: 26)
            
        }
        
        
        customPopView1.textLabel1.text =  NSLocalizedString("Submit is only available if all fields are filled out for each animal submitted.", comment: "")
        
        
    }
    
    @objc func buttonbgPressedTip (){
        buttonbg1.removeFromSuperview()
        customPopView1.removeFromSuperview()
    }
    @IBAction func reviewOrder(_ sender: UIButton) {
        
        
        
        
        
        DispatchQueue.main.async
        {
            if let cell = self.tblView.cellForRow(at: IndexPath(row: self.arr1.keys.count, section: 0) ) as? BillingCell
            {
                if cell.billingBtnOutlet.titleLabel?.text == "N/A"
                {
                    self.transparentView.isHidden = false
                    self.billingView.isHidden = false
                    self.isBillingContact = false
                }
                else
                {
                    
                    if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true &&
                        UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true
                    {
                        updateAnimalOrderEmailStatus(entity: Entities.animalMasterTblEntity, IsEmailId: false)
                        updateAnimalOrderEmailStatus(entity: Entities.animalAddTblEntity, IsEmailId: false)
                        if (UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool == false) || (UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool == nil)
                        {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.acceptOrderTerms, comment: ""))
                            return
                        }
                        
                        if Connectivity.isConnectedToInternet()
                        {
                            
                            UserDefaults.standard.removeObject(forKey: keyValue.submitBtnFlag.rawValue)
                            self.showIndicator(self.view, withTitle: "", and: "")
                            
                            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVC") as! OrderSubmittedVC
                            newViewController.emailOrder=true
                            self.navigationController?.pushViewController(newViewController, animated: true)
                            
                        }
                        else
                        {
                            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveViewController") as! OrderSaveViewController
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        }
                        
                    }
                    
                    else if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == true &&
                                UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == false
                    {
                        updateAnimalOrderEmailStatus(entity: Entities.animalMasterTblEntity, IsEmailId: false)
                        updateAnimalOrderEmailStatus(entity: Entities.animalAddTblEntity, IsEmailId: false)
                        if (UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool == false) || (UserDefaults.standard.value(forKey: keyValue.isAgreeForSubmit.rawValue) as? Bool == nil)
                        {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.acceptOrderTerms, comment: ""))
                            return
                        }
                        
                        if Connectivity.isConnectedToInternet()
                        {
                            
                            UserDefaults.standard.removeObject(forKey: keyValue.submitBtnFlag.rawValue)
                            self.showIndicator(self.view, withTitle: "", and: "")
                            
                            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVC") as! OrderSubmittedVC
                            newViewController.emailOrder=false
                            self.navigationController?.pushViewController(newViewController, animated: true)
                            
                        }
                        else
                        {
                            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveViewController") as! OrderSaveViewController
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        }
                        
                    }
                    else if UserDefaults.standard.value(forKey: keyValue.placeOrderCheck.rawValue) as? Bool == false &&
                                UserDefaults.standard.value(forKey: keyValue.emailCheckValue.rawValue) as? Bool == true
                                
                    {
                        updateAnimalOrderEmailStatus(entity: Entities.animalMasterTblEntity, IsEmailId: true)
                        updateAnimalOrderEmailStatus(entity: Entities.animalAddTblEntity, IsEmailId: true)
                        if !UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue)
                        {
                            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Do you want to email entered data?", comment: ""), preferredStyle: .alert)
                            
                            let cancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
                                UIAlertAction in
                                print(LocalizedStrings.cancelPressed)
                                
                                return
                            }
                            // Create the actions
                            let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) {
                                UIAlertAction in
                                UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                                if Connectivity.isConnectedToInternet() {
                                    self.showIndicator(self.view, withTitle: "", and: "")
                                    
                                    let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVC") as! OrderSubmittedVC
                                    newViewController.emailOrder=true
                                    self.navigationController?.pushViewController(newViewController, animated: true)
                                } else {
                                    let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
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
                            
                            if Connectivity.isConnectedToInternet(){
                                
                                UserDefaults.standard.set(true, forKey: keyValue.submitBtnFlag.rawValue)
                                self.showIndicator(self.view, withTitle: "", and: "")
                                
                                let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                                let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSubmittedVC") as! OrderSubmittedVC
                                newViewController.emailOrder=true
                                self.navigationController?.pushViewController(newViewController, animated: true)
                                
                            }
                            else
                            {
                                let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                                let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderSaveViewController") as! OrderSaveViewController
                                self.navigationController?.pushViewController(newViewController, animated: true)
                            }
                            
                        }
                    }
                    else
                    {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString("Please select at least one checkbox to submit.", comment: ""))
                        return
                    }
                }
                
                
            }
        }
        
        
        
        
    }
    
    @IBAction func pricingLinkAction(_ sender: Any) {
        
        guard let url = URL(string: "https://mysearchpoint.com") else { return }
        UIApplication.shared.open(url)
        
    }
    
    @IBAction func toggleBtnAction(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ReviewOrderVC") as! ReviewOrderVC
        self.navigationController?.pushViewController(newViewController, animated: false)
        
    }
    
    @objc  func checkForReachability(notification:Notification){
        
        let del =  UIApplication.shared.delegate as? AppDelegate
        
        self.networkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if networkStatusLbl?.text == ButtonTitles.connectedText.localized
        {
            self.OffLineBtn.isHidden = true
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else{
            
            self.OffLineBtn.isHidden = false
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
            
        }
        
    }
    
    func initialNetworkCheck()
    {
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        
        let del =  UIApplication.shared.delegate as? AppDelegate
        
        self.networkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if networkStatusLbl?.text == ButtonTitles.connectedText.localized
        {
            self.OffLineBtn.isHidden = true
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else{
            self.OffLineBtn.isHidden = false
            self.networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
            
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
        customPopView = OfflinePopUp.loadFromNibNamed(ClassIdentifiers.offlineViewNib) as? OfflinePopUp
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
    @IBAction func editBtnActon(_ sender: Any) {
        UserDefaults.standard.set(1, forKey: keyValue.orderSlideTag.rawValue)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "OrderingDefaultsVC")), animated: true)
        
    }
    
}
extension OrderProductSelectionReviewVC:offlineCustomView{
    func crossBtnCall() {
        
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
}

extension OrderProductSelectionReviewVC : SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}
