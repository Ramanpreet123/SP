//
//  ApiSyncListOfflineExtension.swift
//  SearchPoint
//
//  Created by Mobile Programming on 21/02/24.
//

import Foundation
import Alamofire

// MARK: POST LIST DATA DAIRY

extension ApiSyncList {
    func postListDataAddOfflineDairy() {
        let animaltbl = fetchAllDataServerAnimalIdWithoutListId(entityName: Entities.dataEntryAnimalAddTbl,userId:userId,orderStatus:"false",custmerId:Int64(UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int ?? 0),serverAnimalId:"")
        
        if animaltbl.count == 0 {
            return
        }
        
        
        for item in animaltbl {
            var listID = 0
            apiSyncListClass.addAnimals.removeAll()
            var ob = Animal()
            if let value = item as? DataEntryAnimaladdTbl{
                
                listID = Int(value.listId)
                let fetchName = fetchListNameAccordingToListId(entityName: Entities.dataEntryListTblEntity,customerId:UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int ?? 0,listId:value.listId ,providerId:Int(value.providerId ))
                if fetchName.count != 0{
                    let getName = fetchName.object(at: 0) as? DataEntryList
                    self.getListName = getName?.listName ?? ""
                    self.descriptionName = getName?.listDesc ?? ""
                }
                
                if value.date != "" {
                    print(value)
                    ob.dob = getOrderDateChange(date: value.date ?? "")
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
            apiSyncListClass.addAnimals.append(ob)
            ob = Animal()
            apiSyncListClass.customerId = custId
            apiSyncListClass.listName = getListName
            apiSyncListClass.description = descriptionName
            apiSyncListClass.speciesId = SpeciesID.dairySpeciesId
            apiSyncListClass.providerId = pvid
            
            let jsonEncoder = JSONEncoder()
            
            var jsonData: Data?
            do {
                jsonData = try jsonEncoder.encode(apiSyncListClass)
                // use jsonData safely
            } catch {
                print("Failed to encode updateGroup: \(error.localizedDescription)")
            }
            
            guard let body = jsonData else {
                print("No JSON data to send")
                return
            }
            let json = String(data: body, encoding: String.Encoding.utf8)
            print(json!)
            
            let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
            let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + accessToken!]
            let urlString = Configuration.Dev(packet: ApiKeys.saveList.rawValue).getUrl()
            var request = URLRequest(url: URL(string: urlString)! )
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headerDict
            request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
            request.httpBody = body
            
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
                    let data = response.data
                    let response = responseObject as! NSDictionary
                    
                    self.responseRecievedOffline(data, status: true, listId: listID)
                    
                    print(response)
                    
                case .failure(let encodingError):
                    
                    if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                        // no internet connection
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
    }
    
    func postListDataEditOfflineDairy() {
        let editCaseData = fetchAllDataEditConditionWithoutListId(entityName: Entities.dataEntryAnimalAddTbl,userId:userId,orderStatus:"false",custmerId:Int64(UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int ?? 0),serverAnimalId:"")
        
        if editCaseData.count == 0 {
            return
        }
        
        for item in editCaseData {
            var listID = 0
            apiSyncListClass.addAnimals.removeAll()
            apiSyncListClass.updateAnimals.removeAll()
            var ob = Animal()
            if let value = item as? DataEntryAnimaladdTbl{
                listID = Int(value.listId)
                let fetchName = fetchListNameAccordingToListId(entityName: Entities.dataEntryListTblEntity,customerId:UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int ?? 0,listId:value.listId ,providerId:Int(value.providerId ))
                if fetchName.count != 0{
                    let getName = fetchName.object(at: 0) as? DataEntryList
                    self.getListName = getName?.listName ?? ""
                    self.descriptionName = getName?.listDesc ?? ""
                }
                
                
                if value.date != "" {
                    print(value)
                    ob.dob = getOrderDateChange(date: value.date ?? "")
                }
                //Mandotry Fields
                ob.deviceAnimalID = Int(value.animalId)
                let serverAnimalId = value.serverAnimalId
                if serverAnimalId != "" {
                    ob.animalID = serverAnimalId
                }
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
            apiSyncListClass.updateAnimals.append(ob)
            ob = Animal()
            
            apiSyncListClass.customerId = custId
            apiSyncListClass.listName = getListName
            apiSyncListClass.description = descriptionName
            apiSyncListClass.speciesId = SpeciesID.dairySpeciesId
            apiSyncListClass.providerId = pvid
            let jsonEncoder = JSONEncoder()
            var jsonData: Data?
            do {
                jsonData = try jsonEncoder.encode(apiSyncListClass)
                // use jsonData safely
            } catch {
                print("Failed to encode updateGroup: \(error.localizedDescription)")
            }
            
            guard let body = jsonData else {
                print("No JSON data to send")
                return
            }
            let json = String(data: body, encoding: String.Encoding.utf8)
            print(json!)
            let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
            let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + accessToken!]
            let urlString = Configuration.Dev(packet: ApiKeys.saveList.rawValue).getUrl()
            var request = URLRequest(url: URL(string: urlString)! )
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headerDict
            
            request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
            request.httpBody = body
            
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
                    let data = response.data
                    let response = responseObject as! NSDictionary
                    self.responseRecievedOffline(data, status: true, listId: listID)
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
    
    func responseRecievedOffline(_ data: Data?, status: Bool,listId:Int) {
        
        print(data as Any)
        print(status)
        if data == nil {
            return
        }
        let decoder = JSONDecoder()
        modalObject = try? decoder.decode(SavingResponseModel.self, from: data!)
        DispatchQueue.main.async {
            
            if self.modalObject != nil {
                self.saveApiResponseOffline(dataModel:self.modalObject!, listId: listId)
            }
        }
    }
    
    func saveApiResponseOffline(dataModel: SavingResponseModel,listId:Int){
        var duplicateAnimalData = [AnimalResponse]()
        let filteredAnimals = dataModel.customerList.animals.uniqueElement { $0.onFarmID == $1.onFarmID && $0.animalTag == $1.animalTag }
        if filteredAnimals.count > 1{
            print(filteredAnimals)
        }
        for animal  in filteredAnimals {
            
            updateDataInSaveClick(entity: Entities.dataEntryAnimalAddTbl,serverAnimalId:animal.animalID ?? "",farmId:animal.onFarmID ?? "",animalTag:animal.officialTag ?? "",custmerId:custId ,animalId:animal.deviceAnimalID ?? 0)
            updateDataInSaveClick(entity: Entities.animalAddTblEntity,serverAnimalId:animal.animalID ?? "",farmId:animal.onFarmID ?? "",animalTag:animal.officialTag ?? "",custmerId:custId ,animalId:animal.deviceAnimalID ?? 0)
            updateDataInSaveClick(entity: Entities.animalMasterTblEntity,serverAnimalId:animal.animalID ?? "",farmId:animal.onFarmID ?? "",animalTag:animal.officialTag ?? "",custmerId:custId ,animalId:animal.deviceAnimalID ?? 0)
            
            
            updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custId,offlineSync:true,listid: listId)
            let duplicateAnimal = dataModel.customerList.animals.filter({$0.onFarmID == animal.onFarmID &&  $0.animalTag == animal.animalTag})
            var doubleAnimals = duplicateAnimal
            if let index = duplicateAnimal.firstIndex(where: {$0.animalID == animal.animalID}) {
                doubleAnimals.remove(at: index)
            }
            
            for aData in doubleAnimals {
                duplicateAnimalData.append(aData)
                
            }
        }
        print(duplicateAnimalData.count)
        self.deleteDuplicateAnimalsFromSever(animalList: duplicateAnimalData)
    }
    
    func postEmailGroupList(groupName:String,custmerId:Int64,emailAdress :[String]) {
        let fetchName = fetchGroupNameAccordingToGroupName(entityName: Entities.resultGroupCreateTblEntity,customerId: Int(custmerId),groupName: groupName)
        
        if fetchName.count != 0{
            let getName = fetchName.object(at: 0) as? ResultGroupCreate
            self.getGroupName = getName?.groupName ?? ""
            self.descriptionName = getName?.groupDesc ?? ""
        }
        
        emailApisyncGroup.customerId = Int(custmerId)
        emailApisyncGroup.groupName = getGroupName
        emailApisyncGroup.emailAddresses = emailAdress
        
        let jsonEncoder = JSONEncoder()
        var jsonData: Data?
        do {
            jsonData = try jsonEncoder.encode(emailApisyncGroup)
            // use jsonData safely
        } catch {
            print("Failed to encode updateGroup: \(error.localizedDescription)")
        }
        
        guard let body = jsonData else {
            print("No JSON data to send")
            return
        }
        let json = String(data: body, encoding: String.Encoding.utf8)
        print(json!)
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + accessToken!]
        let urlString = Configuration.Dev(packet: ApiKeys.emailMeGroup.rawValue).getUrl()
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headerDict
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        request.httpBody = body
        
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
