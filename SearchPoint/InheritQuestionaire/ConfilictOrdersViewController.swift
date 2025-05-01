//
//  ConfilictOrdersViewController.swift
//  SearchPoint
//
//  Created by Mobile Programming on 20/11/20.
//

import UIKit
import Alamofire

// MARK: - CONFLICT ORDERS VIEW CONTROLLER
class ConfilictOrdersViewController: UIViewController {
    
    // MARK: - IB OUTLETS
    @IBOutlet weak var confilictOrdersTitle: UILabel!
    @IBOutlet weak var confilictOrdersSubTitle: UILabel!
    @IBOutlet weak var backgroundBtnOutlet: UIButton!
    @IBOutlet weak var removeAllOutlet: UIButton!
    @IBOutlet weak var conflictTableView: UITableView!
    
    // MARK: - VARIABLES AND CONSTANTS
    var cooount = NSArray()
    var conficlitOrders = NSMutableArray()
    var userId = Int()
    var orderId = Int()
    var pviduser = Int()
    var value = 0
    weak var delegateCustom1 : objectPickfromConfilict?
    weak var dismissDelegate : DismissConflictPopUp?
    var screenName = String()
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    var fetchDataEntry : [DataEntryList] = []
    var listName = String()
    let orderingDatalistVM = OrderingDataListViewModel()
    var custmerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int
    var reviewProductOrder = ReviewOrderVCIpad()
    var reviewAnimalOrder = OPSReviewVCIpad()
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        confilictOrdersTitle.text = NSLocalizedString(ButtonTitles.animalListText, comment: "")
        confilictOrdersSubTitle.text = NSLocalizedString(ButtonTitles.animalsMissingInfo, comment: "")
        removeAllOutlet.setTitle(NSLocalizedString(LocalizedStrings.removeAllStr, comment: ""), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getListName()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        pviduser = UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue)
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: pviduser)
        
        if pviduser == 1 || pviduser == 2 || pviduser == 3 || pviduser == 10 || pviduser == 11 || pviduser == 12 {
            if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                for item in animalCount  {
                    let data = item as! AnimaladdTbl
                    if data.farmId == "" || data.date == "" || data.animalTag == "" {
                        self.conficlitOrders.add(data)
                    }
                }
            } else {
                for item in animalCount  {
                    let data = item as! AnimaladdTbl
                    if data.animalTag == "" || data.farmId == "" || data.date == ""{
                        
                        self.conficlitOrders.add(data)
                    }
                }
            }
        } else if pviduser == 4 || pviduser == 8 || pviduser == 6  {
            for item in animalCount  {
                let data = item as! AnimaladdTbl
                if data.animalName == "" ||  data.date == ""{
                    self.conficlitOrders.add(data)
                }
            }
        }
    }
    
    // MARK: - OBJC SELECTOR METHODS
    @objc func methodOfReceivedNotification(notification: Notification){
        if value == 0{
            UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
            let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
            self.hideIndicator()
            value = value + 1
        }
    }
    
    // MARK: - IB ACTIONS
    @IBAction func crossBtnAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        UserDefaults.standard.set(false, forKey: keyValue.beefPlaceOrderCheck.rawValue)
        UserDefaults.standard.set(false, forKey: keyValue.placeOrderCheck.rawValue)
        
        
        if UIDevice().userInterfaceIdiom == .phone {
            if self.screenName == ScreenNames.productSelectionReview.rawValue {
                self.delegateCustom1?.dataReload!(check :false)
            } else if self.screenName == ScreenNames.reviewVC.rawValue{
                self.delegateCustom1?.dataReload!(check :true)
            }
        } else {
            if self.screenName == "OPSProductReview" {
                self.delegateCustom1?.dataReload!(check :true)
            } else if self.screenName == "OPSAnimalReview"{
                self.delegateCustom1?.dataReload!(check :false)
            }
        }
       
    }
    
    @IBAction func removeAllAction(_ sender: Any) {
        let refreshAlert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.removeAllAnimalsAlert, comment: ""), preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
            self.view.makeToast(NSLocalizedString(LocalizedStrings.orderCleared, comment: ""), duration: 10, position: .center)
            if self.pviduser == 4   {
                self.cooount = fetchAllDataAnimalGirlando(entityName: Entities.animalAddTblEntity,userId:self.userId,orderId:self.orderId,orderStatus:"false",animalName:"",breedRegNumber:"", dateString: "")
            } else {
                self.cooount = fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:self.userId,orderId:self.orderId,orderStatus:"false",farmid:"",animalTag:"", pvid: self.pviduser)
            }
            
            for item in self.cooount {
                let data = item as! AnimaladdTbl
                deleteDataFarmidAnimalid(entityName: Entities.animalAddTblEntity,status: "false",animalId:Int(data.animalId),userId:self.userId,orderId:self.orderId)
                deleteDataFarmidAnimalid(entityName: Entities.productAdonAnimalTblEntity,status: "false",animalId:Int(data.animalId),userId:self.userId,orderId:self.orderId)
                deleteDataFarmidAnimalid(entityName: Entities.subProductTblEntity,status: "false",animalId:Int(data.animalId),userId:self.userId,orderId:self.orderId)
            }
            
            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pviduser)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
                self.dismiss(animated: false, completion: nil)
                if animalCount.count == 0 {
                    self.createListNameAndCheckifExist()
                    UserDefaults.standard.removeObject(forKey: keyValue.identifyStore.rawValue)
                    UserDefaults.standard.removeObject(forKey: keyValue.productCount.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.onKey.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.page.rawValue)
                    UserDefaults.standard.removeObject(forKey: keyValue.breed.rawValue)
                    updateProductTablStatus(entity: Entities.getProductTblEntity)
                    updateProductTablStatus(entity: Entities.getAdonTblEntity)
                    UserDefaults.standard.removeObject(forKey: keyValue.pidKey.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.girlandoSampleType.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.tsuClear.rawValue)
                    UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
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
                    self.delegateCustom1?.selectionObject!(check: false)
                } else {
//                    if self.screenName == ScreenNames.productSelectionReview.rawValue {
//                        self.delegateCustom1?.dataReload!(check :false)
//                        
//                    } else if self.screenName == ScreenNames.reviewVC.rawValue{
//                        self.delegateCustom1?.dataReload!(check :true)
//                    }
                    
                    if UIDevice().userInterfaceIdiom == .phone {
                        if self.screenName == ScreenNames.productSelectionReview.rawValue {
                            self.delegateCustom1?.dataReload!(check :false)
                        } else if self.screenName == ScreenNames.reviewVC.rawValue{
                            self.delegateCustom1?.dataReload!(check :true)
                        }
                    } else {
                        
                        if self.screenName == "OPSProductReview" {
                          //  self.reviewProductOrder.dataReload(check :true)
                           // self.navigationController?.popViewController(animated: false)
                            self.dismissDelegate?.updateDismissUI()
                        } else if self.screenName == "OPSAnimalReview"{
                           // self.reviewAnimalOrder.dataReload(check :false)
                           // self.navigationController?.popViewController(animated: false)
                            self.dismissDelegate?.updateDismissUI()
                        }
                    }
                }
            }
        }))
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
            
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
}

// MARK: - TABLEVIEW DATASOURCE AND DELEGATE
extension ConfilictOrdersViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.conficlitOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ConfilictOrdersCell = (self.conflictTableView.dequeueReusableCell(withIdentifier: "cell") as? ConfilictOrdersCell)!
        let animalVal =  conficlitOrders[indexPath.section] as! AnimaladdTbl
        
        
        if pviduser == 4  {
            if animalVal.animalTag != ""{
                cell.officalIdLbl.text = animalVal.animalbarCodeTag
            } else {
                cell.officalIdLbl.text = "N/A" // Or any default placeholder
            }
            if animalVal.farmId != ""{
                cell.onFarmIdLbl.text = animalVal.earTag
            } else {
                cell.onFarmIdLbl.text = "N/A" // Or any default placeholder
            }
            cell.onFarmIdTitleLbl.text = NSLocalizedString(ButtonTitles.earTagText, comment: "")
            cell.officalIdTitleLbl.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
            cell.onFarmIdLbl.text = animalVal.earTag
            cell.officalIdLbl.text = animalVal.animalbarCodeTag
        } else {
            if animalVal.animalTag != ""{
                cell.officalIdLbl.text = animalVal.animalTag
            } else {
                cell.officalIdLbl.text = "N/A" // Or any default placeholder
            }
            if animalVal.farmId != ""{
                cell.onFarmIdLbl.text = animalVal.farmId
            } else {
                cell.onFarmIdLbl.text = "N/A" // Or any default placeholder
            }
           // cell.onFarmIdLbl.text = animalVal.farmId
           // cell.officalIdLbl.text = animalVal.animalTag
            cell.barcodeLbl.text = animalVal.animalbarCodeTag
            cell.onFarmIdTitleLbl.text = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
            cell.officalIdTitleLbl.text = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
            cell.barcodeTitleLbl.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animalVal  =  conficlitOrders[indexPath.section] as! AnimaladdTbl
        UserDefaults.standard.set(Int(animalVal.animalId), forKey: keyValue.animalIdSelectionCart.rawValue)
        UserDefaults.standard.set(1, forKey: keyValue.placeorder.rawValue)
        self.delegateCustom1?.selectionObject!(check: true)
        self.dismiss(animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if pviduser == 4 {
            return 75
        }
        return 113
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // 1
        let headerView = UIView()
        // 2
        headerView.backgroundColor = view.backgroundColor
        // 3
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete".localized
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let refreshAlert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(LocalizedStrings.removeAnimalFromOrder, comment: ""), preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
        }))
        refreshAlert.addAction(UIAlertAction(title:NSLocalizedString("Yes", comment: "") , style: .default, handler: { [self] (action: UIAlertAction!) in
            
            if editingStyle == .delete {
                let animalVal  =  self.conficlitOrders[indexPath.row] as! AnimaladdTbl
                self.deleteSigalAnimalFromList(animalTagStr: animalVal.animalbarCodeTag ?? "")
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
                let Orders = NSMutableArray(array: fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: pviduser))
                
                if pviduser == 1 || pviduser == 2 || pviduser == 3  || pviduser == 10 || pviduser == 11 || pviduser == 12{
                    self.conficlitOrders = NSMutableArray(array:fetchAllDataAnimalDatarderIdNil(entityName: Entities.animalAddTblEntity,userId:self.userId,orderId:self.orderId,orderStatus:"false",farmid:"",animalTag:"", pvid: pviduser))
                }
                
                if pviduser == 4 {
                    self.conficlitOrders = NSMutableArray(array: fetchAllDataAnimalGirlando(entityName: Entities.animalAddTblEntity,userId:self.userId,orderId:self.orderId,orderStatus:"false",animalName:"",breedRegNumber:"", dateString: ""))
                }
                
                self.view.makeToast(NSLocalizedString(LocalizedStrings.removedAnimalSuccessfully, comment: ""), duration: 1, position: .bottom)
                
                if Orders.count == 1 {
                    UserDefaults.standard.set(nil, forKey: keyValue.onKey.rawValue)
                }
                
                if Orders.count == 0 {
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
                    UserDefaults.standard.set(nil, forKey: keyValue.girlandoSampleTypeClear.rawValue)
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
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        self.dismiss(animated: false, completion: nil)
                        self.delegateCustom1?.selectionObject!(check: false)
                    }
                }
                else {
                    if conficlitOrders.count == 0{
                        self.dismiss(animated: false, completion: nil)
                        if self.screenName == ScreenNames.productSelectionReview.rawValue {
                            self.delegateCustom1?.dataReload!(check :false)
                            
                        } else if self.screenName == ScreenNames.reviewVC.rawValue{
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

// MARK: - CREATE AND DELETE ANIMAL LIST
private typealias DeleteAnimalListHelper = ConfilictOrdersViewController
extension DeleteAnimalListHelper {
    func getListName()  {
        listName = orderingDatalistVM.makeListName(custmerId: custmerId , providerID: pviduser)
        fetchDataEntry  = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.custmerId ),listName:listName ,productName:marketNameType.Dairy.rawValue) as! [DataEntryList]
    }
    
    func deleteSigalAnimalFromList(animalTagStr:String) {
        if fetchDataEntry.count > 0 {
            let fetchAllDatalistAnimals =  fetchAllDataAnimalDaWithOutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderStatus:"false",listid:Int64(fetchDataEntry[0].listId), custmerId: Int64(custmerId ), providerId: pviduser) as! [DataEntryAnimaladdTbl]
            
            if fetchAllDatalistAnimals.count > 0{
                let filterdatalistAnimal = fetchAllDatalistAnimals.filter{$0.animalTag == animalTagStr}
                if filterdatalistAnimal.count > 0 {
                    let animalVal = fetchAllDatalistAnimals[0]
                    if !Connectivity.isConnectedToInternet() {
                        saveDeletedDataListAnimal(entity: Entities.dataEntryOfflineDeletedAnimalTblEntity, animalID: Int(animalVal.animalId), listID: Int(fetchDataEntry[0].listId), customerID: Int64(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)), serverAnimalID: animalVal.serverAnimalId ?? "",speciesID: SpeciesID.dairySpeciesId)
                    }
                  deleteAnimalfromdataEntry(enitityName:Entities.dataEntryAnimalAddTbl, Int(animalVal.animalId), listId: Int(animalVal.listId))
                   // deleteDataWithAnimaldataEntry(Int(animalVal.animalId))
                }
            }
        }
    }
    
    func createListNameAndCheckifExist(){
        if fetchDataEntry.count > 0 {
            self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
            self.view.isUserInteractionEnabled = false
            deleteDataWithListIdDatEntry(entityString: Entities.dataEntryAnimalAddTbl, listId: Int(fetchDataEntry[0].listId), customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userId:userId)
            deleteDataWithListId(entityString: Entities.dataEntryListTblEntity, listId: Int64(Int(fetchDataEntry[0].listId)), customerId: custmerId,userId:userId )
            deleteList(listName: listName, customerId: Int64(custmerId ),listID: Int(fetchDataEntry[0].listId))
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
                Date().saveCurrentDate()
                self.hideIndicator()
                self.view.isUserInteractionEnabled = true
            }
        }
    }
}
