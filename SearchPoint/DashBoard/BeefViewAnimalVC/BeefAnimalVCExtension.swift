//
//  BeefAnimalVCExtension.swift
//  SearchPoint
//
//  Created by Mobile Programming on 02/03/24.
//

import Foundation
import UIKit
import Alamofire

//MARK: TABLEVIEW DATASOURCE AND DELEGATES
extension BeefViewAnimalVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewAnimalArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        if pvid == 5 || pvid == 13{
            return 80
        }
        else if pvid == 7  {
            return 100
        }
        else if pvid == 6 {
            return 194
        }
        else{
            return 150
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ViewAnimalCell = self.tblView.dequeueReusableCell(withIdentifier: ClassIdentifiers.beefCartCell) as! ViewAnimalCell
        let animalVal  =  viewAnimalArray[indexPath.row] as! BeefAnimaladdTbl
        
        if  UserDefaults.standard.object(forKey: keyValue.chkValue.rawValue    ) as? String == "true" {
            if animalVal.isUpadte == "true"{
                if  animalVal.ageConf == "true" {
                    cell.sampleconLbl.text = ButtonTitles.ageLess35Days
                }
                else if animalVal.bothConf == "true" {
                    cell.sampleconLbl.text = ButtonTitles.differentSampleTypeAndAge
                }
                else if animalVal.sampTypeConf == "true" {
                    cell.sampleconLbl.text = ButtonTitles.differentSampleType
                }
                
                cell.innnerView.layer.borderColor = UIColor.red.cgColor
            }
            else{
                cell.innnerView.layer.borderColor = UIColor.clear.cgColor
            }
        }
        
        cell.barcodetitle.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        if pvid == 5{
            cell.officialIdLbl.text = animalVal.animalTag
            cell.farmIDLbl.text = animalVal.farmId
            cell.barcodeLbl.text = animalVal.animalbarCodeTag
          if animalVal.animalTag == "" || animalVal.animalTag ==  nil{
            cell.innnerView.layer.borderColor = UIColor.red.cgColor
          }
           else if animalVal.animalbarCodeTag == "" || animalVal.animalbarCodeTag == nil {
                cell.innnerView.layer.borderColor = UIColor.red.cgColor
            }
            else {
                cell.innnerView.layer.borderColor = UIColor.clear.cgColor
            }
            cell.rgnLbl.isHidden = true
            cell.rgdTitleLabel.isHidden = true
            cell.rgdColonLbl.isHidden = true
        }
        
        if pvid == 7{
            cell.earTagLbl.text = NSLocalizedString(LocalizedStrings.animalTagTattoo, comment: "")
            cell.officialIdLbl.text = animalVal.animalTag
            cell.farmIDLbl.text = animalVal.farmId
            cell.barcodeLbl.text = animalVal.animalbarCodeTag
            if animalVal.animalbarCodeTag == "" || animalVal.animalbarCodeTag == nil {
                cell.innnerView.layer.borderColor = UIColor.red.cgColor
            }
            else {
                cell.innnerView.layer.borderColor = UIColor.clear.cgColor
            }
        }
        
        if pvid == 6 {
            cell.setViewForBeef()
            cell.dobTtileLbl.isHidden = false
            cell.dobTitle.isHidden = false
            cell.dobColonLbl.isHidden = false
            cell.sexTitle.isHidden = false
            cell.sexTitleLbl.isHidden = false
            cell.sexColonLbl.isHidden = false
            cell.earTagLbl.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
            cell.officialIdLbl.text = animalVal.animalTag
            cell.barcodetitle.text = NSLocalizedString(LocalizedStrings.seriesText, comment: "")
            cell.barcodeLbl.text = animalVal.offsireId
            cell.rgnLbl.text = animalVal.offPermanentId
            cell.rgdLbl.text = animalVal.offDamId
            cell.rgdTitleLabel.text  = NSLocalizedString(LocalizedStrings.RGDorAnimalIDText, comment: "")
            cell.rgnTitle.text = NSLocalizedString(LocalizedStrings.RGNText, comment: "")
            cell.dobTtileLbl.text  = NSLocalizedString("DOB", comment: "")
            cell.dobTitle.text = animalVal.date != "" ? animalVal.date : NSLocalizedString("N/A", comment: "")
            cell.sexTitleLbl.text = NSLocalizedString(ButtonTitles.sexTest, comment: "")
            if animalVal.gender == NSLocalizedString(ButtonTitles.femaleText, comment: "")  ||  animalVal.gender == ButtonTitles.femaleText   {
                cell.sexTitle.text =  "F"
            }  else {
                cell.sexTitle.text =  "M"
            }
            if animalVal.animalTag == "" || animalVal.animalTag == nil {
                cell.innnerView.layer.borderColor = UIColor.red.cgColor
            }
            else {
                cell.innnerView.layer.borderColor = UIColor.clear.cgColor
            }
        }
        
        if pvid == 13 {
            cell.earTagLbl.text = NSLocalizedString(ButtonTitles.uniqueIdText, comment: "")
            cell.officialIdLbl.text = animalVal.animalTag
            cell.barcodetitle.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
            cell.barcodeLbl.text = animalVal.animalbarCodeTag
            if animalVal.animalbarCodeTag == "" || animalVal.animalbarCodeTag == nil {
                cell.innnerView.layer.borderColor = UIColor.red.cgColor
            }
            else if animalVal.animalTag?.count ?? 0 < 15 ||  animalVal.animalTag?.count ?? 0 > 16 {
                cell.innnerView.layer.borderColor = UIColor.red.cgColor
            }
            else {
                cell.innnerView.layer.borderColor = UIColor.clear.cgColor
            }
            cell.rgnLbl.text = animalVal.sireIDAU
            cell.rgnTitle.text = "Visual ID".localized
            cell.rgdColonLbl.isHidden = false
            cell.sexTitleLbl.isHidden = true
            cell.sexTitle.isHidden = true
            cell.dobTtileLbl.isHidden = true
            cell.dobTitle.isHidden = true
        }
        cell.innnerView.layer.borderWidth = 1
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete".localized
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animalVal  =  viewAnimalArray[indexPath.row] as! BeefAnimaladdTbl
        self.delegateCustom?.objectGetOnSelection(temp: Int(animalVal.animalId))
        UserDefaults.standard.set(Int(animalVal.animalId), forKey: keyValue.beefAnimalIdSelectionCart.rawValue)
        UserDefaults.standard.set(true, forKey: keyValue.isAnimalClickedFromBeefCart.rawValue)
        
        if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 5  {
            let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.beefAnimalGlobalHD50KVC) as! BeefAnimalGlobalHD50KVC
            vc.isAnimalComingFromCart = true
            navigationController?.pushViewController(vc,animated: false)
        } else if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 6 {
            let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.beefAnimalBrazilVC) as! BeefAnimalBrazilVC
            navigationController?.pushViewController(vc,animated: false)
        } else if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 13 {
            let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.beefUSAddAnimalVC) as! BeefUSAddAnimalVC
            vc.isAnimalComingFromCart = true
            navigationController?.pushViewController(vc,animated: false)
        } else {
            let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.beefAnimalNZVC) as! BeefAnimalNZ_VC
            navigationController?.pushViewController(vc,animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let refreshAlert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(LocalizedStrings.removeAnimalFromOrder, comment: ""), preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
        }))
        refreshAlert.addAction(UIAlertAction(title:NSLocalizedString("Yes", comment: "") , style: .default, handler: { (action: UIAlertAction!) in
            
            if editingStyle == .delete {
                let animalVal  =  self.viewAnimalArray[indexPath.row] as! BeefAnimaladdTbl
                BeefDeleteDataWithProduct(Int(animalVal.animalId))
                beefDeleteDataWithSubProduct(Int(animalVal.animalId))
                beefDeleteDataWithAnimal(Int(animalVal.animalId))
                self.deleteSigalAnimalFromList(index: indexPath.row)
                self.viewAnimalArray =  beefFetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", pvid: self.pvid)
                self.notificationLblCount.text = String(self.viewAnimalArray.count)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.removedAnimalSuccessfully, comment: ""), duration: 1, position: .bottom)
                
                if self.viewAnimalArray.count == 0 {
                    self.createListNameAndCheckifExist()
                    deleteDataProduct(entityName:Entities.beefAnimalAddTblEntity,status:"false")
                    deleteDataProduct(entityName:Entities.productAdonAnimlBeefTblEntity,status:"false")
                    deleteDataProduct(entityName:Entities.subProductBeefTblEntity, status: "false")
                    UserDefaults.standard.removeObject(forKey: keyValue.identifyStore.rawValue)
                    UserDefaults.standard.removeObject(forKey: keyValue.productCount.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.onKey.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.page.rawValue)
                    UserDefaults.standard.set("", forKey: keyValue.nzBeefTSU.rawValue)
                    UserDefaults.standard.set("", forKey: keyValue.genotypeTissueBttn.rawValue)
                    updateProductTablStatus(entity: Entities.getProductBeefTblEntity)
                    updateProductTablStatus(entity: Entities.getAdonTblEntity)
                    UserDefaults.standard.removeObject(forKey: keyValue.pidKey.rawValue)
                    UserDefaults.standard.removeObject(forKey: keyValue.beefBreed.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.beefTSU.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.inheritBeefbreed.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.beefInheritTSU.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.inheritBeefbreedClear.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.beefInheritTsuClear.rawValue)
                    UserDefaults.standard.set("", forKey: keyValue.nzBeeftsuClear.rawValue)
                    UserDefaults.standard.setValue(nil, forKey: keyValue.beefbreedClear.rawValue)
                    UserDefaults.standard.setValue(nil, forKey: keyValue.beeftsuClear.rawValue)
                    UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
                    UserDefaults.standard.removeObject(forKey: keyValue.primaryGenoType.rawValue)
                    UserDefaults.standard.removeObject(forKey: keyValue.secondaryGenoType.rawValue)
                    UserDefaults.standard.removeObject(forKey: keyValue.tertirayGenoType.rawValue)
                    UserDefaults.standard.removeObject(forKey: keyValue.dataListPrimaryGenoType.rawValue)
                    UserDefaults.standard.removeObject(forKey: keyValue.dataListSecondaryGenoType.rawValue)
                    UserDefaults.standard.removeObject(forKey: keyValue.dataListTertirayGenoType.rawValue)
                    UserDefaults.standard.removeObject(forKey: keyValue.beefBreedID.rawValue)
                    UserDefaults.standard.removeObject(forKey: keyValue.beefBreedName.rawValue)
                    UserDefaults.standard.removeObject(forKey: keyValue.dataBeefBreedID.rawValue)
                    UserDefaults.standard.removeObject(forKey: keyValue.dataBeefBreedName.rawValue)
                    UserDefaults.standard.removeObject(forKey: keyValue.GenoBeefBreedName.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.beefbreedClear.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.inheritBeefbreedClear.rawValue)
                    UserDefaults.standard.set(nil, forKey: keyValue.beefInheritTsuClear.rawValue)
                    UserDefaults.standard.setValue(nil, forKey: keyValue.beefbreedClear.rawValue)
                    UserDefaults.standard.setValue(nil, forKey: keyValue.beeftsuClear.rawValue)
                    UserDefaults.standard.set("", forKey: keyValue.nzBeeftsuClear.rawValue)
                    UserDefaults.standard.set("", forKey: keyValue.tissueBttnClear.rawValue)
                    UserDefaults.standard.set("", forKey: keyValue.genotypeTissueBttnClear.rawValue)
                    UserDefaults.standard.set("", forKey: keyValue.emailFlag.rawValue)
                    UserDefaults.standard.set("", forKey: keyValue.submitFlag.rawValue)
                    UserDefaults.standard.set(false, forKey: keyValue.beefBVDVSeleted.rawValue)
                    UserDefaults.standard.set(true, forKey: keyValue.showBeefProductTbl.rawValue)
                    UserDefaults.standard.set(true, forKey: keyValue.showbeefInheritTable.rawValue)
                    deleteRecordFromDatabase(entityName: Entities.getProductBeefTblEntity)
                    deleteRecordFromDatabase(entityName: Entities.productAdonAnimlBeefTblEntity)
                    deleteRecordFromDatabase(entityName: Entities.subProductBeefTblEntity)
                    deleteRecordFromDatabase(entityName: Entities.selectedQuesTblEntity)
                    UserDefaults.standard.set(false, forKey: keyValue.isAgreeForSubmit.rawValue)
                    UserDefaults.standard.set(nil, forKey: "InheritBeefGender")
                    UserDefaults.standard.set(nil, forKey: "GenoGender")
                    UserDefaults.standard.set(nil, forKey: "NonGenoGender")
                    UserDefaults.standard.set(nil, forKey: "DEInheritBeef")
                    UserDefaults.standard.set(nil, forKey: "DEGenoGender")
                    UserDefaults.standard.set(nil, forKey: "DENonGenoGender")
                    self.bckBtnOutlet.isEnabled = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        self.sideMenuViewController?.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
                    }
                    self.cartBttnOutlet.isHidden = true
                    self.notificationLblCount.isHidden = true
                    self.clearOrderOutlet.isHidden = true
                    self.noAnimalToast.isHidden = false
                    self.cartImage.isHidden = false
                }
                else {
                    self.noAnimalToast.isHidden = true
                    self.cartBttnOutlet.isHidden = false
                    self.notificationLblCount.isHidden = false
                    self.clearOrderOutlet.isHidden = false
                    self.cartImage.isHidden = true
                }
                tableView.reloadData()
            }
            else if editingStyle == .insert {
            }
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
}

//MARK: SYNC API DELEGATES
private typealias SyncApiHelper = BeefViewAnimalVC
extension SyncApiHelper : syncApi {
    func failWithError(statusCode: Int) {
        self.hideIndicator()
    }
    
    func failWithErrorInternal() {
        self.hideIndicator()
    }
    
    func didFinishApi(response: String) {
        self.hideIndicator()
        self.emailList()
    }
    
    func failWithInternetConnection() {
        self.hideIndicator()
    }
}

//MARK: DELETE DATA LIST HELPER
//merged
//private typealias DeleteDataListHelper = BeefViewAnimalVC
extension BeefViewAnimalVC {
    func getListName()  {
        listName = orderingDatalistVM.makeListName(custmerId: custmerId ?? 0, providerID: pvid)
        if pvid == 6 {
            //needs discussion
//            var productType  = ""
//            if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeOnly.rawValue {
//                productType = keyValue.genoTypeOnly.rawValue
//            }
//            else if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeStarBlack.rawValue {
//                productType = keyValue.genoTypeStarBlack.rawValue
//            }
//            else if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genStarBlack.rawValue {
//                productType = keyValue.genStarBlack.rawValue
//            }
//            else {
//                productType = keyValue.nonGenoType.rawValue
//            }
            fetchDataEntry =  fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(custmerId ?? 0),listName: listName ,productName:marketNameType.Beef.rawValue) as! [DataEntryList]
        }
        else {
            fetchDataEntry  = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.custmerId ?? 0),listName:listName ,productName:marketNameType.Beef.rawValue) as! [DataEntryList]
        }
    }
    
    func deleteSigalAnimalFromList(index:Int) {
        if fetchDataEntry.count > 0 {
            let fetchAllDatalistAnimals =  fetchAllDataAnimalDaWithOutOrderId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, userId: userId,orderStatus:"false",listid:Int64(fetchDataEntry[0].listId), custmerId: Int64(custmerId ?? 0), providerId: pvid) as! [DataEntryBeefAnimaladdTbl]
            
            if fetchAllDatalistAnimals.count > 0{
                let animalVal = fetchAllDatalistAnimals[index]
                if !Connectivity.isConnectedToInternet() {
                    saveDeletedDataListAnimal(entity: Entities.dataEntryOfflineDeletedAnimalTblEntity, animalID: Int(animalVal.animalId), listID: Int(fetchDataEntry[0].listId), customerID: Int64(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)), serverAnimalID: animalVal.serverAnimalId ?? "", speciesID: SpeciesID.beefSpeciesId)
                }
                self.objApiSync.postListDataDeleteBeef(listId:fetchDataEntry[0].listId,custmerId:Int64(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)), clearOrder: false, animalId: Int(animalVal.animalId))
                
              //  beefDeleteDataWithAnimalDataEntry(Int(animalVal.animalId))
              deleteAnimalfromdataEntry(enitityName:Entities.dataEntryBeefAnimalAddTblEntity, Int(animalVal.animalId), listId: Int(animalVal.listId))
            }
        }
    }
    
    func createListNameAndCheckifExist(){
        if fetchDataEntry.count > 0 {
            self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
            self.view.isUserInteractionEnabled = false
            deleteList(listName: listName, customerId: Int64(custmerId ?? 0),listID: Int(fetchDataEntry[0].listId))
        }
    }
    
    func deleteList(listName: String, customerId: Int64, listID: Int) {
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict = [LocalizedStrings.authorizationHeader: accessToken!,LocalizedStrings.contentType : LocalizedStrings.formURLEncoded]
        let urlString = Configuration.Dev(packet: ApiKeys.deleteList.rawValue).getUrl()
        let parameters : [String: Any] = [keyValue.customerId.rawValue: customerId,keyValue.listName.rawValue:listName]
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = headerDict
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            if statusCode == 200 {
                self.hideIndicator()
                self.view.isUserInteractionEnabled = true
            }
        }
    }
}

//MARK: EMAIL DATA LIST HELPER
private typealias EmailDataListHelper = BeefViewAnimalVC
extension EmailDataListHelper {
    func emailList(){
        var listIdGet =  Int()
        if fetchDataEntry.count > 0{
            listIdGet = Int(fetchDataEntry[0].listId)
        }
        
        if Connectivity.isConnectedToInternet() {
            let emailId = UserDefaults.standard.value(forKey:keyValue.userName.rawValue) as! String
            self.objApiSync.postEmailList(listId:Int64(listIdGet),custmerId:Int64(custmerId ?? 0),emailAdress :[emailId],providerId: pvid,listName: fetchDataEntry[0].listName ?? "")
            self.view.makeToast(NSLocalizedString(LocalizedStrings.receiveEmailWithData, comment: ""), duration: 3, position: .bottom)
        }
        else {
            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(LocalizedStrings.noEmailSent, comment: ""), preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { (action:UIAlertAction!) in
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
    }
}

