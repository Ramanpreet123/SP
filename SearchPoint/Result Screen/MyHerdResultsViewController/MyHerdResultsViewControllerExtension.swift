//
//  MyHerdResultsViewControllerExtension.swift
//  SearchPoint
//
//  Created by Mobile Programming on 01/03/24.
//

import Foundation
import UIKit
import CoreBluetooth

// MARK: - FILTER INFO UPDATE DELEGATE
extension MyHerdResultsViewController :filterInfoUpdate{
    
    func cancelPressed() {
        let resultFIlterDataSave : [ResultFIlterDataSave] =  fetchResultFilterData(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: Int(custmerID)) as! [ResultFIlterDataSave]
        if resultFIlterDataSave.count > 0{
            providerFilterBtnOutlet.setTitle(resultFIlterDataSave.last?.productName, for: .normal)
            UserDefaults.standard.set(resultFIlterDataSave.last?.productName,forKey: keyValue.resultproviderID.rawValue)
            productName = resultFIlterDataSave.last?.productName ?? ""
            providerID = Int(resultFIlterDataSave.last?.productID ?? 0)
            if  resultFIlterDataSave.last?.sex == "F" {
                sexFilterBtnOutlet .setTitle(ButtonTitles.femaleText.localized, for: .normal)
            }
            else if resultFIlterDataSave.last?.sex == "M"{
                sexFilterBtnOutlet .setTitle(ButtonTitles.maleText.localized, for: .normal)
            }
            else if resultFIlterDataSave.last?.sex == "A"{
                sexFilterBtnOutlet .setTitle(ButtonTitles.allText.localized, for: .normal)
            }
            UserDefaults.standard.set(resultFIlterDataSave.last?.isHeriditySelected ?? false, forKey: keyValue.isHerditySelected.rawValue)
            UserDefaults.standard.set(resultFIlterDataSave.last?.idselection, forKey: keyValue.idSelect.rawValue)
            UserDefaults.standard.set(resultFIlterDataSave.last?.sortorder, forKey: keyValue.sortOrder.rawValue)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DateFormatters.yyyyMMddTHHmmssFormat
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.locale = Locale.current
            
            if resultFIlterDataSave.last?.datefrom != ""{
                fromDaten = dateFormatter.date(from: resultFIlterDataSave.last?.datefrom ?? "")!
            }
            
            if resultFIlterDataSave.last?.dateto != ""{
                ToDaten = dateFormatter.date(from: resultFIlterDataSave.last?.dateto ?? "")!
            }
            
            let calendar = Calendar.current
            let fmt = DateFormatter()
            if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                fmt.dateFormat = DateFormatters.MMddyyyyFormat
            } else {
                fmt.dateFormat = DateFormatters.ddMMyyyyFormat
            }
            
            fromdatecheck = fmt.string(from: fromDaten)
            todatecheck = fmt.string(from: ToDaten)
            var alldates = [String]()
            
            while fromDaten <= ToDaten {
                alldates.append(fmt.string(from: fromDaten))
                fromDaten = calendar.date(byAdding: .day, value: 1, to: fromDaten)!
            }
            if (resultFIlterDataSave.last?.breedName?.components(separatedBy: ",").count ?? 0) > 1{
                breedFilterBtnOutlet.setTitle(ButtonTitles.multipleBreedsText.localized, for: .normal)
            }else{
                breedFilterBtnOutlet.setTitle(resultFIlterDataSave.last?.breedName, for: .normal)
            }
        }
    }
    
    func reloaddata() {
        fetchFilterData = fetchResultFilterData(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: Int(customerId ?? 0))
        fetchTempObj1new = fetchAllData(entityName: Entities.resultPageByTraitTblEntity)
        if fetchFilterData.count != 0{
            for items in fetchFilterData{
                let newfetch = items as? ResultFIlterDataSave
                ranktitle = newfetch?.traidsave
                let checkid = newfetch?.idselection
                
                if let ranktitelname = ranktitle{
                    if checkid == LocalizedStrings.officialCheckId{
                        rankLabel.text = "         \(ranktitelname)"
                    }
                    else{
                        rankLabel.text = " \(ranktitelname)"
                    }
                }
                else{
                    rankLabel.text = "Rank"
                }
            }
        }
        
        self.hideIndicator()
        self.hideIndicator()
        self.hideIndicator()
        self.hideIndicator()
        myHerdArray   = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:customerId ?? 0) as! [ResultMyHerdData]
        tblView.isHidden = false
        totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: myHerdArray.count)
        
        if myHerdArray.count == 0{
            message.isHidden = false
            tblView.isHidden = true
            headerview.isHidden = true
        }
        if myHerdArray.count != 0 {
            message.isHidden = true
            tblView.isHidden = false
            headerview.isHidden = false
            
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
    
    
    func dateInfoUpdate(date: String) {
        dateFilterBtnOutlet.setTitle(date, for: .normal)
    }
    
    func breedInfoUpdate(index: Int) {
        custmerID = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64 ?? 0
        let fetchBreeds = fetchResultFilterDataWithProductid(entityName: Entities.resultFilterDataTblEntity, customerId: Int(custmerID), providerid: Int64(providerID))
        if fetchBreeds.count != 0 {
            breedArray.removeAll()
            breedIDArray.removeAll()
            for i in 0 ..< fetchBreeds.count{
                
                let obj = fetchBreeds[i] as! ResultFilterData
                let getProductName = obj.breedName ?? ""
                let getbreedid = obj.breedId ?? ""
                breedArray.append(getProductName)
                breedIDArray.append(getbreedid)
            }
            breedArray = breedArray.removeDuplicates()
            breedIDArray = breedIDArray.removeDuplicates()
            breedName = breedArray[index]
            breedID = breedIDArray[index]
            
            let isHerditySelected = UserDefaults.standard.bool(forKey: keyValue.isHerditySelected.rawValue)
            if isHerditySelected  && providerID == 1{
                if let selectedBreedIds = UserDefaults.standard.value(forKey: keyValue.resultBreedID.rawValue) as? String {
                    var breeds = selectedBreedIds.components(separatedBy: ",")
                    let selectedBreedId = breedIDArray[index]
                    if let index = breeds.firstIndex(of: selectedBreedId) {
                        breeds.remove(at: index)
                    } else {
                        breeds.append(selectedBreedId)
                    }
                    breedID = breeds.joined(separator: ",")
                }
                
                if let selectedBreedNames = UserDefaults.standard.value(forKey: keyValue.breedName.rawValue) as? String {
                    var breeds = selectedBreedNames.components(separatedBy: ",")
                    let output = breedArray.filter{ breeds.contains($0) }
                    breeds = output
                    
                    let selectedBreedName = breedArray[index]
                    if let index = breeds.firstIndex(of: selectedBreedName) {
                        breeds.remove(at: index)
                    } else {
                        breeds.append(selectedBreedName)
                    }
                    breedName = breeds.joined(separator: ",")
                }
            }
            
            UserDefaults.standard.set(breedID, forKey: keyValue.resultBreedID.rawValue)
            UserDefaults.standard.set(breedName, forKey: keyValue.breedName.rawValue)
            let resultbreedID = UserDefaults.standard.value(forKey: keyValue.resultBreedID.rawValue) as? String ?? ""
            let arrayBreedID = resultbreedID.components(separatedBy: ",")
            if arrayBreedID.count > 1{
                breedFilterBtnOutlet.setTitle(ButtonTitles.multipleBreedsText, for: .normal)
            }
            else{
                breedFilterBtnOutlet.setTitle(breedName, for: .normal)
            }
        }
        
        if providerFilterBtnOutlet.titleLabel?.text == nil || providerFilterBtnOutlet.titleLabel?.text == "" || breedFilterBtnOutlet.titleLabel?.text == nil || breedFilterBtnOutlet.titleLabel?.text == nil {
            tblView.reloadData()
        } 
        else {
            let sex = sexname
            UserDefaults.standard.set(sex, forKey: keyValue.sexvalue.rawValue)
        }
    }
    
    func providerInfoUpdate(index: Int) {
        let fetchObj = fetchResultFilterData(entityName: Entities.resultFilterDataTblEntity,customerId: Int(customerId ?? 0))
        if fetchObj.count != 0 {
            for i in 0 ..< fetchObj.count{
                let obj = fetchObj[i] as! ResultFilterData
                let getProductName = obj.providerName ?? ""
                let providerID = obj.providerID
                productArray.append(getProductName)
                providerarray.append(Int(providerID))
            }
            productArray = productArray.removeDuplicates()
            providerarray = providerarray.removeDuplicates()
            productName = productArray[index]
            providerID = providerarray[index]
        }
    }
    
    func genderInfoUpdate(sex:String, providerIndexPath: Int, breedIndexPath: Int, fromdatevalue : String , todatevalue : String,header: String ,trait: String){
        providerInfoUpdate(index: providerIndexPath)
        providerFilterBtnOutlet.setTitle(productArray[providerIndexPath], for: .normal)
        UserDefaults.standard.set(providerarray[providerIndexPath],forKey: keyValue.resultproviderID.rawValue)
        
        if  sex == "F" {
            sexFilterBtnOutlet .setTitle(ButtonTitles.femaleText.localized, for: .normal)
        }
        else if sex == "M"{
            sexFilterBtnOutlet .setTitle(ButtonTitles.maleText.localized, for: .normal)
        }
        else if sex == "A"{
            sexFilterBtnOutlet .setTitle(ButtonTitles.allText.localized, for: .normal)
        }
        
        let dateFormatter = DateFormatter()
        if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
            dateFormatter.dateFormat = DateFormatters.MMddyyyy0000Format
        } else {
            dateFormatter.dateFormat = DateFormatters.ddMMyyyy0000Format
        }
        
        if fromdatevalue != ""{
            fromDaten = dateFormatter.date(from: fromdatevalue)!
        }
        
        if todatevalue != ""{
            ToDaten = dateFormatter.date(from: todatevalue)!
            
        }
        
        let calendar = Calendar.current
        let fmt = DateFormatter()
        if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
            fmt.dateFormat = DateFormatters.MMddyyyyFormat
        } else {
            fmt.dateFormat = DateFormatters.ddMMyyyyFormat
        }
        fromdatecheck = fmt.string(from: fromDaten)
        todatecheck = fmt.string(from: ToDaten)
        var alldates = [String]()
        
        while fromDaten <= ToDaten {
            alldates.append(fmt.string(from: fromDaten))
            fromDaten = calendar.date(byAdding: .day, value: 1, to: fromDaten)!
        }
        UserDefaults.standard.setValue(todatecheck, forKey: keyValue.todate.rawValue)
        UserDefaults.standard.setValue(fromdatecheck, forKey: keyValue.fromdate.rawValue)
        UserDefaults.standard.setValue(sex, forKey: keyValue.savesex.rawValue)
        
        if myHerdArray.count == 0{
            message.isHidden = false
            tblView.isHidden = true
            headerview.isHidden = true
        }
        if myHerdArray.count != 0 {
            message.isHidden = true
            tblView.isHidden = false
            headerview.isHidden = false
            datasource.removeAll()
            for i in 0...myHerdArray.count - 1{
                let ab = callSwipeStruct(name: [myHerdArray[i]], color: .white, image: UIImage(named:ImageNames.threeDotsInactiveImg)!, backgroundGroup: UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0))
                datasource.append(ab)
            }
        }
        UserDefaults.standard.removeObject(forKey: keyValue.fromManagement.rawValue)
        tblView.reloadData()
        tblView.delegate = self
        tblView.dataSource = self
    }
    
    func loadMoreData() {
        myHerdArray.append(contentsOf: myHerdArray)
        self.myHerdArray = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:self.customerId ?? 0) as! [ResultMyHerdData]
        totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: myHerdArray.count)
        self.tblView.reloadData()
    }
}

extension MyHerdResultsViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == myTableView{
            return productArray.count
        }
        if tableView == pairedTableView {
            return arrNearbyDevice.count
        } else {
            return myHerdArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == myTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.myCellIdentifier, for: indexPath as IndexPath)
            let productArr = productArray[indexPath.row]
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.minimumScaleFactor = 0.1
            cell.textLabel?.font = UIFont.systemFont(ofSize: 11.0)
            cell.textLabel?.text = productArr
            return cell
        }
        
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
        
        let cell: MyHerdTblCell = self.tblView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyHerdTblCell
        let myArray = self.myHerdArray[indexPath.row]
        cell.tag = indexPath.row
        cell.delegate = self
        let dob = myArray.dob ?? ""
        let dateonly = dob.components(separatedBy: " ")
        cell.dobLabel.text = "    \(dateonly[0])"
        let status = myArray.status ?? ""
        if fetchFilterData.count != 0{
            for items in fetchFilterData{
                let newfetch = items as? ResultFIlterDataSave
                checkid = newfetch?.idselection ?? ""
                if checkid == LocalizedStrings.officialCheckId{
                    self.officalIdLabel.text = LocalizedStrings.officialIDText.localized
                    cell.officialIdLabel.text = myArray.officialID ?? ""
                    
                }
                else{
                    self.officalIdLabel.text = LocalizedStrings.onFarmIdText.localized
                    cell.officialIdLabel.text = myArray.onFarmID ?? ""
                }
            }
        }
        
        if myHerdArray.count == 0{
            message.isHidden = false
            tblView.isHidden = true
            headerview.isHidden = true
        }
        if myHerdArray.count != 0{
            message.isHidden = true
            tblView.isHidden = false
            headerview.isHidden = false
        }
        
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
        
        let fetchTempObj1 : [ResultPageByTrait] = fetchResultTraitIdPageApi(entityName: Entities.resultPageByTraitTblEntity,traitId: rankid, onFarmId: myArray.onFarmID ?? "",officalId: myArray.officialID ?? "") as! [ResultPageByTrait]
        if fetchTempObj1.count != 0 {
            let rankvalue = fetchTempObj1[0]
            let rankgetvalue = rankvalue.numericFormat
            if checkid == LocalizedStrings.officialCheckId{
                if rankgetvalue == ""{
                    let rankstring = rankvalue.stringValue
                    cell.rankLabel.text = "      " + "   \(rankstring ?? "")" + "    "
                }
                else{
                    cell.rankLabel.text = "\(rankgetvalue ?? "")"
                }
            }
            else{
                if rankgetvalue == ""{
                    let rankstring = rankvalue.stringValue
                    cell.rankLabel.text = "   \(rankstring ?? "")"
                }
                else{
                    cell.rankLabel.text = "   \(rankgetvalue ?? "")"
                }
            }
        }
        
        if status  == LocalizedStrings.banStatus{
            let imag = datasource[indexPath.row]
            cell.groupImage.image = imag.image
            cell.delegate = self
            cell.groupView.layer.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0).cgColor
            cell.groupImage.image = UIImage(named: ImageNames.barnActiveImg)!
        }
        else if status == LocalizedStrings.dollerStatus{
            let imag = datasource[indexPath.row]
            cell.groupImage.image = imag.image
            cell.delegate = self
            cell.groupView.layer.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0).cgColor
            cell.groupImage.image = UIImage(named: ImageNames.dollarActiveImg)!
        }
        else if  status == LocalizedStrings.inactiveStatus {
            let imag = datasource[indexPath.row]
            cell.groupImage.image = imag.image
            cell.delegate = self
            cell.groupView.layer.backgroundColor  = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0).cgColor
            cell.groupImage.image = UIImage(named: ImageNames.threeDotsInactiveImg)!
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == pairedTableView {
            if BluetoothCentre.shared.smartBowPeripheral != nil {
                BluetoothCentre.shared.manager.cancelPeripheralConnection(BluetoothCentre.shared.smartBowPeripheral!)
            }
            BluetoothCentre.shared.ConnectArgument(peripheral: arrNearbyDevice[indexPath.row])
            pairedBackroundView.isHidden = true
            pairedDeviceView.isHidden = true
            pairedTableView.reloadData()
            return
        }
        
        UserDefaults.standard.removeObject(forKey: keyValue.scrollIncrement.rawValue)
        let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.individualAnimalResultControllerVC) as? IndividualAnimalResultController
        vc?.checkCOntroller = LocalizedStrings.resultController
        vc?.backScreenClickIndex = indexPath.row
        vc?.getMyHerdArray = myHerdArray
        vc?.productName = providerFilterBtnOutlet.titleLabel?.text ?? ""
        let offlicalidmyherd = myHerdArray[indexPath.row].officialID
        let onfarmid = myHerdArray[indexPath.row].onFarmID
        UserDefaults.standard.set(offlicalidmyherd, forKey: keyValue.myHerdOfficalid.rawValue)
        UserDefaults.standard.set(onfarmid, forKey: keyValue.myHerdOnfarmId.rawValue)
        UserDefaults.standard.set(myHerdArray[indexPath.row].breedID, forKey: keyValue.selectedAnimalBreedID.rawValue)
        searchTextField.text = ""
        let fetchObject = fetchAnimalAssignExistIntable(entityName: Entities.resultGroupAnimalsTblEntity,customerId: customerId ?? 0,animalId: myHerdArray[indexPath.row].animalID ?? "") as! [ResultGroupsAnimals]
        var filterGroup = [ResultGroupsAnimals]()
        if fetchObject.count != 0 {
            let animalGroup = myHerdArray[indexPath.row].status
            if animalGroup == LocalizedStrings.dollerStatus{
                filterGroup =  fetchObject.filter{$0.groupTypeName == LocalizedStrings.dollarGroupType && $0.groupStatus == LocalizedStrings.activeGroupType}
            }
            else {
                filterGroup =  fetchObject.filter{$0.groupTypeName == LocalizedStrings.barnGroupType && $0.groupStatus == LocalizedStrings.activeGroupType}
            }
            
            if filterGroup.count > 0{
                let resultGrpObject = filterGroup[0]
                let groupStatusId = resultGrpObject.groupStatusId
                let groupTypeId = resultGrpObject.groupTypeId
                let groupname = resultGrpObject.groupName
                UserDefaults.standard.setValue(groupname, forKey: keyValue.groupName.rawValue)
                
                if groupStatusId == 1 && groupTypeId == 1 {
                    UserDefaults.standard.setValue(ImageNames.barnActiveImg, forKey: keyValue.radioButtonCheck.rawValue)
                }
                else if groupStatusId == 1 && groupTypeId == 0 {
                    UserDefaults.standard.setValue(ImageNames.dollarActiveImg, forKey: keyValue.radioButtonCheck.rawValue)
                    
                } 
                else {
                    UserDefaults.standard.setValue(ImageNames.threeDotsInactiveImg, forKey: keyValue.radioButtonCheck.rawValue)
                }
            }
        }
        else{
            UserDefaults.standard.setValue("NA", forKey: keyValue.groupName.rawValue)
            UserDefaults.standard.setValue(ImageNames.threeDotsInactiveImg, forKey: keyValue.radioButtonCheck.rawValue)
        }
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.searchTextField.text! == "" {
            if UserDefaults.standard.integer(forKey: keyValue.animalReceivedCount.rawValue) < 50{
                return
            }
            let lastAnimal = self.myHerdArray.count-1
            if indexPath.row == lastAnimal {
                if Connectivity.isConnectedToInternet() {
                    if !stopPagination {
                        self.showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncResultsData, comment: ""), and: "")
                        self.view.isUserInteractionEnabled = false
                        self.group.enter()
                        self.saveResulyByPageViewModel = ResulyByPageViewModel(callBack: self.navigateTosaveanimal)
                        self.saveResulyByPageViewModel?.callResultByPageAnimalApi()
                    }
                }
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension MyHerdResultsViewController:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

extension MyHerdResultsViewController : SideMenuUI,RFID,nearByDevice{
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
}

extension MyHerdResultsViewController: scannedOCRProtocol {
    func ocrDetected(_ scannedResult: String) {
        // Intentionally left empty.
        // This function will handle navigation to another view controller in the future.
        // Currently unused, but kept for consistency with protocol or planned implementation.
    }
}

extension MyHerdResultsViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let newString = (searchTextField.text ?? "") + string
        if newString != "" {
            myHerdArray = fetchOrdersWithMyHerdFilter(entityName: Entities.resultMyherdDataTblEntity, searchText:  newString as String,customerId: Int64(customerId ?? 0)) as! [ResultMyHerdData]
            
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
            myHerdArray = fetchOrdersWithMyHerdFilter(entityName: Entities.resultMyherdDataTblEntity, searchText:  newString as String, customerId: Int64(customerId ?? 0)) as! [ResultMyHerdData]
            tblView.reloadData()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        let newString: NSString =
        searchTextField.text! as NSString
        
        if newString != "" {
            myHerdArray = fetchOrdersWithMyHerdFilter(entityName: Entities.resultMyherdDataTblEntity, searchText:  (newString.uppercased) as String, customerId: Int64(customerId ?? 0)) as! [ResultMyHerdData]
            
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
            myHerdArray = fetchOrdersWithMyHerdFilter(entityName: Entities.resultMyherdDataTblEntity, searchText:  (newString.uppercased) as String, customerId: Int64(customerId ?? 0)) as! [ResultMyHerdData]
            tblView.reloadData()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
