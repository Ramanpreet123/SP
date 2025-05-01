//
//  BeefViewAnimalVCiPad.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 26/01/25.
//

import Foundation
import Alamofire

//MARK: CLASS
class BeefViewAnimalVCiPad: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var noOrderLbl: UILabel!
    @IBOutlet weak var cartBttnOutlet: UIButton!
    @IBOutlet weak var appStatusLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var networkImgStatus: UIImageView!
    @IBOutlet weak var notificationLblCount: UILabel!
    @IBOutlet weak var cartTitle: UILabel!
    @IBOutlet weak var APPsTATUSlbl: UILabel!
    @IBOutlet weak var noAnimalToast: UILabel!
    @IBOutlet weak var clearOrderOutlet: UIButton!
    @IBOutlet weak var offlineBtnOutlet: UIButton!
    @IBOutlet weak var emailOrderOutlet: UIButton!
    @IBOutlet weak var bckBtnOutlet: UIButton!
    @IBOutlet weak var continuetoOrderOutlet: UIButton!
    @IBOutlet weak var appHelpBtn: UIButton!
    
    //MARK: VARIABLES AND CONSTANTS
    var fetchDataEntry : [DataEntryList] = []
    var listName = String()
    let orderingDatalistVM = OrderingDataListViewModel()
    var objApiSync = ApiSyncList()
    let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
    let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
    let custmerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
    let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    var delegateCustom : objectPickCartScreen?
    var screenBackSave = Bool()
    var productBackSave = Bool()
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    var viewAnimalArray = NSArray()
    var chekvale = String()
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIOnDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUIOnWillAppear()
    }
    
    //MARK: INITIAL UI METHODS
    func setUIOnDidLoad(){
//        if pvid == 13 {
//          appHelpBtn.isHidden = false
//        } else {
//          appHelpBtn.isHidden = true
//        }
       // emailOrderOutlet.setTitle("Email Cart".localized, for: .normal)
        self.navigationController?.navigationBar.isHidden = true
        UserDefaults.standard.setValue(nil, forKey: keyValue.submitTypeSelection.rawValue)
      //  clearOrderOutlet.setTitle("Clear Cart".localized, for: .normal)
      //  noAnimalToast.text = LocalizedStrings.noAnimalAdded.localized
        cartTitle.text = "Cart".localized
     //   clearOrderOutlet.setTitle("Clear Cart".localized, for: .normal)
      //  APPsTATUSlbl.text = NSLocalizedString(ButtonTitles.appStatusText, comment: "")
     //   continuetoOrderOutlet.setTitle(ButtonTitles.continueProdSelection.localized, for: .normal)
        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
    }
    
    func setUIOnWillAppear(){
        initialNetworkCheck()
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        self.viewAnimalArray =  beefFetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", pvid: pvid)
        notificationLblCount.text = String(viewAnimalArray.count)
        self.getListName()
    }
    
    //MARK: SELECTORS AND FUNCTIONS
    @objc func buttonbgPressed (){
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
    @objc func checkForReachability(notification:Notification){
        let del = UIApplication.shared.delegate as? AppDelegate
        self.appStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if appStatusLbl?.text == ButtonTitles.connectedText.localized{
            self.offlineBtnOutlet.isUserInteractionEnabled = false
            networkImgStatus.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else {
            self.offlineBtnOutlet.isUserInteractionEnabled = true
            networkImgStatus.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    func initialNetworkCheck(){
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del = UIApplication.shared.delegate as? AppDelegate
        self.appStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if appStatusLbl?.text == ButtonTitles.connectedText.localized{
            self.offlineBtnOutlet.isUserInteractionEnabled = false
            networkImgStatus.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else {
            networkImgStatus.image = UIImage(named: ImageNames.statusOfflineImg)
            self.offlineBtnOutlet.isUserInteractionEnabled = true
        }
    }
    
    func showAlertformissingBarcodeAnimal(animalCount: Int , msgString: String){
      let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message:  msgString.localized(with: animalCount), preferredStyle: .alert)
      
      let ok = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { action in })
      alert.addAction(ok)
      DispatchQueue.main.async(execute: {
        self.present(alert, animated: true)
      })
    }
    
    //MARK: IB ACTION METHODS
    @IBAction func emailOrder(_ sender: UIButton) {
        UserDefaults.standard.setValue("", forKey: keyValue.dealerCode.rawValue)
        UserDefaults.standard.setValue(true, forKey: keyValue.addDealerCodeCheck.rawValue)
        self.objApiSync.delegeteSyncApi = self
        if fetchDataEntry.count > 0 {
            showIndicator(self.view, withTitle: NSLocalizedString(LocalizedStrings.syncInProgress, comment: ""), and: "")
            self.objApiSync.postListDataBeef(listId:Int64(fetchDataEntry[0].listId),custmerId:Int64(custmerId ?? 0),list_Name: listName)
            
        }
    }
    
    @IBAction func backBtnClk(_ sender: UIButton) {
    
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
        
    }
    
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
        vc?.module = LocalizedStrings.addOrderingAnimalsTextBeef.localized
      vc?.modalPresentationStyle = .overFullScreen
      self.present(vc!, animated: false, completion: nil)
    }
    
    @IBAction func continueBtnAction(_ sender: UIButton){
        
        UserDefaults.standard.setValue("", forKey: keyValue.dealerCode.rawValue)
        UserDefaults.standard.setValue(true, forKey: keyValue.addDealerCodeCheck.rawValue)
        let dataListAnimals : [BeefAnimaladdTbl] = viewAnimalArray as! [BeefAnimaladdTbl]
        switch pvid {
        case 5:
          let eartagAnimals = dataListAnimals.filter({ $0.animalTag == "" || $0.animalTag == nil })
          if eartagAnimals.count > 0{
            showAlertformissingBarcodeAnimal(animalCount: eartagAnimals.count, msgString: AlertMessagesStrings.animalsDoNotHaveEarTag)
            return
          }
          let animals = dataListAnimals.filter({ $0.animalbarCodeTag == "" || $0.animalbarCodeTag == nil })
          if animals.count > 0 {
              showAlertformissingBarcodeAnimal(animalCount: animals.count, msgString: AlertMessagesStrings.pleaseReviewTheCart)
            
          } else {
              let storyboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: Bundle.main)
          
              self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefOPSiPadVC")), animated: true)
          }
        case 6:
          let animals = dataListAnimals.filter({ $0.animalTag == "" ||  $0.animalTag == nil })
          if animals.count > 0 {
            showAlertformissingBarcodeAnimal(animalCount: animals.count, msgString: AlertMessagesStrings.pleaseReviewTheCart)
          } else {
              let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
            if identyCheck == false || identyCheck == nil {
                let storyboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: Bundle.main)
            
              if  UserDefaults.standard.value(forKey: keyValue.page.rawValue) == nil {
                  self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefOPSiPadVC")), animated: true)
                
              }
              else{
                  self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefOPSSecondVCIpad")), animated: true)
              }
            } else {
                let storyboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: Bundle.main)
             
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefOPSSecondVCIpad")), animated: true)
            }
           // self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefOrderingProductSelectionVC)), animated: true)
          }
        case 13:
          let animals = dataListAnimals.filter({ $0.animalTag?.count ?? 0 < 15 ||  $0.animalTag?.count ?? 0 > 16 })
          if animals.count > 0 {
              showAlertformissingBarcodeAnimal(animalCount: animals.count, msgString: AlertMessagesStrings.animalsDoNotHaveValidUniqueId)
          } else {
              let storyboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: Bundle.main)
           
              self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefOPSSecondVCIpad")), animated: true)
          }
          
        default:
            let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
          if identyCheck == false || identyCheck == nil {
              let storyboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: Bundle.main)
           
            if  UserDefaults.standard.value(forKey: keyValue.page.rawValue) == nil {
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefOPSSecondVCIpad")), animated: true)
              
            }
            else{
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefOPSSecondVCIpad")), animated: true)
            }
          } else {
              let storyboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: Bundle.main)
      
              self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefOPSSecondVCIpad")), animated: true)
          }
        }
    }
    
    @IBAction func offlineBtnAction(_ sender: UIButton) {
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(OrderSaveVCiPad.buttonbgPressed), for: .touchUpInside)
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
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        if viewAnimalArray.count == 0 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC) as! DashboardVC
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        else if screenBackSave == true {
            let storyBoard: UIStoryboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "BeefOPSSelectionReviewIPadVC") as! BeefOPSSelectionReviewIPadVC
            self.navigationController?.pushViewController(newViewController, animated: false)
        }
        else if productBackSave ==  true {
            let storyBoard: UIStoryboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "BeefOPSSecondVCIpad") as! BeefOPSSecondVCIpad
            self.navigationController?.pushViewController(newViewController, animated: false)
        }
        else {
            self.delegateCustom?.anOptionalMethod?(check: true)
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    @IBAction func clearOrder(_ sender: UIButton) {
        UserDefaults.standard.setValue("", forKey: keyValue.dealerCode.rawValue)
        UserDefaults.standard.setValue(true, forKey: keyValue.addDealerCodeCheck.rawValue)
        let refreshAlert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.clearAllOrders, comment: ""), preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
            
        }))
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
            self.view.makeToast(NSLocalizedString(LocalizedStrings.orderCleared, comment: ""), duration: 10, position: .center)
            self.createListNameAndCheckifExist()
            deleteDataProduct(entityName:Entities.beefAnimalAddTblEntity,status:"false")
            deleteDataProduct(entityName:Entities.productAdonAnimlBeefTblEntity,status:"false")
            deleteDataProduct(entityName:Entities.subProductBeefTblEntity, status: "false")
            UserDefaults.standard.removeObject(forKey: keyValue.identifyStore.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.productCount.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.onKey.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.page.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.beefBreed.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.beefTSU.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.tissueBttn.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.beefbreedClear.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.inheritBeefbreedClear.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.beefInheritTsuClear.rawValue)
            UserDefaults.standard.setValue(nil, forKey: keyValue.beefbreedClear.rawValue)
            UserDefaults.standard.setValue(nil, forKey: keyValue.beeftsuClear.rawValue)
            UserDefaults.standard.set("", forKey: keyValue.nzBeeftsuClear.rawValue)
            UserDefaults.standard.set("", forKey: keyValue.tissueBttnClear.rawValue)
            UserDefaults.standard.set("", forKey: keyValue.genotypeTissueBttnClear.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
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
            UserDefaults.standard.set(nil, forKey: keyValue.genotypeTissueBttn.rawValue)
            UserDefaults.standard.set(true, forKey: keyValue.showbeefInheritTable.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.inheritBeefbreed.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.beefInheritTSU.rawValue)
            updateProductTablStatus(entity: Entities.getAdonTblEntity)
            UserDefaults.standard.removeObject(forKey: keyValue.pidKey.rawValue)
            UserDefaults.standard.set(true, forKey: keyValue.showBeefProductTbl.rawValue)
            UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
            self.collectionView.isHidden = true
            self.notificationLblCount.text = "0"
            UserDefaults.standard.set("", forKey: keyValue.nzBeefTSU.rawValue)
            UserDefaults.standard.set("", forKey: keyValue.genotypeTissueBttn.rawValue)
            UserDefaults.standard.set("", forKey: keyValue.emailFlag.rawValue)
            UserDefaults.standard.set("", forKey: keyValue.submitFlag.rawValue)
            UserDefaults.standard.set(false, forKey: keyValue.beefBVDVSeleted.rawValue)
            UserDefaults.standard.set(true, forKey: keyValue.showBeefProductTbl.rawValue)
            deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
            deleteRecordFromDatabase(entityName: Entities.productAdonAnimlBeefTblEntity)
            deleteRecordFromDatabase(entityName: Entities.subProductBeefTblEntity)
            deleteRecordFromDatabase(entityName: Entities.selectedQuesTblEntity)
            UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                self.sideMenuViewController?.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
            }
        }))
       
        present(refreshAlert, animated: true, completion: nil)
    }
}

//MARK: OFFLINE CUSTOM VIEW EXTENSION
extension BeefViewAnimalVCiPad : offlineCustomView {
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}
