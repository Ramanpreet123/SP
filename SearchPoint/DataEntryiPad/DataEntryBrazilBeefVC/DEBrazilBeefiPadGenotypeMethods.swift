//
//  DEBrazilBeefiPadGenotypeMethods.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 26/03/25.
//

import Foundation
import UIKit

// MARK: - GENOTYPE METHODS
extension DEBrazilBeefVCIpad {
    func GenotypetextfieldLeftPadding(){
        genotypeScanBarcodeTextField.addPadding(.left(20))
        genotypeSerieTextfield.addPadding(.left(20))
        genotypeRgnTextfield.addPadding(.left(20))
        genotypeAnimalNameTextfield.addPadding(.left(20))
        genotypeRgdTextfield.addPadding(.left(20))
        scanBarcodeTextfield.addPadding(.left(20))
        serieTextfield.addPadding(.left(20))
        rGNTextfield.addPadding(.left(20))
        rGDTextfield.addPadding(.left(20))
        animalTextfield.addPadding(.left(20))
        if !changeColorToRed {
            genotypeScanBarcodeTextField.becomeFirstResponder()
            self.genotypeScanBarcodeTextField.backgroundColor = .white
        }
    }
    
    func GenotypebyDefaultbackroundWhite(isBeginEditing: Bool = true){
        nonGenoExpandOutlet.alpha = 1
        nonGenoExpandOutlet.isEnabled = true
        genoTypeExpandFormBtn.alpha = 1
        genoTypeExpandFormBtn.isEnabled = true
        genotypeMaleFemaleBttn.isEnabled = true
        genotypeScanBarcodeView.layer.backgroundColor = UIColor.white.cgColor
        genotypeSerieTextfield.layer.backgroundColor = UIColor.white.cgColor
        genotypeRgnTextfield.layer.backgroundColor = UIColor.white.cgColor
        genotypeAnimalNameTextfield.layer.backgroundColor = UIColor.white.cgColor
        genotypeRgdTextfield.layer.backgroundColor = UIColor.white.cgColor
        calenderViewOutlet.layer.backgroundColor = UIColor.white.cgColor
        genotypeTissueBttn.layer.backgroundColor = UIColor.white.cgColor
        selectBreedBtn.layer.backgroundColor = UIColor.white.cgColor
        genotypeDOBBttn.layer.backgroundColor = UIColor.white.cgColor
        genotypeSerieTextfield.isEnabled = true
        genotypeRgnTextfield.isEnabled = true
        genotypeAnimalNameTextfield.isEnabled = true
        genotypeRgdTextfield.isEnabled = true
        calenderViewOutlet.isUserInteractionEnabled = true
        
        selectBreedBtn.isEnabled = true
        genotypeDOBBttn.isEnabled = true
        genotypeTissueBttn.isEnabled = true
        priorityBreeingBtnOutlet.isEnabled = true
        territoryBreddingOutlet.isEnabled = true
        secondaryBreddingOutlet.isEnabled = true
        priorityBreeingBtnOutlet.backgroundColor = UIColor.white
        genotypeMaleFemaleBttn.backgroundColor = UIColor.white
        secondaryBreddingOutlet.backgroundColor = UIColor.white
        territoryBreddingOutlet.backgroundColor = UIColor.white
        secondaryBreddingOutlet.setTitleColor(.black, for: .normal)
        genotypeMaleFemaleBttn.setTitleColor(.black, for: .normal)
        priorityBreeingBtnOutlet.setTitleColor(.black, for: .normal)
        territoryBreddingOutlet.setTitleColor(.black, for: .normal)
        genotypeTissueBttn.setTitleColor(.black, for: .normal)
        selectBreedBtn.setTitleColor(.black, for: .normal)
        incrementalBarcodeTitleLabelGenoType.textColor = .black
        incrementalBarcodeButtonGenoType.isEnabled = true
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) && !isBeginEditing {
            if let lastSavedBarCode = UserDefaults.standard.value(forKey: keyValue.barcodeIncremental.rawValue) as? String {
                genotypeScanBarcodeTextField.text = isBarcodeEndingWithNumberAndGetIncremented(lastSavedBarCode).incrementedBarCode
            }
        }
    }
    
    func GenotypebyDefaultbackroundGray(){
        nonGenoExpandOutlet.alpha = 0.4
        nonGenoExpandOutlet.isEnabled = true
        genoTypeExpandFormBtn.alpha = 0.4
        genoTypeExpandFormBtn.isEnabled = true
        selectBreedBtn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeDOBBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        calenderViewOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeSerieTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeRgnTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeAnimalNameTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeRgdTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        secondaryBreddingOutlet.setTitleColor(.gray, for: .normal)
        priorityBreeingBtnOutlet.setTitleColor(.gray, for: .normal)
        territoryBreddingOutlet.setTitleColor(.gray, for: .normal)
        genotypeTissueBttn.setTitleColor(.gray, for: .normal)
        genotypeMaleFemaleBttn.setTitleColor(.gray, for: .normal)
        priorityBreeingBtnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        secondaryBreddingOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        territoryBreddingOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeTissueBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeMaleFemaleBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeSerieTextfield.isEnabled = false
        genotypeRgnTextfield.isEnabled = false
        genotypeAnimalNameTextfield.isEnabled = false
        genotypeRgdTextfield.isEnabled = false
        calenderViewOutlet.isUserInteractionEnabled = false
        genotypeDOBBttn.isEnabled = false
        selectBreedBtn.isEnabled = false
        genotypeTissueBttn.isEnabled = false
        priorityBreeingBtnOutlet.isEnabled = false
        secondaryBreddingOutlet.isEnabled = false
        territoryBreddingOutlet.isEnabled = false
        genotypeMaleFemaleBttn.isEnabled = false
        maleFemaleBttn.isEnabled = false
        tissueBttn.isEnabled = false
        priorityBreeingBtnOutlet.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        secondaryBreddingOutlet.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        territoryBreddingOutlet.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        incrementalBarcodeTitleLabelGenoType.textColor = .gray
        incrementalBarcodeButtonGenoType.isEnabled = false
        if !changeColorToRed {
            genotypeScanBarcodeTextField.becomeFirstResponder()
            self.genotypeScanBarcodeTextField.backgroundColor = .white
        }
        genotypeDateTextField.text = ""
    }
    
    func genotypeSetBorder(){
        if !changeColorToRed {
            genotypeScanBarcodeTextField.becomeFirstResponder()
            self.genotypeScanBarcodeTextField.backgroundColor = .white
        }
    }
    
    func GenotypebyDefaultScreen(){
        if isGenotypeOnlyAdded {
            
            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                
                genotypeDateTextField.isHidden = false
                dateOfLbl.isHidden = true
            } else {
                genotypeDateTextField.isHidden = true
                dateOfLbl.isHidden = false
            }
        } else {
            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                dateTextField.isHidden = false
                dobLbl.isHidden = true
            } else {
                dateTextField.isHidden = true
                dobLbl.isHidden = false
            }
        }
        
        if UserDefaults.standard.value(forKey: "DEGenoGender") as? String == "F" {
            UserDefaults.standard.set("F", forKey: "DEGenoGender")
            self.genotypeMaleFemaleBttn.setTitle("Female", for: .normal)
            genderToggleFlag = 0
            genderString = ButtonTitles.femaleText.localized
        } else {
            UserDefaults.standard.set("M", forKey: "DEGenoGender")
            self.genotypeMaleFemaleBttn.setTitle("Male", for: .normal)
            genderToggleFlag = 1
            genderString = ButtonTitles.maleText.localized
        }
        
        animalId1 = 0
        idAnimal = 0
        isUpdate = false
        barAutoPopu = false
        msgUpatedd = false
        self.msgcheckk = false
        self.isautoPopulated = false
        nonGenoExpandOutlet.alpha = 1.0
        nonGenoExpandOutlet.isEnabled = true
        genoTypeExpandFormBtn.alpha = 1.0
        genoTypeExpandFormBtn.isEnabled = true
        genotypeScanBarcodeTextField.text?.removeAll()
        genotypeSerieTextfield.text?.removeAll()
        genotypeRgnTextfield.text?.removeAll()
        genotypeAnimalNameTextfield.text?.removeAll()
        genotypeRgdTextfield.text?.removeAll()
        genotypeSerieTextfield.isEnabled = true
        genotypeRgnTextfield.isEnabled = true
        genotypeAnimalNameTextfield.isEnabled = true
        genotypeRgdTextfield.isEnabled = true
        calenderViewOutlet.isUserInteractionEnabled = true
        genotypeDOBBttn.isEnabled = true
        genotypeTissueBttn.isEnabled = true
        priorityBreeingBtnOutlet.isEnabled = true
        secondaryBreddingOutlet.isEnabled = true
        territoryBreddingOutlet.isEnabled = true
        
        if let primary = UserDefaults.standard.object(forKey: keyValue.dataListPrimaryGenoType.rawValue)
        {
            priorityBreeingBtnOutlet.setTitle(primary as? String ,for: .normal)
        } else{
            priorityBreeingBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectPrimaryBreed, comment: "") ,for: .normal)
        }
        
        if let secondary = UserDefaults.standard.object(forKey: keyValue.dataListSecondaryGenoType.rawValue)
        {
            secondaryBreddingOutlet.setTitle(secondary as? String ,for: .normal)
        } else{
            secondaryBreddingOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectSecondaryBreed, comment: ""), for: .normal)
        }
        if let  territory = UserDefaults.standard.object(forKey: keyValue.dataListTertirayGenoType.rawValue)
        {
            territoryBreddingOutlet.setTitle(territory as? String ,for: .normal)
        } else{
            territoryBreddingOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectTertiaryBreed, comment: "") ,for: .normal)
        }
        genotypeDOBBttn.titleLabel?.text = ""
        genotypeDOBBttn.setTitle("", for: .normal)
        maleFemaleBttn.isEnabled = false
        genotypeMaleFemaleBttn.isEnabled = false
        tissueBttn.isEnabled = false
        self.genotypeScrollView.contentOffset.y = 0.0
      
        if !changeColorToRed {
            genotypeScanBarcodeTextField.becomeFirstResponder()
            self.genotypeScanBarcodeTextField.backgroundColor = .white
        }
    }
    
    func genotypeAddBtnCondtion(completionHandler: CompletionHandler){
        
        if UserDefaults.standard.value(forKey: "DEGenoGender") as? String == "F" {
            UserDefaults.standard.set("F", forKey: "DEGenoGender")
            self.genotypeMaleFemaleBttn.setTitle("Female", for: .normal)
            genderToggleFlag = 0
            genderString = ButtonTitles.femaleText.localized
        } else {
            UserDefaults.standard.set("M", forKey: "DEGenoGender")
            self.genotypeMaleFemaleBttn.setTitle("Male", for: .normal)
            genderToggleFlag = 1
            genderString = ButtonTitles.maleText.localized
        }
        
        if checkBarcode {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.barcodeMustEndWithNumAlert, comment: ""))
            return
        }
        var dateVale = ""
        let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            dateVale = genotypeDateTextField.text ?? ""
            if dateStr == "DD"{
                dateVale = genotypeDOBBttn.titleLabel?.text ?? ""
            }
            else {
                if dateVale != ""{
                    let values = dateVale.components(separatedBy: "/")
                    let date = values[0]
                    let month = values[1]
                    let year = values[2]
                    dateVale = month + "/" + date + "/" + year
                }
            }
        } else {
            
            dateVale = genotypeDOBBttn.titleLabel?.text ?? ""
            if dateStr == "DD"{
                dateVale = genotypeDOBBttn.titleLabel?.text ?? ""
            }
            else {
                if dateVale != ""{
                    let values = dateVale.components(separatedBy: "/")
                    let date = values[0]
                    let month = values[1]
                    let year = values[2]
                    dateVale = month + "/" + date + "/" + year
                }
            }
        }
        if genotypeDateTextField.text?.count == 0 {}
        else {
            if genotypeDateTextField.text?.count == 10 {
                let validate = isValidDate(dateString: genotypeDateTextField.text ?? "")
                if validate == LocalizedStrings.correctFormatStr {
                    validateDateFlag = true
                } else {
                    dateBttnOutlet.layer.borderColor = UIColor.red.cgColor
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
                dateBttnOutlet.layer.borderColor = UIColor.red.cgColor
                validateDateFlag = false
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
                return
            }
        }
        
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        if genotypeScanBarcodeTextField.text != "" {
            incrementalBarCode = genotypeScanBarcodeTextField.text ?? ""
            let barCode = fetchAnimaBarcodeValidateWithoutOrderId(entityName: Entities.beefAnimalAddTblEntity,animalbarCodeTag:genotypeScanBarcodeTextField.text ?? "",orderSatatus: "false")
            if barCode.count > 0 {
                genotypeScanBarcodeView.layer.borderColor = UIColor.red.cgColor
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.barcodeAlreadyUsed, comment: ""))
                return
            }
        }
        if barcodeflag  && genotypeScanBarcodeTextField.text != "" {
            let barCode = fetchAnimaBarcodeValidateWithoutOrderId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,animalbarCodeTag:genotypeScanBarcodeTextField.text ?? "",orderSatatus: "false")
            
            if barCode.count > 0 {
                if genotypeSerieTextfield.text != "" {
                    genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                if genotypeRgnTextfield.text != "" {
                    genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                genotypeScanBarcodeView.layer.borderColor = UIColor.red.cgColor
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.barcodeAlreadyUsed, comment: ""))
                return
            }
        }
        
        let animaBarcOde = fetchAnimaldataValidateAnimalBarcodeanimalIdearTag(entityName: Entities.beefAnimalMasterTblEntity, animalbarCodeTag: genotypeScanBarcodeTextField.text ?? "", sireId: genotypeSerieTextfield.text ?? "", animalBarCode:genotypeAnimalNameTextfield.text ?? "" , userId: userId, animalId: animalId1, orderStatus: "true",IsDataEmail: false)
        
        if animaBarcOde.count > 0 {
            genotypeScanBarcodeView.layer.borderColor = UIColor.red.cgColor
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sampleAlreadyExists, comment: ""))
            return
        }
        
        let animalData = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId: animalId1, orderId: orderId, userId: userId, orderStatus: "false")
                
        if animalData.count > 0  {
            
            isUpdate = true
            updateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalMasterTblEntity, animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName:  selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true,territoryGeno: territoryBreddingOutlet.titleLabel!.text ?? "")
            
            updateOrderStatusISyncAnimalMaster(entity: Entities.dataEntryBeefAnimalAddTblEntity,animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "true", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: (priorityBreeingBtnOutlet.titleLabel!.text!), nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: territoryBreddingOutlet.titleLabel!.text ?? "")
            
            updateOrderStatusISyncProduct(entity: Entities.productAdonAnimlBeefTblEntity,animalTag: genotypeScanBarcodeTextField.text!,barCodetag:  genotypeAnimalNameTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId:animalId1)
            updateOrderStatusISyncSubProduct(entity: Entities.subProductBeefTblEntity,animalTag: genotypeScanBarcodeTextField.text!,barCodetag:  genotypeAnimalNameTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId: animalId1)
            updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId ?? 0,offlineSync:false,listid: listIdGet)
            
            let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: "",animalTag:genotypeScanBarcodeTextField.text!,barcodeTag:genotypeAnimalNameTextfield.text!)
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            
            if adata.count > 0{
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                GenotypebyDefaultScreen()
            }
            
            else if animalDataMaster.count > 0 {
                if  msgUpatedd {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalRecordUpdated, comment: ""))
                    UserDefaults.standard.set(genotypeTissueBttn.titleLabel?.text, forKey: keyValue.dataEntrygenotypeTissueBttnClear.rawValue)
                    UserDefaults.standard.set(genotypeTissueBttn.titleLabel?.text, forKey: keyValue.dataEntrygenotypeTissueBttn.rawValue)
                    GenotypebyDefaultScreen()
                    
                }
                else{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                    GenotypebyDefaultScreen()
                }
            }
            
            editAid = animalId1
            animalId1 = 0
            
            if identify1  {
                let data1 = fetchAllDataOrderStatus(entityName: Entities.dataEntryBeefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
                if data1.count > 0 {
                    completionHandler(true)
                    return
                }
            }
            completionHandler(true)
            scrolView.contentOffset.y = 0.0
        }
        
        else if isUpdate  {
            animalId1 = editAid
            updateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalMasterTblEntity, animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName:selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
            
            updateOrderStatusISyncAnimalMaster(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "true", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName:  selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
            
            updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId ?? 0,offlineSync:false,listid: listIdGet)
            if identify1  {
                let data1 = fetchAllDataOrderStatus(entityName: Entities.dataEntryBeefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
                if data1.count > 0 {
                    completionHandler(true)
                    return
                }
            }
            isautoPopulated = false
            let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: "",animalTag:genotypeScanBarcodeTextField.text!,barcodeTag:genotypeAnimalNameTextfield.text!)
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            
            if adata.count > 0{
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                GenotypebyDefaultScreen()
            }
            
            else if animalDataMaster.count > 0 {
                if  msgUpatedd {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalRecordUpdated, comment: ""))
                    UserDefaults.standard.set(genotypeTissueBttn.titleLabel?.text, forKey: keyValue.dataEntrygenotypeTissueBttnClear.rawValue)
                    UserDefaults.standard.set(genotypeTissueBttn.titleLabel?.text, forKey: keyValue.dataEntrygenotypeTissueBttn.rawValue)
                    GenotypebyDefaultScreen()
                    
                }
                else{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                    GenotypebyDefaultScreen()
                }
            }
            completionHandler(true)
            scrolView.contentOffset.y = 0.0
        }
        else {
            isUpdate = false
            let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
            let pid = product[0] as! GetProductTblBeef
            var animalID1 = UserDefaults.standard.integer(forKey: keyValue.animalId.rawValue)
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            if animalDataMaster.count > 0{
                if animalID1 == 0 {
                    animalID1 = animalID1 + 1
                    UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                }
                else {
                    animalID1 = animalID1 + 1
                    UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                }
                
                updateOrderStatusISyncAnimalMasterAnimalId(entity: Entities.beefAnimalMasterTblEntity, animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName:  selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1,isSyncServer:false, adhDataServer: false, tertiaryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
                updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId ?? 0,offlineSync:false,listid: listIdGet)
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
                
                let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"true" )
                
                if animalDataMaster.count > 0{
                    updateOrderStatusISyncAnimalMasterAnimalId(entity: Entities.beefAnimalMasterTblEntity, animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName:  selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU:secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1,isSyncServer:false, adhDataServer: false, tertiaryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
                    updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId ?? 0,offlineSync:false,listid: listIdGet)
                }
                else {
                    if tissuId == 0{
                        tissuId = 4
                    }
                    saveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString, animalId: animalID1, productId: Int(pid.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listIdGet), serverAnimalId: "", tertiaryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
                    updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId ?? 0,offlineSync:false,listid: listIdGet)
                }
            }
            
            saveAnimaldataBeefInProductId(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "true", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName:  selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString, animalId: animalID1, productId: Int(pid.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listIdGet), serverAnimalId: "", tertiaryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
            
            updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId ?? 0,offlineSync:false,listid: listIdGet)
            msgShow()
            UserDefaults.standard.set(genotypeTissueBttn.titleLabel?.text, forKey: keyValue.dataEntrygenotypeTissueBttnClear.rawValue)
            UserDefaults.standard.set(genotypeTissueBttn.titleLabel?.text, forKey: keyValue.dataEntrygenotypeTissueBttn.rawValue)
            GenotypebyDefaultScreen()
            
            
            if isBarcodeAutoIncrementedEnabled  {
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
                
            } else {
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
            }
            genotypeScanBarcodeTextField.text = ""
            let animalCount =  fetchDataEnteryAnimalTblBeefDataBrazil(entityName: Entities.dataEntryBeefAnimalAddTblEntity,customerId:self.custmerId ?? 0,listId:Int64(self.listIdGet ),providerId:UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
            notificationLblCount.text = String(animalCount.count)
            let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
            let formatter = DateFormatter()
            
            if dateStr == "MM"{
                formatter.dateFormat = DateFormatters.MMddyyyyFormat
            }
            else {
                formatter.dateFormat = DateFormatters.ddMMyyyyFormat
            }
            dateVale = ""
            genotypeDOBBttn.titleLabel!.text  = ""
            genotypeDOBBttn.setTitle("", for: .normal)
            completionHandler(true)
        }
        
        barAutoPopu = false
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue)  {
            UserDefaults.standard.set(incrementalBarCode, forKey: keyValue.barcodeIncremental.rawValue)
        }
        incrementalBarCode = ""
        
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue)  {
            if let lastSavedBarCode = UserDefaults.standard.value(forKey: keyValue.barcodeIncremental.rawValue) as? String {
                genotypeScanBarcodeTextField.text = isBarcodeEndingWithNumberAndGetIncremented(lastSavedBarCode).incrementedBarCode
                if genotypeScanBarcodeTextField.text?.isEmpty == false {
                    self.GenotypebyDefaultbackroundWhite()
                }
            }
        }
        if !changeColorToRed {
            genotypeScanBarcodeTextField.becomeFirstResponder()
            self.genotypeScanBarcodeTextField.backgroundColor = .white
        }
        
        view.endEditing(true)
        self.scrolView.contentOffset.y = 0.0
        self.genotypeScrollView.contentOffset.y = 0.0
    }
    
    func genotypeDoDatePicker(){
        self.datePicker = UIDatePicker(frame:CGRect(x: 20, y: 40, width: self.calenderView.frame.size.width, height: 260))
        self.datePicker?.backgroundColor = UIColor.white
        if langId == 2
        {
            self.datePicker?.locale = Locale(identifier: Languages.portuguese)
        }
        else if langId == 3
        {
            self.datePicker?.locale = Locale(identifier: Languages.italian)
        }
        else
        {
            self.datePicker?.locale = Locale(identifier: Languages.eng)
        }
        self.datePicker?.datePickerMode = UIDatePicker.Mode.date
        self.datePicker.setDate(selectedDate, animated: true)
        
        if #available(iOS 14, *) {
            self.datePicker?.preferredDatePickerStyle = .wheels
        }
        calenderView.backgroundColor = UIColor.white
        calenderView.addSubview(self.datePicker)
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 1, alpha: 1)
        toolBar.sizeToFit()
        self.datePicker.maximumDate = Date()
        let doneButton = UIBarButtonItem(title:  NSLocalizedString(LocalizedStrings.doneStr, comment: ""), style: .plain, target: self, action: #selector(self.genotypeDoneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title:  NSLocalizedString("Cancel", comment: ""), style: .plain, target: self, action: #selector(self.cancelClick))
        cancelButton.tintColor = UIColor.black
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = CGRect(x: 0, y: 0, width: self.calenderView.frame.size.width, height: 40)
        self.calenderView.addSubview(toolBar)
        self.toolBar.isHidden = false
    }
    
    func genotypecontinueproduct(){
        let storyboard = UIStoryboard(name: "DataEntryBeefiPad", bundle: Bundle.main)
        identify1 = true
        let data1 = fetchDataEnteryAnimalTblBeefDataBrazil(entityName: Entities.dataEntryBeefAnimalAddTblEntity,customerId:self.custmerId ?? 0,listId:Int64(self.listIdGet ),providerId:UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
        let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
        if  identyCheck == false || identyCheck == nil{
            if data1.count > 0 {
                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" {
                    if priorityBreeingBtnOutlet.titleLabel?.text  == ButtonTitles.ciadeMelhoramentoText{
                        requiredflag = 1
                    }else{
                        requiredflag = 0
                    }
                }
                else{
                    requiredflag = 1
                }
                if requiredflag == 0 {
                    if genotypeScanBarcodeTextField.text != ""{
                        if genotypeSerieTextfield.text != "" && genotypeRgnTextfield.text != "" {
                        }else {
                            genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                            genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                            return
                        }
                    }
                    
                    if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil {
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                    }
                    else {
                        if identyCheck == false || identyCheck == nil {
                            if  UserDefaults.standard.value(forKey: keyValue.page.rawValue) == nil {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                            }
                            else{
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                            }
                        }
                        else {
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                        }
                    }
                }
                else {
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        if success {
                            let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                            if  identyCheck == true {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                            }
                            else {
                                if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil{
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                                }
                                else {
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                                }
                            }
                        }
                    })
                }
            }
            
            else {
                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == ""{
                    requiredflag = 0
                }
                else{
                    requiredflag = 1
                }
                if  requiredflag == 0 {
                    if genotypeScanBarcodeTextField.text?.count == 0 {
                        if  requiredflag == 0 {
                            self.textFieldValidation()
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.addOneAnimal, comment: ""))
                            return
                        }
                        else {
                            self.textFieldValidation()
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                            return
                        }
                    }
                    else {
                        if genotypeSerieTextfield.text != "" && genotypeRgnTextfield.text != ""  {
                            genotypeAddBtnCondtion(completionHandler: { (success) -> Void in
                                if success {
                                }
                            })
                        } else {
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                            self.textFieldValidation()
                            return
                        }
                    }
                }
                else {
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        if success {
                            if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil{
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                            }
                            else {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                            }
                        }
                    })
                }
            }
        }
        else {
            if data1.count > 0 {
                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                    if priorityBreeingBtnOutlet.titleLabel?.text  == ButtonTitles.ciadeMelhoramentoText{
                        requiredflag = 1
                    }else{
                        requiredflag = 0
                    }
                }
                else{
                    requiredflag = 1
                }
                if requiredflag == 0 {
                    let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                    if  identyCheck == true {
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                        
                    }  else {
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                    }
                }
                
                else{
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        if success {
                            let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                            if  identyCheck == true {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                                
                            }
                            else {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                            }
                        }
                    })
                }
            }
            else{
                addAnimalBtn(completionHandler: { (success) -> Void in
                    if success {
                        let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                        if  identyCheck == true {
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                        }
                        else {
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
                        }
                    }
                })
            }
        }
    }
}
