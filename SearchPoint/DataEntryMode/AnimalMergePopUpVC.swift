//
//  AnimalMergePopUpVC.swift
//  SearchPoint
//
//  Created by Mobile Programming on 04/05/21.
//

import UIKit
import Alamofire

// MARK: - CLASS

class AnimalMergePopUpVC: UIViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var ImportListTitle: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var removeAllBtnOutlet: customButton!
    @IBOutlet weak var okBtnOutlet: customButton!

    // MARK: - VARIABLES AND CONSTANTS
    var listArray = NSArray()
    var userId = Int()
    weak var delegate: AnimalMergeProtocol?
    var providerId = Int()
    var langId = Int()
    let orderingDataListViewModel = OrderingDataListViewModel()
  let objApiSync = ApiSyncList()
    // MARK: - VIEW LIFE CYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int ?? 1
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        listArray = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(providerId),customerId:Int64(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)))
        
        ImportListTitle.text = LocalizedStrings.importLists.localized
        removeAllBtnOutlet.setTitle(NSLocalizedString(NSLocalizedString(LocalizedStrings.removeAllStr, comment: ""), comment: ""), for: .normal)
        okBtnOutlet.setTitle(NSLocalizedString(NSLocalizedString("Cancel", comment: ""), comment: ""), for: .normal)
        
    }
    
    // MARK: - OBJC SELECTOR METHODS
    @objc func deleteButtonCell(_ sender: UIButton){
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.removingOrdersList, comment: ""), preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
        })
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
            if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String == marketNameType.Beef.rawValue {
                
                let arrayGet1 = self.listArray[sender.tag] as? MergeDataEntryList
                deleteMergeDataListId(entityString:Entities.mergeDataEntryListTblEntity ,listId: Int64(arrayGet1?.listId ?? 0),customerId:Int(arrayGet1?.customerId ?? 0))
                
                let animalData = fetchDataEnteryAnimalTbl(entityName: Entities.beefAnimalAddTblEntity, customerId: Int(arrayGet1?.customerId ?? 0), listId: Int64(arrayGet1?.listId ?? 0))
                
                if animalData.count > 0 {
                    
                    for i in 0 ..< animalData.count {
                        let ad = animalData[i] as! BeefAnimaladdTbl
                        deleteDataWithProductBeefDelete(Int(ad.animalId))
                        deleteDataWithSubProductAnimalId(Int(ad.animalId))
                      self.deleteSigalAnimalFromListBeef(animalID: Int(ad.animalId))
                    }
                    deleteDataWithListIdDatEntry(entityString: Entities.beefAnimalAddTblEntity, listId: Int(arrayGet1?.listId ?? 0), customerId: Int(arrayGet1?.customerId ?? 0),userId:self.userId)
                }
                
                self.listArray = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.providerId),customerId:Int64(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)))
                if self.listArray.count == 0 {
                    self.dismiss(animated: false, completion: nil)
                }
                
            } else {
                let arrayGet1 = self.listArray[sender.tag] as? MergeDataEntryList
                let listId = arrayGet1?.listId
                let custId = arrayGet1?.customerId
                deleteMergeDataListId(entityString:Entities.mergeDataEntryListTblEntity ,listId: Int64(listId ?? 0),customerId:Int(custId ?? 0))
                let animalData = fetchDataEnteryAnimalTbl(entityName: Entities.animalAddTblEntity, customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listId ?? 0))
                
                if animalData.count > 0 {
                    for i in 0 ..< animalData.count {
                        let ad = animalData[i] as! AnimaladdTbl
                        deleteDataWithProduct(Int(ad.animalId))
                        deleteDataWithSubProduct(Int(ad.animalId))
                      self.deleteSigalAnimalFromListDairy(animalID: Int(ad.animalId))
                        
                    }
                    deleteDataWithListIdDatEntry(entityString: Entities.animalAddTblEntity, listId: Int(Int64(listId ?? 0)), customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userId:self.userId)
                }
                
                self.listArray = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.providerId),customerId:Int64(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)))
                if self.listArray.count == 0 {
                    self.dismiss(animated: false, completion: nil)
                }
            }
            
            self.delegate?.refreshUI()
            self.tblView.reloadData()
            
        })
        alert.addAction(ok)
        
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    // MARK: - IB ACTIONS
    @IBAction func removeBtnAction(_ sender: Any) {
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.removingOrdersList, comment: ""), preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: NSLocalizedString("No", comment: "") , style: .default, handler: { action in
            
        })
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
            
            if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String == marketNameType.Beef.rawValue {
                for i in 0 ..< self.listArray.count {
                    let arrayGet1 = self.listArray[i] as? MergeDataEntryList
                    let listId = arrayGet1?.listId
                    let custId = arrayGet1?.customerId
                    
                    deleteMergeDataListId(entityString:Entities.mergeDataEntryListTblEntity ,listId: Int64(listId ?? 0),customerId:Int(custId ?? 0))
                    // Remove Animals
                    
                    let animalData = fetchDataEnteryAnimalTbl(entityName: Entities.beefAnimalAddTblEntity, customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listId ?? 0))
                    
                    if animalData.count > 0 {
                        
                        for i in 0 ..< animalData.count {
                            let ad = animalData[i] as! BeefAnimaladdTbl
                            deleteDataWithProductBeefDelete(Int(ad.animalId))
                            deleteDataWithSubProductAnimalId(Int(ad.animalId))
                          self.deleteSigalAnimalFromListBeef(animalID: Int(ad.animalId))
                        }
                        deleteDataWithListIdDatEntry(entityString: Entities.beefAnimalAddTblEntity, listId: Int(Int64(listId ?? 0)), customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userId:self.userId)
                    }
                }
                
            } else {
                for i in 0 ..< self.listArray.count {
                    let arrayGet1 = self.listArray[i] as? MergeDataEntryList
                    let listId = arrayGet1?.listId
                    let custId = arrayGet1?.customerId
                    
                    deleteMergeDataListId(entityString:Entities.mergeDataEntryListTblEntity ,listId: Int64(listId ?? 0),customerId:Int(custId ?? 0))
                    
                    let animalData = fetchDataEnteryAnimalTbl(entityName: Entities.animalAddTblEntity, customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listId ?? 0))
                    
                    if animalData.count > 0 {
                        
                        for i in 0 ..< animalData.count {
                            let ad = animalData[i] as! AnimaladdTbl
                            deleteDataWithProduct(Int(ad.animalId))
                            deleteDataWithSubProduct(Int(ad.animalId))
                            self.deleteSigalAnimalFromListDairy(animalID: Int(ad.animalId))
                            
                        }
                        deleteDataWithListIdDatEntry(entityString: Entities.animalAddTblEntity, listId: Int(Int64(listId ?? 0)), customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userId:self.userId)
                    }
                }
            }
            
            self.tblView.reloadData()
            self.delegate?.refreshUI()
            self.dismiss(animated: false, completion: nil)
        })
        alert.addAction(ok)
        
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    @IBAction func okBtnAtion(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}

// MARK: - TABLEVIEW DELEGATES AND DATASOURCES
extension AnimalMergePopUpVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AnimalMergePopUpCell = self.tblView.dequeueReusableCell(withIdentifier: "cell") as! AnimalMergePopUpCell
        let listArray = self.listArray[indexPath.row] as! MergeDataEntryList
        cell.listNameLabel.text = listArray.listName
        cell.listDescriptionLbl.text = listArray.listDesc
        cell.crossBtnOutlet.tag = indexPath.row
        cell.crossBtnOutlet.addTarget(self, action: #selector(deleteButtonCell(_:)), for: .touchUpInside)
        return cell
    }
    
}
extension AnimalMergePopUpVC{
  func deleteSigalAnimalFromListDairy(animalID:Int) {
    let objApiSync = ApiSyncList()
    let customerID = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
    let listName = orderingDataListViewModel.makeListName(custmerId: customerID ?? 0,providerID: providerId)
    
    
    let fetchDataEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(customerID ),listName:listName ,productName:"Dairy") as! [DataEntryList]
      if fetchDataEntry.count > 0 {
        let fetchAllDatalistAnimals =  fetchAllDataAnimalDaWithOutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderStatus:"false",listid:Int64(fetchDataEntry[0].listId), custmerId: Int64(customerID ), providerId: Int(Int64(providerId))) as! [DataEntryAnimaladdTbl]
          
          if fetchAllDatalistAnimals.count > 0{
              let filterdatalistAnimal = fetchAllDatalistAnimals.filter{$0.animalId == animalID}
              if filterdatalistAnimal.count > 0 {
                  let animalVal = filterdatalistAnimal[0]
                  if !Connectivity.isConnectedToInternet() {
                      saveDeletedDataListAnimal(entity: Entities.dataEntryOfflineDeletedAnimalTblEntity, animalID: Int(animalVal.animalId), listID: Int(fetchDataEntry[0].listId), customerID: Int64(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)), serverAnimalID: animalVal.serverAnimalId ?? "",speciesID: SpeciesID.dairySpeciesId)
                  }
                deleteAnimalfromdataEntry(enitityName:Entities.dataEntryAnimalAddTbl, Int(animalVal.animalId), listId: Int(animalVal.listId))
                 // deleteDataWithAnimaldataEntry(Int(animalVal.animalId))
              }
          }
      }
  }
  
  func deleteSigalAnimalFromListBeef(animalID :Int) {
    let objApiSync = ApiSyncList()
    let customerID = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
    let listName = orderingDataListViewModel.makeListName(custmerId: customerID ?? 0,providerID: providerId)
    let fetchDataEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(customerID ),listName:listName ,productName:marketNameType.Beef.rawValue) as! [DataEntryList]
    if fetchDataEntry.count > 0 {
      let fetchAllDatalistAnimals =  fetchAllDataAnimalDaWithOutOrderId(entityName: "DataEntryBeefAnimaladdTbl", userId: userId,orderStatus:"false",listid:Int64(fetchDataEntry[0].listId), custmerId: Int64(customerID ), providerId: providerId) as! [DataEntryBeefAnimaladdTbl]
      
      
      if fetchAllDatalistAnimals.count > 0{
        let filterdatalistAnimal = fetchAllDatalistAnimals.filter({ $0.animalId == animalID})
        if filterdatalistAnimal.count > 0 {
          let animalVal = filterdatalistAnimal[0]
          if !Connectivity.isConnectedToInternet() {
            saveDeletedDataListAnimal(entity: "DataEntryOfflineDeletedAnimal", animalID: Int(animalVal.animalId), listID: Int(fetchDataEntry[0].listId), customerID: Int64(UserDefaults.standard.integer(forKey: "currentActiveCustomerId")), serverAnimalID: animalVal.serverAnimalId ?? "", speciesID: "151e2230-9a01-4828-a105-d87a92b5be2f")
          }
          self.objApiSync.postListDataDeleteBeef(listId:fetchDataEntry[0].listId,custmerId:Int64(UserDefaults.standard.integer(forKey: "currentActiveCustomerId")), clearOrder: false, animalId: Int(animalVal.animalId))
          deleteAnimalfromdataEntry(enitityName:Entities.dataEntryBeefAnimalAddTblEntity, Int(animalVal.animalId), listId: Int(animalVal.listId))
         
        }
      }
    }
  }
  
}
