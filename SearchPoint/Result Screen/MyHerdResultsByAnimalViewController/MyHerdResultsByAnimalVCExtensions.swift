//
//  MyHerdResultsByAnimalVCExtensions.swift
//  SearchPoint
//
//  Created by Mobile Programming on 28/02/24.
//

import Foundation
import UIKit
import Alamofire
import CoreBluetooth

//MARK: CHOOSE PROVIDER DELEGATE
extension MyHerdResultsByAnimalViewController : chosseProviderDelegate {
    func selectedProviderIndex(providerName: String) {
        UserDefaults.standard.set(providerName, forKey: keyValue.selectedProviderName.rawValue)
        self.navigateToIndivisualController(productNameStr: providerName)
    }
}

//MARK: GET PROVIDER NAMES
extension MyHerdResultsByAnimalViewController {
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
        }
        else if (isUniqueHeridityTrait && isUniqueDatageneTrait && !isUniqueCdcbTrait)
        {
            navigatetoProviderSelection(showCDCB: isUniqueCdcbTrait, showDatagene: isUniqueDatageneTrait, showHerdity: isUniqueHeridityTrait, showViewCount: 2)
        }
        else if (isUniqueHeridityTrait && isUniqueCdcbTrait && !isUniqueDatageneTrait)
        {
            navigatetoProviderSelection(showCDCB: isUniqueCdcbTrait, showDatagene: isUniqueDatageneTrait, showHerdity: isUniqueHeridityTrait, showViewCount: 2)
        }
        else if (isUniqueDatageneTrait && isUniqueCdcbTrait && !isUniqueHeridityTrait)
        {
            navigatetoProviderSelection(showCDCB: isUniqueCdcbTrait, showDatagene: isUniqueDatageneTrait, showHerdity: isUniqueHeridityTrait, showViewCount: 2)
        }
        
        else if (isUniqueCdcbTrait && !isUniqueDatageneTrait && !isUniqueHeridityTrait)
        {
            self.navigateToIndivisualController(productNameStr: LocalizedStrings.clarifideCDCB)
            UserDefaults.standard.set(LocalizedStrings.clarifideCDCB, forKey: keyValue.selectedProviderName.rawValue)
        }
        else  if (isUniqueDatageneTrait && !isUniqueCdcbTrait && !isUniqueHeridityTrait)
        {
            self.navigateToIndivisualController(productNameStr: LocalizedStrings.clarifideDataGene)
            UserDefaults.standard.set(LocalizedStrings.clarifideDataGene, forKey: keyValue.selectedProviderName.rawValue)
        }
        else if (isUniqueHeridityTrait && !isUniqueDatageneTrait && !isUniqueCdcbTrait)
        {
            self.navigateToIndivisualController(productNameStr: LocalizedStrings.herdity)
            UserDefaults.standard.set(LocalizedStrings.herdity, forKey: keyValue.selectedProviderName.rawValue)
        }
    }
}

//MARK: RESULT FOUND DELEGATE
extension MyHerdResultsByAnimalViewController : ResultFoundDelegate {
    func resultStatus(status: Bool) {
        if !status {
            if viewModel.filterAutoAnimalData.count == 0 {
                searchTextField.text = ""
                hideIndicator()
                self.view.isUserInteractionEnabled = true
                if self.myHerdArray.count > 0 {
                    CommonClass.showAlertMessage(self, titleStr: "Alert!", messageStr: LocalizedStrings.noRecordFound.localized)
                } else {
                    self.message.text = LocalizedStrings.noRecordFound.localized
                }
                
            } else {
                searchTextField.text = ""
                hideIndicator()
                self.view.isUserInteractionEnabled = true
                if self.myHerdArray.count > 0 {
                    CommonClass.showAlertMessage(self, titleStr: "Alert!", messageStr: LocalizedStrings.noResultFoundYet.localized)
                } else {
                    self.message.text = LocalizedStrings.noResultFoundYet.localized
                }
            }
            
        }
    }
}

//MARK: SCANNED OCR PROTOCOL
extension MyHerdResultsByAnimalViewController: scannedOCRProtocol {
    func ocrDetected(_ scannedResult: String) {
        self.scannedString = scannedResult
        searchTextField.text = scannedResult
    }
}

//MARK: SIDE MENU UI AND RFID SCANNER
extension MyHerdResultsByAnimalViewController : SideMenuUI,RFID,nearByDevice{
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

//MARK: OFFLINE CUSTOM VIEW EXTENSION
extension MyHerdResultsByAnimalViewController:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

//MARK: TABLEVIEW DATASOURCE AND DELEGATES
extension MyHerdResultsByAnimalViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == AutoSuggestionTableView {
            return 44
        }
        
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == myTableView{
            return productArray.count
        }
        if tableView == autoSuggestTableView{
            return viewModel.filterAutoAnimalData.count
        }
        if tableView == pairedTableView {
            return arrNearbyDevice.count
        } else {
            if myHerdArray.count >= 20 {
                return 20
            }
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
        if  tableView == autoSuggestTableView {
            let cell = UITableViewCell()
            cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
            if viewModel.filterAutoAnimalData.count > 0 {
                if searchByEarTag{
                    cell.textLabel?.text =  viewModel.filterAutoAnimalData[indexPath.row].earTag
                } else {
                    cell.textLabel?.text =  viewModel.filterAutoAnimalData[indexPath.row].officialID
                }
            }
            
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
        
        let cell: MyHerdTblCell = self.tblView.dequeueReusableCell(withIdentifier: "MyHerdTblCell", for: indexPath) as! MyHerdTblCell
        let myArray = self.myHerdArray[indexPath.row]
        cell.tag = indexPath.row
        if myArray.selectedAnimal {
            cell.selectedBackroundView.isHidden = false
        } else {
            cell.selectedBackroundView.isHidden = true
        }
        cell.delegate = self
        let dob = myArray.dob ?? ""
        let dateonly = dob.components(separatedBy: " ")
        cell.dobLabel.text = "    \(dateonly[0])"
        
        if myArray.notes == "" && myArray.photos == nil{
            cell.notesImgView.isHidden = true
            cell.Label1.isHidden = false
        } else {
            cell.notesImgView.isHidden = false
            cell.Label1.isHidden = true
        }
        
        cell.notesImgView.isUserInteractionEnabled = true
        cell.notesImgView.tag = indexPath.row
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        cell.notesImgView.addGestureRecognizer(tap)
        let status = myArray.status ?? ""
        
        if !searchByEarTag {
            self.officalIdLabel.text = LocalizedStrings.officialIDText.localized
            cell.officialIdLabel.text = myArray.officialID ?? ""
        }
        else
        {
            self.officalIdLabel.text = ButtonTitles.earTagText.localized
            cell.officialIdLabel.text = myArray.onFarmID ?? ""
        }
        let fetchBreed = fetchAllData(entityName: Entities.getBreedsTblEntity) as! [GetBreedsTbl]
        let breedData = fetchBreed.filter{$0.breedId == myArray.breedID }
        if breedData.count > 0 {
            cell.rankLabel.text = breedData[0].alpha2
        } else {
            cell.rankLabel.text = myArray.breed
        }
        if myHerdArray.count > 20 {
            totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with:20)
            
        }else {
            totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: myHerdArray.count)
        }
        if myHerdArray.count == 0
        {
            message.isHidden = false
            tblView.isHidden = true
            headerview.isHidden = true
        }
        if myHerdArray.count != 0
        {
            message.isHidden = true
            tblView.isHidden = false
            headerview.isHidden = false
        }
        
        if status  == LocalizedStrings.banStatus{
            let imag = datasource[indexPath.row]
            cell.groupImage.image = imag.image
            cell.delegate = self
            cell.groupView.layer.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0).cgColor
            cell.groupImage.image = UIImage(named: ImageNames.barnActiveImg)!
            
        } else if status == LocalizedStrings.dollerStatus{
            let imag = datasource[indexPath.row]
            cell.groupImage.image = imag.image
            cell.delegate = self
            cell.groupView.layer.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0).cgColor
            cell.groupImage.image = UIImage(named: ImageNames.dollarActiveImg)!
        } else if  status == LocalizedStrings.inactiveStatus {
            let imag = datasource[indexPath.row]
            cell.groupImage.image = imag.image
            cell.delegate = self
            cell.groupView.layer.backgroundColor  = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0).cgColor
            cell.groupImage.image = UIImage(named: ImageNames.threeDotsInactiveImg)!
        }
        self.view.endEditing(true)
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
        if tableView == autoSuggestTableView {
            var selectedValue = [AutoAnimalList]()
            if searchByEarTag{
                searchTextField.text = viewModel.filterAutoAnimalData[indexPath.row].earTag
                selectedValue = self.viewModel.autoAnimalData.filter({ ($0.earTag ?? "").lowercased().contains(searchTextField.text?.lowercased() ?? "")})
            } else {
                searchTextField.text = viewModel.filterAutoAnimalData[indexPath.row].officialID
                selectedValue = self.viewModel.autoAnimalData.filter({ ($0.officialID ?? "").lowercased().contains(searchTextField.text?.lowercased() ?? "")})
                
            }
            autoSuggestTableView.isHidden = true
            viewModel.filterAutoAnimalData.removeAll()
            viewModel.filterAutoAnimalData = selectedValue
            return
        }
        
        selectedMyHerdArray = self.myHerdArray[indexPath.row]
        selectedIndex = indexPath.row
        tableCellSelected = true
        GetProviderName(animalID: selectedMyHerdArray.animalID ?? "", onfarmID: selectedMyHerdArray.onFarmID ?? "", officialID: selectedMyHerdArray.officialID ?? "", customerId:selectedMyHerdArray.customerId)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.searchTextField.text! == "" {
            if self.myHerdArray.count < 50
            {
                return
            }
            let lastAnimal = self.myHerdArray.count-1
            if indexPath.row == lastAnimal {
                
                if Connectivity.isConnectedToInternet() {
                    
                    if !stopPagination {
                        self.showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncResultsData, comment: ""), and: "")
                        self.view.isUserInteractionEnabled = false
                        self.group.enter()
                        
                    }
                }
            }
        }
    }
}

//MARK: CALL NOTES API AND GET PHOTOS
extension MyHerdResultsByAnimalViewController {
    func getNotesandPhotos(tag:Int){
        let fetchnote = fetchResultnote(entityName: Entities.resultMyherdDataTblEntity ,onFarmID: myHerdArray[tag].onFarmID ?? "", customerId: customerId ?? 0, officialID: myHerdArray[tag].officialID ?? "")
        if fetchnote.count > 0
        {
            let note = fetchnote[0] as?  ResultMyHerdData
            
            let vc = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.notesPhotosViewControllerVC) as! NotesPhotosViewController
            vc.notesStr = note?.notes ?? LocalizedStrings.noNotesAvailable
            if note?.photos != nil {
                vc.photo = UIImage(data: note?.photos as! Data) ?? UIImage.init(named: ImageNames.noImage)!
                vc.photoFound = true
            } else {
                vc.photo = UIImage.init(named: ImageNames.noImage)!
                vc.photoFound = false
            }
            vc.modalPresentationStyle = .overFullScreen
            self.navigationController?.present(vc, animated: false, completion: nil)
        } else {
            getNote(index: tag)
        }
    }
    
    func getNote(index:Int) {
        self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict = [LocalizedStrings.authorizationHeader: accessToken!,LocalizedStrings.contentType : LocalizedStrings.formURLEncoded]
        var animalIDIS = String()
        if UserDefaults.standard.value(forKey: keyValue.groupDetails.rawValue) as? String == keyValue.groupName.rawValue
        {
            let animalidgroup = UserDefaults.standard.value(forKey: keyValue.groupOnAnimalId.rawValue)
            animalIDIS = animalidgroup as? String ?? ""
        }
        else
        {
            animalIDIS = self.myHerdArray[index].animalID ?? ""
        }
        let urlString = Configuration.Dev(packet: ApiKeys.getnotes.rawValue + "/\(animalIDIS)").getUrl()
        print(urlString)
        var request = URLRequest(url: (URL(string: urlString) ?? URL(string: ""))!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headerDict
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        do {
        }
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            
            if statusCode == 200 {
                switch response.result {
                case let .success(value):
                    
                    let groupid = value as? NSDictionary
                    let getnotestext = groupid?.value(forKey:keyValue.notes.rawValue) ?? LocalizedStrings.noNotesAvailable.localized
                    updateNotesAgainstgroupscren(entity: Entities.resultGroupAnimalsTblEntity,custmerId: Int(self.customerId ?? 0) ,onFarmID: self.myHerdArray[index].onFarmID ?? "" ,officialID: self.myHerdArray[index].officialID ?? "" ,notes: getnotestext as? String ?? "")
                    
                    updateNotesAgainstFarmIdOfficalId(entity: Entities.resultMyherdDataTblEntity,custmerId: Int(self.customerId ?? 0) ,onFarmID: self.myHerdArray[index].onFarmID ?? "" ,officialID: self.myHerdArray[index].officialID ?? "",notes: getnotestext as? String ?? "")
                    
                    self.getPhoto(notes: getnotestext as? String ?? "", index: index)
                case let .failure(error):
                    print(error)
                }
                
            } else {
                self.hideIndicator()
            }
            
            if statusCode == 200 {
                DispatchQueue.main.async {
                    self.hideIndicator()
                }
            }
            self.hideIndicator()
        }
    }
    
    func getPhoto(notes:String, index:Int) {
        self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict = [LocalizedStrings.authorizationHeader: accessToken!,LocalizedStrings.contentType : LocalizedStrings.formURLEncoded]
        
        var animalIDIS = String()
        if UserDefaults.standard.value(forKey: keyValue.groupDetails.rawValue) as? String == keyValue.groupName.rawValue
        {
            let animalidgroup = UserDefaults.standard.value(forKey: keyValue.groupOnAnimalId.rawValue)
            animalIDIS = animalidgroup as? String ?? ""
        }
        else
        {
            animalIDIS = self.myHerdArray[index].animalID ?? ""
        }
        let urlString = Configuration.Dev(packet: ApiKeys.getPhotoByAnimalId.rawValue + "/\(animalIDIS)").getUrl()
        print(urlString)
        var request = URLRequest(url: (URL(string: urlString) ?? URL(string: ""))!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headerDict
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        do {
        }
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            if statusCode == 200 {
                switch response.result {
                case let .success(value):
                    let groupid = value as? NSDictionary
                    if groupid?.value(forKey: keyValue.messageKey.rawValue) as! String == LocalizedStrings.noPhotoSaved
                    {
                        if UserDefaults.standard.value(forKey: keyValue.groupDetails.rawValue) as? String == keyValue.groupName.rawValue{
                            updategroupPhotoNil(entity: Entities.resultGroupAnimalsTblEntity,custmerId: Int(self.customerId ?? 0),onFarmID: self.myHerdArray[index].onFarmID ?? "",officialID: self.myHerdArray[index].officialID ?? "")
                        }
                        else
                        {
                            updatePhotoNil(entity: Entities.resultMyherdDataTblEntity,custmerId: Int(self.customerId ?? 0),onFarmID: self.myHerdArray[index].onFarmID ?? "",officialID: self.myHerdArray[index].officialID ?? "")
                        }
                    }
                    
                    else  if groupid?.value(forKey: keyValue.messageKey.rawValue) as! String == "Okay"{
                        
                        let imageBase64 = groupid?.value(forKey: keyValue.photoBase64Encoded.rawValue) as? String ?? ""
                        if imageBase64 != "" {
                            let newImage = self.convertBase64StringToImage(imageBase64String: imageBase64)
                            let img =   newImage
                            
                            if UserDefaults.standard.value(forKey: keyValue.groupDetails.rawValue) as? String == keyValue.groupName.rawValue
                            {
                                updategroupPhotoAgainstFarmIdOfficalId(entity: Entities.resultGroupAnimalsTblEntity,custmerId: Int(self.customerId ?? 0 ),onFarmID: self.myHerdArray[index].onFarmID ?? "",officialID: self.myHerdArray[index].officialID ?? "",photos: img)
                            }
                            else
                            {
                                updatePhotoAgainstFarmIdOfficalId(entity: Entities.resultMyherdDataTblEntity,custmerId: Int(self.customerId ?? 0 ),onFarmID: self.myHerdArray[index].onFarmID ?? "",officialID: self.myHerdArray[index].officialID ?? "",photos: img)
                            }
                            
                            let vc = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.notesPhotosViewControllerVC) as! NotesPhotosViewController
                            vc.notesStr = notes
                            vc.photo = newImage
                            vc.modalPresentationStyle = .overFullScreen
                            self.navigationController?.present(vc, animated: false, completion: nil)
                        }
                    }
                case let .failure(error):
                    print(error)
                }
                
            } else {
                self.hideIndicator()
            }
            
            if statusCode == 200 {
                DispatchQueue.main.async {
                    self.hideIndicator()
                }
            }
            self.hideIndicator()
        }
    }
    
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .ignoreUnknownCharacters)
        let image = UIImage(data: imageData!)
        
        return image!
    }
}

//MARK: IMAGEPICKER CONTROLLER DELEGATE
extension MyHerdResultsByAnimalViewController : UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true, completion: nil)
        if self.searchTextField.tag == 0 {
            self.searchTextField.text = ""
        }
        else{
            self.searchTextField.text = ""
        }
        
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        self.imageView.image = image
        setVisionTextRecognizeImage(image: image)
    }
}

//MARK: OBJECT PICK CART SCREEN EXTENSION
extension MyHerdResultsByAnimalViewController : objectPickCartScreen {
    func objectGetOnSelection(temp: Int) {
    }
}

extension MyHerdResultsByAnimalViewController{
    @IBAction func SelectAllBtnClick(_ sender: Any) {
        myHerdArray  = fetchResultpagenumberMyHerdData(entityName: "ResultMyHerdData",customerId:customerId ?? 0,searchFound: true) as! [ResultMyHerdData]
        if !selectAllSelected  {
            selectAllSelected = true
            selectAllBtnOutlet.setImage(UIImage.init(named: ImageNames.checkImg), for: .normal)
            for animal in myHerdArray{
                updateAnimalSelectedDataResult(entity: "ResultMyHerdData", animalID: animal.animalID ?? "", customerId: Int(animal.customerId), searchbyanimal: true, selectedAnimal: true)
            }
        } else{
            selectAllSelected = false
            selectAllBtnOutlet.setImage(UIImage.init(named: ImageNames.unCheckImg), for: .normal)
            for animal in myHerdArray{
                updateAnimalSelectedDataResult(entity: "ResultMyHerdData", animalID: animal.animalID ?? "", customerId: Int(animal.customerId), searchbyanimal: true, selectedAnimal: false)
            }
            deleteAnimalStackView.isHidden = true
            deletAnimalHeightConstraint.constant = 0
        }
        reloaddata()
        
    }
    @IBAction func deleteAnimalBtnClick(_ sender: Any) {
        myHerdArray  = fetchResultpagenumberMyHerdData(entityName: "ResultMyHerdData",customerId:customerId ?? 0,searchFound: true) as! [ResultMyHerdData]
        let filterHerdanimal = myHerdArray.filter({$0.selectedAnimal })
        if filterHerdanimal.count>0 {
            for animal  in filterHerdanimal {
                deleteDatafromMyHerdAnimal(animal.animalID ?? "")
            }
            reloaddata()
            self.message.text = LocalizedStrings.noRecordFound.localized
            self.view.makeToast(NSLocalizedString("Animal record(s) removed from list successfully.".localized, comment: ""), duration: 1, position: .bottom)
        }
    }
}

//MARK: AUTO POPULATE BULL TABLE
extension MyHerdResultsByAnimalViewController {
    func searchForAutoAnimal (seachText: String) {
        var filteredData = [AutoAnimalList]()
        if searchByEarTag {
            
            filteredData =  self.viewModel.autoAnimalData.filter({ ($0.earTag ?? "").lowercased().contains(seachText.lowercased())})
            
            
        } else {
            filteredData =  self.viewModel.autoAnimalData.filter({ ($0.officialID ?? "").lowercased().contains(seachText.lowercased())})
            
        }
        if filteredData.count == 0{
            self.autoSuggestTableView.isHidden = true
            self.viewModel.filterAutoAnimalData.removeAll()
            self.viewModel.filterAutoAnimalData = filteredData
        } else {
            self.autoSuggestTableView.isHidden = false
            self.viewModel.filterAutoAnimalData.removeAll()
            self.viewModel.filterAutoAnimalData = filteredData
        }
        autoSuggestTableView.reloadData()
    }
    @objc func searchDidChange(sender: UITextField) {
        self.searchForAutoAnimal(seachText: sender.text ?? "")
    }
}
