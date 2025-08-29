//
//  DEOAnimalVCGirlandoExtension.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 19/03/25.
//

import Foundation
//MARK: EXTENSION OFFLINE CUSTOM VIEW
extension DEOAnimalVCGirlando:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }}

//MARK: EXTENSION SIDEMENU UI AND RFID
extension DEOAnimalVCGirlando : SideMenuUI,RFID{
    func rfidCode(rfid: String) {
        
    }
    
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}

//MARK: TEXTFIELD DELEGATE EXTENSION
extension DEOAnimalVCGirlando :UITextFieldDelegate  {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        if barAutoPopu == false {
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
                if textField == scanEarTagTextField{
                    if scanEarTagTextField.text!.count != 1 {
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
                        if scanBarcodeTextfield.text!.count != 1 {
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
            
            let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.animalMasterTblEntity, animalId: idAnimal, customerID: custmerId!)
            if animalFetch.count > 0{
                statusOrder = true
            }
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryAnimalAddTbl, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            if animalDataMaster.count > 0 {
                msgUpatedd = true
                barcodeflag = true
            }
            barcodeflag = true
            if isautoPopulated == true {
                let animalData = fetchAnimaldataValidateAnimalTagGirlandoDataEntry(entityName: Entities.dataEntryAnimalAddTbl, earTag: scanEarTagTextField.text ?? "", listId: listIdGet, userId: userId, custmerId: custmerId ?? 0)
                
                
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
            let ACCEPTABLE_CHARACTERS = LocalizedStrings.acceptableChrString
            let check  = ACCEPTABLE_CHARACTERS.contains(string)
            if check == false {
                return false
            }
        }
        
        if textField == scanEarTagTextField {
            let ACCEPTABLE_CHARACTERS = LocalizedStrings.earTagRegex
            let check  = ACCEPTABLE_CHARACTERS.contains(string)
            if check == false {
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
            return  LocalizedStrings.invalidFormatStr
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == dateTextField {
            if dateTextField.text!.count == 0{
                dateBtnView.layer.borderColor = UIColor.gray.cgColor
                dateBtnView.layer.borderWidth = 0.5
            }  else {
                print(dateTextField.text as Any)
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
                    
                } else {
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
                deleteDataWithAdh1(entity: Entities.animalMasterTblEntity, animalId: idAnim ?? 0, userId: Int(useriD), custmerId: Int(customerId ))
            }
        }
        
        let animalData = fetchAnimaldataValidateAnimalwithouOrderIDGirlando(entityName: Entities.animalMasterTblEntity, earTag: scanEarTagTextField.text ?? "", farmId: "", animalbarCodeTag: scanBarcodeTextfield.text ?? "", offDamId: damRegTextfield.text ?? "" , offsireId: sireRegTextfield.text ?? "", orderId: orderId, userId: userId)
        
        if isautoPopulated == false {
            if animalData.count > 0 {
                self.view.hideToast()
                let data =  animalData.lastObject as! AnimalMaster
                if data.breedId != keyValue.girlandoNewBreedId.rawValue || data.breedName != BreedNames.girlandoBreed{
                    return
                }
                barcodeflag = false
                isautoPopulated = true
                barAutoPopu = true
                textFieldBackroungWhite()
                updateOrder = true
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                animalId1 = Int(data.animalId)
                if data.eT == "" {
                    selectedBornTypeId = 1
                    singleBttn.layer.borderColor = UIColor.clear.cgColor
                   // etBttn.layer.borderWidth = 2
                    etBttn.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
                    multipleBirthBttn.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
                    singleBttn.backgroundColor = UIColor(red: 255/255, green: 96/255, blue: 6/255, alpha: 1)
                    singleBttn.setTitleColor(UIColor.white, for: .normal)
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
                }
                sireRegTextfield.text = data.offsireId
                damRegTextfield.text = data.offDamId
                animalNameTextfield.text = data.animalName
                breedRegTextfield.text = data.breedRegNumber
                tissueBttnOutlet.setTitleColor(.black, for: .normal)
                breedBtnOutlet.setTitleColor(.black, for: .normal)
                
                let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.dataEntryAnimalAddTbl,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                
                if dataFetch.count == 0 {
                    incrementalBarcodeTitleLabel.textColor = .black
                    incrementalBarcodeTitleLabel.alpha = 1
                    incrementalBarcodeCheckBox.alpha = 1
                    incrementalBarcodeButton.isEnabled = true
                }
                else {
                    let orStatus = dataFetch[0] as? DataEntryAnimaladdTbl
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
                    let  aDat = fetchAnimaldata(status: Entities.dataEntryAnimalAddTbl)
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
                
                if data.gender == ButtonTitles.maleText.localized || data.gender == "M" || data.gender == "m"{
              //      self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                    male_femaleBttnOutlet.setTitle("Male", for: .normal)
                    genderToggleFlag = 1
                    genderString = ButtonTitles.maleText.localized
                    
                } else {
                   // self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    male_femaleBttnOutlet.setTitle("Female", for: .normal)
                    genderToggleFlag = 0
                    genderString = ButtonTitles.femaleText.localized
                    
                }
//                singleBttn.layer.borderColor = UIColor.gray.cgColor
//                singleBttn.layer.borderWidth = 0.5
                let et = data.eT
                etBtn = et!
//                etBttn.layer.borderWidth = 0.5
//                singleBttn.layer.borderWidth = 0.5
//                multipleBirthBttn.layer.borderWidth = 0.5
                
                if data.selectedBornTypeId == 3 {
//                    etBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
//                    etBttn.layer.borderWidth = 2
//                    singleBttn.layer.borderColor = UIColor.gray.cgColor
//                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
//                    selectedBornTypeId = 3
                    etBttn.layer.borderColor = UIColor.clear.cgColor
                   // etBttn.layer.borderWidth = 2
                    singleBttn.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
                    multipleBirthBttn.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
                    selectedBornTypeId = 3
                    etBttn.backgroundColor = UIColor(red: 255/255, green: 96/255, blue: 6/255, alpha: 1)
                    etBttn.setTitleColor(UIColor.white, for: .normal)
                }
                else if data.selectedBornTypeId == 1{
//                    singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
//                    singleBttn.layer.borderWidth = 2
//                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
//                    etBttn.layer.borderColor = UIColor.gray.cgColor
//                    selectedBornTypeId = 1
                    singleBttn.layer.borderColor = UIColor.clear.cgColor
                   // etBttn.layer.borderWidth = 2
                    etBttn.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
                    multipleBirthBttn.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
                    selectedBornTypeId = 1
                    singleBttn.backgroundColor = UIColor(red: 255/255, green: 96/255, blue: 6/255, alpha: 1)
                    singleBttn.setTitleColor(UIColor.white, for: .normal)
                }
                else if data.selectedBornTypeId == 2{
                    selectedBornTypeId = 2
                    multipleBirthBttn.layer.borderColor = UIColor.clear.cgColor
                   // etBttn.layer.borderWidth = 2
                    etBttn.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
                    singleBttn.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
                    multipleBirthBttn.backgroundColor = UIColor(red: 255/255, green: 96/255, blue: 6/255, alpha: 1)
                    multipleBirthBttn.setTitleColor(UIColor.white, for: .normal)
                }
                else {
                    singleBttn.layer.borderColor = UIColor.clear.cgColor
                   // etBttn.layer.borderWidth = 2
                    etBttn.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
                    multipleBirthBttn.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
                    selectedBornTypeId = 1
                    singleBttn.backgroundColor = UIColor(red: 255/255, green: 96/255, blue: 6/255, alpha: 1)
                    singleBttn.setTitleColor(UIColor.white, for: .normal)
                }
                
                if data.tissuName == "" || data.tissuName == nil {
                    self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue))
                    for items in self.tissueArr
                    {
                        let tissue = items  as? GetSampleTbl
                        let checkdefault  = tissue?.isDefault
                        
                        if checkdefault == true
                        {
                            self.tissueBttnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
                            self.tissuId =  Int(tissue?.sampleId ?? 4)
                            UserDefaults.standard.set(tissue?.sampleName, forKey: keyValue.dataEntryGirlandoSampleType.rawValue)
                        }
                    }
                }
                else {
                    tissueBttnOutlet.setTitle(data.tissuName?.localized, for: .normal)
                    UserDefaults.standard.set(data.tissuName, forKey: keyValue.dataEntryGirlandoSampleType.rawValue)
                    tissuId = Int(data.tissuId)
                }
                
                if data.breedAssocation == "" || data.breedAssocation == nil {
                    breedRegBttn.setTitle(LocalizedStrings.girolandoAssociationStr, for: .normal)
                } else {
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
        
        if isautoPopulated == false {
            if animalData.count > 0 {
                self.view.hideToast()
                let data =  animalData.lastObject as! AnimalMaster
                if data.breedId != keyValue.girlandoNewBreedId.rawValue || data.breedName != BreedNames.girlandoBreed{
                    
                }
                else {
                    barcodeflag = false
                    isautoPopulated = true
                    barAutoPopu = true
                    textFieldBackroungWhite()
                    updateOrder = true
                    let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                    animalId1 = Int(data.animalId)
                    if data.eT == "" {
                        singleBttn.layer.borderColor = UIColor.clear.cgColor
                       // etBttn.layer.borderWidth = 2
                        etBttn.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
                        multipleBirthBttn.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
                        selectedBornTypeId = 1
                        singleBttn.backgroundColor = UIColor(red: 255/255, green: 96/255, blue: 6/255, alpha: 1)
                        singleBttn.setTitleColor(UIColor.white, for: .normal)                    }
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
                        if isGreater == true {
                            dateBttnOutlet.setTitle("", for: .normal)
                            dateTextField.text = ""
                        }
                    }
                    
                    let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.dataEntryAnimalAddTbl,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                    
                    if dataFetch.count == 0 {
                        incrementalBarcodeTitleLabel.textColor = .black
                        incrementalBarcodeTitleLabel.alpha = 1
                        incrementalBarcodeCheckBox.alpha = 1
                        incrementalBarcodeButton.isEnabled = true
                    }
                    else {
                        let orStatus = dataFetch[0] as? DataEntryAnimaladdTbl
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
                    tissueBttnOutlet.setTitle(data.tissuName?.localized, for: .normal)
                    UserDefaults.standard.set(data.tissuName, forKey: keyValue.dataEntryGirlandoSampleType.rawValue)
                    breedId = data.breedId!
                    let breedidd =  UserDefaults.standard.value(forKey: keyValue.breed.rawValue) as? String
                    if breedidd != breedId {
                        let  aDat = fetchAnimaldata(status: Entities.dataEntryAnimalAddTbl)
                        if aDat.count > 1{
                            UserDefaults.standard.set(true, forKey: keyValue.identifyStore.rawValue)
                        }
                    }
                    UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                    
                    if data.gender == ButtonTitles.maleText.localized || data.gender == "M" || data.gender == "m"{
                   //     self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                        male_femaleBttnOutlet.setTitle("Male", for: .normal)
                        genderToggleFlag = 1
                        genderString = ButtonTitles.maleText.localized
                    }
                    else {
                       // self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                        male_femaleBttnOutlet.setTitle("Female", for: .normal)
                        genderToggleFlag = 0
                        genderString = ButtonTitles.femaleText.localized
                    }
                    
                    let inheritBreed = fetchAllDataProductGirlandoBreedID(entityName: Entities.getBreedsTblEntity,breedId:breedId,pvid:4)
                    if inheritBreed.count != 0 {
                        let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                        breedId = medbreedRegArr1!.breedId ?? ""
                        UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                        breedBtnOutlet.setTitle(medbreedRegArr1?.alpha2 ?? medbreedRegArr1?.breedName, for: .normal)
                    }
                    
//                    singleBttn.layer.borderColor = UIColor.gray.cgColor
//                    singleBttn.layer.borderWidth = 0.5
                    let et = data.eT
                    etBtn = et!
//                    etBttn.layer.borderWidth = 0.5
//                    singleBttn.layer.borderWidth = 0.5
//                    multipleBirthBttn.layer.borderWidth = 0.5
                    
                    if data.selectedBornTypeId == 3 {
    //                    etBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
    //                    etBttn.layer.borderWidth = 2
    //                    singleBttn.layer.borderColor = UIColor.gray.cgColor
    //                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
    //                    selectedBornTypeId = 3
                        etBttn.layer.borderColor = UIColor.clear.cgColor
                       // etBttn.layer.borderWidth = 2
                        singleBttn.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
                        multipleBirthBttn.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
                        selectedBornTypeId = 3
                        etBttn.backgroundColor = UIColor(red: 255/255, green: 96/255, blue: 6/255, alpha: 1)
                        etBttn.setTitleColor(UIColor.white, for: .normal)
                    }
                    else if data.selectedBornTypeId == 1{
    //                    singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
    //                    singleBttn.layer.borderWidth = 2
    //                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
    //                    etBttn.layer.borderColor = UIColor.gray.cgColor
    //                    selectedBornTypeId = 1
                        singleBttn.layer.borderColor = UIColor.clear.cgColor
                       // etBttn.layer.borderWidth = 2
                        etBttn.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
                        multipleBirthBttn.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
                        selectedBornTypeId = 1
                        singleBttn.backgroundColor = UIColor(red: 255/255, green: 96/255, blue: 6/255, alpha: 1)
                        singleBttn.setTitleColor(UIColor.white, for: .normal)
                    }
                    else if data.selectedBornTypeId == 2{
                        selectedBornTypeId = 2
                        multipleBirthBttn.layer.borderColor = UIColor.clear.cgColor
                       // etBttn.layer.borderWidth = 2
                        etBttn.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
                        singleBttn.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
                        multipleBirthBttn.backgroundColor = UIColor(red: 255/255, green: 96/255, blue: 6/255, alpha: 1)
                        multipleBirthBttn.setTitleColor(UIColor.white, for: .normal)
                    }
                    else {
                        singleBttn.layer.borderColor = UIColor.clear.cgColor
                       // etBttn.layer.borderWidth = 2
                        etBttn.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
                        multipleBirthBttn.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
                        selectedBornTypeId = 1
                        singleBttn.backgroundColor = UIColor(red: 255/255, green: 96/255, blue: 6/255, alpha: 1)
                        singleBttn.setTitleColor(UIColor.white, for: .normal)
                    }
                    
                    if data.tissuName == "" || data.tissuName == nil {
                        self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue))
                        for items in self.tissueArr
                        {
                            let tissue = items  as? GetSampleTbl
                            let checkdefault  = tissue?.isDefault
                            if checkdefault == true
                            {
                                self.tissueBttnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
                                self.tissuId =  Int(tissue?.sampleId ?? 4)
                                UserDefaults.standard.set(tissue?.sampleName, forKey: keyValue.dataEntryGirlandoSampleType.rawValue)
                            }
                        }
                    }
                    else {
                        tissueBttnOutlet.setTitle(data.tissuName?.localized, for: .normal)
                        UserDefaults.standard.set(data.tissuName, forKey: keyValue.dataEntryGirlandoSampleType.rawValue)
                        tissuId = Int(data.tissuId)
                    }
                    
                    if data.breedAssocation == "" || data.breedAssocation == nil {
                        breedRegBttn.setTitle(LocalizedStrings.girolandoAssociationStr, for: .normal)
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
                
            } else {
                animalNameTextfield.isEnabled = false
                male_femaleBttnOutlet.isEnabled = false
                scanBarcodeTextfield.isEnabled = false
                breedBtnOutlet.isEnabled = false
                etBttn.isEnabled = false
                multipleBirthBttn.isEnabled = false
                singleBttn.isEnabled = false
                sireRegTextfield.isEnabled = false
                damRegTextfield.isEnabled = false
            }
        }
        
        if textField == scanEarTagTextField {
            scanBarcodeTextfield.becomeFirstResponder()
        } else if  textField == scanBarcodeTextfield {
            breedRegTextfield.becomeFirstResponder()
        } else if textField == breedRegTextfield {
            
            animalNameTextfield.becomeFirstResponder()
            
        } else if textField == animalNameTextfield {
            sireRegTextfield.becomeFirstResponder()
            
        } else if textField == sireRegTextfield {
            damRegTextfield.becomeFirstResponder()
            
        } else if textField == sireRegTextfield {
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
        
        if textField == scanBarcodeTextfield {
            viewsArray = [earTagView, sampleTypeView, genderView, breedTypeView, dateBtnView, breedRegView, associationTypeView, animalNameView, sireRegView, damRegView]
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor)
            self.barcodeView.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
        }
        
        if textField == scanEarTagTextField {
            viewsArray = [barcodeView, sampleTypeView, genderView, breedTypeView, dateBtnView, breedRegView, associationTypeView, animalNameView, sireRegView, damRegView]
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor)
            self.earTagView.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
        }
        
        if textField == breedRegTextfield {
            viewsArray = [barcodeView, sampleTypeView, genderView, breedTypeView, dateBtnView, earTagView, associationTypeView, animalNameView, sireRegView, damRegView]
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor)
            self.breedRegView.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
        }
        
//        if textField == girlandoNoTextField {
//            viewsArray = [barcodeView, sampleTypeView, genderView, breedTypeView, dateBtnView, earTagView, breedRegView, animalNameView, sireRegView, damRegView]
//            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor)
//            self.associationTypeView.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
//        }
        
        if textField == animalNameTextfield {
            viewsArray = [barcodeView, sampleTypeView, genderView, breedTypeView, dateBtnView, earTagView, breedRegView, associationTypeView, sireRegView, damRegView]
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor)
            self.animalNameView.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
        }
        
        if textField == sireRegTextfield {
            viewsArray = [barcodeView, sampleTypeView, genderView, breedTypeView, dateBtnView, earTagView, breedRegView, associationTypeView, animalNameView, damRegView]
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor)
            self.sireRegView.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
        }
        
        if textField == damRegTextfield {
            viewsArray = [barcodeView, sampleTypeView, genderView, breedTypeView, dateBtnView, earTagView, breedRegView, associationTypeView, animalNameView, sireRegView]
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor)
            self.damRegView.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
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
    
    func animateView (_ movement : CGFloat){
        UIView.animate(withDuration: 0.1, animations: {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement);
        })
    }
}

//MARK: TABLEVIEW DATA SOURCE AND DELEGATE
extension DEOAnimalVCGirlando :UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if btnTag == 10 {
            return tissueArr.count
        }
        else if btnTag == 20{
            return breedArr.count
        }
        else if btnTag == 50 {
            return self.genderArray.count
        }
        else{
            return breedRegArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.font = UIFont.systemFont(ofSize: 19)
        if btnTag == 10{
            let tissue = self.tissueArr[indexPath.row]  as! GetSampleTbl
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
        if btnTag == 50 {
           let gender = self.genderArray[indexPath.row] as! String
           cell.textLabel?.text = gender
           return cell
           
       }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        barcodeEnable = true
        self.sampleTypeView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
        self.genderView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
        self.dateBtnView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
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
        
        if btnTag == 50  {
            let gender = self.genderArray[indexPath.row]
            genderString = gender
            male_femaleBttnOutlet.titleLabel?.font = male_femaleBttnOutlet.titleLabel?.font.withSize(20)
            male_femaleBttnOutlet.setTitleColor(.black, for: .normal)
            male_femaleBttnOutlet.setTitle(gender, for: .normal)
            buttonbg2.removeFromSuperview()
            
        }
    }
}

//MARK: SCANNED OCR PROTOCOL EXTENSION
extension DEOAnimalVCGirlando: scannedOCRProtocol {
    func ocrDetected(_ scannedResult: String) {
        scanEarTagTextField.text = scannedResult
        scanEarTagTextField.becomeFirstResponder()
    }
}

//MARK: QR SCANNER PROTOCOL EXTENSION
extension DEOAnimalVCGirlando: QrScannerProtocol {
    func qrCodeScannedResult(_ qrValue: String) {
        scanBarcodeTextfield.text = qrValue
        scanBarcodeTextfield.becomeFirstResponder()
        
    }
}


