//
//  BeefAnimalGlobalHD50KVCInheritMethods.swift
//  SearchPoint
//
//  Created by Mobile Programming on 20/03/24.
//

import Foundation
import UIKit

extension BeefAnimalGlobalHD50KVC {
    func inheritDoDatePicker(){
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
        self.datePicker.setDate(InheritSelectedDate, animated: true)
        
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
        let doneButton = UIBarButtonItem(title: "Done".localized, style: .plain, target: self, action: #selector(self.InheritDoneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel".localized, style: .plain, target: self, action: #selector(self.inheritCancelClick))
        cancelButton.tintColor = UIColor.black
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = CGRect(x: 0, y: 0, width: self.calenderView.frame.size.width, height: 40)
        self.calenderView.addSubview(toolBar)
        self.toolBar.isHidden = false
    }
    
    func inheritByDefaultSetting(){
        dobLbl.textColor = UIColor.gray
        inheritDobLbl.textColor = UIColor.gray
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
        inheritDobBttn.setTitleColor(UIColor.gray, for: .normal)
        inheritBreedBttn.setTitleColor(UIColor.gray, for: .normal)
        isautoPopulated = false
        inheritBarcodeView.layer.borderColor = UIColor.gray.cgColor
        inheritDamYobBttn.placeholder = NSLocalizedString(ButtonTitles.DamYOBText, comment: "")
        inheritDamYobBttn.layer.borderColor = UIColor.gray.cgColor
        inheriSireRedOutlet.layer.borderColor = UIColor.gray.cgColor
        inheritSireYobBttn.placeholder = NSLocalizedString(ButtonTitles.SireYOB, comment: "")
        inheriSireRedOutlet.layer.borderWidth = 0.5
        inheritSireRegTextfield.layer.borderWidth = 0.5
        inheritDamYobBttn.layer.borderWidth = 0.5
        inheritTissueBttn.layer.borderWidth = 0.5
        inheritBreedBttn.layer.borderWidth = 0.5
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
        breedRegTextfield.text?.removeAll()
        inheritEarTagTextfield.text?.removeAll()
        inheritEIDTextfield.text?.removeAll()
        inheritSecondaryIdTextfield.text?.removeAll()
        inheriSireRedOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectSireReg, comment: ""), for: .normal)
        
    
        if UserDefaults.standard.value(forKey: "InheritBeefGender")  as? String  == "F" || UserDefaults.standard.value(forKey: "InheritBeefGender") == nil {
            self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            inheritGenderToggleFlag = 0
            inheritGenderString = "Female".localized
            UserDefaults.standard.set("F", forKey: "InheritBeefGender")
        } else {
            self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
            inheritGenderToggleFlag = 1
            inheritGenderString = "Male".localized
            UserDefaults.standard.set("M", forKey: "InheritBeefGender")
        }
        inheriSireRedOutlet.isEnabled = false
        inheriSireRedOutlet.setTitleColor(.gray, for: .normal)
        inheritBreedBttn.setTitleColor(.gray, for: .normal)
        inheritTissueBttn.setTitleColor(.gray, for: .normal)
        self.InheritSelectedDate = Date()
        inheritTextFieldBackroungGrey()
        self.inheritScrollView.contentOffset.y = 0.0
        
        if UserDefaults.standard.string(forKey: keyValue.beefInheritTSU.rawValue) == nil || UserDefaults.standard.string(forKey: keyValue.beefInheritTSU.rawValue) == ""{
            inheritTissueBttn.setTitle(ButtonTitles.allflexTSUText, for: .normal)
            tissuId = 1
        }
        else{
            inheritTissueBttn.setTitle(UserDefaults.standard.string(forKey: keyValue.beefInheritTSU.rawValue)?.localized, for: .normal)
        }
        
        if UserDefaults.standard.string(forKey: keyValue.inheritBeefbreed.rawValue) == "" || UserDefaults.standard.string(forKey: keyValue.inheritBeefbreed.rawValue) == nil{
            inheritBreedBttn.setTitle("", for: .normal)
            breedId = "d352c4c2-2ff9-451a-9c00-4f0f5604b387"
        }
        else{
            let savedBreed = UserDefaults.standard.string(forKey: keyValue.inheritBeefbreed.rawValue)
            if savedBreed == LocalizedStrings.breedNameX{
                self.inheritBreedBttn.setTitle("XX", for: .normal)
            } else {
                inheritBreedBttn.setTitle(savedBreed, for: .normal)
            }
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
        inheritDobBttn.titleLabel?.text = ""
        incrementalBarcodeTitleLabelInherit.textColor = .gray
        incrementalBarcodeButtonInherit.isEnabled = false
        incrementalBarcodeCheckBoxInherit.alpha = 0.6
        incrementalBarcodeTitleLabelInherit.alpha = 0.6
        self.inheritEarTagTextfield.becomeFirstResponder()
        autoPopulateAnimalData = nil
        isAnimalComingFromCart = false
    }
    
    func inheritAddBtnCondtion(completionHandler: CompletionHandler){
        if checkBarcode {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.barcodeMustEndWithNumAlert, comment: ""))
            return
        }
        
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        
        let barCode = fetchAnimaldataValidateAnimalBarcodeanimalIdOrderId(entityName: Entities.beefAnimalAddTblEntity, animalbarCodeTag: inheritBarcodeTextfield.text ?? "", userId: userId, animalId: animalId1,orderSatatus:"false",orderid:orderId, custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)) as! [BeefAnimaladdTbl]
        
        if barCode.count > 0 && !isAnimalComingFromCart {
            inheritBarcodeView.layer.borderColor = UIColor.red.cgColor
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sampleAlreadyExists, comment: ""))
            return
        }
        else {
            inheritBarcodeView.layer.borderColor = UIColor.gray.cgColor
            let barcodeAnimals = fetchAllData(entityName: Entities.beefAnimalAddTblEntity) as! [BeefAnimaladdTbl]
            let animalfilter = barcodeAnimals.filter({ $0.animalbarCodeTag == inheritBarcodeTextfield.text})
            let animalOrderStatus = animalfilter.filter({ $0.orderstatus == "true"})
            
            if animalfilter.count > 0 && animalOrderStatus.count > 0 {
                inheritBarcodeView.layer.borderColor = UIColor.red.cgColor
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sampleAlreadyExists, comment: ""))
                return
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
        } else {
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
        
        if inheritDateTextField.text?.count == 0 {
            inheritDobBttn.layer.borderColor = UIColor.red.cgColor
            validateDateFlag = false
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
            return
        }
        else {
            if inheritDateTextField.text?.count == 10 {
                let validate = isValidDate(dateString: inheritDateTextField.text ?? "")
                
                
                if validate == LocalizedStrings.correctFormatStr {
                    inheritDobBttn.layer.borderColor = UIColor.gray.cgColor
                    inheritDobBttn.layer.borderWidth = 0.5
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
                }
            } else {
                inheritDobBttn.layer.borderColor = UIColor.red.cgColor
                validateDateFlag = false
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
                return
            }
        }
        
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        
        let beefAnimalData = fetchAllDataWithEarTagstatus(entityName: Entities.beefAnimalAddTblEntity, animalTag:autoPopulateAnimalData?.animalTag ?? "",orderststus:"true", customerId: self.custmerId, pvid: pvid)
        
        if beefAnimalData.count > 0 {
            let existAnimalData = beefAnimalData.lastObject as! BeefAnimaladdTbl
            if existAnimalData.orderstatus == "true" && existAnimalData.date != dateVale || existAnimalData.breedId != breedId || existAnimalData.gender?.localized != inheritGenderString || autoPopulateAnimalData?.animalTag != inheritEarTagTextfield.text {
                    
                    let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Animal Record cannot be updated as the animal has been used for an order.", comment: ""), preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId: Int(existAnimalData.animalId), customerID: self.custmerId)
                        self.autoPop(animalData: animalFetch)
                        self.barcodeEnable = false
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    statusOrder = false
                    self.inheritScrollView.contentOffset.y = 0.0
                    return
                
            }
        }
        
        incrementalBarCode = inheritBarcodeTextfield.text ?? ""
        
        let beefAnimalEartagData = fetchAllDataWithEarTagstatus(entityName: Entities.beefAnimalAddTblEntity, animalTag:inheritEarTagTextfield.text ?? "",orderststus:"false", customerId: self.custmerId, pvid: pvid)
        if beefAnimalEartagData.count > 0  {
            let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:orderId, customerID: custmerId)
            if data12333.count > 0 {
                if (inheritTissueBttn.titleLabel!.text! == ButtonTitles.allflexTSUText || inheritTissueBttn.titleLabel!.text! == ButtonTitles.allflexTSTText || inheritTissueBttn.titleLabel!.text! == ButtonTitles.caisleyTSUText) {
                    isUpdate = true
                    inheritUpdateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalMasterTblEntity, animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "false", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString,animalId: animalId1, sirYOB: inheritSireYobBttn.text ?? "", damYOB: inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "")
                    
                    inheritUpdateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalAddTblEntity, animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "true", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString,animalId: animalId1, sirYOB: inheritSireYobBttn.text ?? "", damYOB: inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "")
                    
                    let fetchDataUpdate = fetchAnimalDataAccEarTag(entityName: Entities.dataEntryBeefAnimalAddTblEntity,animalTag:inheritEarTagTextfield.text ?? "",custmerId :Int64(custmerId ),providerid:pvid,productId:20)
                    
                    if fetchDataUpdate.count != 0 {
                        updateOrderInfoBeefInherit(entity: Entities.dataEntryBeefAnimalAddTblEntity,animalTag: inheritEarTagTextfield.text ?? "", animalbarCodeTag: inheritBarcodeTextfield.text ?? "",date: dateVale,damId: inheritDamIdTextfield.text ?? "",sireId: inheritSireRegTextfield.text ?? "",gender: inheritGenderString,permanentId: inheritBreedRegTextfield.text ?? "",tissuName: inheritTissueBttn.titleLabel!.text ?? "",breedName: inheritBreedBttn.titleLabel!.text ?? "",et: inheritRegAssociationBttn.titleLabel?.text! ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:inheritEIDTextfield.text ?? "",nationHerdAU:inheritSecondaryIdTextfield.text ?? "",userId:userId,udid: timeStampString,sirYOB :inheritSireYobBttn.text ?? "",damYOB:inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "",productId:20,custmerId:Int64(custmerId ), editFlagSave: true)
                        
                        updateOrderInfoBeefInherit(entity: Entities.beefAnimalMasterTblEntity,animalTag: inheritEarTagTextfield.text ?? "", animalbarCodeTag: inheritBarcodeTextfield.text ?? "", date: dateVale,damId: inheritDamIdTextfield.text ?? "",sireId: inheritSireRegTextfield.text ?? "",gender: inheritGenderString,permanentId: inheritBreedRegTextfield.text ?? "",tissuName: inheritTissueBttn.titleLabel!.text ?? "",breedName: inheritBreedBttn.titleLabel!.text ?? "",et: inheritRegAssociationBttn.titleLabel?.text! ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:inheritEIDTextfield.text ?? "",nationHerdAU:inheritSecondaryIdTextfield.text ?? "",userId:userId,udid: timeStampString,sirYOB :inheritSireYobBttn.text ?? "",damYOB:inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "",productId:20,custmerId:Int64(custmerId ), editFlagSave: true)
                    }
                    
                    updateOrderStatusISyncProduct(entity: Entities.productAdonAnimlBeefTblEntity,animalTag: inheritEarTagTextfield.text!,barCodetag:  inheritBarcodeTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId:animalId1)
                    updateOrderStatusISyncSubProduct(entity: Entities.subProductBeefTblEntity,animalTag: inheritEarTagTextfield.text!,barCodetag:  inheritBarcodeTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId: animalId1)
                    
                    let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: "",animalTag:inheritEarTagTextfield.text!,barcodeTag:inheritBarcodeTextfield.text!)
                    let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                    
                    if adata.count > 0{
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                        inheritByDefaultSetting()
                    }
                    
                    else if animalDataMaster.count > 0 {
                        if msgUpatedd {
                            self.NavigateToBeefOrderingScreen()
                            UserDefaults.standard.set(inheritBreedBttn.titleLabel?.text, forKey: keyValue.inheritBeefbreedClear.rawValue)
                            UserDefaults.standard.set(inheritTissueBttn.titleLabel?.text, forKey: keyValue.beefInheritTsuClear.rawValue)
                            UserDefaults.standard.set(inheritBreedBttn.titleLabel?.text, forKey: keyValue.inheritBeefbreed.rawValue)
                            UserDefaults.standard.set(inheritTissueBttn.titleLabel?.text, forKey: keyValue.beefInheritTSU.rawValue)
                            inheritByDefaultSetting()
                        }
                        else{
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                            inheritByDefaultSetting()
                        }
                    }
                    
                    editAid = animalId1
                    animalId1 = 0
                    
                    if identify1  {
                        let data1 = fetchAllDataOrderStatus(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
                        if data1.count > 0 {
                            completionHandler(true)
                            return
                        }
                    }
                    completionHandler(true)
                    scrolView.contentOffset.y = 0.0
                }
                else {
                    let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Animal cannot be updated in order as BVDV product is selected and the animal sample type is other than Allflex (TSU), Allflex (TST) or Caisely (TSU). Do you want to save animal?", comment: ""), preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        self.inheritByDefaultSetting()
                        
                    }
                    let cancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        self.inheritByDefaultSetting()
                        return
                    }
                    alertController.addAction(okAction)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            } else {
                isUpdate = true
                inheritUpdateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalMasterTblEntity, animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "false", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString,animalId: animalId1, sirYOB: inheritSireYobBttn.text ?? "", damYOB: inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "")
                
                inheritUpdateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalAddTblEntity, animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "true", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString,animalId: animalId1, sirYOB: inheritSireYobBttn.text ?? "", damYOB: inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "")
                
                let fetchDataUpdate = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                
                if fetchDataUpdate.count != 0 {
                    
                    inheritUpdateOrderStatusISyncAnimalMaster(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "false", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString,animalId: animalId1, sirYOB: inheritSireYobBttn.text ?? "", damYOB: inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "")
                    
                    inheritUpdateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalMasterTblEntity, animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "false", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString,animalId: animalId1, sirYOB: inheritSireYobBttn.text ?? "", damYOB: inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "")
                    
                }
                
                updateOrderStatusISyncProduct(entity: Entities.productAdonAnimlBeefTblEntity,animalTag: inheritEarTagTextfield.text!,barCodetag:  inheritBarcodeTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId:animalId1)
                updateOrderStatusISyncSubProduct(entity: Entities.subProductBeefTblEntity,animalTag: inheritEarTagTextfield.text!,barCodetag:  inheritBarcodeTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId: animalId1)
                
                let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: "",animalTag:inheritEarTagTextfield.text!,barcodeTag:inheritBarcodeTextfield.text!)
                let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                
                if adata.count > 0{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                    inheritByDefaultSetting()
                }
                
                else if animalDataMaster.count > 0 {
                    if  msgUpatedd {
                        self.NavigateToBeefOrderingScreen()
                        UserDefaults.standard.set(inheritBreedBttn.titleLabel?.text, forKey: keyValue.inheritBeefbreedClear.rawValue)
                        UserDefaults.standard.set(inheritTissueBttn.titleLabel?.text, forKey: keyValue.beefInheritTsuClear.rawValue)
                        UserDefaults.standard.set(inheritBreedBttn.titleLabel?.text, forKey: keyValue.inheritBeefbreed.rawValue)
                        UserDefaults.standard.set(inheritTissueBttn.titleLabel?.text, forKey: keyValue.beefInheritTSU.rawValue)
                        inheritByDefaultSetting()
                    }
                    else{
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                        inheritByDefaultSetting()
                    }
                }
                
                editAid = animalId1
                animalId1 = 0
                
                if identify1  {
                    let data1 = fetchAllDataOrderStatus(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
                    if data1.count > 0 {
                        completionHandler(true)
                        return
                    }
                }
                
                completionHandler(true)
                scrolView.contentOffset.y = 0.0
            }
        }
        else if isUpdate  {
            animalId1 = editAid
            inheritUpdateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalMasterTblEntity, animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "false", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString,animalId: animalId1, sirYOB: inheritSireYobBttn.text ?? "", damYOB: inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "")
            
            inheritUpdateOrderStatusISyncAnimalMaster(entity: Entities.beefAnimalAddTblEntity, animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "true", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString,animalId: animalId1, sirYOB: inheritSireYobBttn.text ?? "", damYOB: inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "")
            
            if identify1  {
                let data1 = fetchAllDataOrderStatus(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false", orderId:orderId,userId:userId)
                if data1.count > 0 {
                    completionHandler(true)
                    return
                }
            }
            isautoPopulated = false
            let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: "",animalTag:inheritEarTagTextfield.text!,barcodeTag:inheritBarcodeTextfield.text!)
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            
            if adata.count > 0{
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalAlreadyAdded, comment: ""))
                inheritByDefaultSetting()
            }
            
            else if animalDataMaster.count > 0 {
                if msgUpatedd {
                    self.NavigateToBeefOrderingScreen()
                    UserDefaults.standard.set(inheritBreedBttn.titleLabel?.text, forKey: keyValue.inheritBeefbreedClear.rawValue)
                    UserDefaults.standard.set(inheritTissueBttn.titleLabel?.text, forKey: keyValue.beefInheritTsuClear.rawValue)
                    UserDefaults.standard.set(inheritBreedBttn.titleLabel?.text, forKey: keyValue.inheritBeefbreed.rawValue)
                    UserDefaults.standard.set(inheritTissueBttn.titleLabel?.text, forKey: keyValue.beefInheritTSU.rawValue)
                    inheritByDefaultSetting()
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
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            if animalDataMaster.count > 0{
                animalID1 = animalID1 + 1
                UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                
                InheritUpdateOrderStatusISyncAnimalMasterAnimalId(entity: Entities.beefAnimalMasterTblEntity, animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "true", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1, sirYOB: inheritSireYobBttn.text ?? "", DamYOB: inheritDamYobBttn.text ?? "", sireRegAssocation: inheriSireRedOutlet.titleLabel?.text ?? "")
                
                let fetchDataUpdate = fetchAnimalDataAccEarTag(entityName: Entities.dataEntryBeefAnimalAddTblEntity,animalTag:inheritEarTagTextfield.text ?? "",custmerId :Int64(custmerId ),providerid:pvid,productId:20)
                
                if fetchDataUpdate.count != 0 {
                    updateOrderInfoBeefInherit(entity: Entities.dataEntryBeefAnimalAddTblEntity,animalTag: inheritEarTagTextfield.text ?? "", animalbarCodeTag: inheritBarcodeTextfield.text ?? "",date: dateVale,damId: inheritDamIdTextfield.text ?? "",sireId: inheritSireRegTextfield.text ?? "",gender: inheritGenderString,permanentId: inheritBreedRegTextfield.text ?? "",tissuName: inheritTissueBttn.titleLabel!.text ?? "",breedName: inheritBreedBttn.titleLabel!.text ?? "",et: inheritRegAssociationBttn.titleLabel?.text! ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:inheritEIDTextfield.text ?? "",nationHerdAU:inheritSecondaryIdTextfield.text ?? "",userId:userId,udid: timeStampString,sirYOB :inheritSireYobBttn.text ?? "",damYOB:inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "",productId:20,custmerId:Int64(custmerId ), editFlagSave: true)
                    
                    updateOrderInfoBeefInherit(entity: Entities.beefAnimalMasterTblEntity,animalTag: inheritEarTagTextfield.text ?? "", animalbarCodeTag: inheritBarcodeTextfield.text ?? "", date: dateVale,damId: inheritDamIdTextfield.text ?? "",sireId: inheritSireRegTextfield.text ?? "",gender: inheritGenderString,permanentId: inheritBreedRegTextfield.text ?? "",tissuName: inheritTissueBttn.titleLabel!.text ?? "",breedName: inheritBreedBttn.titleLabel!.text ?? "",et: inheritRegAssociationBttn.titleLabel?.text! ?? "",farmId: "",breedId: breedId,providerId:pvid,tissuId: tissuId,sireIDAU:inheritEIDTextfield.text ?? "",nationHerdAU:inheritSecondaryIdTextfield.text ?? "",userId:userId,udid: timeStampString,sirYOB :inheritSireYobBttn.text ?? "",damYOB:inheritDamYobBttn.text ?? "",sireRegAssocation:inheriSireRedOutlet.titleLabel?.text ?? "",productId:20,custmerId:Int64(custmerId ), editFlagSave: true)
                }
            }
            else{
                UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                
                let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"true" )
                
                if animalDataMaster.count > 0{
                    InheritUpdateOrderStatusISyncAnimalMasterAnimalId(entity: Entities.beefAnimalMasterTblEntity, animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "false", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU:inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1, sirYOB: inheritSireYobBttn.text ?? "", DamYOB: inheritDamYobBttn.text ?? "", sireRegAssocation: inheriSireRedOutlet.titleLabel?.text ?? "")
                }
                else {
                    inheritSaveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "false", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: (inheritBreedBttn.titleLabel?.text!)!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString, animalId: animalID1,productId:Int(pid?.productId ?? 0), sirYOB: inheritSireYobBttn.text ?? "", damYOB: inheritDamYobBttn.text ?? "", sireRegAssocation: inheriSireRedOutlet.titleLabel?.text ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: 0, serverAnimalId: "", tertiaryGeno: "")
                    createDataList()
                }
            }
            
            let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:orderId, customerID: custmerId)
            if data12333.count > 0{
                if inheritTissueBttn.titleLabel!.text! == ButtonTitles.allflexTSUText || inheritTissueBttn.titleLabel!.text! == ButtonTitles.allflexTSTText || inheritTissueBttn.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                    inheritSaveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "true", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString, animalId: animalID1,productId: Int(pid?.productId ?? 0), sirYOB: inheritSireYobBttn.text ?? "", damYOB: inheritDamYobBttn.text ?? "", sireRegAssocation: inheriSireRedOutlet.titleLabel?.text ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: 0, serverAnimalId: "", tertiaryGeno: "")
                    createDataList()
                }
                else{
                    let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: NSLocalizedString("YES", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        self.inheritByDefaultSetting()
                    }
                    let cancelAction = UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        
                        deleteDataWithProductwithEntity(animalID1,entity: Entities.productAdonAnimlBeefTblEntity)
                        deleteDataWithProductwithEntity(animalID1, entity: Entities.subProductBeefTblEntity)
                        deleteDataWithProductwithEntity(animalID1, entity: Entities.beefAnimalAddTblEntity)
                        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                        self.notificationLblCount.text = String(animalCount.count)
                        self.inheritByDefaultSetting()
                        return
                    }
                    alertController.addAction(cancelAction)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
            }
            else {
                inheritSaveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: inheritEarTagTextfield.text!, barCodetag: inheritBarcodeTextfield.text!, date: dateVale , damId: inheritDamIdTextfield.text!, sireId: inheritSireRegTextfield.text ?? "" , gender: inheritGenderString,update: "true", permanentId:inheritBreedRegTextfield.text!, tissuName: inheritTissueBttn.titleLabel!.text!, breedName: inheritBreedBttn.titleLabel!.text!, et: inheritRegAssociationBttn.titleLabel?.text! ?? "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: inheritEIDTextfield.text!, nationHerdAU: inheritSecondaryIdTextfield.text!, userId: userId,udid:timeStampString, animalId: animalID1,productId: Int(pid?.productId ?? 0), sirYOB: inheritSireYobBttn.text ?? "", damYOB: inheritDamYobBttn.text ?? "", sireRegAssocation: inheriSireRedOutlet.titleLabel?.text ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: 0, serverAnimalId: "", tertiaryGeno: "")
                createDataList()
            }
            
            let animalData = fetchAnimaldataDairy(entityName: Entities.beefAnimalAddTblEntity, animalTag:animalID1,orderId:orderId,userId:userId)
            
            for k in 0 ..< animalData.count{
                let animalId = animalData[k] as! BeefAnimaladdTbl
                for i in 0 ..< product.count {
                    let data = product[i] as! GetProductTblBeef
                    
                    saveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: animalId.farmId ?? "", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: animalID1, marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: true)
                    
                    let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                    
                    for j in 0 ..< addonArr.count {
                        let addonDat = addonArr[j] as! GetAdonTbl
                        if data12333.count > 0 {
                            if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: animalID1,custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: Int(addonDat.adonId), status: "true")
                            }
                            else{
                                saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: animalID1,custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                            }
                        }
                        else {
                            saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: animalID1,custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                        }
                        
                        statusOrder = false
                        UserDefaults.standard.removeObject(forKey: keyValue.review.rawValue)
                        self.animalSucInOrder = ""
                        if !self.msgAnimalSucess {
                            if self.addContiuneBtn == 1 {
                                if self.msgcheckk  {
                                    self.view.makeToast(NSLocalizedString(AlertMessagesStrings.animalRecordUpdatedAdded, comment: ""), duration: 2, position: .bottom)
                                }
                                else {
                                    if self.isautoPopulated  {
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAddedSuccessfully, comment: ""), duration: 2, position: .bottom)
                                    } else {
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAdded, comment: ""), duration: 2, position: .bottom)
                                    }
                                }
                            }
                            else if self.addContiuneBtn == 2{
                                if self.msgcheckk  {
                                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalRecordUpdatedAdded, comment: ""))
                                }
                                else{
                                    if self.isautoPopulated  {
                                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAddedSuccessfully, comment: ""))
                                        
                                    }
                                    else {
                                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAdded, comment: ""))
                                    }
                                }
                            }
                            else {
                                if self.msgcheckk  {
                                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.animalRecordUpdatedAdded, comment: ""))
                                }
                                else{
                                    if self.isautoPopulated  {
                                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAddedSuccessfully, comment: ""))
                                    }
                                    else {
                                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.animalAdded, comment: ""))
                                    }
                                }
                            }
                            self.msgAnimalSucess = false
                        } else {
                            if self.msgcheckk  {
                                self.view.makeToast(NSLocalizedString(AlertMessagesStrings.animalRecordUpdatedAdded, comment: ""), duration: 2, position: .bottom)
                            }
                            else{
                                if self.isautoPopulated  {
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAddedSuccessfully, comment: ""), duration: 2, position: .bottom)
                                }
                                else {
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.animalAdded, comment: ""), duration: 2, position: .bottom)
                                }
                            }
                        }
                    }
                }
            }
            
            UserDefaults.standard.set(inheritBreedBttn.titleLabel?.text, forKey: keyValue.inheritBeefbreedClear.rawValue)
            UserDefaults.standard.set(inheritTissueBttn.titleLabel?.text, forKey: keyValue.beefInheritTsuClear.rawValue)
            UserDefaults.standard.set(inheritBreedBttn.titleLabel?.text, forKey: keyValue.inheritBeefbreed.rawValue)
            UserDefaults.standard.set(inheritTissueBttn.titleLabel?.text, forKey: keyValue.beefInheritTSU.rawValue)
            
            if isBarcodeAutoIncrementedEnabled  {
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
            } else {
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
            }
            
            self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            inheritGenderToggleFlag = 0
            inheritGenderString = "Female".localized
            barAutoPopu = false
            inheritEarTagTextfield.text = ""
            self.inheritScrollView.contentOffset.y = 0.0
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
            notificationLblCount.text = String(animalCount.count)
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
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue)  {
            UserDefaults.standard.set(incrementalBarCode, forKey: keyValue.barcodeIncremental.rawValue)
        }
        incrementalBarCode = ""
        inheritTextFieldBackroungGrey()
        inheritByDefaultSetting()
        view.endEditing(true)
    }
    
    func inheritValidation(){
        if inheritEarTagTextfield.text == ""{
            inheritEarTagView.layer.borderColor = UIColor.red.cgColor
        }
        else {
            inheritEarTagView.layer.borderColor = UIColor.gray.cgColor
        }
        if inheritBarcodeTextfield.text == ""{
            inheritBarcodeView.layer.borderColor = UIColor.red.cgColor
        }
        else {
            inheritBarcodeView.layer.borderColor = UIColor.gray.cgColor
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
    
    func inheritSireYOBDoDatePicker(){
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
        self.datePicker.setDate(InheritSireSelectedDate, animated: true)
        
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
        let doneButton = UIBarButtonItem(title: "Done".localized, style: .plain, target: self, action: #selector(self.InheritSireYOBDoneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel".localized, style: .plain, target: self, action: #selector(self.inheritSireCancelClick))
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
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 1, alpha: 1)
        toolBar.sizeToFit()
        self.datePicker.maximumDate = Date()
        let doneButton = UIBarButtonItem(title: "Done".localized, style: .plain, target: self, action: #selector(self.InheritDamYOBDoneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel".localized, style: .plain, target: self, action: #selector(self.inheritDamCancelClick))
        cancelButton.tintColor = UIColor.black
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = CGRect(x: 0, y: 0, width: self.calenderView.frame.size.width, height: 40)
        self.calenderView.addSubview(toolBar)
        self.toolBar.isHidden = false
    }
}
