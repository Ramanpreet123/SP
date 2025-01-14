//
//  DEBAnimalNZSelectorUIMethods.swift
//  SearchPoint
//
//  Created by Mobile Programming on 26/02/24.
//

import Foundation
import UIKit

// MARK: - OBJC SELECTOR METHODS
extension DataEntryBeefAnimalNZ_VC {
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            DispatchQueue.main.async {
                self.keyBoardOptionsView.isHidden = false
            }
            keyBoardOptionsViewBottomConstrains.constant = keyboardHeight + 20
            addanimalBttn.isHidden = true
            continueBttn.isHidden = true
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        keyBoardOptionsView.isHidden = true
        addanimalBttn.isHidden = false
        continueBttn.isHidden = false
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
        dateComp =  checkAge(date: datePicker.date)
        self.datePicker.resignFirstResponder()
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        calenderView.isHidden = true
        calenderbkg.isHidden = true
        _ = statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    @objc func cancelClick() {
        calenderView.isHidden = true
        calenderbkg.isHidden = true
        datePicker.isHidden = true
        self.toolBar.isHidden = true
    }
    
    @objc func buttonPreddDroper() {
        buttonbg2.removeFromSuperview()
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
    
    @objc func closeAddAnimalAndContinueOptions(tapGestureRecognizer: UITapGestureRecognizer) {
        view1.isHidden = true
        view2.isHidden = true
    }
    
    func setUIOnDidLoad(){
        addObserver()
        tapRec.addTarget(self, action: #selector(closeAddAnimalAndContinueOptions(tapGestureRecognizer:)))
        listIdGet = UserDefaults.standard.integer(forKey: keyValue.listIdSaveOnSelection.rawValue)
        listName = UserDefaults.standard.object(forKey: keyValue.listNameSaveOnSelection.rawValue) as! String
        if dataEntryConflicedBack == true {
            notificationLblCount.isHidden = true
            countLbl.isHidden = true
            addanimalBttn.setTitle("Save", for: .normal)
        } 
        else {
            notificationLblCount.isHidden = false
            countLbl.isHidden = false
        }
        
        if UserDefaults.standard.bool(forKey: keyValue.expandView.rawValue) == false {
            let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.expandFormStr, comment: ""), attributes: self.attrs)
            expandFormOutlet.setAttributedTitle(attributeString, for: .normal)
            damREGBottomConstraint.constant = 0
            damREGHeightConstraint.constant = 0
            damREGTopConstraint.constant = 0
            sireRegHeightConstraint.constant = 0
            sireRegTopConstraint.constant = 0
            animalNameHeightConstraint.constant = 0
            animalNameTopConstraint.constant = 0
            nzAngusHeightConstraint.constant = 0
            nzAngusTopConstraint.constant = 0
            breedRegHeightConstraint.constant = 0
            breedRegTopConstraint.constant = 0
            breedBtnHeightConstraint.constant = 0
            breedBtnTopConstraint.constant = 0
            dobViewHeightConsraint.constant = 0
            dobTitleLbl.isHidden = true
            maleFemaleHeightConstrant.constant = 0
            tissueBtnHeightConstraint.constant = 0
            tissueImageIcon.isHidden = true
            tissueBttnOutlet.isHidden = true
            breedBtnOutlet.isHidden = true
            dateTextField.isHidden = true
            dateBtnOutlet.isHidden = true
        } 
        else {
            let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.collapseFormStr, comment: ""), attributes: self.attrs)
            expandFormOutlet.setAttributedTitle(attributeString, for: .normal)
        }
        
        UserDefaults.standard.setValue(nil, forKey: keyValue.submitTypeSelection.rawValue)
        dateTextField.keyboardType = .phonePad
        dateTextField.borderStyle = .none
        dateTextField.delegate = self
        heartBeatViewModel?.callGetHearBeatData()
        
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            dateTextField.isHidden = false
        } 
        else {
            dateTextField.isHidden = true
        }
        UserDefaults.standard.set("NZ", forKey: keyValue.beefProduct.rawValue)
        UserDefaults.standard.set("NZ", forKey: "screenBeef")
        byDefaultSetting()
        self.defaultIncrementalBarCodeSetting()
        
        breedRegArr = fetchAllDataProductBeefBreedSociety(entityName: Entities.getBreedSocietiesTblEntity, productId: 25)
        if breedRegArr.count == 1 || breedRegArr.count == 0{
            angusDropDownIcon.isHidden = true
            breedRegAssociationBttn.isUserInteractionEnabled = false
            
        } else {
            angusDropDownIcon.isHidden = false
            breedRegAssociationBttn.isUserInteractionEnabled = true
            
        }
        
        breedArr = fetchproviderProductData(entityName: Entities.getBreedsTblEntity, provId: pvid)
        if breedArr.count == 1 || breedArr.count == 0{
            breedDropDownIcon.isHidden = true
            breedBtnOutlet.isUserInteractionEnabled = false
            
        } else {
            breedDropDownIcon.isHidden = false
            breedBtnOutlet.isUserInteractionEnabled = true
            
        }
        let attributeString = NSMutableAttributedString(string: NSLocalizedString("Reset", comment: ""), attributes: self.attrs)
        clearFormOutlet.setAttributedTitle(attributeString, for: .normal)
    }
    
    func setUIOnWillAppear(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        initialNetworkCheck()
        landIdApplangaugeConversion(langid: Int(langId!))
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        self.navigationController?.navigationBar.isHidden = true
        earTagView.layer.cornerRadius = (earTagView.frame.size.height / 2)
        earTagView.layer.borderWidth = 0.5
        earTagView.layer.borderColor = UIColor.gray.cgColor
        earTagView.clipsToBounds = true
        barcodeView.layer.cornerRadius = (barcodeView.frame.size.height / 2)
        barcodeView.layer.borderWidth = 0.5
        barcodeView.layer.borderColor = UIColor.gray.cgColor
        barcodeView.clipsToBounds = true
        dateBttnOutlet.layer.cornerRadius = (dateBttnOutlet.frame.size.height / 2)
        dateBttnOutlet.layer.borderWidth = 0.5
        dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
        dateBttnOutlet.clipsToBounds = true
        scanAnimalTagTextField.addPadding(.left(20))
        scanBarcodeTextfield.addPadding(.left(20))
        damRegTextfield.addPadding(.left(20))
        sireRegTextfield.addPadding(.left(20))
        breedRegTextfield.addPadding(.left(20))
        animalNameTextfield.addPadding(.left(20))
        breedRegAssociationBttn.layer.cornerRadius = (breedRegAssociationBttn.frame.size.height / 2)
        breedRegAssociationBttn.layer.borderWidth = 0.5
        breedRegAssociationBttn.layer.borderColor = UIColor.gray.cgColor
        breedRegAssociationBttn.clipsToBounds = true
        let auto = UserDefaults.standard.bool(forKey: keyValue.autoIdBeef.rawValue)
        if auto == false {
            autoIncrementidtable()
            autoD = fetchFromAutoIncrement()
            timeStampString = timeStamp()
            UserDefaults.standard.set(timeStampString, forKey: keyValue.timeStamp.rawValue)
            UserDefaults.standard.set(true, forKey: keyValue.autoIdBeef.rawValue)
            let animaltbl = fetchRemaningSubmitOrder(entityName: Entities.dataEntryBeefAnimalAddTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            for i in 0..<animaltbl.count{
                let data = animaltbl.object(at: i) as! DataEntryBeefAnimaladdTbl
                updateOrderStatusServerRemain(entity: Entities.beefAnimalMasterTblEntity, aniamltag: data.animalTag ?? "", userId: userId)
            }
            deleteRemaningSubmitOrder(entityName: Entities.productAdonAnimlBeefTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            deleteRemaningSubmitOrder(entityName: Entities.subProductBeefTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            
            UserDefaults.standard.set(autoD, forKey: keyValue.orderIdBeef.rawValue)
        }
        autoD = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        timeStampString = UserDefaults.standard.value(forKey: keyValue.timeStamp.rawValue) as? String ?? ""
        orderId  = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        calenderView.isHidden = true
        calenderbkg.isHidden = true
        
        if UserDefaults.standard.integer(forKey: keyValue.beefAnimalIdSelectionCart.rawValue) > 0 {
            let temp = UserDefaults.standard.integer(forKey: keyValue.beefAnimalIdSelectionCart.rawValue)
            animalIdBool = true
            UserDefaults.standard.set(0, forKey: keyValue.beefAnimalIdSelectionCart.rawValue)
            dataPopulateInScreen(animalId: temp)
            isautoPopulated = true
            barAutoPopu = true
            messageCheck = true
            textFieldBackroungWhite()
        }
        
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncrementalClear.rawValue) == false {
            self.isBarcodeAutoIncrementedEnabled = false
        }
        
        let animalCount = fetchDataEnteryAnimalTblBeefData(entityName: Entities.dataEntryBeefAnimalAddTblEntity,customerId:self.custmerId ?? 0,listId:Int64(self.listIdGet ),productId:25) as!  [DataEntryBeefAnimaladdTbl]
        notificationLblCount.text = String(animalCount.count)
        if animalCount.count == 0{
            notificationLblCount.isHidden = true
            countLbl.isHidden = true
        }
    }
}
