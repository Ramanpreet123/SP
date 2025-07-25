////
////  BeedUSAddAnimalVCSelectorAndOtherMethods.swift
////  SearchPoint
////
////  Created by Mobile Programming on 05/03/24.
////
//
//import Foundation
//import UIKit
//
////MARK: SELECTOR METHODS
//extension BeefUSAddAnimalVC {
//    @objc func closeAddAnimalAndContinueOptions(tapGestureRecognizer: UITapGestureRecognizer) {
//        view1.isHidden = true
//        view2.isHidden = true
//    }
//    
//    @objc func keyboardWillShow(_ notification: Notification) {
//        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            let keyboardHeight = keyboardRectangle.height
//            DispatchQueue.main.async {
//                self.keyBoardOptionsView.isHidden = false
//            }
//            keyBoardOptionsViewBottomConstrains.constant = keyboardHeight+20
//            addbttn.isHidden = true
//            continueBttn.isHidden = true
//            inheritAddBttn.isHidden = true
//            inheritContinueBttn.isHidden = true
//            if(UserDefaults.standard.value(forKey: keyValue.scrollIsEnable.rawValue) as? Bool ?? true){
//                inheritScrollView.isScrollEnabled = true
//            }
//            else {
//                inheritScrollView.isScrollEnabled = false
//            }
//        }
//    }
//    
//    @objc func keyboardWillHide(_ notification: Notification) {
//        keyBoardOptionsView.isHidden = true
//        addbttn.isHidden = false
//        continueBttn.isHidden = false
//        inheritAddBttn.isHidden = false
//        inheritContinueBttn.isHidden = false
//        inheritScrollView.isScrollEnabled = true
//    }
//    
//    @objc func methodOfReceivedNotification(notification: Notification){
//        if value == 0{
//            UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
//            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
//            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
//            self.navigationController?.pushViewController(newViewController, animated: true)
//            self.hideIndicator()
//            value = value + 1
//        }
//    }
//    
//    @objc func checkForReachability(notification:Notification){
//        let del = UIApplication.shared.delegate as? AppDelegate
//        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
//        if NetworkStatusLbl?.text == ButtonTitles.connectedText.localized {
//            networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
//            offLineBtn.isEnabled = false
//        }
//        else {
//            networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
//            offLineBtn.isEnabled = true
//        }
//    }
//    
//    @objc func doneClick() {
//        let date = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
//        let dateFormatter1 = DateFormatter()
//        dateFormatter1.dateStyle = .medium
//        dateFormatter1.timeStyle = .none
//        let dateFormatter3 = DateFormatter()
//        if date == "MM"{
//            dateFormatter3.dateFormat = DateFormatters.MMddyyyyFormat
//        }
//        else {
//            dateFormatter3.dateFormat = DateFormatters.ddMMyyyyFormat
//        }
//        self.selectedDate = datePicker.date
//        
//        let selectedDate = dateFormatter3.string(from: datePicker.date)
//        dateBttnOutlet.setTitle(selectedDate, for: .normal)
//        self.datePicker.resignFirstResponder()
//        datePicker.isHidden = true
//        self.toolBar.isHidden = true
//        calenderView.isHidden = true
//        calenderbkg.isHidden = true
//    }
//    
//    @objc func cancelClick() {
//        calenderView.isHidden = true
//        calenderbkg.isHidden = true
//        datePicker.isHidden = true
//        self.toolBar.isHidden = true
//    }
//    
//    @objc func InheritDoneClick() {
//        let date = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
//        let dateFormatter1 = DateFormatter()
//        dateFormatter1.dateStyle = .medium
//        dateFormatter1.timeStyle = .none
//        let dateFormatter3 = DateFormatter()
//        if date == "MM"{
//            dateFormatter3.dateFormat = DateFormatters.MMddyyyyFormat
//        }
//        else {
//            dateFormatter3.dateFormat = DateFormatters.ddMMyyyyFormat
//        }
//        self.InheritSelectedDate = datePicker.date
//        let selectedDate = dateFormatter3.string(from: datePicker.date)
//        inheritDobBttn.setTitle(selectedDate, for: .normal)
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.year], from: datePicker.date)
//        yearPublic = components.year!
//        self.datePicker.resignFirstResponder()
//        datePicker.isHidden = true
//        self.toolBar.isHidden = true
//        calenderView.isHidden = true
//        calenderbkg.isHidden = true
//    }
//    
//    @objc func inheritCancelClick() {
//        calenderView.isHidden = true
//        calenderbkg.isHidden = true
//        datePicker.isHidden = true
//        self.toolBar.isHidden = true
//    }
//    
//    @objc func InheritSireYOBDoneClick() {
//        let date = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
//        let dateFormatter1 = DateFormatter()
//        dateFormatter1.dateStyle = .medium
//        dateFormatter1.timeStyle = .none
//        let dateFormatter3 = DateFormatter()
//        if date == "MM"{
//            dateFormatter3.dateFormat = DateFormatters.MMddyyyyFormat
//        }
//        else {
//            dateFormatter3.dateFormat = DateFormatters.ddMMyyyyFormat
//        }
//        self.InheritSireSelectedDate = datePicker.date
//        self.datePicker.resignFirstResponder()
//        datePicker.isHidden = true
//        self.toolBar.isHidden = true
//        calenderView.isHidden = true
//        calenderbkg.isHidden = true
//    }
//    
//    @objc func inheritSireCancelClick() {
//        calenderView.isHidden = true
//        calenderbkg.isHidden = true
//        datePicker.isHidden = true
//        self.toolBar.isHidden = true
//    }
//    
//    @objc func InheritDamYOBDoneClick() {
//        let date = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
//        let dateFormatter1 = DateFormatter()
//        dateFormatter1.dateStyle = .medium
//        dateFormatter1.timeStyle = .none
//        let dateFormatter3 = DateFormatter()
//        if date == "MM"{
//            dateFormatter3.dateFormat = DateFormatters.MMddyyyyFormat
//        }
//        else {
//            dateFormatter3.dateFormat = DateFormatters.ddMMyyyyFormat
//        }
//        self.InheritDamSelectedDate = datePicker.date
//        self.datePicker.resignFirstResponder()
//        datePicker.isHidden = true
//        self.toolBar.isHidden = true
//        calenderView.isHidden = true
//        calenderbkg.isHidden = true
//    }
//    
//    @objc func inheritDamCancelClick() {
//        calenderView.isHidden = true
//        calenderbkg.isHidden = true
//        datePicker.isHidden = true
//        self.toolBar.isHidden = true
//    }
//    
//    @objc func buttonPreddDroper() {
//        buttonbg2.removeFromSuperview()
//    }
//}
//
////MARK: INITIAL UI METHODS
//extension BeefUSAddAnimalVC {
//    func setUIOnDidLoad(){
//        addObserver()
//        tapRec.addTarget(self, action: #selector(closeAddAnimalAndContinueOptions(tapGestureRecognizer:)))
//        super.viewDidLoad()
//        UserDefaults.standard.set(1, forKey: keyValue.orderIdBeef.rawValue)
//        UserDefaults.standard.set(1, forKey: keyValue.userId.rawValue)
//        self.userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
//        self.orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
//        pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
//        UserDefaults.standard.setValue(nil, forKey: keyValue.submitTypeSelection.rawValue)
//        importListMainView.isHidden = true
//        importBackroundView.isHidden = true
//        heartBeatViewModel?.callGetHearBeatData()
//        globalDateTextField.keyboardType = .phonePad
//        inheritDateTextField.keyboardType = .phonePad
//        pairedBackroundView.isHidden = true
//        pairedDeviceView.isHidden = true
//        importTblView.delegate = self
//        importTblView.dataSource = self
//        globalDateTextField.borderStyle = .none
//        globalDateTextField.delegate = self
//        inheritDateTextField.borderStyle = .none
//        inheritDateTextField.delegate = self
//        tissuId = 1
//        let animalCount = fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
//        notificationLblCount.text = String(animalCount.count)
//        
//        if animalCount.count == 0{
//            notificationLblCount.isHidden = true
//            countLbl.isHidden = true
//            UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
//        }
//        inheritScrollView.isHidden = false
//        inheritByDefaultSetting()
//        globalClearFormOutlet.isHidden = true
//        inheritClearFormOutlet.isHidden = false
//        inheritResetIconImage.isHidden = true
//        self.defaultIncrementalBarCodeSetting_Inherit()
//        inheritBreedArr = fetchproviderProductDataGlobal(entityName: Entities.getBreedsTblEntity, provId: pvid, productId: 52)
//        
//        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
//            inheritDateTextField.isHidden = false
//        } else {
//            inheritDateTextField.isHidden = true
//        }
//        
//        let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.importMyListStr, comment: ""), attributes: self.attrs)
//        inheritImportFromOutlet.setAttributedTitle(attributeString, for: .normal)
//        let dataFetc = fetchDataEnteryWithListId(entityName: Entities.beefAnimalAddTblEntity,customerId:self.custmerId ,listId:0,providerId:pvid,orderstatus:"false", orderiD: UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue))
//        
//        if dataFetc.count == 0 {
//            UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
//            let attributeString = NSMutableAttributedString(string: NSLocalizedString(LocalizedStrings.importMyListStr, comment: ""), attributes: self.attrs)
//            inheritImportFromOutlet.setAttributedTitle(attributeString, for: .normal)
//            inheritImportFromOutlet.isEnabled = true
//            inheritCrossBtnOutlet.isHidden = true
//            InheritmergeListBtnOulet.isHidden = true
//        }
//        else {
//            let get = dataFetc.object(at: 0) as? BeefAnimaladdTbl
//            let getListid = get?.listId ?? 0
//            UserDefaults.standard.set(Int64(getListid), forKey: keyValue.dataEntryListId.rawValue)
//            
//            let fetchName = fetchListNameAccordingToListId(entityName: Entities.dataEntryListTblEntity,customerId:custmerId ,listId:getListid,providerId:pvid )
//            
//            if fetchName.count != 0{
//                inheritCrossBtnOutlet.isHidden = true
//                inheritImportFromOutlet.isEnabled = true
//            }
//        }
//        if fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count == 0 {
//            InheritmergeListBtnOulet.isHidden = true
//        } else {
//            InheritmergeListBtnOulet.isHidden = false
//            if dataFetc.count == 0 {
//                InheritmergeListBtnOulet.isHidden = true
//            }
//        }
//        let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ,providerId:pvid )
//        
//        if fetchObj.count != 0 {
//            let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
//            let obj = objectFetch?.listName
//            let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
//            
//            if fetchAllMergeDta == 0 {
//                let fetchNameDisplay = String(obj ?? "")
//                let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
//                InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
//            }
//            else {
//                let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
//                let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
//                InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
//            }
//        }
//        inheritCrossBtnOutlet.isHidden = true
//    }
//    
//    func setUIOnWillAppear(){
//        UserDefaults.standard.set(1, forKey: keyValue.orderIdBeef.rawValue)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
//        self.userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
//        self.orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
//        let attributeString = NSMutableAttributedString(string: NSLocalizedString("Reset", comment: ""), attributes: self.attrs)
//        globalClearFormOutlet .setAttributedTitle(attributeString, for: .normal)
//        inheritClearFormOutlet.setAttributedTitle(attributeString, for: .normal)
//        initialNetworkCheck()
//        inheritDamYobBttn.delegate = self
//        inheritSireYobBttn.delegate = self
//        landIdApplangaugeConversion()
//        scrolView.flashScrollIndicators()
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.deleg = self
//        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
//        notificationLblCount.text = String(animalCount.count)
//        if animalCount.count == 0{
//            notificationLblCount.isHidden = true
//            countLbl.isHidden = true
//            UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
//            globalMergeListBtnOulet.isHidden = true
//            deleteDataWithPvidCustomerId(entityString: Entities.mergeDataEntryListTblEntity ,providerId: Int64(UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)),customerId: Int64(self.custmerId ))
//        }
//        
//        self.navigationController?.navigationBar.isHidden = true
//        earTagView.layer.cornerRadius = (earTagView.frame.size.height / 2)
//        earTagView.layer.borderWidth = 0.5
//        earTagView.layer.borderColor = UIColor.gray.cgColor
//        earTagView.clipsToBounds = true
//        barcodeView.layer.cornerRadius = (barcodeView.frame.size.height / 2)
//        barcodeView.layer.borderWidth = 0.5
//        barcodeView.layer.borderColor = UIColor.gray.cgColor
//        barcodeView.clipsToBounds = true
//        dateBttnOutlet.layer.cornerRadius = (dateBttnOutlet.frame.size.height / 2)
//        dateBttnOutlet.layer.borderWidth = 0.5
//        dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
//        dateBttnOutlet.clipsToBounds = true
//        scanEarTagTextField.addPadding(.left(20))
//        scanBarcodeTextfield.addPadding(.left(20))
//        damRegTextfield.addPadding(.left(20))
//        sireRegTextfield.addPadding(.left(20))
//        breedRegTextfield.addPadding(.left(20))
//        animalNameTextfield.addPadding(.left(20))
//        inheritSireYobBttn.addPadding(.left(20))
//        inheritDamYobBttn.addPadding(.left(20))
//        inheritEarTagView.layer.cornerRadius = (earTagView.frame.size.height / 2)
//        inheritEarTagView.layer.borderWidth = 0.5
//        inheritEarTagView.layer.borderColor = UIColor.gray.cgColor
//        inheritEarTagView.clipsToBounds = true
//        inheritBarcodeView.layer.cornerRadius = (barcodeView.frame.size.height / 2)
//        inheritBarcodeView.layer.borderWidth = 0.5
//        inheritBarcodeView.layer.borderColor = UIColor.gray.cgColor
//        inheritBarcodeView.clipsToBounds = true
//        inheritDobBttn.layer.cornerRadius = (dateBttnOutlet.frame.size.height / 2)
//        inheritDobBttn.layer.borderWidth = 0.5
//        inheritDobBttn.layer.borderColor = UIColor.gray.cgColor
//        inheritDobBttn.clipsToBounds = true
//        inheritRegAssociationBttn.layer.cornerRadius = (inheritRegAssociationBttn.frame.size.height / 2)
//        inheritRegAssociationBttn.layer.borderWidth = 0.5
//        inheritRegAssociationBttn.layer.borderColor = UIColor.gray.cgColor
//        inheritRegAssociationBttn.clipsToBounds = true
//        inheritSireYobBttn.layer.cornerRadius = (inheritSireYobBttn.frame.size.height / 2)
//        inheritSireYobBttn.layer.borderWidth = 0.5
//        inheritSireYobBttn.layer.borderColor = UIColor.gray.cgColor
//        inheritSireYobBttn.clipsToBounds = true
//        inheritEIDTextfield.layer.cornerRadius = (inheritEIDTextfield.frame.size.height / 2)
//        inheritEIDTextfield.layer.borderWidth = 0.5
//        inheritEIDTextfield.layer.borderColor = UIColor.gray.cgColor
//        inheritEIDTextfield.clipsToBounds = true
//        inheritSecondaryIdTextfield.layer.cornerRadius = (inheritSecondaryIdTextfield.frame.size.height / 2)
//        inheritSecondaryIdTextfield.layer.borderWidth = 0.5
//        inheritSecondaryIdTextfield.layer.borderColor = UIColor.gray.cgColor
//        inheritSecondaryIdTextfield.clipsToBounds = true
//        inheritDamYobBttn.layer.cornerRadius = (inheritSireYobBttn.frame.size.height / 2)
//        inheritDamYobBttn.layer.borderWidth = 0.5
//        inheritDamYobBttn.layer.borderColor = UIColor.gray.cgColor
//        inheritDamYobBttn.clipsToBounds = true
//        inheritEarTagTextfield.addPadding(.left(20))
//        inheritDamIdTextfield.addPadding(.left(20))
//        inheritBarcodeTextfield.addPadding(.left(20))
//        inheritBreedRegTextfield.addPadding(.left(20))
//        inheritSireRegTextfield.addPadding(.left(20))
//        inheritEIDTextfield.addPadding(.left(20))
//        inheritSecondaryIdTextfield.addPadding(.left(20))
//        calenderView.isHidden = true
//        calenderbkg.isHidden = true
//        
//        let auto = UserDefaults.standard.bool(forKey: keyValue.autoIdBeef.rawValue)
//        if auto == false {
//            autoIncrementidtable()
//            autoD = fetchFromAutoIncrement()
//            timeStampString = timeStamp()
//            UserDefaults.standard.set(timeStampString, forKey: keyValue.timeStamp.rawValue)
//            UserDefaults.standard.set(true, forKey: keyValue.autoIdBeef.rawValue)
//            let animaltbl = fetchRemaningSubmitOrder(entityName: Entities.beefAnimalAddTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
//            
//            for i in 0..<animaltbl.count{
//                let data = animaltbl.object(at: i) as! BeefAnimaladdTbl
//                updateOrderStatusServerRemain(entity: Entities.beefAnimalMasterTblEntity, aniamltag: data.animalTag!, userId: userId)
//            }
//            deleteRemaningSubmitOrder(entityName: Entities.beefAnimalAddTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
//            deleteRemaningSubmitOrder(entityName: Entities.productAdonAnimlBeefTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
//            deleteRemaningSubmitOrder(entityName: Entities.subProductBeefTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
//            
//            UserDefaults.standard.set(1, forKey: keyValue.orderIdBeef.rawValue)
//        }
//        autoD = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
//        orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
//        timeStampString = UserDefaults.standard.value(forKey: keyValue.timeStamp.rawValue) as? String ?? ""
//        BluetoothCentre.shared.navController = self
//        BluetoothCentre.shared.manager.scanForPeripherals(withServices: nil, options: nil)
//        self.navigationController?.navigationBar.isHidden = true
//        appDelegate.deleg = self
//        BluetoothCentre.shared.delegateRFID  = self
//        BluetoothCentre.shared.nearByDeviceDelegate  = self
//  
//        if UserDefaults.standard.integer(forKey: keyValue.beefAnimalIdSelectionCart.rawValue) > 0{
//            var cartAnimalID = UserDefaults.standard.integer(forKey: keyValue.beefAnimalIdSelectionCart.rawValue)
//            let existAnimalData = fetchAllDataWithAnimalIdstatus(entityName: Entities.beefAnimalAddTblEntity, animalId:cartAnimalID,orderststus:"false", customerId: self.custmerId) as! [BeefAnimaladdTbl]
//            if existAnimalData.count > 0{
//              autoPopulateAnimalData = existAnimalData[0]
//              isAnimalComingFromCart = true
//            }
//              animalIdBool = true
//              isautoPopulated = true
//              barAutoPopu = true
//              textFieldBackroungWhite()
//              UserDefaults.standard.set(0, forKey: keyValue.beefAnimalIdSelectionCart.rawValue)
//              dataPopulateInScreen(animalId: cartAnimalID)
//              messageCheck = true
//        }
//        
//        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeMatched.rawValue){
//            incrementalBarcodeCheckBoxInherit.image = UIImage(named: ImageNames.checkImg)
//        } else {
//            incrementalBarcodeCheckBoxInherit.image = UIImage(named: ImageNames.incrementalCheckImg)
//        }
//        
//        let animalCount1 =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
//        if animalCount1.count == 0{
//            checkUserDataListName()
//        }
//        self.updateCartCount()
//        if  UserDefaults.standard.integer(forKey:keyValue.beefPvid.rawValue) == 13  {
//            if UserDefaults.standard.value(forKey: keyValue.beefScannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue{
//                ocrBtnOutlet.setImage(UIImage(named: ImageNames.ocrInactiveImg), for: .normal)
//                globalOcrBtnOutlet.setImage(UIImage(named: ImageNames.ocrInactiveImg), for: .normal)
//            } else {
//                if BluetoothCentre.shared.smartBowPeripheral?.state == .connected{
//                    ocrBtnOutlet.setImage(UIImage(named: ImageNames.forma1Copy2Img), for: .normal)
//                    globalOcrBtnOutlet.setImage(UIImage(named: ImageNames.forma1Copy2Img), for: .normal)
//                    
//                } else {
//                    ocrBtnOutlet.setImage(UIImage(named: ImageNames.scanIconActiveImg), for: .normal)
//                    globalOcrBtnOutlet.setImage(UIImage(named: ImageNames.scanIconActiveImg), for: .normal)
//                }
//            }
//        }
//    }
//    
//    func tableViewpop() {
//        buttonbg2.frame = CGRect(x:0,y: 0,width: 1024,height: 1000)
//        buttonbg2.addTarget(self, action:#selector(BeefUSAddAnimalVC.buttonPreddDroper), for: .touchUpInside)
//        buttonbg2.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
//        self.view.addSubview(buttonbg2)
//        droperTableView.delegate = self
//        droperTableView.dataSource = self
//        droperTableView.layer.cornerRadius = 8.0
//        droperTableView.layer.borderWidth = 0.5
//        droperTableView.layer.borderColor =  UIColor.gray.cgColor
//        buttonbg2.addSubview(droperTableView)
//    }
//    
//     func setUpGallary(){
//        if UIImagePickerController.isSourceTypeAvailable(.camera){
//            let imgPhotoLib = UIImagePickerController()
//            imgPhotoLib.delegate = self
//            imgPhotoLib.allowsEditing = true
//            imgPhotoLib.sourceType = .camera
//            self.present(imgPhotoLib,animated: true,completion: nil)
//        }
//    }
//    
//    func textFieldBackroungWhite(){
//        dobLbl.textColor = UIColor.black
//        inheritDobLbl.textColor = UIColor.black
//        dateBttnOutlet.setTitleColor(.black, for: .normal)
//        breedBtnOutlet.setTitleColor(UIColor.black, for: .normal)
//        tissueBttnOutlet.setTitleColor(UIColor.black, for: .normal)
//        sireRegDropdownOutlet.setTitleColor(UIColor.black, for: .normal)
//        damRegDropdownOutlet.setTitleColor(UIColor.black, for: .normal)
//        breedRegBttn.setTitleColor(UIColor.black, for: .normal)
//        dateBttnOutlet.isEnabled = true
//        damRegDropdownOutlet.isEnabled = true
//        male_femaleBttnOutlet.isEnabled = true
//        tissueBttnOutlet.isEnabled = true
//        breedBtnOutlet.isEnabled = true
//        barcodeBtn.isEnabled = true
//        scanBarcodeTextfield.isEnabled = true
//        damRegTextfield.isEnabled = true
//        sireRegTextfield.isEnabled = true
//        breedRegTextfield.isEnabled = true
//        animalNameTextfield.isEnabled = true
//        breedRegBttn.isEnabled = true
//        tissueBttnOutlet.isEnabled = true
//        sireRegDropdownOutlet.isEnabled = true
//        breedRegBttn.backgroundColor = .white
//        sireRegDropdownOutlet.backgroundColor = .white
//        damRegDropdownOutlet.backgroundColor = .white
//        barcodeView.backgroundColor = UIColor.white
//        scanBarcodeTextfield.backgroundColor = UIColor.white
//        damRegTextfield.backgroundColor = UIColor.white
//        tissueBttnOutlet.backgroundColor = UIColor.white
//        sireRegTextfield.backgroundColor = UIColor.white
//        breedRegTextfield.backgroundColor = UIColor.white
//        animalNameTextfield.backgroundColor = UIColor.white
//        breedBtnOutlet.backgroundColor = UIColor.white
//        tissueBttnOutlet.backgroundColor = UIColor.white
//        dateBttnOutlet.backgroundColor = UIColor.white
//        globalDateTextField.isEnabled = true
//        if isautoPopulated == false {
//            incrementalBarcodeTitleLabelGlobal.textColor = .black
//            incrementalBarcodeButtonGlobal.isEnabled = true
//            incrementalBarcodeCheckBoxGlobal.alpha = 1
//            incrementalBarcodeTitleLabelGlobal.alpha = 1
//            if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
//                if let lastSavedBarCode = UserDefaults.standard.value(forKey: keyValue.barcodeIncremental.rawValue) as? String {
//                    scanBarcodeTextfield.text = isBarCodeEndsWithNumber_GetIncrementedBarCode(lastSavedBarCode).incrementedBarCode
//                }
//            }
//        } else {
//            incrementalBarcodeTitleLabelGlobal.textColor = .gray
//            incrementalBarcodeButtonGlobal.isEnabled = true
//            incrementalBarcodeCheckBoxGlobal.alpha = 0.6
//            incrementalBarcodeTitleLabelGlobal.alpha = 0.6
//        }
//    }
//    
//    func inherittextFieldBackroungWhite(){
//        dobLbl.textColor = UIColor.black
//        inheritDobLbl.textColor = UIColor.black
//        inheriSireRedOutlet.setTitleColor(.black, for: .normal)
//        inheritDobBttn.setTitleColor(.black, for: .normal)
//        inheritTissueBttn.setTitleColor(.black, for: .normal)
//        inheritBreedBttn.setTitleColor(.black, for: .normal)
//        inheritRegAssociationBttn.setTitleColor(UIColor.black, for: .normal)
//        inheritDamYobBttn.textColor = .black
//        inheritSireYobBttn.textColor = .black
//        inheritMaleFemaleBttn.isEnabled = true
//        inheritDobBttn.isEnabled = true
//        inheritbarcodeBttn.isEnabled = true
//        inheritBarcodeTextfield.isEnabled = true
//        inheritDamIdTextfield.isEnabled = true
//        inheritSireRegTextfield.isEnabled = true
//        inheritBreedRegTextfield.isEnabled = true
//        inheritTissueBttn.isEnabled = true
//        inheritBreedBttn.isEnabled = true
//        inheritRegAssociationBttn.isEnabled = true
//        inheritEIDTextfield.isEnabled = true
//        inheritSecondaryIdTextfield.isEnabled = true
//        inheriSireRedOutlet.isEnabled = true
//        inheritDobBttn.isEnabled = true
//        inheritSireYobBttn.isEnabled = true
//        inheritDamYobBttn.isEnabled = true
//        inheriSireRedOutlet.backgroundColor = UIColor.white
//        inheritDobBttn.backgroundColor = UIColor.white
//        inheritBarcodeTextfield.backgroundColor = UIColor.white
//        inheritDamIdTextfield.backgroundColor = UIColor.white
//        inheritSireRegTextfield.backgroundColor = UIColor.white
//        inheritBarcodeView.backgroundColor = UIColor.white
//        breedRegTextfield.backgroundColor = UIColor.white
//        animalNameTextfield.backgroundColor = UIColor.white
//        inheritBreedBttn.backgroundColor = UIColor.white
//        inheritTissueBttn.backgroundColor = UIColor.white
//        inheritRegAssociationBttn.backgroundColor = UIColor.white
//        inheritBreedRegTextfield.backgroundColor = UIColor.white
//        inheritDamYobBttn.backgroundColor = .white
//        inheritSireYobBttn.backgroundColor = .white
//        inheritEIDTextfield.backgroundColor =  .white
//        inheritSecondaryIdTextfield.backgroundColor = .white
//        inheritDateTextField.text = ""
//        inheritDateTextField.isEnabled = true
//        
//        if isautoPopulated == false {
//            incrementalBarcodeTitleLabelInherit.textColor = .black
//            incrementalBarcodeButtonInherit.isEnabled = true
//            incrementalBarcodeCheckBoxInherit.alpha = 1
//            incrementalBarcodeTitleLabelInherit.alpha = 1
//            if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) == true {
//                if let lastSavedBarCode = UserDefaults.standard.value(forKey: keyValue.barcodeIncremental.rawValue) as? String {
//                    inheritBarcodeTextfield.text = isBarCodeEndsWithNumber_GetIncrementedBarCode(lastSavedBarCode).incrementedBarCode
//                }
//            }
//        } else {
//            incrementalBarcodeTitleLabelInherit.textColor = UIColor.gray
//            incrementalBarcodeButtonInherit.isEnabled = false
//            incrementalBarcodeCheckBoxInherit.alpha = 0.6
//            incrementalBarcodeTitleLabelInherit.alpha = 0.6
//        }
//    }
//    
//    func inheritTextFieldBackroungGrey(){
//        dobLbl.textColor = UIColor.gray
//        inheritDobLbl.textColor = UIColor.gray
//        inheritDobBttn.setTitleColor(.gray, for: .normal)
//        inheritTissueBttn.setTitleColor(.gray, for: .normal)
//        inheriSireRedOutlet.setTitleColor(.gray, for: .normal)
//        inheritDobBttn.setTitle("", for: .normal)
//        inheritDobBttn.setTitle(nil, for: .normal)
//        inheritBreedBttn.setTitleColor(.gray, for: .normal)
//        inheritRegAssociationBttn.setTitleColor(UIColor.gray, for: .normal)
//        inheritDamYobBttn.textColor = .gray
//        inheritSireYobBttn.textColor = .gray
//        inheritMaleFemaleBttn.isEnabled = false
//        inheritDobBttn.isEnabled = false
//        inheritDobBttn.isEnabled = false
//        inheritSireYobBttn.isEnabled = false
//        inheritDamYobBttn.isEnabled = false
//        inheritbarcodeBttn.isEnabled = false
//        inheritBarcodeTextfield.isEnabled = false
//        inheritDamIdTextfield.isEnabled = false
//        inheritSireRegTextfield.isEnabled = false
//        inheritBreedRegTextfield.isEnabled = false
//        inheritRegAssociationBttn.isEnabled = false
//        inheritEIDTextfield.isEnabled = false
//        inheritSecondaryIdTextfield.isEnabled = false
//        inheritDateTextField.isEnabled = false
//        inheritTissueBttn.isEnabled = false
//        inheritBreedBttn.isEnabled = false
//        inheritRegAssociationBttn.isEnabled = false
//        inheriSireRedOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        inheritDobBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        inheritBarcodeTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        inheritDamIdTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        inheritSireRegTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        inheritBarcodeView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        breedRegTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        animalNameTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        breedBtnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        tissueBttnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        sireRegDropdownOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        damRegDropdownOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        inheritBreedBttn.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        inheritTissueBttn.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        inheritRegAssociationBttn.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        inheritBreedRegTextfield.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        inheritDamYobBttn.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        inheritSireYobBttn.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        inheritEIDTextfield.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        inheritSecondaryIdTextfield.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        inheritDobBttn.setTitle(nil, for: .normal)
//        inheritDobBttn.setTitle("", for: .normal)
//        inheritDateTextField.text = ""
//    }
//    
//    func textFieldBackroungGrey(){
//        dobLbl.textColor = UIColor.gray
//        inheritDobLbl.textColor = UIColor.gray
//        dateBttnOutlet.setTitleColor(.gray, for: .normal)
//        tissueBttnOutlet.setTitleColor(.gray, for: .normal)
//        breedBtnOutlet.setTitleColor(.gray, for: .normal)
//        breedRegBttn.setTitleColor(.gray, for: .normal)
//        sireRegDropdownOutlet.setTitleColor(UIColor.gray, for: .normal)
//        damRegDropdownOutlet.setTitleColor(UIColor.gray, for: .normal)
//        male_femaleBttnOutlet.isEnabled = false
//        dateBttnOutlet.isEnabled = false
//        tissueBttnOutlet.isEnabled = false
//        breedBtnOutlet.isEnabled = false
//        breedRegBttn.isEnabled = false
//        scanBarcodeTextfield.isEnabled = false
//        damRegTextfield.isEnabled = false
//        sireRegTextfield.isEnabled = false
//        breedRegTextfield.isEnabled = false
//        sireRegDropdownOutlet.isEnabled = false
//        animalNameTextfield.isEnabled = false
//        damRegDropdownOutlet.isEnabled = false
//        barcodeBtn.isEnabled = false
//        breedBtnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        dateBttnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        scanBarcodeTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        damRegTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        sireRegTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        barcodeView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        breedRegTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        animalNameTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        breedBtnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        tissueBttnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        sireRegDropdownOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        damRegDropdownOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        breedRegBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
//        dateBttnOutlet.setTitle("", for: .normal)
//        globalDateTextField.text = ""
//        dateBttnOutlet.setTitle(nil, for: .normal)
//        self.scanEarTagTextField.becomeFirstResponder()
//        globalDateTextField.isEnabled = false
//    }
//    
//    func initialNetworkCheck(){
//        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
//        let del = UIApplication.shared.delegate as? AppDelegate
//        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
//        if NetworkStatusLbl?.text == ButtonTitles.connectedText.localized {
//            networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
//            offLineBtn.isEnabled = false
//        }
//        else {
//            offLineBtn.isEnabled = true
//            networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
//        }
//    }
//    
//    func inheritSireYOBDoDatePicker(){
//        self.datePicker = UIDatePicker(frame:CGRect(x: 20, y: 40, width: self.calenderView.frame.size.width, height: 260))
//        self.datePicker?.backgroundColor = UIColor.white
//        if langId == 2{
//            self.datePicker?.locale = Locale(identifier: Languages.portuguese)
//        }
//        else if langId == 3{
//            self.datePicker?.locale = Locale(identifier: Languages.italian)
//        }
//        else{
//            self.datePicker?.locale = Locale(identifier: Languages.eng)
//        }
//        self.datePicker?.datePickerMode = UIDatePicker.Mode.date
//        self.datePicker.setDate(InheritSireSelectedDate, animated: true)
//        
//        if #available(iOS 14, *) {
//            self.datePicker?.preferredDatePickerStyle = .wheels
//        }
//        calenderView.backgroundColor = UIColor.white
//        calenderView.addSubview(self.datePicker)
//        toolBar.barStyle = .default
//        toolBar.isTranslucent = true
//        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
//        toolBar.sizeToFit()
//        self.datePicker.maximumDate = Date()
//        let doneButton = UIBarButtonItem(title: LocalizedStrings.doneStr.localized, style: .plain, target: self, action: #selector(self.InheritSireYOBDoneClick))
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel".localized, style: .plain, target: self, action: #selector(self.inheritSireCancelClick))
//        cancelButton.tintColor = UIColor.black
//        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
//        toolBar.isUserInteractionEnabled = true
//        toolBar.frame = CGRect(x: 0, y: 0, width: self.calenderView.frame.size.width, height: 40)
//        self.calenderView.addSubview(toolBar)
//        self.toolBar.isHidden = false
//    }
//  
//    func inheritDamYOBDoDatePicker(){
//        self.datePicker = UIDatePicker(frame:CGRect(x: 20, y: 40, width: self.calenderView.frame.size.width, height: 260))
//        self.datePicker?.backgroundColor = UIColor.white
//        if langId == 2{
//            self.datePicker?.locale = Locale(identifier: Languages.portuguese)
//        }
//        else if langId == 3{
//            self.datePicker?.locale = Locale(identifier: Languages.italian)
//        }
//        else{
//            self.datePicker?.locale = Locale(identifier: Languages.eng)
//        }
//        self.datePicker?.datePickerMode = UIDatePicker.Mode.date
//        self.datePicker.setDate(InheritDamSelectedDate, animated: true)
//        
//        if #available(iOS 14, *) {
//            self.datePicker?.preferredDatePickerStyle = .wheels
//        }
//        calenderView.backgroundColor = UIColor.white
//        calenderView.addSubview(self.datePicker)
//        toolBar.barStyle = .default
//        toolBar.isTranslucent = true
//        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
//        toolBar.sizeToFit()
//        self.datePicker.maximumDate = Date()
//        let doneButton = UIBarButtonItem(title: LocalizedStrings.doneStr.localized, style: .plain, target: self, action: #selector(self.InheritDamYOBDoneClick))
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel".localized, style: .plain, target: self, action: #selector(self.inheritDamCancelClick))
//        cancelButton.tintColor = UIColor.black
//        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
//        toolBar.isUserInteractionEnabled = true
//        toolBar.frame = CGRect(x: 0, y: 0, width: self.calenderView.frame.size.width, height: 40)
//        self.calenderView.addSubview(toolBar)
//        self.toolBar.isHidden = false
//    }
//    
//    func inheritDoDatePicker(){
//        self.datePicker = UIDatePicker(frame:CGRect(x: 20, y: 40, width: self.calenderView.frame.size.width, height: 260))
//        self.datePicker?.backgroundColor = UIColor.white
//        if langId == 2{
//            self.datePicker?.locale = Locale(identifier: Languages.portuguese)
//        }
//        else if langId == 3{
//            self.datePicker?.locale = Locale(identifier: Languages.italian)
//        }
//        else{
//            self.datePicker?.locale = Locale(identifier: Languages.eng)
//        }
//        self.datePicker?.datePickerMode = UIDatePicker.Mode.date
//        self.datePicker.setDate(InheritSelectedDate, animated: true)
//        
//        if #available(iOS 14, *) {
//            self.datePicker?.preferredDatePickerStyle = .wheels
//        }
//        calenderView.backgroundColor = UIColor.white
//        calenderView.addSubview(self.datePicker)
//        toolBar.barStyle = .default
//        toolBar.isTranslucent = true
//        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
//        toolBar.sizeToFit()
//        self.datePicker.maximumDate = Date()
//        let doneButton = UIBarButtonItem(title: LocalizedStrings.doneStr.localized, style: .plain, target: self, action: #selector(self.InheritDoneClick))
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel".localized, style: .plain, target: self, action: #selector(self.inheritCancelClick))
//        cancelButton.tintColor = UIColor.black
//        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
//        toolBar.isUserInteractionEnabled = true
//        toolBar.frame = CGRect(x: 0, y: 0, width: self.calenderView.frame.size.width, height: 40)
//        self.calenderView.addSubview(toolBar)
//        self.toolBar.isHidden = false
//    }
//
//    func inheritByDefaultSetting(){
//        dobLbl.textColor = UIColor.gray
//        inheritDobLbl.textColor = UIColor.gray
//        let dateformt = DateFormatter()
//        let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
//        if dateStr == "MM" {
//            dateformt.dateFormat = DateFormatters.MMddyyyyFormat
//            inheritDateTextField.placeholder = DateFormatters.MMDDYYYYFormat
//        } else {
//            dateformt.dateFormat = DateFormatters.ddMMyyyyFormat
//            inheritDateTextField.placeholder = DateFormatters.DDMMYYYYFormat
//        }
//        animalId1 = 0
//        idAnimal = 0
//        isUpdate = false
//        msgUpatedd = false
//        self.msgcheckk = false
//        barAutoPopu = false
//        self.isautoPopulated = false
//        self.isAnimalComingFromCart = false
//        inheritDobBttn.setTitleColor(UIColor.gray, for: .normal)
//        inheritBreedBttn.setTitleColor(UIColor.gray, for: .normal)
//        isautoPopulated = false
//        inheritBarcodeView.layer.borderColor = UIColor.gray.cgColor
//        inheritDamYobBttn.placeholder = NSLocalizedString(ButtonTitles.DamYOBText, comment: "")
//        inheritDamYobBttn.layer.borderColor = UIColor.gray.cgColor
//        inheriSireRedOutlet.layer.borderColor = UIColor.gray.cgColor
//        inheritSireYobBttn.placeholder = NSLocalizedString(ButtonTitles.SireYOB, comment: "")
//        inheriSireRedOutlet.layer.borderWidth = 0.5
//        inheritSireRegTextfield.layer.borderWidth = 0.5
//        inheritDamYobBttn.layer.borderWidth = 0.5
//        inheritTissueBttn.layer.borderWidth = 0.5
//        inheritBreedBttn.layer.borderWidth = 0.5
//        inheritDamIdTextfield.layer.borderColor = UIColor.gray.cgColor
//        inheritSireRegTextfield.layer.borderColor = UIColor.gray.cgColor
//        inheritBreedRegTextfield.layer.borderColor = UIColor.gray.cgColor
//        inheritRegAssociationBttn.layer.borderColor = UIColor.gray.cgColor
//        inheritBreedBttn.layer.borderColor = UIColor.gray.cgColor
//        inheritDobBttn.layer.borderColor = UIColor.gray.cgColor
//        inheriSireRedOutlet.layer.borderColor = UIColor.gray.cgColor
//        inheritDamYobBttn.layer.borderColor = UIColor.gray.cgColor
//        inheritSecondaryIdTextfield.layer.borderColor = UIColor.gray.cgColor
//        inheritEIDTextfield.layer.borderColor = UIColor.gray.cgColor
//        inheritSireYobBttn.text?.removeAll()
//        inheritDamYobBttn.text?.removeAll()
//        inheritDamIdTextfield.text?.removeAll()
//        inheritSireRegTextfield.text?.removeAll()
//        inheritBreedRegTextfield.text?.removeAll()
//        inheritBarcodeTextfield.text?.removeAll()
//        breedRegTextfield.text?.removeAll()
//        inheritEarTagTextfield.text?.removeAll()
//        inheritEIDTextfield.text?.removeAll()
//        inheritSecondaryIdTextfield.text?.removeAll()
//        inheriSireRedOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectSireReg, comment: ""), for: .normal)
//        self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
//        inheritGenderToggleFlag = 0
//        inheritGenderString = ButtonTitles.femaleText.localized
//        inheriSireRedOutlet.isEnabled = false
//        inheriSireRedOutlet.setTitleColor(.gray, for: .normal)
//        inheritBreedBttn.setTitleColor(.gray, for: .normal)
//        inheritTissueBttn.setTitleColor(.gray, for: .normal)
//        self.InheritSelectedDate = Date()
//        inheritTextFieldBackroungGrey()
//        self.inheritScrollView.contentOffset.y = 0.0
//        
//        //merged
//     //   if UserDefaults.standard.string(forKey: keyValue.beefInheritTSU.rawValue) == nil || UserDefaults.standard.string(forKey: keyValue.beefInheritTSU.rawValue) == ""{
//        if UserDefaults.standard.string(forKey: keyValue.beefInheritSampleType.rawValue) == nil || UserDefaults.standard.string(forKey: keyValue.beefInheritSampleType.rawValue) == ""{
//            inheritTissueBttn.setTitle(ButtonTitles.allflexTSUText, for: .normal)
//            tissuId = 1
//        }
//        else{
//            //merged
////            inheritTissueBttn.setTitle(UserDefaults.standard.string(forKey: keyValue.beefInheritTSU.rawValue)?.localized, for: .normal)
//            inheritTissueBttn.setTitle(UserDefaults.standard.string(forKey: keyValue.beefInheritSampleType.rawValue)?.localized, for: .normal)
//        }
//        
//        if UserDefaults.standard.string(forKey: keyValue.inheritBeefbreed.rawValue) == "" || UserDefaults.standard.string(forKey: keyValue.inheritBeefbreed.rawValue) == nil{
//            inheritBreedBttn.setTitle("XX", for: .normal)
//            breedId = "87c30632-8da0-4f86-8d94-46da17c520dd"
//        }
//        else{
//            let savedBreed = UserDefaults.standard.string(forKey: keyValue.inheritBeefbreed.rawValue)
//            inheritBreedBttn.setTitle(savedBreed, for: .normal)
//            let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
//            let breeds = fetchproviderProductData(entityName: Entities.getBreedsTblEntity, provId: pvid)
//            for breed in breeds as? [GetBreedsTbl] ?? [] {
//                if breed.breedName == savedBreed {
//                    self.breedId = breed.breedId ?? ""
//                    break
//                }
//            }
//        }
//        if breedId  == "" {
//            let inheritBreed = fetchAllDataProductBeefId(entityName: Entities.getBreedsTblEntity, breedName: (inheritBreedBttn.titleLabel?.text!)!, productId: 20)
//            if inheritBreed.count != 0 {
//                let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
//                breedId = medbreedRegArr1!.breedId ?? ""
//            }
//        }
//        
//        inheritRegAssociationBttn.setTitle(NSLocalizedString(LocalizedStrings.selectBreedAssc, comment: ""), for: .normal)
//        inheritDobBttn.titleLabel?.text = ""
//        incrementalBarcodeTitleLabelInherit.textColor = .gray
//        incrementalBarcodeButtonInherit.isEnabled = false
//        incrementalBarcodeCheckBoxInherit.alpha = 0.6
//        incrementalBarcodeTitleLabelInherit.alpha = 0.6
//        self.inheritEarTagTextfield.becomeFirstResponder()
//        autoPopulateAnimalData = nil
//        isAnimalComingFromCart = false
//    }
//    
//    func landIdApplangaugeConversion(){
//        selectListLbl.text =  NSLocalizedString(ButtonTitles.selectListText, comment: "")
//        inheritEarTagTextfield.placeholder = NSLocalizedString(ButtonTitles.enterUniqueIdText, comment: "")
//        scanBarcodeTextfield.placeholder = NSLocalizedString(ButtonTitles.enterSampleBarcode, comment: "")
//        inheritEIDTextfield.placeholder = NSLocalizedString(ButtonTitles.enterVisualIdText, comment: "")
//        scanBarcodeTextfield.addPadding(.right(35))
//        inheritEIDTextfield.addPadding(.right(20))
//        inheritSecondaryIdTextfield.placeholder = NSLocalizedString(ButtonTitles.enterSecondaryId, comment: "")
//        dobLbl.text = NSLocalizedString(ButtonTitles.dateOfBirthText, comment: "")
//        inheritDobLbl.text = NSLocalizedString(ButtonTitles.dateOfBirthText, comment: "")
//        inheritRegAssociationBttn.setTitle(LocalizedStrings.selectBreedAssc.localized, for: .normal)
//        inheritBreedRegTextfield.placeholder = NSLocalizedString(ButtonTitles.enterBreedRegNumber, comment: "")
//        inheritDamIdTextfield.placeholder = NSLocalizedString(ButtonTitles.enterDamIDText, comment: "")
//        inheritSireRegTextfield.placeholder = NSLocalizedString(ButtonTitles.enterSireRegNumber, comment: "")
//        inheritBarcodeTextfield.placeholder = NSLocalizedString(ButtonTitles.enterSampleBarcode, comment: "")
//        inheritRegAssociationBttn.setTitle(LocalizedStrings.selectBreedAssc, for: .normal)
//        inheritSireYobBttn.placeholder = NSLocalizedString(ButtonTitles.SireYOB, comment: "")
//        inheritDamYobBttn.placeholder = NSLocalizedString(ButtonTitles.DamYOBText, comment: "")
//        inheritAddBttn.setTitle(NSLocalizedString(ButtonTitles.addAnotherAnimalText, comment: ""),for: .normal)
//        addbttn.setTitle(NSLocalizedString(ButtonTitles.addAnotherAnimalText, comment: ""),for: .normal)
//        continueBttn.setTitle(NSLocalizedString(ButtonTitles.continueProdSelection, comment: ""),for: .normal)
//        inheritContinueBttn.setTitle(NSLocalizedString(ButtonTitles.continueProdSelection, comment: ""),for: .normal)
//        scanEarTagTextField.placeholder = NSLocalizedString(ButtonTitles.earTagText, comment: "")
//        breedRegTextfield.placeholder = NSLocalizedString(ButtonTitles.enterBreedRegNumber, comment: "")
//        breedRegBttn.setTitle(NSLocalizedString(LocalizedStrings.selectBreedAssc, comment: ""), for: .normal)
//        animalNameTextfield.placeholder = NSLocalizedString(ButtonTitles.enterAnimalName, comment: "")
//        sireRegTextfield.placeholder = NSLocalizedString(ButtonTitles.enterSireRegNumber, comment: "")
//        damRegTextfield.placeholder =  NSLocalizedString(ButtonTitles.entireDamRegNumber, comment: "")
//        sireRegDropdownOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectSireReg, comment: ""),for: .normal)
//        damRegDropdownOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectDamReg, comment: ""),for: .normal)
//        appStatusLbl.text = NSLocalizedString(ButtonTitles.appStatusText, comment: "")
//        orderingTitleLbl.text = NSLocalizedString(ButtonTitles.orderingAddAnimalText, comment: "")
//    }
//}
