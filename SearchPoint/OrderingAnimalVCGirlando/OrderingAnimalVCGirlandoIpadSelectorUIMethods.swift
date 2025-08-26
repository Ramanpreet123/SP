//
//  OrderingAnimalVCGirlandoIpadSelectorUIMethods.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 08/03/25.
//

import Foundation
import UIKit

// MARK: - OBJC SELECTOR METHODS
extension OrderingAnimalVCGirlandoIpad {
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
            keyBoardOptionsViewBottomConstrains.constant = keyboardHeight+140
          
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
        addbttn.isHidden =  false
        continueBttn.isHidden = false
        scrolView.isScrollEnabled = true
    }
    
    @objc func methodOfReceivedNotification(notification: Notification){
        if value == 0{
            UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
            let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
            self.hideIndicator()
            value = value + 1
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
        dobLbl.isHidden = true
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
        self.sampleTypeView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.genderView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.dateBtnView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        self.setShadowForUIView(view: sampleTypeView, removeShadow: true)
        self.setShadowForUIView(view: genderView, removeShadow: true)
        
    }
}

// MARK: - UI METHODS
extension OrderingAnimalVCGirlandoIpad {
    func setUIOnDidLoad(){
        self.scanBarcodeTextfield.layer.cornerRadius = 15.0
        self.scanBarcodeTextfield.clipsToBounds = true
        self.scanEarTagTextField.layer.cornerRadius = 15.0
        self.scanEarTagTextField.clipsToBounds = true
        self.tissueBttnOutlet.layer.cornerRadius = 15.0
        self.tissueBttnOutlet.clipsToBounds = true
        self.male_femaleBttnOutlet.layer.cornerRadius = 15.0
        self.male_femaleBttnOutlet.clipsToBounds = true
        self.breedRegTextfield.layer.cornerRadius = 15.0
        self.breedRegTextfield.clipsToBounds = true
        self.animalNameTextfield.layer.cornerRadius = 15.0
        self.animalNameTextfield.clipsToBounds = true
        self.sireRegTextfield.layer.cornerRadius = 15.0
        self.sireRegTextfield.clipsToBounds = true
        self.damRegTextfield.layer.cornerRadius = 15.0
        self.damRegTextfield.clipsToBounds = true
        
        addObserver()
        dateTextField.setLeftPaddingPoints(20.0)
        tapRec.addTarget(self, action: #selector(closeAddAnimalAndContinueOptions(tapGestureRecognizer:)))
        self.pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        
        
        let dataFetc = fetchDataEnteryWithListId(entityName: Entities.animalAddTblEntity,customerId:self.custmerId ?? 0 ,listId:0,providerId:pvid,orderstatus:"false", orderiD:UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue) )
        if dataFetc.count == 0 {
            UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
            
            deleteDataWithPvidCustomerId(entityString: Entities.mergeDataEntryListTblEntity ,providerId: Int64(pvid),customerId: Int64(self.custmerId ?? 0))
        } else {
            let get = dataFetc.object(at: 0) as? AnimaladdTbl
            let getListid = get?.listId ?? 0
            UserDefaults.standard.set(Int64(getListid), forKey: keyValue.dataEntryListId.rawValue)
        }
        
        dateTextField.keyboardType = .phonePad
        dateTextField.borderStyle = .none
        dateTextField.delegate = self
        heartBeatViewModel?.callGetHearBeatData()
        byDefaultSetting()
        dobLbl.text = NSLocalizedString(ButtonTitles.selectdateText, comment: "")
        
        scanEarTagTextField.addPadding(.left(20))
        scanBarcodeTextfield.addPadding(.left(20))
        breedRegTextfield.addPadding(.left(20))
        animalNameTextfield.addPadding(.left(20))
        sireRegTextfield.addPadding(.left(20))
        damRegTextfield.addPadding(.left(20))
        girlandoNoTextField.addPadding(.left(20))
        calenderView.isHidden = true
        calenderbkg.isHidden = true
        breedArr =  fetchBreedData(entityName: Entities.getBreedsTblEntity, provId: pvid)
        
        breedRegArr = fetchAllDataProductBeefBreedSociety(entityName: Entities.getBreedSocietiesTblEntity, productId: 17)
        
        self.defaultIncrementalBarCodeSetting()
        
        if fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId ?? 0)).count == 0 {
            self.mergeListView.isHidden = true
        } else {
            self.mergeListView.isHidden = false
        }
        
        let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ?? 0,providerId:pvid )
        
        if fetchObj.count != 0 {
            let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
            let obj = objectFetch?.listName
            let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId ?? 0)).count - 1
            
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
    }
    
    func setUIOnWillAppear(){
        self.setSideMenu()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
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
                updateOrderStatusServerRemain(entity: Entities.animalMasterTblEntity, aniamltag: data.animalTag ?? "l.", userId: userId)
            }
            deleteRemaningSubmitOrder(entityName: Entities.animalAddTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            deleteRemaningSubmitOrder(entityName: Entities.productAdonAnimalTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            deleteRemaningSubmitOrder(entityName: Entities.subProductTblEntity, isSync: "false", status: "false", orderstatus: "false", orderId: orderId, userId: userId)
            
            UserDefaults.standard.set(autoD, forKey: keyValue.orderId.rawValue)
        }
        autoD = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        timeStampString = UserDefaults.standard.value(forKey: keyValue.timeStamp.rawValue) as? String ?? ""
        self.orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        initialNetworkCheck()
        BluetoothCentre.shared.manager.scanForPeripherals(withServices: nil, options: nil)
        self.navigationController?.navigationBar.isHidden = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        
        if UserDefaults.standard.integer(forKey: keyValue.animalIdSelectionCart.rawValue) > 0 {
            let temp = UserDefaults.standard.integer(forKey: keyValue.animalIdSelectionCart.rawValue)
            animalIdBool = true
            textFieldBackroungWhite()
            UserDefaults.standard.set(0, forKey: keyValue.animalIdSelectionCart.rawValue)
            dataPopulateInScreen(animalId: temp)
            if UserDefaults.standard.integer(forKey: keyValue.placeOrderText.rawValue) == 1{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if self.dateBttnOutlet.titleLabel?.text == ""{
                        self.dateBttnOutlet.layer.borderColor = UIColor.red.cgColor
                        self.dateBtnView.layer.borderColor = UIColor.red.cgColor
                    }
                    if self.animalNameTextfield.text == ""{
                        self.animalNameTextfield.layer.borderColor = UIColor.red.cgColor
                    }
                }
                UserDefaults.standard.set(0, forKey: keyValue.placeOrderText.rawValue)
            }
        }
        if !UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncrementalClear.rawValue) {
            self.isBarcodeAutoIncrementedEnabled = false
        }
        let viewAnimalArray =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid)
        if viewAnimalArray.count == 0{
            checkUserDataListName()
        }
        self.showUpdatedCartAnimalCount()
    }
    
    func setUIOnDidAppear(){
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false",providerId: self.pvid)
        notificationLblCount.text = String(animalCount.count)
        if animalCount.count == 0{
            notificationLblCount.isHidden = true
            countLbl.isHidden = true
            self.cartView.isHidden = true
        }
    }
    
    func tableViewpop() {
        buttonbg2.frame = CGRect(x:0,y: 0,width: self.view.frame.width,height: self.view.frame.height)
        buttonbg2.addTarget(self, action:#selector(OrderingAnimalVCGirlandoIpad.buttonPreddDroper), for: .touchUpInside)
        buttonbg2.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        self.view.addSubview(buttonbg2)
        droperTableView.delegate = self
        droperTableView.dataSource = self
        droperTableView.layer.cornerRadius = 8.0
        droperTableView.layer.borderWidth = 0.5
        droperTableView.layer.borderColor =  UIColor.gray.cgColor
        buttonbg2.addSubview(droperTableView)
    }
    
    func textFieldBackroungGrey(){
        dateBttnOutlet.setTitleColor(.gray, for: .normal)
        tissueBttnOutlet.setTitleColor(.gray, for: .normal)
        breedBtnOutlet.setTitleColor(.gray, for: .normal)
        breedRegBttn.setTitleColor(.gray, for: .normal)
        male_femaleBttnOutlet.setTitleColor(.gray, for: .normal)
        male_femaleBttnOutlet.isEnabled = false
        dateBttnOutlet.isEnabled = false
        dateTextField.isEnabled = false
        tissueBttnOutlet.isEnabled = false
        breedBtnOutlet.isEnabled = false
        breedRegBttn.isEnabled = false
        scanBarcodeTextfield.isEnabled = true
        damRegTextfield.isEnabled = false
        sireRegTextfield.isEnabled = false
        breedRegTextfield.isEnabled = false
        girlandoNoTextField.isEnabled = false
        dobLbl.textColor = UIColor.gray
        scanEarTagTextField.isEnabled = false
        animalNameTextfield.isEnabled = false
        etBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        singleBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        multipleBirthBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        breedBtnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        dateBttnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        scanBarcodeTextfield.backgroundColor = UIColor.white
        damRegTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        male_femaleBttnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        sireRegTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        earTagView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        breedRegTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        animalNameTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        breedBtnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        tissueBttnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        breedRegBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        girlandoNoTextField.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        scanEarTagTextField.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        incrementalBarcodeTitleLabel.textColor = .gray
        incrementalBarcodeButton.isEnabled = false
        incrementalBarcodeCheckBox.alpha = 0.6
        incrementalBarcodeTitleLabel.alpha = 0.6
        singleBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        etBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        multipleBirthBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        singleBttn.setTitleColor(.black, for: .normal)
        multipleBirthBttn.setTitleColor(.black, for: .normal)
        etBttn.setTitleColor(.black, for: .normal)
    }
    
    
    func textFieldBackroungWhite(){
        etBttn.backgroundColor = UIColor.white
        singleBttn.backgroundColor = UIColor.white
        multipleBirthBttn.backgroundColor = UIColor.white
        singleBttn.backgroundColor = UIColor(red:57/255, green: 69/255, blue: 73/255, alpha: 1)
        singleBttn.setTitleColor(UIColor.white, for: .normal)
        dateTextField.isEnabled = true
        breedRegBttn.isEnabled = true
        male_femaleBttnOutlet.isEnabled = true
        dateBttnOutlet.setTitleColor(.black, for: .normal)
        male_femaleBttnOutlet.setTitleColor(.black, for: .normal)
        breedBtnOutlet.setTitleColor(UIColor.black, for: .normal)
        tissueBttnOutlet.setTitleColor(UIColor.black, for: .normal)
        breedRegBttn.setTitleColor(UIColor.black, for: .normal)
        dateBttnOutlet.isEnabled = true
        male_femaleBttnOutlet.isEnabled = true
        tissueBttnOutlet.isEnabled = true
        breedBtnOutlet.isEnabled = true
        scanBarcodeTextfield.isEnabled = true
        scanEarTagTextField.isEnabled = true
        damRegTextfield.isEnabled = true
        sireRegTextfield.isEnabled = true
        breedRegTextfield.isEnabled = true
        animalNameTextfield.isEnabled = true
        girlandoNoTextField.isEnabled = true
        tissueBttnOutlet.isEnabled = true
        breedRegBttn.backgroundColor = .white
        barcodeView.backgroundColor = UIColor.white
        earTagView.backgroundColor = UIColor.white
        scanBarcodeTextfield.backgroundColor = UIColor.white
        damRegTextfield.backgroundColor = UIColor.white
        tissueBttnOutlet.backgroundColor = UIColor.white
        sireRegTextfield.backgroundColor = UIColor.white
        breedRegTextfield.backgroundColor = UIColor.white
        girlandoNoTextField.backgroundColor = UIColor.white
        animalNameTextfield.backgroundColor = UIColor.white
        breedBtnOutlet.backgroundColor = UIColor.white
        tissueBttnOutlet.backgroundColor = UIColor.white
        dateBttnOutlet.backgroundColor = UIColor.white
        scanEarTagTextField.backgroundColor = UIColor.white
        male_femaleBttnOutlet.backgroundColor = UIColor.white
        singleBttn.layer.borderWidth = 2
        singleBttn.layer.borderColor = UIColor.clear.cgColor
        selectedBornTypeId = 1
        etBttn.isEnabled = true
        singleBttn.isEnabled = true
        multipleBirthBttn.isEnabled = true
        breedRegBttn.setTitleColor(.black, for: .normal)
        breedRegBttn.setTitle(NSLocalizedString(LocalizedStrings.girolandoAssociationStr, comment: ""), for: .normal)
        breedBtnOutlet.setTitleColor(.black, for: .normal)
        
        if !isautoPopulated {
            incrementalBarcodeTitleLabel.textColor = UIColor.black
            incrementalBarcodeButton.isEnabled = true
            incrementalBarcodeCheckBox.alpha = 1
            incrementalBarcodeTitleLabel.alpha = 1
            incrementalBarcodeButton.isEnabled = true
            if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue){
                if let lastSavedBarCode = UserDefaults.standard.value(forKey: keyValue.barcodeIncremental.rawValue) as? String {
                    scanBarcodeTextfield.text = isBarcodeEndingWithNumberAndGetIncremented(lastSavedBarCode).incrementedBarCode
                }
            }
        } else {
            incrementalBarcodeTitleLabel.textColor = UIColor.gray
            incrementalBarcodeButton.isEnabled = false
            incrementalBarcodeCheckBox.alpha = 0.6
            incrementalBarcodeTitleLabel.alpha = 0.6
        }
    }
    
    func setUpGallary(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imgPhotoLib = UIImagePickerController()
            imgPhotoLib.delegate = self
            imgPhotoLib.allowsEditing = true
            imgPhotoLib.sourceType = .camera
            self.present(imgPhotoLib,animated: true,completion: nil)
        }
    }
    
    func currentTimeInMilliSeconds()-> Int{
        let currentDate = Date()
        let since1970 = currentDate.timeIntervalSince1970
        return Int(since1970 * 1000)
    }
    
    func timeStamp()-> String{
        let time1 = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatters.MMddyyyyHHmmssFormat
        let timestamp = formatter.string(from: time1 as Date)
        lblTimeStamp = timestamp.replacingOccurrences(of: "-", with: "", options: .regularExpression)
        lblTimeStamp = lblTimeStamp.replacingOccurrences(of: ":", with: "", options: .regularExpression)
        let string = lblTimeStamp as String
        let charset = CharacterSet(charactersIn: "i")
        if string.rangeOfCharacter(from: charset) != nil {
            
        }
        let udid = UserDefaults.standard.value(forKey: keyValue.applicationIdentifier.rawValue)! as! String
        let sessionGUID1 =   lblTimeStamp + "_" + String(describing: autoD as Int)
        lblTimeStamp = sessionGUID1 + "_" + "iOS" + "_" + String(udid)
        return lblTimeStamp
    }
    
    func doDatePicker(){
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
        self.datePicker.setDate(selectedDate, animated: true)
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
        let doneButton = UIBarButtonItem(title: NSLocalizedString("Done", comment: "") , style: .plain, target: self, action: #selector(self.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: NSLocalizedString("Cancel", comment: "") , style: .plain, target: self, action: #selector(self.cancelClick))
        cancelButton.tintColor = UIColor.black
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = CGRect(x: 0, y: 0, width: self.calenderView.frame.size.width, height: 40)
        self.calenderView.addSubview(toolBar)
        self.toolBar.isHidden = false
        
    }
    
    
    func initialNetworkCheck(){
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del = UIApplication.shared.delegate as? AppDelegate
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        if NetworkStatusLbl?.text == ButtonTitles.connectedText.localized {
            networkStatusImg.image = UIImage(named: ImageNames.statusOnlineSign)
            offLineBtn.isEnabled = false
        }
        else {
            offLineBtn.isEnabled = true
            networkStatusImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    func showUpdatedCartAnimalCount() {
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
        self.notificationLblCount.text = String(animalCount.count)
        if animalCount.count == 0 {
            self.notificationLblCount.isHidden = true
            self.countLbl.isHidden = true
            self.cartView.isHidden = true
        } else {
            self.notificationLblCount.isHidden = false
            self.countLbl.isHidden = false
            self.cartView.isHidden = false
        }
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
                singleBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
                singleBttn.layer.borderWidth = 2
                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                etBttn.layer.borderColor = UIColor.gray.cgColor
                
                selectedBornTypeId = 1
            }
            barcodeView.layer.borderColor = UIColor.gray.cgColor
            
            if data.date != "" {
                dobLbl.text = ""
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
            tissueBttnOutlet.setTitle(data.tissuName, for: .normal)
            UserDefaults.standard.set(data.tissuName, forKey: keyValue.girlandoSampleType.rawValue)
            breedRegBttn.setTitle(data.breedAssocation, for: .normal)
            breedId = data.breedId!
            let breedidd =  UserDefaults.standard.value(forKey: keyValue.breed.rawValue) as? String
            if breedidd != breedId {
                let  aDat = fetchAnimaldata(status: Entities.animalAddTblEntity)
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
            
            if data.gender == "Male".localized || data.gender == "M" || data.gender == "m"{
                genderToggleFlag = 1
                genderString = NSLocalizedString("Male", comment: "")
                male_femaleBttnOutlet.setTitle("Male", for: .normal)
                UserDefaults.standard.set("M", forKey: "GirlandoGender")
            }
            else {
                genderToggleFlag = 0
                genderString = NSLocalizedString("Female", comment: "")
                male_femaleBttnOutlet.setTitle("Female", for: .normal)
                UserDefaults.standard.set("F", forKey: "GirlandoGender")
            }
       
            let et = data.eT
            etBtn = et!
         
            if et == "Et"{
                etBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                etBttn.layer.borderWidth = 2
                singleBttn.layer.borderColor = UIColor.gray.cgColor
                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                selectedBornTypeId = 3
            }
            else if et == LocalizedStrings.singlesText{
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
                singleBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
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
    
    func byDefaultSetting(){
        let dateformt = DateFormatter()
        let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
        if dateStr == "MM" {
            dateformt.dateFormat = DateFormatters.MMddyyyyFormat
            dateTextField.placeholder = DateFormatters.MMDDYYYYAllCapsFormat
        } else {
            dateformt.dateFormat = DateFormatters.ddMMyyyyFormat
            dateTextField.placeholder = DateFormatters.DDMMYYYYAllCapsFormat
            
        }
        dobLbl.textColor = UIColor.gray
        animalId1 = 0
        idAnimal = 0
        isUpdate = false
        msgUpatedd = false
        self.msgcheckk = false
        barAutoPopu = false
        self.isautoPopulated = false
        dateBttnOutlet.setTitleColor(UIColor.gray, for: .normal)
        breedBtnOutlet.setTitleColor(UIColor.gray, for: .normal)
        dateBttnOutlet.setTitle( "", for: .normal)
        dateTextField.text = ""
        scanEarTagTextField.text?.removeAll()
        scanBarcodeTextfield.text?.removeAll()
        damRegTextfield.text?.removeAll()
        sireRegTextfield.text?.removeAll()
        breedRegTextfield.text?.removeAll()
        girlandoNoTextField.text?.removeAll()
        animalNameTextfield.text?.removeAll()
        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
            dateTextField.isHidden = false
            dobLbl.isHidden = true
        } else {
            dateTextField.isHidden = true
            dobLbl.isHidden = false
        }
        etBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        singleBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        multipleBirthBttn.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
    
        etBttn.isEnabled = false
        singleBttn.isEnabled = false
        multipleBirthBttn.isEnabled = false
        
        if UserDefaults.standard.value(forKey: "GirlandoGender") as? String == "F" || UserDefaults.standard.value(forKey: "GirlandoGender") == nil {
            male_femaleBttnOutlet.setTitle("Female", for: .normal)
            genderString = NSLocalizedString("Female", comment: "")
            genderToggleFlag = 0
            UserDefaults.standard.set("F", forKey: "GirlandoGender")
        } else {
            UserDefaults.standard.set("M", forKey: "GirlandoGender")
            male_femaleBttnOutlet.setTitle("Male", for: .normal)
            genderString = NSLocalizedString("Male", comment: "")
            genderToggleFlag = 1
        }
        
        
        breedRegBttn.setTitle(NSLocalizedString(LocalizedStrings.girolandoAssociationStr, comment:  "") , for: .normal)
     
        if UserDefaults.standard.bool(forKey: keyValue.isBarCodeIncremental.rawValue) != true {
            textFieldBackroungGrey()
        }
        self.scrolView.contentOffset.y = 0.0
        if UserDefaults.standard.string(forKey: keyValue.girlandoSampleType.rawValue) == nil || UserDefaults.standard.string(forKey: keyValue.girlandoSampleType.rawValue) == ""{
            let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
            self.tissueArr = fetchproviderData(entityName: Entities.getSampleTblEntity, provId: pvid)
            for items in self.tissueArr{
                let tissue = items  as? GetSampleTbl
                let checkdefault  = tissue?.isDefault
                
                if checkdefault == true{
                    self.tissueBttnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
                    self.tissuId = 4
                    UserDefaults.standard.set(tissue?.sampleName, forKey: keyValue.girlandoSampleType.rawValue)
                    self.tissuId =  Int(tissue?.sampleId ?? 4)
                    if tissue?.sampleName == LocalizedStrings.hairString.localized{
                        tissueBttnOutlet.setTitle(NSLocalizedString(LocalizedStrings.hairString.localized, comment: ""), for: .normal)
                    }
                }
            }
        }
        else{
            tissueBttnOutlet.setTitle(UserDefaults.standard.string(forKey: keyValue.girlandoSampleType.rawValue)?.localized, for: .normal)
        }
        
        if breedId  == "" {
            breedBtnOutlet.setTitle(ButtonTitles.girolandoText, for: .normal)
            let inheritBreed = fetchAllDataProductBeefIdNz(entityName: Entities.getBreedsTblEntity, breedName: (breedBtnOutlet.titleLabel?.text)!, pvid: 4)
            if inheritBreed.count != 0 {
                let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                breedId = medbreedRegArr1!.breedId ?? ""
                UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                breedBtnOutlet.setTitle(medbreedRegArr1?.alpha2 ?? medbreedRegArr1?.breedName, for: .normal)
            }
        } else {
            UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
            let inheritBreed = fetchAllDataProductGirlandoBreedID(entityName: Entities.getBreedsTblEntity,breedId:breedId,pvid:4)
            if inheritBreed.count != 0 {
                let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                breedId = medbreedRegArr1!.breedId ?? ""
                UserDefaults.standard.set(breedId, forKey: keyValue.breed.rawValue)
                breedBtnOutlet.setTitle(medbreedRegArr1?.alpha2 ?? medbreedRegArr1?.breedName, for: .normal)
            }
        }
        incrementalBarcodeTitleLabel.textColor = .gray
        incrementalBarcodeButton.isEnabled = false
        dateTextField.text = ""
        dateBttnOutlet.titleLabel?.text = ""
        if !changeColorToRed {
            self.scanBarcodeTextfield.becomeFirstResponder()
        }
        
    }
}
