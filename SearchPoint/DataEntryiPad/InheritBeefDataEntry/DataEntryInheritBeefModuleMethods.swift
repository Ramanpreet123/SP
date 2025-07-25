//
//  DataEntryInheritBeefModuleMethods.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 25/03/25.
//

import Foundation
import UIKit

// MARK: - INHERIT MODULE METHODS
extension DataEntryInheritBeefVC {
    func inheritDoDatePicker(){
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
        self.datePicker.setDate(InheritSelectedDate, animated: true)
        
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
        let doneButton = UIBarButtonItem(title:  NSLocalizedString(LocalizedStrings.doneStr, comment: ""), style: .plain, target: self, action: #selector(self.InheritDoneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title:  NSLocalizedString("Cancel", comment: ""), style: .plain, target: self, action: #selector(self.inheritCancelClick))
        cancelButton.tintColor = UIColor.black
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = CGRect(x: 0, y: 0, width: self.calenderView.frame.size.width, height: 40)
        self.calenderView.addSubview(toolBar)
        self.toolBar.isHidden = false
        
    }
 
    func inheritByDefaultSetting(){
     
        inheritExpandBtnOutlet.alpha = 0.4
        inheritExpandBtnOutlet.isEnabled = false
        let dateformt = DateFormatter()
        let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        if dateStr == "MM" {
            dateformt.dateFormat = DateFormatters.MMddyyyyFormat
            inheritDateTextField.placeholder = DateFormatters.MMDDYYYYFormat
        } else {
            dateformt.dateFormat = DateFormatters.ddMMyyyyFormat
            inheritDateTextField.placeholder = DateFormatters.DDMMYYYYFormat
            
        }
        animalId1 = 0
        idAnimal = 0
        isUpdate = false
        msgUpatedd = false
        self.msgcheckk = false
        barAutoPopu = false
        self.isautoPopulated = false
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            inheritDateTextField.isHidden = false
            inheritDobLbl.isHidden = true
        } else {
            inheritDateTextField.isHidden = true
            inheritDobLbl.isHidden = false
        }
        inheritDobBttn.setTitleColor(UIColor.gray, for: .normal)
        inheritBreedBttn.setTitleColor(UIColor.gray, for: .normal)
        isautoPopulated = false
        inheritBarcodeView.layer.borderColor = UIColor.gray.cgColor
        inheritDamYobBttn.placeholder = NSLocalizedString(ButtonTitles.DamYOBText, comment: "")
        inheritDamYobBttn.layer.borderColor = UIColor.gray.cgColor
        inheriSireRedOutlet.layer.borderColor = UIColor.gray.cgColor
        inheritSireYobBttn.placeholder = NSLocalizedString(ButtonTitles.SireYOB, comment: "")
        inheritDamIdTextfield.layer.borderColor = UIColor.gray.cgColor
        inheritSireRegTextfield.layer.borderColor = UIColor.gray.cgColor
        inheritBreedRegTextfield.layer.borderColor = UIColor.gray.cgColor
        inheritRegAssociationBttn.layer.borderColor = UIColor.gray.cgColor
        inheritBreedBttn.layer.borderColor = UIColor.gray.cgColor
        inheritDobBttn.layer.borderColor = UIColor.gray.cgColor
        inheriSireRedOutlet.layer.borderColor = UIColor.gray.cgColor
        inheritDamYobBttn.layer.borderColor = UIColor.gray.cgColor
        inheritSecondaryIdTextfield.layer.borderColor = UIColor.gray.cgColor
        inheritEIDTextfield.layer.borderColor = UIColor.gray.cgColor
        inheritSireYobBttn.text?.removeAll()
        inheritDamYobBttn.text?.removeAll()
        inheritDamIdTextfield.text?.removeAll()
        inheritSireRegTextfield.text?.removeAll()
        inheritBreedRegTextfield.text?.removeAll()
        inheritBarcodeTextfield.text?.removeAll()
        inheritEarTagTextfield.text?.removeAll()
        inheritEIDTextfield.text?.removeAll()
        inheritSecondaryIdTextfield.text?.removeAll()
        inheriSireRedOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectSireReg, comment: ""), for: .normal)
   //     self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
        if UserDefaults.standard.value(forKey: "DEInheritBeef") as? String == "F" || UserDefaults.standard.value(forKey: "DEInheritBeef") as? String == nil {
            UserDefaults.standard.set("F", forKey: "DEInheritBeef")
            inheritMaleFemaleBttn.setTitle("Female", for: .normal)
            inheritGenderToggleFlag = 0
            inheritGenderString = ButtonTitles.femaleText.localized
        } else {
            UserDefaults.standard.set("M", forKey: "DEInheritBeef")
            inheritMaleFemaleBttn.setTitle("Male", for: .normal)
            inheritGenderToggleFlag = 1
            inheritGenderString = ButtonTitles.maleText.localized
        }
   //     inheritMaleFemaleBttn.setTitle("Female", for: .normal)
        inheritGenderToggleFlag = 0
        inheritGenderString = ButtonTitles.femaleText.localized
        inheriSireRedOutlet.isEnabled = false
        inheriSireRedOutlet.setTitleColor(.gray, for: .normal)
        inheritBreedBttn.setTitleColor(.gray, for: .normal)
        inheritTissueBttn.setTitleColor(.gray, for: .normal)
        self.InheritSelectedDate = Date()
        inheritTextFieldBackroungGrey()
        self.inheritScrollView.contentOffset.y = 0.0
        
        if UserDefaults.standard.string(forKey: keyValue.dataEntryBeefInheritTsu.rawValue) == nil || UserDefaults.standard.string(forKey: keyValue.dataEntryBeefInheritTsu.rawValue) == ""{
            inheritTissueBttn.setTitle(ButtonTitles.allflexTSUText, for: .normal)
            tissuId = 1
        }
        else{
            inheritTissueBttn.setTitle(UserDefaults.standard.string(forKey: keyValue.dataEntryBeefInheritTsu.rawValue)?.localized, for: .normal)
        }
        if UserDefaults.standard.string(forKey: keyValue.dataEntryInheritBeefbreed.rawValue) == "" || UserDefaults.standard.string(forKey: keyValue.dataEntryInheritBeefbreed.rawValue) == nil{
          //  inheritBreedBttn.setTitle(ButtonTitles.ANGText, for: .normal)
            inheritBreedBttn.setTitle("", for: .normal)
            breedId = "d352c4c2-2ff9-451a-9c00-4f0f5604b387"
        }
        else{
            let savedBreed = UserDefaults.standard.string(forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
            inheritBreedBttn.setTitle(savedBreed, for: .normal)
            let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
            let breeds = fetchproviderProductData(entityName: Entities.getBreedsTblEntity, provId: pvid)
            for breed in breeds as? [GetBreedsTbl] ?? [] {
                if breed.breedName == savedBreed {
                    self.breedId = breed.breedId ?? ""
                    break
                }
            }
        }
        if breedId  == "" {
            let inheritBreed = fetchAllDataProductBeefId(entityName: Entities.getBreedsTblEntity, breedName: (inheritBreedBttn.titleLabel?.text!)!, productId: 20)
            
            if inheritBreed.count != 0 {
                let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                breedId = medbreedRegArr1!.breedId ?? ""
            }
        }
        inheritRegAssociationBttn.setTitle(NSLocalizedString(LocalizedStrings.selectBreedAssc, comment: ""), for: .normal)
        inheritDobBttn.setTitle("", for: .normal)
        inheritDobBttn.setTitle(nil, for: .normal)
        inheritDobBttn.setTitle("", for: .normal)
        incrementalBarcodeTitleLabelInherit.textColor = .gray
        incrementalBarcodeButtonInherit.isEnabled = false
        incrementalBarcodeCheckBoxInherit.alpha = 0.6
        incrementalBarcodeTitleLabelInherit.alpha = 0.6
        if !changeColorToRed {
            self.inheritEarTagTextfield.becomeFirstResponder()
            inheritEarTagTextfield.backgroundColor = .white
        }
        
        autoPopulateAnimalData = nil
        isAnimalComingFromCart = false
    }
    
    func inheritAddBtnCondtion(completionHandler: CompletionHandler){
        if UserDefaults.standard.value(forKey: "DEInheritBeef") as? String == "F" || UserDefaults.standard.value(forKey: "DEInheritBeef") as? String == nil {
            UserDefaults.standard.set("F", forKey: "DEInheritBeef")
            inheritMaleFemaleBttn.setTitle("Female", for: .normal)
            inheritGenderToggleFlag = 0
            inheritGenderString = ButtonTitles.femaleText.localized
        } else {
            UserDefaults.standard.set("M", forKey: "DEInheritBeef")
            inheritMaleFemaleBttn.setTitle("Male", for: .normal)
            inheritGenderToggleFlag = 1
            inheritGenderString = ButtonTitles.maleText.localized
        }
        self.view.endEditing(true)
        if checkBarcode == true {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.barcodeMustEndWithNumAlert, comment: ""))
            return
        }
        
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        if  barcodeflag == true {
            let earTag =  fetchAnimaldataValidateAnimalBarcodeanimalIdOrderIdEarTag(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalbarCodeTag: inheritEarTagTextfield.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"false",orderid:orderId)
            //merged
//            if earTag.count > 0 {
//                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalDataCantLoad, comment: ""))
//                return
//            }
            if inheritBarcodeTextfield.text != "" {
                let barCode = fetchAnimaldataValidateAnimalBarcodeanimalIdOrderId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalbarCodeTag: inheritBarcodeTextfield.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"false",orderid:orderId, custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue))
                
                if barCode.count > 0  {
                    inheritBarcodeView.layer.borderColor = UIColor.red.cgColor
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sampleAlreadyExists, comment: ""))
                    return
                }
            }
        }
        
        let codeId = fetchBreedDataTissueCode(entityName: Entities.getSampleTblEntity, provId: pvid, tissueName:(inheritTissueBttn.titleLabel?.text)!)
        let naabFetch1 = codeId.value(forKey: keyValue.sampleId.rawValue) as? NSArray
        
        if naabFetch1!.count != 0 {
            let breedIdGet = naabFetch1![0] as? Int
            self.tissuId = breedIdGet!
        }
        
        let inheritBreed = fetchAllDataProductBeefId(entityName: Entities.getBreedsTblEntity, breedName: (self.inheritBreedBttn.titleLabel?.text!)!, productId: 20)
        
        if inheritBreed.count != 0 {
            let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
            self.breedId = medbreedRegArr1!.breedId ?? ""
        }
        
        if inheritBarcodeTextfield.text != "" {
            let animaBarcOde = fetchAnimaldataValidateAnimalBarcodeanimalId(entityName: Entities.beefAnimalMasterTblEntity, animalbarCodeTag: inheritBarcodeTextfield.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"true", custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),IsDataEmail: false)
            
            if animaBarcOde.count > 0   {
                inheritBarcodeView.layer.borderColor = UIColor.red.cgColor
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sampleAlreadyExists, comment: ""))
                return
            }
        }
        var dateVale = ""
        let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            dateVale = inheritDateTextField.text ?? ""
            if dateVale != ""{
                if dateStr == "DD"{
                    dateVale = inheritDateTextField.text ?? ""
                }
                else {
                    let values = dateVale.components(separatedBy: "/")
                    let date = values[0]
                    let month = values[1]
                    let year = values[2]
                    dateVale = month + "/" + date + "/" + year
                }
            }
        }
        else {
            dateVale = inheritDobBttn.titleLabel?.text ?? ""
            if dateVale != ""{
                if dateStr == "DD"{
                    dateVale = inheritDobBttn.titleLabel?.text ?? ""
                }
                else {
                    let values = dateVale.components(separatedBy: "/")
                    let date = values[0]
                    let month = values[1]
                    let year = values[2]
                    dateVale = month + "/" + date + "/" + year
                    
                }
            }
        }
        if inheritDateTextField.text?.count == 0 {}
        else {
            if inheritDateTextField.text?.count == 10 {
                let validate = isValidDate(dateString: inheritDateTextField.text ?? "")
                if validate == LocalizedStrings.correctFormatStr {
//                    inheritDobBttn.layer.borderColor = UIColor.gray.cgColor
//                    inheritDobBttn.layer.borderWidth = 0.5
                    validateDateFlag = true
                } else {
                    inheritDobBttn.layer.borderColor = UIColor.red.cgColor
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
                inheritDobBttn.layer.borderColor = UIColor.red.cgColor
                validateDateFlag = false
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
                return
            }
        }
        
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        incrementalBarCode = inheritBarcodeTextfield.text ?? ""
        
        //merged
        let animalData1 = fetchAnimaldataValidateAnimalTagDataEntry(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: inheritEarTagTextfield.text!,listId: listIdGet , custmerId: custmerId )
      var animalData  = [DataEntryBeefAnimaladdTbl]()
      if animalId1 != 0{
         animalData = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId: animalId1, orderId: orderId, userId: userId, orderStatus: "false",listId: listIdGet) as! [DataEntryBeefAnimaladdTbl]
      }
        
        
       // let animalData = fetchAnimaldataValidateAnimalTagDataEntry(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: inheritEarTagTextfield.text!,listId: listIdGet , custmerId: custmerId )
        
        if animalData.count > 0 || animalData1.count > 0  {
            isUpdate = true
            inheritUpdateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalMasterTblEntity, animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "false", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString,animalId: animalId1, sirYOB: inheritSireYobBttn.text ?? "", damYOB: inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "")
          
          inheritUpdateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalAddTblEntity, animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "false", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString,animalId: animalId1, sirYOB: inheritSireYobBttn.text ?? "", damYOB: inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "")
            
            inheritUpdateOrderStatusISyncAnimalMaster(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "true", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString,animalId: animalId1, sirYOB: inheritSireYobBttn.text ?? "", damYOB: inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "")
            
            updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId,offlineSync:false,listid: listIdGet)
            
            let fetchDataUpdate = fetchAnimalDataAccEarTag(entityName: Entities.beefAnimalAddTblEntity,animalTag:inheritEarTagTextfield.text ?? "", custmerId :Int64(custmerId ),providerid:pvid,productId:20)
            let fetchDataUpdate1 = fetchAnimalDataAccEarTag(entityName: Entities.dataEntryBeefAnimalAddTblEntity,animalTag:inheritEarTagTextfield.text ?? "",custmerId :Int64(custmerId ),providerid:pvid,productId:20)
            
            if fetchDataUpdate.count != 0 {
                updateOrderInfoBeefInherit(entity: Entities.beefAnimalAddTblEntity,animalTag: inheritEarTagTextfield.text ?? "", animalbarCodeTag: inheritBarcodeTextfield.text ?? "",date: dateVale,damId: inheritDamIdTextfield.text ?? "",sireId: inheritSireRegTextfield.text ?? "",gender: inheritGenderString,permanentId: inheritBreedRegTextfield.text ?? "",tissuName: inheritTissueBttn.titleLabel!.text ?? "",breedName: inheritBreedBttn.titleLabel!.text ?? "",et: inheritRegAssociationBttn.titleLabel?.text! ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:inheritEIDTextfield.text ?? "",nationHerdAU:inheritSecondaryIdTextfield.text ?? "",userId:userId,udid: timeStampString,sirYOB :inheritSireYobBttn.text ?? "",damYOB:inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "",productId:20,custmerId:Int64(custmerId ), editFlagSave: true)
                
                updateOrderInfoBeefInherit(entity: Entities.dataEntryBeefAnimalAddTblEntity,animalTag: inheritEarTagTextfield.text ?? "", animalbarCodeTag: inheritBarcodeTextfield.text ?? "",date: dateVale,damId: inheritDamIdTextfield.text ?? "",sireId: inheritSireRegTextfield.text ?? "",gender: inheritGenderString,permanentId: inheritBreedRegTextfield.text ?? "",tissuName: inheritTissueBttn.titleLabel!.text ?? "",breedName: inheritBreedBttn.titleLabel!.text ?? "",et: inheritRegAssociationBttn.titleLabel?.text! ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:inheritEIDTextfield.text ?? "",nationHerdAU:inheritSecondaryIdTextfield.text ?? "",userId:userId,udid: timeStampString,sirYOB :inheritSireYobBttn.text ?? "",damYOB:inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "",productId:20,custmerId:Int64(custmerId ), editFlagSave: true)
                
                updateOrderInfoBeefInherit(entity: Entities.beefAnimalMasterTblEntity,animalTag: inheritEarTagTextfield.text ?? "", animalbarCodeTag: inheritBarcodeTextfield.text ?? "",date: dateVale,damId: inheritDamIdTextfield.text ?? "",sireId: inheritSireRegTextfield.text ?? "",gender: inheritGenderString,permanentId: inheritBreedRegTextfield.text ?? "",tissuName: inheritTissueBttn.titleLabel!.text ?? "",breedName: inheritBreedBttn.titleLabel!.text ?? "",et: inheritRegAssociationBttn.titleLabel?.text! ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:inheritEIDTextfield.text ?? "",nationHerdAU:inheritSecondaryIdTextfield.text ?? "",userId:userId,udid: timeStampString,sirYOB :inheritSireYobBttn.text ?? "",damYOB:inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "",productId:20,custmerId:Int64(custmerId ), editFlagSave: true)
                
                updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId,offlineSync:false,listid: listIdGet)
            }
            
            
            if fetchDataUpdate1.count != 0 {
                updateOrderInfoBeefInherit(entity: Entities.dataEntryBeefAnimalAddTblEntity,animalTag: inheritEarTagTextfield.text ?? "", animalbarCodeTag: inheritBarcodeTextfield.text ?? "",date: dateVale,damId: inheritDamIdTextfield.text ?? "",sireId: inheritSireRegTextfield.text ?? "",gender: inheritGenderString,permanentId: inheritBreedRegTextfield.text ?? "",tissuName: inheritTissueBttn.titleLabel!.text ?? "",breedName: inheritBreedBttn.titleLabel!.text ?? "",et: inheritRegAssociationBttn.titleLabel?.text! ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:inheritEIDTextfield.text ?? "",nationHerdAU:inheritSecondaryIdTextfield.text ?? "",userId:userId,udid: timeStampString,sirYOB :inheritSireYobBttn.text ?? "",damYOB:inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "",productId:20,custmerId:Int64(custmerId ), editFlagSave: true)
                
                updateOrderInfoBeefInherit(entity: Entities.beefAnimalMasterTblEntity,animalTag: inheritEarTagTextfield.text ?? "", animalbarCodeTag: inheritBarcodeTextfield.text ?? "",date: dateVale,damId: inheritDamIdTextfield.text ?? "",sireId: inheritSireRegTextfield.text ?? "",gender: inheritGenderString,permanentId: inheritBreedRegTextfield.text ?? "",tissuName: inheritTissueBttn.titleLabel!.text ?? "",breedName: inheritBreedBttn.titleLabel!.text ?? "",et: inheritRegAssociationBttn.titleLabel?.text! ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:inheritEIDTextfield.text ?? "",nationHerdAU:inheritSecondaryIdTextfield.text ?? "",userId:userId,udid: timeStampString,sirYOB :inheritSireYobBttn.text ?? "",damYOB:inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "",productId:20,custmerId:Int64(custmerId ), editFlagSave: true)
              
              updateOrderInfoBeefInherit(entity: Entities.beefAnimalAddTblEntity,animalTag: inheritEarTagTextfield.text ?? "", animalbarCodeTag: inheritBarcodeTextfield.text ?? "",date: dateVale,damId: inheritDamIdTextfield.text ?? "",sireId: inheritSireRegTextfield.text ?? "",gender: inheritGenderString,permanentId: inheritBreedRegTextfield.text ?? "",tissuName: inheritTissueBttn.titleLabel!.text ?? "",breedName: inheritBreedBttn.titleLabel!.text ?? "",et: inheritRegAssociationBttn.titleLabel?.text! ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:inheritEIDTextfield.text ?? "",nationHerdAU:inheritSecondaryIdTextfield.text ?? "",userId:userId,udid: timeStampString,sirYOB :inheritSireYobBttn.text ?? "",damYOB:inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "",productId:20,custmerId:Int64(custmerId ), editFlagSave: true)
                updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId,offlineSync:false,listid: listIdGet)
            }
            
            updateOrderStatusISyncProduct(entity: Entities.productAdonAnimlBeefTblEntity,animalTag: inheritEarTagTextfield.text!,barCodetag:  inheritBarcodeTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId:animalId1)
            updateOrderStatusISyncSubProduct(entity: Entities.subProductBeefTblEntity,animalTag: inheritEarTagTextfield.text!,barCodetag:  inheritBarcodeTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId: animalId1)
            
            let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: "",animalTag:inheritEarTagTextfield.text!,barcodeTag:inheritBarcodeTextfield.text!)
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            
            if adata.count > 0{
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                inheritByDefaultSetting()
                return
            }
            
            else if animalDataMaster.count > 0 {
                if  msgUpatedd == true{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalRecordUpdated, comment: ""))
                    UserDefaults.standard.set(inheritBreedBttn.titleLabel?.text, forKey: keyValue.dataEntryInheritBeefbreedClear.rawValue)
                    UserDefaults.standard.set(inheritTissueBttn.titleLabel?.text, forKey: keyValue.dataEntryBeefInheritTsuClear.rawValue)
                    UserDefaults.standard.set(inheritBreedBttn.titleLabel?.text, forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
                    UserDefaults.standard.set(inheritTissueBttn.titleLabel?.text, forKey: keyValue.dataEntryBeefInheritTsu.rawValue)
                    inheritByDefaultSetting()
                    return
                }
                else{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                    inheritByDefaultSetting()
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
            inheritUpdateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalMasterTblEntity, animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "false", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString,animalId: animalId1, sirYOB: inheritSireYobBttn.text ?? "", damYOB: inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "")
          
          inheritUpdateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalAddTblEntity, animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "false", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString,animalId: animalId1, sirYOB: inheritSireYobBttn.text ?? "", damYOB: inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "")
            
            inheritUpdateOrderStatusISyncAnimalMaster(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "true", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString,animalId: animalId1, sirYOB: inheritSireYobBttn.text ?? "", damYOB: inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "")
            
            updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId,offlineSync:false,listid: listIdGet)
            
            if identify1 == true {
                let data1 = fetchAllDataOrderStatus(entityName: Entities.dataEntryBeefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
                if data1.count > 0 {
                    completionHandler(true)
                    return
                }
            }
            isautoPopulated = false
            let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: "",animalTag:inheritEarTagTextfield.text!,barcodeTag:inheritBarcodeTextfield.text!)
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            
            if adata.count > 0{
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                inheritByDefaultSetting()
                return
            }
            
            else if animalDataMaster.count > 0 {
                if msgUpatedd == true{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalRecordUpdated, comment: ""))
                    UserDefaults.standard.set(inheritBreedBttn.titleLabel?.text, forKey: keyValue.dataEntryInheritBeefbreedClear.rawValue)
                    UserDefaults.standard.set(inheritTissueBttn.titleLabel?.text, forKey: keyValue.dataEntryBeefInheritTsuClear.rawValue)
                    UserDefaults.standard.set(inheritBreedBttn.titleLabel?.text, forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
                    UserDefaults.standard.set(inheritTissueBttn.titleLabel?.text, forKey: keyValue.dataEntryBeefInheritTsu.rawValue)
                    inheritByDefaultSetting()
                    return
                }
                else{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                    inheritByDefaultSetting()
                    
                }
            }
            completionHandler(true)
            scrolView.contentOffset.y = 0.0
        }
        else {
            let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
            if product.count > 0 {
                pid = product[0] as? GetProductTblBeef
            }
            
            isUpdate = false
            var animalID1 = UserDefaults.standard.integer(forKey: keyValue.animalId.rawValue)
            
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId :inheritAnimalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            if animalDataMaster.count > 0{
                if animalID1 == 0 {
                    animalID1 = animalID1 + 1
                    UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                    
                }
                else {
                    animalID1 = animalID1 + 1
                    UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                }
                
                InheritUpdateOrderStatusISyncAnimalMasterAnimalId(entity: Entities.beefAnimalMasterTblEntity, animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "true", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1, sirYOB: inheritSireYobBttn.text ?? "", DamYOB: inheritDamYobBttn.text ?? "", sireRegAssocation: inheriSireRedOutlet.titleLabel?.text ?? "")
              
              InheritUpdateOrderStatusISyncAnimalMasterAnimalId(entity: Entities.beefAnimalAddTblEntity, animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "true", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1, sirYOB: inheritSireYobBttn.text ?? "", DamYOB: inheritDamYobBttn.text ?? "", sireRegAssocation: inheriSireRedOutlet.titleLabel?.text ?? "")
              
              InheritUpdateOrderStatusISyncAnimalMasterAnimalId(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "true", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1, sirYOB: inheritSireYobBttn.text ?? "", DamYOB: inheritDamYobBttn.text ?? "", sireRegAssocation: inheriSireRedOutlet.titleLabel?.text ?? "")
                
                let fetchDataUpdate = fetchAnimalDataAccEarTag(entityName: Entities.beefAnimalAddTblEntity,animalTag:inheritEarTagTextfield.text ?? "",custmerId :Int64(custmerId ),providerid:pvid,productId:20)
                let fetchDataUpdate1 = fetchAnimalDataAccEarTag(entityName: Entities.dataEntryBeefAnimalAddTblEntity,animalTag:inheritEarTagTextfield.text ?? "",custmerId :Int64(custmerId ),providerid:pvid,productId:20)
                
                print(fetchDataUpdate)
                
                if fetchDataUpdate.count != 0 {
                    
                    updateOrderInfoBeefInherit(entity: Entities.beefAnimalAddTblEntity,animalTag: inheritEarTagTextfield.text ?? "", animalbarCodeTag: inheritBarcodeTextfield.text ?? "",date: dateVale,damId: inheritDamIdTextfield.text ?? "",sireId: inheritSireRegTextfield.text ?? "",gender: inheritGenderString,permanentId: inheritBreedRegTextfield.text ?? "",tissuName: inheritTissueBttn.titleLabel!.text ?? "",breedName: inheritBreedBttn.titleLabel!.text ?? "",et: inheritRegAssociationBttn.titleLabel?.text! ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:inheritEIDTextfield.text ?? "",nationHerdAU:inheritSecondaryIdTextfield.text ?? "",userId:userId,udid: timeStampString,sirYOB :inheritSireYobBttn.text ?? "",damYOB:inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "",productId:20,custmerId:Int64(custmerId ), editFlagSave: true)
                    
                    updateOrderInfoBeefInherit(entity: Entities.dataEntryBeefAnimalAddTblEntity,animalTag: inheritEarTagTextfield.text ?? "", animalbarCodeTag: inheritBarcodeTextfield.text ?? "",date: dateVale,damId: inheritDamIdTextfield.text ?? "",sireId: inheritSireRegTextfield.text ?? "",gender: inheritGenderString,permanentId: inheritBreedRegTextfield.text ?? "",tissuName: inheritTissueBttn.titleLabel!.text ?? "",breedName: inheritBreedBttn.titleLabel!.text ?? "",et: inheritRegAssociationBttn.titleLabel?.text! ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:inheritEIDTextfield.text ?? "",nationHerdAU:inheritSecondaryIdTextfield.text ?? "",userId:userId,udid: timeStampString,sirYOB :inheritSireYobBttn.text ?? "",damYOB:inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "",productId:20,custmerId:Int64(custmerId ), editFlagSave: true)
                    
                    updateOrderInfoBeefInherit(entity: Entities.beefAnimalMasterTblEntity,animalTag: inheritEarTagTextfield.text ?? "", animalbarCodeTag: inheritBarcodeTextfield.text ?? "",date: dateVale,damId: inheritDamIdTextfield.text ?? "",sireId: inheritSireRegTextfield.text ?? "",gender: inheritGenderString,permanentId: inheritBreedRegTextfield.text ?? "",tissuName: inheritTissueBttn.titleLabel!.text ?? "",breedName: inheritBreedBttn.titleLabel!.text ?? "",et: inheritRegAssociationBttn.titleLabel?.text! ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:inheritEIDTextfield.text ?? "",nationHerdAU:inheritSecondaryIdTextfield.text ?? "",userId:userId,udid: timeStampString,sirYOB :inheritSireYobBttn.text ?? "",damYOB:inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "",productId:20,custmerId:Int64(custmerId ), editFlagSave: true)
                    
                    updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId,offlineSync:false,listid: listIdGet)
                }
                
                
                if fetchDataUpdate1.count != 0 {
                    updateOrderInfoBeefInherit(entity: Entities.dataEntryBeefAnimalAddTblEntity,animalTag: inheritEarTagTextfield.text ?? "", animalbarCodeTag: inheritBarcodeTextfield.text ?? "",date: dateVale,damId: inheritDamIdTextfield.text ?? "",sireId: inheritSireRegTextfield.text ?? "",gender: inheritGenderString,permanentId: inheritBreedRegTextfield.text ?? "",tissuName: inheritTissueBttn.titleLabel!.text ?? "",breedName: inheritBreedBttn.titleLabel!.text ?? "",et: inheritRegAssociationBttn.titleLabel?.text! ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:inheritEIDTextfield.text ?? "",nationHerdAU:inheritSecondaryIdTextfield.text ?? "",userId:userId,udid: timeStampString,sirYOB :inheritSireYobBttn.text ?? "",damYOB:inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "",productId:20,custmerId:Int64(custmerId ), editFlagSave: true)
                    
                    updateOrderInfoBeefInherit(entity: Entities.beefAnimalMasterTblEntity,animalTag: inheritEarTagTextfield.text ?? "", animalbarCodeTag: inheritBarcodeTextfield.text ?? "",date: dateVale,damId: inheritDamIdTextfield.text ?? "",sireId: inheritSireRegTextfield.text ?? "",gender: inheritGenderString,permanentId: inheritBreedRegTextfield.text ?? "",tissuName: inheritTissueBttn.titleLabel!.text ?? "",breedName: inheritBreedBttn.titleLabel!.text ?? "",et: inheritRegAssociationBttn.titleLabel?.text! ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:inheritEIDTextfield.text ?? "",nationHerdAU:inheritSecondaryIdTextfield.text ?? "",userId:userId,udid: timeStampString,sirYOB :inheritSireYobBttn.text ?? "",damYOB:inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "",productId:20,custmerId:Int64(custmerId ), editFlagSave: true)
                  
                  updateOrderInfoBeefInherit(entity: Entities.beefAnimalAddTblEntity,animalTag: inheritEarTagTextfield.text ?? "", animalbarCodeTag: inheritBarcodeTextfield.text ?? "",date: dateVale,damId: inheritDamIdTextfield.text ?? "",sireId: inheritSireRegTextfield.text ?? "",gender: inheritGenderString,permanentId: inheritBreedRegTextfield.text ?? "",tissuName: inheritTissueBttn.titleLabel!.text ?? "",breedName: inheritBreedBttn.titleLabel!.text ?? "",et: inheritRegAssociationBttn.titleLabel?.text! ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:inheritEIDTextfield.text ?? "",nationHerdAU:inheritSecondaryIdTextfield.text ?? "",userId:userId,udid: timeStampString,sirYOB :inheritSireYobBttn.text ?? "",damYOB:inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "",productId:20,custmerId:Int64(custmerId ), editFlagSave: true)
                  
                    updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId,offlineSync:false,listid: listIdGet)
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
                
                let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"true" )
                if animalDataMaster.count > 0{
                    InheritUpdateOrderStatusISyncAnimalMasterAnimalId(entity: Entities.beefAnimalMasterTblEntity, animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "false", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU:inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1, sirYOB: inheritSireYobBttn.text ?? "", DamYOB: inheritDamYobBttn.text ?? "", sireRegAssocation: inheriSireRedOutlet.titleLabel?.text ?? "")
                    updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId,offlineSync:false,listid: listIdGet)
                }
                else {
                    
                    inheritSaveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "false", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: (inheritBreedBttn.titleLabel?.text!)!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString, animalId: animalID1,productId:Int(pid?.productId ?? 0), sirYOB: inheritSireYobBttn.text ?? "", damYOB: inheritDamYobBttn.text ?? "", sireRegAssocation: inheriSireRedOutlet.titleLabel?.text ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listIdGet), serverAnimalId: "", tertiaryGeno: "")
                    updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId,offlineSync:false,listid: listIdGet)
                }
            }
            
            let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:orderId, customerID: custmerId)
            if data12333.count > 0{
             //   if inheritTissueBttn.titleLabel!.text! == ButtonTitles.allflexTSUText || inheritTissueBttn.titleLabel!.text! == ButtonTitles.allflexTSTText || //inheritTissueBttn.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                    inheritSaveAnimaldataBeefInProductId(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "true", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString, animalId: animalID1,productId: Int(pid?.productId ?? 0), sirYOB: inheritSireYobBttn.text ?? "", damYOB: inheritDamYobBttn.text ?? "", sireRegAssocation: inheriSireRedOutlet.titleLabel?.text ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listIdGet), serverAnimalId: "", tertiaryGeno: "")
                    updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId,offlineSync:false,listid: listIdGet)
                    
             //   }
//                else{
//                    let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
//                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
//                        UIAlertAction in
//                        self.inheritByDefaultSetting()
//                    }
//                    let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
//                        UIAlertAction in
//                        deleteDataWithProductwithEntity(animalID1,entity: Entities.productAdonAnimlBeefTblEntity)
//                        deleteDataWithProductwithEntity(animalID1, entity: Entities.subProductBeefTblEntity)
//                        if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
//
//                            let animalCount = fetchDataEnteryAnimalTblBeefData(entityName: Entities.dataEntryBeefAnimalAddTblEntity,customerId:self.custmerId ,listId:Int64(self.listIdGet ),productId:19) as!  [DataEntryBeefAnimaladdTbl]
//                            self.notificationLblCount.text = String(animalCount.count)
//                            if animalCount.count == 0{
//                                self.notificationLblCount.isHidden = true
//                                self.countLbl.isHidden = true
//                            }
//                            else {
//                                self.notificationLblCount.isHidden = false
//                                self.countLbl.isHidden = false
//                            }
//                        }
//                        else {
//                            let animalCount = fetchDataEnteryAnimalTblBeefData(entityName: Entities.dataEntryBeefAnimalAddTblEntity,customerId:self.custmerId ,listId:Int64(self.listIdGet ),productId:0) as!  [DataEntryBeefAnimaladdTbl]
//                            self.notificationLblCount.text = String(animalCount.count)
//                            if animalCount.count == 0{
//                                self.notificationLblCount.isHidden = true
//                                self.countLbl.isHidden = true
//                            }
//                            else {
//                                self.notificationLblCount.isHidden = false
//                                self.countLbl.isHidden = false
//                            }
//                        }
//                        self.inheritByDefaultSetting()
//                        return
//                    }
//
//                    alertController.addAction(okAction)
//                    alertController.addAction(cancelAction)
//                    self.present(alertController, animated: true, completion: nil)
//                    return
//                }
            }
            else {
                inheritSaveAnimaldataBeefInProductId(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "true", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString, animalId: animalID1,productId: Int(pid?.productId ?? 0), sirYOB: inheritSireYobBttn.text ?? "", damYOB: inheritDamYobBttn.text ?? "", sireRegAssocation: inheriSireRedOutlet.titleLabel?.text ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listIdGet), serverAnimalId: "", tertiaryGeno: "")
                updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custmerId,offlineSync:false,listid: listIdGet)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAdded, comment: ""), duration: 2, position: .bottom)
            }
            
            UserDefaults.standard.set(inheritBreedBttn.titleLabel?.text, forKey: keyValue.dataEntryInheritBeefbreedClear.rawValue)
            UserDefaults.standard.set(inheritTissueBttn.titleLabel?.text, forKey: keyValue.dataEntryBeefInheritTsuClear.rawValue)
            UserDefaults.standard.set(inheritBreedBttn.titleLabel?.text, forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
            UserDefaults.standard.set(inheritTissueBttn.titleLabel?.text, forKey: keyValue.dataEntryBeefInheritTsu.rawValue)
            
            if isBarcodeAutoIncrementedEnabled == true {
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
            } else {
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
            }
            
        //    self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            inheritByDefaultSetting()
            
//            inheritGenderToggleFlag = 0
//            inheritGenderString = ButtonTitles.femaleText.localized
            barAutoPopu = false
            self.inheritScrollView.contentOffset.y = 0.0
            inheritEarTagTextfield.text = ""
            if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
                let animalCount = fetchDataEnteryAnimalTblBeefData(entityName: Entities.dataEntryBeefAnimalAddTblEntity,customerId:custmerId ,listId:Int64(self.listIdGet ),productId:19) as!  [DataEntryBeefAnimaladdTbl]
                notificationLblCount.text = String(animalCount.count)
                if animalCount.count == 0{
                    notificationLblCount.isHidden = true
                    countLbl.isHidden = true
                    self.cartView.isHidden = true
                }
            }
            else {
                let animalCount = fetchDataEnteryAnimalTblBeefDataBrazil(entityName: Entities.dataEntryBeefAnimalAddTblEntity,customerId:custmerId ,listId:Int64(self.listIdGet ),providerId: beefPvid) as!  [DataEntryBeefAnimaladdTbl]
                notificationLblCount.text = String(animalCount.count)
                if animalCount.count == 0{
                    notificationLblCount.isHidden = true
                    countLbl.isHidden = true
                    self.cartView.isHidden = true
                }
            }
            let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
            let formatter = DateFormatter()
            
            if dateStr == "MM"{
                formatter.dateFormat = DateFormatters.MMddyyyyFormat
            }
            else {
                formatter.dateFormat = DateFormatters.ddMMyyyyFormat
            }
            inheritDobBttn.setTitle("", for: .normal)
            dateVale = ""
            inheritDobBttn.setTitle(nil, for: .normal)
            
            completionHandler(true)
        }
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
            UserDefaults.standard.set(incrementalBarCode, forKey: keyValue.barcodeIncremental.rawValue)
        }
        incrementalBarCode = ""
        inheritTextFieldBackroungGrey()
        view.endEditing(true)
    }
    
    func inheritSireYOBDoDatePicker(){
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
        self.datePicker.setDate(InheritSireSelectedDate, animated: true)
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
        let doneButton = UIBarButtonItem(title:  NSLocalizedString(LocalizedStrings.doneStr, comment: ""), style: .plain, target: self, action: #selector(self.InheritSireYOBDoneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title:  NSLocalizedString("Cancel", comment: ""), style: .plain, target: self, action: #selector(self.inheritSireCancelClick))
        cancelButton.tintColor = UIColor.black
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = CGRect(x: 0, y: 0, width: self.calenderView.frame.size.width, height: 40)
        self.calenderView.addSubview(toolBar)
        self.toolBar.isHidden = false
    }
    
    func inheritDamYOBDoDatePicker(){
        self.datePicker = UIDatePicker(frame:CGRect(x: 20, y: 40, width: self.calenderView.frame.size.width, height: 260))
        self.datePicker?.backgroundColor = UIColor.white
        if langId == 2{
            self.datePicker?.locale = Locale(identifier: Languages.portuguese)
        }
        else if langId == 3{
            self.datePicker?.locale = Locale(identifier: Languages.italian)
        }
        else{
            self.datePicker?.locale = Locale(identifier: Languages.eng)
        }
        self.datePicker?.datePickerMode = UIDatePicker.Mode.date
        self.datePicker.setDate(InheritDamSelectedDate, animated: true)
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
        let doneButton = UIBarButtonItem(title:  NSLocalizedString(LocalizedStrings.doneStr, comment: ""), style: .plain, target: self, action: #selector(self.InheritDamYOBDoneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title:  NSLocalizedString("Cancel", comment: ""), style: .plain, target: self, action: #selector(self.inheritDamCancelClick))
        cancelButton.tintColor = UIColor.black
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = CGRect(x: 0, y: 0, width: self.calenderView.frame.size.width, height: 40)
        self.calenderView.addSubview(toolBar)
        self.toolBar.isHidden = false
    }
    
    func inheritTextFieldBackroungGrey(){
        inheritExpandBtnOutlet.alpha = 0.4
        inheritExpandBtnOutlet.isEnabled = false
        inheritDobBttn.setTitleColor(.gray, for: .normal)
        inheritTissueBttn.setTitleColor(.gray, for: .normal)
        inheritMaleFemaleBttn.setTitleColor(.gray, for: .normal)
        inheriSireRedOutlet.setTitleColor(.gray, for: .normal)
        inheritDobBttn.setTitle("", for: .normal)
        inheritDobBttn.setTitle(nil, for: .normal)
        inheritBreedBttn.setTitleColor(.gray, for: .normal)
        inheritRegAssociationBttn.setTitleColor(UIColor.gray, for: .normal)
        inheritDamYobBttn.textColor = .gray
        inheritSireYobBttn.textColor = .gray
        inheritMaleFemaleBttn.isEnabled = false
        inheritDobBttn.isEnabled = false
        inheritDobBttn.isEnabled = false
        inheritSireYobBttn.isEnabled = false
        inheritDamYobBttn.isEnabled = false
        inheritbarcodeBttn.isEnabled = false
        ocrBtnOutlet.isEnabled = false
        inheritBarcodeTextfield.isEnabled = false
        inheritDamIdTextfield.isEnabled = false
        inheritSireRegTextfield.isEnabled = false
        inheritBreedRegTextfield.isEnabled = false
        inheritRegAssociationBttn.isEnabled = false
        inheritEIDTextfield.isEnabled = false
        inheritSecondaryIdTextfield.isEnabled = false
        inheritDateTextField.isEnabled = false
        inheritTissueBttn.isEnabled = false
        inheritBreedBttn.isEnabled = false
        inheritRegAssociationBttn.isEnabled = false
        inheriSireRedOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        inheritMaleFemaleBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        inheritDobBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        inheritBarcodeTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        inheritDamIdTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        inheritSireRegTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        inheritEIDView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        inheritBarcodeView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
  
        inheritBreedBttn.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        inheritTissueBttn.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        inheritRegAssociationBttn.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        inheritBreedRegTextfield.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        inheritDamYobBttn.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        inheritSireYobBttn.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        inheritEIDTextfield.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        inheritSecondaryIdTextfield.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        inheritDobBttn.setTitle(nil, for: .normal)
        inheritDobBttn.setTitle("", for: .normal)
        inheritDateTextField.text = ""
        if isautoPopulated == false {
            incrementalBarcodeTitleLabelInherit.textColor = .black
            incrementalBarcodeButtonInherit.isEnabled = true
            incrementalBarcodeCheckBoxInherit.alpha = 1
            incrementalBarcodeTitleLabelInherit.alpha = 1
            if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
                if let lastSavedBarCode = UserDefaults.standard.value(forKey: keyValue.barcodeIncremental.rawValue) as? String {
                    inheritBarcodeTextfield.textColor = UIColor.gray
                    inheritBarcodeTextfield.text = isBarCodeEndsWithNumber_GetIncrementedBarCode(lastSavedBarCode).incrementedBarCode
                }
            }
        } else {
            incrementalBarcodeTitleLabelInherit.textColor = UIColor.gray
            incrementalBarcodeButtonInherit.isEnabled = false
            incrementalBarcodeCheckBoxInherit.alpha = 0.6
            incrementalBarcodeTitleLabelInherit.alpha = 0.6
        }
    }
    
    func inherittextFieldBackroungWhite(){
      
        inheritExpandBtnOutlet.alpha = 1
        inheritExpandBtnOutlet.isEnabled = true
        inheriSireRedOutlet.setTitleColor(.black, for: .normal)
        inheritMaleFemaleBttn.setTitleColor(.black, for: .normal)
        inheritDobBttn.setTitleColor(.black, for: .normal)
        inheritTissueBttn.setTitleColor(.black, for: .normal)
        inheritBreedBttn.setTitleColor(.black, for: .normal)
        inheritRegAssociationBttn.setTitleColor(UIColor.black, for: .normal)
        inheritDamYobBttn.textColor = .black
        inheritSireYobBttn.textColor = .black
        inheritMaleFemaleBttn.isEnabled = true
        inheritMaleFemaleBttn.setTitleColor(.black, for: .normal)
        inheritDobBttn.isEnabled = true
        inheritbarcodeBttn.isEnabled = true
        ocrBtnOutlet.isEnabled = true
        inheritBarcodeTextfield.isEnabled = true
        inheritDamIdTextfield.isEnabled = true
        inheritSireRegTextfield.isEnabled = true
        inheritBreedRegTextfield.isEnabled = true
        inheritTissueBttn.isEnabled = true
        inheritBreedBttn.isEnabled = true
        inheritRegAssociationBttn.isEnabled = true
        inheritEIDTextfield.isEnabled = true
        inheritSecondaryIdTextfield.isEnabled = true
        inheriSireRedOutlet.isEnabled = true
        inheritDobBttn.isEnabled = true
        inheritSireYobBttn.isEnabled = true
        inheritDamYobBttn.isEnabled = true
        inheriSireRedOutlet.backgroundColor = UIColor.white
        inheritDobBttn.backgroundColor = UIColor.white
        inheritBarcodeTextfield.backgroundColor = UIColor.white
        inheritDamIdTextfield.backgroundColor = UIColor.white
        inheritSireRegTextfield.backgroundColor = UIColor.white
        inheritBarcodeView.backgroundColor = UIColor.white
        inheritEIDView.backgroundColor = UIColor.white
      //  animalNameTextfield.backgroundColor = UIColor.white
        inheritBreedBttn.backgroundColor = UIColor.white
        inheritMaleFemaleBttn.backgroundColor = UIColor.white
        inheritTissueBttn.backgroundColor = UIColor.white
        inheritRegAssociationBttn.backgroundColor = UIColor.white
        inheritBreedRegTextfield.backgroundColor = UIColor.white
        inheritDamYobBttn.backgroundColor = .white
        inheritSireYobBttn.backgroundColor = .white
        inheritEIDTextfield.backgroundColor = .white
        inheritSecondaryIdTextfield.backgroundColor = .white
        inheritDateTextField.text = ""
        inheritDateTextField.isEnabled = true
        inheritBarcodeTextfield.textColor = UIColor.black
        if isautoPopulated == false {
            incrementalBarcodeTitleLabelInherit.textColor = .black
            incrementalBarcodeButtonInherit.isEnabled = true
            incrementalBarcodeCheckBoxInherit.alpha = 1
            incrementalBarcodeTitleLabelInherit.alpha = 1
            if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
                if let lastSavedBarCode = UserDefaults.standard.value(forKey: keyValue.barcodeIncremental.rawValue) as? String {
                    inheritBarcodeTextfield.text = isBarCodeEndsWithNumber_GetIncrementedBarCode(lastSavedBarCode).incrementedBarCode
                }
            }
        } else {
            incrementalBarcodeTitleLabelInherit.textColor = UIColor.gray
            incrementalBarcodeButtonInherit.isEnabled = false
            incrementalBarcodeCheckBoxInherit.alpha = 0.6
            incrementalBarcodeTitleLabelInherit.alpha = 0.6
        }
    }
    
    func inheritValidation(){
        if inheritEarTagTextfield.text == ""{
            inheritEarTagView.layer.borderColor = UIColor.red.cgColor
        }
        else {
            inheritEarTagView.layer.borderColor = UIColor.gray.cgColor
        }
        if inheritSireRegTextfield.text != ""{
            if inheriSireRedOutlet.titleLabel?.text != NSLocalizedString(LocalizedStrings.selectSireReg, comment: "") {
                inheriSireRedOutlet.layer.borderColor = UIColor.gray.cgColor
            } else {
                inheriSireRedOutlet.layer.borderColor = UIColor.red.cgColor
            }
            inheritSireRegTextfield.layer.borderColor = UIColor.gray.cgColor
        }
    }
}
