//
//  ViewAnimalsControlleriPadVC.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 25/01/25.
//

import Foundation
import Alamofire

//MARK: CLASS
class ViewAnimalsControlleriPadVC: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var deleteIcon: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var noOrderLbl: UILabel!
    @IBOutlet weak var cartBttnOutlet: UIButton!
    @IBOutlet weak var appStatusLbl: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var networkImgStatus: UIImageView!
    @IBOutlet weak var notificationLblCount: UILabel!
    @IBOutlet weak var appStatusTtile: UILabel!
    @IBOutlet weak var cartLbl: UILabel!
    @IBOutlet weak var noAnimalToast: UILabel!
    @IBOutlet weak var clearOrderOutlet: UIButton!
    @IBOutlet weak var emailOrderOutlet: UIButton!
    @IBOutlet weak var continuetoOrderOutlet: UIButton!
    @IBOutlet weak var offlineBtnOutlet: UIButton!
    @IBOutlet weak var bckBtnOutlet: UIButton!
    
    //MARK: VARIABLES AND CONSTANTS
    let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
    var viewAnimalArray = NSArray()
    var fetchDataEntry : [DataEntryList] = []
    var listName = String()
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    var delegateCustom : objectPickCartScreen?
    var screenBackSave = Bool()
    var productBackSave = Bool()
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    var objApiSync = ApiSyncList()
    let orderingDatalistVM = OrderingDataListViewModel()
    let userID = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
    var heartBeatViewModel:HeartBeatViewModel?
    var custmerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
    var value = 0
    var collectionViewIndexPath = IndexPath(row: 0, section: 0)
    
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
    
    //MARK: INITIAL UI AND OTHER METHODS
    func setUIOnDidLoad(){
        heartBeatViewModel?.callGetHearBeatData()
        UserDefaults.standard.set(nil, forKey: keyValue.submitTypeSelection.rawValue)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.backItem?.title = ""
        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
        cartLbl.text = NSLocalizedString("Cart", comment: "")
    }
    
    func setUIOnWillAppear(){
        cartLbl.text = NSLocalizedString("Cart", comment: "")
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        initialNetworkCheck()
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        viewAnimalArray =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pviduser)
        notificationLblCount.text = String(viewAnimalArray.count)
        self.getListName()
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
         
        }
        else {
            for i in 0 ..< data1.count{
                let breeid1 = data1.object(at: i) as! AnimaladdTbl
                
                if bredidd123 == breeid1.breedName {
                    UserDefaults.standard.set(false, forKey: keyValue.identifyStore.rawValue)
                    UserDefaults.standard.set(breeid1.breedId, forKey: keyValue.breed.rawValue)
                }
                else{
                    UserDefaults.standard.set(true, forKey: keyValue.identifyStore.rawValue)
                    break
                }
                bredidd123 = breeid1.breedName ?? ""
            }
        }
    }
    
    //MARK: OBJC SELECTOR METHODS METHODS
    @objc func methodOfReceivedNotification(notification: Notification){
        if value == 0 {
            UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
            let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
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
    
    @objc  func checkForReachability(notification:Notification){
        let del = UIApplication.shared.delegate as? AppDelegate
        self.appStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if appStatusLbl?.text == ButtonTitles.connectedText.localized{
            self.offlineBtnOutlet.isUserInteractionEnabled = false
            networkImgStatus.image = UIImage(named: ImageNames.statusOnlineSign)
        } else {
            self.offlineBtnOutlet.isUserInteractionEnabled = true
            networkImgStatus.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    //MARK: IB ACTIONS METHODS
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
        vc?.module = LocalizedStrings.addOrderingAnimalsText.localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
    }
    
    @IBAction func backBtnClk(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
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
        validateBreed()
        if viewAnimalArray.count == 0 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC) as! DashboardVC
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        else if screenBackSave {
            let storyBoard: UIStoryboard = UIStoryboard(name: "DairyPlaceAnOrder", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "OPSReviewVCIpad") as! OPSReviewVCIpad
            self.navigationController?.pushViewController(newViewController, animated: false)
        }
        else if productBackSave ==  true {
            let storyBoard: UIStoryboard = UIStoryboard(name: "DairyPlaceAnOrder", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "OPSSecondVCiPad") as! OPSSecondVCiPad
            self.navigationController?.pushViewController(newViewController, animated: false)
        }
        else {
            self.delegateCustom?.anOptionalMethod?(check: true)
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    @IBAction func emailOrder(_ sender: UIButton) {
        self.objApiSync.delegeteSyncApi = self
        if fetchDataEntry.count > 0 {
            showIndicator(self.view, withTitle: NSLocalizedString(LocalizedStrings.syncInProgress, comment: ""), and: "")
            self.objApiSync.postListData(listId:Int64(fetchDataEntry[0].listId),custmerId:Int64(custmerId ?? 0))
        }
    }
    
    @IBAction func continueBtnAction(_ sender: UIButton){
        
        let dataListAnimals : [AnimaladdTbl] = viewAnimalArray as! [AnimaladdTbl]
        let animals = dataListAnimals.filter({ $0.animalbarCodeTag == "" || $0.animalbarCodeTag == nil })
        
        if animals.count > 0 {
            let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message: AlertMessagesStrings.pleaseReviewTheCart.localized(with: animals.count), preferredStyle: .alert)
            
            let ok = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { action in
                
            })
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        } else if dataListAnimals.count == 1 {
            let storyboard = UIStoryboard(name: "DairyPlaceAnOrder", bundle: Bundle.main)
            
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "OPSelectioniPadVC")), animated: true)
        }
        else {
            let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
            if identyCheck == false || identyCheck == nil {
                let storyboard = UIStoryboard(name: "DairyPlaceAnOrder", bundle: Bundle.main)
                
                if  UserDefaults.standard.value(forKey: keyValue.page.rawValue) == nil {
                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "OPSelectioniPadVC")), animated: true)
                } else {
                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "OPSSecondVCiPad")), animated: true)
                }
            } else {
                let storyboard = UIStoryboard(name: "DairyPlaceAnOrder", bundle: Bundle.main)
                
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "OPSSecondVCiPad")), animated: true)
            }
        }
    }
    
    @IBAction func clearOrder(_ sender: UIButton) {
        let refreshAlert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.clearAllOrders, comment: ""), preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
            
            self.view.makeToast(NSLocalizedString(LocalizedStrings.orderCleared, comment: ""), duration: 10, position: .center)
            for animalVal in self.viewAnimalArray {
                updateAdhAnimalDataforCart(entity: Entities.animalMasterTblEntity, officialID: (animalVal as AnyObject).animalTag ?? "", barCode: (animalVal as AnyObject).animalbarCodeTag ?? "", isADHCart: false)
            }
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
            UserDefaults.standard.removeObject(forKey: keyValue.pidKey.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.girlandoSampleType.rawValue)
            UserDefaults.standard.setValue(nil, forKey: keyValue.dataEntryListName.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.tsuClear.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.submitTypeSelection.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.showbeefInheritTable.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.girlandoSampleTypeClear.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.breedNameClear.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.capsBreedName.rawValue)
            UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlag.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.tsuKey.rawValue)
            UserDefaults.standard.set("False", forKey: keyValue.isAuSelected.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.bvdvValidation.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.capsBreedName.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.submitBtnFlag.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.isAgreeForSubmit.rawValue)
            UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
            UserDefaults.standard.set(false, forKey: keyValue.bvdvSelected.rawValue)
            UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
            UserDefaults.standard.set("", forKey: keyValue.emailFlag.rawValue)
            UserDefaults.standard.set("", forKey: keyValue.submitFlag.rawValue)
            UserDefaults.standard.set(nil, forKey: "USDairyGender")
            UserDefaults.standard.set(nil, forKey: "GirlandoGender")
            UserDefaults.standard.set(nil, forKey: "DEUSDairyGender")
            UserDefaults.standard.set(nil, forKey: "DEGirlandoGender")
            self.notificationLblCount.text = "0"
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                self.sideMenuViewController?.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
            }
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
}

//MARK: COLLECTIONVIEW DATASOURCE AND DELEGATES
extension ViewAnimalsControlleriPadVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewAnimalArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let animalVal =  viewAnimalArray[indexPath.row] as! AnimaladdTbl
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
        
        switch pviduser {
        case 4 :
            let cell : ViewAnimalCelliPad = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! ViewAnimalCelliPad
            cell.officialIdLbl.text = animalVal.animalbarCodeTag
            cell.farmIDLbl.text = animalVal.earTag
            cell.onFarmIdTitle.text = NSLocalizedString(ButtonTitles.earTagText, comment: "")
            cell.officalIdTitle.text = ButtonTitles.barcodeText.localized
            cell.barcodeTtileLbl.text = NSLocalizedString(ButtonTitles.sexTest, comment: "")
            cell.barcodeSeperator.isHidden = false
            if animalVal.gender == "F" {
                animalVal.gender = ButtonTitles.femaleText
            } else if animalVal.gender == "M" {
                animalVal.gender = ButtonTitles.maleText
            }
            if animalVal.gender == NSLocalizedString(ButtonTitles.femaleText, comment: "") {
                cell.barcodeLbl.text = "F"
            }else {
                cell.barcodeLbl.text = "M"
            }
            
            cell.rgdTitleLabel.text = NSLocalizedString("DOB", comment: "")
            if animalVal.date == "" {
                cell.rgdLbl.text = "NA"
            }
            else{
                cell.rgdLbl.text = animalVal.date
            }
            
            cell.rgdLbl.isHidden = false
            cell.rgdTitleLabel.isHidden = false
            cell.barcodeLbl.isHidden = false
            cell.barcodeLbl.isHidden = false
            cell.barcodeTtileLbl.isHidden = false
            cell.onFarmIdTitle.text = NSLocalizedString(ButtonTitles.earTagText, comment: "")
            cell.officalIdTitle.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
            cell.barcodeTtileLbl.text = NSLocalizedString("Sex", comment: "")
            
            if animalVal.animalbarCodeTag == "" || animalVal.animalbarCodeTag == nil {
                cell.innnerView.layer.borderColor = UIColor.red.cgColor
            }else  {
                cell.innnerView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
            }
            
            cell.deleteAction = { [unowned self] ( error) in
                self.collectionViewIndexPath = indexPath
                let refreshAlert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(LocalizedStrings.removeAnimalFromOrder, comment: ""), preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                refreshAlert.addAction(UIAlertAction(title:NSLocalizedString("Yes", comment: "") , style: .default, handler: { (action: UIAlertAction!) in
                    
                    let animalVal  =  self.viewAnimalArray[indexPath.row] as! AnimaladdTbl
                    self.deleteSigalAnimalFromList(index: indexPath.row)
                    updateAdhAnimalDataforCart(entity: Entities.animalMasterTblEntity, officialID: animalVal.animalTag ?? "", barCode: animalVal.animalbarCodeTag ?? "", isADHCart: false)
                    deleteDataWithProduct(Int(animalVal.animalId))
                    deleteDataWithSubProduct(Int(animalVal.animalId))
                    deleteDataWithAnimal(Int(animalVal.animalId))
                    let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                    let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
                    updateProductTablDataaid(entity: Entities.getProductTblEntity, status: "false")
                    let fethData =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId, farmId:"")
                    for pName in fethData as? [ProductAdonAnimalTbl] ?? [] {
                        updateProductTablaid(entity:Entities.getProductTblEntity,productId:
                                                Int(pName.productId),status: "true")
                    }
                    
                    self.viewAnimalArray =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pviduser)
                    self.notificationLblCount.text = String(self.viewAnimalArray.count)
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.removedAnimalSuccessfully, comment: ""), duration: 1, position: .bottom)
                    if self.viewAnimalArray.count == 0 {
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
                        if self.pviduser == 4 {
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
                            
                            let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
                        }
                        self.cartBttnOutlet.isHidden = true
                        self.notificationLblCount.isHidden = true
                        self.clearOrderOutlet.isHidden = true
                        self.emailOrderOutlet.isHidden = true
                        UserDefaults.standard.set(nil, forKey: "USDairyGender")
                        UserDefaults.standard.set(nil, forKey: "GirlandoGender")
                        UserDefaults.standard.set(nil, forKey: "DEUSDairyGender")
                        UserDefaults.standard.set(nil, forKey: "DEGirlandoGender")
                    }
                    else {
                        self.emailOrderOutlet.isHidden = false
                        self.cartBttnOutlet.isHidden = false
                        self.notificationLblCount.isHidden = false
                        self.clearOrderOutlet.isHidden = false
                    }
                    collectionView.reloadData()
                    
                }))
                present(refreshAlert, animated: true, completion: nil)
            }
            
            return cell
        case 8:
            let cell : ViewAnimalCelliPad = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cartcell", for: indexPath as IndexPath) as! ViewAnimalCelliPad
            cell.dobTtileLbl.isHidden = false
            cell.dobTitle.isHidden = false
            cell.sexTitle.isHidden = false
            cell.sexTitleLbl.isHidden = false
            cell.officialIdLbl.text = animalVal.animalTag
            cell.farmIDLbl.text = animalVal.farmId
            cell.barcodeLbl.text = animalVal.animalbarCodeTag
            cell.dobTtileLbl.text  = NSLocalizedString("DOB", comment: "")
            cell.dobTitle.text = animalVal.date != "" ? animalVal.date : NSLocalizedString("N/A", comment: "")
            cell.sexTitleLbl.text = NSLocalizedString(ButtonTitles.sexTest, comment: "")
            if animalVal.gender == "F" {
                animalVal.gender = ButtonTitles.femaleText
            } else if animalVal.gender == "M" {
                animalVal.gender = ButtonTitles.maleText
            }
            if animalVal.gender == NSLocalizedString(ButtonTitles.femaleText, comment: "")  ||  animalVal.gender == ButtonTitles.femaleText   {
                cell.sexTitle.text =  "F"
            } else {
                cell.sexTitle.text =  "M"
            }
            cell.barcodeLbl.isHidden = false
            cell.onFarmIdTitle.isHidden = false
            cell.onFarmIdTitle.text = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
            cell.officalIdTitle.text = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
            cell.barcodetitle.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
            
            if animalVal.animalbarCodeTag == "" || animalVal.animalbarCodeTag == nil {
                cell.innnerView.layer.borderColor = UIColor.red.cgColor
            }else {
                cell.innnerView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
            }
            
            cell.deleteAction = { [unowned self] ( error) in
                self.collectionViewIndexPath = indexPath
                let refreshAlert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(LocalizedStrings.removeAnimalFromOrder, comment: ""), preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                refreshAlert.addAction(UIAlertAction(title:NSLocalizedString("Yes", comment: "") , style: .default, handler: { (action: UIAlertAction!) in
                    
                    let animalVal  =  self.viewAnimalArray[indexPath.row] as! AnimaladdTbl
                    self.deleteSigalAnimalFromList(index: indexPath.row)
                    updateAdhAnimalDataforCart(entity: Entities.animalMasterTblEntity, officialID: animalVal.animalTag ?? "", barCode: animalVal.animalbarCodeTag ?? "", isADHCart: false)
                    deleteDataWithProduct(Int(animalVal.animalId))
                    deleteDataWithSubProduct(Int(animalVal.animalId))
                    deleteDataWithAnimal(Int(animalVal.animalId))
                    let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                    let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
                    updateProductTablDataaid(entity: Entities.getProductTblEntity, status: "false")
                    let fethData =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId, farmId:"")
                    for pName in fethData as? [ProductAdonAnimalTbl] ?? [] {
                        updateProductTablaid(entity:Entities.getProductTblEntity,productId:
                                                Int(pName.productId),status: "true")
                    }
                    
                    self.viewAnimalArray =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pviduser)
                    self.notificationLblCount.text = String(self.viewAnimalArray.count)
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.removedAnimalSuccessfully, comment: ""), duration: 1, position: .bottom)
                    if self.viewAnimalArray.count == 0 {
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
                        if self.pviduser == 4 {
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
                            
                            let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
                        }
                        self.cartBttnOutlet.isHidden = true
                        self.notificationLblCount.isHidden = true
                        self.clearOrderOutlet.isHidden = true
                        self.emailOrderOutlet.isHidden = true
                      
                    }
                    else {
                        self.emailOrderOutlet.isHidden = false
                        self.cartBttnOutlet.isHidden = false
                        self.notificationLblCount.isHidden = false
                        self.clearOrderOutlet.isHidden = false
                      
                    }
                    collectionView.reloadData()
                    
                }))
                present(refreshAlert, animated: true, completion: nil)
            }
            return cell
        default:
            let cell : ViewAnimalCelliPad = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! ViewAnimalCelliPad
            cell.officialIdLbl.text = animalVal.animalTag
            cell.farmIDLbl.text = animalVal.farmId
            cell.barcodeLbl.text = animalVal.animalbarCodeTag
            cell.rgdLbl.isHidden = true
            cell.rgdTitleLabel.isHidden = true
            cell.barcodeLbl.isHidden = false
            cell.barcodeLbl.isHidden = false
            cell.barcodeTtileLbl.isHidden = false
            cell.onFarmIdTitle.text = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
            cell.officalIdTitle.text = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
            cell.barcodeTtileLbl.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
            cell.barcodeSeperator.isHidden = true
            if animalVal.animalbarCodeTag == "" || animalVal.animalbarCodeTag == nil {
                cell.innnerView.layer.borderColor = UIColor.red.cgColor
            } else  {
                cell.innnerView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
            }
            
            cell.deleteAction = { [unowned self] ( error) in
                self.collectionViewIndexPath = indexPath
                let refreshAlert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(LocalizedStrings.removeAnimalFromOrder, comment: ""), preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                refreshAlert.addAction(UIAlertAction(title:NSLocalizedString("Yes", comment: "") , style: .default, handler: { (action: UIAlertAction!) in
                    
                    let animalVal  =  self.viewAnimalArray[indexPath.row] as! AnimaladdTbl
                    self.deleteSigalAnimalFromList(index: indexPath.row)
                    updateAdhAnimalDataforCart(entity: Entities.animalMasterTblEntity, officialID: animalVal.animalTag ?? "", barCode: animalVal.animalbarCodeTag ?? "", isADHCart: false)
                    deleteDataWithProduct(Int(animalVal.animalId))
                    deleteDataWithSubProduct(Int(animalVal.animalId))
                    deleteDataWithAnimal(Int(animalVal.animalId))
                    let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                    let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
                    updateProductTablDataaid(entity: Entities.getProductTblEntity, status: "false")
                    let fethData =  fetchAllDataFarmIdStatus(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId, farmId:"")
                    for pName in fethData as? [ProductAdonAnimalTbl] ?? [] {
                        updateProductTablaid(entity:Entities.getProductTblEntity,productId:
                                                Int(pName.productId),status: "true")
                    }
                    
                    self.viewAnimalArray =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pviduser)
                    self.notificationLblCount.text = String(self.viewAnimalArray.count)
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.removedAnimalSuccessfully, comment: ""), duration: 1, position: .bottom)
                    if self.viewAnimalArray.count == 0 {
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
                        if self.pviduser == 4 {
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
                            
                            let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
                        }
                        self.cartBttnOutlet.isHidden = true
                        self.notificationLblCount.isHidden = true
                        self.clearOrderOutlet.isHidden = true
                        self.emailOrderOutlet.isHidden = true
                       
                    }
                    else {
                        self.emailOrderOutlet.isHidden = false
                        self.cartBttnOutlet.isHidden = false
                        self.notificationLblCount.isHidden = false
                        self.clearOrderOutlet.isHidden = false
                       
                    }
                    collectionView.reloadData()
                    
                }))
                present(refreshAlert, animated: true, completion: nil)
            }
            
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let animalVal  =  viewAnimalArray[indexPath.row] as! AnimaladdTbl
        self.delegateCustom?.objectGetOnSelection(temp: Int(animalVal.animalId))
        UserDefaults.standard.set(Int(animalVal.animalId), forKey: keyValue.animalIdSelectionCart.rawValue)
        if pviduser == 4  {
            let storyboard = UIStoryboard(name: "DairyPlaceAnOrder", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "OrderingAnimalVCGirlandoIpad") as! OrderingAnimalVCGirlandoIpad
            navigationController?.pushViewController(vc,animated: false)
            
        } else {
            let storyboard = UIStoryboard(name: "DairyPlaceAnOrder", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "OrderingAnimalipadVC") as! OrderingAnimalipadVC
            vc.iscomingFromCart = true
            navigationController?.pushViewController(vc,animated: false)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if pviduser == 4 {
            let totalSpacing = 15 * 2
            let screenWidth = UIScreen.main.bounds.width
            let itemWidth = screenWidth / 2
            return CGSize(width: Int(itemWidth) - totalSpacing, height: 240)
        }
        else if pviduser == 8 {
            let totalSpacing = 15 * 2
            let screenWidth = UIScreen.main.bounds.width
            let itemWidth = screenWidth / 2
            return CGSize(width: Int(itemWidth) - totalSpacing, height: 290)
        }
        else {
            let totalSpacing = 15 * 2
            let screenWidth = UIScreen.main.bounds.width
            let itemWidth = screenWidth / 2
            return CGSize(width: Int(itemWidth) - totalSpacing, height: 186)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if UIDevice().userInterfaceIdiom == .pad {
            return 15
            
        }
        else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: DELETE LIST HELPER OR VIEW ANIMAL CONTROLLER
private typealias DeleteListHelper = ViewAnimalsControlleriPadVC
extension DeleteListHelper {
    func getListName()  {
        listName = orderingDatalistVM.makeListName(custmerId: custmerId ?? 0, providerID: pviduser)
        fetchDataEntry  = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.custmerId ?? 0),listName:listName ,productName:marketNameType.Dairy.rawValue) as! [DataEntryList]
        
    }
    
    func deleteSigalAnimalFromList(index:Int) {
        if fetchDataEntry.count > 0 {
            let fetchAllDatalistAnimals =  fetchAllDataAnimalDaWithOutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userID,orderStatus:"false",listid:Int64(fetchDataEntry[0].listId), custmerId: Int64(custmerId ?? 0), providerId: pviduser) as! [DataEntryAnimaladdTbl]
            
            if fetchAllDatalistAnimals.count > 0{
                let animalVal = fetchAllDatalistAnimals[index]
                if !Connectivity.isConnectedToInternet() {
                    saveDeletedDataListAnimal(entity: Entities.dataEntryOfflineDeletedAnimalTblEntity, animalID: Int(animalVal.animalId), listID: Int(fetchDataEntry[0].listId), customerID: Int64(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)), serverAnimalID: animalVal.serverAnimalId ?? "",speciesID: SpeciesID.dairySpeciesId)
                }
                self.objApiSync.postListDataDelete(listId:fetchDataEntry[0].listId,custmerId:Int64(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)), clearOrder: false, animalId: Int(animalVal.animalId))
                deleteAnimalfromdataEntry(enitityName:Entities.dataEntryAnimalAddTbl, Int(animalVal.animalId), listId: Int(animalVal.listId))
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
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict = [LocalizedStrings.authorizationHeader: accessToken!,LocalizedStrings.contentType : LocalizedStrings.formURLEncoded]
        let urlString = Configuration.Dev(packet: ApiKeys.deleteList.rawValue).getUrl()
        let parameters : [String: Any] = [keyValue.customerId.rawValue: customerId,keyValue.listName.rawValue:listName]
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = headerDict
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
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
                deleteDataWithListIdDatEntry(entityString: Entities.dataEntryAnimalAddTbl, listId: Int(listID), customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userId:self.userID)
                deleteDataWithListId(entityString: Entities.dataEntryListTblEntity, listId: Int64(listID), customerId: Int(customerId ),userId:self.userID)
            }
        }
    }
}

//MARK: EMAIL LIST HELPER OR VIEW ANIMAL CONTROLLER
private typealias EmailListHelper = ViewAnimalsControlleriPadVC
extension EmailListHelper {
    func emailList(){
        var listIdGet =  Int()
        if fetchDataEntry.count > 0{
            listIdGet = Int(fetchDataEntry[0].listId)
        }
        
        if Connectivity.isConnectedToInternet() {
            let emailId = UserDefaults.standard.value(forKey:keyValue.userName.rawValue) as! String
            self.objApiSync.postEmailList(listId:Int64(listIdGet),custmerId:Int64(custmerId ?? 0),emailAdress :[emailId],providerId: pviduser,listName: fetchDataEntry[0].listName ?? "")
            self.hideIndicator()
            self.view.makeToast(NSLocalizedString(LocalizedStrings.receiveEmailWithData, comment: ""), duration: 3, position: .bottom)
        }
        else {
            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(LocalizedStrings.noEmailSent, comment: ""), preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { (action:UIAlertAction!) in
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
    }
}

//MARK: SYNC API EXTENSION
private typealias SyncApiHelper = ViewAnimalsControlleriPadVC
extension SyncApiHelper : syncApi {
    func failWithError(statusCode: Int) {
        self.hideIndicator()
    }
    
    func failWithErrorInternal() {
        self.hideIndicator()
    }
    
    func didFinishApi(response: String) {
        self.hideIndicator()
        self.emailList()
    }
    
    func failWithInternetConnection() {
        self.hideIndicator()
    }
}

//MARK: OFFLINE CUSTOM VIEW EXTENSION
extension ViewAnimalsControlleriPadVC : offlineCustomView {
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}
