//
//  OrderSaveViewController.swift
//  SearchPoint
//
//  Created by "" on 12/12/19.
//

import UIKit

//MARK: ORDER SAVE VIEW CONTROLLER
class OrderSaveViewController: UIViewController {
    
    //MARK: IB OUTLETS
    @IBOutlet weak var networkStatusImg: UIImageView!
    @IBOutlet weak var offLineBtn: UIButton!
    @IBOutlet weak var connectedLbl: UILabel!
    @IBOutlet weak var centreConst: NSLayoutConstraint!
    @IBOutlet weak var emailSaveView: UIView!
    @IBOutlet weak var orderSaveScreenTitle: UILabel!
    @IBOutlet weak var oflineView: UIView!
    @IBOutlet weak var emailInfoLbl: UILabel!
    
    //MARK: VARIABLES AND CONSTANTS
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    var heartBeatViewModel:HeartBeatViewModel?
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    var orderId = Int()
    var userId = Int()
    var value = 0

    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        heartBeatViewModel?.callGetHearBeatData()
        UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlag.rawValue)
        UserDefaults.standard.set(nil, forKey: keyValue.tsuKey.rawValue)
        UserDefaults.standard.removeObject(forKey: keyValue.capsBreedName.rawValue)
        UserDefaults.standard.set(true, forKey: keyValue.syncOff.rawValue)
        userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        UserDefaults.standard.set("False", forKey: keyValue.isAuSelected.rawValue)
        UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
        UserDefaults.standard.set("", forKey: keyValue.emailFlag.rawValue)
        UserDefaults.standard.set("", forKey: keyValue.submitFlag.rawValue)
        UserDefaults.standard.set(false, forKey: keyValue.bvdvSelected.rawValue)
        UserDefaults.standard.set(false, forKey: keyValue.beefBVDVSeleted.rawValue)
        emailInfoLbl.text = NSLocalizedString(LocalizedStrings.receiveDataInEmail, comment: "")
        
        if UserDefaults.standard.value(forKey: "name") as? String  == marketNameType.Dairy.rawValue{
            if let submitBtnFlag = UserDefaults.standard.value(forKey: keyValue.submitBtnFlag.rawValue) as? Bool {
                if submitBtnFlag == false {
                    emailSaveView.isHidden = true
                } else {
                    orderSaveScreenTitle.text = keyValue.emailOrder.rawValue.localized
                }
            } else {
                orderSaveScreenTitle.text = keyValue.emailOrder.rawValue.localized
            }
        }
        else  {
            if let submitBtnFlag = UserDefaults.standard.value(forKey: keyValue.emailBeef.rawValue) as? Bool {
                if submitBtnFlag == false {
                    emailSaveView.isHidden = true
                } else {
                    orderSaveScreenTitle.text = keyValue.emailOrder.rawValue.localized
                }
                
            } else {
                orderSaveScreenTitle.text = keyValue.emailOrder.rawValue.localized
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
                centreConst.constant = -16
            case 1334:
                centreConst.constant = -16
            case 1920, 2208:
                centreConst.constant = -8
            case 2436:
                centreConst.constant = -16
            case 2688,2796:
                centreConst.constant = -16
            case 1792:
                centreConst.constant = -16
            default:
                centreConst.constant = -16
            }
        }
        initialNetworkCheck()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.string(forKey: keyValue.name.rawValue) == marketNameType.Beef.rawValue{
            BeefresetGenertaeNewOrderId()
            saveOffLineOrderId(entity: Entities.offlineOrderBeefTblEntity,orderId: orderId,status: "false", isemail: "")
        }
        else {
            resetGenertaeNewOrderId()
            if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) == true {
                saveOffLineOrderId(entity: Entities.offlineOrderTblEntity,orderId: orderId,status: "false",isemail: "true")
                UserDefaults.standard.set(true, forKey: keyValue.dairySubmitBtnFlag.rawValue)
            }
            else{
                saveOffLineOrderId(entity: Entities.offlineOrderTblEntity,orderId: orderId,status: "false", isemail: "")
                UserDefaults.standard.set(false, forKey: keyValue.dairySubmitBtnFlag.rawValue)
                
            }
            UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlag.rawValue)
            UserDefaults.standard.set(false, forKey: keyValue.submitBtnFlagNew.rawValue)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(Notification.Name(keyValue.notificationIdentifier.rawValue))
    }
    
    //MARK: METHODS AND FUNCTIONS
    func initialNetworkCheck(){
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del = UIApplication.shared.delegate as? AppDelegate
        self.connectedLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if connectedLbl?.text == ButtonTitles.connectedText.localized{
            self.offLineBtn.isUserInteractionEnabled = false
            networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else {
            networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
            self.offLineBtn.isUserInteractionEnabled = true
        }
    }
    
    func BeefresetGenertaeNewOrderId(){
        let animaltbl = fetchAllDataOrderStatusIsSync(entityName: Entities.beefAnimalAddTblEntity, isSync: "false",ordestatus: "false", status: "true", orderId: orderId, userId: userId)
        for i in 0..<animaltbl.count{
            let animadata = animaltbl[i] as! BeefAnimaladdTbl
            updateOrderStatusISyncAnimalOFFline(entity: Entities.beefAnimalAddTblEntity, isSync: "false", status: "true", orderstatus: "false")
            updateOrderStatusISyncAnimalOFFlineMaster(entity: Entities.beefAnimalMasterTblEntity, isSync: "false", status: "false", orderstatus: "false",aid:Int(animadata.animalId))
            updateOrderStatusISyncProductOFFLine(entity: Entities.productAdonAnimlBeefTblEntity, isSync: "false", animalTag:Int(animadata.animalId), orderstatus: "false")
            updateOrderStatusISyncProductOFFLine(entity: Entities.subProductBeefTblEntity, isSync: "false", animalTag:Int(animadata.animalId), orderstatus: "false")
        }
        
        UserDefaults.standard.set(false, forKey: keyValue.autoIdBeef.rawValue)
        updateProductTablStatus(entity: Entities.getProductBeefTblEntity)
        updateProductTablStatus(entity: Entities.getAdonTblEntity)
        deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
        UserDefaults.standard.set(nil, forKey: keyValue.onKey.rawValue)
        UserDefaults.standard.set(nil, forKey: keyValue.pdId.rawValue)
        UserDefaults.standard.set(nil, forKey: keyValue.page.rawValue)
        UserDefaults.standard.set("", forKey: keyValue.productName.rawValue)
        UserDefaults.standard.removeObject(forKey: keyValue.review.rawValue)
        UserDefaults.standard.set(true, forKey: keyValue.showBeefProductTbl.rawValue)
        UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
    }
    
    func resetGenertaeNewOrderId(){
        let animaltbl = fetchAllDataOrderStatusIsSync(entityName: Entities.animalAddTblEntity, isSync: "false",ordestatus: "false", status: "true", orderId: orderId, userId: userId)
        for i in 0..<animaltbl.count{
            let animadata = animaltbl[i] as! AnimaladdTbl
            updateOrderStatusISyncAnimalOFFline(entity: Entities.animalAddTblEntity, isSync: "false", status: "true", orderstatus: "false")
            updateOrderStatusISyncAnimalOFFlineMaster(entity: Entities.animalMasterTblEntity, isSync: "false", status: "false", orderstatus: "false",aid:Int(animadata.animalId))
            let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
            if providerName == keyValue.auDairyProducts.rawValue{
                updateOrderStatusISyncProductclarifdeAU(entity: Entities.productAdonAnimalTblEntity, isSync: "false", animalTag:Int(animadata.animalId), orderstatus: "false",orderId: orderId,userId: userId,productName:LocalizedStrings.clarifideDataGene, productName1: LocalizedStrings.clarifideCDCB, productName2: LocalizedStrings.providerClarifidePlus, status: "true")
            }
            else if providerName == keyValue.clarifideAHDBUK.rawValue {
                updateOrderStatusISyncProductclarifdeUK(entity: Entities.productAdonAnimalTblEntity, isSync: "false", animalTag:Int(animadata.animalId), orderstatus: "false",orderId: orderId,userId: userId,productName:LocalizedStrings.clarifideAHDB, productName1: LocalizedStrings.clarifideCDCB, productName2: LocalizedStrings.providerClarifidePlus, status: "true")
            }
            else {
                updateOrderStatusISyncProductclarifde(entity: Entities.productAdonAnimalTblEntity, isSync: "false", animalTag:Int(animadata.animalId), orderstatus: "false",orderId: orderId,userId: userId,productName:LocalizedStrings.providerClarifide,status: "true")
            }
            updateOrderStatusISyncProductOFFLine(entity: Entities.productAdonAnimalTblEntity, isSync: "false", animalTag:Int(animadata.animalId), orderstatus: "false")
            updateOrderStatusISyncProductOFFLine(entity: Entities.subProductTblEntity, isSync: "false", animalTag:Int(animadata.animalId), orderstatus: "false")
        }
        UserDefaults.standard.set(false, forKey: keyValue.autoId.rawValue)
        updateProductTablStatus(entity: Entities.getProductTblEntity)
        updateProductTablStatus(entity: Entities.getAdonTblEntity)
        UserDefaults.standard.set(nil, forKey: keyValue.onKey.rawValue)
        UserDefaults.standard.set(nil, forKey: keyValue.pdId.rawValue)
        UserDefaults.standard.set(nil, forKey: keyValue.page.rawValue)
        UserDefaults.standard.set("", forKey: keyValue.productName.rawValue)
        UserDefaults.standard.removeObject(forKey: keyValue.review.rawValue)
        UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
    }
    
    //MARK: OBJC SELECTOR METHODS
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
    
    @objc func buttonbgPressed (){
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
    @objc func checkForReachability(notification:Notification){
        let del = UIApplication.shared.delegate as? AppDelegate
        self.connectedLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if connectedLbl?.text == ButtonTitles.connectedText.localized{
            self.offLineBtn.isUserInteractionEnabled = false
            networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
        } else {
            self.offLineBtn.isUserInteractionEnabled = true
            networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }

    //MARK: IB ACTIONS
    @IBAction func backBtnClk(_ sender: UIButton) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func offlineBtnAction(_ sender: UIButton) {
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(OrderSaveViewController.buttonbgPressed), for: .touchUpInside)
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
    
    @IBAction func leftMenuBtnClick(_ sender: Any) {
        self.sideMenuViewController?.presentRightMenuViewController()
        self.view.makeCorner(withRadius: 40)
    }
    
    @IBAction func acknowledgeAction(_ sender: UIButton) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func emailScreenAcknowledgrBtn(_ sender: UIButton) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
}

//MARK: SIDE MENU UI EXTENSION
extension OrderSaveViewController : SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}

//MARK: OFFLINE CUSTOM VIEW EXTENSION
extension OrderSaveViewController : offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

