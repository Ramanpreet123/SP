//
//  DEOAnimalVCSelectorMethodsIpad.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 13/03/25.
//

import Foundation
import UIKit
import Vision
import VisionKit

// MARK: - SELECTOR AND VISION KIT METHODS
extension DataEntryOrderingAnimalVCIpad {
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            DispatchQueue.main.async {
                self.keyBoardOptionsView.isHidden = false
            }
            keyBoardOptionsViewBottomConstrains.constant = keyboardHeight + 140
          
            if(UserDefaults.standard.value(forKey: keyValue.scrollIsEnable.rawValue) as? Bool ?? true){
                scrolView.isScrollEnabled = true
            }
            else {
                scrolView.isScrollEnabled = false
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        dataEntryAddAnimal.isHidden = false
        dataEntryReviewData.isHidden = false
        keyBoardOptionsView.isHidden = true
        scrolView.isScrollEnabled = true
    }
    
    @objc func methodOfReceivedNotification(notification: Notification)
    {
        
        UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
        let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
        self.hideIndicator()
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
        dateOfBirthLbl.isHidden = true
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
        self.breedTypeView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.genderView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.sampleTypeView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.setShadowForUIView(view: sampleTypeView, removeShadow: true)
        self.setShadowForUIView(view: genderView, removeShadow: true)
        self.setShadowForUIView(view: breedTypeView, removeShadow: true)
    }
    
    @objc func buttonPreddDroperAutosugesstion() {
        buttonbgAutoSuggestion.removeFromSuperview()
    }
    
    @objc func closeAddAnimalAndContinueOptions(tapGestureRecognizer: UITapGestureRecognizer) {
        view1.isHidden = true
        view2.isHidden = true
    }
}

// MARK: - UI METHODS AND VALIDATION
extension DataEntryOrderingAnimalVCIpad {
    
    
    func animateView (_ movement : CGFloat){
        UIView.animate(withDuration: 0.1, animations: {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement);
        })
    }
    
    func textFieldBackroungWhite(){
        expandFormOutlet.isEnabled = true
        expandFormOutlet.alpha = 1
        dateOfBirthLbl.textColor = UIColor.black
        dateBtnOutlet.setTitleColor(.black, for: .normal)
        male_femaleBtnOutlet.setTitleColor(.black, for: .normal)
        male_femaleBtnOutlet.isEnabled = true
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
        dateTextField.backgroundColor = UIColor.white
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
        male_femaleBtnOutlet.backgroundColor = UIColor.white
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
            singleBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
            singleBttn.layer.borderWidth = 2
            self.singleBtnAction(UIButton())
            
        }
        self.isGrayField = false
        self.bornTypeCollection.reloadData()
        
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
        
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) {
            matchedBarcodeLbl.textColor = UIColor.gray
            matchedBarcodeBtnOutlet.isEnabled = false
            matchedBarcodeCheckBox.alpha = 0.6
            matchedBarcodeLbl.alpha = 0.6
            incrementalBarcodeTitleLabel.textColor = UIColor.black
            incrementalBarcodeButton.isEnabled = true
            incrementalBarcodeCheckBox.alpha = 1
            incrementalBarcodeTitleLabel.alpha = 1
            
        } else if UserDefaults.standard.bool(forKey: keyValue.matchedBarcodeFlagDataEntry.rawValue) {
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
    }
    
    func textFieldBackroungGrey(){
        expandFormOutlet.isEnabled = false
        expandFormOutlet.alpha = 0.4
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
        dateTextField.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
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
            if !smallDate {
                return LocalizedStrings.greaterThenDateStr
            }
            return LocalizedStrings.correctFormatStr
        } else {
            return  LocalizedStrings.invalidFormatStr
        }
    }
    
    func dataPopulateInFocusChange(){
        var animalTagValue = String()
        var farmIdValue = String()
        if scanAnimalTagText.tag == 0 {
            scanAnimalText = scanAnimalTagText.text!.uppercased()
            farmIdText = farmIdTextField.text!.uppercased()
            animalTagValue = scanAnimalText
            farmIdValue = farmIdText
        }
        else  {
            scanAnimalText = farmIdTextField.text!.uppercased()
            farmIdText = scanAnimalTagText.text!
            animalTagValue = scanAnimalText
            farmIdValue = farmIdText
        }
        
        let animalData1 = fetchAnimaldataValidateAnimalwithouOrderIDAND(entityName: Entities.animalMasterTblEntity, animalTag:animalTagValue.uppercased(), farmId: farmIdValue, animalbarCodeTag: scanBarcodeText.text!.uppercased(), offPermanentId: permanentIDTextField.text!.uppercased(), offDamId: damtexfield.text!.uppercased(), offsireId: sireIdTextField.text!.uppercased(),orderId:orderId,userId:userId,custmerId:custmerId ?? 0)
        if animalData1.count > 1 {
            for number in 0..<(animalData1.count-1) {
                let animId = animalData1.object(at: number) as? AnimalMaster
                let idAnim = animId?.animalId
                let useriD = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                let customerId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
                deleteDataWithAdh1(entity: Entities.animalMasterTblEntity, animalId: idAnim ?? 0, userId: Int(useriD ), custmerId: Int(customerId ))
            }
        }
        
        let animalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: Entities.dataEntryAnimalAddTbl, animalTag:animalTagValue.uppercased(), farmId: farmIdValue, animalbarCodeTag: scanBarcodeText.text!.uppercased(), offPermanentId: permanentIDTextField.text!.uppercased(), offDamId: damtexfield.text!.uppercased(), offsireId: sireIdTextField.text!.uppercased(),orderId:orderId,userId:userId,custmerId:custmerId ?? 0)
        
        if !isautoPopulated {
            if animalData1.count > 0 {
                self.view.hideToast()
                let data = animalData1.lastObject as! AnimalMaster
                if data.breedName == ButtonTitles.girolandoText || data.breedId == keyValue.girlandoNewBreedId.rawValue || data.breedName == BreedNames.girlandoBreed{
                    return
                }
                
                adhDataServerAutoPopulate = data.adhDataServer
                barcodeflag = false
                isautoPopulated = true
                barAutoPopu = true
                textFieldBackroungWhite()
                updateOrder = true
                dataAutoPopulatedBool =  true
                
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
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
                dateBtnOutlet.titleLabel!.text = ""
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
                    if isGreater  {
                        dateBtnOutlet.setTitle("", for: .normal)
                        dateTextField.text = ""
                    }
                }
                
                permanentIDTextField.text = data.offPermanentId
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
                        incrementalBarcodeCheckBox.alpha = 0.6
                        incrementalBarcodeTitleLabel.alpha = 0.6
                        checkBarcode = false
                        matchedBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                        matchedBarcodeBtnOutlet.isEnabled = false
                        matchedBarcodeLbl.textColor = .gray
                        matchedBarcodeLbl.alpha = 0.6
                        matchedBarcodeCheckBox.alpha = 0.6
                        matchedBarcodeBtnOutlet.alpha = 0.6
                        UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlagDataEntry.rawValue)
                    }
                }
                
                tissueBtnOutlet.setTitleColor(.black, for: .normal)
                breedBtnOutlet.setTitleColor(.black, for: .normal)
                tissueBtnOutlet.setTitle(data.tissuName, for: .normal)
                UserDefaults.standard.set(data.tissuName, forKey: keyValue.dataEntryTsu.rawValue)
                
                if data.tissuName?.isEmpty == true {
                    let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
                    if providerName == keyValue.clarifideAHDBUK.rawValue{
                        
                        self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue))
                        for items in self.tissueArr
                        {
                            let tissue = items  as? GetSampleTbl
                            let checkdefault  = tissue?.isDefault
                            
                            if self.pvid == 11 {
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
                            } else if self.pvid == 8 {
                                self.saveSampleNameandID(sampleNameStr: LocalizedStrings.hairString, sampleID: 4)
                                self.tissueBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.hairString, comment: ""), for: .normal)
                            }
                            else {
                                if checkdefault == true
                                {
                                    self.saveSampleNameandID(sampleNameStr: tissue?.sampleName ?? "", sampleID: 0)
                                    self.tissueBtnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
                                }
                            }
                        }
                        
                    } else {
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
                }
                
                if data.breedId == "" {
                    let inheritBreed = fetchAllDataProductBreedIdDairy(entityName: Entities.getBreedsTblEntity,breedId:breedId,pvid:pvid)
                    if inheritBreed.count != 0 {
                        let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                        data.breedName = medbreedRegArr1?.alpha2 ?? medbreedRegArr1?.threeCharCode ?? medbreedRegArr1?.breedName
                        data.breedId = breedId
                    }
                }
                
                breedBtnOutlet.setTitle(data.breedName, for: .normal)
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
                    if data.animalTag!.count  == 17 {
                        borderRedCheck = false
                        farmIdTextField.textColor = UIColor.black
                    } else {
                        
                        if data.animalTag!.count  == 0{
                        } else {
                            let replacedString = farmIdTextField.text?.replacingOccurrences(of: " ", with: "")
                            self.validationId17(animalId: replacedString?.uppercased() ?? "")
                        }
                    }
                } else {
                    scanAnimalTagText.text = data.animalTag
                    UserDefaults.standard.set(data.animalTag!.uppercased(), forKey: keyValue.selectAnimalId.rawValue)
                    farmIdTextField.text = data.farmId
                    
                    if data.animalTag?.count == 17 {
                        let twoString = data.animalTag
                        let twoBreed  = String((twoString?.prefix(2))!)
                        if breedAr.contains(twoBreed) {
                            
                            self.breedBtnOutlet.setTitle(twoBreed, for: .normal)
                            let codeId1 = fetchBreedDatabreedCode( entityName: Entities.getBreedsTblEntity,provId: self.pvid,breedCode:(self.breedBtnOutlet.titleLabel?.text)!)
                            let naabFetch11 = codeId1.value(forKey: keyValue.breedId.rawValue) as? NSArray
                            if naabFetch11!.count == 0 {
                                
                            } else {
                                let breedIdGet = (naabFetch11![0] as? String)!
                                self.breedId = breedIdGet
                                UserDefaults.standard.set(self.breedId, forKey: keyValue.dataEntrybreedId.rawValue)
                                let breedName = codeId1.value(forKey: keyValue.alpha2.rawValue) as? NSArray
                                if naabFetch11!.count != 0 {
                                    let nameBreed = (breedName![0] as? String)!
                                    self.breedBtnOutlet.setTitle(nameBreed, for: .normal)
                                }}
                        }
                    }
                }
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
                
                if data.selectedBornTypeId == 3 {
                    etBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                    etBttn.layer.borderWidth = 2
                    singleBttn.layer.borderColor = UIColor.gray.cgColor
                    internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                    cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 3
                    
                }
                else if data.selectedBornTypeId == 1{
                    singleBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                    singleBttn.layer.borderWidth = 2
                    internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                    cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                    etBttn.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 1
                    
                }
                else if data.selectedBornTypeId == 2{
                    multipleBirthBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                    multipleBirthBttn.layer.borderWidth = 2
                    internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                    singleBttn.layer.borderColor = UIColor.gray.cgColor
                    SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                    cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                    etBttn.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 2
                }
                
                else if data.selectedBornTypeId == 4 {
                    SplitEmbryoOutlet.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                    SplitEmbryoOutlet.layer.borderWidth = 2
                    internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                    singleBttn.layer.borderColor = UIColor.gray.cgColor
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                    etBttn.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 4
                    
                }
                
                else if data.selectedBornTypeId ==  5 {
                    cloneOutlet.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                    cloneOutlet.layer.borderWidth = 2
                    internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                    singleBttn.layer.borderColor = UIColor.gray.cgColor
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                    etBttn.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 5
                }
                
                else if data.selectedBornTypeId == 6 {
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
                let adata = fetchAllDataOrderStatusMaster(entityName: Entities.animalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
                if adata.count > 0{
                    let animal  = adata.object(at: 0) as! AnimalMaster
                    idAnimal = Int(animal.animalId)
                    messageCheck = true
                }
                
                if pvid == 3 {
                    if ausBullId.contains(data.offsireId as Any) || sireNationalID.contains(data.offsireId as Any){
                        sireIdTextField.textColor = UIColor.black
                        let fetchData =  fetchAusNaabBullAgaintName(entityName: Entities.ausNaabBullTblEntity, sireNationalId: data.offsireId ?? "")
                        if fetchData.count != 0 {
                            let nationHerdAU1 = fetchData.object(at: 0) as? AusNaabBull
                            let bullId =   nationHerdAU1?.bullID ?? ""
                            sireIdTextField.text = bullId.uppercased()
                        }
                        
                    } else {
                        let replacedString = data.offsireId!.replacingOccurrences(of: " ", with: "")
                        sireIdTextField.text = replacedString.uppercased()
                        validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                        
                    }
                } else  {
                    
                    if data.offsireId?.count == 17 || data.offsireId?.count == 0 {
                        sireIdTextField.text = data.offsireId?.uppercased()
                    } else {
                        let replacedString = data.offsireId!.replacingOccurrences(of: " ", with: "")
                        sireIdTextField.text = replacedString.uppercased()
                        validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                    }
                }
                
                if pvid == 3 {
                    damtexfield.text = data.offDamId?.uppercased()
                    
                } else {
                    if data.offDamId?.count == 17 ||  data.offDamId?.count == 0 {
                        damtexfield.text = data.offDamId?.uppercased()
                    } else {
                        let replacedString = data.offDamId!.replacingOccurrences(of: " ", with: "")
                        damtexfield.text = replacedString.uppercased()
                        validationId17SireDam(animalId: damtexfield.text!, tag: 4)
                    }
                }
            } else if animalData.count > 0 {
                self.view.hideToast()
                let data = animalData.lastObject as! DataEntryAnimaladdTbl
                if data.breedName == ButtonTitles.girolandoText || data.breedId == keyValue.girlandoNewBreedId.rawValue || data.breedName == BreedNames.girlandoBreed{
                    return
                }
                
                adhDataServerAutoPopulate = data.adhDataServer
                barcodeflag = false
                isautoPopulated = true
                barAutoPopu = true
                textFieldBackroungWhite()
                updateOrder = true
                dataAutoPopulatedBool =  true
                
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
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
                dateBtnOutlet.titleLabel!.text = ""
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
                    if isGreater  {
                        dateBtnOutlet.setTitle("", for: .normal)
                        dateTextField.text = ""
                    }
                }
                
                permanentIDTextField.text = data.offPermanentId
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
                        incrementalBarcodeCheckBox.alpha = 0.6
                        incrementalBarcodeTitleLabel.alpha = 0.6
                        checkBarcode = false
                        matchedBarcodeCheckBox.image = UIImage(named: ImageNames.incrementalCheckImg)
                        matchedBarcodeBtnOutlet.isEnabled = false
                        matchedBarcodeLbl.textColor = .gray
                        matchedBarcodeLbl.alpha = 0.6
                        matchedBarcodeCheckBox.alpha = 0.6
                        matchedBarcodeBtnOutlet.alpha = 0.6
                        UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlagDataEntry.rawValue)
                    }
                }
                
                tissueBtnOutlet.setTitleColor(.black, for: .normal)
                breedBtnOutlet.setTitleColor(.black, for: .normal)
                tissueBtnOutlet.setTitle(data.tissuName, for: .normal)
                UserDefaults.standard.set(data.tissuName, forKey: keyValue.dataEntryTsu.rawValue)
                
                if data.tissuName?.isEmpty == true {
                    let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String
                    if providerName == keyValue.clarifideAHDBUK.rawValue{
                        
                        self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue))
                        for items in self.tissueArr
                        {
                            let tissue = items  as? GetSampleTbl
                            let checkdefault  = tissue?.isDefault
                            
                            if self.pvid == 11 {
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
                            } else if self.pvid == 8 {
                                self.saveSampleNameandID(sampleNameStr: LocalizedStrings.hairString, sampleID: 4)
                                self.tissueBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.hairString, comment: ""), for: .normal)
                            }
                            else {
                                if checkdefault == true
                                {
                                    self.saveSampleNameandID(sampleNameStr: tissue?.sampleName ?? "", sampleID: 0)
                                    self.tissueBtnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
                                }
                            }
                        }
                        
                    } else {
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
                }
                
                if data.breedId == "" {
                    let inheritBreed = fetchAllDataProductBreedIdDairy(entityName: Entities.getBreedsTblEntity,breedId:breedId,pvid:pvid)
                    if inheritBreed.count != 0 {
                        let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                        data.breedName = medbreedRegArr1?.alpha2 ?? medbreedRegArr1?.threeCharCode ?? medbreedRegArr1?.breedName
                        data.breedId = breedId
                    }
                }
                
                breedBtnOutlet.setTitle(data.breedName, for: .normal)
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
                    if data.animalTag!.count  == 17 {
                        borderRedCheck = false
                        farmIdTextField.textColor = UIColor.black
                    } else {
                        
                        if data.animalTag!.count  == 0{
                        } else {
                            let replacedString = farmIdTextField.text?.replacingOccurrences(of: " ", with: "")
                            self.validationId17(animalId: replacedString?.uppercased() ?? "")
                        }
                    }
                } else {
                    scanAnimalTagText.text = data.animalTag
                    UserDefaults.standard.set(data.animalTag!.uppercased(), forKey: keyValue.selectAnimalId.rawValue)
                    farmIdTextField.text = data.farmId
                    
                    if data.animalTag?.count == 17 {
                        let twoString = data.animalTag
                        let twoBreed  = String((twoString?.prefix(2))!)
                        if breedAr.contains(twoBreed) {
                            
                            self.breedBtnOutlet.setTitle(twoBreed, for: .normal)
                            let codeId1 = fetchBreedDatabreedCode( entityName: Entities.getBreedsTblEntity,provId: self.pvid,breedCode:(self.breedBtnOutlet.titleLabel?.text)!)
                            let naabFetch11 = codeId1.value(forKey: keyValue.breedId.rawValue) as? NSArray
                            if naabFetch11!.count == 0 {
                                
                            } else {
                                let breedIdGet = (naabFetch11![0] as? String)!
                                self.breedId = breedIdGet
                                UserDefaults.standard.set(self.breedId, forKey: keyValue.dataEntrybreedId.rawValue)
                                let breedName = codeId1.value(forKey: keyValue.alpha2.rawValue) as? NSArray
                                if naabFetch11!.count != 0 {
                                    let nameBreed = (breedName![0] as? String)!
                                    self.breedBtnOutlet.setTitle(nameBreed, for: .normal)
                                }}
                        }
                    }
                }
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
                
                if data.selectedBornTypeId == 3 {
                    etBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                    etBttn.layer.borderWidth = 2
                    singleBttn.layer.borderColor = UIColor.gray.cgColor
                    internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                    cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 3
                    
                }
                else if data.selectedBornTypeId == 1{
                    singleBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                    singleBttn.layer.borderWidth = 2
                    internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                    cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                    etBttn.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 1
                    
                }
                else if data.selectedBornTypeId == 2{
                    multipleBirthBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                    multipleBirthBttn.layer.borderWidth = 2
                    internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                    singleBttn.layer.borderColor = UIColor.gray.cgColor
                    SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                    cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                    etBttn.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 2
                }
                
                else if data.selectedBornTypeId == 4 {
                    SplitEmbryoOutlet.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                    SplitEmbryoOutlet.layer.borderWidth = 2
                    internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                    singleBttn.layer.borderColor = UIColor.gray.cgColor
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                    etBttn.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 4
                    
                }
                
                else if data.selectedBornTypeId ==  5 {
                    cloneOutlet.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                    cloneOutlet.layer.borderWidth = 2
                    internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                    singleBttn.layer.borderColor = UIColor.gray.cgColor
                    multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                    SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                    etBttn.layer.borderColor = UIColor.gray.cgColor
                    selectedBornTypeId = 5
                }
                
                else if data.selectedBornTypeId == 6 {
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
                let adata = fetchAllDataOrderStatusMaster(entityName: Entities.animalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
                if adata.count > 0{
                    let animal  = adata.object(at: 0) as! AnimalMaster
                    idAnimal = Int(animal.animalId)
                    messageCheck = true
                }
                
                if pvid == 3 {
                    if ausBullId.contains(data.offsireId as Any) || sireNationalID.contains(data.offsireId as Any){
                        sireIdTextField.textColor = UIColor.black
                        let fetchData =  fetchAusNaabBullAgaintName(entityName: Entities.ausNaabBullTblEntity, sireNationalId: data.offsireId ?? "")
                        if fetchData.count != 0 {
                            let nationHerdAU1 = fetchData.object(at: 0) as? AusNaabBull
                            let bullId =   nationHerdAU1?.bullID ?? ""
                            sireIdTextField.text = bullId.uppercased()
                        }
                        
                    } else {
                        let replacedString = data.offsireId!.replacingOccurrences(of: " ", with: "")
                        sireIdTextField.text = replacedString.uppercased()
                        validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                        
                    }
                } else  {
                    
                    if data.offsireId?.count == 17 || data.offsireId?.count == 0 {
                        sireIdTextField.text = data.offsireId?.uppercased()
                    } else {
                        let replacedString = data.offsireId!.replacingOccurrences(of: " ", with: "")
                        sireIdTextField.text = replacedString.uppercased()
                        validationId17SireDam(animalId: sireIdTextField.text!, tag: 3)
                    }
                }
                
                if pvid == 3 {
                    damtexfield.text = data.offDamId?.uppercased()
                    
                } else {
                    if data.offDamId?.count == 17 ||  data.offDamId?.count == 0 {
                        damtexfield.text = data.offDamId?.uppercased()
                    } else {
                        let replacedString = data.offDamId!.replacingOccurrences(of: " ", with: "")
                        damtexfield.text = replacedString.uppercased()
                        validationId17SireDam(animalId: damtexfield.text!, tag: 4)
                    }
                }
            }
        }
    }
    
    func validation() {
        if damIdValidationB  {
            damtexfield.layer.borderColor = UIColor.red.cgColor
            
        } else {
            damtexfield.layer.borderColor = UIColor.gray.cgColor
        }
        if sireIdValidationB  {
            sireIdTextField.layer.borderColor = UIColor.red.cgColor
            
        } else {
            sireIdTextField.layer.borderColor = UIColor.gray.cgColor
        }
        
        if scanAnimalTagText.text == ""{
            officalTagView.layer.borderColor = UIColor.red.cgColor
        }
        else {
            officalTagView.layer.borderColor = UIColor.gray.cgColor
        }
        
        if farmIdTextField.text == ""{
            farmIdView.layer.borderColor = UIColor.red.cgColor
        }
        else {
            farmIdView.layer.borderColor = UIColor.gray.cgColor
        }
        
        if breedBtnOutlet.titleLabel!.text == keyValue.dataEntrybreedId.rawValue{
            breedBtnOutlet.layer.borderColor = UIColor.red.cgColor
        }
        else {
            breedBtnOutlet.layer.borderColor = UIColor.gray.cgColor
        }
        
        if sireIAuTextField.text == ""{
            sireIAuTextField.layer.borderColor = UIColor.red.cgColor
        }
        else {
            sireIAuTextField.layer.borderColor = UIColor.gray.cgColor
        }
        if nationalHerdIdTextField.text == ""{
            nationalHerdIdTextField.layer.borderColor = UIColor.red.cgColor
        }
        else {
            nationalHerdIdTextField.layer.borderColor = UIColor.gray.cgColor
        }
        
        if etBtn == "" {
            etBttn.layer.borderColor = UIColor.red.cgColor
            multipleBirthBttn.layer.borderColor = UIColor.red.cgColor
            singleBttn.layer.borderColor = UIColor.red.cgColor
            cloneOutlet.layer.borderColor = UIColor.red.cgColor
            SplitEmbryoOutlet.layer.borderColor = UIColor.red.cgColor
            internalBtnOulet.layer.borderColor = UIColor.red.cgColor
            etBttn.layer.borderWidth = 0.5
            singleBttn.layer.borderWidth = 0.5
            multipleBirthBttn.layer.borderWidth = 0.5
            cloneOutlet.layer.borderWidth = 0.5
            SplitEmbryoOutlet.layer.borderWidth = 0.5
            internalBtnOulet.layer.borderWidth = 0.5
            
        }
        else {
            
            if etBtn == NSLocalizedString(LocalizedStrings.multipleBirthStr, comment: "") {
                etBttn.layer.borderColor = UIColor.gray.cgColor
                singleBttn.layer.borderColor = UIColor.gray.cgColor
                cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                multipleBirthBttn.layer.borderWidth = 2
                multipleBirthBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                selectedBornTypeId = 2
                
            } else if etBtn == NSLocalizedString("Et", comment: ""){
                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                singleBttn.layer.borderColor = UIColor.gray.cgColor
                etBttn.layer.borderWidth = 2
                cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                etBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                selectedBornTypeId = 3
            } else if etBtn == NSLocalizedString(LocalizedStrings.splitEmbryoStr, comment: "") {
                
                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                singleBttn.layer.borderColor = UIColor.gray.cgColor
                etBttn.layer.borderColor = UIColor.gray.cgColor
                cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                SplitEmbryoOutlet.layer.borderWidth = 2
                SplitEmbryoOutlet.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                selectedBornTypeId = 4
            }
            else if etBtn == NSLocalizedString(LocalizedStrings.cloneText, comment: "") {
                
                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                singleBttn.layer.borderColor = UIColor.gray.cgColor
                etBttn.layer.borderColor = UIColor.gray.cgColor
                SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                cloneOutlet.layer.borderWidth = 2
                cloneOutlet.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                selectedBornTypeId = 5
            }
            else if etBtn == NSLocalizedString(LocalizedStrings.internalStr, comment: "") {
                
                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                singleBttn.layer.borderColor = UIColor.gray.cgColor
                etBttn.layer.borderColor = UIColor.gray.cgColor
                SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                internalBtnOulet.layer.borderWidth = 2
                cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                internalBtnOulet.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                selectedBornTypeId = 6
            }
            else {
                etBttn.layer.borderColor = UIColor.gray.cgColor
                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
            }
        }
    }
}
