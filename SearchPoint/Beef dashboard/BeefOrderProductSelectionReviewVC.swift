//
//  BeefOrderProductSelectionReviewVC.swift
//  SearchPoint
//
//  Created by "" on 12/03/20.
//

import UIKit
import DropDown
import MBProgressHUD
class BeefOrderProductSelectionReviewVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextFieldDelegate,BillingDelegate,offlineCustomView1,UITextViewDelegate,objectPickfromConfilict{
 
    func crossBtn() {
        // this method is left empty for now
    }
    @IBOutlet weak var selectBillingContactLbl: UILabel!
    
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
    var rGN_ID = 0
    var rGD_ID = 0
    
    let buttonbg1 = UIButton ()
    var customPopView1 :TipPopUp!
    
    @IBOutlet weak var animalLbl: UILabel!
    @IBOutlet weak var appStatusLbl: UILabel!
    @IBOutlet weak var productLbl: UILabel!
    @IBOutlet weak var reviewOrderLbl: UILabel!
    @IBOutlet weak var sortBtLbl: UILabel!
    @IBOutlet weak var appHelpBtn: UIButton!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var billingView: UIView!
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
    var indexOfSelection:[IndexPath?] = [IndexPath]()
    var collViewOfselection:[UICollectionView?] = [UICollectionView]()
    var billingdelegateVC = BillingTableViewDelegate()
    var farmAddr = [GetBillingContact]()
    var custmerId = UserDefaults.standard.value(forKey: "currentActiveCustomerId") as! Int
    var userId = UserDefaults.standard.integer(forKey: "userId")
    var orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
    var langId = UserDefaults.standard.value(forKey: "lngId") as? Int
    var heartBeatViewModel:HeartBeatViewModel?
    let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
    func navigateToAnotherVc(){
    }
    func dataReload(check :Bool){
        if !check{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "BeefOrderProductSelectionReviewVC") as! BeefOrderProductSelectionReviewVC
            self.navigationController?.pushViewController(newViewController, animated: false)
        }
    }
    func firstLevel(check: Bool) {
        
        let currentCustomerId = UserDefaults.standard.value(forKey: "currentActiveCustomerId") as? Int
        
        let fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: "BeefAnimaladdTbl",orderId:orderId,userId:userId,customerId:currentCustomerId ?? 0,date:"")
        
        if fetchAnimalTbl.count != 0 {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BeefConfilictOrdersViewController") as! BeefConfilictOrdersViewController
            vc.delegateCustom1 = self
            vc.screenName = "beefproductSelectionReview"
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    func selectionObject(check: Bool) {
        
        if check{
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
            
        }}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        farmAddr = fetchBillingCustomer(entityName: "GetBillingContact",customerID: self.custmerId) as! [GetBillingContact]
        UserDefaults.standard.set(1, forKey: "orderIdBeef")
        heartBeatViewModel = HeartBeatViewModel(callBack: navigateToAnotherVc)
        heartBeatViewModel?.callGetHearBeatData()
        
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
        
        
        animalLbl.text = NSLocalizedString("Animal", comment: "")
        appStatusLbl.text = NSLocalizedString("App Status:", comment: "")
        productLbl.text = NSLocalizedString("Product", comment: "")
        reviewOrderLbl.text = NSLocalizedString("Review Order", comment: "")
        sortBtLbl.text = NSLocalizedString("Sort By:", comment: "")
        
        serchTextField.placeholder = NSLocalizedString("Search", comment: "")
        
        
        selectBillingContactLbl.text = NSLocalizedString("Select Billing Contact", comment: "")
        
        
    }
    
    
    @IBAction func emailMeEnteredDataAction(_ sender: Any) {
        
        if !UserDefaults.standard.bool(forKey: "SubmitBtnFlag") {
            let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Do you want to email entered data?", comment: ""), preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("Cancel Pressed")
                
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
        
        UserDefaults.standard.set(true, forKey: "SubmitBtnFlag")
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
        customPopView1.frame = CGRect(x: 20,y: p.origin.y + 42   ,width: screenSize.width - 109, height: 125)
        
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
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "ProductWiseTermsController") as! ProductWiseTermsController
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
        customPopView1.frame = CGRect(x: 20,y: p.origin.y + 42   ,width: screenSize.width - 100, height: 115)
        
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
        
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
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
            selection.append (["animalTag":aTag as Any,"addon":data as Any,"row":collectionView.tag])
            
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
        dropDown.cellHeight = 37
        if pvid == 13 {
            dropDown.dataSource  = ["Unique ID".localized, NSLocalizedString("Barcode", comment: "")]
        }
        if pvid == 7 {
            dropDown.dataSource = [ NSLocalizedString("Animal Tag", comment: ""), NSLocalizedString("Barcode", comment: "")]
        }
        if pvid  == 5{
            dropDown.dataSource = [ NSLocalizedString("Ear Tag", comment: ""), NSLocalizedString("Barcode", comment: "")]
        }
        if pvid == 6{
            dropDown.dataSource = [NSLocalizedString("Barcode", comment: ""), NSLocalizedString("Series", comment: ""), NSLocalizedString("RGN", comment: ""), NSLocalizedString("RGD or Animal ID", comment: "")]
        }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            
            self.clickOnDropDown = item
            
            self.farmIdDisplyOutlet.setTitle(item, for: .normal)
            self.farmIdDisplyOutlet.layer.borderColor = UIColor.gray.cgColor
            
            if pvid == 5 || pvid == 7 || pvid == 13{
                if self.clickOnDropDown == NSLocalizedString("Ear Tag", comment: "") || self.clickOnDropDown == NSLocalizedString("Official ID", comment: "") || self.clickOnDropDown == "Animal Tag".localized || self.clickOnDropDown == "Unique ID".localized {
                    UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
                    if self.animaId == 0{
                        self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                        
                        self.fethData =  fetchAllDataanimalTagStatus(entityName: "ProductAdonAnimlTbLBeef",asending : true,status: "true", orderStatus: "false", animalTag: self.serchTextField.text!)
                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                        self.animaId = 1
                    }
                    else{
                        self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                        
                        self.fethData =  fetchAllDataanimalTagStatus(entityName: "ProductAdonAnimlTbLBeef", asending: false,status: "true", orderStatus: "false", animalTag: self.serchTextField.text!)
                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                        self.animaId = 0
                    }
                    
                }
                else{
                    UserDefaults.standard.set("barcode", forKey: "InheritFOSampleTrackingDetailVC")
                    if self.barCodeId == 0{
                        self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                        
                        self.fethData =  fetchAllDataBarcOdeStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                        self.barCodeId = 1
                    }
                    else{
                        self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                        
                        self.fethData =  fetchAllDataBarcOdeStatus(entityName: "ProductAdonAnimlTbLBeef", asending: false,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
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
                        
                        self.fethData =  fetchAllDataanimalTagStatus(entityName: "ProductAdonAnimlTbLBeef",asending : true,status: "true", orderStatus: "false", animalTag: self.serchTextField.text!)
                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                        self.animaId = 1
                    }
                    else{
                        self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                        
                        self.fethData =  fetchAllDataanimalTagStatus(entityName: "ProductAdonAnimlTbLBeef", asending: false,status: "true", orderStatus: "false", animalTag: self.serchTextField.text!)
                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                        self.animaId = 0
                    }
                    
                }
                if self.clickOnDropDown ==  NSLocalizedString("Series", comment: ""){
                    UserDefaults.standard.set(false, forKey: "brazilBarcode")
                    UserDefaults.standard.set(true, forKey: "series")
                    UserDefaults.standard.set("barcode", forKey: "InheritFOSampleTrackingDetailVC")
                    if self.barCodeId == 0{
                        self.dropUpDownBtn.setImage(UIImage(named: "sortingdesc"), for: .normal)
                        
                        self.fethData =  fetchAllDataBarcOdeStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                        self.barCodeId = 1
                    }
                    else{
                        self.dropUpDownBtn.setImage(UIImage(named: "sorting"), for: .normal)
                        
                        self.fethData =  fetchAllDataBarcOdeStatus(entityName: "ProductAdonAnimlTbLBeef", asending: false,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
                        self.fetchProductAdonAnimalTbl(fethData: self.fethData, completion: {})
                        self.barCodeId = 0
                    }
                    
                }
                if self.clickOnDropDown == NSLocalizedString("RGN", comment: ""){
                    UserDefaults.standard.set("rgn", forKey: "InheritFOSampleTrackingDetailVC")
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
                    UserDefaults.standard.set("rgd", forKey: "InheritFOSampleTrackingDetailVC")
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
        
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.userId = UserDefaults.standard.integer(forKey: "userId")
        self.orderId = UserDefaults.standard.integer(forKey: "orderIdBeef")
        
        tableViewBilling.delegate = billingdelegateVC
        tableViewBilling.dataSource = billingdelegateVC
        tableViewBilling.reloadData()
        billingdelegateVC.delegate = self
        
        if pvid == 13 {
            appHelpBtn.isHidden = false
        } else {
            appHelpBtn.isHidden = true
        }
        
        let animaltbl = fetchRemaningSubmitOrder(entityName: "BeefAnimaladdTbl", isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
        
        for i in 0..<animaltbl.count{
            let data = animaltbl.object(at: i) as! BeefAnimaladdTbl
            deleteRemaningSubmitOrderReview(entityName: "ProductAdonAnimlTbLBeef", isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId, aid: Int(data.animalId))
            deleteRemaningSubmitOrderReview(entityName: "SubProductTblBeef", isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId,aid: Int(data.animalId))
        }
        deleteRemaningSubmitOrder(entityName: "BeefAnimaladdTbl", isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
        
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
            }
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
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
            }
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            self.fethData =  fetchAllDataanimalTagStatus(entityName: "ProductAdonAnimlTbLBeef",asending : true,status: "true", orderStatus: "false", animalTag: serchTextField.text!)
        }
        if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "barcode" || UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "Barcode"{
            if pvid == 5 || pvid == 7{
                var selected = UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC")
                if selected == "barcode" {
                    selected = "Barcode"
                }
                self.clickOnDropDown = NSLocalizedString(selected ?? "Ear Tag", comment: "")
            }
            if pvid == 6{
                UserDefaults.standard.set(false, forKey: "brazilBarcode")
                UserDefaults.standard.set(true, forKey: "series")
                self.clickOnDropDown =  NSLocalizedString("Series", comment: "")
            }
            if pvid == 13{
                
                self.clickOnDropDown = "Unique ID".localized
            }
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            self.fethData =  fetchAllDataBarcOdeStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true,status: "true", orderStatus: "false", barcode: serchTextField.text!)
        }
        if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "rgn" {
            self.clickOnDropDown =  NSLocalizedString("RGN", comment: "")
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            self.fethData =  fetchAllDataRGNStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
            
        }
        if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "rgd" {
            self.clickOnDropDown =  NSLocalizedString("RGD or Animal ID", comment: "")
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
            self.fethData =  fetchAllDataRGDStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true,status: "true", orderStatus: "false", barcode: self.serchTextField.text!)
        }
        
        if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "Series" {
            
            self.clickOnDropDown =  NSLocalizedString("Series", comment: "")
            self.farmIdDisplyOutlet.setTitle(self.clickOnDropDown, for: .normal)
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
        
        
        if farmAddr.count > 0 {
            updateUI()
        }
        
    }
    
    @IBAction func crossClick(_ sender: UIButton) {
        transparentView.isHidden = true
        billingView.isHidden = true
    }
    
    @IBAction func viewAnimalClick(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BeefViewAnimalVC") as? BeefViewAnimalVC
        vc!.screenBackSave = true
        vc!.productBackSave = false
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    var pricingLinkC = String()
    @IBAction func menuBtnClk(_ sender: UIButton) {
        self.view.makeCorner(withRadius: 40)
        self.sideMenuViewController?.presentRightMenuViewController()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr1.keys.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == arr1.keys.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BillinghCell", for: indexPath) as! BillingCell
            let attributeString = NSMutableAttributedString(string: (UserDefaults.standard.value(forKey: "farmValue") as! String), attributes: self.attrs)
            cell.pricingTextView.delegate = self
            cell.delegateCustom = self
            if UserDefaults.standard.value(forKey: "name") as? String  != "Dairy"{
                cell.addDealerCodeTextField.delegate = cell
                cell.addDealerCodeTextField.isHidden = true
                cell.addDealerCodeTextField.layer.borderWidth = 1.0
                cell.addDealerCodeTextField.layer.borderColor = UIColor.lightGray.cgColor
                cell.addDealerCodeTextField.layer.cornerRadius = 10.0
                cell.addDealerCodeTextField.setLeftPaddingPoints(10.0)
                cell.dealerCodeLabel.textColor = .black
                cell.dealerCodeLabel.font = cell.dealerCodeLabel.font.withSize(10)
                cell.dealerCodeLabel.textAlignment = .left
                cell.dealerCodeLabel.numberOfLines = 1
                cell.dealerCodeLabel.lineBreakMode = .byCharWrapping
                cell.dealerCodeLabel.text = "3213132321321321321312312313213213"
                cell.dealerCodeLabel.sizeToFit()
                cell.dealerCodeView.addSubview(cell.dealerCodeLabel)
                cell.dealerCodeView.layer.cornerRadius = 15.0
                cell.button.frame = CGRect(x: 154, y: 5, width: 18, height: 18)
                cell.button.setImage(cell.image, for: .normal)
                cell.dealerCodeView.addSubview(cell.button)
                let dealerCode = UserDefaults.standard.value(forKey: "dealerCode") as? String
                
                let addDealerCodeCheck = UserDefaults.standard.value(forKey: "addDealerCodeCheck") as? Bool
                if UserDefaults.standard.value(forKey: "beefplaceordercheck") as? Bool == true
                {
                    if addDealerCodeCheck == false {
                        cell.addDealerCodeOutlet.setImage(UIImage(named: "check"), for: .normal)
                        
                        if  dealerCode == "" || dealerCode == nil {
                            cell.dealerCodeView.isHidden = true
                            cell.addDealerCodeTextField.isHidden = false
                            cell.addDealerCodeTextField.layer.borderWidth = 1.0
                            cell.addDealerCodeTextField.layer.borderColor = UIColor.lightGray.cgColor
                            cell.addDealerCodeTextField.layer.cornerRadius = 20.0
                            cell.addDealerCodeTextField.setLeftPaddingPoints(10.0)
                            
                        } else {
                            cell.dealerCodeView.isHidden = false
                            cell.dealerCodeLabel.text = dealerCode
                            cell.dealerCodeView.alpha = 1
                            cell.dealerCodeView.isUserInteractionEnabled = true
                            cell.addDealerCodeTextField.isHidden = true
                        }
                    }
                    else {
                        cell.addDealerCodeOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                        cell.addDealerCodeTextField.isHidden = true
                        if  dealerCode == "" || dealerCode == nil {
                            cell.dealerCodeView.isHidden = true
                        } else {
                            cell.dealerCodeView.isHidden = false
                            cell.dealerCodeLabel.text = dealerCode
                            cell.dealerCodeView.alpha = 0.6
                            cell.dealerCodeView.isUserInteractionEnabled = false
                            cell.addDealerCodeTextField.isHidden = true
                        }
                    }
                } else{
                    cell.addDealerCodeOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                    cell.addDealerCodeTextField.isHidden = true
                    if dealerCode == "" || dealerCode == nil{
                        cell.dealerCodeView.isHidden = true
                    } else {
                        cell.dealerCodeView.isHidden = false
                        cell.dealerCodeLabel.text = dealerCode
                        cell.dealerCodeView.alpha = 0.6
                        cell.dealerCodeView.isUserInteractionEnabled = false
                        cell.addDealerCodeTextField.isHidden = true
                    }
                } }
            
            let marketId = UserDefaults.standard.value(forKey: "currentActiveMarketId") as! String
            let markeData = fetchdataFromMarketId(marketId: marketId)
            if markeData.count > 0 {
                let marketnA = markeData.object(at: 0) as! GetMarketsTbl
                let pricingLink = marketnA.pricingLinkUrl
                pricingLinkC = pricingLink ?? ""
                
                UserDefaults.standard.setValue(true, forKey: "beefemailcheckvalue")
                cell.beefEmailSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                
                let attributedString = NSMutableAttributedString(string:  "For Information on list pricing of products, please visit the following web page. Pricing".localized)
                cell.pricingTextView.linkTextAttributes = [
                    .foregroundColor: UIColor.blue,
                    .underlineStyle: NSUnderlineStyle.single.rawValue
                ]
                attributedString.addAttribute(.link, value: "1", range: NSRange(location: 82, length: 7))
                cell.pricingTextView.attributedText = attributedString
                cell.pricingTextView.isHidden = true
                
                
                if UserDefaults.standard.value(forKey: "submitTypeSelection") as? String == "emailMe" || UserDefaults.standard.value(forKey: "submitTypeSelection") as? String == "" ||  UserDefaults.standard.value(forKey: "submitTypeSelection") as? String == nil{
                    
                    UserDefaults.standard.setValue("emailMe", forKey: "submitTypeSelection")
                    UserDefaults.standard.setValue("email", forKey: "emailFlag")
                    if  UserDefaults.standard.value(forKey: "beefemailcheckvalue") as? Bool == true
                    {
                        cell.beefEmailSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                    }
                    else  if !cell.beefEmailSelectionOutlet.isSelected
                    {
                        cell.beefEmailSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                    }
                    if UserDefaults.standard.value(forKey: "beefplaceordercheck") as? Bool == true
                    {
                        
                        cell.beefPlaceSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                        cell.addDealerCodeLabel.alpha = 1
                        cell.addDealerCodeOutlet.alpha = 1
                        
                    }
                    else  if !cell.beefPlaceSelectionOutlet.isSelected
                    {
                        cell.beefPlaceSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                        cell.addDealerCodeLabel.alpha = 0.6
                        cell.addDealerCodeOutlet.alpha = 0.6
                    }
                    
                } else {
                    if  UserDefaults.standard.value(forKey: "beefemailcheckvalue") as? Bool == true
                    {
                        cell.beefEmailSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                    }
                    else  if !cell.beefEmailSelectionOutlet.isSelected
                    {
                        cell.beefEmailSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                    }
                    if UserDefaults.standard.value(forKey: "beefplaceordercheck") as? Bool == true
                    {
                        
                        cell.beefPlaceSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                        cell.addDealerCodeLabel.alpha = 1
                        cell.addDealerCodeOutlet.alpha = 1
                        
                    }
                    else  if !cell.beefPlaceSelectionOutlet.isSelected
                    {
                        cell.beefPlaceSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                        cell.addDealerCodeLabel.alpha = 0.6
                        cell.addDealerCodeOutlet.alpha = 0.6
                    }
                    
                    
                    cell.beefEmailSelectionOutlet.alpha = 1
                }
                let pviduser = (UserDefaults.standard.integer(forKey:"BeefPvid") as? Int)!
                let currentCustomerId = UserDefaults.standard.value(forKey: "currentActiveCustomerId") as? Int
                if pviduser == 13 {
                    
                    
                    let fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: "BeefAnimaladdTbl",orderId:orderId,userId:userId,customerId:currentCustomerId ?? 0,date:"")
                    
                    if fetchAnimalTbl.count == 0 {
                        UserDefaults.standard.set(false, forKey: "beefemailcheckvalue")
                        cell.beefPlaceAnSelectionTitle.alpha = 1
                        cell.beefPlaceSelectionOutlet.alpha = 1
                        cell.beefEmailSelectionOutlet.isHidden = true
                        cell.emailMeSelectionTtile.isHidden = true
                        cell.beefEmaiInfoBtnOutlet.isHidden =  true
                        cell.beefPlaceanOrderCheckboxTopConstraint.constant = 5
                        cell.beefEmailMeCheckboxHeightConstraint.constant = 0
                        cell.beefEmailMeTopSelectionConstraint.constant = 0
                        if UserDefaults.standard.value(forKey: "beefplaceordercheck") as? Bool == true
                        {
                            
                            cell.beefPlaceSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                            cell.addDealerCodeLabel.alpha = 1
                            cell.addDealerCodeOutlet.alpha = 1
                            
                        }
                        else  if !cell.beefPlaceSelectionOutlet.isSelected
                        {
                            cell.beefPlaceSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                            cell.addDealerCodeLabel.alpha = 0.6
                            cell.addDealerCodeOutlet.alpha = 0.6
                        }
                        if  UserDefaults.standard.value(forKey: "beefemailcheckvalue") as? Bool == true
                        {
                            cell.beefEmailSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                        }
                        else  if !cell.beefEmailSelectionOutlet.isSelected
                        {
                            cell.beefEmailSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                        }
                        
                        
                        
                    } else {
                        
                        cell.beefPlaceAnSelectionTitle.alpha = 0.6
                        cell.beefPlaceSelectionOutlet.alpha = 0.6
                        cell.beefEmailSelectionOutlet.isHidden = true
                        cell.emailMeSelectionTtile.isHidden = true
                        cell.beefEmaiInfoBtnOutlet.isHidden =  true
                        cell.beefPlaceanOrderCheckboxTopConstraint.constant = 0
                        cell.beefEmailMeCheckboxHeightConstraint.constant = 0
                        
                        if UserDefaults.standard.value(forKey: "beefplaceordercheck") as? Bool == true
                        {
                            
                            cell.beefPlaceSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                            cell.addDealerCodeLabel.alpha = 1
                            cell.addDealerCodeOutlet.alpha = 1
                            
                        }
                        else  if !cell.beefPlaceSelectionOutlet.isSelected
                        {
                            cell.beefPlaceSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                            cell.addDealerCodeLabel.alpha = 0.6
                            cell.addDealerCodeOutlet.alpha = 0.6
                        }
                        if  UserDefaults.standard.value(forKey: "beefemailcheckvalue") as? Bool == true
                        {
                            cell.beefEmailSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                        }
                        else  if !cell.beefEmailSelectionOutlet.isSelected
                        {
                            cell.beefEmailSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                        }
                        cell.agreeTextHeight.constant = 0
                        cell.pricingTexthEIGHT.constant = 0
                        cell.agreeLl.isHidden = true
                        cell.beefinfoBtnSelectionOutlet.isHidden = true
                        cell.pricingTextView.isHidden = true
                        cell.termsInfoBtnOutlet.isHidden = true
                        cell.beefEmailMeTopSelectionConstraint.constant = 0
                        cell.beefAggreeTopConstaraint.constant = 0
                        cell.beefEmailSelectionOutlet.isHidden = true
                        cell.beefEmaiInfoBtnOutlet.isHidden = true
                        
                    }
                    
                }
                
                if pviduser == 5 && UserDefaults.standard.string(forKey: "beefProduct") == "INHERIT" {
                   
                        let fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: "BeefAnimaladdTbl",orderId:orderId,userId:userId,customerId:currentCustomerId ?? 0,date:"")
                        
                        if fetchAnimalTbl.count == 0 {
                            
                            cell.beefPlaceAnSelectionTitle.alpha = 1
                            cell.beefPlaceSelectionOutlet.alpha = 1
                            if UserDefaults.standard.value(forKey: "beefplaceordercheck") as? Bool == true
                            {
                                
                                cell.beefPlaceSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                                cell.addDealerCodeLabel.alpha = 1
                                cell.addDealerCodeOutlet.alpha = 1
                                
                            }
                            else  if !cell.beefPlaceSelectionOutlet.isSelected
                            {
                                cell.beefPlaceSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                                cell.addDealerCodeLabel.alpha = 0.6
                                cell.addDealerCodeOutlet.alpha = 0.6
                            }
                            if  UserDefaults.standard.value(forKey: "beefemailcheckvalue") as? Bool == true
                            {
                                cell.beefEmailSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                            }
                            else  if !cell.beefEmailSelectionOutlet.isSelected
                            {
                                cell.beefEmailSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                            }
                            
                            
                            
                        } else {
                            cell.beefPlaceAnSelectionTitle.alpha = 0.6
                            cell.beefPlaceSelectionOutlet.alpha = 0.6
                            if UserDefaults.standard.value(forKey: "beefplaceordercheck") as? Bool == true
                            {
                                
                                cell.beefPlaceSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                                cell.addDealerCodeLabel.alpha = 1
                                cell.addDealerCodeOutlet.alpha = 1
                                
                            }
                            else  if !cell.beefPlaceSelectionOutlet.isSelected
                            {
                                cell.beefPlaceSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                                cell.addDealerCodeLabel.alpha = 0.6
                                cell.addDealerCodeOutlet.alpha = 0.6
                            }
                            if  UserDefaults.standard.value(forKey: "beefemailcheckvalue") as? Bool == true
                            {
                                cell.beefEmailSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                            }
                            else  if !cell.beefEmailSelectionOutlet.isSelected
                            {
                                cell.beefEmailSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                            }
                            UserDefaults.standard.setValue("emailMe", forKey: "submitTypeSelection")
                            cell.agreeTextHeight.constant = 0
                            cell.pricingTexthEIGHT.constant = 0
                            cell.agreeLl.isHidden = true
                            cell.beefinfoBtnSelectionOutlet.isHidden = true
                            cell.pricingTextView.isHidden = true
                            cell.termsInfoBtnOutlet.isHidden = true
                            cell.beefEmailMeTopSelectionConstraint.constant = 0
                            cell.beefAggreeTopConstaraint.constant = 0
                            
                        }
                    }
                    if pviduser == 7 || pviduser == 6{
                        
                        if UserDefaults.standard.string(forKey: "BrazilGenotype") == "Genotype"
                        {
                        cell.beefPlaceAnSelectionTitle.alpha = 1
                        cell.beefPlaceSelectionOutlet.alpha = 1
                        cell.addDealerCodeOutlet.alpha = 1
                        cell.addDealerCodeLabel.alpha = 1
                        cell.beefPlaceSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                        cell.beefEmailSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                    }
                    else
                    {
                        let fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: "BeefAnimaladdTbl",orderId:orderId,userId:userId,customerId:currentCustomerId ?? 0,date:"")
                        
                        if fetchAnimalTbl.count == 0 {
                            
                            cell.beefPlaceAnSelectionTitle.alpha = 1
                            cell.beefPlaceSelectionOutlet.alpha = 1
                            
                            if UserDefaults.standard.value(forKey: "beefplaceordercheck") as? Bool == true
                            {
                                
                                cell.beefPlaceSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                                cell.addDealerCodeLabel.alpha = 1
                                cell.addDealerCodeOutlet.alpha = 1
                                
                            }
                            else  if !cell.beefPlaceSelectionOutlet.isSelected
                            {
                                cell.beefPlaceSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                                cell.addDealerCodeLabel.alpha = 0.6
                                cell.addDealerCodeOutlet.alpha = 0.6
                            }
                            if  UserDefaults.standard.value(forKey: "beefemailcheckvalue") as? Bool == true
                            {
                                cell.beefEmailSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                            }
                            else  if !cell.beefEmailSelectionOutlet.isSelected
                            {
                                cell.beefEmailSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                            }
                            
                        } else {
                            cell.beefPlaceAnSelectionTitle.alpha = 0.6
                            cell.beefPlaceSelectionOutlet.alpha = 0.6
                            
                            
                            if UserDefaults.standard.value(forKey: "beefplaceordercheck") as? Bool == true
                            {
                                
                                cell.beefPlaceSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                                cell.addDealerCodeLabel.alpha = 1
                                cell.addDealerCodeOutlet.alpha = 1
                                
                            }
                            else  if !cell.beefPlaceSelectionOutlet.isSelected
                            {
                                cell.beefPlaceSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                                cell.addDealerCodeLabel.alpha = 0.6
                                cell.addDealerCodeOutlet.alpha = 0.6
                            }
                            if  UserDefaults.standard.value(forKey: "beefemailcheckvalue") as? Bool == true
                            {
                                cell.beefEmailSelectionOutlet.setImage(UIImage(named: "check"), for: .normal)
                            }
                            else  if !cell.beefEmailSelectionOutlet.isSelected
                            {
                                cell.beefEmailSelectionOutlet.setImage(UIImage(named: "Uncheck"), for: .normal)
                            }
                            
                            UserDefaults.standard.setValue("emailMe", forKey: "submitTypeSelection")
                            cell.agreeTextHeight.constant = 0
                            cell.pricingTexthEIGHT.constant = 0
                            cell.agreeLl.isHidden = true
                            cell.beefinfoBtnSelectionOutlet.isHidden = true
                            cell.pricingTextView.isHidden = true
                            cell.termsInfoBtnOutlet.isHidden = true
                            cell.beefEmailMeTopSelectionConstraint.constant = 0
                            cell.beefAggreeTopConstaraint.constant = 0
                            
                            
                        }
                    }
                }
            }
            
            cell.beefPlaceAnSelectionTitle.text = "Place an Order".localized
            cell.emailMeSelectionTtile.text = "E-Mail Me Entered Data".localized
            cell.bilingLLbl.text = NSLocalizedString("Billing Contact:", comment: "")
            let pviduser = (UserDefaults.standard.integer(forKey:"BeefPvid") as? Int)!
            if pviduser == 13 && UserDefaults.standard.value(forKey: "name") as? String  == "Beef" {
                cell.submitOrderAction.setTitle("Submit Order to Blockyard".localized, for: .normal)
            }else {
                cell.submitOrderAction.setTitle(NSLocalizedString("Submit", comment: ""), for: .normal)
            }
            
            cell.agreeLl.text = "I agree to the Acceptance and Authorization, Warranty and Indemnification and Data Usage Policies.".localized
            
            cell.billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
            if UserDefaults.standard.value(forKey: "name") as! String  == "Beef"{
                cell.beefsubmitInfoBtn.isHidden = false
            }
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OPSTableViewCell", for: indexPath) as! OPSTableViewCell
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
            cell.vollView.tag = indexPath.row
            cell.deleteBttn.tag = indexPath.row
            cell.farmidHeight.constant = 0
            cell.farmidTitleBottom.constant = 25
            cell.deleteBttn.addTarget(nil, action: #selector(deleteButton(_:)), for: .touchUpInside)
        }
        
        if pvid == 6 {
            cell.farmidHeight.constant = 9
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
            cell.rgdOrAnimalID.text = NSLocalizedString("RGD or Animal ID", comment: "")
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
    
    @objc func deleteButton(_ sender : UIButton){
        // This method is intentionally left empty.
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "1"{
            
            let url =  NSURL(string: pricingLinkC) as! URL
            UIApplication.shared.open(url) { (Bool) in
                
            }
        }
        return true
    }
    
    @IBAction func dropAction(_ sender: UIButton) {
        
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
        if newString != ""{
            
            if pvid == 5 || pvid == 7 || pvid == 13 {
                if self.clickOnDropDown == NSLocalizedString("Ear Tag", comment: "")  || self.clickOnDropDown == NSLocalizedString("Official ID", comment: "") || self.clickOnDropDown == "Animal Tag" || self.clickOnDropDown == "Unique ID".localized{
                    let bPredicate: NSPredicate = NSPredicate(format: "farmId contains[cd] %@ || animalbarCodeTag contains[cd] %@ || animalTag contains[cd] %@ || productName contains[cd] %@", newString,newString,newString,newString)
                    
                    let fetchcustRep = fetchAllDataanimalTagStatus(entityName: "ProductAdonAnimlTbLBeef", asending: true, status: "true", orderStatus: "false",animalTag: newString as String).filtered(using: bPredicate) as NSArray
                    if fetchcustRep.count > 0 {
                        fetchProductAdonAnimalTbl(fethData: fetchcustRep, completion: {})
                    }
                    else{
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
                        arr1.removeAll()
                        reloadTable()
                        self.view.makeToast(NSLocalizedString("No records found.", comment: ""), duration: 1, position: .center)
                    }
                }
            }
        }else{
            self.dropUpDownBtn.setImage(UIImage(named: "Image"), for: .normal)
            
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
            
            if UserDefaults.standard.value(forKey: "name") as! String  == "Beef"{
                return 350
                
            } else {
                return 250
                
            }
        }
        
        var addon = 0
        var data = [String:Any]()
        for result in selection{
            if (result["animalTag"] as! String) == String(values[indexPath.row]){
                data = result
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
        return 40 * CGFloat(count) + 40 + CGFloat(count*20) + CGFloat(addon + 90)
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
            item.lbl.text = arr1[values[collectionView.tag]]![indexPath.row].productName!
            item.layer.masksToBounds = true
            item.layoutIfNeeded()
            item.lbl.layoutIfNeeded()
            item.lbl.layer.masksToBounds = true
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
                    if (value["animalTag"] as! String) == String(values[collectionView.tag]){
                        data = value
                    }
                }
                item.lbl.layer.borderColor = UIColor.lightGray.cgColor
                
                if ((data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).status! == "true"{
                    item.lbl.backgroundColor = UIColor(red: 220/255, green: 54/255, blue: 72/255, alpha: 1)
                    item.lbl.textColor = UIColor.white
                }else{
                    item.lbl.backgroundColor = UIColor.white
                    item.lbl.textColor = UIColor.black
                }
                
                
                item.lbl.text = ((data["addon"] as! NSArray).object(at: indexPath.row - 2) as! SubProductTblBeef).adonName!
                
                return item
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width / 2 ) - 10, height: 40)
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
                            self.showIndicator(self.view, withTitle: "", and: "")
                            
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
                            
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please accept the order terms to proceed.", comment: ""))
                            return
                        }
                        
                        if Connectivity.isConnectedToInternet()
                        {
                            
                            UserDefaults.standard.set(false, forKey: "emailBeef")
                            self.showIndicator(self.view, withTitle: "", and: "")
                            
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
                        
                    }
                    else if UserDefaults.standard.value(forKey: "beefplaceordercheck") as? Bool == false &&
                                UserDefaults.standard.value(forKey: "beefemailcheckvalue") as? Bool == true
                    {
                        updateAnimalOrderEmailStatus(entity: "BeefAnimaladdTbl", IsEmailId: true)
                        updateAnimalOrderEmailStatus(entity: "BeefAnimalMaster", IsEmailId: true)
                        if !UserDefaults.standard.bool(forKey: "checkvalue")
                            
                        {
                            let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Do you want to email entered data?", comment: ""), preferredStyle: .alert)
                            
                            let cancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
                                UIAlertAction in
                                NSLog("Cancel Pressed")
                                
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
                            if Connectivity.isConnectedToInternet()
                            {
                                
                                
                                self.showIndicator(self.view, withTitle: "", and: "")
                                
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
                    else
                    {
                        
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please select at least one checkbox to submit.", comment: ""))
                        return
                    }
                }
                
            }
        }
    }
    
    
    @IBAction func toggleBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
        
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
            if let cell = self.tblView.cellForRow(at: IndexPath(row: self.arr1.keys.count, section: 0) ) as? BillingCell{
                let filterArr = self.farmAddr.filter({$0.isDefault == true })
                if filterArr.count > 0{
                    updateBillingCustomer(entity: "GetBillingContact", customerID: self.custmerId, isDefault: false, billcustomerId: filterArr[0].billToCustId ?? "0", billcustomerName: filterArr[0].contactName ?? "")
                    
                }
                UserDefaults.standard.set(SelectedBillingCustomer.contactName, forKey: "farmValue")
                UserDefaults.standard.set(SelectedBillingCustomer.billToCustId, forKey: "billToCustomerId")
                
                updateBillingCustomer(entity: "GetBillingContact", customerID: self.custmerId, isDefault: true, billcustomerId: SelectedBillingCustomer.billToCustId ?? "0", billcustomerName: SelectedBillingCustomer.contactName ?? "")
                
                self.farmAddr = fetchBillingCustomer(entityName: "GetBillingContact",customerID: self.custmerId) as! [GetBillingContact]
                
                let attributeString = NSMutableAttributedString(string: SelectedBillingCustomer.contactName ?? "", attributes: self.attrs)
                cell.billingBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                
            }
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
            self.transparentView.isHidden = true
            self.billingView.isHidden = true
        }
    }
    @IBAction func editBtnActon(_ sender: Any) {
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
extension BeefOrderProductSelectionReviewVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
}

extension BeefOrderProductSelectionReviewVC : SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}
