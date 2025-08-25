//
//  BeefAnimalGlobalHD50KVCExtension.swift
//  SearchPoint
//
//  Created by Mobile Programming on 11/03/24.
//

import Foundation
import UIKit
import CoreBluetooth

extension BeefAnimalGlobalHD50KVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

extension BeefAnimalGlobalHD50KVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == importTblView {
            return importListArray.count
        }
        if tableView == pairedTableView {
            return arrNearbyDevice.count
        }
        
        if btnTag == 20 {
            return tissueArr.count
        }
        else if btnTag == 10{
            return  breedArr.count
        }
        else if btnTag == 40{
            return damRegArr.count
        }
        else if btnTag == 50{
            return inheritTissueArr.count
        }
        else if btnTag == 60{
            return inheritBreedArr.count
        }
        else if btnTag == 70{
            return inheritRegArr.count
        }
        else if btnTag == 80{
            return breedRegArr.count
        } else if btnTag == 90{
            return inheritRegArr.count
        }
        else{
            return sireRegArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        
        if tableView == importTblView {
            let cell :ImportListCell = importTblView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ImportListCell
            cell.listNameLabel.text = importListArray[indexPath.row].listName
            cell.listNameDescLbl.text = importListArray[indexPath.row].listDesc
            return cell
        }
        
        if tableView == pairedTableView {
            let cell = pairedTableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! PairedDeviceCell
            var deviceName = arrNearbyDevice[indexPath.row].name
            if deviceName == nil {
                deviceName = String(describing: arrNearbyDevice[indexPath.row].identifier)
            }
            
            cell.deviceLbl?.text = deviceName
            let state = arrNearbyDevice[indexPath.row].state
            if state == .connected{
                cell.accessoryType = .checkmark
            }
            else {
                cell.accessoryType = .none
                
            }
            return cell
        }
        
        if btnTag == 20{
            let tissue = self.tissueArr[indexPath.row]  as! GetSampleTbl
            cell.textLabel?.text = tissue.sampleName?.localized
            return cell
        }
        
        if btnTag == 10{
            let breed = breedArr[indexPath.row] as! GetBreedsTbl
            if breed.threeCharCode == LocalizedStrings.breedNameX{
                cell.textLabel?.text = "XX"
                return cell
            }
            cell.textLabel?.text = breed.threeCharCode
            return cell
        }
        if btnTag == 30 {
            let tissue = self.sireRegArr[indexPath.row]  as! GetBreedSocieties
            cell.textLabel?.text = tissue.association
            return cell
        }
        if btnTag == 40{
            let tissue = self.damRegArr[indexPath.row]  as! GetBreedSocieties
            cell.textLabel?.text = tissue.association
        }
        if btnTag == 80{
            let tissue = self.breedRegArr[indexPath.row]  as! GetBreedSocieties
            cell.textLabel?.text = tissue.association
        }
        if btnTag == 50{
            let tissue = self.inheritTissueArr[indexPath.row]  as! GetSampleTbl
            cell.textLabel?.text = tissue.sampleName?.localized
            return cell
        }
        
        if btnTag == 60{
            let breed = inheritBreedArr[indexPath.row] as! GetBreedsTbl
            if breed.threeCharCode == LocalizedStrings.breedNameX{
                cell.textLabel?.text = "XX"
                return cell
            }
            cell.textLabel?.text = breed.threeCharCode
            return cell
            
        }
        if btnTag == 70{
            let tissue = self.inheritRegArr[indexPath.row]  as! GetBreedSocieties
            cell.textLabel?.text =  tissue.association
        }
        if btnTag == 90{
            let tissue = self.inheritRegArr[indexPath.row]  as! GetBreedSocieties
            cell.textLabel?.text =  tissue.association
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
        if orederStatus.count > 0 {
            barcodeEnable = true
        }
        
        if tableView == importTblView {
            let listId1 = importListArray[indexPath.row].listId
            let listName = importListArray[indexPath.row].listName
            listNameString = listName ?? ""
            listId = Int(listId1)
            return
        }
        
        if btnTag == 20  {
            let tissue = self.tissueArr[indexPath.row] as! GetSampleTbl
            tissuId = Int(tissue.sampleId)
            tissueBttnOutlet.setTitleColor(.black, for: .normal)
            tissueBttnOutlet.setTitle(tissue.sampleName?.localized, for: .normal)
            buttonbg2.removeFromSuperview()
        }
        
        if btnTag == 10  {
            let breed = self.breedArr[indexPath.row] as! GetBreedsTbl
            breedId = breed.breedId!
            breedBtnOutlet.setTitleColor(.black, for: .normal)
            if breed.threeCharCode == LocalizedStrings.breedNameX{
                breedBtnOutlet.setTitle("XX", for: .normal)
            } else {
                breedBtnOutlet.setTitle(breed.threeCharCode, for: .normal)
            }
            buttonbg2.removeFromSuperview()
        }
        
        if btnTag == 30{
            let sireReg = sireRegArr[indexPath.row] as! GetBreedSocieties
            sireRegDropdownOutlet.setTitleColor(.black, for: .normal)
            sireRegDropdownOutlet.setTitle(sireReg.association, for: .normal)
            UserDefaults.standard.set(sireReg.association, forKey: keyValue.beefSireReg.rawValue)
            buttonbg2.removeFromSuperview()
        }
        
        if btnTag == 40{
            let damReg = damRegArr[indexPath.row] as! GetBreedSocieties
            damRegDropdownOutlet.setTitleColor(.black, for: .normal)
            damRegDropdownOutlet.setTitle(damReg.association, for: .normal)
            UserDefaults.standard.set(damReg.association, forKey: keyValue.beefDamReg.rawValue)
            buttonbg2.removeFromSuperview()
        }
        
        if btnTag == 80{
            let breedReg = breedRegArr[indexPath.row] as! GetBreedSocieties
            breedRegBttn.setTitleColor(.black, for: .normal)
            breedRegBttn.setTitle(breedReg.association, for: .normal)
            UserDefaults.standard.set(breedReg.association, forKey: keyValue.beefBreedReg.rawValue)
            buttonbg2.removeFromSuperview()
        }
        
        if btnTag == 50{
            let tissue = self.inheritTissueArr[indexPath.row] as! GetSampleTbl
            tissuId = Int(tissue.sampleId)
            inheritTissueBttn.setTitleColor(.black, for: .normal)
            inheritTissueBttn.setTitle(tissue.sampleName?.localized, for: .normal)
            buttonbg2.removeFromSuperview()
        }
        
        if btnTag == 60{
            let breed = self.inheritBreedArr[indexPath.row] as! GetBreedsTbl
            breedId = breed.breedId!
            inheritBreedBttn.setTitleColor(.black, for: .normal)
            if breed.threeCharCode == LocalizedStrings.breedNameX{
                inheritBreedBttn.setTitle("XX", for: .normal)
            } else {
                inheritBreedBttn.setTitle(breed.threeCharCode, for: .normal)
            }
            buttonbg2.removeFromSuperview()
        }
        
        if btnTag == 70{
            let breedReg = inheritRegArr[indexPath.row] as! GetBreedSocieties
            inheritRegAssociationBttn.setTitleColor(.black, for: .normal)
            inheritRegAssociationBttn.setTitle(breedReg.association?.localized, for: .normal)
            UserDefaults.standard.set(breedReg.association, forKey: keyValue.beefRegAssociation.rawValue)
            buttonbg2.removeFromSuperview()
        }
        
        if btnTag == 90{
            let breedReg = inheritRegArr[indexPath.row] as! GetBreedSocieties
            inheriSireRedOutlet.setTitleColor(.black, for: .normal)
            inheriSireRedOutlet.setTitle(breedReg.association, for: .normal)
            UserDefaults.standard.set(breedReg.association, forKey: keyValue.beefRegAssociation.rawValue)
            buttonbg2.removeFromSuperview()
        }
        
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
    }
}

extension BeefAnimalGlobalHD50KVC : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if scanEarTagTextField == textField || inheritEarTagTextfield == textField {
            scanEarTagTextField.returnKeyType = .next
            inheritEarTagTextfield.returnKeyType = .next
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !barAutoPopu {
            barcodeflag = true
        } else {
            let orderStatus = fetchAllDataWithAnimalIdstatus(
                entityName: Entities.beefAnimalMasterTblEntity,
                animalId: idAnimal,
                orderststus: "true",
                customerId: custmerId
            )
            let eligibleFields: [UITextField] = [
                scanEarTagTextField, inheritEarTagTextfield, breedRegTextfield, inheritBreedRegTextfield,
                animalNameTextfield, sireRegTextfield, damRegTextfield, inheritSireRegTextfield,
                inheritDamIdTextfield, inheritEIDTextfield, inheritSecondaryIdTextfield,
                inheritDamYobBttn, inheritSireYobBttn
            ]
            if orderStatus.count > 0 && eligibleFields.contains(textField) {
                barcodeEnable = true
            }
        }
        
        if string == " " {
            return false
        }
        
        func updateBarcodeUI(for textField: UITextField, imageView: UIImageView) {
            barcodeflag = true
            let currentText = textField.text ?? ""
            let newString = (currentText as NSString).replacingCharacters(in: range, with: string)
            if isBarcodeAutoIncrementedEnabled {
                let barcodeInfo = isBarcodeEndingWithNumberAndGetIncremented(newString)
                if barcodeInfo.isBarCodeEndsWithNumber {
                    imageView.image = UIImage(named: ImageNames.checkImg)
                    UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
                    checkBarcode = false
                } else {
                    UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                    checkBarcode = true
                }
            }
        }
        
        if textField == scanBarcodeTextfield {
            updateBarcodeUI(for: scanBarcodeTextfield, imageView: incrementalBarcodeCheckBoxGlobal)
        } else if textField == inheritBarcodeTextfield {
            updateBarcodeUI(for: inheritBarcodeTextfield, imageView: incrementalBarcodeCheckBoxInherit)
        }
        
        if let char = string.cString(using: .utf8), strcmp(char, "\\b") == -92 {
            // Backspace handling
            switch textField {
            case scanEarTagTextField:
                textField.text?.count == 1 ? textFieldBackroungGrey() : textFieldBackroungWhite()
                isautoPopulated = false
            case inheritEarTagTextfield:
                inheritEarTagTextfield.text?.count == 1 ? inheritTextFieldBackroungGrey() : inherittextFieldBackroungWhite()
                isautoPopulated = false
            case breedRegTextfield:
                break // No action needed
            case damRegTextfield:
                break // No action needed
            case inheritSireRegTextfield:
                if inheritSireRegTextfield.text?.count == 1 {
                    inheriSireRedOutlet.setTitleColor(.black, for: .normal)
                }
            case scanBarcodeTextfield:
                barcodeflag = true
                if scanBarcodeTextfield.text?.count == 1 {
                    incrementalBarcodeCheckBoxGlobal.image = UIImage(named: ImageNames.incrementalCheckImg)
                    UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                    isBarcodeAutoIncrementedEnabled = false
                    checkBarcode = false
                }
            case inheritBarcodeTextfield:
                barcodeflag = true
                if inheritBarcodeTextfield.text?.count == 1 {
                    incrementalBarcodeCheckBoxInherit.image = UIImage(named: ImageNames.incrementalCheckImg)
                    UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                    isBarcodeAutoIncrementedEnabled = false
                    checkBarcode = false
                }
            default:
                break
            }
            return true
        }
        
        // Validation for other inputs
        if textField == inheritDamYobBttn || textField == inheritSireYobBttn {
            let updatedText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let allowedChars = CharacterSet.decimalDigits
            guard string.rangeOfCharacter(from: allowedChars.inverted) == nil else { return false }
            if updatedText.count > 4 { return false }
        }
        
        if textField == inheritBarcodeTextfield || textField == scanBarcodeTextfield {
            let allowedChars = CharacterSet(charactersIn: LocalizedStrings.abcdNumberFormat)
            if string.rangeOfCharacter(from: allowedChars.inverted) != nil { return false }
        }
        
        if textField == inheritEarTagTextfield || textField == scanEarTagTextField {
            let allowedChars = CharacterSet(charactersIn: LocalizedStrings.earTagRegex)
            if string.rangeOfCharacter(from: allowedChars.inverted) != nil { return false }
        }
        
        func appendSlashIfNeeded(for textField: UITextField) {
            if let text = textField.text, text.count == 2 || text.count == 5 {
                textField.text?.append("/")
            }
            if let text = textField.text, text.count >= 10 {
                return
            }
        }
        
        if textField == inheritDateTextField {
            appendSlashIfNeeded(for: inheritDateTextField)
            if inheritDateTextField.text?.count == 10 { return false }
        }
        
        if textField == globalDateTextField {
            appendSlashIfNeeded(for: globalDateTextField)
            if globalDateTextField.text?.count == 10 { return false }
        }
        
        // UI updates based on text field
        switch textField {
        case scanEarTagTextField:
            isautoPopulated = false
            textFieldBackroungWhite()
        case inheritEarTagTextfield:
            isautoPopulated = false
            inherittextFieldBackroungWhite()
        case breedRegTextfield:
            breedRegBttn.isEnabled = true
        case sireRegTextfield:
            sireRegDropdownOutlet.isEnabled = true
        case inheritSireRegTextfield:
            inheriSireRedOutlet.backgroundColor = .white
            inheriSireRedOutlet.setTitleColor(.black, for: .normal)
        case damRegTextfield:
            damRegDropdownOutlet.isEnabled = true
        default:
            break
        }
        
        // State flags update
        if editIngText {
            editIngText = false
        } else if isUpdate {
            animalId1 = editAid
            isUpdate = false
        }
        
        if statusOrder {
            msgAnimalSucess = true
        } else {
            messageCheck = true
        }
        
        let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal, customerID: custmerId)
        statusOrder = animalFetch.count > 0
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(
            entityName: Entities.beefAnimalAddTblEntity,
            animalId: animalId1,
            orderId: orderId,
            userId: userId,
            orderStatus: "false"
        )
        msgUpatedd = animalDataMaster.count > 0
        
        if isautoPopulated {
            let animalData = fetchAnimaldataValidateAnimalTag(
                entityName: Entities.beefAnimalAddTblEntity,
                animalTag: scanAnimalText,
                orderId: orderId,
                userId: userId,
                animalId: animalId1
            )
            if animalData.count == 0 {
                let animalDataMaster = fetchAnimaldataValidateAnimalId(
                    entityName: Entities.beefAnimalMasterTblEntity,
                    animalId: animalId1,
                    orderId: orderId,
                    userId: userId,
                    orderStatus: "false"
                )
                if animalDataMaster.count > 0 {
                    msgcheckk = false
                }
            }
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        func validateDate(for textField: UITextField, button: UIButton) {
            guard let text = textField.text, !text.isEmpty else { return }
            
            if text.count == 10 {
                let validationResult = isValidDate(dateString: text)
                if validationResult == LocalizedStrings.correctFormatStr {
                    button.layer.borderColor = UIColor.gray.cgColor
                    button.layer.borderWidth = 0.5
                    validateDateFlag = true
                } else {
                    button.layer.borderColor = UIColor.red.cgColor
                    validateDateFlag = false
                }
            } else {
                button.layer.borderColor = UIColor.red.cgColor
                validateDateFlag = false
            }
        }
        
        if textField == inheritDateTextField {
            validateDate(for: inheritDateTextField, button: inheritDobBttn)
        } else if textField == globalDateTextField {
            validateDate(for: globalDateTextField, button: dateBttnOutlet)
        } else if textField == scanEarTagTextField {
            if let text = scanEarTagTextField.text, !text.isEmpty {
                dataPopulateInFocusChange()
            }
        } else if textField == inheritEarTagTextfield {
            if let text = inheritEarTagTextfield.text, !text.isEmpty {
                dataPopulateInFocusChange()
                incrementalBarcodeTitleLabelInherit.textColor = .black
                incrementalBarcodeButtonInherit.isEnabled = true
                incrementalBarcodeCheckBoxInherit.alpha = 1
                incrementalBarcodeTitleLabelInherit.alpha = 1
            }
        }
    }
    
    
    func dataPopulateInFocusChange(){
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        if inheritEarTagTextfield.text != "" {
            let inheritAnimalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: Entities.beefAnimalMasterTblEntity, animalTag:inheritEarTagTextfield.text!, farmId: "", animalbarCodeTag: inheritBarcodeTextfield.text!, offPermanentId: inheritBreedRegTextfield.text!, offDamId: inheritDamIdTextfield.text!, offsireId: inheritSireRegTextfield.text!,orderId:orderId,userId:userId,custmerId:custmerId )
            let inheritAddAnimal = fetchAnimaldataValidateAnimalwithouOrderID(entityName: Entities.beefAnimalAddTblEntity, animalTag:inheritEarTagTextfield.text!, farmId: "", animalbarCodeTag: inheritBarcodeTextfield.text!, offPermanentId: inheritBreedRegTextfield.text!, offDamId: inheritDamIdTextfield.text!, offsireId: inheritSireRegTextfield.text!,orderId:orderId,userId:userId,custmerId:custmerId )
            
            
            if !isautoPopulated {
                isautoPopulated = true
                barAutoPopu = true
                inherittextFieldBackroungWhite()
                updateOrder = true
                if inheritAnimalData.count > 0 {
                    let data =  inheritAnimalData.lastObject as! BeefAnimalMaster
                    let cartAnimal = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalMasterTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId)) as! [BeefAnimalMaster]
                    
                    if cartAnimal.count != 0 {
                        let filterAnimalCart = cartAnimal.filter({$0.animalbarCodeTag == data.animalbarCodeTag && $0.orderstatus == "false"})
                        if filterAnimalCart.count > 0  {
                            isAnimalComingFromCart = true
                        }
                    }
                    
                    let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                    animalId1 = Int(data.animalId)
                    barcodeflag = false
                    inheritEarTagView.layer.borderColor = UIColor.gray.cgColor
                    inheritBarcodeView.layer.borderColor = UIColor.gray.cgColor
                    let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
                    let formatter = DateFormatter()
                    inheritDobBttn.titleLabel?.text = ""
                    
                    if data.date != ""{
                        if dateStr == "MM"{
                            var dateVale = ""
                            let values = data.date!.components(separatedBy: "/")
                            if values.count > 1{
                                let date = values[0]
                                let month = values[1]
                                let year = values[2]
                                dateVale = month + "/" + date + "/" + year
                                yearPublic = Int(year)!
                            }
                            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                                inheritDateTextField.text = dateVale
                            } else {
                                inheritDobBttn.setTitle(dateVale, for: .normal)
                            }
                            formatter.dateFormat = DateFormatters.MMddyyyyFormat
                        }
                        else {
                            var dateVale = ""
                            let values = data.date!.components(separatedBy: "/")
                            
                            if values.count > 1{
                                let date = values[0]
                                let month = values[1]
                                let year = values[2]
                                dateVale = date + "/" + month + "/" + year
                                yearPublic = Int(year)!
                            }
                            
                            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                                inheritDateTextField.text = dateVale
                            } else {
                                inheritDobBttn.setTitle(dateVale, for: .normal)
                            }
                            formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                        }
                        
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String != keyValue.defaultEntry.rawValue {
                            if inheritDobBttn.titleLabel!.text == nil {
                                self.InheritSelectedDate = Date()
                            }
                            else{
                                self.InheritSelectedDate = formatter.date(from: inheritDobBttn.titleLabel!.text!)!
                            }
                        }
                        
                    }
                    
                    inheritBreedRegTextfield.text = data.offPermanentId
                    inheritSireRegTextfield.text = data.offsireId
                    inheritDamIdTextfield.text = data.offDamId
                    inheriSireRedOutlet.setTitle(data.sireRegAssocation, for: .normal)
                    let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                    if dataFetch.count == 0 {
                        incrementalBarcodeTitleLabelInherit.textColor = .black
                        incrementalBarcodeTitleLabelInherit.alpha = 1
                        incrementalBarcodeCheckBoxInherit.alpha = 1
                        incrementalBarcodeButtonInherit.isEnabled = true
                    } else {
                        let orStatus = dataFetch[0] as? BeefAnimaladdTbl
                        if orStatus?.orderstatus == "true"{
                            checkBarcode = false
                            incrementalBarcodeTitleLabelInherit.textColor = .black
                            incrementalBarcodeButtonInherit.isEnabled = true
                            incrementalBarcodeTitleLabelInherit.alpha = 1
                            incrementalBarcodeCheckBoxInherit.alpha = 1
                        } else {
                            inheritBarcodeTextfield.text = data.animalbarCodeTag
                            UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                            UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                            self.isBarcodeAutoIncrementedEnabled = false
                            incrementalBarcodeCheckBoxInherit.image = UIImage(named: ImageNames.incrementalCheckImg)
                            incrementalBarcodeButtonInherit.isEnabled = false
                            incrementalBarcodeTitleLabelInherit.textColor = .gray
                            checkBarcode = false
                        }}
                    if data.breedName == LocalizedStrings.breedNameX{
                        inheritBreedBttn.setTitle("XX", for: .normal)
                    } else {
                        inheritBreedBttn.setTitle(data.breedName, for: .normal)
                    }
                    
                    inheritTissueBttn.setTitleColor(.black, for: .normal)
                    inheritBreedBttn.setTitleColor(.black, for: .normal)
                    inheritTissueBttn.setTitle(data.tissuName?.localized, for: .normal)
                    UserDefaults.standard.set(data.tissuName, forKey: keyValue.beefInheritTSU.rawValue)
                    inheritSireYobBttn.text = data.sireYOB
                    inheritDamYobBttn.text = data.damYOB
                    breedId = data.breedId!
                    UserDefaults.standard.set(data.breedName, forKey: keyValue.inheritBeefbreed.rawValue)
                    inheritEIDTextfield.text = data.sireIDAU
                    inheritSecondaryIdTextfield.text = data.nationHerdAU
                    inheritRegAssociationBttn.setTitle(data.eT?.localized, for: .normal)
                    if data.gender == "Male".localized || data.gender == "M"{
                        self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                        inheritMaleFemaleBttn.setTitle("Male", for: .normal)
                        inheritGenderToggleFlag = 1
                        inheritGenderString = NSLocalizedString("Male", comment: "")
                        UserDefaults.standard.set("M", forKey: "InheritBeefGender")
                    }
                    else {
                        self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                        inheritMaleFemaleBttn.setTitle("Female", for: .normal)
                        inheritGenderToggleFlag = 0
                        inheritGenderString = "Female".localized
                        UserDefaults.standard.set("F", forKey: "InheritBeefGender")
                    }
                    
                    tissuId = Int(data.tissuId)
                    
                    inheritDobBttn.setTitleColor(.black, for: .normal)
                    statusOrder = false
                    messageCheck = false
                    let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
                    if adata.count > 0{
                        let animal  = adata.object(at: 0) as! BeefAnimalMaster
                        idAnimal = Int(animal.animalId)
                        messageCheck = true
                    }
                    
                    if data.eT == "" || data.eT == nil {
                        inheritRegAssociationBttn.setTitle(NSLocalizedString(LocalizedStrings.selectBreedAssc, comment: ""), for: .normal)
                    }
                    if data.sireRegAssocation == nil || data.sireRegAssocation == "" {
                        inheriSireRedOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectSireReg, comment: ""), for: .normal)
                    }
                }
                else if inheritAddAnimal.count > 0 {
                    let data =  inheritAddAnimal.lastObject as! BeefAnimaladdTbl
                    let cartAnimal = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId)) as! [BeefAnimaladdTbl]
                    
                    if cartAnimal.count != 0 {
                        let filterAnimalCart = cartAnimal.filter({$0.animalbarCodeTag == data.animalbarCodeTag && $0.orderstatus == "false"})
                        if filterAnimalCart.count > 0  {
                            isAnimalComingFromCart = true
                        }
                    }
                    
                    autoPopulateAnimalData = data
                    let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                    animalId1 = Int(data.animalId)
                    barcodeflag = false
                    inheritEarTagView.layer.borderColor = UIColor.gray.cgColor
                    inheritBarcodeView.layer.borderColor = UIColor.gray.cgColor
                    let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
                    let formatter = DateFormatter()
                    inheritDobBttn.titleLabel?.text = ""
                    
                    if data.date != ""{
                        if dateStr == "MM"{
                            var dateVale = ""
                            let values = data.date!.components(separatedBy: "/")
                            if values.count > 1{
                                let date = values[0]
                                let month = values[1]
                                let year = values[2]
                                dateVale = month + "/" + date + "/" + year
                                yearPublic = Int(year)!
                            }
                            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                                inheritDateTextField.text = dateVale
                            } else {
                                inheritDobBttn.setTitle(dateVale, for: .normal)
                            }
                            formatter.dateFormat = DateFormatters.MMddyyyyFormat
                        }
                        else {
                            var dateVale = ""
                            let values = data.date!.components(separatedBy: "/")
                            
                            if values.count > 1{
                                let date = values[0]
                                let month = values[1]
                                let year = values[2]
                                dateVale = date + "/" + month + "/" + year
                                yearPublic = Int(year)!
                            }
                            
                            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                                inheritDateTextField.text = dateVale
                            } else {
                                inheritDobBttn.setTitle(dateVale, for: .normal)
                            }
                            formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                        }
                        
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String != keyValue.defaultEntry.rawValue {
                            if inheritDobBttn.titleLabel!.text == nil {
                                self.InheritSelectedDate = Date()
                            }
                            else{
                                self.InheritSelectedDate = formatter.date(from: inheritDobBttn.titleLabel!.text!)!
                            }
                        }
                        
                    }
                    
                    inheritBreedRegTextfield.text = data.offPermanentId
                    inheritSireRegTextfield.text = data.offsireId
                    inheritDamIdTextfield.text = data.offDamId
                    inheriSireRedOutlet.setTitle(data.sireRegAssocation, for: .normal)
                    let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                    if dataFetch.count == 0 {
                        incrementalBarcodeTitleLabelInherit.textColor = .black
                        incrementalBarcodeTitleLabelInherit.alpha = 1
                        incrementalBarcodeCheckBoxInherit.alpha = 1
                        incrementalBarcodeButtonInherit.isEnabled = true
                    } else {
                        let orStatus = dataFetch[0] as? BeefAnimaladdTbl
                        if orStatus?.orderstatus == "true"{
                            checkBarcode = false
                            incrementalBarcodeTitleLabelInherit.textColor = .black
                            incrementalBarcodeButtonInherit.isEnabled = true
                            incrementalBarcodeTitleLabelInherit.alpha = 1
                            incrementalBarcodeCheckBoxInherit.alpha = 1
                        } else {
                            inheritBarcodeTextfield.text = data.animalbarCodeTag
                            UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                            UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                            self.isBarcodeAutoIncrementedEnabled = false
                            incrementalBarcodeCheckBoxInherit.image = UIImage(named: ImageNames.incrementalCheckImg)
                            incrementalBarcodeButtonInherit.isEnabled = false
                            incrementalBarcodeTitleLabelInherit.textColor = .gray
                            checkBarcode = false
                        }}
                    if data.breedName == LocalizedStrings.breedNameX{
                        inheritBreedBttn.setTitle("XX", for: .normal)
                    } else {
                        inheritBreedBttn.setTitle(data.breedName, for: .normal)
                    }
                    
                    inheritTissueBttn.setTitleColor(.black, for: .normal)
                    inheritBreedBttn.setTitleColor(.black, for: .normal)
                    inheritTissueBttn.setTitle(data.tissuName?.localized, for: .normal)
                    UserDefaults.standard.set(data.tissuName, forKey: keyValue.beefInheritTSU.rawValue)
                    inheritSireYobBttn.text = data.sireYOB
                    inheritDamYobBttn.text = data.damYOB
                    breedId = data.breedId!
                    UserDefaults.standard.set(data.breedName, forKey: keyValue.inheritBeefbreed.rawValue)
                    inheritEIDTextfield.text = data.sireIDAU
                    inheritSecondaryIdTextfield.text = data.nationHerdAU
                    inheritRegAssociationBttn.setTitle(data.eT?.localized, for: .normal)
                    if data.gender == "Male".localized || data.gender == "M"{
                        self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                        inheritMaleFemaleBttn.setTitle("Male", for: .normal)
                        inheritGenderToggleFlag = 1
                        inheritGenderString = NSLocalizedString("Male", comment: "")
                        UserDefaults.standard.set("M", forKey: "InheritBeefGender")
                    }
                    else {
                        self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                        inheritMaleFemaleBttn.setTitle("Female", for: .normal)
                        inheritGenderToggleFlag = 0
                        inheritGenderString = "Female".localized
                        UserDefaults.standard.set("F", forKey: "InheritBeefGender")
                    }
                    
                    tissuId = Int(data.tissuId)
                    
                    inheritDobBttn.setTitleColor(.black, for: .normal)
                    statusOrder = false
                    messageCheck = false
                    let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
                    if adata.count > 0{
                        let animal  = adata.object(at: 0) as! BeefAnimalMaster
                        idAnimal = Int(animal.animalId)
                        messageCheck = true
                    }
                    
                    if data.eT == "" || data.eT == nil {
                        inheritRegAssociationBttn.setTitle(NSLocalizedString(LocalizedStrings.selectBreedAssc, comment: ""), for: .normal)
                    }
                    if data.sireRegAssocation == nil || data.sireRegAssocation == "" {
                        inheriSireRedOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectSireReg, comment: ""), for: .normal)
                    }
                }
            }
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        let animalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: Entities.beefAnimalMasterTblEntity, animalTag:scanEarTagTextField.text!, farmId: "", animalbarCodeTag: scanBarcodeTextfield.text!, offPermanentId: breedRegTextfield.text!, offDamId: damRegTextfield.text!, offsireId: sireRegTextfield.text!,orderId:orderId,userId:userId,custmerId:custmerId )
        let inheritAnimalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: Entities.beefAnimalMasterTblEntity, animalTag:inheritEarTagTextfield.text!, farmId: "", animalbarCodeTag: inheritBarcodeTextfield.text!, offPermanentId: inheritBreedRegTextfield.text!, offDamId: inheritDamIdTextfield.text!, offsireId: inheritSireRegTextfield.text!,orderId:orderId,userId:userId,custmerId:custmerId )
        
        if !isautoPopulated {
            if animalData.count > 0 {
                isautoPopulated = true
                barAutoPopu = true
                textFieldBackroungWhite()
                updateOrder = true
                let data =  animalData.lastObject as! BeefAnimalMaster
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                animalId1 = Int(data.animalId)
                
                let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                if dataFetch.count == 0 {
                    incrementalBarcodeTitleLabelGlobal.textColor = .black
                    incrementalBarcodeTitleLabelGlobal.alpha = 1
                    incrementalBarcodeCheckBoxGlobal.alpha = 1
                    incrementalBarcodeButtonGlobal.isEnabled = true
                } else {
                    if data.orderstatus == "true"{
                        checkBarcode = false
                        incrementalBarcodeTitleLabelGlobal.textColor = .black
                        incrementalBarcodeButtonGlobal.isEnabled = true
                        incrementalBarcodeTitleLabelGlobal.alpha = 1
                        incrementalBarcodeCheckBoxGlobal.alpha = 1
                    }
                    else {
                        scanBarcodeTextfield.text = data.animalbarCodeTag
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                        self.isBarcodeAutoIncrementedEnabled = false
                        incrementalBarcodeCheckBoxGlobal.image = UIImage(named: ImageNames.incrementalCheckImg)
                        incrementalBarcodeButtonGlobal.isEnabled = false
                        incrementalBarcodeTitleLabelGlobal.textColor = .gray
                        incrementalBarcodeTitleLabelGlobal.alpha = 0.6
                        incrementalBarcodeCheckBoxGlobal.alpha = 0.6
                        checkBarcode = false
                    }
                }
                
                earTagView.layer.borderColor = UIColor.gray.cgColor
                barcodeView.layer.borderColor = UIColor.gray.cgColor
                dateBttnOutlet.titleLabel?.text = ""
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
                            yearPublic = Int(year)!
                            
                        }
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            globalDateTextField.text = dateVale
                        } else {
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
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
                            yearPublic = Int(year)!
                            
                        }
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            globalDateTextField.text = dateVale
                        } else {
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
                        }
                        formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                    }
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String != keyValue.defaultEntry.rawValue {
                        if dateBttnOutlet.titleLabel!.text == nil {
                            self.selectedDate = Date()
                        }
                        else {
                            self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                            
                        }
                    }
                }
                
                barcodeflag = false
                breedRegTextfield.text = data.offPermanentId
                sireRegTextfield.text = data.offsireId
                damRegTextfield.text = data.offDamId
                animalNameTextfield.text  = data.eT
                if data.breedName == LocalizedStrings.breedNameX{
                    breedBtnOutlet.setTitle("XX", for: .normal)
                } else {
                    breedBtnOutlet.setTitle(data.breedName, for: .normal)
                }
                tissueBttnOutlet.setTitleColor(.black, for: .normal)
                breedBtnOutlet.setTitleColor(.black, for: .normal)
                tissueBttnOutlet.setTitle(data.tissuName, for: .normal)
                UserDefaults.standard.set(data.tissuName, forKey: keyValue.beefTSU.rawValue)
                
                if data.farmId != ""{
                    breedRegBttn.setTitle(data.farmId, for: .normal)
                    breedRegBttn.setTitleColor(.black, for: .normal)
                }
                if data.sireIDAU != ""{
                    sireRegDropdownOutlet.setTitle(data.sireIDAU, for: .normal)
                    sireRegDropdownOutlet.setTitleColor(.black, for: .normal)
                }
                if data.nationHerdAU != ""{
                    damRegDropdownOutlet.setTitle(data.nationHerdAU, for: .normal)
                    damRegDropdownOutlet.setTitleColor(.black, for: .normal)
                }
                breedRegBttn.backgroundColor = .white
                sireRegDropdownOutlet.backgroundColor = .white
                damRegDropdownOutlet.backgroundColor = .white
                breedId = data.breedId!
                UserDefaults.standard.set(data.breedName, forKey: keyValue.beefBreed.rawValue)
                
                if data.gender == "Male".localized || data.gender == "M"{
                    self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 1
                    genderString = NSLocalizedString("Male", comment: "")
                    
                } else {
                    self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 0
                    genderString = "Female".localized
                    
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
            
            if inheritAnimalData.count > 0 {
                isautoPopulated = true
                barAutoPopu = true
                inherittextFieldBackroungWhite()
                updateOrder = true
                let data =  inheritAnimalData.lastObject as! BeefAnimalMaster
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                animalId1 = Int(data.animalId)
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                self.isBarcodeAutoIncrementedEnabled = false
                barcodeflag = false
                inheritEarTagView.layer.borderColor = UIColor.gray.cgColor
                inheritBarcodeView.layer.borderColor = UIColor.gray.cgColor
                let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
                let formatter = DateFormatter()
                inheritDobBttn.titleLabel?.text = ""
                
                if data.date != "" {
                    if dateStr == "MM"{
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        if values.count > 1{
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = month + "/" + date + "/" + year
                            yearPublic = Int(year)!
                        }
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            inheritDateTextField.text = dateVale
                        }else {
                            inheritDobBttn.setTitle(dateVale, for: .normal)
                        }
                        formatter.dateFormat = DateFormatters.MMddyyyyFormat
                    }
                    else {
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        
                        if values.count > 1{
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = date + "/" + month + "/" + year
                            yearPublic = Int(year)!
                            
                        }
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            inheritDateTextField.text = dateVale
                        }else {
                            inheritDobBttn.setTitle(dateVale, for: .normal)
                        }
                        formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                    }
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String != keyValue.defaultEntry.rawValue {
                        if inheritDobBttn.titleLabel!.text == nil {
                            self.InheritSelectedDate = Date()
                        }
                        else{
                            self.InheritSelectedDate = formatter.date(from: inheritDobBttn.titleLabel!.text!)!
                        }
                    }
                }
                
                let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                if dataFetch.count == 0 {
                    incrementalBarcodeTitleLabelInherit.textColor = .black
                    incrementalBarcodeTitleLabelInherit.alpha = 1
                    incrementalBarcodeCheckBoxInherit.alpha = 1
                    incrementalBarcodeButtonInherit.isEnabled = true
                }
                else {
                    let orStatus = dataFetch[0] as? BeefAnimaladdTbl
                    
                    if orStatus?.orderstatus == "true"{
                        checkBarcode = false
                        incrementalBarcodeTitleLabelInherit.textColor = .black
                        incrementalBarcodeButtonInherit.isEnabled = true
                        incrementalBarcodeTitleLabelInherit.alpha = 1
                        incrementalBarcodeCheckBoxInherit.alpha = 1
                    } else {
                        inheritBarcodeTextfield.text = data.animalbarCodeTag
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                        self.isBarcodeAutoIncrementedEnabled = false
                        incrementalBarcodeCheckBoxInherit.image = UIImage(named: ImageNames.incrementalCheckImg)
                        incrementalBarcodeButtonInherit.isEnabled = false
                        incrementalBarcodeTitleLabelInherit.textColor = .gray
                        checkBarcode = false
                    }
                }
                
                inheritBreedRegTextfield.text = data.offPermanentId
                inheritSireRegTextfield.text = data.offsireId
                inheritDamIdTextfield.text = data.offDamId
                inheriSireRedOutlet.setTitle(data.sireRegAssocation, for: .normal)
                
                if data.breedName == LocalizedStrings.breedNameX{
                    inheritBreedBttn.setTitle("XX", for: .normal)
                } else {
                    inheritBreedBttn.setTitle(data.breedName, for: .normal)
                }
                
                inheritTissueBttn.setTitleColor(.black, for: .normal)
                inheritBreedBttn.setTitleColor(.black, for: .normal)
                inheritTissueBttn.setTitle(data.tissuName?.localized, for: .normal)
                UserDefaults.standard.set(data.tissuName?.localized, forKey: keyValue.beefInheritTSU.rawValue)
                inheritSireYobBttn.text = data.sireYOB
                inheritDamYobBttn.text = data.damYOB
                breedId = data.breedId!
                UserDefaults.standard.set(data.breedName, forKey: keyValue.inheritBeefbreed.rawValue)
                inheritEIDTextfield.text = data.sireIDAU
                inheritSecondaryIdTextfield.text = data.nationHerdAU
                inheritRegAssociationBttn.setTitle(data.eT?.localized, for: .normal)
                if data.gender == "Male".localized || data.gender == "M"{
                    self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    inheritGenderToggleFlag = 1
                    inheritGenderString = NSLocalizedString("Male", comment: "")
                }
                else {
                    self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    inheritGenderToggleFlag = 0
                    inheritGenderString = "Female".localized
                }
                
                tissuId = Int(data.tissuId)
                textField.resignFirstResponder()
                inheritDobBttn.setTitleColor(.black, for: .normal)
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
            if scanEarTagTextField.text!.count > 0 {
                textFieldBackroungWhite()
            }
            else{
                textFieldBackroungGrey()
            }
        }
        
        let borderViewMap: [UITextField: UIView] = [
            scanEarTagTextField: earTagView,
            scanBarcodeTextfield: barcodeView,
            inheritEarTagTextfield: inheritEarTagView,
            inheritBarcodeTextfield: inheritBarcodeView
        ]
        
        let nextResponderMap: [UITextField: UIResponder] = [
            scanEarTagTextField: scanBarcodeTextfield,
            scanBarcodeTextfield: breedRegTextfield,
            breedRegTextfield: animalNameTextfield,
            animalNameTextfield: sireRegTextfield,
            sireRegTextfield: damRegTextfield,
            damRegTextfield: textField,
            
            inheritEarTagTextfield: inheritBarcodeTextfield,
            inheritBarcodeTextfield: inheritEIDTextfield,
            inheritEIDTextfield: inheritSecondaryIdTextfield,
            inheritSecondaryIdTextfield: inheritBreedRegTextfield,
            inheritBreedRegTextfield: inheritSireRegTextfield,
            inheritSireRegTextfield: inheritSireYobBttn,
            inheritSireYobBttn: inheritDamIdTextfield,
            inheritDamIdTextfield: inheritDamYobBttn,
            inheritDamYobBttn: textField
        ]
        
        if let borderView = borderViewMap[textField] {
            let isEmpty = textField.text?.isEmpty ?? true
            borderView.layer.borderColor = isEmpty ? UIColor.red.cgColor : UIColor.gray.cgColor
        }
        
        if let nextResponder = nextResponderMap[textField] {
            if nextResponder === textField {
                textField.resignFirstResponder()
            } else {
                nextResponder.becomeFirstResponder()
            }
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    func pageLoading() {
        self.NavigateToBeefOrderingScreen()
    }
    
    func timeStamp()-> String{
        let time1 = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatters.MMddyyyyHHmmssFormat
        let timestamp = formatter.string(from: time1 as Date)
        lblTimeStamp = timestamp.replacingOccurrences(of: "-", with: "", options: .regularExpression)
        lblTimeStamp = lblTimeStamp.replacingOccurrences(of: ":", with: "", options: .regularExpression)
        let udid = UserDefaults.standard.value(forKey: keyValue.applicationIdentifier.rawValue)! as! String
        let sessionGUID1 =   lblTimeStamp + "_" + String(describing: autoD as Int)
        lblTimeStamp = sessionGUID1 + "_" + "iOS" + "_" + String(udid)
        return lblTimeStamp
    }
    
}
extension BeefAnimalGlobalHD50KVC : SideMenuUI,objectPickCartScreen{
    func objectGetOnSelection(temp: Int) {
        isAnimalComingFromCart = true
        let animalID = temp
        let existAnimalData = fetchAllDataWithAnimalIdstatus(entityName: Entities.beefAnimalAddTblEntity, animalId:animalID,orderststus:"false", customerId: self.custmerId) as! [BeefAnimaladdTbl]
        if existAnimalData.count > 0{
            autoPopulateAnimalData = existAnimalData[0]
        }
    }
    
    func anOptionalMethod(check :Bool){
        if check {
            isUpdate = false
            editIngText = false
            statusOrder = false
            animalId1 = -1
            editAid = -1
            idAnimal = 0
            isautoPopulated = false
            byDefaultSetting()
            inheritByDefaultSetting()
            textFieldBackroungGrey()
            msgUpatedd = false
        }}
    
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}

extension BeefAnimalGlobalHD50KVC: InheritQuestionaireControllerDelegate {
    func inheritQuestionaireControllerDismissed() {
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        UserDefaults.standard.set(false, forKey: keyValue.showbeefInheritTable.rawValue)
        inheritEarTagTextfield.becomeFirstResponder()
        UserDefaults.standard.set(InheritQuestionaireManager.shared.inheritQuestionaireModel?.selectedPrimaryBreedId, forKey: keyValue.selectedPrimaryBreed.rawValue)
        let arr = fetchproviderProductData(entityName: Entities.getBreedsTblEntity, provId: pvid)
        for i in arr  {
            if (i as! GetBreedsTbl).breedName == InheritQuestionaireManager.shared.inheritQuestionaireModel?.getSelectedBreedType() {
                self.breedId = (i as! GetBreedsTbl).breedId ?? ""
                
                if (i as! GetBreedsTbl).breedId == "87c30632-8da0-4f86-8d94-46da17c520dd" {
                    inheritBreedBttn.setTitle("XX", for: .normal)
                    UserDefaults.standard.string(forKey: keyValue.inheritBeefbreed.rawValue)
                    UserDefaults.standard.set((i as! GetBreedsTbl).breedName, forKey: keyValue.inheritBeefbreed.rawValue)
                } else {
                    inheritBreedBttn.setTitle((i as! GetBreedsTbl).threeCharCode, for: .normal)
                    UserDefaults.standard.string(forKey: keyValue.inheritBeefbreed.rawValue)
                    UserDefaults.standard.set((i as! GetBreedsTbl).threeCharCode, forKey: keyValue.inheritBeefbreed.rawValue)
                }
            }
        }
    }
}

extension BeefAnimalGlobalHD50KVC : AnimalMergeProtocol{
    func refreshUI() {
        if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
            let animalCount = fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
            self.notificationLblCount.text = String(animalCount.count)
            if animalCount.count == 0 {
                self.notificationLblCount.isHidden = true
                self.countLbl.isHidden = true
                self.globalCrossBtnOutlet.isHidden = true
                self.globalMergeListBtnOulet.isHidden = true
            }
            else {
                self.notificationLblCount.isHidden = false
                self.countLbl.isHidden = false
                self.globalCrossBtnOutlet.isHidden = false
                self.globalMergeListBtnOulet.isHidden = false
            }
            
            let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ,providerId:pvid)
            if fetchObj.count != 0 {
                let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                let obj = objectFetch?.listName
                let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
                
                if fetchAllMergeDta == 0 {
                    let fetchNameDisplay = String(obj ?? "")
                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                    globalMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                    
                } else {
                    let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                    globalMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                    
                }
            }else {
                let attributeString = NSMutableAttributedString(string: "", attributes: self.attrs)
                globalMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                globalMergeListBtnOulet.isHidden = true
                globalCrossBtnOutlet.isHidden = true
            }
        }
        else {
            let animalCount = fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
            self.notificationLblCount.text = String(animalCount.count)
            if animalCount.count == 0 {
                self.notificationLblCount.isHidden = true
                self.countLbl.isHidden = true
                self.inheritCrossBtnOutlet.isHidden = true
                self.InheritmergeListBtnOulet.isHidden = true
            }
            else {
                self.notificationLblCount.isHidden = false
                self.countLbl.isHidden = false
                self.inheritCrossBtnOutlet.isHidden = false
                self.InheritmergeListBtnOulet.isHidden = false
            }
            
            let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ,providerId:pvid)
            if fetchObj.count != 0 {
                let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                let obj = objectFetch?.listName
                let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
                
                if fetchAllMergeDta == 0 {
                    let fetchNameDisplay = String(obj ?? "")
                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                    InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                } else {
                    let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                    InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                }
            }else {
                let attributeString = NSMutableAttributedString(string: "", attributes: self.attrs)
                InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                InheritmergeListBtnOulet.isHidden = true
                inheritCrossBtnOutlet.isHidden = true
            }
        }
    }
}

private typealias DataListGlobalHD50KCartHelper = BeefAnimalGlobalHD50KVC
extension DataListGlobalHD50KCartHelper {
    func fetchDatalistDetailbyName(listName: String) -> [DataEntryList] {
        let fetchDataEntry : [DataEntryList] = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.custmerId ),listName:listName ,productName:marketNameType.Dairy.rawValue) as! [DataEntryList]
        return fetchDataEntry
    }
    
    func checkCartanimalCount() {
        let viewAnimalArray =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid)
        if viewAnimalArray.count > 0{
            createDataList()
        }
    }
    
    func createDataList(){
        let orderingDataList = OrderingDataListViewModel()
        let listName = orderingDataList.makeListName(custmerId: custmerId , providerID: pvid)
        if listName != "" {
            var animalID1 = UserDefaults.standard.integer(forKey: keyValue.listId.rawValue)
            animalID1 = animalID1 + 1
            UserDefaults.standard.set(animalID1, forKey: keyValue.listId.rawValue)
            self.hideIndicator()
            
            if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String == marketNameType.Beef.rawValue && self.pvid == 5 {
                var fetchDatEntry = [DataEntryList]()
                var productType  = ""
                fetchDatEntry =  fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(custmerId ),listName: listName ,productName:marketNameType.Beef.rawValue) as! [DataEntryList]
                if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.capsInherit.rawValue {
                    productType = keyValue.capsInherit.rawValue
                }
                else {
                    productType = keyValue.globalHD50K.rawValue
                }
                
                if fetchDatEntry.count == 0 {
                    saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(custmerId ),listDesc: "",listId: Int64(animalID1),listName: listName ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: self.pvid, productType: productType, productName: marketNameType.Beef.rawValue)
                    
                    SaveAnimalDatInList(listID: Int64(animalID1), animalID: animalID1)
                    
                } else {
                    let listIdGet = fetchDatEntry[0].listId
                    let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderId:orderId,orderStatus:"false",listid:Int64(fetchDatEntry[0].listId), custmerId: Int64(custmerId ), providerId: pvid)
                    if fetchData11.count != 0 {
                        for i in 0...fetchData11.count - 1 {
                            let animalVal = fetchData11.object(at: i) as! DataEntryAnimaladdTbl
                            deleteAnimalfromdataEntry(enitityName: Entities.dataEntryBeefAnimalAddTblEntity, Int(animalVal.animalId), listId: Int(animalVal.listId))
                        }
                    }
                    SaveAnimalDatInList(listID: listIdGet, animalID: animalID1)
                }
            }
        }
    }
    
    func SaveAnimalDatInList(listID:Int64,animalID:Int){
        if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue{
            let animals = fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid) as! [BeefAnimaladdTbl]
            
            for data in animals {
                let animalData = checkAnimaldataValidateAnimalTagDataEntry(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalTag:data.animalTag ?? ""  ,listId: Int(listID ), custmerId: custmerId ,providerID: self.pvid)
                if animalData.count == 0 {
                    saveAnimalInDataBeefAnimalGlobalHD50K(listID: listID, animalDetails: data, animalID: animalID)
                }
            }
        } else {
            let animals = fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid) as! [BeefAnimaladdTbl]
            
            for data in animals {
                
                let animalData = checkAnimaldataValidateAnimalTagDataEntry(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalTag:data.animalTag ?? ""  ,listId: Int(listID ), custmerId: custmerId , providerID: self.pvid)
                if animalData.count == 0 {
                    inheritSaveAnimalInDataBeefAnimalGlobalHD50K(listID: listID, animalDetails: data, animalID: animalID)
                }
            }
        }
    }
    
    func saveAnimalInDataBeefAnimalGlobalHD50K(listID:Int64, animalDetails:BeefAnimaladdTbl,animalID:Int) {
        saveAnimaldataBeefInProductId(entity: Entities.dataEntryBeefAnimalAddTblEntity,
                                      animalTag: animalDetails.animalTag ?? "",
                                      barCodetag: animalDetails.animalbarCodeTag ?? "" ,
                                      date: animalDetails.date ?? ""  ,
                                      damId: animalDetails.offDamId ?? "",
                                      sireId: animalDetails.offsireId ?? "" ,
                                      gender: animalDetails.gender ?? "",
                                      update: "true",
                                      permanentId:animalDetails.offPermanentId ?? "",
                                      tissuName: animalDetails.tissuName ?? "",
                                      breedName: animalDetails.breedName ?? "",
                                      et: animalDetails.eT ?? "",
                                      farmId: animalDetails.farmId ?? "",
                                      orderId: autoD,
                                      orderSataus:"false",
                                      breedId:animalDetails.breedId ?? "",
                                      isSync:"false",
                                      providerId: Int(animalDetails.providerId),
                                      tissuId: Int(animalDetails.tissuId),
                                      sireIDAU: animalDetails.sireIDAU ?? "",
                                      nationHerdAU: animalDetails.nationHerdAU ?? "",
                                      userId: userId,
                                      udid:animalDetails.udid ?? "",
                                      animalId: Int(animalDetails.animalId),
                                      productId:Int(animalDetails.productId),
                                      custId: Int(animalDetails.custmerId),
                                      listId: listID,
                                      serverAnimalId: "",
                                      tertiaryGeno: animalDetails.tertiaryGeno ?? "")
    }
    
    func inheritSaveAnimalInDataBeefAnimalGlobalHD50K(listID:Int64, animalDetails:BeefAnimaladdTbl,animalID:Int) {
        inheritSaveAnimaldataBeefInProductId(entity: Entities.dataEntryBeefAnimalAddTblEntity,
                                             animalTag: animalDetails.animalTag ?? "",
                                             barCodetag: animalDetails.animalbarCodeTag ?? "",
                                             date: animalDetails.date ?? "" ,
                                             damId: animalDetails.offDamId ?? "",
                                             sireId: animalDetails.offsireId ?? "" ,
                                             gender: animalDetails.gender ?? "",
                                             update: "true",
                                             permanentId:animalDetails.offPermanentId ?? "",
                                             tissuName: animalDetails.tissuName ?? "",
                                             breedName: animalDetails.breedName ?? "",
                                             et: animalDetails.eT ?? "",
                                             farmId:animalDetails.farmId ?? "",
                                             orderId: autoD,
                                             orderSataus:"false",
                                             breedId:animalDetails.breedId ?? "",
                                             isSync:"false",
                                             providerId: Int(animalDetails.providerId ),
                                             tissuId: Int(animalDetails.tissuId ),
                                             sireIDAU: animalDetails.sireIDAU ?? "",
                                             nationHerdAU: animalDetails.nationHerdAU ?? "",
                                             userId: userId,
                                             udid:animalDetails.udid ?? "",
                                             animalId: Int(animalDetails.animalId ),
                                             productId:Int(animalDetails.productId ),
                                             sirYOB: animalDetails.sireYOB ?? "",
                                             damYOB: animalDetails.damYOB ?? "",
                                             sireRegAssocation: animalDetails.sireRegAssocation ?? "",
                                             custId: Int(animalDetails.custmerId ),
                                             listId: listID ,
                                             serverAnimalId: "",
                                             tertiaryGeno: animalDetails.tertiaryGeno ?? "")
    }
}
private typealias AutoImportDataListHelper = BeefAnimalGlobalHD50KVC
extension AutoImportDataListHelper {
    func checkUserDataListName(){
        let orderingDataList = OrderingDataListViewModel()
        let listName = orderingDataList.makeListName(custmerId: self.custmerId , providerID: pvid)
        let fetchDatEntry : [DataEntryList] = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.custmerId ),listName:listName ,productName:marketNameType.Beef.rawValue) as! [DataEntryList]
        if fetchDatEntry.count > 0{
            inheritCrossBtnOutlet.isHidden = true
            globalCrossBtnOutlet.isHidden = true
            let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false",listid:Int64(fetchDatEntry.first?.listId ?? 0), custmerId: Int64(custmerId ), providerId: pvid) as! [DataEntryBeefAnimaladdTbl]
            if fetchData11.count != 0 {
                
                for i in 0...fetchData11.count - 1 {
                    let fetchCartAnimal = fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)) as! [BeefAnimaladdTbl]
                    let filterCartAnimal =  fetchCartAnimal.filter({ $0.animalTag == fetchData11[i].animalTag && $0.animalbarCodeTag == fetchData11[i].animalbarCodeTag})
                    if filterCartAnimal.isEmpty{
                        let dataGet = fetchData11[i]
                        if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
                            saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity,
                                                          animalTag: dataGet.animalTag ?? "",
                                                          barCodetag: dataGet.animalbarCodeTag ?? "" ,
                                                          date: dataGet.date ?? ""  ,
                                                          damId: dataGet.offDamId ?? "",
                                                          sireId: dataGet.offsireId ?? "" ,
                                                          gender: dataGet.gender ?? "",
                                                          update: "true",
                                                          permanentId:dataGet.offPermanentId ?? "",
                                                          tissuName: dataGet.tissuName ?? "",
                                                          breedName: dataGet.breedName ?? "",
                                                          et: dataGet.eT ?? "",
                                                          farmId: dataGet.farmId ?? "",
                                                          orderId: autoD,
                                                          orderSataus:"false",
                                                          breedId:dataGet.breedId ?? "",
                                                          isSync:"false",
                                                          providerId: pvid,
                                                          tissuId: Int(dataGet.tissuId),
                                                          sireIDAU: dataGet.sireIDAU ?? "",
                                                          nationHerdAU: dataGet.nationHerdAU ?? "",
                                                          userId: userId,
                                                          udid:dataGet.udid ?? "",
                                                          animalId: Int(dataGet.animalId),
                                                          productId:Int(dataGet.productId),
                                                          custId: Int(dataGet.custmerId),
                                                          listId: fetchDatEntry.first?.listId ?? 0,
                                                          serverAnimalId: "",
                                                          tertiaryGeno: dataGet.tertiaryGeno ?? "")
                            UserDefaults.standard.setValue(dataGet.breedName, forKey: keyValue.beefBreed.rawValue)
                            UserDefaults.standard.setValue(dataGet.tissuName, forKey: keyValue.beefTSU.rawValue)
                            tissueBttnOutlet.setTitle(dataGet.tissuName ?? "", for: .normal)
                            if dataGet.breedName == LocalizedStrings.breedNameX{
                                breedBtnOutlet.setTitle("XX", for: .normal)
                            } else {
                                breedBtnOutlet.setTitle(dataGet.breedName, for: .normal)
                            }
                        } else {
                            inheritSaveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: pvid ,tissuId: Int(dataGet.tissuId ),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId ),productId:Int(dataGet.productId ), sirYOB: dataGet.sireYOB ?? "", damYOB: dataGet.damYOB ?? "", sireRegAssocation: dataGet.sireRegAssocation ?? "",custId: Int(dataGet.custmerId ), listId: fetchDatEntry.first?.listId ?? 0 , serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                            
                            UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: keyValue.dataEntryBeefInheritTsu.rawValue)
                            UserDefaults.standard.set(dataGet.breedName ?? "", forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
                            
                            self.inheritTissueBttn.setTitle(dataGet.tissuName?.localized, for: .normal)
                            if dataGet.breedName == LocalizedStrings.breedNameX{
                                self.inheritBreedBttn.setTitle("XX", for: .normal)
                            } else {
                                self.inheritBreedBttn.setTitle(dataGet.breedName, for: .normal)
                            }
                        }
                        autoSaveProductandsubProduct(dataGet: dataGet)
                        
                    }
                }
            }
        }
        inheritCrossBtnOutlet.isHidden = true
        globalCrossBtnOutlet.isHidden = true
    }
    
    func autoSaveProductandsubProduct(dataGet:DataEntryBeefAnimaladdTbl){
        let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
        let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
        for k in 0 ..< animalData.count{
            let animalId = animalData[k] as! BeefAnimaladdTbl
            for i in 0 ..< product.count {
                let data = product[i] as! GetProductTblBeef
                
                saveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: animalId.farmId ?? "", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "", orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: true)
                
                let addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                let subProductArr =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:orderId,customerID: custmerId)
                
                for j in 0 ..< addonArr.count {
                    
                    let addonDat = addonArr[j] as! GetAdonTbl
                    if subProductArr.count > 0 {
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
    }
}

extension BeefAnimalGlobalHD50KVC: QrScannerProtocol {
    func qrCodeScannedResult(_ qrValue: String) {
        if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
            scanBarcodeTextfield.text = qrValue
        }
        else{
            inheritBarcodeTextfield.text = qrValue
        }
    }
}

extension BeefAnimalGlobalHD50KVC: scannedOCRProtocol {
    func ocrDetected(_ scannedResult: String) {
        inheritEIDTextfield.text = scannedResult
        isautoPopulated = false
    }
}

extension BeefAnimalGlobalHD50KVC : RFID,nearByDevice{
    func rfidCode(rfid: String) {
        let beefScannerSelection = UserDefaults.standard.string(forKey: keyValue.beefScannerSelection.rawValue)
        let providerName = UserDefaults.standard.string(forKey: keyValue.providerName.rawValue)

        if !(beefScannerSelection == keyValue.ocrKey.rawValue && providerName == keyValue.USDairyProducts.rawValue) {
            inheritEIDTextfield.text?.removeAll()
            if inheritEIDTextfield.isEnabled {
                inheritEIDTextfield.text = rfid.trimmingCharacters(in: .whitespaces)
                inheritEIDTextfield.becomeFirstResponder()
            }
        }
    }
    
    func deviceNear(deviceName : [CBPeripheral]){
        arrNearbyDevice = deviceName
    }
}

extension BeefAnimalGlobalHD50KVC : offlineCustomView1 {
    func crossBtn() {
        buttonbg.removeFromSuperview()
        customPopView1.removeFromSuperview()
    }
}
