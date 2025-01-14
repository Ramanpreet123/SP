//
//  OrderingAnimalVCGirlandoActionMethods.swift
//  SearchPoint
//
//  Created by Mobile Programming on 10/03/24.
//

import Foundation
import UIKit
import Alamofire

// MARK: - IB ACTIONS
extension OrderingAnimalVCGirlando {
    @IBAction func mergeListBtnClick(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.animalMergePopVC) as! AnimalMergePopUpVC
        vc.delegate = self
        vc.providerId = pvid
        self.navigationController?.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func importFromListAction(_ sender: Any) {
        view.endEditing(true)
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int
        listId = 0
        tempImportListArray = fetchDataEntryListGet(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId, providerId: pvid) as!  [DataEntryList]
        if tempImportListArray.count > 0{
            importListArray = orderingDataListViewModel.hideInternalDataList(tempImportListArray: tempImportListArray)
        }
        if importListArray.count == 0 {
            
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.noListImported, comment: ""))
            
            importListMainView.isHidden = true
            importBackroundView.isHidden = true
            return
        }
        conflictArr.removeAll()
        showIndicator(self.view, withTitle: NSLocalizedString(LocalizedStrings.loadStr, comment: ""), and: "")
        
        let data1 = fetchAllDataWithOrderID(entityName: Entities.animalAddTblEntity,orderId:orderId,userId:userId)
        if data1.count > 0{
            
            let animalStatusChck = fetchAllDataWithOrderIDStatucCheck(entityName: Entities.animalAddTblEntity,orderId:self.orderId,userId:self.userId,status:"true")
            
            if animalStatusChck.count != 0 {
                let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message:NSLocalizedString(AlertMessagesStrings.prodSelectionCleared, comment: "") , preferredStyle: .alert)
                
                let cancel = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
                    self.importListMainView.isHidden = true
                    self.importBackroundView.isHidden = true
                    return
                })
                alert.addAction(cancel)
                
                let ok = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
                    
                    updateProductTablDataaid(entity: Entities.getProductTblEntity, status: "false")
                    updateProductTablDataaid(entity: Entities.getAdonTblEntity, status: "false")
                    for j in 0 ..< data1.count {
                        let animal = data1.object(at: j) as! AnimaladdTbl
                        updateAnimalTblDataDairystatus(entity: Entities.productAdonAnimalTblEntity, status: "false", animalTag: Int(animal.animalId), orderId: self.orderId, userId: userId)
                        updateAnimalTblDataDairystatus(entity: Entities.animalAddTblEntity, status: "false", animalTag: Int(animal.animalId), orderId: self.orderId, userId: userId)
                        updateProductTablDataaid(entity: Entities.subProductTblEntity, status: "false")
                        
                    }
                    if self.importListArray.count != 0 {
                        self.importListMainView.isHidden = false
                        self.importBackroundView.isHidden = false
                        self.importTblView.reloadData()
                        
                    }
                })
                alert.addAction(ok)
                
                DispatchQueue.main.async(execute: {
                    self.present(alert, animated: true)
                })
                
            }else {
                if importListArray.count != 0 {
                    importListMainView.isHidden = false
                    importBackroundView.isHidden = false
                    importTblView.reloadData()
                    
                }
            }
        }else {
            
            if importListArray.count != 0 {
                importListMainView.isHidden = false
                importBackroundView.isHidden = false
                importTblView.reloadData()
                
            }
        }
        self.hideIndicator()
    }
    
    @IBAction func crossBtnAction(_ sender: Any) {
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.removingOrdersList, comment: ""), preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
        })
        
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
            self.listId = UserDefaults.standard.value(forKey: keyValue.dataEntryListId.rawValue) as? Int ?? 0
            let listArray = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId ?? 0))
            
            for i in 0 ..< listArray.count{
                let listObj = listArray[i] as! MergeDataEntryList
                let animalData =  fetchDataEnteryAnimalTbl(entityName: Entities.animalAddTblEntity, customerId: Int(listObj.customerId), listId: Int64(listObj.listId))
                
                if animalData.count > 0 {
                    for i in 0 ..< animalData.count {
                        let ad = animalData[i] as! AnimaladdTbl
                        deleteDataWithProduct(Int(ad.animalId))
                        deleteDataWithSubProduct(Int(ad.animalId))
                        self.deleteSigalAnimalFromList(animalTagStr: ad.animalbarCodeTag ?? "")
                        
                    }
                    deleteDataWithListIdDatEntry(entityString: Entities.animalAddTblEntity, listId: Int(listObj.listId), customerId: Int(listObj.customerId),userId:self.userId)
                }
            }
            deleteDataWithPvidCustomerId(entityString: Entities.mergeDataEntryListTblEntity ,providerId: Int64(self.pvid),customerId: Int64(self.custmerId ?? 0))
            UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
            self.importFromListOutlet.isEnabled = true
            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
            self.notificationLblCount.text = String(animalCount.count)
            if animalCount.count == 0 {
                self.notificationLblCount.isHidden = true
                self.countLbl.isHidden = true
            } else {
                self.notificationLblCount.isHidden = false
                self.countLbl.isHidden = false
            }
            
            if fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId ?? 0)).count == 0 {
                self.mergeListBtnOulet.isHidden = true
            } else {
                self.mergeListBtnOulet.isHidden = false
            }
            self.crossBtnOutlet.isHidden = true
        })
        alert.addAction(ok)
        
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
  func deleteSigalAnimalFromList(animalTagStr:String) {
    let objApiSync = ApiSyncList()
    let listName = orderingDataListViewModel.makeListName(custmerId: custmerId ?? 0,providerID: pvid)
    
    let fetchDataEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.custmerId ?? 0 ),listName:listName ,productName:"Dairy") as! [DataEntryList]
      if fetchDataEntry.count > 0 {
        let fetchAllDatalistAnimals =  fetchAllDataAnimalDaWithOutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderStatus:"false",listid:Int64(fetchDataEntry[0].listId), custmerId: Int64(custmerId ?? 0 ), providerId: pvid) as! [DataEntryAnimaladdTbl]
          if fetchAllDatalistAnimals.count > 0{
              let filterdatalistAnimal = fetchAllDatalistAnimals.filter{$0.animalbarCodeTag == animalTagStr}
              if filterdatalistAnimal.count > 0 {
                  let animalVal = filterdatalistAnimal[0]
                deleteAnimalfromdataEntry(enitityName:Entities.dataEntryAnimalAddTbl, Int(animalVal.animalId), listId: Int(animalVal.listId))
                  if Connectivity.isConnectedToInternet() {
                      objApiSync.postListDataDelete(listId: fetchDataEntry[0].listId, custmerId: Int64(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)), clearOrder: false, animalId: Int(animalVal.animalId))
                  }
              }
          }
      }
  }
    @IBAction func okBtnClickImportViewAction(_ sender: Any) {
        orderId = autoD
        if listId == 0 {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.selectListToImport, comment: "") )
        }
        else {
            let aData =  fetchAnimaldataDairyOrderIdUserId(entityName: Entities.animalAddTblEntity, orderId: autoD, userId: userId,providerId:self.pvid)
            if aData.count > 0 {
                for k in 0 ..< aData.count{
                    let data1 = aData[k] as! AnimaladdTbl
                    let earTag = data1.earTag
                    let dataEntryVALE = fetchAllDataAnimalDatarderIdDateEntrycheckGirlandoEARtag(entityName: Entities.dataEntryAnimalAddTbl,userId:userId,orderId:orderId,listid:Int64(listId),custmerId:Int64(custmerId ?? 0),providerId:pvid,earTag: earTag ?? "", orderStatus: "false") as! [DataEntryAnimaladdTbl]
                    
                    if dataEntryVALE.count > 0 {
                        self.conflictArr.append(contentsOf: dataEntryVALE)
                    }
                }
                
                if conflictArr.count > 0 {
                    let count1 = conflictArr.count
                    let alertPrint = String(count1) + " " + NSLocalizedString(LocalizedStrings.selectActionToBePerformed, comment: "")
                    let alert = UIAlertController(title: listNameString, message: alertPrint, preferredStyle: .alert)
                  let cancel = UIAlertAction(title: "Cancel".localized, style: .default, handler: { action in
                        self.importBackroundView.isHidden = true
                        self.importListMainView.isHidden = true
                        
                    })
                    alert.addAction(cancel)
                  let ok = UIAlertAction(title: "Ignore".localized, style: .default, handler: { [self] action in
                        
                        let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: Entities.dataEntryAnimalAddTbl, userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ?? 0), providerId: self.pvid)
                        if fetchData11.count != 0 {
                            for i in 0...fetchData11.count - 1 {
                                let dataGet = fetchData11.object(at: i) as! DataEntryAnimaladdTbl
                                let fetchCountGirlando =  fetchAllDataAnimalGiirlando(entityName: Entities.animalAddTblEntity,earTag:dataGet.earTag ?? "",custmerId :Int(dataGet.custmerId)  ,userID :self.userId,orderId :self.orderId)
                                if fetchCountGirlando.count == 0 {
                                    let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.orderId, customerID: custmerId ?? 0)
                                    if data12333.count > 0{
                                        if self.tissueBttnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || self.tissueBttnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || tissueBttnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText || self.tissuId == 1 || self.tissuId == 18 {
                                            
                                            saveAnimaldataGirlando(entity: Entities.animalAddTblEntity, earTag: dataGet.earTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "", damId: dataGet.offDamId ?? "" , sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "" , update: dataGet.status ?? "", breedRegNumber: dataGet.breedRegNumber ?? "" , tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "" , et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "" , orderId: self.orderId, orderSataus: dataGet.orderstatus ?? "" , breedId: dataGet.breedId ?? "", isSync: dataGet.isSync ?? "", providerId: Int(dataGet.providerId), tissuId: Int(dataGet.tissuId), sireIDAU: dataGet.sireIDAU ?? "", animalName: dataGet.animalName ?? "" , userId: Int(userId), udid: dataGet.udid ?? "", animalId: Int(dataGet.animalId), selectedBornTypeId: Int(dataGet.selectedBornTypeId), breedAssocation: dataGet.breedAssocation ?? "" , custId: Int(dataGet.custmerId), listId: Int64(dataGet.listId), serverAnimalId: "",girlandoID:girlandoNoTextField.text ?? "")
                                            
                                            UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.dataEntryGirlandoSampleType.rawValue)
                                            UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.dataEntryGirlandoSampleTypeClear.rawValue)
                                            UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.dataEntryGirlandoSampleTypeClear.rawValue)
                                            tissueBttnOutlet.setTitle(dataGet.tissuName ?? "", for: .normal)
                                            
                                        }
                                        else{
                                            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                            
                                            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                self.byDefaultSetting()
                                                
                                            }
                                            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                            }
                                            
                                            alertController.addAction(okAction)
                                            alertController.addAction(cancelAction)
                                            
                                            self.present(alertController, animated: true, completion: nil)
                                            return
                                        }
                                    }
                                    else {
                                        
                                        saveAnimaldataGirlando(entity: Entities.animalAddTblEntity, earTag: dataGet.earTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "", damId: dataGet.offDamId ?? "" , sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "" , update: dataGet.status ?? "", breedRegNumber: dataGet.breedRegNumber ?? "" , tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "" , et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "" , orderId: self.orderId, orderSataus: dataGet.orderstatus ?? "" , breedId: dataGet.breedId ?? "", isSync: dataGet.isSync ?? "", providerId: Int(dataGet.providerId), tissuId: Int(dataGet.tissuId), sireIDAU: dataGet.sireIDAU ?? "", animalName: dataGet.animalName ?? "" , userId: Int(userId), udid: dataGet.udid ?? "", animalId: Int(dataGet.animalId), selectedBornTypeId: Int(dataGet.selectedBornTypeId), breedAssocation: dataGet.breedAssocation ?? "" , custId: Int(dataGet.custmerId), listId: Int64(dataGet.listId), serverAnimalId: "",girlandoID:girlandoNoTextField.text ?? "")
                                        
                                        UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.dataEntryGirlandoSampleType.rawValue)
                                        UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.dataEntryGirlandoSampleTypeClear.rawValue)
                                        tissueBttnOutlet.setTitle(dataGet.tissuName ?? "", for: .normal)
                                        
                                    }
                                    
                                    let animalData = fetchAnimaldataDairy(entityName: Entities.animalAddTblEntity, animalTag:Int(dataGet.animalId),orderId:orderId,userId:userId)
                                    let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: Int(dataGet.providerId), breedId: dataGet.breedId ?? "" )
                                    
                                    
                                    for k in 0 ..< animalData.count{
                                        let animalId = animalData[k] as! AnimaladdTbl
                                        for i in 0 ..< product.count{
                                            let data = product[i] as! GetProductTbl
                                            if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:Int(self.orderId ), customerID: customerId )
                                                if data12333.count > 0 {
                                                    let adonDat =  fetchProductAdonDataWithBVDV(entityName: Entities.getAdonTblEntity, prodId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue),adonId : LocalizedStrings.bvdvAddOnId)
                                                    if adonDat.count > 0 {
                                                        addedd = true
                                                        saveProductAdonTblEarTagGirlando(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: farmIdText, orderId: self.orderId, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",eartag:animalId.earTag ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue))
                                                        updateOrderStatusAnimal(entity: Entities.animalAddTblEntity, status: "true", orderId: self.orderId, userId: userId, animalId: Int(dataGet.animalId))
                                                    }
                                                }
                                                else {
                                                    saveProductAdonTblEarTagGirlando(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: farmIdText, orderId: self.orderId, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",eartag:animalId.earTag ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue))
                                                }
                                            }
                                            else {
                                                saveProductAdonTblEarTagGirlando(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId ?? "", productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: farmIdText, orderId: self.orderId, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",eartag:animalId.earTag ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue))
                                            }
                                            
                                            let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                            
                                            for j in 0 ..< addonArr.count {
                                                let addonDat = addonArr[j] as! GetAdonTbl
                                                if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                    let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.orderId, customerID:  customerId)
                                                    if data12333.count > 0 {
                                                        if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                            saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: self.orderId, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: farmIdText, animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                            updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue), status: "true")
                                                            
                                                        }
                                                        else {
                                                            saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: self.orderId, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: farmIdText, animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                        }
                                                    }
                                                }
                                                else {
                                                    saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: self.orderId, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: farmIdText, animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                }
                                            }
                                        }
                                        if data12333.count > 0 {
                                            if addedd == false {
                                                
                                                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAddedBVDV, comment: ""), preferredStyle: .alert)
                                                
                                                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                                    UIAlertAction in
                                                    deleteDataWithProduct(Int(dataGet.animalId))
                                                    deleteDataWithSubProduct(Int(dataGet.animalId))
                                                    deleteDataWithAnimal(Int(dataGet.animalId))
                                                    
                                                    self.byDefaultSetting()
                                                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
                                                    self.notificationLblCount.text = String(animalCount.count)
                                                    return
                                                }
                                                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                                    UIAlertAction in
                                                    deleteDataWithProduct(Int(dataGet.animalId))
                                                    deleteDataWithSubProduct(Int(dataGet.animalId))
                                                    deleteDataWithAnimal(Int(dataGet.animalId))
                                                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
                                                    self.notificationLblCount.text = String(animalCount.count)
                                                    return
                                                }
                                                
                                                alertController.addAction(okAction)
                                                alertController.addAction(cancelAction)
                                                
                                                self.present(alertController, animated: true, completion: nil)
                                                return
                                                
                                            }
                                        }
                                    }
                                    self.crossBtnOutlet.isHidden = false
                                    UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                                    UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                                    importFromListOutlet.isEnabled = true
                                    
                                    if fetchMergeDataListId(entityName: Entities.mergeDataEntryListTblEntity,listId: Int64(dataGet.listId),customerId: Int64(self.custmerId ?? 0)).count == 0 {
                                        let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ?? 0))
                                        let listObject = fetchList.object(at: 0) as? DataEntryList
                                        let listDescr = listObject?.listDesc
                                        saveMergeDataEntryList(entity: Entities.mergeDataEntryListTblEntity, customerId: Int64(self.custmerId ?? 0), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                    }
                                    
                                    let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ?? 0,providerId:pvid )
                                    if fetchObj.count != 0 {
                                        let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                        let obj = objectFetch?.listName
                                        let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId ?? 0)).count - 1
                                        
                                        if fetchAllMergeDta == 0 {
                                            let fetchNameDisplay = String(obj ?? "")
                                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                            mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                            mergeListBtnOulet.isHidden = false
                                        } else {
                                            let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                            mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                            mergeListBtnOulet.isHidden = false
                                        }
                                    }
                                }
                            }
                            createDataList()
                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
                            self.notificationLblCount.text = String(animalCount.count)
                            if animalCount.count == 0{
                                self.notificationLblCount.isHidden = true
                                self.countLbl.isHidden = true
                            } else {
                                self.notificationLblCount.isHidden = false
                                self.countLbl.isHidden = false
                            }
                        }
                        
                        let fetchCheckListId = fetchAllDataOrderListIDgET(entityName: Entities.animalAddTblEntity,ordestatus: "false",orderId:self.orderId,userId:self.userId,listId:0)
                        
                        if fetchCheckListId.count == 0{
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.noAnimalsAddedToOrder, comment: ""), duration: 2, position: .top)
                        }
                    })
                    alert.addAction(ok)
                    
                    DispatchQueue.main.async(execute: {
                        self.present(alert, animated: true)
                    })
                    
                } else {
                    let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: Entities.dataEntryAnimalAddTbl, userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ?? 0), providerId: self.pvid)
                    if fetchData11.count != 0 {
                        for i in 0...fetchData11.count - 1 {
                            let dataGet = fetchData11.object(at: i) as! DataEntryAnimaladdTbl
                            let fetchCountGirlando =  fetchAllDataAnimalGiirlando(entityName: Entities.animalAddTblEntity,earTag:dataGet.earTag ?? "",custmerId :Int(dataGet.custmerId)  ,userID :self.userId,orderId :self.orderId)
                            if fetchCountGirlando.count == 0 {
                                
                                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.orderId, customerID: customerId )
                                if data12333.count > 0{
                                    if self.tissueBttnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || self.tissueBttnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || tissueBttnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText || self.tissuId == 1 || self.tissuId == 18 {
                                        
                                        saveAnimaldataGirlando(entity: Entities.animalAddTblEntity, earTag: dataGet.earTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "", damId: dataGet.offDamId ?? "" , sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "" , update: dataGet.status ?? "", breedRegNumber: dataGet.breedRegNumber ?? "" , tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "" , et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "" , orderId: self.orderId, orderSataus: dataGet.orderstatus ?? "" , breedId: dataGet.breedId ?? "", isSync: dataGet.isSync ?? "", providerId: Int(dataGet.providerId), tissuId: Int(dataGet.tissuId), sireIDAU: dataGet.sireIDAU ?? "", animalName: dataGet.animalName ?? "" , userId: Int(userId), udid: dataGet.udid ?? "", animalId: Int(dataGet.animalId), selectedBornTypeId: Int(dataGet.selectedBornTypeId), breedAssocation: dataGet.breedAssocation ?? "" , custId: Int(dataGet.custmerId), listId: Int64(dataGet.listId), serverAnimalId: "",girlandoID:girlandoNoTextField.text ?? "")
                                        
                                        UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.dataEntryGirlandoSampleType.rawValue.localized)
                                        UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.dataEntryGirlandoSampleTypeClear.rawValue)
                                        tissueBttnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                        
                                    }
                                    else{
                                        let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                        
                                        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                            UIAlertAction in
                                            self.byDefaultSetting()
                                            
                                        }
                                        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                            UIAlertAction in
                                        }
                                        
                                        alertController.addAction(okAction)
                                        alertController.addAction(cancelAction)
                                        self.present(alertController, animated: true, completion: nil)
                                        return
                                    }
                                }
                                else {
                                    saveAnimaldataGirlando(entity: Entities.animalAddTblEntity, earTag: dataGet.earTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "", damId: dataGet.offDamId ?? "" , sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "" , update: dataGet.status ?? "", breedRegNumber: dataGet.breedRegNumber ?? "" , tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "" , et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "" , orderId: self.orderId, orderSataus: dataGet.orderstatus ?? "" , breedId: dataGet.breedId ?? "", isSync: dataGet.isSync ?? "", providerId: Int(dataGet.providerId), tissuId: Int(dataGet.tissuId), sireIDAU: dataGet.sireIDAU ?? "", animalName: dataGet.animalName ?? "" , userId: Int(userId), udid: dataGet.udid ?? "", animalId: Int(dataGet.animalId), selectedBornTypeId: Int(dataGet.selectedBornTypeId), breedAssocation: dataGet.breedAssocation ?? "" , custId: Int(dataGet.custmerId), listId: Int64(dataGet.listId), serverAnimalId: "", girlandoID:girlandoNoTextField.text ?? "")
                                    
                                    UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.dataEntryGirlandoSampleType.rawValue)
                                    UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.dataEntryGirlandoSampleTypeClear.rawValue)
                                    tissueBttnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                }
                                
                                
                                let animalData = fetchAnimaldataDairy(entityName: Entities.animalAddTblEntity, animalTag:Int(dataGet.animalId),orderId:orderId,userId:userId)
                                let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: Int(dataGet.providerId), breedId: dataGet.breedId ?? "" )
                                
                                for k in 0 ..< animalData.count{
                                    let animalId = animalData[k] as! AnimaladdTbl
                                    for i in 0 ..< product.count{
                                        let data = product[i] as! GetProductTbl
                                        if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                            let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.orderId, customerID: custmerId ?? 0)
                                            if data12333.count > 0 {
                                                let adonDat =  fetchProductAdonDataWithBVDV(entityName: Entities.getAdonTblEntity, prodId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue),adonId : LocalizedStrings.bvdvAddOnId)
                                                if adonDat.count > 0 {
                                                    addedd = true
                                                    saveProductAdonTblEarTagGirlando(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: farmIdText, orderId: self.orderId, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",eartag:animalId.earTag ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue))
                                                    updateOrderStatusAnimal(entity: Entities.animalAddTblEntity, status: "true", orderId: self.orderId, userId: userId, animalId: Int(dataGet.animalId))
                                                }
                                            }
                                            else {
                                                saveProductAdonTblEarTagGirlando(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: farmIdText, orderId: self.orderId, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",eartag:animalId.earTag ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue))
                                            }
                                        }
                                        else {
                                            saveProductAdonTblEarTagGirlando(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId ?? "", productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: farmIdText, orderId: self.orderId, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",eartag:animalId.earTag ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue))
                                        }
                                        
                                        let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                        
                                        for j in 0 ..< addonArr.count {
                                            let addonDat = addonArr[j] as! GetAdonTbl
                                            if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.orderId, customerID: custmerId ?? 0)
                                                if data12333.count > 0 {
                                                    if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: self.orderId, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: farmIdText, animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                        updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue), status: "true")
                                                        
                                                    }
                                                    else {
                                                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: self.orderId, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: farmIdText, animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                    }
                                                }
                                            }
                                            else {
                                                saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: self.orderId, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: farmIdText, animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                            }
                                        }
                                    }
                                    if data12333.count > 0 {
                                        if addedd == false {
                                            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAddedBVDV, comment: ""), preferredStyle: .alert)
                                            
                                            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                deleteDataWithProduct(Int(dataGet.animalId))
                                                deleteDataWithSubProduct(Int(dataGet.animalId))
                                                deleteDataWithAnimal(Int(dataGet.animalId))
                                                
                                                self.byDefaultSetting()
                                                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
                                                self.notificationLblCount.text = String(animalCount.count)
                                                return
                                            }
                                            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                deleteDataWithProduct(Int(dataGet.animalId))
                                                deleteDataWithSubProduct(Int(dataGet.animalId))
                                                deleteDataWithAnimal(Int(dataGet.animalId))
                                                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
                                                self.notificationLblCount.text = String(animalCount.count)
                                                return
                                            }
                                            
                                            alertController.addAction(okAction)
                                            alertController.addAction(cancelAction)
                                            self.present(alertController, animated: true, completion: nil)
                                            return
                                        }
                                    }
                                }
                                self.crossBtnOutlet.isHidden = false
                                
                                if fetchMergeDataListId(entityName: Entities.mergeDataEntryListTblEntity,listId: Int64(dataGet.listId),customerId: Int64(self.custmerId ?? 0)).count == 0 {
                                    let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ?? 0))
                                    let listObject = fetchList.object(at: 0) as? DataEntryList
                                    let listDescr = listObject?.listDesc
                                    
                                    saveMergeDataEntryList(entity: Entities.mergeDataEntryListTblEntity, customerId: Int64(self.custmerId ?? 0), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                }
                                
                                let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ?? 0,providerId:pvid )
                                if fetchObj.count != 0 {
                                    let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                    let obj = objectFetch?.listName
                                    let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId ?? 0)).count - 1
                                    
                                    if fetchAllMergeDta == 0 {
                                        let fetchNameDisplay = String(obj ?? "")
                                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                        mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                        mergeListBtnOulet.isHidden = false
                                    } else {
                                        let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                        mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                        mergeListBtnOulet.isHidden = false
                                    }
                                }
                                
                                UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                                UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                                importFromListOutlet.isEnabled = true
                            }
                        }
                        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
                        self.notificationLblCount.text = String(animalCount.count)
                        if animalCount.count == 0{
                            self.notificationLblCount.isHidden = true
                            self.countLbl.isHidden = true
                        } else {
                            self.notificationLblCount.isHidden = false
                            self.countLbl.isHidden = false
                        }
                    }
                }
            }
            else {
                let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: Entities.dataEntryAnimalAddTbl, userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ?? 0), providerId: self.pvid)
                if fetchData11.count != 0 {
                    for i in 0...fetchData11.count - 1 {
                        let dataGet = fetchData11.object(at: i) as! DataEntryAnimaladdTbl
                        let fetchCountGirlando =  fetchAllDataAnimalGiirlando(entityName: Entities.animalAddTblEntity,earTag:dataGet.earTag ?? "",custmerId :Int(dataGet.custmerId)  ,userID :self.userId,orderId :autoD)
                        if fetchCountGirlando.count == 0 {
                            let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.orderId, customerID: custmerId ?? 0)
                            if data12333.count > 0{
                                if self.tissueBttnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || self.tissueBttnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || tissueBttnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText || self.tissuId == 1 || self.tissuId == 18 {
                                    
                                    saveAnimaldataGirlando(entity: Entities.animalAddTblEntity, earTag: dataGet.earTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "", damId: dataGet.offDamId ?? "" , sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "" , update: dataGet.status ?? "", breedRegNumber: dataGet.breedRegNumber ?? "" , tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "" , et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "" , orderId: self.orderId, orderSataus: dataGet.orderstatus ?? "" , breedId: dataGet.breedId ?? "", isSync: dataGet.isSync ?? "", providerId: Int(dataGet.providerId), tissuId: Int(dataGet.tissuId), sireIDAU: dataGet.sireIDAU ?? "", animalName: dataGet.animalName ?? "" , userId: Int(userId), udid: dataGet.udid ?? "", animalId: Int(dataGet.animalId), selectedBornTypeId: Int(dataGet.selectedBornTypeId), breedAssocation: dataGet.breedAssocation ?? "" , custId: Int(dataGet.custmerId), listId: Int64(dataGet.listId), serverAnimalId: "",girlandoID:girlandoNoTextField.text ?? "")
                                    
                                    UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.dataEntryGirlandoSampleType.rawValue)
                                    UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.dataEntryGirlandoSampleTypeClear.rawValue)
                                    tissueBttnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                    
                                }
                                else{
                                    let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                    
                                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                        UIAlertAction in
                                        self.byDefaultSetting()
                                        
                                    }
                                    let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                        UIAlertAction in
                                    }
                                    alertController.addAction(okAction)
                                    alertController.addAction(cancelAction)
                                    self.present(alertController, animated: true, completion: nil)
                                    return
                                }
                            }
                            else {
                                saveAnimaldataGirlando(entity: Entities.animalAddTblEntity, earTag: dataGet.earTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "", damId: dataGet.offDamId ?? "" , sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "" , update: dataGet.status ?? "", breedRegNumber: dataGet.breedRegNumber ?? "" , tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "" , et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "" , orderId: self.orderId, orderSataus: dataGet.orderstatus ?? "" , breedId: dataGet.breedId ?? "", isSync: dataGet.isSync ?? "", providerId: Int(dataGet.providerId), tissuId: Int(dataGet.tissuId), sireIDAU: dataGet.sireIDAU ?? "", animalName: dataGet.animalName ?? "" , userId: Int(userId), udid: dataGet.udid ?? "", animalId: Int(dataGet.animalId), selectedBornTypeId: Int(dataGet.selectedBornTypeId), breedAssocation: dataGet.breedAssocation ?? "" , custId: Int(dataGet.custmerId), listId: Int64(dataGet.listId), serverAnimalId: "",girlandoID:girlandoNoTextField.text ?? "")
                                
                                UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.dataEntryGirlandoSampleType.rawValue)
                                UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.dataEntryGirlandoSampleTypeClear.rawValue)
                                tissueBttnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                            }
                            
                            
                            let animalData = fetchAnimaldataDairy(entityName: Entities.animalAddTblEntity, animalTag:Int(dataGet.animalId),orderId:orderId,userId:userId)
                            let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: Int(dataGet.providerId), breedId: dataGet.breedId ?? "" )
                            
                            for k in 0 ..< animalData.count{
                                let animalId = animalData[k] as! AnimaladdTbl
                                for i in 0 ..< product.count{
                                    let data = product[i] as! GetProductTbl
                                    if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                        let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.orderId, customerID: custmerId ?? 0)
                                        if data12333.count > 0 {
                                            let adonDat =  fetchProductAdonDataWithBVDV(entityName: Entities.getAdonTblEntity, prodId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue),adonId : LocalizedStrings.bvdvAddOnId)
                                            if adonDat.count > 0 {
                                                addedd = true
                                                saveProductAdonTblEarTagGirlando(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: farmIdText, orderId: self.orderId, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",eartag:animalId.earTag ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue))
                                                updateOrderStatusAnimal(entity: Entities.animalAddTblEntity, status: "true", orderId: self.orderId, userId: userId, animalId: Int(dataGet.animalId))
                                            }
                                        }
                                        else {
                                            saveProductAdonTblEarTagGirlando(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: farmIdText, orderId: self.orderId, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",eartag:animalId.earTag ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue))
                                        }
                                    }
                                    else {
                                        saveProductAdonTblEarTagGirlando(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId ?? "", productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: farmIdText, orderId: self.orderId, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",eartag:animalId.earTag ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue))
                                    }
                                    
                                    let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                    
                                    for j in 0 ..< addonArr.count {
                                        let addonDat = addonArr[j] as! GetAdonTbl
                                        if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                            let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.orderId, customerID: custmerId ?? 0)
                                            if data12333.count > 0 {
                                                if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                    saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: self.orderId, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: farmIdText, animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                    updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue), status: "true")
                                                }
                                                else {
                                                    saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: self.orderId, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: farmIdText, animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                }
                                            }
                                        }
                                        else {
                                            saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: self.orderId, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: farmIdText, animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                        }
                                    }
                                }
                                
                                if data12333.count > 0 {
                                    if addedd == false {
                                        let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAddedBVDV, comment: ""), preferredStyle: .alert)
                                        
                                        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                            UIAlertAction in
                                            deleteDataWithProduct(Int(dataGet.animalId))
                                            deleteDataWithSubProduct(Int(dataGet.animalId))
                                            deleteDataWithAnimal(Int(dataGet.animalId))
                                            
                                            self.byDefaultSetting()
                                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
                                            self.notificationLblCount.text = String(animalCount.count)
                                            return
                                        }
                                        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                            UIAlertAction in
                                            deleteDataWithProduct(Int(dataGet.animalId))
                                            deleteDataWithSubProduct(Int(dataGet.animalId))
                                            deleteDataWithAnimal(Int(dataGet.animalId))
                                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
                                            self.notificationLblCount.text = String(animalCount.count)
                                            return
                                        }
                                        
                                        alertController.addAction(okAction)
                                        alertController.addAction(cancelAction)
                                        self.present(alertController, animated: true, completion: nil)
                                        return
                                    }
                                }
                            }
                            
                            self.crossBtnOutlet.isHidden = false
                            UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                            UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                            importFromListOutlet.isEnabled = true
                            
                            if fetchMergeDataListId(entityName: Entities.mergeDataEntryListTblEntity,listId: Int64(dataGet.listId),customerId: Int64(self.custmerId ?? 0)).count == 0 {
                                let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ?? 0))
                                let listObject = fetchList.object(at: 0) as? DataEntryList
                                let listDescr = listObject?.listDesc
                                saveMergeDataEntryList(entity: Entities.mergeDataEntryListTblEntity, customerId: Int64(self.custmerId ?? 0), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                            }
                            
                            let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ?? 0,providerId:pvid )
                            if fetchObj.count != 0 {
                                let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                let obj = objectFetch?.listName
                                let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId ?? 0)).count - 1
                                
                                if fetchAllMergeDta == 0 {
                                    let fetchNameDisplay = String(obj ?? "")
                                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                    mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                    mergeListBtnOulet.isHidden = false
                                } else {
                                    let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                    mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                    mergeListBtnOulet.isHidden = false
                                }
                            }
                        }
                    }
                    
                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
                    self.notificationLblCount.text = String(animalCount.count)
                    if animalCount.count == 0{
                        self.notificationLblCount.isHidden = true
                        self.countLbl.isHidden = true
                    } else {
                        self.notificationLblCount.isHidden = false
                        self.countLbl.isHidden = false
                    }
                }
            }
            
            importBackroundView.isHidden = true
            importListMainView.isHidden = true
            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid)
            notificationLblCount.text = String(animalCount.count)
            if animalCount.count == 0{
                notificationLblCount.isHidden = true
                countLbl.isHidden = true
            } else {
                notificationLblCount.isHidden = false
                countLbl.isHidden = false
                self.showAlertforwithoutBarcodeAnimal(importListAnimal: nil)
            }
        }
        createDataList()
    }
    
    @IBAction func cancelBtnClickImportViewAction(_ sender: Any) {
        importBackroundView.isHidden = true
        importListMainView.isHidden = true
    }
    
    @IBAction func incrementalBarcodeButtonAction(_ sender: UIButton) {
        if UserDefaults.standard.bool(forKey: keyValue.matchedBarcodeFlag.rawValue) == true {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.barcodeSelectedStr, comment: "") )
        }
        else {
            guard scanBarcodeTextfield.text?.isEmpty == false else {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.enterBarcodeAlert, comment: "") )
                return
            }
            
            guard isBarCodeEndsWithNumber_GetIncrementedBarCode(scanBarcodeTextfield.text ?? "").isBarCodeEndsWithNumber else {
                if checkBarcode == false{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.barcodeMustEndWithNumAlert, comment: ""))
                }
                else {
                    sender.isSelected = false
                    incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                    UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                    self.isBarcodeAutoIncrementedEnabled = false
                    checkBarcode = false
                }
                return
            }
            
            if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
                sender.isSelected = false
                incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                self.isBarcodeAutoIncrementedEnabled = false
                checkBarcode = false
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                
            } else {
                sender.isSelected = true
                incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.checkImg)
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
                self.isBarcodeAutoIncrementedEnabled = true
                checkBarcode = false
            }
        }
    }
    
    @IBAction func addAction(_ sender: UIButton) {
        let tag = sender.tag
        if tag == 0 {
            view1.isHidden = false
            view2.isHidden = true
            closeImage1.addGestureRecognizer(tapRec)
        } else {
            view1.isHidden = true
            view2.isHidden = false
            closeImage2.addGestureRecognizer(tapRec)
        }
    }
    
    @IBAction func viewAnimalClick(_ sender: Any) {
        barcodeScreen = false
        selectedDate = Date()
        let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.viewAnimalsControllerVC) as? ViewAnimalsController
        vc!.productBackSave = false
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func EtBtnAction(_ sender: UIButton) {
        view.endEditing(true)
        selectedBornTypeId = 3
        etBtn = "Et"
        multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
        singleBttn.layer.borderColor = UIColor.gray.cgColor
        etBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        etBttn.layer.borderWidth = 2
        multipleBirthBttn.layer.borderWidth = 0.5
        singleBttn.layer.borderWidth = 0.5
        
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func multiBirthBtnAction(_ sender: UIButton) {
        view.endEditing(true)
        selectedBornTypeId = 2
        etBtn = LocalizedStrings.multipleBirthStr
        multipleBirthBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        etBttn.layer.borderColor = UIColor.gray.cgColor
        singleBttn.layer.borderColor = UIColor.gray.cgColor
        etBttn.layer.borderWidth = 0.5
        multipleBirthBttn.layer.borderWidth = 2
        singleBttn.layer.borderWidth = 0.5
        _ = statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func singleBtnAction(_ sender: UIButton) {
        view.endEditing(true)
        selectedBornTypeId = 1
        etBtn = LocalizedStrings.singlesText
        singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        etBttn.layer.borderColor = UIColor.gray.cgColor
        multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
        etBttn.layer.borderWidth = 0.5
        multipleBirthBttn.layer.borderWidth = 0.5
        singleBttn.layer.borderWidth = 2
        _ = statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func backBtnClk(_ sender: UIButton) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func dateAction(_ sender: Any) {
        barcodeEnable = true
        self.view.endEditing(true)
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            dateTextField.isHidden = false
        } else {
            dateTextField.isHidden = true
            calenderView.isHidden = false
            calenderbkg.isHidden = false
            calenderView.layer.cornerRadius = 30
            calenderView.layer.masksToBounds = true
            doDatePicker()
        }
        _ = statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func menuBtnClk(_ sender: UIButton) {
        self.view.makeCorner(withRadius: 40)
        self.sideMenuViewController?.presentRightMenuViewController()
    }
    
    @IBAction func maleFemaleAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if(genderToggleFlag == 0) {
            self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 1
            genderString = NSLocalizedString("Male", comment: "")
        }
        else {
            self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            genderString = NSLocalizedString("Female", comment: "")
            genderToggleFlag = 0
        }
        _ = statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func offLineRestrictionPopUp(_ sender: UIButton) {
        let popOverVC = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil).instantiateViewController(withIdentifier: ClassIdentifiers.offLineRestrictionVC) as! OffLineRestrictionVC
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    
    @IBAction func addAnimalAction(_ sender: Any) {
        self.view.endEditing(true)
        addContiuneBtn = 1
        isAddMoreAnimal = true
        addAnimalBtn(completionHandler: { (success) -> Void in
            self.scanBarcodeTextfield.becomeFirstResponder()
        })
    }
    
    @IBAction func continueBtnAction(_ sender: Any) {
        addContiuneBtn = 2
        let  userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let  orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        identify1 = true
        let data1 = fetchAllDataOrderStatus(entityName: Entities.animalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
        validateBreed(completionHandler: { (success) -> Void in
            if success == true {
                let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                
                if  identyCheck == false || identyCheck == nil{
                    if data1.count > 0 {
                        if scanEarTagTextField.text == "" && scanBarcodeTextfield.text == ""{
                            if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil {
                                
                                let data1 = fetchAllDataOrderStatus(entityName: Entities.animalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
                                if data1.count > 0 {
                                    self.NavigateToOrderingProductSelectionScreen()
                                }
                                
                            } else {
                                if identyCheck == false || identyCheck == nil {
                                    if  UserDefaults.standard.value(forKey: keyValue.page.rawValue) == nil {
                                        self.NavigateToOrderingProductSelectionScreen()
                                    }
                                    else{
                                      self.NavigateToOrderingProductSelectionScreen(screenType: 2)
                                        self.NavigateToOrderingProductSelectionScreen(screenType: 2)
                                    }
                                }
                                else {
                                    self.NavigateToOrderingProductSelectionScreen(screenType: 2)
                                }
                            }
                        } else {
                            addAnimalBtn(completionHandler: { (success) -> Void in
                                if success == true {
                                    self.validateBreed(completionHandler: { (success) -> Void in
                                        if success == true{
                                            let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                                            if  identyCheck == true {
                                                
                                                let data1 = fetchAllDataOrderStatus(entityName: Entities.animalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
                                                if data1.count > 0 {
                                                    self.NavigateToOrderingProductSelectionScreen()
                                                }
                                            }  else {
                                                if UserDefaults.standard.value(forKey: keyValue.page.rawValue) == nil {
                                                    self.NavigateToOrderingProductSelectionScreen()
                                                }
                                                else{
                                                    self.NavigateToOrderingProductSelectionScreen(screenType: 2)
                                                }
                                            }
                                        }
                                    })
                                }
                                
                            })
                        }
                    }
                    else {
                        addAnimalBtn(completionHandler: { (success) -> Void in
                            if success == true {
                                self.validateBreed(completionHandler: { (success) -> Void in
                                    if success == true{
                                        if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil{
                                            self.NavigateToOrderingProductSelectionScreen()
                                        } else {
                                            self.NavigateToOrderingProductSelectionScreen()
                                        }
                                    }
                                })
                            }
                        })
                    }
                }
                else{
                    if data1.count > 0 {
                        if scanEarTagTextField.text == "" && scanBarcodeTextfield.text == ""{
                            let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                            if  identyCheck == true {
                                self.NavigateToOrderingProductSelectionScreen(screenType: 2)
                            }  else {
                                if  UserDefaults.standard.value(forKey: keyValue.page.rawValue) == nil {
                                    self.NavigateToOrderingProductSelectionScreen()
                                }
                                else{
                                    self.NavigateToOrderingProductSelectionScreen(screenType: 2)
                                }
                            }
                        }
                        else{
                            addAnimalBtn(completionHandler: { (success) -> Void in
                                if success == true {
                                    self.validateBreed(completionHandler: { (success) -> Void in
                                        if success == true{
                                            let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                                            if identyCheck == true {
                                                self.NavigateToOrderingProductSelectionScreen(screenType: 2)
                                            }
                                            else {
                                                if  UserDefaults.standard.value(forKey: keyValue.page.rawValue) == nil {
                                                    self.NavigateToOrderingProductSelectionScreen()
                                                }
                                                else{
                                                    self.NavigateToOrderingProductSelectionScreen(screenType: 2)
                                                }
                                            }
                                        }
                                    })
                                }
                            })
                        }
                    }
                    else{
                        addAnimalBtn(completionHandler: { (success) -> Void in
                            if success == true {
                                self.validateBreed(completionHandler: { (success) -> Void in
                                    if success == true{
                                        let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                                        if identyCheck == true {
                                            self.NavigateToOrderingProductSelectionScreen(screenType: 2)
                                        }
                                        else {
                                            if  UserDefaults.standard.value(forKey: keyValue.page.rawValue) == nil {
                                                self.NavigateToOrderingProductSelectionScreen()
                                            }
                                            else{
                                                self.NavigateToOrderingProductSelectionScreen(screenType: 2)
                                            }
                                        }
                                    }
                                })
                            }
                        })
                    }
                }
            }
        })
    }
    @IBAction func breedRegAction(_ sender: Any) {
        breedRegArr = fetchAllDataProductBeefBreedSociety(entityName: Entities.getBreedSocietiesTblEntity, productId: 17)
        if breedRegArr.count == 1 {
            return
        }
        btnTag = 30
        view.endEditing(true)
        self.tableViewpop()
        var yFrame = (breedRegLbl.frame.minY + 130) - self.scrolView.contentOffset.y
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
            case 1334:
                yFrame = (breedRegLbl.frame.minY + 105) - self.scrolView.contentOffset.y
            case 1920, 2208:
                yFrame = (breedRegLbl.frame.minY + 110) - self.scrolView.contentOffset.y
            case 2436:
                break
            case 2688,2796:
                break
            case 1792:
                yFrame = (breedRegLbl.frame.minY + 143) - self.scrolView.contentOffset.y
            default:
                break
            }
        }
        if breedRegArr.count < 2 {
            droperTableView.frame = CGRect(x: 25,y: yFrame,width: breedRegBttn.frame.width,height: 80)
            
        } else {
            droperTableView.frame = CGRect(x: 25,y: yFrame,width: breedRegBttn.frame.width,height: 180)
        }
        droperTableView.reloadData()
    }
    
    @IBAction func breedAction(_ sender: UIButton) {
        let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        breedArr =  fetchBreedData(entityName: Entities.getBreedsTblEntity, provId: pvid)
        if breedArr.count == 1 {
            return
        }
        
        btnTag = 20
        view.endEditing(true)
        self.tableViewpop()
        var yFrame = (breedLbl.frame.minY + 130) - self.scrolView.contentOffset.y
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
            case 1334:
                yFrame = (breedLbl.frame.minY + 105) - self.scrolView.contentOffset.y
            case 1920, 2208:
                yFrame = (breedLbl.frame.minY + 110) - self.scrolView.contentOffset.y
            case 2436:
                break
            case 2688,2796:
                break
            case 1792:
                yFrame = (breedLbl.frame.minY + 143) - self.scrolView.contentOffset.y
            default:
                break
            }
        }
        
        droperTableView.frame = CGRect(x: 30,y: yFrame,width: 150,height: 80)
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func tissueBtnnAction(_ sender: UIButton) {
        btnTag = 10
        view.endEditing(true)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        tissueArr =  fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
        self.tableViewpop()
        var yFrame = (tissueLbl.frame.minY + 130) - self.scrolView.contentOffset.y
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
            case 1334:
                yFrame = (tissueLbl.frame.minY + 105) - self.scrolView.contentOffset.y
            case 1920, 2208:
                yFrame = (tissueLbl.frame.minY + 110) - self.scrolView.contentOffset.y
            case 2436:
                break
            case 2688,2796:
                break
            case 1792:
                yFrame = (tissueLbl.frame.minY + 143) - self.scrolView.contentOffset.y
            default:
                break
            }
        }
        droperTableView.frame = CGRect(x: 30,y: yFrame,width: 150,height: 150)
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @IBAction func acnADHAnimalList(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.adhAnimalVC) as? ADHAnimalVC
        vc!.bckRetain = true
        self.navigationController?.pushViewController(vc!, animated: false)
    }
    
    @IBAction func scanButtonAction(_ sender: UIButton) {
        barcodeScreen = true
        let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.cameraViewControllerVC) as? CameraViewController
        vc?.delegate = self
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func offlineBtnAction(_ sender: UIButton) {
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(OrderingAnimalVCGirlando.buttonbgPressed), for: .touchUpInside)
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
    
    @IBAction func ocrBtnAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.textScanVC) as? TextScanVC
        vc!.delegate = self
        self.navigationController?.pushViewController(vc!, animated: false)
    }
    
    @IBAction func clearFromAction(_ sender: Any) {
        self.view.endEditing(true)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message: NSLocalizedString(LocalizedStrings.wantToResetForm, comment: ""), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("No",comment: ""), style: .default, handler: { action in
            
        })
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title:NSLocalizedString("Yes",comment: "") , style: .default, handler: { action in
            self.textFieldBackroungGrey()
            self.byDefaultSetting()
            let tissueName = UserDefaults.standard.string(forKey: keyValue.girlandoSampleTypeClear.rawValue)
            if UserDefaults.standard.string(forKey: keyValue.girlandoSampleTypeClear.rawValue) == nil || UserDefaults.standard.string(forKey: keyValue.girlandoSampleTypeClear.rawValue) == ""{
                self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
                for items in self.tissueArr{
                    let tissue = items  as? GetSampleTbl
                    let checkdefault  = tissue?.isDefault
                    if checkdefault == true{
                        self.tissueBttnOutlet.setTitle(tissue?.sampleName, for: .normal)
                        self.tissuId =  Int(tissue?.sampleId ?? 4)
                    }
                }
            }
            else {
                let codeId = fetchBreedDataTissueCode(entityName: Entities.getSampleTblEntity,provId: pvid,tissueName:tissueName!)
                let naabFetch1 = codeId.value(forKey: keyValue.sampleId.rawValue) as? NSArray
                if naabFetch1!.count != 0 {
                    let breedIdGet = naabFetch1![0] as? Int
                    self.tissuId = breedIdGet!
                }
                self.tissueBttnOutlet.setTitle(tissueName, for: .normal)
                UserDefaults.standard.set(self.tissueBttnOutlet.titleLabel!.text, forKey: keyValue.girlandoSampleType.rawValue)
            }
            
            let inrementCheck = UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncrementalClear.rawValue)
            if inrementCheck == true {
                self.isBarcodeAutoIncrementedEnabled = true
                self.incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.checkImg)
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
                
            } else {
                self.incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                self.isBarcodeAutoIncrementedEnabled = false
            }
            self.scanBarcodeTextfield.becomeFirstResponder()
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    @IBAction func checkBoxButtonAction(_ sender: UIButton) {
        if !sender.isSelected{
            sender.isSelected = true
            nonRegisterCheckBox.image = UIImage(named: ImageNames.checkImg)
            girlandoNoTextField.isUserInteractionEnabled = false
            girlandoNoTextField.text = String(currentTimeInMilliSeconds())
        } else {
            girlandoNoTextField.text = ""
            sender.isSelected = false
            nonRegisterCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
            girlandoNoTextField.isUserInteractionEnabled = true
        }
    }
}
