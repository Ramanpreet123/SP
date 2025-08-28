//
//  ADHAnimalVCExtension.swift
//  SearchPoint
//
//  Created by Mobile Programming on 07/03/24.
//

import Foundation
import UIKit
import CoreBluetooth

//MARK: FILTER INFO UPDATE EXTENSION
extension ADHAnimalVC :filterInfoUpdate{
    func breedInfoUpdate(index: Int) {
        // This method is intentionally left empty.
        // It will be implemented in the future to handle navigation logic.
    }
    
    func dateInfoUpdate(date: String) {
        // This method is intentionally left empty.
        // It will be implemented in the future to handle navigation logic.
    }
    
    func cancelPressed() {
        print("CancelPressed")
    }
    
    func providerInfoUpdate(index: Int) {
        print("Provider info Update")
    }
    
    func genderInfoUpdate(sex: String, providerIndexPath: Int, breedIndexPath: Int, fromdatevalue: String, todatevalue: String, header: String, trait: String) {
        // This method is intentionally left empty.
        // It will be implemented in the future to handle navigation logic.
    }
    
    func reloaddata() {
        fetchFilterData = fetchResultFilterData(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: Int(customerId ))
        fetchTempObj1new = fetchAllData(entityName: Entities.resultPageByTraitTblEntity)
        if fetchFilterData.count != 0{
            for items in fetchFilterData{
                let newfetch = items as? ResultFIlterDataSave
                ranktitle = newfetch?.traidsave
            }
        }
        
        self.hideIndicator()
        self.hideIndicator()
        self.hideIndicator()
        self.hideIndicator()
        myHerdArray   = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:Int64(customerId)) as! [ResultMyHerdData]
        tblView.isHidden = false
        totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: self.myHerdArray.count)
        
        if myHerdArray.count == 0{
            message.isHidden = false
            tblView.isHidden = true
        }
        
        if myHerdArray.count != 0 {
            message.isHidden = true
            tblView.isHidden = false
            datasource.removeAll()
            for i in 0...myHerdArray.count - 1{
                let ab = callSwipeStruct(name: [myHerdArray[i]], color: .white, image: UIImage(named:ImageNames.threeDotsInactiveImg)!, backgroundGroup: UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0))
                datasource.append(ab)
            }
        }
        tblView.reloadData()
        tblView.delegate = self
        tblView.dataSource = self
    }
    
    func loadMoreData() {
        myHerdArray.append(contentsOf: myHerdArray)
        self.myHerdArray = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:Int64(self.customerId) ) as! [ResultMyHerdData]
        totalAnimalCount.text = "Total Animals : \(myHerdArray.count)"
        self.tblView.reloadData()
    }
}

//MARK: TABLEVIEW DATASOURCE AND DELEGATE
extension ADHAnimalVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == myTableView{
            return adhAnimalModel.count
        }
        
        if tableView == pairedTableView {
            return arrNearbyDevice.count
        } else {
            if searchFound {
                return self.viewModel.filterAdhAnimalData.count
            }
            return self.viewModel.adhAnimalData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == myTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.minimumScaleFactor = 0.1
            cell.textLabel?.font = UIFont.systemFont(ofSize: 11.0)
            
            return cell
        }
        
        if tableView == pairedTableView {
            let cell = pairedTableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! PairedDeviceCell
            var deviceName = arrNearbyDevice[indexPath.row].name
            if deviceName == nil {
                deviceName = String(describing: arrNearbyDevice[indexPath.row].identifier)
            }
            
            cell.deviceLbl?.text = deviceName
            let state = arrNearbyDevice[indexPath.row].state
            if state == .connected{
                cell.accessoryType = .checkmark
            }
            else {
                cell.accessoryType = .none
            }
            return cell
        }
        
        let cell: ADHListCell = self.tblView.dequeueReusableCell(withIdentifier: ClassIdentifiers.adhListCellId, for: indexPath) as! ADHListCell
        cell.scanBarCodeTextField.delegate = cell
        if searchFound {
            cell.data = self.viewModel.filterAdhAnimalData[indexPath.row]
            guard let animalData = self.viewModel.filterAdhAnimalData[indexPath.row] as? AnimalMaster else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.setAnimalData(animalData: animalData, index: indexPath.row)
        } else {
            cell.data = self.viewModel.adhAnimalData[indexPath.row]
            guard let animalData = self.viewModel.adhAnimalData[indexPath.row] as? AnimalMaster else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.setAnimalData(animalData: animalData, index: indexPath.row)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let isSearching = searchFound
        let selectedItem = isSearching ? viewModel.filterAdhAnimalData[indexPath.row] : viewModel.adhAnimalData[indexPath.row]

        if selectedItem.animalbarCodeTag?.isEmpty ?? true {
            toggleTextFields(for: indexPath.row, isSearchResult: isSearching)
        } else {
            updateAnimalBarcode(for: indexPath.row, isSearchResult: isSearching)
            showTotalCount()
        }

        tblView.reloadData()
    }
    
    private func toggleTextFields(for selectedIndex: Int, isSearchResult: Bool) {
        if isSearchResult {
            for index in viewModel.filterAdhAnimalData.indices {
                viewModel.filterAdhAnimalData[index].showTextField =
                    index == selectedIndex && !viewModel.filterAdhAnimalData[index].showTextField
            }
        } else {
            for index in viewModel.adhAnimalData.indices {
                viewModel.adhAnimalData[index].showTextField =
                    index == selectedIndex && !viewModel.adhAnimalData[index].showTextField
            }
        }
    }

    private func updateAnimalBarcode(for index: Int, isSearchResult: Bool) {
        let data = isSearchResult ? viewModel.filterAdhAnimalData[index] : viewModel.adhAnimalData[index]
        let pvID = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)

        updateADhAnimalBarcode(
            entity: Entities.animalMasterTblEntity,
            officialID: data.animalTag ?? "",
            barCode: data.animalbarCodeTag ?? "",
            pvID: pvID,
            isADHSelected: !data.isADHSelected
        )
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

//MARK: OFFLINE CUSTOMVIEW EXTENSION
extension ADHAnimalVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

//MARK: SIDE MENU UI, RFID AND NEARBY DEVICE EXTENSION
extension ADHAnimalVC : SideMenuUI,RFID,nearByDevice{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
    
    func deviceNear(deviceName : [CBPeripheral]){
        arrNearbyDevice = deviceName
    }
    
    func rfidCode(rfid: String) {
        if UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String != keyValue.ocrKey.rawValue {
            self.searchTextField.text?.removeAll()
            if self.searchTextField.isEnabled {
                self.searchTextField.text = self.searchTextField.text!.trimmingCharacters(in: CharacterSet.whitespaces)
            }
        }
    }
    
    func timeStamp() -> String {
        let autoD = fetchFromAutoIncrement()
        let time1 = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatters.MMddyyyyHHmmssFormat
        let timestamp = formatter.string(from: time1 as Date)
            .replacingOccurrences(of: "-", with: "", options: .regularExpression)
            .replacingOccurrences(of: ":", with: "", options: .regularExpression)
        
        let udid = UserDefaults.standard.value(forKey: keyValue.applicationIdentifier.rawValue)! as! String
        let sessionGUID = "\(timestamp)_\(autoD)_iOS_\(udid)"
        
        return sessionGUID
    }
}

//MARK: ADH CELL PROTOCOL AND ADH FILTER PROTOCOL EXTENSION
extension ADHAnimalVC: ADHFilterProtocol, ADHCellProtocol {
    func openCamForBarCodeScan(_ cell: ADHListCell) {
        if let indexPath = tblView?.indexPath(for: cell)  {
            self.cellIndexForScanner = indexPath
            barcodeScreen = true
            let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.cameraViewControllerVC) as? CameraViewController
            vc?.delegate = self
            self.present(vc!, animated: true, completion: nil)
        }
    }
    
    func applyFilterData(fromDate: String, toDate: String, gender: String, breed: String) {
        self.isADHFilterApplied = true
        filterToDate = toDate
        filterFromDate = fromDate
        filterGender = gender
        filterBreedId = breed
        self.viewModel.fetchFilteredADHAnimalList(userId: self.userId!, customerID: Int(self.customerId), fromDate: fromDate, toDate: toDate, gender: gender, breedID: filterBreedId ?? "")
        showTotalCount()
    }
    
    func barCodeEntered(_ animalData: AnimalMaster) {
        self.tblView.reloadData()
    }
    
    func textField(editingDidBeginIn cell: ADHListCell) {
        // Intentionally left empty.
        // This delegate method is required by the protocol,
        // but we don’t need custom behavior here (for now).
    }
    
    func textField(editingChangedInTextField newText: String, in cell: ADHListCell) {
        // Intentionally left empty.
        // This delegate method is required by the protocol,
        // but we don’t need custom behavior here (for now).
    }
    
    func textFieldEndedEditing(finalText barCode: String, in cell: ADHListCell) {
        if searchFound {
            if let indexPath = tblView?.indexPath(for: cell) {
                let coreDataModel = self.viewModel.filterAdhAnimalData[indexPath.row]
                if barCode == "" {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseEnterBarcode, comment: ""))
                    return
                }
                
                let filteredArr = self.viewModel.filterAdhAnimalData.filter { $0.animalbarCodeTag == barCode }
                _ = self.viewModel.fetchCartAnimals()
                let cartAnimalFiltered = self.viewModel.cartAnimals.filter { $0.animalbarCodeTag == barCode }
                if filteredArr.count > 0 {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.duplicateBarCodeEntry, comment: ""))
                    return
                } else  {
                    if cartAnimalFiltered.count > 0 {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sampleBarcodeAlreadyExists, comment: ""))
                        return
                    }
                }
                let pvID =  UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue)
                updateADhAnimalBarcode(entity: Entities.animalMasterTblEntity, officialID: coreDataModel.animalTag!, barCode: barCode, pvID: pvID , isADHSelected: true)
                if isADHFilterApplied ?? false {
                    self.viewModel.fetchFilteredADHAnimalList(userId: self.userId!, customerID: Int(self.customerId), fromDate: self.filterFromDate ?? "", toDate: self.filterToDate ?? "", gender: filterGender ?? "", breedID: filterBreedId ?? "")
                } else {
                    fetchADHAnimalData()
                }
                showTotalCount()
                DispatchQueue.main.async {
                    cell.scanBarCodeTextField.text = ""
                    self.tblView.reloadData()
                }
            }
        }
        else {
            if let indexPath = tblView?.indexPath(for: cell) {
                let coreDataModel = self.viewModel.adhAnimalData[indexPath.row]
                if barCode == "" {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.pleaseEnterBarcode, comment: ""))
                    return
                }
                
                let filteredArr = self.viewModel.adhAnimalData.filter { $0.animalbarCodeTag == barCode }
                _ = self.viewModel.fetchCartAnimals()
                let cartAnimalFiltered = self.viewModel.cartAnimals.filter { $0.animalbarCodeTag == barCode }
                
                if filteredArr.count > 0 {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.duplicateBarCodeEntry, comment: ""))
                    return
                } else  {
                    if cartAnimalFiltered.count > 0 {
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sampleBarcodeAlreadyExists, comment: ""))
                        return
                    }
                }
                let pvID =  UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue)
                updateADhAnimalBarcode(entity: Entities.animalMasterTblEntity, officialID: coreDataModel.animalTag!, barCode: barCode, pvID: pvID , isADHSelected: true)
                if isADHFilterApplied ?? false {
                    self.viewModel.fetchFilteredADHAnimalList(userId: self.userId!, customerID: Int(self.customerId), fromDate: self.filterFromDate ?? "", toDate: self.filterToDate ?? "", gender: self.filterGender ?? "", breedID: filterBreedId ?? "")
                } else {
                    fetchADHAnimalData()
                }
                showTotalCount()
                DispatchQueue.main.async {
                    cell.scanBarCodeTextField.text = ""
                    self.tblView.reloadData()
                }
            }
        }
    }
}

//MARK: QR SCANNER PROTOCOL EXTENSION
extension ADHAnimalVC: QrScannerProtocol {
    func qrCodeScannedResult(_ qrValue: String) {
        guard let cell  = tblView.cellForRow(at: cellIndexForScanner!) as? ADHListCell else {
            return
        }
        
        if searchFound {
            guard self.viewModel.filterAdhAnimalData[cellIndexForScanner?.row ?? 0] is AnimalMaster else {
                
            }
            if (tblView?.indexPath(for: cell)) != nil {
                cell.scanBarCodeTextField.text = qrValue
                cell.scanBarCodeTextField.becomeFirstResponder()
            }
        } else  {
            guard self.viewModel.adhAnimalData[cellIndexForScanner?.row ?? 0] is AnimalMaster else {
                
            }
            if (tblView?.indexPath(for: cell)) != nil {
                cell.scanBarCodeTextField.text = qrValue
                cell.scanBarCodeTextField.becomeFirstResponder()
            }
        }
    }
}

//MARK: SCANNED OCR PROTOCOL EXTENSION
extension ADHAnimalVC: scannedOCRProtocol {
    func ocrDetected(_ scannedResult: String) {
        // Intentionally left empty.
        // This delegate method is required by the protocol,
        // but we don’t need custom behavior here (for now).
    }
}

//MARK: FETCH AND CREATE DATA LIST
private typealias DataListCartHelper = ADHAnimalVC
extension DataListCartHelper {
    func fetchDatalistDetailbyName(listName: String) -> [DataEntryList] {
        let fetchDataEntry : [DataEntryList] = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.customerId),listName:listName ,productName:marketNameType.Dairy.rawValue) as! [DataEntryList]
        return fetchDataEntry
    }
    
    func checkCartanimalCount() {
        let viewAnimalArray =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId ?? 1,orderId:1,orderStatus:"false", providerId: self.pvid )
        if viewAnimalArray.count > 0{
            createDataList()
        }
    }
    
    func createDataList(){
        let listName = orderingDataListViewModel.makeListName(custmerId: Int(self.customerId ),providerID: pvid )
        if listName != "" {
            var animalID1 = UserDefaults.standard.integer(forKey: keyValue.listId.rawValue)
            animalID1 = animalID1 + 1
            UserDefaults.standard.set(animalID1, forKey: keyValue.listId.rawValue)
            
            self.hideIndicator()
            if self.pvid == 1 || self.pvid == 2 || self.pvid == 3 || self.pvid == 4 || self.pvid == 8 || self.pvid == 10 || self.pvid == 11 || self.pvid == 12{
                let fetchDatEntry = fetchDatalistDetailbyName(listName: listName)
                
                if fetchDatEntry.count == 0 {
                    let nominatorStr = UserDefaults.standard.value(forKey: keyValue.nominatorSave.rawValue) as? String
                    if  nominatorStr == keyValue.zoetis.rawValue{
                        saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(self.customerId ),listDesc: "1",listId: Int64(animalID1),listName: listName ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: self.pvid , productType: "", productName: marketNameType.Dairy.rawValue)
                    } else {
                        saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(self.customerId ),listDesc: "2",listId: Int64(animalID1),listName: listName ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: self.pvid , productType: "", productName: marketNameType.Dairy.rawValue)
                    }
                    
                    let animalData  = fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId ?? 1,orderId:1,orderStatus:"false", providerId: self.pvid ) as! [AnimaladdTbl]
                    for animalDetail in animalData {
                        let fetchDataUpdate = checkAnimalDataAccOfficalFarmid_ListID(entityName: Entities.dataEntryAnimalAddTbl,farmId:animalDetail.farmId ?? "",anmalTag:animalDetail.animalTag ?? "",custmerId :Int(customerId ), listId: animalID1,providerID: pvid )
                        if fetchDataUpdate.count == 0 {
                            saveAnimalinDataOrderingAnimal(listID: Int64(animalID1), animalDetails: animalDetail, animalID:animalID1)
                        }
                    }
                }
                else {
                    let listId = fetchDatEntry[0].listId
                    let animalData  = fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId ?? 1,orderId:1,orderStatus:"false", providerId: self.pvid )  as! [AnimaladdTbl]
                    for animalDetail in animalData {
                        let fetchDataUpdate = checkAnimalDataAccOfficalFarmid_ListID(entityName: Entities.dataEntryAnimalAddTbl,farmId:animalDetail.farmId ?? "",anmalTag:animalDetail.animalTag ?? "",custmerId :Int(customerId ), listId: Int(listId),providerID: pvid )
                        
                        if fetchDataUpdate.count == 0 {
                            saveAnimalinDataOrderingAnimal(listID: Int64(listId), animalDetails: animalDetail, animalID:animalID1)
                        }
                    }
                }
            }
        }
    }
    
    func saveAnimalinDataOrderingAnimal(listID:Int64, animalDetails:AnimaladdTbl,animalID:Int) {
        saveAnimaldata(entity: Entities.dataEntryAnimalAddTbl,
                       animalTag: animalDetails.animalTag ?? "",
                       barCodetag: animalDetails.animalbarCodeTag ?? "",
                       date: animalDetails.date ?? "" ,
                       damId: animalDetails.offDamId ?? "",
                       sireId: animalDetails.offsireId ?? "" ,
                       gender: animalDetails.gender ?? "Female",
                       update: "false",
                       permanentId:animalDetails.offPermanentId ?? "",
                       tissuName: animalDetails.tissuName ?? "",
                       breedName: animalDetails.breedName ?? "",
                       et: animalDetails.eT ?? "",
                       farmId:animalDetails.farmId ?? "",
                       orderId: 1,
                       orderSataus:"false",
                       breedId:animalDetails.breedId ?? "",
                       isSync:"false",
                       providerId: pvid ,
                       tissuId: Int(animalDetails.tissuId ),
                       sireIDAU:animalDetails.sireIDAU ?? "",
                       nationHerdAU:animalDetails.nationHerdAU ?? "",
                       userId: userId ?? 1,
                       udid:timeStampString,
                       animalId: animalID,
                       selectedBornTypeId: -1,
                       custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),
                       specisId: SpeciesID.dairySpeciesId,
                       earTag: "",
                       isSyncServer:false,
                       adhDataServer: false,
                       listId:listID,
                       editFlagSave: false,
                       serverAnimalId: "")
    }
}

//MARK: TEXTFIELD DELEGATE
extension ADHAnimalVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isEmpty else {
            return true
        }
        let currentString: NSString = searchTextField.text! as NSString
        let newString: String =
        (currentString.replacingCharacters(in: range, with: string) as NSString) as String
        self.searchForADHAnimal(seachText: newString)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        if(textField.text == ""){
            searchFound = false
            showTotalCount()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.text == ""){
            searchFound = false
            showTotalCount()
        }
        textField.resignFirstResponder()
        return true
    }
}

//MARK: OBJECT PICK CART SCREEN EXTENSION
extension ADHAnimalVC : objectPickCartScreen {
    func objectGetOnSelection(temp: Int) {
        // Intentionally left empty.
        // This delegate method is required by the protocol,
        // but we don’t need custom behavior here (for now).
    }
}

//MARK: IMAGE PICKER CONTROLLER DELEGATE
extension ADHAnimalVC : UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true, completion: nil)
        self.searchTextField.text = ""
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        self.imageView.image = image
        setVisionTextRecognizeImage(image: image)
    }
    
}
