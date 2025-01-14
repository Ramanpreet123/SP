//
//  BeefConfilictOrdersViewController.swift
//  SearchPoint
//
//  Created by Mobile Programming on 23/12/20.
//

import UIKit
import Alamofire

// MARK: - BEEF CONFLICT ORDERS VIEW CONTROLLER
class BeefConfilictOrdersViewController: UIViewController {
    
    // MARK: - IB OUTLETS
    @IBOutlet weak var confilictOrdersTitle: UILabel!
    @IBOutlet weak var confilictOrdersSubTitle: UILabel!
    @IBOutlet weak var backgroundBtnOutlet: UIButton!
    @IBOutlet weak var removeAllOutlet: UIButton!
    @IBOutlet weak var conflictTableView: UITableView!
    
    // MARK: - VARIABLES AND CONSTANTS
    var conficlitOrders = NSMutableArray()
    var pviduser = Int()
    var value = 0
    weak var delegateCustom1 : objectPickfromConfilict?
    var screenName = String()
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    var currentCustomerId = Int()
    var objApiSync = ApiSyncList()
    var fetchDataEntry : [DataEntryList] = []
    var listName = String()
    let orderingDatalistVM = OrderingDataListViewModel()
    let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
    let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
    let custmerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
    let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        currentCustomerId = (UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int)!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getListName()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        pviduser = UserDefaults.standard.integer(forKey:keyValue.beefPvid.rawValue)
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
        
        for item in animalCount  {
            let data = item as! BeefAnimaladdTbl
            if data.date == ""{
                self.conficlitOrders.add(data)
            }
        }
    }
    
    // MARK: - OBJC SELECTOR METHODS
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
    
    // MARK: - IB ACTIONS
    @IBAction func removeAllAction(_ sender: Any) {
        let refreshAlert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.removeAllAnimalsAlert, comment: ""), preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("YES", comment: ""), style: .default, handler: { [self] (action: UIAlertAction!) in
            self.view.makeToast(NSLocalizedString(LocalizedStrings.orderCleared, comment: ""), duration: 10, position: .center)
            let fetchAnimalTbl = fetchBeefSetValueDobCheck(entityName: Entities.beefAnimalAddTblEntity,orderId:self.orderId,userId:self.userId,customerId:self.currentCustomerId ,date:"")
            
            for item in fetchAnimalTbl {
                let data = item as! BeefAnimaladdTbl
                deleteDataFarmidAnimalid(entityName: Entities.beefAnimalAddTblEntity,status: "false",animalId:Int(data.animalId),userId:self.userId,orderId:self.orderId)
                deleteDataFarmidAnimalid(entityName: Entities.productAdonAnimlBeefTblEntity,status: "false",animalId:Int(data.animalId),userId:self.userId,orderId:self.orderId)
                deleteDataFarmidAnimalid(entityName: Entities.subProductBeefTblEntity,status: "false",animalId:Int(data.animalId),userId:self.userId,orderId:self.orderId)
            }
            
            let animalCount = fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
                self.dismiss(animated: false, completion: nil)
                
                if animalCount.count == 0 {
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
                    UserDefaults.standard.set(nil, forKey: keyValue.genotypeTissueBttn.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.inheritBeefbreed.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.beefInheritTSU.rawValue)
                    updateProductTablStatus(entity: Entities.getAdonTblEntity)
                    UserDefaults.standard.removeObject(forKey: keyValue.pidKey.rawValue)
                    deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                    deleteRecordFromDatabase(entityName: Entities.productAdonAnimlBeefTblEntity)
                    deleteRecordFromDatabase(entityName: Entities.subProductBeefTblEntity)
                    deleteRecordFromDatabase(entityName: Entities.selectedQuesTblEntity)
                    UserDefaults.standard.set(true, forKey: keyValue.showBeefProductTbl.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
                    UserDefaults.standard.set("", forKey: keyValue.nzBeefTSU.rawValue)
                    UserDefaults.standard.set("", forKey: keyValue.genotypeTissueBttn.rawValue)
                    UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
                    self.delegateCustom1?.selectionObject!(check: false)
                } else {
                    if self.screenName == ClassIdentifiers.beefProductSelectionReviewScreen {
                        self.delegateCustom1?.dataReload!(check :false)
                        
                    } else if self.screenName == ClassIdentifiers.beefReviewVCScreen{
                        self.delegateCustom1?.dataReload!(check :true)
                    }}
            }
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    @IBAction func crossBtnAction(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: keyValue.beefPlaceOrderCheck.rawValue)
        UserDefaults.standard.set(true, forKey: keyValue.checkValue.rawValue)
        self.dismiss(animated: false, completion: nil)
        if self.screenName == ClassIdentifiers.beefProductSelectionReviewScreen {
            self.delegateCustom1?.dataReload!(check :false)
        } else if self.screenName == ClassIdentifiers.beefReviewVCScreen{
            self.delegateCustom1?.dataReload!(check :true)
        }
    }
}

// MARK: - TABLEVIEW DATASOURCE AND DELEGATE
extension BeefConfilictOrdersViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.conficlitOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:BeefConfilictOrdersCell = (self.conflictTableView.dequeueReusableCell(withIdentifier: "cell") as? BeefConfilictOrdersCell)!
        let animalVal =  conficlitOrders[indexPath.row] as! BeefAnimaladdTbl
        
        if pviduser == 5 {
            cell.onFarmIdLbl.text = animalVal.animalTag
            cell.officalIdLbl.text = animalVal.animalbarCodeTag
            cell.onFarmIdTitleLbl.text = NSLocalizedString(ButtonTitles.earTagText, comment: "")
            cell.officalIdTitleLbl.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
            
        }
        if pviduser == 13 {
            cell.onFarmIdLbl.text = animalVal.animalTag
            cell.officalIdLbl.text = animalVal.animalbarCodeTag
            cell.onFarmIdTitleLbl.text = NSLocalizedString(ButtonTitles.uniqueIdText, comment: "")
            cell.officalIdTitleLbl.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
        }
        
        if pviduser == 6 {
            cell.onFarmIdLbl.text = animalVal.animalTag
            cell.officalIdLbl.text = animalVal.offsireId
            cell.barcodeLbl.text = animalVal.offPermanentId
            cell.fourthLbl.text = animalVal.offDamId
            cell.onFarmIdTitleLbl.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
            cell.officalIdTitleLbl.text = NSLocalizedString(LocalizedStrings.seriesText, comment: "")
            cell.barcodeTitleLbl.text = NSLocalizedString(LocalizedStrings.RGNText, comment: "")
            cell.fourthTitleLbl.text = NSLocalizedString(LocalizedStrings.RGDorAnimalIDText, comment: "")
        }
        
        if pviduser == 7 {
            cell.onFarmIdLbl.text = animalVal.animalTag
            cell.officalIdLbl.text = animalVal.animalbarCodeTag
            cell.onFarmIdTitleLbl.text = NSLocalizedString(LocalizedStrings.animalTagStr, comment: "")
            cell.officalIdTitleLbl.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animalVal  =  conficlitOrders[indexPath.row] as! BeefAnimaladdTbl
        UserDefaults.standard.set(Int(animalVal.animalId), forKey: keyValue.beefAnimalIdSelectionCart.rawValue)
        self.delegateCustom1?.selectionObject!(check: true)
        self.dismiss(animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if pviduser == 6 {
            return 170
        }
        return 90
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete".localized
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let refreshAlert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(LocalizedStrings.wantToRemoveAnimal, comment: ""), preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
            
        }))
        refreshAlert.addAction(UIAlertAction(title:NSLocalizedString("YES", comment: "") , style: .default, handler: { [self] (action: UIAlertAction!) in
            
            if editingStyle == .delete {
                let animalVal  =  self.conficlitOrders[indexPath.row] as! BeefAnimaladdTbl
                BeefDeleteDataWithProduct(Int(animalVal.animalId))
                beefDeleteDataWithSubProduct(Int(animalVal.animalId))
                beefDeleteDataWithAnimal(Int(animalVal.animalId))
                self.deleteSigalAnimalFromList(animalbarCode: animalVal.animalbarCodeTag ?? "")
                let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
                let Orders = NSMutableArray(array: beefFetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", pvid: pvid))
                self.conficlitOrders = NSMutableArray(array: fetchBeefSetValueDobCheck(entityName: Entities.beefAnimalAddTblEntity,orderId:self.orderId,userId:self.userId,customerId:self.currentCustomerId ,date:""))
                
                self.view.makeToast(NSLocalizedString(LocalizedStrings.removedAnimalSuccessfully, comment: ""), duration: 1, position: .bottom)
                
                if Orders.count == 0 {
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
                    UserDefaults.standard.set(nil, forKey: keyValue.genotypeTissueBttn.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.inheritBeefbreed.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.beefInheritTSU.rawValue)
                    updateProductTablStatus(entity: Entities.getAdonTblEntity)
                    UserDefaults.standard.removeObject(forKey: keyValue.pidKey.rawValue)
                    deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                    deleteRecordFromDatabase(entityName: Entities.productAdonAnimlBeefTblEntity)
                    deleteRecordFromDatabase(entityName: Entities.subProductBeefTblEntity)
                    deleteRecordFromDatabase(entityName: Entities.selectedQuesTblEntity)
                    UserDefaults.standard.set(true, forKey: keyValue.showBeefProductTbl.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
                    UserDefaults.standard.set("", forKey: keyValue.nzBeefTSU.rawValue)
                    UserDefaults.standard.set("", forKey: keyValue.genotypeTissueBttn.rawValue)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        self.dismiss(animated: false, completion: nil)
                        self.delegateCustom1?.selectionObject!(check: false)
                    }
                } else {
                    if conficlitOrders.count == 0{
                        self.dismiss(animated: false, completion: nil)
                        if self.screenName == ClassIdentifiers.beefProductSelectionReviewScreen {
                            self.delegateCustom1?.dataReload!(check :false)
                        } else if self.screenName == ClassIdentifiers.beefReviewVCScreen{
                            self.delegateCustom1?.dataReload!(check :true)
                            
                        }
                    }
                }
                tableView.reloadData()
            }
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
}

// MARK: - GET AND DELETE LIST NAME
private typealias DeleteBeefConflictDataListHelper = BeefConfilictOrdersViewController
extension DeleteBeefConflictDataListHelper {
    func getListName()  {
        listName = orderingDatalistVM.makeListName(custmerId: custmerId ?? 0, providerID: pvid)
        if pvid == 6 {
            if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeOnly.rawValue {
                fetchDataEntry =  fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.custmerId ?? 0),userId:userId,providerId:pvid,productType:keyValue.genoTypeOnly.rawValue) as! [DataEntryList]
                fetchDataEntry = fetchDataEntry.filter({$0.listName == listName})
            }
            else  if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeStarBlack.rawValue {
                fetchDataEntry =  fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.custmerId ?? 0),userId:userId,providerId:pvid,productType:keyValue.genoTypeStarBlack.rawValue) as! [DataEntryList]
                fetchDataEntry = fetchDataEntry.filter({$0.listName == listName})
            }
            else  if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genStarBlack.rawValue {
                fetchDataEntry =  fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.custmerId ?? 0),userId:userId,providerId:pvid,productType:keyValue.genStarBlack.rawValue) as! [DataEntryList]
                fetchDataEntry = fetchDataEntry.filter({$0.listName == listName})
            }
            else {
                fetchDataEntry =  fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.custmerId ?? 0),userId:userId,providerId:pvid,productType:keyValue.nonGenoType.rawValue) as! [DataEntryList]
                fetchDataEntry = fetchDataEntry.filter({$0.listName == listName})
            }
        } else {
            fetchDataEntry  = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.custmerId ?? 0),listName:listName ,productName:marketNameType.Beef.rawValue) as! [DataEntryList]
        }
    }
    
    func deleteSigalAnimalFromList(animalbarCode :String) {
        if fetchDataEntry.count > 0 {
            let fetchAllDatalistAnimals =  fetchAllDataAnimalDaWithOutOrderId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, userId: userId,orderStatus:"false",listid:Int64(fetchDataEntry[0].listId), custmerId: Int64(custmerId ?? 0), providerId: pvid) as! [DataEntryBeefAnimaladdTbl]
            
            if fetchAllDatalistAnimals.count > 0{
                let filterdatalistAnimal = fetchAllDatalistAnimals.filter({ $0.animalbarCodeTag == animalbarCode})
                if filterdatalistAnimal.count > 0 {
                    let animalVal = fetchAllDatalistAnimals[0]
                    if !Connectivity.isConnectedToInternet() {
                        saveDeletedDataListAnimal(entity: Entities.dataEntryOfflineDeletedAnimalTblEntity, animalID: Int(animalVal.animalId), listID: Int(fetchDataEntry[0].listId), customerID: Int64(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)), serverAnimalID: animalVal.serverAnimalId ?? "", speciesID: SpeciesID.beefSpeciesId)
                    }
                    self.objApiSync.postListDataDeleteBeef(listId:fetchDataEntry[0].listId,custmerId:Int64(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)), clearOrder: false, animalId: Int(animalVal.animalId))
                    //beefDeleteDataWithAnimalDataEntry(Int(animalVal.animalId))
                  deleteAnimalfromdataEntry(enitityName:Entities.dataEntryBeefAnimalAddTblEntity, Int(animalVal.animalId), listId: Int(animalVal.listId))
                }
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
        let parameters : [String: Any] = ["customerId": customerId,"listName":listName]
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
                deleteDataWithListIdDatEntry(entityString: Entities.dataEntryBeefAnimalAddTblEntity, listId: Int(listID), customerId: Int(customerId ),userId:1)
                deleteDataWithListId(entityString: Entities.dataEntryListTblEntity, listId: Int64(listID), customerId: Int(customerId ),userId:1)
            }
        }
    }
}
