//
//  DataEntryBeefAnimalNZVCExtensions.swift
//  SearchPoint
//
//  Created by Mobile Programming on 26/02/24.
//

import Foundation
import UIKit

// MARK: - TEXTFIELD DELEGATE
extension DataEntryBeefAnimalNZ_VC : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == damRegTextfield ) {
            damRegTextfield.returnKeyType = UIReturnKeyType.done
        }
        else {
            scanAnimalTagTextField.returnKeyType = UIReturnKeyType.next
            scanBarcodeTextfield.returnKeyType = UIReturnKeyType.next
            animalNameTextfield.returnKeyType = UIReturnKeyType.next
            sireRegTextfield.returnKeyType = UIReturnKeyType.next
            breedRegTextfield.returnKeyType = UIReturnKeyType.next
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if barAutoPopu == false {
            barcodeflag = true
        } else {
            let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId!)
            if orederStatus.count > 0 {
                if textField == scanAnimalTagTextField || textField == damRegTextfield || textField == sireRegTextfield || textField == breedRegTextfield ||  textField == animalNameTextfield {
                    barcodeEnable = true
                }
            }
        }
        if  (string == " ") {
            return false
        }
        
        if textField == scanBarcodeTextfield {
            let currentString: NSString = scanBarcodeTextfield.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            barcodeflag = true
            if self.isBarcodeAutoIncrementedEnabled {
                if isBarCodeEndsWithNumber_GetIncrementedBarCode(newString as String).isBarCodeEndsWithNumber  {
                    incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.checkImg)
                    UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
                    checkBarcode = false
                }
                else {
                    UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                    checkBarcode = true
                }
            }
        }
        
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                if textField == scanAnimalTagTextField{
                    if scanAnimalTagTextField.text!.count == 1 {
                        textFieldBackroungGrey()
                    } else {
                        textFieldBackroungWhite()
                    }
                    isautoPopulated = false
                }
                else if textField == scanBarcodeTextfield {
                    barcodeflag = true
                    if scanBarcodeTextfield.text!.count == 1 {
                        incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                        self.isBarcodeAutoIncrementedEnabled = false
                        checkBarcode = false
                    }
                }
                return true
            }
            else {
                if textField == scanAnimalTagTextField{
                    isautoPopulated = false
                    textFieldBackroungWhite()
                }
            }
            
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
            
            let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal,customerID: custmerId!)
            if animalFetch.count > 0{
                statusOrder = true
            }
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            if animalDataMaster.count > 0 {
                msgUpatedd = true
            }
            
            if isautoPopulated == true {
                let animalData = fetchAnimaldataValidateAnimalTag(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalTag:scanAnimalText, orderId: orderId, userId: userId, animalId: animalId1)
                if animalData.count == 0{
                    let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                    if animalDataMaster.count > 0 {
                        msgcheckk = true
                    }
                }
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
        
        if textField == scanBarcodeTextfield {
            let ACCEPTABLE_CHARACTERS = LocalizedStrings.abcdNumberFormat
            let check  = ACCEPTABLE_CHARACTERS.contains(string)
            if check == false {
                return false
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == dateTextField {
            if dateTextField.text!.count == 0{
                
            }
            else{
                if dateTextField.text?.count == 10 {
                    let validate = isValidDate(dateString: dateTextField.text ?? "")
                    if validate == LocalizedStrings.correctFormatStr {
                        dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
                        dateBttnOutlet.layer.borderWidth = 0.5
                        validateDateFlag = true
                    }
                    else {
                        dateBttnOutlet.layer.borderColor = UIColor.red.cgColor
                        validateDateFlag = false
                        if validate == LocalizedStrings.greaterThenDateStr {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.dobSmallerthanCurrDate, comment: ""))
                        }
                        else {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
                        }
                    }
                }
                else {
                    dateBttnOutlet.layer.borderColor = UIColor.red.cgColor
                    validateDateFlag = false
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
                }
            }
        }
        if textField == scanAnimalTagTextField {
            self.dataPopulateInFocusChange()
        }
    }
    
    func isValidDate(dateString: String) -> String {
        let dateFormatterGet = DateFormatter()
        let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        if dateStr == "MM"{
            dateFormatterGet.dateFormat = DateFormatters.MMddyyyyFormat
        }
        else {
            dateFormatterGet.dateFormat = DateFormatters.ddMMyyyyFormat
        }
        
        if let dateGet = dateFormatterGet.date(from: dateString) {
            let smallDate = dateGet.isSmallerThan(Date())
            if smallDate == false {
                return LocalizedStrings.greaterThenDateStr
            }
            return LocalizedStrings.correctFormatStr
        } else {
            return  LocalizedStrings.invalidFormatStr
        }
    }
    
    func dataPopulateInFocusChange(){
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        let animalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: Entities.beefAnimalMasterTblEntity, animalTag:scanAnimalTagTextField.text!, farmId: "", animalbarCodeTag: scanBarcodeTextfield.text!, offPermanentId: breedRegTextfield.text!, offDamId: damRegTextfield.text!, offsireId: sireRegTextfield.text!,orderId:orderId,userId:userId, custmerId: custmerId ?? 0)
        
        if isautoPopulated == false{
            if animalData.count > 0 {
                isautoPopulated = true
                textFieldBackroungWhite()
                barAutoPopu = true
                barcodeflag = false
                updateOrder = true
                let data =  animalData.lastObject as! BeefAnimalMaster
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                animalId1 = Int(data.animalId)
                earTagView.layer.borderColor = UIColor.gray.cgColor
                barcodeView.layer.borderColor = UIColor.gray.cgColor
                breedRegTextfield.layer.borderColor = UIColor.gray.cgColor
                let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
                let formatter = DateFormatter()
                dateBttnOutlet.titleLabel!.text = ""
                
                if data.date != ""{
                    if dateStr == "MM"{
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        if values.count > 1 {
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = month + "/" + date + "/" + year
                            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                                dateTextField.text = dateVale
                            } else {
                                dateBttnOutlet.setTitle(dateVale, for: .normal)
                            }
                        }
                        formatter.dateFormat = DateFormatters.MMddyyyyFormat
                    }
                    else {
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        if values.count > 1 {
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = date + "/" + month + "/" + year
                        }
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            dateTextField.text = dateVale
                        } else {
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
                        }
                        formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                    }
                    
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String != keyValue.defaultEntry.rawValue {
                        if dateBttnOutlet.titleLabel!.text != nil {
                            self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                        }
                    }
                }
                
                breedRegTextfield.text = data.offPermanentId
                sireRegTextfield.text = data.offsireId
                damRegTextfield.text = data.offDamId
                animalNameTextfield.text  = data.eT
                breedBtnOutlet.setTitle(data.breedName, for: .normal)
                tissueBttnOutlet.setTitleColor(.black, for: .normal)
                breedBtnOutlet.setTitleColor(.black, for: .normal)
                tissueBttnOutlet.setTitle(data.tissuName, for: .normal)
                UserDefaults.standard.set(data.tissuName, forKey: keyValue.dataEntryNZBeeftsu.rawValue)
                breedRegAssociationBttn.setTitle(data.sireIDAU, for: .normal)
                breedId = data.breedId!
                UserDefaults.standard.set(data.breedName, forKey: keyValue.NZBeefbreed.rawValue)
                
                if data.gender == ButtonTitles.maleText.localized || data.gender == "M"{
                    self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 1
                    genderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
                }
                else {
                    self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 0
                    genderString = ButtonTitles.femaleText.localized
                    
                }
                scanBarcodeTextfield.text = data.animalbarCodeTag
                let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                if dataFetch.count == 0 {
                    incrementalBarcodeTitleLabel.textColor = .black
                    incrementalBarcodeTitleLabel.alpha = 1
                    incrementalBarcodeCheckBox.alpha = 1
                    incrementalBarcodeButton.isEnabled = true
                } else {
                    if data.orderstatus == "true"{
                        checkBarcode = false
                        incrementalBarcodeTitleLabel.textColor = .black
                        incrementalBarcodeButton.isEnabled = true
                        incrementalBarcodeTitleLabel.alpha = 1
                        incrementalBarcodeCheckBox.alpha = 1
                    }
                    else {
                        scanBarcodeTextfield.text = data.animalbarCodeTag
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                        self.isBarcodeAutoIncrementedEnabled = false
                        incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                        incrementalBarcodeButton.isEnabled = false
                        incrementalBarcodeTitleLabel.textColor = .gray
                        checkBarcode = false
                        incrementalBarcodeTitleLabel.alpha = 0.6
                        incrementalBarcodeCheckBox.alpha = 0.6
                    }
                }
                
                tissuId = Int(data.tissuId)
                dateBttnOutlet.setTitleColor(.black, for: .normal)
                statusOrder = false
                messageCheck = false
                let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
                if adata.count > 0{
                    let animal  = adata.object(at: 0) as! BeefAnimalMaster
                    idAnimal = Int(animal.animalId)
                    messageCheck = true
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        let animalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: Entities.beefAnimalMasterTblEntity, animalTag:scanAnimalTagTextField.text!, farmId: "", animalbarCodeTag: scanBarcodeTextfield.text!, offPermanentId: breedRegTextfield.text!, offDamId: damRegTextfield.text!, offsireId: sireRegTextfield.text!,orderId:orderId,userId:userId, custmerId: custmerId ?? 0)
        
        if isautoPopulated == false{
            if animalData.count > 0 {
                isautoPopulated = true
                textFieldBackroungWhite()
                barAutoPopu = true
                barcodeflag = false
                updateOrder = true
                let data =  animalData.lastObject as! BeefAnimalMaster
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                animalId1 = Int(data.animalId)
                scanBarcodeTextfield.text = data.animalbarCodeTag
                let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                if dataFetch.count == 0 {
                    incrementalBarcodeTitleLabel.textColor = .black
                    incrementalBarcodeTitleLabel.alpha = 1
                    incrementalBarcodeCheckBox.alpha = 1
                    incrementalBarcodeButton.isEnabled = true
                } else {
                    if data.orderstatus == "true"{
                        checkBarcode = false
                        incrementalBarcodeTitleLabel.textColor = .black
                        incrementalBarcodeButton.isEnabled = true
                        incrementalBarcodeTitleLabel.alpha = 1
                        incrementalBarcodeCheckBox.alpha = 1
                    } else {
                        scanBarcodeTextfield.text = data.animalbarCodeTag
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                        self.isBarcodeAutoIncrementedEnabled = false
                        incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                        incrementalBarcodeButton.isEnabled = false
                        incrementalBarcodeTitleLabel.textColor = .gray
                        incrementalBarcodeTitleLabel.alpha = 0.6
                        incrementalBarcodeCheckBox.alpha = 0.6
                        checkBarcode = false
                    }
                }
                dateBttnOutlet.titleLabel!.text = ""
                earTagView.layer.borderColor = UIColor.gray.cgColor
                barcodeView.layer.borderColor = UIColor.gray.cgColor
                breedRegTextfield.layer.borderColor = UIColor.gray.cgColor
                let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
                let formatter = DateFormatter()
                if data.date != ""{
                    
                    if dateStr == "MM"{
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        if values.count > 1 {
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = month + "/" + date + "/" + year
                            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                                dateTextField.text = dateVale
                            } else {
                                dateBttnOutlet.setTitle(dateVale, for: .normal)
                            }
                        }
                        formatter.dateFormat = DateFormatters.MMddyyyyFormat
                    }
                    else {
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        if values.count > 1 {
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = date + "/" + month + "/" + year
                        }
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            dateTextField.text = dateVale
                        } else {
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
                        }
                        formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                    }
                    
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String != keyValue.defaultEntry.rawValue {
                        if dateBttnOutlet.titleLabel!.text != nil{
                            self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                        }
                    }
                }
                
                breedRegTextfield.text = data.offPermanentId
                sireRegTextfield.text = data.offsireId
                damRegTextfield.text = data.offDamId
                animalNameTextfield.text  = data.eT
                breedBtnOutlet.setTitle(data.breedName, for: .normal)
                tissueBttnOutlet.setTitleColor(.black, for: .normal)
                breedBtnOutlet.setTitleColor(.black, for: .normal)
                tissueBttnOutlet.setTitle(data.tissuName, for: .normal)
                UserDefaults.standard.set(data.tissuName, forKey: keyValue.dataEntryNZBeeftsu.rawValue)
                breedRegAssociationBttn.setTitle(data.sireIDAU, for: .normal)
                breedId = data.breedId!
                UserDefaults.standard.set(data.breedName, forKey: keyValue.NZBeefbreed.rawValue)
                if data.gender == ButtonTitles.maleText.localized || data.gender == "M"{
                    self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 1
                    genderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
                }
                else {
                    self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 0
                    genderString = ButtonTitles.femaleText.localized
                    
                }
                
                tissuId = Int(data.tissuId)
                textField.resignFirstResponder()
                dateBttnOutlet.setTitleColor(.black, for: .normal)
                statusOrder = false
                messageCheck = false
                let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
                if adata.count > 0{
                    let animal  = adata.object(at: 0) as! BeefAnimalMaster
                    idAnimal = Int(animal.animalId)
                    messageCheck = true
                }
            }
        }
        else{
            if scanAnimalTagTextField.text!.count > 0 {
                textFieldBackroungWhite()
            }
            else{
                textFieldBackroungGrey()
            }
        }
        
        if textField == scanAnimalTagTextField {
            if scanAnimalTagTextField.text == ""{
                earTagView.layer.borderColor = UIColor.red.cgColor
            }
            else {
                earTagView.layer.borderColor = UIColor.gray.cgColor
            }
            scanBarcodeTextfield.becomeFirstResponder()
        }
        if textField == scanBarcodeTextfield {
            if scanBarcodeTextfield.text == ""{
                barcodeView.layer.borderColor = UIColor.red.cgColor
            }
            else {
                barcodeView.layer.borderColor = UIColor.gray.cgColor
            }
            breedRegTextfield.becomeFirstResponder()
        }
        
        if textField == breedRegTextfield {
            if breedRegTextfield.text == ""{
                breedRegTextfield.layer.borderColor = UIColor.red.cgColor
            }
            else {
                breedRegTextfield.layer.borderColor = UIColor.gray.cgColor
            }
            animalNameTextfield.becomeFirstResponder()
        }
        
        if textField == animalNameTextfield {
            sireRegTextfield.becomeFirstResponder()
        }
        
        if textField == sireRegTextfield {
            damRegTextfield.becomeFirstResponder()
        }
        
        if textField == damRegTextfield {
            textField.resignFirstResponder()
        }
        
        return true
    }
}

// MARK: - OBJECT PICK CART SCREEN AND SIDE MENU UI
extension DataEntryBeefAnimalNZ_VC : objectPickCartScreen,SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
    
    func objectGetOnSelection(temp: Int) {
        
    }
    func anOptionalMethod(check :Bool){
        if check == true{
            isUpdate = false
            editIngText = false
            statusOrder = false
            animalId1 = -1
            editAid = -1
            idAnimal = 0
            isautoPopulated = false
            byDefaultSetting()
            textFieldBackroungGrey()
            msgUpatedd = false
        }}
}

// MARK: - TABLEVIEW DELEGATES AND DATASOURCES
extension DataEntryBeefAnimalNZ_VC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if btnTag == 20 {
            return tissueArr.count
        }
        else if btnTag == 80{
            return breedRegArr.count
        }
        else{
            return breedArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        
        if btnTag == 20{
            let tissue = self.tissueArr[indexPath.row]  as! GetSampleTbl
            cell.textLabel?.text = tissue.sampleName
            return cell
        }
        
        if btnTag == 10{
            let breed = breedArr[indexPath.row] as! GetBreedsTbl
            cell.textLabel?.text = breed.threeCharCode
            return cell
        }
        
        if btnTag == 80{
            let tissue = self.breedRegArr[indexPath.row]  as! GetBreedSocieties
            cell.textLabel?.text = tissue.association
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        barcodeEnable = true
        if btnTag == 20  {
            let tissue = self.tissueArr[indexPath.row] as! GetSampleTbl
            tissuId = Int(tissue.sampleId)
            tissueBttnOutlet.setTitleColor(.black, for: .normal)
            tissueBttnOutlet.setTitle(tissue.sampleName, for: .normal)
            buttonbg2.removeFromSuperview()
        }
        
        if btnTag == 10  {
            let breed = self.breedArr[indexPath.row] as! GetBreedsTbl
            breedId = breed.breedId!
            breedBtnOutlet.setTitleColor(.black, for: .normal)
            breedBtnOutlet.setTitle(breed.threeCharCode, for: .normal)
            UserDefaults.standard.set(breed.threeCharCode, forKey: keyValue.NZBeefbreed.rawValue)
            buttonbg2.removeFromSuperview()
        }
        
        if btnTag == 80  {
            let breedReg = breedRegArr[indexPath.row] as! GetBreedSocieties
            let damRegID = Int(breedReg.associationId!)
            if damRegID == 80 {
                breedRegAssociationBttn.setTitleColor(.black, for: .normal)
                breedRegAssociationBttn.setTitle(breedReg.association, for: .normal)
                UserDefaults.standard.set(breedReg.association, forKey: keyValue.NZBeefBreedReg.rawValue)
            }
            else{
                CommonClass.showAlertMessage(self, titleStr:NSLocalizedString(AlertMessagesStrings.alertString, comment: "") , messageStr: NSLocalizedString(AlertMessagesStrings.nzAngusAssociation, comment: ""))
            }
            buttonbg2.removeFromSuperview()
        }
    }
}

// MARK: - OFFLINE CUSTOM VIEW EXTENSION
extension DataEntryBeefAnimalNZ_VC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

// MARK: - SCANNED OCR PROTOCOL
extension DataEntryBeefAnimalNZ_VC: scannedOCRProtocol {
    func ocrDetected(_ scannedResult: String) {
        scanAnimalTagTextField.text = scannedResult
        scanAnimalTagTextField.text = scannedResult
    }
}

// MARK: - SCROLL VIEW DELEGATES
extension DataEntryBeefAnimalNZ_VC : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
            case 1334:
                scrolView.contentSize.height = 630
                
            case 1920, 2208:
                scrolView.contentSize.height = 630
                
            case 2436:
                scrolView.contentSize.height = 630
                
            case 2688,2796:
                scrolView.contentSize.height = 630
                
            case 1792:
                scrolView.contentSize.height = 630
                
            default:
                break
            }
        }
    }
}

// MARK: - IMAGE PICKER CONTROLLER DELEGATES
extension DataEntryBeefAnimalNZ_VC : UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true, completion: nil)
        self.scanAnimalTagTextField.text = ""
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        setVisionTextRecognizeImage(image: image)
        print(image)
    }
}
