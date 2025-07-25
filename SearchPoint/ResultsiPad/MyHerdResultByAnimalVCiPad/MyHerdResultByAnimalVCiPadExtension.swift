//
//  MyHerdResultByAnimalVCExtension.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 08/05/25.
//

import Foundation
import UIKit
import Alamofire
import CoreBluetooth

//MARK: CHOOSE PROVIDER DELEGATE
extension MyHerdResultByAnimalVCiPad : chosseProviderDelegate {
    func selectedProviderIndex(providerName: String) {
        UserDefaults.standard.set(providerName, forKey: keyValue.selectedProviderName.rawValue)
        self.navigateToIndivisualController(productNameStr: providerName)
    }
}

//MARK: GET PROVIDER NAMES
extension MyHerdResultByAnimalVCiPad {
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
extension MyHerdResultByAnimalVCiPad : ResultFoundDelegate {
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

          //  self.view.makeToast(NSLocalizedString(LocalizedStrings.noResultFoundYet.localized, comment: ""), duration: 3, position: .bottom)
        }
    }
}

//MARK: SCANNED OCR PROTOCOL
extension MyHerdResultByAnimalVCiPad: scannedOCRProtocol {
    func ocrDetected(_ scannedResult: String) {
        self.scannedString = scannedResult
        searchTextField.text = scannedResult
    }
}

//MARK: SIDE MENU UI AND RFID SCANNER
extension MyHerdResultByAnimalVCiPad : SideMenuUI,RFID,nearByDevice{
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

//MARK: OFFLINE CUSTOM VIEW EXTENSION
extension MyHerdResultByAnimalVCiPad:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

//MARK: TABLEVIEW DATASOURCE AND DELEGATES
extension MyHerdResultByAnimalVCiPad:UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if myHerdArray.count >= 20 {
            return 20
        }
        return myHerdArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 270, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if UIDevice().userInterfaceIdiom == .pad {
            return 15
            
        }
        else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : MyHerdCollectionViewCelliPad = self.resultCollectionView.dequeueReusableCell(withReuseIdentifier: "MyHerdCollectionViewCelliPad", for: indexPath as IndexPath) as! MyHerdCollectionViewCelliPad
        
      //  let cell: MyHerdTblCell = self.tblView.dequeueReusableCell(withIdentifier: "MyHerdTblCell", for: indexPath) as! MyHerdTblCell
        cell.isDetailScreen = false
        cell.contentView.layer.borderWidth = 0
        cell.layer.cornerRadius = 15
        cell.contentView.layer.cornerRadius = 15
        cell.contentView.clipsToBounds = true
        cell.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell.layer.shadowOpacity = 0.7
        cell.layer.shadowRadius = 6
        cell.layer.masksToBounds = false
        let myArray = self.myHerdArray[indexPath.row]
        cell.tag = indexPath.row
        if myArray.selectedAnimal == true {
         //   cell.selectedBackroundView.isHidden = false
        } else {
         //   cell.selectedBackroundView.isHidden = true
        }
        cell.delegate = self
        let dob = myArray.dob ?? ""
        let dateonly = dob.components(separatedBy: " ")
        cell.dobLabel.text = "\(dateonly[0])"
        
        if myArray.notes == "" && myArray.photos == nil{
            cell.notesImgView.isHidden = true
          //  cell.Label1.isHidden = false
        } else {
            cell.notesImgView.isHidden = false
         //   cell.Label1.isHidden = true
        }
        
        cell.notesImgView.isUserInteractionEnabled = true
        cell.notesImgView.tag = indexPath.row
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        cell.notesImgView.addGestureRecognizer(tap)
        let status = myArray.status ?? ""
        
        if !searchByEarTag {
            cell.idLabel.text = LocalizedStrings.officialIDText.localized
            cell.officialIdLabel.text = myArray.officialID ?? ""
        }
        else
        {
            cell.idLabel.text = ButtonTitles.earTagText.localized
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
//            tblView.isHidden = true
//            headerview.isHidden = true
            resultCollectionView.isHidden = true
        }
        if myHerdArray.count != 0
        {
            message.isHidden = true
           // tblView.isHidden = false
            resultCollectionView.isHidden = false
          //  headerview.isHidden = false
        }
        
        if status  == LocalizedStrings.banStatus{
            let imag = datasource[indexPath.row]
            cell.groupImage.image = imag.image
         //   cell.delegate = self
         //   cell.groupView.layer.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0).cgColor
            cell.groupImage.image = UIImage(named: "barnImage")!
            cell.groupNameLabel.text = "Barn"
            
        } else if status == LocalizedStrings.dollerStatus{
            let imag = datasource[indexPath.row]
            cell.groupImage.image = imag.image
        //    cell.delegate = self
          //  cell.groupView.layer.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0).cgColor
            cell.groupImage.image = UIImage(named: "dollarImage")!
            cell.groupNameLabel.text = "Dollar"
        } else if  status == LocalizedStrings.inactiveStatus {
            let imag = datasource[indexPath.row]
            cell.groupImage.image = imag.image
         //   cell.delegate = self
          //  cell.groupView.layer.backgroundColor  = UIColor(red: 220/255, green: 220/255, //blue: //220/255, alpha: 1.0).cgColor
            cell.groupImage.image = UIImage(named: "resultsNAImage")!
            cell.groupNameLabel.text = "N/A"
        }
        cell.barnAction = { [unowned self] ( error) in
            if cell.groupNameLabel.text == "Barn" {
                return
            }
            let dataObject = self.myHerdArray[indexPath.row]
            let animalId = dataObject.animalID ?? ""
            let status = dataObject.status ?? ""
            let onfarmid = dataObject.onFarmID ?? ""
            let officialID = dataObject.officialID ?? ""
            
            let fetchActiveBarnExist = fetchGroupExistInDataBase(entityName: Entities.resultGroupCreateTblEntity, groupStatusId: 1, groupTypeId: 1, customerId: Int64(customerId ?? 0))
            if fetchActiveBarnExist.count == 0  {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.noActiveBarn, comment: "") )
                return
            } else {
                let fetchObject = fetchActiveBarnExist.object(at: 0) as! ResultGroupCreate
                let groupServerId = fetchObject.groupServerId ?? ""
                let data = fetchGroupIdupdateanimal(entityName: Entities.resultGroupAnimalsTblEntity, customerId:Int64(self.customerId ?? 0), groupTypeId: 0 ,onFarmId:onfarmid, officialID: officialID)
                
                if data.count > 0
                {
                    let datafetch = data.object(at: 0) as! ResultGroupsAnimals
                    let groupstatus = datafetch.groupStatusId
                    if groupstatus != 0{
                        self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                        removeAnimalInGroup(groupId: datafetch.serverGroupId ?? "", animalIds: animalId, completionHandler: { (result) in
                            if result == true{
                                _ = deletGroupInfoResultGroupDetail(entityName: Entities.resultGroupAnimalsTblEntity, groupName:datafetch.groupName ?? "", customerId: Int64(self.customerId ?? 0), onFarmId: datafetch.onFarmId ?? "", officalId: datafetch.officalId ?? "")
                            }
                        })
                    }
                }
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: LocalizedStrings.en_US_POSIXStr)
                dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                
                let date:Date? = dateFormatter.date(from:dataObject.dob ?? "")
                saveAnimaldataResult(entity: Entities.resultGroupAnimalsTblEntity, serverGroupId: groupServerId, groupName: fetchObject.groupName ?? "", groupStatusId: Int(fetchObject.groupStatusId), groupStatus: fetchObject.groupStatus ?? "", groupTypeId: Int(fetchObject.groupTypeId), groupTypeName: fetchObject.groupTypeName ?? "", animalID: animalId , onFarmId: dataObject.onFarmID ?? "", officalId: dataObject.officialID ?? "", dob: dataObject.dob ?? "", sex: dataObject.sex ?? "", breedId: dataObject.breedID ?? "", breedName: dataObject.breed ?? "", name: dataObject.name ?? "", groupId: 0, customerId: dataObject.customerId,datedob:date ?? Date())
                
                updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ?? 0), animalID: animalId, status: LocalizedStrings.banStatus)
                cell.groupImage.image = UIImage(named: "barnImage")!
                cell.groupNameLabel.text = "Barn"
            }
            self.hideIndicator()
        }
        
        cell.dollarAction = { [unowned self] ( error) in
            if cell.groupNameLabel.text == "Dollar" {
                return
            }
            let dataObject = datasource[indexPath.row].name
            let animalId = dataObject[0].animalID ?? ""
            let status = dataObject[0].status ?? ""
            let onfarmid = dataObject[0].onFarmID ?? ""
            let officialID = dataObject[0].officialID ?? ""
            let fetchActiveBarnExist = fetchGroupExistInDataBase(entityName: Entities.resultGroupCreateTblEntity, groupStatusId: 1, groupTypeId: 0, customerId: Int64(customerId ?? 0))
            
            if fetchActiveBarnExist.count == 0  {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(LocalizedStrings.noActiveDoller, comment: "") )
                return
            } else {
                let fetchObject = fetchActiveBarnExist.object(at: 0) as! ResultGroupCreate
                let groupServerId = fetchObject.groupServerId ?? ""
                let data = fetchGroupIdupdateanimal(entityName: Entities.resultGroupAnimalsTblEntity, customerId:Int64(self.customerId ?? 0), groupTypeId: 1,onFarmId:onfarmid, officialID: officialID)
                if data.count > 0{
                    let datafetch = data.object(at: 0) as! ResultGroupsAnimals
                    let groupstatus = datafetch.groupStatusId
                    if groupstatus != 0{
                        self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                        removeAnimalInGroup(groupId: datafetch.serverGroupId ?? "", animalIds: animalId, completionHandler: { (result) in
                            if result == true{
                                
                                _ = deletGroupInfoResultGroupDetail(entityName: Entities.resultGroupAnimalsTblEntity, groupName:datafetch.groupName ?? "", customerId: Int64(self.customerId ?? 0), onFarmId: datafetch.onFarmId ?? "", officalId: datafetch.officalId ?? "")
                            }
                        })
                    }
                }
                
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: LocalizedStrings.en_US_POSIXStr)
                dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                let date:Date? = dateFormatter.date(from:dataObject[0].dob ?? "")
                saveAnimaldataResult(entity: Entities.resultGroupAnimalsTblEntity, serverGroupId: groupServerId, groupName: fetchObject.groupName ?? "", groupStatusId: Int(fetchObject.groupStatusId), groupStatus: fetchObject.groupStatus ?? "", groupTypeId: Int(fetchObject.groupTypeId), groupTypeName: fetchObject.groupTypeName ?? "", animalID: animalId , onFarmId: dataObject[0].onFarmID ?? "", officalId: dataObject[0].officialID ?? "", dob: dataObject[0].dob ?? "", sex: dataObject[0].sex ?? "", breedId: dataObject[0].breedID ?? "", breedName: dataObject[0].breed ?? "", name: dataObject[0].name ?? "", groupId: 0, customerId: dataObject[0].customerId, datedob: date ?? Date())
                
                updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ?? 0), animalID: animalId, status: LocalizedStrings.dollerStatus)
                cell.groupImage.image = UIImage(named: "dollarImage")!
                cell.groupNameLabel.text = "Dollar"
            }
            self.hideIndicator()
        }
        
        cell.unAssignedAction = { [unowned self] ( error) in
            if cell.groupNameLabel.text == "N/A" {
                return
            }
            let dataObject = self.myHerdArray[indexPath.row]
            let animalId = dataObject.animalID ?? ""
            let status = dataObject.status ?? ""
            let onfarmid = dataObject.onFarmID ?? ""
            let officialID = dataObject.officialID ?? ""
            
            let fetchActiveBarnExist = fetchGroupExistInDataBase(entityName: Entities.resultGroupCreateTblEntity, groupStatusId: 1, groupTypeId: 1, customerId: Int64(customerId ?? 0))
            
            if fetchActiveBarnExist.count == 0  {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(LocalizedStrings.noActiveDoller, comment: "") )
                return
            } else {
                
                let fetchObject = fetchActiveBarnExist.object(at: 0) as! ResultGroupCreate
                let groupServerId = fetchObject.groupServerId ?? ""
                if status == LocalizedStrings.banStatus  {
                    self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                    removeAnimalInGroup(groupId: fetchObject.groupServerId ?? "", animalIds: animalId, completionHandler: { (result) in
                        if result == true{
                            _ = deletGroupInfoResultGroupDetail(entityName: Entities.resultGroupAnimalsTblEntity, groupName:fetchObject.groupName ?? "", customerId: Int64(self.customerId ?? 0), onFarmId: dataObject.onFarmID ?? "", officalId: dataObject.officialID ?? "")
                            
                            updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ?? 0), animalID: animalId, status: LocalizedStrings.inactiveStatus)
                        }
                    })
                    self.myHerdArray = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:customerId ?? 0,searchFound: true) as! [ResultMyHerdData]
                    cell.groupImage.image = UIImage(named: "resultsNAImage")!
                    cell.groupNameLabel.text = "N/A"
                } else {
                    let dataObject = datasource[indexPath.row].name
                    let animalId = dataObject[0].animalID ?? ""
                    let status = dataObject[0].status ?? ""
                    let onfarmid = dataObject[0].onFarmID ?? ""
                    let officialID = dataObject[0].officialID ?? ""
                    let fetchActiveBarnExist = fetchGroupExistInDataBase(entityName: Entities.resultGroupCreateTblEntity, groupStatusId: 1, groupTypeId: 0, customerId: Int64(customerId ?? 0))
                    updateMyHerdData(entity: Entities.resultMyherdDataTblEntity, customerId : Int64(self.customerId ?? 0) ,animalID : animalId ,groupIDs : groupServerId)
                    self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                    removeAnimalInGroup(groupId: fetchObject.groupServerId ?? "", animalIds: animalId, completionHandler: { (result) in
                        if result == true{
                            _ = deletGroupInfoResultGroupDetail(entityName: Entities.resultGroupAnimalsTblEntity, groupName:fetchObject.groupName ?? "", customerId: dataObject[0].customerId, onFarmId: dataObject[0].onFarmID ?? "", officalId: dataObject[0].officialID ?? "")
                        }
                    })
                    
                    updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ?? 0), animalID: animalId, status: LocalizedStrings.inactiveStatus)
                    self.myHerdArray = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:customerId ?? 0,searchFound: true) as! [ResultMyHerdData]
                    cell.groupImage.image = UIImage(named: "resultsNAImage")!
                    cell.groupNameLabel.text = "N/A"
                }
            }
            self.hideIndicator()
        }
        
        self.view.endEditing(true)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = UIStoryboard.init(name: "Results", bundle: Bundle.main).instantiateViewController(withIdentifier: "IndividualAnimalResultsVCiPad") as? IndividualAnimalResultsVCiPad
//        vc?.checkCOntroller = LocalizedStrings.resultController
//        vc?.backScreenClickIndex = indexPath.row
//        vc?.getMyHerdArray = myHerdArray
//        vc?.productName =
//        let offlicalidmyherd = myHerdArray[indexPath.row].officialID
//        let onfarmid = myHerdArray[indexPath.row].onFarmID
//        UserDefaults.standard.set(offlicalidmyherd, forKey: keyValue.myHerdOfficalid.rawValue)
//        UserDefaults.standard.set(onfarmid, forKey: keyValue.myHerdOnfarmId.rawValue)
//        UserDefaults.standard.set(myHerdArray[indexPath.row].breedID, forKey: keyValue.selectedAnimalBreedID.rawValue)
//        searchTextField.text = ""
//        let fetchObject = fetchAnimalAssignExistIntable(entityName: Entities.resultGroupAnimalsTblEntity,customerId: customerId ?? 0,animalId: myHerdArray[indexPath.row].animalID ?? "") as! [ResultGroupsAnimals]
//        var filterGroup = [ResultGroupsAnimals]()
//        if fetchObject.count != 0 {
//            let animalGroup = myHerdArray[indexPath.row].status
//            if animalGroup == LocalizedStrings.dollerStatus{
//                filterGroup =  fetchObject.filter{$0.groupTypeName == LocalizedStrings.dollarGroupType && $0.groupStatus == LocalizedStrings.activeGroupType}
//            }
//            else {
//                filterGroup =  fetchObject.filter{$0.groupTypeName == LocalizedStrings.barnGroupType && $0.groupStatus == LocalizedStrings.activeGroupType}
//            }
//            
//            if filterGroup.count > 0{
//                let resultGrpObject = filterGroup[0]
//                let groupStatusId = resultGrpObject.groupStatusId
//                let groupTypeId = resultGrpObject.groupTypeId
//                let groupname = resultGrpObject.groupName
//                UserDefaults.standard.setValue(groupname, forKey: keyValue.groupName.rawValue)
//                
//                if groupStatusId == 1 && groupTypeId == 1 {
//                    UserDefaults.standard.setValue(ImageNames.barnActiveImg, forKey: keyValue.radioButtonCheck.rawValue)
//                }
//                else if groupStatusId == 1 && groupTypeId == 0 {
//                    UserDefaults.standard.setValue(ImageNames.dollarActiveImg, forKey: keyValue.radioButtonCheck.rawValue)
//                    
//                }
//                else {
//                    UserDefaults.standard.setValue(ImageNames.threeDotsInactiveImg, forKey: keyValue.radioButtonCheck.rawValue)
//                }
//            }
//        }
//        else{
//            UserDefaults.standard.setValue("NA", forKey: keyValue.groupName.rawValue)
//            UserDefaults.standard.setValue(ImageNames.threeDotsInactiveImg, forKey: keyValue.radioButtonCheck.rawValue)
//        }
        selectedMyHerdArray = self.myHerdArray[indexPath.row]
        selectedIndex = indexPath.row
        GetProviderName(animalID: selectedMyHerdArray.animalID ?? "", onfarmID: selectedMyHerdArray.onFarmID ?? "", officialID: selectedMyHerdArray.officialID ?? "", customerId:selectedMyHerdArray.customerId)
       // self.navigationController?.pushViewController(vc!, animated: true)
    }
}

//MARK: TABLEVIEW DATASOURCE AND DELEGATES
extension MyHerdResultByAnimalVCiPad:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == AutoSuggestionTableView {
            return 300
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
            cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
            if viewModel.filterAutoAnimalData.count > 0 {
                if searchByEarTag{
                    cell.textLabel?.text =  viewModel.filterAutoAnimalData[indexPath.row].earTag
                } else {
                    cell.textLabel?.text =  viewModel.filterAutoAnimalData[indexPath.row].officialID
                }
            }

            return cell
        }
        
    //    if tableView == pairedTableView {
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
            
     //   }
        
//        let cell: MyHerdTblCell = self.tblView.dequeueReusableCell(withIdentifier: "MyHerdTblCell", for: indexPath) as! MyHerdTblCell
//        let myArray = self.myHerdArray[indexPath.row]
//        cell.tag = indexPath.row
//        if myArray.selectedAnimal == true {
//            cell.selectedBackroundView.isHidden = false
//        } else {
//            cell.selectedBackroundView.isHidden = true
//        }
//        cell.delegate = self
//        let dob = myArray.dob ?? ""
//        let dateonly = dob.components(separatedBy: " ")
//        cell.dobLabel.text = "    \(dateonly[0])"
//        
//        if myArray.notes == "" && myArray.photos == nil{
//            cell.notesImgView.isHidden = true
//            cell.Label1.isHidden = false
//        } else {
//            cell.notesImgView.isHidden = false
//            cell.Label1.isHidden = true
//        }
//        
//        cell.notesImgView.isUserInteractionEnabled = true
//        cell.notesImgView.tag = indexPath.row
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
//        cell.notesImgView.addGestureRecognizer(tap)
//        let status = myArray.status ?? ""
//        
//        if !searchByEarTag {
//            self.officalIdLabel.text = LocalizedStrings.officialIDText.localized
//            cell.officialIdLabel.text = myArray.officialID ?? ""
//        }
//        else
//        {
//            self.officalIdLabel.text = ButtonTitles.earTagText.localized
//            cell.officialIdLabel.text = myArray.onFarmID ?? ""
//        }
//        let fetchBreed = fetchAllData(entityName: Entities.getBreedsTblEntity) as! [GetBreedsTbl]
//        let breedData = fetchBreed.filter{$0.breedId == myArray.breedID }
//        if breedData.count > 0 {
//            cell.rankLabel.text = breedData[0].alpha2
//        } else {
//            cell.rankLabel.text = myArray.breed
//        }
//        if myHerdArray.count > 20 {
//            totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with:20)
//            
//        }else {
//            totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: myHerdArray.count)
//        }
//        if myHerdArray.count == 0
//        {
//            message.isHidden = false
//            tblView.isHidden = true
//            headerview.isHidden = true
//        }
//        if myHerdArray.count != 0
//        {
//            message.isHidden = true
//            tblView.isHidden = false
//            headerview.isHidden = false
//        }
//        
//        if status  == LocalizedStrings.banStatus{
//            let imag = datasource[indexPath.row]
//            cell.groupImage.image = imag.image
//            cell.delegate = self
//            cell.groupView.layer.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0).cgColor
//            cell.groupImage.image = UIImage(named: ImageNames.barnActiveImg)!
//            
//        } else if status == LocalizedStrings.dollerStatus{
//            let imag = datasource[indexPath.row]
//            cell.groupImage.image = imag.image
//            cell.delegate = self
//            cell.groupView.layer.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0).cgColor
//            cell.groupImage.image = UIImage(named: ImageNames.dollarActiveImg)!
//        } else if  status == LocalizedStrings.inactiveStatus {
//            let imag = datasource[indexPath.row]
//            cell.groupImage.image = imag.image
//            cell.delegate = self
//            cell.groupView.layer.backgroundColor  = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0).cgColor
//            cell.groupImage.image = UIImage(named: ImageNames.threeDotsInactiveImg)!
//        }
//        self.view.endEditing(true)
//        return cell
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
extension MyHerdResultByAnimalVCiPad {
    func getNotesandPhotos(tag:Int){
        let fetchnote = fetchResultnote(entityName: Entities.resultMyherdDataTblEntity ,onFarmID: myHerdArray[tag].onFarmID ?? "", customerId: customerId ?? 0, officialID: myHerdArray[tag].officialID ?? "")
        if fetchnote.count > 0
        {
            let note = fetchnote[0] as?  ResultMyHerdData
            let storyboard = UIStoryboard(name: "Results", bundle: Bundle.main)
            let vc = storyboard.instantiateViewController(withIdentifier: "NotesPhotosVCiPad") as! NotesPhotosVCiPad
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
                            let storyboard = UIStoryboard(name: "Results", bundle: Bundle.main)
                            let vc = storyboard.instantiateViewController(withIdentifier: "NotesPhotosVCiPad") as! NotesPhotosVCiPad
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
extension MyHerdResultByAnimalVCiPad : UIImagePickerControllerDelegate & UINavigationControllerDelegate {
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
extension MyHerdResultByAnimalVCiPad : objectPickCartScreen {
    func objectGetOnSelection(temp: Int) {
    }
}

//1.10
extension MyHerdResultByAnimalVCiPad{
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
            collectionViewTopConstraint.constant = 83
            // unselect all code
        }
        Reloaddata()
        
    }
    @IBAction func deleteAnimalBtnClick(_ sender: Any) {
        myHerdArray  = fetchResultpagenumberMyHerdData(entityName: "ResultMyHerdData",customerId:customerId ?? 0,searchFound: true) as! [ResultMyHerdData]
        let filterHerdanimal = myHerdArray.filter({$0.selectedAnimal == true })
        if filterHerdanimal.count>0 {
            for animal  in filterHerdanimal {
                deleteDatafromMyHerdAnimal(animal.animalID ?? "")
            }
            Reloaddata()
            self.message.text = LocalizedStrings.noRecordFound.localized
            self.view.makeToast(NSLocalizedString("Animal record(s) removed from list successfully.".localized, comment: ""), duration: 1, position: .bottom)
        }
    }
}

//MARK: AUTO POPULATE BULL TABLE
extension MyHerdResultByAnimalVCiPad {
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
//        autoSuggestTableView.dataSource = self
//        autoSuggestTableView.delegate = self
        autoSuggestTableView.reloadData()
    }
    @objc func searchDidChange(sender: UITextField) {
        self.searchForAutoAnimal(seachText: sender.text ?? "")
    }
}
