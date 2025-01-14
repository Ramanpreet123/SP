//
//  DEOAnmalVCTextfieldDelegateExtension.swift
//  SearchPoint
//
//  Created by Mobile Programming on 25/02/24.
//

import Foundation

// MARK: - TEXTFIELD DELEGATE EXTENSION
extension DataEntryOrderingAnimalVC :UITextFieldDelegate  {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = UIColor.black
        dropDown.hide()
        if scanAnimalTagText.text!.count > 0 {
            farmIdTextField.isEnabled = true
            scanBarcodeText.isEnabled = true
            permanentIDTextField.isEnabled = true
            tissueBtnOutlet.isEnabled = true
            breedBtnOutlet.isEnabled = true
            etBttn.isEnabled = true
            multipleBirthBttn.isEnabled = true
            singleBttn.isEnabled = true
            sireIdTextField.isEnabled = true
            damtexfield.isEnabled = true
            nationalHerdIdTextField.isEnabled = true
            sireIAuTextField.isEnabled = true
            male_femaleBtnOutlet.isEnabled = true
            bleBttn.isEnabled = true
            blebttn1.isEnabled = true
            scanButton.isEnabled = true
            dateTextField.isEnabled = true
            
        } else {
            male_femaleBtnOutlet.isEnabled = false
            farmIdTextField.isEnabled = false
            scanBarcodeText.isEnabled = false
            permanentIDTextField.isEnabled = false
            tissueBtnOutlet.isEnabled = false
            breedBtnOutlet.isEnabled = false
            etBttn.isEnabled = false
            multipleBirthBttn.isEnabled = false
            singleBttn.isEnabled = false
            sireIdTextField.isEnabled = false
            damtexfield.isEnabled = false
            nationalHerdIdTextField.isEnabled = false
            sireIAuTextField.isEnabled = false
            bleBttn.isEnabled = false
            scanButton.isEnabled = false
            blebttn1.isEnabled = false
            scanButton.isEnabled = false
            dateTextField.isEnabled = false
            if scanAnimalTagText.tag == 0 {
                blebttn1.isEnabled = true
            }
        }
        
        let selctionAuProvider = UserDefaults.standard.value(forKey: keyValue.clickAuProvider.rawValue) as? Bool
        if selctionAuProvider == true {
            if (textField == nationalHerdIdTextField ) {
                nationalHerdIdTextField.returnKeyType = UIReturnKeyType.done
            } else {
                scanAnimalTagText.returnKeyType = UIReturnKeyType.next
                farmIdTextField.returnKeyType = UIReturnKeyType.next
                permanentIDTextField.returnKeyType = UIReturnKeyType.next
                scanBarcodeText.returnKeyType = UIReturnKeyType.next
                sireIdTextField.returnKeyType = UIReturnKeyType.next
                damtexfield.returnKeyType = UIReturnKeyType.next
                sireIAuTextField.returnKeyType = UIReturnKeyType.next
            }
            
        } else {
            if (textField == damtexfield ) {
                damtexfield.returnKeyType = UIReturnKeyType.done
            } else {
                scanAnimalTagText.returnKeyType = UIReturnKeyType.next
                farmIdTextField.returnKeyType = UIReturnKeyType.next
                permanentIDTextField.returnKeyType = UIReturnKeyType.next
                scanBarcodeText.returnKeyType = UIReturnKeyType.next
                sireIdTextField.returnKeyType = UIReturnKeyType.next
            }
        }
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.textColor = UIColor.black
        addObserver()
        return true;
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true;
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
      if barAutoPopu == false {
        barcodeflag = true
      } else {
        let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: "AnimalMaster", animalId: idAnimal,orderststus:"true", customerId: self.custmerId!)
        if orederStatus.count > 0 {
          if textField == farmIdTextField || textField == scanAnimalTagText || textField == sireIdTextField || textField == damtexfield  {
            barcodeEnable = true
          }
        }
      }
      
      
      if textField == scanBarcodeText {
      
        let currentString: NSString = scanBarcodeText.text! as NSString
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        
        
        //            if newString == "" {
        //                self.isBarcodeAutoIncrementedEnabled = false
        //            }
        barcodeflag = true
        if self.isBarcodeAutoIncrementedEnabled {
          if isBarCodeEndsWithNumber_GetIncrementedBarCode(newString as String).isBarCodeEndsWithNumber  {
            incrementalBarcodeCheckBox.image = UIImage(named: "check")
            UserDefaults.standard.set(true, forKey: "isBarCodeIncremental")
            checkBarcode = false
          } else {
            //incrementalBarcodeCheckBox.image = UIImage(named: "Incremental_Check")
            UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
            //self.defaultIncrementalBarCodeSetting()
            checkBarcode = true
            
          }
        }
        
        
        
      }
    
      
      
      let providerName = UserDefaults.standard.value(forKey: "ProviderName") as? String
      
      if providerName == "AU Dairy Products" {
        
        if textField == sireIdTextField {
          if let char = string.cString(using: String.Encoding.utf8) {
            
            let isBackSpace1 = strcmp(char, "\\b")
            if (isBackSpace1 == -92) {
              isautoPopulated = false
              autoSuggestionStatus = false
              //manish true
              sireIdValidationB = true
              
            }
            //Manish new line
            // sireIdValidationB = false
            if pvid == 3{
              sireIdValidationB = true
            }
            
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            btnTag = 30
            let bPredicate: NSPredicate = NSPredicate(format: "srcLine contains[cd] %@", newString)
            fetchNaabBullArray = fetchAusNaabBullData().filtered(using: bPredicate) as NSArray
            autocompleteUrls1 = fetchNaabBullArray.mutableCopy() as! NSMutableArray
            autocompleteUrls2.removeAllObjects()
            sireNatonIdArray.removeAllObjects()
            
            self.tableViewpopAutosugesstion()
            var yFrame = 460 - self.scrolView.contentOffset.y
            
            var strDeviceType = ""
            if UIDevice().userInterfaceIdiom == .phone {
              switch UIScreen.main.nativeBounds.height {
              case 1136:
                strDeviceType = "iPhone 5 or 5S or 5C"
              case 1334:
                strDeviceType = "iPhone 6/6S/7/8"
                yFrame = 400 - self.scrolView.contentOffset.y
              case 1920, 2208:
                strDeviceType = "iPhone 6+/6S+/7+/8+"
                yFrame = 415 - self.scrolView.contentOffset.y
              case 2436:
                strDeviceType = "iPhone X"
                yFrame = 425 - self.scrolView.contentOffset.y
             case 2688,2796:
                strDeviceType = "iPhone Xs Max"
                yFrame = 425 - self.scrolView.contentOffset.y
              case 1792:
                yFrame = 425 - self.scrolView.contentOffset.y
                strDeviceType = "iPhone Xr"
              default:
                strDeviceType = "unknown"
              }
            }
            for i in 0..<autocompleteUrls1.count {
              
              let f = autocompleteUrls1.object(at:i) as! AusNaabBull
              let farmName = f.bullID
              let sireNationlId = f.bullID
              sireNatonIdArray.add(sireNationlId!)
              autocompleteUrls2.add(farmName!)
            }
            
            // Table view frame set
            if autocompleteUrls2.count < 3 {
              AutoSuggestionTableView.frame = CGRect(x: 29,y: yFrame + 72,width: 350,height: 80)
            } else {
              AutoSuggestionTableView.frame = CGRect(x: 29,y: yFrame - 95 ,width: 350,height: 250)
            }
            
            
            if autocompleteUrls2.count == 0 {
              AutoSuggestionTableView.isHidden = true
              buttonbgAutoSuggestion.removeFromSuperview()
            }
            else{
              AutoSuggestionTableView.isHidden = false
              AutoSuggestionTableView.reloadData()
            }}
          
        }
      }
      //////////a00008791
      
      if let char = string.cString(using: String.Encoding.utf8) {
        textField.textColor =  UIColor.black
        
        let isBackSpace1 = strcmp(char, "\\b")
        if (isBackSpace1 == -92) {
          
          if textField == scanAnimalTagText{
            if borderRedChange == false {
              isautoPopulated = false
              sireIdTextField.layer.borderColor = UIColor.gray.cgColor
              damtexfield.layer.borderColor = UIColor.gray.cgColor
              
              if scanAnimalTagText.tag == 0{
                borderRedCheck = true
              }
            }
            /// manish updated value when delete
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "DataEntryAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            if animalDataMaster.count > 0 {
              msgUpatedd = true
              //barcodeflag = true
            }
            if scanAnimalTagText.text!.count == 1 {
              //  textFieldBackroungGrey()
            } else {
              
              // textFieldBackroungWhite()
            }
            
          } else if textField == farmIdTextField{
            
            if borderRedChange == false {
              isautoPopulated = false
              if scanAnimalTagText.tag == 1{
                borderRedCheck = true
              }
              /// manish updated value when delete
              let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "DataEntryAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
              if animalDataMaster.count > 0 {
                msgUpatedd = true
                //barcodeflag = true
              }
              sireIdTextField.layer.borderColor = UIColor.gray.cgColor
              damtexfield.layer.borderColor = UIColor.gray.cgColor
            }
          } else if textField == sireIdTextField {
            isautoPopulated = false
            // autoSuggestionStatus = false
            if pvid == 3{
              //  sireIdValidationB = false
            }else {
              sireIdValidationB = true
            }
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "DataEntryAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            if animalDataMaster.count > 0 {
              msgUpatedd = true
              //barcodeflag = true
            }
          } else if textField == damtexfield {
            damiidTextValueStore = damtexfield.text!
            isautoPopulated = false
            if pvid == 3{
              damIdValidationB = false
              
            }else {
              damIdValidationB = true
            }
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "DataEntryAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            if animalDataMaster.count > 0 {
              msgUpatedd = true
              //barcodeflag = true
            }
          }
          else if textField == scanBarcodeText{
            barcodeflag = true
            if scanBarcodeText.text!.count == 1 {
              self.isBarcodeAutoIncrementedEnabled = false
              
              //    incrementalBarcodeTitleLabel.textColor = .gray
              // incrementalBarcodeButton.isEnabled = false
              UserDefaults.standard.set(false, forKey: "isBarCodeIncremental")
              checkBarcode = false
              
              incrementalBarcodeCheckBox.image = UIImage(named: "Incremental_Check")
            } else {
              //  incrementalBarcodeTitleLabel.textColor = UIColor.black
              //incrementalBarcodeButton.isEnabled = true
              
            }
          }
          return true
          
        } else if textField == scanAnimalTagText{
            textFieldBackroungWhite()
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            if scanAnimalTagText.tag == 0 {
              btnTag = 0
              var filteredData = [AnimalMaster]()
              filteredData  =  self.adhAnimalData.filter { ($0.animalTag?.lowercased())!.contains( newString.lowercased())}
              
              filterAdhAnimalData = filteredData
              self.AutoPopulateSuggetion(tag: 0)
              let check  = ACCEPTABLE_CHARACTERS.contains(string)
              borderRedCheck = true
              if check == false {
                return false
              }
              
            } else {
              btnTag = 1
              var filteredData = [AnimalMaster]()
              filteredData  =  self.adhAnimalData.filter { ($0.farmId?.lowercased())!.contains( newString.lowercased())}
              
              filterAdhAnimalData = filteredData
              self.AutoPopulateSuggetion(tag: 1)
                if pvid == 11 {
                    let maxLength = 9
//                    let currentString = (textField.text ?? "") as NSString
//                    let newString = currentString.replacingCharacters(in: range, with: string)
                    let check  = LocalizedStrings.farmIdRegex.contains(string)
                      if check == false {
                          return false
                      }
                  
                    return newString.count <= maxLength
                }
              let check  = LocalizedStrings.farmIdRegex.contains(string)
              //borderRedCheck = true
              if check == false {
                return false
              }
  //                if pvid == 11 {
  //                  let maxLength = 9
  //                  let currentString = (textField.text ?? "") as NSString
  //                  let newString = currentString.replacingCharacters(in: range, with: string)
  //
  //                  return newString.count <= maxLength
  //
  //                }
            }
          }
        
        else if textField == farmIdTextField {
            
            let currentString: NSString = textField.text! as NSString
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            if farmIdTextField.tag == 1 {
              btnTag = 1
              var filteredData = [AnimalMaster]()
              filteredData  =  self.adhAnimalData.filter { ($0.farmId?.lowercased())!.contains( newString.lowercased())}
              filterAdhAnimalData = filteredData
              
              self.AutoPopulateSuggetion(tag: 1)
                if pvid == 11 {
                    let maxLength = 9
//                    let currentString = (textField.text ?? "") as NSString
//                    let newString = currentString.replacingCharacters(in: range, with: string)
                    let check  = LocalizedStrings.farmIdRegex.contains(string)
                      if check == false {
                          return false
                      }
                  
                    return newString.count <= maxLength
                }
              let check  = LocalizedStrings.farmIdRegex.contains(string)
             // borderRedCheck = true
              if check == false {
                return false
              }
              
            } else {
              // this is for BeNeLux
              if pvid == 11 {
                let ACCEPTABLE_CHR = "0123456789\("")"
                if newString.count == 2{
                  let enterString = newString.lowercased()
                  let countryCode : String = providerCountryCodeAlpha2.lowercased()
                  if enterString.contains(countryCode) {
                    return true
                  } else {
                    //check for input is  number here
                    let alert = UIAlertController(title: NSLocalizedString("", comment: ""), message: "Please Add valid Country Code at the beginning".localized(with: providerCountryCodeAlpha2), preferredStyle: .alert)
                    let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertAction.Style.default) {
                      UIAlertAction in
                      NSLog("ok Pressed")
                    }
                    
                    // Add the actions
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                    return false
                  }
                } else {
                  if newString.count > 2 {
                    let check  = ACCEPTABLE_CHR.contains(string)
                   // borderRedCheck = true
                    if check == false {
                      return false
                    }
                    let maxLength = 11
                    let currentString = (textField.text ?? "") as NSString
                    let newString = currentString.replacingCharacters(in: range, with: string)
                    
                    return newString.count <= maxLength
                    
                  } else{
                    return true
                  }
                }
                
              }
              btnTag = 0
              var filteredData = [AnimalMaster]()
              filteredData  =  self.adhAnimalData.filter { ($0.animalTag?.lowercased())!.contains( newString.lowercased())}
              filterAdhAnimalData = filteredData
              
              self.AutoPopulateSuggetion(tag: 0)
              
              let check  = ACCEPTABLE_CHARACTERS.contains(string)
              borderRedCheck = true
              if check == false {
                return false
              }
            }
          }
       else if textField == sireIdTextField {
          
          isautoPopulated = false
          if pvid == 3{
            // sireIdValidationB = false
          }else {
            sireIdValidationB = true
          }
        }
        else if textField == damtexfield {
          
          let check  = ACCEPTABLE_CHARACTERS.contains(string)
          
          if pvid == 3{
            damIdValidationB = false
            
            
          }else {
            
            damIdValidationB = true
            
          }
          if check == false {
            return false
          }
        }
        if textField == scanBarcodeText {
          
          let ACCEPTABLE_CHARACTERS = "+?%ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\("")"
          let check  = ACCEPTABLE_CHARACTERS.contains(string)
          if check == false {
            return false
          }
        }
        
        
        if textField == dateTextField {
          
          
          
          if dateTextField.text?.count == 2 || dateTextField.text?.count == 5{
            dateTextField.text?.append("/")
          }
          if dateTextField.text?.count == 10 {
            return false
          }
          
        }
        
        
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let orderId = UserDefaults.standard.integer(forKey: "orderId")
        if editIngText == true{
          editIngText = false
          
        }
        
        else if isUpdate == true {
          animalId1 = editAid
          isUpdate = false
        }
        if statusOrder == true{
          msgAnimalSucess = true
        }
        else{
          messageCheck = true
        }
        let animalFetch = fetchAllDataWithAnimalId(entityName: "AnimalMaster", animalId: idAnimal, customerID: custmerId!)
        if animalFetch.count > 0{
          statusOrder = true
        }
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "DataEntryAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
          msgUpatedd = true
          //barcodeflag = true
        }
        //barcodeflag = true
        if isautoPopulated == true {
          
          let animalData = fetchAnimaldataValidateListAndCustomerIdaUTOPOP(entityName: "DataEntryAnimaladdTbl", userId: userId,listId:listIdGet,customerId:custmerId ?? 0)
          
          
          if animalData.count == 0{
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "AnimalMaster", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            if animalDataMaster.count > 0 {
              msgcheckk = true
            }
          }
        }
        
        //            if string == "+" || string == "?" || string == "%"{
        //                let allowedCharacters = CharacterSet(charactersIn:"0123456789")//Here change this characters based on your requirement
        //                let characterSet = CharacterSet(charactersIn: string)
        //                return allowedCharacters.isSuperset(of: characterSet)
        //            }
      
      }
      
      return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        var animalTagValue = String()
            if textField == scanAnimalTagText || textField == farmIdTextField {
            if scanAnimalTagText.tag == 0 {
                scanAnimalText = scanAnimalTagText.text!.uppercased()
                farmIdText = farmIdTextField.text!.uppercased()
                animalTagValue = scanAnimalText
                if scanAnimalTagText.text != "" {
                    if textField == scanAnimalTagText  {
                        if borderRedCheck == false  &&  animalTagValue.count == 17{
                        } else {
                            let replacedString = animalTagValue.replacingOccurrences(of: " ", with: "")
                            self.validationId17(animalId: replacedString.uppercased())
                            animalTagValue = scanAnimalTagText.text!.uppercased()
                          dataPopulateInFocusChange()
                        }
                        
                    } else {
                        let animalTag1 = fetchAnimaldataValidateFamID(entityName: Entities.animalMasterTblEntity,farmId:farmIdTextField.text ?? "",custmerId: custmerId ?? 0, userId: userId, animalId: Int64(animalId1))
                        
                        if animalTag1.count == 0 {
                        } else {
                            dataPopulateInFocusChange()
                        }
                    }
                }
                
                if UserDefaults.standard.bool(forKey: keyValue.matchedBarcodeFlagDataEntry.rawValue) == true {
                    if scanBarcodeText.text?.count == 0 {
                        if scanAnimalTagText.text?.count == 17 {
                            let str = scanAnimalTagText.text!
                            let start = str.index(str.startIndex, offsetBy: 2)
                            let end = str.index(str.endIndex, offsetBy: -12)
                            let range = start..<end
                            let subStr = str[range]
                            print( subStr )
                            
                            if subStr == LocalizedStrings.eightFortyCountryCode {
                                scanBarcodeText.text = String(scanAnimalTagText.text!.dropFirst(2))
                            }
                            else
                            {
                                let alert = UIAlertController(title: NSLocalizedString("", comment: ""), message: NSLocalizedString(LocalizedStrings.cannotCopyOfficialId, comment: ""), preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: { [self]  (_) in
                                    matchedBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                                    UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlag.rawValue)
                                    // barcodefixed = false
                                    matchedBarcodeBtnOutlet.isSelected = false
                                    incrementalBarcodeTitleLabel.textColor = UIColor.black
                                    incrementalBarcodeButton.isEnabled = true
                                    incrementalBarcodeCheckBox.alpha = 1
                                    incrementalBarcodeTitleLabel.alpha = 1
                                }))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
            
            else  {
                scanAnimalText = farmIdTextField.text!.uppercased()
                farmIdText = scanAnimalTagText.text!
                animalTagValue = scanAnimalText
                if animalTagValue != ""{
                    if borderRedCheck == false &&  animalTagValue.count == 17 {
                        let animalTag1 = fetchAnimaldataValidateFamIDListId(entityName: Entities.animalMasterTblEntity,farmId:scanAnimalTagText.text ?? "",custmerId: custmerId ?? 0, userId: userId, animalId: Int64(animalId1),listId:Int64(listIdGet))
                       
                        if animalTag1.count != 0 &&  dataAutoPopulatedBool == true {
                            if dataEntryConflicedBack == true {
                                
                            } else  {
                                farmIDBoolEntrySecond = true
                                officalTagView.layer.borderColor = UIColor.red.cgColor
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.duplicateEntryStr, comment: ""))
                            }
                        } else {
                            officalTagView.layer.borderColor = UIColor.gray.cgColor
                        }
                        
                    } else {
                        var replacedString = animalTagValue.replacingOccurrences(of: " ", with: "")
                        if pvid == 11 {
                            if animalTagValue.count > 9 {
                                replacedString = String(replacedString.dropFirst(2))
                            } else {
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalIDStr, comment: ""), duration: 2, position: .top)
                                farmIdTextField.textColor = UIColor.red
                                borderRedCheck = true
                                farmIdView.layer.borderColor = UIColor.red.cgColor
                                return
                            }
                        }
                        
                        self.validationId17(animalId: replacedString.uppercased())
                        animalTagValue = farmIdTextField.text!.uppercased()
                        let bbb =  fetchAnimaldataValidateAnimalBarcodetag(entityName: Entities.dataEntryAnimalAddTbl,animalbarCodeTag:animalTagValue ,orderId: orderId, userId: userId, custmerId: custmerId ?? 0)
                        
                        if bbb.count != 0 &&  dataAutoPopulatedBool == true{
                            if dataEntryConflicedBack != true {
                                farmIDBoolEntry = true
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.duplicateEntryStr, comment: ""))
                            }
                        } else {
                            farmIdView.layer.borderColor = UIColor.gray.cgColor
                            if bbb.count == 1 &&  dataAutoPopulatedBool == false{
                                dataPopulateInFocusChange()
                            }
                        }
                    }
                } else {
                    borderRedCheck = false
                    
                    if animalTagValue.count == 0 && dataAutoPopulatedBool == true {
                        let animalTag1 = fetchAnimaldataValidateFamID(entityName: Entities.animalMasterTblEntity,farmId:scanAnimalTagText.text ?? "",custmerId: custmerId ?? 0, userId: userId, animalId: Int64(animalId1))
                        if textField == scanAnimalTagText {
                            dataPopulateInFocusChange()
                            
                        }
                        else if textField == farmIdTextField {
                            if animalTag1.count != 0 && farmIdTextField.text?.count != 0 {
                                dataPopulateInFocusChange()
                            }
                        }
                        
                    }else {
                        dataPopulateInFocusChange()
                    }
                }
                
                if UserDefaults.standard.bool(forKey: keyValue.matchedBarcodeFlagDataEntry.rawValue) == true {
                    if scanBarcodeText.text?.count == 0 {
                        if farmIdTextField.text?.count == 17
                        {
                            let str = farmIdTextField.text!
                            let start = str.index(str.startIndex, offsetBy: 2)
                            let end = str.index(str.endIndex, offsetBy: -12)
                            let range = start..<end
                            let subStr = str[range]
                            print( subStr )
                            
                            if subStr == LocalizedStrings.eightFortyCountryCode {
                                scanBarcodeText.text = String(farmIdTextField.text!.dropFirst(2))
                            }
                            else
                            {
                                let alert = UIAlertController(title: NSLocalizedString("", comment: ""), message: NSLocalizedString(LocalizedStrings.cannotCopyOfficialId, comment: ""), preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: { [self]  (_) in
                                    matchedBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                                    UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlag.rawValue)
                                    matchedBarcodeBtnOutlet.isSelected = false
                                    incrementalBarcodeTitleLabel.textColor = UIColor.black
                                    incrementalBarcodeButton.isEnabled = true
                                    incrementalBarcodeCheckBox.alpha = 1
                                    incrementalBarcodeTitleLabel.alpha = 1
                                }))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
        }
        if textField == sireIdTextField {
            if sireIdTextField.text!.count == 0{
            }
            else{
                if sireIdValidationB == false {
                    if ausBullId.contains(sireIdTextField.text?.uppercased() as Any) || sireNationalID.contains(sireIdTextField.text?.uppercased() as Any){
                        
                    } else {
                    }
                } else {
                    if pvid == 3 {
                        if ausBullId.contains(sireIdTextField.text?.uppercased() as Any) || sireNationalID.contains(sireIdTextField.text?.uppercased() as Any){
                            sireIdValidationB = false
                        } else {
                            validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                        }
                    } else {
                        validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                    }
                    
                }
            }
        }
        
        if textField == damtexfield {
            if damtexfield.text!.count == 0{
            }
            else{
                if pvid != 3 {
                    if damIdValidationB == true {
                        validationId17SireDam(animalId: damtexfield.text!, tag: 4)
                    }
                }
            }
        }
        
        if textField == dateTextField {
            if dateTextField.text!.count == 0{
                
            }
            else{
                if dateTextField.text?.count == 10 {
                    let validate = isValidDate(dateString: dateTextField.text ?? "")
                    if validate == LocalizedStrings.correctFormatStr{ //true {
                        dateBtnOutlet.layer.borderColor = UIColor.gray.cgColor
                        dateBtnOutlet.layer.borderWidth = 0.5
                        validateDateFlag = true
                    } else {
                        dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
                        validateDateFlag = false
                        if validate == LocalizedStrings.greaterThenDateStr {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.dobSmallerthanCurrDate, comment: ""))
                            
                        } else {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
                        }
                    }
                    
                } else {
                    dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
                    validateDateFlag = false
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var animalTagValue = String()
        var farmIdValue = String()
        if textField == scanAnimalTagText || textField == farmIdTextField {
            if scanAnimalTagText.tag == 0 {
                scanAnimalText = scanAnimalTagText.text!.uppercased()
                farmIdText = farmIdTextField.text!.uppercased()
                animalTagValue = scanAnimalText
                farmIdValue = farmIdText
                if textField == scanAnimalTagText {
                    self.validationId17(animalId: animalTagValue.uppercased())
                    animalTagValue = scanAnimalTagText.text!.uppercased()
                  dataPopulateInFocusChange()
                }
            }
            else  {
                scanAnimalText = farmIdTextField.text!.uppercased()
                farmIdText = scanAnimalTagText.text!
                animalTagValue = scanAnimalText
                farmIdValue = farmIdText
                if animalTagValue != ""{
                    self.validationId17(animalId: animalTagValue.uppercased())
                    animalTagValue = farmIdTextField.text!.uppercased()
                    
                } else {
                    borderRedCheck = false
                }
            }
        }
        
        if selctionAuProvider == true {
            nationalHerdIdTextField.isHidden = false
            sireIAuTextField.isHidden = false
            nationalHerdIdTextField.isEnabled = true
            sireIAuTextField.isEnabled = true
            
        } else {
            nationalHerdIdTextField.isHidden = true
            sireIAuTextField.isHidden = true
            nationalHerdIdTextField.isEnabled = false
            sireIAuTextField.isEnabled = false
            
        }
        var samplename = String()
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        let animalData1 = fetchAnimaldataValidateAnimalwithouOrderID(entityName: Entities.animalMasterTblEntity, animalTag:animalTagValue.uppercased(), farmId: farmIdValue, animalbarCodeTag: scanBarcodeText.text!.uppercased(), offPermanentId: permanentIDTextField.text!.uppercased(), offDamId: damtexfield.text!.uppercased(), offsireId: sireIdTextField.text!.uppercased(),orderId:orderId,userId:userId,custmerId:custmerId ?? 0)
        
        if animalData1.count > 1 {
            for number in 0..<(animalData1.count-1) {
                let animId = animalData1.object(at: number) as? AnimalMaster
                let idAnim = animId?.animalId
                let useriD = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                let customerId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
                deleteDataWithAdh1(entity: Entities.animalMasterTblEntity, animalId: idAnim ?? 0, userId: Int(useriD ), custmerId: Int(customerId ))
            }
        }
        
        let animalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: Entities.animalMasterTblEntity, animalTag:animalTagValue.uppercased(), farmId: farmIdValue, animalbarCodeTag: scanBarcodeText.text!.uppercased(), offPermanentId: permanentIDTextField.text!.uppercased(), offDamId: damtexfield.text!.uppercased(), offsireId: sireIdTextField.text!.uppercased(),orderId:orderId,userId:userId,custmerId:custmerId ?? 0)
        
        if isautoPopulated == false {
            if animalData.count > 0 {
                self.view.hideToast()
                let data =  animalData.lastObject as! AnimalMaster
                if data.breedName == ButtonTitles.girolandoText || data.breedId == keyValue.girlandoNewBreedId.rawValue || data.breedName == BreedNames.girlandoBreed{
                } else {
                    barcodeflag = false
                    isautoPopulated = true
                    barAutoPopu = true
                    textFieldBackroungWhite()
                    updateOrder = true
                    dataAutoPopulatedBool =  true
                    let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                    animalId1 = Int(data.animalId)
                    if pvid == 3 {
                        sireIdValidationB = true
                        autoSuggestionStatus = true
                    } else {
                        sireIdValidationB = false
                        autoSuggestionStatus = false
                        
                    }
                    
                    if selctionAuProvider == true {
                        if data.sireIDAU != "" {
                            nationalHerdIdTextField.text = data.nationHerdAU
                            sireIAuTextField.text = data.sireIDAU
                        }
                        
                    } else {
                        nationalHerdIdTextField.text = data.nationHerdAU
                        sireIAuTextField.text = data.sireIDAU
                    }
                    
                    officalTagView.layer.borderColor = UIColor.gray.cgColor
                    farmIdView.layer.borderColor = UIColor.gray.cgColor
                    barcodeView.layer.borderColor = UIColor.gray.cgColor
                    permanentIDTextField.layer.borderColor = UIColor.gray.cgColor
                    sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                    damtexfield.layer.borderColor = UIColor.gray.cgColor
                    dateBtnOutlet.titleLabel!.text = ""
                    
                    if data.date != "" {
                        let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
                        let formatter = DateFormatter()
                        
                        if dateStr == "MM"{
                            var dateVale = ""
                            let values = data.date!.components(separatedBy: "/")
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = month + "/" + date + "/" + year
                            dateBtnOutlet.setTitle(dateVale, for: .normal)
                            dateTextField.text = dateVale
                            formatter.dateFormat = DateFormatters.MMddyyyyFormat
                        }
                        else {
                            var dateVale = ""
                            let values = data.date!.components(separatedBy: "/")
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = date + "/" + month + "/" + year
                            dateBtnOutlet.setTitle(dateVale, for: .normal)
                            dateTextField.text = dateVale
                            formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                        }
                        
                        self.selectedDate = formatter.date(from: dateBtnOutlet.titleLabel!.text!) ?? Date()
                        let isGreater = Date().isSmaller(than: selectedDate)
                        if isGreater == true {
                            dateBtnOutlet.setTitle("", for: .normal)
                            dateTextField.text = ""
                        }
                    }
                    
                    permanentIDTextField.text = data.offPermanentId
                    checkBarcode = false
                    incrementalBarcodeTitleLabel.textColor = .black
                    incrementalBarcodeButton.isEnabled = true
                    
                    let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.dataEntryAnimalAddTbl,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                    if dataFetch.count != 0 {
                        if data.orderstatus == "true"{
                          
                        } else {
                            scanBarcodeText.text = data.animalbarCodeTag
                            UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                            UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                            self.isBarcodeAutoIncrementedEnabled = false
                            incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                            incrementalBarcodeButton.isEnabled = false
                            incrementalBarcodeTitleLabel.textColor = .gray
                            checkBarcode = false
                            incrementalBarcodeCheckBox.alpha = 0.6
                            incrementalBarcodeTitleLabel.alpha = 0.6
                            UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlagDataEntry.rawValue)
                            matchedBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                            matchedBarcodeBtnOutlet.isEnabled = false
                            matchedBarcodeLbl.textColor = .gray
                            matchedBarcodeCheckBox.alpha = 0.6
                            matchedBarcodeBtnOutlet.alpha = 0.6
                            matchedBarcodeLbl.alpha = 0.6
                        }
                    }
                    
                    if data.breedId == "" {
                        let inheritBreed = fetchAllDataProductBreedIdDairy(entityName: Entities.getBreedsTblEntity,breedId:breedId,pvid:pvid)
                        if inheritBreed.count != 0 {
                            let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                            data.breedName = medbreedRegArr1?.alpha2 ?? medbreedRegArr1?.threeCharCode ?? medbreedRegArr1?.breedName
                            data.breedId = breedId
                        }
                    }
                    
                    if pvid == 3 {
                        damtexfield.text = data.offDamId?.uppercased()
                        
                    } else {
                        if data.offDamId?.count == 17 || data.offDamId?.count == 0 {
                            damtexfield.text = data.offDamId?.uppercased()
                        } else {
                            let replacedString = data.offDamId?.replacingOccurrences(of: " ", with: "")
                            damtexfield.text = replacedString?.uppercased()
                            validationId17SireDam(animalId: damtexfield.text!, tag: 4)
                        }}
                    
                    breedBtnOutlet.setTitle(data.breedName, for: .normal)
                    tissueBtnOutlet.setTitleColor(.black, for: .normal)
                    breedBtnOutlet.setTitleColor(.black, for: .normal)
                    tissueBtnOutlet.setTitle(data.tissuName, for: .normal)
                    UserDefaults.standard.set(data.tissuName, forKey: keyValue.dataEntryTsu.rawValue)
                    
                    if data.tissuName?.isEmpty == true {
                        self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue))
                        for items in self.tissueArr
                        {
                            let tissue = items  as? GetSampleTbl
                            let checkdefault  = tissue?.isDefault
                            
                            if pvid == 11 {
                                let country : String = UserDefaults.standard.object(forKey: keyValue.country.rawValue) as? String ?? ""
                                switch country  {
                                case countryName.Belgium.title, countryName.Luxembourg.title :
                                    self.saveSampleNameandID(sampleNameStr: ButtonTitles.allflexTSUText, sampleID: 1)
                                    self.tissueBtnOutlet.setTitle(ButtonTitles.allflexTSUText, for: .normal)
                                case countryName.Netherlands.title :
                                    self.saveSampleNameandID(sampleNameStr: LocalizedStrings.hairString, sampleID: 4)
                                    self.tissueBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.hairString, comment: ""), for: .normal)
                                default:
                                    break
                                }
                            } else if pvid == 8 {
                                self.saveSampleNameandID(sampleNameStr: LocalizedStrings.hairString, sampleID: 4)
                                self.tissueBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.hairString, comment: ""), for: .normal)
                            }
                            else {
                                if checkdefault == true
                                {
                                    self.saveSampleNameandID(sampleNameStr: tissue?.sampleName ?? "", sampleID: 4)
                                    self.tissueBtnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
                                }
                            }
                        }
                    }
                    breedId = data.breedId!
                    let breedidd =  UserDefaults.standard.value(forKey: keyValue.dataEntrybreedId.rawValue) as? String
                    if breedidd != breedId {
                        let  aDat = fetchAnimaldata(status: Entities.dataEntryAnimalAddTbl)
                        if aDat.count > 1{
                            UserDefaults.standard.set(true, forKey: keyValue.identifyStore.rawValue)
                        }
                    }
                    samplename = data.tissuName!
                    UserDefaults.standard.set(breedId, forKey: keyValue.dataEntrybreedId.rawValue)
                    
                    if data.gender == ButtonTitles.maleText.localized || data.gender == "M" {
                        self.male_femaleBtnOutlet.setImage(UIImage(named: "LangMale\(langCode)"), for: .normal)
                        genderToggleFlag = 1
                        genderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
                        
                    } else {
                        self.male_femaleBtnOutlet.setImage(UIImage(named: "LangFemale\(langCode)"), for: .normal)
                        genderToggleFlag = 0
                        genderString = ButtonTitles.femaleText.localized
                        
                    }
                    
                    let screenRefernce = UserDefaults.standard.value(forKey:keyValue.screen.rawValue) as? String
                    if screenRefernce == keyValue.farmId.rawValue || screenRefernce == "" {
                        scanAnimalTagText.text = data.farmId
                        UserDefaults.standard.set(data.animalTag!.uppercased(), forKey: keyValue.selectAnimalId.rawValue)
                        farmIdTextField.text = data.animalTag
                        if data.animalTag!.count  == 17 {
                            borderRedCheck = false
                            farmIdTextField.textColor = UIColor.black
                        }
                        
                    } else {
                        
                        scanAnimalTagText.text = data.animalTag
                        UserDefaults.standard.set(data.animalTag!.uppercased(), forKey: keyValue.selectAnimalId.rawValue)
                        farmIdTextField.text = data.farmId
                        
                        if data.animalTag?.count == 17 {
                            let twoString = data.animalTag
                            let twoBreed  = String((twoString?.prefix(2))!)
                            
                            if breedAr.contains(twoBreed) {
                                self.breedBtnOutlet.setTitle(twoBreed, for: .normal)
                                let codeId1 = fetchBreedDatabreedCode( entityName: Entities.getBreedsTblEntity,provId: self.pvid,breedCode:(self.breedBtnOutlet.titleLabel?.text)!)
                                let naabFetch11 = codeId1.value(forKey: keyValue.breedId.rawValue) as? NSArray
                                if naabFetch11!.count != 0 {
                                    let breedIdGet = (naabFetch11![0] as? String)!
                                    self.breedId = breedIdGet
                                    UserDefaults.standard.set(self.breedId, forKey: keyValue.dataEntrybreedId.rawValue)
                                    let breedName = codeId1.value(forKey: keyValue.alpha2.rawValue) as? NSArray
                                    if naabFetch11!.count != 0 {
                                        let nameBreed = (breedName![0] as? String)!
                                        self.breedBtnOutlet.setTitle(nameBreed, for: .normal)
                                    }
                                }
                            }
                        }
                    }
                    sireIdValidationB = false
                    damIdValidationB = false
                    singleBttn.layer.borderColor = UIColor.gray.cgColor
                    singleBttn.layer.borderWidth = 0.5
                    let et = data.eT
                    etBtn = et!
                    etBttn.layer.borderWidth = 0.5
                    singleBttn.layer.borderWidth = 0.5
                    multipleBirthBttn.layer.borderWidth = 0.5
                    cloneOutlet.layer.borderWidth = 0.5
                    SplitEmbryoOutlet.layer.borderWidth = 0.5
                    internalBtnOulet.layer.borderWidth = 0.5
    
                    if data.selectedBornTypeId == 3 {
                        etBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                        etBttn.layer.borderWidth = 2
                        singleBttn.layer.borderColor = UIColor.gray.cgColor
                        internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                        multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                        SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                        cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                        selectedBornTypeId = 3
                        
                    } else if data.selectedBornTypeId == 1 {
                        singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                        singleBttn.layer.borderWidth = 2
                        internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                        multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                        SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                        cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                        etBttn.layer.borderColor = UIColor.gray.cgColor
                        selectedBornTypeId = 1
                        
                    }
                    
                    else if data.selectedBornTypeId == 2 {
                        multipleBirthBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                        multipleBirthBttn.layer.borderWidth = 2
                        internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                        singleBttn.layer.borderColor = UIColor.gray.cgColor
                        SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                        cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                        etBttn.layer.borderColor = UIColor.gray.cgColor
                        selectedBornTypeId = 2
                    }
                    
                    else if data.selectedBornTypeId == 4 {
                        SplitEmbryoOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                        SplitEmbryoOutlet.layer.borderWidth = 2
                        internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                        singleBttn.layer.borderColor = UIColor.gray.cgColor
                        multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                        cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                        etBttn.layer.borderColor = UIColor.gray.cgColor
                        selectedBornTypeId = 4
                        
                    }
                    
                    else if data.selectedBornTypeId == 5 {
                        cloneOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                        cloneOutlet.layer.borderWidth = 2
                        internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                        singleBttn.layer.borderColor = UIColor.gray.cgColor
                        multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                        SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                        etBttn.layer.borderColor = UIColor.gray.cgColor
                        selectedBornTypeId = 5
                    }
                    
                    else if data.selectedBornTypeId == 6 {
                        internalBtnOulet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                        internalBtnOulet.layer.borderWidth = 2
                        cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                        singleBttn.layer.borderColor = UIColor.gray.cgColor
                        multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                        SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                        etBttn.layer.borderColor = UIColor.gray.cgColor
                        selectedBornTypeId = 6
                    }
                    
                    if pvid == 3 {
                        if ausBullId.contains(data.offsireId as Any) || sireNationalID.contains(data.offsireId as Any){
                            sireIdTextField.textColor = UIColor.black
                            let fetchData =  fetchAusNaabBullAgaintName(entityName: Entities.ausNaabBullTblEntity, sireNationalId: data.offsireId ?? "")
                            if fetchData.count != 0 {
                                let nationHerdAU1 = fetchData.object(at: 0) as? AusNaabBull
                                let bullId =   nationHerdAU1?.bullID ?? ""
                                sireIdTextField.text = bullId.uppercased()
                                
                            }
                        } else {
                            let replacedString = data.offsireId?.replacingOccurrences(of: " ", with: "")
                            sireIdTextField.text = replacedString?.uppercased()
                            validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                            
                            
                        }
                    } else  {
                        if data.offsireId?.count == 17 || data.offsireId?.count == 0{
                            sireIdTextField.text = data.offsireId?.uppercased()
                        } else {
                            let replacedString = data.offsireId?.replacingOccurrences(of: " ", with: "")
                            sireIdTextField.text = replacedString!.uppercased()
                            validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                        }
                    }
                    
                    tissuId = Int(data.tissuId)
                    textField.resignFirstResponder()
                    
                    if (textField == self.sireIAuTextField) {
                        self.nationalHerdIdTextField.becomeFirstResponder()
                        if sireIAuTextField.text == ""{
                            sireIAuTextField.layer.borderColor = UIColor.red.cgColor
                        }else{
                            sireIAuTextField.layer.borderColor = UIColor.gray.cgColor
                        }
                        
                    } else if (textField == self.nationalHerdIdTextField) {
                        self.nationalHerdIdTextField.resignFirstResponder()
                        if nationalHerdIdTextField.text == ""{
                            nationalHerdIdTextField.layer.borderColor = UIColor.red.cgColor
                        }else{
                            nationalHerdIdTextField.layer.borderColor = UIColor.gray.cgColor
                            addAnimalBtn(completionHandler: { (success) -> Void in
                            })
                        }
                    }
                    dateBtnOutlet.setTitleColor(.black, for: .normal)
                    statusOrder = false
                    messageCheck = false
                    let adata = fetchAllDataOrderStatusMaster(entityName: Entities.animalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
                    if adata.count > 0{
                        let animal  = adata.object(at: 0) as! AnimalMaster
                        idAnimal = Int(animal.animalId)
                        messageCheck = true
                    }
                }
            }
        }
        
        else{
            if scanAnimalTagText.text!.count > 0 {
                farmIdTextField.isEnabled = true
                scanBarcodeText.isEnabled = true
                permanentIDTextField.isEnabled = true
                tissueBtnOutlet.isEnabled = true
                breedBtnOutlet.isEnabled = true
                etBttn.isEnabled = true
                multipleBirthBttn.isEnabled = true
                singleBttn.isEnabled = true
                sireIdTextField.isEnabled = true
                damtexfield.isEnabled = true
                textFieldBackroungWhite()
                nationalHerdIdTextField.isEnabled = true
                sireIAuTextField.isEnabled = true
                male_femaleBtnOutlet.isEnabled = true
                bleBttn.isEnabled = true
                blebttn1.isEnabled = true
                scanButton.isEnabled = true
                dateTextField.isEnabled = true
            } else {
                farmIdTextField.isEnabled = false
                scanBarcodeText.isEnabled = false
                permanentIDTextField.isEnabled = false
                tissueBtnOutlet.isEnabled = false
                breedBtnOutlet.isEnabled = false
                etBttn.isEnabled = false
                multipleBirthBttn.isEnabled = false
                singleBttn.isEnabled = false
                sireIdTextField.isEnabled = false
                damtexfield.isEnabled = false
                nationalHerdIdTextField.isEnabled = false
                sireIAuTextField.isEnabled = false
                male_femaleBtnOutlet.isEnabled = false
                bleBttn.isEnabled = false
                blebttn1.isEnabled = false
                scanButton.isEnabled = false
                dateTextField.isEnabled = false
                if scanAnimalTagText.tag == 0 {
                    blebttn1.isEnabled = true
                    
                }
            }
        }
        
        if (textField == damtexfield ) {
            if selctionAuProvider == true {
                self.sireIAuTextField.becomeFirstResponder()
                if damtexfield.text?.count == 0 {
                } else {
                    if pvid != 3 {
                        validationId17SireDam(animalId: damtexfield.text!, tag: 4)
                    }
                }
                
            } else {
                damtexfield.resignFirstResponder()
                if damtexfield.text?.count == 0 {
                    addAnimalBtn(completionHandler: { (success) -> Void in
                    })
                    
                } else {
                    if pvid != 3 {
                        validationId17SireDam(animalId: damtexfield.text!, tag: 4)
                    }
                }
            }
        }
        
        else if (textField == self.scanAnimalTagText) {
            if scanAnimalTagText.text == "" {
                officalTagView.layer.borderColor = UIColor.red.cgColor
            } else {
                self.farmIdTextField.becomeFirstResponder()
                self.farmIdTextField.becomeFirstResponder()
            }
            self.farmIdTextField.becomeFirstResponder()
            
        }
        else if (textField == self.farmIdTextField) {
            if scanAnimalTagText.tag == 1{
                if borderRedCheck == true {
                    self.scanBarcodeText.becomeFirstResponder()
                    UserDefaults.standard.set("", forKey: keyValue.selectAnimalId.rawValue)
                } else {
                    self.scanBarcodeText.becomeFirstResponder()
                    farmIdView.layer.borderColor = UIColor.gray.cgColor
                }
            } else {
                self.scanBarcodeText.becomeFirstResponder()
            }
        }
    
        else if (textField == self.sireIdTextField) {
            if sireIdTextField.text == ""{
                self.damtexfield.becomeFirstResponder()
            }else{
                if autoSuggestionStatus == true {
                    self.damtexfield.becomeFirstResponder()
                    
                }else{
                    if pvid == 3 {
                    } else {
                        validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                    }
                    self.damtexfield.becomeFirstResponder()
                }
            }
        }
        
        else if (textField == self.sireIAuTextField) {
            self.nationalHerdIdTextField.becomeFirstResponder()
            if sireIAuTextField.text == ""{
            }else{
                sireIAuTextField.layer.borderColor = UIColor.gray.cgColor
            }
        }
        else if (textField == self.nationalHerdIdTextField) {
            self.nationalHerdIdTextField.resignFirstResponder()
            if nationalHerdIdTextField.text == ""{
            }else{
                nationalHerdIdTextField.layer.borderColor = UIColor.gray.cgColor
                addAnimalBtn(completionHandler: { (success) -> Void in
                })
            }
        }
        
        if samplename == "" {
            samplename = tissueBtnOutlet.titleLabel!.text ?? ""
            
        }
        if breedId == ""{
            breedId = "ea9b9e1b-cde8-4b7e-9207-5f699ad7df53"
            UserDefaults.standard.set(breedId, forKey: keyValue.dataEntrybreedId.rawValue)
        }
        if animalData.count > 0 {
            let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: pvid, breedId: breedId )
            if product.count == 0{
                let refreshAlert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.breedDoesNotExist, comment: ""), preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    self.byDefaultSetting()
                    self.isautoPopulated = false
                }))
                
                present(refreshAlert, animated: true, completion: nil)
            }
        }
        return true
    }
}
