//
//  DEOAnimalVCUIMethodsIpad.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 13/03/25.
//

import Foundation
import UIKit

// MARK: - DID LOAD AND WILL APPEAR UI METHODS EXTENSION

extension DataEntryOrderingAnimalVCIpad {
    func setUIOnDidLoad(){
        self.setSideMenu()
        dateTextField.setLeftPaddingPoints(20.0)
        addObserver()
        tapRec.addTarget(self, action: #selector(closeAddAnimalAndContinueOptions(tapGestureRecognizer:)))
        if dataEntryConflicedBack {
            notificationLblCount.isHidden = true
            self.cartView.isHidden = true
            countLbl.isHidden = true
            dataEntryAddAnimal.setTitle("Save", for: .normal)
        } else {
            notificationLblCount.isHidden = false
            countLbl.isHidden = false
            self.cartView.isHidden = false
        }
        if !UserDefaults.standard.bool(forKey: keyValue.expandView.rawValue) {
            
            sireTipBTNoUTLET.isHidden = true
        } else {
            
            sireTipBTNoUTLET.isHidden = false
        }
        listIdGet = UserDefaults.standard.integer(forKey: keyValue.listIdSaveOnSelection.rawValue)
        listName = UserDefaults.standard.object(forKey: keyValue.listNameSaveOnSelection.rawValue) as? String ?? ""
        scrollInnerHeightConstraint.constant = 700.0
        sampleTypeAndGenderStackView.isHidden = true
        sampleTypeHeaderView.isHidden = true
        breedAndDateStackView.isHidden = true
        genderHeaderView.isHidden = true
        bornTypeView.isHidden = true
        sampleBreedHeaderView.isHidden = true
        dobHeaderView.isHidden = true
        sireIdAndDamIdStackView.isHidden = true
        damIDHeaderView.isHidden = true
        sireIDHeaderView.isHidden = true
        sireIDViewAustralia.isHidden = true
        bornTypeHeaderView.isHidden = true
        clearFormBottomConstraint.constant = 175
        addAnimalStackTopConstraint.constant = 50
        nationalHerdAuHeightConstrainr.constant = 0
        sireIdAuHeightConstrainr.constant = 0
     
        self.userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        self.orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        if UserDefaults.standard.bool(forKey: keyValue.matchedBarcodeFlagDataEntry.rawValue) {
            matchedBarcodeCheckBox.image = UIImage(named: "incrementalCheckIpad")
            
        } else {
            matchedBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
        }
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            dateTextField.isHidden = false
            
        } else {
            dateTextField.isHidden = true
        }
        dateTextField.keyboardType = .phonePad
        dateTextField.borderStyle = .none
        pairedDeviceView.isHidden = true
        pairedBackroundView.isHidden = true
        scrolView.flashScrollIndicators()
        autoSuggestionStatus = false
        dateOfBirthLbl.text = NSLocalizedString(ButtonTitles.selectdateText, comment: "")
        if providerName == keyValue.clarifideAHDBUK.rawValue{
            UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.screen.rawValue)
            self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue))
            for items in self.tissueArr
            {
                let tissue = items  as? GetSampleTbl
                let checkdefault  = tissue?.isDefault
                
                if pvid == 11 {
                    let country : String = UserDefaults.standard.object(forKey: keyValue.country.rawValue) as? String ?? ""
                    switch country  {
                    case countryName.Belgium.title, countryName.Luxembourg.title :
                        self.saveSampleNameandID(sampleNameStr: ButtonTitles.allflexTSUText, sampleID: 1)
                        self.tissueBtnOutlet.setTitle(ButtonTitles.allflexTSUText, for: .normal)
                    case countryName.Netherlands.title :
                        self.saveSampleNameandID(sampleNameStr: LocalizedStrings.hairString, sampleID: 4)
                        self.tissueBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.hairString, comment: ""), for: .normal)
                    default:
                        break
                    }
                } else if pvid == 8 {
                    self.saveSampleNameandID(sampleNameStr: LocalizedStrings.hairString, sampleID: 4)
                    self.tissueBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.hairString, comment: ""), for: .normal)
                }
                else {
                    if checkdefault == true
                    {
                        self.saveSampleNameandID(sampleNameStr: tissue?.sampleName ?? "", sampleID: 4)
                        self.tissueBtnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
                    }
                }
            }
        }
        
        UserDefaults.standard.removeObject(forKey: keyValue.selectAnimalId.rawValue)
        countryCodesArray = fetchAllData(entityName: Entities.getCountryCodeTblEntity)
        naabCodesArray = fetchAllData(entityName: Entities.getNaabCodeTblEntity)
        tissuId = 1
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.byDefaultSetting()
        scanAnimalTagText.delegate = self
        dateTextField.delegate = self
        scanAnimalTagText.addPadding(.left(20))
        scanBarcodeText.addPadding(.left(20))
        permanentIDTextField.addPadding(.left(20))
        farmIdTextField.addPadding(.left(20))
        damtexfield.addPadding(.left(20))
        sireIdTextField.addPadding(.left(20))
        nationalHerdIdTextField.addPadding(.left(20))
        sireIAuTextField.addPadding(.left(20))
        calenderView.isHidden = true
        calendarViewBkg.isHidden = true
        genderString = ButtonTitles.femaleText.localized
        
        if UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue {
            bleBttn.setImage(UIImage(named: "ocrImageipad"), for: .normal)
            blebttn1.setImage(UIImage(named: "ocrImageipad"), for: .normal)
            
        }
        let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        
        let formatter = DateFormatter()
        if dateStr == "MM" {
            formatter.dateFormat = DateFormatters.MMddyyyyFormat
            dateTextField.placeholder = DateFormatters.MMDDYYYYFormat
        } else {
            formatter.dateFormat = DateFormatters.ddMMyyyyFormat
            dateTextField.placeholder = DateFormatters.DDMMYYYYFormat
            
        }
        setUPCollectionView()
        self.defaultIncrementalBarCodeSetting()
    }
    
    func setUIOnWillAppear(){
        tissueBtnOutlet.layer.cornerRadius = 15
        tissueBtnOutlet.clipsToBounds = true
        male_femaleBtnOutlet.layer.cornerRadius = 15
        male_femaleBtnOutlet.clipsToBounds = true
        breedBtnOutlet.layer.cornerRadius = 15
        breedBtnOutlet.clipsToBounds = true
        scanAnimalTagText.layer.cornerRadius = 15
        scanAnimalTagText.clipsToBounds = true
        farmIdTextField.layer.cornerRadius = 15
        farmIdTextField.clipsToBounds = true
        sireIdTextField.layer.cornerRadius = 15
        sireIdTextField.clipsToBounds = true
        damtexfield.layer.cornerRadius = 15
        damtexfield.clipsToBounds = true
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        self.userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        self.orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        matchedBarcodeLbl.text = NSLocalizedString(ButtonTitles.matched840Id, comment: "")
        dataEntryReviewData.setTitle(NSLocalizedString(ButtonTitles.reviewDataText, comment: ""), for: .normal)
        dataEntryAddAnimal.setTitle(NSLocalizedString(ButtonTitles.addAnotherAnimalText, comment: ""), for: .normal)
        
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int
        self.fetchADHAnimalList(userId: userId, customerID: currentCustomerId)
        
        if providerName == keyValue.clarifideAHDBUK.rawValue{
            if tissueBtnOutlet.titleLabel?.text == nil || tissueBtnOutlet.titleLabel?.text == ""{
                self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue))
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
                    } else if pvid == 8{
                        saveSampleNameandID(sampleNameStr: LocalizedStrings.hairString, sampleID: 4)
                        self.tissueBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.hairString, comment: ""), for: .normal)
                    }
                    else {
                        if checkdefault == true
                        {
                            saveSampleNameandID(sampleNameStr: tissue?.sampleName ?? "", sampleID: 0)
                            self.tissueBtnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
                            
                        }
                    }
                }
            }}
        
        if UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue {
            bleBttn.setImage(UIImage(named: "ocrImageipad"), for: .normal)
            blebttn1.setImage(UIImage(named: "ocrImageipad"), for: .normal)
            
        } else {
            if BluetoothCentre.shared.smartBowPeripheral?.state == .connected{
                bleBttn.setImage(UIImage(named: "bleImageIpad"), for: .normal)
                blebttn1.setImage(UIImage(named: "bleImageIpad"), for: .normal)
                
            } else {
                bleBttn.setImage(UIImage(named: "bleImageIpad"), for: .normal)
                blebttn1.setImage(UIImage(named: "bleImageIpad"), for: .normal)
            }
        }
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        
        let auto = UserDefaults.standard.bool(forKey: keyValue.autoId.rawValue)
        if !auto {
            autoIncrementidtable()
            autoD = fetchFromAutoIncrement()
            timeStampString = timeStamp()
            UserDefaults.standard.set(timeStampString, forKey: keyValue.timeStamp.rawValue)
            UserDefaults.standard.set(true, forKey: keyValue.autoId.rawValue)
            deleteRemaningSubmitOrder(entityName: Entities.productAdonAnimalTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            deleteRemaningSubmitOrder(entityName: Entities.subProductTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            
            UserDefaults.standard.set(autoD, forKey: keyValue.orderId.rawValue)
        }
        autoD = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        timeStampString = UserDefaults.standard.value(forKey: keyValue.timeStamp.rawValue) as? String ?? ""
        BluetoothCentre.shared.navController = self
        initialNetworkCheck()
        BluetoothCentre.shared.manager.scanForPeripherals(withServices: nil, options: nil)
        self.navigationController?.navigationBar.isHidden = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        BluetoothCentre.shared.delegateRFID  = self
        BluetoothCentre.shared.nearByDeviceDelegate  = self
        defaltscreen =  UserDefaults.standard.string(forKey: keyValue.screen.rawValue) ?? ""
        if defaltscreen == keyValue.farmId.rawValue || defaltscreen == ""{
            lblOfficialTagTitle.text = "On-Farm ID"
            lblOnFarmIdTitle.textAlignment = .center
            lblOnFarmIdTitle.text = "Official ID"
            scanAnimalTagText.placeholder = NSLocalizedString(ButtonTitles.enterOnFarmId, comment: "")
            pairedDeviceTitle.text = NSLocalizedString(ButtonTitles.selectDeviceStr, comment: "")
            farmIdTextField.placeholder = NSLocalizedString(ButtonTitles.scanEnterOfficialTag, comment: "")
            auPOPupTitle.text = NSLocalizedString(ButtonTitles.addClarifideCDCBUS, comment: "")
            
            if UserDefaults.standard.value(forKey: keyValue.keyboardSelection.rawValue) as? String == keyValue.numericKeyboard.rawValue {
                self.scanAnimalTagText.keyboardType = UIKeyboardType.numberPad
            } else {
                self.scanAnimalTagText.keyboardType = UIKeyboardType.default
            }
            scanAnimalTagText.tag = 1
            farmIdTextField.tag = 0
            bleBttn.isHidden = false
            blebttn1.isHidden = true
        }
        else {
            blebttn1.isEnabled = true
            lblOfficialTagTitle.text = "Official ID"
            lblOfficialTagTitle.textAlignment = .center
            lblOnFarmIdTitle.text = "On-Farm ID"
            if UserDefaults.standard.value(forKey: keyValue.keyboardSelection.rawValue) as? String == keyValue.numericKeyboard.rawValue {
                self.farmIdTextField.keyboardType = UIKeyboardType.numberPad
            } else {
                self.farmIdTextField.keyboardType = UIKeyboardType.default
            }
            blebttn1.isHidden = false
            bleBttn.isHidden = true
        }
        
        let selctionAuProvider = UserDefaults.standard.value(forKey: keyValue.clickAuProvider.rawValue) as? Bool
        if selctionAuProvider == true {
            nationalHerdIdTextField.isHidden = false
            sireIAuTextField.isHidden = false
            nationalHerdIdTextField.isEnabled = true
            sireIAuTextField.isEnabled = true
            sireIdAuHeightConstrainr.constant = 0
            nationalHerdAuHeightConstrainr.constant = 0
        
        } else {
            nationalHerdIdTextField.isHidden = true
            sireIAuTextField.isHidden = true
            sireIdAuHeightConstrainr.constant = 0
            nationalHerdAuHeightConstrainr.constant = 0
         
        }
        
        if UserDefaults.standard.integer(forKey: keyValue.dataEntryAnimalIdSelectionCart.rawValue) > 0 {
            let temp = UserDefaults.standard.integer(forKey: keyValue.dataEntryAnimalIdSelectionCart.rawValue)
            animalIdBool = true
            let existAnimalData = fetchAllDataWithAnimalIdstatus(entityName: "DataEntryAnimaladdTbl", animalId:temp,orderststus:"false", customerId: self.custmerId ?? 0) as! [DataEntryAnimaladdTbl]
            if existAnimalData.count > 0{
                loadedAnimalData = existAnimalData[0]
                isComingFromDataList = true
            }
            textFieldBackroungWhite()
            UserDefaults.standard.set(0, forKey: keyValue.dataEntryAnimalIdSelectionCart.rawValue)
            dataPopulateInScreen(animalId: temp)
            
        }
        if !UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncrementalClear.rawValue) {
            self.isBarcodeAutoIncrementedEnabled = false
            
        }
        breedCodesArray = fetchBreedData(entityName: Entities.getBreedsTblEntity, provId: pvid)
        breedAr = breedCodesArray.value(forKey: keyValue.alpha2.rawValue) as! NSArray
        threeCharCode = breedCodesArray.value(forKey: keyValue.threeCharCode.rawValue) as! NSArray
        countryArr = countryCodesArray.value(forKey: keyValue.alphaCode.rawValue) as! NSArray
        naabArr = naabCodesArray.value(forKey: keyValue.naabCode.rawValue) as! NSArray
        counteryNumericArr = countryCodesArray.value(forKey: keyValue.numericCode.rawValue) as! NSArray
        AusNabb = fetchAusNaabBullData()
        ausBullId = AusNabb.value(forKey: keyValue.bullID.rawValue) as! NSArray
        sireNationalID = AusNabb.value(forKey: keyValue.sireNationalId.rawValue) as! NSArray
        
        let marketNameID = UserDefaults.standard.value(forKey: keyValue.marketNameID.rawValue) as? String
        if marketNameID == MarketID.NetherlandMarketId
        {
            if let country = UserDefaults.standard.object(forKey: keyValue.country.rawValue) {
                let getMarketName = fetchAllCountryDataWithMarketIdandCountryname(entityName: Entities.getCountryCodeTblEntity, alpha2: marketNameID ?? "", countryName: country as! String)
                if getMarketName.count != 0 {
                    let getMarketName1 = getMarketName.object(at: 0) as? GetCountryCode
                    providerSelectionCountryCode =   getMarketName1?.alphaCode ?? ""
                    providerCountryCodeAlpha2 = getMarketName1?.alpha2 ?? ""
                }
            }
        } else {
            let getMarketName = fetchAllCountryDataWithMarketId(entityName: Entities.getCountryCodeTblEntity, alpha2: marketNameID!)
            if getMarketName.count != 0 {
                let getMarketName1 = getMarketName.object(at: 0) as? GetCountryCode
                providerSelectionCountryCode =   getMarketName1?.alphaCode ?? ""
            }
        }
        sireTipBTNoUTLET.isHidden = true
        calendarViewBkg.isHidden = true
        self.auSelectionView.isHidden = true
        sireIDViewAustralia.isHidden = true
        let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
        if providerName == keyValue.auDairyProducts.rawValue {
            sireIdTextField.placeholder = NSLocalizedString(ButtonTitles.sireIDNASISBullName, comment: "")
            sireTipBTNoUTLET.isHidden = false
            sireIDViewAustralia.isHidden = false
            if !UserDefaults.standard.bool(forKey: keyValue.expandView.rawValue) {
                sireTipBTNoUTLET.isHidden = true
                sireIDViewAustralia.isHidden = true
            } else {
                sireTipBTNoUTLET.isHidden = false
            }
        }
        
    }
    
    func setUIOnDidAppear(){
        let animalCount =  fetchAllDataAnimalDaWithOutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderStatus:"false",listid: Int64(self.listIdGet ), custmerId: Int64(custmerId ?? 0), providerId: pvid)
        notificationLblCount.text = String(animalCount.count)
        if animalCount.count == 0{
            notificationLblCount.isHidden = true
            countLbl.isHidden = true
            self.cartView.isHidden = true
        }
    }
    
    func defaultIncrementalBarCodeSetting() {
        incrementalBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
        incrementalBarcodeTitleLabel.text =  NSLocalizedString(ButtonTitles.incrementalBarcodeText, comment: "")
    }
    
    func addObserver()
    {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
    }
    
    func removeObserver()
    {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification , object: nil)
    }
    
    func anOptionalMethod(check :Bool){
        if check{
            isUpdate = false
            editIngText = false
            statusOrder = false
            animalId1 = -1
            editAid = -1
            idAnimal = 0
            isautoPopulated = false
            msgUpatedd = false
        }}
    
    
    func getCurrentTimeStampWOMiliseconds(dateToConvert: NSDate) -> String {
        let objDateformat: DateFormatter = DateFormatter()
        objDateformat.dateFormat = DateFormatters.yyyyMMddFormat
        let strTime: String = objDateformat.string(from: dateToConvert as Date)
        let objUTCDate: NSDate = objDateformat.date(from: strTime)! as NSDate
        let milliseconds: Int64 = Int64(objUTCDate.timeIntervalSince1970)
        let strTimeStamp: String = "\(milliseconds)"
        return strTimeStamp
    }
    
    func statusOrderTrue() -> Bool{
        let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.animalMasterTblEntity, animalId: idAnimal, customerID: custmerId!)
        if animalFetch.count > 0{
            statusOrder = true
            return true
        } else {
            return false
        }
    }
    
    func validateBreed(completionHandler: CompletionHandler) {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        let data1 = fetchAllDataOrderStatusDataEntry(entityName: Entities.dataEntryAnimalAddTbl,ordestatus: "false",orderId:orderId,userId:userId,listId:listIdGet)
        var bredidd123 = String ()
        if data1.count > 0 {
            let breeid1 = data1.object(at: 0) as! DataEntryAnimaladdTbl
            bredidd123 = breeid1.breedName ?? ""
        }
        
        if data1.count == 1 {
            UserDefaults.standard.set(false, forKey: keyValue.identifyStore.rawValue)
        }
        else {
            for i in 0 ..< data1.count{
                let breeid1 = data1.object(at: i) as! DataEntryAnimaladdTbl
                if bredidd123 == breeid1.breedName {
                    UserDefaults.standard.set(false, forKey: keyValue.identifyStore.rawValue)
                }
                
                else{
                    UserDefaults.standard.set(true, forKey: keyValue.identifyStore.rawValue)
                    return   completionHandler(true)
                }
                
                bredidd123 = breeid1.breedName ?? ""
            }
        }
        return completionHandler(true)
    }
    
    func addAnimalBtn(completionHandler: @escaping CompletionHandler){
        self.view.endEditing(true)
        if farmIDBoolEntryTag {
            let bbb =  fetchAnimaldataValidateAnimalBarcodetag(entityName: Entities.dataEntryAnimalAddTbl,animalbarCodeTag:scanAnimalTagText.text ?? "",orderId: orderId, userId: userId, custmerId: custmerId ?? 0)
            
            if bbb.count != 0 &&  dataAutoPopulatedBool{
                farmIDBoolEntry = true
                officalTagView.layer.borderColor = UIColor.red.cgColor
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.duplicateEntryStr, comment: ""))
                return
            }
        }
        
        if farmIDBoolEntry  {
            let bbb =  fetchAnimaldataValidateAnimalBarcodetag(entityName: Entities.dataEntryAnimalAddTbl,animalbarCodeTag:farmIdTextField.text ?? "",orderId: orderId, userId: userId, custmerId: custmerId ?? 0)
            
            if bbb.count != 0 &&  dataAutoPopulatedBool{
                farmIDBoolEntry = true
                farmIdView.layer.borderColor = UIColor.red.cgColor
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.duplicateEntryStr, comment: ""))
                return
            }
        }
        
        if farmIDBoolEntrySecond {
            let animalTag1 = fetchAnimaldataValidateFamID(entityName: Entities.animalMasterTblEntity,farmId:scanAnimalTagText.text ?? "",custmerId: custmerId ?? 0, userId: userId, animalId: Int64(animalId1))
            if animalTag1.count != 0 &&  dataAutoPopulatedBool{
                farmIDBoolEntrySecond = true
                officalTagView.layer.borderColor = UIColor.red.cgColor
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.duplicateEntryStr, comment: ""))
                return
            }
        }
        
        let valueCheck = dateBtnOutlet.titleLabel?.text
        if valueCheck!.count != 0{
            dateBtnOutlet.layer.borderColor = UIColor.gray.cgColor
            calenderDobView.layer.borderColor = UIColor.gray.cgColor
        }
        
        if damtexfield.text!.count == 0 {
            damtexfield.layer.borderColor = UIColor.gray.cgColor
        }
        
        if sireIdTextField.text!.count == 0 {
            sireIdTextField.layer.borderColor = UIColor.gray.cgColor
        }
        if dateTextField.text?.count == 0 {
            
            
        }
        else if !validateDateFlag || dateTextField.text?.count != 10{
            if dateTextField.text?.count == 10 {
                let validate = isValidDate(dateString: dateTextField.text ?? "")
                if validate == LocalizedStrings.correctFormatStr {
                    validateDateFlag = true
                }
                else {
                    dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
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
                dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
                validateDateFlag = false
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.invalidDateFormat, comment: ""))
                return
                
            }
        }
        
        if statusOrder {
            msgAnimalSucess = true
            let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.animalMasterTblEntity, animalId: idAnimal, customerID: custmerId!)
            if animalFetch.count > 0{
                editIngText = true
            }
        }
        
        if scanAnimalTagText.tag == 1{
            if scanAnimalTagText.text == ""   {
                if scanAnimalTagText.text!.count == 0 {
                    officalTagView.layer.borderColor = UIColor.red.cgColor
                } else {
                    officalTagView.layer.borderColor = UIColor.gray.cgColor
                    scanAnimalTagText.textColor = UIColor.black
                }
                
                if damtexfield.text!.count == 0 {
                    damtexfield.layer.borderColor = UIColor.gray.cgColor
                }
                
                if sireIdTextField.text!.count == 0 {
                    sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                }
                
                borderRedCheck = true
                if farmIdTextField.text?.count == 0 {
                    farmIdView.layer.borderColor = UIColor.gray.cgColor
                }
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                return
                
            } else {
                officalTagView.layer.borderColor = UIColor.gray.cgColor
                scanAnimalTagText.textColor = UIColor.black
                barcodeView.layer.borderColor = UIColor.gray.cgColor
                scanBarcodeText.textColor = UIColor.black
                if farmIdTextField.text?.count == 0 {
                    farmIdView.layer.borderColor = UIColor.gray.cgColor
                    borderRedCheck = false
                }
                else if farmIdTextField.text?.count == 17 {
                    
                }
                else {
                    borderRedCheck = true
                }
                
                if sireIdTextField.text?.count != 0 || damtexfield.text?.count != 0 {
                    if sireIdTextField.text!.count == 0 {
                        sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                    }
                    if damtexfield.text!.count == 0 {
                        damtexfield.layer.borderColor = UIColor.gray.cgColor
                    }
                    
                    if sireIdTextField.text?.count == 0{
                        sireIdValidationB = false
                    }
                    
                    if damtexfield.text?.count == 0{
                        damIdValidationB = false
                    }
                    
                    if ausBullId.contains(sireIdTextField.text?.uppercased() as Any) || sireNationalID.contains(sireIdTextField.text?.uppercased() as Any){
                        sireIdValidationB = false
                    }
                    
                    if borderRedCheck || damIdValidationB || sireIdValidationB  {
                        if sireIdTextField.text?.count != 0{
                            if sireIdValidationB  {
                                if pvid == 3 {
                                    if ausBullId.contains(sireIdTextField.text?.uppercased() as Any) || sireNationalID.contains(sireIdTextField.text?.uppercased() as Any){
                                        
                                    } else {
                                        validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                                        return
                                    }
                                }
                                else {
                                    validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                                    return
                                }
                            }
                            else{
                                if sireIdTextField.text?.count == 17 {
                                }
                                else {
                                    if autoSuggestionStatus == true {
                                    }
                                    else {
                                        if pvid == 3 {
                                        }
                                        else {
                                            validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                                            return
                                        }
                                    }
                                }
                            }
                        }
                        else {
                            sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                        }
                        
                        if damtexfield.text?.count != 0{
                            if damIdValidationB  {
                                if pvid != 3 {
                                    validationId17SireDam(animalId: damtexfield.text!, tag: 4)
                                    return
                                }
                            }
                            else {
                                if damtexfield.text?.count == 17 {
                                }
                                else {
                                    if pvid != 3 {
                                        validationId17SireDam(animalId: damtexfield.text!, tag: 4)
                                        return
                                    }
                                }
                            }
                        }
                        else {
                            damtexfield.layer.borderColor = UIColor.gray.cgColor
                        }
                        if borderRedCheck {
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalIDStr, comment: ""), duration: 2, position: .top)
                            farmIdView.layer.borderColor = UIColor.red.cgColor
                        }
                        return
                    }
                } else {
                    damtexfield.layer.borderColor = UIColor.gray.cgColor
                    sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                }
                
                if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == "True" {
                } else {
                    if farmIdTextField.text!.count == 0 {
                        borderRedCheck = false
                    }
                }
                if sireIdTextField.text?.count == 17  || sireIdTextField.text?.count == 0{
                }
                else{
                    if autoSuggestionStatus == true {
                    }
                    else {
                        if pvid == 3 {
                        }
                        else {
                            validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                            return
                        }
                    }
                }
                if damtexfield.text?.count == 17  || damtexfield.text?.count == 0{
                }
                else{
                    if pvid != 3 {
                        validationId17SireDam(animalId: damtexfield.text!, tag: 4)
                        return
                    }
                }
                if !borderRedCheck {
                    addBtnCondtion(completionHandler: { (success) -> Void in
                        if success{
                            borderRedCheck = true
                            completionHandler(true)
                            
                        }
                    })
                }
                else {
                    if farmIdTextField.text?.count == 0 {
                        farmIdView.layer.borderColor = UIColor.red.cgColor
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                        return
                        
                    }
                    else  {
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalIDStr, comment: ""), duration: 2, position: .top)
                        farmIdView.layer.borderColor = UIColor.red.cgColor
                        return
                    }
                }
            }
        }
        
        else {
            if  scanAnimalTagText.text == "" {
                if scanAnimalTagText.text!.count == 0 {
                    officalTagView.layer.borderColor = UIColor.red.cgColor
                } else {
                    officalTagView.layer.borderColor = UIColor.gray.cgColor
                    scanAnimalTagText.textColor = UIColor.black
                }
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseFillFields, comment: ""))
                completionHandler(false)
                return
                
            } else {
                officalTagView.layer.borderColor = UIColor.gray.cgColor
                scanAnimalTagText.textColor = UIColor.black
                barcodeView.layer.borderColor = UIColor.gray.cgColor
                scanBarcodeText.textColor = UIColor.black
                
                if sireIdTextField.text?.count != 0 || damtexfield.text?.count != 0 {
                    
                    if sireIdTextField.text!.count == 0 {
                        sireIdValidationB = false
                        sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                    }
                    if damtexfield.text!.count == 0 {
                        damIdValidationB = false
                        damtexfield.layer.borderColor = UIColor.gray.cgColor
                    }
                    
                    if ausBullId.contains(sireIdTextField.text?.uppercased() as Any) || sireNationalID.contains(sireIdTextField.text?.uppercased() as Any){
                        sireIdValidationB = false
                    }
                    
                    if  borderRedCheck || damIdValidationB || sireIdValidationB  {
                        if sireIdTextField.text?.count != 0{
                            if sireIdValidationB  {
                                if autoSuggestionStatus != true {
                                    if pvid == 3 {
                                        sireIdTextField.layer.borderColor = UIColor.red.cgColor
                                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.bullIdDoesNotExist, comment: ""))
                                        return
                                    } else {
                                        validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                                        return
                                    }
                                }
                            }
                        }
                        
                        else {
                            sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                        }
                        
                        if damtexfield.text?.count != 0{
                            if damIdValidationB  {
                                if pvid != 3 {
                                    validationId17SireDam(animalId: damtexfield.text!, tag: 4)
                                    return
                                }
                            }
                        } else {
                            damtexfield.layer.borderColor = UIColor.gray.cgColor
                        }
                        if borderRedCheck {
                            officalTagView.layer.borderColor = UIColor.red.cgColor
                            self.view.makeToast( NSLocalizedString(LocalizedStrings.invalidAnimalIDStr, comment: ""), duration: 2, position: .top)
                            
                        }
                        return
                    }
                }
                
                if scanAnimalTagText.text?.count == 17 {
                } else {
                    borderRedCheck = true
                    
                }
                
                if borderRedCheck {
                    officalTagView.layer.borderColor = UIColor.red.cgColor
                    self.view.makeToast( NSLocalizedString(LocalizedStrings.invalidAnimalIDStr, comment: ""), duration: 2, position: .top)
                    return
                }
                else {
                    if sireIdTextField.text?.count == 17  || sireIdTextField.text?.count == 0{
                    }
                    else{
                        if autoSuggestionStatus == true {
                        }else{
                            if autoSuggestionStatus == true {
                            }else{
                                if pvid == 3 {
                                }
                                else {
                                    validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                                    return
                                }
                            }
                        }
                    }
                    if damtexfield.text?.count == 17  || damtexfield.text?.count == 0{
                    }
                    else{
                        if pvid != 3 {
                            validationId17SireDam(animalId: damtexfield.text!, tag: 4)
                            return
                        }
                    }
                    addBtnCondtion(completionHandler: { (success) -> Void in
                        if success{
                            borderRedCheck = true
                            
                            completionHandler(true)
                            
                        }
                    })
                }
            }
        }
        
        if dataEntryConflicedBack {
            notificationLblCount.isHidden = true
            countLbl.isHidden = true
            self.cartView.isHidden = true
        } else {
            if notificationLblCount.text != "0"{
                countLbl.isHidden = false
                notificationLblCount.isHidden = false
                self.cartView.isHidden = false
            }
        }}
    
    func autoPop(animalData:NSArray) {
        let data =  animalData.lastObject as! AnimalMaster
        if data.breedName == ButtonTitles.girolandoText || data.breedId == keyValue.girlandoNewBreedId.rawValue || data.breedName == BreedNames.girlandoBreed{
            return
        }
        barcodeflag = false
        isautoPopulated = true
        barAutoPopu = true
        textFieldBackroungWhite()
        updateOrder = true
        animalId1 = Int(data.animalId)
        if pvid == 3 {
            sireIdValidationB = true
            autoSuggestionStatus = true
        } else {
            sireIdValidationB = false
            autoSuggestionStatus = false
        }
        
        if selctionAuProvider == true {
            if data.sireIDAU == "" {
                
            } else {
                nationalHerdIdTextField.text = data.nationHerdAU
                sireIAuTextField.text = data.sireIDAU
            }
            
        } else {
            nationalHerdIdTextField.text = data.nationHerdAU
            sireIAuTextField.text = data.sireIDAU
        }
        
        officalTagView.layer.borderColor = UIColor.gray.cgColor
        farmIdView.layer.borderColor = UIColor.gray.cgColor
        barcodeView.layer.borderColor = UIColor.gray.cgColor
        permanentIDTextField.layer.borderColor = UIColor.gray.cgColor
        sireIdTextField.layer.borderColor = UIColor.gray.cgColor
        damtexfield.layer.borderColor = UIColor.gray.cgColor
        dateBtnOutlet.titleLabel?.text = ""
        if data.date != "" {
            
            let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
            let formatter = DateFormatter()
            dateOfBirthLbl.text = ""
            if dateStr == "MM"{
                var dateVale = ""
                let values = data.date!.components(separatedBy: "/")
                let date = values[0]
                let month = values[1]
                let year = values[2]
                dateVale = month + "/" + date + "/" + year
                if UserDefaults.standard.value(forKey: "defaultDatePicker") as! String == "pickerMode" {
                    dateBtnOutlet.setTitle(dateVale, for: .normal)
                } else {
                    dateTextField.text = dateVale
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
                if UserDefaults.standard.value(forKey: "defaultDatePicker") as! String == "pickerMode" {
                    dateBtnOutlet.setTitle(dateVale, for: .normal)
                } else {
                    dateTextField.text = dateVale
                }
                formatter.dateFormat = DateFormatters.ddMMyyyyFormat
            }
            
            self.selectedDate = formatter.date(from: dateBtnOutlet.titleLabel!.text!) ?? Date()
            let isGreater = Date().isSmaller(than: selectedDate)
            if isGreater {
                dateBtnOutlet.setTitle("", for: .normal)
                dateTextField.text = ""
                
            }
        }
        checkBarcode = false
        incrementalBarcodeTitleLabel.textColor = .black
        incrementalBarcodeButton.isEnabled = true
        let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.dataEntryAnimalAddTbl,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
        if dataFetch.count != 0 {
            if data.orderstatus == "true"{
                
            } else {
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
                UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlagDataEntry.rawValue)
                matchedBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                matchedBarcodeBtnOutlet.isEnabled = false
                matchedBarcodeLbl.textColor = .gray
                matchedBarcodeCheckBox.alpha = 0.6
                matchedBarcodeBtnOutlet.alpha = 0.6
                matchedBarcodeLbl.alpha = 0.6
            }
        }
        permanentIDTextField.text = data.offPermanentId
        damtexfield.text = data.offDamId
        breedBtnOutlet.setTitle(data.breedName, for: .normal)
        UserDefaults.standard.set(data.breedName, forKey: keyValue.dataEntrybreedName.rawValue)
        tissueBtnOutlet.setTitleColor(.black, for: .normal)
        breedBtnOutlet.setTitleColor(.black, for: .normal)
        tissueBtnOutlet.setTitle(data.tissuName, for: .normal)
        UserDefaults.standard.set(data.tissuName, forKey: keyValue.dataEntryTsu.rawValue)
        
        if data.tissuName?.isEmpty == true {
            self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue))
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
                } else if pvid == 8{
                    saveSampleNameandID(sampleNameStr: LocalizedStrings.hairString, sampleID: 4)
                    self.tissueBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.hairString, comment: ""), for: .normal)
                }
                else {
                    if checkdefault == true
                    {
                        saveSampleNameandID(sampleNameStr: tissue?.sampleName ?? "", sampleID: 0)
                        self.tissueBtnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
                    }
                }
            }
        }
        
        breedId = data.breedId!
        let breedidd =  UserDefaults.standard.value(forKey: keyValue.dataEntrybreedId.rawValue) as? String
        if breedidd != breedId {
            let  aDat = fetchAnimaldata(status: Entities.dataEntryAnimalAddTbl)
            if aDat.count > 1{
                UserDefaults.standard.set(true, forKey: keyValue.identifyStore.rawValue)
            }
        }
        UserDefaults.standard.set(breedId, forKey: keyValue.dataEntrybreedId.rawValue)
        
        if data.gender == ButtonTitles.maleText.localized || data.gender == "M" {
            self.male_femaleBtnOutlet.setTitle("Male", for: .normal)
            genderToggleFlag = 1
            genderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
            
        } else {
            self.male_femaleBtnOutlet.setTitle("Female", for: .normal)
            genderToggleFlag = 0
            genderString = ButtonTitles.femaleText.localized
        }
        
        let screenRefernce = UserDefaults.standard.value(forKey:keyValue.screen.rawValue) as? String
        if screenRefernce == keyValue.farmId.rawValue || screenRefernce == ""{
            scanAnimalTagText.text = data.farmId
            UserDefaults.standard.set(data.animalTag!.uppercased(), forKey: keyValue.selectAnimalId.rawValue)
            farmIdTextField.text = data.animalTag
        } else {
            scanAnimalTagText.text = data.animalTag
            UserDefaults.standard.set(data.animalTag!.uppercased(), forKey: keyValue.selectAnimalId.rawValue)
            farmIdTextField.text = data.farmId
        }
        
        sireIdValidationB = false
        damIdValidationB = false
        let et = data.eT
        etBtn = et!
        
        if pvid == 3 {
            if ausBullId.contains(data.offsireId as Any) || sireNationalID.contains(data.offsireId as Any){
                sireIdTextField.text = data.offsireId
            } else {
                let fetchData =  fetchAusNaabBullAgaintName(entityName: Entities.ausNaabBullTblEntity, sireNationalId: data.offsireId ?? "")
                if fetchData.count != 0 {
                    let nationHerdAU1 = fetchData.object(at: 0) as? AusNaabBull
                    let bullId =   nationHerdAU1?.bullID ?? ""
                    sireIdTextField.text = bullId
                } else  {
                    sireIdValidationB = true
                    sireIdTextField.text = data.offsireId
                    sireIdTextField.layer.borderColor = UIColor.red.cgColor
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.bullIdDoesNotExist, comment: ""))
                    return
                }
            }
        } else  {
            sireIdTextField.text = data.offsireId
        }
        
        if et == NSLocalizedString("Et", comment: ""){
            etBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
            etBttn.layer.borderWidth = 2
            singleBttn.layer.borderColor = UIColor.gray.cgColor
            internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
            multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
            SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
            cloneOutlet.layer.borderColor = UIColor.gray.cgColor
            selectedBornTypeId = 3
        }
        
        else if et == NSLocalizedString(LocalizedStrings.singlesText, comment: ""){
            singleBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
            singleBttn.layer.borderWidth = 2
            internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
            multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
            SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
            cloneOutlet.layer.borderColor = UIColor.gray.cgColor
            etBttn.layer.borderColor = UIColor.gray.cgColor
            selectedBornTypeId = 1
        }
        
        else if et == NSLocalizedString(LocalizedStrings.multipleBirthStr, comment: ""){
            multipleBirthBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
            multipleBirthBttn.layer.borderWidth = 2
            internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
            singleBttn.layer.borderColor = UIColor.gray.cgColor
            SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
            cloneOutlet.layer.borderColor = UIColor.gray.cgColor
            etBttn.layer.borderColor = UIColor.gray.cgColor
            selectedBornTypeId = 2
        }
        
        else if et == NSLocalizedString(LocalizedStrings.splitEmbryoStr, comment: ""){
            SplitEmbryoOutlet.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
            SplitEmbryoOutlet.layer.borderWidth = 2
            internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
            singleBttn.layer.borderColor = UIColor.gray.cgColor
            multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
            cloneOutlet.layer.borderColor = UIColor.gray.cgColor
            etBttn.layer.borderColor = UIColor.gray.cgColor
            selectedBornTypeId = 4
        }
        
        else if et == NSLocalizedString(LocalizedStrings.cloneText, comment: ""){
            cloneOutlet.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
            cloneOutlet.layer.borderWidth = 2
            internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
            singleBttn.layer.borderColor = UIColor.gray.cgColor
            multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
            SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
            etBttn.layer.borderColor = UIColor.gray.cgColor
            selectedBornTypeId = 5
        }
        
        else if et == NSLocalizedString(LocalizedStrings.internalStr, comment: ""){
            internalBtnOulet.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
            internalBtnOulet.layer.borderWidth = 2
            cloneOutlet.layer.borderColor = UIColor.gray.cgColor
            singleBttn.layer.borderColor = UIColor.gray.cgColor
            multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
            SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
            etBttn.layer.borderColor = UIColor.gray.cgColor
            selectedBornTypeId = 6
        }
        
        tissuId = Int(data.tissuId)
        dateBtnOutlet.setTitleColor(.black, for: .normal)
        statusOrder = false
        messageCheck = false
    }
    
    func changeViewColorToBlack(view : [UIView], color : CGColor) {
        for value in view {
            value.layer.borderColor = color
        }
    }
}
