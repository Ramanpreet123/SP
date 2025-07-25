//
//  DataEntryInheritBeefUIMethods.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 25/03/25.
//

import Foundation
import UIKit

extension DataEntryInheritBeefVC {
    
    // MARK: - VIEW DID LOAD UI
    func setUIOnDidLoad(){
        self.setSideMenu()
        inheritDateTextField.setLeftPaddingPoints(20.0)
        addObserver()
        tapRec.addTarget(self, action: #selector(closeAddAnimalAndContinueOptions(tapGestureRecognizer:)))
        self.userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        self.orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        UserDefaults.standard.setValue(nil, forKey: keyValue.submitTypeSelection.rawValue)
        listIdGet = UserDefaults.standard.integer(forKey: keyValue.listIdSaveOnSelection.rawValue)
        listName = UserDefaults.standard.object(forKey: keyValue.listNameSaveOnSelection.rawValue) as! String
        heartBeatViewModel?.callGetHearBeatData()
     //   globalDateTextField.keyboardType = .phonePad
        inheritDateTextField.keyboardType = .phonePad
     //   globalDateTextField.borderStyle = .none
      //  globalDateTextField.delegate = self
        inheritDateTextField.borderStyle = .none
        inheritDateTextField.delegate = self
     //   addbttn.isHidden = true
     //   continueBttn.isHidden = true
        tissuId = 1
        
        pairedBackroundView.isHidden = true
        pairedDeviceView.isHidden = true
        
        if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
            inheritScrollView.isHidden = true
            byDefaultSetting()
            UserDefaults.standard.set("", forKey: keyValue.selectedPrimaryBreed.rawValue)
            self.defaultIncrementalBarCodeSetting_Global()
         //   globalClearFormOutlet.isHidden = false
            inheritClearFormOutlet.isHidden = true
            inheritResetIconImage.isHidden = true
            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
           //     globalDateTextField.isHidden = false
            }
            else {
             //   globalDateTextField.isHidden = true
            }
            
            if UserDefaults.standard.bool(forKey: keyValue.expandView.rawValue) == false {
                let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.expandFormStr, comment: ""), attributes: self.attrs)
                expanBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                expanBtnOutlet.setImage(UIImage(named:"downiPad"), for: .normal)
                scrolView.isScrollEnabled = false
                damRegAssoHeightConstraint.constant = 0
                damRegAssoTopConstraint.constant = 0
                damRegNumberHeightConstraint.constant = 0
                damRegNumberTopConstraint.constant = 0
                sireRegAssoHeightConstraint.constant = 0
                sireRegAssoTopConstraint.constant = 0
                sireRegNumberHeightConstraint.constant = 0
                sireRegNumberTopConstraint.constant = 0
                animalNameHeightConstraint.constant = 0
                animalNameTopConstraint.constant = 0
                breedAssocationHeightConstraint.constant = 0
                breedAssocationTopConstraint.constant = 0
                breedRegNumberHeightConstraint.constant = 0
                breedRegNumberTopConstraint.constant = 0
                breedBtnHeightConstraint.constant = 0
                breedBtnTopConstraint.constant = 0
                dobHeighConstraint.constant = 0
                tissueHeightConstraint.constant = 0
                maleFemailHeightConstraint.constant = 0
                dobLbl.isHidden = false
                tissueBttnOutlet.isHidden = false
                breedBtnOutlet.isHidden = true
             //   sireRegDropdownOutlet.isHidden = true
                breedRegBttn.isHidden = true
             //   damRegDropdownOutlet.isHidden = true
           //     globalTissueDropDownArroe.isHidden = true
           //     globalBreedDropDownArroe.isHidden = true
            //    globalBreedAssDropDownArroe.isHidden = true
             //   globalsireREgDropDownArroe.isHidden = true
             //   globalDamRegDropDownArroe.isHidden = true
                dateBttnOutlet.isHidden = true
              //  globalDateTextField.isHidden = true
            }
            else {
                let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.collapseFormStr, comment: ""), attributes: self.attrs)
                expanBtnOutlet.setAttributedTitle(attributeString, for: .normal)
                expanBtnOutlet.setImage(UIImage(named:"collapseArrowiPad"), for: .normal)
            }
        }
        else {
            inheritScrollView.isHidden = false
            inheritByDefaultSetting()
        //    globalClearFormOutlet.isHidden = true
            inheritClearFormOutlet.isHidden = false
            self.defaultIncrementalBarCodeSetting_Inherit()
            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                inheritDateTextField.isHidden = false
            } else {
                inheritDateTextField.isHidden = true
            }
            
            if UserDefaults.standard.bool(forKey: keyValue.expandView.rawValue) == false {
                let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.expandFormStr, comment: ""), attributes: self.attrs)
                inheritExpandBtnOutlet.setTitle(LocalizedStrings.expandFormStr, for: .normal)
                inheritExpandBtnOutlet.setImage(UIImage(named:"downiPad"), for: .normal)
                self.eidAndSecondaryStackView.isHidden = true
                self.eidHeaderView.isHidden = true
                self.secondaryHeaderView.isHidden = true
                self.breedAndDobStackView.isHidden = true
                self.breedTypeHeaderView.isHidden = true
                self.dobHeaderView.isHidden = true
                self.breedRegStackView.isHidden = true
                self.breedAssociationHeaderView.isHidden = true
                self.breedRegHeaderView.isHidden = true
//                self.sireRegStackView.isHidden = true
//                self.sireRegNumberHeaderView.isHidden = true
//                self.sireRegAssociationHeaderView.isHidden = true
//                self.sireYOBStackView.isHidden = true
//                self.sireYOBHeaderView.isHidden = true
//                self.damIDHeaderView.isHidden = true
//                self.damYOBStackView.isHidden = true
//                self.damIDHeaderView.isHidden = true
//                self.damYOBHeaderView.isHidden = true
                self.resetBottomConstraint.constant = 390
                self.addAnimalStackTopConstraint.constant = 50
              
            }
            else {
                let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.collapseFormStr, comment: ""), attributes: self.attrs)
                inheritExpandBtnOutlet.setTitle(LocalizedStrings.collapseFormStr, for: .normal)
                    inheritExpandBtnOutlet.setImage(UIImage(named:"collapseArrowiPad"), for: .normal)
                self.eidAndSecondaryStackView.isHidden = false
                self.eidHeaderView.isHidden = false
                self.secondaryHeaderView.isHidden = false
                self.breedAndDobStackView.isHidden = false
                self.breedTypeHeaderView.isHidden = false
                self.dobHeaderView.isHidden = false
                self.breedRegStackView.isHidden = false
                self.breedAssociationHeaderView.isHidden = false
                self.breedRegHeaderView.isHidden = false
//                self.sireRegStackView.isHidden = false
//                self.sireRegNumberHeaderView.isHidden = false
//                self.sireRegAssociationHeaderView.isHidden = false
//                self.sireYOBStackView.isHidden = false
//                self.sireYOBHeaderView.isHidden = false
//                self.damIDHeaderView.isHidden = false
//                self.damYOBStackView.isHidden = false
//                self.damIDHeaderView.isHidden = false
//                self.damYOBHeaderView.isHidden = false
                self.resetBottomConstraint.constant = 92
                self.addAnimalStackTopConstraint.constant = 350
            }
            
            if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) != keyValue.globalHD50K.rawValue {
                if isautoPopulated != true {
                    if  UserDefaults.standard.bool(forKey: keyValue.showbeefInheritTable.rawValue) == true{
                        
                        UserDefaults.standard.removeObject(forKey: keyValue.selectedPrimaryBreed.rawValue)
                        UserDefaults.standard.removeObject(forKey: keyValue.selectedSecondaryBreed.rawValue)
                        UserDefaults.standard.removeObject(forKey: keyValue.selectedTertiaryBreed.rawValue)
                        
                        inheritEarTagTextfield.resignFirstResponder()
                        self.view.endEditing(true)
                        let storyboard = UIStoryboard(name: "BeefPlaceAnOrder", bundle: Bundle.main)
                        let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.inheritQuestionaireControllerVC) as! InheritQuestionaireController
                        vc.delegate = self
                        self.navigationController?.present(vc, animated: false, completion: nil)
                    }
                }
            }
        }
    }
    
    // MARK: - VIEW WILL APPEAR UI
    func setUIOnWillAppear(){
        self.inheritEarTagTextfield.layer.cornerRadius = 15.0
        self.inheritEarTagTextfield.clipsToBounds = true
        self.inheritBarcodeTextfield.layer.cornerRadius = 15.0
        self.inheritBarcodeTextfield.clipsToBounds = true
        self.inheritEIDTextfield.layer.cornerRadius = 15.0
        self.inheritEIDTextfield.clipsToBounds = true
        self.inheritSecondaryIdTextfield.layer.cornerRadius = 15.0
        self.inheritSecondaryIdTextfield.clipsToBounds = true
        self.inheritBreedRegTextfield.layer.cornerRadius = 15.0
        self.inheritBreedRegTextfield.clipsToBounds = true
        self.inheritMaleFemaleBttn.layer.cornerRadius = 15.0
        self.inheritMaleFemaleBttn.clipsToBounds = true
        self.inheritTissueBttn.layer.cornerRadius = 15.0
        self.inheritTissueBttn.clipsToBounds = true
        self.inheritBreedBttn.layer.cornerRadius = 15.0
        self.inheritBreedBttn.clipsToBounds = true
        self.inheritRegAssociationBttn.layer.cornerRadius = 15.0
        self.inheritRegAssociationBttn.clipsToBounds = true

        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        self.userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        self.userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        self.orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        let attributeString = NSMutableAttributedString(string: NSLocalizedString("Reset", comment: ""), attributes: self.attrs)
       // globalClearFormOutlet .setAttributedTitle(attributeString, for: .normal)
      //  inheritClearFormOutlet.setAttributedTitle(attributeString, for: .normal)
        initialNetworkCheck()
        inheritDamYobBttn.delegate = self
        inheritSireYobBttn.delegate = self
        landIdApplangaugeConversion(langid: langId!)
      //  scrolView.flashScrollIndicators()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        
        if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
            let beefPvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
            
            let animalCount = beefFetchAllDataWithListId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,orderStatus:"false",pvid :beefPvid,listid:Int64(listIdGet),custmerId:Int64(custmerId))
            
            //merged commented
           // let animalCount = fetchDataEnteryAnimalTblBeefData(entityName: Entities.dataEntryBeefAnimalAddTblEntity,customerId:custmerId ,listId:Int64(self.listIdGet),productId:19) as!  [DataEntryBeefAnimaladdTbl]
            notificationLblCount.text = String(animalCount.count)
            if animalCount.count == 0{
                notificationLblCount.isHidden = true
                countLbl.isHidden = true
                self.cartView.isHidden = true
            }
            else {
                notificationLblCount.isHidden = false
                countLbl.isHidden = false
                self.cartView.isHidden = false
            }
        }
        else {
            let animalCount = beefFetchAllDataWithListId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,orderStatus:"false",pvid :beefPvid,listid:Int64(listIdGet),custmerId:Int64(custmerId))
            
            notificationLblCount.text = String(animalCount.count)
            if animalCount.count == 0{
                notificationLblCount.isHidden = true
                countLbl.isHidden = true
                self.cartView.isHidden = true
                // merged
                //UserDefaults.standard.set(true, forKey: keyValue.showbeefInheritTable.rawValue)
            }
            else {
                notificationLblCount.isHidden = false
                countLbl.isHidden = false
                self.cartView.isHidden = false
            }
        }
        self.navigationController?.navigationBar.isHidden = true
       // animalNameTextfield.addPadding(.left(20))
        inheritSireYobBttn.addPadding(.left(20))
        inheritDamYobBttn.addPadding(.left(20))
        inheritEarTagTextfield.addPadding(.left(20))
        inheritDamIdTextfield.addPadding(.left(20))
        inheritBarcodeTextfield.addPadding(.left(20))
        inheritBreedRegTextfield.addPadding(.left(20))
        inheritSireRegTextfield.addPadding(.left(20))
        inheritEIDTextfield.addPadding(.left(20))
        inheritSecondaryIdTextfield.addPadding(.left(20))
        calenderView.isHidden = true
        calenderbkg.isHidden = true
        
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
        self.navigationController?.navigationBar.isHidden = true
        self.orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        
        if UserDefaults.standard.integer(forKey: keyValue.beefAnimalIdSelectionCart.rawValue) > 0 {
            var listAnimalID = UserDefaults.standard.integer(forKey: keyValue.beefAnimalIdSelectionCart.rawValue)
            let temp = UserDefaults.standard.integer(forKey: keyValue.beefAnimalIdSelectionCart.rawValue)
            animalIdBool = true
            isautoPopulated = true
            barAutoPopu = true
           // textFieldBackroungWhite()
            let existAnimalData = fetchAllDataWithAnimalIdstatus(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId:listAnimalID,orderststus:"false", customerId: self.custmerId) as! [DataEntryBeefAnimaladdTbl]
            if existAnimalData.count > 0{
             autoPopulateAnimalData = existAnimalData[0]
             isAnimalComingFromCart = true
           }
            UserDefaults.standard.set(0, forKey: keyValue.beefAnimalIdSelectionCart.rawValue)
            dataPopulateInScreen(animalId: temp)
            messageCheck = true
        }
        
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncrementalClear.rawValue) == false {
            self.isBarcodeAutoIncrementedEnabled = false
            
        }
        
        pairedBackroundView.isHidden = true
        pairedDeviceView.isHidden = true
        //1.10 merged changes
        let marketId = UserDefaults.standard.object(forKey: keyValue.currentActiveMarketId.rawValue) as? String ?? ""
        if marketId == MarketID.USMarketId {
            let fetchSettingData = fetchAllOrderSetting(entityName: Entities.orderSettingsTblEntity, customerId: custmerId,userId:1)
            if fetchSettingData.count != 0 {
                let fetchDat = fetchSettingData.object(at: 0) as? OrderSettings
                let beefScanner = fetchDat?.beefUSscannerSelection
                if beefScanner == keyValue.ocrKey.rawValue {
                    ocrBtnOutlet.setImage(UIImage(named: "ocrImageipad"), for: .normal)
                   // globalOcrBtnOutlet.setImage(UIImage(named: ImageNames.ocrInactiveImg), for: .normal)
                } else {
                    if BluetoothCentre.shared.smartBowPeripheral?.state == .connected{
                        ocrBtnOutlet.setImage(UIImage(named: "bleImageIpad"), for: .normal)
                    //    globalOcrBtnOutlet.setImage(UIImage(named: ImageNames.forma1Copy2Img), for: .normal)
                        
                    } else {
                        ocrBtnOutlet.setImage(UIImage(named: "bleImageIpad"), for: .normal)
                     //   globalOcrBtnOutlet.setImage(UIImage(named: ImageNames.scanIconActiveImg), for: .normal)
                    }
                }
            }
        } else {
            ocrBtnOutlet.setImage(UIImage(named: "ocrImageipad"), for: .normal)
           // globalOcrBtnOutlet.setImage(UIImage(named: ImageNames.ocrInactiveImg), for: .normal)
        }
    }
    
    // MARK: - OBJC SELECTOR METHODS
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
            keyBoardOptionsViewBottomConstrains.constant = keyboardHeight-64
         //   addbttn.isHidden = true
         //   continueBttn.isHidden = true
         //   inheritContinueBttn.isHidden = true
         //   inheritAddBttn.isHidden = true
            if(UserDefaults.standard.value(forKey: keyValue.scrollIsEnable.rawValue) as? Bool ?? true){
                inheritScrollView.isScrollEnabled = true
            }
            else {
                inheritScrollView.isScrollEnabled = false
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        keyBoardOptionsView.isHidden = true
     //   addbttn.isHidden = true
     //   continueBttn.isHidden = true
     //   inheritContinueBttn.isHidden = false
      //  inheritAddBttn.isHidden = false
      //  inheritScrollView.isScrollEnabled = true
    }
    
    
    @objc func methodOfReceivedNotification(notification: Notification){
        UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
        let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
        self.hideIndicator()
        
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
        dobLbl.isHidden = true
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
    
    @objc func InheritDoneClick() {
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
        self.InheritSelectedDate = datePicker.date
        
        let selectedDate = dateFormatter3.string(from: datePicker.date)
        inheritDobBttn.setTitle(selectedDate, for: .normal)
        inheritDobLbl.isHidden = true
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: datePicker.date)
        yearPublic = components.year!
        self.datePicker.resignFirstResponder()
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        calenderView.isHidden = true
        calenderbkg.isHidden = true
    }
    
    @objc func inheritCancelClick() {
        calenderView.isHidden = true
        calenderbkg.isHidden = true
        datePicker.isHidden = true
        self.toolBar.isHidden = true
    }
    
    @objc func InheritSireYOBDoneClick() {
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
        self.InheritSireSelectedDate = datePicker.date
        self.datePicker.resignFirstResponder()
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        calenderView.isHidden = true
        calenderbkg.isHidden = true
    }
    
    @objc func inheritSireCancelClick() {
        calenderView.isHidden = true
        calenderbkg.isHidden = true
        datePicker.isHidden = true
        self.toolBar.isHidden = true
    }
    
    @objc func InheritDamYOBDoneClick() {
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
        self.InheritDamSelectedDate = datePicker.date
        self.datePicker.resignFirstResponder()
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        calenderView.isHidden = true
        calenderbkg.isHidden = true
    }
    
    @objc func inheritDamCancelClick() {
        calenderView.isHidden = true
        calenderbkg.isHidden = true
        datePicker.isHidden = true
        self.toolBar.isHidden = true
    }
    
    @objc func buttonPreddDroper() {
        buttonbg2.removeFromSuperview()
        
        self.inheritGenderView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.sampleTypeView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.breedTypeView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.sireRegAssociationView.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        
        self.setShadowForUIView(view: sampleTypeView, removeShadow: true)
        self.setShadowForUIView(view: inheritGenderView, removeShadow: true)
        self.setShadowForUIView(view: breedTypeView, removeShadow: true)
        self.setShadowForUIView(view: breedAssociationView, removeShadow: true)
    }
    
   
}
