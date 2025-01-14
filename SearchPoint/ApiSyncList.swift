//
//  ApiSyncList.swift
//  SearchPoint
//
//  Created by Mobile Programming on 27/01/21.
//

import UIKit
import Alamofire
import MBProgressHUD
import SystemConfiguration
import CoreData

class ApiSyncList: NSObject {
    
    var delegeteSyncApi : syncApi?
    let loginData = fetchAllData(entityName: Entities.LoginTblEntity)
    var userId = Int()
    var ApisyncList = SaveListModel()
    var emailApisyncList = EmailListModel()
    var orderString = String()
    var nameSex = String()
    let billToCustomerId = UserDefaults.standard.integer(forKey: keyValue.billToCustomerId.rawValue)
    let custId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
    var nominatorName =  UserDefaults.standard.value(forKey: keyValue.nominatorSave.rawValue) as? String
    var nominatorid = Int()
    var pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
    var sireNameAus = String()
    var getListName = String()
    var beefpvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
    var descriptionName = String()
    var delegate1:ResponseDelegate?
    var getGroupName = String()
    var emailApisyncGroup = EmailGroupModel()
    var animaltbl1 = NSArray()

    override init() {
        super.init()
        userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        
    }
    
    // MARK: Post List data
    
    func postListData(listId:Int64,custmerId:Int64) {
        let animaltbl = fetchAllDataAnimalDaWithOutOrderIdserverAnimalId(entityName: Entities.dataEntryAnimalAddTbl,userId:userId,orderStatus:"false",listid:listId,custmerId:custmerId,providerId:UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue),serverAnimalId:"")
        
        let editCaseData = fetchAllDataEditCondition(entityName: Entities.dataEntryAnimalAddTbl,userId:userId,orderStatus:"false",listid:listId,custmerId:custmerId,providerId:UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue),serverAnimalId:"")
        
        if animaltbl.count == 0 && editCaseData.count == 0 {
            self.delegeteSyncApi?.didFinishApi(response: "true")
            return
        }
        
        var datee = String()
        let fetchName = fetchListNameAccordingToListId(entityName: Entities.dataEntryListTblEntity,customerId:Int(custmerId ),listId:listId,providerId:pvid)
        if fetchName.count != 0{
            let getName = fetchName.object(at: 0) as? DataEntryList
            self.getListName = getName?.listName ?? ""
            self.descriptionName = getName?.listDesc ?? ""
        }
        
        ApisyncList.addAnimals.removeAll()
        for item in animaltbl{
            
            var ob = Animal()
            if let value = item as? DataEntryAnimaladdTbl{
                if value.date != "" {
                    print(value)
                    datee = getOrderDateChange(date: value.date ?? "")
                    ob.dob = datee
                }
                ob.deviceAnimalID = Int(value.animalId)
                ob.onFarmID = value.farmId ?? ""
                ob.officialTag = value.animalTag
                ob.sampleBarCode = value.animalbarCodeTag
                ob.breedId = value.breedId ?? ""
                ob.sampleTypeId = Int(value.tissuId)
                
                let sexName = value.gender ?? ""
                if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                    nameSex = "F"
                } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                    nameSex = "M"
                }  else {
                    nameSex = "F"
                }
                
                ob.sex = nameSex
                
                ob.bornTypeId = Int(value.selectedBornTypeId)
                ob.officialSireId = value.offsireId
                ob.officialDamId  = value.offDamId
                ob.earTag  = value.earTag
                ob.animalName  = value.animalName
                ob.speciesId = SpeciesID.dairySpeciesId
                ob.breedId = value.breedId ?? ""
                ob.earTag  = value.earTag
                ob.animalTag  = ""
                ob.breedRegNumber  = value.breedRegNumber
                
                ob.animalName  = value.animalName
                ob.sireRegNumber  = value.offsireId
                ob.damRegNumber  = value.offDamId
                ob.sireID  = value.offsireId
                ob.damId = value.offDamId
                ob.sireNAAB = ""
                ob.mbc  = value.eT
                ob.breedRegistrationNumber = ""
                ob.sireYOB = 0
                ob.animalDamID = ""
                ob.damYOB = 0
                ob.series  = ""
                ob.rgd  = ""
                ob.rgn  = value.breedAssocation
                if value.breedAssocation == LocalizedStrings.girolandoAssociationStr {
                    ob.breedAssociationId = "a40549b9-beae-4c0c-8e48-5147f18333d9"
                }
            }
            ApisyncList.addAnimals.append(ob)
            ob = Animal()
        }
      // get the list name and check farmid and official id animal list and update that list
        for item in editCaseData{
            
            var ob = Animal()
            if let value = item as? DataEntryAnimaladdTbl{
                if value.date != "" {
                    print(value)
                    datee = getOrderDateChange(date: value.date ?? "")
                    ob.dob = datee
                }
                //Mandotry Fields
                ob.deviceAnimalID = Int(value.animalId)
                ob.onFarmID = value.farmId ?? ""
                ob.officialTag = value.animalTag
                ob.sampleBarCode = value.animalbarCodeTag
                ob.breedId = value.breedId ?? ""
                ob.sampleTypeId = Int(value.tissuId)
                
                let sexName = value.gender ?? ""
                if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                    nameSex = "F"
                } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                    nameSex = "M"
                }  else {
                    nameSex = "F"
                }
                
                ob.sex = nameSex
                
                ob.bornTypeId = Int(value.selectedBornTypeId)
                ob.officialSireId = value.offsireId
                ob.officialDamId  = value.offDamId
                ob.earTag  = value.earTag
                ob.animalName  = value.animalName
                
                let serverAnimalId = value.serverAnimalId
                if serverAnimalId != "" {
                    
                    ob.animalID = serverAnimalId
                }
                ob.speciesId = SpeciesID.dairySpeciesId
                ob.breedId = value.breedId ?? ""
                ob.earTag  = value.earTag
                ob.animalTag  = ""
                ob.breedRegNumber  = value.breedRegNumber
                ob.animalName  = value.animalName
                ob.sireRegNumber  = value.offsireId
                ob.damRegNumber  = value.offDamId
                
                ob.sireNAAB = ""
                ob.mbc  = value.eT
                ob.breedRegistrationNumber = ""
                ob.sireYOB = 0
                ob.animalDamID = ""
                ob.damYOB = 0
                ob.series  = ""
                ob.rgd  = ""
                ob.rgn  = value.breedAssocation
                if value.breedAssocation == LocalizedStrings.girolandoAssociationStr {
                    
                    ob.breedAssociationId = "a40549b9-beae-4c0c-8e48-5147f18333d9"
                    
                }
                ob.sireID  = value.offsireId
                ob.damId = value.offDamId
            }
            ApisyncList.updateAnimals.append(ob)
            ob = Animal()
        }
        ApisyncList.customerId = custId
        ApisyncList.listName = getListName
        ApisyncList.description = descriptionName
        ApisyncList.speciesId = SpeciesID.dairySpeciesId
        ApisyncList.providerId = pvid
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(ApisyncList)
        let json = String(data: jsonData, encoding: String.Encoding.utf8)
        print(json!)
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + accessToken!]
        var urlString = String()
        urlString = Configuration.Dev(packet: ApiKeys.saveList.rawValue).getUrl()
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headerDict
        
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        request.httpBody = jsonData
        
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            
            NotificationCenter.default.post(name: Notification.Name(LocalizedStrings.sessionExpiredStr), object: nil, userInfo: [LocalizedStrings.statusCodeText:"\(String(describing: response.response?.statusCode ?? 0))"])
            if statusCode == 401  {
                
                self.delegeteSyncApi?.failWithError(statusCode: statusCode!)
            }
            else if statusCode == 500 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408 {
                self.delegeteSyncApi?.failWithErrorInternal()
                self.delegeteSyncApi?.failWithError(statusCode: statusCode!)
            }
            
            switch response.result {
                
            case .success(let responseObject):
                // internet works.saveProductData
                let data = response.data
                print(response.data as Any)
                //let decoder = JSONDecoder()
                let response = responseObject as! NSDictionary
                self.ApisyncList.addAnimals.removeAll()
                self.ApisyncList.updateAnimals.removeAll()
                self.ApisyncList.deleteAnimals.removeAll()
                self.responseRecieved1(data, status: true, listId: Int(listId))
                
                print(response)
                
            case .failure(let encodingError):
                
                if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                    self.delegeteSyncApi?.failWithInternetConnection()
                    print(err)
                } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                    print (encodingError)
                    print (responseString)
                    if let s = statusCode {
                        
                        self.delegeteSyncApi?.failWithError(statusCode: s)
                    } else {
                        self.delegeteSyncApi?.failWithErrorInternal()
                    }
                } else {
                    self.delegeteSyncApi?.failWithErrorInternal()
                }
            }
        }
    }
  // Update animal list and merge list together
  func updateAnimalLists(listId:Int64,custmerId:Int64){
   
    
    let editCaseData = fetchAllDataEditCondition(entityName: Entities.dataEntryAnimalAddTbl,userId:userId,orderStatus:"false",listid:listId,custmerId:custmerId,providerId:UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue),serverAnimalId:"")
    
    if editCaseData.count == 0 {
        self.delegeteSyncApi?.didFinishApi(response: "true")
        return
    }
    
    var datee = String()
    let fetchName = fetchListNameAccordingToListId(entityName: Entities.dataEntryListTblEntity,customerId:Int(custmerId ),listId:listId,providerId:pvid)
    if fetchName.count != 0{
        let getName = fetchName.object(at: 0) as? DataEntryList
        self.getListName = getName?.listName ?? ""
        self.descriptionName = getName?.listDesc ?? ""
    }
    
    ApisyncList.addAnimals.removeAll()
   
  // get the list name and check farmid and official id animal list and update that list
    for item in editCaseData{
        
        var ob = Animal()
        if let value = item as? DataEntryAnimaladdTbl{
            if value.date != "" {
                print(value)
                datee = getOrderDateChange(date: value.date ?? "")
                ob.dob = datee
            }
            //Mandotry Fields
            ob.deviceAnimalID = Int(value.animalId)
            ob.onFarmID = value.farmId ?? ""
            ob.officialTag = value.animalTag
            ob.sampleBarCode = value.animalbarCodeTag
            ob.breedId = value.breedId ?? ""
            ob.sampleTypeId = Int(value.tissuId)
            
            let sexName = value.gender ?? ""
            if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                nameSex = "F"
            } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                nameSex = "M"
            }  else {
                nameSex = "F"
            }
            
            ob.sex = nameSex
            
            ob.bornTypeId = Int(value.selectedBornTypeId)
            ob.officialSireId = value.offsireId
            ob.officialDamId  = value.offDamId
            ob.earTag  = value.earTag
            ob.animalName  = value.animalName
            
            let serverAnimalId = value.serverAnimalId
            if serverAnimalId != "" {
                
                ob.animalID = serverAnimalId
            }
            ob.speciesId = SpeciesID.dairySpeciesId
            ob.breedId = value.breedId ?? ""
            ob.earTag  = value.earTag
            ob.animalTag  = ""
            ob.breedRegNumber  = value.breedRegNumber
            ob.animalName  = value.animalName
            ob.sireRegNumber  = value.offsireId
            ob.damRegNumber  = value.offDamId
            
            ob.sireNAAB = ""
            ob.mbc  = value.eT
            ob.breedRegistrationNumber = ""
            ob.sireYOB = 0
            ob.animalDamID = ""
            ob.damYOB = 0
            ob.series  = ""
            ob.rgd  = ""
            ob.rgn  = value.breedAssocation
            if value.breedAssocation == LocalizedStrings.girolandoAssociationStr {
                
                ob.breedAssociationId = "a40549b9-beae-4c0c-8e48-5147f18333d9"
                
            }
            ob.sireID  = value.offsireId
            ob.damId = value.offDamId
        }
        ApisyncList.updateAnimals.append(ob)
        ob = Animal()
    }
    ApisyncList.customerId = custId
    ApisyncList.listName = getListName
    ApisyncList.description = descriptionName
    ApisyncList.speciesId = SpeciesID.dairySpeciesId
    ApisyncList.providerId = pvid
    let jsonEncoder = JSONEncoder()
    let jsonData = try! jsonEncoder.encode(ApisyncList)
    let json = String(data: jsonData, encoding: String.Encoding.utf8)
    print(json!)
    let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
    let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + accessToken!]
    var urlString = String()
    urlString = Configuration.Dev(packet: ApiKeys.saveUpdateLists.rawValue).getUrl()
    var request = URLRequest(url: URL(string: urlString)! )
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = headerDict
    
    request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
    request.httpBody = jsonData
    
    AF.request(request as URLRequestConvertible).responseJSON { response in
        let statusCode =  response.response?.statusCode
        
        NotificationCenter.default.post(name: Notification.Name(LocalizedStrings.sessionExpiredStr), object: nil, userInfo: [LocalizedStrings.statusCodeText:"\(String(describing: response.response?.statusCode ?? 0))"])
        if statusCode == 401  {
            
            self.delegeteSyncApi?.failWithError(statusCode: statusCode!)
        }
        else if statusCode == 500 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408 {
            self.delegeteSyncApi?.failWithErrorInternal()
            self.delegeteSyncApi?.failWithError(statusCode: statusCode!)
        }
        
        switch response.result {
            
        case .success(let responseObject):
            // internet works.saveProductData
            let data = response.data
            print(response.data as Any)
            //let decoder = JSONDecoder()
            let response = responseObject as! NSDictionary
            self.ApisyncList.addAnimals.removeAll()
            self.ApisyncList.updateAnimals.removeAll()
            self.ApisyncList.deleteAnimals.removeAll()
            self.responseRecieved1(data, status: true, listId: Int(listId))
            
            print(response)
            
        case .failure(let encodingError):
            
            if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                self.delegeteSyncApi?.failWithInternetConnection()
                print(err)
            } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                print (encodingError)
                print (responseString)
                if let s = statusCode {
                    self.delegeteSyncApi?.failWithError(statusCode: s)
                } else {
                    self.delegeteSyncApi?.failWithErrorInternal()
                }
            } else {
                self.delegeteSyncApi?.failWithErrorInternal()
            }
        }
    }
}
  
    func getOrderDateChange(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatters.ddMMyyyyFormat
        let date1 = dateFormatter.date(from: date )// create   date from string
        dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
        let timeStamp = dateFormatter.string(from: date1!)
        print(timeStamp)
        return timeStamp
    }
    
    func responseRecieved1(_ data: Data?, status: Bool,listId:Int) {
        print(data as Any)
        print(status)
        if data == nil {
            return
        }
        let decoder = JSONDecoder()
        modalObject = try! decoder.decode(SavingResponseModel.self, from: data!)
        DispatchQueue.main.async {
            
            if self.modalObject != nil {
                self.saveApiResponse(dataModel:self.modalObject!, listId: listId)
            }
        }
    }
    var modalObject: SavingResponseModel?
    
    func saveApiResponse(dataModel: SavingResponseModel,listId:Int){
        
        let animaltbl = fetchAllDataAnimalDaWithOutOrderIdserverAnimalId(entityName: Entities.dataEntryAnimalAddTbl,userId:userId,orderStatus:"false",listid:Int64(listId),custmerId:Int64(UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int),providerId:UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue),serverAnimalId:"")
        
        var duplicateAnimalData = [AnimalResponse]()
      let filteredAnimals = dataModel.customerList.animals.uniqueElement { $0.onFarmID == $1.onFarmID && $0.animalTag == $1.animalTag && $0.sampleBarCode == $1.sampleBarCode }
        
        if dataModel.customerList.animals.count < animaltbl.count {
          //  let filteredAnimals = animaltbl.uniqueElement { $0.onFarmID == $1.onFarmID && $0.animalTag == $1.animalTag && $0.sampleBarCode == $1.sampleBarCode }
            if animaltbl.count > 0 {
                self.postListData(listId: Int64(listId), custmerId: Int64(UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int))
            }
        } else  if dataModel.customerList.animals.count > filteredAnimals.count {

            for animal in filteredAnimals {
                
                let duplicateAnimal = dataModel.customerList.animals.filter({$0.onFarmID == animal.onFarmID &&  $0.animalTag == animal.animalTag && $0.sampleBarCode == animal.sampleBarCode})
                
                var doubleAnimals = duplicateAnimal
                if let index = duplicateAnimal.firstIndex(where: {$0.animalID == animal.animalID}) {
                    doubleAnimals.remove(at: index)
                }
                
                
                for aData in doubleAnimals {
                    duplicateAnimalData.append(aData)
                    
                }
            }
            print(duplicateAnimalData.count)
            
            if duplicateAnimalData.count>0{
                
                self.deleteDuplicateAnimalsFromSever(animalList: duplicateAnimalData, list_id: listId)
            }
        } else {
            //update local database
            
            for animal  in filteredAnimals {
                
              updateDataInSaveClick(entity: Entities.dataEntryAnimalAddTbl,serverAnimalId:animal.animalID ?? "",farmId:animal.onFarmID ?? "",animalTag:animal.officialTag ?? "",custmerId:custId ,animalId:animal.deviceAnimalID ?? 0,listId: listId)
                updateDataInSaveClick(entity: Entities.animalAddTblEntity,serverAnimalId:animal.animalID ?? "",farmId:animal.onFarmID ?? "",animalTag:animal.officialTag ?? "",custmerId:custId ,animalId:animal.deviceAnimalID ?? 0,listId: listId)
                updateDataInSaveClick(entity: Entities.animalMasterTblEntity,serverAnimalId:animal.animalID ?? "",farmId:animal.onFarmID ?? "",animalTag:animal.officialTag ?? "",custmerId:custId ,animalId:animal.deviceAnimalID ?? 0,listId: listId)
                updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custId,offlineSync:true,listid: listId)
                
            }
            self.delegeteSyncApi?.didFinishApi(response: "true")
        }
    }
    
    func saveBeefApiResponse(dataModel: SavingResponseModel,listId:Int){
        
        let animaltbl = fetchAllDataAnimalDaWithOutOrderIdserverAnimalId(entityName: Entities.dataEntryAnimalAddTbl,userId:userId,orderStatus:"false",listid:Int64(listId),custmerId:Int64(UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int),providerId:UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue),serverAnimalId:"")
        
        var duplicateAnimalData = [AnimalResponse]()
        let filteredAnimals = dataModel.customerList.animals.uniqueElement { $0.earTag == $1.earTag && $0.sampleBarCode == $1.sampleBarCode }
        
        if dataModel.customerList.animals.count < animaltbl.count {
            // some animal are still pending for update
            if animaltbl.count > 0 {
                self.postListData(listId: Int64(listId), custmerId: Int64(UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int))
            }
        } else  if dataModel.customerList.animals.count > filteredAnimals.count {
      
            for animal  in filteredAnimals {
                let duplicateAnimal = dataModel.customerList.animals.filter({$0.earTag == animal.earTag &&  $0.sampleBarCode == animal.sampleBarCode})
                
                var doubleAnimals = duplicateAnimal
                if let index = duplicateAnimal.firstIndex(where: {$0.animalID == animal.animalID}) {
                    doubleAnimals.remove(at: index)
                }
                
                for aData in doubleAnimals {
                    duplicateAnimalData.append(aData)
                    
                }
            }
            print(duplicateAnimalData.count)
            
            if duplicateAnimalData.count>0{
                
                self.deleteDuplicateAnimalsFromSever(animalList: duplicateAnimalData, list_id: listId)
            }
        } else {
            
            for animal in filteredAnimals {
                
                updateDataInSaveClick(entity: Entities.dataEntryAnimalAddTbl,serverAnimalId:animal.animalID ?? "",farmId:animal.onFarmID ?? "",animalTag:animal.officialTag ?? "",custmerId:custId ,animalId:animal.deviceAnimalID ?? 0,listId: listId)
                updateDataInSaveClick(entity: Entities.beefAnimalAddTblEntity,serverAnimalId:animal.animalID ?? "",farmId:animal.onFarmID ?? "",animalTag:animal.officialTag ?? "",custmerId:custId ,animalId:animal.deviceAnimalID ?? 0,listId: listId)
                updateDataInSaveClick(entity: Entities.beefAnimalMasterTblEntity,serverAnimalId:animal.animalID ?? "",farmId:animal.onFarmID ?? "",animalTag:animal.officialTag ?? "",custmerId:custId ,animalId:animal.deviceAnimalID ?? 0,listId: listId)
                updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custId,offlineSync:true,listid: listId)
                
            }
            self.delegeteSyncApi?.didFinishApi(response: "true")
        }
    }
        
    func postListDataDelete(listId:Int64,custmerId:Int64,clearOrder :Bool,animalId :Int) {
        self.ApisyncList.deleteAnimals.removeAll()
        self.ApisyncList.addAnimals.removeAll()
        if clearOrder == true {
            self.animaltbl1 = fetchAllDataAnimalDaWithOutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderStatus:"false",listid: Int64(listId ), custmerId: Int64(custmerId ), providerId: pvid)
        } else {
            
            self.animaltbl1 = fetchOneByOneListElements(animalId: Int(animalId),listID: Int(listId),entityName:Entities.dataEntryAnimalAddTbl)
            
        }
        
        
        let fetchName = fetchListNameAccordingToListId(entityName: Entities.dataEntryListTblEntity,customerId:Int(custmerId ),listId:listId,providerId:pvid)
        if fetchName.count != 0{
            let getName = fetchName.object(at: 0) as? DataEntryList
            self.getListName = getName?.listName ?? ""
            self.descriptionName = getName?.listDesc ?? ""
        }
        
        for item in animaltbl1{
            
            var ob = Animal()
            if let value = item as? DataEntryAnimaladdTbl{
                let serverAnimalId = value.serverAnimalId
                if serverAnimalId != "" {
                    ob.animalID = serverAnimalId
                }
            }
            ApisyncList.deleteAnimals.append(ob)
            ob = Animal()
        }
        
        ApisyncList.customerId = custId
        ApisyncList.listName = getListName
        ApisyncList.description = descriptionName
        ApisyncList.speciesId = SpeciesID.dairySpeciesId
        ApisyncList.providerId = pvid
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(ApisyncList)
        let json = String(data: jsonData, encoding: String.Encoding.utf8)
        print(json!)
        
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + accessToken!]
        var urlString = String()
        
        urlString = Configuration.Dev(packet: ApiKeys.saveList.rawValue).getUrl()
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headerDict
        
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        request.httpBody = jsonData
        
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            
            NotificationCenter.default.post(name: Notification.Name(LocalizedStrings.sessionExpiredStr), object: nil, userInfo: [LocalizedStrings.statusCodeText:"\(String(describing: response.response?.statusCode ?? 0))"])
            if statusCode == 401  {
                
                self.delegeteSyncApi?.failWithError(statusCode: statusCode!)
            }
            else if statusCode == 500 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408 {
                self.delegeteSyncApi?.failWithErrorInternal()
                self.delegeteSyncApi?.failWithError(statusCode: statusCode!)
            }
            
            switch response.result {
                
            case .success(let responseObject):
                let response = responseObject as! NSDictionary
                print(response)
                
            case .failure(let encodingError):
                
                if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                    self.delegeteSyncApi?.failWithErrorInternal()
                    print(err)
                } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                    // other failures
                    print (encodingError)
                    print (responseString)
                    if let s = statusCode {
                        
                        self.delegeteSyncApi?.failWithError(statusCode: s)
                    } else {
                        self.delegeteSyncApi?.failWithErrorInternal()
                    }
                }
            }
        }
    }
    
    
    /// Email list api
    
    
    func postEmailList(listId:Int64,custmerId:Int64,emailAdress :[String],providerId:Int, listName: String = "") {
        
        if listName == ""{
            let fetchName = fetchListNameAccordingToListId(entityName: Entities.dataEntryListTblEntity,customerId:Int(custmerId ),listId:listId,providerId:providerId)
            if fetchName.count != 0{
                let getName = fetchName.object(at: 0) as? DataEntryList
                self.getListName = getName?.listName ?? ""
                self.descriptionName = getName?.listDesc ?? ""
            }
        } else {
            self.getListName = listName
        }
        
        emailApisyncList.customerId = Int(custmerId)
        emailApisyncList.listName = getListName
        emailApisyncList.emailAddresses = emailAdress
        
        
        let jsonEncoder = JSONEncoder()
        
        let jsonData = try! jsonEncoder.encode(emailApisyncList)
        let json = String(data: jsonData, encoding: String.Encoding.utf8)
        print(json!)
        
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + accessToken!]
        var urlString = String()
        
        urlString = Configuration.Dev(packet: ApiKeys.emailMeList.rawValue).getUrl()
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headerDict
        
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        request.httpBody = jsonData
        
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            
            NotificationCenter.default.post(name: Notification.Name(LocalizedStrings.sessionExpiredStr), object: nil, userInfo: [LocalizedStrings.statusCodeText:"\(String(describing: response.response?.statusCode ?? 0))"])
            if statusCode == 401  {
                
                self.delegeteSyncApi?.failWithError(statusCode: statusCode!)
            }
            else if statusCode == 500 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408 {
                self.delegeteSyncApi?.failWithErrorInternal()
                self.delegeteSyncApi?.failWithError(statusCode: statusCode!)
            }
            
            switch response.result {
                
            case .success(let responseObject):
                let response = responseObject as! NSDictionary
                print(response)
                
            case .failure(let encodingError):
                
                if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                    self.delegeteSyncApi?.failWithErrorInternal()
                    print(err)
                } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                    print (encodingError)
                    print (responseString)
                    if let s = statusCode {
                        
                        self.delegeteSyncApi?.failWithError(statusCode: s)
                    } else {
                        self.delegeteSyncApi?.failWithErrorInternal()
                    }
                }
            }
        }
    }
  
}

