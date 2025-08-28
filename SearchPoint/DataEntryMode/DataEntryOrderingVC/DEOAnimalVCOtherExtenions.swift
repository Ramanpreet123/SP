//
//  DEOAnimalVCOtherExtenions.swift
//  SearchPoint
//
//  Created by Mobile Programming on 25/02/24.
//

import Foundation
import CoreBluetooth
import Toast_Swift
import Vision
import VisionKit

// MARK: - TABLEVIEW DELEGATE AND DATASOURCE EXTENSION
extension DataEntryOrderingAnimalVC :UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == pairedTableView {
            return arrNearbyDevice.count
        }
        else if btnTag == 10 {
            return self.breedArr.count
        }  else  if btnTag == 20{
            return self.tissueArr.count
        }else if btnTag == 0 || btnTag == 1 {
            return self.filterAdhAnimalData.count
        }
        else{
            return self.autocompleteUrls2.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        if tableView == pairedTableView {
            let cell = pairedTableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.pairedDeviceCellId, for: indexPath) as! PairedDeviceCell
            var deviceName = arrNearbyDevice[indexPath.row].name
            if deviceName == nil {
                deviceName = String(describing: arrNearbyDevice[indexPath.row].identifier)
            }
            cell.deviceLbl?.text = deviceName
            let state = arrNearbyDevice[indexPath.row].state
            if  state == .connected{
                cell.accessoryType = .checkmark
            }
            else {
                cell.accessoryType = .none
            }
            return cell
            
        }
        
        if btnTag == 10 {
            
            let breeedData = self.breedArr[indexPath.row]  as! GetBreedsTbl
            if breeedData.breedId == LocalizedStrings.burkinaFasoBreedId && breeedData.alpha2?.isEmpty == true {
                cell.textLabel?.text = "BF"
            } else {
                cell.textLabel?.text = breeedData.alpha2
            }
            return cell
            
        } else if btnTag == 20 {
            let tissue = self.tissueArr[indexPath.row]  as! GetSampleTbl
            cell.textLabel?.text = tissue.sampleName?.localized
            saveSampleNameandID(sampleNameStr: tissue.sampleName ?? "", sampleID: Int(tissue.sampleId))
            return cell
            
        }else if btnTag == 30 {
            do {
                if indexPath.row  < autocompleteUrls2.count {
                    if let value = autocompleteUrls2.object(at:indexPath.row) as? String{
                        cell.textLabel?.text = value
                        cell.textLabel?.numberOfLines = 2
                    }
                }
                return cell
            }
        }
        
        else if btnTag == 0 {
            do{
                if indexPath.row  < filterAdhAnimalData.count {
                    if scanAnimalTagText.tag == 0 {
                        if let value = filterAdhAnimalData[indexPath.row].animalTag{
                            cell.textLabel?.text = value
                        }
                    } else {
                        if let value = filterAdhAnimalData[indexPath.row].animalTag{
                            cell.textLabel?.text = value
                        }
                    }
                }
            }
            return cell
        }
        else if btnTag == 1 {
            do{
                if indexPath.row  < filterAdhAnimalData.count {
                    if scanAnimalTagText.tag == 1 {
                        if let value = filterAdhAnimalData[indexPath.row].farmId{
                            cell.textLabel?.text = value
                        }
                    } else {
                        if let value = filterAdhAnimalData[indexPath.row].farmId{
                            cell.textLabel?.text = value
                        }
                    }
                }
                return cell
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == pairedTableView {
            if BluetoothCentre.shared.smartBowPeripheral != nil {
                BluetoothCentre.shared.manager.cancelPeripheralConnection(BluetoothCentre.shared.smartBowPeripheral!)
            }
            BluetoothCentre.shared.ConnectArgument(peripheral: arrNearbyDevice[indexPath.row])
            pairedBackroundView.isHidden = true
            pairedDeviceView.isHidden = true
            pairedTableView.reloadData()
            return
        }
        
        if btnTag == 10 {
            let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.animalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId!)
            if orederStatus.count > 0 {
                barcodeEnable = true
                buttonbg2.removeFromSuperview()
                let breeedData = self.breedArr[indexPath.row]  as! GetBreedsTbl
                breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
                return
            }
            
            let breeedData = self.breedArr[indexPath.row]  as! GetBreedsTbl
            breedId = breeedData.breedId!
            let breedidd =  UserDefaults.standard.value(forKey: keyValue.dataEntrybreedId.rawValue) as? String
            if breedidd != breedId {
                let animalData = fetchAnimaldataDairy(entityName: Entities.dataEntryAnimalAddTbl, animalTag:animalId1,orderId:orderId,userId:userId)
                if animalData.count > 0 {
                    
                    let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(LocalizedStrings.changeBreedClearProduct, comment: ""), preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: { (_) in
                    }))
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                        let animalId = animalData.object(at: 0) as! DataEntryAnimaladdTbl
                        deleteDataWithProduct(Int(animalId.animalId))
                        deleteDataWithSubProduct(Int(animalId.animalId))
                        let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
                        let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: pvid, breedId: self.breedId )
                        for k in 0 ..< animalData.count  {
                            let animalId = animalData[k] as! DataEntryAnimaladdTbl
                            for i in 0 ..< product.count{
                                let data = product[i] as! GetProductTbl
                                if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                    let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.autoD, customerID: self.custmerId ?? 0)
                                    if data12333.count > 0 {
                                        let adonDat =  fetchProductAdonDataWithBVDV(entityName: Entities.getAdonTblEntity, prodId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue),adonId : LocalizedStrings.bvdvAddOnId)
                                        if adonDat.count > 0 {
                                            saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: self.farmIdText, orderId: Int(animalId.orderId), orderStatus: "false", isSync: "false", userId: self.userId,udid:animalId.udid ?? "", animalId: Int(animalId.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "", custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                            
                                            updateOrderStatusAnimal(entity: Entities.dataEntryAnimalAddTbl, status: "true", orderId: Int(animalId.orderId), userId: self.userId, animalId:  Int(animalId.animalId))
                                        }
                                    }
                                    else {
                                        saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: self.farmIdText, orderId: Int(animalId.orderId), orderStatus: "false", isSync: "false", userId: self.userId,udid:animalId.udid ?? "", animalId: Int(animalId.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                    }
                                }
                                else {
                                    saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId! , productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: self.farmIdText, orderId: Int(animalId.orderId), orderStatus: "false", isSync: "false", userId: self.userId,udid:animalId.udid ?? "", animalId: Int(animalId.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                }
                                let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                
                                for j in 0 ..< addonArr.count {
                                    let addonDat = addonArr[j] as! GetAdonTbl
                                    if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                                        let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.autoD, customerID: self.custmerId ?? 0)
                                        if data12333.count > 0 {
                                            if Int(addonDat.adonId) == 1 {
                                                saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: Int(animalId.orderId), orderStatus: "false", isSync: "false", userId: self.userId,udid:animalId.udid ?? "", farmId: self.farmIdText, animalId: Int(animalId.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue), status: "true")
                                            }
                                            else {
                                                saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(animalId.orderId), orderStatus: "false", isSync: "false", userId: self.userId,udid:animalId.udid ?? "", farmId: self.farmIdText, animalId: Int(animalId.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                            }
                                        }
                                    }
                                    else {
                                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(animalId.orderId), orderStatus: "false", isSync: "false", userId: self.userId,udid:animalId.udid ?? "", farmId: self.farmIdText, animalId: Int(animalId.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                    }
                                }
                            }
                        }
                        let  aDat = fetchAllData(entityName: Entities.dataEntryAnimalAddTbl)
                        if aDat.count > 0{
                            UserDefaults.standard.set(true, forKey: keyValue.identifyStore.rawValue)
                        }
                        
                        UserDefaults.standard.set(self.breedId, forKey: keyValue.dataEntrybreedId.rawValue)
                        self.breedBtnOutlet.setTitleColor(.black, for: .normal)
                        
                        if breeedData.breedId == LocalizedStrings.burkinaFasoBreedId && breeedData.alpha2?.isEmpty == true {
                            self.breedBtnOutlet.setTitle("BF", for: .normal)
                            UserDefaults.standard.set("BF", forKey: keyValue.dataEntrybreedName.rawValue)
                            
                        } else {
                            let breestr = breeedData.alpha2 ?? ""
                            let stri = UserDefaults.standard.value(forKey: keyValue.selectAnimalId.rawValue) as? String ?? ""
                            
                            if (breestr == stri.prefix(2))
                            {
                                self.breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
                            }
                            else
                            {
                                let alert = UIAlertController(title: NSLocalizedString("", comment: ""), message: NSLocalizedString(LocalizedStrings.selectedDiffBreed, comment: ""), preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { (_) in
                                    self.breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
                                }))
                                alert.addAction(UIAlertAction(title: "NO", style: .default, handler: { (_) in
                                    self.breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
                                    UserDefaults.standard.set(breeedData.alpha2, forKey: keyValue.capsBreedName.rawValue)
                                    var animalBreedChange = UserDefaults.standard.value(forKey: keyValue.selectAnimalId.rawValue) as? String ?? ""
                                    if animalBreedChange.count == 17 {
                                        if breeedData.alpha2! == "" {
                                            animalBreedChange = "BF" + String(animalBreedChange.dropFirst(2))
                                            
                                        } else {
                                            animalBreedChange = breeedData.alpha2! + String(animalBreedChange.dropFirst(2))
                                            
                                        }
                                        UserDefaults.standard.set(animalBreedChange, forKey: keyValue.selectAnimalId.rawValue)
                                        self.textFieldAnimal = animalBreedChange
                                        if self.scanAnimalTagText.tag == 0 {
                                            self.scanAnimalTagText.text! = animalBreedChange
                                        }
                                        else {
                                            
                                            self.farmIdTextField.text! = animalBreedChange
                                        }
                                    }
                                }))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                        
                        let animalBreedChange = UserDefaults.standard.value(forKey: keyValue.selectAnimalId.rawValue) as? String ?? ""
                        let codeId = fetchBreedDatabreedCode( entityName: Entities.getBreedsTblEntity,provId: pvid,breedCode:breeedData.alpha2!)
                        let naabFetch1 = codeId.value(forKey: keyValue.breedId.rawValue) as? NSArray
                        if naabFetch1!.count == 0 {
                        } else {
                            let breedIdGet = (naabFetch1![0] as? String)!
                            self.breedId = breedIdGet
                        }
                        if self.borderRedCheck{
                            
                        } else {
                            if self.scanAnimalTagText.tag == 0 {
                                self.scanAnimalTagText.text! = animalBreedChange
                            }
                            else {
                                self.farmIdTextField.text! = animalBreedChange
                            }
                        }
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                else {
                    if breedidd != breedId {
                        let  aDat = fetchAllData(entityName: Entities.dataEntryAnimalAddTbl)
                        if aDat.count > 0{
                            UserDefaults.standard.set(true, forKey: keyValue.identifyStore.rawValue)
                        }
                    }
                    
                    UserDefaults.standard.set(self.breedId, forKey: keyValue.dataEntrybreedId.rawValue)
                    self.breedBtnOutlet.setTitleColor(.black, for: .normal)
                    if breeedData.breedId == LocalizedStrings.burkinaFasoBreedId && breeedData.alpha2?.isEmpty == true {
                        self.breedBtnOutlet.setTitle("BF", for: .normal)
                        UserDefaults.standard.set("BF", forKey: keyValue.dataEntrybreedName.rawValue)
                    } else {
                        let alert = UIAlertController(title: NSLocalizedString("", comment: ""), message: NSLocalizedString(LocalizedStrings.selectedDiffBreed, comment: ""), preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { (_) in
                            self.breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
                            
                        }))
                        
                        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (_) in
                            self.breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
                            UserDefaults.standard.set(breeedData.alpha2, forKey: keyValue.capsBreedName.rawValue)
                            var animalBreedChange = UserDefaults.standard.value(forKey: keyValue.selectAnimalId.rawValue) as? String ?? ""
                            if animalBreedChange.count == 17 {
                                if breeedData.alpha2! == "" {
                                    animalBreedChange = "BF" + String(animalBreedChange.dropFirst(2))
                                    
                                } else {
                                    animalBreedChange = breeedData.alpha2! + String(animalBreedChange.dropFirst(2))
                                    
                                }
                                UserDefaults.standard.set(animalBreedChange, forKey: keyValue.selectAnimalId.rawValue)
                                self.textFieldAnimal = animalBreedChange
                                if self.scanAnimalTagText.tag == 0 {
                                    self.scanAnimalTagText.text! = animalBreedChange
                                }
                                else {
                                    self.farmIdTextField.text! = animalBreedChange
                                }
                            }
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    let animalBreedChange = UserDefaults.standard.value(forKey: keyValue.selectAnimalId.rawValue) as? String ?? ""
                    let codeId = fetchBreedDatabreedCode( entityName: Entities.getBreedsTblEntity,provId: pvid,breedCode:breeedData.alpha2!)
                    let naabFetch1 = codeId.value(forKey: keyValue.breedId.rawValue) as? NSArray
                    if naabFetch1!.count == 0 {
                        
                    } else {
                        let breedIdGet = (naabFetch1![0] as? String)!
                        breedId = breedIdGet
                    }
                    if borderRedCheck {
                        
                    } else {
                        if scanAnimalTagText.tag == 0 {
                            scanAnimalTagText.text! = animalBreedChange
                        }
                        else {
                            farmIdTextField.text! = animalBreedChange
                        }
                    }
                }
            }
            else {
                if breedidd != breedId {
                    let  aDat = fetchAllData(entityName: Entities.dataEntryAnimalAddTbl)
                    if aDat.count > 0{
                        UserDefaults.standard.set(true, forKey: keyValue.identifyStore.rawValue)
                    }
                }
                
                self.breedBtnOutlet.setTitleColor(.black, for: .normal)
                if breeedData.breedId == LocalizedStrings.burkinaFasoBreedId && breeedData.alpha2?.isEmpty == true {
                    self.breedBtnOutlet.setTitle("BF", for: .normal)
                    UserDefaults.standard.set("BF", forKey: keyValue.dataEntrybreedName.rawValue)
                    UserDefaults.standard.set( breeedData.breedId, forKey: keyValue.dataEntrybreedId.rawValue)
                } else {
                    self.breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
                    UserDefaults.standard.set(breeedData.alpha2, forKey: keyValue.dataEntrybreedName.rawValue)
                    UserDefaults.standard.set(breedId, forKey: keyValue.dataEntrybreedId.rawValue)
                }
                var animalBreedChange = UserDefaults.standard.value(forKey: keyValue.selectAnimalId.rawValue) as? String ?? ""
                if animalBreedChange.count == 17 {
                    if breeedData.alpha2! == "" {
                        animalBreedChange = "BF" + String(animalBreedChange.dropFirst(2))
                    } else {
                        animalBreedChange = breeedData.alpha2! + String(animalBreedChange.dropFirst(2))
                        
                    }
                    textFieldAnimal = animalBreedChange
                }
                if sireIdTextField.text!.count == 17 {
                    var sireBreedChange = UserDefaults.standard.value(forKey: keyValue.sireIdSaveTemp.rawValue) as! String
                    sireBreedChange = (breeedData.alpha2 ?? "")  + String(sireBreedChange.dropFirst(2))
                    if sireIdTextField.text!.count != 0 {
                        sireIdTextField.text = sireBreedChange
                    }
                }
                
                if damtexfield.text!.count == 17 {
                    var damBreedChange = UserDefaults.standard.value(forKey: keyValue.naabIdSaveTemp.rawValue) as! String
                    damBreedChange = (breeedData.alpha2 ?? "") + String(damBreedChange.dropFirst(2))
                    
                    if damtexfield.text!.count != 0 {
                        damtexfield.text = damBreedChange
                        
                    }
                }
                let codeId = fetchBreedDatabreedCode( entityName: Entities.getBreedsTblEntity,provId: pvid,breedCode:breeedData.alpha2!)
                let naabFetch1 = codeId.value(forKey: keyValue.breedId.rawValue) as? NSArray
                if naabFetch1!.count == 0 {
                } else {
                    let breedIdGet = (naabFetch1![0] as? String)!
                    breedId = breedIdGet
                }
                if borderRedCheck {
                } else {
                    if scanAnimalTagText.tag == 0 {
                        scanAnimalTagText.text! = animalBreedChange
                    }
                    else {
                        farmIdTextField.text! = animalBreedChange
                    }
                }
            }
            buttonbg2.removeFromSuperview()
            
        } else if btnTag == 20  {
            let tissue = self.tissueArr[indexPath.row]  as! GetSampleTbl
            tissuId = Int(tissue.sampleId)
            saveSampleNameandID(sampleNameStr: tissue.sampleName ?? "", sampleID: Int(tissue.sampleId))
            tissueBtnOutlet.setTitle(tissue.sampleName?.localized, for: .normal)
            tissueBtnOutlet.setTitleColor(.black, for: .normal)
            buttonbg2.removeFromSuperview()
        }
        
        else if btnTag == 0 {
            if scanAnimalTagText.tag == 0 {
                scanAnimalTagText.text = filterAdhAnimalData[indexPath.row].animalTag ?? ""
                dataPopulateInFocusChange()
            } else {
                farmIdTextField.text = filterAdhAnimalData[indexPath.row].animalTag ?? ""
            }
            buttonbgAutoSuggestion.removeFromSuperview()
            
        }
        else if btnTag == 1 {
            if scanAnimalTagText.tag == 1 {
                scanAnimalTagText.text = filterAdhAnimalData[indexPath.row].farmId ?? ""
                dataPopulateInFocusChange()
            } else {
                farmIdTextField.text = filterAdhAnimalData[indexPath.row].farmId ?? ""
            }
            buttonbgAutoSuggestion.removeFromSuperview()
        }
        else {
            sireIdTextField.text  = sireNatonIdArray.object(at:indexPath.row) as? String
            autoSuggestionStatus = true
            buttonbgAutoSuggestion.removeFromSuperview()
            sireIdValidationB = false
            sireIdTextField.layer.borderColor = UIColor.gray.cgColor
            self.damtexfield.becomeFirstResponder()
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == AutoSuggestionTableView {
            return 44
        }
        return 44
    }
}

// MARK: - COLLECTIONVIEW DELEGATE AND DATASOURCE
extension DataEntryOrderingAnimalVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setUPCollectionView() {
        self.getBornTypes = fetchBornTypesWithProviderId(entityName: Entities.getBornTypeTblEntity, providerId: pvid)
        self.etBtn = LocalizedStrings.singlesText
        self.selectedBornTypeId = 1
        self.singleBtnAction(UIButton())
        self.bornTypeCollection.delegate = self
        self.bornTypeCollection.dataSource = self
        bornTypeCollection.register(UINib(nibName: ClassIdentifiers.bornTypeCellIdentifier, bundle: Bundle.main), forCellWithReuseIdentifier: ClassIdentifiers.bornTypeCellIdentifier)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.getBornTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassIdentifiers.bornTypeCellIdentifier, for: indexPath) as? BorntTypeCell
        let borntype = self.getBornTypes[indexPath.row]
        cell?.bornTypeLabel.text = borntype.bornTypeName?.localized
        cell?.bornTypeLabel.textColor = UIColor(red: 144/255, green: 144/255, blue: 144/255, alpha: 1)
        if borntype.bornTypeName == LocalizedStrings.singleText
        {
            cell?.bornTypeLabel.text = NSLocalizedString(LocalizedStrings.singleText, comment: "")
        }
        else if borntype.bornTypeName == LocalizedStrings.multipleBirthStr
        {
            cell?.bornTypeLabel.text = NSLocalizedString(LocalizedStrings.multipleBirthStr, comment: "")
        }
        else if borntype.bornTypeName == "ET"
        {
            cell?.bornTypeLabel.text = NSLocalizedString("ET", comment: "")
        }
        else if borntype.bornTypeName == NSLocalizedString(LocalizedStrings.splitEmbryoStr, comment: "")
        {
            cell?.bornTypeLabel.text = NSLocalizedString(LocalizedStrings.splitEmbryoStr, comment: "")
        }
        else if borntype.bornTypeName == LocalizedStrings.cloneText
        {
            cell?.bornTypeLabel.text = NSLocalizedString(LocalizedStrings.cloneText, comment: "")
        }
        else if borntype.bornTypeName == LocalizedStrings.internalStr
        {
            cell?.bornTypeLabel.text = NSLocalizedString(LocalizedStrings.internalStr, comment: "")
        }
        if self.selectedBornTypeId == borntype.bornTypeID && !isGrayField {
            cell?.titleButton.layer.borderWidth = 2
            cell?.titleButton.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        } else {
            cell?.titleButton.layer.borderWidth = 0.5
            cell?.titleButton.layer.borderColor = UIColor.gray.cgColor
        }
        
        if isGrayField {
            cell?.titleButton.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        } else {
            cell?.titleButton.backgroundColor = .white
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.endEditing(true)
        let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.animalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId!)
        if orederStatus.count > 0 {
            barcodeEnable = true
        }
        
        let borntype = self.getBornTypes[indexPath.row]
        
        self.selectedBornTypeId = Int(borntype.bornTypeID)
        
        if let bornTypes = BornTypes(rawValue: indexPath.item) {
            switch bornTypes {
            case .Single:
                self.singleBtnAction(UIButton())
                break
            case .Multiple_Birth:
                self.multiBirthBtnAction(UIButton())
                break
            case .ET:
                self.EtBtnAction(UIButton())
                break
            case .Split_Embryo:
                self.splitEmbryoAction(UIButton())
                break
            case .Clone:
                self.cloneBtnClick(UIButton())
                break
            case .Internal:
                self.internalBtnAction(UIButton())
                break
            }
        }
        UIView.performWithoutAnimation {
            self.bornTypeCollection.reloadData()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3.0
        return CGSize(width: yourWidth-5, height: 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}

// MARK: - FETCH ANIMAL LIST EXTENSION
extension DataEntryOrderingAnimalVC {
    func fetchADHAnimalList(userId: Int, customerID: Int) {
        adhAnimalData.removeAll()
        let specieID = SpeciesID.dairySpeciesId
        let breedID  =  UserDefaults.standard.value(forKey: keyValue.dataEntrybreedId.rawValue) as? String ?? ""
        adhAnimalData = SearchPoint.fetchADHAnimalList(entityName: Entities.animalMasterTblEntity, customerId: customerID, userID: 1, specieID: specieID, breedID: breedID, gender: "F", isADHCart: false) as! [AnimalMaster]
        applySorting()
    }
    
    func applySorting() {
        let sortedArray : [AnimalMaster] = (self.adhAnimalData.sorted(by: {($0.farmId ?? "").localizedStandardCompare($1.farmId ?? "") == .orderedAscending }))
        self.adhAnimalData = sortedArray
    }
    
    func AutoPopulateSuggetion(tag : Int) {
        btnTag = tag
        buttonbgAutoSuggestion.frame = CGRect(x:0,y: 0,width: 1024,height: 1000)
        buttonbgAutoSuggestion.addTarget(self, action:#selector(OrderingAnimalVC.buttonPreddDroperAutosugesstion), for: .touchUpInside)
        buttonbgAutoSuggestion.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        self.view.addSubview(buttonbgAutoSuggestion)
        AutoSuggestionTableView.delegate = self
        AutoSuggestionTableView.dataSource = self
        AutoSuggestionTableView.layer.cornerRadius = 8.0
        AutoSuggestionTableView.layer.borderWidth = 0.5
        AutoSuggestionTableView.layer.borderColor =  UIColor.gray.cgColor
        buttonbgAutoSuggestion.addSubview(AutoSuggestionTableView)
        var yFrame = 0 - self.scrolView.contentOffset.y
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
            case 1334:
                yFrame = 72 - self.scrolView.contentOffset.y
            case 1920, 2208:
                yFrame = 82 - self.scrolView.contentOffset.y
            case 2436:
                yFrame = 100 - self.scrolView.contentOffset.y
            case 2688:
                yFrame = 120 - self.scrolView.contentOffset.y
            case 1792:
                yFrame = 120 - self.scrolView.contentOffset.y
            case 2532:
                yFrame = 120 - self.scrolView.contentOffset.y
            case 2340:
                yFrame = 100 - self.scrolView.contentOffset.y
            case 2778, 2556:
                yFrame = 120 - self.scrolView.contentOffset.y
            default:
                yFrame = 72 - self.scrolView.contentOffset.y
            }
        }
        if tag == 0 {
            if scanAnimalTagText.tag == 1{
                AutoSuggestionTableView.frame = CGRect(x: 20,y: yFrame + 160,width: self.view.frame.width-40,height: 200)
            } else {
                AutoSuggestionTableView.frame = CGRect(x: 20,y: yFrame + 102,width: self.view.frame.width-40,height: 200)
            }
        } else {
            if scanAnimalTagText.tag == 0{
                AutoSuggestionTableView.frame = CGRect(x: 20,y: yFrame + 160,width: self.view.frame.width-40,height: 200)
            } else {
                AutoSuggestionTableView.frame = CGRect(x: 20,y: yFrame + 102,width: self.view.frame.width-40,height: 200)
            }
        }
        if filterAdhAnimalData.count == 0 {
            AutoSuggestionTableView.isHidden = true
            buttonbgAutoSuggestion.removeFromSuperview()
        }
        else{
            AutoSuggestionTableView.isHidden = false
            AutoSuggestionTableView.reloadData()
        }}
}

// MARK: - QR SCANNER PROTOCOL EXTENSION
extension DataEntryOrderingAnimalVC: QrScannerProtocol {
    func qrCodeScannedResult(_ qrValue: String) {
        let currentOfficialId = farmIdTextField.text
        if currentOfficialId == qrValue {
            barcodeView.layer.borderColor = UIColor.red.cgColor
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sampleBarcodeNotSame, comment: ""))
        } else {
            scanBarcodeText.text = qrValue
        }
    }
}

// MARK: - SCANNED OCR PROTOCOL EXTENSION
extension DataEntryOrderingAnimalVC: scannedOCRProtocol {
    func ocrDetected(_ scannedResult: String) {
        if farmIdTextField.tag == 0 {
            farmIdTextField.text = scannedResult
            farmIdTextField.becomeFirstResponder()
        } else {
            scanAnimalTagText.text = scannedResult
            scanAnimalTagText.becomeFirstResponder()
        }
        textFieldBackroungWhite()
    }
}

// MARK: - SAVE SAMPLE NAME AND ID EXTENSION
extension DataEntryOrderingAnimalVC {
    func saveSampleNameandID (sampleNameStr: String, sampleID :Int) {
        if sampleID == 0 {
            let filterTissueArray  = tissueArr.filter{($0 as! GetSampleTbl).sampleName == sampleNameStr}
            if filterTissueArray.count > 0 {
                self.sampleID = Int((filterTissueArray[0] as! GetSampleTbl).sampleId)
                self.sampleName = (filterTissueArray[0] as! GetSampleTbl).sampleName ?? ""
            }
        } else {
            let filterTissueArray  = tissueArr.filter{($0 as! GetSampleTbl).sampleId == sampleID}
            if filterTissueArray.count > 0 {
                self.sampleID = Int((filterTissueArray[0] as! GetSampleTbl).sampleId)
                self.sampleName = (filterTissueArray[0] as! GetSampleTbl).sampleName ?? ""
            }
        }
    }
}

// MARK: - OFFLINE CUSTOM VIEW EXTENSION
extension DataEntryOrderingAnimalVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }}

// MARK: - SIDE MENU UI AND RFID EXTENSION EXTENSION
extension DataEntryOrderingAnimalVC : SideMenuUI,RFID,nearByDevice{
    func rfidCode(rfid: String) {
        if UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue {
        } else {
            farmIdTextField.text?.removeAll()
            if defaltscreen == keyValue.farmId.rawValue{
                if farmIdTextField.isEnabled {
                    farmIdTextField.text = breedBtnOutlet.titleLabel!.text! + rfid
                    farmIdTextField.text = farmIdTextField.text!.trimmingCharacters(in: CharacterSet.whitespaces)
                    dataPopulateInFocusChange()
                    textFieldBackroungWhite()
                }
            } else {
                if scanAnimalTagText.isEnabled {
                    scanAnimalTagText.becomeFirstResponder()
                    scanAnimalTagText.text = breedBtnOutlet.titleLabel!.text! + rfid
                    scanAnimalTagText.text = scanAnimalTagText.text!.trimmingCharacters(in: CharacterSet.whitespaces)
                    dataPopulateInFocusChange()
                    textFieldBackroungWhite()
                }
            }
        }}
    
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
    
    func deviceNear(deviceName : [CBPeripheral]){
        arrNearbyDevice = deviceName
    }
}

// MARK: - IMAGE PICKER CONTROLLER DELEGATE AND NAVIGATION EXTENSION
extension DataEntryOrderingAnimalVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true, completion: nil)
        startAnimating()
        if self.scanAnimalTagText.tag == 0 {
            self.scanAnimalTagText.text = ""
            
        } else  {
            self.farmIdTextField.text = ""
        }
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        self.imageView.image = image
        setVisionTextRecognizeImage(image: image)
    }
}

// MARK: - OFFLINE CUSTOM VIEW1 EXTENSION
extension DataEntryOrderingAnimalVC: offlineCustomView1 {
    func crossBtn() {
        buttonbg1.removeFromSuperview()
        customPopView1.removeFromSuperview()
    }
}

// MARK: - OBJECT PICK CART EXTENSION
extension DataEntryOrderingAnimalVC : objectPickCartScreen {
    func objectGetOnSelection(temp: Int) {
        
    }
}
