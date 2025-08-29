//
//  DataEntryViewAnimalController.swift
//  SearchPoint
//
//  Created by Mobile Programming on 21/12/20.
//

import UIKit
import Alamofire
import CoreData

// MARK: - CLASS
class DataEntryViewAnimalController: UIViewController {
    
    // MARK: - OUTLETS
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
    @IBOutlet weak var offlineBtnOutlet: UIButton!
    @IBOutlet weak var bckBtnOutlet: customButton!
    
    // MARK: - VARIABLES AND CONSTANTS
    let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
    var productBackSave = Bool()
    var viewAnimalArray = NSArray()
    var dateEnteryReviewScreen = Bool()
    var listIdGet = Int()
    var listName = String()
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    var delegateCustom : objectPickCartScreen?
    var animalBackSave = Bool()
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    var heartBeatViewModel:HeartBeatViewModel?
    var objApiSync = ApiSyncList()
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        initialNetworkCheck()
        listIdGet = UserDefaults.standard.integer(forKey: keyValue.listIdSaveOnSelection.rawValue)
        listName = UserDefaults.standard.object(forKey: keyValue.listNameSaveOnSelection.rawValue) as! String
        let customerId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        viewAnimalArray =  fetchAllDataAnimalDaWithOutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderStatus:"false",listid:Int64(listIdGet), custmerId: Int64(customerId), providerId: pviduser)
        notificationLblCount.text = String(viewAnimalArray.count)
    }
    
    // MARK: - UI AND OTHER METHODS
    func setInitialUI(){
        heartBeatViewModel?.callGetHearBeatData()
        UserDefaults.standard.set(nil, forKey: keyValue.submitTypeSelection.rawValue)
        UserDefaults.standard.set(false, forKey: keyValue.expandView.rawValue)
        self.navigationController?.navigationBar.isHidden = true
        cartImage.isHidden = true
        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
        noAnimalToast.text = LocalizedStrings.noAnimalAdded.localized
        appStatusTtile.text = NSLocalizedString(ButtonTitles.appStatusText, comment: "")
        cartLbl.text = "List".localized
        clearOrderOutlet.setTitle("Clear List".localized, for: .normal)
        bckBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.backBtnText, comment: ""), for: .normal)
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
        let data1 = fetchAllDataOrderStatusDataEntry(entityName: Entities.dataEntryAnimalAddTbl,ordestatus: "false",orderId:orderId,userId:userId,listId:listIdGet)
        var bredidd123 = String ()
        if data1.count > 0 {
            let breeid1 = data1.object(at: 0) as! DataEntryAnimaladdTbl
            bredidd123 = breeid1.breedName ?? ""
        }
        
        if data1.count == 1 {
            let breeid1 = data1.object(at: 0) as! DataEntryAnimaladdTbl
            UserDefaults.standard.set(false, forKey: keyValue.identifyStore.rawValue)
            UserDefaults.standard.set(breeid1.breedId, forKey: keyValue.dataEntrybreedId.rawValue)
            for i in 0 ..< data1.count{
                let breeid1 = data1.object(at: i) as! DataEntryAnimaladdTbl
                if bredidd123 == breeid1.breedName {
                    UserDefaults.standard.set(false, forKey: keyValue.identifyStore.rawValue)
                    UserDefaults.standard.set(breeid1.breedId, forKey: keyValue.dataEntrybreedId.rawValue)
                }
                else{
                    UserDefaults.standard.set(true, forKey: keyValue.identifyStore.rawValue)
                    break
                }
                bredidd123 = breeid1.breedName ?? ""
            }
        }
    }
    
    
    //MARK: OBJC SELECTOR METHODS
    @objc func methodOfReceivedNotification(notification: Notification){
        UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
        let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
        self.hideIndicator()
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
    
    //MARK: IB ACTIONS
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
        vc?.module = LocalizedStrings.dataEntryModeText.localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
    }
    
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
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        validateBreed()
        if viewAnimalArray.count == 0 {
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC) as! DashboardVC
            self.navigationController?.pushViewController(newViewController, animated: true)
            
        }
        else if dateEnteryReviewScreen ==  true {
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeReviewDataVC) as! DataEntryModeReviewData
            self.navigationController?.pushViewController(newViewController, animated: false)
        }
        else if animalBackSave ==  true {
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryOrderingAnimalVC) as! DataEntryOrderingAnimalVC
            self.navigationController?.pushViewController(newViewController, animated: false)
        }
        else {
            self.delegateCustom?.anOptionalMethod?(check: true)
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    @IBAction func clearOrder(_ sender: UIButton) {
        self.DeleteData(msg: LocalizedStrings.clearTheListStr)
    }
}

//MARK: TABLE VIEW DELEGATE AND DATASOURCES
extension DataEntryViewAnimalController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewAnimalArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ViewAnimalCell = self.tblView.dequeueReusableCell(withIdentifier: "cell") as! ViewAnimalCell
        let animalVal =  viewAnimalArray[indexPath.row] as! DataEntryAnimaladdTbl
        
        let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
        if pviduser == 4 {
            cell.officialIdLbl.text = animalVal.animalbarCodeTag
            cell.farmIDLbl.text = animalVal.earTag
            cell.barcodeLbl.isHidden = true
            cell.thirdColonLbl.isHidden = true
            cell.barcodeLbl.isHidden = true
            cell.barcodeTtileLbl.isHidden = true
            cell.onFarmIdTitle.text = NSLocalizedString(ButtonTitles.earTagText, comment: "")
            cell.officalIdTitle.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
            bckBtnOutlet.titleLabel?.text = NSLocalizedString(LocalizedStrings.backBtnText, comment: "")
        }
        else {
            cell.officialIdLbl.text = animalVal.animalTag
            cell.farmIDLbl.text = animalVal.farmId
            cell.barcodeLbl.text = animalVal.animalbarCodeTag
            cell.barcodeLbl.isHidden = false
            cell.thirdColonLbl.isHidden = false
            cell.barcodeLbl.isHidden = false
            cell.barcodeTtileLbl.isHidden = false
            cell.onFarmIdTitle.text = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
            cell.officalIdTitle.text = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
            cell.barcodeTtileLbl.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
            bckBtnOutlet.titleLabel?.text = NSLocalizedString(LocalizedStrings.backBtnText, comment: "")
        }
        cell.innnerView.layer.borderWidth = 1
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animalVal = viewAnimalArray[indexPath.row] as! DataEntryAnimaladdTbl
        self.delegateCustom?.objectGetOnSelection(temp: Int(animalVal.animalId))
        UserDefaults.standard.set(Int(animalVal.animalId), forKey: keyValue.dataEntryAnimalIdSelectionCart.rawValue)
        
        if pviduser == 4 {
            let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryOrderingAnimalVCGirlando) as! DataEntryOrderingAnimalVCGirlando
            navigationController?.pushViewController(vc,animated: false)
        }
        else {
            let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryOrderingAnimalVC) as! DataEntryOrderingAnimalVC
            navigationController?.pushViewController(vc,animated: false)
        }
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete".localized
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if viewAnimalArray.count == 1{
            if editingStyle == .delete {
                self.DeleteData(msg: LocalizedStrings.deleteLastAnimalStr)
            }
        }
        else {
            let refreshAlert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(LocalizedStrings.removeAnimalStr, comment: ""), preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
                print("No")
            }))
            
            refreshAlert.addAction(UIAlertAction(title:NSLocalizedString("Yes", comment: "") , style: .default, handler: { [self] (action: UIAlertAction!) in
                
                if editingStyle == .delete {
                    let customerId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
                    let animalVal = self.viewAnimalArray[indexPath.row] as! DataEntryAnimaladdTbl
                    self.objApiSync.postListDataDelete(listId:Int64(self.listIdGet),custmerId:Int64(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)), clearOrder: false, animalId: Int(animalVal.animalId))
                    
                    if !Connectivity.isConnectedToInternet() {
                        saveDeletedDataListAnimal(entity: Entities.dataEntryOfflineDeletedAnimalTblEntity, animalID: Int(animalVal.animalId), listID: self.listIdGet, customerID: Int64(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)), serverAnimalID: animalVal.serverAnimalId ?? "",speciesID: SpeciesID.dairySpeciesId)
                    }
                    if UserDefaults.standard.value(forKey: "name") as? String == marketNameType.Beef.rawValue  {
                        deleteAnimalfromdataEntry(enitityName:Entities.dataEntryBeefAnimalAddTblEntity, Int(animalVal.animalId), listId: Int(animalVal.listId))
                    }
                    else {
                        deleteAnimalfromdataEntry(enitityName:Entities.dataEntryAnimalAddTbl, Int(animalVal.animalId), listId: Int(animalVal.listId))
                    }
                    
                    let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                    self.viewAnimalArray =  fetchAllDataAnimalDaWithOutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderStatus:"false", listid: Int64(self.listIdGet ), custmerId: Int64(customerId), providerId: pviduser)
                    self.notificationLblCount.text = String(self.viewAnimalArray.count)
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.animalRemovedStr, comment: ""), duration: 1, position: .bottom)
                    
                    if self.viewAnimalArray.count == 0 {
                        deleteDataProductDataEntry(entityName: Entities.dataEntryAnimalAddTbl,status: "false",listId:self.listIdGet,customerId: UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int)
                        
                        UserDefaults.standard.removeObject(forKey: keyValue.dataEntryTsu.rawValue)
                        UserDefaults.standard.removeObject(forKey: keyValue.dataEntrybreedId.rawValue)
                        UserDefaults.standard.removeObject(forKey: keyValue.dataEntryTsuClear.rawValue)
                        UserDefaults.standard.removeObject(forKey: keyValue.dataEntrybreedNameClear.rawValue)
                        UserDefaults.standard.removeObject(forKey: keyValue.dataEntrybreedName.rawValue)
                        UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlagDataEntry.rawValue)
                        self.bckBtnOutlet.isEnabled = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeListVC)), animated: true)
                        }
                        self.cartBttnOutlet.isHidden = true
                        self.notificationLblCount.isHidden = true
                        self.clearOrderOutlet.isHidden = true
                        self.noAnimalToast.isHidden = false
                        self.cartImage.isHidden = false
                    }
                    else {
                        self.noAnimalToast.isHidden = true
                        self.cartBttnOutlet.isHidden = false
                        self.notificationLblCount.isHidden = false
                        self.clearOrderOutlet.isHidden = false
                        self.cartImage.isHidden = true
                        
                    }
                    print(self.viewAnimalArray.count)
                    tableView.reloadData()
                }
                else if editingStyle == .insert {
                    
                }
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if pviduser == 4 {
            return 80
        }
        return 122
    }
}

//MARK: DELETE DATA AND LIST METHODS
extension DataEntryViewAnimalController {
    func DeleteData(msg: String){
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        let customerId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
        
        if Connectivity.isConnectedToInternet() {
            if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String  == marketNameType.Dairy.rawValue{
                let animalCount1 = fetchAnimalCountAccrodingToOrderWise(entityName: Entities.animalAddTblEntity, listId:Int64(listIdGet ),customerId:Int64(customerId ),orderId:orderId ,orderstatus:"false")
                
                if animalCount1.count > 0{
                    let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.cannotDeleteList, comment: ""), preferredStyle: .alert)
                    let ok = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: { action in
                        print("Ok")
                    })
                    alert.addAction(ok)
                    DispatchQueue.main.async(execute: {
                        self.present(alert, animated: true)
                    })
                    
                } else {
                    
                    let refreshAlert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: msg.localized, preferredStyle: UIAlertController.Style.alert)
                    refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
                        refreshAlert .dismiss(animated: true, completion: nil)
                    }))
                    
                    refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { [self] (action: UIAlertAction!) in
                        
                        let customerId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
                        
                        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                        if !Connectivity.isConnectedToInternet() {
                            for animal in self.viewAnimalArray{
                                let animalVal = animal as! DataEntryAnimaladdTbl
                                saveDeletedDataListAnimal(entity: Entities.dataEntryOfflineDeletedAnimalTblEntity, animalID: Int(animalVal.animalId), listID: self.listIdGet, customerID: Int64(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)), serverAnimalID: animalVal.serverAnimalId ?? "",speciesID: SpeciesID.dairySpeciesId)
                            }
                        }
                        
                        deleteList(listName:listName ,customerId:(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)))
                        
                        deleteDataWithListId(entityString: Entities.dataEntryListTblEntity, listId: Int64((listIdGet )), customerId: customerId ,userId:userId )
                        
                        let animalData =  fetchDataEnteryAnimalTbl(entityName: Entities.animalAddTblEntity, customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listIdGet ))
                        
                        if animalData.count > 0 {
                            for i in 0 ..< animalData.count {
                                let ad = animalData[i] as! AnimaladdTbl
                                deleteDataWithProduct(Int(ad.animalId))
                                deleteDataWithSubProduct(Int(ad.animalId))
                            }
                            
                            if UserDefaults.standard.value(forKey: keyValue.dataEntryListId.rawValue) as? Int == listIdGet {
                                UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListId.rawValue)
                                UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
                            }
                            
                            deleteDataWithListIdDatEntry(entityString: Entities.animalAddTblEntity, listId: Int(listIdGet ), customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userId:userId)
                        }
                        
                        let animalData1 =  fetchDataEnteryAnimalTbl(entityName: Entities.dataEntryAnimalAddTbl, customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listIdGet ))
                        if animalData1.count > 0 {
                            deleteDataWithListIdDatEntry(entityString: Entities.dataEntryAnimalAddTbl, listId: Int(listIdGet ), customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userId:userId)
                            
                        }
                        UserDefaults.standard.removeObject(forKey: keyValue.dataEntryTsu.rawValue)
                        UserDefaults.standard.removeObject(forKey: keyValue.dataEntrybreedId.rawValue)
                        UserDefaults.standard.removeObject(forKey: keyValue.dataEntryTsuClear.rawValue)
                        UserDefaults.standard.removeObject(forKey: keyValue.dataEntrybreedNameClear.rawValue)
                        UserDefaults.standard.removeObject(forKey: keyValue.dataEntrybreedName.rawValue)
                        UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlagDataEntry.rawValue)
                        
                    }))
                    
                    self.present(refreshAlert, animated: true, completion: nil)
                }
            }
        }
        
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.deleteListForUsers, comment: ""), preferredStyle: .alert)
        let ok = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.deleteOnlineList, comment: ""))
            
        })
        let cancel = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
            print("No")
        })
        alert.addAction(cancel)
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
        return
        
    }
    
    func deleteList(listName:String, customerId:Int) {
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
                self.view.makeToast(NSLocalizedString(LocalizedStrings.listDeleted, comment: ""), duration: 2, position: .bottom)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
                }
            }
        }
    }
}

//MARK: OFFLINE CUSTOM VIEW EXTENSION
extension DataEntryViewAnimalController : offlineCustomView {
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}
