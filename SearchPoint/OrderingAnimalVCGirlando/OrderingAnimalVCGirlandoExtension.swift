//
//  OrderingAnimalVCGirlandoExtension.swift
//  SearchPoint
//
//  Created by Mobile Programming on 10/03/24.
//

import Foundation
import UIKit

// MARK: - OFFLINE CUSTOM VIEW EXTENSION
extension OrderingAnimalVCGirlando:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }}

// MARK: - SIDE MENU UI, RFID EXTENSION
extension OrderingAnimalVCGirlando : SideMenuUI,RFID{
    func rfidCode(rfid: String) {
        // Intentionally left empty.
        // This function will handle navigation to another view controller in the future.
        // Currently unused, but kept for consistency with protocol or planned implementation.
    }
    
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}

// MARK: - TEXTFIELD DELEGATE
extension OrderingAnimalVCGirlando :UITextFieldDelegate  {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == animalNameTextfield{
            guard range.location == 0 else {
                return true
            }
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
            return newString.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines).location != 0
        }
        else{
            if (string == " ") {
                return false
            }
        }
        if !barAutoPopu  {
            barcodeflag = true
        }
        else {
            let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.animalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId!)
            if orederStatus.count > 0 {
                if textField == damRegTextfield || textField == sireRegTextfield || textField == breedRegTextfield || textField == animalNameTextfield || textField == scanEarTagTextField || textField == damRegTextfield {
                    barcodeEnable = true
                }
            }
        }
        
        if textField == scanBarcodeTextfield {
            let currentString: NSString = scanBarcodeTextfield.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            isautoPopulated = false
            barcodeflag = true
            if self.isBarcodeAutoIncrementedEnabled {
                if isBarcodeEndingWithNumberAndGetIncremented(newString as String).isBarCodeEndsWithNumber  {
                    incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.checkImg)
                    UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
                    checkBarcode = false
                } else {
                    UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                    checkBarcode = true
                }
            }
        }
        
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                if textField == scanEarTagTextField{
                    if scanEarTagTextField.text!.count > 1{
                        textFieldBackroungWhite()
                    }
                    isautoPopulated = false
                }
                else if textField == scanBarcodeTextfield{
                    if scanBarcodeTextfield.text!.count == 1 {
                        incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                        self.isBarcodeAutoIncrementedEnabled = false
                        checkBarcode = false
                        
                        if scanBarcodeTextfield.text!.count == 1 {
                            textFieldBackroungGrey()
                        } else {
                            textFieldBackroungWhite()
                        }
                    }
                }
                return true
            }
            else {
                if textField == scanBarcodeTextfield{
                    textFieldBackroungWhite()
                }
            }
            if editIngText{
                editIngText = false
            }
            else if isUpdate  {
                animalId1 = editAid
                isUpdate = false
            }
            if statusOrder {
                msgAnimalSucess = true
            }
            else{
                messageCheck = true
            }
            
            let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.animalMasterTblEntity, animalId: idAnimal, customerID: custmerId!)
            if animalFetch.count > 0{
                statusOrder = true
            }
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            if animalDataMaster.count > 0 {
                msgUpatedd = true
                barcodeflag = true
            }
            barcodeflag = true
            if isautoPopulated  {
                let animalData = fetchAnimaldataValidateAnimalTagGirlando(entityName: Entities.animalAddTblEntity, earTag:scanEarTagTextField.text ?? "", orderId: orderId, userId: userId, animalId: animalId1)
                if animalData.count == 0{
                    let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.animalMasterTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
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
            let acceptableCharacters = LocalizedStrings.acceptableChrString
            let check  = acceptableCharacters.contains(string)
            if !check {
                return false
            }
        }
        
        if textField == scanEarTagTextField {
            let acceptableCharacters = LocalizedStrings.earTagRegex
            let check  = acceptableCharacters.contains(string)
            if !check {
                return false
            }
        }
        return true
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
            if !smallDate  {
                return LocalizedStrings.greaterThenDateStr
            }
            return LocalizedStrings.correctFormatStr
        } else {
            return LocalizedStrings.invalidFormatStr
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == dateTextField {
            if dateTextField.text!.count == 0{
                dateBtnView.layer.borderColor = UIColor.gray.cgColor
                dateBtnView.layer.borderWidth = 0.5
            }
            else {
                if dateTextField.text?.count == 10 {
                    let validate = isValidDate(dateString: dateTextField.text ?? "")
                    if validate == LocalizedStrings.correctFormatStr {
                        dateBtnView.layer.borderColor = UIColor.gray.cgColor
                        dateBtnView.layer.borderWidth = 0.5
                        validateDateFlag = true
                    } else {
                        dateBtnView.layer.borderColor = UIColor.red.cgColor
                        validateDateFlag = false
                        if validate == LocalizedStrings.greaterThenDateStr {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.dobSmallerthanCurrDate, comment: ""))
                            return
                        } else {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
                            return
                        }
                    }
                }
                else {
                    dateBtnView.layer.borderColor = UIColor.red.cgColor
                    validateDateFlag = false
                }
            }
        }
        if textField == scanEarTagTextField {
            dataPopulateInFocusChange()
        }
    }
    
    func dataPopulateInFocusChange(){
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        let animalData1 = fetchAnimaldataValidateAnimalwithouOrderIDGirlando(entityName: Entities.animalMasterTblEntity, earTag: scanEarTagTextField.text ?? "", farmId: "", animalbarCodeTag: scanBarcodeTextfield.text ?? "", offDamId: damRegTextfield.text ?? "" , offsireId: sireRegTextfield.text ?? "", orderId: orderId, userId: userId)
        
        if animalData1.count > 1 {
            for number in 0..<(animalData1.count-1) {
                let animId = animalData1.object(at: number) as? AnimalMaster
                let idAnim = animId?.animalId
                let useriD = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                let customerId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
                deleteDataWithAdh1(entity: Entities.animalMasterTblEntity, animalId: idAnim ?? 0, userId: Int(useriD ), custmerId: Int(customerId ))
            }
        }
        
        let animalData = fetchAnimaldataValidateAnimalwithouOrderIDGirlando(entityName: Entities.animalMasterTblEntity, earTag: scanEarTagTextField.text ?? "", farmId: "", animalbarCodeTag: scanBarcodeTextfield.text ?? "", offDamId: damRegTextfield.text ?? "" , offsireId: sireRegTextfield.text ?? "", orderId: orderId, userId: userId)
        
        if !isautoPopulated  {
            if animalData.count > 0 {
                self.view.hideToast()
                let data =  animalData.lastObject as! AnimalMaster
                if data.breedId != keyValue.girlandoNewBreedId.rawValue || data.breedName != BreedNames.girlandoBreed{
                    return
                }
                isautoPopulated = true
                barAutoPopu = true
                textFieldBackroungWhite()
                updateOrder = true
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                animalId1 = Int(data.animalId)
                if data.eT == "" {
                    singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    singleBttn.layer.borderWidth = 2
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    etBttn.layer.borderColor = UIColor.gray.cgColor
                    
                    selectedBornTypeId = 1
                }
                barcodeView.layer.borderColor = UIColor.gray.cgColor
                dateBttnOutlet.titleLabel!.text = ""
                dateTextField.text = ""
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
                        formatter.dateFormat = DateFormatters.MMddyyyyFormat
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            dateTextField.text = dateVale
                        } else {
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
                        }
                    }
                    else {
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        dateVale = date + "/" + month + "/" + year
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            dateTextField.text = dateVale
                        } else {
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
                        }
                        formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                    }
                    
                    self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!) ?? Date()
                    let isGreater = Date().isSmaller(than: selectedDate)
                    if isGreater  {
                        dateBttnOutlet.setTitle("", for: .normal)
                        dateTextField.text = ""
                    }
                }
                
                sireRegTextfield.text = data.offsireId
                damRegTextfield.text = data.offDamId
                animalNameTextfield.text = data.animalName
                breedRegTextfield.text = data.breedRegNumber
                tissueBttnOutlet.setTitleColor(.black, for: .normal)
                breedBtnOutlet.setTitleColor(.black, for: .normal)
                
                let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.animalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                
                if dataFetch.count == 0 {
                    incrementalBarcodeTitleLabel.textColor = .black
                    incrementalBarcodeTitleLabel.alpha = 1
                    incrementalBarcodeCheckBox.alpha = 1
                    incrementalBarcodeButton.isEnabled = true
                }
                else {
                    let orStatus = dataFetch[0] as? AnimaladdTbl
                    if orStatus?.orderstatus == "true"{
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
                if data.breedId == "" {
                    breedId = keyValue.girlandoNewBreedId.rawValue
                    data.breedId = breedId
                    data.breedName = BreedNames.girlandoBreed
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
                UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                let inheritBreed = fetchAllDataProductGirlandoBreedID(entityName: Entities.getBreedsTblEntity,breedId:breedId,pvid:4)
                
                if inheritBreed.count != 0 {
                    let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                    breedId = medbreedRegArr1!.breedId ?? ""
                    UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                    breedBtnOutlet.setTitle(medbreedRegArr1?.alpha2 ?? medbreedRegArr1?.breedName, for: .normal)
                }
                
                
                
                if data.gender == "Male".localized || data.gender == "M" || data.gender == "m"{
                    self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 1
                    genderString = NSLocalizedString("Male", comment: "")
                    UserDefaults.standard.set("M", forKey: "GirlandoGender")
                }
                else {
                    self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 0
                    genderString = "Female".localized
                    UserDefaults.standard.set("F", forKey: "GirlandoGender")
                }
                
                singleBttn.layer.borderColor = UIColor.gray.cgColor
                singleBttn.layer.borderWidth = 0.5
                let et = data.eT
                etBtn = et!
                etBttn.layer.borderWidth = 0.5
                singleBttn.layer.borderWidth = 0.5
                multipleBirthBttn.layer.borderWidth = 0.5
                
                if data.selectedBornTypeId == 3 {
                    etBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    etBttn.layer.borderWidth = 2
                    singleBttn.layer.borderColor = UIColor.gray.cgColor
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 3
                }
                else if data.selectedBornTypeId == 1{
                    singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    singleBttn.layer.borderWidth = 2
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    etBttn.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 1
                }
                else if data.selectedBornTypeId == 2{
                    multipleBirthBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    multipleBirthBttn.layer.borderWidth = 2
                    singleBttn.layer.borderColor = UIColor.gray.cgColor
                    etBttn.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 2
                }
                else {
                    singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    singleBttn.layer.borderWidth = 2
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    etBttn.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 1
                }
                
                if data.tissuName == "" || data.tissuName == nil {
                    let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
                    self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
                    for items in self.tissueArr{
                        let tissue = items  as? GetSampleTbl
                        let checkdefault  = tissue?.isDefault
                        if checkdefault == true{
                            self.tissueBttnOutlet.setTitle(tissue?.sampleName, for: .normal)
                            self.tissuId = 4
                            UserDefaults.standard.set(tissue?.sampleName, forKey: keyValue.girlandoSampleType.rawValue)
                            self.tissuId =  Int(tissue?.sampleId ?? 4)
                        }
                    }
                }
                else {
                    tissueBttnOutlet.setTitle(data.tissuName, for: .normal)
                    UserDefaults.standard.set(data.tissuName, forKey: keyValue.girlandoSampleType.rawValue)
                    tissuId = Int(data.tissuId)
                }
                
                if data.breedAssocation == "" || data.breedAssocation == nil {
                    breedRegBttn.setTitle(NSLocalizedString(LocalizedStrings.girolandoAssociationStr, comment: ""), for: .normal)
                }
                else {
                    breedRegBttn.setTitle(data.breedAssocation, for: .normal)
                }
                dateBttnOutlet.setTitleColor(.black, for: .normal)
                statusOrder = false
                messageCheck = false
                let adata = fetchAllDataOrderStatusMasterGirlando(entityName: Entities.animalMasterTblEntity, ordestatus: "true", userId: userId, farmId: data.farmId!, earTag: data.earTag ?? "", barcodeTag: data.animalbarCodeTag!)
                
                if adata.count > 0{
                    let animal  = adata.object(at: 0) as! AnimalMaster
                    idAnimal = Int(animal.animalId)
                    messageCheck = true
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        let animalData1 = fetchAnimaldataValidateAnimalwithouOrderIDGirlando(entityName: Entities.animalMasterTblEntity, earTag: scanEarTagTextField.text ?? "", farmId: "", animalbarCodeTag: scanBarcodeTextfield.text ?? "", offDamId: damRegTextfield.text ?? "" , offsireId: sireRegTextfield.text ?? "", orderId: orderId, userId: userId)
        
        if animalData1.count > 1 {
            for number in 0..<(animalData1.count-1) {
                let animId = animalData1.object(at: number) as? AnimalMaster
                let idAnim = animId?.animalId
                let useriD = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                let customerId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
                deleteDataWithAdh1(entity: Entities.animalMasterTblEntity, animalId: idAnim ?? 0, userId: Int(useriD ), custmerId: Int(customerId ))
            }
        }
        let animalData = fetchAnimaldataValidateAnimalwithouOrderIDGirlando(entityName: Entities.animalMasterTblEntity, earTag: scanEarTagTextField.text ?? "", farmId: "", animalbarCodeTag: scanBarcodeTextfield.text ?? "", offDamId: damRegTextfield.text ?? "" , offsireId: sireRegTextfield.text ?? "", orderId: orderId, userId: userId)
        
        if !isautoPopulated {
            if animalData.count > 0 {
                self.view.hideToast()
                let data =  animalData.lastObject as! AnimalMaster
                if data.breedId != keyValue.girlandoNewBreedId.rawValue || data.breedName != BreedNames.girlandoBreed{
                } else {
                    barcodeflag = false
                    isautoPopulated = true
                    barAutoPopu = true
                    textFieldBackroungWhite()
                    updateOrder = true
                    let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                    animalId1 = Int(data.animalId)
                    if data.eT == "" {
                        singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                        singleBttn.layer.borderWidth = 2
                        multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                        etBttn.layer.borderColor = UIColor.gray.cgColor
                        
                        selectedBornTypeId = 1
                    }
                    barcodeView.layer.borderColor = UIColor.gray.cgColor
                    dateBttnOutlet.titleLabel!.text = ""
                    
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
                            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                                dateTextField.text = dateVale
                            } else {
                                dateBttnOutlet.setTitle(dateVale, for: .normal)
                            }
                            formatter.dateFormat = DateFormatters.MMddyyyyFormat
                        }
                        else {
                            var dateVale = ""
                            let values = data.date!.components(separatedBy: "/")
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = date + "/" + month + "/" + year
                            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                                dateTextField.text = dateVale
                            } else {
                                dateBttnOutlet.setTitle(dateVale, for: .normal)
                            }
                            formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                        }
                        self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!) ?? Date()
                        let isGreater = Date().isSmaller(than: selectedDate)
                        if isGreater  {
                            dateBttnOutlet.setTitle("", for: .normal)
                            dateTextField.text = ""
                        }
                    }
                    
                    let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.animalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                    
                    if dataFetch.count == 0 {
                        incrementalBarcodeTitleLabel.textColor = .black
                        incrementalBarcodeTitleLabel.alpha = 1
                        incrementalBarcodeCheckBox.alpha = 1
                        incrementalBarcodeButton.isEnabled = true
                    } else {
                        let orStatus = dataFetch[0] as? AnimaladdTbl
                        
                        if orStatus?.orderstatus == "true"{
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
                            incrementalBarcodeTitleLabel.alpha = 0.6
                            incrementalBarcodeCheckBox.alpha = 0.6
                            checkBarcode = false
                        }
                    }
                    
                    if data.breedId == "" {
                        breedId = keyValue.girlandoNewBreedId.rawValue
                        data.breedId = breedId
                        data.breedName = BreedNames.girlandoBreed
                    }
                    
                    sireRegTextfield.text = data.offsireId
                    damRegTextfield.text = data.offDamId
                    animalNameTextfield.text = data.animalName
                    breedRegTextfield.text = data.breedRegNumber
                    breedBtnOutlet.setTitle(data.breedName, for: .normal)
                    tissueBttnOutlet.setTitleColor(.black, for: .normal)
                    breedBtnOutlet.setTitleColor(.black, for: .normal)
                    tissueBttnOutlet.setTitle(data.tissuName, for: .normal)
                    UserDefaults.standard.set(data.tissuName, forKey: keyValue.girlandoSampleType.rawValue)
                    breedId = data.breedId!
                    let breedidd =  UserDefaults.standard.value(forKey: keyValue.breed.rawValue) as? String
                    
                    if breedidd != breedId {
                        let  aDat = fetchAnimaldata(status: Entities.animalAddTblEntity)
                        if aDat.count > 1{
                            UserDefaults.standard.set(true, forKey: keyValue.identifyStore.rawValue)
                        }
                    }
                    UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                    
                    if data.gender == "Male".localized || data.gender == "M" || data.gender == "m"{
                        self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                        genderToggleFlag = 1
                        genderString = "Male".localized
                        UserDefaults.standard.set("M", forKey: "GirlandoGender")
                    }
                    else {
                        self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                        genderToggleFlag = 0
                        genderString = "Female".localized
                        UserDefaults.standard.set("F", forKey: "GirlandoGender")
                    }
                    
                    let inheritBreed = fetchAllDataProductGirlandoBreedID(entityName: Entities.getBreedsTblEntity,breedId:breedId,pvid:4)
                    if inheritBreed.count != 0 {
                        let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                        breedId = medbreedRegArr1!.breedId ?? ""
                        UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                        breedBtnOutlet.setTitle(medbreedRegArr1?.alpha2 ?? medbreedRegArr1?.breedName, for: .normal)
                    }
                    
                    singleBttn.layer.borderColor = UIColor.gray.cgColor
                    singleBttn.layer.borderWidth = 0.5
                    let et = data.eT
                    etBtn = et!
                    etBttn.layer.borderWidth = 0.5
                    singleBttn.layer.borderWidth = 0.5
                    multipleBirthBttn.layer.borderWidth = 0.5
                    
                    if data.selectedBornTypeId == 3{
                        etBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                        etBttn.layer.borderWidth = 2
                        singleBttn.layer.borderColor = UIColor.gray.cgColor
                        multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                        selectedBornTypeId = 3
                    }
                    else if data.selectedBornTypeId == 1{
                        singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                        singleBttn.layer.borderWidth = 2
                        multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                        etBttn.layer.borderColor = UIColor.gray.cgColor
                        selectedBornTypeId = 1
                        
                    }
                    else if data.selectedBornTypeId == 2 {
                        multipleBirthBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                        multipleBirthBttn.layer.borderWidth = 2
                        singleBttn.layer.borderColor = UIColor.gray.cgColor
                        etBttn.layer.borderColor = UIColor.gray.cgColor
                        selectedBornTypeId = 2
                    }
                    else {
                        singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                        singleBttn.layer.borderWidth = 2
                        multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                        etBttn.layer.borderColor = UIColor.gray.cgColor
                        selectedBornTypeId = 1
                    }
                    
                    if data.tissuName == "" || data.tissuName == nil {
                        let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
                        self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
                        for items in self.tissueArr{
                            let tissue = items  as? GetSampleTbl
                            let checkdefault  = tissue?.isDefault
                            if checkdefault == true{
                                self.tissueBttnOutlet.setTitle(tissue?.sampleName, for: .normal)
                                UserDefaults.standard.set(tissue?.sampleName, forKey: keyValue.girlandoSampleType.rawValue)
                                self.tissuId =  Int(tissue?.sampleId ?? 4)
                            }
                        }
                    }
                    else {
                        tissueBttnOutlet.setTitle(data.tissuName, for: .normal)
                        UserDefaults.standard.set(data.tissuName, forKey: keyValue.girlandoSampleType.rawValue)
                        tissuId = Int(data.tissuId)
                    }
                    
                    if data.breedAssocation == "" || data.breedAssocation == nil {
                        breedRegBttn.setTitle(NSLocalizedString(LocalizedStrings.girolandoAssociationStr, comment: ""), for: .normal)
                    }
                    else {
                        breedRegBttn.setTitle(data.breedAssocation, for: .normal)
                    }
                    
                    textField.resignFirstResponder()
                    dateBttnOutlet.setTitleColor(.black, for: .normal)
                    statusOrder = false
                    messageCheck = false
                    let adata = fetchAllDataOrderStatusMasterGirlando(entityName: Entities.animalMasterTblEntity, ordestatus: "true", userId: userId, farmId: data.farmId!, earTag: data.earTag!, barcodeTag: data.animalbarCodeTag!)
                    
                    if adata.count > 0{
                        let animal  = adata.object(at: 0) as! AnimalMaster
                        idAnimal = Int(animal.animalId)
                        messageCheck = true
                    }
                }
            }
        }
        else{
            if scanEarTagTextField.text!.count > 0 {
                animalNameTextfield.isEnabled = true
                male_femaleBttnOutlet.isEnabled = true
                scanBarcodeTextfield.isEnabled = true
                breedBtnOutlet.isEnabled = true
                etBttn.isEnabled = true
                multipleBirthBttn.isEnabled = true
                singleBttn.isEnabled = true
                sireRegTextfield.isEnabled = true
                damRegTextfield.isEnabled = true
                textFieldBackroungWhite()
            }
            else {
                animalNameTextfield.isEnabled = false
                male_femaleBttnOutlet.isEnabled = false
                scanBarcodeTextfield.isEnabled = false
                breedBtnOutlet.isEnabled = false
                etBttn.isEnabled = false
                multipleBirthBttn.isEnabled = false
                singleBttn.isEnabled = false
                sireRegTextfield.isEnabled = false
                damRegTextfield.isEnabled = false
                textFieldBackroungGrey()
            }
        }
        
        if textField == scanBarcodeTextfield {
            scanEarTagTextField.becomeFirstResponder()
        }
        else if textField == scanEarTagTextField {
            breedRegTextfield.becomeFirstResponder()
        }
        else if textField == breedRegTextfield {
            animalNameTextfield.becomeFirstResponder()
            
        }
        else if textField == animalNameTextfield {
            sireRegTextfield.becomeFirstResponder()
            
        }
        else if textField == sireRegTextfield {
            damRegTextfield.becomeFirstResponder()
            
        }
        else if textField == sireRegTextfield {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == damRegTextfield ) {
            damRegTextfield.returnKeyType = UIReturnKeyType.done
        } else {
            scanEarTagTextField.returnKeyType = UIReturnKeyType.next
            scanBarcodeTextfield.returnKeyType = UIReturnKeyType.next
            breedRegTextfield.returnKeyType = UIReturnKeyType.next
            animalNameTextfield.returnKeyType = UIReturnKeyType.next
            sireRegTextfield.returnKeyType = UIReturnKeyType.next
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
    }
    
    func animateView (_ movement : CGFloat){
        UIView.animate(withDuration: 0.1, animations: {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement);
        })
    }
}

// MARK: - TABLEVIEW DATASOURCE AND DELEGATE
extension OrderingAnimalVCGirlando :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == importTblView {
            return importListArray.count
        }
        
        if btnTag == 10 {
            return tissueArr.count
        }
        else if btnTag == 20 {
            return breedArr.count
        }
        else {
            return breedRegArr.count
        }    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        
        if tableView == importTblView {
            let cell :ImportListCell = importTblView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ImportListCell
            cell.listNameLabel.text = importListArray[indexPath.row].listName
            cell.listNameDescLbl.text = importListArray[indexPath.row].listDesc
            return cell
        }
        
        if btnTag == 10{
            let tissue = self.tissueArr[indexPath.row]  as! GetSampleTbl
            cell.textLabel?.text = NSLocalizedString("tissue.sampleName", comment: "")
            cell.textLabel?.text = tissue.sampleName?.localized
            return cell
        }
        
        if btnTag == 20{
            let breed = breedArr[indexPath.row] as! GetBreedsTbl
            cell.textLabel?.text = breed.breedName
            return cell
        }
        
        if btnTag == 30{
            let tissue = self.breedRegArr[indexPath.row]  as! GetBreedSocieties
            cell.textLabel?.text = tissue.association
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        barcodeEnable = true
        
        if tableView == importTblView {
            let listId1 = importListArray[indexPath.row].listId
            let listName = importListArray[indexPath.row].listName
            listNameString = listName ?? ""
            listId = Int(listId1)
            return
        }
        
        if btnTag == 10  {
            let tissue = self.tissueArr[indexPath.row] as! GetSampleTbl
            tissuId = Int(tissue.sampleId)
            tissueBttnOutlet.setTitleColor(.black, for: .normal)
            tissueBttnOutlet.setTitle(tissue.sampleName?.localized, for: .normal)
            buttonbg2.removeFromSuperview()
        }
        
        if btnTag == 20  {
            let breed = self.breedArr[indexPath.row] as! GetBreedsTbl
            breedId = breed.breedId!
            breedBtnOutlet.setTitleColor(.black, for: .normal)
            breedBtnOutlet.setTitle(breed.alpha2 ?? breed.breedName, for: .normal)
            buttonbg2.removeFromSuperview()
        }
        
        if btnTag == 30  {
            let breedReg = breedRegArr[indexPath.row] as! GetBreedSocieties
            breedRegBttn.setTitleColor(.black, for: .normal)
            breedRegBttn.setTitle(breedReg.association, for: .normal)
            buttonbg2.removeFromSuperview()
        }
    }
}

// MARK: - ANIMAL MERGE PROTOCOL
extension OrderingAnimalVCGirlando : AnimalMergeProtocol{
    func refreshUI() {
        let animalCount = fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
        self.notificationLblCount.text = String(animalCount.count)
        if animalCount.count == 0 {
            self.notificationLblCount.isHidden = true
            self.countLbl.isHidden = true
            self.crossBtnOutlet.isHidden = true
            self.mergeListBtnOulet.isHidden = true
        }
        else {
            self.notificationLblCount.isHidden = false
            self.countLbl.isHidden = false
            self.crossBtnOutlet.isHidden = false
            self.mergeListBtnOulet.isHidden = false
        }
        
        let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ?? 0,providerId:pvid)
        if fetchObj.count != 0 {
            let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
            let obj = objectFetch?.listName
            let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId ?? 0)).count - 1
            
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
        else {
            mergeListBtnOulet.isHidden = true
            crossBtnOutlet.isHidden = true
        }
    }
}

// MARK: - DATALIST CART HELPER EXTENSION
private typealias DataListCartHelper = OrderingAnimalVCGirlando
extension DataListCartHelper {
    func fetchDatalistDetailbyName(listName: String) -> [DataEntryList] {
        let fetchDataEntry : [DataEntryList] = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.custmerId ?? 0),listName:listName ,productName:marketNameType.Dairy.rawValue) as! [DataEntryList]
        return fetchDataEntry
    }
    
    func checkCartanimalCount() {
        let viewAnimalArray =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid)
        if viewAnimalArray.count > 0{
            createDataList()
        }
    }
    
    func createDataList() {
        let listName = orderingDataListViewModel.makeListName(custmerId: custmerId ?? 0 ,providerID: pvid)
        if listName != "" {
            var animalID1 = UserDefaults.standard.integer(forKey: keyValue.listId.rawValue)
            if animalID1 == 0 {
                animalID1 = animalID1 + 1
                UserDefaults.standard.set(animalID1, forKey: keyValue.listId.rawValue)
                
            } else {
                animalID1 = animalID1 + 1
                UserDefaults.standard.set(animalID1, forKey: keyValue.listId.rawValue)
            }
            self.hideIndicator()
            
            if self.pvid == 1 || self.pvid == 2 || self.pvid == 3 || self.pvid == 4 || self.pvid == 8 || self.pvid == 10 || self.pvid == 11 || self.pvid == 12{
                
                let fetchDatEntry = fetchDatalistDetailbyName(listName: listName)
                
                if fetchDatEntry.count == 0 {
                    saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(self.custmerId ?? 0 ),listDesc: "cart",listId: Int64(animalID1),listName: listName ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: self.pvid, productType: "", productName: marketNameType.Dairy.rawValue)
                    
                    let animalData  = fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid) as! [AnimaladdTbl]
                    for animalDetail in animalData {
                        let fetchDataUpdate = checkAnimalDataAccOfficalFarmid_ListID(entityName: Entities.dataEntryAnimalAddTbl,farmId:animalDetail.farmId ?? "",anmalTag:animalDetail.animalTag ?? "",custmerId :custmerId ?? 0 , listId: animalID1,providerID: pvid)
                        
                        if fetchDataUpdate.count == 0 {
                            saveAnimalinDataOrderingAnimal(listID: Int64(animalID1), animalDetails: animalDetail, animalID:animalID1)
                        }
                    }
                    
                } else {
                    let listId = fetchDatEntry[0].listId
                    let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderId:orderId,orderStatus:"false",listid:Int64(fetchDatEntry[0].listId), custmerId: Int64(custmerId ?? 0 ), providerId: pvid)
                    if fetchData11.count != 0 {
                        for i in 0...fetchData11.count - 1 {
                            let animalVal = fetchData11.object(at: i) as! DataEntryAnimaladdTbl
                            deleteAnimalDatafromList(entityName: Entities.dataEntryAnimalAddTbl, Int(animalVal.animalId), listID: Int(animalVal.listId))
                        }
                    }
                    
                    let animalData  = fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid)  as! [AnimaladdTbl]
                    
                    for animalDetail in animalData {
                        saveAnimalinDataOrderingAnimal(listID: Int64(listId), animalDetails: animalDetail, animalID:animalID1)
                    }
                }
            }
        }
    }
    
    func saveAnimalinDataOrderingAnimal(listID:Int64, animalDetails:AnimaladdTbl,animalID:Int) {
        saveAnimaldataGirlando(entity: Entities.dataEntryAnimalAddTbl,
                               earTag: animalDetails.earTag ?? "",
                               barCodetag: animalDetails.animalbarCodeTag ?? "",
                               date: animalDetails.date ?? "",
                               damId: animalDetails.offDamId ?? "" ,
                               sireId: animalDetails.offsireId ?? "" ,
                               gender: animalDetails.gender ?? "" ,
                               update: animalDetails.status ?? "",
                               breedRegNumber: animalDetails.breedRegNumber ?? "" ,
                               tissuName: animalDetails.tissuName ?? "",
                               breedName: animalDetails.breedName ?? "" ,
                               et: animalDetails.eT ?? "",
                               farmId: animalDetails.farmId ?? "" ,
                               orderId: 1,
                               orderSataus: "false" ,
                               breedId: animalDetails.breedId ?? "",
                               isSync: animalDetails.isSync ?? "",
                               providerId: Int(pvid),
                               tissuId: Int(animalDetails.tissuId),
                               sireIDAU: animalDetails.sireIDAU ?? "",
                               animalName: animalDetails.animalName ?? "" ,
                               userId: Int(userId),
                               udid: animalDetails.udid ?? "",
                               animalId: Int(animalDetails.animalId),
                               selectedBornTypeId: Int(animalDetails.selectedBornTypeId),
                               breedAssocation: animalDetails.breedAssocation ?? "" ,
                               custId: Int(custmerId ?? 0),
                               listId: Int64(listID),
                               serverAnimalId: "",
                               girlandoID:animalDetails.girlandoID ?? "")
        
    }
}

// MARK: - CHECK USER LIST AND AUTOSAVE PRODUCTS
private typealias AutoImportDatalistHelper = OrderingAnimalVCGirlando
extension AutoImportDatalistHelper {
    func checkUserDataListName(){
        let orderingDataList = OrderingDataListViewModel()
        let listName = orderingDataList.makeListName(custmerId: self.custmerId ?? 0, providerID: pvid)
        let fetchDatEntry : [DataEntryList] = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.custmerId ?? 0),listName:listName ,productName:marketNameType.Dairy.rawValue) as! [DataEntryList]
        if fetchDatEntry.count > 0{
            crossBtnOutlet.isHidden = true
            let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderId:orderId,orderStatus:"false",listid:Int64(fetchDatEntry.first?.listId ?? 0), custmerId: Int64(custmerId ?? 0), providerId: pvid)
            if fetchData11.count != 0 {
                for i in 0...fetchData11.count - 1 {
                    let animalDetails = fetchData11.object(at: i) as! DataEntryAnimaladdTbl
                    
                    saveAnimaldataGirlando(entity: Entities.animalAddTblEntity,
                                           earTag: animalDetails.earTag ?? "",
                                           barCodetag: animalDetails.animalbarCodeTag ?? "",
                                           date: animalDetails.date ?? "",
                                           damId: animalDetails.offDamId ?? "" ,
                                           sireId: animalDetails.offsireId ?? "" ,
                                           gender: animalDetails.gender ?? "" ,
                                           update: animalDetails.status ?? "",
                                           breedRegNumber: animalDetails.breedRegNumber ?? "" ,
                                           tissuName: animalDetails.tissuName ?? "",
                                           breedName: animalDetails.breedName ?? "" ,
                                           et: animalDetails.eT ?? "",
                                           farmId: animalDetails.farmId ?? "" ,
                                           orderId: 1,
                                           orderSataus: "false" ,
                                           breedId: animalDetails.breedId ?? "",
                                           isSync: animalDetails.isSync ?? "",
                                           providerId: Int(pvid),
                                           tissuId: Int(animalDetails.tissuId),
                                           sireIDAU: animalDetails.sireIDAU ?? "",
                                           animalName: animalDetails.animalName ?? "" ,
                                           userId: Int(1),
                                           udid: animalDetails.udid ?? "",
                                           animalId: Int(animalDetails.animalId),
                                           selectedBornTypeId: Int(animalDetails.selectedBornTypeId),
                                           breedAssocation: animalDetails.breedAssocation ?? "" ,
                                           custId: Int(custmerId ?? 0),
                                           listId: 0,
                                           serverAnimalId: "",
                                           girlandoID:animalDetails.girlandoID ?? "")
                    
                    UserDefaults.standard.setValue(animalDetails.tissuName ?? "", forKey: keyValue.dataEntryGirlandoSampleType.rawValue)
                    UserDefaults.standard.setValue(animalDetails.tissuName ?? "", forKey: keyValue.dataEntryGirlandoSampleTypeClear.rawValue)
                    tissueBttnOutlet.setTitle(animalDetails.tissuName?.localized ?? "", for: .normal)
                    autoSaveProductandsubProduct(dataGet: animalDetails)
                }
            }
        }
    }
    
    func autoSaveProductandsubProduct(dataGet:DataEntryAnimaladdTbl){
        let animalData = fetchAnimaldataDairy(entityName: Entities.animalAddTblEntity, animalTag:Int(dataGet.animalId),orderId:orderId,userId:userId)
        let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: Int(dataGet.providerId), breedId: dataGet.breedId ?? "" )
        
        for k in 0 ..< animalData.count{
            let animalId = animalData[k] as! AnimaladdTbl
            for i in 0 ..< product.count{
                let data = product[i] as! GetProductTbl
                if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                    let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:Int(animalId.orderId ), customerID: customerId)
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
                        let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:self.orderId, customerID: customerId )
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
        }
    }
}

// MARK: - QR SCANNER PROTOCOL
extension OrderingAnimalVCGirlando: QrScannerProtocol {
    func qrCodeScannedResult(_ qrValue: String) {
        scanBarcodeTextfield.text = qrValue
        textFieldBackroungWhite()
    }
}

// MARK: - SCANNED OCR PROTOCOL
extension OrderingAnimalVCGirlando: scannedOCRProtocol {
    func ocrDetected(_ scannedResult: String) {
        scanEarTagTextField.text = scannedResult
        scanEarTagTextField.becomeFirstResponder()
    }
}

