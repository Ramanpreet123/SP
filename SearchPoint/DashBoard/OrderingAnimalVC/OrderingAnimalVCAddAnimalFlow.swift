//
//  OrderingAnimalVCAddAnimalFlow.swift
//  SearchPoint
//
//  Created by Mobile Programming on 22/03/24.
//

import Foundation
import UIKit

//MARK: ADD ANIMAL FULL FLOW
extension OrderingAnimalVC {
  //func validateBreedProductselection(completionHandler: @escaping CompletionHandler)
//  {
//    let breedidd =  UserDefaults.standard.value(forKey: keyValue.breed.rawValue) as? String
//    let getbreedname = fetchbreedname(entityName: Entities.getBreedsTblEntity, breedid: self.breedId)
//    let animalData = fetchAnimaldataDairy(entityName: Entities.animalAddTblEntity, animalTag:animalId1,orderId:orderId,userId:userId)
//    if breedChanged {
//      let alert = UIAlertController(title: NSLocalizedString("", comment: ""), message: NSLocalizedString(LocalizedStrings.changeBreedClearProduct, comment: ""), preferredStyle: .alert)
//      
//      alert.addAction(UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: .default, handler: { (_) in
//        return completionHandler(false)
//      }))
//      alert.addAction(UIAlertAction(title: "YES".localized, style: .default, handler: { (_) in
//        let animalId = animalData.object(at: 0) as! AnimaladdTbl
//        deleteDataWithProduct(Int(animalId.animalId))
//        deleteDataWithSubProduct(Int(animalId.animalId))
//        let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
//        let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: pvid, breedId: self.breedId )
//        for k in 0 ..< animalData.count  {
//          
//          let animalId = animalData[k] as! AnimaladdTbl
//          
//          for i in 0 ..< product.count{
//            
//            let data = product[i] as! GetProductTbl
//            if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
//              let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.autoD,customerID: self.custmerId)
//              if data12333.count > 0 {
//                let adonDat =  fetchProductAdonDataWithBVDV(entityName: Entities.getAdonTblEntity, prodId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue),adonId : LocalizedStrings.bvdvAddOnId)
//                if adonDat.count > 0 {
//                  saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: self.farmIdText, orderId: Int(animalId.orderId), orderStatus: "false", isSync: "false", userId: self.userId,udid:animalId.udid ?? "", animalId: Int(animalId.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "", custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
//                  
//                  updateOrderStatusAnimal(entity: Entities.animalAddTblEntity, status: "true", orderId: Int(animalId.orderId), userId: self.userId, animalId:  Int(animalId.animalId))
//                }
//              }
//              else {
//                saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: self.farmIdText, orderId: Int(animalId.orderId), orderStatus: "false", isSync: "false", userId: self.userId,udid:animalId.udid ?? "", animalId: Int(animalId.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
//              }
//              
//            }
//            else {
//              saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId! , productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: self.farmIdText, orderId: Int(animalId.orderId), orderStatus: "false", isSync: "false", userId: self.userId,udid:animalId.udid ?? "", animalId: Int(animalId.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
//            }
//            if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
//              self.addonArr = fetchProductAdonData(entityName : Entities.getAdonTblEntity,prodId: Int(data.productId),isCdcbProduct:false)
//              
//            } else {
//              
//              self.addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
//            }
//            
//            for j in 0 ..< self.addonArr.count {
//              
//              let addonDat = self.addonArr[j] as! GetAdonTbl
//              if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
//                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.autoD,customerID: self.custmerId)
//                if data12333.count > 0 {
//                  if Int(addonDat.adonId) == 1 {
//                    saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: Int(animalId.orderId), orderStatus: "false", isSync: "false", userId: self.userId,udid:animalId.udid ?? "", farmId: self.farmIdText, animalId: Int(animalId.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
//                    updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue), status: "true")
//                  }
//                  else {
//                    saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(animalId.orderId), orderStatus: "false", isSync: "false", userId: self.userId,udid:animalId.udid ?? "", farmId: self.farmIdText, animalId: Int(animalId.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
//                  }
//                  
//                }
//              }
//              else {
//                saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(animalId.orderId), orderStatus: "false", isSync: "false", userId: self.userId,udid:animalId.udid ?? "", farmId: self.farmIdText, animalId: Int(animalId.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
//                
//              }
//            }
//            
//            
//          }
//        }
//                let  aDat = fetchAllData(entityName: Entities.animalAddTblEntity)
//                if aDat.count > 0{
//                  UserDefaults.standard.set(true, forKey: keyValue.identifyStore.rawValue)
//                }
//        
//            let breedDataArray = self.breedArr as! [GetBreedsTbl]
//           let breeedData : [GetBreedsTbl] = breedDataArray.filter{ $0.breedId ==  self.breedId}
//                UserDefaults.standard.set(self.breedId, forKey: keyValue.breed.rawValue)
//                self.breedBtnOutlet.setTitleColor(.black, for: .normal)
//        
//                if breeedData.breedId == "1f263617-923b-450f-825b-1489bfb42d7f" && breeedData.alpha2?.isEmpty == true {
//                  self.breedBtnOutlet.setTitle("BF", for: .normal)
//                  UserDefaults.standard.set("BF", forKey: keyValue.capsBreedName.rawValue)
//        
//                } else {
//                  let breestr = breeedData.alpha2 ?? ""
//                  print(breestr)
//                  let stri = UserDefaults.standard.value(forKey: keyValue.selectAnimalId.rawValue) as? String ?? ""
//                  print(stri.prefix(2))
//        
//                  if (breestr == stri.prefix(2)) || self.farmIdTextField.text == "" {
//                    self.breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
//                  }
//                  else{
//                    let alert = UIAlertController(title: NSLocalizedString("", comment: ""), message: NSLocalizedString(LocalizedStrings.selectedDiffBreed, comment: ""), preferredStyle: .alert)
//        
//                    alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { (_) in
//                      self.breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
//                    }))
//        
//        
//                    alert.addAction(UIAlertAction(title: "NO", style: .default, handler: { (_) in
//                      self.breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
//                      UserDefaults.standard.set(breeedData.alpha2, forKey: keyValue.capsBreedName.rawValue)
//                      var animalBreedChange = UserDefaults.standard.value(forKey: keyValue.selectAnimalId.rawValue) as? String ?? ""
//                      if animalBreedChange.count == 17 {
//                        if breeedData.alpha2! == "" {
//                          animalBreedChange = "BF" + String(animalBreedChange.dropFirst(2))
//        
//                        } else {
//                          animalBreedChange = breeedData.alpha2! + String(animalBreedChange.dropFirst(2))
//        
//                        }
//                        UserDefaults.standard.set(animalBreedChange, forKey: keyValue.selectAnimalId.rawValue)
//                        self.textFieldAnimal = animalBreedChange
//                        if self.scanAnimalTagText.tag == 0 {
//                          self.scanAnimalTagText.text! = animalBreedChange
//                        }
//                        else {
//        
//                          self.farmIdTextField.text! = animalBreedChange
//                        }
//                      }
//                    }))
//                    self.present(alert, animated: true, completion: nil)
//        
//                  }
//                }
//        
//                let animalBreedChange = UserDefaults.standard.value(forKey: keyValue.selectAnimalId.rawValue) as? String ?? ""
//                let codeId = fetchBreedDatabreedCode( entityName: Entities.getBreedsTblEntity,provId: pvid,breedCode:breeedData.alpha2!)
//                let naabFetch1 = codeId.value(forKey: keyValue.breedId.rawValue) as? NSArray
//        
//                if naabFetch1!.count != 0 {
//                  let breedIdGet = (naabFetch1![0] as? String)!
//                  self.breedId = breedIdGet
//                }
//        
//                if self.borderRedCheck != true{
//                  if self.scanAnimalTagText.tag == 0 {
//                    self.scanAnimalTagText.text! = animalBreedChange
//                  }
//                  else {
//                    self.farmIdTextField.text! = animalBreedChange
//                  }
//                }
//        return completionHandler(true)
//      }))
//      self.present(alert, animated: true, completion: nil)
//      
//      
//    }
//    return completionHandler(true)
//  }
  //MARK: ADD ANIMAL BUTTON
  func addAnimalBtn_raman(completionHandler: @escaping CompletionHandler){
//    self.validateBreedProductselection(completionHandler: { [self]  (success) -> Void in
//      if success == true{
     
        if self.matchedBarcodeBtnOutlet.isSelected {
          UserDefaults.standard.setValue(true, forKey: keyValue.matchedBarcodeFlag.rawValue)
        }
        if self.barcodefixed == true{
          UserDefaults.standard.setValue(true, forKey: keyValue.matchedBarcodeFlag.rawValue)
        }
        if self.fetchrecord == true{
          self.fetchrecord = false
          let newcheck = fetchAllDataOrdercheckfarmid(entityName: Entities.animalMasterTblEntity, ordestatus: "true", farmid: self.onfarmidtext ,userId: self.userId)
          let newcheck2 = fetchAllDataOrdercheckfarmid(entityName: Entities.animalMasterTblEntity, ordestatus: "false", farmid: self.onfarmidtext ,userId: self.userId)
          let newcheck1 = fetchAllDataOrdercheckfarmid(entityName: Entities.animalAddTblEntity, ordestatus: "false", farmid: self.onfarmidtext ,userId: self.userId)
          
          if newcheck.count > 0{
            let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.matchedPreviousOnFarmId, comment: ""), preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString(LocalizedStrings.overWriteText, comment: ""), style: .default, handler: { [self]  (_) in
              CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyUsedStr, comment: ""))
              self.fetchrecord = true
            }))
            alert.addAction(UIAlertAction(title: LocalizedStrings.retrieveText, style: .default, handler: { (_) in
              self.fetchrecord = false
              self.dataPopulateInFocusChange()
            }))
            alert.addAction(UIAlertAction(title: "Cancel".localized, style: .default, handler: { (_) in
              self.fetchrecord = true
            }))
            self.present(alert, animated: true, completion: nil)
            return
            
          }
          
          else if newcheck1.count > 0 || newcheck2.count > 0{
            let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.matchedPreviousOnFarmId, comment: ""), preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString(LocalizedStrings.overWriteText, comment: ""), style: .default, handler: { [self]  (_) in
              self.fetchrecord = false
              
              if self.screentext == keyValue.officialId.rawValue{
                if newcheck1.count > 0{
                  let newvalue1 = newcheck1.object(at: 0) as? AnimaladdTbl
                  self.isoverride  =  true
                  self.saveanimalID = newvalue1?.animalId ??  0
                  self.checkofsaveanimalid = true
                  self.newfarmid = newvalue1?.farmId ?? ""
                  self.newtextfieldfarmid = self.farmIdTextField.text ?? ""
                  print(self.newfarmid)
                  if self.isoverride == true{
                    self.farmIdTextField.text = self.newfarmid
                  }
                }
                else if newcheck2.count > 0{
                  let newvalue2 = newcheck2.object(at: 0) as? AnimalMaster
                  self.isoverride  =  true
                  self.saveanimalID = newvalue2?.animalId ??  0
                  self.checkofsaveanimalid = true
                  self.newfarmid = newvalue2?.farmId ?? ""
                  self.newtextfieldfarmid = self.farmIdTextField.text ?? ""
                  print(self.newfarmid)
                  if self.isoverride == true{
                    self.farmIdTextField.text = self.newfarmid
                  }
                }
              }
              else{
                if newcheck1.count > 0{
                  let newvalue1 = newcheck1.object(at: 0) as? AnimaladdTbl
                  self.isoverride  =  true
                  self.newfarmid = newvalue1?.farmId ?? ""
                  self.newtextfieldfarmid = self.scanAnimalTagText.text ?? ""
                  print(self.newfarmid)
                  if self.isoverride == true{
                    self.scanAnimalTagText.text = self.newfarmid
                  }
                }
                else if newcheck2.count > 0{
                  let newvalue2 = newcheck2.object(at: 0) as? AnimalMaster
                  self.isoverride  =  true
                  self.newfarmid = newvalue2?.farmId ?? ""
                  self.newtextfieldfarmid = self.scanAnimalTagText.text ?? ""
                  print(self.newfarmid)
                  if self.isoverride == true{
                    self.scanAnimalTagText.text = self.newfarmid
                  }
                }
              }
              
              if self.siraidcheck == true{
                self.sireIdTextField.layer.borderColor = UIColor.red.cgColor
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(LocalizedStrings.sireIDShouldBeDiff, comment: ""))
                self.siraidcheck = false
                self.sireIdTextField.becomeFirstResponder()
                return
              }
              
              if self.barcodeEnable == true {
                let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.animalMasterTblEntity, animalId: self.idAnimal,orderststus:"true", customerId: self.custmerId)
                if orederStatus.count > 0 {
                  let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalAlreadyUsedStr, comment: ""), preferredStyle: .alert)
                  
                  let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.animalMasterTblEntity, animalId: self.idAnimal, customerID: self.custmerId)
                    self.autoPop(animalData: animalFetch)
                    self.barcodeEnable = false
                  }
                  alertController.addAction(okAction)
                  self.present(alertController, animated: true, completion: nil)
                  self.statusOrder = false
                  self.scrolView.contentOffset.y = 0.0
                  return
                }
              }
              
              if self.farmIDBoolEntryTag == true {
                let bbb =  fetchAnimaldataValidateAnimalBarcodetag(entityName: Entities.animalAddTblEntity,animalbarCodeTag:self.scanAnimalTagText.text ?? "",orderId: self.orderId, userId: self.userId, custmerId: custmerId)
                
                if bbb.count != 0 &&  self.dataAutoPopulatedBool == true{
                  self.farmIDBoolEntry = true
                  self.officalTagView.layer.borderColor = UIColor.red.cgColor
                  CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.duplicateEntryStr, comment: ""))
                  return
                }
              }
              
              if self.farmIDBoolEntry == true {
                let bbb =  fetchAnimaldataValidateAnimalBarcodetag(entityName: Entities.animalAddTblEntity,animalbarCodeTag:self.farmIdTextField.text ?? "",orderId: self.orderId, userId: self.userId, custmerId: custmerId)
                
                if bbb.count != 0 &&  self.dataAutoPopulatedBool == true{
                  self.farmIDBoolEntry = true
                  self.farmIdView.layer.borderColor = UIColor.red.cgColor
                  CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.duplicateEntryStr, comment: ""))
                  return
                }
              }
              
              if self.farmIDBoolEntrySecond == true {
                let animalTag1 = fetchAnimaldataValidateFamID(entityName: Entities.animalMasterTblEntity,farmId:self.scanAnimalTagText.text ?? "",custmerId: self.custmerId , userId: self.userId, animalId: Int64(self.animalId1))
                if animalTag1.count != 0 &&  self.dataAutoPopulatedBool == true{
                  self.farmIDBoolEntrySecond = true
                  self.officalTagView.layer.borderColor = UIColor.red.cgColor
                  CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.duplicateEntryStr, comment: ""))
                  return
                }
              }
              let valueCheck = self.dateBtnOutlet.titleLabel?.text
              
              if valueCheck!.count != 0{
                self.dateBtnOutlet.layer.borderColor = UIColor.gray.cgColor
                self.calenderDobView.layer.borderColor = UIColor.gray.cgColor
                
              }
              if self.damtexfield.text!.count == 0 {
                self.damtexfield.layer.borderColor = UIColor.gray.cgColor
              }
              if self.sireIdTextField.text!.count == 0 {
                self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
              }
              if self.scanBarcodeText.text!.count == 0 {
                self.barcodeView.layer.borderColor = UIColor.gray.cgColor
              }
              if self.validateDateFlag == false || self.dateTextField.text?.count != 10{
                
                if self.dateTextField.text?.count == 10 {
                  let validate = self.isValidDate(dateString: self.dateTextField.text ?? "")
                  
                  if validate == LocalizedStrings.correctFormatStr {
                    self.dateBtnOutlet.layer.borderColor = UIColor.gray.cgColor
                    self.dateBtnOutlet.layer.borderWidth = 0.5
                    self.validateDateFlag = true
                  } else {
                    self.dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
                    self.validateDateFlag = false
                    
                    if validate == LocalizedStrings.greaterThenDateStr {
                      CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.dobSmallerthanCurrDate, comment: ""))
                      return
                    } else {
                      CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
                      return
                    }
                    return
                    
                  }
                } 
                  else if self.dateTextField.text == "" {
                  }
                  else {
                  self.dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
                  self.validateDateFlag = false
                  CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
                  return
                }
              }
              
              if self.statusOrder == true {
                self.msgAnimalSucess = true
                let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.animalMasterTblEntity, animalId: self.idAnimal, customerID: self.custmerId)
                if animalFetch.count > 0{
                  self.editIngText = true
                }
              }
              
              if self.scanAnimalTagText.tag == 1{
                if self.scanAnimalTagText.text == "" || self.scanBarcodeText.text == ""  {
                  
                  if self.scanAnimalTagText.text!.count == 0 {
                    self.officalTagView.layer.borderColor = UIColor.red.cgColor
                  } else {
                    self.officalTagView.layer.borderColor = UIColor.gray.cgColor
                    self.scanAnimalTagText.textColor = UIColor.black
                  }
                  
                  if self.scanBarcodeText.text!.count == 0 {
                    self.barcodeView.layer.borderColor = UIColor.red.cgColor
                    self.scanBarcodeText.textColor = UIColor.red
                  } else {
                    self.barcodeView.layer.borderColor = UIColor.gray.cgColor
                    self.scanBarcodeText.textColor = UIColor.black
                  }
                  
                  if self.damtexfield.text!.count == 0 {
                    self.damtexfield.layer.borderColor = UIColor.gray.cgColor
                  }
                  
                  if self.sireIdTextField.text!.count == 0 {
                    self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                  }
                  
                  if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == "True" {
                    if self.farmIdTextField.text?.count == 0 && !isCheckCountryUK() {
                      self.farmIdView.layer.borderColor = UIColor.red.cgColor
                    } else if self.farmIdTextField.text?.count == 17 {
                      
                    }else {
                      self.borderRedCheck = true
                    }
                    
                  } else {
                    if self.farmIdTextField.text?.count == 0 {
                      self.farmIdView.layer.borderColor = UIColor.gray.cgColor
                    }
                  }
                  
                  CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                  return
                  
                } else {
                  self.officalTagView.layer.borderColor = UIColor.gray.cgColor
                  self.scanAnimalTagText.textColor = UIColor.black
                  self.barcodeView.layer.borderColor = UIColor.gray.cgColor
                  self.scanBarcodeText.textColor = UIColor.black
                  
                  if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == "True" {
                    if self.farmIdTextField.text?.count == 0 && !isCheckCountryUK(){
                      self.farmIdView.layer.borderColor = UIColor.red.cgColor
                      CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                      return
                      
                    } else if self.farmIdTextField.text?.count == 17 {} else {
                      self.borderRedCheck = true
                    }
                    
                  } else {
                    if self.farmIdTextField.text?.count == 0 {
                      self.farmIdView.layer.borderColor = UIColor.gray.cgColor
                      self.borderRedCheck = false
                    } else if self.farmIdTextField.text?.count == 17 {} else {
                      self.borderRedCheck = true
                    }
                  }
                  
                  if self.sireIdTextField.text?.count != 0 || self.damtexfield.text?.count != 0 {
                    if self.sireIdTextField.text!.count == 0 {
                      self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                    }
                    if self.damtexfield.text!.count == 0 {
                      self.damtexfield.layer.borderColor = UIColor.gray.cgColor
                    }
                    
                    if self.sireIdTextField.text?.count == 0{
                      self.sireIdValidationB = false
                    }
                    
                    if self.damtexfield.text?.count == 0{
                      self.damIdValidationB = false
                    }
                    
                    if self.ausBullId.contains(self.sireIdTextField.text?.uppercased() as Any) || self.sireNationalID.contains(self.sireIdTextField.text?.uppercased() as Any){
                      self.sireIdValidationB = false
                    }
                    
                    if self.borderRedCheck == true || self.damIdValidationB == true || self.sireIdValidationB == true  {
                      
                      if self.sireIdTextField.text?.count != 0{
                        if self.sireIdValidationB  == true {
                          if self.pvid == 3 {
                            if self.ausBullId.contains(self.sireIdTextField.text?.uppercased() as Any) || self.sireNationalID.contains(self.sireIdTextField.text?.uppercased() as Any){
                              
                            } else {
                              self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                              return
                            }
                          } else {
                            self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                            return
                          }
                          
                        } else{
                          if self.sireIdTextField.text?.count == 17 {
                          }
                          else {
                            if self.autoSuggestionStatus == true {
                            }
                            else {
                              if self.pvid == 3 {
                                
                              }
                              else {
                                self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                                return
                              }
                            }
                          }
                        }
                      } else {
                        self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                      }
                      
                      if self.damtexfield.text?.count != 0{
                        if self.damIdValidationB  == true {
                          if self.pvid != 3 {
                            self.validationId17SireDam(animalId: self.damtexfield.text!, tag: 4)
                            return
                          }
                        }else {
                          if self.damtexfield.text?.count == 17 {
                          }
                          else {
                            if self.pvid != 3 {
                              self.validationId17SireDam(animalId: self.damtexfield.text!, tag: 4)
                              return
                            }
                          }
                        }
                      } else {
                        self.damtexfield.layer.borderColor = UIColor.gray.cgColor
                      }
                      
                      if self.borderRedCheck == true {
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalIDStr, comment: ""), duration: 2, position: .top)
                        self.farmIdView.layer.borderColor = UIColor.red.cgColor
                      }
                      
                      return
                    }
                  } else {
                    self.damtexfield.layer.borderColor = UIColor.gray.cgColor
                    self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                  }
                  
                  
                  if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String != "True" {
                    if self.farmIdTextField.text!.count == 0 {
                      self.borderRedCheck = false
                    }
                  }
                  if self.sireIdTextField.text?.count == 17  || self.sireIdTextField.text?.count == 0{
                  }
                  else{
                    if self.autoSuggestionStatus == true {
                    }
                    else {
                      if self.pvid == 3 {
                      }
                      else {
                        self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                        return
                      }
                    }
                  }
                  if self.damtexfield.text?.count == 17  || self.damtexfield.text?.count == 0{
                  }
                  else{
                    if self.pvid != 3 {
                      self.validationId17SireDam(animalId: self.damtexfield.text!, tag: 4)
                      return
                    }
                  }
                  
                  if self.borderRedCheck == false {
                    self.addBtnCondtion(completionHandler: { (success) -> Void in
                      if success == true{
                        self.borderRedCheck = true
                        completionHandler(true)
                        
                      }
                    })
                    
                  } else {
                    if self.farmIdTextField.text?.count == 0 && !isCheckCountryUK() {
                      self.farmIdView.layer.borderColor = UIColor.red.cgColor
                      CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                      
                      return
                    } else  {
                      self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalIDStr, comment: ""), duration: 2, position: .top)
                      self.farmIdView.layer.borderColor = UIColor.red.cgColor
                      return
                    }
                  }
                }
              } else {
                // change button postion
                if self.scanBarcodeText.text == "" || self.scanAnimalTagText.text == "" {
                  if self.scanAnimalTagText.text!.count == 0 {
                    self.officalTagView.layer.borderColor = UIColor.red.cgColor
                  } else {
                    self.officalTagView.layer.borderColor = UIColor.gray.cgColor
                    self.scanAnimalTagText.textColor = UIColor.black
                  }
                  if self.scanBarcodeText.text!.count == 0 {
                    self.barcodeView.layer.borderColor = UIColor.red.cgColor
                    self.scanBarcodeText.textColor = UIColor.red
                  } else {
                    self.barcodeView.layer.borderColor = UIColor.gray.cgColor
                    self.scanBarcodeText.textColor = UIColor.black
                  }
                  
                  CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                  completionHandler(false)
                  return
                } else {
                  self.officalTagView.layer.borderColor = UIColor.gray.cgColor
                  self.scanAnimalTagText.textColor = UIColor.black
                  self.barcodeView.layer.borderColor = UIColor.gray.cgColor
                  self.scanBarcodeText.textColor = UIColor.black
                  
                  if self.sireIdTextField.text?.count != 0 || self.damtexfield.text?.count != 0 {
                    if self.sireIdTextField.text!.count == 0 {
                      self.sireIdValidationB = false
                      self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                    }
                    if self.damtexfield.text!.count == 0 {
                      self.damIdValidationB = false
                      self.damtexfield.layer.borderColor = UIColor.gray.cgColor
                    }
                    
                    if self.ausBullId.contains(self.sireIdTextField.text?.uppercased() as Any) || self.sireNationalID.contains(self.sireIdTextField.text?.uppercased() as Any){
                      self.sireIdValidationB = false
                    }
                    
                    if self.borderRedCheck == true || self.damIdValidationB == true || self.sireIdValidationB == true  {
                      
                      if self.sireIdTextField.text?.count != 0{
                        if self.sireIdValidationB  == true {
                          if self.autoSuggestionStatus == true {
                          }
                          else {
                            if self.pvid == 3 {
                              self.sireIdTextField.layer.borderColor = UIColor.red.cgColor
                              CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.bullIdDoesNotExist, comment: ""))
                              return
                            } else {
                              self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                              return
                            }
                          }
                        }
                      } else {
                        self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                      }
                      
                      if self.damtexfield.text?.count != 0{
                        if self.damIdValidationB  == true {
                          if self.pvid != 3 {
                            self.validationId17SireDam(animalId: self.damtexfield.text!, tag: 4)
                            return
                          }
                        }
                      } else {
                        self.damtexfield.layer.borderColor = UIColor.gray.cgColor
                      }
                      if self.borderRedCheck == true {
                        self.officalTagView.layer.borderColor = UIColor.red.cgColor
                        self.view.makeToast( NSLocalizedString(LocalizedStrings.invalidAnimalIDStr, comment: ""), duration: 2, position: .top)
                      }
                      return
                    }
                  }
                  
                  if self.scanAnimalTagText.text?.count != 17 {
                    self.borderRedCheck = true
                  }
                  
                  if self.borderRedCheck == true {
                    self.officalTagView.layer.borderColor = UIColor.red.cgColor
                    self.view.makeToast( NSLocalizedString(LocalizedStrings.invalidAnimalIDStr, comment: ""), duration: 2, position: .top)
                    return
                  } else {
                    if self.sireIdTextField.text?.count == 17  || self.sireIdTextField.text?.count == 0{
                      
                    } else {
                      if self.autoSuggestionStatus == true {
                      }
                      else {
                        if self.autoSuggestionStatus == true {
                        }
                        else{
                          if self.pvid == 3 {
                          }
                          else {
                            self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                            return
                          }
                        }
                      }
                    }
                    if self.damtexfield.text?.count == 17  || self.damtexfield.text?.count == 0{
                      
                    } else {
                      if self.pvid != 3 {
                        self.validationId17SireDam(animalId: self.damtexfield.text!, tag: 4)
                        return
                      }
                      
                    }
                    
                    self.addBtnCondtion(completionHandler: { (success) -> Void in
                      if success == true{
                        self.borderRedCheck = true
                        completionHandler(true)
                        
                      }
                    })
                  }
                }
              }
              
              if self.notificationLblCount.text != "0"{
                self.countLbl.isHidden = false
                self.notificationLblCount.isHidden = false
              }
            }))
            
            alert.addAction(UIAlertAction(title: LocalizedStrings.retrieveText, style: .default, handler: { (_) in
              self.fetchrecord = false
              self.dataPopulateInFocusChange()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
              self.fetchrecord = true
            }))
            self.present(alert, animated: true, completion: nil)
            return
          }
          
        }
        
        if self.mainrecord == true{
          self.mainrecord = false
          let newcheck = fetchAllDataOrdercheck(entityName: Entities.animalMasterTblEntity, ordestatus: "true", animalTag:self.newanimaltagvalue ,userId: self.userId, animalBarcode: self.scanBarcodeText.text ?? "")
          let newcheck2 = fetchAllDataOrdercheck(entityName: Entities.animalMasterTblEntity, ordestatus: "false", animalTag:self.newanimaltagvalue ,userId: self.userId, animalBarcode: self.scanBarcodeText.text ?? "")
          let newcheck1 = fetchAllDataOrdercheck(entityName: Entities.animalAddTblEntity, ordestatus: "false", animalTag:self.newanimaltagvalue ,userId: self.userId, animalBarcode: self.scanBarcodeText.text ?? "")
          
          if newcheck.count > 0{
            let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.matchedPreviousOfficialID, comment: ""), preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString(LocalizedStrings.overWriteText, comment: ""), style: .default, handler: { [self]  (_) in
              CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyUsedStr, comment: ""))
              self.mainrecord = true
            }))
            alert.addAction(UIAlertAction(title: LocalizedStrings.retrieveText, style: .default, handler: { (_) in
              self.mainrecord = false
              self.dataPopulateInFocusChange()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
              self.mainrecord = true
            }))
            self.present(alert, animated: true, completion: nil)
            return
          }
          
          else if newcheck1.count > 0 || newcheck2.count > 0 {
            let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.matchedPreviousOfficialID, comment: ""), preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString(LocalizedStrings.overWriteText, comment: ""), style: .default, handler: {  (_) in
              
              if self.screentext == keyValue.officialId.rawValue{
                if newcheck1.count > 0{
                  let newvalue1 = newcheck1.object(at: 0) as? AnimaladdTbl
                  self.isoverride  =  true
                  self.saveanimalID = newvalue1?.animalId ??  0
                  self.checkofsaveanimalid = true
                  self.newfarmid = newvalue1?.farmId ?? ""
                  self.newtextfieldfarmid = self.farmIdTextField.text ?? ""
                  if self.isoverride == true{
                    self.farmIdTextField.text = self.newfarmid
                  }
                }
                else if newcheck2.count > 0{
                  let newvalue2 = newcheck2.object(at: 0) as? AnimalMaster
                  self.isoverride  =  true
                  self.saveanimalID = newvalue2?.animalId ??  0
                  self.checkofsaveanimalid = true
                  self.newfarmid = newvalue2?.farmId ?? ""
                  self.newtextfieldfarmid = self.farmIdTextField.text ?? ""
                  if self.isoverride == true{
                    self.farmIdTextField.text = self.newfarmid
                    
                  }
                }
              }
              else{
                self.farmIdView.layer.borderColor = UIColor.gray.cgColor
                if newcheck1.count > 0
                {
                  let newvalue1 = newcheck1.object(at: 0) as? AnimaladdTbl
                  self.isoverride  =  true
                  self.newfarmid = newvalue1?.farmId ?? ""
                  self.newtextfieldfarmid = self.scanAnimalTagText.text ?? ""
                  print(self.newfarmid)
                  if self.isoverride == true{
                    self.scanAnimalTagText.text = self.newfarmid
                  }
                }
                else if newcheck2.count > 0{
                  let newvalue2 = newcheck2.object(at: 0) as? AnimalMaster
                  self.isoverride  =  true
                  self.newfarmid = newvalue2?.farmId ?? ""
                  self.newtextfieldfarmid = self.scanAnimalTagText.text ?? ""
                  if self.isoverride == true{
                    self.scanAnimalTagText.text = self.newfarmid
                  }
                }
              }
              
              if self.siraidcheck == true{
                self.sireIdTextField.layer.borderColor = UIColor.red.cgColor
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(LocalizedStrings.sireIDShouldBeDiff, comment: ""))
                self.siraidcheck = false
                self.sireIdTextField.becomeFirstResponder()
                return
              }
              
              if self.barcodeEnable == true {
                let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.animalMasterTblEntity, animalId: self.idAnimal,orderststus:"true", customerId: self.custmerId)
                if orederStatus.count > 0 {
                  let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalAlreadyUsedStr, comment: ""), preferredStyle: .alert)
                  
                  let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.animalMasterTblEntity, animalId: self.idAnimal, customerID: self.custmerId)
                    self.autoPop(animalData: animalFetch)
                    self.barcodeEnable = false
                  }
                  alertController.addAction(okAction)
                  self.present(alertController, animated: true, completion: nil)
                  self.statusOrder = false
                  self.scrolView.contentOffset.y = 0.0
                  return
                }
              }
              
              if self.farmIDBoolEntryTag == true {
                let bbb =  fetchAnimaldataValidateAnimalBarcodetag(entityName: Entities.animalAddTblEntity,animalbarCodeTag:self.scanAnimalTagText.text ?? "",orderId: self.orderId, userId: self.userId,custmerId: self.custmerId)
                
                if bbb.count != 0 &&  self.dataAutoPopulatedBool == true{
                  self.farmIDBoolEntry = true
                  self.officalTagView.layer.borderColor = UIColor.red.cgColor
                  CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.duplicateEntryStr, comment: ""))
                  return
                }
                
                
              }
              if self.farmIDBoolEntry == true {
                let bbb =  fetchAnimaldataValidateAnimalBarcodetag(entityName: Entities.animalAddTblEntity,animalbarCodeTag:self.farmIdTextField.text ?? "",orderId: self.orderId, userId: self.userId,custmerId: self.custmerId)
                
                if bbb.count != 0 &&  self.dataAutoPopulatedBool == true{
                  self.farmIDBoolEntry = true
                  self.farmIdView.layer.borderColor = UIColor.red.cgColor
                  CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.duplicateEntryStr, comment: ""))
                  return
                }
              }
              
              if self.farmIDBoolEntrySecond == true {
                let animalTag1 = fetchAnimaldataValidateFamID(entityName: Entities.animalMasterTblEntity,farmId:self.scanAnimalTagText.text ?? "",custmerId: self.custmerId , userId: self.userId, animalId: Int64(self.animalId1))
                if animalTag1.count != 0 &&  self.dataAutoPopulatedBool == true{
                  
                  self.farmIDBoolEntrySecond = true
                  self.officalTagView.layer.borderColor = UIColor.red.cgColor
                  CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.duplicateEntryStr, comment: ""))
                  return
                }
              }
              
              let valueCheck = self.dateBtnOutlet.titleLabel?.text
              
              if valueCheck!.count != 0{
                self.dateBtnOutlet.layer.borderColor = UIColor.gray.cgColor
                self.calenderDobView.layer.borderColor = UIColor.gray.cgColor
                
              }
              if self.damtexfield.text!.count == 0 {
                self.damtexfield.layer.borderColor = UIColor.gray.cgColor
              }
              if self.sireIdTextField.text!.count == 0 {
                self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
              }
              if self.scanBarcodeText.text!.count == 0 {
                self.barcodeView.layer.borderColor = UIColor.gray.cgColor
              }
              if self.validateDateFlag == false || self.dateTextField.text?.count != 10{
                
                if self.dateTextField.text?.count == 10 {
                  let validate = self.isValidDate(dateString: self.dateTextField.text ?? "")
                  if validate == LocalizedStrings.correctFormatStr {
                    self.dateBtnOutlet.layer.borderColor = UIColor.gray.cgColor
                    self.dateBtnOutlet.layer.borderWidth = 0.5
                    self.validateDateFlag = true
                  } else {
                    self.dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
                    self.validateDateFlag = false
                    
                    if validate == LocalizedStrings.greaterThenDateStr {
                      CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.dobSmallerthanCurrDate, comment: ""))
                      return
                    } else {
                      CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
                      return
                    }
                    return
                  }
                } else {
                  self.dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
                  self.validateDateFlag = false
                  CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
                  return
                }
              }
              
              if self.statusOrder == true {
                self.msgAnimalSucess = true
                let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.animalMasterTblEntity, animalId: self.idAnimal, customerID: self.custmerId)
                if animalFetch.count > 0{
                  self.editIngText = true
                }
              }
              
              if self.scanAnimalTagText.tag == 1{
                if self.scanAnimalTagText.text == "" || self.scanBarcodeText.text == ""  {
                  if self.scanAnimalTagText.text!.count == 0 {
                    self.officalTagView.layer.borderColor = UIColor.red.cgColor
                  } else {
                    self.officalTagView.layer.borderColor = UIColor.gray.cgColor
                    self.scanAnimalTagText.textColor = UIColor.black
                  }
                  
                  if self.scanBarcodeText.text!.count == 0 {
                    self.barcodeView.layer.borderColor = UIColor.red.cgColor
                    self.scanBarcodeText.textColor = UIColor.red
                  } else {
                    self.barcodeView.layer.borderColor = UIColor.gray.cgColor
                    self.scanBarcodeText.textColor = UIColor.black
                  }
                  if self.damtexfield.text!.count == 0 {
                    self.damtexfield.layer.borderColor = UIColor.gray.cgColor
                  }
                  if self.sireIdTextField.text!.count == 0 {
                    self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                  }
                  if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == "True" {
                    if self.farmIdTextField.text?.count == 0 && !self.isCheckCountryUK() {
                      self.farmIdView.layer.borderColor = UIColor.red.cgColor
                    } else if self.farmIdTextField.text?.count == 17 {
                      
                    }else {
                      self.borderRedCheck = true
                    }
                    
                  } else {
                    if self.farmIdTextField.text?.count == 0 {
                      self.farmIdView.layer.borderColor = UIColor.gray.cgColor
                    }
                  }
                  
                  CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                  return
                  
                } else {
                  self.officalTagView.layer.borderColor = UIColor.gray.cgColor
                  self.scanAnimalTagText.textColor = UIColor.black
                  self.barcodeView.layer.borderColor = UIColor.gray.cgColor
                  self.scanBarcodeText.textColor = UIColor.black
                  
                  if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == "True" {
                    if self.farmIdTextField.text?.count == 0 && !self.isCheckCountryUK() {
                      self.farmIdView.layer.borderColor = UIColor.red.cgColor
                      CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                      return
                      
                    } else if self.farmIdTextField.text?.count == 17 {
                      
                    } else {
                      self.borderRedCheck = true
                    }
                    
                  } else {
                    if self.farmIdTextField.text?.count == 0 {
                      self.farmIdView.layer.borderColor = UIColor.gray.cgColor
                      self.borderRedCheck = false
                    } else if self.farmIdTextField.text?.count == 17 {
                    } else {
                      self.borderRedCheck = true
                    }
                    
                  }
                  
                  if self.sireIdTextField.text?.count != 0 || self.damtexfield.text?.count != 0 {
                    if self.sireIdTextField.text!.count == 0 {
                      self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                    }
                    if self.damtexfield.text!.count == 0 {
                      self.damtexfield.layer.borderColor = UIColor.gray.cgColor
                    }
                    
                    
                    if self.sireIdTextField.text?.count == 0{
                      self.sireIdValidationB = false
                    }
                    
                    if self.damtexfield.text?.count == 0{
                      self.damIdValidationB = false
                    }
                    
                    if self.ausBullId.contains(self.sireIdTextField.text?.uppercased() as Any) || self.sireNationalID.contains(self.sireIdTextField.text?.uppercased() as Any){
                      self.sireIdValidationB = false
                    }
                    
                    if self.borderRedCheck == true || self.damIdValidationB == true || self.sireIdValidationB == true  {
                      if self.sireIdTextField.text?.count != 0{
                        if self.sireIdValidationB  == true {
                          if self.pvid == 3 {
                            if self.ausBullId.contains(self.sireIdTextField.text?.uppercased() as Any) || self.sireNationalID.contains(self.sireIdTextField.text?.uppercased() as Any){
                            } else {
                              self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                              return
                            }
                          } else {
                            self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                            return
                          }
                          
                        } else{
                          if self.sireIdTextField.text?.count == 17 {
                          }
                          else {
                            if self.autoSuggestionStatus == true{
                            }
                            else {
                              if self.pvid == 3 {
                              }
                              else {
                                self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                                return
                              }
                            }
                          }
                        }
                      } else {
                        self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                      }
                      
                      if self.damtexfield.text?.count != 0{
                        if self.damIdValidationB  == true {
                          if self.pvid != 3 {
                            self.validationId17SireDam(animalId: self.damtexfield.text!, tag: 4)
                            return
                            
                          }
                          
                        }else {
                          if self.damtexfield.text?.count == 17 {
                          }
                          else {
                            if self.pvid != 3 {
                              self.validationId17SireDam(animalId: self.damtexfield.text!, tag: 4)
                              return
                            }
                          }
                        }
                      } else {
                        self.damtexfield.layer.borderColor = UIColor.gray.cgColor
                      }
                      
                      if self.borderRedCheck == true {
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalIDStr, comment: ""), duration: 2, position: .top)
                        self.farmIdView.layer.borderColor = UIColor.red.cgColor
                      }
                      
                      return
                    }
                  } else {
                    self.damtexfield.layer.borderColor = UIColor.gray.cgColor
                    self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                  }
                  
                  if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String != "True" {
                    if self.farmIdTextField.text!.count == 0 {
                      self.borderRedCheck = false
                    }
                  }
                  
                  if self.sireIdTextField.text?.count == 17  || self.sireIdTextField.text?.count == 0{
                    
                  } else {
                    if self.autoSuggestionStatus == true {
                    }
                    else {
                      if self.pvid == 3 {
                      }
                      else {
                        self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                        return
                      }
                      
                    }
                  }
                  if self.damtexfield.text?.count == 17  || self.damtexfield.text?.count == 0{
                    
                  } else {
                    if self.pvid != 3 {
                      self.validationId17SireDam(animalId: self.damtexfield.text!, tag: 4)
                      return
                    }
                  }
                  
                  if self.borderRedCheck == false {
                    self.addBtnCondtion(completionHandler: { (success) -> Void in
                      if success == true{
                        self.borderRedCheck = true
                        completionHandler(true)
                      }
                    })
                    
                  } else {
                    if self.farmIdTextField.text?.count == 0 && !self.isCheckCountryUK() {
                      self.farmIdView.layer.borderColor = UIColor.red.cgColor
                      CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                      return
                      
                    } else  {
                      self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalIDStr, comment: ""), duration: 2, position: .top)
                      self.farmIdView.layer.borderColor = UIColor.red.cgColor
                      return
                    }
                  }
                }
              } else {
                if self.scanBarcodeText.text == "" || self.scanAnimalTagText.text == "" {
                  if self.scanAnimalTagText.text!.count == 0 {
                    self.officalTagView.layer.borderColor = UIColor.red.cgColor
                  } else {
                    self.officalTagView.layer.borderColor = UIColor.gray.cgColor
                    self.scanAnimalTagText.textColor = UIColor.black
                  }
                  if self.scanBarcodeText.text!.count == 0 {
                    self.barcodeView.layer.borderColor = UIColor.red.cgColor
                    self.scanBarcodeText.textColor = UIColor.red
                  } else {
                    self.barcodeView.layer.borderColor = UIColor.gray.cgColor
                    self.scanBarcodeText.textColor = UIColor.black
                  }
                  
                  CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                  completionHandler(false)
                  return
                  
                } else {
                  self.officalTagView.layer.borderColor = UIColor.gray.cgColor
                  self.scanAnimalTagText.textColor = UIColor.black
                  self.barcodeView.layer.borderColor = UIColor.gray.cgColor
                  self.scanBarcodeText.textColor = UIColor.black
                  
                  if self.sireIdTextField.text?.count != 0 || self.damtexfield.text?.count != 0 {
                    if self.sireIdTextField.text!.count == 0 {
                      self.sireIdValidationB = false
                      self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                    }
                    if self.damtexfield.text!.count == 0 {
                      self.damIdValidationB = false
                      self.damtexfield.layer.borderColor = UIColor.gray.cgColor
                    }
                    
                    if self.ausBullId.contains(self.sireIdTextField.text?.uppercased() as Any) || self.sireNationalID.contains(self.sireIdTextField.text?.uppercased() as Any){
                      self.sireIdValidationB = false
                    }
                    
                    if self.borderRedCheck == true || self.damIdValidationB == true || self.sireIdValidationB == true  {
                      if self.sireIdTextField.text?.count != 0{
                        if self.sireIdValidationB  == true {
                          if self.autoSuggestionStatus != true {
                            if self.pvid == 3 {
                              self.sireIdTextField.layer.borderColor = UIColor.red.cgColor
                              CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.bullIdDoesNotExist, comment: ""))
                              return
                            } else {
                              self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                              return
                            }
                          }
                        }
                      } else {
                        self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                      }
                      
                      if self.damtexfield.text?.count != 0{
                        if self.damIdValidationB  == true {
                          if self.pvid != 3 {
                            self.validationId17SireDam(animalId: self.damtexfield.text!, tag: 4)
                            return
                          }
                        }
                      } else {
                        self.damtexfield.layer.borderColor = UIColor.gray.cgColor
                      }
                      if self.borderRedCheck == true {
                        self.officalTagView.layer.borderColor = UIColor.red.cgColor
                        self.view.makeToast( NSLocalizedString(LocalizedStrings.invalidAnimalIDStr, comment: ""), duration: 2, position: .top)
                      }
                      return
                    }
                  }
                  
                  if self.scanAnimalTagText.text?.count != 17 {
                    self.borderRedCheck = true
                  }
                  
                  if self.borderRedCheck == true {
                    self.officalTagView.layer.borderColor = UIColor.red.cgColor
                    self.view.makeToast( NSLocalizedString(LocalizedStrings.invalidAnimalIDStr, comment: ""), duration: 2, position: .top)
                    return
                  } else {
                    if self.sireIdTextField.text?.count == 17  || self.sireIdTextField.text?.count == 0{
                      
                    } else {
                      if self.autoSuggestionStatus == true {
                      }
                      else {
                        if self.autoSuggestionStatus == true {
                        }
                        else {
                          if self.pvid == 3 {
                          }
                          else {
                            self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                            return
                          }
                        }
                      }
                    }
                    if self.damtexfield.text?.count == 17  || self.damtexfield.text?.count == 0{
                    } else {
                      if self.pvid != 3 {
                        self.validationId17SireDam(animalId: self.damtexfield.text!, tag: 4)
                        return
                      }
                      
                    }
                    
                    self.addBtnCondtion(completionHandler: { (success) -> Void in
                      if success == true{
                        self.borderRedCheck = true
                        completionHandler(true)
                      }
                    })
                  }
                }
              }
              
              if self.notificationLblCount.text != "0"{
                self.countLbl.isHidden = false
                self.notificationLblCount.isHidden = false
              }
            }))
            
            alert.addAction(UIAlertAction(title: LocalizedStrings.retrieveText, style: .default, handler: { (_) in
              self.mainrecord = false
              self.dataPopulateInFocusChange()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
              self.mainrecord = true
            }))
            self.present(alert, animated: true, completion: nil)
            return
          }
        }
        
        if self.screentext == keyValue.officialId.rawValue{
          if self.isoverride == true{
            self.farmIdTextField.text = self.newfarmid
            self.isoverride = false
          }
        }
        else{
          if self.isoverride == true{
            self.scanAnimalTagText.text = self.newfarmid
            self.isoverride = false
          }
        }
        if self.siraidcheck == true{
          self.sireIdTextField.layer.borderColor = UIColor.red.cgColor
          CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sireIdCannotBeSame, comment: ""))
          self.siraidcheck = false
          self.sireIdTextField.becomeFirstResponder()
          return
        }
        
        if self.barcodeEnable == true {
          let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.animalMasterTblEntity, animalId: self.idAnimal,orderststus:"true", customerId: self.custmerId)
          if orederStatus.count > 0 {
            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalAlreadyUsedStr, comment: ""), preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
              UIAlertAction in
              let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.animalMasterTblEntity, animalId: self.idAnimal, customerID: self.custmerId)
              self.autoPop(animalData: animalFetch)
              self.barcodeEnable = false
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            self.statusOrder = false
            self.scrolView.contentOffset.y = 0.0
            return
          }
        }
        
        if self.farmIDBoolEntryTag == true {
          let bbb =  fetchAnimaldataValidateAnimalBarcodetag(entityName: Entities.animalAddTblEntity,animalbarCodeTag:self.scanAnimalTagText.text ?? "",orderId: self.orderId, userId: self.userId, custmerId: self.custmerId)
          
          if bbb.count != 0 &&  self.dataAutoPopulatedBool == true{
            self.farmIDBoolEntry = true
            self.officalTagView.layer.borderColor = UIColor.red.cgColor
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.duplicateEntryStr, comment: ""))
            return
          }
        }
        if self.farmIDBoolEntry == true {
          let bbb =  fetchAnimaldataValidateAnimalBarcodetag(entityName: Entities.animalAddTblEntity,animalbarCodeTag:self.farmIdTextField.text ?? "",orderId: self.orderId, userId: self.userId, custmerId: self.custmerId)
          
          if bbb.count != 0 &&  self.dataAutoPopulatedBool == true{
            self.farmIDBoolEntry = true
            self.farmIdView.layer.borderColor = UIColor.red.cgColor
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.duplicateEntryStr, comment: ""))
            return
          }
        }
        
        if self.farmIDBoolEntrySecond == true {
          let animalTag1 = fetchAnimaldataValidateFamID(entityName: Entities.animalMasterTblEntity,farmId:self.scanAnimalTagText.text ?? "",custmerId: self.custmerId , userId: self.userId, animalId: Int64(self.animalId1))
          if animalTag1.count != 0 &&  self.dataAutoPopulatedBool == true{
            self.farmIDBoolEntrySecond = true
            self.officalTagView.layer.borderColor = UIColor.red.cgColor
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.duplicateEntryStr, comment: ""))
            return
          }
        }
        let valueCheck = self.dateBtnOutlet.titleLabel?.text
        
        if valueCheck!.count != 0{
          self.dateBtnOutlet.layer.borderColor = UIColor.gray.cgColor
          self.calenderDobView.layer.borderColor = UIColor.gray.cgColor
          
        }
        if self.damtexfield.text!.count == 0 {
          self.damtexfield.layer.borderColor = UIColor.gray.cgColor
        }
        if self.sireIdTextField.text!.count == 0 {
          self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
        }
        if self.scanBarcodeText.text!.count == 0 {
          self.barcodeView.layer.borderColor = UIColor.gray.cgColor
        }
        if self.dateTextField.text?.count == 0 {}
        else if self.validateDateFlag == false || self.dateTextField.text?.count != 10{
          if self.dateTextField.text?.count == 10 {
            let validate = self.isValidDate(dateString: self.dateTextField.text ?? "")
            if validate == LocalizedStrings.correctFormatStr {
              self.dateBtnOutlet.layer.borderColor = UIColor.gray.cgColor
              self.dateBtnOutlet.layer.borderWidth = 0.5
              self.validateDateFlag = true
            } else {
              self.dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
              self.validateDateFlag = false
              
              if validate == LocalizedStrings.greaterThenDateStr {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.dobSmallerthanCurrDate, comment: ""))
                return
              } else {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
                return
              }
              return
              
            }
          } else {
            self.dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
            self.validateDateFlag = false
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
            return
          }
        }
        
        if self.statusOrder == true {
          self.msgAnimalSucess = true
          let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.animalMasterTblEntity, animalId: self.idAnimal, customerID: self.custmerId)
          if animalFetch.count > 0{
            self.editIngText = true
          }
        }
        
        if self.scanAnimalTagText.tag == 1{
          
          if self.scanAnimalTagText.text == "" || self.scanBarcodeText.text == ""  {
            
            if self.scanAnimalTagText.text!.count == 0 {
              self.officalTagView.layer.borderColor = UIColor.red.cgColor
            } else {
              self.officalTagView.layer.borderColor = UIColor.gray.cgColor
              self.scanAnimalTagText.textColor = UIColor.black
            }
            
            if self.scanBarcodeText.text!.count == 0 {
              self.barcodeView.layer.borderColor = UIColor.red.cgColor
              self.scanBarcodeText.textColor = UIColor.red
            } else {
              self.barcodeView.layer.borderColor = UIColor.gray.cgColor
              self.scanBarcodeText.textColor = UIColor.black
            }
            if self.damtexfield.text!.count == 0 {
              self.damtexfield.layer.borderColor = UIColor.gray.cgColor
            }
            if self.sireIdTextField.text!.count == 0 {
              self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
            }
            if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == "True" {
              if self.farmIdTextField.text?.count == 0 && !self.isCheckCountryUK() {
                self.farmIdView.layer.borderColor = UIColor.red.cgColor
              } else if self.farmIdTextField.text?.count == 17 {
                
              }else {
                self.borderRedCheck = true
              }
              
            } else {
              if self.farmIdTextField.text?.count == 0 {
                self.farmIdView.layer.borderColor = UIColor.gray.cgColor
              }
            }
            
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
            return
            
          } else {
            
            self.officalTagView.layer.borderColor = UIColor.gray.cgColor
            self.scanAnimalTagText.textColor = UIColor.black
            self.barcodeView.layer.borderColor = UIColor.gray.cgColor
            self.scanBarcodeText.textColor = UIColor.black
            if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == "True" {
              if self.farmIdTextField.text?.count == 0 && !self.isCheckCountryUK() {
                self.farmIdView.layer.borderColor = UIColor.red.cgColor
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                return
                
              } else if self.farmIdTextField.text?.count == 17 {
                
              } else {
                self.borderRedCheck = true
              }
              
            } else {
              if self.farmIdTextField.text?.count == 0 {
                self.farmIdView.layer.borderColor = UIColor.gray.cgColor
                self.borderRedCheck = false
              } else if self.farmIdTextField.text?.count == 17 {
              } else {
                self.borderRedCheck = true
              }
            }
            
            if self.sireIdTextField.text?.count != 0 || self.damtexfield.text?.count != 0 {
              
              if self.sireIdTextField.text!.count == 0 {
                self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
              }
              if self.damtexfield.text!.count == 0 {
                self.damtexfield.layer.borderColor = UIColor.gray.cgColor
              }
              
              if self.sireIdTextField.text?.count == 0{
                self.sireIdValidationB = false
              }
              
              if self.damtexfield.text?.count == 0{
                self.damIdValidationB = false
              }
              
              if self.ausBullId.contains(self.sireIdTextField.text?.uppercased() as Any) || self.sireNationalID.contains(self.sireIdTextField.text?.uppercased() as Any){
                self.sireIdValidationB = false
              }
              
              if self.borderRedCheck == true || self.damIdValidationB == true || self.sireIdValidationB == true  {
                if self.sireIdTextField.text?.count != 0{
                  if self.sireIdValidationB  == true {
                    if self.pvid == 3 {
                      if ausBullId.contains(sireIdTextField.text?.uppercased() as Any) || self.sireNationalID.contains(sireIdTextField.text?.uppercased() as Any){
                        
                      } else {
                        self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                        return
                      }
                    } else {
                      self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                      return
                    }
                  } else{
                    if self.sireIdTextField.text?.count == 17 {
                    }
                    else {
                      if self.autoSuggestionStatus == true {
                      }
                      else {
                        if self.pvid == 3 {
                        }
                        else {
                          self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                          return
                        }
                      }
                    }
                  }
                } else {
                  self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                }
                
                if self.damtexfield.text?.count != 0{
                  if damIdValidationB  == true {
                    if pvid != 3 {
                      validationId17SireDam(animalId: damtexfield.text!, tag: 4)
                      return
                    }
                  }else {
                    if damtexfield.text?.count == 17 {
                    }
                    else {
                      if pvid != 3 {
                        validationId17SireDam(animalId: damtexfield.text!, tag: 4)
                        return
                      }
                    }
                  }
                } else {
                  damtexfield.layer.borderColor = UIColor.gray.cgColor
                }
                
                if borderRedCheck == true {
                  self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalIDStr, comment: ""), duration: 2, position: .top)
                  farmIdView.layer.borderColor = UIColor.red.cgColor
                }
                return
              }
            } else {
              
              damtexfield.layer.borderColor = UIColor.gray.cgColor
              sireIdTextField.layer.borderColor = UIColor.gray.cgColor
            }
            
            if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String != "True" {
              if farmIdTextField.text!.count == 0 {
                borderRedCheck = false
              }
            }
            if sireIdTextField.text?.count == 17  || sireIdTextField.text?.count == 0{
              
            } else {
              if autoSuggestionStatus == true {
              }
              else {
                if pvid == 3 {
                }
                else {
                  validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                  return
                }
              }
            }
            
            if damtexfield.text?.count == 17  || damtexfield.text?.count == 0{
              
            } else {
              if pvid != 3 {
                validationId17SireDam(animalId: damtexfield.text!, tag: 4)
                return
              }
            }
            
            if borderRedCheck == false {
              addBtnCondtion(completionHandler: { (success) -> Void in
                if success == true{
                  borderRedCheck = true
                  completionHandler(true)
                }
              })
            } else {
              if farmIdTextField.text?.count == 0 && !isCheckCountryUK() {
                farmIdView.layer.borderColor = UIColor.red.cgColor
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                return
                
                
              } else  {
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalIDStr, comment: ""), duration: 2, position: .top)
                farmIdView.layer.borderColor = UIColor.red.cgColor
                return
              }
            }
          }
        } else {
          if scanBarcodeText.text == "" || scanAnimalTagText.text == "" {
            if scanAnimalTagText.text!.count == 0 {
              officalTagView.layer.borderColor = UIColor.red.cgColor
            } else {
              officalTagView.layer.borderColor = UIColor.gray.cgColor
              scanAnimalTagText.textColor = UIColor.black
            }
            if scanBarcodeText.text!.count == 0 {
              barcodeView.layer.borderColor = UIColor.red.cgColor
              scanBarcodeText.textColor = UIColor.red
            } else {
              barcodeView.layer.borderColor = UIColor.gray.cgColor
              scanBarcodeText.textColor = UIColor.black
            }
            
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
            completionHandler(false)
            return
            
          } else {
            officalTagView.layer.borderColor = UIColor.gray.cgColor
            scanAnimalTagText.textColor = UIColor.black
            barcodeView.layer.borderColor = UIColor.gray.cgColor
            scanBarcodeText.textColor = UIColor.black
            
            if sireIdTextField.text?.count != 0 || damtexfield.text?.count != 0 {
              if sireIdTextField.text!.count == 0 {
                sireIdValidationB = false
                sireIdTextField.layer.borderColor = UIColor.gray.cgColor
              }
              if damtexfield.text!.count == 0 {
                damIdValidationB = false
                damtexfield.layer.borderColor = UIColor.gray.cgColor
              }
              
              if ausBullId.contains(sireIdTextField.text?.uppercased() as Any) || sireNationalID.contains(sireIdTextField.text?.uppercased() as Any){
                sireIdValidationB = false
              }
              
              if borderRedCheck == true || damIdValidationB == true || sireIdValidationB == true  {
                if sireIdTextField.text?.count != 0{
                  if sireIdValidationB  == true {
                    if autoSuggestionStatus != true {
                      if pvid == 3 {
                        sireIdTextField.layer.borderColor = UIColor.red.cgColor
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.bullIdDoesNotExist, comment: ""))
                        return
                        
                      } else {
                        validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                        return
                      }
                    }
                  }
                } else {
                  sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                }
                
                if damtexfield.text?.count != 0{
                  if damIdValidationB  == true {
                    if pvid != 3 {
                      validationId17SireDam(animalId: damtexfield.text!, tag: 4)
                      return
                    }
                  }
                } else {
                  damtexfield.layer.borderColor = UIColor.gray.cgColor
                }
                if borderRedCheck == true {
                  officalTagView.layer.borderColor = UIColor.red.cgColor
                  self.view.makeToast( NSLocalizedString(LocalizedStrings.invalidAnimalIDStr, comment: ""), duration: 2, position: .top)
                }
                return
              }
            }
            
            if scanAnimalTagText.text?.count != 17 {
              borderRedCheck = true
              officalTagView.layer.borderColor = UIColor.red.cgColor
              self.view.makeToast( NSLocalizedString(LocalizedStrings.invalidAnimalIDStr, comment: ""), duration: 2, position: .top)
              
              return
            }
            else {
              if sireIdTextField.text?.count == 17  || sireIdTextField.text?.count == 0{
                
              } else {
                if autoSuggestionStatus == true {
                }
                else {
                  if autoSuggestionStatus == true {
                  }
                  else {
                    if pvid == 3 {
                    }
                    else {
                      validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                      return
                    }
                  }
                }
              }
              if damtexfield.text?.count == 17  || damtexfield.text?.count == 0{
              } else {
                if pvid != 3 {
                  validationId17SireDam(animalId: damtexfield.text!, tag: 4)
                  return
                }
              }
              
              addBtnCondtion(completionHandler: { (success) -> Void in
                if success == true{
                  borderRedCheck = true
                  completionHandler(true)
                  
                }
              })
            }
          }
        }
        
        if notificationLblCount.text != "0"{
          countLbl.isHidden = false
          notificationLblCount.isHidden = false
        }
//      }})
    }
  
  func addAnimalBtn(completionHandler: @escaping CompletionHandler){
    
    //            let barCode = fetchAnimaldataValidateAnimalBarcodeanimalIdOrderId(entityName: "AnimaladdTbl", animalbarCodeTag: scanBarcodeText.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"false",orderid:orderId,custId:custmerId)
    //            if barCode.count > 0 {
    //                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Barcode is already used with an animal.", comment: ""))
    //                barcodeView.layer.borderColor = UIColor.red.cgColor
    //
    //                return
    //            }
    //            let screenRefernce = UserDefaults.standard.value(forKey:"screen") as? String
    //
    //            if screenRefernce == "officialid" || screenRefernce == ""{
    //
    //            }
    //            else
    //            {
    //                newanimaltagvalue = farmIdTextField.text ?? ""
    //                let newcheck = fetchAllDataOrdercheck(entityName: "AnimalMaster", ordestatus: "true", animalTag:newanimaltagvalue ,userId: userId)
    //                let newcheck1 = fetchAllDataOrdercheck(entityName: "AnimaladdTbl", ordestatus: "false", animalTag:newanimaltagvalue ?? "",userId: userId)
    //                if newcheck.count > 0{
    //                    mainrecord = true
    //                }
    //                else
    //                {
    //                    mainrecord = false
    //                }
    //                if newcheck1.count > 0{
    //                    mainrecord = true
    //                }
    //                else
    //                {
    //                    mainrecord = false
    //                }
    //
    //
    //            }
                if matchedBarcodeBtnOutlet.isSelected {
                    UserDefaults.standard.setValue(true, forKey: "matchedBarcodeFlag")
                }
                if barcodefixed == true
                {
                UserDefaults.standard.setValue(true, forKey: "matchedBarcodeFlag")
                }
                if fetchrecord == true
                {
                   // self.barcodeflag = false
                    fetchrecord = false
                    let newcheck = fetchAllDataOrdercheckfarmid(entityName: "AnimalMaster", ordestatus: "true", farmid: onfarmidtext ,userId: userId)
                    let newcheck2 = fetchAllDataOrdercheckfarmid(entityName: "AnimalMaster", ordestatus: "false", farmid: onfarmidtext ,userId: userId)
                  let newcheck1 = fetchAllDataOrdercheckfarmid(entityName: "AnimaladdTbl", ordestatus: "false", farmid: onfarmidtext,userId: userId)
                        
                        print(newcheck)
                        print(newcheck1)
                        
                        if newcheck.count > 0{
                            let newvalue1 = newcheck.object(at: 0) as? AnimalMaster
                            let alert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("The entered information has matched the OnFarmID for a previously saved animal. Select action to proceed.", comment: ""), preferredStyle: .alert)

                            alert.addAction(UIAlertAction(title: NSLocalizedString("Overwrite", comment: ""), style: .default, handler: { [self]  (_) in
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal Record cannot be updated as the animal has been used for an order.", comment: ""))
                                self.fetchrecord = true
                                //byDefaultSetting()
                            }))
                            alert.addAction(UIAlertAction(title: "Retrieve", style: .default, handler: { (_) in
                                self.fetchrecord = false
                                self.dataPopulateInFocusChange()
                            }))
                            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
                                self.fetchrecord = true
                            }))
                            self.present(alert, animated: true, completion: nil)
                            return
                           
                        }
                        
                    else if newcheck1.count > 0 || newcheck2.count > 0{
                            
                            
                            let alert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("The entered information has matched the OnFarmID for a previously saved animal. Select action to proceed.", comment: ""), preferredStyle: .alert)

                            alert.addAction(UIAlertAction(title: NSLocalizedString("Overwrite", comment: ""), style: .default, handler: { [self]  (_) in
                                self.fetchrecord = false
                               
                                if self.screentext == "officialid"
                                {
                                    if newcheck1.count > 0
                                    {
                                      let newvalue1 = newcheck1.object(at: 0) as? AnimaladdTbl
                                    self.isoverride  =  true
                                    self.saveanimalID = newvalue1?.animalId ??  0
                                    self.checkofsaveanimalid = true
                                  self.newfarmid = newvalue1?.farmId ?? ""
                                  self.newtextfieldfarmid = self.farmIdTextField.text ?? ""
                                  print(self.newfarmid)
                                 // self.scanAnimalTagText.text = self.newfarmid
                                  if self.isoverride == true
                                   {
                                      self.farmIdTextField.text = self.newfarmid
                                     
                                  }
                                    }
                                    else if newcheck2.count > 0
                                    {
                                        let newvalue2 = newcheck2.object(at: 0) as? AnimalMaster
                                        self.isoverride  =  true
                                        self.saveanimalID = newvalue2?.animalId ??  0
                                        self.checkofsaveanimalid = true
                                      self.newfarmid = newvalue2?.farmId ?? ""
                                      self.newtextfieldfarmid = self.farmIdTextField.text ?? ""
                                      print(self.newfarmid)
                                     // self.scanAnimalTagText.text = self.newfarmid
                                      if self.isoverride == true
                                       {
                                          self.farmIdTextField.text = self.newfarmid
                                         
                                      }
                                    }
                                  
                                }
                                else
                                {
                                    if newcheck1.count > 0
                                    {
                                        let newvalue1 = newcheck1.object(at: 0) as? AnimaladdTbl
                                    self.isoverride  =  true
                                  self.newfarmid = newvalue1?.farmId ?? ""
                                  self.newtextfieldfarmid = self.scanAnimalTagText.text ?? ""
                                  print(self.newfarmid)
                                 // self.scanAnimalTagText.text = self.newfarmid
                                  if self.isoverride == true
                                   {
                                      self.scanAnimalTagText.text = self.newfarmid
                                     
                                  }
                                    }
                                    else if newcheck2.count > 0
                                    {
                                        let newvalue2 = newcheck2.object(at: 0) as? AnimalMaster
                                        self.isoverride  =  true
                                      self.newfarmid = newvalue2?.farmId ?? ""
                                      self.newtextfieldfarmid = self.scanAnimalTagText.text ?? ""
                                      print(self.newfarmid)
                                     // self.scanAnimalTagText.text = self.newfarmid
                                      if self.isoverride == true
                                       {
                                          self.scanAnimalTagText.text = self.newfarmid
                                         
                                      }
                                    }
                                  }
                            
                                if self.siraidcheck == true
                                {
                                    self.sireIdTextField.layer.borderColor = UIColor.red.cgColor
                                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString("The SireID cannot be the same as the Official ID or the On Farm ID.", comment: ""))
                                    self.siraidcheck = false
                                    self.sireIdTextField.becomeFirstResponder()
                                    return
                                }
    //                            if self.scanbarcodecheck == true
    //                            {
    //                                self.barcodeView.layer.borderColor = UIColor.red.cgColor
    //                                self.scanbarcodecheck = true
    //                               CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString("The Barcode cannot be the same as the Official ID.", comment: ""))
    //                                self.scanbarcodecheck = false
    //                                self.scanBarcodeText.becomeFirstResponder()
    //
    //                               return
    //                           }
                                if self.barcodeEnable == true {
                                    let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: "AnimalMaster", animalId: self.idAnimal,orderststus:"true", customerId: self.custmerId)
                                    if orederStatus.count > 0 {
                                        
                                        let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Animal Record cannot be updated as the animal has been used for an order.", comment: ""), preferredStyle: .alert)
                                        
                                        // Create the actions
                                        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                            UIAlertAction in
                                            let animalFetch = fetchAllDataWithAnimalId(entityName: "AnimalMaster", animalId: self.idAnimal, customerID: self.custmerId)
                                            self.autoPop(animalData: animalFetch)
                                            self.barcodeEnable = false
                                        }
                                        alertController.addAction(okAction)
                                        
                                        
                                        // Present the controller
                                        self.present(alertController, animated: true, completion: nil)
                                        self.statusOrder = false
                                        self.scrolView.contentOffset.y = 0.0
                                        return
                                    }
                                }
                                else {
                                    
                                }
                                
                                
    //                            var fetchBarcodeDuplicay = fetchAnimaldataCheckBarcodeDuplicay(entityName: "AnimalMaster",animalbarCodeTag:self.scanBarcodeText.text ?? "" , userId: self.userId)
    //                            if fetchBarcodeDuplicay.count > 0 {
    //
    //                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Duplicate Entry.", comment: ""))
    //                                scanBarcodeText.layer.borderColor = UIColor.red.cgColor
    //                            return
    //
    //                            }
                    //
                                
                                
                                
    //                            if self.farmIDBoolEntryTag == true {
    //                              var bbb =  fetchAnimaldataValidateAnimalBarcodetag(entityName: "AnimaladdTbl",animalbarCodeTag:self.scanAnimalTagText.text ?? "",orderId: self.orderId, userId: self.userId, custmerId: custmerId)
    //
    //                                if bbb.count != 0 &&  self.dataAutoPopulatedBool == true{
    //                                    self.farmIDBoolEntry = true
    //                                    self.officalTagView.layer.borderColor = UIColor.red.cgColor
    //                                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Duplicate Entry.", comment: ""))
    //                                    return
    //                                }
    //
    //
    //                            }
    //                            if self.farmIDBoolEntry == true {
    //                                var bbb =  fetchAnimaldataValidateAnimalBarcodetag(entityName: "AnimaladdTbl",animalbarCodeTag:self.farmIdTextField.text ?? "",orderId: self.orderId, userId: self.userId, custmerId: custmerId)
    //
    //                                if bbb.count != 0 &&  self.dataAutoPopulatedBool == true{
    //                                    self.farmIDBoolEntry = true
    //                                    self.farmIdView.layer.borderColor = UIColor.red.cgColor
    //                                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Duplicate Entry.", comment: ""))
    //                                    return
    //                                }
    //
    //
    //                            }
    //                            if self.farmIDBoolEntrySecond == true {
    //
    //                                var animalTag1 = fetchAnimaldataValidateFamID(entityName: "AnimalMaster",farmId:self.scanAnimalTagText.text ?? "",custmerId: self.custmerId ?? 0, userId: self.userId, animalId: Int64(self.animalId1))
    //                                if animalTag1.count != 0 &&  self.dataAutoPopulatedBool == true{
    //
    //                                    self.farmIDBoolEntrySecond = true
    //                                    self.officalTagView.layer.borderColor = UIColor.red.cgColor
    //                                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Duplicate Entry.", comment: ""))
    //                                    return
    //                                }
    //                            }
                                
                                
                                
                                let valueCheck = self.dateBtnOutlet.titleLabel?.text
                                
                                if valueCheck!.count != 0{
                                    self.dateBtnOutlet.layer.borderColor = UIColor.gray.cgColor
                                    self.calenderDobView.layer.borderColor = UIColor.gray.cgColor
                                    
                                }
                                if self.damtexfield.text!.count == 0 {
                                    self.damtexfield.layer.borderColor = UIColor.gray.cgColor
                                }
                                if self.sireIdTextField.text!.count == 0 {
                                    self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                                }
                                if self.scanBarcodeText.text!.count == 0 {
                                    self.barcodeView.layer.borderColor = UIColor.gray.cgColor
                                }
                                if self.dateTextField.text?.count == 0 {
                                    
                                    
                                } else if self.validateDateFlag == false || self.dateTextField.text?.count != 10{
                                    
                                    if self.dateTextField.text?.count == 10 {
                                        var validate = self.isValidDate(dateString: self.dateTextField.text ?? "")
                                  
                                        
                                        if validate == "Correct Format" {
                                            self.dateBtnOutlet.layer.borderColor = UIColor.gray.cgColor
                                            self.dateBtnOutlet.layer.borderWidth = 0.5
                                            self.validateDateFlag = true
                                        } else {
                                            self.dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
                                          //  dateBtnOutlet.layer.borderWidth = 1
                                            self.validateDateFlag = false
                                            
                                            if validate == "GreaterThenDate" {
                                                
                                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Date of birth cannot be greater than current date.", comment: ""))
                                                return
                                            } else {
                                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Invalid date format.", comment: ""))
                                                return
                                            }
                                            
                                            return
                                            
                                        }
                                    } else {
                                        self.dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
                                        self.validateDateFlag = false
                                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Invalid date format.", comment: ""))
                                        return
                                        
                                    }
                                }
                                
                                
                                if self.statusOrder == true {
                                    self.msgAnimalSucess = true
                                    
                                    let animalFetch = fetchAllDataWithAnimalId(entityName: "AnimalMaster", animalId: self.idAnimal, customerID: self.custmerId)
                                    if animalFetch.count > 0{
                                        //dataPopulateInScreen(animalId: idAnimal)
                                        self.editIngText = true
                                        
                                        if self.msgAnimalSucess == false {
                                            
                                        } else {
                                            
                                        }
                                    }
                                }
                                
                                
                                let selctionAuProvider = UserDefaults.standard.value(forKey: "ClickAuProvider") as? Bool
                                
                                
                                
                                if self.scanAnimalTagText.tag == 1{
                                    
                                    if self.scanAnimalTagText.text == "" || self.scanBarcodeText.text == ""  {
                                        
                                        if self.scanAnimalTagText.text!.count == 0 {
                                            self.officalTagView.layer.borderColor = UIColor.red.cgColor
                                        } else {
                                            self.officalTagView.layer.borderColor = UIColor.gray.cgColor
                                            self.scanAnimalTagText.textColor = UIColor.black
                                        }
                                        
                                        if self.scanBarcodeText.text!.count == 0 {
                                            self.barcodeView.layer.borderColor = UIColor.red.cgColor
                                            self.scanBarcodeText.textColor = UIColor.red
                                        } else {
                                            self.barcodeView.layer.borderColor = UIColor.gray.cgColor
                                            self.scanBarcodeText.textColor = UIColor.black
                                        }
                                        if self.damtexfield.text!.count == 0 {
                                            
                                            self.damtexfield.layer.borderColor = UIColor.gray.cgColor
                                        }
                                        if self.sireIdTextField.text!.count == 0 {
                                            
                                            self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                                        }
                                        if UserDefaults.standard.value(forKey: "isAuSelected") as? String == "True" {
                                            
                                            if self.farmIdTextField.text?.count == 0 && !isCheckCountryUK() {
                                                self.farmIdView.layer.borderColor = UIColor.red.cgColor
                                            } else if self.farmIdTextField.text?.count == 17 {
                                                
                                            }else {
                                                self.borderRedCheck = true
                                            }
                                            
                                        } else {
                                            if self.farmIdTextField.text?.count == 0 {
                                                self.farmIdView.layer.borderColor = UIColor.gray.cgColor
                                            }
                                        }
                                        
                                        
                                        //                    if selctionAuProvider == true {
                                        //
                                        //                        if sireIdTextField.text!.count == 0 {
                                        //
                                        //                            sireIdTextField.layer.borderColor = UIColor.red.cgColor
                                        //                        }}
                                        //                var dateVale = dateBtnOutlet.titleLabel?.text ?? ""
                                        //
                                        //                if dateVale == "" {
                                        //                    dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
                                        //                    calenderDobView.layer.borderColor = UIColor.red.cgColor
                                        //                }
                                        
                                        
                                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                        return
                                        
                                    } else {
                                        
                                        self.officalTagView.layer.borderColor = UIColor.gray.cgColor
                                        self.scanAnimalTagText.textColor = UIColor.black
                                        self.barcodeView.layer.borderColor = UIColor.gray.cgColor
                                        self.scanBarcodeText.textColor = UIColor.black
                                        
                                        if UserDefaults.standard.value(forKey: "isAuSelected") as? String == "True" {
                                            
                                            if self.farmIdTextField.text?.count == 0 && !isCheckCountryUK(){
                                                self.farmIdView.layer.borderColor = UIColor.red.cgColor
                                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                                return
                                                
                                            } else if self.farmIdTextField.text?.count == 17 {
                                                
                                            } else {
                                                self.borderRedCheck = true
                                            }
                                            
                                        } else {
                                            if self.farmIdTextField.text?.count == 0 {
                                                self.farmIdView.layer.borderColor = UIColor.gray.cgColor
                                                self.borderRedCheck = false
                                            } else if self.farmIdTextField.text?.count == 17 {
                                                
                                                //     self.validationId17(animalId: (farmIdTextField.text?.uppercased())!)
                                                
                                            } else {
                                                self.borderRedCheck = true
                                            }
                                            
                                        }
                                        
                                        if self.sireIdTextField.text?.count != 0 || self.damtexfield.text?.count != 0 {
                                            
                                            if self.sireIdTextField.text!.count == 0 {
                                                self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                                            }
                                            if self.damtexfield.text!.count == 0 {
                                                self.damtexfield.layer.borderColor = UIColor.gray.cgColor
                                            }
                                            
                                            
                                            if self.sireIdTextField.text?.count == 0{
                                                self.sireIdValidationB = false
                                            }
                                            
                                            if self.damtexfield.text?.count == 0{
                                                self.damIdValidationB = false
                                            }
                                            
                                            if self.ausBullId.contains(self.sireIdTextField.text?.uppercased()) || self.sireNationalID.contains(self.sireIdTextField.text?.uppercased()){
                                                self.sireIdValidationB = false
                                            }
                                            
                                            if self.borderRedCheck == true || self.damIdValidationB == true || self.sireIdValidationB == true  {
                                                
                                                
                                                
                                                
                                                if self.sireIdTextField.text?.count != 0{
                                                    if self.sireIdValidationB  == true {
                                                        // if autoSuggestionStatus == true {
                                                        //   }else{
                                                        
                                                        if self.pvid == 3 {
                                                            // sireIdValidationB = false
                                                            
                                                            
                                                            if self.ausBullId.contains(self.sireIdTextField.text?.uppercased()) || self.sireNationalID.contains(self.sireIdTextField.text?.uppercased()){
                                                                
                                                            } else {
                                                                self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                                                                return
                                                                //                                            sireIdTextField.layer.borderColor = UIColor.red.cgColor
                                                                //                                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Bull ID for this animal does not exist.", comment: ""))
                                                                //                                            return
                                                            }
                                                        } else {
                                                            
                                                            self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                                                            return
                                                        }
                                                        
                                                        // }
                                                    } else{
                                                        if self.sireIdTextField.text?.count == 17 {
                                                            
                                                        } else {
                                                            if self.autoSuggestionStatus == true {
                                                            }else{
                                                                
                                                                if self.pvid == 3 {
                                                                    
                                                                } else {
                                                                    
                                                                    self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                                                                    return
                                                                }
                                                                
                                                            }}                    }
                                                } else {
                                                    self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                                                }
                                                
                                                if self.damtexfield.text?.count != 0{
                                                    
                                                    if self.damIdValidationB  == true {
                                                        
                                                        if self.pvid != 3 {
                                                            self.validationId17SireDam(animalId: self.damtexfield.text!, tag: 4)
                                                            return
                                                            
                                                        }
                                                        
                                                        
                                                        //                                validationId17SireDam(animalId: damtexfield.text!, tag: 4)
                                                        //                                return
                                                    }else {
                                                        
                                                        if self.damtexfield.text?.count == 17 {
                                                        }else{
                                                            if self.pvid != 3 {
                                                                
                                                                self.validationId17SireDam(animalId: self.damtexfield.text!, tag: 4)
                                                                return
                                                            }
                                                        }
                                                        
                                                    }
                                                } else {
                                                    self.damtexfield.layer.borderColor = UIColor.gray.cgColor
                                                }
                                                
                                                
                                                if self.borderRedCheck == true {
                                                    self.view.makeToast(NSLocalizedString("Invalid Animal id.", comment: ""), duration: 2, position: .top)
                                                    self.farmIdView.layer.borderColor = UIColor.red.cgColor
                                                }
                                                
                                                return
                                            }
                                        } else {
                                            
                                            self.damtexfield.layer.borderColor = UIColor.gray.cgColor
                                            self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                                        }
                                        
                                        
                                        if UserDefaults.standard.value(forKey: "isAuSelected") as? String == "True" {
                                            
                                        } else {
                                            if self.farmIdTextField.text!.count == 0 {
                                                self.borderRedCheck = false
                                            }
                                        }
                                        if self.sireIdTextField.text?.count == 17  || self.sireIdTextField.text?.count == 0{
                                            
                                        } else {
                                            if self.autoSuggestionStatus == true {
                                                
                                                
                                            } else {
                                                
                                                if self.pvid == 3 {
                                                    
                                                } else {
                                                    
                                                    self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                                                    return
                                                }
                                                
                                            }
                                        }
                                        if self.damtexfield.text?.count == 17  || self.damtexfield.text?.count == 0{
                                            
                                        } else {
                                            if self.pvid != 3 {
                                                
                                                self.validationId17SireDam(animalId: self.damtexfield.text!, tag: 4)
                                                return
                                            }
                                        }
                                        var selctionAuProvider = UserDefaults.standard.value(forKey: "ClickAuProvider") as? Bool
                                        //
                                        //                var dateVale = dateBtnOutlet.titleLabel?.text ?? ""
                                        //
                                        //                if dateVale == "" {
                                        //                    dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
                                        //                    calenderDobView.layer.borderColor = UIColor.red.cgColor
                                        //                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                        
                                        //                    if sireIdTextField.text!.count == 0 && selctionAuProvider == true{
                                        //                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                        //                        sireIdTextField.layer.borderColor = UIColor.red.cgColor
                                        //                        return
                                        //                    }
                                        
                                        //                    return
                                        //
                                        //                }
                                        //
                                        
                                        if self.borderRedCheck == false {
                                            
                                            //                        if selctionAuProvider == true {
                                            //
                                            //                            if sireIdTextField.text!.count == 0 {
                                            //
                                            //                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                            //                                sireIdTextField.layer.borderColor = UIColor.red.cgColor
                                            //                                return
                                            //
                                            //                            } else {
                                            self.addBtnCondtion(completionHandler: { (success) -> Void in
                                                if success == true{
                                                    self.borderRedCheck = true
                                                    
                                                    completionHandler(true)
                                                    
                                                }
                                            })
                                            
                                            
                                            //                        } else {
                                            //
                                            //
                                            //                            addBtnCondtion(completionHandler: { (success) -> Void in
                                            //                                if success == true{
                                            //                                    borderRedCheck = true
                                            //
                                            //                                    completionHandler(true)
                                            //
                                            //                                }
                                            //                            })
                                            //
                                            //
                                            //
                                            //                        }
                                            
                                            
                                            
                                            
                                        } else {
                                            
                                            if self.farmIdTextField.text?.count == 0 && !isCheckCountryUK() {
                                                
                                                self.farmIdView.layer.borderColor = UIColor.red.cgColor
                                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                                
                                                return
                                                
                                                
                                            } else  {
                                                self.view.makeToast(NSLocalizedString("Invalid Animal id.", comment: ""), duration: 2, position: .top)
                                                self.farmIdView.layer.borderColor = UIColor.red.cgColor
                                                
                                                return
                                                
                                            }
                                            
                                            
                                        }
                                    }
                                } else {
                                    // change button postion
                                    if self.scanBarcodeText.text == "" || self.scanAnimalTagText.text == "" {//|| dateBtnOutlet.titleLabel?.text == "" {
                                        
                                        if self.scanAnimalTagText.text!.count == 0 {
                                            self.officalTagView.layer.borderColor = UIColor.red.cgColor
                                            //farmIdView.textColor = UIColor.red
                                        } else {
                                            self.officalTagView.layer.borderColor = UIColor.gray.cgColor
                                            
                                            //  scanAnimalTagText.layer.borderColor = UIColor.gray.cgColor
                                            self.scanAnimalTagText.textColor = UIColor.black
                                        }
                                        if self.scanBarcodeText.text!.count == 0 {
                                            self.barcodeView.layer.borderColor = UIColor.red.cgColor
                                            self.scanBarcodeText.textColor = UIColor.red
                                        } else {
                                            self.barcodeView.layer.borderColor = UIColor.gray.cgColor
                                            self.scanBarcodeText.textColor = UIColor.black
                                        }
                                        
                                        //                if dateBtnOutlet.titleLabel?.text == "" {
                                        //                    dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
                                        //                    calenderDobView.layer.borderColor = UIColor.red.cgColor
                                        //                }
                                        
                                        //   if sireIdTextField.text!.count == 0 && selctionAuProvider == true{//
                                        //      sireIdTextField.layer.borderColor = UIColor.red.cgColor
                                        ///   } else {
                                        //      sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                                        
                                        //  }
                                        
                                        
                                        
                                        
                                        
                                        
                                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                        completionHandler(false)
                                        return
                                        
                                    } else {
                                        self.officalTagView.layer.borderColor = UIColor.gray.cgColor
                                        self.scanAnimalTagText.textColor = UIColor.black
                                        self.barcodeView.layer.borderColor = UIColor.gray.cgColor
                                        self.scanBarcodeText.textColor = UIColor.black
                                        
                                        
                                        if self.sireIdTextField.text?.count != 0 || self.damtexfield.text?.count != 0 {
                                            
                                            if self.sireIdTextField.text!.count == 0 {
                                                self.sireIdValidationB = false
                                                self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                                            }
                                            if self.damtexfield.text!.count == 0 {
                                                self.damIdValidationB = false
                                                self.damtexfield.layer.borderColor = UIColor.gray.cgColor
                                            }
                                            
                                            if self.ausBullId.contains(self.sireIdTextField.text?.uppercased()) || self.sireNationalID.contains(self.sireIdTextField.text?.uppercased()){
                                                self.sireIdValidationB = false
                                            }
                                            
                                            
                                            if  self.borderRedCheck == true || self.damIdValidationB == true || self.sireIdValidationB == true  {
                                                
                                               
                                                
                                                
                                                if self.sireIdTextField.text?.count != 0{
                                                    if self.sireIdValidationB  == true {
                                                        if self.autoSuggestionStatus == true {
                                                        }else{
                                                            
                                                            if self.pvid == 3 {
                                                                
                                                                self.sireIdTextField.layer.borderColor = UIColor.red.cgColor
                                                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Bull ID for this animal does not exist.", comment: ""))
                                                                return
                                                                
                                                                
                                                                
                                                            } else {
                                                                
                                                                self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                                                                return
                                                            }
                                                            
                                                        }
                                                    }
                                                } else {
                                                    self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                                                }
                                                
                                                if self.damtexfield.text?.count != 0{
                                                    
                                                    if self.damIdValidationB  == true {
                                                        if self.pvid != 3 {
                                                            
                                                            self.validationId17SireDam(animalId: self.damtexfield.text!, tag: 4)
                                                            
                                                            return
                                                        }
                                                    }
                                                } else {
                                                    self.damtexfield.layer.borderColor = UIColor.gray.cgColor
                                                }
                                                if self.borderRedCheck == true {
                                                    
                                                    self.officalTagView.layer.borderColor = UIColor.red.cgColor
                                                    self.view.makeToast( NSLocalizedString("Invalid Animal id.", comment: ""), duration: 2, position: .top)
                                                    
                                                    
                                                }
                                                
                                                
                                                
                                                
                                                return
                                            }
                                        }
                                        
                                        if self.scanAnimalTagText.text?.count == 17 {
                                        } else {
                                            self.borderRedCheck = true
                                            
                                        }
                                        if self.borderRedCheck == true {
                                            
                                            self.officalTagView.layer.borderColor = UIColor.red.cgColor
                                            self.view.makeToast( NSLocalizedString("Invalid Animal id.", comment: ""), duration: 2, position: .top)
                                            
                                            return
                                        } else {
                                            if self.sireIdTextField.text?.count == 17  || self.sireIdTextField.text?.count == 0{
                                                
                                            } else {
                                                if self.autoSuggestionStatus == true {
                                                }else{
                                                    if self.autoSuggestionStatus == true {
                                                    }else{
                                                        
                                                        if self.pvid == 3 {
                                                            
                                                        } else {
                                                            
                                                            self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                                                            return
                                                            
                                                        }
                                                    }
                                                }
                                            }
                                            if self.damtexfield.text?.count == 17  || self.damtexfield.text?.count == 0{
                                                
                                            } else {
                                                if self.pvid != 3 {
                                                    
                                                    self.validationId17SireDam(animalId: self.damtexfield.text!, tag: 4)
                                                    return
                                                }
                                                
                                            }
                                            //
                                            //                        if selctionAuProvider == true {
                                            //
                                            //                            if sireIdTextField.text!.count == 0 {
                                            //
                                            //                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                            //                                sireIdTextField.layer.borderColor = UIColor.red.cgColor
                                            //                                return
                                            //
                                            //                            } else {
                                            self.addBtnCondtion(completionHandler: { (success) -> Void in
                                                if success == true{
                                                    self.borderRedCheck = true
                                                    
                                                    completionHandler(true)
                                                    
                                                }
                                            })
                                            
                                            
                                            //                        } else {
                                            //
                                            //                            addBtnCondtion(completionHandler: { (success) -> Void in
                                            //                                if success == true{
                                            //                                    borderRedCheck = true
                                            //
                                            //                                    completionHandler(true)
                                            //
                                            //                                }
                                            //                            })
                                            //                        }
                                            
                                            
                                        }
                                    }
                                }
                                
                                if self.notificationLblCount.text != "0"{
                                    self.countLbl.isHidden = false
                                    self.notificationLblCount.isHidden = false
                                }
                            }))


                            alert.addAction(UIAlertAction(title: "Retrieve", style: .default, handler: { (_) in
                                self.fetchrecord = false
                                self.dataPopulateInFocusChange()
                            }))
                            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
                                self.fetchrecord = true
                            }))
                            self.present(alert, animated: true, completion: nil)
                            return
                        }
                   
                }
               
                if mainrecord == true
                {
                   // self.barcodeflag = false
                    mainrecord = false
                  let newcheck = fetchAllDataOrdercheck(entityName: "AnimalMaster", ordestatus: "true", animalTag:newanimaltagvalue ,userId: userId, animalBarcode: self.scanBarcodeText.text ?? "")
                  let newcheck2 = fetchAllDataOrdercheck(entityName: "AnimalMaster", ordestatus: "false", animalTag:newanimaltagvalue ,userId: userId, animalBarcode: self.scanBarcodeText.text ?? "")
                  let newcheck1 = fetchAllDataOrdercheck(entityName: "AnimaladdTbl", ordestatus: "false", animalTag:newanimaltagvalue ?? "",userId: userId, animalBarcode: self.scanBarcodeText.text ?? "")
                  let valuecheck = fetchAllDataofflicalID(entityName: "AnimaladdTbl", animalTag: newanimaltagvalue)
                  let valuecheck1 = fetchAllDataofflicalID(entityName: "AnimalMaster", animalTag: newanimaltagvalue)
                    print(newcheck)
                    print(newcheck1)

                        if newcheck.count > 0{
                            let newvalue1 = newcheck.object(at: 0) as? AnimalMaster
                            let alert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("The entered information has matched the OfficialID for a previously saved animal. Select action to proceed.", comment: ""), preferredStyle: .alert)

                            alert.addAction(UIAlertAction(title: NSLocalizedString("Overwrite", comment: ""), style: .default, handler: { [self]  (_) in
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal Record cannot be updated as the animal has been used for an order.", comment: ""))
                                self.mainrecord = true
                                //byDefaultSetting()
                            }))
                            alert.addAction(UIAlertAction(title: "Retrieve", style: .default, handler: { (_) in
                                self.mainrecord = false
                                self.dataPopulateInFocusChange()
                            }))
                            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
                                self.mainrecord = true
                            }))
                            self.present(alert, animated: true, completion: nil)
                            return
                           
                            
                            
                        }
                        
                        
                   
                    
                    else if newcheck1.count > 0 || newcheck2.count > 0 {
                       
                        
                        let alert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("The entered information has matched the OfficialID for a previously saved animal. Select action to proceed.", comment: ""), preferredStyle: .alert)

                        alert.addAction(UIAlertAction(title: NSLocalizedString("Overwrite", comment: ""), style: .default, handler: {  (_) in
                           
                            if self.screentext == "officialid"
                            {
                                if newcheck1.count > 0
                                {
                                    let newvalue1 = newcheck1.object(at: 0) as? AnimaladdTbl
                                self.isoverride  =  true
                                self.saveanimalID = newvalue1?.animalId ??  0
                                self.checkofsaveanimalid = true
                              self.newfarmid = newvalue1?.farmId ?? ""
                              self.newtextfieldfarmid = self.farmIdTextField.text ?? ""
                              print(self.newfarmid)
                             // self.scanAnimalTagText.text = self.newfarmid
                              if self.isoverride == true
                               {
                                  self.farmIdTextField.text = self.newfarmid
                                 
                              }
                                }
                                else if newcheck2.count > 0
                                {
                                    let newvalue2 = newcheck2.object(at: 0) as? AnimalMaster
                                    self.isoverride  =  true
                                    self.saveanimalID = newvalue2?.animalId ??  0
                                    self.checkofsaveanimalid = true
                                  self.newfarmid = newvalue2?.farmId ?? ""
                                  self.newtextfieldfarmid = self.farmIdTextField.text ?? ""
                                  print(self.newfarmid)
                                 // self.scanAnimalTagText.text = self.newfarmid
                                  if self.isoverride == true
                                   {
                                      self.farmIdTextField.text = self.newfarmid
                                     
                                  }
                                }
                            }
                            else
                            {
                           self.farmIdView.layer.borderColor = UIColor.gray.cgColor
                                if newcheck1.count > 0
                                {
                                    let newvalue1 = newcheck1.object(at: 0) as? AnimaladdTbl
                              self.isoverride  =  true
                            self.newfarmid = newvalue1?.farmId ?? ""
                            self.newtextfieldfarmid = self.scanAnimalTagText.text ?? ""
                            print(self.newfarmid)
                           // self.scanAnimalTagText.text = self.newfarmid
                            if self.isoverride == true
                             {
                                self.scanAnimalTagText.text = self.newfarmid
                               
                            }
                                }
                                else if newcheck2.count > 0
                                {
                                    let newvalue2 = newcheck2.object(at: 0) as? AnimalMaster
                                    self.isoverride  =  true
                                  self.newfarmid = newvalue2?.farmId ?? ""
                                  self.newtextfieldfarmid = self.scanAnimalTagText.text ?? ""
                                  print(self.newfarmid)
                                 // self.scanAnimalTagText.text = self.newfarmid
                                  if self.isoverride == true
                                   {
                                      self.scanAnimalTagText.text = self.newfarmid
                                     
                                  }
                                }
                            }
                        
                            if self.siraidcheck == true
                            {
                                self.sireIdTextField.layer.borderColor = UIColor.red.cgColor
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString("The SireID cannot be the same as the Official ID or the On Farm ID.", comment: ""))
                                self.siraidcheck = false
                                self.sireIdTextField.becomeFirstResponder()
                                return
                            }
   
                            
                            
                            let valueCheck = self.dateBtnOutlet.titleLabel?.text
                            
                            if valueCheck!.count != 0{
                                self.dateBtnOutlet.layer.borderColor = UIColor.gray.cgColor
                                self.calenderDobView.layer.borderColor = UIColor.gray.cgColor
                                
                            }
                            if self.damtexfield.text!.count == 0 {
                                self.damtexfield.layer.borderColor = UIColor.gray.cgColor
                            }
                            if self.sireIdTextField.text!.count == 0 {
                                self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                            }
                            if self.scanBarcodeText.text!.count == 0 {
                                self.barcodeView.layer.borderColor = UIColor.gray.cgColor
                            }
                            if self.dateTextField.text?.count == 0 {
                                
                                
                            } else if self.validateDateFlag == false || self.dateTextField.text?.count != 10{
                                
                                if self.dateTextField.text?.count == 10 {
                                    var validate = self.isValidDate(dateString: self.dateTextField.text ?? "")
                              
                                    
                                    if validate == "Correct Format" {
                                        self.dateBtnOutlet.layer.borderColor = UIColor.gray.cgColor
                                        self.dateBtnOutlet.layer.borderWidth = 0.5
                                        self.validateDateFlag = true
                                    } else {
                                        self.dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
                                      //  dateBtnOutlet.layer.borderWidth = 1
                                        self.validateDateFlag = false
                                        
                                        if validate == "GreaterThenDate" {
                                            
                                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Date of birth cannot be greater than current date.", comment: ""))
                                            return
                                        } else {
                                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Invalid date format.", comment: ""))
                                            return
                                        }
                                        
                                        return
                                        
                                    }
                                } else {
                                    self.dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
                                    self.validateDateFlag = false
                                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Invalid date format.", comment: ""))
                                    return
                                    
                                }
                            }
                            
                            
                            if self.statusOrder == true {
                                self.msgAnimalSucess = true
                                
                                let animalFetch = fetchAllDataWithAnimalId(entityName: "AnimalMaster", animalId: self.idAnimal, customerID: self.custmerId)
                                if animalFetch.count > 0{
                                    //dataPopulateInScreen(animalId: idAnimal)
                                    self.editIngText = true
                                    
                                    if self.msgAnimalSucess == false {
                                        
                                    } else {
                                        
                                    }
                                }
                            }
                            
                            
                            let selctionAuProvider = UserDefaults.standard.value(forKey: "ClickAuProvider") as? Bool
                            
                            
                            
                            if self.scanAnimalTagText.tag == 1{
                                
                                if self.scanAnimalTagText.text == "" || self.scanBarcodeText.text == ""  {
                                    
                                    if self.scanAnimalTagText.text!.count == 0 {
                                        self.officalTagView.layer.borderColor = UIColor.red.cgColor
                                    } else {
                                        self.officalTagView.layer.borderColor = UIColor.gray.cgColor
                                        self.scanAnimalTagText.textColor = UIColor.black
                                    }
                                    
                                    if self.scanBarcodeText.text!.count == 0 {
                                        self.barcodeView.layer.borderColor = UIColor.red.cgColor
                                        self.scanBarcodeText.textColor = UIColor.red
                                    } else {
                                        self.barcodeView.layer.borderColor = UIColor.gray.cgColor
                                        self.scanBarcodeText.textColor = UIColor.black
                                    }
                                    if self.damtexfield.text!.count == 0 {
                                        
                                        self.damtexfield.layer.borderColor = UIColor.gray.cgColor
                                    }
                                    if self.sireIdTextField.text!.count == 0 {
                                        
                                        self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                                    }
                                    if UserDefaults.standard.value(forKey: "isAuSelected") as? String == "True" {
                                        
                                      if self.farmIdTextField.text?.count == 0 && !self.isCheckCountryUK() {
                                            self.farmIdView.layer.borderColor = UIColor.red.cgColor
                                        } else if self.farmIdTextField.text?.count == 17 {
                                            
                                        }else {
                                            self.borderRedCheck = true
                                        }
                                        
                                    } else {
                                        if self.farmIdTextField.text?.count == 0 {
                                            self.farmIdView.layer.borderColor = UIColor.gray.cgColor
                                        }
                                    }
                                    
                                    
                                    //                    if selctionAuProvider == true {
                                    //
                                    //                        if sireIdTextField.text!.count == 0 {
                                    //
                                    //                            sireIdTextField.layer.borderColor = UIColor.red.cgColor
                                    //                        }}
                                    //                var dateVale = dateBtnOutlet.titleLabel?.text ?? ""
                                    //
                                    //                if dateVale == "" {
                                    //                    dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
                                    //                    calenderDobView.layer.borderColor = UIColor.red.cgColor
                                    //                }
                                    
                                    
                                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                    return
                                    
                                } else {
                                    
                                    self.officalTagView.layer.borderColor = UIColor.gray.cgColor
                                    self.scanAnimalTagText.textColor = UIColor.black
                                    self.barcodeView.layer.borderColor = UIColor.gray.cgColor
                                    self.scanBarcodeText.textColor = UIColor.black
                                    
                                    if UserDefaults.standard.value(forKey: "isAuSelected") as? String == "True" {
                                        
                                      if self.farmIdTextField.text?.count == 0 && !self.isCheckCountryUK() {
                                            self.farmIdView.layer.borderColor = UIColor.red.cgColor
                                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                            return
                                            
                                        } else if self.farmIdTextField.text?.count == 17 {
                                            
                                        } else {
                                            self.borderRedCheck = true
                                        }
                                        
                                    } else {
                                        if self.farmIdTextField.text?.count == 0 {
                                            self.farmIdView.layer.borderColor = UIColor.gray.cgColor
                                            self.borderRedCheck = false
                                        } else if self.farmIdTextField.text?.count == 17 {
                                            
                                            //     self.validationId17(animalId: (farmIdTextField.text?.uppercased())!)
                                            
                                        } else {
                                            self.borderRedCheck = true
                                        }
                                        
                                    }
                                    
                                    
                                    
                                    
                                    if self.sireIdTextField.text?.count != 0 || self.damtexfield.text?.count != 0 {
                                        
                                        if self.sireIdTextField.text!.count == 0 {
                                            self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                                        }
                                        if self.damtexfield.text!.count == 0 {
                                            self.damtexfield.layer.borderColor = UIColor.gray.cgColor
                                        }
                                        
                                        
                                        if self.sireIdTextField.text?.count == 0{
                                            self.sireIdValidationB = false
                                        }
                                        
                                        if self.damtexfield.text?.count == 0{
                                            self.damIdValidationB = false
                                        }
                                        
                                        if self.ausBullId.contains(self.sireIdTextField.text?.uppercased()) || self.sireNationalID.contains(self.sireIdTextField.text?.uppercased()){
                                            self.sireIdValidationB = false
                                        }
                                        
                                        if self.borderRedCheck == true || self.damIdValidationB == true || self.sireIdValidationB == true  {
                                           
                                            if self.sireIdTextField.text?.count != 0{
                                                if self.sireIdValidationB  == true {
                                                    // if autoSuggestionStatus == true {
                                                    //   }else{
                                                    
                                                    if self.pvid == 3 {
                                                        // sireIdValidationB = false
                                                        
                                                        
                                                        if self.ausBullId.contains(self.sireIdTextField.text?.uppercased()) || self.sireNationalID.contains(self.sireIdTextField.text?.uppercased()){
                                                            
                                                        } else {
                                                            self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                                                            return
                                                            //                                            sireIdTextField.layer.borderColor = UIColor.red.cgColor
                                                            //                                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Bull ID for this animal does not exist.", comment: ""))
                                                            //                                            return
                                                        }
                                                    } else {
                                                        
                                                        self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                                                        return
                                                    }
                                                    
                                                    // }
                                                } else{
                                                    if self.sireIdTextField.text?.count == 17 {
                                                        
                                                    } else {
                                                        if self.autoSuggestionStatus == true {
                                                        }else{
                                                            
                                                            if self.pvid == 3 {
                                                                
                                                            } else {
                                                                
                                                                self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                                                                return
                                                            }
                                                            
                                                        }}                    }
                                            } else {
                                                self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                                            }
                                            
                                            if self.damtexfield.text?.count != 0{
                                                
                                                if self.damIdValidationB  == true {
                                                    
                                                    if self.pvid != 3 {
                                                        self.validationId17SireDam(animalId: self.damtexfield.text!, tag: 4)
                                                        return
                                                        
                                                    }
                                                    
                                                    
                                                    //                                validationId17SireDam(animalId: damtexfield.text!, tag: 4)
                                                    //                                return
                                                }else {
                                                    
                                                    if self.damtexfield.text?.count == 17 {
                                                    }else{
                                                        if self.pvid != 3 {
                                                            
                                                            self.validationId17SireDam(animalId: self.damtexfield.text!, tag: 4)
                                                            return
                                                        }
                                                    }
                                                    
                                                }
                                            } else {
                                                self.damtexfield.layer.borderColor = UIColor.gray.cgColor
                                            }
                                            
                                            
                                            if self.borderRedCheck == true {
                                                self.view.makeToast(NSLocalizedString("Invalid Animal id.", comment: ""), duration: 2, position: .top)
                                                self.farmIdView.layer.borderColor = UIColor.red.cgColor
                                            }
                                            
                                            return
                                        }
                                    } else {
                                        
                                        self.damtexfield.layer.borderColor = UIColor.gray.cgColor
                                        self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                                    }
                                    
                                    
                                    if UserDefaults.standard.value(forKey: "isAuSelected") as? String == "True" {
                                        
                                    } else {
                                        if self.farmIdTextField.text!.count == 0 {
                                            self.borderRedCheck = false
                                        }
                                    }
                                    if self.sireIdTextField.text?.count == 17  || self.sireIdTextField.text?.count == 0{
                                        
                                    } else {
                                        if self.autoSuggestionStatus == true {
                                            
                                            
                                        } else {
                                            
                                            if self.pvid == 3 {
                                                
                                            } else {
                                                
                                                self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                                                return
                                            }
                                            
                                        }
                                    }
                                    if self.damtexfield.text?.count == 17  || self.damtexfield.text?.count == 0{
                                        
                                    } else {
                                        if self.pvid != 3 {
                                            
                                            self.validationId17SireDam(animalId: self.damtexfield.text!, tag: 4)
                                            return
                                        }
                                    }
                                    var selctionAuProvider = UserDefaults.standard.value(forKey: "ClickAuProvider") as? Bool
                                    //
                                    //                var dateVale = dateBtnOutlet.titleLabel?.text ?? ""
                                    //
                                    //                if dateVale == "" {
                                    //                    dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
                                    //                    calenderDobView.layer.borderColor = UIColor.red.cgColor
                                    //                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                    
                                    //                    if sireIdTextField.text!.count == 0 && selctionAuProvider == true{
                                    //                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                    //                        sireIdTextField.layer.borderColor = UIColor.red.cgColor
                                    //                        return
                                    //                    }
                                    
                                    //                    return
                                    //
                                    //                }
                                    //
                                    
                                    if self.borderRedCheck == false {
                                        
                                        //                        if selctionAuProvider == true {
                                        //
                                        //                            if sireIdTextField.text!.count == 0 {
                                        //
                                        //                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                        //                                sireIdTextField.layer.borderColor = UIColor.red.cgColor
                                        //                                return
                                        //
                                        //                            } else {
                                        self.addBtnCondtion(completionHandler: { (success) -> Void in
                                            if success == true{
                                                self.borderRedCheck = true
                                                
                                                completionHandler(true)
                                                
                                            }
                                        })
                                        
                                        
                                        //                        } else {
                                        //
                                        //
                                        //                            addBtnCondtion(completionHandler: { (success) -> Void in
                                        //                                if success == true{
                                        //                                    borderRedCheck = true
                                        //
                                        //                                    completionHandler(true)
                                        //
                                        //                                }
                                        //                            })
                                        //
                                        //
                                        //
                                        //                        }
                                        
                                        
                                        
                                        
                                    } else {
                                        
                                      if self.farmIdTextField.text?.count == 0 && !self.isCheckCountryUK() {
                                            
                                            self.farmIdView.layer.borderColor = UIColor.red.cgColor
                                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                            
                                            return
                                            
                                            
                                        } else  {
                                            self.view.makeToast(NSLocalizedString("Invalid Animal id.", comment: ""), duration: 2, position: .top)
                                            self.farmIdView.layer.borderColor = UIColor.red.cgColor
                                            
                                            return
                                            
                                        }
                                        
                                        
                                    }
                                }
                            } else {
                                // change button postion
                                if self.scanBarcodeText.text == "" || self.scanAnimalTagText.text == "" {//|| dateBtnOutlet.titleLabel?.text == "" {
                                    
                                    if self.scanAnimalTagText.text!.count == 0 {
                                        self.officalTagView.layer.borderColor = UIColor.red.cgColor
                                        //farmIdView.textColor = UIColor.red
                                    } else {
                                        self.officalTagView.layer.borderColor = UIColor.gray.cgColor
                                        
                                        //  scanAnimalTagText.layer.borderColor = UIColor.gray.cgColor
                                        self.scanAnimalTagText.textColor = UIColor.black
                                    }
                                    if self.scanBarcodeText.text!.count == 0 {
                                        self.barcodeView.layer.borderColor = UIColor.red.cgColor
                                        self.scanBarcodeText.textColor = UIColor.red
                                    } else {
                                        self.barcodeView.layer.borderColor = UIColor.gray.cgColor
                                        self.scanBarcodeText.textColor = UIColor.black
                                    }
                                    
                                    //                if dateBtnOutlet.titleLabel?.text == "" {
                                    //                    dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
                                    //                    calenderDobView.layer.borderColor = UIColor.red.cgColor
                                    //                }
                                    
                                    //   if sireIdTextField.text!.count == 0 && selctionAuProvider == true{//
                                    //      sireIdTextField.layer.borderColor = UIColor.red.cgColor
                                    ///   } else {
                                    //      sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                                    
                                    //  }
                                    
                                    
                                    
                                    
                                    
                                    
                                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                    completionHandler(false)
                                    return
                                    
                                } else {
                                    self.officalTagView.layer.borderColor = UIColor.gray.cgColor
                                    self.scanAnimalTagText.textColor = UIColor.black
                                    self.barcodeView.layer.borderColor = UIColor.gray.cgColor
                                    self.scanBarcodeText.textColor = UIColor.black
                                    
                                    
                                    if self.sireIdTextField.text?.count != 0 || self.damtexfield.text?.count != 0 {
                                        
                                        if self.sireIdTextField.text!.count == 0 {
                                            self.sireIdValidationB = false
                                            self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                                        }
                                        if self.damtexfield.text!.count == 0 {
                                            self.damIdValidationB = false
                                            self.damtexfield.layer.borderColor = UIColor.gray.cgColor
                                        }
                                        
                                        if self.ausBullId.contains(self.sireIdTextField.text?.uppercased()) || self.sireNationalID.contains(self.sireIdTextField.text?.uppercased()){
                                            self.sireIdValidationB = false
                                        }
                                        
                                        
                                        if  self.borderRedCheck == true || self.damIdValidationB == true || self.sireIdValidationB == true  {
                                            
                                           
                                            
                                            
                                            if self.sireIdTextField.text?.count != 0{
                                                if self.sireIdValidationB  == true {
                                                    if self.autoSuggestionStatus == true {
                                                    }else{
                                                        
                                                        if self.pvid == 3 {
                                                            
                                                            self.sireIdTextField.layer.borderColor = UIColor.red.cgColor
                                                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Bull ID for this animal does not exist.", comment: ""))
                                                            return
                                                            
                                                            
                                                            
                                                        } else {
                                                            
                                                            self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                                                            return
                                                        }
                                                        
                                                    }
                                                }
                                            } else {
                                                self.sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                                            }
                                            
                                            if self.damtexfield.text?.count != 0{
                                                
                                                if self.damIdValidationB  == true {
                                                    if self.pvid != 3 {
                                                        
                                                        self.validationId17SireDam(animalId: self.damtexfield.text!, tag: 4)
                                                        
                                                        return
                                                    }
                                                }
                                            } else {
                                                self.damtexfield.layer.borderColor = UIColor.gray.cgColor
                                            }
                                            if self.borderRedCheck == true {
                                                
                                                self.officalTagView.layer.borderColor = UIColor.red.cgColor
                                                self.view.makeToast( NSLocalizedString("Invalid Animal id.", comment: ""), duration: 2, position: .top)
                                                
                                            }
                                            
                                            return
                                        }
                                    }
                                    
                                    if self.scanAnimalTagText.text?.count == 17 {
                                    } else {
                                        self.borderRedCheck = true
                                        
                                    }
                                    if self.borderRedCheck == true {
                                        
                                        self.officalTagView.layer.borderColor = UIColor.red.cgColor
                                        self.view.makeToast( NSLocalizedString("Invalid Animal id.", comment: ""), duration: 2, position: .top)
                                        
                                        return
                                    } else {
                                        if self.sireIdTextField.text?.count == 17  || self.sireIdTextField.text?.count == 0{
                                            
                                        } else {
                                            if self.autoSuggestionStatus == true {
                                            }else{
                                                if self.autoSuggestionStatus == true {
                                                }else{
                                                    
                                                    if self.pvid == 3 {
                                                        
                                                    } else {
                                                        
                                                        self.validationId17SireDam(animalId: self.sireIdTextField.text!, tag: 3)
                                                        return
                                                        
                                                    }
                                                }
                                            }
                                        }
                                        if self.damtexfield.text?.count == 17  || self.damtexfield.text?.count == 0{
                                            
                                        } else {
                                            if self.pvid != 3 {
                                                
                                                self.validationId17SireDam(animalId: self.damtexfield.text!, tag: 4)
                                                return
                                            }
                                            
                                        }
                                        //
                                        //                        if selctionAuProvider == true {
                                        //
                                        //                            if sireIdTextField.text!.count == 0 {
                                        //
                                        //                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                        //                                sireIdTextField.layer.borderColor = UIColor.red.cgColor
                                        //                                return
                                        //
                                        //                            } else {
                                        self.addBtnCondtion(completionHandler: { (success) -> Void in
                                            if success == true{
                                                self.borderRedCheck = true
                                                
                                                completionHandler(true)
                                                
                                            }
                                        })
                                        
                                        
                                        //                        } else {
                                        //
                                        //                            addBtnCondtion(completionHandler: { (success) -> Void in
                                        //                                if success == true{
                                        //                                    borderRedCheck = true
                                        //
                                        //                                    completionHandler(true)
                                        //
                                        //                                }
                                        //                            })
                                        //                        }
                                        
                                        
                                    }
                                }
                            }
                            
                            if self.notificationLblCount.text != "0"{
                                self.countLbl.isHidden = false
                                self.notificationLblCount.isHidden = false
                            }
                        }))


                        alert.addAction(UIAlertAction(title: "Retrieve", style: .default, handler: { (_) in
                            self.mainrecord = false
                            self.dataPopulateInFocusChange()
                        }))
                        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
                            self.mainrecord = true
                        }))
                        self.present(alert, animated: true, completion: nil)
                        return
                    }
                }
                
                 if screentext == "officialid"
                 {
                     if isoverride == true
                      {
                         self.farmIdTextField.text = self.newfarmid
                         isoverride = false
                     }
                 }
                else
                {
                if isoverride == true
                 {
                    scanAnimalTagText.text = newfarmid
                    isoverride = false
                }
                }
                if siraidcheck == true
                {
                    sireIdTextField.layer.borderColor = UIColor.red.cgColor
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("The Sire ID cannot be the same as the Official ID or the On Farm ID.", comment: ""))
                    self.siraidcheck = false
                    sireIdTextField.becomeFirstResponder()
                    return
                }
  
                
                
                let valueCheck = dateBtnOutlet.titleLabel?.text
                
                if valueCheck!.count != 0{
                    dateBtnOutlet.layer.borderColor = UIColor.gray.cgColor
                    calenderDobView.layer.borderColor = UIColor.gray.cgColor
                    
                }
                if damtexfield.text!.count == 0 {
                    damtexfield.layer.borderColor = UIColor.gray.cgColor
                }
                if sireIdTextField.text!.count == 0 {
                    sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                }
                if scanBarcodeText.text!.count == 0 {
                    barcodeView.layer.borderColor = UIColor.gray.cgColor
                }
                if dateTextField.text?.count == 0 {
                    
                    
                } else if validateDateFlag == false || dateTextField.text?.count != 10{
                    
                    if dateTextField.text?.count == 10 {
                    var validate = isValidDate(dateString: dateTextField.text ?? "")
                  
                        
                        if validate == "Correct Format" {
                            dateBtnOutlet.layer.borderColor = UIColor.gray.cgColor
                            dateBtnOutlet.layer.borderWidth = 0.5
                            validateDateFlag = true
                        } else {
                            dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
                          //  dateBtnOutlet.layer.borderWidth = 1
                            validateDateFlag = false
                            
                            if validate == "GreaterThenDate" {
                                
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Date of birth cannot be greater than current date.", comment: ""))
                                return
                            } else {
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Invalid date format.", comment: ""))
                                return
                            }
                            
                            return
                            
                        }
                    } else {
                        dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
                        validateDateFlag = false
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Invalid date format.", comment: ""))
                        return
                        
                    }
                }
                
                
                if statusOrder == true {
                    msgAnimalSucess = true
                    
                    let animalFetch = fetchAllDataWithAnimalId(entityName: "AnimalMaster", animalId: idAnimal, customerID: custmerId)
                    if animalFetch.count > 0{
                        //dataPopulateInScreen(animalId: idAnimal)
                        editIngText = true
                        
                        if msgAnimalSucess == false {
                            
                        } else {
                            
                        }
                    }
                }
                
                
                let selctionAuProvider = UserDefaults.standard.value(forKey: "ClickAuProvider") as? Bool
                
                
                
                if scanAnimalTagText.tag == 1{
                    
                    if scanAnimalTagText.text == "" || scanBarcodeText.text == ""  {
                        
                        if scanAnimalTagText.text!.count == 0 {
                            officalTagView.layer.borderColor = UIColor.red.cgColor
                        } else {
                            officalTagView.layer.borderColor = UIColor.gray.cgColor
                            scanAnimalTagText.textColor = UIColor.black
                        }
                        
                        if scanBarcodeText.text!.count == 0 {
                            barcodeView.layer.borderColor = UIColor.red.cgColor
                            scanBarcodeText.textColor = UIColor.red
                        } else {
                            barcodeView.layer.borderColor = UIColor.gray.cgColor
                            scanBarcodeText.textColor = UIColor.black
                        }
                        if damtexfield.text!.count == 0 {
                            
                            damtexfield.layer.borderColor = UIColor.gray.cgColor
                        }
                        if sireIdTextField.text!.count == 0 {
                            
                            sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                        }
                        if UserDefaults.standard.value(forKey: "isAuSelected") as? String == "True" {
                            
                            if farmIdTextField.text?.count == 0 && !isCheckCountryUK() {
                                farmIdView.layer.borderColor = UIColor.red.cgColor
                            } else if farmIdTextField.text?.count == 17 {
                                
                            }else {
                                borderRedCheck = true
                            }
                            
                        } else {
                            if farmIdTextField.text?.count == 0 {
                                farmIdView.layer.borderColor = UIColor.gray.cgColor
                            }
                        }
                        
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                        return
                        
                    } else {
                        
                        officalTagView.layer.borderColor = UIColor.gray.cgColor
                        scanAnimalTagText.textColor = UIColor.black
                        barcodeView.layer.borderColor = UIColor.gray.cgColor
                        scanBarcodeText.textColor = UIColor.black
                        
                        if UserDefaults.standard.value(forKey: "isAuSelected") as? String == "True" {
                            
                            if farmIdTextField.text?.count == 0 && !isCheckCountryUK() {
                                farmIdView.layer.borderColor = UIColor.red.cgColor
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                return
                                
                            } else if farmIdTextField.text?.count == 17 {
                                
                            } else {
                                borderRedCheck = true
                            }
                            
                        } else {
                            if farmIdTextField.text?.count == 0 {
                                farmIdView.layer.borderColor = UIColor.gray.cgColor
                                borderRedCheck = false
                            } else if farmIdTextField.text?.count == 17 {
                                
                                //     self.validationId17(animalId: (farmIdTextField.text?.uppercased())!)
                                
                            } else {
                                borderRedCheck = true
                            }
                            
                        }
                        
                        
                        
                        
                        if sireIdTextField.text?.count != 0 || damtexfield.text?.count != 0 {
                            
                            if sireIdTextField.text!.count == 0 {
                                sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                            }
                            if damtexfield.text!.count == 0 {
                                damtexfield.layer.borderColor = UIColor.gray.cgColor
                            }
                            
                            
                            if sireIdTextField.text?.count == 0{
                                sireIdValidationB = false
                            }
                            
                            if damtexfield.text?.count == 0{
                                damIdValidationB = false
                            }
                            
                            if ausBullId.contains(sireIdTextField.text?.uppercased()) || sireNationalID.contains(sireIdTextField.text?.uppercased()){
                                sireIdValidationB = false
                            }
                            
                            if borderRedCheck == true || damIdValidationB == true || sireIdValidationB == true  {
                                
                                
                                
                                
                                if sireIdTextField.text?.count != 0{
                                    if sireIdValidationB  == true {
                                        // if autoSuggestionStatus == true {
                                        //   }else{
                                        
                                        if pvid == 3 {
                                            // sireIdValidationB = false
                                            
                                            
                                            if ausBullId.contains(sireIdTextField.text?.uppercased()) || sireNationalID.contains(sireIdTextField.text?.uppercased()){
                                                
                                            } else {
                                                validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                                                return
                                                //                                            sireIdTextField.layer.borderColor = UIColor.red.cgColor
                                                //                                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Bull ID for this animal does not exist.", comment: ""))
                                                //                                            return
                                            }
                                        } else {
                                            
                                            validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                                            return
                                        }
                                        
                                        // }
                                    } else{
                                        if sireIdTextField.text?.count == 17 {
                                            
                                        } else {
                                            if autoSuggestionStatus == true {
                                            }else{
                                                
                                                if pvid == 3 {
                                                    
                                                } else {
                                                    
                                                    validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                                                    return
                                                }
                                                
                                            }}                    }
                                } else {
                                    sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                                }
                                
                                if damtexfield.text?.count != 0{
                                    
                                    if damIdValidationB  == true {
                                        
                                        if pvid != 3 {
                                            validationId17SireDam(animalId: damtexfield.text!, tag: 4)
                                            return
                                            
                                        }
                                        
                                        
                                        //                                validationId17SireDam(animalId: damtexfield.text!, tag: 4)
                                        //                                return
                                    }else {
                                        
                                        if damtexfield.text?.count == 17 {
                                        }else{
                                            if pvid != 3 {
                                                
                                                validationId17SireDam(animalId: damtexfield.text!, tag: 4)
                                                return
                                            }
                                        }
                                        
                                    }
                                } else {
                                    damtexfield.layer.borderColor = UIColor.gray.cgColor
                                }
                                
                                
                                if borderRedCheck == true {
                                    self.view.makeToast(NSLocalizedString("Invalid Animal id.", comment: ""), duration: 2, position: .top)
                                    farmIdView.layer.borderColor = UIColor.red.cgColor
                                }
                                
                                return
                            }
                        } else {
                            
                            damtexfield.layer.borderColor = UIColor.gray.cgColor
                            sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                        }
                        
                        
                        if UserDefaults.standard.value(forKey: "isAuSelected") as? String == "True" {
                            
                        } else {
                            if farmIdTextField.text!.count == 0 {
                                borderRedCheck = false
                            }
                        }
                        if sireIdTextField.text?.count == 17  || sireIdTextField.text?.count == 0{
                            
                        } else {
                            if autoSuggestionStatus == true {
                                
                                
                            } else {
                                
                                if pvid == 3 {
                                    
                                } else {
                                    
                                    validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                                    return
                                }
                                
                            }
                        }
                        if damtexfield.text?.count == 17  || damtexfield.text?.count == 0{
                            
                        } else {
                            if pvid != 3 {
                                
                                validationId17SireDam(animalId: damtexfield.text!, tag: 4)
                                return
                            }
                        }
                        var selctionAuProvider = UserDefaults.standard.value(forKey: "ClickAuProvider") as? Bool
                        //
                        //                var dateVale = dateBtnOutlet.titleLabel?.text ?? ""
                        //
                        //                if dateVale == "" {
                        //                    dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
                        //                    calenderDobView.layer.borderColor = UIColor.red.cgColor
                        //                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                        
                        //                    if sireIdTextField.text!.count == 0 && selctionAuProvider == true{
                        //                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                        //                        sireIdTextField.layer.borderColor = UIColor.red.cgColor
                        //                        return
                        //                    }
                        
                        //                    return
                        //
                        //                }
                        //
                        
                        if borderRedCheck == false {
                            
                            //                        if selctionAuProvider == true {
                            //
                            //                            if sireIdTextField.text!.count == 0 {
                            //
                            //                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                            //                                sireIdTextField.layer.borderColor = UIColor.red.cgColor
                            //                                return
                            //
                            //                            } else {
                            addBtnCondtion(completionHandler: { (success) -> Void in
                                if success == true{
                                    borderRedCheck = true
                                    completionHandler(true)
                                    
                                }
                            })
                        } else {
                            
                            if farmIdTextField.text?.count == 0 && !isCheckCountryUK() {
                                
                                farmIdView.layer.borderColor = UIColor.red.cgColor
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                                
                                return
                                
                                
                            } else  {
                                self.view.makeToast(NSLocalizedString("Invalid Animal id.", comment: ""), duration: 2, position: .top)
                                farmIdView.layer.borderColor = UIColor.red.cgColor
                                
                                return
                                
                            }
                            
                            
                        }
                    }
                } else {
                    // change button postion
                    if scanBarcodeText.text == "" || scanAnimalTagText.text == "" {//|| dateBtnOutlet.titleLabel?.text == "" {
                        
                        if scanAnimalTagText.text!.count == 0 {
                            officalTagView.layer.borderColor = UIColor.red.cgColor
                            //farmIdView.textColor = UIColor.red
                        } else {
                            officalTagView.layer.borderColor = UIColor.gray.cgColor
                            
                            //  scanAnimalTagText.layer.borderColor = UIColor.gray.cgColor
                            scanAnimalTagText.textColor = UIColor.black
                        }
                        if scanBarcodeText.text!.count == 0 {
                            barcodeView.layer.borderColor = UIColor.red.cgColor
                            scanBarcodeText.textColor = UIColor.red
                        } else {
                            barcodeView.layer.borderColor = UIColor.gray.cgColor
                            scanBarcodeText.textColor = UIColor.black
                        }
                        
                        //                if dateBtnOutlet.titleLabel?.text == "" {
                        //                    dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
                        //                    calenderDobView.layer.borderColor = UIColor.red.cgColor
                        //                }
                        
                        //   if sireIdTextField.text!.count == 0 && selctionAuProvider == true{//
                        //      sireIdTextField.layer.borderColor = UIColor.red.cgColor
                        ///   } else {
                        //      sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                        
                        //  }
                        
                        
                        
                        
                        
                        
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                        completionHandler(false)
                        return
                        
                    } else {
                        officalTagView.layer.borderColor = UIColor.gray.cgColor
                        scanAnimalTagText.textColor = UIColor.black
                        barcodeView.layer.borderColor = UIColor.gray.cgColor
                        scanBarcodeText.textColor = UIColor.black
                        
                        
                        if sireIdTextField.text?.count != 0 || damtexfield.text?.count != 0 {
                            
                            if sireIdTextField.text!.count == 0 {
                                sireIdValidationB = false
                                sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                            }
                            if damtexfield.text!.count == 0 {
                                damIdValidationB = false
                                damtexfield.layer.borderColor = UIColor.gray.cgColor
                            }
                            
                            if ausBullId.contains(sireIdTextField.text?.uppercased()) || sireNationalID.contains(sireIdTextField.text?.uppercased()){
                                sireIdValidationB = false
                            }
                            
                            
                            if  borderRedCheck == true || damIdValidationB == true || sireIdValidationB == true  {
                                
                               
                                
                                
                                if sireIdTextField.text?.count != 0{
                                    if sireIdValidationB  == true {
                                        if autoSuggestionStatus == true {
                                        }else{
                                            
                                            if pvid == 3 {
                                                
                                                sireIdTextField.layer.borderColor = UIColor.red.cgColor
                                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Bull ID for this animal does not exist.", comment: ""))
                                                return
                                                
                                                
                                                
                                            } else {
                                                
                                                validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                                                return
                                            }
                                            
                                        }
                                    }
                                } else {
                                    sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                                }
                                
                                if damtexfield.text?.count != 0{
                                    
                                    if damIdValidationB  == true {
                                        if pvid != 3 {
                                            
                                            validationId17SireDam(animalId: damtexfield.text!, tag: 4)
                                            
                                            return
                                        }
                                    }
                                } else {
                                    damtexfield.layer.borderColor = UIColor.gray.cgColor
                                }
                                if borderRedCheck == true {
                                    
                                    officalTagView.layer.borderColor = UIColor.red.cgColor
                                    self.view.makeToast( NSLocalizedString("Invalid Animal id.", comment: ""), duration: 2, position: .top)
                                    
                                    
                                }
                                return
                            }
                        }
                        
                        if scanAnimalTagText.text?.count == 17 {
                          borderRedCheck = false
                        } else {
                            borderRedCheck = true
                            
                        }
                        if borderRedCheck == true {
                            
                            officalTagView.layer.borderColor = UIColor.red.cgColor
                            self.view.makeToast( NSLocalizedString("Invalid Animal id.", comment: ""), duration: 2, position: .top)
                            
                            return
                        } else {
                            if sireIdTextField.text?.count == 17  || sireIdTextField.text?.count == 0{
                                
                            } else {
                                if autoSuggestionStatus == true {
                                }else{
                                    if autoSuggestionStatus == true {
                                    }else{
                                        
                                        if pvid == 3 {
                                            
                                        } else {
                                            
                                            validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                                            return
                                            
                                        }
                                    }
                                }
                            }
                            if damtexfield.text?.count == 17  || damtexfield.text?.count == 0{
                                
                            } else {
                                if pvid != 3 {
                                    
                                    validationId17SireDam(animalId: damtexfield.text!, tag: 4)
                                    return
                                }
                                
                            }
                           
                            addBtnCondtion(completionHandler: { (success) -> Void in
                                if success == true{
                                    borderRedCheck = true
                                    
                                    completionHandler(true)
                                    
                                }
                            })
                            
                            
                            
                        }
                    }
                }
                
                if notificationLblCount.text != "0"{
                    countLbl.isHidden = false
                    notificationLblCount.isHidden = false
                }
           createDataList()
            }
    
    //MARK: ADD ANIMAL BUTTON CONDITION
    func addBtnCondtion(completionHandler: CompletionHandler){
        if checkBarcode == true {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.barcodeMustEndWithNumAlert, comment: ""))
            return
        }
        
        if tissueBtnOutlet.titleLabel?.text == nil || tissueBtnOutlet.titleLabel?.text == "" {
            tissueBtnOutlet.layer.borderColor = UIColor.red.cgColor
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
            return
        }
        
        var dateVale = ""
        let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            dateVale = dateTextField.text ?? ""
            
        } else {
            dateVale = dateBtnOutlet.titleLabel?.text ?? ""
            
        }
        let codeId = fetchBreedDataTissueCode(entityName: Entities.getSampleTblEntity,provId: self.pvid,tissueName:(sampleName))
        let naabFetch1 = codeId.value(forKey: keyValue.sampleId.rawValue) as? NSArray
        if naabFetch1!.count != 0 {
            let breedIdGet = naabFetch1![0] as? Int
            self.tissuId = breedIdGet!
        }
        let codeId1 = fetchBreedDatabreedCode( entityName: Entities.getBreedsTblEntity,provId: self.pvid,breedCode:(self.breedBtnOutlet.titleLabel?.text)!)
        let naabFetch11 = codeId1.value(forKey: keyValue.breedId.rawValue) as? NSArray
        if naabFetch11!.count == 0 {
            
        } else {
            let breedIdGet = (naabFetch11![0] as? String)!
            self.breedId = breedIdGet
            UserDefaults.standard.set(self.breedId, forKey: keyValue.breed.rawValue)
            
        }
        if dateTextField.text?.count == 0 {
            
            
        }
        else {
            if dateTextField.text?.count == 10 {
                let validate = isValidDate(dateString: dateTextField.text ?? "")
                if validate == LocalizedStrings.correctFormatStr {
                    dateBtnOutlet.layer.borderColor = UIColor.gray.cgColor
                    dateBtnOutlet.layer.borderWidth = 0.5
                    validateDateFlag = true
                } else {
                    dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
                    validateDateFlag = false
                    
                    if validate == LocalizedStrings.greaterThenDateStr {
                        
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.dobSmallerthanCurrDate, comment: ""))
                        return
                    } else {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
                        return
                    }
                    return
                    
                }
            } else {
                dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
                validateDateFlag = false
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
                return
            }
        }
        
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            dateVale = dateTextField.text ?? ""
            if dateVale != "" {
                if dateStr == "DD"{
                    dateVale = dateTextField.text ?? ""
                }
                else {
                    
                    let values = dateVale.components(separatedBy: "/")
                    let date = values[0]
                    let month = values[1]
                    let year = values[2]
                    dateVale = month + "/" + date + "/" + year
                }
            }
        } else {
            if dateVale != "" {
                if dateStr == "DD"{
                    dateVale = dateBtnOutlet.titleLabel?.text ?? ""
                }
                else {
                    
                    let values = dateVale.components(separatedBy: "/")
                    let date = values[0]
                    let month = values[1]
                    let year = values[2]
                    dateVale = date + "/" + month + "/" + year
                    
                }}
            
        }
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        
        if scanAnimalTagText.tag == 0 {
            scanAnimalText = scanAnimalTagText.text!
            farmIdText = farmIdTextField.text!
        }
        else {
            
            scanAnimalText = farmIdTextField.text!
            farmIdText = scanAnimalTagText.text!
        }
        
        if barcodeflag == true {
            let barCode = fetchAnimaldataValidateAnimalBarcodeanimalIdOrderId(entityName: Entities.animalAddTblEntity, animalbarCodeTag: scanBarcodeText.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"false",orderid:orderId,custId:custmerId)
            if barCode.count > 0 && !iscomingFromCart {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sampleAlreadyExists, comment: ""))
                barcodeView.layer.borderColor = UIColor.red.cgColor
                
                return
            }
        }
        
        let fetchListId = fetchAnimaldataValidateFamIDGetListId(entityName: Entities.animalAddTblEntity,farmId:scanAnimalTagText.text ?? "",custmerId: custmerId , userId: userId) as! [AnimaladdTbl]
        if fetchListId.count != 0 {
            let listIdGetObject = fetchListId.filter({ $0.orderstatus == "false"})
            if listIdGetObject.count > 0{
                self.listIdGet = Int(listIdGetObject[0].listId)
                self.animalId1 = Int(listIdGetObject[0].animalId)
                msgUpatedd = true
            }
        }
        
        if checkofsaveanimalid == true{
            if  screentext == keyValue.officialId.rawValue{
                animalId1 = Int(saveanimalID)
            }
            checkofsaveanimalid = false
        }
        //merged
        //  let animalData = fetchAnimaldataValidateAnimalTag(entityName: Entities.animalAddTblEntity, animalTag:scanAnimalText, orderId: orderId, userId: userId, animalId: animalId1)
        
        var animalTagValue = String()
        var farmIdValue = String()
        if scanAnimalTagText.tag == 0 {
            // officialId selected
            scanAnimalText = scanAnimalTagText.text!.uppercased()
            farmIdText = farmIdTextField.text!.uppercased()
            animalTagValue = scanAnimalText
            farmIdValue = farmIdText
        }
        else  {
            //FarmId selected
            scanAnimalText = farmIdTextField.text!.uppercased()
            farmIdText = scanAnimalTagText.text!
            animalTagValue = scanAnimalText
            farmIdValue = farmIdText
        }
                
        let animaBarcOde = fetchAnimaldataValidateAnimalBarcodeanimalId(entityName: Entities.animalAddTblEntity, animalbarCodeTag: scanBarcodeText.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"true",custId:custmerId,IsDataEmail: false)
        let animaBarcOdeListIdCheck = fetchAnimaldataValidateAnimalBarcodeanimalId(entityName: Entities.animalAddTblEntity, animalbarCodeTag: scanBarcodeText.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"true",custId:custmerId,IsDataEmail: false)
        let fetchdata = fetchAllData(entityName: Entities.animalAddTblEntity) as! [AnimaladdTbl]
        let filterDta = fetchdata.filter({ $0.animalbarCodeTag ==  scanBarcodeText.text ?? ""})
        let bbbb = animaBarcOdeListIdCheck.lastObject as? AnimaladdTbl
        
        if bbbb?.listId == 0 {
            if animaBarcOde.count > 0 {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sampleAlreadyExists, comment: ""))
                barcodeView.layer.borderColor = UIColor.red.cgColor
                return
            }
        }
            else if filterDta.count > 0 {
                if filterDta[0].animalId != animalId1 {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sampleAlreadyExists, comment: ""))
                    barcodeView.layer.borderColor = UIColor.red.cgColor
                    return
                }
            }
            
            let animalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: Entities.animalAddTblEntity, animalTag:loadedAnimalData?.animalTag ?? "", farmId: loadedAnimalData?.farmId ?? "", animalbarCodeTag: "", offPermanentId: "", offDamId: "", offsireId: "",orderId:orderId,userId:userId,custmerId:custmerId) as! [AnimaladdTbl]

            
            //TODO: merged
            let animalMasterData = fetchAllDataWithAnimalId(entityName: Entities.animalMasterTblEntity, animalId: self.idAnimal, customerID: self.custmerId) as! [AnimalMaster]
            let filteranimalMasterData =  animalMasterData.filter({$0.orderstatus == "false"})
            let filterbarcodeAnimal =  animalData.filter({$0.orderstatus == "false"})
            
            if animalData.count > 0  {
                let existAnimalData = animalData.first
                if existAnimalData?.orderstatus == "true" {
                    if existAnimalData?.date != dateVale || existAnimalData?.eT != etBtn || existAnimalData?.breedId != breedId || existAnimalData?.gender?.localized != genderString || existAnimalData?.farmId != farmIdValue || existAnimalData?.animalTag != animalTagValue {
                        let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Animal Record cannot be updated as the animal has been used for an order.", comment: ""), preferredStyle: .alert)
                        
                        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) { [self]
                            UIAlertAction in
                            let animalFetch = fetchAnimaldataValidateAnimalwithouOrderID(entityName: Entities.animalMasterTblEntity, animalTag:existAnimalData?.animalTag ?? "", farmId: existAnimalData?.farmId ?? "", animalbarCodeTag: scanBarcodeText.text!.uppercased(), offPermanentId: permanentIDTextField.text!.uppercased(), offDamId: self.damtexfield.text!.uppercased(), offsireId: self.sireIdTextField.text!.uppercased(),orderId:orderId,userId:userId,custmerId:self.custmerId)
                            self.autoPop(animalData: animalFetch)
                            self.barcodeEnable = false
                        }
                        alertController.addAction(okAction)
                        
                        
                        // Present the controller
                        self.present(alertController, animated: true, completion: nil)
                        self.statusOrder = false
                        self.scrolView.contentOffset.y = 0.0
                        return
                        
                    }
                }
            }
            incrementalBarCode = scanBarcodeText.text ?? ""
            
            if animalData.count > 0 && filterbarcodeAnimal.count > 0 || animalData.last?.animalbarCodeTag == ""  || filteranimalMasterData.count > 0 {
                if isoverride == true{
                    farmIdText = newtextfieldfarmid
                    msgUpatedd = true
                }
                let dataBVDV =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:autoD, customerID: custmerId)
                
                if dataBVDV.count>0 {
                    if  tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || tissueBtnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText{
                        isUpdate = true
                        updateOrderStatusISyncAnimalMaster(entity: Entities.animalMasterTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: sampleName, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: sampleID,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
                        
                        updateOrderStatusISyncAnimalMaster(entity: Entities.animalAddTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!, sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "true", permanentId:permanentIDTextField.text!, tissuName: sampleName, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: sampleID,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
                        
                        updateOrderStatusISyncProduct(entity: Entities.productAdonAnimalTblEntity,animalTag: scanAnimalText,barCodetag:  scanBarcodeText.text!,farmId: farmIdText,orderId: orderId,userId:userId,animalId:animalId1)
                        updateOrderStatusISyncSubProduct(entity: Entities.subProductTblEntity,animalTag: scanAnimalText,barCodetag:  scanBarcodeText.text!,farmId: farmIdText,orderId: orderId,userId:userId,animalId: animalId1)
                        
                        let fetchDataUpdate = fetchAnimalDataAccOfficalFarmid(entityName: Entities.dataEntryAnimalAddTbl,farmId:farmIdText,anmalTag:scanAnimalText,custmerId :custmerId )
                        
                        if fetchDataUpdate.count != 0 {
                            
                            updateDataInMasterAnimalTbl(entity: Entities.dataEntryAnimalAddTbl, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: sampleName, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: sampleID,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, custmerId: custmerId , editFlagSave: true)
                            
                            updateDataInMasterAnimalTbl(entity: Entities.animalMasterTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: sampleName, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: sampleID,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, custmerId: custmerId , editFlagSave: true)
                            
                            let sId = fetchDataUpdate.object(at: 0) as? DataEntryAnimaladdTbl
                            let srverId = sId?.value(forKey: keyValue.serverAnimalId.rawValue) as! String
                            
                            updateDataInSaveClickSeverId(entity: Entities.animalAddTblEntity,serverAnimalId:srverId ,farmId:farmIdText ,animalTag:scanAnimalText ,custmerId:custmerId ,animalId:animalId1)
                        }
                        
                        let adata = fetchAllDataOrderStatusMaster(entityName: Entities.animalMasterTblEntity, ordestatus: "true", userId: userId,farmId: farmIdText,animalTag:scanAnimalText,barcodeTag:scanBarcodeText.text!)
                        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                        if adata.count > 0 && scanBarcodeText.isEnabled == true{
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                            byDefaultSetting()
                        }
                        
                        else if animalDataMaster.count > 0 {
                            if msgUpatedd == true{
                                UserDefaults.standard.set(sampleName, forKey: keyValue.tsuClear.rawValue)
                                UserDefaults.standard.set(breedBtnOutlet.titleLabel?.text, forKey: keyValue.breedNameClear.rawValue)
                                UserDefaults.standard.set(sampleName, forKey: keyValue.tsuKey.rawValue)
                                UserDefaults.standard.set(breedBtnOutlet.titleLabel?.text, forKey: keyValue.capsBreedName.rawValue)
                                byDefaultSetting()
                            }
                            else{
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                                byDefaultSetting()
                                
                            }
                        }
                        editAid = animalId1
                        animalId1 = 0
                        
                        if identify1 == true {
                            let data1 = fetchAllDataOrderStatus(entityName: Entities.animalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
                            if data1.count > 0 {
                                completionHandler(true)
                                return
                            }
                        }
                        completionHandler(true)
                        scrolView.contentOffset.y = 0.0
                    } else {
                        ShowAlertforSampletype()
                        
                    }
                } else {
                    isUpdate = true
                  let existAnimalData = animalData.last!
                    updateOrderStatusISyncAnimalMaster(entity: Entities.animalMasterTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: sampleName, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: sampleID,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: Int(existAnimalData.animalId), selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
                    
                    updateOrderStatusISyncAnimalMaster(entity: Entities.animalAddTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!, sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "true", permanentId:permanentIDTextField.text!, tissuName: sampleName, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: sampleID,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: Int(existAnimalData.animalId), selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
                    
                    updateOrderStatusISyncProduct(entity: Entities.productAdonAnimalTblEntity,animalTag: scanAnimalText,barCodetag:  scanBarcodeText.text!,farmId: farmIdText,orderId: orderId,userId:userId,animalId:Int(existAnimalData.animalId))
                    updateOrderStatusISyncSubProduct(entity: Entities.subProductTblEntity,animalTag: scanAnimalText,barCodetag:  scanBarcodeText.text!,farmId: farmIdText,orderId: orderId,userId:userId,animalId: Int(existAnimalData.animalId))
                    
                   // let fetchDataUpdate = fetchAnimalDataAccOfficalFarmid(entityName: Entities.dataEntryAnimalAddTbl,farmId:farmIdText,anmalTag:scanAnimalText,custmerId :custmerId )
                  let fetchDataUpdate = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryAnimalAddTbl, animalId :Int(existAnimalData.animalId),orderId:orderId,userId:userId, orderStatus:"false" )
                    
                    if fetchDataUpdate.count != 0 {
                        
                        updateDataInMasterAnimalTbl(entity: Entities.dataEntryAnimalAddTbl, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: sampleName, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: sampleID,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: Int(existAnimalData.animalId), selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, custmerId: custmerId , editFlagSave: true)
                        
                        updateDataInMasterAnimalTbl(entity: Entities.animalMasterTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: sampleName, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: sampleID,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: Int(existAnimalData.animalId), selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, custmerId: custmerId , editFlagSave: true)
                        
                        let sId = fetchDataUpdate.object(at: 0) as? DataEntryAnimaladdTbl
                        let srverId = sId?.value(forKey: keyValue.serverAnimalId.rawValue) as! String
                        
                        updateDataInSaveClickSeverId(entity: Entities.animalAddTblEntity,serverAnimalId:srverId ,farmId:farmIdText ,animalTag:scanAnimalText ,custmerId:custmerId ,animalId:animalId1)
                    }
                    
                    let adata = fetchAllDataOrderStatusMaster(entityName: Entities.animalMasterTblEntity, ordestatus: "true", userId: userId,farmId: farmIdText,animalTag:scanAnimalText,barcodeTag:scanBarcodeText.text!)
                    let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                    
                    if adata.count > 0{
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                        byDefaultSetting()
                    }
                    
                    else if animalDataMaster.count > 0 {
                        if msgUpatedd == true{
                            UserDefaults.standard.set(sampleName, forKey: keyValue.tsuClear.rawValue)
                            UserDefaults.standard.set(breedBtnOutlet.titleLabel?.text, forKey: keyValue.breedNameClear.rawValue)
                            UserDefaults.standard.set(sampleName, forKey: keyValue.tsuKey.rawValue)
                            UserDefaults.standard.set(breedBtnOutlet.titleLabel?.text, forKey: keyValue.capsBreedName.rawValue)
                            
                            byDefaultSetting()
                            
                        }
                        else{
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                            byDefaultSetting()
                        }
                    }
                    
                    editAid = animalId1
                    animalId1 = 0
                    if identify1 == true {
                        let data1 = fetchAllDataOrderStatus(entityName: Entities.animalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
                        if data1.count > 0 {
                            completionHandler(true)
                            return
                        }
                    }
                    completionHandler(true)
                    scrolView.contentOffset.y = 0.0
                }
            }
            else if isUpdate == true {
                
                let dataBVDV =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:autoD, customerID: custmerId)
                if dataBVDV.count > 0 {
                    if addedd == false {
                        let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAddedBVDV, comment: ""), preferredStyle: .alert)
                        
                        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default){
                            UIAlertAction in
                            self.byDefaultSetting()
                        }
                        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                            
                            UIAlertAction in
                            self.byDefaultSetting()
                            return
                        }
                        alertController.addAction(okAction)
                        alertController.addAction(cancelAction)
                        self.present(alertController, animated: true, completion: nil)
                        return
                        
                    }
                } else  {
                    animalId1 = editAid
                    updateOrderStatusISyncAnimalMaster(entity: Entities.animalMasterTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text?.uppercased() ?? "", sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: sampleName, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: sampleID,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
                    
                    updateOrderStatusISyncAnimalMaster(entity: Entities.animalAddTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text?.uppercased() ?? "", sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "true", permanentId:permanentIDTextField.text!, tissuName: sampleName, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: sampleID,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: "")
                    
                    updateOrderStatusISyncProduct(entity: Entities.productAdonAnimalTblEntity,animalTag: scanAnimalText,barCodetag:  scanBarcodeText.text!,farmId: farmIdText,orderId: orderId,userId:userId,animalId:animalId1)
                    updateOrderStatusISyncSubProduct(entity: Entities.subProductTblEntity,animalTag: scanAnimalText,barCodetag:  scanBarcodeText.text!,farmId: farmIdText,orderId: orderId,userId:userId,animalId: animalId1)
                    
                    let fetchDataUpdate = fetchAnimalDataAccOfficalFarmid(entityName: Entities.dataEntryAnimalAddTbl,farmId:farmIdText,anmalTag:scanAnimalText,custmerId :custmerId )
                    
                    if fetchDataUpdate.count != 0 {
                        
                        updateDataInMasterAnimalTbl(entity: Entities.dataEntryAnimalAddTbl, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: sampleName, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: sampleID,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, custmerId: custmerId , editFlagSave: true)
                        
                        updateDataInMasterAnimalTbl(entity: Entities.animalMasterTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: sampleName, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: sampleID,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, custmerId: custmerId , editFlagSave: true)
                        
                        let sId = fetchDataUpdate.object(at: 0) as? DataEntryAnimaladdTbl
                        let srverId = sId?.value(forKey: keyValue.serverAnimalId.rawValue) as! String
                        
                        updateDataInSaveClickSeverId(entity: Entities.animalAddTblEntity,serverAnimalId:srverId ,farmId:farmIdText ,animalTag:scanAnimalText ,custmerId:custmerId ,animalId:animalId1)
                        
                    }
                    
                    if identify1 == true {
                        let data1 = fetchAllDataOrderStatus(entityName: Entities.animalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
                        if data1.count > 0 {
                            completionHandler(true)
                            return
                        }
                    }
                    isautoPopulated = false
                    let adata = fetchAllDataOrderStatusMaster(entityName: Entities.animalMasterTblEntity, ordestatus: "true", userId: userId,farmId: farmIdText,animalTag:scanAnimalText,barcodeTag:scanBarcodeText.text!)
                    let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                    
                    if adata.count > 0{
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                        byDefaultSetting()
                    }
                    
                    else if animalDataMaster.count > 0 {
                        if  msgUpatedd == true{
                            UserDefaults.standard.set(sampleName, forKey: keyValue.tsuClear.rawValue)
                            UserDefaults.standard.set(breedBtnOutlet.titleLabel?.text, forKey: keyValue.breedNameClear.rawValue)
                            UserDefaults.standard.set(sampleName, forKey: keyValue.tsuKey.rawValue)
                            UserDefaults.standard.set(breedBtnOutlet.titleLabel?.text, forKey: keyValue.capsBreedName.rawValue)
                            byDefaultSetting()
                        }
                        else{
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                            byDefaultSetting()
                        }
                    }
                    completionHandler(true)
                    scrolView.contentOffset.y = 0.0
                }
            } else {
                isUpdate = false
                if pvid == 2 {
                    if breedId  == "" {
                        let inheritBreed = fetchAllDataProductBeefIdDairy(entityName: Entities.getBreedsTblEntity, breedName: (breedBtnOutlet.titleLabel?.text)!, pvid: 2)
                        if inheritBreed.count != 0 {
                            let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                            breedId = medbreedRegArr1!.breedId ?? ""
                            UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                            
                        }
                    }else {
                        UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                    }
                    
                }
                
                if pvid == 1 || pvid == 2 || pvid == 10 || pvid == 11 || pvid == 6 || pvid == 8 || pvid == 12 {
                    if breedId  == "" {
                        let inheritBreed = fetchAllDataProductBeefIdDairy(entityName: Entities.getBreedsTblEntity, breedName: (breedBtnOutlet.titleLabel?.text)!, pvid: pvid)
                        if inheritBreed.count != 0 {
                            let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                            breedId = medbreedRegArr1!.breedId ?? ""
                            UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                        }
                    }else {
                        UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                    }
                } else if pvid == 3 {
                    if breedId  == "" {
                        let inheritBreed = fetchAllDataProductBeefIdDairy(entityName: Entities.getBreedsTblEntity, breedName: (breedBtnOutlet.titleLabel?.text)!, pvid: 3)
                        if inheritBreed.count != 0 {
                            let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                            breedId = medbreedRegArr1!.breedId ?? ""
                            UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                            
                        }
                    }else {
                        UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                    }
                }
                
                let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
                let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: pvid, breedId: breedId )
                var animalID1 = UserDefaults.standard.integer(forKey: keyValue.animalId.rawValue)
                let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalMasterTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                
                if animalDataMaster.count > 0{
                    if animalID1 == 0 {
                        animalID1 = animalID1 + 1
                        UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                    }
                    else {
                        animalID1 = animalID1 + 1
                        UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                    }
                    
                    updateOrderStatusISyncAnimalMasterAnimalId(entity: Entities.animalMasterTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text?.uppercased() ?? "", sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: sampleName, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: sampleID,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, tertiaryGeno: "")
                    
                    let fetchDataUpdate = fetchAnimalDataAccOfficalFarmid(entityName: Entities.dataEntryAnimalAddTbl,farmId:farmIdText,anmalTag:scanAnimalText,custmerId :custmerId )
                    
                    if fetchDataUpdate.count != 0 {
                        updateDataInMasterAnimalTbl(entity: Entities.dataEntryAnimalAddTbl, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text!.uppercased(), sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: sampleName, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: sampleID,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString,animalId: animalId1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, custmerId: custmerId , editFlagSave: true)
                        
                        let sId = fetchDataUpdate.object(at: 0) as? DataEntryAnimaladdTbl
                        let srverId = sId?.value(forKey: keyValue.serverAnimalId.rawValue) as! String
                        updateDataInSaveClickSeverId(entity: Entities.animalAddTblEntity,serverAnimalId:srverId ,farmId:farmIdText ,animalTag:scanAnimalText ,custmerId:custmerId ,animalId:animalId1)
                    }
                }
                else{
                    if animalID1 == 0 {
                        animalID1 = animalID1 + 1
                        UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                    }
                    else {
                        animalID1 = animalID1 + 1
                        UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                    }
                    
                    let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalMasterTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"true" )
                    
                    if animalDataMaster.count > 0{
                        
                        updateOrderStatusISyncAnimalMasterAnimalId(entity: Entities.animalMasterTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text?.uppercased() ?? "", sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: sampleName, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: sampleID,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1, selectedBornTypeId: selectedBornTypeId,isSyncServer:false, adhDataServer: false, tertiaryGeno: "")
                    }
                    else {
                        if isoverride == true
                        {
                            farmIdText = newtextfieldfarmid
                            
                        }
                        saveAnimaldata(entity: Entities.animalMasterTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text?.uppercased() ?? "", sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName:sampleName, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: sampleID,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString, animalId: animalID1, selectedBornTypeId: selectedBornTypeId,custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), specisId: SpeciesID.dairySpeciesId, earTag: "",isSyncServer:false, adhDataServer: false, listId: 0, editFlagSave: false, serverAnimalId: "")
                        self.createDataList()
                    }
                }
                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:autoD, customerID: custmerId)
                
                if data12333.count > 0{
                    if tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || tissueBtnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || tissueBtnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                        saveAnimaldata(entity: Entities.animalAddTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text?.uppercased() ?? "", sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: sampleName, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: sampleID,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString, animalId: animalID1, selectedBornTypeId: selectedBornTypeId, custId: custmerId, specisId: SpeciesID.dairySpeciesId, earTag: "",isSyncServer:false, adhDataServer: false, listId: 0, editFlagSave: false, serverAnimalId: "")
                        
                        self.createDataList()
                    }
                    else{
                        let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            self.byDefaultSetting()
                            
                        }
                        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            deleteDataWithProduct(animalID1)
                            deleteDataWithSubProduct(animalID1)
                            deleteDataWithAnimal(animalID1)
                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid)
                            self.notificationLblCount.text = String(animalCount.count)
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
                    if isoverride == true{
                        farmIdText = newtextfieldfarmid
                    }
                    saveAnimaldata(entity: Entities.animalAddTblEntity, animalTag: scanAnimalText, barCodetag: scanBarcodeText.text!, date: dateVale , damId: damtexfield.text?.uppercased() ?? "", sireId: sireIdTextField.text?.uppercased() ?? "" , gender: genderString,update: "false", permanentId:permanentIDTextField.text!, tissuName: sampleName, breedName: breedBtnOutlet.titleLabel!.text!, et: etBtn, farmId:farmIdText, orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: sampleID,sireIDAU:sireIAuTextField.text ?? "", nationHerdAU:nationalHerdIdTextField.text ?? "", userId: userId,udid:timeStampString, animalId: animalID1, selectedBornTypeId: selectedBornTypeId,custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), specisId: SpeciesID.dairySpeciesId, earTag: "",isSyncServer:false, adhDataServer: false, listId: 0, editFlagSave: false, serverAnimalId: "")
                    self.createDataList()
                    
                    let fetchDataUpdate = fetchAnimalDataAccOfficalFarmid(entityName: Entities.dataEntryAnimalAddTbl,farmId:farmIdText,anmalTag:scanAnimalText,custmerId :custmerId )
                    
                    if fetchDataUpdate.count != 0 {
                        let sId = fetchDataUpdate.object(at: 0) as? DataEntryAnimaladdTbl
                        let srverId = sId?.value(forKey: keyValue.serverAnimalId.rawValue) as! String
                        updateDataInSaveClickSeverId(entity: Entities.animalAddTblEntity,serverAnimalId:srverId ,farmId:farmIdText ,animalTag:scanAnimalText ,custmerId:custmerId ,animalId:animalId1)
                    }
                }
                
                let animalData = fetchAnimaldataDairy(entityName: Entities.animalAddTblEntity, animalTag:animalID1,orderId:orderId,userId:userId)
                
                for k in 0 ..< animalData.count{
                    let animalId = animalData[k] as! AnimaladdTbl
                    for i in 0 ..< product.count{
                        
                        let data = product[i] as! GetProductTbl
                        if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                            let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:autoD,customerID:custmerId)
                            if data12333.count > 0 {
                                let adonDat =  fetchProductAdonDataWithBVDV(entityName: Entities.getAdonTblEntity, prodId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue),adonId : LocalizedStrings.bvdvAddOnId)
                                if adonDat.count > 0 {
                                    addedd = true
                                    saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: farmIdText, orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: animalID1, marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                                    updateOrderStatusAnimal(entity: Entities.animalAddTblEntity, status: "true", orderId: autoD, userId: userId, animalId: animalID1)
                                }
                            }
                            else {
                                saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: farmIdText, orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: animalID1, marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                            }
                        }
                        else {
                            saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId ?? "", productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: farmIdText, orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: animalID1, marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
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
                                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: farmIdText, animalId: animalID1, custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                        updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue), status: "true")
                                    }
                                    else {
                                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: farmIdText, animalId: animalID1,custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                    }
                                }
                                else {
                                    saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: farmIdText, animalId: animalID1,custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                }
                            }
                            else {
                                saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: farmIdText, animalId: animalID1,custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                            }
                            
                        }
                    }
                    let BVDVfound = UserDefaults.standard.bool(forKey: keyValue.bvdvSelected.rawValue)
                    if data12333.count > 0 && !BVDVfound {
                        if addedd == false {
                            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAddedBVDV, comment: ""), preferredStyle: .alert)
                            
                            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                                UIAlertAction in
                                deleteDataWithProduct(animalID1)
                                deleteDataWithSubProduct(animalID1)
                                deleteDataWithAnimal(animalID1)
                                
                                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid)
                                var bredidd123 = String ()
                                
                                if animalCount.count > 0 {
                                    let breeid1 = animalCount.object(at: 0) as! AnimaladdTbl
                                    bredidd123 = breeid1.breedName ?? ""
                                }
                                for i in 0 ..< animalCount.count{
                                    let breeid1 = animalCount.object(at: i) as! AnimaladdTbl
                                    
                                    if bredidd123 == breeid1.breedName {
                                        bredidd123 = breeid1.breedName ?? ""
                                        UserDefaults.standard.set(breeid1.breedId, forKey: keyValue.breed.rawValue)
                                    }
                                }
                                self.byDefaultSetting()
                                self.notificationLblCount.text = String(animalCount.count)
                                return
                            }
                            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                                UIAlertAction in
                                deleteDataWithProduct(animalID1)
                                deleteDataWithSubProduct(animalID1)
                                deleteDataWithAnimal(animalID1)
                                
                                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid)
                                self.notificationLblCount.text = String(animalCount.count)
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
                }
                
                message = NSLocalizedString(LocalizedStrings.animalAdded, comment: "")
                statusOrder = false
                UserDefaults.standard.removeObject(forKey: keyValue.review.rawValue)
                self.animalSucInOrder = ""
                if self.msgAnimalSucess == false {
                    if self.addContiuneBtn == 1 {
                        if self.msgcheckk == true {
                            self.view.makeToast(NSLocalizedString(AlertMessagesStrings.animalRecordUpdatedAdded, comment: ""), duration: 2, position: .bottom)
                        }
                        else {
                            
                            if self.isautoPopulated == true {
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAddedSuccessfully, comment: ""), duration: 2, position: .bottom)
                            } else {
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAdded, comment: ""), duration: 2, position: .bottom)
                            }
                        }
                    } else if self.addContiuneBtn == 2{
                        if self.msgcheckk == true {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalRecordUpdatedAdded, comment: ""))
                        }
                        else{
                            if self.isautoPopulated == true {
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAddedSuccessfully, comment: ""))
                            } else {
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAdded, comment: ""))
                            }
                        }
                    }else {
                        if self.msgcheckk == true {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalRecordUpdatedAdded, comment: ""))
                        }
                        else{
                            if self.isautoPopulated == true {
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAddedSuccessfully, comment: ""))
                                
                            } else {
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAdded, comment: ""))
                            }
                        }
                    }
                    self.msgAnimalSucess = false
                } else {
                    if self.msgcheckk == true {
                        self.view.makeToast(NSLocalizedString(AlertMessagesStrings.animalRecordUpdatedAdded, comment: ""), duration: 2, position: .bottom)
                    }
                    else{
                        if self.isautoPopulated == true {
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAddedSuccessfully, comment: ""), duration: 2, position: .bottom)
                        }
                        else {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAdded, comment: ""))
                        }
                    }
                }
                UserDefaults.standard.set(sampleName, forKey: keyValue.tsuClear.rawValue)
                UserDefaults.standard.set(breedBtnOutlet.titleLabel?.text, forKey: keyValue.breedNameClear.rawValue)
                UserDefaults.standard.set(sampleName, forKey: keyValue.tsuKey.rawValue)
                UserDefaults.standard.set(breedBtnOutlet.titleLabel?.text, forKey: keyValue.capsBreedName.rawValue)
                
                if isBarcodeAutoIncrementedEnabled == true {
                    UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                    UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
                    
                } else {
                    UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                    
                }
                
                UserDefaults.standard.set("", forKey: keyValue.selectAnimalId.rawValue)
                barAutoPopu = false
                let langCode : String = UserDefaults.standard.object(forKey: keyValue.lngCode.rawValue) as! String
                self.male_femaleBtnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                byDefaultSetting()
                textFieldBackroungGrey()
                genderToggleFlag = 0
                genderString = NSLocalizedString("Female", comment: "")
                etBtn.removeAll()
                etBttn.layer.borderWidth = 0.5
                singleBttn.layer.borderWidth = 0.5
                multipleBirthBttn.layer.borderWidth = 0.5
                scanAnimalTagText.text = ""
                scanBarcodeText.text = ""
                
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
                
                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: pvid)
                notificationLblCount.text = String(animalCount.count)
                
                let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
                let formatter = DateFormatter()
                
                if dateStr == "MM" {
                    formatter.dateFormat = DateFormatters.MMddyyyyFormat
                } else {
                    formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                }
                
                _ = formatter.string(from: date)
                
                dateBtnOutlet.setTitle("", for: .normal)
                dateBtnOutlet.setTitle(nil, for: .normal)
                dateTextField.text = ""
                
                dateVale = ""
                completionHandler(true)
            }
            
            if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
                UserDefaults.standard.set(incrementalBarCode, forKey: keyValue.barcodeIncremental.rawValue)
            }
            incrementalBarCode = ""
            
        }
    }

