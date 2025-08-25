//
//  OrderingAnimalVCSelectorAndUIMethods.swift
//  SearchPoint
//
//  Created by Mobile Programming on 22/03/24.
//

import Foundation
import UIKit

//MARK: OBJC SELECTOR METHODS
extension OrderingAnimalVC {
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            addanimalbo.isHidden = true
            countineanimalbo.isHidden = true
            
            if(UserDefaults.standard.value(forKey: keyValue.scrollIsEnable.rawValue) as? Bool ?? true){
                scrolView.isScrollEnabled = true
            }
            else {
                scrolView.isScrollEnabled = false
            }
            DispatchQueue.main.async {
                self.keyBoardOptionsView.isHidden = false
            }
            keyBoardOptionsViewBottomConstrains.constant = keyboardHeight+20
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        scrolView.isScrollEnabled = true
        addanimalbo.isHidden = false
        countineanimalbo.isHidden = false
        keyBoardOptionsView.isHidden = true
    }
    
    @objc func doneClick() {
        let date = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        let dateFormatter3 = DateFormatter()
        if date == "MM"{
            dateFormatter3.dateFormat = DateFormatters.MMddyyyyFormat
        }
        else {
            dateFormatter3.dateFormat = DateFormatters.ddMMyyyyFormat
        }
        self.selectedDate = datePicker.date
        
        let selectedDate = dateFormatter3.string(from: datePicker.date)
        dateBtnOutlet.setTitle(selectedDate, for: .normal)
        dateTextField.text = selectedDate
        
        self.datePicker.resignFirstResponder()
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        calenderView.isHidden = true
        calendarViewBkg.isHidden = true
    }
    
    @objc func cancelClick() {
        calenderView.isHidden = true
        calendarViewBkg.isHidden = true
        datePicker.isHidden = true
        self.toolBar.isHidden = true
    }
    
    @objc func checkForReachability(notification:Notification){
        let del = UIApplication.shared.delegate as? AppDelegate
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if NetworkStatusLbl?.text == ButtonTitles.connectedText.localized {
            networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
            offLineBtn.isEnabled = false
        }
        else {
            networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
            offLineBtn.isEnabled = true
        }
    }
    
    @objc func buttonbgPressed (){
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    @objc func buttonbgPressedTip (){
        buttonbg1.removeFromSuperview()
        customPopView1.removeFromSuperview()
    }
    
    @objc func buttonPreddDroper() {
        buttonbg2.removeFromSuperview()
    }
    
    @objc func buttonPreddDroperAutosugesstion() {
        buttonbgAutoSuggestion.removeFromSuperview()
    }
    
    @objc func closeAddAnimalAndContinueOptions(tapGestureRecognizer: UITapGestureRecognizer) {
        view1.isHidden = true
        view2.isHidden = true
    }
    
    @objc func methodOfReceivedNotification(notification: Notification){
        if value == 0{
            UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
            self.hideIndicator()
            value = value + 1
        }
    }
}

//MARK: UI METHODS
extension OrderingAnimalVC {
    
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
        
        _ =  fetchAllData(entityName: Entities.animalAddTblEntity)
        animalId1 = Int(data.animalId)
        if pvid == 3 {
            sireIdValidationB = true
            autoSuggestionStatus = true
        }
        else {
            sireIdValidationB = false
            autoSuggestionStatus = false
        }
        
        if selctionAuProvider == true {
            if data.sireIDAU != "" {
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
            
            if dateStr == "MM"{
                var dateVale = ""
                let values = data.date!.components(separatedBy: "/")
                let date = values[0]
                let month = values[1]
                let year = values[2]
                dateVale = month + "/" + date + "/" + year
                dateBtnOutlet.setTitle(dateVale, for: .normal)
                dateTextField.text = dateVale
                formatter.dateFormat = DateFormatters.MMddyyyyFormat
            }
            else {
                var dateVale = ""
                let values = data.date!.components(separatedBy: "/")
                let date = values[0]
                let month = values[1]
                let year = values[2]
                dateVale = date + "/" + month + "/" + year
                dateBtnOutlet.setTitle(dateVale, for: .normal)
                dateTextField.text = dateVale
                formatter.dateFormat = DateFormatters.ddMMyyyyFormat
            }
            
            self.selectedDate = formatter.date(from: dateBtnOutlet.titleLabel!.text!) ?? Date()
            let isGreater = Date().isSmaller(than: selectedDate)
            
            if isGreater {
                dateBtnOutlet.setTitle("", for: .normal)
                dateTextField.text = ""
            }
        }else {
            dateBtnOutlet.setTitle("", for: .normal)
            
        }
        checkBarcode = false
        incrementalBarcodeTitleLabel.textColor = .black
        incrementalBarcodeButton.isEnabled = true
        
        let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.animalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
        if dataFetch.count != 0 {
            if data.orderstatus != "true"{
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
                UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlag.rawValue)
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
        UserDefaults.standard.set(data.breedName, forKey: keyValue.capsBreedName.rawValue)
        tissueBtnOutlet.setTitleColor(.black, for: .normal)
        breedBtnOutlet.setTitleColor(.black, for: .normal)
        tissueBtnOutlet.setTitle(data.tissuName?.localized, for: .normal)
        saveSampleNameandID(sampleNameStr: data.tissuName ?? "", sampleID: Int(data.tissuId))
        UserDefaults.standard.set(data.tissuName, forKey: keyValue.tsuKey.rawValue)
        
        if data.tissuName?.isEmpty == true {
            let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
            if providerName == keyValue.clarifideAHDBUK.rawValue{
                self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
                for items in self.tissueArr{
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
                    } else {
                        if checkdefault == true{
                            saveSampleNameandID(sampleNameStr: tissue?.sampleName ?? "", sampleID: Int(tissue?.sampleId ?? 0))
                            self.tissueBtnOutlet.setTitle(tissue?.sampleName, for: .normal)
                        }
                    }
                }
            }
            else {
                self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
                for items in self.tissueArr{
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
                    } else {
                        if checkdefault == true{
                            saveSampleNameandID(sampleNameStr: tissue?.sampleName ?? "", sampleID: Int(tissue?.sampleId ?? 0))
                            self.tissueBtnOutlet.setTitle(tissue?.sampleName, for: .normal)
                        }
                    }
                }
            }
        }
        breedId = data.breedId!
        let breedidd =  UserDefaults.standard.value(forKey: keyValue.breed.rawValue) as? String
        if breedidd != breedId {
            let  aDat = fetchAnimaldata(status: Entities.animalAddTblEntity)
            if aDat.count > 1{
                UserDefaults.standard.set(true, forKey: keyValue.identifyStore.rawValue)
            }
        }
        
        UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
        let langCode : String = UserDefaults.standard.object(forKey: keyValue.lngCode.rawValue) as! String
        if data.gender == "Male".localized || data.gender == "M" {
            self.male_femaleBtnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 1
            genderString = NSLocalizedString("Male", comment: "")
            UserDefaults.standard.set("M", forKey: "USDairyGender")
            
        }
        else {
            self.male_femaleBtnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 0
            genderString = NSLocalizedString("Female", comment: "")
            UserDefaults.standard.set("F", forKey: "USDairyGender")
        }
        
        let screenRefernce = UserDefaults.standard.value(forKey:keyValue.screen.rawValue) as? String
        
        if screenRefernce == keyValue.farmId.rawValue || screenRefernce == ""{
            scanAnimalTagText.text = data.farmId
            UserDefaults.standard.set(data.animalTag!.uppercased(), forKey: keyValue.selectAnimalId.rawValue)
            farmIdTextField.text = data.animalTag
        }
        else {
            scanAnimalTagText.text = data.animalTag
            UserDefaults.standard.set(data.animalTag!.uppercased(), forKey: keyValue.selectAnimalId.rawValue)
            farmIdTextField.text = data.farmId
        }
        
        sireIdValidationB = false
        damIdValidationB = false
        singleBttn.layer.borderColor = UIColor.gray.cgColor
        singleBttn.layer.borderWidth = 0.5
        let et = data.eT
        etBtn = et!
        etBttn.layer.borderWidth = 0.5
        singleBttn.layer.borderWidth = 0.5
        multipleBirthBttn.layer.borderWidth = 0.5
        cloneOutlet.layer.borderWidth = 0.5
        SplitEmbryoOutlet.layer.borderWidth = 0.5
        internalBtnOulet.layer.borderWidth = 0.5
        
        if pvid == 3 {
            if ausBullId.contains(data.offsireId as Any) || sireNationalID.contains(data.offsireId as Any){
                sireIdTextField.text = data.offsireId
            }
            else {
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
        
        if et == "Et"{
            etBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            etBttn.layer.borderWidth = 2
            singleBttn.layer.borderColor = UIColor.gray.cgColor
            internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
            multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
            SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
            cloneOutlet.layer.borderColor = UIColor.gray.cgColor
            selectedBornTypeId = 3
        }
        
        else if et == LocalizedStrings.singlesText{
            singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            singleBttn.layer.borderWidth = 2
            internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
            multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
            SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
            cloneOutlet.layer.borderColor = UIColor.gray.cgColor
            etBttn.layer.borderColor = UIColor.gray.cgColor
            selectedBornTypeId = 1
        }
        
        else if et == LocalizedStrings.multipleBirthStr{
            multipleBirthBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            multipleBirthBttn.layer.borderWidth = 2
            internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
            singleBttn.layer.borderColor = UIColor.gray.cgColor
            SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
            cloneOutlet.layer.borderColor = UIColor.gray.cgColor
            etBttn.layer.borderColor = UIColor.gray.cgColor
            selectedBornTypeId = 2
        }
        
        else if et == NSLocalizedString(LocalizedStrings.splitEmbryoStr, comment: ""){
            SplitEmbryoOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            SplitEmbryoOutlet.layer.borderWidth = 2
            internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
            singleBttn.layer.borderColor = UIColor.gray.cgColor
            multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
            cloneOutlet.layer.borderColor = UIColor.gray.cgColor
            etBttn.layer.borderColor = UIColor.gray.cgColor
            selectedBornTypeId = 4
        }
        
        else if et == LocalizedStrings.cloneText{
            cloneOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            cloneOutlet.layer.borderWidth = 2
            internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
            singleBttn.layer.borderColor = UIColor.gray.cgColor
            multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
            SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
            etBttn.layer.borderColor = UIColor.gray.cgColor
            selectedBornTypeId = 5
        }
        
        else if et == LocalizedStrings.internalStr{
            internalBtnOulet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            internalBtnOulet.layer.borderWidth = 2
            cloneOutlet.layer.borderColor = UIColor.gray.cgColor
            singleBttn.layer.borderColor = UIColor.gray.cgColor
            multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
            SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
            etBttn.layer.borderColor = UIColor.gray.cgColor
            selectedBornTypeId = 6
        }
        
        tissuId = Int(data.tissuId)
        sampleID = Int(data.tissuId)
        dateBtnOutlet.setTitleColor(.black, for: .normal)
        statusOrder = false
        messageCheck = false
    }
    
    func initialNetworkCheck(){
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del = UIApplication.shared.delegate as? AppDelegate
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if NetworkStatusLbl?.text == ButtonTitles.connectedText.localized{
            networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
            offLineBtn.isEnabled = false
        }
        else {
            offLineBtn.isEnabled = true
            networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    func byDefaultSetting(){
        let dateformt = DateFormatter()
        let dateStr = UserDefaults.standard.value(forKey: "date") as? String
        
        if dateStr == "MM" {
            dateformt.dateFormat = "MM/dd/yyyy"
            
        } else {
            dateformt.dateFormat = "dd/MM/yyyy"
        }
        
        animalId1 = 0
        idAnimal = 0
        isUpdate = false
        msgUpatedd = false
        barAutoPopu = false
        self.msgcheckk = false
        self.isautoPopulated = false
        dataAutoPopulatedBool =  false
        farmIDBoolEntry = false
        farmIDBoolEntryTag = false
        farmIDBoolEntrySecond = false
        dateBtnOutlet.setTitleColor(UIColor.gray, for: .normal)
        breedBtnOutlet.setTitleColor(UIColor.gray, for: .normal)
        dateOfBirthLbl.textColor = UIColor.gray
        etBttn.layer.borderWidth = 0.5
        singleBttn.layer.borderWidth = 0.5
        multipleBirthBttn.layer.borderWidth = 0.5
        cloneOutlet.layer.borderWidth = 0.5
        SplitEmbryoOutlet.layer.borderWidth = 0.5
        internalBtnOulet.layer.borderWidth = 0.5
        nationalHerdIdTextField.layer.borderWidth = 0.5
        sireIAuTextField.layer.borderWidth = 0.5
        officalTagView.layer.borderColor = UIColor.gray.cgColor
        cloneOutlet.layer.borderColor = UIColor.gray.cgColor
        SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
        etBttn.layer.borderColor = UIColor.gray.cgColor
        singleBttn.layer.borderColor = UIColor.gray.cgColor
        multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
        farmIdView.layer.borderColor = UIColor.gray.cgColor
        barcodeView.layer.borderColor = UIColor.gray.cgColor
        permanentIDTextField.layer.borderColor = UIColor.gray.cgColor
        sireIdTextField.layer.borderColor = UIColor.gray.cgColor
        damtexfield.layer.borderColor = UIColor.gray.cgColor
        internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
        nationalHerdIdTextField.layer.borderColor = UIColor.gray.cgColor
        sireIAuTextField.layer.borderColor = UIColor.gray.cgColor
        dateBtnOutlet.layer.borderColor = UIColor.gray.cgColor
        nationalHerdIdTextField.text?.removeAll()
        sireIAuTextField.text?.removeAll()
        scanBarcodeText.text?.removeAll()
        scanAnimalTagText.text?.removeAll()
        farmIdTextField.text?.removeAll()
        scanAnimalTagText.text?.removeAll()
        permanentIDTextField.text?.removeAll()
        sireIdTextField.text?.removeAll()
        damtexfield.text?.removeAll()
        
        if UserDefaults.standard.value(forKey: keyValue.capsBreedName.rawValue) as? String == "" || UserDefaults.standard.value(forKey: keyValue.capsBreedName.rawValue)  as? String == nil{
            breedBtnOutlet.setTitle("HO", for: .normal)
        }
        
        else {
            let breedName = UserDefaults.standard.value(forKey: keyValue.capsBreedName.rawValue)  as? String
            let filterBreedArray = breedArr.filter{($0 as! GetBreedsTbl ).breedName == breedName}
            
            if filterBreedArray.count > 0{
                breedBtnOutlet.setTitle(breedName, for: .normal)
                
            }
        }
        
        if UserDefaults.standard.value(forKey: "USDairyGender") as? String == "F" || UserDefaults.standard.value(forKey: "USDairyGender") == nil {
            genderString = NSLocalizedString("Female", comment: "")
            UserDefaults.standard.set("F", forKey: "USDairyGender")
            self.male_femaleBtnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 0
            
        } else {
            genderString = NSLocalizedString("Male", comment: "")
            UserDefaults.standard.set("M", forKey: "USDairyGender")
            self.male_femaleBtnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
            genderToggleFlag = 1
        }
        
        if UserDefaults.standard.string(forKey: "tsu") == nil || UserDefaults.standard.string(forKey: "tsu") == ""{
            self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid) as! [GetSampleTbl] as NSArray
            
            for items in self.tissueArr{
                let tissue = items  as? GetSampleTbl
                let checkdefault  = tissue?.isDefault
                
                if pvid == 11 {
                    let country : String = UserDefaults.standard.object(forKey: keyValue.country.rawValue) as? String ?? ""
                    
                    switch country  {
                        
                    case countryName.Belgium.title, countryName.Luxembourg.title :
                        saveSampleNameandID(sampleNameStr: "Allflex (TSU)", sampleID: 1)
                        self.tissueBtnOutlet.setTitle("Allflex (TSU)", for: .normal)
                        
                    case countryName.Netherlands.title :
                        saveSampleNameandID(sampleNameStr: "Hair", sampleID: 4)
                        self.tissueBtnOutlet.setTitle(NSLocalizedString("Hair", comment: ""), for: .normal)
                        
                    default:
                        break
                    }
                    
                } else if pvid == 8 {
                    saveSampleNameandID(sampleNameStr: "Hair", sampleID: 4)
                    self.tissueBtnOutlet.setTitle(NSLocalizedString("Hair", comment: ""), for: .normal)
                }
                else  {
                    if checkdefault == true{
                        saveSampleNameandID(sampleNameStr: tissue?.sampleName ?? "", sampleID: Int(tissue?.sampleId ?? 0))
                        tissueBtnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
                    }
                }
            }
        }
        
        else{
            
            self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid) as! [GetSampleTbl] as NSArray
            let filterTissueArray = tissueArr.filter{($0 as! GetSampleTbl).sampleName == UserDefaults.standard.string(forKey: "tsu")}
            
            if filterTissueArray.count > 0{
                sampleID = Int((filterTissueArray[0] as! GetSampleTbl).sampleId)
                sampleName = (filterTissueArray[0] as! GetSampleTbl).sampleName ?? ""
                tissueBtnOutlet.setTitle(UserDefaults.standard.string(forKey: "tsu")?.localized, for: .normal)
            }
            else {
                sampleID = Int((tissueArr[0] as! GetSampleTbl).sampleId)
                sampleName = (tissueArr[0] as! GetSampleTbl).sampleName ?? ""
                tissueBtnOutlet.setTitle((tissueArr[0] as! GetSampleTbl).sampleName?.localized, for: .normal)
            }
        }
        
        let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
        
        if providerName == keyValue.clarifideAHDBUK.rawValue{
            
            if UserDefaults.standard.string(forKey: "tsu") == nil || UserDefaults.standard.string(forKey: "tsu") == ""{
                self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
                
                for items in self.tissueArr{
                    let tissue = items  as? GetSampleTbl
                    let checkdefault  = tissue?.isDefault
                    
                    if pvid == 11 {
                        
                        let country : String = UserDefaults.standard.object(forKey: keyValue.country.rawValue) as? String ?? ""
                        
                        switch country  {
                        case countryName.Belgium.title, countryName.Luxembourg.title :
                            saveSampleNameandID(sampleNameStr: "Allflex (TSU)", sampleID: 1)
                            self.tissueBtnOutlet.setTitle("Allflex (TSU)", for: .normal)
                            
                        case countryName.Netherlands.title :
                            saveSampleNameandID(sampleNameStr: "Hair", sampleID: 4)
                            self.tissueBtnOutlet.setTitle(NSLocalizedString("Hair", comment: ""), for: .normal)
                            
                        default:
                            break
                        }
                    }
                    
                    else  {
                        
                        if checkdefault == true{
                            saveSampleNameandID(sampleNameStr: tissue?.sampleName ?? "", sampleID: Int(tissue?.sampleId ?? 0))
                            tissueBtnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
                        }
                    }
                }
            }
            
            else{
                saveSampleNameandID(sampleNameStr: UserDefaults.standard.string(forKey: "tsu") ?? "", sampleID: 0)
                tissueBtnOutlet.setTitle(UserDefaults.standard.string(forKey: "tsu")?.localized, for: .normal)
            }
            
            
            
            if breedId  == "" {
                let inheritBreed = fetchAllDataProductBeefIdDairy(entityName: Entities.getBreedsTblEntity, breedName: (breedBtnOutlet.titleLabel?.text)!, pvid: 2)
                
                if inheritBreed.count != 0 {
                    let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                    breedId = medbreedRegArr1!.breedId ?? ""
                    UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                }
            }
        }
        
        breedBtnOutlet.setTitleColor(.gray, for: .normal)
        tissueBtnOutlet.setTitleColor(.gray, for: .normal)
        self.selectedDate = Date()
        textFieldBackroungGrey()
        self.scrolView.contentOffset.y = 0.0
        dateBtnOutlet.titleLabel?.text = ""
        dateBtnOutlet.setTitle(nil, for: .normal)
        dateTextField.text = ""
        self.selectedBornTypeId = 1
        
        if pvid == 1 || pvid == 10 || pvid == 11 || pvid == 6 || pvid == 8 || pvid == 12{
            if breedId  == "" {
                let inheritBreed = fetchAllDataProductBeefIdDairy(entityName: Entities.getBreedsTblEntity, breedName: (breedBtnOutlet.titleLabel?.text)!, pvid: pvid)
                
                if inheritBreed.count != 0 {
                    let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                    breedId = medbreedRegArr1!.breedId ?? ""
                    UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                }
            }
        } else if pvid == 3 {
            if breedId  == "" {
                let inheritBreed = fetchAllDataProductBeefIdDairy(entityName: Entities.getBreedsTblEntity, breedName: (breedBtnOutlet.titleLabel?.text)!, pvid: 3)
                
                if inheritBreed.count != 0 {
                    let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                    breedId = medbreedRegArr1!.breedId ?? ""
                    UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                }
            }
        }
        
        incrementalBarcodeTitleLabel.textColor = .gray
        incrementalBarcodeButton.isEnabled = false
        self.scanAnimalTagText.becomeFirstResponder()
        loadedAnimalData = nil
        iscomingFromCart = false
        breedChanged = false
    }
    
    func timeStamp()-> String {
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
    
    func setUIOnDidLoad(){
        if UIDevice().userInterfaceIdiom == .pad {
            return
        }
        addObserver()
        self.userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        self.orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        tapRec.addTarget(self, action: #selector(closeAddAnimalAndContinueOptions(tapGestureRecognizer:)))
        importListMainView.isHidden = true
        importBGView.isHidden = true
        
        let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.findMyAnimalText, comment: ""), attributes: self.attrs)
        btnFindAnimal.setAttributedTitle(attributeString, for: .normal)
        
        if UserDefaults.standard.bool(forKey: keyValue.matchedBarcodeFlag.rawValue) {
            matchedBarcodeCheckBox.image = UIImage(named: ImageNames.checkImg)
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
        dateOfBirthLbl.text = NSLocalizedString(ButtonTitles.dateOfBirthText, comment: "")
        
        if providerName == keyValue.clarifideAHDBUK.rawValue{
            UserDefaults.standard.set(keyValue.officialId.rawValue, forKey: keyValue.screen.rawValue)
            self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
            for items in self.tissueArr{
                let tissue = items  as? GetSampleTbl
                let checkdefault  = tissue?.isDefault
                
                if pvid == 11 {
                    let country : String = UserDefaults.standard.object(forKey: keyValue.country.rawValue) as? String ?? ""
                    switch country  {
                    case countryName.Luxembourg.title, countryName.Belgium.title :
                        saveSampleNameandID(sampleNameStr: ButtonTitles.allflexTSUText, sampleID: 1)
                        self.tissueBtnOutlet.setTitle(ButtonTitles.allflexTSUText, for: .normal)
                        
                    case countryName.Netherlands.title :
                        saveSampleNameandID(sampleNameStr: LocalizedStrings.hairString, sampleID: 4)
                        self.tissueBtnOutlet.setTitle(LocalizedStrings.hairString.localized, for: .normal)
                        
                    default:
                        break
                    }
                } else {
                    if checkdefault == true{
                        saveSampleNameandID(sampleNameStr: tissue?.sampleName ?? "", sampleID: Int(tissue?.sampleId ?? 0))
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
        genderString = NSLocalizedString("Female", comment: "")
        textFieldBackroungGrey()
        
        if UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue {
            bleBttn.setImage(UIImage(named: ImageNames.ocrInactiveImg), for: .normal)
            blebttn1.setImage(UIImage(named: ImageNames.ocrInactiveImg), for: .normal)
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
        if UIDevice().userInterfaceIdiom == .pad {
            return
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        self.fetchADHAnimalList(userId: 1, customerID: currentCustomerId)
        let dataFetc = fetchDataEnteryWithListId(entityName: Entities.animalAddTblEntity,customerId:self.custmerId ,listId:0,providerId:pvid,orderstatus:"false", orderiD: UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue))
        
        if dataFetc.count == 0 {
            UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
            let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.importMyListStr, comment: ""), attributes: self.attrs)
            mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
            importFromListOutlet.isEnabled = true
            crossedBtnOutlet.isHidden = true
            deleteDataWithPvidCustomerId(entityString: Entities.mergeDataEntryListTblEntity ,providerId: Int64(self.pvid),customerId: Int64(self.custmerId ))
        }
        else {
            let get = dataFetc.object(at: 0) as? AnimaladdTbl
            let getListid = get?.listId ?? 0
            UserDefaults.standard.set(Int64(getListid), forKey: keyValue.dataEntryListId.rawValue)
            UserDefaults.standard.set(Int64(getListid), forKey: keyValue.dataEntryListId.rawValue)
            let fetchName = fetchListNameAccordingToListId(entityName: Entities.dataEntryListTblEntity,customerId:custmerId ,listId:getListid,providerId:pvid )
            
            if fetchName.count != 0{
                let getName = fetchName.object(at: 0) as? DataEntryList
                let getListName = getName?.listName ?? ""
                let speciesType = UserDefaults.standard.object(forKey: keyValue.name.rawValue) as? String ?? ""
                var cartListName = "_" + "CartList" + "_" + speciesType.lowercased()
                if let emails = getName?.listName?.getEmails() {
                    if emails.count > 0 {
                        cartListName = emails[0] + cartListName
                        
                        if getListName.contains(cartListName)
                        {
                            crossedBtnOutlet.isHidden = true
                        } else {
                            crossedBtnOutlet.isHidden = false
                        }
                    } else {
                        crossedBtnOutlet.isHidden = false
                    }
                    
                } else {
                    crossedBtnOutlet.isHidden = false
                }
                
                importFromListOutlet.isEnabled = true
                let attributeString = NSMutableAttributedString(string: getListName, attributes: self.attrs)
                mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
            }
        }
        
        if fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count == 0 {
            mergeListBtnOulet.isHidden = true
        } else {
            mergeListBtnOulet.isHidden = false
        }
        let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ,providerId:pvid )
        
        if fetchObj.count != 0 {
            let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
            let obj = objectFetch?.listName
            let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
            
            if fetchAllMergeDta == 0 {
                let fetchNameDisplay = String(obj ?? "")
                let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                
            } else {
                let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
            }
            
        }
        
        let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.importMyListStr, comment: ""), attributes: self.attrs)
        importFromListOutlet.setAttributedTitle(attributeString, for: .normal)
        self.userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        self.orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        matchedBarcodeLbl.text = NSLocalizedString(ButtonTitles.matched840Id, comment: "")
        cancelBtnOutlet.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal)
        okBtnOutlet.setTitle(NSLocalizedString("Ok", comment: ""), for: .normal)
        selectListLbl.text = NSLocalizedString(ButtonTitles.selectListText, comment: "")
        
        if providerName == keyValue.clarifideAHDBUK.rawValue{
            if tissueBtnOutlet.titleLabel?.text == nil || tissueBtnOutlet.titleLabel?.text == ""{
                self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
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
                    } else {
                        if checkdefault == true{
                            saveSampleNameandID(sampleNameStr: tissue?.sampleName ?? "", sampleID: Int(tissue?.sampleId ?? 0))
                            self.tissueBtnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
                        }
                    }
                }
            }
        }
        
        if UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue {
            bleBttn.setImage(UIImage(named: ImageNames.ocrInactiveImg), for: .normal)
            blebttn1.setImage(UIImage(named: ImageNames.ocrInactiveImg), for: .normal)
        } else {
            if BluetoothCentre.shared.smartBowPeripheral?.state == .connected{
                bleBttn.setImage(UIImage(named: ImageNames.forma1Copy2Img), for: .normal)
                blebttn1.setImage(UIImage(named: ImageNames.forma1Copy2Img), for: .normal)
            } else {
                bleBttn.setImage(UIImage(named: ImageNames.scanIconActiveImg), for: .normal)
                blebttn1.setImage(UIImage(named: ImageNames.scanIconActiveImg), for: .normal)
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
            let animaltbl = fetchRemaningSubmitOrder(entityName: Entities.animalAddTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            
            for i in 0..<animaltbl.count{
                let data = animaltbl.object(at: i) as! AnimaladdTbl
                updateOrderStatusServerRemain(entity: Entities.animalMasterTblEntity, aniamltag: data.animalTag!, userId: userId)
            }
            deleteRemaningSubmitOrder(entityName: Entities.animalAddTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            deleteRemaningSubmitOrder(entityName: Entities.productAdonAnimalTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            deleteRemaningSubmitOrder(entityName: Entities.subProductTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            
            UserDefaults.standard.set(autoD, forKey: keyValue.orderId.rawValue)
        }
        autoD = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        self.orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
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
            scanAnimalTagText.placeholder = NSLocalizedString(ButtonTitles.enterOnFarmId, comment: "")
            pairedDeviceTitle.text = NSLocalizedString(ButtonTitles.selectDeviceStr, comment: "")
            farmIdTextField.placeholder = NSLocalizedString(ButtonTitles.scanEnterOfficialTag, comment: "")
            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
            if animalCount.count == 0 {
                auPOPupTitle.text = NSLocalizedString(ButtonTitles.addClarifideCDCBUS, comment: "")
                self.auSelectionView.isHidden = false
                self.AUbackroundView.isHidden = false
            }
            else {
                auPOPupTitle.text = ""
                auSelectionView.isHidden = true
                calendarViewBkg.isHidden = true
                self.AUbackroundView.isHidden = true
            }
            
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
            sireIdAuUperConstraint.constant = 0
            nationalHerdAuUperConstraint.constant = 0
        } else {
            nationalHerdIdTextField.isHidden = true
            sireIAuTextField.isHidden = true
            sireIdAuHeightConstrainr.constant = 0
            nationalHerdAuHeightConstrainr.constant = 0
            sireIdAuUperConstraint.constant = 0
            nationalHerdAuUperConstraint.constant = 0
        }
        
        if UserDefaults.standard.integer(forKey: keyValue.animalIdSelectionCart.rawValue) > 0 {
            
            let cartAnimalID = UserDefaults.standard.integer(forKey: keyValue.animalIdSelectionCart.rawValue)
            let existAnimalData = fetchAllDataWithAnimalIdstatus(entityName: Entities.animalAddTblEntity, animalId:cartAnimalID,orderststus:"false", customerId: self.custmerId) as! [AnimaladdTbl]
            if existAnimalData.count > 0{
                loadedAnimalData = existAnimalData[0]
                iscomingFromCart = true
            }
            animalIdBool = true
            textFieldBackroungWhite()
            UserDefaults.standard.set(0, forKey: keyValue.animalIdSelectionCart.rawValue)
            dataPopulateInScreen(animalId: cartAnimalID)
            
            
            
        }
        
        if !UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncrementalClear.rawValue){
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
        
        if marketNameID == MarketID.NetherlandMarketId {
            if let country = UserDefaults.standard.object(forKey: keyValue.country.rawValue) {
                let getMarketName = fetchAllCountryDataWithMarketIdandCountryname(entityName: Entities.getCountryCodeTblEntity, alpha2: marketNameID ?? "", countryName: country as! String)
                
                if getMarketName.count != 0 {
                    let getMarketName1 = getMarketName.object(at: 0) as? GetCountryCode
                    providerSelectionCountryCode =   getMarketName1?.alphaCode ?? ""
                    providerCountryCodeAlpha2 = getMarketName1?.alpha2 ?? ""
                }
            }
        } else  {
            let getMarketName = fetchAllCountryDataWithMarketId(entityName: Entities.getCountryCodeTblEntity, alpha2: marketNameID!)
            if getMarketName.count != 0 {
                let getMarketName1 = getMarketName.object(at: 0) as? GetCountryCode
                providerSelectionCountryCode =   getMarketName1?.alphaCode ?? ""
            }
        }
        sireTipBTNoUTLET.isHidden = true
        let providerID = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        
        if providerID == 3 {
            UserDefaults.standard.set(true, forKey: keyValue.clickAuProvider.rawValue)
            sireIdTextField.placeholder = NSLocalizedString(ButtonTitles.sireIDNASISBullName, comment: "")
            sireTipBTNoUTLET.isHidden = false
            if UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                
                if scanAnimalTagText.tag == 1 {
                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid)
                    if animalCount.count > 0 {
                        calendarViewBkg.isHidden = true
                        self.auSelectionView.isHidden = true
                        self.AUbackroundView.isHidden = true
                    } else {
                        calendarViewBkg.isHidden = false
                        self.auSelectionView.isHidden = false
                        self.AUbackroundView.isHidden = false
                    }
                    
                } else {
                    calendarViewBkg.isHidden = true
                    self.auSelectionView.isHidden = true
                    self.AUbackroundView.isHidden = true
                }
            } else {
                calendarViewBkg.isHidden = false
                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid)
                if animalCount.count > 0 {
                    auSelectionView.isHidden = true
                    calendarViewBkg.isHidden = true
                    self.AUbackroundView.isHidden = true
                }
                else {
                    calendarViewBkg.isHidden = false
                    self.auSelectionView.isHidden = false
                    self.AUbackroundView.isHidden = false
                }
                
                self.scanAnimalTagText.resignFirstResponder()
            }
        } else {
            UserDefaults.standard.set(keyValue.noNeedAuPopUp.rawValue, forKey: keyValue.isAuSelected.rawValue)
            self.AUbackroundView.isHidden = true
            UserDefaults.standard.set(false, forKey: keyValue.clickAuProvider.rawValue)
            calendarViewBkg.isHidden = true
            self.auSelectionView.isHidden = true
            
        }
        
        let attributeString1 = NSMutableAttributedString(string: NSLocalizedString("Reset", comment: ""), attributes: self.attrs)
        clearFormOutlet.setAttributedTitle(attributeString1, for: .normal)
        let viewAnimalArray =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid)
        if viewAnimalArray.count == 0{
            checkUserDataListName()
        }
        self.updateCartCount()
    }
    
    func setUIOnDidAppear(){
        if UIDevice().userInterfaceIdiom == .pad {
            return
        }
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: pvid)
        notificationLblCount.text = String(animalCount.count)
        
        if animalCount.count == 0{
            notificationLblCount.isHidden = true
            countLbl.isHidden = true
        }
        
        officalTagView.layer.cornerRadius = (officalTagView.frame.size.height / 2)
        officalTagView.layer.borderWidth = 0.5
        officalTagView.layer.borderColor = UIColor.gray.cgColor
        officalTagView.layer.masksToBounds = true
        barcodeView.layer.cornerRadius = (barcodeView.frame.size.height / 2)
        barcodeView.layer.borderWidth = 0.5
        barcodeView.layer.borderColor = UIColor.gray.cgColor
        barcodeView.clipsToBounds = true
        dateBtnOutlet.layer.cornerRadius = (scanAnimalTagText.frame.size.height / 2)
        dateBtnOutlet.layer.borderWidth = 0.5
        dateBtnOutlet.layer.borderColor = UIColor.gray.cgColor
        dateBtnOutlet.clipsToBounds = true
        farmIdView.layer.cornerRadius = (farmIdView.frame.size.height / 2)
        farmIdView.layer.borderWidth = 0.5
        farmIdView.layer.borderColor = UIColor.gray.cgColor
        farmIdView.clipsToBounds = true
        permanentIDTextField.layer.cornerRadius = (scanAnimalTagText.frame.size.height / 2)
        permanentIDTextField.layer.borderWidth = 0.5
        permanentIDTextField.layer.borderColor = UIColor.gray.cgColor
        permanentIDTextField.clipsToBounds = true
        noneBttn.layer.cornerRadius = (noneBttn.frame.size.height / 2)
        noneBttn.layer.borderWidth = 0.5
        noneBttn.layer.borderColor = UIColor.gray.cgColor
        noneBttn.layer.masksToBounds = true
        sireIdTextField.layer.borderWidth = 0.5
        sireIdTextField.layer.borderColor = UIColor.gray.cgColor
        damtexfield.layer.borderColor = UIColor.gray.cgColor
        damtexfield.layer.borderWidth = 0.5
        breedBtnOutlet.layer.borderWidth = 0.5
        tissueBtnOutlet.layer.borderWidth = 0.5
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification , object: nil)
    }
    
    func setUpGallary(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imgPhotoLib = UIImagePickerController()
            imgPhotoLib.delegate = self
            imgPhotoLib.allowsEditing = true
            imgPhotoLib.sourceType = .camera
            imgPhotoLib.accessibilityLanguage = nil
            self.present(imgPhotoLib,animated: true,completion: nil)
        }
    }
    
    func textFieldBackroungWhite(){
        dateOfBirthLbl.textColor = UIColor.black
        dateBtnOutlet.setTitleColor(.black, for: .normal)
        breedBtnOutlet.setTitleColor(UIColor.black, for: .normal)
        tissueBtnOutlet.setTitleColor(UIColor.black, for: .normal)
        male_femaleBtnOutlet.isEnabled = true
        tissueBtnOutlet.isEnabled = true
        etBttn.isEnabled = true
        singleBttn.isEnabled = true
        multipleBirthBttn.isEnabled = true
        sireIdTextField.isEnabled = true
        breedBtnOutlet.isEnabled = true
        cloneOutlet.isEnabled = true
        SplitEmbryoOutlet.isEnabled = true
        internalBtnOulet.isEnabled = true
        dateBtnOutlet.isEnabled = true
        dateTextField.isEnabled = true
        bleBttn.isEnabled = true
        blebttn1.isEnabled = true
        scanButton.isEnabled = true
        farmIdTextField.isEnabled = true
        scanBarcodeText.isEnabled = true
        permanentIDTextField.isEnabled = true
        damtexfield.isEnabled = true
        sireIdTextField.isEnabled = true
        farmIdView.backgroundColor = UIColor.white
        barcodeView.backgroundColor = UIColor.white
        officalTagView.backgroundColor = UIColor.white
        permanentIDTextField.backgroundColor = UIColor.white
        tissueBtnOutlet.backgroundColor = UIColor.white
        etBttn.backgroundColor = UIColor.white
        singleBttn.backgroundColor = UIColor.white
        multipleBirthBttn.backgroundColor = UIColor.white
        sireIdTextField.backgroundColor = UIColor.white
        damtexfield.backgroundColor = UIColor.white
        breedBtnOutlet.backgroundColor = UIColor.white
        internalBtnOulet.backgroundColor = UIColor.white
        cloneOutlet.backgroundColor = UIColor.white
        SplitEmbryoOutlet.backgroundColor = UIColor.white
        farmIdTextField.backgroundColor = UIColor.white
        nationalHerdIdTextField.backgroundColor = UIColor.white
        sireIAuTextField.backgroundColor = UIColor.white
        dateBtnOutlet.backgroundColor = UIColor.white
        scanBarcodeText.textColor = UIColor.black
        if etBtn.count == 0 {
            singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            singleBttn.layer.borderWidth = 2
            self.singleBtnAction(UIButton())
        }
        
        self.isGrayField = false
        self.bornTypeCollection.reloadData()
        
        if !isautoPopulated  {
            incrementalBarcodeTitleLabel.textColor = UIColor.black
            incrementalBarcodeButton.isEnabled = true
            incrementalBarcodeCheckBox.alpha = 1
            incrementalBarcodeTitleLabel.alpha = 1
            if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) && !isautoPopulated {
                if let lastSavedBarCode = UserDefaults.standard.value(forKey: keyValue.barcodeIncremental.rawValue) as? String {
                    if scanBarcodeText.text?.isEmpty == true {
                        scanBarcodeText.text = isBarcodeEndingWithNumberAndGetIncremented(lastSavedBarCode).incrementedBarCode
                    }
                }
            }
            
        } else {
            self.isautoPopulated = false
            incrementalBarcodeTitleLabel.textColor = UIColor.gray
            incrementalBarcodeButton.isEnabled = true
            incrementalBarcodeCheckBox.alpha = 1
            incrementalBarcodeTitleLabel.alpha = 1
        }
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) {
            matchedBarcodeLbl.textColor = UIColor.gray
            matchedBarcodeBtnOutlet.isEnabled = false
            matchedBarcodeCheckBox.alpha = 0.6
            matchedBarcodeLbl.alpha = 0.6
            incrementalBarcodeTitleLabel.textColor = UIColor.black
            incrementalBarcodeButton.isEnabled = true
            incrementalBarcodeCheckBox.alpha = 1
            incrementalBarcodeTitleLabel.alpha = 1
            
        } else if UserDefaults.standard.bool(forKey: keyValue.matchedBarcodeFlag.rawValue) {
            
            incrementalBarcodeTitleLabel.textColor = UIColor.gray
            incrementalBarcodeButton.isEnabled = false
            incrementalBarcodeCheckBox.alpha = 0.6
            incrementalBarcodeTitleLabel.alpha = 0.6
            matchedBarcodeLbl.textColor = UIColor.black
            matchedBarcodeBtnOutlet.isEnabled = true
            matchedBarcodeCheckBox.alpha = 1
            matchedBarcodeLbl.alpha = 1
            
        }else {
            matchedBarcodeLbl.textColor = UIColor.black
            matchedBarcodeBtnOutlet.isEnabled = true
            matchedBarcodeCheckBox.alpha = 1
            matchedBarcodeLbl.alpha = 1
            
            incrementalBarcodeTitleLabel.textColor = UIColor.black
            incrementalBarcodeButton.isEnabled = true
            incrementalBarcodeCheckBox.alpha = 1
            incrementalBarcodeTitleLabel.alpha = 1
        }
        
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) && !isautoPopulated {
            if let lastSavedBarCode = UserDefaults.standard.value(forKey: keyValue.barcodeIncremental.rawValue) as? String {
                if scanBarcodeText.text?.isEmpty == true {
                    scanBarcodeText.text = isBarcodeEndingWithNumberAndGetIncremented(lastSavedBarCode).incrementedBarCode
                }
            }
        }
        
        if UserDefaults.standard.integer(forKey: keyValue.animalIdSelectionCart.rawValue) > 0 {
            dateBtnOutlet.layer.borderColor = UIColor.red.cgColor
        }
        
    }
    
    func textFieldBackroungGrey(){
        dateOfBirthLbl.textColor = UIColor.gray
        dateBtnOutlet.setTitleColor(.gray, for: .normal)
        tissueBtnOutlet.setTitleColor(.gray, for: .normal)
        breedBtnOutlet.setTitleColor(.gray, for: .normal)
        male_femaleBtnOutlet.isEnabled = false
        dateBtnOutlet.isEnabled = false
        farmIdTextField.isEnabled = false
        scanBarcodeText.isEnabled = false
        permanentIDTextField.isEnabled = false
        tissueBtnOutlet.isEnabled = false
        etBttn.isEnabled = false
        singleBttn.isEnabled = false
        multipleBirthBttn.isEnabled = false
        sireIdTextField.isEnabled = false
        damtexfield.isEnabled = false
        breedBtnOutlet.isEnabled = false
        cloneOutlet.isEnabled = false
        SplitEmbryoOutlet.isEnabled = false
        internalBtnOulet.isEnabled = false
        sireIdTextField.isEnabled = false
        nationalHerdIdTextField.isEnabled = false
        sireIAuTextField.isEnabled = false
        bleBttn.isEnabled = false
        blebttn1.isEnabled = false
        scanButton.isEnabled = false
        dateTextField.isEnabled = false
        
        if scanAnimalTagText.tag == 0 {
            blebttn1.isEnabled = true
            
        }
        nationalHerdIdTextField.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        sireIAuTextField.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        farmIdTextField.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        farmIdView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        barcodeView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        permanentIDTextField.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        tissueBtnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        etBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        singleBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        multipleBirthBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        sireIdTextField.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        damtexfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        breedBtnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        internalBtnOulet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        cloneOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        SplitEmbryoOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        dateBtnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        singleBttn.layer.borderWidth = 0.5
        self.isGrayField = true
        self.bornTypeCollection.reloadData()
        scanBarcodeText.textColor = UIColor.gray
        incrementalBarcodeTitleLabel.textColor = UIColor.gray
        incrementalBarcodeButton.isEnabled = false
        incrementalBarcodeCheckBox.alpha = 0.6
        incrementalBarcodeTitleLabel.alpha = 0.6
        self.isautoPopulated = false
        matchedBarcodeCheckBox.alpha = 0.6
        matchedBarcodeBtnOutlet.isEnabled = false
        matchedBarcodeLbl.textColor = UIColor.gray
        matchedBarcodeLbl.alpha = 0.6
        if !isautoPopulated {
            incrementalBarcodeTitleLabel.textColor = UIColor.black
            incrementalBarcodeButton.isEnabled = true
            incrementalBarcodeCheckBox.alpha = 1
            incrementalBarcodeTitleLabel.alpha = 1
            if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) && !isautoPopulated {
                if let lastSavedBarCode = UserDefaults.standard.value(forKey: keyValue.barcodeIncremental.rawValue) as? String {
                    if scanBarcodeText.text?.isEmpty == true {
                        scanBarcodeText.text = isBarcodeEndingWithNumberAndGetIncremented(lastSavedBarCode).incrementedBarCode
                    }
                }
            }
            
        } else {
            self.isautoPopulated = false
            incrementalBarcodeTitleLabel.textColor = UIColor.gray
            incrementalBarcodeButton.isEnabled = true
            incrementalBarcodeCheckBox.alpha = 1
            incrementalBarcodeTitleLabel.alpha = 1
        }
        
    }
}
