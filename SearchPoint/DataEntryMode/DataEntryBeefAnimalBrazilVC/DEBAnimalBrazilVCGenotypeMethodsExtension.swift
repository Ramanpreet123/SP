//
//  DEBAnimalBrazilVCGenotypeMethodsExtension.swift
//  SearchPoint
//
//  Created by Mobile Programming on 26/02/24.
//

import Foundation
import UIKit

// MARK: - GENOTYPE METHODS
extension DataEntryBeefAnimalBrazilVC {
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
        self.genotypeScanBarcodeTextField.becomeFirstResponder()
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
        dateOfLbl.textColor = UIColor.black
        dobLbl.textColor = UIColor.black
        selectBreedBtn.isEnabled = true
        genotypeDOBBttn.isEnabled = true
        genotypeTissueBttn.isEnabled = true
        priorityBreeingBtnOutlet.isEnabled = true
        territoryBreddingOutlet.isEnabled = true
        secondaryBreddingOutlet.isEnabled = true
        priorityBreeingBtnOutlet.backgroundColor = UIColor.white
        secondaryBreddingOutlet.backgroundColor = UIColor.white
        territoryBreddingOutlet.backgroundColor = UIColor.white
        secondaryBreddingOutlet.setTitleColor(.black, for: .normal)
        priorityBreeingBtnOutlet.setTitleColor(.black, for: .normal)
        territoryBreddingOutlet.setTitleColor(.black, for: .normal)
        genotypeTissueBttn.setTitleColor(.black, for: .normal)
        selectBreedBtn.setTitleColor(.black, for: .normal)
        incrementalBarcodeTitleLabelGenoType.textColor = .black
        incrementalBarcodeButtonGenoType.isEnabled = true
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true && isBeginEditing == false {
            if let lastSavedBarCode = UserDefaults.standard.value(forKey: keyValue.barcodeIncremental.rawValue) as? String {
                genotypeScanBarcodeTextField.text = isBarCodeEndsWithNumber_GetIncrementedBarCode(lastSavedBarCode).incrementedBarCode
            }
        }
    }
    
    func GenotypebyDefaultbackroundGray(){
        dateOfLbl.textColor = UIColor.gray
        dobLbl.textColor = UIColor.gray
        nonGenoExpandOutlet.alpha = 0.4
        nonGenoExpandOutlet.isEnabled = true
        genoTypeExpandFormBtn.alpha = 0.4
        genoTypeExpandFormBtn.isEnabled = true
        selectBreedBtn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeDOBBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeScanBarcodeView.layer.borderColor = UIColor.gray.cgColor
        genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
        genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
        genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
        calenderViewOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeSerieTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeRgnTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeAnimalNameTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeRgdTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        secondaryBreddingOutlet.setTitleColor(.gray, for: .normal)
        priorityBreeingBtnOutlet.setTitleColor(.gray, for: .normal)
        territoryBreddingOutlet.setTitleColor(.gray, for: .normal)
        genotypeTissueBttn.setTitleColor(.gray, for: .normal)
        priorityBreeingBtnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        secondaryBreddingOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        territoryBreddingOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeTissueBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
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
        self.genotypeScanBarcodeTextField.becomeFirstResponder()
        genotypeDateTextField.text = ""
    }
    
    func genotypeSetBorder(){
        genotypeTissueBttn.layer.cornerRadius = (genotypeScanBarcodeView.frame.size.height / 2)
        genotypeTissueBttn.layer.borderWidth = 0.5
        genotypeTissueBttn.layer.borderColor = UIColor.gray.cgColor
        genotypeTissueBttn.layer.masksToBounds = true
        genotypeScanBarcodeView.layer.cornerRadius = (genotypeScanBarcodeView.frame.size.height / 2)
        genotypeScanBarcodeView.layer.borderWidth = 0.5
        genotypeScanBarcodeView.layer.borderColor = UIColor.gray.cgColor
        genotypeScanBarcodeView.layer.masksToBounds = true
        genotypeDOBBttn.layer.cornerRadius = (genotypeDOBBttn.frame.size.height / 2)
        genotypeDOBBttn.layer.borderWidth = 0.5
        genotypeDOBBttn.layer.borderColor = UIColor.gray.cgColor
        genotypeDOBBttn.layer.masksToBounds = true
        genotypeSerieTextfield.layer.cornerRadius = (genotypeSerieTextfield.frame.size.height / 2)
        genotypeSerieTextfield.layer.borderWidth = 0.5
        genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
        selectBreedBtn.layer.cornerRadius = (genotypeDOBBttn.frame.size.height / 2)
        selectBreedBtn.layer.borderWidth = 0.5
        selectBreedBtn.layer.borderColor = UIColor.gray.cgColor
        selectBreedBtn.layer.masksToBounds = true
        genotypeSerieTextfield.layer.masksToBounds = true
        genotypeRgnTextfield.layer.cornerRadius = (genotypeRgnTextfield.frame.size.height / 2)
        genotypeRgnTextfield.layer.borderWidth = 0.5
        genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
        genotypeRgnTextfield.layer.masksToBounds = true
        genotypeAnimalNameTextfield.layer.cornerRadius = (genotypeAnimalNameTextfield.frame.size.height / 2)
        genotypeAnimalNameTextfield.layer.borderWidth = 0.5
        genotypeAnimalNameTextfield.layer.borderColor = UIColor.gray.cgColor
        genotypeAnimalNameTextfield.layer.masksToBounds = true
        genotypeRgdTextfield.layer.cornerRadius = (genotypeRgdTextfield.frame.size.height / 2)
        genotypeRgdTextfield.layer.borderWidth = 0.5
        genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
        genotypeRgdTextfield.layer.masksToBounds = true
        priorityBreeingBtnOutlet.layer.cornerRadius = (priorityBreeingBtnOutlet.frame.size.height / 2)
        priorityBreeingBtnOutlet.layer.borderWidth = 0.5
        priorityBreeingBtnOutlet.layer.borderColor = UIColor.gray.cgColor
        priorityBreeingBtnOutlet.layer.masksToBounds = true
        secondaryBreddingOutlet.layer.cornerRadius = (secondaryBreddingOutlet.frame.size.height / 2)
        secondaryBreddingOutlet.layer.borderWidth = 0.5
        secondaryBreddingOutlet.layer.borderColor = UIColor.gray.cgColor
        secondaryBreddingOutlet.layer.masksToBounds = true
        territoryBreddingOutlet.layer.cornerRadius = (territoryBreddingOutlet.frame.size.height / 2)
        territoryBreddingOutlet.layer.borderWidth = 0.5
        territoryBreddingOutlet.layer.borderColor = UIColor.gray.cgColor
        territoryBreddingOutlet.layer.masksToBounds = true
        self.genotypeScanBarcodeTextField.becomeFirstResponder()
    }
    
    func GenotypebyDefaultScreen(){
        self.maleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
        genderToggleFlag = 0
        genderString = ButtonTitles.femaleText.localized
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
        genotypeScanBarcodeView.layer.borderColor = UIColor.gray.cgColor
        genotypeDOBBttn.layer.borderColor = UIColor.gray.cgColor
        genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
        genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
        genotypeAnimalNameTextfield.layer.borderColor = UIColor.gray.cgColor
        genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
        priorityBreeingBtnOutlet.layer.borderColor = UIColor.gray.cgColor
        secondaryBreddingOutlet.layer.borderColor = UIColor.gray.cgColor
        territoryBreddingOutlet.layer.borderColor = UIColor.gray.cgColor
        tissueBttn.layer.borderColor = UIColor.gray.cgColor
        selectBreedBtn.layer.borderColor = UIColor.gray.cgColor
        rGDTextfield.layer.borderColor = UIColor.gray.cgColor
        //merged
       // GenotypebyDefaultbackroundGray()
        self.genotypeScanBarcodeTextField.becomeFirstResponder()
    }
    
    func genotypeAddBtnCondtion(completionHandler: CompletionHandler){
        if checkBarcode == true {
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
                    dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
                    dateBttnOutlet.layer.borderWidth = 0.5
                    validateDateFlag = true
                } else {
                    dateBttnOutlet.layer.borderColor = UIColor.red.cgColor
                    //  dateBtnOutlet.layer.borderWidth = 1
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
        if barcodeflag == true && genotypeScanBarcodeTextField.text != "" {
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
        
        //merged
        let animalData = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId: animalId1, orderId: orderId, userId: userId, orderStatus: "false")

       // let animalData = fetchAnimaldataValidateAnimalTagWithoutOrderId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: animalTextfield.text ?? "",sireId: serieTextfield.text ?? "", animalBarCode:animalTextfield.text ?? "", orderId: orderId, custmerId: custmerId ?? 0,animalId:animalId1)
        
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
                if  msgUpatedd == true{
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
            
            if identify1 == true {
                let data1 = fetchAllDataOrderStatus(entityName: Entities.dataEntryBeefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
                if data1.count > 0 {
                    completionHandler(true)
                    return
                }
            }
            completionHandler(true)
            scrolView.contentOffset.y = 0.0
        }
        
        else if isUpdate == true {
            animalId1 = editAid
            updateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalMasterTblEntity, animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName:selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
            
            updateOrderStatusISyncAnimalMaster(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "true", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName:  selectBreedBtn.titleLabel!.text!, et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString,animalId: animalId1,isSyncServer:false, adhDataServer: false, editFlagSave: true, territoryGeno: territoryBreddingOutlet.titleLabel?.text ?? "")
            
            updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId ?? 0,offlineSync:false,listid: listIdGet)
            if identify1 == true {
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
                if  msgUpatedd == true{
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
            self.genotypeMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            GenotypebyDefaultScreen()
            genderToggleFlag = 0
            genderString = ButtonTitles.femaleText.localized
            
            if isBarcodeAutoIncrementedEnabled == true {
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
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
            UserDefaults.standard.set(incrementalBarCode, forKey: keyValue.barcodeIncremental.rawValue)
        }
        incrementalBarCode = ""
        
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
            if let lastSavedBarCode = UserDefaults.standard.value(forKey: keyValue.barcodeIncremental.rawValue) as? String {
                genotypeScanBarcodeTextField.text = isBarCodeEndsWithNumber_GetIncrementedBarCode(lastSavedBarCode).incrementedBarCode
                if genotypeScanBarcodeTextField.text?.isEmpty == false {
                    self.GenotypebyDefaultbackroundWhite()
                }
            }
        }
        
        genotypeScanBarcodeTextField.becomeFirstResponder()
        view.endEditing(true)
        self.scrolView.contentOffset.y = 0.0
        self.genotypeScrollView.contentOffset.y = 0.0
    }
    
    func genotypeDoDatePicker(){
        // DatePicker
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
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
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
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                    }
                    else {
                        if identyCheck == false || identyCheck == nil {
                            if  UserDefaults.standard.value(forKey: keyValue.page.rawValue) == nil {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                            }
                            else{
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                            }
                        }
                        else {
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                        }
                    }
                }
                else {
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        if success == true{
                            let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                            if  identyCheck == true {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                            }
                            else {
                                if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil{
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                                }
                                else {
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
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
                                if success == true{
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
                        if success == true{
                            if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil{
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                            }
                            else {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController:
                                self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
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
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                        
                    }  else {
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                    }
                }
                
                else{
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        if success == true{
                            let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                            if  identyCheck == true {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                                
                            }
                            else {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                            }
                        }
                    })
                }
            }
            else{
                addAnimalBtn(completionHandler: { (success) -> Void in
                    if success == true{
                        let identyCheck = UserDefaults.standard.value(forKey: keyValue.identifyStore.rawValue) as? Bool
                        if  identyCheck == true {
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                        }
                        else {
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.beefDataEntryModeReviewDataVC)), animated: true)
                        }
                    }
                })
            }
        }
    }
}
