//
//  GroupDetailVCExtension.swift
//  SearchPoint
//
//  Created by Mobile Programming on 29/02/24.
//

import Foundation
import UIKit
import CoreBluetooth

//MARK: TABLEVIEW DATASOURCE AND DELEGATE
extension GroupDetailsViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == pairedTableView {
            return arrNearbyDevice.count
        }
        else {
            return myHerdArray.count
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == pairedTableView {
            let cell = pairedTableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.pairedDeviceCellId, for: indexPath) as! PairedDeviceCell
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
        
        let cell: MyHerdTblCell = self.tblView.dequeueReusableCell(withIdentifier: "cell") as! MyHerdTblCell
        let myArray = self.myHerdArray[indexPath.row]
        cell.delegate = self
        cell.tag =  indexPath.row
        let dob = myArray.dob ?? ""
        let dateonly = dob.components(separatedBy: " ")
        cell.dobLabel.text = dateonly[0]
        if fetchFilterData.count != 0 {
            for items in fetchFilterData{
                let newfetch = items as? ResultFIlterDataSave
                checkid = newfetch?.idselection ?? ""
            }
        }
        
        if checkid == LocalizedStrings.officialCheckId{
            cell.tableviewstackview.distribution = .equalSpacing
            self.officalIdLabel.text = LocalizedStrings.officialIDText.localized
            cell.officialIdLabel.text = myArray.officalId ?? ""
        }
        else{
            cell.tableviewstackview.distribution = .fillEqually
            self.officalIdLabel.text = LocalizedStrings.onFarmIdText.localized
            cell.officialIdLabel.text = myArray.onFarmId ?? ""
        }
        
        let fetchTempObj1new = fetchAllData(entityName: Entities.resultPageByTraitTblEntity)
        for items in fetchTempObj1new{
            let dwscall = items as? ResultPageByTrait
            let name = dwscall?.trait
            let traidid = dwscall?.traitId
            
            if fetchFilterData.count != 0{
                for items in fetchFilterData{
                    let newfetch = items as? ResultFIlterDataSave
                    let traidstting = newfetch?.trait ?? ""
                    if name == traidstting{
                        rankid = traidid ?? ""
                    }
                }
            }
        }
        
        let fetchTempObj1 = fetchResultTraitIdPageApi(entityName: Entities.resultPageByTraitTblEntity,traitId: rankid, onFarmId: myArray.onFarmId ?? "",officalId: myArray.officalId ?? "")
        
        if fetchTempObj1.count != 0 && rankid  != "" {
            let rankvalue = fetchTempObj1.object(at: 0) as? ResultPageByTrait
            let rankgetvalue = rankvalue?.numericFormat
            if checkid == LocalizedStrings.officialCheckId{
                if rankgetvalue == ""{
                    let rankstring = rankvalue?.stringValue
                    cell.rankLabel.text = "  \(rankstring ?? "")"
                }
                else{
                    cell.rankLabel.text = "  \(rankgetvalue ?? "")"
                }
            }
            else{
                if rankgetvalue == ""{
                    let rankstring = rankvalue?.stringValue
                    cell.rankLabel.text = "     \(rankstring ?? "")"
                }
                else{
                    cell.rankLabel.text = "     \(rankgetvalue ?? "")"
                }
            }
        }
        else {
            cell.rankLabel.text = "     0.0"
        }
        
        cell.index = indexPath.row
        if self.myHerdArray.count == datasource.count{
            let imag = datasource[indexPath.row]
            let checksatus = myArray.groupStatusId
            let typecheck = myArray.groupTypeId
            if checksatus == 0{
                cell.groupView.layer.backgroundColor  = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0).cgColor
                cell.groupImage.image = UIImage(named: ImageNames.threeDotsInactiveImg)!
            }
            else{
                if typecheck == 0{
                    cell.groupView.layer.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0).cgColor
                    cell.groupImage.image = UIImage(named: ImageNames.dollarActiveImg)!
                    
                }
                else if typecheck == 1{
                    cell.groupView.layer.backgroundColor  = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0).cgColor
                    cell.groupImage.image = UIImage(named: ImageNames.barnActiveImg)!
                }
                cell.groupImage.image = imag.image
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == pairedTableView{
            if BluetoothCentre.shared.smartBowPeripheral != nil {
                BluetoothCentre.shared.manager.cancelPeripheralConnection(BluetoothCentre.shared.smartBowPeripheral!)
            }
            BluetoothCentre.shared.ConnectArgument(peripheral: arrNearbyDevice[indexPath.row])
            pairedBackroundView.isHidden = true
            pairedDeviceView.isHidden = true
            pairedTableView.reloadData()
            return
        }
        let onformid = myHerdArray[indexPath.row].onFarmId
        let officalid = myHerdArray[indexPath.row].officalId
        let groupstatus = myHerdArray[indexPath.row].groupStatus
        let grouptypename = myHerdArray[indexPath.row].groupTypeName
        let animalidgroup = myHerdArray[indexPath.row].animalID
        selectedMyHerdArray = self.myHerdArray[indexPath.row]
        selectedIndex = indexPath.row
        if searchByAnimal {
            GetProviderName(animalID: animalidgroup ?? "", onfarmID: onformid ?? "", officialID: officalid ?? "", customerId: customerId ?? 0)
        }else {
            let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.individualAnimalResultControllerVC) as? IndividualAnimalResultController
            vc?.checkCOntroller = "Group"
            UserDefaults.standard.set(false, forKey: keyValue.searchByAnimal.rawValue)
            vc?.newbackscreenindex = indexPath.row
            vc?.groupanimalarray = myHerdArray
            vc?.navigateFromGroupDetailScreen = true
            vc?.groupNameExist = groupName
            UserDefaults.standard.set(indexPath.row, forKey: keyValue.newBackScreenIndex.rawValue)
            UserDefaults.standard.set(officalid, forKey: keyValue.myHerdOfficalid.rawValue)
            UserDefaults.standard.set(onformid, forKey: keyValue.myHerdOnfarmId.rawValue)
            UserDefaults.standard.set(animalidgroup, forKey: keyValue.groupOnAnimalId.rawValue)
            UserDefaults.standard.set(groupName, forKey: keyValue.groupNameSave.rawValue)
            UserDefaults.standard.set(groupstatus, forKey: keyValue.groupStatus.rawValue)
            UserDefaults.standard.set(grouptypename, forKey: keyValue.groupTypeId.rawValue)
            UserDefaults.standard.set(keyValue.groupName.rawValue, forKey: keyValue.groupDetails.rawValue)
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

//MARK: OFFLINE CUSTOM VIEW EXTENSION
extension GroupDetailsViewController:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

//MARK: TEXTFIELD DELEGATES
extension GroupDetailsViewController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let currentString: NSString = searchTextField.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        
        if newString != "" {
            myHerdArray = fetchOrdersWithMyGroupFilteranimals(entityName: Entities.resultGroupAnimalsTblEntity, searchText: (newString.uppercased) as String,customerId:customerId ?? 0, groupName: groupName ) as! [ResultGroupsAnimals]
            if myHerdArray.count > 0 {
                message.isHidden = true
                tblView.isHidden = false
                tblView.reloadData()
            }
            
            if myHerdArray.count == 0{
                message.isHidden = false
                tblView.isHidden = true
                tblView.reloadData()
            }
        }
        else {
            message.isHidden = true
            tblView.isHidden = false
            myHerdArray = fetchOrdersWithMyGroupFilteranimals(entityName: Entities.resultGroupAnimalsTblEntity, searchText: (newString.uppercased) as String,customerId:customerId ?? 0, groupName: groupName) as! [ResultGroupsAnimals]
            if myHerdArray.count != 0
            {
                myHerdArray = fetchGroupInfoResult(entityName: Entities.resultGroupAnimalsTblEntity,groupName: groupName,customerId:self.customerId ?? 0) as! [ResultGroupsAnimals]
            }
            tblView.reloadData()
        }
        return true
    }
    func textFieldDidEndEditing(textField: UITextField){
        if searchTextField.tag == 1{
            let newString: NSString = searchTextField.text! as NSString
            if newString != "" {
                myHerdArray = fetchOrdersWithMyGroupFilteranimals(entityName: Entities.resultGroupAnimalsTblEntity, searchText: (newString.uppercased) as String,customerId:customerId ?? 0, groupName: groupName ) as! [ResultGroupsAnimals]
                
                if myHerdArray.count > 0 {
                    message.isHidden = true
                    tblView.isHidden = false
                    tblView.reloadData()
                }
                
                if myHerdArray.count == 0{
                    message.isHidden = false
                    tblView.isHidden = true
                    tblView.reloadData()
                }
            }
            else {
                message.isHidden = true
                tblView.isHidden = false
                myHerdArray = fetchOrdersWithMyGroupFilteranimals(entityName: Entities.resultGroupAnimalsTblEntity, searchText: (newString.uppercased) as String,customerId:customerId ?? 0, groupName: groupName) as! [ResultGroupsAnimals]
                if myHerdArray.count != 0
                {
                    myHerdArray = fetchGroupInfoResult(entityName: Entities.resultGroupAnimalsTblEntity,groupName: groupName,customerId:self.customerId ?? 0) as! [ResultGroupsAnimals]
                }
                tblView.reloadData()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        textField.resignFirstResponder()
        return true
    }
}

//MARK: SCANNED OCR PROTOCOL
extension GroupDetailsViewController: scannedOCRProtocol {
    func ocrDetected(_ scannedResult: String) {
        print(scannedResult)
    }
}

//MARK: GET PROVIDER NAME EXTENSION
extension GroupDetailsViewController {
    func GetProviderName(animalID: String, onfarmID:String,officialID:String,customerId: Int64 ) {
        var isUniqueCdcbTrait = Bool()
        var isUniqueDatageneTrait = Bool()
        var isUniqueHeridityTrait = Bool()
        let animalTraitItems = fetchResultRank(entityName: Entities.resultPageByTraitTblEntity, onFarmId: onfarmID, officalId: officialID, customerId: customerId) as! [ResultPageByTrait]
        
        let filterTraitCDCB =  animalTraitItems.filter{ $0.trait == "NM$"}
        let filterTraitDateGene =  animalTraitItems.filter{ $0.trait == "BalancedPerformanceIndex"}
        let filterTraitHerdity =  animalTraitItems.filter{ $0.trait == "MHP"}
        
        if filterTraitCDCB.count > 0 {
            isUniqueCdcbTrait = true
            
        }
        if filterTraitDateGene.count > 0 {
            isUniqueDatageneTrait = true
            
        }
        if filterTraitHerdity.count > 0{
            isUniqueHeridityTrait = true
            
        }
        if (filterTraitCDCB.count == 0 && filterTraitDateGene.count == 0 && filterTraitHerdity.count == 0){
            isUniqueCdcbTrait = true
        }
        
        if (isUniqueDatageneTrait && isUniqueCdcbTrait && isUniqueHeridityTrait)
        {
            navigatetoProviderSelection(showCDCB: isUniqueCdcbTrait, showDatagene: isUniqueDatageneTrait, showHerdity: isUniqueHeridityTrait, showViewCount: 3)
            return
        }
        else if (isUniqueHeridityTrait && isUniqueDatageneTrait && !isUniqueCdcbTrait)
        {
            navigatetoProviderSelection(showCDCB: isUniqueCdcbTrait, showDatagene: isUniqueDatageneTrait, showHerdity: isUniqueHeridityTrait, showViewCount: 2)
            return
        }
        else if (isUniqueHeridityTrait && isUniqueCdcbTrait && !isUniqueDatageneTrait)
        {
            navigatetoProviderSelection(showCDCB: isUniqueCdcbTrait, showDatagene: isUniqueDatageneTrait, showHerdity: isUniqueHeridityTrait, showViewCount: 2)
            return
        }
        else if (isUniqueDatageneTrait && isUniqueCdcbTrait && !isUniqueHeridityTrait)
        {
            navigatetoProviderSelection(showCDCB: isUniqueCdcbTrait, showDatagene: isUniqueDatageneTrait, showHerdity: isUniqueHeridityTrait, showViewCount: 2)
            return
        }
        
        else if (isUniqueCdcbTrait && !isUniqueDatageneTrait && !isUniqueHeridityTrait)
        {
            self.navigateToIndividualController(productNameStr: LocalizedStrings.clarifideCDCB)
            
            UserDefaults.standard.set(LocalizedStrings.clarifideCDCB, forKey: keyValue.selectedProviderName.rawValue)
            return
        }
        else  if (isUniqueDatageneTrait && !isUniqueCdcbTrait && !isUniqueHeridityTrait)
        {
            self.navigateToIndividualController(productNameStr: LocalizedStrings.clarifideDataGene)
            UserDefaults.standard.set(LocalizedStrings.clarifideDataGene, forKey: keyValue.selectedProviderName.rawValue)
            return
        }
        else if (isUniqueHeridityTrait && !isUniqueDatageneTrait && !isUniqueCdcbTrait)
        {
            self.navigateToIndividualController(productNameStr: LocalizedStrings.herdity)
            UserDefaults.standard.set(LocalizedStrings.herdity, forKey: keyValue.selectedProviderName.rawValue)
            return
        }
    }
}

//MARK: CHOOSE PROVIDER DELEGATE
extension GroupDetailsViewController : chosseProviderDelegate {
    func selectedProviderIndex(providerName: String) {
        UserDefaults.standard.set(providerName, forKey: keyValue.selectedProviderName.rawValue)
        self.navigateToIndividualController(productNameStr: providerName)
    }
}

//MARK: SIDE MENU UI AND RFID SCANNER
extension GroupDetailsViewController : SideMenuUI, RFID, nearByDevice {
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
    
    func deviceNear(deviceName : [CBPeripheral]){
        arrNearbyDevice = deviceName
    }
    
    func rfidCode(rfid: String) {
        if UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String != keyValue.ocrKey.rawValue {
            self.searchTextField.text?.removeAll()
            if self.searchTextField.isEnabled == true {
                self.searchTextField.text = self.searchTextField.text!.trimmingCharacters(in: CharacterSet.whitespaces)
            }
        }
    }
}

//MARK: SWIPE CELL EXTENSION
extension GroupDetailsViewController : swipeCell {
    func swipeLeft(index: Int) {
        NotificationCenter.default.addObserver(self, selector: #selector(notificationRecevied(notification:)), name: NSNotification.Name(rawValue: LocalizedStrings.animationEndNoti), object: nil)
        datasource.remove(at: index)
        let dataObject = self.myHerdArray[index]
        let sid = dataObject.serverGroupId ?? ""
        let animalId = dataObject.animalID ?? ""
        let gStaus = dataObject.groupStatus ?? ""
        if gStaus == LocalizedStrings.capsInactiveStatus || gStaus == "Unknown"{
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.noActiveBarn, comment: "") )
            return
        }
        
        else {
            let ban =  fetchGroupIdFethSatusG(entityName: Entities.resultGroupCreateTblEntity, customerId: self.customerId ?? 0, groupStatusId: 1, groupTypeId: 1)
            if ban.count > 0 {
                let gruupCreate = ban.object(at: 0) as? ResultGroupCreate
                let groupName = gruupCreate?.groupName  ?? ""
                let groupTypeName = gruupCreate?.groupTypeName  ?? ""
                let groupServerId =  gruupCreate?.groupServerId ?? ""
                let groupStatusId = gruupCreate?.groupStatusId  ?? 0
                let groupStatus = gruupCreate?.groupStatus  ?? ""
                let dollar =  fetchGroupIdFethSatusG(entityName: Entities.resultGroupCreateTblEntity, customerId: self.customerId ?? 0, groupStatusId: 1, groupTypeId: 0)
                    if dollar.count > 0 {
                    let gruupCreate1 = dollar.object(at: 0) as? ResultGroupCreate
                    let groupName1 = gruupCreate1?.groupName  ?? ""
                    
                    if  dataObject.groupTypeName != LocalizedStrings.barnGroupType {
                        self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                        _ = deletGroupInfoResultGroupDetail(entityName: Entities.resultGroupAnimalsTblEntity, groupName: groupName1, customerId: self.customerId ?? 0, onFarmId: dataObject.onFarmId ?? "", officalId: dataObject.officalId ?? "")
                        let checkanimal = fetchanimalExistInDataBase(entityName: Entities.resultGroupAnimalsTblEntity, groupStatusId: 1, groupTypeId: 1, customerId: self.customerId ?? 0, Onfarmid: dataObject.onFarmId ?? "", officialID: dataObject.officalId ?? "")
                        if checkanimal.count > 0{
                            updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  self.customerId ?? 0, animalID: animalId , status: LocalizedStrings.banStatus)
                            self.myHerdArray = fetchGroupInfoResult(entityName: Entities.resultGroupAnimalsTblEntity,groupName: self.groupName,customerId:self.customerId ?? 0) as! [ResultGroupsAnimals]
                            self.totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: self.myHerdArray.count)
                        }
                        
                        else{
                            let dateFormatter = DateFormatter()
                            dateFormatter.locale = Locale(identifier: LocalizedStrings.en_US_POSIXStr)
                            dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                            let date:Date? = dateFormatter.date(from:dataObject.dob ?? "")
                            saveAnimaldataResult(entity: Entities.resultGroupAnimalsTblEntity, serverGroupId: groupServerId, groupName: groupName, groupStatusId: Int(groupStatusId), groupStatus: groupStatus, groupTypeId: 1, groupTypeName: groupTypeName, animalID: dataObject.animalID ?? "" , onFarmId:dataObject.onFarmId ?? "", officalId:dataObject.officalId ?? "", dob: dataObject.dob ?? "", sex:dataObject.sex ?? "", breedId: dataObject.breedId ?? "", breedName: dataObject.breedName ?? "", name: dataObject.name ?? "", groupId: 0, customerId: self.customerId ?? 0 ,datedob: date ?? Date())
                            updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  self.customerId ?? 0, animalID: animalId , status: LocalizedStrings.banStatus)
                            self.myHerdArray = fetchGroupInfoResult(entityName: Entities.resultGroupAnimalsTblEntity,groupName: self.groupName,customerId:self.customerId ?? 0) as! [ResultGroupsAnimals]
                            self.totalAnimalCount.text = "Total Animals : \(self.myHerdArray.count)"
                        }
                        removeAnimalInGroup(groupId: sid , animalIds: dataObject.animalID ?? "", completionHandler: { (result) in
                            if result == true{
                                self.hideIndicator()
                            }
                        })
                    }
                    else {
                        showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                        _ = deletGroupInfoResultGroupDetail(entityName: Entities.resultGroupAnimalsTblEntity, groupName: groupName , customerId: self.customerId ?? 0, onFarmId: dataObject.onFarmId ?? "", officalId: dataObject.officalId ?? "")
                        updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  self.customerId ?? 0, animalID: animalId , status: LocalizedStrings.inactiveStatus)
                        self.myHerdArray = fetchGroupInfoResult(entityName: Entities.resultGroupAnimalsTblEntity,groupName: self.groupName,customerId:self.customerId ?? 0) as! [ResultGroupsAnimals]
                        self.totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: self.myHerdArray.count)
                        removeAnimalInGroup(groupId: sid , animalIds: animalId, completionHandler: { (result) in
                            if result == true{
                                self.hideIndicator()
                            }
                        })
                    }
                }
                
                else{
                    let sid = dataObject.serverGroupId ?? ""
                    let animalId = dataObject.animalID ?? ""
                    let statusname  = dataObject.groupName ?? ""
                    showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                    _ = deletGroupInfoResultGroupDetail(entityName: Entities.resultGroupAnimalsTblEntity, groupName: statusname , customerId: self.customerId ?? 0, onFarmId: dataObject.onFarmId ?? "", officalId: dataObject.officalId ?? "")
                    updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  self.customerId ?? 0, animalID: animalId , status: LocalizedStrings.inactiveStatus)
                    self.myHerdArray = fetchGroupInfoResult(entityName: Entities.resultGroupAnimalsTblEntity,groupName: statusname,customerId:self.customerId ?? 0) as! [ResultGroupsAnimals]
                    self.totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: self.myHerdArray.count)
                    removeAnimalInGroup(groupId: sid , animalIds: animalId, completionHandler: { (result) in
                        if result == true{
                            self.hideIndicator()
                        }
                    })
                }
            }
            else{
                if  ban.count == 0 {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.noActiveBarn, comment: "") )
                }
                else{
                    showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                    _ = deletGroupInfoResultGroupDetail(entityName: Entities.resultGroupAnimalsTblEntity, groupName: self.groupName , customerId: self.customerId ?? 0, onFarmId: dataObject.onFarmId ?? "", officalId: dataObject.officalId ?? "")
                    updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  self.customerId ?? 0, animalID: animalId , status: LocalizedStrings.inactiveStatus)
                    self.myHerdArray = fetchGroupInfoResult(entityName: Entities.resultGroupAnimalsTblEntity,groupName: self.groupName,customerId:self.customerId ?? 0) as! [ResultGroupsAnimals]
                    self.totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: self.myHerdArray.count)
                    removeAnimalInGroup(groupId: sid , animalIds: animalId, completionHandler: { (result) in
                        if result == true{
                            self.hideIndicator()
                        }
                    })
                }
            }
        }
    }
    
    func swipeRight(index: Int){
        NotificationCenter.default.addObserver(self, selector: #selector(notificationRecevied(notification:)), name: NSNotification.Name(rawValue: LocalizedStrings.animationEndNoti), object: nil)
        
        datasource.remove(at: index)
        let array = self.myHerdArray[index]
        let animalId = array.animalID ?? ""
        let onFarmId = array.onFarmId ?? ""
        let groupServerIdmain = array.serverGroupId ?? ""
        if array.groupStatus == LocalizedStrings.capsInactiveStatus || array.groupStatus == "Unknown"{
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(LocalizedStrings.noActiveDoller, comment: "") )
            return
        }
        else{
            let ban =  fetchGroupIdFethSatusG(entityName: Entities.resultGroupCreateTblEntity, customerId: self.customerId ?? 0, groupStatusId: 1, groupTypeId: 1)
            if ban.count > 0 {
                let gruupCreate = ban.object(at: 0) as? ResultGroupCreate
                let groupName = gruupCreate?.groupName  ?? ""
                let groupStatusId = gruupCreate?.groupStatusId  ?? 0
                let groupStatus = gruupCreate?.groupStatus  ?? ""
                let dollar =  fetchGroupIdFethSatusG(entityName: Entities.resultGroupCreateTblEntity, customerId: self.customerId ?? 0, groupStatusId: 1, groupTypeId: 0)
                
                if dollar.count > 0 {
                    let gruupCreate1 = dollar.object(at: 0) as? ResultGroupCreate
                    let groupName1 = gruupCreate1?.groupName  ?? ""
                    let groupTypeName1 = gruupCreate1?.groupTypeName  ?? ""
                    let groupServerId1 =  gruupCreate1?.groupServerId ?? ""
                    if array.groupTypeName == LocalizedStrings.barnGroupType{
                        self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                        _ = deletGroupInfoResultGroupDetail(entityName: Entities.resultGroupAnimalsTblEntity, groupName: groupName , customerId: self.customerId ?? 0, onFarmId: array.onFarmId ?? "", officalId: array.officalId ?? "")
                        let checkanimal = fetchanimalExistInDataBase(entityName: Entities.resultGroupAnimalsTblEntity, groupStatusId: 1, groupTypeId: 0, customerId:self.customerId ?? 0, Onfarmid: array.onFarmId ?? "", officialID: array.officalId ?? "")
                        if checkanimal.count > 0{
                            updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:self.customerId ?? 0, animalID: animalId , status: LocalizedStrings.dollerStatus)
                            self.myHerdArray = fetchGroupInfoResult(entityName: Entities.resultGroupAnimalsTblEntity,groupName: self.groupName,customerId:self.customerId ?? 0) as! [ResultGroupsAnimals]
                            
                            self.totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: self.myHerdArray.count)
                        }
                        else{
                            let dateFormatter = DateFormatter()
                            dateFormatter.locale = Locale(identifier: LocalizedStrings.en_US_POSIXStr)
                            dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                            let date:Date? = dateFormatter.date(from:array.dob ?? "")
                            
                            saveAnimaldataResult(entity: Entities.resultGroupAnimalsTblEntity, serverGroupId: groupServerId1, groupName: groupName1, groupStatusId: Int(groupStatusId), groupStatus: groupStatus, groupTypeId: 0, groupTypeName: groupTypeName1 , animalID: array.animalID ?? "" , onFarmId:array.onFarmId ?? "", officalId:array.officalId ?? "", dob: array.dob ?? "", sex:array.sex ?? "", breedId: array.breedId ?? "", breedName: array.breedName ?? "", name: array.name ?? "", groupId: array.groupId, customerId:  self.customerId ?? 0,datedob: date ?? Date())
                            updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:self.customerId ?? 0, animalID: animalId , status: LocalizedStrings.dollerStatus)
                            self.myHerdArray = fetchGroupInfoResult(entityName: Entities.resultGroupAnimalsTblEntity,groupName: self.groupName,customerId:self.customerId ?? 0) as! [ResultGroupsAnimals]
                            
                            self.totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: self.myHerdArray.count)
                        }
                        removeAnimalInGroup(groupId: groupServerIdmain , animalIds: animalId , completionHandler: { (result) in
                            if result == true{
                                self.hideIndicator()
                            }
                        })
                    }
                    else {
                        showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                        _ = deletGroupInfoResultGroupDetail(entityName: Entities.resultGroupAnimalsTblEntity, groupName: groupName1, customerId: self.customerId ?? 0, onFarmId: onFarmId, officalId: array.officalId ?? "")
                        self.myHerdArray = fetchGroupInfoResult(entityName: Entities.resultGroupAnimalsTblEntity,groupName: groupName1,customerId:self.customerId ?? 0) as! [ResultGroupsAnimals]
                        updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  self.customerId ?? 0, animalID: animalId , status: LocalizedStrings.inactiveStatus)
                        UserDefaults.standard.setValue("", forKey: keyValue.del.rawValue)
                        self.totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: self.myHerdArray.count)
                        removeAnimalInGroup(groupId: groupServerIdmain , animalIds: animalId, completionHandler: { [self] (result) in
                            if result == true {
                                
                                self.hideIndicator()
                            }
                        })
                    }
                }
                else{
                    if dollar.count == 0{
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(LocalizedStrings.noActiveDoller, comment: "") )
                    }
                    else{
                        let animalId = array.animalID ?? ""
                        let onFarmId = array.onFarmId ?? ""
                        let group = array.groupName ?? ""
                        let groupServerIdmain = array.serverGroupId ?? ""
                        showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                        UserDefaults.standard.setValue("", forKey: keyValue.del.rawValue)
                        _ = deletGroupInfoResultGroupDetail(entityName: Entities.resultGroupAnimalsTblEntity, groupName:group , customerId: self.customerId ?? 0, onFarmId: onFarmId, officalId: array.officalId ?? "")
                        self.myHerdArray = fetchGroupInfoResult(entityName: Entities.resultGroupAnimalsTblEntity,groupName: group,customerId:self.customerId ?? 0) as! [ResultGroupsAnimals]
                        updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  self.customerId ?? 0, animalID: animalId , status: LocalizedStrings.inactiveStatus)
                        
                        self.totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: self.myHerdArray.count)
                        removeAnimalInGroup(groupId: groupServerIdmain , animalIds: animalId, completionHandler: { [self] (result) in
                            if result == true {
                                self.hideIndicator()
                            }
                        })
                    }
                }
            }
            else{
                let animalId = array.animalID ?? ""
                let onFarmId = array.onFarmId ?? ""
                let group = array.groupName ?? ""
                let groupServerIdmain = array.serverGroupId ?? ""
                showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                UserDefaults.standard.setValue("", forKey: keyValue.del.rawValue)
                _ = deletGroupInfoResultGroupDetail(entityName: Entities.resultGroupAnimalsTblEntity, groupName: group, customerId: self.customerId ?? 0, onFarmId: onFarmId, officalId: array.officalId ?? "")
                self.myHerdArray = fetchGroupInfoResult(entityName: Entities.resultGroupAnimalsTblEntity,groupName: group,customerId:self.customerId ?? 0) as! [ResultGroupsAnimals]
                updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  self.customerId ?? 0, animalID: animalId , status: LocalizedStrings.inactiveStatus)
                self.totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: self.myHerdArray.count)
                removeAnimalInGroup(groupId: groupServerIdmain , animalIds: animalId, completionHandler: { [self] (result) in
                    if result == true {
                        self.hideIndicator()
                    }
                })
            }
        }
    }
}

//MARK: OBJECT PICK CART SCREEN EXTENSION
extension GroupDetailsViewController : objectPickCartScreen {
    func objectGetOnSelection(temp: Int) {
    }
}
