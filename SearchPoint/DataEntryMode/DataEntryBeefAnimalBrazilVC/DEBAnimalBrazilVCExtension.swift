//
//  DEBAnimalBrazilVCExtension.swift
//  SearchPoint
//
//  Created by Mobile Programming on 26/02/24.
//

import Foundation

// MARK: - SIDE MENU UI AND OBJECT PICK CART SCREEN
extension DataEntryBeefAnimalBrazilVC : SideMenuUI,objectPickCartScreen{
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
            msgUpatedd = false
        }}
    
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}

// MARK: - QR SCANNER PROTOCOL
extension DataEntryBeefAnimalBrazilVC: QrScannerProtocol {
    func qrCodeScannedResult(_ qrValue: String) {
        if isGenotypeOnlyAdded == true {
            genotypeScanBarcodeTextField.text = qrValue
            GenotypebyDefaultbackroundWhite()
        }
        else{
            scanBarcodeTextfield.text = qrValue
            othersByDefaultBackroundWhite()
        }
    }
    
}

// MARK: - TEXTFIELD DELEGATE
extension DataEntryBeefAnimalBrazilVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if isGenotypeOnlyAdded == false {
            if (textField == animalTextfield ) {
                animalTextfield.returnKeyType = UIReturnKeyType.done
            }
            else {
                serieTextfield.returnKeyType = UIReturnKeyType.next
                scanBarcodeTextfield.returnKeyType = UIReturnKeyType.next
                rGNTextfield.returnKeyType = UIReturnKeyType.next
                rGDTextfield.returnKeyType = UIReturnKeyType.next
            }
            
            if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
                if UserDefaults.standard.value(forKey: keyValue.barcodeIncremental.rawValue) as? String != scanBarcodeTextfield.text {
                }
                else {
                    if let lastSavedBarCode = UserDefaults.standard.value(forKey: keyValue.barcodeIncremental.rawValue) as? String {
                        scanBarcodeTextfield.text = isBarCodeEndsWithNumber_GetIncrementedBarCode(lastSavedBarCode).incrementedBarCode
                        if scanBarcodeTextfield.text?.isEmpty == false {
                            othersByDefaultBackroundWhite()
                        }
                    }}
            }
        }
        else {
            if (textField == genotypeAnimalNameTextfield ) {
                genotypeAnimalNameTextfield.returnKeyType = UIReturnKeyType.done
            } else {
                genotypeScanBarcodeTextField.returnKeyType = UIReturnKeyType.next
                genotypeSerieTextfield.returnKeyType = UIReturnKeyType.next
                genotypeRgnTextfield.returnKeyType = UIReturnKeyType.next
                genotypeRgdTextfield.returnKeyType = UIReturnKeyType.next
                
            }
            if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
                if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
                    if UserDefaults.standard.value(forKey: keyValue.barcodeIncremental.rawValue) as? String != genotypeScanBarcodeTextField.text {
                    } else {
                        if let lastSavedBarCode = UserDefaults.standard.value(forKey: keyValue.barcodeIncremental.rawValue) as? String {
                            genotypeScanBarcodeTextField.text = isBarCodeEndsWithNumber_GetIncrementedBarCode(lastSavedBarCode).incrementedBarCode
                            if genotypeScanBarcodeTextField.text?.isEmpty == false {
                                self.GenotypebyDefaultbackroundWhite()
                            }
                        }
                    }
                }}}
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == genotypeDateTextField {
            if genotypeDateTextField.text!.count != 0{
                if genotypeDateTextField.text?.count == 10 {
                    let validate = isValidDate(dateString: genotypeDateTextField.text ?? "")
                    print(validate)
                    if validate == LocalizedStrings.correctFormatStr {
                        genotypeDOBBttn.layer.borderColor = UIColor.gray.cgColor
                        genotypeDOBBttn.layer.borderWidth = 0.5
                        validateDateFlag = true
                    }
                    else {
                        genotypeDOBBttn.layer.borderColor = UIColor.red.cgColor
                        validateDateFlag = false
                    }
                }
                else {
                    genotypeDOBBttn.layer.borderColor = UIColor.red.cgColor
                    validateDateFlag = false
                }
            }
        }
        
        if textField == dateTextField {
            if dateTextField.text!.count == 0{
                
            }
            else{
                if dateTextField.text?.count == 10 {
                    let validate = isValidDate(dateString: dateTextField.text ?? "")
                    print(validate)
                    if validate == LocalizedStrings.correctFormatStr {
                        dobView.layer.borderColor = UIColor.gray.cgColor
                        dobView.layer.borderWidth = 0.5
                        validateDateFlag = true
                    } else {
                        dobView.layer.borderColor = UIColor.red.cgColor
                        validateDateFlag = false
                    }
                }
                else {
                    dobView.layer.borderColor = UIColor.red.cgColor
                    validateDateFlag = false
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == self.genotypeScanBarcodeTextField) {
            if genotypeScanBarcodeTextField.text == ""{
                genotypeScanBarcodeView.layer.borderColor = UIColor.red.cgColor
            }
            else {
                genotypeScanBarcodeView.layer.borderColor = UIColor.gray.cgColor
                self.genotypeSerieTextfield.becomeFirstResponder()
            }
            self.genotypeSerieTextfield.becomeFirstResponder()
        }
        else if (textField == self.genotypeSerieTextfield) {
            requiredflag = 1
            if genotypeSerieTextfield.text == ""{
                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                    if priorityBreeingBtnOutlet.titleLabel?.text  == ButtonTitles.ciadeMelhoramentoText{
                        requiredflag = 1
                    }
                    else{
                        requiredflag = 0
                    }
                }
                else{
                    if isautoPopulated == true{
                        requiredflag = 1
                    }
                    else{
                        requiredflag = 1
                    }
                }
                if requiredflag == 1{
                    genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                }
            }
            else {
                if requiredflag == 1{
                    genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                }
            }
            self.genotypeRgnTextfield.becomeFirstResponder()
        }
        
        else if (textField == self.genotypeRgnTextfield) {
            requiredflag = 1
            if genotypeRgnTextfield.text == ""{
                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                    if priorityBreeingBtnOutlet.titleLabel?.text  == ButtonTitles.ciadeMelhoramentoText{
                        requiredflag = 1
                    }
                    else{
                        requiredflag = 0
                    }
                }
                else{
                    if isautoPopulated == true{
                        requiredflag = 1
                    }
                    else{
                        requiredflag = 1
                    }
                }
                if requiredflag == 1{
                    genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                }
            }
            else {
                if requiredflag == 1{
                    genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                }
            }
            self.genotypeRgdTextfield.becomeFirstResponder()
        }
        
        else if (textField == self.genotypeRgdTextfield) {
            requiredflag = 1
            if genotypeRgdTextfield.text == ""{
                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                    if priorityBreeingBtnOutlet.titleLabel?.text  == ButtonTitles.ciadeMelhoramentoText{
                        requiredflag = 1
                    }else{
                        requiredflag = 0
                    }
                }
                else{
                    if isautoPopulated == true{
                        requiredflag = 1
                    }
                    else{
                        requiredflag = 1
                    }
                }
                if requiredflag == 1{
                    genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                }
            }
            else {
                if requiredflag == 1{
                    genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                }
            }
            self.genotypeAnimalNameTextfield.becomeFirstResponder()
        }
        
        else if (textField == self.genotypeAnimalNameTextfield) {
            self.genotypeAnimalNameTextfield.resignFirstResponder()
            
        }
        if scanBarcodeTextfield.text!.count > 0 {
            othersByDefaultBackroundWhite()
        }
        
        if (textField == self.scanBarcodeTextfield) {
            if scanBarcodeTextfield.text == ""{
                barcodeView.layer.borderColor = UIColor.red.cgColor
            }
            else {
                barcodeView.layer.borderColor = UIColor.gray.cgColor
                self.genotypeSerieTextfield.becomeFirstResponder()
            }
            self.serieTextfield.becomeFirstResponder()
        }
        
        else if (textField == self.serieTextfield) {
            requiredflag = 1
            if serieTextfield.text == ""{
                if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                    requiredflag = 0
                }
                else{
                    if isautoPopulated == true{
                        requiredflag = 1
                    }
                    else{
                        requiredflag = 1
                    }
                }
                if requiredflag == 1{
                    serieTextfield.layer.borderColor = UIColor.gray.cgColor
                    rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                    rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    serieTextfield.layer.borderColor = UIColor.red.cgColor
                    rGNTextfield.layer.borderColor = UIColor.red.cgColor
                    rGDTextfield.layer.borderColor = UIColor.red.cgColor
                }
                
            } else {
                rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                serieTextfield.layer.borderColor = UIColor.gray.cgColor
                rGDTextfield.layer.borderColor = UIColor.gray.cgColor
            }
            self.rGNTextfield.becomeFirstResponder()
        }
        
        else if (textField == self.rGNTextfield) {
            requiredflag = 1
            if rGNTextfield.text == ""{
                if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                    requiredflag = 0
                }
                else{
                    if isautoPopulated == true{
                        requiredflag = 1
                    }
                    else{
                        requiredflag = 1
                    }
                }
                if requiredflag == 1{
                    serieTextfield.layer.borderColor = UIColor.gray.cgColor
                    rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                    rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    serieTextfield.layer.borderColor = UIColor.red.cgColor
                    rGNTextfield.layer.borderColor = UIColor.red.cgColor
                    rGDTextfield.layer.borderColor = UIColor.red.cgColor
                }
                
            } else {
                rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                serieTextfield.layer.borderColor = UIColor.gray.cgColor
                rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                rGNTextfield.layer.borderColor = UIColor.gray.cgColor
            }
            self.rGDTextfield.becomeFirstResponder()
        }
        
        else if (textField == self.rGDTextfield) {
            requiredflag = 1
            if rGDTextfield.text == ""{
                if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                    requiredflag = 0
                }
                else{
                    if isautoPopulated == true{
                        requiredflag = 1
                    }
                    else{
                        requiredflag = 1
                    }
                }
                if requiredflag == 1{
                    serieTextfield.layer.borderColor = UIColor.gray.cgColor
                    rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                    rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    serieTextfield.layer.borderColor = UIColor.red.cgColor
                    rGNTextfield.layer.borderColor = UIColor.red.cgColor
                    rGDTextfield.layer.borderColor = UIColor.red.cgColor
                }
                
            } else {
                rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                serieTextfield.layer.borderColor = UIColor.gray.cgColor
                rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                rGDTextfield.layer.borderColor = UIColor.gray.cgColor
            }
            self.animalTextfield.becomeFirstResponder()
        }
        else if (textField == self.animalTextfield) {
            self.animalTextfield.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if barAutoPopu == false {
            barcodeflag = true
        }
        else {
            let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId!)
            if orederStatus.count > 0 {
                if textField == genotypeSerieTextfield || textField == genotypeRgnTextfield || textField == genotypeAnimalNameTextfield || textField == genotypeRgdTextfield ||  textField == serieTextfield || textField == rGNTextfield || textField == rGDTextfield || textField == animalTextfield  {
                    barcodeEnable = true
                }
            }
        }
        if  (string == " ") {
            return false
        }
        
        if textField == genotypeScanBarcodeTextField{
            barcodeflag = true
            if genotypeScanBarcodeTextField.text!.count == 1 {
                self.isBarcodeAutoIncrementedEnabled = false
                incrementalBarcodeTitleLabelGenoType.textColor = .gray
                incrementalBarcodeButtonGenoType.isEnabled = false
                incrementalBarcodeCheckBoxGenoType.image = UIImage(named: ImageNames.incrementalCheckImg)
            }
            else {
                GenotypebyDefaultbackroundWhite(isBeginEditing: true)
            }
        }
        
        if textField == scanBarcodeTextfield {
            self.defaultIncrementalBarCodeSetting()
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
                    incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.checkImg)
                    UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                    checkBarcode = true
                }
            }
        }
        
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                if textField == scanBarcodeTextfield{
                    barcodeflag = true
                    if scanBarcodeTextfield.text!.count == 1 {
                        self.isBarcodeAutoIncrementedEnabled = false
                        // UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                        incrementalBarcodeTitleLabel.textColor = .gray
                        incrementalBarcodeButton.isEnabled = false
                        incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                        //merged
                       // OtherbyTextfieldGray()
                    }
                    else {
                        othersByDefaultBackroundWhite(isBeginEditing: true)
                    }
                }
                
                if textField == genotypeScanBarcodeTextField{
                    barcodeflag = true
                    if genotypeScanBarcodeTextField.text!.count == 1 {
                        self.isBarcodeAutoIncrementedEnabled = false
                        incrementalBarcodeTitleLabelGenoType.textColor = .gray
                        incrementalBarcodeButtonGenoType.isEnabled = false
                        incrementalBarcodeCheckBoxGenoType.image = UIImage(named: ImageNames.incrementalCheckImg)
                        //merged
                       // GenotypebyDefaultbackroundGray()
                    } else {
                        GenotypebyDefaultbackroundWhite(isBeginEditing: true)
                    }
                }
                return true
            }
            else {
                if textField == scanBarcodeTextfield{
                    othersByDefaultBackroundWhite(isBeginEditing: true)
                }
            }
            if textField == genotypeDateTextField {
                if genotypeDateTextField.text?.count == 2 || genotypeDateTextField.text?.count == 5{
                    genotypeDateTextField.text?.append("/")
                }
                if genotypeDateTextField.text?.count == 10 {
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
            
            let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal, customerID: custmerId!)
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
        if textField == scanBarcodeTextfield || textField == genotypeScanBarcodeTextField {
            let ACCEPTABLE_CHARACTERS = LocalizedStrings.abcdNumberFormat
            let check  = ACCEPTABLE_CHARACTERS.contains(string)
            if check == false {
                return false
            }
        }
        return true
    }
}
// MARK: OFFLINE CUSTOM VIEW
extension DataEntryBeefAnimalBrazilVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

// MARK: TABLEVIEW DELEGATE AND DATASOURCE
extension DataEntryBeefAnimalBrazilVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if btnTag == 10 {
            return self.tissueArr.count
        }else if btnTag == 116
        {
            return self.breedArr.count
        }
        else if btnTag == 117
        {
            return self.breedArrblack.count
        }
        else if btnTag == 20 {
            return self.priorityBreeding.count
        }
        else  if btnTag == 40 {
            return self.tissueArr.count
        }
        else {
            return self.secondaryBreeding.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        if btnTag == 10 {
            let tissue = self.tissueArr[indexPath.row]  as! GetSampleTbl
            tissuId =  Int(tissue.sampleId)
            cell.textLabel?.text = tissue.sampleName?.localized
            return cell
        }
        else if btnTag == 116
        {
            if isGenostarblackOnlyAdded && isGenotypeOnlyAdded
            {
                cell.textLabel?.text = tempbreedarraynames2[indexPath.row]
                return cell
            }
            else
            {
                let breed = breedArr[indexPath.row] as! GetBreedsTbl
                cell.textLabel?.text = breed.threeCharCode
                return cell
            }
        }
        
        else if btnTag == 117
        {
            let breed1 = breedArrblack[indexPath.row] as! GetBreedsTbl
            cell.textLabel?.text = breed1.threeCharCode
            return cell
        }
        else if btnTag == 20 {
            let tissue = self.priorityBreeding[indexPath.row]  as! GetPriorityBreeding
            cell.textLabel?.text = tissue.priorityBreedName
            return cell
            
        } else if btnTag == 40 {
            let tissue = self.tissueArr[indexPath.row]  as! GetSampleTbl
            tissuId =  Int(tissue.sampleId)
            cell.textLabel?.text = tissue.sampleName?.localized
            return cell
            
        } else {
            let tissue = self.secondaryBreeding[indexPath.row]  as! GetSecondaryBreedingPrograms
            cell.textLabel?.text = tissue.priorityBreedName
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        barcodeEnable = true
        if btnTag == 10 {
            let tissue = self.tissueArr[indexPath.row]  as! GetSampleTbl
            genotypeTissueBttn.setTitleColor(.black, for: .normal)
            tissuId = Int(tissue.sampleId)
            genotypeTissueBttn.setTitle(tissue.sampleName?.localized, for: .normal)
            buttonbg2.removeFromSuperview()
            
        }
        else if btnTag == 116
        {
            if isGenostarblackOnlyAdded && isGenotypeOnlyAdded
            {
                breedId = tempbreedarraynames1[indexPath.row]
                selectBreedBtn.setTitle(tempbreedarraynames2[indexPath.row], for: .normal)
            }
            else {
                let breed = self.breedArr[indexPath.row] as! GetBreedsTbl
                breedId = breed.breedId!
                selectBreedBtn.setTitleColor(.black, for: .normal)
                selectBreedBtn.setTitle(breed.threeCharCode, for: .normal)
            }
            buttonbg2.removeFromSuperview()
        }
        else if btnTag == 117{
            let breed1 = self.breedArrblack[indexPath.row] as! GetBreedsTbl
            breedId = breed1.breedId!
            genstarblackBreedBtn.setTitleColor(.black, for: .normal)
            genstarblackBreedBtn.setTitle(breed1.threeCharCode, for: .normal)
            buttonbg2.removeFromSuperview()
        }
        else  if btnTag == 20 {
            let tissue = self.priorityBreeding[indexPath.row]  as! GetPriorityBreeding
            priorityBreeingBtnOutlet.setTitleColor(.black, for: .normal)
            priorityBreeingBtnOutlet.setTitle(tissue.priorityBreedName, for: .normal)
            buttonbg2.removeFromSuperview()
        }
        else if btnTag == 40 {
            let tissue = self.tissueArr[indexPath.row]  as! GetSampleTbl
            tissueBttn.setTitleColor(.black, for: .normal)
            tissuId = Int(tissue.sampleId)
            tissueBttn.setTitle(tissue.sampleName?.localized, for: .normal)
            buttonbg2.removeFromSuperview()
        }
        else if btnTag == 50 {
            let tissue = self.tertiaryBreeding[indexPath.row]  as! GetTertiaryBreedingPrograms
            territoryBreddingOutlet.setTitleColor(.black, for: .normal)
            territoryBreddingOutlet.setTitle(tissue.priorityBreedName, for: .normal)
            buttonbg2.removeFromSuperview()
        }
        else {
            let tissue = self.secondaryBreeding[indexPath.row]  as! GetSecondaryBreedingPrograms
            secondaryBreddingOutlet.setTitleColor(.black, for: .normal)
            secondaryBreddingOutlet.setTitle(tissue.priorityBreedName, for: .normal)
            buttonbg2.removeFromSuperview()
        }
    }
}
