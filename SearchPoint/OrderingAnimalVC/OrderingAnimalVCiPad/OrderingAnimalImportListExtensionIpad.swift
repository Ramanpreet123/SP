//
//  OrderingAnimalImportListExtensionIpad.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 05/04/25.
//

import Foundation
extension OrderingAnimalipadVC : ImportListProtocol {
    
    func importList(listNameString: String, listId: Int) {
        self.listNameString = listNameString
        self.listId = listId
        self.orderId = autoD
        if self.listId == 0 {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.selectListToImport, comment: "") )
            return
        }
        
        let allDataAnimalTbl1 = fetchAllDataAnimalAnimalIgnoreCase(entityName: Entities.dataEntryAnimalAddTbl,custmerId :UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userID :self.userId,listId:Int64(self.listId))
        
        if allDataAnimalTbl1.count == 0 {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.noAnimalsAddedStr, comment: ""))
//            importListMainView.isHidden = true
//            importBGView.isHidden = true
            return
        }
        let screenPerference = UserDefaults.standard.value(forKey: keyValue.screen.rawValue) as? String
        
        if screenPerference == keyValue.officialId.rawValue {
            allDataAnimalTbl = fetchAllDataAnimalAnimalIgnoreCase(entityName: Entities.dataEntryAnimalAddTbl,custmerId :UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userID :self.userId,listId:Int64(self.listId))
            arrayCountCond = fetchAllDataAnimalAnimalTagCheck(entityName: Entities.dataEntryAnimalAddTbl,anmalTag:"",custmerId :UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), userID: userId, listId: Int64(self.listId))
            
            if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == "True" {
                arrayCountCond = fetchAllDataAnimalFarmiIdCheckBothMandatory(entityName: Entities.dataEntryAnimalAddTbl,farmId:"",animalTag:"",custmerId :UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userID :userId, listId: Int64(listId))
            }
            
            if arrayCountCond.count == 0 {
                let aData =  fetchAnimaldataDairyOrderIdUserId(entityName: Entities.animalAddTblEntity, orderId: self.autoD, userId: self.userId,providerId:self.pvid)
                if aData.count > 0 {
                    for k in 0 ..< aData.count{
                        let data1 = aData[k] as! AnimaladdTbl
                        let offId = data1.animalTag
                        let farmId  = data1 .farmId
                        let dataEntryvalue =  fetchAllDataAnimalDatarderIdDateEntrycheckfarmIdOffId(entityName: Entities.dataEntryAnimalAddTbl, userId: self.userId, orderId: self.orderId, listid: Int64(self.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid, farmId: farmId ?? "" , animaTag: offId ?? "") as! [DataEntryAnimaladdTbl]
                        
                        if dataEntryvalue.count > 0 {
                            self.conflictArr.append(contentsOf: dataEntryvalue)
                        }
                    }
                    
                    if self.conflictArr.count > 0 {
                        let count1 = self.conflictArr.count
                        let alertPrint = String(count1) + " " + NSLocalizedString(LocalizedStrings.selectActionToBePerformed, comment: "")
                        
                        let alert = UIAlertController(title: self.listNameString, message: alertPrint, preferredStyle: .alert)
                        let ResolveAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default ,handler: {
                            (_)in
//                            self.importBGView.isHidden = true
//                            self.importListMainView.isHidden = true
                        })
                        
                        let IgnoreAction = UIAlertAction(title: NSLocalizedString("Ignore", comment: ""), style: UIAlertAction.Style.default, handler: { [self]
                            (_)in
                            
                            let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderId:orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(custmerId ), providerId: pvid)
                            
                            if fetchData11.count != 0 {
                                for i in 0...fetchData11.count - 1 {
                                    let dataGet = fetchData11.object(at: i) as! DataEntryAnimaladdTbl
                                    let fetchData =  fetchAllDataAnimalAnimalIdOfficalId(entityName: Entities.animalAddTblEntity, animalId: dataGet.farmId ?? "", anmalTag: dataGet.animalTag ?? "",custmerId: Int(dataGet.custmerId), userID: userId, orderId: self.orderId)
                                    if fetchData.count == 0 {
                                        
                                        let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:autoD, customerID: custmerId )
                                        if data12333.count > 0{
                                            if tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || tissueBtnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText {//|| tissuId == 1 || tissuId == 18 {
                                                
                                                saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                                
                                                UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                                UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                                UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                                UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                                UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                                self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                                self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                                saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                                
                                            }
                                            else{
                                                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                                
                                                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                                    UIAlertAction in
                                                    self.byDefaultSetting()
                                                    
                                                }
                                                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                                    UIAlertAction in
                                                    deleteDataWithProduct(Int(dataGet.animalId ))
                                                    deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                    deleteDataWithAnimal(Int(dataGet.animalId ))
                                                    UserDefaults.standard.set("", forKey: keyValue.tsuKey.rawValue)
                                                    self.byDefaultSetting()
                                                    return
                                                }
                                                alertController.addAction(okAction)
                                                alertController.addAction(cancelAction)
                                                self.present(alertController, animated: true, completion: nil)
                                                return
                                            }
                                        }
                                        else {
                                            saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                            
                                            UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                            UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                            UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                            UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                            UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                            self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                            self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                            saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                        }
                                        
                                        
                                        let animalData = fetchAnimaldataDairy(entityName: Entities.animalAddTblEntity, animalTag:Int(dataGet.animalId ),orderId:Int(self.orderId ),userId:userId)
                                        
                                        let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: Int(dataGet.providerId), breedId: dataGet.breedId ?? "" )
                                        for k in 0 ..< animalData.count{
                                            let animalId = animalData[k] as! AnimaladdTbl
                                            for i in 0 ..< product.count{
                                                let data = product[i] as! GetProductTbl
                                                if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                    let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:autoD, customerID: custmerId)
                                                    if data12333.count > 0 {
                                                        let adonDat =  fetchProductAdonDataWithBVDV(entityName: Entities.getAdonTblEntity, prodId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue),adonId : LocalizedStrings.bvdvAddOnId)
                                                        if adonDat.count > 0 {
                                                            addedd = true
                                                            saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                            updateOrderStatusAnimal(entity: Entities.dataEntryAnimalAddTbl, status: "true", orderId: Int(self.orderId), userId: userId, animalId: Int(dataGet.animalId ))
                                                        }
                                                    }
                                                    else {
                                                        saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                    }
                                                }
                                                else {
                                                    saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId ?? "", productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false",  farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                }
                                                
                                                if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                                                    addonArr = fetchProductAdonData(entityName : Entities.getAdonTblEntity,prodId: Int(data.productId),isCdcbProduct:false)
                                                } else {
                                                    addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                                }
                                                
                                                for j in 0 ..< addonArr.count {
                                                    let addonDat = addonArr[j] as! GetAdonTbl
                                                    if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                        let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:autoD, customerID: custmerId)
                                                        if data12333.count > 0 {
                                                            if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                                saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                                updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue), status: "true")
                                                                
                                                            }
                                                            else {
                                                                saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                            }
                                                        }
                                                        else {
                                                            saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                        }
                                                    }
                                                    
                                                    else {
                                                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                    }
                                                }
                                            }
                                            
                                            if data12333.count > 0 {
                                                if addedd == false {
                                                    let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAddedBVDV, comment: ""), preferredStyle: .alert)
                                                    
                                                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                                        UIAlertAction in
                                                        deleteDataWithProduct(Int(dataGet.animalId ))
                                                        deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                        deleteDataWithAnimal(Int(dataGet.animalId ))
                                                        
                                                        let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                        var bredidd123 = String ()
                                                        
                                                        if animalCount.count > 0 {
                                                            let breeid1 = animalCount.object(at: 0) as! AnimaladdTbl
                                                            bredidd123 = breeid1.breedName ?? ""
                                                        }
                                                        
                                                        for i in 0 ..< animalCount.count{
                                                            let breeid1 = animalCount.object(at: i) as! AnimaladdTbl
                                                            if bredidd123 == breeid1.breedName {
                                                                bredidd123 = breeid1.breedName ?? ""
                                                                UserDefaults.standard.set(breeid1.breedId, forKey: keyValue.breedId.rawValue)
                                                            }
                                                        }
                                                        self.byDefaultSetting()
                                                        self.notificationLblCount.text = String(animalCount.count)
                                                        return
                                                    }
                                                    let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                                        
                                                        UIAlertAction in
                                                        deleteDataWithProduct(Int(dataGet.animalId ))
                                                        deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                        deleteDataWithAnimal(Int(dataGet.animalId ))
                                                        
                                                        let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId ),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                        self.notificationLblCount.text = String(animalCount.count)
                                                        UserDefaults.standard.set("", forKey: keyValue.tsuKeyType.rawValue)
                                                        self.byDefaultSetting()
                                                        return
                                                    }
                                                    
                                                    alertController.addAction(okAction)
                                                    alertController.addAction(cancelAction)
                                                    self.present(alertController, animated: true, completion: nil)
                                                    return
                                                    
                                                }
                                            }
                                        }
                                        
                                        UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                                        let attributeString = NSMutableAttributedString(string: listNameString, attributes: self.attrs)
                                        mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                                   //     showAlertforwithoutBarcodeAnimal()
                                        
                                        if fetchMergeDataListId(entityName: Entities.mergeDataEntryListTblEntity,listId: Int64(dataGet.listId),customerId: Int64(self.custmerId )).count == 0 {
                                            let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ))
                                            let listObject = fetchList.object(at: 0) as? DataEntryList
                                            let listDescr = listObject?.listDesc
                                            saveMergeDataEntryList(entity: Entities.mergeDataEntryListTblEntity, customerId: Int64(self.custmerId ), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                        }
                                        UserDefaults.standard.setValue(listNameString, forKey: keyValue.dataEntryListName.rawValue)
//                                        crossedBtnOutlet.isHidden = false
//                                        importFromListOutlet.isEnabled = true
                                    }
                                }
                            }
                            
//                            importListMainView.isHidden = true
//                            importBGView.isHidden = true
                            let attributeString = NSMutableAttributedString(string: listNameString, attributes: self.attrs)
                            mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                            UserDefaults.standard.setValue(listNameString, forKey: keyValue.dataEntryListName.rawValue)
                           // crossedBtnOutlet.isHidden = false
                            let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ,providerId:pvid)
                            
                            if fetchObj.count != 0 {
                                let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                let obj = objectFetch?.listName
                                let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
                                
                                if fetchAllMergeDta == 0 {
                                    let fetchNameDisplay = String(obj ?? "")
                                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                    mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                    
                                } else {
                                    let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                    mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                }
                            }
                            
                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: pvid)
                            notificationLblCount.text = String(animalCount.count)
                            showAlertforwithoutBarcodeAnimal()
                            if animalCount.count == 0 {
                                notificationLblCount.isHidden = true
                                countLbl.isHidden = true
                                self.cartView.isHidden = true
                            } else {
                                notificationLblCount.isHidden = false
                                countLbl.isHidden = false
                                self.cartView.isHidden = false
                            }
                        })
                        alert.addAction(ResolveAction)
                        alert.addAction(IgnoreAction)
//                        importListMainView.isHidden = true
//                        importBGView.isHidden = true
                        DispatchQueue.main.async(execute: {
                            self.present(alert, animated: true)
                        })
                    }else {
                        let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderId:orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(custmerId ), providerId: pvid)
                        
                        if fetchData11.count != 0 {
                            for i in 0...fetchData11.count - 1 {
                                let dataGet = fetchData11.object(at: i) as! DataEntryAnimaladdTbl
                                let fetchData =  fetchAllDataAnimalAnimalIdOfficalId(entityName: Entities.animalAddTblEntity, animalId: dataGet.farmId ?? "", anmalTag: dataGet.animalTag ?? "",custmerId: Int(dataGet.custmerId), userID: userId, orderId: self.orderId)
                                if fetchData.count == 0 {
                                    let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:autoD, customerID: custmerId)
                                    if data12333.count > 0{
                                        if tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || tissueBtnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                                            
                                            saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                            
                                            UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                            UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                            UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                            UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                            UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                            self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                            self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                            saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                        }
                                        else{
                                            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                            
                                            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                self.byDefaultSetting()
                                            }
                                            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                deleteDataWithProduct(Int(dataGet.animalId ))
                                                deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                deleteDataWithAnimal(Int(dataGet.animalId ))
                                                UserDefaults.standard.set("", forKey: keyValue.tsuKey.rawValue)
                                                self.byDefaultSetting()
                                                return
                                            }
                                            alertController.addAction(okAction)
                                            alertController.addAction(cancelAction)
                                            self.present(alertController, animated: true, completion: nil)
                                            return
                                        }
                                    }
                                    else {
                                        saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                        
                                        UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                        UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                        UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                        UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                        UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                        self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                        self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                        saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                    }
                                    
                                    let animalData = fetchAnimaldataDairy(entityName: Entities.animalAddTblEntity, animalTag:Int(dataGet.animalId ),orderId:Int(self.orderId ),userId:userId)
                                    let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: Int(dataGet.providerId), breedId: dataGet.breedId ?? "" )
                                    
                                    for k in 0 ..< animalData.count{
                                        let animalId = animalData[k] as! AnimaladdTbl
                                        
                                        for i in 0 ..< product.count{
                                            let data = product[i] as! GetProductTbl
                                            if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:autoD, customerID: custmerId)
                                                if data12333.count > 0 {
                                                    let adonDat =  fetchProductAdonDataWithBVDV(entityName: Entities.getAdonTblEntity, prodId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue),adonId : LocalizedStrings.bvdvAddOnId)
                                                    if adonDat.count > 0 {
                                                        addedd = true
                                                        saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                        updateOrderStatusAnimal(entity: Entities.dataEntryAnimalAddTbl, status: "true", orderId: Int(self.orderId), userId: userId, animalId: Int(dataGet.animalId ))
                                                    }
                                                }
                                                else {
                                                    saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                }
                                            }
                                            else {
                                                saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId ?? "", productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false",  farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                            }
                                            
                                            if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                                                addonArr = fetchProductAdonData(entityName : Entities.getAdonTblEntity,prodId: Int(data.productId),isCdcbProduct:false)
                                                
                                            } else {
                                                addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                            }
                                            
                                            for j in 0 ..< addonArr.count {
                                                let addonDat = addonArr[j] as! GetAdonTbl
                                                
                                                if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                    let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:autoD, customerID: custmerId)
                                                    
                                                    if data12333.count > 0 {
                                                        if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                            saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                            updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue), status: "true")
                                                            
                                                        }
                                                        else {
                                                            saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                        }
                                                    }
                                                    else {
                                                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                    }
                                                }
                                                
                                                else {
                                                    saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                }
                                            }
                                        }
                                        
                                        
                                        if data12333.count > 0 {
                                            if addedd == false {
                                                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAddedBVDV, comment: ""), preferredStyle: .alert)
                                                
                                                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                                    UIAlertAction in
                                                    
                                                    deleteDataWithProduct(Int(dataGet.animalId ))
                                                    deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                    deleteDataWithAnimal(Int(dataGet.animalId ))
                                                    
                                                    let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                    var bredidd123 = String ()
                                                    
                                                    if animalCount.count > 0 {
                                                        let breeid1 = animalCount.object(at: 0) as! AnimaladdTbl
                                                        bredidd123 = breeid1.breedName ?? ""
                                                    }
                                                    
                                                    for i in 0 ..< animalCount.count{
                                                        let breeid1 = animalCount.object(at: i) as! AnimaladdTbl
                                                        if bredidd123 == breeid1.breedName {
                                                            bredidd123 = breeid1.breedName ?? ""
                                                            UserDefaults.standard.set(breeid1.breedId, forKey: keyValue.breedId.rawValue)
                                                            
                                                        }
                                                    }
                                                    self.byDefaultSetting()
                                                    self.notificationLblCount.text = String(animalCount.count)
                                                    return
                                                }
                                                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                                    UIAlertAction in
                                                    
                                                    deleteDataWithProduct(Int(dataGet.animalId ))
                                                    deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                    deleteDataWithAnimal(Int(dataGet.animalId ))
                                                    let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId ),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                    self.notificationLblCount.text = String(animalCount.count)
                                                    UserDefaults.standard.set("", forKey: keyValue.tsuKeyType.rawValue)
                                                    self.byDefaultSetting()
                                                    return
                                                }
                                                
                                                alertController.addAction(okAction)
                                                alertController.addAction(cancelAction)
                                                self.present(alertController, animated: true, completion: nil)
                                                return
                                            }
                                        }
                                    }
                                    
                                    UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                                    let attributeString = NSMutableAttributedString(string: listNameString, attributes: self.attrs)
                                    mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                                    mergeListBtnOulet.isHidden = false
                                    mergeListView.isHidden = false
                                   // showAlertforwithoutBarcodeAnimal()
                                    
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
                                            mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                        } else {
                                            let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                            mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                        }
                                    }
                                    
                                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: pvid)
                                    notificationLblCount.text = String(animalCount.count)
                                    
                                    if animalCount.count == 0 {
                                        notificationLblCount.isHidden = true
                                        countLbl.isHidden = true
                                        self.cartView.isHidden = true
                                    } else {
                                        notificationLblCount.isHidden = false
                                        countLbl.isHidden = false
                                        self.cartView.isHidden = false
                                    }
                                    UserDefaults.standard.setValue(listNameString, forKey: keyValue.dataEntryListName.rawValue)
//                                    crossedBtnOutlet.isHidden = false
//                                    importFromListOutlet.isEnabled = true
                                }
                            }
                        }
                        
//                        importListMainView.isHidden = true
//                        importBGView.isHidden = true
                        showAlertforwithoutBarcodeAnimal()
                    }
                    
                } else {
                    let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderId:orderId,orderStatus:"false",listid:Int64(listId), custmerId: Int64(custmerId ), providerId: pvid)
                    
                    if fetchData11.count != 0 {
                        for i in 0...fetchData11.count - 1 {
                            let dataGet = fetchData11.object(at: i) as! DataEntryAnimaladdTbl
                            let fetchData =  fetchAllDataAnimalAnimalIdOfficalId(entityName: Entities.animalAddTblEntity, animalId: dataGet.farmId ?? "", anmalTag: dataGet.animalTag ?? "",custmerId: Int(dataGet.custmerId), userID: userId, orderId: self.orderId)
                            
                            if fetchData.count == 0 {
                                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:autoD, customerID: custmerId)
                                
                                if data12333.count > 0{
                                    if tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || tissueBtnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                                        
                                        saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                        
                                        UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                        UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                        UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                        UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                        UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                        self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                        self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                        saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                        
                                    }
                                    else{
                                        let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                        
                                        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                            UIAlertAction in
                                            self.byDefaultSetting()
                                            
                                        }
                                        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                            UIAlertAction in
                                            
                                            deleteDataWithProduct(Int(dataGet.animalId ))
                                            deleteDataWithSubProduct(Int(dataGet.animalId ))
                                            deleteDataWithAnimal(Int(dataGet.animalId ))
                                            UserDefaults.standard.set("", forKey: keyValue.tsuKey.rawValue)
                                            self.byDefaultSetting()
                                            return
                                        }
                                        
                                        alertController.addAction(okAction)
                                        alertController.addAction(cancelAction)
                                        self.present(alertController, animated: true, completion: nil)
                                        return
                                    }
                                }
                                else {
                                    saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                    
                                    UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                    UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                    UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                    UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                    UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                    self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                    self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                    saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                    
                                }
                                let animalData = fetchAnimaldataDairy(entityName: Entities.animalAddTblEntity, animalTag:Int(dataGet.animalId ),orderId:Int(self.orderId ),userId:userId)
                                let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: Int(dataGet.providerId), breedId: dataGet.breedId ?? "" )
                                
                                for k in 0 ..< animalData.count{
                                    let animalId = animalData[k] as! AnimaladdTbl
                                    
                                    for i in 0 ..< product.count{
                                        let data = product[i] as! GetProductTbl
                                        
                                        if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                            let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:autoD, customerID: custmerId)
                                            if data12333.count > 0 {
                                                let adonDat =  fetchProductAdonDataWithBVDV(entityName: Entities.getAdonTblEntity, prodId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue),adonId : LocalizedStrings.bvdvAddOnId)
                                                if adonDat.count > 0 {
                                                    addedd = true
                                                    saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                    updateOrderStatusAnimal(entity: Entities.dataEntryAnimalAddTbl, status: "true", orderId: Int(self.orderId), userId: userId, animalId: Int(dataGet.animalId ))
                                                }
                                            }
                                            else {
                                                saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                            }
                                        }
                                        else {
                                            saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId ?? "", productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false",  farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                        }
                                        
                                        if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                                            addonArr = fetchProductAdonData(entityName : Entities.getAdonTblEntity,prodId: Int(data.productId),isCdcbProduct:false)
                                            
                                        } else {
                                            addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                        }
                                        
                                        for j in 0 ..< addonArr.count {
                                            let addonDat = addonArr[j] as! GetAdonTbl
                                            if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:autoD, customerID: custmerId)
                                                if data12333.count > 0 {
                                                    if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                        updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue), status: "true")
                                                        
                                                    }
                                                    else {
                                                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                    }
                                                }
                                                else {
                                                    saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                }
                                            }
                                            else {
                                                saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                            }
                                        }
                                    }
                                    
                                    if data12333.count > 0 {
                                        if addedd == false {
                                            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAddedBVDV, comment: ""), preferredStyle: .alert)
                                            
                                            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                
                                                deleteDataWithProduct(Int(dataGet.animalId ))
                                                deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                deleteDataWithAnimal(Int(dataGet.animalId ))
                                                let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                var bredidd123 = String ()
                                                
                                                if animalCount.count > 0 {
                                                    let breeid1 = animalCount.object(at: 0) as! AnimaladdTbl
                                                    bredidd123 = breeid1.breedName ?? ""
                                                }
                                                
                                                for i in 0 ..< animalCount.count{
                                                    let breeid1 = animalCount.object(at: i) as! AnimaladdTbl
                                                    if bredidd123 == breeid1.breedName {
                                                        bredidd123 = breeid1.breedName ?? ""
                                                        UserDefaults.standard.set(breeid1.breedId, forKey: keyValue.breedId.rawValue)
                                                    }
                                                }
                                                self.byDefaultSetting()
                                                self.notificationLblCount.text = String(animalCount.count)
                                                return
                                            }
                                            
                                            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                
                                                deleteDataWithProduct(Int(dataGet.animalId ))
                                                deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                deleteDataWithAnimal(Int(dataGet.animalId ))
                                                let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId ),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                self.notificationLblCount.text = String(animalCount.count)
                                                UserDefaults.standard.set("", forKey: keyValue.tsuKeyType.rawValue)
                                                self.byDefaultSetting()
                                                return
                                            }
                                            
                                            alertController.addAction(okAction)
                                            alertController.addAction(cancelAction)
                                            self.present(alertController, animated: true, completion: nil)
                                            return
                                        }
                                    }
                                }
                                
                                UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                                let attributeString = NSMutableAttributedString(string: listNameString, attributes: self.attrs)
                                mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                                self.mergeListBtnOulet.isHidden = false
                                self.mergeListView.isHidden = false
                             //   self.crossedBtnOutlet.isHidden = false
                               // showAlertforwithoutBarcodeAnimal()
                                
                                if fetchMergeDataListId(entityName: Entities.mergeDataEntryListTblEntity,listId: Int64(dataGet.listId),customerId: Int64(self.custmerId )).count == 0 {
                                    let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ))
                                    let listObject = fetchList.object(at: 0) as? DataEntryList
                                    let listDescr = listObject?.listDesc
                                    
                                    saveMergeDataEntryList(entity: Entities.mergeDataEntryListTblEntity, customerId: Int64(self.custmerId ), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                }
                                
                                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: pvid)
                                notificationLblCount.text = String(animalCount.count)
                                if animalCount.count == 0 {
                                    notificationLblCount.isHidden = true
                                    countLbl.isHidden = true
                                    self.cartView.isHidden = false
                                } else {
                                    notificationLblCount.isHidden = false
                                    countLbl.isHidden = false
                                    self.cartView.isHidden = false
                                }
                                
                                UserDefaults.standard.setValue(listNameString, forKey: keyValue.dataEntryListName.rawValue)
//                                crossedBtnOutlet.isHidden = false
//                                importFromListOutlet.isEnabled = true
                            }
                        }
                    }
//                    importListMainView.isHidden = true
//                    importBGView.isHidden = true
                    showAlertforwithoutBarcodeAnimal()
                }
            }
            else {
                let count1 = arrayCountCond.count
                let alertPrint = String(count1) + " " + LocalizedStrings.animalsMissingInfo
                let alert = UIAlertController(title: listNameString, message: alertPrint, preferredStyle: .alert)
                
                let ResolveAction = UIAlertAction(title: "Resolve", style: UIAlertAction.Style.default ,handler: {
                    (_)in
                    let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "DataEntryConflictedImportListIpad") as! DataEntryConflictedImportListIpad
                    vc.listId = self.listId
                    UserDefaults.standard.set(self.listId, forKey: keyValue.listIdSaveOnSelection.rawValue)
                    self.navigationController?.pushViewController(vc,animated: false)
                    
                })
                
                let IgnoreAction = UIAlertAction(title: "Ignore", style: UIAlertAction.Style.default, handler: { [self]
                    (_)in
                    let aData =  fetchAnimaldataDairyOrderIdUserId(entityName: Entities.animalAddTblEntity, orderId: self.autoD, userId: self.userId,providerId:self.pvid)
                    
                    if aData.count > 0 {
                        for k in 0 ..< aData.count{
                            let data1 = aData[k] as! AnimaladdTbl
                            let offId = data1.animalTag
                            let farmId  = data1 .farmId
                            let dataEntryvalue =  fetchAllDataAnimalDatarderIdDateEntrycheckfarmIdOffId(entityName: Entities.dataEntryAnimalAddTbl, userId: self.userId, orderId: self.orderId, listid: Int64(self.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid, farmId: farmId ?? "" , animaTag: offId ?? "") as! [DataEntryAnimaladdTbl]
                            
                            if dataEntryvalue.count > 0 {
                                self.conflictArr.append(contentsOf: dataEntryvalue)
                            }
                        }
                        
                        if self.conflictArr.count > 0 {
                            let count1 = self.conflictArr.count
                            let alertPrint = String(count1) + " " + NSLocalizedString(LocalizedStrings.selectActionToBePerformed, comment: "")
                            let alert = UIAlertController(title: self.listNameString, message: alertPrint, preferredStyle: .alert)
                            let ResolveAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default ,handler: {
                                (_)in
//                                self.importBGView.isHidden = true
//                                self.importListMainView.isHidden = true
                            })
                            
                            let IgnoreAction = UIAlertAction(title: NSLocalizedString("Ignore", comment: ""), style: UIAlertAction.Style.default, handler: { [self]
                                (_)in
                                
                                let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderId:orderId,orderStatus:"false",listid:Int64(listId), custmerId: Int64(self.custmerId ), providerId: pvid)
                                
                                if fetchData11.count != 0 {
                                    for i in 0...fetchData11.count - 1 {
                                        let dataGet = fetchData11.object(at: i) as! DataEntryAnimaladdTbl
                                        
                                        if dataGet.animalTag != "" {
                                            let fetchData =  fetchAllDataAnimalAnimalIdOfficalId(entityName: Entities.animalAddTblEntity, animalId: dataGet.farmId ?? "", anmalTag: dataGet.animalTag ?? "",custmerId: Int(dataGet.custmerId), userID: self.userId, orderId: self.orderId)
                                            
                                            if fetchData.count == 0 {
                                                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:orderId, customerID: custmerId)
                                                
                                                if data12333.count > 0{
                                                    if self.tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || tissueBtnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                                                        
                                                        saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                                        
                                                        UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                                        UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                                        UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                                        UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                                        UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                                        self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                                        self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                                        saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                                        
                                                    }
                                                    else{
                                                        let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                                        
                                                        let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) {
                                                            UIAlertAction in
                                                            self.byDefaultSetting()
                                                        }
                                                        
                                                        let cancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
                                                            UIAlertAction in
                                                            
                                                            deleteDataWithProduct(Int(dataGet.animalId ))
                                                            deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                            deleteDataWithAnimal(Int(dataGet.animalId ))
                                                            UserDefaults.standard.set("", forKey: keyValue.tsuKey.rawValue)
                                                            self.byDefaultSetting()
                                                            return
                                                        }
                                                        
                                                        alertController.addAction(okAction)
                                                        alertController.addAction(cancelAction)
                                                        self.present(alertController, animated: true, completion: nil)
                                                        return
                                                    }
                                                }
                                                else {
                                                    saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                                    
                                                    UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                                    UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                                    UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                                    UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                                    UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                                    self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                                    self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                                    saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                                    
                                                }
                                                
                                                let animalData = fetchAnimaldataDairy(entityName: Entities.animalAddTblEntity, animalTag:Int(dataGet.animalId ),orderId:Int(self.orderId ),userId:self.userId)
                                                let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: Int(dataGet.providerId), breedId: dataGet.breedId ?? "" )
                                                
                                                for k in 0 ..< animalData.count{
                                                    let animalId = animalData[k] as! AnimaladdTbl
                                                    
                                                    for i in 0 ..< product.count{
                                                        let data = product[i] as! GetProductTbl
                                                        if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                            let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.autoD, customerID: custmerId)
                                                            if data12333.count > 0 {
                                                                let adonDat =  fetchProductAdonDataWithBVDV(entityName: Entities.getAdonTblEntity, prodId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue),adonId : LocalizedStrings.bvdvAddOnId)
                                                                if adonDat.count > 0 {
                                                                    self.addedd = true
                                                                    saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "true", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                                    updateOrderStatusAnimal(entity: Entities.dataEntryAnimalAddTbl, status: "true", orderId: Int(self.orderId), userId: self.userId, animalId: Int(dataGet.animalId ))
                                                                }
                                                            }
                                                            else {
                                                                saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "false", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                            }
                                                        }
                                                        else {
                                                            saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId ?? "", productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "false",  farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                        }
                                                        
                                                        if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                                                            addonArr = fetchProductAdonData(entityName : Entities.getAdonTblEntity,prodId: Int(data.productId),isCdcbProduct:false)
                                                            
                                                        } else {
                                                            addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                                        }
                                                        
                                                        for j in 0 ..< addonArr.count {
                                                            let addonDat = addonArr[j] as! GetAdonTbl
                                                            
                                                            if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.autoD,customerID: custmerId)
                                                                
                                                                if data12333.count > 0 {
                                                                    if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:self.timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                                        updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue), status: "true")
                                                                        
                                                                    }
                                                                    else {
                                                                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:self.timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                                    }
                                                                }
                                                                else {
                                                                    saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:self.timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                                }
                                                            }
                                                            
                                                            else {
                                                                saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:self.timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                            }
                                                        }
                                                    }
                                                    
                                                    if data12333.count > 0 {
                                                        if self.addedd == false {
                                                            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAddedBVDV, comment: ""), preferredStyle: .alert)
                                                            
                                                            let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) {
                                                                UIAlertAction in
                                                                
                                                                deleteDataWithProduct(Int(dataGet.animalId ))
                                                                deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                                deleteDataWithAnimal(Int(dataGet.animalId ))
                                                                let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                                var bredidd123 = String ()
                                                                
                                                                if animalCount.count > 0 {
                                                                    let breeid1 = animalCount.object(at: 0) as! AnimaladdTbl
                                                                    bredidd123 = breeid1.breedName ?? ""
                                                                }
                                                                
                                                                for i in 0 ..< animalCount.count{
                                                                    let breeid1 = animalCount.object(at: i) as! AnimaladdTbl
                                                                    if bredidd123 == breeid1.breedName {
                                                                        bredidd123 = breeid1.breedName ?? ""
                                                                        UserDefaults.standard.set(breeid1.breedId, forKey: keyValue.breedId.rawValue)
                                                                    }
                                                                }
                                                                self.byDefaultSetting()
                                                                self.notificationLblCount.text = String(animalCount.count)
                                                                return
                                                            }
                                                            
                                                            let cancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
                                                                UIAlertAction in
                                                                
                                                                deleteDataWithProduct(Int(dataGet.animalId ))
                                                                deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                                deleteDataWithAnimal(Int(dataGet.animalId ))
                                                                
                                                                let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId ),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                                self.notificationLblCount.text = String(animalCount.count)
                                                                self.byDefaultSetting()
                                                                return
                                                            }
                                                            
                                                            alertController.addAction(okAction)
                                                            alertController.addAction(cancelAction)
                                                            self.present(alertController, animated: true, completion: nil)
                                                            return
                                                            
                                                        }
                                                    }
                                                }
                                                
                                                UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                                                let attributeString = NSMutableAttributedString(string: listNameString, attributes: self.attrs)
                                                mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                                self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                                                self.mergeListBtnOulet.isHidden = false
                                                self.mergeListView.isHidden = false
                                               // showAlertforwithoutBarcodeAnimal()
                                                UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                                           //     self.crossedBtnOutlet.isHidden = false
                                                
                                                if fetchMergeDataListId(entityName: Entities.mergeDataEntryListTblEntity,listId: Int64(dataGet.listId),customerId: Int64(self.custmerId )).count == 0 {
                                                    let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ))
                                                    let listObject = fetchList.object(at: 0) as? DataEntryList
                                                    let listDescr = listObject?.listDesc
                                                    
                                                    saveMergeDataEntryList(entity: Entities.mergeDataEntryListTblEntity, customerId: Int64(self.custmerId ), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                                }
                                                
                                                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: pvid)
                                                notificationLblCount.text = String(animalCount.count)
                                                let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ,providerId:pvid )
                                                
                                                if fetchObj.count != 0 {
                                                    let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                                    let obj = objectFetch?.listName
                                                    let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
                                                    
                                                    if fetchAllMergeDta == 0 {
                                                        let fetchNameDisplay = String(obj ?? "")
                                                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                                        mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                                        
                                                    } else {
                                                        let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                                        mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                                    }
                                                }
                                                
                                            } else {
                                                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: pvid)
                                                notificationLblCount.text = String(animalCount.count)
                                            }
                                        }
                                      
                                    }
                                    let fetchCheckListId = fetchAllDataOrderListIDgET(entityName: Entities.animalAddTblEntity,ordestatus: "false",orderId:self.orderId,userId:self.userId,listId:0)
                                    
                                    if fetchCheckListId.count == 0{
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.noAnimalsAddedToOrder, comment: ""), duration: 2, position: .top)
                                    }
                                }
                                
                                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: pvid)
                                notificationLblCount.text = String(animalCount.count)
                                showAlertforwithoutBarcodeAnimal()
//                                self.importListMainView.isHidden = true
//                                self.importBGView.isHidden = true
//                                self.importFromListOutlet.isEnabled = true
                            })
                            
                            alert.addAction(ResolveAction)
                            alert.addAction(IgnoreAction)
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                        else {
                            
                            let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderId:orderId,orderStatus:"false",listid:Int64(listId), custmerId: Int64(self.custmerId ), providerId: pvid)
                            if fetchData11.count != 0 {
                                
                                for i in 0...fetchData11.count - 1 {
                                    let dataGet = fetchData11.object(at: i) as! DataEntryAnimaladdTbl
                                    
                                    if dataGet.animalTag != "" {
                                        let fetchData =  fetchAllDataAnimalAnimalIdOfficalId(entityName: Entities.animalAddTblEntity, animalId: dataGet.farmId ?? "", anmalTag: dataGet.animalTag ?? "",custmerId: Int(dataGet.custmerId), userID: self.userId, orderId: self.orderId)
                                        if fetchData.count == 0 {
                                            
                                            let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.orderId, customerID: custmerId)
                                            if data12333.count > 0{
                                                if self.tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || self.tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || self.tissueBtnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                                                    
                                                    saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(self.userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                                    
                                                    UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                                    UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                                    UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                                    UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                                    UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                                    self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                                    self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                                    saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                                    
                                                }
                                                else{
                                                    let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                                    
                                                    let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) {
                                                        UIAlertAction in
                                                        self.byDefaultSetting()
                                                        
                                                    }
                                                    let cancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
                                                        UIAlertAction in
                                                        
                                                        deleteDataWithProduct(Int(dataGet.animalId ))
                                                        deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                        deleteDataWithAnimal(Int(dataGet.animalId ))
                                                        UserDefaults.standard.set("", forKey: keyValue.tsuKey.rawValue)
                                                        self.byDefaultSetting()
                                                        return
                                                    }
                                                    
                                                    alertController.addAction(okAction)
                                                    alertController.addAction(cancelAction)
                                                    self.present(alertController, animated: true, completion: nil)
                                                    return
                                                }
                                            }
                                            else {
                                                saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(self.userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                                
                                                UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                                UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                                UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                                UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                                UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                                self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                                self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                                saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                            }
                                            
                                            let animalData = fetchAnimaldataDairy(entityName: Entities.animalAddTblEntity, animalTag:Int(dataGet.animalId ),orderId:Int(self.orderId ),userId:self.userId)
                                            let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: Int(dataGet.providerId), breedId: dataGet.breedId ?? "" )
                                            
                                            for k in 0 ..< animalData.count{
                                                let animalId = animalData[k] as! AnimaladdTbl
                                                
                                                for i in 0 ..< product.count{
                                                    let data = product[i] as! GetProductTbl
                                                    if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                        let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.autoD,customerID: custmerId)
                                                        if data12333.count > 0 {
                                                            let adonDat =  fetchProductAdonDataWithBVDV(entityName: Entities.getAdonTblEntity, prodId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue),adonId : LocalizedStrings.bvdvAddOnId)
                                                            if adonDat.count > 0 {
                                                                self.addedd = true
                                                                saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "true", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                                updateOrderStatusAnimal(entity: Entities.dataEntryAnimalAddTbl, status: "true", orderId: Int(self.orderId), userId: self.userId, animalId: Int(dataGet.animalId ))
                                                            }
                                                        }
                                                        else {
                                                            saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "false", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                        }
                                                    }
                                                    else {
                                                        saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId ?? "", productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "false",  farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                    }
                                                    
                                                    if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                                                        addonArr = fetchProductAdonData(entityName : Entities.getAdonTblEntity,prodId: Int(data.productId),isCdcbProduct:false)
                                                        
                                                    } else {
                                                        addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                                    }
                                                    
                                                    for j in 0 ..< addonArr.count {
                                                        let addonDat = addonArr[j] as! GetAdonTbl
                                                        if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                            let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.autoD,customerID: custmerId)
                                                            if data12333.count > 0 {
                                                                if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                                    saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                                    updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue), status: "true")
                                                                    
                                                                }
                                                                else {
                                                                    saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                                }
                                                            }
                                                            else {
                                                                saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                            }
                                                        }
                                                        
                                                        else {
                                                            saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                        }
                                                    }
                                                }
                                                
                                                if data12333.count > 0 {
                                                    if self.addedd == false {
                                                        let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAddedBVDV, comment: ""), preferredStyle: .alert)
                                                        
                                                        let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) {
                                                            UIAlertAction in
                                                            
                                                            deleteDataWithProduct(Int(dataGet.animalId ))
                                                            deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                            deleteDataWithAnimal(Int(dataGet.animalId ))
                                                            let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                            var bredidd123 = String ()
                                                            
                                                            if animalCount.count > 0 {
                                                                let breeid1 = animalCount.object(at: 0) as! AnimaladdTbl
                                                                bredidd123 = breeid1.breedName ?? ""
                                                            }
                                                            
                                                            for i in 0 ..< animalCount.count{
                                                                let breeid1 = animalCount.object(at: i) as! AnimaladdTbl
                                                                
                                                                if bredidd123 == breeid1.breedName {
                                                                    bredidd123 = breeid1.breedName ?? ""
                                                                    UserDefaults.standard.set(breeid1.breedId, forKey: keyValue.breedId.rawValue)
                                                                    
                                                                }
                                                            }
                                                            self.byDefaultSetting()
                                                            self.notificationLblCount.text = String(animalCount.count)
                                                            return
                                                        }
                                                        
                                                        let cancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
                                                            UIAlertAction in
                                                            
                                                            deleteDataWithProduct(Int(dataGet.animalId ))
                                                            deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                            deleteDataWithAnimal(Int(dataGet.animalId ))
                                                            let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId ),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                            self.notificationLblCount.text = String(animalCount.count)
                                                            self.byDefaultSetting()
                                                            return
                                                        }
                                                        
                                                        alertController.addAction(okAction)
                                                        alertController.addAction(cancelAction)
                                                        self.present(alertController, animated: true, completion: nil)
                                                        return
                                                        
                                                    }
                                                }
                                            }
                                            UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                                            
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
                                                    mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                                }
                                                else {
                                                    let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                                    mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                                    
                                                }
                                            }
                                            self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                                            self.mergeListBtnOulet.isHidden = false
                                            self.mergeListView.isHidden = false
                                            
                                            UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                                        //    self.crossedBtnOutlet.isHidden = false
                                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: pvid)
                                            self.notificationLblCount.text = String(animalCount.count)
                                        }
                                        else {
                                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: pvid)
                                            self.notificationLblCount.text = String(animalCount.count)
                                        }
                                    }
                                   
                                }
                                let fetchCheckListId = fetchAllDataOrderListIDgET(entityName: Entities.animalAddTblEntity,ordestatus: "false",orderId:self.orderId,userId:self.userId,listId:0)
                                
                                if fetchCheckListId.count == 0{
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noAnimalsAddedToOrder, comment: ""), duration: 2, position: .top)
                                }
                            }
                            showAlertforwithoutBarcodeAnimal()
                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: pvid)
                            self.notificationLblCount.text = String(animalCount.count)
//                            self.importListMainView.isHidden = true
//                            self.importBGView.isHidden = true
//                            self.importFromListOutlet.isEnabled = true
                        }
                    }
                    else {
                        for i in 0...self.allDataAnimalTbl.count - 1{
                            let dataGet = self.allDataAnimalTbl.object(at: i) as! DataEntryAnimaladdTbl
                            let data = dataGet.value(forKey: "animalTag") as? String
                            
                            if data != "" {
                                let fetchData =  fetchAllDataAnimalAnimalIdOfficalId(entityName: Entities.animalAddTblEntity, animalId: dataGet.farmId ?? "", anmalTag: dataGet.animalTag ?? "",custmerId: Int(dataGet.custmerId), userID: self.userId,orderId:self.orderId)
                                if fetchData.count == 0 {
                                    
                                    let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.orderId,customerID: custmerId)
                                    if data12333.count > 0{
                                        if self.tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || self.tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || self.tissueBtnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText {//|| tissuId == 1 || tissuId == 18 {
                                            
                                            saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(self.userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                            
                                            UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                            UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                            UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                            UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                            UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                            self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                            self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                            saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                        }
                                        else{
                                            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                            
                                            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                self.byDefaultSetting()
                                                
                                            }
                                            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                
                                                deleteDataWithProduct(Int(dataGet.animalId ))
                                                deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                deleteDataWithAnimal(Int(dataGet.animalId ))
                                                UserDefaults.standard.set("", forKey: keyValue.tsuKey.rawValue)
                                                self.byDefaultSetting()
                                                return
                                            }
                                            
                                            alertController.addAction(okAction)
                                            alertController.addAction(cancelAction)
                                            self.present(alertController, animated: true, completion: nil)
                                            return
                                        }
                                    }
                                    else {
                                        saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(self.userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                        
                                        UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                        UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                        UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                        UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                        UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                        self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                        self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                        saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                    }
                                    let animalData = fetchAnimaldataDairy(entityName: Entities.animalAddTblEntity, animalTag:Int(dataGet.animalId ),orderId:Int(self.orderId ),userId:self.userId)
                                    let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: Int(dataGet.providerId), breedId: dataGet.breedId ?? "" )
                                    
                                    for k in 0 ..< animalData.count{
                                        let animalId = animalData[k] as! AnimaladdTbl
                                        
                                        for i in 0 ..< product.count{
                                            let data = product[i] as! GetProductTbl
                                            
                                            if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.autoD,customerID: custmerId)
                                                
                                                if data12333.count > 0 {
                                                    let adonDat =  fetchProductAdonDataWithBVDV(entityName: Entities.getAdonTblEntity, prodId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue),adonId : LocalizedStrings.bvdvAddOnId)
                                                    if adonDat.count > 0 {
                                                        self.addedd = true
                                                        saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "true", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                        updateOrderStatusAnimal(entity: Entities.dataEntryAnimalAddTbl, status: "true", orderId: Int(self.orderId), userId: self.userId, animalId: Int(dataGet.animalId ))
                                                    }
                                                }
                                                else {
                                                    saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "false", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                }
                                            }
                                            else {
                                                saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId ?? "", productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "false",  farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                            }
                                            
                                            if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                                                addonArr = fetchProductAdonData(entityName : Entities.getAdonTblEntity,prodId: Int(data.productId),isCdcbProduct:false)
                                                
                                            } else {
                                                addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                            }
                                            
                                            for j in 0 ..< addonArr.count {
                                                let addonDat = addonArr[j] as! GetAdonTbl
                                                
                                                if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                    let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.autoD,customerID: custmerId)
                                                    
                                                    if data12333.count > 0 {
                                                        if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                            saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                            updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue), status: "true")
                                                        }
                                                        else {
                                                            saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                        }
                                                    }
                                                    else {
                                                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                    }
                                                }
                                                
                                                else {
                                                    saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                }
                                            }
                                        }
                                        
                                        if data12333.count > 0 {
                                            if self.addedd == false {
                                                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAddedBVDV, comment: ""), preferredStyle: .alert)
                                                
                                                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                                    UIAlertAction in
                                                    
                                                    deleteDataWithProduct(Int(dataGet.animalId ))
                                                    deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                    deleteDataWithAnimal(Int(dataGet.animalId ))
                                                    let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                    var bredidd123 = String ()
                                                    if animalCount.count > 0 {
                                                        let breeid1 = animalCount.object(at: 0) as! AnimaladdTbl
                                                        bredidd123 = breeid1.breedName ?? ""
                                                    }
                                                    for i in 0 ..< animalCount.count{
                                                        let breeid1 = animalCount.object(at: i) as! AnimaladdTbl
                                                        if bredidd123 == breeid1.breedName {
                                                            bredidd123 = breeid1.breedName ?? ""
                                                            UserDefaults.standard.set(breeid1.breedId, forKey: keyValue.breedId.rawValue)
                                                        }
                                                    }
                                                    self.byDefaultSetting()
                                                    self.notificationLblCount.text = String(animalCount.count)
                                                    return
                                                }
                                                
                                                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                                    UIAlertAction in
                                                    
                                                    deleteDataWithProduct(Int(dataGet.animalId ))
                                                    deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                    deleteDataWithAnimal(Int(dataGet.animalId ))
                                                    
                                                    let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId ),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                    self.notificationLblCount.text = String(animalCount.count)
                                                    UserDefaults.standard.set("", forKey: keyValue.tsuKeyType.rawValue)
                                                    self.byDefaultSetting()
                                                    return
                                                }
                                                
                                                alertController.addAction(okAction)
                                                alertController.addAction(cancelAction)
                                                self.present(alertController, animated: true, completion: nil)
                                                return
                                            }
                                        }
                                    }
                                    
                                    UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                                    self.mergeListBtnOulet.isHidden = false
                                    self.mergeListView.isHidden = false
                                  //  showAlertforwithoutBarcodeAnimal()
                                    UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                                //    self.crossedBtnOutlet.isHidden = false
                                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: pvid)
                                    self.notificationLblCount.text = String(animalCount.count)
//                                    self.importBGView.isHidden = true
//                                    self.importListMainView.isHidden = true
                                    
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
                                            mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                            
                                        }
                                        else {
                                            let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                            mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                        }
                                    }
                                }
                                
                                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: pvid)
                                self.notificationLblCount.text = String(animalCount.count)
                            }
                            
                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: pvid)
                            self.notificationLblCount.text = String(animalCount.count)
                            self.cartView.isHidden = false
                        }
                    }
             
                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: pvid)
                    self.notificationLblCount.text = String(animalCount.count)
                    self.cartView.isHidden = false
                    showAlertforwithoutBarcodeAnimal()
                    if animalCount.count == 0 {
                        self.notificationLblCount.isHidden = true
                        self.countLbl.isHidden = true
                        self.cartView.isHidden = true
                    } else {
                        self.notificationLblCount.isHidden = false
                        self.countLbl.isHidden = false
                        self.cartView.isHidden = false
                    }
                })
                let thirdAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
                    (_)in
                })
//                self.importListMainView.isHidden = true
//                self.importBGView.isHidden = true
                alert.addAction(ResolveAction)
                alert.addAction(IgnoreAction)
                alert.addAction(thirdAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        if screenPerference ==  keyValue.farmId.rawValue || screenPerference == "" {
            
            allDataAnimalTbl = fetchAllDataAnimalAnimalIgnoreCase(entityName: Entities.dataEntryAnimalAddTbl,custmerId :UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userID :self.userId,listId:Int64(self.listId))
            arrayCountCond = fetchAllDataAnimalFarmiIdCheck(entityName: Entities.dataEntryAnimalAddTbl,anmalTag:"",custmerId :UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), userID: userId, listId: Int64(listId))
            
            if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == "True" {
                arrayCountCond = fetchAllDataAnimalFarmiIdCheckBothMandatory(entityName: Entities.dataEntryAnimalAddTbl,farmId:"",animalTag:"",custmerId :UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userID :userId, listId: Int64(listId))
            }
            
            if arrayCountCond.count == 0 {
                let aData =  fetchAnimaldataDairyOrderIdUserId(entityName: Entities.animalAddTblEntity, orderId: self.autoD, userId: self.userId,providerId:self.pvid)
                
                if aData.count > 0 {
                    for k in 0 ..< aData.count{
                        let data1 = aData[k] as! AnimaladdTbl
                        let offId = data1.animalTag
                        let farmId  = data1 .farmId
                        let dataEntryvalue =  fetchAllDataAnimalDatarderIdDateEntrycheckfarmIdOffId(entityName: Entities.dataEntryAnimalAddTbl, userId: self.userId, orderId: self.orderId, listid: Int64(self.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid, farmId: farmId ?? "" , animaTag: offId ?? "") as! [DataEntryAnimaladdTbl]
                        
                        if dataEntryvalue.count > 0 {
                            self.conflictArr.append(contentsOf: dataEntryvalue)
                        }
                    }
                    
                    if self.conflictArr.count > 0 {
                        let count1 = self.conflictArr.count
                        let alertPrint = String(count1) + " " + NSLocalizedString(LocalizedStrings.selectActionToBePerformed, comment: "")
                        let alert = UIAlertController(title: self.listNameString, message: alertPrint, preferredStyle: .alert)
                        let ResolveAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default ,handler: {
                            (_)in
//                            self.importBGView.isHidden = true
//                            self.importListMainView.isHidden = true
                            
                        })
                        
                        let IgnoreAction = UIAlertAction(title: NSLocalizedString("Ignore", comment: ""), style: UIAlertAction.Style.default, handler: { [self]
                            (_)in
                            let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderId:orderId,orderStatus:"false",listid:Int64(listId), custmerId: Int64(custmerId ), providerId: pvid)
                            
                            if fetchData11.count != 0 {
                                for i in 0...fetchData11.count - 1 {
                                    let dataGet = fetchData11.object(at: i) as! DataEntryAnimaladdTbl
                                    let fetchData =  fetchAllDataAnimalAnimalIdOfficalId(entityName: Entities.animalAddTblEntity, animalId: dataGet.farmId ?? "", anmalTag: dataGet.animalTag ?? "",custmerId: Int(dataGet.custmerId), userID: userId, orderId: self.orderId)
                                    
                                    if fetchData.count == 0 {
                                        let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:autoD, customerID: custmerId)
                                        
                                        if data12333.count > 0{
                                            if tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || tissueBtnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                                                
                                                saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                                
                                                UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                                UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                                UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                                UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                                UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                                self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                                self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                                saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                            }
                                            else{
                                                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                                
                                                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                                    UIAlertAction in
                                                    self.byDefaultSetting()
                                                    
                                                }
                                                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                                    UIAlertAction in
                                                    
                                                    deleteDataWithProduct(Int(dataGet.animalId ))
                                                    deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                    deleteDataWithAnimal(Int(dataGet.animalId ))
                                                    UserDefaults.standard.set("", forKey: keyValue.tsuKey.rawValue)
                                                    self.byDefaultSetting()
                                                    return
                                                }
                                                
                                                alertController.addAction(okAction)
                                                alertController.addAction(cancelAction)
                                                self.present(alertController, animated: true, completion: nil)
                                                return
                                            }
                                        }
                                        else {
                                            saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                            
                                            UserDefaults.standard.setValue(dataGet.tissuName, forKey: keyValue.tsuKeyType.rawValue)
                                            UserDefaults.standard.setValue(dataGet.breedId, forKey: keyValue.breedId.rawValue)
                                            UserDefaults.standard.setValue(dataGet.tissuName, forKey: keyValue.capsTSUClear.rawValue)
                                            UserDefaults.standard.setValue(dataGet.breedName, forKey: keyValue.breedNameClear.rawValue)
                                            UserDefaults.standard.setValue(dataGet.breedName, forKey: keyValue.capsBreedName.rawValue)
                                            breedBtnOutlet.setTitle(dataGet.breedName, for: .normal)
                                            tissueBtnOutlet.setTitle(dataGet.tissuName?.localized, for: .normal)
                                        }
                                        
                                        let animalData = fetchAnimaldataDairy(entityName: Entities.animalAddTblEntity, animalTag:Int(dataGet.animalId ),orderId:Int(self.orderId ),userId:userId)
                                        let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: Int(dataGet.providerId), breedId: dataGet.breedId ?? "" )
                                        
                                        for k in 0 ..< animalData.count{
                                            let animalId = animalData[k] as! AnimaladdTbl
                                            
                                            for i in 0 ..< product.count{
                                                let data = product[i] as! GetProductTbl
                                                if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                    let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:Int(self.orderId ), customerID: custmerId)
                                                    if data12333.count > 0 {
                                                        let adonDat =  fetchProductAdonDataWithBVDV(entityName: Entities.getAdonTblEntity, prodId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue),adonId : LocalizedStrings.bvdvAddOnId)
                                                        if adonDat.count > 0 {
                                                            addedd = true
                                                            saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                            updateOrderStatusAnimal(entity: Entities.animalAddTblEntity, status: "true", orderId: Int(self.orderId), userId: userId, animalId: Int(dataGet.animalId ))
                                                        }
                                                    }
                                                    else {
                                                        saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                    }
                                                }
                                                else {
                                                    saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId ?? "", productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false",  farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                }
                                                
                                                if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                                                    addonArr = fetchProductAdonData(entityName : Entities.getAdonTblEntity,prodId: Int(data.productId),isCdcbProduct:false)
                                                }
                                                else {
                                                    addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                                }
                                                
                                                for j in 0 ..< addonArr.count {
                                                    let addonDat = addonArr[j] as! GetAdonTbl
                                                    
                                                    if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                        let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:autoD, customerID: custmerId)
                                                        
                                                        if data12333.count > 0 {
                                                            if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                                saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                                updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue), status: "true")
                                                                
                                                            }
                                                            else {
                                                                saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                            }
                                                        }
                                                        else {
                                                            saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                        }
                                                    }
                                                    
                                                    else {
                                                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                    }
                                                }
                                            }
                                            
                                            if data12333.count > 0 {
                                                if addedd == false {
                                                    let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAddedBVDV, comment: ""), preferredStyle: .alert)
                                                    
                                                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                                        UIAlertAction in
                                                        
                                                        deleteDataWithProduct(Int(dataGet.animalId ))
                                                        deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                        deleteDataWithAnimal(Int(dataGet.animalId ))
                                                        let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                        var bredidd123 = String ()
                                                        
                                                        if animalCount.count > 0 {
                                                            let breeid1 = animalCount.object(at: 0) as! AnimaladdTbl
                                                            bredidd123 = breeid1.breedName ?? ""
                                                        }
                                                        
                                                        for i in 0 ..< animalCount.count{
                                                            let breeid1 = animalCount.object(at: i) as! AnimaladdTbl
                                                            if bredidd123 == breeid1.breedName {
                                                                bredidd123 = breeid1.breedName ?? ""
                                                                UserDefaults.standard.set(breeid1.breedId, forKey: keyValue.breedId.rawValue)
                                                                
                                                            }
                                                        }
                                                        
                                                        self.byDefaultSetting()
                                                        self.notificationLblCount.text = String(animalCount.count)
                                                        return
                                                    }
                                                    let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                                        UIAlertAction in
                                                        
                                                        deleteDataWithProduct(Int(dataGet.animalId ))
                                                        deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                        deleteDataWithAnimal(Int(dataGet.animalId ))
                                                        let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId ),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                        self.notificationLblCount.text = String(animalCount.count)
                                                        UserDefaults.standard.set("", forKey: keyValue.tsuKeyType.rawValue)
                                                        self.byDefaultSetting()
                                                        return
                                                    }
                                                    alertController.addAction(okAction)
                                                    alertController.addAction(cancelAction)
                                                    self.present(alertController, animated: true, completion: nil)
                                                    return
                                                }
                                            }
                                        }
                                        
                                        UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                                        self.mergeListBtnOulet.isHidden = false
                                        self.mergeListView.isHidden = false
                                      //  self.crossedBtnOutlet.isHidden = false
                                    //    showAlertforwithoutBarcodeAnimal()
                                        
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
                                                mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                                
                                            } else {
                                                let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                                let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                                mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                                
                                            }
                                        }
                                        UserDefaults.standard.setValue(listNameString, forKey: keyValue.dataEntryListName.rawValue)
                                   //     crossedBtnOutlet.isHidden = false
                                        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: pvid)
                                        notificationLblCount.text = String(animalCount.count)
                                        
                                        if animalCount.count == 0 {
                                            notificationLblCount.isHidden = true
                                            countLbl.isHidden = true
                                            self.cartView.isHidden = true
                                        } else {
                                            notificationLblCount.isHidden = false
                                            countLbl.isHidden = false
                                            self.cartView.isHidden = false
                                        }
                                    }
                                }
                            } else {
//                                crossedBtnOutlet.isHidden = false
//                                importFromListOutlet.isEnabled = true
                                
                            }
                           // showAlertforwithoutBarcodeAnimal()
//                            importListMainView.isHidden = true
//                            importBGView.isHidden = true
//                            crossedBtnOutlet.isHidden = false
                            let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ,providerId:pvid )
                            
                            if fetchObj.count != 0 {
                                let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                let obj = objectFetch?.listName
                                let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
                                
                                if fetchAllMergeDta == 0 {
                                    let fetchNameDisplay = String(obj ?? "")
                                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                    mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                    
                                } else {
                                    let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                    mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                }
                            }
                            
                            self.mergeListBtnOulet.isHidden = false
                            self.mergeListView.isHidden = false
                        //    self.crossedBtnOutlet.isHidden = false
                            showAlertforwithoutBarcodeAnimal()
                        })
//                        self.importListMainView.isHidden = true
//                        self.importBGView.isHidden = true
                        alert.addAction(ResolveAction)
                        alert.addAction(IgnoreAction)
                        DispatchQueue.main.async(execute: {
                            self.present(alert, animated: true)
                        })
                    } else {
                        let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderId:orderId,orderStatus:"false",listid:Int64(listId), custmerId: Int64(custmerId ), providerId: pvid)
                        
                        if fetchData11.count != 0 {
                            for i in 0...fetchData11.count - 1 {
                                let dataGet = fetchData11.object(at: i) as! DataEntryAnimaladdTbl
                                let fetchData =  fetchAllDataAnimalAnimalIdOfficalId(entityName: Entities.animalAddTblEntity, animalId: dataGet.farmId ?? "", anmalTag: dataGet.animalTag ?? "",custmerId: Int(dataGet.custmerId), userID: userId, orderId: self.orderId)
                                
                                if fetchData.count == 0 {
                                    let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:autoD, customerID: custmerId)
                                    
                                    if data12333.count > 0{
                                        if tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || tissueBtnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                                            
                                            saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                            
                                            UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                            UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                            UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                            UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                            UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                            self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                            self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                            saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                        }
                                        else{
                                            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                            
                                            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                self.byDefaultSetting()
                                                
                                            }
                                            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                
                                                deleteDataWithProduct(Int(dataGet.animalId ))
                                                deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                deleteDataWithAnimal(Int(dataGet.animalId ))
                                                UserDefaults.standard.set("", forKey: keyValue.tsuKey.rawValue)
                                                self.byDefaultSetting()
                                                return
                                            }
                                            
                                            alertController.addAction(okAction)
                                            alertController.addAction(cancelAction)
                                            self.present(alertController, animated: true, completion: nil)
                                            return
                                        }
                                    }
                                    else {
                                        saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                        
                                        UserDefaults.standard.setValue(dataGet.tissuName, forKey: keyValue.tsuKeyType.rawValue)
                                        UserDefaults.standard.setValue(dataGet.breedId, forKey: keyValue.breedId.rawValue)
                                        UserDefaults.standard.setValue(dataGet.tissuName, forKey: keyValue.capsTSUClear.rawValue)
                                        UserDefaults.standard.setValue(dataGet.breedName, forKey: keyValue.breedNameClear.rawValue)
                                        UserDefaults.standard.setValue(dataGet.breedName, forKey: keyValue.capsBreedName.rawValue)
                                        breedBtnOutlet.setTitle(dataGet.breedName, for: .normal)
                                        tissueBtnOutlet.setTitle(dataGet.tissuName?.localized, for: .normal)
                                    }
                                    
                                    let animalData = fetchAnimaldataDairy(entityName: Entities.animalAddTblEntity, animalTag:Int(dataGet.animalId ),orderId:Int(self.orderId ),userId:userId)
                                    let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: Int(dataGet.providerId), breedId: dataGet.breedId ?? "" )
                                    
                                    for k in 0 ..< animalData.count{
                                        let animalId = animalData[k] as! AnimaladdTbl
                                        
                                        for i in 0 ..< product.count{
                                            let data = product[i] as! GetProductTbl
                                            if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:Int(self.orderId ), customerID: custmerId)
                                                if data12333.count > 0 {
                                                    let adonDat =  fetchProductAdonDataWithBVDV(entityName: Entities.getAdonTblEntity, prodId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue),adonId : LocalizedStrings.bvdvAddOnId)
                                                    if adonDat.count > 0 {
                                                        addedd = true
                                                        saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                        updateOrderStatusAnimal(entity: Entities.animalAddTblEntity, status: "true", orderId: Int(self.orderId), userId: userId, animalId: Int(dataGet.animalId ))
                                                    }
                                                }
                                                else {
                                                    saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                }
                                            }
                                            else {
                                                saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId ?? "", productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false",  farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                            }
                                            
                                            if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                                                addonArr = fetchProductAdonData(entityName : Entities.getAdonTblEntity,prodId: Int(data.productId),isCdcbProduct:false)
                                            }
                                            else {
                                                addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                            }
                                            
                                            for j in 0 ..< addonArr.count {
                                                let addonDat = addonArr[j] as! GetAdonTbl
                   
                                                if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                    let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:autoD, customerID: custmerId)
                                                    
                                                    if data12333.count > 0 {
                                                        if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                            saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                            
                                                            updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue), status: "true")
                                                            
                                                        }
                                                        else {
                                                            saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                        }
                                                    }
                                                    else {
                                                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                    }
                                                }
                                                
                                                else {
                                                    saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                }
                                            }
                                        }
                                        
                                        if data12333.count > 0 {
                                            if addedd == false {
                                                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAddedBVDV, comment: ""), preferredStyle: .alert)
                                                
                                                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                                    UIAlertAction in
                                                    
                                                    deleteDataWithProduct(Int(dataGet.animalId ))
                                                    deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                    deleteDataWithAnimal(Int(dataGet.animalId ))
                                                    let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                    var bredidd123 = String ()
                                                    
                                                    if animalCount.count > 0 {
                                                        let breeid1 = animalCount.object(at: 0) as! AnimaladdTbl
                                                        bredidd123 = breeid1.breedName ?? ""
                                                    }
                                                    
                                                    for i in 0 ..< animalCount.count{
                                                        let breeid1 = animalCount.object(at: i) as! AnimaladdTbl
                                                        if bredidd123 == breeid1.breedName {
                                                            bredidd123 = breeid1.breedName ?? ""
                                                            UserDefaults.standard.set(breeid1.breedId, forKey: keyValue.breedId.rawValue)
                                                        }
                                                    }
                                                    self.byDefaultSetting()
                                                    self.notificationLblCount.text = String(animalCount.count)
                                                    return
                                                }
                                                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                                    UIAlertAction in
                                                    
                                                    deleteDataWithProduct(Int(dataGet.animalId ))
                                                    deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                    deleteDataWithAnimal(Int(dataGet.animalId ))
                                                    let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId ),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                    self.notificationLblCount.text = String(animalCount.count)
                                                    UserDefaults.standard.set("", forKey: keyValue.tsuKeyType.rawValue)
                                                    self.byDefaultSetting()
                                                    return
                                                }
                                                alertController.addAction(okAction)
                                                alertController.addAction(cancelAction)
                                                self.present(alertController, animated: true, completion: nil)
                                                return
                                            }
                                        }
                                    }
                                    
                                    UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                                    let attributeString = NSMutableAttributedString(string: listNameString, attributes: self.attrs)
                                    mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                                    self.mergeListBtnOulet.isHidden = false
                                    self.mergeListView.isHidden = false
                                //    self.crossedBtnOutlet.isHidden = false
                                //    showAlertforwithoutBarcodeAnimal()
                                    
                                    if fetchMergeDataListId(entityName: Entities.mergeDataEntryListTblEntity,listId: Int64(dataGet.listId),customerId: Int64(self.custmerId )).count == 0 {
                                        let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ))
                                        let listObject = fetchList.object(at: 0) as? DataEntryList
                                        let listDescr = listObject?.listDesc
                                        saveMergeDataEntryList(entity: Entities.mergeDataEntryListTblEntity, customerId: Int64(self.custmerId ), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                    }
  
                                    UserDefaults.standard.setValue(listNameString, forKey: keyValue.dataEntryListName.rawValue)
                                 //   crossedBtnOutlet.isHidden = false
                                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid)
                                    notificationLblCount.text = String(animalCount.count)
                                    
                                    if animalCount.count == 0 {
                                        notificationLblCount.isHidden = true
                                        countLbl.isHidden = true
                                        self.cartView.isHidden = true
                                    } else {
                                        notificationLblCount.isHidden = false
                                        countLbl.isHidden = false
                                        self.cartView.isHidden = false
                                    }
                                }
                            }
                        } else {
                          //  crossedBtnOutlet.isHidden = false
                          //  importFromListOutlet.isEnabled = true
                        }
                        showAlertforwithoutBarcodeAnimal()
//                        importListMainView.isHidden = true
//                        importBGView.isHidden = true
//                        crossedBtnOutlet.isHidden = false
                        let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ,providerId:pvid )
                        
                        if fetchObj.count != 0 {
                            let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                            let obj = objectFetch?.listName
                            let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
                            
                            if fetchAllMergeDta == 0 {
                                let fetchNameDisplay = String(obj ?? "")
                                let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                            }
                            else {
                                let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                            }
                        }
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                        showAlertforwithoutBarcodeAnimal()
                    }
                }
                
                else {
                    let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderId:orderId,orderStatus:"false",listid:Int64(listId), custmerId: Int64(custmerId ), providerId: pvid)
                    
                    if fetchData11.count != 0 {
                        for i in 0...fetchData11.count - 1 {
                            let dataGet = fetchData11.object(at: i) as! DataEntryAnimaladdTbl
                            let fetchData =  fetchAllDataAnimalAnimalIdOfficalId(entityName: Entities.animalAddTblEntity, animalId: dataGet.farmId ?? "", anmalTag: dataGet.animalTag ?? "",custmerId: Int(dataGet.custmerId), userID: userId, orderId: self.orderId)
                            
                            if fetchData.count == 0 {
                                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:autoD, customerID: custmerId)
                                if data12333.count > 0{
                                    if tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || tissueBtnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                                        
                                        saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                        
                                        UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                        UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                        UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                        UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                        UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                        
                                        self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                        self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                        saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                    }
                                    else{
                                        let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                        
                                        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                            UIAlertAction in
                                            self.byDefaultSetting()
                                            
                                        }
                                        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                            UIAlertAction in
                                            
                                            deleteDataWithProduct(Int(dataGet.animalId ))
                                            deleteDataWithSubProduct(Int(dataGet.animalId ))
                                            deleteDataWithAnimal(Int(dataGet.animalId ))
                                            UserDefaults.standard.set("", forKey: keyValue.tsuKey.rawValue)
                                            self.byDefaultSetting()
                                            return
                                        }
                                        alertController.addAction(okAction)
                                        alertController.addAction(cancelAction)
                                        self.present(alertController, animated: true, completion: nil)
                                        return
                                    }
                                }
                                else {
                                    saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                    
                                    UserDefaults.standard.setValue(dataGet.tissuName, forKey: keyValue.tsuKeyType.rawValue)
                                    UserDefaults.standard.setValue(dataGet.breedId, forKey: keyValue.breedId.rawValue)
                                    UserDefaults.standard.setValue(dataGet.tissuName, forKey: keyValue.capsTSUClear.rawValue)
                                    UserDefaults.standard.setValue(dataGet.breedName, forKey: keyValue.breedNameClear.rawValue)
                                    UserDefaults.standard.setValue(dataGet.breedName, forKey: keyValue.capsBreedName.rawValue)
                                    breedBtnOutlet.setTitle(dataGet.breedName, for: .normal)
                                    tissueBtnOutlet.setTitle(dataGet.tissuName?.localized, for: .normal)
                                }
                                
                                let animalData = fetchAnimaldataDairy(entityName: Entities.animalAddTblEntity, animalTag:Int(dataGet.animalId ),orderId:Int(self.orderId ),userId:userId)
                                let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: Int(dataGet.providerId), breedId: dataGet.breedId ?? "" )
                                
                                for k in 0 ..< animalData.count{
                                    let animalId = animalData[k] as! AnimaladdTbl
                                    
                                    for i in 0 ..< product.count{
                                        let data = product[i] as! GetProductTbl
                                        if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                            let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:Int(self.orderId ), customerID: custmerId)
                                            if data12333.count > 0 {
                                                let adonDat =  fetchProductAdonDataWithBVDV(entityName: Entities.getAdonTblEntity, prodId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue),adonId : LocalizedStrings.bvdvAddOnId)
                                                if adonDat.count > 0 {
                                                    addedd = true
                                                    saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                    updateOrderStatusAnimal(entity: Entities.animalAddTblEntity, status: "true", orderId: Int(self.orderId), userId: userId, animalId: Int(dataGet.animalId ))
                                                }
                                            }
                                            else {
                                                saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                            }
                                        }
                                        else {
                                            saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId ?? "", productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false",  farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                        }
                                        
                                        if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                                            addonArr = fetchProductAdonData(entityName : Entities.getAdonTblEntity,prodId: Int(data.productId),isCdcbProduct:false)
                                        } else {
                                            addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                        }
                                        
                                        for j in 0 ..< addonArr.count {
                                            let addonDat = addonArr[j] as! GetAdonTbl
                                            if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:autoD, customerID: custmerId)
                                                if data12333.count > 0 {
                                                    if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                        updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue), status: "true")
                                                    }
                                                    else {
                                                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                    }
                                                }
                                                else {
                                                    saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                }
                                            }
                                            
                                            else {
                                                saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                            }
                                        }
                                    }
                                    
                                    if data12333.count > 0 {
                                        if addedd == false {
                                            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAddedBVDV, comment: ""), preferredStyle: .alert)
                                            
                                            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                
                                                deleteDataWithProduct(Int(dataGet.animalId ))
                                                deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                deleteDataWithAnimal(Int(dataGet.animalId ))
                                                let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                var bredidd123 = String ()
                                                
                                                if animalCount.count > 0 {
                                                    let breeid1 = animalCount.object(at: 0) as! AnimaladdTbl
                                                    bredidd123 = breeid1.breedName ?? ""
                                                }
                                                for i in 0 ..< animalCount.count{
                                                    let breeid1 = animalCount.object(at: i) as! AnimaladdTbl
                                                    if bredidd123 == breeid1.breedName {
                                                        bredidd123 = breeid1.breedName ?? ""
                                                        UserDefaults.standard.set(breeid1.breedId, forKey: keyValue.breedId.rawValue)
                                                        
                                                    }
                                                }
                                                self.byDefaultSetting()
                                                self.notificationLblCount.text = String(animalCount.count)
                                                return
                                            }
                                            
                                            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                deleteDataWithProduct(Int(dataGet.animalId ))
                                                deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                deleteDataWithAnimal(Int(dataGet.animalId ))
                                                let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId ),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                self.notificationLblCount.text = String(animalCount.count)
                                                UserDefaults.standard.set("", forKey: keyValue.tsuKeyType.rawValue)
                                                self.byDefaultSetting()
                                                return
                                            }
                                            
                                            alertController.addAction(okAction)
                                            alertController.addAction(cancelAction)
                                            self.present(alertController, animated: true, completion: nil)
                                            return
                                        }
                                    }
                                }
                                
                                UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                                mergeListBtnOulet.isHidden = false
                                self.mergeListView.isHidden = false
                        //        showAlertforwithoutBarcodeAnimal()
                                
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
                                        mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                    }
                                    else {
                                        let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                        mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                        
                                    }
                                }
                                
                                UserDefaults.standard.setValue(listNameString, forKey: keyValue.dataEntryListName.rawValue)
                             //   crossedBtnOutlet.isHidden = false
                                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid)
                                notificationLblCount.text = String(animalCount.count)
                                
                                if animalCount.count == 0 {
                                    notificationLblCount.isHidden = true
                                    countLbl.isHidden = true
                                    self.cartView.isHidden = true
                                } else {
                                    notificationLblCount.isHidden = false
                                    countLbl.isHidden = false
                                    self.cartView.isHidden = false
                                }
                            }
                        }
                    } else {
//                        crossedBtnOutlet.isHidden = false
//                        importFromListOutlet.isEnabled = true
                    }
                    showAlertforwithoutBarcodeAnimal()
//                    importListMainView.isHidden = true
//                    importBGView.isHidden = true
//                    crossedBtnOutlet.isHidden = false
                    let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ,providerId:pvid )
                    let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                    let obj = objectFetch?.listName
                    let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
                    
                    if fetchAllMergeDta == 0 {
                        let fetchNameDisplay = String(obj ?? "")
                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                        mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                    } else {
                        let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                        mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                    }
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                    mergeListBtnOulet.isHidden = false
                    self.mergeListView.isHidden = false
                    showAlertforwithoutBarcodeAnimal()
                }
                
            } else {
                let count1 = arrayCountCond.count
                let alertPrint = String(count1) + " " + LocalizedStrings.animalsMissingInfo
                
                let alert = UIAlertController(title: listNameString, message: alertPrint, preferredStyle: .alert)
                let ResolveAction = UIAlertAction(title: "Resolve", style: UIAlertAction.Style.default ,handler: {
                    (_)in
//                    self.importListMainView.isHidden = true
//                    self.importBGView.isHidden = true
                    
//                    let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
//                    let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.DataEntryViewConflicedImportListVC) as! DataEntryViewConflicedImportList
//                    vc.listId = self.listId
//                    UserDefaults.standard.set(self.listId, forKey: keyValue.listIdSaveOnSelection.rawValue)
//                    self.navigationController?.pushViewController(vc,animated: false)
                    let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "DataEntryConflictedImportListIpad") as! DataEntryConflictedImportListIpad
                    vc.listId = self.listId
                    UserDefaults.standard.set(self.listId, forKey: keyValue.listIdSaveOnSelection.rawValue)
                    self.navigationController?.pushViewController(vc,animated: false)
                })
                
                let IgnoreAction = UIAlertAction(title: "Ignore", style: UIAlertAction.Style.default, handler: {
                    (_)in
     
                    if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == "True" {
                        let aData =  fetchAnimaldataDairyOrderIdUserId(entityName: Entities.animalAddTblEntity, orderId: self.autoD, userId: self.userId,providerId:self.pvid)
                        
                        if aData.count > 0 {
                            for k in 0 ..< aData.count{
                                let data1 = aData[k] as! AnimaladdTbl
                                let offId = data1.animalTag
                                let farmId  = data1 .farmId
                                
                                let dataEntryvalue =  fetchAllDataAnimalDatarderIdDateEntrycheckfarmIdOffId(entityName: Entities.dataEntryAnimalAddTbl, userId: self.userId, orderId: self.orderId, listid: Int64(self.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid, farmId: farmId ?? "" , animaTag: offId ?? "") as! [DataEntryAnimaladdTbl]
                                
                                if dataEntryvalue.count > 0 {
                                    self.conflictArr.append(contentsOf: dataEntryvalue)
                                }
                            }
                            
                            if self.conflictArr.count > 0 {
                                let count1 = self.conflictArr.count
                                let alertPrint = String(count1) + " " + NSLocalizedString(LocalizedStrings.selectActionToBePerformed, comment: "")
                                
                                let alert = UIAlertController(title: self.listNameString, message: alertPrint, preferredStyle: .alert)
                                let ResolveAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default ,handler: {
                                    (_)in
//                                    self.importBGView.isHidden = true
//                                    self.importListMainView.isHidden = true
                                })
                                
                                let IgnoreAction = UIAlertAction(title: NSLocalizedString("Ignore", comment: ""), style: UIAlertAction.Style.default, handler: { [self]
                                    (_)in
                                    
                                    let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderId:orderId,orderStatus:"false",listid:Int64(listId), custmerId: Int64(self.custmerId ), providerId: pvid)
                                    
                                    if fetchData11.count != 0 {
                                        for i in 0...fetchData11.count - 1 {
                                            let dataGet = fetchData11.object(at: i) as! DataEntryAnimaladdTbl
                                            
                                            if dataGet.farmId == "" || dataGet.animalTag == ""{} else {
                                                let fetchData =  fetchAllDataAnimalAnimalIdOfficalId(entityName: Entities.animalAddTblEntity, animalId: dataGet.farmId ?? "", anmalTag: dataGet.animalTag ?? "",custmerId: Int(dataGet.custmerId), userID: self.userId, orderId: self.orderId)
                                                
                                                if fetchData.count == 0 {
                                                    let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:orderId, customerID: custmerId)
                                                    
                                                    if data12333.count > 0{
                                                        if self.tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || tissueBtnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                                                            
                                                            saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                                            
                                                            UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                                            UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                                            UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                                            UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                                            UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                                            self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                                            self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                                            saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                                            
                                                        }
                                                        else{
                                                            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                                            
                                                            let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) {
                                                                UIAlertAction in
                                                                self.byDefaultSetting()
                                                                
                                                            }
                                                            let cancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
                                                                UIAlertAction in
                                                                
                                                                deleteDataWithProduct(Int(dataGet.animalId ))
                                                                deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                                deleteDataWithAnimal(Int(dataGet.animalId ))
                                                                UserDefaults.standard.set("", forKey: keyValue.tsuKey.rawValue)
                                                                self.byDefaultSetting()
                                                                return
                                                            }
                                                            
                                                            alertController.addAction(okAction)
                                                            alertController.addAction(cancelAction)
                                                            self.present(alertController, animated: true, completion: nil)
                                                            return
                                                        }
                                                    }
                                                    else {
                                                        saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                                        
                                                        UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                                        UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                                        UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                                        UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                                        UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                                        self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                                        self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                                        saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                                    }
                                                    
                                                    let animalData = fetchAnimaldataDairy(entityName: Entities.animalAddTblEntity, animalTag:Int(dataGet.animalId ),orderId:Int(self.orderId ),userId:self.userId)
                                                    let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: Int(dataGet.providerId), breedId: dataGet.breedId ?? "" )
                                                    
                                                    for k in 0 ..< animalData.count{
                                                        let animalId = animalData[k] as! AnimaladdTbl
                                                        for i in 0 ..< product.count{
                                                            let data = product[i] as! GetProductTbl
                                                            if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.autoD,customerID: custmerId)
                                                                if data12333.count > 0 {
                                                                    let adonDat =  fetchProductAdonDataWithBVDV(entityName: Entities.getAdonTblEntity, prodId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue),adonId : LocalizedStrings.bvdvAddOnId)
                                                                    if adonDat.count > 0 {
                                                                        self.addedd = true
                                                                        saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "true", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                                        updateOrderStatusAnimal(entity: Entities.dataEntryAnimalAddTbl, status: "true", orderId: Int(self.orderId), userId: self.userId, animalId: Int(dataGet.animalId ))
                                                                    }
                                                                }
                                                                else {
                                                                    saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "false", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                                }
                                                            }
                                                            else {
                                                                saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId ?? "", productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "false",  farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                            }
                                                            
                                                            if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                                                                addonArr = fetchProductAdonData(entityName : Entities.getAdonTblEntity,prodId: Int(data.productId),isCdcbProduct:false)
                                                            } else {
                                                                addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                                            }
                                                            
                                                            for j in 0 ..< addonArr.count {
                                                                let addonDat = addonArr[j] as! GetAdonTbl
                                                                if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                                    let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.autoD,customerID: custmerId)
                                                                    
                                                                    if data12333.count > 0 {
                                                                        if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                                            saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:self.timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                                            updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue), status: "true")
                                                                            
                                                                        }
                                                                        else {
                                                                            saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:self.timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                                        }
                                                                    }
                                                                    else {
                                                                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:self.timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                                    }
                                                                }
                                                                
                                                                else {
                                                                    saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:self.timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                                }
                                                            }
                                                        }
                                                        
                                                        if data12333.count > 0 {
                                                            if self.addedd == false {
                                                                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAddedBVDV, comment: ""), preferredStyle: .alert)
                                                                
                                                                let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) {
                                                                    UIAlertAction in
                                                                    
                                                                    deleteDataWithProduct(Int(dataGet.animalId ))
                                                                    deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                                    deleteDataWithAnimal(Int(dataGet.animalId ))
                                                                    let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                                    var bredidd123 = String ()
                                                                    if animalCount.count > 0 {
                                                                        let breeid1 = animalCount.object(at: 0) as! AnimaladdTbl
                                                                        bredidd123 = breeid1.breedName ?? ""
                                                                    }
                                                                    for i in 0 ..< animalCount.count{
                                                                        let breeid1 = animalCount.object(at: i) as! AnimaladdTbl
                                                                        if bredidd123 == breeid1.breedName {
                                                                            bredidd123 = breeid1.breedName ?? ""
                                                                            UserDefaults.standard.set(breeid1.breedId, forKey: keyValue.breedId.rawValue)
                                                                        }
                                                                    }
                                                                    self.byDefaultSetting()
                                                                    self.notificationLblCount.text = String(animalCount.count)
                                                                    return
                                                                }
                                                                let cancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
                                                                    UIAlertAction in
                                                                    
                                                                    deleteDataWithProduct(Int(dataGet.animalId ))
                                                                    deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                                    deleteDataWithAnimal(Int(dataGet.animalId ))
                                                                    let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId ),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                                    self.notificationLblCount.text = String(animalCount.count)
                                                                    self.byDefaultSetting()
                                                                    return
                                                                }
                                                                
                                                                alertController.addAction(okAction)
                                                                alertController.addAction(cancelAction)
                                                                self.present(alertController, animated: true, completion: nil)
                                                                return
                                                            }
                                                        }
                                                    }
                                                    
                                                    UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                                                    mergeListBtnOulet.isHidden = false
                                                    self.mergeListView.isHidden = false
                                                  //  showAlertforwithoutBarcodeAnimal()
                                                    UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                                                   // self.crossedBtnOutlet.isHidden = false
                                                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: pvid)
                                                    notificationLblCount.text = String(animalCount.count)
                                                    
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
                                                            mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                                            
                                                        } else {
                                                            let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                                            mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                                        }
                                                    }
                                                    
                                                } else {
                                                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: pvid)
                                                    notificationLblCount.text = String(animalCount.count)
                                                }
                                            }
                                        }
                                    }
                                    showAlertforwithoutBarcodeAnimal()
                                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: pvid)
                                    notificationLblCount.text = String(animalCount.count)
//                                    self.importListMainView.isHidden = true
//                                    self.importBGView.isHidden = true
//                                    self.importFromListOutlet.isEnabled = true
                                
                                })
//                                self.importBGView.isHidden = true
//                                self.importListMainView.isHidden = true
                                alert.addAction(ResolveAction)
                                alert.addAction(IgnoreAction)
                                self.present(alert, animated: true, completion: nil)
                            }
                            else {
                                let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                
                                if fetchData11.count != 0 {
                                    for i in 0...fetchData11.count - 1 {
                                        let dataGet = fetchData11.object(at: i) as! DataEntryAnimaladdTbl
                                        
                                        if dataGet.farmId == "" || dataGet.animalTag == ""{}
                                        else {
                                            let fetchData =  fetchAllDataAnimalAnimalIdOfficalId(entityName: Entities.animalAddTblEntity, animalId: dataGet.farmId ?? "", anmalTag: dataGet.animalTag ?? "",custmerId: Int(dataGet.custmerId), userID: self.userId, orderId: self.orderId)
                                            
                                            if fetchData.count == 0 {
                                                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.orderId,customerID: self.custmerId)
                                                
                                                if data12333.count > 0{
                                                    if self.tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || self.tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || self.tissueBtnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                                                        
                                                        saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(self.userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                                        
                                                        UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                                        UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                                        UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                                        UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                                        UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                                        self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                                        self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                                        self.saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                                        
                                                    }
                                                    else{
                                                        let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                                        
                                                        let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) {
                                                            UIAlertAction in
                                                            self.byDefaultSetting()
                                                            
                                                        }
                                                        let cancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
                                                            UIAlertAction in
                                                            
                                                            deleteDataWithProduct(Int(dataGet.animalId ))
                                                            deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                            deleteDataWithAnimal(Int(dataGet.animalId ))
                                                            UserDefaults.standard.set("", forKey: keyValue.tsuKey.rawValue)
                                                            self.byDefaultSetting()
                                                            return
                                                        }
                                                        alertController.addAction(okAction)
                                                        alertController.addAction(cancelAction)
                                                        self.present(alertController, animated: true, completion: nil)
                                                        return
                                                    }
                                                }
                                                else {
                                                    saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(self.userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                                    
                                                    UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                                    UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                                    UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                                    UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                                    UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                                    self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                                    self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                                    self.saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                                }
                                                
                                                let animalData = fetchAnimaldataDairy(entityName: Entities.animalAddTblEntity, animalTag:Int(dataGet.animalId ),orderId:Int(self.orderId ),userId:self.userId)
                                                let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: Int(dataGet.providerId), breedId: dataGet.breedId ?? "" )
                                                
                                                for k in 0 ..< animalData.count{
                                                    let animalId = animalData[k] as! AnimaladdTbl
                                                    
                                                    for i in 0 ..< product.count{
                                                        let data = product[i] as! GetProductTbl
                                                        if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                            let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.autoD,customerID: self.custmerId)
                                                            if data12333.count > 0 {
                                                                let adonDat =  fetchProductAdonDataWithBVDV(entityName: Entities.getAdonTblEntity, prodId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue),adonId : LocalizedStrings.bvdvAddOnId)
                                                                if adonDat.count > 0 {
                                                                    self.addedd = true
                                                                    saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "true", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                                    updateOrderStatusAnimal(entity: Entities.dataEntryAnimalAddTbl, status: "true", orderId: Int(self.orderId), userId: self.userId, animalId: Int(dataGet.animalId ))
                                                                }
                                                            }
                                                            else {
                                                                saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "false", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                            }
                                                        }
                                                        else {
                                                            saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId ?? "", productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "false",  farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                        }
                                                        
                                                        if self.pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                                                            self.addonArr = fetchProductAdonData(entityName : Entities.getAdonTblEntity,prodId: Int(data.productId),isCdcbProduct:false)
                                                            
                                                        } else {
                                                            self.addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                                        }
                                                        
                                                        for j in 0 ..< self.addonArr.count {
                                                            let addonDat = self.addonArr[j] as! GetAdonTbl
                                                            if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.autoD,customerID: self.custmerId)
                                                                if data12333.count > 0 {
                                                                    if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                                        updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue), status: "true")
                                                                        
                                                                    }
                                                                    else {
                                                                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                                    }
                                                                }
                                                                else {
                                                                    saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                                }
                                                            }
                                                            
                                                            else {
                                                                saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                            }
                                                        }
                                                    }
                                                    
                                                    if data12333.count > 0 {
                                                        if self.addedd == false {
                                                            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAddedBVDV, comment: ""), preferredStyle: .alert)
                                                            
                                                            let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) {
                                                                UIAlertAction in
                                                                deleteDataWithProduct(Int(dataGet.animalId ))
                                                                deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                                deleteDataWithAnimal(Int(dataGet.animalId ))
                                                                let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                                var bredidd123 = String ()
                                                                if animalCount.count > 0 {
                                                                    let breeid1 = animalCount.object(at: 0) as! AnimaladdTbl
                                                                    bredidd123 = breeid1.breedName ?? ""
                                                                }
                                                                for i in 0 ..< animalCount.count{
                                                                    let breeid1 = animalCount.object(at: i) as! AnimaladdTbl
                                                                    if bredidd123 == breeid1.breedName {
                                                                        bredidd123 = breeid1.breedName ?? ""
                                                                        UserDefaults.standard.set(breeid1.breedId, forKey: keyValue.breedId.rawValue)
                                                                    }
                                                                }
                                                                self.byDefaultSetting()
                                                                self.notificationLblCount.text = String(animalCount.count)
                                                                return
                                                            }
                                                            let cancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
                                                                UIAlertAction in
                                                                
                                                                deleteDataWithProduct(Int(dataGet.animalId ))
                                                                deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                                deleteDataWithAnimal(Int(dataGet.animalId ))
                                                                let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId ),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                                self.notificationLblCount.text = String(animalCount.count)
                                                                self.byDefaultSetting()
                                                                return
                                                            }
                                                            
                                                            alertController.addAction(okAction)
                                                            alertController.addAction(cancelAction)
                                                            self.present(alertController, animated: true, completion: nil)
                                                            return
                                                            
                                                        }
                                                    }
                                                }
                                                
                                                UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                                                let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:self.custmerId ,providerId:self.pvid )
                                                if fetchObj.count != 0 {
                                                    let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                                    let obj = objectFetch?.listName
                                                    let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
                                                    let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                                    self.mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                                                    self.mergeListBtnOulet.isHidden = false
                                                    self.mergeListView.isHidden = false
                                                //    self.crossedBtnOutlet.isHidden = false
                                                    self.showAlertforwithoutBarcodeAnimal()
                                                    UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                                                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
                                                    self.notificationLblCount.text = String(animalCount.count)
                                                }
                                              
                                            }
                                            else {
                                                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
                                                self.notificationLblCount.text = String(animalCount.count)
                                                
                                            }
//                                            self.importBGView.isHidden = true
//                                            self.importListMainView.isHidden = true
                                            
                                        }
                                    }
                                }
                            }
                        }
                        else {
                            for i in 0...self.allDataAnimalTbl.count - 1{
                                let dataGet = self.allDataAnimalTbl.object(at: i) as! DataEntryAnimaladdTbl
                                let data = dataGet.value(forKey: keyValue.capsFarmId.rawValue) as? String
                                
                                if data == "" || dataGet.animalTag == "" {} else {
                                    let fetchData =  fetchAllDataAnimalAnimalIdOfficalId(entityName: Entities.animalAddTblEntity, animalId: dataGet.farmId ?? "", anmalTag: dataGet.animalTag ?? "",custmerId: Int(dataGet.custmerId), userID: self.userId, orderId: self.orderId)
                                    if fetchData.count == 0 {
                                        
                                        let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.orderId,customerID: self.custmerId)
                                        if data12333.count > 0{
                                            if self.tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || self.tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || self.tissueBtnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText {//|| tissuId == 1 || tissuId == 18 {
                                                
                                                saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(self.userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                                
                                                UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                                UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                                UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                                UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                                UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                                self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                                self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                                self.saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                            }
                                            else{
                                                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                                
                                                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                                    UIAlertAction in
                                                    self.byDefaultSetting()
                                                    
                                                }
                                                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                                    UIAlertAction in
                                                    
                                                    deleteDataWithProduct(Int(dataGet.animalId ))
                                                    deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                    deleteDataWithAnimal(Int(dataGet.animalId ))
                                                    UserDefaults.standard.set("", forKey: keyValue.tsuKey.rawValue)
                                                    self.byDefaultSetting()
                                                    return
                                                }
                                                
                                                alertController.addAction(okAction)
                                                alertController.addAction(cancelAction)
                                                self.present(alertController, animated: true, completion: nil)
                                                return
                                            }
                                        }
                                        else {
                                            saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(self.userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                            
                                            UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                            UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                            UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                            UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                            UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                            self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                            self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                            self.saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                        }
                                        
                                        let animalData = fetchAnimaldataDairy(entityName: Entities.animalAddTblEntity, animalTag:Int(dataGet.animalId ),orderId:Int(self.orderId ),userId:self.userId)
                                        let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: Int(dataGet.providerId), breedId: dataGet.breedId ?? "" )
                                        
                                        for k in 0 ..< animalData.count{
                                            let animalId = animalData[k] as! AnimaladdTbl
                                            
                                            for i in 0 ..< product.count{
                                                let data = product[i] as! GetProductTbl
                                                if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                    let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.autoD,customerID: self.custmerId)
                                                    if data12333.count > 0 {
                                                        let adonDat =  fetchProductAdonDataWithBVDV(entityName: Entities.getAdonTblEntity, prodId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue),adonId : LocalizedStrings.bvdvAddOnId)
                                                        if adonDat.count > 0 {
                                                            self.addedd = true
                                                            saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "true", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                            updateOrderStatusAnimal(entity: Entities.dataEntryAnimalAddTbl, status: "true", orderId: Int(self.orderId), userId: self.userId, animalId: Int(dataGet.animalId ))
                                                        }
                                                    }
                                                    else {
                                                        saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "false", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                    }
                                                }
                                                else {
                                                    saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId ?? "", productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "false",  farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                }
                                                
                                                if self.pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                                                    self.addonArr = fetchProductAdonData(entityName : Entities.getAdonTblEntity,prodId: Int(data.productId),isCdcbProduct:false)
                                                    
                                                } else {
                                                    self.addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                                }
                                                
                                                for j in 0 ..< self.addonArr.count {
                                                    let addonDat = self.addonArr[j] as! GetAdonTbl
                                                    if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                        let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.autoD,customerID: self.custmerId)
                                                        if data12333.count > 0 {
                                                            if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                                saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                                updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue), status: "true")
                                                                
                                                            }
                                                            else {
                                                                saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                            }
                                                        }
                                                        else {
                                                            saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                        }
                                                    }
                                                    
                                                    else {
                                                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                    }
                                                }
                                            }
                                            
                                            if data12333.count > 0 {
                                                if self.addedd == false {
                                                    let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAddedBVDV, comment: ""), preferredStyle: .alert)
                                                    
                                                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                                        UIAlertAction in
                                                        deleteDataWithProduct(Int(dataGet.animalId ))
                                                        deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                        deleteDataWithAnimal(Int(dataGet.animalId ))
                                                        
                                                        let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                        var bredidd123 = String ()
                                                        
                                                        if animalCount.count > 0 {
                                                            let breeid1 = animalCount.object(at: 0) as! AnimaladdTbl
                                                            bredidd123 = breeid1.breedName ?? ""
                                                        }
                                                        
                                                        for i in 0 ..< animalCount.count{
                                                            let breeid1 = animalCount.object(at: i) as! AnimaladdTbl
                                                            if bredidd123 == breeid1.breedName {
                                                                bredidd123 = breeid1.breedName ?? ""
                                                                UserDefaults.standard.set(breeid1.breedId, forKey: keyValue.breedId.rawValue)
                                                            }
                                                        }
                                                        self.byDefaultSetting()
                                                        self.notificationLblCount.text = String(animalCount.count)
                                                        return
                                                    }
                                                    let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                                        UIAlertAction in
                                                        deleteDataWithProduct(Int(dataGet.animalId ))
                                                        deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                        deleteDataWithAnimal(Int(dataGet.animalId ))
                                                        
                                                        let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId ),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                        
                                                        self.notificationLblCount.text = String(animalCount.count)
                                                        UserDefaults.standard.set("", forKey: keyValue.tsuKeyType.rawValue)
                                                        self.byDefaultSetting()
                                                        return
                                                    }
                                                    alertController.addAction(okAction)
                                                    alertController.addAction(cancelAction)
                                                    self.present(alertController, animated: true, completion: nil)
                                                    return
                                                }
                                            }
                                        }
                                        
                                        UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                                        UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                                     //   self.crossedBtnOutlet.isHidden = false
                                        
                                        if fetchMergeDataListId(entityName: Entities.mergeDataEntryListTblEntity,listId: Int64(dataGet.listId),customerId: Int64(self.custmerId )).count == 0 {
                                            let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ))
                                            let listObject = fetchList.object(at: 0) as? DataEntryList
                                            let listDescr = listObject?.listDesc
                                            saveMergeDataEntryList(entity: Entities.mergeDataEntryListTblEntity, customerId: Int64(self.custmerId ), listName:self.listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                            
                                        }
                                       
                                        let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:self.custmerId ,providerId:self.pvid )
                                        
                                        if fetchObj.count != 0 {
                                            let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                            let obj = objectFetch?.listName
                                            let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
                                            
                                            if fetchAllMergeDta == 0 {
                                                let fetchNameDisplay = String(obj ?? "")
                                                let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                                self.mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                                self.mergeListBtnOulet.isHidden = false
                                                self.mergeListView.isHidden = false
                                             //   self.crossedBtnOutlet.isHidden = false
                                            } else {
                                                let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                                let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                                self.mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                                self.mergeListBtnOulet.isHidden = false
                                                self.mergeListView.isHidden = false
                                           //     self.crossedBtnOutlet.isHidden = false
                                            }
                                        }
                                        
                                        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
                                        self.notificationLblCount.text = String(animalCount.count)
                                        if animalCount.count == 0 {
                                            self.notificationLblCount.isHidden = true
                                            self.countLbl.isHidden = true
                                            self.cartView.isHidden = true
                                        } else {
                                            self.notificationLblCount.isHidden = false
                                            self.countLbl.isHidden = false
                                            self.cartView.isHidden = false
                                            
                                        }
                                    }
//                                    self.importBGView.isHidden = true
//                                    self.importListMainView.isHidden = true
                                }
                            }
                        }
                        
                    //    self.importFromListOutlet.setTitle(self.listNameString, for: .normal)
                        UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
                        self.notificationLblCount.text = String(animalCount.count)
                        
                        if animalCount.count == 0 {
                            self.notificationLblCount.isHidden = true
                            self.countLbl.isHidden = true
                            self.cartView.isHidden = true
                        } else {
                            self.notificationLblCount.isHidden = false
                            self.countLbl.isHidden = false
                            self.cartView.isHidden = false
                        }
                    }
                    else {
                        let aData =  fetchAnimaldataDairyOrderIdUserId(entityName: Entities.animalAddTblEntity, orderId: self.autoD, userId: self.userId,providerId:self.pvid)
                        if aData.count > 0 {
                            for k in 0 ..< aData.count{
                                let data1 = aData[k] as! AnimaladdTbl
                                let offId = data1.animalTag
                                let farmId  = data1 .farmId
                                let dataEntryvalue =  fetchAllDataAnimalDatarderIdDateEntrycheckfarmIdOffId(entityName: Entities.dataEntryAnimalAddTbl, userId: self.userId, orderId: self.orderId, listid: Int64(self.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid, farmId: farmId ?? "" , animaTag: offId ?? "") as! [DataEntryAnimaladdTbl]
                                
                                if dataEntryvalue.count > 0 {
                                    self.conflictArr.append(contentsOf: dataEntryvalue)
                                }
                            }
                            
                            if self.conflictArr.count > 0 {
                                let count1 = self.conflictArr.count
                                let alertPrint = String(count1) + " " + NSLocalizedString(LocalizedStrings.selectActionToBePerformed, comment: "")
                                
                                let alert = UIAlertController(title: self.listNameString, message: alertPrint, preferredStyle: .alert)
                                let ResolveAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default ,handler: {
                                    (_)in
//                                    self.importBGView.isHidden = true
//                                    self.importListMainView.isHidden = true
                                })
                                
                                let IgnoreAction = UIAlertAction(title: NSLocalizedString("Ignore", comment: ""), style: UIAlertAction.Style.default, handler: { [self]
                                    (_)in
      
                                    let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderId:orderId,orderStatus:"false",listid:Int64(listId), custmerId: Int64(self.custmerId ), providerId: pvid)
                                    
                                    if fetchData11.count != 0 {
                                        for i in 0...fetchData11.count - 1 {
                                            let dataGet = fetchData11.object(at: i) as! DataEntryAnimaladdTbl
                                            
                                            if dataGet.farmId != "" {
                                                let fetchData =  fetchAllDataAnimalAnimalIdOfficalId(entityName: Entities.animalAddTblEntity, animalId: dataGet.farmId ?? "", anmalTag: dataGet.animalTag ?? "",custmerId: Int(dataGet.custmerId), userID: self.userId, orderId: self.orderId)
                                                
                                                if fetchData.count == 0 {
                                                    let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:orderId,customerID: custmerId)
                                                    
                                                    if data12333.count > 0{
                                                        if self.tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || tissueBtnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                                                            
                                                            saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                                            
                                                            UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                                            UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                                            UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                                            UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                                            UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                                            self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                                            self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                                            saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                                        }
                                                        else{
                                                            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                                            
                                                            let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) {
                                                                UIAlertAction in
                                                                self.byDefaultSetting()
                                                                
                                                            }
                                                            let cancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
                                                                UIAlertAction in
                                                                deleteDataWithProduct(Int(dataGet.animalId ))
                                                                deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                                deleteDataWithAnimal(Int(dataGet.animalId ))
                                                                UserDefaults.standard.set("", forKey: keyValue.tsuKey.rawValue)
                                                                self.byDefaultSetting()
                                                                return
                                                            }
                                                            alertController.addAction(okAction)
                                                            alertController.addAction(cancelAction)
                                                            self.present(alertController, animated: true, completion: nil)
                                                            return
                                                        }
                                                    }
                                                    else {
                                                        saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                                        
                                                        UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                                        UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                                        UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                                        UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                                        UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                                        self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                                        self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                                        saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                                        
                                                    }
                                                    let animalData = fetchAnimaldataDairy(entityName: Entities.animalAddTblEntity, animalTag:Int(dataGet.animalId ),orderId:Int(self.orderId ),userId:self.userId)
                                                    let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: Int(dataGet.providerId), breedId: dataGet.breedId ?? "" )
                                                    
                                                    for k in 0 ..< animalData.count{
                                                        let animalId = animalData[k] as! AnimaladdTbl
                                                        
                                                        for i in 0 ..< product.count{
                                                            let data = product[i] as! GetProductTbl
                                                            if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.autoD,customerID: custmerId)
                                                                if data12333.count > 0 {
                                                                    let adonDat =  fetchProductAdonDataWithBVDV(entityName: Entities.getAdonTblEntity, prodId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue),adonId : LocalizedStrings.bvdvAddOnId)
                                                                    if adonDat.count > 0 {
                                                                        self.addedd = true
                                                                        saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "true", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                                        updateOrderStatusAnimal(entity: Entities.dataEntryAnimalAddTbl, status: "true", orderId: Int(self.orderId), userId: self.userId, animalId: Int(dataGet.animalId ))
                                                                    }
                                                                }
                                                                else {
                                                                    saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "false", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                                }
                                                            }
                                                            else {
                                                                saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId ?? "", productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "false",  farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                            }
                                                            
                                                            let addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                                            
                                                            for j in 0 ..< addonArr.count {
                                                                let addonDat = addonArr[j] as! GetAdonTbl
                                                                
                                                                if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                                    let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.autoD,customerID: custmerId)
                                                                    
                                                                    if data12333.count > 0 {
                                                                        if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                                            saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:self.timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                                            updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue), status: "true")
                                                                        }
                                                                        else {
                                                                            saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:self.timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                                        }
                                                                    }
                                                                    else {
                                                                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:self.timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                                    }
                                                                }
                                                                
                                                                else {
                                                                    saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:self.timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                                }
                                                            }
                                                        }
                                                        
                                                        
                                                        if data12333.count > 0 {
                                                            if self.addedd == false {
                                                                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAddedBVDV, comment: ""), preferredStyle: .alert)
                                                                
                                                                let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) {
                                                                    UIAlertAction in
                                                                    deleteDataWithProduct(Int(dataGet.animalId ))
                                                                    deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                                    deleteDataWithAnimal(Int(dataGet.animalId ))
                                                                    
                                                                    let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                                    var bredidd123 = String ()
                                                                    
                                                                    if animalCount.count > 0 {
                                                                        let breeid1 = animalCount.object(at: 0) as! AnimaladdTbl
                                                                        bredidd123 = breeid1.breedName ?? ""
                                                                    }
                                                                    
                                                                    for i in 0 ..< animalCount.count{
                                                                        let breeid1 = animalCount.object(at: i) as! AnimaladdTbl
                                                                        if bredidd123 == breeid1.breedName {
                                                                            bredidd123 = breeid1.breedName ?? ""
                                                                            UserDefaults.standard.set(breeid1.breedId, forKey: keyValue.breedId.rawValue)
                                                                            
                                                                        }
                                                                        
                                                                        
                                                                    }
                                                                    self.byDefaultSetting()
                                                                    self.notificationLblCount.text = String(animalCount.count)
                                                                    return
                                                                }
                                                                let cancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
                                                                    UIAlertAction in
                                                                    deleteDataWithProduct(Int(dataGet.animalId ))
                                                                    deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                                    deleteDataWithAnimal(Int(dataGet.animalId ))
                                                                    
                                                                    let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId ),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                                    self.notificationLblCount.text = String(animalCount.count)
                                                                    self.byDefaultSetting()
                                                                    return
                                                                }
                                                                
                                                                alertController.addAction(okAction)
                                                                alertController.addAction(cancelAction)
                                                                self.present(alertController, animated: true, completion: nil)
                                                                return
                                                                
                                                            }
                                                        }
                                                    }
                                                    UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                                                    mergeListBtnOulet.isHidden = false
                                                    self.mergeListView.isHidden = false
                                                  //  showAlertforwithoutBarcodeAnimal()
                                                    UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                                                 //   self.crossedBtnOutlet.isHidden = false
                                                    if fetchMergeDataListId(entityName: Entities.mergeDataEntryListTblEntity,listId: Int64(dataGet.listId),customerId: Int64(self.custmerId )).count == 0 {
                                                        let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ))
                                                        let listObject = fetchList.object(at: 0) as? DataEntryList
                                                        let listDescr = listObject?.listDesc
                                                        saveMergeDataEntryList(entity: Entities.mergeDataEntryListTblEntity, customerId: Int64(self.custmerId ), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                                    }
                                                    
                                                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: pvid)
                                                    notificationLblCount.text = String(animalCount.count)
                                                    let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ,providerId:pvid )
                                                    
                                                    if fetchObj.count != 0 {
                                                        let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                                        let obj = objectFetch?.listName
                                                        let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
                                                        
                                                        if fetchAllMergeDta == 0 {
                                                            let fetchNameDisplay = String(obj ?? "")
                                                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                                            mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                                        }
                                                        else {
                                                            let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                                            mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                                        }
                                                    }
                                                }
                                                else {
                                                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: pvid)
                                                    notificationLblCount.text = String(animalCount.count)
                                                }
                                            }
                                        }
                                    }
                                    
                                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: pvid)
                                    notificationLblCount.text = String(animalCount.count)
                                    showAlertforwithoutBarcodeAnimal()
//                                    self.importListMainView.isHidden = true
//                                    self.importBGView.isHidden = true
//                                    self.importFromListOutlet.isEnabled = true
                                })
//                                self.importBGView.isHidden = true
//                                self.importListMainView.isHidden = true
                                alert.addAction(ResolveAction)
                                alert.addAction(IgnoreAction)
                                self.present(alert, animated: true, completion: nil)
                            }
                            else {
                                let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                if fetchData11.count != 0 {
                                    
                                    for i in 0...fetchData11.count - 1 {
                                        let dataGet = fetchData11.object(at: i) as! DataEntryAnimaladdTbl
                                        
                                        if dataGet.farmId != "" {
                                            let fetchData =  fetchAllDataAnimalAnimalIdOfficalId(entityName: Entities.animalAddTblEntity, animalId: dataGet.farmId ?? "", anmalTag: dataGet.animalTag ?? "",custmerId: Int(dataGet.custmerId), userID: self.userId, orderId: self.orderId)
                                            
                                            if fetchData.count == 0 {
                                                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.orderId,customerID: self.custmerId)
                                                
                                                if data12333.count > 0{
                                                    if self.tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || self.tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || self.tissueBtnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                                                        
                                                        saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(self.userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                                        
                                                        UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                                        UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                                        UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                                        UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                                        UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                                        self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                                        self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                                        self.saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                                    }
                                                    else{
                                                        let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                                        
                                                        let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) {
                                                            UIAlertAction in
                                                            self.byDefaultSetting()
                                                            
                                                        }
                                                        let cancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
                                                            UIAlertAction in
                                                            deleteDataWithProduct(Int(dataGet.animalId ))
                                                            deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                            deleteDataWithAnimal(Int(dataGet.animalId ))
                                                            UserDefaults.standard.set("", forKey: keyValue.tsuKey.rawValue)
                                                            self.byDefaultSetting()
                                                            return
                                                        }
                                                        alertController.addAction(okAction)
                                                        alertController.addAction(cancelAction)
                                                        self.present(alertController, animated: true, completion: nil)
                                                        return
                                                    }
                                                }
                                                else {
                                                    saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(self.userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                                    
                                                    UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                                    UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                                    UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                                    UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                                    UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                                    self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                                    self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                                    self.saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                                }
                                                let animalData = fetchAnimaldataDairy(entityName: Entities.animalAddTblEntity, animalTag:Int(dataGet.animalId ),orderId:Int(self.orderId ),userId:self.userId)
                                                let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: Int(dataGet.providerId), breedId: dataGet.breedId ?? "" )
                                                
                                                for k in 0 ..< animalData.count{
                                                    let animalId = animalData[k] as! AnimaladdTbl
                                                    
                                                    for i in 0 ..< product.count{
                                                        let data = product[i] as! GetProductTbl
                                                        if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                            let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.autoD,customerID: self.custmerId)
                                                            if data12333.count > 0 {
                                                                let adonDat =  fetchProductAdonDataWithBVDV(entityName: Entities.getAdonTblEntity, prodId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue),adonId : LocalizedStrings.bvdvAddOnId)
                                                                if adonDat.count > 0 {
                                                                    self.addedd = true
                                                                    saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "true", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                                    updateOrderStatusAnimal(entity: Entities.dataEntryAnimalAddTbl, status: "true", orderId: Int(self.orderId), userId: self.userId, animalId: Int(dataGet.animalId ))
                                                                }
                                                            }
                                                            else {
                                                                saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "false", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                            }
                                                        }
                                                        else {
                                                            saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId ?? "", productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "false",  farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                        }
                                                        
                                                        if self.pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                                                            self.addonArr = fetchProductAdonData(entityName : Entities.getAdonTblEntity,prodId: Int(data.productId),isCdcbProduct:false)
                                                        }
                                                        else {
                                                            self.addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                                        }
                                                        
                                                        for j in 0 ..< self.addonArr.count {
                                                            let addonDat = self.addonArr[j] as! GetAdonTbl
                                                            if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.autoD,customerID: self.custmerId)
                                                                if data12333.count > 0 {
                                                                    if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                                        updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue), status: "true")
                                                                    }
                                                                    else {
                                                                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                                    }
                                                                }
                                                                else {
                                                                    saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                                }
                                                            }
                                                            
                                                            else {
                                                                saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                            }
                                                        }
                                                    }
                                                    
                                                    
                                                    if data12333.count > 0 {
                                                        if self.addedd == false {
                                                            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAddedBVDV, comment: ""), preferredStyle: .alert)
                                                            
                                                            let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) {
                                                                UIAlertAction in
                                                                deleteDataWithProduct(Int(dataGet.animalId ))
                                                                deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                                deleteDataWithAnimal(Int(dataGet.animalId ))
                                                                
                                                                let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                                var bredidd123 = String ()
                                                                
                                                                if animalCount.count > 0 {
                                                                    let breeid1 = animalCount.object(at: 0) as! AnimaladdTbl
                                                                    bredidd123 = breeid1.breedName ?? ""
                                                                }
                                                                
                                                                for i in 0 ..< animalCount.count{
                                                                    let breeid1 = animalCount.object(at: i) as! AnimaladdTbl
                                                                    if bredidd123 == breeid1.breedName {
                                                                        bredidd123 = breeid1.breedName ?? ""
                                                                        UserDefaults.standard.set(breeid1.breedId, forKey: keyValue.breedId.rawValue)
                                                                    }
                                                                }
                                                                self.byDefaultSetting()
                                                                self.notificationLblCount.text = String(animalCount.count)
                                                                return
                                                            }
                                                            let cancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
                                                                UIAlertAction in
                                                                deleteDataWithProduct(Int(dataGet.animalId ))
                                                                deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                                deleteDataWithAnimal(Int(dataGet.animalId ))
                                                                
                                                                let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId ),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                                self.notificationLblCount.text = String(animalCount.count)
                                                                self.byDefaultSetting()
                                                                return
                                                            }
                                                            alertController.addAction(okAction)
                                                            alertController.addAction(cancelAction)
                                                            self.present(alertController, animated: true, completion: nil)
                                                            return
                                                        }
                                                    }
                                                }
                                                
                                                UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                                                
                                                if fetchMergeDataListId(entityName: Entities.mergeDataEntryListTblEntity,listId: Int64(dataGet.listId),customerId: Int64(self.custmerId )).count == 0 {
                                                    let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ))
                                                    let listObject = fetchList.object(at: 0) as? DataEntryList
                                                    let listDescr = listObject?.listDesc
                                                    saveMergeDataEntryList(entity: Entities.mergeDataEntryListTblEntity, customerId: Int64(self.custmerId ), listName:self.listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                                }
                                                let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:self.custmerId ,providerId:self.pvid )
                                                
                                                if fetchObj.count != 0 {
                                                    let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                                    let obj = objectFetch?.listName
                                                    let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
                                                    
                                                    if fetchAllMergeDta == 0 {
                                                        let fetchNameDisplay = String(obj ?? "")
                                                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                                        self.mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                                    }
                                                    else {
                                                        let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                                        self.mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                                        
                                                    }
                                                }
                                                self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                                                self.mergeListBtnOulet.isHidden = false
                                                self.mergeListView.isHidden = false
                                                self.showAlertforwithoutBarcodeAnimal()
                                                UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                                             //   self.crossedBtnOutlet.isHidden = false
                                                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
                                                self.notificationLblCount.text = String(animalCount.count)
                                            }
                                            else {
                                                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
                                                self.notificationLblCount.text = String(animalCount.count)
                                            }
                                        }
                                    }
                                }
                                
                                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
                                self.notificationLblCount.text = String(animalCount.count)
//                                self.importListMainView.isHidden = true
//                                self.importBGView.isHidden = true
//                                self.importFromListOutlet.isEnabled = true
                            }
                        }
                        else {
                            for i in 0...self.allDataAnimalTbl.count - 1{
                                let dataGet = self.allDataAnimalTbl.object(at: i) as! DataEntryAnimaladdTbl
                                let data = dataGet.value(forKey: keyValue.capsFarmId.rawValue) as? String
                                
                                if data != "" {
                                    let fetchData =  fetchAllDataAnimalAnimalIdOfficalId(entityName: Entities.animalAddTblEntity, animalId: dataGet.farmId ?? "", anmalTag: dataGet.animalTag ?? "",custmerId: Int(dataGet.custmerId), userID: self.userId, orderId: self.orderId)
                                    
                                    if fetchData.count == 0 {
                                        let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.orderId,customerID: self.custmerId)
                                        if data12333.count > 0{
                                            if self.tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || self.tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || self.tissueBtnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                                                
                                                saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(self.userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                                
                                                UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                                UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                                UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                                UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                                UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                                self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                                self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                                self.saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                                
                                            }
                                            else{
                                                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                                
                                                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                                    UIAlertAction in
                                                    self.byDefaultSetting()
                                                    
                                                }
                                                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                                    UIAlertAction in
                                                    deleteDataWithProduct(Int(dataGet.animalId ))
                                                    deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                    deleteDataWithAnimal(Int(dataGet.animalId ))
                                                    UserDefaults.standard.set("", forKey: keyValue.tsuKey.rawValue)
                                                    self.byDefaultSetting()
                                                    return
                                                }
                                                alertController.addAction(okAction)
                                                alertController.addAction(cancelAction)
                                                self.present(alertController, animated: true, completion: nil)
                                                return
                                            }
                                        }
                                        else {
                                            saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ),orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(self.userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                                            
                                            UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                                            UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                                            UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                                            UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                                            UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                                            self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                                            self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                                            self.saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                                        }
                                        
                                        let animalData = fetchAnimaldataDairy(entityName: Entities.animalAddTblEntity, animalTag:Int(dataGet.animalId ),orderId:Int(self.orderId ),userId:self.userId)
                                        let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: Int(dataGet.providerId), breedId: dataGet.breedId ?? "" )
                                        
                                        for k in 0 ..< animalData.count{
                                            let animalId = animalData[k] as! AnimaladdTbl
                                            for i in 0 ..< product.count{
                                                let data = product[i] as! GetProductTbl
                                                if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                    let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.autoD,customerID: self.custmerId)
                                                    if data12333.count > 0 {
                                                        let adonDat =  fetchProductAdonDataWithBVDV(entityName: Entities.getAdonTblEntity, prodId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue),adonId : LocalizedStrings.bvdvAddOnId)
                                                        if adonDat.count > 0 {
                                                            self.addedd = true
                                                            saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "true", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                            updateOrderStatusAnimal(entity: Entities.dataEntryAnimalAddTbl, status: "true", orderId: Int(self.orderId), userId: self.userId, animalId: Int(dataGet.animalId ))
                                                        }
                                                    }
                                                    else {
                                                        saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "false", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                    }
                                                }
                                                else {
                                                    saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId ?? "", productId:Int(data.productId) , productName: data.productName ?? "", providerId: self.pvid, status: "false",  farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                                }
                                                
                                                if self.pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                                                    self.addonArr = fetchProductAdonData(entityName : Entities.getAdonTblEntity,prodId: Int(data.productId),isCdcbProduct:false)
                                                } else {
                                                    self.addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                                }
                                                
                                                for j in 0 ..< self.addonArr.count {
                                                    let addonDat = self.addonArr[j] as! GetAdonTbl
                                                    if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                                        let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.autoD,customerID: self.custmerId)
                                                        if data12333.count > 0 {
                                                            if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                                saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                                updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue), status: "true")
                                                                
                                                            }
                                                            else {
                                                                saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                            }
                                                        }
                                                        else {
                                                            saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                        }
                                                    }
                                                    else {
                                                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: self.userId,udid:self.timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                    }
                                                }
                                            }
                                            
                                            if data12333.count > 0 {
                                                if self.addedd == false {
                                                    let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAddedBVDV, comment: ""), preferredStyle: .alert)
                                                    
                                                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                                        UIAlertAction in
                                                        deleteDataWithProduct(Int(dataGet.animalId ))
                                                        deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                        deleteDataWithAnimal(Int(dataGet.animalId ))
                                                        
                                                        
                                                        let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                        var bredidd123 = String ()
                                                        
                                                        if animalCount.count > 0 {
                                                            let breeid1 = animalCount.object(at: 0) as! AnimaladdTbl
                                                            bredidd123 = breeid1.breedName ?? ""
                                                        }
                                                        
                                                        for i in 0 ..< animalCount.count{
                                                            let breeid1 = animalCount.object(at: i) as! AnimaladdTbl
                                                            if bredidd123 == breeid1.breedName {
                                                                bredidd123 = breeid1.breedName ?? ""
                                                                UserDefaults.standard.set(breeid1.breedId, forKey: keyValue.breedId.rawValue)
                                                            }
                                                        }
                                                        self.byDefaultSetting()
                                                        self.notificationLblCount.text = String(animalCount.count)
                                                        return
                                                    }
                                                    let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                                        
                                                        UIAlertAction in
                                                        
                                                        deleteDataWithProduct(Int(dataGet.animalId ))
                                                        deleteDataWithSubProduct(Int(dataGet.animalId ))
                                                        deleteDataWithAnimal(Int(dataGet.animalId ))
                                                        
                                                        let animalCount =  fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.animalAddTblEntity, userId: Int(self.userId),orderId:Int(self.orderId ),orderStatus:"false",listid: Int64(dataGet.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                                                        self.notificationLblCount.text = String(animalCount.count)
                                                        
                                                        UserDefaults.standard.set("", forKey: keyValue.tsuKeyType.rawValue)
                                                        self.byDefaultSetting()
                                                        return
                                                    }
                                                    alertController.addAction(okAction)
                                                    alertController.addAction(cancelAction)
                                                    self.present(alertController, animated: true, completion: nil)
                                                    return
                                                }
                                            }
                                        }
                                        
                                        UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                                        UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                                     //   self.crossedBtnOutlet.isHidden = false
                                        
                                        if fetchMergeDataListId(entityName: Entities.mergeDataEntryListTblEntity,listId: Int64(dataGet.listId),customerId: Int64(self.custmerId )).count == 0 {
                                            let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ))
                                            let listObject = fetchList.object(at: 0) as? DataEntryList
                                            let listDescr = listObject?.listDesc
                                            saveMergeDataEntryList(entity: Entities.mergeDataEntryListTblEntity, customerId: Int64(self.custmerId ), listName:self.listNameString, listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                        }
                                        
                                        let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:self.custmerId ,providerId:self.pvid)
                                        
                                        if fetchObj.count != 0 {
                                            let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                            let obj = objectFetch?.listName
                                            let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
                                            
                                            if fetchAllMergeDta == 0 {
                                                let fetchNameDisplay = String(obj ?? "")
                                                let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                                self.mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                                
                                            } else {
                                                let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                                let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                                self.mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                            }
                                        }
                                        
                                        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
                                        self.notificationLblCount.text = String(animalCount.count)
                                        
                                        if animalCount.count == 0 {
                                            self.notificationLblCount.isHidden = true
                                            self.countLbl.isHidden = true
                                            self.cartView.isHidden = true
                                        } else {
                                            self.notificationLblCount.isHidden = false
                                            self.countLbl.isHidden = false
                                            self.cartView.isHidden = false
                                        }
                                    }
//                                    self.importBGView.isHidden = true
//                                    self.importListMainView.isHidden = true
                                }
                            }
                        }
                        
                        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
                        self.notificationLblCount.text = String(animalCount.count)
                        
                        if animalCount.count == 0 {
                            self.notificationLblCount.isHidden = true
                            self.countLbl.isHidden = true
                            self.cartView.isHidden = true
                        } else {
                            self.notificationLblCount.isHidden = false
                            self.countLbl.isHidden = false
                            self.cartView.isHidden = false
                        }
                    }
                })
                let thirdAction = UIAlertAction(title:  NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default, handler: {
                    (_)in
                })
//                self.importListMainView.isHidden = true
//                self.importBGView.isHidden = true
                alert.addAction(ResolveAction)
                alert.addAction(IgnoreAction)
                alert.addAction(thirdAction)
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        createDataList()
    }
}

