//
//  OrderingAnimalVCiPadTextFldDelegates.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 18/01/25.
//

import Foundation
import UIKit

//MARK: TEXTFIELD DELEGATES
extension OrderingAnimalipadVC :UITextFieldDelegate  {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = UIColor.black
        dropDown.hide()
       
        
        if scanAnimalTagText.text!.count > 0 {
            farmIdTextField.isEnabled = true
            scanBarcodeText.isEnabled = true
         //   permanentIDTextField.isEnabled = true
            tissueBtnOutlet.isEnabled = true
            breedBtnOutlet.isEnabled = true
            etBttn.isEnabled = true
            multipleBirthBttn.isEnabled = true
            singleBttn.isEnabled = true
            sireIdTextField.isEnabled = true
            damtexfield.isEnabled = true
           // nationalHerdIdTextField.isEnabled = true
         //   sireIAuTextField.isEnabled = true
            male_femaleBtnOutlet.isEnabled = true
            male_femaleBtnOutlet.backgroundColor = UIColor.white

            bleBttn.isEnabled = true
            blebttn1.isEnabled = true
            scanButton.isEnabled = true
            dateTextField.isEnabled = true
            self.farmIdView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor
            self.officalTagView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor


        } else {
            male_femaleBtnOutlet.isEnabled = false
            male_femaleBtnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)

            farmIdTextField.isEnabled = false
            scanBarcodeText.isEnabled = false
         //   permanentIDTextField.isEnabled = false
            tissueBtnOutlet.isEnabled = false
            breedBtnOutlet.isEnabled = false
            etBttn.isEnabled = false
            multipleBirthBttn.isEnabled = false
            singleBttn.isEnabled = false
            sireIdTextField.isEnabled = false
            damtexfield.isEnabled = false
          //  nationalHerdIdTextField.isEnabled = false
          //  sireIAuTextField.isEnabled = false
            bleBttn.isEnabled = false
            scanButton.isEnabled = false
            blebttn1.isEnabled = false
            scanButton.isEnabled = false
            dateTextField.isEnabled = false
            textFieldBackroungGrey()
            if scanAnimalTagText.tag == 0 {
                blebttn1.isEnabled = true
            }
        }
        
        
        let selctionAuProvider = UserDefaults.standard.value(forKey: keyValue.clickAuProvider.rawValue) as? Bool
      
        if scanAnimalTagText.tag == 0 {
            if textField == farmIdTextField {
                self.farmIdView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor
                self.officalTagView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
                self.barcodeView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
                self.sireIdView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
                self.damIdView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
            }
            else if textField == scanAnimalTagText {
                self.officalTagView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor
                self.farmIdView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
                self.barcodeView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
                self.sireIdView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
                self.damIdView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
            }
            
            if textField != farmIdTextField && textField != scanAnimalTagText {
                self.farmIdView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
                self.officalTagView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
            }
            
            if textField == scanBarcodeText {
                self.barcodeView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor
                self.sireIdView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
                self.damIdView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
            }
            else if textField == sireIdTextField {
                self.barcodeView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
                self.sireIdView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor
                self.damIdView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
            }
            else if textField == damtexfield {
                self.barcodeView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
                self.sireIdView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
                self.damIdView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor
            }
        } else {
            if textField == farmIdTextField {
                self.farmIdView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor
                self.officalTagView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor


            }
            else {
                print("no")
                self.officalTagView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor
                self.farmIdView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor

            }
            
            if textField != farmIdTextField && textField != scanAnimalTagText {
                self.farmIdView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
                self.officalTagView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
            }
            
            if textField == scanBarcodeText {
                self.barcodeView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor
                self.sireIdView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
                self.damIdView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
            }
            else if textField == sireIdTextField {
                self.barcodeView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
                self.sireIdView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor
                self.damIdView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
            }
            else if textField == damtexfield {
                self.barcodeView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
                self.sireIdView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
                self.damIdView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor
            }
        }
        if selctionAuProvider == true {
            if (textField == nationalHerdIdTextField ) {
                nationalHerdIdTextField.returnKeyType = UIReturnKeyType.done
            } else {
                scanAnimalTagText.returnKeyType = UIReturnKeyType.next
                farmIdTextField.returnKeyType = UIReturnKeyType.next
             //   permanentIDTextField.returnKeyType = UIReturnKeyType.next
                scanBarcodeText.returnKeyType = UIReturnKeyType.next
                sireIdTextField.returnKeyType = UIReturnKeyType.next
                damtexfield.returnKeyType = UIReturnKeyType.next
              //  sireIAuTextField.returnKeyType = UIReturnKeyType.next
            }
            
        } else {
            if (textField == damtexfield ) {
                damtexfield.returnKeyType = UIReturnKeyType.done
            } else {
                scanAnimalTagText.returnKeyType = UIReturnKeyType.next
                farmIdTextField.returnKeyType = UIReturnKeyType.next
              //  permanentIDTextField.returnKeyType = UIReturnKeyType.next
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        super.touchesBegan(touches, with: event)
        dropDown.hide()
        let touch: UITouch? = touches.first
        if touch?.view != self.sideMenuViewVC {
            sideMenuState(expanded: false)
        }
    }
    
    func animateView (_ movement : CGFloat){
        UIView.animate(withDuration: 0.1, animations: {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement);
        })
    }
    
    func isCheckCountryUK() -> Bool {
        if providerName == keyValue.clarifideAHDBUK.rawValue {
            return true
        }else {
            return false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      
        if barAutoPopu == false {
            barcodeflag = true
        } else {
            let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.animalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
            if orederStatus.count > 0 {
                if textField == farmIdTextField || textField == scanAnimalTagText || textField == sireIdTextField || textField == damtexfield  {
                    barcodeEnable = true
                }
            }
        }
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let status : Bool = backSpacepressed(textField: textField, newString: string)
        if status == false {
            switch textField {
            case farmIdTextField:
                if farmIdTextField.tag == 1 {
                    btnTag = 1
                    var filteredData = [AnimalMaster]()
                    if self.adhAnimalData.count > 0 {
                        filteredData  =  self.adhAnimalData.filter { ($0.farmId?.lowercased())!.contains( newString.lowercased())}
                        filterAdhAnimalData = filteredData
                    }
                    self.AutoPopulateSuggetion(tag: 1)
                    if pvid == 11 {
                        let maxLength = 9
    //                    let currentString = (textField.text ?? "") as NSString
    //                    let newString = currentString.replacingCharacters(in: range, with: string)
                        let check  = LocalizedStrings.farmIdRegexAlphanumeric.contains(string)
                          if check == false {
                              return false
                          }
                      
                        return newString.count <= maxLength
                    }
                    var check  = LocalizedStrings.farmIdRegexAlphanumeric.contains(string)
                      if UserDefaults.standard.value(forKey: keyValue.keyboardSelection.rawValue) as? String == keyValue.numericKeyboard.rawValue {
                          check = LocalizedStrings.farmIdRegexNumeric.contains(string)
                      } else {
                          check = LocalizedStrings.farmIdRegexAlphanumeric.contains(string)
                      }
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
                                let alert = UIAlertController(title: NSLocalizedString("", comment: ""), message: LocalizedStrings.pleaseAddCountry.localized(with: providerCountryCodeAlpha2), preferredStyle: .alert)
                                let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                }
                                
                                alert.addAction(okAction)
                                self.present(alert, animated: true, completion: nil)
                                return false
                            }
                        } else {
                            if newString.count > 2 {
                                let check  = ACCEPTABLE_CHR.contains(string)
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
                    // this is for Canada
                    if pvid == 12 {
                        let maxLength = 12
    //                    let currentString = (textField.text ?? "") as NSString
    //                    let newString = currentString.replacingCharacters(in: range, with: string)
                        let check  = LocalizedStrings.farmIdRegexAlphanumeric.contains(string)
                          if check == false {
                              return false
                          }
                      
                        return newString.count <= maxLength
                    }
                    btnTag = 0
                    var filteredData = [AnimalMaster]()
                    if self.adhAnimalData.count > 0 {
                        filteredData  =  self.adhAnimalData.filter { ($0.animalTag?.lowercased())!.contains( newString.lowercased())}
                        filterAdhAnimalData = filteredData
                    }
                    
                    self.AutoPopulateSuggetion(tag: 0)
                    let check  = ACCEPTABLE_CHARACTERS.contains(string)
                    borderRedCheck = true
                    if check == false {
                        return false
                    }
                }
                
            case scanAnimalTagText:
                if scanAnimalTagText.text!.count >= 0 {
                    textFieldBackroungWhite()
                } else {
                    textFieldBackroungGrey()
                }
                barcodeflag = true
                
               
                
                if self.isBarcodeAutoIncrementedEnabled {
                    if isBarCodeEndsWithNumber_GetIncrementedBarCode(newString as String).isBarCodeEndsWithNumber  {
                        incrementalBarcodeCheckBox.image = UIImage(named: "incrementalCheckIpad")
                        UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
                        checkBarcode = false
                    } else {
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                        checkBarcode = true
                    }
                }
                
                if scanAnimalTagText.tag == 0 {
                    if pvid == 12 {
                        let maxLength = 12
    //                    let currentString = (textField.text ?? "") as NSString
    //                    let newString = currentString.replacingCharacters(in: range, with: string)
                        let check  = LocalizedStrings.farmIdRegexAlphanumeric.contains(string)
                          if check == false {
                              return false
                          }
                      
                        return newString.count <= maxLength
                    }
                    btnTag = 0
                    var filteredData = [AnimalMaster]()
                    if self.adhAnimalData.count > 0 {
                        filteredData  =  self.adhAnimalData.filter { ($0.animalTag?.lowercased())!.contains( newString.lowercased())}
                        filterAdhAnimalData = filteredData
                    }
                    self.AutoPopulateSuggetion(tag: 0)
                    let check  = ACCEPTABLE_CHARACTERS.contains(string)
                    borderRedCheck = true
                    if check == false {
                        return false
                    }
                    
                } else {
                    if pvid == 11 {
                        let maxLength = 9
    //                    let currentString = (textField.text ?? "") as NSString
    //                    let newString = currentString.replacingCharacters(in: range, with: string)
                        let check  = LocalizedStrings.farmIdRegexAlphanumeric.contains(string)
                          if check == false {
                              return false
                          }
                      
                        return newString.count <= maxLength
                    }
                    if pvid == 12 {
                        let maxLength = 12
    //                    let currentString = (textField.text ?? "") as NSString
    //                    let newString = currentString.replacingCharacters(in: range, with: string)
                        var check  = LocalizedStrings.farmIdRegexAlphanumeric.contains(string)
                          if UserDefaults.standard.value(forKey: keyValue.keyboardSelection.rawValue) as? String == keyValue.numericKeyboard.rawValue {
                              check = LocalizedStrings.farmIdRegexNumeric.contains(string)
                          } else {
                              check = LocalizedStrings.farmIdRegexAlphanumeric.contains(string)
                          }
                          if check == false {
                              return false
                          }
                      
                        return newString.count <= maxLength
                    }
                    btnTag = 1
                    var filteredData = [AnimalMaster]()
                    if self.adhAnimalData.count > 0 {
                        filteredData  =  self.adhAnimalData.filter { ($0.farmId?.lowercased())!.contains( newString.lowercased())}
                        filterAdhAnimalData = filteredData
                    }
                    self.AutoPopulateSuggetion(tag: 1)
                    
                    var check  = LocalizedStrings.farmIdRegexAlphanumeric.contains(string)
                      if UserDefaults.standard.value(forKey: keyValue.keyboardSelection.rawValue) as? String == keyValue.numericKeyboard.rawValue {
                          check = LocalizedStrings.farmIdRegexNumeric.contains(string)
                      } else {
                          check = LocalizedStrings.farmIdRegexAlphanumeric.contains(string)
                      }
                    if check == false {
                        return false
                    }

                }
                
            case scanBarcodeText:
                barcodeflag = true
                if self.isBarcodeAutoIncrementedEnabled {
                    if isBarCodeEndsWithNumber_GetIncrementedBarCode(newString as String).isBarCodeEndsWithNumber  {
                        incrementalBarcodeCheckBox.image = UIImage(named: "incrementalCheckIpad")
                        UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
                        checkBarcode = false
                    } else {
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                        checkBarcode = true
                    }
                }
                
            case sireIdTextField :
                let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
                if providerName == keyValue.auDairyProducts.rawValue {
                    
                    if textField == sireIdTextField {
                        if let char = string.cString(using: String.Encoding.utf8) {
                            
                            let isBackSpace1 = strcmp(char, "\\b")
                            if (isBackSpace1 == -92) {
                                isautoPopulated = false
                                autoSuggestionStatus = false
                                sireIdValidationB = true
                                
                            }
                            
                            if pvid == 3{
                                sireIdValidationB = true
                            }
                            
                            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                            btnTag = 30
                            let bPredicate: NSPredicate = NSPredicate(format: "srcLine contains[cd] %@", newString)
                            fetchNaabBullArray = fetchAusNaabBullData().filtered(using: bPredicate) as NSArray
                            autocompleteUrls1 = fetchNaabBullArray.mutableCopy() as! NSMutableArray
                            autocompleteUrlsbullname.removeAllObjects()
                            autocompleteUrls2.removeAllObjects()
                            sireNatonIdArray.removeAllObjects()
                            self.tableViewpopAutosugesstion()
                            self.AutoPopulateBullTableForAU()
                        }
                        
                    }
                }
            case damtexfield:
                damiidTextValueStore = damtexfield.text!
                isautoPopulated = false
                if pvid == 3{
                    damIdValidationB = false
                    
                }else {
                    damIdValidationB = true
                }
                let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                if animalDataMaster.count > 0 {
                    msgUpatedd = true
                    //barcodeflag = true
                }
            case dateTextField:
                if dateTextField.text?.count == 2 || dateTextField.text?.count == 5{
                    dateTextField.text?.append("/")
                }
                if dateTextField.text?.count == 10 {
                    return false
                }
                
            default:
                break
            }
        }
        checkOtherTextfield()
        return true
    }
    
    
    func backSpacepressed(textField: UITextField, newString: String) ->Bool{
        if let char = newString.cString(using: String.Encoding.utf8) {
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
                    let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                    if animalDataMaster.count > 0 {
                        msgUpatedd = true
                    }
                    if scanAnimalTagText.text!.count == 1 {
                        textFieldBackroungGrey()
                        buttonbgAutoSuggestion.removeFromSuperview()
                    } else {
                        textFieldBackroungWhite()
                    }
                    
                } else if textField == farmIdTextField{
                    if borderRedChange == false {
                        isautoPopulated = false
                        if scanAnimalTagText.tag == 1{
                            borderRedCheck = true
                        }
                        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                        if animalDataMaster.count > 0 {
                            msgUpatedd = true
                        }
                        
                        sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                        damtexfield.layer.borderColor = UIColor.gray.cgColor
                    }
                }
                else if textField == sireIdTextField {
                    isautoPopulated = false
                    if pvid != 3{
                        sireIdValidationB = true
                    }
                    
                    let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                    if animalDataMaster.count > 0 {
                        msgUpatedd = true
                    }
                    
                    if textField.text?.count == 1 {
                        AutoSuggestionTableView.isHidden = true
                        buttonbgAutoSuggestion.removeFromSuperview()
                        
                    }
                }
                else if textField == damtexfield {
                    damiidTextValueStore = damtexfield.text!
                    isautoPopulated = false
                    if pvid == 3{
                        damIdValidationB = false
                        
                    }else {
                        damIdValidationB = true
                    }
                    let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                    if animalDataMaster.count > 0 {
                        msgUpatedd = true
                    }
                }
                else if textField == scanBarcodeText{
                    barcodeflag = true
                    if scanBarcodeText.text!.count == 1 {
                        self.isBarcodeAutoIncrementedEnabled = false
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                        checkBarcode = false
                        incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                    }
                }
                return true
            }
        }else {
            if textField == scanAnimalTagText{
                textFieldBackroungWhite()
            }
        }
        return false
    }
    
    func checkOtherTextfield () {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
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
        let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.animalMasterTblEntity, animalId: idAnimal, customerID: custmerId)
        if animalFetch.count > 0{
            statusOrder = true
        }
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
        
        if isautoPopulated == true {
            let animalData = fetchAnimaldataValidateAnimalTag(entityName: Entities.animalAddTblEntity, animalTag:scanAnimalText, orderId: orderId, userId: userId, animalId: animalId1)
            if animalData.count == 0{
                let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalMasterTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                if animalDataMaster.count > 0 {
                    msgcheckk = true
                }
            }
        }
    }
    
    func textField123(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if barAutoPopu == false {
            barcodeflag = true
        } else {
            let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.animalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
            if orederStatus.count > 0 {
                if textField == farmIdTextField || textField == scanAnimalTagText || textField == sireIdTextField || textField == damtexfield  {
                    barcodeEnable = true
                }
            }
        }
        
        if textField == scanBarcodeText {
            let currentString: NSString = scanBarcodeText.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            
            barcodeflag = true
            if self.isBarcodeAutoIncrementedEnabled {
                if isBarCodeEndsWithNumber_GetIncrementedBarCode(newString as String).isBarCodeEndsWithNumber  {
                    incrementalBarcodeCheckBox.image = UIImage(named: "incrementalCheckIpad")
                    UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
                    checkBarcode = false
                } else {
                    UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                    checkBarcode = true
                }
            }
        }
        
        let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
        if providerName == keyValue.auDairyProducts.rawValue {
            
            if textField == sireIdTextField {
                if let char = string.cString(using: String.Encoding.utf8) {
                    let isBackSpace1 = strcmp(char, "\\b")
                    if (isBackSpace1 == -92) {
                        isautoPopulated = false
                        autoSuggestionStatus = false
                        sireIdValidationB = true
                        
                    }
                    if pvid == 3{
                        sireIdValidationB = true
                    }
                    
                    let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                    btnTag = 30
                    let bPredicate: NSPredicate = NSPredicate(format: "srcLine contains[cd] %@", newString)
                    fetchNaabBullArray = fetchAusNaabBullData().filtered(using: bPredicate) as NSArray
                    autocompleteUrls1 = fetchNaabBullArray.mutableCopy() as! NSMutableArray
                    autocompleteUrlsbullname.removeAllObjects()
                    autocompleteUrls2.removeAllObjects()
                    sireNatonIdArray.removeAllObjects()
                    
                    self.tableViewpopAutosugesstion()
                    var yFrame = 460 - self.scrolView.contentOffset.y
                    
                    if UIDevice().userInterfaceIdiom == .phone {
                        switch UIScreen.main.nativeBounds.height {
                        case 1136:
                            break
                        case 1334:
                            yFrame = 460 - self.scrolView.contentOffset.y
                            
                        case 1920, 2208:
                            yFrame = 470 - self.scrolView.contentOffset.y
                            
                        case 2436:
                            yFrame = 475 - self.scrolView.contentOffset.y
                            
                        case 2688,2796:
                            yFrame = 490 - self.scrolView.contentOffset.y
                            
                        case 1792:
                            yFrame = 490 - self.scrolView.contentOffset.y
                            
                        case 2532:
                            yFrame = 490 - self.scrolView.contentOffset.y
                            
                        case 2340:
                            yFrame = 475 - self.scrolView.contentOffset.y
                            
                        case 2778:
                            yFrame = 500 - self.scrolView.contentOffset.y
                            
                        default:
                            yFrame = 400 - self.scrolView.contentOffset.y
                        }
                    }
                    for i in 0..<autocompleteUrls1.count {
                        let f = autocompleteUrls1.object(at:i) as! AusNaabBull
                        let farmName = f.bullID
                        let sirename = f.sireName
                        let sireNationlId = f.bullID
                        autocompleteUrlsbullname.add(sirename!)
                        sireNatonIdArray.add(sireNationlId!)
                        autocompleteUrls2.add(farmName!)
                    }
                    
                    if autocompleteUrls2.count < 3 {
                        AutoSuggestionTableView.frame = CGRect(x: 15,y: yFrame + 72,width: 350,height: 80)
                    } else {
                        if UIDevice().userInterfaceIdiom == .phone {
                            switch UIScreen.main.nativeBounds.height {
                            case 1136:
                                break
                            case 1334:
                                AutoSuggestionTableView.frame = CGRect(x: 15,y: yFrame - 95 ,width: 350,height: 250)
                                
                            case 1920, 2208:
                                AutoSuggestionTableView.frame = CGRect(x: 30,y: yFrame - 95 ,width: 350,height: 250)
                                
                            case 2436:
                                AutoSuggestionTableView.frame = CGRect(x: 13,y: yFrame - 95 ,width: 350,height: 250)
                                
                            case 2688,2796:
                                AutoSuggestionTableView.frame = CGRect(x: 30,y: yFrame - 95 ,width: 350,height: 250)
                                
                            case 1792:
                                AutoSuggestionTableView.frame = CGRect(x: 30,y: yFrame - 95 ,width: 350,height: 250)
                                
                            case 2532:
                                AutoSuggestionTableView.frame = CGRect(x: 15,y: yFrame - 95 ,width: 350,height: 250)
                                
                            case 2340:
                                AutoSuggestionTableView.frame = CGRect(x: 12,y: yFrame - 95 ,width: 350,height: 250)
                                
                            case 2778:
                                AutoSuggestionTableView.frame = CGRect(x: 33,y: yFrame - 95 ,width: 350,height: 250)
                                
                            default:
                                AutoSuggestionTableView.frame = CGRect(x: 15,y: yFrame - 95 ,width: 350,height: 250)
                            }
                        }
                    }
                    if autocompleteUrls2.count == 0 {
                        AutoSuggestionTableView.isHidden = true
                        buttonbgAutoSuggestion.removeFromSuperview()
                    }
                    else{
                        AutoSuggestionTableView.isHidden = false
                        AutoSuggestionTableView.reloadData()
                    }
                }
            }
        }
        
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
                    let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                    if animalDataMaster.count > 0 {
                        msgUpatedd = true
                    }
                    if scanAnimalTagText.text!.count == 1 {
                        textFieldBackroungGrey()
                        buttonbgAutoSuggestion.removeFromSuperview()
                    } else {
                        textFieldBackroungWhite()
                    }
                    
                } else if textField == farmIdTextField{
                    
                    if borderRedChange == false {
                        isautoPopulated = false
                        if scanAnimalTagText.tag == 1{
                            borderRedCheck = true
                        }
                        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                        if animalDataMaster.count > 0 {
                            msgUpatedd = true
                        }
                        sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                        damtexfield.layer.borderColor = UIColor.gray.cgColor
                    }
                } else if textField == sireIdTextField {
                    isautoPopulated = false
                    if pvid != 3{
                        sireIdValidationB = true
                    }
                    let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                    if animalDataMaster.count > 0 {
                        msgUpatedd = true
                    }
                } else if textField == damtexfield {
                    damiidTextValueStore = damtexfield.text!
                    isautoPopulated = false
                    if pvid == 3{
                        damIdValidationB = false
                        
                    }else {
                        damIdValidationB = true
                    }
                    let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                    if animalDataMaster.count > 0 {
                        msgUpatedd = true
                        //barcodeflag = true
                    }
                }
                else if textField == scanBarcodeText{
                    barcodeflag = true
                    if scanBarcodeText.text!.count == 1 {
                        self.isBarcodeAutoIncrementedEnabled = false
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                        checkBarcode = false
                        incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                    }
                }
                return true
            }
        }
        else {
            if textField == scanAnimalTagText{
                textFieldBackroungWhite()
            }
        }
        
        if scanAnimalTagText.tag == 0 {
            if textField == scanAnimalTagText {
                let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                btnTag = 0
                var filteredData = [AnimalMaster]()
                filteredData  =  self.adhAnimalData.filter { ($0.farmId?.lowercased())!.contains( newString.lowercased())}
                
                filterAdhAnimalData = filteredData
                self.AutoPopulateSuggetion(tag: 0)
                
                let ACCEPTABLE_CHARACTERS = LocalizedStrings.alphaNumericFormat
                let check  = ACCEPTABLE_CHARACTERS.contains(string)
                borderRedCheck = true
                if check == false {
                    return false
                }
                
                if pvid == 12 {
                    let maxLength = 12
//                    let currentString = (textField.text ?? "") as NSString
//                    let newString = currentString.replacingCharacters(in: range, with: string)
                    let check  = LocalizedStrings.farmIdRegexAlphanumeric.contains(string)
                      if check == false {
                          return false
                      }
                  
                    return newString.count <= maxLength
                }
            }
        }
        else {
            
            if textField == farmIdTextField {
                let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                btnTag = 1
                var filteredData = [AnimalMaster]()
                filteredData  =  self.adhAnimalData.filter { ($0.animalTag?.lowercased())!.contains( newString.lowercased())}
                filterAdhAnimalData = filteredData
                self.AutoPopulateSuggetion(tag: 1)
                
                let ACCEPTABLE_CHARACTERS = LocalizedStrings.abcdAcceptableStr
                let check  = ACCEPTABLE_CHARACTERS.contains(string)
                borderRedCheck = true
                if check == false {
                    return false
                }
                
                if pvid == 12 {
                    let maxLength = 12
//                    let currentString = (textField.text ?? "") as NSString
//                    let newString = currentString.replacingCharacters(in: range, with: string)
                    let check  = LocalizedStrings.farmIdRegexAlphanumeric.contains(string)
                      if check == false {
                          return false
                      }
                  
                    return newString.count <= maxLength
                }
                
            }else if textField == scanAnimalTagText {
                if string.cString(using: String.Encoding.utf8) != nil {
                    
                    textFieldBackroungWhite()
                    let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                    
                    btnTag = 0
                    var filteredData = [AnimalMaster]()
                    filteredData  =  self.adhAnimalData.filter { ($0.farmId?.lowercased())!.contains( newString.lowercased())}
                    filterAdhAnimalData = filteredData
                    self.AutoPopulateSuggetion(tag: 0)
                    let ACCEPTABLE_CHARACTERS = LocalizedStrings.alphaNumericFormat
                    let check  = ACCEPTABLE_CHARACTERS.contains(string)
                    
                    if check == false {
                        return false
                    }
                    if pvid == 12 {
                        let maxLength = 12
    //                    let currentString = (textField.text ?? "") as NSString
    //                    let newString = currentString.replacingCharacters(in: range, with: string)
                        let check  = LocalizedStrings.farmIdRegexAlphanumeric.contains(string)
                          if check == false {
                              return false
                          }
                      
                        return newString.count <= maxLength
                    }
                }
            }
        }
        
        if textField == sireIdTextField {
            isautoPopulated = false
            if pvid != 3{
                sireIdValidationB = true
            }
        }
        
        if textField == damtexfield {
            let ACCEPTABLE_CHARACTERS = LocalizedStrings.alphaNumericFormat
            let check  = ACCEPTABLE_CHARACTERS.contains(string)
            if pvid == 3{
                damIdValidationB = false
            }
            else {
                damIdValidationB = true
            }
            if check == false {
                return false
            }
        }
        
        if textField == scanBarcodeText {
            let ACCEPTABLE_CHARACTERS = LocalizedStrings.acceptableChrString
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
        
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
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
        let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.animalMasterTblEntity, animalId: idAnimal, customerID: custmerId)
        if animalFetch.count > 0{
            statusOrder = true
        }
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
        if isautoPopulated == true {
            let animalData = fetchAnimaldataValidateAnimalTag(entityName: Entities.animalAddTblEntity, animalTag:scanAnimalText, orderId: orderId, userId: userId, animalId: animalId1)
            if animalData.count == 0{
                let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalMasterTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                if animalDataMaster.count > 0 {
                    msgcheckk = true
                }
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

      var animalTagValue = String()
        var farmIdValue = String()
        if textField == scanAnimalTagText || textField == farmIdTextField {
            
            if scanAnimalTagText.tag == 0 {
                scanAnimalText = scanAnimalTagText.text!.uppercased()
                farmIdText = farmIdTextField.text!.uppercased()
                self.farmIdView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor

                animalTagValue = scanAnimalText
                farmIdValue = farmIdText
                if scanAnimalTagText.text != "" {
                    
                    if textField == scanAnimalTagText  {
                        if borderRedCheck == true  &&  animalTagValue.count != 17{
                            let replacedString = animalTagValue.replacingOccurrences(of: " ", with: "")
                            self.validationId17(animalId: replacedString.uppercased())
                            animalTagValue = scanAnimalTagText.text!.uppercased()
                            dataPopulateInFocusChange()
                        }
                        
                    } else {
                        let animalTag1 = fetchAnimaldataValidateFamID(entityName: Entities.animalMasterTblEntity,farmId:farmIdTextField.text ?? "",custmerId: custmerId , userId: userId, animalId: Int64(animalId1))
                        
                        if animalTag1.count != 0 {
                            onfarmidtext = farmIdTextField.text ?? ""
                            fetchrecord = true
                        }
                    }
                }
                
                
                if UserDefaults.standard.bool(forKey: keyValue.matchedBarcodeFlag.rawValue) == true {
                    if scanBarcodeText.text?.count == 0 {
                        if scanAnimalTagText.text?.count == 17 {
                            let str = scanAnimalTagText.text!
                            let start = str.index(str.startIndex, offsetBy: 2)
                            let end = str.index(str.endIndex, offsetBy: -12)
                            let range = start..<end
                            let subStr = str[range]
                            
                            if subStr == "840" {
                                scanBarcodeText.text = String(scanAnimalTagText.text!.dropFirst(2))
                            }
                            else
                            {
                                let alert = UIAlertController(title: NSLocalizedString("", comment: ""), message: NSLocalizedString(LocalizedStrings.cannotCopyOfficialId, comment: ""), preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: { [self]  (_) in
                                    matchedBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                                    UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlag.rawValue)
                                    barcodefixed = false
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
                if scanAnimalText.count < 17{
                    savebarcodecopyofficialid = scanAnimalText
                }
                farmIdText = scanAnimalTagText.text!
                self.officalTagView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
                self.farmIdView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor


                animalTagValue = scanAnimalText
                farmIdValue = farmIdText
                if animalTagValue != ""{
                    if borderRedCheck == false &&  animalTagValue.count == 17
                    {
                        
                        let fetchListId = fetchAnimaldataValidateFamIDGetListId(entityName: Entities.animalAddTblEntity,farmId:scanAnimalTagText.text ?? "",custmerId: custmerId , userId: userId)
                        if fetchListId.count != 0 {
                            let listIdGetObject = fetchListId.object(at: 0) as! AnimaladdTbl
                            self.listIdGet = Int(listIdGetObject.listId)
                            
                        }
                        let animalTag1 = fetchAnimaldataValidateFamIDListId(entityName: Entities.animalMasterTblEntity,farmId:scanAnimalTagText.text ?? "",custmerId: custmerId , userId: userId, animalId: Int64(animalId1),listId:Int64(listIdGet))
                        
                        if animalTag1.count != 0 &&  dataAutoPopulatedBool == true {//&& farmiDValueStore != farmIdText{
                            farmIDBoolEntrySecond = true
                            officalTagView.layer.borderColor = UIColor.red.cgColor
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.duplicateEntryStr, comment: ""))
                        } else {
                            officalTagView.layer.borderColor = UIColor.gray.cgColor
                        }
                        
                    } else {
                        var replacedString: String = animalTagValue.replacingOccurrences(of: " ", with: "")
                        
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
                        
                        let bbb =  fetchAnimaldataValidateAnimalBarcodetag(entityName: Entities.animalAddTblEntity,animalbarCodeTag:animalTagValue ,orderId: orderId, userId: userId, custmerId: custmerId)
                        
                        if bbb.count != 0 &&  dataAutoPopulatedBool == true{
                            farmIDBoolEntry = true
                            farmIdView.layer.borderColor = UIColor.red.cgColor
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.duplicateEntryStr, comment: ""))
                        } else {
                            let screenRefernce = UserDefaults.standard.value(forKey:keyValue.screen.rawValue) as? String
                            
                            if screenRefernce == keyValue.officialId.rawValue || screenRefernce == ""{
                                if textField != farmIdTextField {
                                    dataPopulateInFocusChange()
                                }
                                
                            }
                            else{
                                newanimaltagvalue = animalTagValue
                                mainrecord = true
                            }
                        }
                    }
                    
                } else {
                    borderRedCheck = false
                    checkfarmbool = true
                    if animalTagValue.count == 0 && dataAutoPopulatedBool == true {
                        let animalTag1 = fetchAnimaldataValidateFamID(entityName: Entities.animalMasterTblEntity,farmId:scanAnimalTagText.text ?? "",custmerId: custmerId , userId: userId, animalId: Int64(animalId1))
                        
                        if textField == scanAnimalTagText {
                            dataPopulateInFocusChange()
                        }
                        
                        else if textField == farmIdTextField {
                            if animalTag1.count != 0 && farmIdTextField.text?.count != 0 {
                                dataPopulateInFocusChange()
                            }
                        }
                    }
                    else {
                        dataPopulateInFocusChange()
                    }
                }
                
                
                if UserDefaults.standard.bool(forKey: keyValue.matchedBarcodeFlag.rawValue) == true {
                    
                    if scanBarcodeText.text?.count == 0 {
                        if farmIdTextField.text?.count == 17{
                            let str = farmIdTextField.text!
                            let start = str.index(str.startIndex, offsetBy: 2)
                            let end = str.index(str.endIndex, offsetBy: -12)
                            let range = start..<end
                            let subStr = str[range]
                            
                            if subStr == "840" {
                                scanBarcodeText.text = String(farmIdTextField.text!.dropFirst(2))
                            }
                            else{
                                let alert = UIAlertController(title: NSLocalizedString("", comment: ""), message: NSLocalizedString(LocalizedStrings.cannotCopyOfficialId, comment: ""), preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: { [self]  (_) in
                                    matchedBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                                    UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlag.rawValue)
                                    barcodefixed = false
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
            if sireIdTextField.text!.count != 0{
                if  providerName == keyValue.clarifideCDCBUS.rawValue || providerName == keyValue.clarifideAHDBUK.rawValue || providerName == keyValue.auDairyProducts.rawValue{
                    if sireIdTextField.text! == scanAnimalTagText.text! || sireIdTextField.text! == farmIdTextField.text!{
                        siraidcheck = true
                    }
                    else{
                        siraidcheck = false
                        damtexfield.isUserInteractionEnabled = true
                        sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                        damtexfield.becomeFirstResponder()
                        
                    }
                }
                damtexfield.isUserInteractionEnabled = true
                
                if sireIdValidationB == true {
                    if pvid == 3 {
                        if ausBullId.contains(sireIdTextField.text?.uppercased() as Any) || sireNationalID.contains(sireIdTextField.text?.uppercased() as Any){
                            sireIdValidationB = false
                        } else {
                            validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                            if sireIdTextField.text! == scanAnimalTagText.text! || sireIdTextField.text! == farmIdTextField.text! {
                                siraidcheck = true
                            }
                            else
                            {
                                siraidcheck = false
                                damtexfield.isUserInteractionEnabled = true
                                sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                                damtexfield.becomeFirstResponder()
                            }
                        }
                    } else {
                        
                        validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                        if sireIdTextField.text! == scanAnimalTagText.text! || sireIdTextField.text! == farmIdTextField.text! {
                            siraidcheck = true
                            return
                        }
                        else
                        {
                            siraidcheck = false
                            damtexfield.isUserInteractionEnabled = true
                            sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                            damtexfield.becomeFirstResponder()
                        }
                        
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
            else {
                if dateTextField.text?.count == 10 {
                    let validate = isValidDate(dateString: dateTextField.text ?? "")
                    
                    if validate == LocalizedStrings.correctFormatStr{
//                        dateBtnOutlet.layer.borderColor = UIColor.gray.cgColor
//                        dateBtnOutlet.layer.borderWidth = 0.5
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
        
        let animalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: Entities.animalMasterTblEntity, animalTag:animalTagValue.uppercased(), farmId: farmIdValue, animalbarCodeTag: scanBarcodeText.text!.uppercased(), offPermanentId: "", offDamId: damtexfield.text!.uppercased(), offsireId: sireIdTextField.text!.uppercased(),orderId:orderId,userId:userId,custmerId:custmerId )
      //  permanentIDTextField.text!.uppercased()
        if animalData.count > 0 {
            let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: pvid, breedId: breedId )
            if product.count == 0{
                let refreshAlert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.breedDoesNotExist, comment: ""), preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    self.byDefaultSetting()
                    self.textFieldBackroungGrey()
                    self.isautoPopulated = false
                }))
                present(refreshAlert, animated: true, completion: nil)
            }
        }
        
        let samType = fetchproviderDataChekValidation( entityName : Entities.getSampleTblEntity, provId: pvid,sampleID:sampleID)
        if samType.count == 0 {
            let refreshAlert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.sampleTypeDoesNotExist, comment: ""), preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.byDefaultSetting()
                self.textFieldBackroungGrey()
                self.isautoPopulated = false
                if self.pvid == 8 {
                    self.tissueBtnOutlet.setTitle(LocalizedStrings.hairString.localized, for: .normal)
                    self.saveSampleNameandID(sampleNameStr: LocalizedStrings.hairString, sampleID: 4)
                } else {
                    self.tissueBtnOutlet.titleLabel!.text = ButtonTitles.allflexTSUText
                    self.tissueBtnOutlet.setTitle(ButtonTitles.allflexTSUText, for: .normal)
                    self.saveSampleNameandID(sampleNameStr: ButtonTitles.allflexTSUText, sampleID: 1)
                }
            }))
            present(refreshAlert, animated: true, completion: nil)
            
        }
    }
    
    func isValidDate(dateString: String) -> String {
        let dateFormatterGet = DateFormatter()
        
        let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        if dateStr == "MM"{
            dateFormatterGet.dateFormat = DateFormatters.MMddyyyyFormat
        } else {
            dateFormatterGet.dateFormat = DateFormatters.ddMMyyyyFormat
            
        }
        if let dateGet = dateFormatterGet.date(from: dateString) {
            let smallDate = dateGet.isSmallerThan(Date())
            
            if smallDate == false {
                return LocalizedStrings.greaterThenDateStr
            }
            return LocalizedStrings.correctFormatStr
        } else {
            return LocalizedStrings.invalidFormatStr
        }
    }
    
    func autoShowFarmIDPopUp(){}
    
    func dataPopulateInFocusChange(){
        var animalTagValue = String()
        var farmIdValue = String()
        
        if scanAnimalTagText.tag == 0 {
            scanAnimalText = scanAnimalTagText.text!.uppercased()
            farmIdText = farmIdTextField.text!.uppercased()
            animalTagValue = scanAnimalText
            farmIdValue = farmIdText
        }
        else  {
            scanAnimalText = farmIdTextField.text!.uppercased()
            farmIdText = scanAnimalTagText.text!
            animalTagValue = scanAnimalText
            farmIdValue = farmIdText
        }
        
        let animalData1 = fetchAnimaldataValidateAnimalwithouOrderIDAND(entityName: Entities.dataEntryAnimalAddTbl, animalTag:animalTagValue.uppercased(), farmId: farmIdValue, animalbarCodeTag: scanBarcodeText.text!.uppercased(), offPermanentId: "", offDamId: damtexfield.text!.uppercased(), offsireId: sireIdTextField.text!.uppercased(),orderId:orderId,userId:userId,custmerId:custmerId)
        //needs confirmation
      //  permanentIDTextField.text!.uppercased()
        if animalData1.count > 1 {
            for number in 0..<(animalData1.count-1) {
                let animId = animalData1.object(at: number) as? AnimalMaster
                let idAnim = animId?.animalId
                let useriD = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                let customerId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
                deleteDataWithAdh1(entity: Entities.animalMasterTblEntity, animalId: idAnim ?? 0, userId: Int(useriD ), custmerId: Int(customerId ))
            }
        }
        
        let animalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: Entities.animalMasterTblEntity, animalTag:animalTagValue.uppercased(), farmId: farmIdValue, animalbarCodeTag: scanBarcodeText.text!.uppercased(), offPermanentId: "", offDamId: damtexfield.text!.uppercased(), offsireId: sireIdTextField.text!.uppercased(),orderId:orderId,userId:userId,custmerId:custmerId )
        //needs confirmation
      //  permanentIDTextField.text!.uppercased()
        let animalCartData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: Entities.animalAddTblEntity, animalTag:animalTagValue.uppercased(), farmId: farmIdValue, animalbarCodeTag: scanBarcodeText.text!.uppercased(), offPermanentId: "", offDamId: damtexfield.text!.uppercased(), offsireId: sireIdTextField.text!.uppercased(),orderId:orderId,userId:userId,custmerId:custmerId) as! [AnimaladdTbl]
        //needs confirmation
      //  permanentIDTextField.text!.uppercased()
        
        if isautoPopulated == false {
            if animalCartData.count > 0{
                loadedAnimalData = animalCartData[0]
            }
            if animalData.count > 0 {
                self.view.hideToast()
                let data = animalData.lastObject as! AnimalMaster
                if data.breedName == ButtonTitles.girolandoText || data.breedId == keyValue.girlandoNewBreedId.rawValue || data.breedName == BreedNames.girlandoBreed{
                    return
                }
                
                adhDataServerAutoPopulate = data.adhDataServer
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
//                        nationalHerdIdTextField.text = data.nationHerdAU
//                        sireIAuTextField.text = data.sireIDAU
                    }
                    
                } else {
//                    nationalHerdIdTextField.text = data.nationHerdAU
//                    sireIAuTextField.text = data.sireIDAU
                }
                
                
                officalTagView.layer.borderColor = UIColor.gray.cgColor
                farmIdView.layer.borderColor = UIColor.gray.cgColor
                barcodeView.layer.borderColor = UIColor.gray.cgColor
               // permanentIDTextField.layer.borderColor = UIColor.gray.cgColor
                sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                damtexfield.layer.borderColor = UIColor.gray.cgColor
                dateBtnOutlet.titleLabel!.text = "MM/DD/YYYY"
                
                
                if data.date == "DD/MM/YYYY" || data.date == "MM/DD/YYYY"  {
                    dateBtnOutlet.setTitle("", for: .normal)
                    dateBtnOutlet.titleLabel?.text = ""
                    dateTextField.text = ""
                    dateTextField.placeholder = "MM/DD/YYYY"
                } else {
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
    //                        UserDefaults.standard.set("pickerMode", forKey: "defaultDatePicker")
                            if UserDefaults.standard.value(forKey: "defaultDatePicker") as! String == "pickerMode" {
                                dateBtnOutlet.setTitle(dateVale, for: .normal)
                            } else {
                                dateTextField.text = dateVale
                            }
    //                        dateBtnOutlet.setTitle(dateVale, for: .normal)
    //                        dateTextField.text = dateVale
                            formatter.dateFormat = DateFormatters.MMddyyyyFormat
                        }
                        else {
                            var dateVale = ""
                            let values = data.date!.components(separatedBy: "/")
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = date + "/" + month + "/" + year
                            if UserDefaults.standard.value(forKey: "defaultDatePicker") as! String == "pickerMode" {
                                dateBtnOutlet.setTitle(dateVale, for: .normal)
                            } else {
                                dateTextField.text = dateVale
                            }
    //                        dateBtnOutlet.setTitle(dateVale, for: .normal)
    //                        dateTextField.text = dateVale
                            formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                        }
                        
                        self.selectedDate = formatter.date(from: dateBtnOutlet.titleLabel!.text!) ?? Date()
                        let isGreater = Date().isSmaller(than: selectedDate)
                        
                        if isGreater == true {
                            dateBtnOutlet.setTitle("", for: .normal)
                            dateTextField.text = ""
                        }
                    }

                }
                
             //   permanentIDTextField.text = data.offPermanentId
                checkBarcode = false
                incrementalBarcodeTitleLabel.textColor = .black
                incrementalBarcodeButton.isEnabled = true
                let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.animalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                
                if dataFetch.count == 0 {}
                else {
                    let filterAnimalCart = animalCartData.filter({$0.animalbarCodeTag == data.animalbarCodeTag && $0.orderstatus == "false"})
                    if filterAnimalCart.count > 0  {
                        iscomingFromCart = true
                    }
                    if data.orderstatus == "true" && !iscomingFromCart{}
                    else {
                        scanBarcodeText.text = data.animalbarCodeTag
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                        self.isBarcodeAutoIncrementedEnabled = false
                        incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                        incrementalBarcodeButton.isEnabled = false
                        incrementalBarcodeTitleLabel.textColor = .gray
                        incrementalBarcodeCheckBox.alpha = 0.6
                        incrementalBarcodeTitleLabel.alpha = 0.6
                        checkBarcode = false
                        matchedBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                        matchedBarcodeBtnOutlet.isEnabled = false
                        matchedBarcodeLbl.textColor = .gray
                        matchedBarcodeLbl.alpha = 0.6
                        matchedBarcodeCheckBox.alpha = 0.6
                        matchedBarcodeBtnOutlet.alpha = 0.6
                        UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlag.rawValue)
                    }
                }
                
                tissueBtnOutlet.setTitleColor(.black, for: .normal)
                breedBtnOutlet.setTitleColor(.black, for: .normal)
                tissueBtnOutlet.setTitle(data.tissuName?.localized, for: .normal)
                saveSampleNameandID(sampleNameStr: data.tissuName ?? "", sampleID: Int(data.tissuId))
                UserDefaults.standard.set(data.tissuName, forKey: keyValue.tsuKey.rawValue)
                
                if data.tissuName?.isEmpty == true {
                    let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
                    if providerName == keyValue.clarifideAHDBUK.rawValue{
                        self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
                        for items in self.tissueArr{
                            let tissue = items  as? GetSampleTbl
                            let checkdefault  = tissue?.isDefault
                            
                            if pvid == 11 {
                                let country : String = UserDefaults.standard.object(forKey: keyValue.country.rawValue) as? String ?? ""
                                switch country  {
                                case countryName.Belgium.title, countryName.Luxembourg.title :
                                    saveSampleNameandID(sampleNameStr: ButtonTitles.allflexTSUText, sampleID: 1)
                                    self.tissueBtnOutlet.setTitle(ButtonTitles.allflexTSUText, for: .normal)
                                case countryName.Netherlands.title :
                                    saveSampleNameandID(sampleNameStr: LocalizedStrings.hairString, sampleID: 4)
                                    self.tissueBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.hairString, comment: ""), for: .normal)
                                default:
                                    break
                                }
                            } else {
                                if checkdefault == true{
                                    saveSampleNameandID(sampleNameStr: tissue?.sampleName ?? "", sampleID: Int(tissue?.sampleId ?? 0))
                                    self.tissueBtnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
                                }
                            }
                        }
                        
                    } else {
                        self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
                        for items in self.tissueArr{
                            let tissue = items  as? GetSampleTbl
                            let checkdefault  = tissue?.isDefault
                            
                            if pvid == 11 {
                                let country : String = UserDefaults.standard.object(forKey: keyValue.country.rawValue) as? String ?? ""
                                switch country  {
                                case countryName.Belgium.title, countryName.Luxembourg.title :
                                    saveSampleNameandID(sampleNameStr: ButtonTitles.allflexTSUText, sampleID: 1)
                                    self.tissueBtnOutlet.setTitle(ButtonTitles.allflexTSUText, for: .normal)
                                case countryName.Netherlands.title :
                                    saveSampleNameandID(sampleNameStr:LocalizedStrings.hairString, sampleID: 4)
                                    self.tissueBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.hairString, comment: ""), for: .normal)
                                default:
                                    break
                                }
                            } else {
                                if checkdefault == true{
                                    saveSampleNameandID(sampleNameStr: tissue?.sampleName ?? "", sampleID: Int(tissue?.sampleId ?? 0))
                                    self.tissueBtnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
                                }
                            }
                        }
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
                
                breedBtnOutlet.setTitle(data.breedName, for: .normal)
                breedId = data.breedId!
                let breedidd =  UserDefaults.standard.value(forKey: keyValue.breed.rawValue) as? String
                
                if breedidd != breedId {
                    let  aDat = fetchAnimaldata(status: Entities.animalAddTblEntity)
                    if aDat.count > 1{
                        UserDefaults.standard.set(true, forKey: keyValue.identifyStore.rawValue)
                    }
                }
                
                sampleID = Int(data.tissuId)
                sampleName = data.tissuName ?? ""
                UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                
                if data.gender == "Male".localized || data.gender == "M" {
                 //   self.male_femaleBtnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 1
                    genderString = NSLocalizedString("Male", comment: "")
                    self.male_femaleBtnOutlet.setTitle("Male", for: .normal)
                    self.male_femaleBtnOutlet.setTitleColor(.black, for: .normal)

                } else {
               //     self.male_femaleBtnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 0
                    genderString = NSLocalizedString("Female", comment: "")
                    self.male_femaleBtnOutlet.setTitle("Female", for: .normal)
                    self.male_femaleBtnOutlet.setTitleColor(.black, for: .normal)

                }
                let screenRefernce = UserDefaults.standard.value(forKey:keyValue.screen.rawValue) as? String
                
                if screenRefernce == keyValue.farmId.rawValue || screenRefernce == ""{
                    scanAnimalTagText.text = data.farmId
                    UserDefaults.standard.set(data.animalTag!.uppercased(), forKey: keyValue.selectAnimalId.rawValue)
                    farmIdTextField.text = data.animalTag
                    if data.animalTag!.count  == 17 {
                        borderRedCheck = false
                        farmIdTextField.textColor = UIColor.black
                    } else {
                        
                        if data.animalTag!.count  != 0{
                            let replacedString = farmIdTextField.text?.replacingOccurrences(of: " ", with: "")
                            self.validationId17(animalId: replacedString?.uppercased() ?? "")
                        }
                    }
                }
                else {
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
                                UserDefaults.standard.set(self.breedId, forKey: keyValue.breed.rawValue)
                                let breedName = codeId1.value(forKey: keyValue.alpha2.rawValue) as? NSArray
                                if naabFetch11!.count != 0 {
                                    let nameBreed = (breedName![0] as? String)!
                                    self.breedBtnOutlet.setTitle(nameBreed, for: .normal)
                                }
                            }
                        }
                    }
                }
                
                damIdValidationB = false
              //  singleBttn.layer.borderColor = UIColor.gray.cgColor
              //  singleBttn.layer.borderWidth = 0.5
                let et = data.eT
                etBtn = et as! String
//                etBttn.layer.borderWidth = 0.5
//                singleBttn.layer.borderWidth = 0.5
//                multipleBirthBttn.layer.borderWidth = 0.5
//                cloneOutlet.layer.borderWidth = 0.5
//                SplitEmbryoOutlet.layer.borderWidth = 0.5
//                internalBtnOulet.layer.borderWidth = 0.5
                
                if data.selectedBornTypeId == 3 {
                    etBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    etBttn.layer.borderWidth = 2
                    singleBttn.layer.borderColor = UIColor.gray.cgColor
                    internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                    cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 3
                    
                } else if data.selectedBornTypeId == 1{
                    singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    singleBttn.layer.borderWidth = 2
                    internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                    cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                    etBttn.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 1
                    
                }else if data.selectedBornTypeId == 2{
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
                else if data.selectedBornTypeId ==  5 {
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
                
                tissuId = Int(data.tissuId)
                sampleID = Int(data.tissuId)
                dateBtnOutlet.setTitleColor(.black, for: .normal)
                statusOrder = false
                messageCheck = false
                let adata = fetchAllDataOrderStatusMaster(entityName: Entities.animalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
                
                if adata.count > 0{
                    let animal  = adata.object(at: 0) as! AnimalMaster
                    idAnimal = Int(animal.animalId)
                    messageCheck = true
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
                        let replacedString = data.offsireId!.replacingOccurrences(of: " ", with: "")
                        sireIdTextField.text = replacedString.uppercased()
                        validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                        
                    }
                } else  {
                    
                    if data.offsireId?.count == 17 || data.offsireId?.count == 0 {
                        sireIdTextField.text = data.offsireId?.uppercased()
                    } else {
                        let replacedString = data.offsireId!.replacingOccurrences(of: " ", with: "")
                        sireIdTextField.text = replacedString.uppercased()
                        validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                    }
                }
                
                if pvid == 3 {
                    damtexfield.text = data.offDamId?.uppercased()
                } else {
                    if data.offDamId?.count == 17 ||  data.offDamId?.count == 0 {
                        damtexfield.text = data.offDamId?.uppercased()
                    } else {
                        let replacedString = data.offDamId!.replacingOccurrences(of: " ", with: "")
                        damtexfield.text = replacedString.uppercased()
                        validationId17SireDam(animalId: damtexfield.text!, tag: 4)
                    }
                }
            }
            
            else if animalData1.count > 0 {
                
                self.view.hideToast()
                let data = animalData1[0] as! DataEntryAnimaladdTbl
                
                if data.breedName == ButtonTitles.girolandoText || data.breedId == keyValue.girlandoNewBreedId.rawValue || data.breedName == BreedNames.girlandoBreed{
                    return
                }
                
                adhDataServerAutoPopulate = data.adhDataServer
                barcodeflag = false
                isautoPopulated = true
                barAutoPopu = true
                textFieldBackroungWhite()
                updateOrder = true
                dataAutoPopulatedBool =  true
                
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                let animalTbl =  fetchAllData(entityName: Entities.animalAddTblEntity)
                animalId1 = Int(data.animalId)
                
                if pvid == 3 {
                    sireIdValidationB = true
                    
                    autoSuggestionStatus = true
                } else {
                    sireIdValidationB = false
                    
                    autoSuggestionStatus = false
                    
                }
                /////////end
                if selctionAuProvider == true {
                    if data.sireIDAU == "" {
                        
                    } else {
//                        nationalHerdIdTextField.text = data.nationHerdAU
//                        sireIAuTextField.text = data.sireIDAU
                    }
                    
                } else {
//                    nationalHerdIdTextField.text = data.nationHerdAU
//                    sireIAuTextField.text = data.sireIDAU
                }
                
                
                officalTagView.layer.borderColor = UIColor.gray.cgColor
                farmIdView.layer.borderColor = UIColor.gray.cgColor
                barcodeView.layer.borderColor = UIColor.gray.cgColor
             //   permanentIDTextField.layer.borderColor = UIColor.gray.cgColor
                sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                damtexfield.layer.borderColor = UIColor.gray.cgColor
                //
                dateBtnOutlet.titleLabel!.text = "MM/DD/YYYY"
                if data.date != "" {
                    
                    let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
                    var formatter = DateFormatter()
                    
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
                    let dates =  formatter.string(from: selectedDate)
                    let isGreater = Date().isSmaller(than: selectedDate)
                    
                    if isGreater == true {
                        dateBtnOutlet.setTitle("", for: .normal)
                        dateTextField.text = ""
                    }
                }
                
              //  permanentIDTextField.text = data.offPermanentId
                checkBarcode = false
                incrementalBarcodeTitleLabel.textColor = .black
                incrementalBarcodeButton.isEnabled = true
                var dataFetch = fetchAllDataWithAnimalId(entityName: Entities.animalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                
                if dataFetch.count == 0 {
                    
                } else {
                    
                    if data.orderstatus == "true" && !iscomingFromCart{
                       
                    } else {
                        scanBarcodeText.text = data.animalbarCodeTag
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                        self.isBarcodeAutoIncrementedEnabled = false
                        incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                        incrementalBarcodeButton.isEnabled = false
                        incrementalBarcodeTitleLabel.textColor = .gray
                        incrementalBarcodeCheckBox.alpha = 0.6
                        incrementalBarcodeTitleLabel.alpha = 0.6
                        checkBarcode = false
                        matchedBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                        matchedBarcodeBtnOutlet.isEnabled = false
                        matchedBarcodeLbl.textColor = .gray
                        matchedBarcodeLbl.alpha = 0.6
                        matchedBarcodeCheckBox.alpha = 0.6
                        matchedBarcodeBtnOutlet.alpha = 0.6
                        UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlag.rawValue)
                    }
                }
        
                tissueBtnOutlet.setTitleColor(.black, for: .normal)
                breedBtnOutlet.setTitleColor(.black, for: .normal)
                tissueBtnOutlet.setTitle(data.tissuName?.localized, for: .normal)
                saveSampleNameandID(sampleNameStr: data.tissuName ?? "", sampleID: Int(data.tissuId))
                UserDefaults.standard.set(data.tissuName, forKey: "tsu")
                
                if data.tissuName?.isEmpty == true {
                    let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
                    if providerName == keyValue.clarifideAHDBUK.rawValue{
                        self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
                        for items in self.tissueArr{
                            let tissue = items  as? GetSampleTbl
                            let checkdefault  = tissue?.isDefault
                            if pvid == 11 {
                                let country : String = UserDefaults.standard.object(forKey: keyValue.country.rawValue) as? String ?? ""
                                switch country  {
                                case countryName.Belgium.title, countryName.Luxembourg.title :
                                    saveSampleNameandID(sampleNameStr: ButtonTitles.allflexTSUText, sampleID: 1)
                                    self.tissueBtnOutlet.setTitle(ButtonTitles.allflexTSUText, for: .normal)
                                case countryName.Netherlands.title :
                                    saveSampleNameandID(sampleNameStr: LocalizedStrings.hairString, sampleID: 4)
                                    self.tissueBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.hairString, comment: ""), for: .normal)
                                default:
                                    break
                                }
                            } else {
                                if checkdefault == true
                                {
                                    saveSampleNameandID(sampleNameStr: tissue?.sampleName ?? "", sampleID: Int(tissue?.sampleId ?? 0))
                                    self.tissueBtnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
                                }
                            }
                        }
                      
                    } else {
                        self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
                        for items in self.tissueArr
                        {
                            let tissue = items  as? GetSampleTbl
                            let checkdefault  = tissue?.isDefault
                            
                            if pvid == 11 {
                                let country : String = UserDefaults.standard.object(forKey: keyValue.country.rawValue) as? String ?? ""
                                switch country  {
                                case countryName.Belgium.title, countryName.Luxembourg.title :
                                    saveSampleNameandID(sampleNameStr: ButtonTitles.allflexTSUText, sampleID: 1)
                                    self.tissueBtnOutlet.setTitle(ButtonTitles.allflexTSUText, for: .normal)
                                case countryName.Netherlands.title :
                                    saveSampleNameandID(sampleNameStr:LocalizedStrings.hairString, sampleID: 4)
                                    self.tissueBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.hairString, comment: ""), for: .normal)
                                default:
                                    break
                                }
                            } else {
                                if checkdefault == true
                                {
                                    saveSampleNameandID(sampleNameStr: tissue?.sampleName ?? "", sampleID: Int(tissue?.sampleId ?? 0))
                                    self.tissueBtnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
                                }
                            }
                        }
                    }
                }
        
                if data.breedId == "" {
                    var inheritBreed = fetchAllDataProductBreedIdDairy(entityName: Entities.getBreedsTblEntity,breedId:breedId,pvid:pvid)
                    if inheritBreed.count != 0 {
                        let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                        data.breedName = medbreedRegArr1?.alpha2 ?? medbreedRegArr1?.threeCharCode ?? medbreedRegArr1?.breedName
                        data.breedId = breedId
                    }
                }
                
                breedBtnOutlet.setTitle(data.breedName, for: .normal)
                breedId = data.breedId!
                let breedidd =  UserDefaults.standard.value(forKey: keyValue.breed.rawValue) as? String
                if breedidd != breedId {
                    let  aDat = fetchAnimaldata(status: Entities.animalAddTblEntity)
                    if aDat.count > 1{
                        UserDefaults.standard.set(true, forKey: keyValue.identifyStore.rawValue)
                    }
                }
                sampleID = Int(data.tissuId)
                sampleName = data.tissuName ?? ""
                let pvidAA = data.providerId
                UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                
                if data.gender == "Male".localized || data.gender == "M" {
                  //  self.male_femaleBtnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 1
                    genderString = NSLocalizedString("Male", comment: "")
                    self.male_femaleBtnOutlet.setTitle("Male", for: .normal)
                    self.male_femaleBtnOutlet.setTitleColor(.black, for: .normal)

                } else {
                 //   self.male_femaleBtnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 0
                    genderString = NSLocalizedString("Female", comment: "")
                    self.male_femaleBtnOutlet.setTitle("Female", for: .normal)
                    self.male_femaleBtnOutlet.setTitleColor(.black, for: .normal)

                }
                
                let screenRefernce = UserDefaults.standard.value(forKey:keyValue.screen.rawValue) as? String
                
                if screenRefernce == keyValue.farmId.rawValue || screenRefernce == ""{
                    scanAnimalTagText.text = data.farmId
                    UserDefaults.standard.set(data.animalTag!.uppercased(), forKey: keyValue.selectAnimalId.rawValue)
                    farmIdTextField.text = data.animalTag
                    if data.animalTag!.count  == 17 {
                        borderRedCheck = false
                        farmIdTextField.textColor = UIColor.black
                    } else {
                        if data.animalTag!.count  == 0{
                        } else {
                            let replacedString = farmIdTextField.text?.replacingOccurrences(of: " ", with: "")
                            
                            self.validationId17(animalId: replacedString?.uppercased() ?? "")
                        }
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
                            if naabFetch11!.count == 0 {
                                
                            } else {
                                let breedIdGet = (naabFetch11![0] as? String)!
                                self.breedId = breedIdGet
                                UserDefaults.standard.set(self.breedId, forKey: keyValue.breed.rawValue)
                                let breedName = codeId1.value(forKey: keyValue.alpha2.rawValue) as? NSArray
                                if naabFetch11!.count != 0 {
                                    let nameBreed = (breedName![0] as? String)!
                                    self.breedBtnOutlet.setTitle(nameBreed, for: .normal)
                                }
                            }
                        }
                    }
                }
                
                damIdValidationB = false
               // singleBttn.layer.borderColor = UIColor.gray.cgColor
              //  singleBttn.layer.borderWidth = 0.5
                let et = data.eT
                etBtn = et as! String
//                etBttn.layer.borderWidth = 0.5
//                singleBttn.layer.borderWidth = 0.5
//                multipleBirthBttn.layer.borderWidth = 0.5
//                cloneOutlet.layer.borderWidth = 0.5
//                SplitEmbryoOutlet.layer.borderWidth = 0.5
//                internalBtnOulet.layer.borderWidth = 0.5
                
                if data.selectedBornTypeId == 3 {
                    etBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    etBttn.layer.borderWidth = 2
                    singleBttn.layer.borderColor = UIColor.gray.cgColor
                    internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                    cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                    
                    selectedBornTypeId = 3
                    
                } else if data.selectedBornTypeId == 1{
                    
                    singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    singleBttn.layer.borderWidth = 2
                    internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                    cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                    etBttn.layer.borderColor = UIColor.gray.cgColor
                    
                    selectedBornTypeId = 1
                    
                }else if data.selectedBornTypeId == 2{
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
                else if data.selectedBornTypeId ==  5 {
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
                
                tissuId = Int(data.tissuId)
                sampleID = Int(data.tissuId)
                dateBtnOutlet.setTitleColor(.black, for: .normal)
                statusOrder = false
                messageCheck = false
                let adata = fetchAllDataOrderStatusMaster(entityName: Entities.animalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
                if adata.count > 0{
                    let animal  = adata.object(at: 0) as! AnimalMaster
                    idAnimal = Int(animal.animalId)
                    messageCheck = true
                }
                
                if pvid == 3 {
                    if ausBullId.contains(data.offsireId) || sireNationalID.contains(data.offsireId){
                        sireIdTextField.textColor = UIColor.black
                        
                        let fetchData =  fetchAusNaabBullAgaintName(entityName: Entities.ausNaabBullTblEntity, sireNationalId: data.offsireId ?? "")
                        if fetchData.count != 0 {
                            let nationHerdAU1 = fetchData.object(at: 0) as? AusNaabBull
                            let bullId =   nationHerdAU1?.bullID ?? ""
                            sireIdTextField.text = bullId.uppercased()
                            
                        }
                        
                    } else {
                        let replacedString = data.offsireId!.replacingOccurrences(of: " ", with: "")
                        sireIdTextField.text = replacedString.uppercased()
                        validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                    }
                } else  {
                    
                    if data.offsireId?.count == 17 || data.offsireId?.count == 0 {
                        sireIdTextField.text = data.offsireId?.uppercased()
                    } else {
                        let replacedString = data.offsireId!.replacingOccurrences(of: " ", with: "")
                        sireIdTextField.text = replacedString.uppercased()
                        validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                    }
                }
                
                if pvid == 3 {
                    damtexfield.text = data.offDamId?.uppercased()
                    
                } else {
                    if data.offDamId?.count == 17 ||  data.offDamId?.count == 0 {
                        damtexfield.text = data.offDamId?.uppercased()
                    } else {
                        let replacedString = data.offDamId!.replacingOccurrences(of: " ", with: "")
                        damtexfield.text = replacedString.uppercased()
                        validationId17SireDam(animalId: damtexfield.text!, tag: 4)
                    }
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
                    savebarcodecopyofficialid = scanAnimalTagText.text!
                    self.validationId17(animalId: animalTagValue.uppercased())
                    animalTagValue = scanAnimalTagText.text!.uppercased()
                    dataPopulateInFocusChange()
                }
            }
            else  {
                savebarcodecopyofficialid = farmIdTextField.text!
                scanAnimalText = farmIdTextField.text!.uppercased()
                farmIdText = scanAnimalTagText.text!
                animalTagValue = scanAnimalText
                farmIdValue = farmIdText
                if animalTagValue != ""{
                    if providerSelectionCountryCode == CountryCodes.australia{
                        if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == "True"{
                            self.validationId17(animalId: animalTagValue.uppercased())
                        }
                        else if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue{
                            if animalTagValue.count == 17{
                                self.validationId17(animalId: animalTagValue.uppercased())
                            }
                            else{
                                self.view.hideToast()
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalIDStr, comment: ""), duration: 2, position: .top)
                                id17display(animalId: animalTagValue, borderRed: true)
                            }
                        }
                    }
                    else
                    {
                        self.validationId17(animalId: animalTagValue.uppercased())
                    }
                    
                    animalTagValue = farmIdTextField.text!.uppercased()
                    
                } else {
                    borderRedCheck = false
                }
            }
        }
        
        
        if selctionAuProvider == true {
//            nationalHerdIdTextField.isHidden = false
//            sireIAuTextField.isHidden = false
//            nationalHerdIdTextField.isEnabled = true
//            sireIAuTextField.isEnabled = true
            
        } else {
//            nationalHerdIdTextField.isHidden = true
//            sireIAuTextField.isHidden = true
//            nationalHerdIdTextField.isEnabled = false
//            sireIAuTextField.isEnabled = false
//            AutoSuggestionTableView.isHidden = true
            buttonbgAutoSuggestion.removeFromSuperview()
        }
        
        
        var samplename = String()
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
    //    permanentIDTextField.text!.uppercased()
        let animalData1 = fetchAnimaldataValidateAnimalwithouOrderID(entityName: Entities.animalMasterTblEntity, animalTag:animalTagValue.uppercased(), farmId: farmIdValue, animalbarCodeTag: scanBarcodeText.text!.uppercased(), offPermanentId: "", offDamId: damtexfield.text!.uppercased(), offsireId: sireIdTextField.text!.uppercased(),orderId:orderId,userId:userId,custmerId:custmerId )
        
        
        if animalData1.count > 1 {
            let screenRefernce = UserDefaults.standard.value(forKey:keyValue.screen.rawValue) as? String
            
            if screenRefernce == keyValue.officialId.rawValue || screenRefernce == ""{
                onfarmidtext = farmIdValue
                fetchrecord = true
                scanBarcodeText.becomeFirstResponder()
              //  return true
            }
            else{
                newanimaltagvalue = animalTagValue
                mainrecord = true
                scanBarcodeText.becomeFirstResponder()
              //  return true
            }
            
            for number in 0..<(animalData1.count-1) {
                let animId = animalData1.object(at: number) as? AnimalMaster
                let idAnim = animId?.animalId
                let useriD = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                let customerId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
                deleteDataWithAdh1(entity: Entities.animalMasterTblEntity, animalId: idAnim ?? 0, userId: Int(useriD ), custmerId: Int(customerId ))
            }
        }
        //permanentIDTextField.text!.uppercased()
        let animalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: Entities.dataEntryAnimalAddTbl, animalTag:animalTagValue.uppercased(), farmId: farmIdValue, animalbarCodeTag: scanBarcodeText.text!.uppercased(), offPermanentId: "", offDamId: damtexfield.text!.uppercased(), offsireId: sireIdTextField.text!.uppercased(),orderId:orderId,userId:userId,custmerId:custmerId )
        
        if isautoPopulated == false {
            
            if animalData1.count > 0 {
                let screenRefernce = UserDefaults.standard.value(forKey:keyValue.screen.rawValue) as? String
                if screenRefernce == keyValue.officialId.rawValue || screenRefernce == ""{
                    onfarmidtext = farmIdValue
                    fetchrecord = true
                    scanBarcodeText.becomeFirstResponder()
                   // return true
                }
                else{
                    newanimaltagvalue = animalTagValue
                    mainrecord = true
                    scanBarcodeText.becomeFirstResponder()
                  //  return true
                }
                
                self.view.hideToast()
                let data =  animalData1.lastObject as! AnimalMaster
                
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
                           // nationalHerdIdTextField.text = data.nationHerdAU
                           // sireIAuTextField.text = data.sireIDAU
                        }
                    } else {
                       // nationalHerdIdTextField.text = data.nationHerdAU
                       // sireIAuTextField.text = data.sireIDAU
                    }
                    
                    officalTagView.layer.borderColor = UIColor.gray.cgColor
                    farmIdView.layer.borderColor = UIColor.gray.cgColor
                    barcodeView.layer.borderColor = UIColor.gray.cgColor
                  //  permanentIDTextField.layer.borderColor = UIColor.gray.cgColor
                    sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                    damtexfield.layer.borderColor = UIColor.gray.cgColor
                    dateBtnOutlet.titleLabel!.text = "MM/DD/YYYY"
                    
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
                 //   permanentIDTextField.text = data.offPermanentId
                    checkBarcode = false
                    incrementalBarcodeTitleLabel.textColor = .black
                    incrementalBarcodeButton.isEnabled = true
                    
                    let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.animalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                    if dataFetch.count != 0 {
                        if data.orderstatus != "true"{
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
                            UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlag.rawValue)
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
                        }
                    }
                    
                    breedBtnOutlet.setTitle(data.breedName, for: .normal)
                    tissueBtnOutlet.setTitleColor(.black, for: .normal)
                    breedBtnOutlet.setTitleColor(.black, for: .normal)
                    tissueBtnOutlet.setTitle(data.tissuName?.localized, for: .normal)
                    saveSampleNameandID(sampleNameStr: data.tissuName ?? "", sampleID: Int(data.tissuId))
                    UserDefaults.standard.set(data.tissuName, forKey: keyValue.tsuKey.rawValue)
                    
                    if data.tissuName?.isEmpty == true {
                        let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
                        if providerName == keyValue.clarifideAHDBUK.rawValue{
                            self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
                            for items in self.tissueArr
                            {
                                let tissue = items  as? GetSampleTbl
                                let checkdefault  = tissue?.isDefault
                                
                                if pvid == 11 {
                                    let country : String = UserDefaults.standard.object(forKey: keyValue.country.rawValue) as? String ?? ""
                                    switch country  {
                                    case countryName.Belgium.title, countryName.Luxembourg.title :
                                        saveSampleNameandID(sampleNameStr: ButtonTitles.allflexTSUText, sampleID: 1)
                                        self.tissueBtnOutlet.setTitle(ButtonTitles.allflexTSUText, for: .normal)
                                        
                                    case countryName.Netherlands.title :
                                        saveSampleNameandID(sampleNameStr: LocalizedStrings.hairString, sampleID: 4)
                                        self.tissueBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.hairString, comment: ""), for: .normal)
                                        
                                    default:
                                        break
                                    }
                                } else {
                                    if checkdefault == true{
                                        saveSampleNameandID(sampleNameStr: tissue?.sampleName ?? "", sampleID: Int(tissue?.sampleId ?? 0))
                                        self.tissueBtnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
                                    }
                                }
                            }
                        }
                        else {
                            self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
                            for items in self.tissueArr{
                                let tissue = items  as? GetSampleTbl
                                let checkdefault  = tissue?.isDefault
                                if pvid == 11 {
                                    let country : String = UserDefaults.standard.object(forKey: keyValue.country.rawValue) as? String ?? ""
                                    switch country  {
                                    case countryName.Belgium.title, countryName.Luxembourg.title :
                                        saveSampleNameandID(sampleNameStr: ButtonTitles.allflexTSUText, sampleID: 1)
                                        self.tissueBtnOutlet.setTitle(ButtonTitles.allflexTSUText, for: .normal)
                                    case countryName.Netherlands.title :
                                        saveSampleNameandID(sampleNameStr: LocalizedStrings.hairString, sampleID: 4)
                                        self.tissueBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.hairString, comment: ""), for: .normal)
                                    default:
                                        break
                                    }
                                } else {
                                    if checkdefault == true{
                                        saveSampleNameandID(sampleNameStr: tissue?.sampleName ?? "", sampleID: Int(tissue?.sampleId ?? 0))
                                        self.tissueBtnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
                                    }
                                }
                            }
                        }
                    }
                    
                    
                    breedId = data.breedId!
                    let breedidd =  UserDefaults.standard.value(forKey: keyValue.breed.rawValue) as? String
                    if breedidd != breedId {
                        let  aDat = fetchAnimaldata(status: Entities.animalAddTblEntity)
                        if aDat.count > 1{
                            UserDefaults.standard.set(true, forKey: keyValue.identifyStore.rawValue)
                        }
                    }
                    samplename = data.tissuName!
                    saveSampleNameandID(sampleNameStr: data.tissuName!, sampleID: Int(data.tissuId))
                    UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                    
                    if data.gender == "Male".localized || data.gender == "M" {
                       // self.male_femaleBtnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                        genderToggleFlag = 1
                        genderString = NSLocalizedString("Male", comment: "")
                        self.male_femaleBtnOutlet.setTitle("Male", for: .normal)

                        self.male_femaleBtnOutlet.setTitleColor(.black, for: .normal)
                    } else {
                     //   self.male_femaleBtnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                        genderToggleFlag = 0
                        genderString = NSLocalizedString("Female", comment: "")
                        self.male_femaleBtnOutlet.setTitle("Female", for: .normal)
                        self.male_femaleBtnOutlet.setTitleColor(.black, for: .normal)

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
                                if naabFetch11!.count == 0 {
                                    
                                } else {
                                    let breedIdGet = (naabFetch11![0] as? String)!
                                    self.breedId = breedIdGet
                                    UserDefaults.standard.set(self.breedId, forKey: keyValue.breed.rawValue)
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
                   // singleBttn.layer.borderColor = UIColor.gray.cgColor
                  //  singleBttn.layer.borderWidth = 0.5
                    let et = data.eT
                    etBtn = et as! String
//                    etBttn.layer.borderWidth = 0.5
//                    singleBttn.layer.borderWidth = 0.5
//                    multipleBirthBttn.layer.borderWidth = 0.5
//                    cloneOutlet.layer.borderWidth = 0.5
//                    SplitEmbryoOutlet.layer.borderWidth = 0.5
//                    internalBtnOulet.layer.borderWidth = 0.5
                    
                    if data.selectedBornTypeId == 3 {
                        etBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                        etBttn.layer.borderWidth = 2
                        singleBttn.layer.borderColor = UIColor.gray.cgColor
                        internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                        multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                        SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                        cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                        selectedBornTypeId = 3
                    }
                    else if data.selectedBornTypeId == 1 {
                        singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                        singleBttn.layer.borderWidth = 2
                        internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                        multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                        SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                        cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                        etBttn.layer.borderColor = UIColor.gray.cgColor
                        selectedBornTypeId = 1
                        
                    }else if data.selectedBornTypeId == 2 {
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
                        //self.nationalHerdIdTextField.becomeFirstResponder()
                        if sireIAuTextField.text == ""{
                            sireIAuTextField.layer.borderColor = UIColor.red.cgColor
                        }else{
                            sireIAuTextField.layer.borderColor = UIColor.gray.cgColor
                        }
                        
                    } else if (textField == self.nationalHerdIdTextField) {
                       // self.nationalHerdIdTextField.resignFirstResponder()
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
                        //statusOrder = true
                        messageCheck = true
                    }
                }
            }
            
            else if animalData.count > 0 {
                let screenRefernce = UserDefaults.standard.value(forKey:keyValue.screen.rawValue) as? String
                if screenRefernce == keyValue.officialId.rawValue || screenRefernce == ""{
                    onfarmidtext = farmIdValue
                    fetchrecord = true
                    scanBarcodeText.becomeFirstResponder()
                   // return true
                }
                else{
                    newanimaltagvalue = animalTagValue
                    mainrecord = true
                    scanBarcodeText.becomeFirstResponder()
                  //  return true
                }
                
                self.view.hideToast()
                let data =  animalData.lastObject as! DataEntryAnimaladdTbl
                
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
//                            nationalHerdIdTextField.text = data.nationHerdAU
//                            sireIAuTextField.text = data.sireIDAU
                        }
                    } else {
//                        nationalHerdIdTextField.text = data.nationHerdAU
//                        sireIAuTextField.text = data.sireIDAU
                    }
                    
                    officalTagView.layer.borderColor = UIColor.gray.cgColor
                    farmIdView.layer.borderColor = UIColor.gray.cgColor
                    barcodeView.layer.borderColor = UIColor.gray.cgColor
                 //   permanentIDTextField.layer.borderColor = UIColor.gray.cgColor
                    sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                    damtexfield.layer.borderColor = UIColor.gray.cgColor
                    dateBtnOutlet.titleLabel!.text = "MM/DD/YYYY"
                    
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
                   // permanentIDTextField.text = data.offPermanentId
                    checkBarcode = false
                    incrementalBarcodeTitleLabel.textColor = .black
                    incrementalBarcodeButton.isEnabled = true
                    
                    let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.animalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                    if dataFetch.count != 0 {
                        if data.orderstatus != "true"{
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
                            UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlag.rawValue)
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
                        }
                    }
                    
                    breedBtnOutlet.setTitle(data.breedName, for: .normal)
                    tissueBtnOutlet.setTitleColor(.black, for: .normal)
                    breedBtnOutlet.setTitleColor(.black, for: .normal)
                    tissueBtnOutlet.setTitle(data.tissuName?.localized, for: .normal)
                    saveSampleNameandID(sampleNameStr: data.tissuName ?? "", sampleID: Int(data.tissuId))
                    UserDefaults.standard.set(data.tissuName, forKey: keyValue.tsuKey.rawValue)
                    
                    if data.tissuName?.isEmpty == true {
                        let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
                        if providerName == keyValue.clarifideAHDBUK.rawValue{
                            self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
                            for items in self.tissueArr
                            {
                                let tissue = items  as? GetSampleTbl
                                let checkdefault  = tissue?.isDefault
                                
                                if pvid == 11 {
                                    let country : String = UserDefaults.standard.object(forKey: keyValue.country.rawValue) as? String ?? ""
                                    switch country  {
                                    case countryName.Belgium.title, countryName.Luxembourg.title :
                                        saveSampleNameandID(sampleNameStr: ButtonTitles.allflexTSUText, sampleID: 1)
                                        self.tissueBtnOutlet.setTitle(ButtonTitles.allflexTSUText, for: .normal)
                                        
                                    case countryName.Netherlands.title :
                                        saveSampleNameandID(sampleNameStr: LocalizedStrings.hairString, sampleID: 4)
                                        self.tissueBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.hairString, comment: ""), for: .normal)
                                        
                                    default:
                                        break
                                    }
                                } else {
                                    if checkdefault == true{
                                        saveSampleNameandID(sampleNameStr: tissue?.sampleName ?? "", sampleID: Int(tissue?.sampleId ?? 0))
                                        self.tissueBtnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
                                    }
                                }
                            }
                        }
                        else {
                            self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
                            for items in self.tissueArr{
                                let tissue = items  as? GetSampleTbl
                                let checkdefault  = tissue?.isDefault
                                if pvid == 11 {
                                    let country : String = UserDefaults.standard.object(forKey: keyValue.country.rawValue) as? String ?? ""
                                    switch country  {
                                    case countryName.Belgium.title, countryName.Luxembourg.title :
                                        saveSampleNameandID(sampleNameStr: ButtonTitles.allflexTSUText, sampleID: 1)
                                        self.tissueBtnOutlet.setTitle(ButtonTitles.allflexTSUText, for: .normal)
                                    case countryName.Netherlands.title :
                                        saveSampleNameandID(sampleNameStr: LocalizedStrings.hairString, sampleID: 4)
                                        self.tissueBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.hairString, comment: ""), for: .normal)
                                    default:
                                        break
                                    }
                                } else {
                                    if checkdefault == true{
                                        saveSampleNameandID(sampleNameStr: tissue?.sampleName ?? "", sampleID: Int(tissue?.sampleId ?? 0))
                                        self.tissueBtnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
                                    }
                                }
                            }
                        }
                    }
                    
                    
                    breedId = data.breedId!
                    let breedidd =  UserDefaults.standard.value(forKey: keyValue.breed.rawValue) as? String
                    if breedidd != breedId {
                        let  aDat = fetchAnimaldata(status: Entities.animalAddTblEntity)
                        if aDat.count > 1{
                            UserDefaults.standard.set(true, forKey: keyValue.identifyStore.rawValue)
                        }
                    }
                    samplename = data.tissuName!
                    saveSampleNameandID(sampleNameStr: data.tissuName!, sampleID: Int(data.tissuId))
                    UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                    
                    if data.gender == "Male".localized || data.gender == "M" {
                       // self.male_femaleBtnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                        genderToggleFlag = 1
                        genderString = NSLocalizedString("Male", comment: "")
                        self.male_femaleBtnOutlet.setTitle("Male", for: .normal)

                        self.male_femaleBtnOutlet.setTitleColor(.black, for: .normal)
                    } else {
                     //   self.male_femaleBtnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                        genderToggleFlag = 0
                        genderString = NSLocalizedString("Female", comment: "")
                        self.male_femaleBtnOutlet.setTitle("Female", for: .normal)
                        self.male_femaleBtnOutlet.setTitleColor(.black, for: .normal)

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
                                if naabFetch11!.count == 0 {
                                    
                                } else {
                                    let breedIdGet = (naabFetch11![0] as? String)!
                                    self.breedId = breedIdGet
                                    UserDefaults.standard.set(self.breedId, forKey: keyValue.breed.rawValue)
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
//                    singleBttn.layer.borderColor = UIColor.gray.cgColor
//                    singleBttn.layer.borderWidth = 0.5
                    let et = data.eT
                    etBtn = et as! String
//                    etBttn.layer.borderWidth = 0.5
//                    singleBttn.layer.borderWidth = 0.5
//                    multipleBirthBttn.layer.borderWidth = 0.5
//                    cloneOutlet.layer.borderWidth = 0.5
//                    SplitEmbryoOutlet.layer.borderWidth = 0.5
//                    internalBtnOulet.layer.borderWidth = 0.5
                    
                    if data.selectedBornTypeId == 3 {
                        etBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                        etBttn.layer.borderWidth = 2
                        singleBttn.layer.borderColor = UIColor.gray.cgColor
                        internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                        multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                        SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                        cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                        selectedBornTypeId = 3
                    }
                    else if data.selectedBornTypeId == 1 {
                        singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                        singleBttn.layer.borderWidth = 2
                        internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                        multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                        SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                        cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                        etBttn.layer.borderColor = UIColor.gray.cgColor
                        selectedBornTypeId = 1
                        
                    }else if data.selectedBornTypeId == 2 {
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
                        //statusOrder = true
                        messageCheck = true
                    }
                }
            }
        }
        else{
            if scanAnimalTagText.text!.count > 0 {
                
                farmIdTextField.isEnabled = true
                scanBarcodeText.isEnabled = true
             //   permanentIDTextField.isEnabled = true
                tissueBtnOutlet.isEnabled = true
                breedBtnOutlet.isEnabled = true
                etBttn.isEnabled = true
                multipleBirthBttn.isEnabled = true
                singleBttn.isEnabled = true
                sireIdTextField.isEnabled = true
                damtexfield.isEnabled = true
                textFieldBackroungWhite()
             //   nationalHerdIdTextField.isEnabled = true
              //  sireIAuTextField.isEnabled = true
                male_femaleBtnOutlet.isEnabled = true
                male_femaleBtnOutlet.backgroundColor = UIColor.white

                bleBttn.isEnabled = true
                blebttn1.isEnabled = true
                scanButton.isEnabled = true
                dateTextField.isEnabled = true
            } else {
                farmIdTextField.isEnabled = false
                scanBarcodeText.isEnabled = false
              //  permanentIDTextField.isEnabled = false
                tissueBtnOutlet.isEnabled = false
                breedBtnOutlet.isEnabled = false
                etBttn.isEnabled = false
                multipleBirthBttn.isEnabled = false
                singleBttn.isEnabled = false
                sireIdTextField.isEnabled = false
                damtexfield.isEnabled = false
                textFieldBackroungGrey()
              //  nationalHerdIdTextField.isEnabled = false
              //  sireIAuTextField.isEnabled = false
                male_femaleBtnOutlet.isEnabled = false
                male_femaleBtnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)

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
              //  self.sireIAuTextField.becomeFirstResponder()
                if damtexfield.text?.count == 0 {
                }
                else{
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
                self.farmIdView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor

            }
            self.farmIdTextField.becomeFirstResponder()
            self.farmIdView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor

            
        } else if (textField == self.farmIdTextField) {
            if scanAnimalTagText.tag == 1{
                
                if borderRedCheck == true {
                    self.scanBarcodeText.becomeFirstResponder()
                    UserDefaults.standard.set("", forKey: keyValue.selectAnimalId.rawValue)
                } else {
                    if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as! String == "True" {
                        
                        if farmIdTextField.text == ""  && !isCheckCountryUK() {
                            borderRedCheck = true
                            farmIdView.layer.borderColor = UIColor.red.cgColor
                            
                        }
                        self.scanBarcodeText.becomeFirstResponder()
                        
                    } else {
                        self.scanBarcodeText.becomeFirstResponder()
                        farmIdView.layer.borderColor = UIColor.gray.cgColor
                    }
                }
            } else {
                self.scanBarcodeText.becomeFirstResponder()
            }
        }
        
        else if (textField == self.scanBarcodeText) {
            if scanBarcodeText.text == ""{
                barcodeView.layer.borderColor = UIColor.red.cgColor
            } else {
                barcodeView.layer.borderColor = UIColor.gray.cgColor
            }
            self.sireIdTextField.becomeFirstResponder()
            
        }
        
        else if (textField == self.sireIdTextField) {
            if sireIdTextField.text == ""{
                self.damtexfield.becomeFirstResponder()
            }else{
                if autoSuggestionStatus == true {
                    self.damtexfield.becomeFirstResponder()
                    
                }else{
                    if pvid == 3 {
                    }
                    else {
                        validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                        
                    }
                    if  providerName == keyValue.clarifideCDCBUS.rawValue || providerName == keyValue.clarifideAHDBUK.rawValue || providerName == keyValue.auDairyProducts.rawValue{
                        if sireIdTextField.text! == scanAnimalTagText.text! || sireIdTextField.text! == farmIdTextField.text! {
                            damtexfield.isUserInteractionEnabled = false
                            sireIdTextField.layer.borderColor = UIColor.red.cgColor
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sireIdCannotBeSame, comment: ""))
                            sireIdTextField.becomeFirstResponder()
                            
                            return false
                        } else {
                            self.damtexfield.becomeFirstResponder()
                            damtexfield.isUserInteractionEnabled = true
                        }
                    }
                }
            }
        }
        
        else if (textField == self.sireIAuTextField) {
            self.nationalHerdIdTextField.becomeFirstResponder()
            if sireIAuTextField.text != ""{
                sireIAuTextField.layer.borderColor = UIColor.gray.cgColor
            }
        }
        
        else if (textField == self.nationalHerdIdTextField) {
            self.nationalHerdIdTextField.resignFirstResponder()
            if nationalHerdIdTextField.text != ""{
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
            UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
        }
        
        if animalData.count > 0 {
            let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: pvid, breedId: breedId )
            if product.count == 0{
                let refreshAlert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.breedDoesNotExist, comment: ""), preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    self.byDefaultSetting()
                    self.textFieldBackroungGrey()
                    self.isautoPopulated = false
                }))
                present(refreshAlert, animated: true, completion: nil)
            }
        }
        
        let samType = fetchproviderDataChekValidation( entityName : Entities.getSampleTblEntity, provId: pvid,sampleID: sampleID)
        if samType.count == 0 {
            byDefaultSetting()
            textFieldBackroungGrey()
            isautoPopulated = false
            if self.pvid == 8 {
                self.tissueBtnOutlet.setTitle(LocalizedStrings.hairString.localized, for: .normal)
                self.saveSampleNameandID(sampleNameStr: LocalizedStrings.hairString, sampleID: 4)
            } else {
                tissueBtnOutlet.titleLabel!.text = ButtonTitles.allflexTSUText
                tissueBtnOutlet.setTitle(ButtonTitles.allflexTSUText, for: .normal)
                self.saveSampleNameandID(sampleNameStr: ButtonTitles.allflexTSUText, sampleID: 1)
            }
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sampleTypeDoesNotExist, comment: ""))
        }
        
        return true
    }
}
