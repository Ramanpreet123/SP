//
//  DEOAnimalVCGirlandoSelectorAndUIMethods.swift
//  SearchPoint
//
//  Created by Mobile Programming on 26/02/24.
//

import Foundation
import UIKit

//MARK: OBJC SELECTOR METHODS
extension DataEntryOrderingAnimalVCGirlando {
    
    @objc func closeAddAnimalAndContinueOptions(tapGestureRecognizer: UITapGestureRecognizer) {
        view1.isHidden = true
        view2.isHidden = true
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            DispatchQueue.main.async {
                self.keyBoardOptionsView.isHidden = false
            }
            keyBoardOptionsViewBottomConstrains.constant = keyboardHeight + 20
            addbttn.isHidden = true
            continueBttn.isHidden =  true
            if(UserDefaults.standard.value(forKey: keyValue.scrollIsEnable.rawValue) as? Bool ?? true){
                scrolView.isScrollEnabled = true
            }
            else {
                scrolView.isScrollEnabled = false
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        keyBoardOptionsView.isHidden = true
        addbttn.isHidden = false
        continueBttn.isHidden =  false
        scrolView.isScrollEnabled = true
    }
    
    @objc func methodOfReceivedNotification(notification: Notification){
        UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
        let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
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
        dateBttnOutlet.setTitle(selectedDate, for: .normal)
        self.datePicker.resignFirstResponder()
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        calenderView.isHidden = true
        calenderbkg.isHidden = true
    }
    
    @objc func cancelClick() {
        calenderView.isHidden = true
        calenderbkg.isHidden = true
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
}

//MARK: IMAGEPICKER CONTROLLER DELEGATE
extension DataEntryOrderingAnimalVCGirlando : UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true, completion: nil)
        self.scanEarTagTextField.text = ""
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        setVisionTextRecognizeImage(image: image)
    }
}

//MARK: UI METHODS
extension DataEntryOrderingAnimalVCGirlando {
    func setUIOnDidLoad(){
        addObserver()
        tapRec.addTarget(self, action: #selector(closeAddAnimalAndContinueOptions(tapGestureRecognizer:)))
        listIdGet = UserDefaults.standard.integer(forKey: keyValue.listIdSaveOnSelection.rawValue)
        listName = UserDefaults.standard.object(forKey: keyValue.listNameSaveOnSelection.rawValue) as! String
        damTextFieldHeightConstaint.constant = 0
        damTextFieldTopConstaint.constant = 0
        sireRegTextFieldHeightConstaint.constant = 0
        sireRegTextFieldTopConstaint.constant = 0
        animalNameHeightConstaint.constant = 0
        animalNameTopHeightConstaint.constant = 0
        breedRegHeightConstaint.constant = 0
        breedRegTopHeightConstaint.constant = 0
        breedAssociationHeightConstaint.constant = 0
        breedAssociationTopHeightConstaint.constant = 0
        breedBtnHeightConstaint.constant = 0
        dobViewHeightConstaint.constant = 0
        maleFemaleHeightConstaint.constant = 0
        singleStackViewHeightConstaint.constant = 0
        tissueHeightConstaint.constant = 0
        tissueBttnOutlet.isHidden = true
        breedBtnOutlet.isHidden = true
        scrolView.isScrollEnabled = false
        singleBttn.isHidden = true
        multipleBirthBttn.isHidden = true
        etBttn.isHidden = true
        UserDefaults.standard.set(false, forKey: keyValue.expandView.rawValue)
        breedRegBttn.isHidden = true
        tissureDropDown.isHidden = true
        
        if UserDefaults.standard.bool(forKey: keyValue.expandView.rawValue) == false {
            let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.expandFormStr, comment: ""), attributes: self.attrs)
            expandFormOutlet.setAttributedTitle(attributeString, for: .normal)
        }
        else {
            let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.collapseFormStr, comment: ""), attributes: self.attrs)
            expandFormOutlet.setAttributedTitle(attributeString, for: .normal)
        }
        
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            dateTextField.isHidden = false
        }
        else {
            dateTextField.isHidden = true
        }
        
        dateTextField.keyboardType = .phonePad
        dateTextField.borderStyle = .none
        dateTextField.delegate = self
        heartBeatViewModel?.callGetHearBeatData()
        byDefaultSetting()
        dobLbl.text = NSLocalizedString(ButtonTitles.dateOfBirthText, comment: "")
        dateBtnView.layer.borderColor = UIColor.gray.cgColor
        dateBtnView.layer.borderWidth = 0.5
        scanEarTagTextField.addPadding(.left(20))
        scanBarcodeTextfield.addPadding(.left(20))
        breedRegTextfield.addPadding(.left(20))
        animalNameTextfield.addPadding(.left(20))
        sireRegTextfield.addPadding(.left(20))
        damRegTextfield.addPadding(.left(20))
        calenderView.isHidden = true
        calenderbkg.isHidden = true
        scanEarTagTextField.placeholder = NSLocalizedString(ButtonTitles.earTagText, comment: "")
        scanBarcodeTextfield.placeholder = NSLocalizedString(ButtonTitles.enterSampleBarcode, comment: "")
        breedRegTextfield.placeholder = NSLocalizedString(ButtonTitles.enterBreedRegNumber, comment: "")
        animalNameTextfield.placeholder = NSLocalizedString(ButtonTitles.enterAnimalName, comment: "")
        sireRegTextfield.placeholder = NSLocalizedString(ButtonTitles.enterSireRegNumber, comment: "")
        damRegTextfield.placeholder = NSLocalizedString(ButtonTitles.entireDamRegNumber, comment: "")
        appStatusLbl.text = NSLocalizedString(ButtonTitles.appStatusText, comment: "")
        addbttn.setTitle(NSLocalizedString(ButtonTitles.addAnotherAnimalText, comment: ""), for: .normal)
        continueBttn.setTitle(NSLocalizedString(ButtonTitles.reviewDataText, comment: ""), for: .normal)
        orderingTitleLbl.text = NSLocalizedString(ButtonTitles.addAnimalText, comment: "")
        bckToListNavigateOutlet.setTitle(NSLocalizedString(LocalizedStrings.backBtnText, comment: ""), for: .normal)
        let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        breedArr =  fetchBreedData(entityName: Entities.getBreedsTblEntity, provId: pvid)
        if breedArr.count == 1 {
            breedDropIcon.isHidden = true
        }
        else {
            breedDropIcon.isHidden = false
        }
        
        breedRegArr = fetchAllDataProductBeefBreedSociety(entityName: Entities.getBreedSocietiesTblEntity, productId: 17)
        if breedRegArr.count == 1 {
            breedAssociationIcon.isHidden = true
        }
        else {
            breedAssociationIcon.isHidden = false
        }
        
        self.defaultIncrementalBarCodeSetting()
        let attributeString = NSMutableAttributedString(string: NSLocalizedString("Reset", comment: ""), attributes: self.attrs)
        clearFormOutlet.setAttributedTitle(attributeString, for: .normal)
    }
    
    func setUIOnWillAppear(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        let auto = UserDefaults.standard.bool(forKey: keyValue.autoId.rawValue)
        if auto == false {
            autoIncrementidtable()
            autoD = fetchFromAutoIncrement()
            timeStampString = timeStamp()
            UserDefaults.standard.set(timeStampString, forKey: keyValue.timeStamp.rawValue)
            UserDefaults.standard.set(true, forKey: keyValue.autoId.rawValue)
            let animaltbl = fetchRemaningSubmitOrder(entityName: Entities.dataEntryAnimalAddTbl, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            for i in 0..<animaltbl.count {
                let data = animaltbl.object(at: i) as! DataEntryAnimaladdTbl
                updateOrderStatusServerRemain(entity: Entities.animalMasterTblEntity, aniamltag: data.animalTag ?? "", userId: userId)
            }
            deleteRemaningSubmitOrder(entityName: Entities.productAdonAnimalTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            deleteRemaningSubmitOrder(entityName: Entities.subProductTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            UserDefaults.standard.set(autoD, forKey: keyValue.orderId.rawValue)
        }
        
        autoD = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        timeStampString = UserDefaults.standard.value(forKey: keyValue.timeStamp.rawValue) as? String ?? ""
        initialNetworkCheck()
        BluetoothCentre.shared.manager.scanForPeripherals(withServices: nil, options: nil)
        self.navigationController?.navigationBar.isHidden = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        
        if UserDefaults.standard.integer(forKey: keyValue.dataEntryAnimalIdSelectionCart.rawValue) > 0 {
            let temp = UserDefaults.standard.integer(forKey: keyValue.dataEntryAnimalIdSelectionCart.rawValue)
            animalIdBool = true
            textFieldBackroungWhite()
            UserDefaults.standard.set(0, forKey: keyValue.dataEntryAnimalIdSelectionCart.rawValue)
            dataPopulateInScreen(animalId: temp)
        }
        
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncrementalClear.rawValue) == false {
            self.isBarcodeAutoIncrementedEnabled = false
        }
    }
    
    func setUIOnDidAppear(){
        let animalCount =   fetchAllDataAnimalDaWithOutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderStatus:"false",listid:Int64(listIdGet), custmerId: Int64(custmerId ?? 0), providerId: pviduser)
        notificationLblCount.text = String(animalCount.count)
        if animalCount.count == 0{
            notificationLblCount.isHidden = true
            countLbl.isHidden = true
        }
        earTagView.layer.cornerRadius = (earTagView.frame.size.height / 2)
        earTagView.layer.borderWidth = 0.5
        earTagView.layer.borderColor = UIColor.gray.cgColor
        earTagView.clipsToBounds = true
        dateBtnView.layer.cornerRadius = (dateBtnView.frame.size.height / 2)
        dateBtnView.layer.borderWidth = 0.5
        dateBtnView.layer.borderColor = UIColor.gray.cgColor
        dateBtnView.clipsToBounds = true
        barcodeView.layer.cornerRadius = (barcodeView.frame.size.height / 2)
        barcodeView.layer.borderWidth = 0.5
        barcodeView.layer.borderColor = UIColor.gray.cgColor
        barcodeView.clipsToBounds = true
    }
    
    func textFieldBackroungGrey(){
        expandFormOutlet.alpha = 0.4
        expandFormOutlet.isEnabled = false
        scanBarocodeOutlet.isEnabled = false
        dateBttnOutlet.setTitleColor(.gray, for: .normal)
        tissueBttnOutlet.setTitleColor(.gray, for: .normal)
        breedBtnOutlet.setTitleColor(.gray, for: .normal)
        breedRegBttn.setTitleColor(.gray, for: .normal)
        male_femaleBttnOutlet.isEnabled = false
        dateBttnOutlet.isEnabled = false
        dateTextField.isEnabled = false
        tissueBttnOutlet.isEnabled = false
        breedBtnOutlet.isEnabled = false
        breedRegBttn.isEnabled = false
        scanEarTagTextField.isEnabled = false
        damRegTextfield.isEnabled = false
        sireRegTextfield.isEnabled = false
        breedRegTextfield.isEnabled = false
        dobLbl.textColor = UIColor.gray
        scanBarcodeTextfield.backgroundColor = UIColor.white
        animalNameTextfield.isEnabled = false
        etBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        singleBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        multipleBirthBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        breedBtnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        dateBttnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        scanEarTagTextField.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        damRegTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        sireRegTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        earTagView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        breedRegTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        animalNameTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        breedBtnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        tissueBttnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        breedRegBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        incrementalBarcodeTitleLabel.textColor = .gray
        incrementalBarcodeButton.isEnabled = false
        incrementalBarcodeCheckBox.alpha = 0.6
        incrementalBarcodeTitleLabel.alpha = 0.6
    }
    
    func textFieldBackroungWhite(){
        expandFormOutlet.alpha = 1
        earTagView.layer.backgroundColor = UIColor.white.cgColor
        expandFormOutlet.isEnabled = true
        scanBarocodeOutlet.isEnabled = true
        etBttn.layer.borderColor = UIColor.gray.cgColor
        singleBttn.layer.borderColor = UIColor.gray.cgColor
        multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
        etBttn.backgroundColor = UIColor.white
        singleBttn.backgroundColor = UIColor.white
        multipleBirthBttn.backgroundColor = UIColor.white
        etBttn.layer.borderWidth = 0.5
        multipleBirthBttn.layer.borderWidth = 0.5
        dateTextField.isEnabled = true
        dobLbl.textColor = UIColor.black
        breedRegBttn.isEnabled = true
        dateBttnOutlet.setTitleColor(.black, for: .normal)
        breedBtnOutlet.setTitleColor(UIColor.black, for: .normal)
        tissueBttnOutlet.setTitleColor(UIColor.black, for: .normal)
        breedRegBttn.setTitleColor(UIColor.black, for: .normal)
        dateBttnOutlet.isEnabled = true
        male_femaleBttnOutlet.isEnabled = true
        tissueBttnOutlet.isEnabled = true
        breedBtnOutlet.isEnabled = true
        scanBarcodeTextfield.isEnabled = true
        damRegTextfield.isEnabled = true
        sireRegTextfield.isEnabled = true
        breedRegTextfield.isEnabled = true
        animalNameTextfield.isEnabled = true
        tissueBttnOutlet.isEnabled = true
        scanEarTagTextField.isEnabled = true
        breedRegBttn.backgroundColor = .white
        barcodeView.backgroundColor = UIColor.white
        scanBarcodeTextfield.backgroundColor = UIColor.white
        scanEarTagTextField.backgroundColor = UIColor.white
        damRegTextfield.backgroundColor = UIColor.white
        tissueBttnOutlet.backgroundColor = UIColor.white
        sireRegTextfield.backgroundColor = UIColor.white
        breedRegTextfield.backgroundColor = UIColor.white
        animalNameTextfield.backgroundColor = UIColor.white
        breedBtnOutlet.backgroundColor = UIColor.white
        tissueBttnOutlet.backgroundColor = UIColor.white
        dateBttnOutlet.backgroundColor = UIColor.white
        singleBttn.layer.borderWidth = 2
        singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        selectedBornTypeId = 1
        etBttn.isEnabled = true
        singleBttn.isEnabled = true
        multipleBirthBttn.isEnabled = true
        breedRegBttn.setTitleColor(.black, for: .normal)
        breedRegBttn.setTitle(LocalizedStrings.girolandoAssociationStr, for: .normal)
        breedBtnOutlet.setTitleColor(.black, for: .normal)
        
        if isautoPopulated == false {
            incrementalBarcodeTitleLabel.textColor = UIColor.black
            incrementalBarcodeButton.isEnabled = true
            incrementalBarcodeCheckBox.alpha = 1
            incrementalBarcodeTitleLabel.alpha = 1
            incrementalBarcodeButton.isEnabled = true
            
            if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
                if let lastSavedBarCode = UserDefaults.standard.value(forKey: keyValue.barcodeIncremental.rawValue) as? String {
                    scanBarcodeTextfield.text = isBarCodeEndsWithNumber_GetIncrementedBarCode(lastSavedBarCode).incrementedBarCode
                }
            }
        }
        else {
            incrementalBarcodeTitleLabel.textColor = UIColor.gray
            incrementalBarcodeButton.isEnabled = false
            incrementalBarcodeCheckBox.alpha = 0.6
            incrementalBarcodeTitleLabel.alpha = 0.6
        }
    }
    
    func tableViewpop() {
        buttonbg2.frame = CGRect(x:0,y: 0,width: 1024,height: 1000)
        buttonbg2.addTarget(self, action:#selector(DataEntryOrderingAnimalVCGirlando.buttonPreddDroper), for: .touchUpInside)
        buttonbg2.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        self.view.addSubview(buttonbg2)
        droperTableView.delegate = self
        droperTableView.dataSource = self
        droperTableView.layer.cornerRadius = 8.0
        droperTableView.layer.borderWidth = 0.5
        droperTableView.layer.borderColor =  UIColor.gray.cgColor
        buttonbg2.addSubview(droperTableView)
    }
    
    func autoPop(animalData:NSArray) {
        if animalData.count > 0 {
            self.view.hideToast()
            barcodeflag = false
            isautoPopulated = true
            barAutoPopu = true
            textFieldBackroungWhite()
            updateOrder = true
            let data =  animalData.lastObject as! AnimalMaster
            let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
            animalId1 = Int(data.animalId)
            dateBttnOutlet.titleLabel!.text = ""
            dateTextField.text = ""
            if data.eT == "" {
                singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                singleBttn.layer.borderWidth = 2
                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                etBttn.layer.borderColor = UIColor.gray.cgColor
                selectedBornTypeId = 1
            }
            barcodeView.layer.borderColor = UIColor.gray.cgColor
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
            }
            
            if data.orderstatus == "false"{
                scanBarcodeTextfield.text = data.animalbarCodeTag
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
            breedRegBttn.setTitle(data.breedAssocation, for: .normal)
            breedId = data.breedId!
            let breedidd =  UserDefaults.standard.value(forKey: keyValue.breed.rawValue) as? String
            if breedidd != breedId {
                let  aDat = fetchAnimaldata(status: Entities.dataEntryAnimalAddTbl)
                if aDat.count > 1{
                    UserDefaults.standard.set(true, forKey: keyValue.identifyStore.rawValue)
                }
            }
            let inheritBreed = fetchAllDataProductGirlandoBreedID(entityName: Entities.getBreedsTblEntity,breedId:breedId,pvid:4)
            if inheritBreed.count != 0 {
                let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                breedId = medbreedRegArr1!.breedId ?? ""
                UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                breedBtnOutlet.setTitle(medbreedRegArr1?.alpha2 ?? medbreedRegArr1?.breedName, for: .normal)
            }
            
            UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
            UserDefaults.standard.set(data.breedName, forKey: keyValue.capsBreedName.rawValue)
            
            if data.gender == ButtonTitles.maleText.localized || data.gender == "M" || data.gender == "m"{
                self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                genderToggleFlag = 1
                genderString = ButtonTitles.maleText.localized
                
            } else {
                self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                genderToggleFlag = 0
                genderString = ButtonTitles.femaleText.localized
                
            }
            singleBttn.layer.borderColor = UIColor.gray.cgColor
            singleBttn.layer.borderWidth = 0.5
            let et = data.eT
            etBtn = et!
            etBttn.layer.borderWidth = 0.5
            singleBttn.layer.borderWidth = 0.5
            multipleBirthBttn.layer.borderWidth = 0.5
            
            if et == "Et"{
                etBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                etBttn.layer.borderWidth = 2
                singleBttn.layer.borderColor = UIColor.gray.cgColor
                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                selectedBornTypeId = 3
                
            } else if et == LocalizedStrings.singlesText{
                singleBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                singleBttn.layer.borderWidth = 2
                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                etBttn.layer.borderColor = UIColor.gray.cgColor
                selectedBornTypeId = 1
                
            }
            else if et == LocalizedStrings.multipleBirthStr{
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
            
            tissuId = Int(data.tissuId)
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
