//
//  BeefAnimalGlobalHD50KVCActionMethods.swift
//  SearchPoint
//
//  Created by Mobile Programming on 11/03/24.
//

import Foundation
import UIKit
import CoreBluetooth

extension BeefAnimalGlobalHD50KVC {
    @IBAction func cancelBtnAction(_ sender: Any) {
        importListMainView.isHidden = true
        importBackroundView.isHidden = true
    }
    
    @IBAction func okBtnClickImportView(_ sender: Any) {
        if listId == 0 {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.selectListToImport, comment: "") )
            
            return
        }
        let allDataAnimalTbl1 = fetchAllDataAnimalAnimalIgnoreCase(entityName: Entities.dataEntryBeefAnimalAddTblEntity,custmerId :UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userID :self.userId,listId:Int64(self.listId))
        
        if allDataAnimalTbl1.count == 0 {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.noAnimalsAddedStr, comment: ""))
            importListMainView.isHidden = true
            importBackroundView.isHidden = true
            return
        }
        
        if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
            let aData =  fetchAnimaldataDairyOrderIdUserId(entityName: Entities.beefAnimalAddTblEntity, orderId: autoD, userId: userId,providerId:self.pvid)
            if aData.count > 0 {
                for k in 0 ..< aData.count{
                    let data1 = aData[k] as! BeefAnimaladdTbl
                    let earTag = data1.animalTag
                    
                    let dataEntryVALE = fetchAllDataGlobalEarTAG(entityName: Entities.dataEntryBeefAnimalAddTblEntity,userId:userId,orderId:orderId,listid:Int64(listId),custmerId:Int64(custmerId ),providerId:pvid,earTag: earTag ?? "", orderStatus: "false") as! [DataEntryBeefAnimaladdTbl]
                    
                    if dataEntryVALE.count > 0 {
                        self.conflictArr.append(contentsOf: dataEntryVALE)
                    }
                }
                if conflictArr.count > 0 {
                    let count1 = conflictArr.count
                    let alertPrint = String(count1) + " " + NSLocalizedString(LocalizedStrings.selectActionToBePerformed, comment: "")
                    let alert = UIAlertController(title: listNameString, message: alertPrint, preferredStyle: .alert)
                    let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: { action in
                        self.importBackroundView.isHidden = true
                        self.importListMainView.isHidden = true
                        
                    })
                    alert.addAction(cancel)
                    
                    let ok = UIAlertAction(title: NSLocalizedString("Ignore", comment: ""), style: .default, handler: { [self] action in
                        let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: Entities.dataEntryBeefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                        if fetchData11.count != 0 {
                            for i in 0...fetchData11.count - 1 {
                                let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                                let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                                if fetchCountGirlando.count == 0 {
                                    let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:orderId, customerID: custmerId)
                                    if data12333.count > 0{
                                        if tissueBttnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || tissueBttnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || tissueBttnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                                            
                                            saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "" , date: dataGet.date ?? ""  , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU:  dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId),productId:Int(dataGet.productId),custId: Int(dataGet.custmerId), listId: dataGet.listId, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                            
                                            UserDefaults.standard.setValue(dataGet.breedName, forKey: keyValue.beefBreed.rawValue)
                                            UserDefaults.standard.setValue(dataGet.tissuName, forKey: keyValue.beefTSU.rawValue)
                                            tissueBttnOutlet.setTitle(dataGet.tissuName ?? "", for: .normal)
                                            if dataGet.breedName == LocalizedStrings.breedNameX{
                                                breedBtnOutlet.setTitle("XX", for: .normal)
                                            } else {
                                                breedBtnOutlet.setTitle(dataGet.breedName, for: .normal)
                                            }
                                            createDataList()
                                        }
                                        else {
                                            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                            
                                            let okAction = UIAlertAction(title: NSLocalizedString("YES", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                self.byDefaultSetting()
                                                
                                            }
                                            let cancelAction = UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                
                                                deleteDataWithProductwithEntity(Int(dataGet.animalId),entity: Entities.productAdonAnimlBeefTblEntity)
                                                deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.subProductBeefTblEntity)
                                                deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.beefAnimalAddTblEntity)
                                                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                                                self.notificationLblCount.text = String(animalCount.count)
                                                self.byDefaultSetting()
                                                return
                                                
                                            }
                                            
                                            alertController.addAction(cancelAction)
                                            alertController.addAction(okAction)
                                            self.present(alertController, animated: true, completion: nil)
                                            return
                                        }
                                    }
                                    else {
                                        saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "" , date: dataGet.date ?? ""  , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU:  dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId),productId:Int(dataGet.productId),custId: Int(dataGet.custmerId), listId: dataGet.listId, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                        
                                        UserDefaults.standard.setValue(dataGet.breedName, forKey: keyValue.beefBreed.rawValue)
                                        UserDefaults.standard.setValue(dataGet.tissuName, forKey: keyValue.beefTSU.rawValue)
                                        tissueBttnOutlet.setTitle(dataGet.tissuName ?? "", for: .normal)
                                        if dataGet.breedName == LocalizedStrings.breedNameX{
                                            breedBtnOutlet.setTitle("XX", for: .normal)
                                        } else {
                                            breedBtnOutlet.setTitle(dataGet.breedName, for: .normal)
                                        }
                                        createDataList()
                                    }
                                    
                                    let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                                    
                                    let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                                    
                                    for k in 0 ..< animalData.count{
                                        let animalId = animalData[k] as! BeefAnimaladdTbl
                                        for i in 0 ..< product.count {
                                            let data = product[i] as! GetProductTblBeef
                                            saveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: animalId.farmId ?? "", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "", orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: true)
                                            
                                            let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                            
                                            for j in 0 ..< addonArr.count {
                                                let addonDat = addonArr[j] as! GetAdonTbl
                                                if data12333.count > 0 {
                                                    if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                        saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                        updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: Int(addonDat.adonId), status: "true")
                                                    }
                                                    else {
                                                        saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                    }
                                                }
                                                else {
                                                    saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                }
                                                statusOrder = false
                                                UserDefaults.standard.removeObject(forKey: keyValue.review.rawValue)
                                                self.animalSucInOrder = ""
                                            }
                                        }
                                    }
                                    
                                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                                    notificationLblCount.text = String(animalCount.count)
                                    if animalCount.count == 0{
                                        self.notificationLblCount.isHidden = true
                                        self.countLbl.isHidden = true
                                    } else {
                                        self.notificationLblCount.isHidden = false
                                        self.countLbl.isHidden = false
                                    }
                                    self.globalCrossBtnOutlet.isHidden = false
                                    
                                    UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                                    UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                                    globalImportFromOutlet.isEnabled = true
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                                    
                                    showAlertforwithoutBarcodeAnimal(importListAnimal: allDataAnimalTbl1 as! [DataEntryBeefAnimaladdTbl])
                                    if fetchMergeDataListId(entityName: Entities.mergeDataEntryListTblEntity,listId: Int64(dataGet.listId),customerId: Int64(self.custmerId )).count == 0 {
                                        
                                        let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ))
                                        let listObject = fetchList.object(at: 0) as? DataEntryList
                                        let listDescr = listObject?.listDesc
                                        saveMergeDataEntryList(entity: Entities.mergeDataEntryListTblEntity, customerId: Int64(self.custmerId ), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                        
                                    }
                                    
                                    let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ,providerId:pvid )
                                    if fetchObj.count != 0 {
                                        
                                        let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                        let obj = objectFetch?.listName
                                        let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
                                        
                                        if fetchAllMergeDta == 0 {
                                            let fetchNameDisplay = String(obj ?? "")
                                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                            globalMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                            globalMergeListBtnOulet.isHidden = false
                                        } else {
                                            let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                            globalMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                            globalMergeListBtnOulet.isHidden = false
                                        }
                                    }
                                }
                                let fetchCheckListId = fetchAllDataOrderListIDgET(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false",orderId:self.orderId,userId:self.userId,listId:0)
                                
                                if fetchCheckListId.count == 0{
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noAnimalsAddedToOrder, comment: ""), duration: 2, position: .top)
                                    self.importBackroundView.isHidden = true
                                    self.importListMainView.isHidden = true
                                }
                            }
                        }
                    })
                    alert.addAction(ok)
                    self.importBackroundView.isHidden = true
                    self.importListMainView.isHidden = true
                    DispatchQueue.main.async(execute: {
                        self.present(alert, animated: true)
                    })
                }else {
                    let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: Entities.dataEntryBeefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                    if fetchData11.count != 0 {
                        for i in 0...fetchData11.count - 1 {
                            let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                            let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                            if fetchCountGirlando.count == 0 {
                                
                                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:orderId, customerID: custmerId)
                                if data12333.count > 0{
                                    if tissueBttnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || tissueBttnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || tissueBttnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                                        
                                        saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "" , date: dataGet.date ?? ""  , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU:  dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId),productId:Int(dataGet.productId),custId: Int(dataGet.custmerId), listId: dataGet.listId, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                        
                                        UserDefaults.standard.setValue(dataGet.breedName, forKey: keyValue.beefBreed.rawValue)
                                        UserDefaults.standard.setValue(dataGet.tissuName, forKey: keyValue.beefTSU.rawValue)
                                        tissueBttnOutlet.setTitle(dataGet.tissuName ?? "", for: .normal)
                                        if dataGet.breedName == LocalizedStrings.breedNameX{
                                            breedBtnOutlet.setTitle("XX", for: .normal)
                                        } else {
                                            breedBtnOutlet.setTitle(dataGet.breedName, for: .normal)
                                        }
                                        createDataList()
                                    }
                                    else {
                                        let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                        
                                        let okAction = UIAlertAction(title: NSLocalizedString("YES", comment: ""), style: UIAlertAction.Style.default) {
                                            UIAlertAction in
                                            self.byDefaultSetting()
                                            
                                        }
                                        let cancelAction = UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: UIAlertAction.Style.default) {
                                            UIAlertAction in
                                            
                                            deleteDataWithProductwithEntity(Int(dataGet.animalId),entity: Entities.productAdonAnimlBeefTblEntity)
                                            deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.subProductBeefTblEntity)
                                            deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.beefAnimalAddTblEntity)
                                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                                            self.notificationLblCount.text = String(animalCount.count)
                                            self.byDefaultSetting()
                                            return
                                        }
                                        alertController.addAction(cancelAction)
                                        alertController.addAction(okAction)
                                        self.present(alertController, animated: true, completion: nil)
                                        return
                                    }
                                }
                                else {
                                    saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "" , date: dataGet.date ?? ""  , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU:  dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId),productId:Int(dataGet.productId),custId: Int(dataGet.custmerId), listId: dataGet.listId, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                    
                                    UserDefaults.standard.setValue(dataGet.breedName, forKey: keyValue.beefBreed.rawValue)
                                    UserDefaults.standard.setValue(dataGet.tissuName, forKey: keyValue.beefTSU.rawValue)
                                    tissueBttnOutlet.setTitle(dataGet.tissuName ?? "", for: .normal)
                                    if dataGet.breedName == LocalizedStrings.breedNameX{
                                        breedBtnOutlet.setTitle("XX", for: .normal)
                                    } else {
                                        breedBtnOutlet.setTitle(dataGet.breedName, for: .normal)
                                    }
                                    createDataList()
                                }
                                
                                let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                                let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                                
                                for k in 0 ..< animalData.count{
                                    let animalId = animalData[k] as! BeefAnimaladdTbl
                                    for i in 0 ..< product.count {
                                        let data = product[i] as! GetProductTblBeef
                                        saveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: animalId.farmId ?? "", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "", orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: true)
                                        
                                        let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                        for j in 0 ..< addonArr.count {
                                            let addonDat = addonArr[j] as! GetAdonTbl
                                            if data12333.count > 0 {
                                                if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                    saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                    updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: Int(addonDat.adonId), status: "true")
                                                }
                                                else {
                                                    saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                }
                                            }
                                            else {
                                                saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                            }
                                            statusOrder = false
                                            UserDefaults.standard.removeObject(forKey: keyValue.review.rawValue)
                                            self.animalSucInOrder = ""
                                        }
                                    }
                                }
                                
                                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                                notificationLblCount.text = String(animalCount.count)
                                if animalCount.count == 0{
                                    self.notificationLblCount.isHidden = true
                                    self.countLbl.isHidden = true
                                } else {
                                    self.notificationLblCount.isHidden = false
                                    self.countLbl.isHidden = false
                                }
                                self.globalCrossBtnOutlet.isHidden = false
                                UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                                UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                                globalImportFromOutlet.isEnabled = true
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                                showAlertforwithoutBarcodeAnimal(importListAnimal: allDataAnimalTbl1 as! [DataEntryBeefAnimaladdTbl])
                                if fetchMergeDataListId(entityName: Entities.mergeDataEntryListTblEntity,listId: Int64(dataGet.listId),customerId: Int64(self.custmerId )).count == 0 {
                                    
                                    let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ))
                                    let listObject = fetchList.object(at: 0) as? DataEntryList
                                    let listDescr = listObject?.listDesc
                                    saveMergeDataEntryList(entity: Entities.mergeDataEntryListTblEntity, customerId: Int64(self.custmerId ), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                }
                                
                                let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ,providerId:pvid )
                                if fetchObj.count != 0 {
                                    
                                    let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                    let obj = objectFetch?.listName
                                    let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
                                    
                                    if fetchAllMergeDta == 0 {
                                        let fetchNameDisplay = String(obj ?? "")
                                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                        globalMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                        globalMergeListBtnOulet.isHidden = false
                                    } else {
                                        let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                        globalMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                        globalMergeListBtnOulet.isHidden = false
                                    }
                                }
                            }
                            let fetchCheckListId = fetchAllDataOrderListIDgET(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false",orderId:self.orderId,userId:self.userId,listId:0)
                            
                            if fetchCheckListId.count == 0{
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.noAnimalsAddedToOrder, comment: ""), duration: 2, position: .top)
                                self.importBackroundView.isHidden = true
                                self.importListMainView.isHidden = true
                            }
                        }
                    }
                }
                
            } else {
                let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: Entities.dataEntryBeefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                if fetchData11.count != 0 {
                    
                    for i in 0...fetchData11.count - 1 {
                        let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                        let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                        if fetchCountGirlando.count == 0 {
                            
                            let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:orderId, customerID: custmerId)
                            if data12333.count > 0{
                                if tissueBttnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || tissueBttnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || tissueBttnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                                    
                                    saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "" , date: dataGet.date ?? ""  , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU:  dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId),productId:Int(dataGet.productId),custId: Int(dataGet.custmerId), listId: dataGet.listId, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                    
                                    UserDefaults.standard.setValue(dataGet.breedName, forKey: keyValue.beefBreed.rawValue)
                                    UserDefaults.standard.setValue(dataGet.tissuName, forKey: keyValue.beefTSU.rawValue)
                                    tissueBttnOutlet.setTitle(dataGet.tissuName ?? "", for: .normal)
                                    if dataGet.breedName == LocalizedStrings.breedNameX{
                                        breedBtnOutlet.setTitle("XX", for: .normal)
                                    } else {
                                        breedBtnOutlet.setTitle(dataGet.breedName, for: .normal)
                                    }
                                    createDataList()
                                }
                                else {
                                    let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                    
                                    let okAction = UIAlertAction(title: NSLocalizedString("YES", comment: ""), style: UIAlertAction.Style.default) {
                                        UIAlertAction in
                                        self.byDefaultSetting()
                                        
                                    }
                                    let cancelAction = UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: UIAlertAction.Style.default) {
                                        UIAlertAction in
                                        
                                        deleteDataWithProductwithEntity(Int(dataGet.animalId),entity: Entities.productAdonAnimlBeefTblEntity)
                                        deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.subProductBeefTblEntity)
                                        deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.beefAnimalAddTblEntity)
                                        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                                        self.notificationLblCount.text = String(animalCount.count)
                                        self.byDefaultSetting()
                                        return
                                    }
                                    
                                    alertController.addAction(cancelAction)
                                    alertController.addAction(okAction)
                                    self.present(alertController, animated: true, completion: nil)
                                    return
                                }
                            }
                            else {
                                saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "" , date: dataGet.date ?? ""  , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU:  dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId),productId:Int(dataGet.productId),custId: Int(dataGet.custmerId), listId: dataGet.listId, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                
                                UserDefaults.standard.setValue(dataGet.breedName, forKey: keyValue.beefBreed.rawValue)
                                UserDefaults.standard.setValue(dataGet.tissuName, forKey: keyValue.beefTSU.rawValue)
                                tissueBttnOutlet.setTitle(dataGet.tissuName ?? "", for: .normal)
                                if dataGet.breedName == LocalizedStrings.breedNameX{
                                    breedBtnOutlet.setTitle("XX", for: .normal)
                                } else {
                                    breedBtnOutlet.setTitle(dataGet.breedName, for: .normal)
                                }
                                createDataList()
                            }
                            
                            let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                            let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                            
                            for k in 0 ..< animalData.count{
                                let animalId = animalData[k] as! BeefAnimaladdTbl
                                for i in 0 ..< product.count {
                                    let data = product[i] as! GetProductTblBeef
                                    saveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: animalId.farmId ?? "", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "", orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: true)
                                    
                                    let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                    
                                    for j in 0 ..< addonArr.count {
                                        let addonDat = addonArr[j] as! GetAdonTbl
                                        if data12333.count > 0 {
                                            if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: Int(addonDat.adonId), status: "true")
                                            }
                                            else {
                                                saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                            }
                                        }
                                        else {
                                            saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                        }
                                        
                                        statusOrder = false
                                        UserDefaults.standard.removeObject(forKey: keyValue.review.rawValue)
                                        self.animalSucInOrder = ""
                                    }
                                }
                            }
                            
                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                            notificationLblCount.text = String(animalCount.count)
                            if animalCount.count == 0{
                                self.notificationLblCount.isHidden = true
                                self.countLbl.isHidden = true
                            } else {
                                self.notificationLblCount.isHidden = false
                                self.countLbl.isHidden = false
                            }
                            self.globalCrossBtnOutlet.isHidden = false
                            UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                            UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                            globalImportFromOutlet.isEnabled = true
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                            showAlertforwithoutBarcodeAnimal(importListAnimal: allDataAnimalTbl1 as! [DataEntryBeefAnimaladdTbl])
                            if fetchMergeDataListId(entityName: Entities.mergeDataEntryListTblEntity,listId: Int64(dataGet.listId),customerId: Int64(self.custmerId )).count == 0 {
                                
                                let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ))
                                let listObject = fetchList.object(at: 0) as? DataEntryList
                                let listDescr = listObject?.listDesc
                                saveMergeDataEntryList(entity: Entities.mergeDataEntryListTblEntity, customerId: Int64(self.custmerId ), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                
                            }
                            let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ,providerId:pvid )
                            
                            if fetchObj.count != 0 {
                                let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                let obj = objectFetch?.listName
                                let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
                                
                                if fetchAllMergeDta == 0 {
                                    let fetchNameDisplay = String(obj ?? "")
                                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                    globalMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                    globalMergeListBtnOulet.isHidden = false
                                } else {
                                    let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                    globalMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                    globalMergeListBtnOulet.isHidden = false
                                }
                            }
                        }
                    }
                    
                }
            }
            
            importListMainView.isHidden = true
            importBackroundView.isHidden = true
            
        } else {
            let aData =  fetchAnimaldataDairyOrderIdUserId(entityName: Entities.beefAnimalAddTblEntity, orderId: autoD, userId: userId,providerId:self.pvid)
            if aData.count > 0 {
                for k in 0 ..< aData.count{
                    let data1 = aData[k] as! BeefAnimaladdTbl
                    let earTag = data1.animalTag
                    
                    let dataEntryVALE = fetchAllDataGlobalEarTAG(entityName: Entities.dataEntryBeefAnimalAddTblEntity,userId:userId,orderId:orderId,listid:Int64(listId),custmerId:Int64(custmerId ),providerId:pvid,earTag: earTag ?? "", orderStatus: "false") as! [DataEntryBeefAnimaladdTbl]
                    
                    if dataEntryVALE.count > 0 {
                        self.conflictArr.append(contentsOf: dataEntryVALE)
                        
                    }
                }
                
                if conflictArr.count > 0 {
                    let count1 = conflictArr.count
                    let alertPrint = String(count1) + " " + NSLocalizedString(LocalizedStrings.selectActionToBePerformed, comment: "")
                    
                    let alert = UIAlertController(title: listNameString, message: alertPrint, preferredStyle: .alert)
                    let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: { action in
                        
                        self.importBackroundView.isHidden = true
                        self.importListMainView.isHidden = true
                        
                    })
                    
                    alert.addAction(cancel)
                    let ok = UIAlertAction(title: NSLocalizedString("Ignore", comment: ""), style: .default, handler: { [self] action in
                        let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: Entities.dataEntryBeefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                        if fetchData11.count != 0 {
                            for i in 0...fetchData11.count - 1 {
                                let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                                let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                                if fetchCountGirlando.count == 0 {
                                    
                                    let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:orderId, customerID: custmerId)
                                    if data12333.count > 0{
                                        if inheritTissueBttn.titleLabel!.text! == ButtonTitles.allflexTSUText || inheritTissueBttn.titleLabel!.text! == ButtonTitles.allflexTSTText || inheritTissueBttn.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                                            inheritSaveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ) ,tissuId: Int(dataGet.tissuId ),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId ),productId:Int(dataGet.productId ), sirYOB: dataGet.sireYOB ?? "", damYOB: dataGet.damYOB ?? "", sireRegAssocation: dataGet.sireRegAssocation ?? "",custId: Int(dataGet.custmerId ), listId: dataGet.listId , serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                            
                                            UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: keyValue.dataEntryBeefInheritTsu.rawValue)
                                            UserDefaults.standard.set(dataGet.breedName ?? "", forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
                                            
                                            self.inheritTissueBttn.setTitle(dataGet.tissuName?.localized, for: .normal)
                                            
                                            if dataGet.breedName == LocalizedStrings.breedNameX{
                                                self.inheritBreedBttn.setTitle("XX", for: .normal)
                                            } else {
                                                self.inheritBreedBttn.setTitle(dataGet.breedName, for: .normal)
                                            }
                                            createDataList()
                                        }
                                        else{
                                            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                            
                                            let okAction = UIAlertAction(title: NSLocalizedString("YES", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                self.inheritByDefaultSetting()
                                            }
                                            let cancelAction = UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                
                                                deleteDataWithProductwithEntity(Int(dataGet.animalId),entity: Entities.productAdonAnimlBeefTblEntity)
                                                deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.subProductBeefTblEntity)
                                                deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.beefAnimalAddTblEntity)
                                                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                                                self.notificationLblCount.text = String(animalCount.count)
                                                self.inheritByDefaultSetting()
                                                return
                                            }
                                            
                                            alertController.addAction(cancelAction)
                                            alertController.addAction(okAction)
                                            self.present(alertController, animated: true, completion: nil)
                                            return
                                        }
                                    }
                                    else {
                                        inheritSaveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ) ,tissuId: Int(dataGet.tissuId ),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId ),productId:Int(dataGet.productId ), sirYOB: dataGet.sireYOB ?? "", damYOB: dataGet.damYOB ?? "", sireRegAssocation: dataGet.sireRegAssocation ?? "",custId: Int(dataGet.custmerId ), listId: dataGet.listId , serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                        
                                        UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: keyValue.dataEntryBeefInheritTsu.rawValue)
                                        UserDefaults.standard.set(dataGet.breedName ?? "", forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
                                        self.inheritTissueBttn.setTitle(dataGet.tissuName?.localized, for: .normal)
                                        if dataGet.breedName == LocalizedStrings.breedNameX{
                                            self.inheritBreedBttn.setTitle("XX", for: .normal)
                                        } else {
                                            self.inheritBreedBttn.setTitle(dataGet.breedName, for: .normal)
                                        }
                                        createDataList()
                                    }
                                    
                                    let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                                    let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                                    
                                    for k in 0 ..< animalData.count{
                                        let animalId = animalData[k] as! BeefAnimaladdTbl
                                        for i in 0 ..< product.count {
                                            let data = product[i] as! GetProductTblBeef
                                            saveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: animalId.farmId ?? "", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: true)
                                            
                                            let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                            
                                            for j in 0 ..< addonArr.count {
                                                let addonDat = addonArr[j] as! GetAdonTbl
                                                if data12333.count > 0 {
                                                    if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                        saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                        updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: Int(addonDat.adonId), status: "true")
                                                    }
                                                    else{
                                                        saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                    }
                                                }
                                                else {
                                                    saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                }
                                                statusOrder = false
                                                UserDefaults.standard.removeObject(forKey: keyValue.review.rawValue)
                                                self.animalSucInOrder = ""
                                            }
                                            
                                        }
                                    }
                                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                                    notificationLblCount.text = String(animalCount.count)
                                    if animalCount.count == 0{
                                        self.notificationLblCount.isHidden = true
                                        self.countLbl.isHidden = true
                                    } else {
                                        self.notificationLblCount.isHidden = false
                                        self.countLbl.isHidden = false
                                    }
                                    self.inheritCrossBtnOutlet.isHidden = false
                                    UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                                    UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                                    inheritImportFromOutlet.isEnabled = true
                                    self.importBackroundView.isHidden = true
                                    self.importListMainView.isHidden = true
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                                    
                                    showAlertforwithoutBarcodeAnimal(importListAnimal: allDataAnimalTbl1 as! [DataEntryBeefAnimaladdTbl])
                                    
                                    if fetchMergeDataListId(entityName: Entities.mergeDataEntryListTblEntity,listId: Int64(dataGet.listId),customerId: Int64(self.custmerId )).count == 0 {
                                        
                                        let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ))
                                        let listObject = fetchList.object(at: 0) as? DataEntryList
                                        let listDescr = listObject?.listDesc
                                        
                                        saveMergeDataEntryList(entity: Entities.mergeDataEntryListTblEntity, customerId: Int64(self.custmerId ), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                    }
                                    
                                    let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ,providerId:pvid )
                                    if fetchObj.count != 0 {
                                        
                                        let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                        let obj = objectFetch?.listName
                                        let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
                                        
                                        if fetchAllMergeDta == 0 {
                                            let fetchNameDisplay = String(obj ?? "")
                                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                            InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                            InheritmergeListBtnOulet.isHidden = false
                                        } else {
                                            let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                            InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                            InheritmergeListBtnOulet.isHidden = false
                                        }
                                    }
                                    
                                }
                                let fetchCheckListId = fetchAllDataOrderListIDgET(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false",orderId:self.orderId,userId:self.userId,listId:0)
                                
                                if fetchCheckListId.count == 0{
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noAnimalsAddedToOrder, comment: ""), duration: 2, position: .top)
                                    self.importBackroundView.isHidden = true
                                    self.importListMainView.isHidden = true
                                }
                            }
                        }
                    })
                    alert.addAction(ok)
                    self.importBackroundView.isHidden = true
                    self.importListMainView.isHidden = true
                    
                    DispatchQueue.main.async(execute: {
                        self.present(alert, animated: true)
                    })
                } else {
                    let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: Entities.dataEntryBeefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                    if fetchData11.count != 0 {
                        
                        for i in 0...fetchData11.count - 1 {
                            let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                            let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                            if fetchCountGirlando.count == 0 {
                                
                                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:orderId, customerID: custmerId)
                                if data12333.count > 0{
                                    if inheritTissueBttn.titleLabel!.text! == ButtonTitles.allflexTSUText || inheritTissueBttn.titleLabel!.text! == ButtonTitles.allflexTSTText || inheritTissueBttn.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                                        inheritSaveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ) ,tissuId: Int(dataGet.tissuId ),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId ),productId:Int(dataGet.productId ), sirYOB: dataGet.sireYOB ?? "", damYOB: dataGet.damYOB ?? "", sireRegAssocation: dataGet.sireRegAssocation ?? "",custId: Int(dataGet.custmerId ), listId: dataGet.listId , serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                        
                                        UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: keyValue.dataEntryBeefInheritTsu.rawValue)
                                        UserDefaults.standard.set(dataGet.breedName ?? "", forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
                                        
                                        self.inheritTissueBttn.setTitle(dataGet.tissuName?.localized, for: .normal)
                                        if dataGet.breedName == LocalizedStrings.breedNameX{
                                            self.inheritBreedBttn.setTitle("XX", for: .normal)
                                        } else {
                                            self.inheritBreedBttn.setTitle(dataGet.breedName, for: .normal)
                                        }
                                        createDataList()
                                        
                                    }
                                    else{
                                        let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                        
                                        let okAction = UIAlertAction(title: NSLocalizedString("YES", comment: ""), style: UIAlertAction.Style.default) {
                                            UIAlertAction in
                                            self.inheritByDefaultSetting()
                                        }
                                        let cancelAction = UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: UIAlertAction.Style.default) {
                                            UIAlertAction in
                                            
                                            deleteDataWithProductwithEntity(Int(dataGet.animalId),entity: Entities.productAdonAnimlBeefTblEntity)
                                            deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.subProductBeefTblEntity)
                                            deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.beefAnimalAddTblEntity)
                                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                                            self.notificationLblCount.text = String(animalCount.count)
                                            self.inheritByDefaultSetting()
                                            return
                                        }
                                        
                                        alertController.addAction(cancelAction)
                                        alertController.addAction(okAction)
                                        self.present(alertController, animated: true, completion: nil)
                                        return
                                    }
                                }
                                else {
                                    inheritSaveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ) ,tissuId: Int(dataGet.tissuId ),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId ),productId:Int(dataGet.productId ), sirYOB: dataGet.sireYOB ?? "", damYOB: dataGet.damYOB ?? "", sireRegAssocation: dataGet.sireRegAssocation ?? "",custId: Int(dataGet.custmerId), listId: dataGet.listId , serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                    
                                    UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: keyValue.dataEntryBeefInheritTsu.rawValue)
                                    UserDefaults.standard.set(dataGet.breedName ?? "", forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
                                    
                                    self.inheritTissueBttn.setTitle(dataGet.tissuName?.localized, for: .normal)
                                    if dataGet.breedName == LocalizedStrings.breedNameX{
                                        self.inheritBreedBttn.setTitle("XX", for: .normal)
                                    } else {
                                        self.inheritBreedBttn.setTitle(dataGet.breedName, for: .normal)
                                    }
                                    createDataList()
                                }
                                
                                let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                                let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                                
                                for k in 0 ..< animalData.count{
                                    let animalId = animalData[k] as! BeefAnimaladdTbl
                                    for i in 0 ..< product.count {
                                        let data = product[i] as! GetProductTblBeef
                                        saveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: animalId.farmId ?? "", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: true)
                                        
                                        let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                        
                                        for j in 0 ..< addonArr.count {
                                            let addonDat = addonArr[j] as! GetAdonTbl
                                            if data12333.count > 0 {
                                                if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                    saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                    updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: Int(addonDat.adonId), status: "true")
                                                }
                                                else{
                                                    saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                }
                                            }
                                            else {
                                                saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                            }
                                            statusOrder = false
                                            UserDefaults.standard.removeObject(forKey: keyValue.review.rawValue)
                                            self.animalSucInOrder = ""
                                        }
                                    }
                                }
                                
                                let animalCount = fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                                notificationLblCount.text = String(animalCount.count)
                                if animalCount.count == 0{
                                    self.notificationLblCount.isHidden = true
                                    self.countLbl.isHidden = true
                                } else {
                                    self.notificationLblCount.isHidden = false
                                    self.countLbl.isHidden = false
                                }
                                self.inheritCrossBtnOutlet.isHidden = false
                                UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                                UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                                inheritImportFromOutlet.isEnabled = true
                                self.importBackroundView.isHidden = true
                                self.importListMainView.isHidden = true
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                                
                                showAlertforwithoutBarcodeAnimal(importListAnimal: allDataAnimalTbl1 as! [DataEntryBeefAnimaladdTbl])
                                
                                if fetchMergeDataListId(entityName: Entities.mergeDataEntryListTblEntity,listId: Int64(dataGet.listId),customerId: Int64(self.custmerId )).count == 0 {
                                    let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ))
                                    let listObject = fetchList.object(at: 0) as? DataEntryList
                                    let listDescr = listObject?.listDesc
                                    
                                    saveMergeDataEntryList(entity: Entities.mergeDataEntryListTblEntity, customerId: Int64(self.custmerId ), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                }
                                
                                let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ,providerId:pvid )
                                if fetchObj.count != 0 {
                                    
                                    let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                    let obj = objectFetch?.listName
                                    let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
                                    
                                    if fetchAllMergeDta == 0 {
                                        let fetchNameDisplay = String(obj ?? "")
                                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                        InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                        InheritmergeListBtnOulet.isHidden = false
                                    } else {
                                        let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                        InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                        InheritmergeListBtnOulet.isHidden = false
                                    }
                                }
                                
                            }}}}
                
            }else {
                let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: Entities.dataEntryBeefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                if fetchData11.count != 0 {
                    for i in 0...fetchData11.count - 1 {
                        let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                        let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                        if fetchCountGirlando.count == 0 {
                            
                            let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:orderId, customerID: custmerId)
                            if data12333.count > 0{
                                if inheritTissueBttn.titleLabel!.text! == ButtonTitles.allflexTSUText || inheritTissueBttn.titleLabel!.text! == ButtonTitles.allflexTSTText || inheritTissueBttn.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                                    inheritSaveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ) ,tissuId: Int(dataGet.tissuId ),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId ),productId:Int(dataGet.productId ), sirYOB: dataGet.sireYOB ?? "", damYOB: dataGet.damYOB ?? "", sireRegAssocation: dataGet.sireRegAssocation ?? "",custId: Int(dataGet.custmerId ), listId: dataGet.listId , serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                    
                                    UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: keyValue.dataEntryBeefInheritTsu.rawValue)
                                    UserDefaults.standard.set(dataGet.breedName ?? "", forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
                                    
                                    self.inheritTissueBttn.setTitle(dataGet.tissuName?.localized, for: .normal)
                                    if dataGet.breedName == LocalizedStrings.breedNameX{
                                        self.inheritBreedBttn.setTitle("XX", for: .normal)
                                    } else {
                                        self.inheritBreedBttn.setTitle(dataGet.breedName, for: .normal)
                                    }
                                    createDataList()
                                }
                                else{
                                    let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                    
                                    let okAction = UIAlertAction(title: NSLocalizedString("YES", comment: ""), style: UIAlertAction.Style.default) {
                                        UIAlertAction in
                                        self.inheritByDefaultSetting()
                                    }
                                    let cancelAction = UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: UIAlertAction.Style.default) {
                                        UIAlertAction in
                                        
                                        deleteDataWithProductwithEntity(Int(dataGet.animalId),entity: Entities.productAdonAnimlBeefTblEntity)
                                        deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.subProductBeefTblEntity)
                                        deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.beefAnimalAddTblEntity)
                                        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                                        self.notificationLblCount.text = String(animalCount.count)
                                        self.inheritByDefaultSetting()
                                        return
                                    }
                                    alertController.addAction(cancelAction)
                                    alertController.addAction(okAction)
                                    self.present(alertController, animated: true, completion: nil)
                                    return
                                }
                            }
                            else {
                                inheritSaveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ) ,tissuId: Int(dataGet.tissuId ),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId ),productId:Int(dataGet.productId ), sirYOB: dataGet.sireYOB ?? "", damYOB: dataGet.damYOB ?? "", sireRegAssocation: dataGet.sireRegAssocation ?? "",custId: Int(dataGet.custmerId ), listId: dataGet.listId , serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                
                                UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: keyValue.dataEntryBeefInheritTsu.rawValue)
                                UserDefaults.standard.set(dataGet.breedName ?? "", forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
                                
                                self.inheritTissueBttn.setTitle(dataGet.tissuName?.localized, for: .normal)
                                if dataGet.breedName == LocalizedStrings.breedNameX{
                                    self.inheritBreedBttn.setTitle("XX", for: .normal)
                                } else {
                                    self.inheritBreedBttn.setTitle(dataGet.breedName, for: .normal)
                                }
                                createDataList()
                            }
                            
                            let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                            let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                            
                            for k in 0 ..< animalData.count{
                                let animalId = animalData[k] as! BeefAnimaladdTbl
                                for i in 0 ..< product.count {
                                    let data = product[i] as! GetProductTblBeef
                                    saveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: animalId.farmId ?? "", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: true)
                                    
                                    let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                    
                                    for j in 0 ..< addonArr.count {
                                        let addonDat = addonArr[j] as! GetAdonTbl
                                        if data12333.count > 0 {
                                            if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: Int(addonDat.adonId), status: "true")
                                            }
                                            else{
                                                saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                            }
                                        }
                                        else {
                                            saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                        }
                                        statusOrder = false
                                        UserDefaults.standard.removeObject(forKey: keyValue.review.rawValue)
                                        self.animalSucInOrder = ""
                                        
                                    }
                                }
                            }
                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                            notificationLblCount.text = String(animalCount.count)
                            if animalCount.count == 0{
                                self.notificationLblCount.isHidden = true
                                self.countLbl.isHidden = true
                            } else {
                                self.notificationLblCount.isHidden = false
                                self.countLbl.isHidden = false
                            }
                            self.inheritCrossBtnOutlet.isHidden = false
                            UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                            UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                            inheritImportFromOutlet.isEnabled = true
                            self.importBackroundView.isHidden = true
                            self.importListMainView.isHidden = true
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                            
                            showAlertforwithoutBarcodeAnimal(importListAnimal: allDataAnimalTbl1 as! [DataEntryBeefAnimaladdTbl])
                            if fetchMergeDataListId(entityName: Entities.mergeDataEntryListTblEntity,listId: Int64(dataGet.listId),customerId: Int64(self.custmerId )).count == 0 {
                                
                                let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ))
                                let listObject = fetchList.object(at: 0) as? DataEntryList
                                let listDescr = listObject?.listDesc
                                
                                saveMergeDataEntryList(entity: Entities.mergeDataEntryListTblEntity, customerId: Int64(self.custmerId ), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                            }
                            
                            let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ,providerId:pvid )
                            if fetchObj.count != 0 {
                                
                                let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                let obj = objectFetch?.listName
                                let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
                                
                                if fetchAllMergeDta == 0 {
                                    let fetchNameDisplay = String(obj ?? "")
                                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                    InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                    InheritmergeListBtnOulet.isHidden = false
                                } else {
                                    let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                    InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                    InheritmergeListBtnOulet.isHidden = false
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func crossPairedAction(_ sender: Any) {
        pairedBackroundView.isHidden = true
        pairedDeviceView.isHidden = true
    }
    
    
    @IBAction func rfidTippopClick(_ sender: UIButton) {
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(OrderingAnimalVC.buttonbgPressedTip), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view .addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed(ClassIdentifiers.tipPopUpNib) as? TipPopUp
        customPopView1.elipseImage2.isHidden = true
        customPopView1.elipseImage1.isHidden = true
        customPopView1.textLbl2.isHidden = true
        if defaltscreen == keyValue.farmId.rawValue {
            customPopView1.frame = CGRect(x: 33,y: innerView.layer.frame.minY + 11 ,width: screenSize.width - 90, height: 70)
            customPopView1.textLabel1.text = NSLocalizedString(LocalizedStrings.herdManagement, comment: "")
        } else {
            customPopView1.frame = CGRect(x: 33,y: innerView.layer.frame.minY + 11 ,width: screenSize.width - 90, height:90)
            customPopView1.textLabel1.text = NSLocalizedString(LocalizedStrings.uniqueMetalEarTag, comment: "")
        }
        customPopView1.arrow_Top.isHidden = true
        customPopView1.delegate = self
        customPopView1.layer.borderColor = UIColor.blue.cgColor
        customPopView1.layer.borderWidth = 1
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1.addSubview(customPopView1)
    }
    
    @IBAction func inheritImportFromAction(_ sender: Any) {
        view.endEditing(true)
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int
        listId = 0
        tempimportListArray = fetchDataEntryListGetWithProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:pvid,productType:keyValue.capsInherit.rawValue) as! [DataEntryList]
        if tempimportListArray.count>0 {
            importListArray = orderingDataListViewModel.hideInternalDataList(tempImportListArray: tempimportListArray)
        }
        
        if importListArray.count == 0 {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.noListsAvailable, comment: ""))
            importListMainView.isHidden = true
            importBackroundView.isHidden = true
            return
        }
        conflictArr.removeAll()
        let data1 = fetchAllDataWithOrderID(entityName: Entities.beefAnimalAddTblEntity,orderId:orderId,userId:userId)
        if data1.count > 0{
            let animalStatusChck = fetchAllDataWithOrderIDStatucCheck(entityName: Entities.beefAnimalAddTblEntity,orderId:self.orderId,userId:self.userId,status:"true")
            
            if animalStatusChck.count != 0 {
                if self.importListArray.count != 0 {
                    self.importListMainView.isHidden = false
                    self.importBackroundView.isHidden = false
                    self.importTblView.reloadData()
                }
            } else {
                if importListArray.count != 0 {
                    importListMainView.isHidden = false
                    importBackroundView.isHidden = false
                    importTblView.reloadData()
                }
            }
        } else {
            if importListArray.count != 0 {
                importListMainView.isHidden = false
                importBackroundView.isHidden = false
                importTblView.reloadData()
            }
        }
    }
    
    @IBAction func InheritmergeListBtnClick(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.animalMergePopVC) as! AnimalMergePopUpVC
        vc.delegate = self
        vc.providerId = pvid
        self.navigationController?.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func globalMergeListBtnClick(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.animalMergePopVC) as! AnimalMergePopUpVC
        vc.delegate = self
        vc.providerId = pvid
        self.navigationController?.present(vc, animated: false, completion: nil)
        
    }
    
    @IBAction func inheritCrossBtnAction(_ sender: Any) {
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.removingOrdersList, comment: ""), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
        })
        
        alert.addAction(cancel)
        let ok = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
            let listArray = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId ))
            
            for i in 0 ..< listArray.count{
                let listObj = listArray[i] as! MergeDataEntryList
                let animalData =  fetchDataEnteryAnimalTbl(entityName: Entities.beefAnimalAddTblEntity, customerId: Int(listObj.customerId), listId: Int64(listObj.listId))
                
                if animalData.count > 0 {
                    for i in 0 ..< animalData.count {
                        let ad = animalData[i] as! BeefAnimaladdTbl
                        deleteDataWithProductBeefDelete(Int(ad.animalId))
                        deleteDataWithSubProductAnimalId(Int(ad.animalId))
                    }
                    deleteDataWithListIdDatEntry(entityString: Entities.beefAnimalAddTblEntity, listId: Int(listObj.listId), customerId: Int(listObj.customerId),userId: self.userId)
                }
            }
            
            deleteDataWithPvidCustomerId(entityString: Entities.mergeDataEntryListTblEntity ,providerId: Int64(UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)),customerId: Int64(self.custmerId ))
            UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
            self.inheritImportFromOutlet.isEnabled = true
            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
            self.notificationLblCount.text = String(animalCount.count)
            if animalCount.count == 0 {
                self.notificationLblCount.isHidden = true
                self.countLbl.isHidden = true
            } else {
                self.notificationLblCount.isHidden = false
                self.countLbl.isHidden = false
            }
            self.inheritCrossBtnOutlet.isHidden = true
            if fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count == 0 {
                self.InheritmergeListBtnOulet.isHidden = true
            } else {
                self.InheritmergeListBtnOulet.isHidden = false
            }
        })
        alert.addAction(ok)
        
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    @IBAction func globalImportFromAction(_ sender: Any) {
        view.endEditing(true)
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int
        listId = 0
        tempimportListArray = fetchDataEntryListGetWithProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:pvid,productType:keyValue.globalHD50K.rawValue) as! [DataEntryList]
        if tempimportListArray.count>0 {
            importListArray = orderingDataListViewModel.hideInternalDataList(tempImportListArray: tempimportListArray)
        }
        conflictArr.removeAll()
        if importListArray.count == 0 {
            
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.noListsAvailable, comment: ""))
            
            importListMainView.isHidden = true
            importBackroundView.isHidden = true
            return
        }
        let data1 = fetchAllDataWithOrderID(entityName: Entities.beefAnimalAddTblEntity,orderId:orderId,userId:userId)
        if data1.count > 0{
            let animalStatusChck = fetchAllDataWithOrderIDStatucCheck(entityName: Entities.beefAnimalAddTblEntity,orderId:self.orderId,userId:self.userId,status:"true")
            
            if animalStatusChck.count != 0 {
                if self.importListArray.count != 0 {
                    self.importListMainView.isHidden = false
                    self.importBackroundView.isHidden = false
                    self.importTblView.reloadData()
                }
                
            } else {
                if importListArray.count != 0 {
                    importListMainView.isHidden = false
                    importBackroundView.isHidden = false
                    importTblView.reloadData()
                }
            }
        } else {
            if importListArray.count != 0 {
                importListMainView.isHidden = false
                importBackroundView.isHidden = false
                importTblView.reloadData()
            }
        }
    }
    
    @IBAction func globalCrossBtnAction(_ sender: Any) {
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.removingOrdersList, comment: ""), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
        })
        
        alert.addAction(cancel)
        let ok = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
            let listArray = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId ))
            
            for i in 0 ..< listArray.count{
                let listObj = listArray[i] as! MergeDataEntryList
                let animalData =  fetchDataEnteryAnimalTbl(entityName: Entities.beefAnimalAddTblEntity, customerId: Int(listObj.customerId), listId: Int64(listObj.listId))
                
                if animalData.count > 0 {
                    for i in 0 ..< animalData.count {
                        let ad = animalData[i] as! BeefAnimaladdTbl
                        deleteDataWithProductBeefDelete(Int(ad.animalId))
                        deleteDataWithSubProductAnimalId(Int(ad.animalId))
                        
                    }
                    deleteDataWithListIdDatEntry(entityString: Entities.beefAnimalAddTblEntity, listId: Int(listObj.listId), customerId:  Int(listObj.customerId),userId:self.userId)
                }
            }
            deleteDataWithPvidCustomerId(entityString: Entities.mergeDataEntryListTblEntity ,providerId: Int64(UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)),customerId: Int64(self.custmerId ))
            UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
            self.globalImportFromOutlet.isEnabled = true
            let animalCount = fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
            self.notificationLblCount.text = String(animalCount.count)
            if animalCount.count == 0 {
                self.notificationLblCount.isHidden = true
                self.countLbl.isHidden = true
            } else {
                self.notificationLblCount.isHidden = false
                self.countLbl.isHidden = false
            }
            if fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count == 0 {
                self.globalMergeListBtnOulet.isHidden = true
            } else {
                self.globalMergeListBtnOulet.isHidden = false
            }
            self.globalCrossBtnOutlet.isHidden = true
        })
        alert.addAction(ok)
        
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    @IBAction func incrementalBarcodeButtonActionInherit(_ sender: UIButton) {
        guard inheritBarcodeTextfield.text?.isEmpty == false else {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.enterBarcodeAlert, comment: "") )
            return
        }
        guard isBarcodeEndingWithNumberAndGetIncremented(inheritBarcodeTextfield.text ?? "").isBarCodeEndsWithNumber else {
            if !checkBarcode{
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.barcodeMustEndWithNumAlert, comment: ""))
            }
            else {
                sender.isSelected = false
                incrementalBarcodeCheckBoxInherit.image = UIImage(named: ImageNames.incrementalCheckImg)
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                self.isBarcodeAutoIncrementedEnabled = false
                checkBarcode = false
            }
            return
        }
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue)  {
            sender.isSelected = false
            incrementalBarcodeCheckBoxInherit.image = UIImage(named: ImageNames.incrementalCheckImg)
            UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
            self.isBarcodeAutoIncrementedEnabled = false
            checkBarcode = false
        } else {
            sender.isSelected = true
            incrementalBarcodeCheckBoxInherit.image = UIImage(named: ImageNames.checkImg)
            UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
            self.isBarcodeAutoIncrementedEnabled = true
            checkBarcode = false
        }
    }
    
    @IBAction func incrementalBarcodeButtonActionGlobal(_ sender: UIButton) {
        guard scanBarcodeTextfield.text?.isEmpty == false else {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.enterBarcodeAlert, comment: "") )
            return
        }
        
        guard isBarcodeEndingWithNumberAndGetIncremented(scanBarcodeTextfield.text ?? "").isBarCodeEndsWithNumber else {
            if !checkBarcode{
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.barcodeMustEndWithNumAlert, comment: ""))
            } else {
                sender.isSelected = false
                incrementalBarcodeCheckBoxGlobal.image = UIImage(named: ImageNames.incrementalCheckImg)
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                self.isBarcodeAutoIncrementedEnabled = false
                checkBarcode = false
            }
            return
        }
        
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) {
            sender.isSelected = false
            incrementalBarcodeCheckBoxGlobal.image = UIImage(named: ImageNames.incrementalCheckImg)
            UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
            self.isBarcodeAutoIncrementedEnabled = false
            checkBarcode = false
        } else {
            sender.isSelected = true
            incrementalBarcodeCheckBoxGlobal.image = UIImage(named: ImageNames.checkImg)
            UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
            self.isBarcodeAutoIncrementedEnabled = true
            checkBarcode = false
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
    
    @IBAction func offlineBtnAction(_ sender: UIButton) {
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(OrderingAnimalVC.buttonbgPressed), for: .touchUpInside)
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
    
    @IBAction func backBtnClk(_ sender: UIButton) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func dateAction(_ sender: UIButton) {
        let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
        if orederStatus.count > 0 {
            barcodeEnable = true
        }
        self.view.endEditing(true)
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            globalDateTextField.isHidden = false
        }else {
            globalDateTextField.isHidden = true
            calenderView.isHidden = false
            calenderbkg.isHidden = false
            calenderView.layer.cornerRadius = 30
            calenderView.layer.masksToBounds = true
            doDatePicker()
        }
        _ = statusOrderTrue()
        if statusOrder {
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
    
    @IBAction func viewAnimalClick(_ sender: UIButton) {
        barcodeScreen = false
        selectedDate = Date()
        InheritSelectedDate = Date()
        let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.beefViewAnimalVC) as? BeefViewAnimalVC
        vc?.delegateCustom = self
        vc!.screenBackSave = false
        vc!.productBackSave = false
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func inheritSireRedNumberAction(_ sender: UIButton) {
        if inheritEarTagTextfield.text?.count == 0 {
            return
        }
        btnTag = 90
        view.endEditing(true)
        inheritRegArr = fetchAllDataProductBeefBreedSociety(entityName: Entities.getBreedSocietiesTblEntity, productId: 20)
        self.tableViewpop()
        var yFrame = (inheritRegHideLbl.frame.minY + 135) - self.inheritScrollView.contentOffset.y
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
            case 1334:
                yFrame = (self.inheritRegHideLbl.frame.minY + 110) - self.inheritScrollView.contentOffset.y
            case 1920, 2208:
                yFrame = (self.inheritRegHideLbl.frame.minY + 110) - self.inheritScrollView.contentOffset.y
            case 2436:
                break
            case 2688,2796:
                break
            case 1792:
                yFrame = (self.inheritRegHideLbl.frame.minY + 143) - self.inheritScrollView.contentOffset.y
            default:
                break
            }
        }
        droperTableView.frame = CGRect(x: 25,y: yFrame,width: inheritRegAssociationBttn.frame.width,height: 200)
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder {
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
    
    @IBAction func breedRegAction(_ sender: UIButton) {
        btnTag = 80
        breedRegArr = fetchAllDataProductBeefBreedSociety(entityName: Entities.getBreedSocietiesTblEntity, productId: 19)
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
        droperTableView.frame = CGRect(x: 25,y: yFrame,width: breedRegBttn.frame.width,height: 200)
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder {
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
    
    @IBAction func inheritTissueBttnAction(_ sender: UIButton) {
        btnTag = 50
        view.endEditing(true)
        self.tableViewpop()
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        inheritTissueArr =  fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
        
        var yFrame = (inheritTissueHideLbl.frame.minY + 140) - self.inheritScrollView.contentOffset.y
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
            case 1334:
                yFrame = (inheritTissueHideLbl.frame.minY + 105) - self.inheritScrollView.contentOffset.y
            case 1920, 2208:
                yFrame = (inheritTissueHideLbl.frame.minY + 110) - self.inheritScrollView.contentOffset.y
            case 2436:
                break
            case 2688,2796:
                break
            case 1792:
                yFrame = (inheritTissueHideLbl.frame.minY + 143) - self.inheritScrollView.contentOffset.y
            default:
                break
            }
        }
        droperTableView.frame = CGRect(x: 30,y: yFrame,width: 150,height: 150)
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder {
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
    
    @IBAction func scanBarcodeAction(_ sender: UIButton) {
        barcodeScreen = true
        let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.cameraViewControllerVC) as? CameraViewController
        vc?.delegate = self
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func tissueBtnnAction(_ sender: UIButton) {
        btnTag = 20
        view.endEditing(true)
        self.tableViewpop()
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        tissueArr =  fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
        
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
        if statusOrder {
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
    
    @IBAction func inheritBreedAction(_ sender: UIButton) {
        btnTag = 60
        view.endEditing(true)
        self.tableViewpop()
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        inheritBreedArr = fetchproviderProductDataGlobal(entityName: Entities.getBreedsTblEntity, provId: pvid, productId: 55, speciesName: "Beef")
        var yFrame = (inheritBreedLbl.frame.minY + 140) - self.inheritScrollView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
            case 1334:
                yFrame = (inheritBreedLbl.frame.minY + 105) - self.inheritScrollView.contentOffset.y
            case 1920, 2208:
                yFrame = (inheritBreedLbl.frame.minY + 110) - self.inheritScrollView.contentOffset.y
            case 2436:
                break
            case 2688,2796:
                break
            case 1792:
                yFrame = (inheritBreedLbl.frame.minY + 143) - self.inheritScrollView.contentOffset.y
            default:
                break
            }
        }
        droperTableView.frame = CGRect(x: 30,y: yFrame,width: 150,height: 300)
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder {
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
    
    @IBAction func breedAction(_ sender: UIButton) {
        btnTag = 10
        view.endEditing(true)
        self.tableViewpop()
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        breedArr = fetchproviderProductDataGlobal(entityName: Entities.getBreedsTblEntity, provId: pvid, productId: 19, speciesName: "")
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
        droperTableView.frame = CGRect(x: 30,y: yFrame,width: 150,height: 300)
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder {
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
    
    @IBAction func sireRegAction(_ sender: UIButton) {
        btnTag = 30
        view.endEditing(true)
        sireRegArr = fetchAllDataProductBeefBreedSociety(entityName: Entities.getBreedSocietiesTblEntity, productId: 19)
        self.tableViewpop()
        var yFrame = (sireRegLbl.frame.minY + 130) - self.scrolView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
            case 1334:
                yFrame = (sireRegLbl.frame.minY + 105) - self.scrolView.contentOffset.y
            case 1920, 2208:
                yFrame = (sireRegLbl.frame.minY + 110) - self.scrolView.contentOffset.y
            case 2436:
                break
            case 2688,2796:
                break
            case 1792:
                yFrame = (sireRegLbl.frame.minY + 143) - self.scrolView.contentOffset.y
            default:
                break
            }
        }
        
        droperTableView.frame = CGRect(x: 25,y: yFrame,width: sireRegDropdownOutlet.frame.width,height: 200)
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder {
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
    
    @IBAction func damRegAction(_ sender: UIButton) {
        btnTag = 40
        damRegArr = fetchAllDataProductBeefBreedSociety(entityName: Entities.getBreedSocietiesTblEntity, productId: 19)
        view.endEditing(true)
        self.tableViewpop()
        var yFrame = (damRegLbl.frame.minY + 130) - self.scrolView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
            case 1334:
                yFrame = (damRegLbl.frame.minY + 105) - self.scrolView.contentOffset.y
            case 1920, 2208:
                yFrame = (damRegLbl.frame.minY + 110) - self.scrolView.contentOffset.y
            case 2436:
                break
            case 2688,2796:
                break
            case 1792:
                yFrame = (damRegLbl.frame.minY + 143) - self.scrolView.contentOffset.y
            default:
                break
            }
        }
        droperTableView.frame = CGRect(x: 25,y: yFrame,width: sireRegDropdownOutlet.frame.width,height: 200)
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder {
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
    
    @IBAction func maleFemaleAction(_ sender: UIButton) {
        let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
        if orederStatus.count > 0 {
            barcodeEnable = true
        }
        
        self.view.endEditing(true)
        if(genderToggleFlag == 0) {
            self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 1
            genderString = NSLocalizedString("Male", comment: "")
        }
        else {
            self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 0
            genderString = "Female".localized
        }
        _ = statusOrderTrue()
        if statusOrder {
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
    
    @IBAction func addAnimalAction(_ sender: UIButton) {
        addContiuneBtn = 1
        addAnimalBtn(completionHandler: { (success) -> Void in
            
            DispatchQueue.main.async{
                self.scanEarTagTextField.becomeFirstResponder()
            }
        })
        self.view.endEditing(true)
    }
    
    @IBAction func sideMenuAction(_ sender: UIButton) {
        self.sideMenuViewController?.presentRightMenuViewController()
        self.view.makeCorner(withRadius: 40)
    }
    
    @IBAction func backClick(_ sender: UIButton) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func continueAction(_ sender: UIButton) {
        UserDefaults.standard.setValue("", forKey: keyValue.dealerCode.rawValue)
        if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
            addContiuneBtn = 2
            let  userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            let  orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
            identify1 = true
            let data1 = fetchAllDataOrderStatus(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
            
            if data1.count > 0 {
                if scanEarTagTextField.text == "" && scanBarcodeTextfield.text == ""{
                    pageLoading()
                } else {
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        if success {
                            self.pageLoading()
                        }
                    })
                }
            }
            else {
                if scanEarTagTextField.text == "" {
                    if scanEarTagTextField.text == "" && scanBarcodeTextfield.text == "" {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.addOneAnimal, comment: ""))
                        self.validation()
                    } else {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                        self.validation()
                    }
                }
                else {
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        if success {
                            self.pageLoading()
                        }
                    })
                }
            }
            
            if data1.count > 0 {
                if scanEarTagTextField.text == "" && scanBarcodeTextfield.text == ""{
                    self.pageLoading()
                }
                else{
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        if success {
                            self.pageLoading()
                        }
                    })
                }
            }
            else{
                addAnimalBtn(completionHandler: { (success) -> Void in
                    if success {
                        self.pageLoading()
                    }
                })
            }
        }
        else{
            addContiuneBtn = 2
            let  userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            let  orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
            identify1 = true
            let data1 = fetchAllDataOrderStatus(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
            let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
            
            if  identyCheck == false || identyCheck == nil{
                if data1.count > 0 {
                    if inheritEarTagTextfield.text == "" && inheritBarcodeTextfield.text == ""{
                        self.pageLoading()
                    } else {
                        addAnimalBtn(completionHandler: { (success) -> Void in
                            if success {
                                self.pageLoading()
                            }
                        })
                    }
                }
                else {
                    if inheritEarTagTextfield.text == "" || inheritBarcodeTextfield.text == ""{
                        if inheritEarTagTextfield.text == "" && inheritBarcodeTextfield.text == ""{
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.addOneAnimal, comment: ""))
                            self.inheritValidation()
                        } else {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                            self.inheritValidation()
                        }
                    }
                    else {
                        addAnimalBtn(completionHandler: { (success) -> Void in
                            if success {
                                self.pageLoading()
                            }
                        })
                    }
                }
            }
            else{
                if data1.count > 0 {
                    if inheritEarTagTextfield.text == "" || inheritBarcodeTextfield.text == ""{
                        self.pageLoading()
                    }
                    else{
                        addAnimalBtn(completionHandler: { (success) -> Void in
                            if success {
                                self.pageLoading()
                            }
                        })
                    }
                }
                else{
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        if success {
                            self.pageLoading()
                        }
                    })
                }
            }
            
        }
    }
    
    @IBAction func inheritAddAnimalAction(_ sender: UIButton) {
        self.view.endEditing(true)
        addContiuneBtn = 1
        addAnimalBtn(completionHandler: { (success) -> Void in
            self.inheritEarTagTextfield.becomeFirstResponder()
        })
    }
    
    @IBAction func inheritSireYobAction(_ sender: UIButton) {
        self.view.endEditing(true)
        calenderView.isHidden = false
        calenderbkg.isHidden = false
        calenderView.layer.cornerRadius = 30
        calenderView.layer.masksToBounds = true
        inheritSireYOBDoDatePicker()
    }
    
    @IBAction func inheritDamYObAction(_ sender: UIButton) {
        self.view.endEditing(true)
        calenderView.isHidden = false
        calenderbkg.isHidden = false
        calenderView.layer.cornerRadius = 30
        calenderView.layer.masksToBounds = true
        inheritDamYOBDoDatePicker()
    }
    
    @IBAction func inheritRegAssociationAction(_ sender: UIButton){
        btnTag = 70
        view.endEditing(true)
        inheritRegArr = fetchAllDataProductBeefBreedSociety(entityName: Entities.getBreedSocietiesTblEntity, productId: 20)
        self.tableViewpop()
        var yFrame = (inheritRegistrationLbl.frame.minY + 140) - self.inheritScrollView.contentOffset.y
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
            case 1334:
                yFrame = (self.inheritRegistrationLbl.frame.minY + 105) - self.inheritScrollView.contentOffset.y
            case 1920, 2208:
                yFrame = (self.inheritRegistrationLbl.frame.minY + 110) - self.inheritScrollView.contentOffset.y
            case 2436:
                break
            case 2688,2796:
                break
            case 1792:
                yFrame = (self.inheritRegistrationLbl.frame.minY + 143) - self.inheritScrollView.contentOffset.y
            default:
                break
            }
        }
        droperTableView.frame = CGRect(x: 25,y: yFrame,width: inheritRegAssociationBttn.frame.width,height: 200)
        droperTableView.reloadData()
        _ = statusOrderTrue()
        if statusOrder {
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
    
    @IBAction func inheritDateAction(_ sender: UIButton) {
        let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
        if orederStatus.count > 0 {
            barcodeEnable = true
        }
        
        self.view.endEditing(true)
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            inheritDateTextField.isHidden = false
        } else {
            inheritDateTextField.isHidden = true
            calenderView.isHidden = false
            calenderbkg.isHidden = false
            calenderView.layer.cornerRadius = 30
            calenderView.layer.masksToBounds = true
            inheritDoDatePicker()
        }
        _ = statusOrderTrue()
        if statusOrder {
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
    
    @IBAction func inheritMaleFemaleBttnAction(_ sender: UIButton) {
        let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
        if orederStatus.count > 0 {
            barcodeEnable = true
        }
        
        self.view.endEditing(true)
        if(inheritGenderToggleFlag == 0) {
            self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
            inheritGenderToggleFlag = 1
            inheritGenderString = NSLocalizedString("Male", comment: "")
            UserDefaults.standard.set("M", forKey: "InheritBeefGender")
        }
        else {
            self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            inheritGenderToggleFlag = 0
            inheritGenderString = "Female".localized
            UserDefaults.standard.set("F", forKey: "InheritBeefGender")
        }
        
        _ = statusOrderTrue()
        if statusOrder {
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
    
    @IBAction func inheritBarcodeAction(_ sender: UIButton) {
        barcodeScreen = true
        let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.cameraViewControllerVC) as? CameraViewController
        vc?.delegate = self
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func scanButtonAction(_ sender: UIButton) {
        barcodeScreen = true
        let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.cameraViewControllerVC) as? CameraViewController
        vc?.delegate = self
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func inheritOCRbtn(_ sender: UIButton) {
        let marketId = UserDefaults.standard.object(forKey: keyValue.currentActiveMarketId.rawValue) as? String ?? ""
        if marketId == MarketID.USMarketId{
            if UserDefaults.standard.value(forKey: keyValue.beefScannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue{
                let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.textScanVC) as? TextScanVC
                vc?.delegate = self
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            else {
                if BluetoothCentre.shared.manager.state == .poweredOff{
                    let alertController = UIAlertController (title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.bluetoothOffText, comment: ""), preferredStyle: .alert)
                    
                    let settingsAction = UIAlertAction(title: NSLocalizedString(LocalizedStrings.settingsText, comment: ""), style: .default) { (_) -> Void in
                        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                            return
                        }
                        if UIApplication.shared.canOpenURL(settingsUrl) {
                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
                                
                            } else {
                                UIApplication.shared.openURL(settingsUrl)
                                
                            }
                        }
                    }
                    alertController.addAction(settingsAction)
                    let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: nil)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                else {
                    if BluetoothCentre.shared.smartBowPeripheral?.state == CBPeripheralState.disconnected || BluetoothCentre.shared.smartBowPeripheral == nil{
                        pairedDeviceView.isHidden = false
                        pairedBackroundView.isHidden = false
                        pairedTableView.reloadData()
                    }
                    if BluetoothCentre.shared.smartBowPeripheral?.state == CBPeripheralState.connected || BluetoothCentre.shared.smartBowPeripheral?.state == CBPeripheralState.connecting {
                        BluetoothCentre.shared.manager.scanForPeripherals(withServices: nil, options: nil)
                        pairedDeviceView.isHidden = false
                        pairedBackroundView.isHidden = false
                        pairedTableView.reloadData()
                        
                    }
                }
            }
        } else {
            let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.textScanVC) as? TextScanVC
            vc?.delegate = self
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    @IBAction func globalOcrBtnAction(_ sender: Any) {
        let marketId = UserDefaults.standard.object(forKey: keyValue.currentActiveMarketId.rawValue) as? String ?? ""
        if marketId == MarketID.USMarketId{
            if UserDefaults.standard.value(forKey: keyValue.beefScannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue{
                let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.textScanVC) as? TextScanVC
                vc?.delegate = self
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            else {
                if BluetoothCentre.shared.manager.state == .poweredOff{
                    let alertController = UIAlertController (title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.bluetoothOffText, comment: ""), preferredStyle: .alert)
                    
                    let settingsAction = UIAlertAction(title: NSLocalizedString(LocalizedStrings.settingsText, comment: ""), style: .default) { (_) -> Void in
                        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                            return
                        }
                        if UIApplication.shared.canOpenURL(settingsUrl) {
                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
                                
                            } else {
                                UIApplication.shared.openURL(settingsUrl)
                            }
                        }
                    }
                    alertController.addAction(settingsAction)
                    let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: nil)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                else {
                    if BluetoothCentre.shared.smartBowPeripheral?.state == CBPeripheralState.disconnected || BluetoothCentre.shared.smartBowPeripheral == nil{
                        pairedDeviceView.isHidden = false
                        pairedBackroundView.isHidden = false
                        pairedTableView.reloadData()
                    }
                    if BluetoothCentre.shared.smartBowPeripheral?.state == CBPeripheralState.connected || BluetoothCentre.shared.smartBowPeripheral?.state == CBPeripheralState.connecting {
                        BluetoothCentre.shared.manager.scanForPeripherals(withServices: nil, options: nil)
                        pairedDeviceView.isHidden = false
                        pairedBackroundView.isHidden = false
                        pairedTableView.reloadData()
                        
                    }
                }
            }
        } else {
            let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.textScanVC) as? TextScanVC
            vc?.delegate = self
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    @IBAction func globalclearFromAction(_ sender: Any) {
        self.view.endEditing(true)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message: NSLocalizedString(LocalizedStrings.wantToResetForm, comment: ""), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("No",comment: ""), style: .default, handler: { action in
            
        })
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title:NSLocalizedString("Yes",comment: "") , style: .default, handler: { action in
            self.byDefaultSetting()
            let ab =  UserDefaults.standard.string(forKey: keyValue.beeftsuClear.rawValue)
            if ab == nil || ab == "" {
                
                self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                for items in self.tissueArr{
                    let tissue = items  as? GetSampleTbl
                    let checkdefault  = tissue?.isDefault
                    
                    if checkdefault == true{
                        self.tissueBttnOutlet.setTitle(tissue?.sampleName, for: .normal)
                        self.tissuId =  Int(tissue?.sampleId ?? 1)
                    }
                }
            } else {
                self.tissueBttnOutlet.setTitle(ab, for: .normal)
                UserDefaults.standard.set(self.tissueBttnOutlet.titleLabel!.text, forKey: keyValue.beefTSU.rawValue)
                let codeId = fetchBreedDataTissueCode(entityName: Entities.getSampleTblEntity, provId: pvid, tissueName: ab!)
                let naabFetch1 = codeId.value(forKey: keyValue.sampleId.rawValue) as? NSArray
                if naabFetch1!.count != 0 {
                    let breedIdGet = naabFetch1![0] as? Int
                    self.tissuId = breedIdGet!
                }
            }
            
            var breed = UserDefaults.standard.string(forKey: keyValue.beefbreedClear.rawValue)
            if breed == nil || breed == "" {
                breed = ButtonTitles.ANGText
                self.breedBtnOutlet.setTitle(breed, for: .normal)
            } else {
                self.breedBtnOutlet.setTitle(breed, for: .normal)
                UserDefaults.standard.set(self.breedBtnOutlet.titleLabel?.text, forKey: keyValue.beefBreed.rawValue)
                
                let inheritBreed = fetchAllDataProductBeefId(entityName: Entities.getBreedsTblEntity, breedName: (self.breedBtnOutlet.titleLabel?.text!)!, productId: 19)
                if inheritBreed.count != 0 {
                    let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                    self.breedId = medbreedRegArr1!.breedId ?? ""
                }
            }
            
            let inrementCheck = UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncrementalClear.rawValue)
            if inrementCheck == true {
                self.isBarcodeAutoIncrementedEnabled = true
                self.incrementalBarcodeCheckBoxGlobal.image = UIImage(named: ImageNames.checkImg)
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
            } else {
                self.incrementalBarcodeCheckBoxGlobal.image = UIImage(named: ImageNames.incrementalCheckImg)
                self.isBarcodeAutoIncrementedEnabled = false
            }
            self.scanEarTagTextField.becomeFirstResponder()
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    @IBAction func inheritClearFromAction(_ sender: Any) {
        self.view.endEditing(true)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString,comment: ""), message: NSLocalizedString(LocalizedStrings.wantToResetForm, comment: ""), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("No",comment: ""), style: .default, handler: { action in
            
        })
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title:NSLocalizedString("Yes",comment: "") , style: .default, handler: { action in
            self.inheritByDefaultSetting()
            let ab =  UserDefaults.standard.string(forKey: keyValue.beefInheritTsuClear.rawValue)
            if ab == nil || ab == "" {
                self.inheritTissueBttn.setTitle(ButtonTitles.allflexTSUText, for: .normal)
                self.tissuId = 1
            }
            else {
                self.inheritTissueBttn.setTitle(ab, for: .normal)
                UserDefaults.standard.set(self.inheritTissueBttn.titleLabel!.text, forKey: keyValue.beefInheritTSU.rawValue)
                let codeId = fetchBreedDataTissueCode(entityName: Entities.getSampleTblEntity, provId: pvid, tissueName: ab!)
                
                let naabFetch1 = codeId.value(forKey: keyValue.sampleId.rawValue) as? NSArray
                if naabFetch1!.count != 0 {
                    let breedIdGet = naabFetch1![0] as? Int
                    self.tissuId = breedIdGet!
                }
                else {
                 
                }
            }
            
            let breed = UserDefaults.standard.string(forKey: keyValue.inheritBeefbreedClear.rawValue)
            
            if breed != nil || breed != "" {
                if breed == LocalizedStrings.breedNameX{
                    self.inheritBreedBttn.setTitle("XX", for: .normal)
                } else {
                    self.inheritBreedBttn.setTitle(breed, for: .normal)
                }
                
                UserDefaults.standard.set(self.inheritBreedBttn.titleLabel?.text, forKey: keyValue.inheritBeefbreed.rawValue)
                let inheritBreed = fetchAllDataProductBeefId(entityName: Entities.getBreedsTblEntity, breedName: (self.inheritBreedBttn.titleLabel?.text!)!, productId: 20)
                if inheritBreed.count != 0 {
                    let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                    self.breedId = medbreedRegArr1!.breedId ?? ""
                }
            }
            
            let inrementCheck = UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncrementalClear.rawValue)
            
            if inrementCheck == true {
                self.isBarcodeAutoIncrementedEnabled = true
                self.incrementalBarcodeCheckBoxInherit.image = UIImage(named: ImageNames.checkImg)
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
            }
            else {
                self.incrementalBarcodeCheckBoxInherit.image = UIImage(named: ImageNames.incrementalCheckImg)
                self.isBarcodeAutoIncrementedEnabled = false
            }
            self.inheritEarTagTextfield.becomeFirstResponder()
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
}
