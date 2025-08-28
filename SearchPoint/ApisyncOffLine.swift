//
//  ApisyncOffLine.swift
//  SearchPoint
//
//  Created by "" on 06/01/2020.


import Foundation
import UIKit
import Alamofire
import MBProgressHUD
import SystemConfiguration
import CoreData


class ApisyncOffLine :NSObject {
    
    var orderString = String()
    let loginData = fetchAllData(entityName: Entities.LoginTblEntity)
    var delegeteSyncApi : syncApiOffline?
    var modalObject:ProductResponse?
    var userId = Int()
    var speciesId = Int()
    let semaphore = DispatchSemaphore(value: 1)
    var myGroup = DispatchGroup()
    var apiSyncClass = ApiSyncModal()
    let billToCustomerId = UserDefaults.standard.integer(forKey: keyValue.billToCustomerId.rawValue)
    var nominatorName =  UserDefaults.standard.value(forKey: keyValue.nominatorSave.rawValue) as? String
    var nominatorid = Int()
    var pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
    var datee = String()
    var nameSex = String()
    var sireNameAus = String()
    var beefpvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
    
    override init() {
        super.init()
        userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        if UserDefaults.standard.string(forKey: keyValue.name.rawValue) == marketNameType.Beef.rawValue{
            speciesId = 2
        }
        else{
            speciesId = 1
        }
        if  nominatorName == keyValue.zoetis.rawValue || nominatorName == nil{
            nominatorid = 1
        } else if nominatorName == keyValue.holsteinUSA.rawValue {
            nominatorid = 2
            
        }
    }
    func tempBeef(data:OfflineOrderBeef){
        let orderId = Int(data.orderId)
        var secondaRyBreedingId = String()
        var priorityBreedingId = String()
        var tertiaryBreedingId = String()
        var sireIDAUbreedAssociationId1 = String()
        var sireRegAssocationbreedAssociationId = String()
        var breedAssociationIdInherit = String()
        var breedAssociationId = String()
        var breedAssociationId1 = String()
        
        apiSyncClass.animals.removeAll()
        let animaltbl = fetchAllDataOrderStatusIsSyncOfflineAnimalordrId(entityName: Entities.beefAnimalAddTblEntity,orderId: orderId,userId: userId)
        
        for item in animaltbl {
            var ob = AnimalDetail()
            if let value = item as? BeefAnimaladdTbl {
                if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 5  {
                    if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
                        if value.date != "" {
                            print(value)
                            datee = getOrderDateChange(date: value.date ?? "")
                            ob.dob = datee
                            
                        }
                        
                        let medbreedRegArr = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 19, association: value.farmId ?? "")
                        
                        if medbreedRegArr.count != 0 {
                            let medbreedRegArr1 = medbreedRegArr.object(at: 0) as? GetBreedSocieties
                            breedAssociationId =   medbreedRegArr1!.associationId ?? ""
                            ob.breedAssociationId = breedAssociationId
                        }
                        
                        let nationHerdAU = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 19, association: value.nationHerdAU ?? "")
                        if nationHerdAU.count != 0 {
                            let nationHerdAU1 = nationHerdAU.object(at: 0) as? GetBreedSocieties
                            breedAssociationId1 =   nationHerdAU1?.associationId ?? ""
                            ob.damAssociationId = breedAssociationId1
                        }
                        
                        
                        let sireIDAU = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 19, association: value.sireIDAU ?? "")
                        if sireIDAU.count != 0 {
                            let sireIDAU1 = sireIDAU.object(at: 0) as? GetBreedSocieties
                            sireIDAUbreedAssociationId1 =   sireIDAU1?.associationId ?? ""
                            ob.sireAssociationId = sireIDAUbreedAssociationId1
                        }
                        
                        ob.earTag = value.animalTag
                        ob.sampleBarCode = value.animalbarCodeTag
                        
                        if value.eT != ""{
                            ob.animalName = value.eT
                        }
                        
                        if value.offPermanentId != "" {
                            ob.breedRegNumber = value.offPermanentId
                        }
                        
                        ob.providerId = Int(value.providerId )
                        
                        if value.breedId == "" {
                            ob.breedId = "d352c4c2-2ff9-451a-9c00-4f0f5604b387"
                            
                        }else {
                            ob.breedId = value.breedId
                            
                        }
                        
                        
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        } else  {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                        
                        
                    } else {
                        if value.date != "" {
                            print(value)
                            datee = getOrderDateChange(date: value.date ?? "")
                        }
                        let medbreedRegArr = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 20, association: value.eT ?? "")
                        if medbreedRegArr.count != 0 {
                            
                            let medbreedRegArr1 = medbreedRegArr.object(at: 0) as? GetBreedSocieties
                            breedAssociationIdInherit =   medbreedRegArr1!.associationId ?? ""
                            ob.breedAssociationId = breedAssociationIdInherit
                            
                        }
                        
                        let sireRegAssocation = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 20, association: value.sireRegAssocation ?? "")
                        if sireRegAssocation.count != 0 {
                            
                            let medbreedRegArr1 = sireRegAssocation.object(at: 0) as? GetBreedSocieties
                            sireRegAssocationbreedAssociationId =   medbreedRegArr1!.associationId ?? ""
                            ob.sireAssociationId = sireRegAssocationbreedAssociationId
                            
                        }
                        ob.earTag = value.animalTag
                        ob.sampleBarCode = value.animalbarCodeTag
                        
                        if value.offsireId != ""{
                            ob.sireRegNumber = value.offsireId
                        }
                        if value.offPermanentId != ""{
                            ob.breedRegNumber = value.offPermanentId
                        }
                        
                        let numberFromString = value.sireYOB ?? "0"
                        let inTd = Int(numberFromString)
                        if numberFromString != "" {
                            ob.sireYOB = inTd ?? 0
                        }
                        
                        if value.offDamId != "" {
                            ob.damId = value.offDamId
                        }
                        
                        let damYOBString = value.damYOB ?? "0"
                        let inTddamYOB = Int(damYOBString)
                        if numberFromString != "" {
                            ob.damYOB = inTddamYOB ?? 0
                            
                        }
                        ob.providerId = Int(value.providerId )
                        
                        if value.breedId != ""{
                            
                            ob.breedId = value.breedId
                            
                        }
                        
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        } else  {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                        ob.dob = datee
                        
                    }
                }
                if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 6  {
                    if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeOnly.rawValue{
                        // GENOTYPE
                        let priorityBreeding = fetchAllDataPriorityData(entityName: Entities.getPriorityBreedingTblEntity, priorityBreedId: value.sireIDAU ?? "")
                        
                        if priorityBreeding.count != 0 {
                            
                            let medbreedRegArr1 = priorityBreeding.object(at: 0) as? GetPriorityBreeding
                            priorityBreedingId =   medbreedRegArr1!.priorityBreedId ?? ""
                            ob.primaryPriorityProgramId = priorityBreedingId
                            
                        }
                        
                        let secondaRypriorityBreeding = fetchAllDataPriorityData(entityName: Entities.getSecondaryBreedingProgramsTblEntity, priorityBreedId: value.nationHerdAU ?? "")
                        
                        if secondaRypriorityBreeding.count != 0 {
                            
                            let secondaRy = secondaRypriorityBreeding.object(at: 0) as? GetSecondaryBreedingPrograms
                            secondaRyBreedingId =   secondaRy!.priorityBreedId ?? ""
                            ob.secondaryPriorityProgramId = secondaRyBreedingId
                            
                        }
                        
                        let tertiaryPriorityBreeding = fetchAllDataPriorityData(entityName: Entities.getTertiaryBreedingProgramsTblEntity, priorityBreedId: value.nationHerdAU ?? "")
                        
                        if tertiaryPriorityBreeding.count != 0 {
                            
                            let tertiaryRy = tertiaryPriorityBreeding.object(at: 0) as? GetTertiaryBreedingPrograms
                            tertiaryBreedingId =   tertiaryRy!.priorityBreedId ?? ""
                            ob.tertiaryPriorityProgramId = tertiaryBreedingId
                            
                        }
                        if value.date != "" {
                            
                            datee = getOrderDateChange(date: value.date ?? "")
                            ob.dob = datee
                        }
                        
                        if value.animalTag != ""{
                            ob.sampleBarCode = value.animalTag
                        }
                        
                        if value.offsireId != "" {
                            ob.series = value.offsireId
                        }
                        
                        if value.offDamId != ""{
                            ob.rgd = value.offDamId
                        }
                        
                        if value.offPermanentId != "" {
                            ob.rgn = value.offPermanentId
                        }
                        
                        if value.animalbarCodeTag != ""{
                            ob.animalName = value.animalbarCodeTag
                        }
                        ob.breedId = value.breedId
                        ob.providerId = Int(value.providerId)
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        }else  {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                        
                    } else { //nonGenotype
                        
                        if value.date != "" {
                            datee = getOrderDateChange(date: value.date ?? "")
                            ob.dob = datee
                        }
                        
                        if value.animalTag != ""{
                            ob.sampleBarCode = value.animalTag
                        }
                        if value.animalbarCodeTag != ""{
                            ob.animalName = value.animalbarCodeTag
                        }
                        if value.offsireId != "" {
                            ob.series = value.offsireId
                        }
                        if value.offDamId != ""{
                            ob.rgd = value.offDamId
                        }
                        if value.offPermanentId != "" {
                            ob.rgn = value.offPermanentId
                        }
                        if UserDefaults.standard.string(forKey: keyValue.bfProductId.rawValue) == "24"
                        {
                            
                            ob.breedId = value.breedId
                        }
                        ob.providerId = Int(value.providerId )
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        } else  {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                    }
                }
                if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 7  {
                    if value.date != "" {
                        print(value)
                        datee = getOrderDateChange(date: value.date ?? "")
                    }
                    if value.animalTag != "" {
                        ob.animalTag = value.animalTag
                    }
                    
                    if value.animalbarCodeTag != ""{
                        ob.sampleBarCode = value.animalbarCodeTag
                    }
                    
                    if value.eT != "" {
                        ob.animalName = value.eT
                    }
                    
                    if value.offsireId != "" {
                        ob.sireRegNumber = value.offsireId
                    }
                    if value.offDamId != ""{
                        ob.damRegNumber = value.offDamId
                    }
                    
                    if value.offPermanentId != ""{
                        ob.breedRegNumber = value.offPermanentId
                    }
                    
                    let sireRegAssocation = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 25, association: value.sireIDAU ?? "")
                    if sireRegAssocation.count != 0 {
                        
                        let medbreedRegArr1 = sireRegAssocation.object(at: 0) as? GetBreedSocieties
                        sireRegAssocationbreedAssociationId =   medbreedRegArr1!.associationId ?? ""
                        ob.breedAssociationId = sireRegAssocationbreedAssociationId
                        
                    }
                    
                    
                    ob.providerId = Int(value.providerId)
                    if value.breedId == "" {
                        ob.breedId = "d352c4c2-2ff9-451a-9c00-4f0f5604b387"
                    } else {
                        
                        ob.breedId = value.breedId
                        
                    }
                    ob.sampleTypeId = Int(value.tissuId)
                    let sexName = value.gender ?? ""
                    
                    if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                        
                        nameSex = "F"
                    } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                        nameSex = "M"
                        
                    } else  {
                        nameSex = "F"
                    }
                    
                    ob.sex = nameSex
                }
                let productData = fetchAllDataOrderStatusIsSyncOfflineProductBeef(entityName: Entities.productAdonAnimlBeefTblEntity, orderId: orderId,userId: userId, status: "true", animalId:Int(value.animalId))
                
                var product = ProductDetailSubmit()
                for item in productData{
                    var productSubmit = ProductSubmit()
                    if let productValue = item as? ProductAdonAnimlTbLBeef{
                        productSubmit.productID = productValue.productId
                        product.products.append(productSubmit)
                        
                        let addonId = fetchSubProductDataTrueSelectedISYNCAdonsBeefOfflineAdon(orderId:orderId,userId:userId, productId: Int(productValue.productId), animalID: Int(productValue.animalId))
                        
                        var addOn = AddOnSubmit()
                        for item in addonId {
                            if let addOnValue = item as? SubProductTblBeef{
                                addOn.addOnID = addOnValue.adonId
                                product.addOns.append(addOn)
                            }
                        }
                        ob.productDetails.append(product)
                        product = ProductDetailSubmit()
                      
                    }
                }
            }
            
            apiSyncClass.animals.append(ob)
            ob = AnimalDetail()
        }
        let custId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
        apiSyncClass.customerId = String(custId)
        apiSyncClass.billToCustomerId = String(billToCustomerId)
        apiSyncClass.species = marketNameType.Beef.rawValue
        apiSyncClass.isOFFline = true
        if beefpvid == 5 {
            
            let selectedPrimaryBreed = UserDefaults.standard.value(forKey: keyValue.selectedPrimaryBreed.rawValue) as? String
            if  selectedPrimaryBreed != ""{
                apiSyncClass.breed1 = selectedPrimaryBreed
            }
            
            let selectedSecondaryBreed = UserDefaults.standard.value(forKey: keyValue.selectedSecondaryBreed.rawValue) as? String
            if  selectedSecondaryBreed != "" {
                apiSyncClass.breed2 = selectedSecondaryBreed
            }
            
            let selectedTertiaryBreed = UserDefaults.standard.value(forKey: keyValue.selectedTertiaryBreed.rawValue) as? String
            if  selectedTertiaryBreed != ""  {
                apiSyncClass.breed3 = selectedTertiaryBreed
            }
            
        }
        apiSyncClass.nominatorId = 0
        apiSyncClass.providerId = beefpvid
        
        
        do {
            let jsonEncoder = JSONEncoder()
            var jsonData: Data?
            do {
                jsonData = try jsonEncoder.encode(apiSyncClass)
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
            let _: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
            let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
            let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
            
            var urlString = String()
            if UserDefaults.standard.bool(forKey: keyValue.emailBeef.rawValue) {
                urlString = Configuration.Dev(packet: ApiKeys.emailSave.rawValue).getUrl()
            }
            else {
                urlString = Configuration.Dev(packet: ApiKeys.orderSave.rawValue).getUrl()
            }
            
            var request = URLRequest(url: URL(string: urlString)! )
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headerDict
            request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
            request.httpBody = body
            
            AF.request(request as URLRequestConvertible).responseJSON { response in
                let statusCode =  response.response?.statusCode
                
                NotificationCenter.default.post(name: Notification.Name(LocalizedStrings.sessionExpiredStr), object: nil, userInfo: [LocalizedStrings.statusCodeText:"\(String(describing: response.response?.statusCode ?? 0))"])
                
                if statusCode == 401  {
                    self.delegeteSyncApi!.failWithErrorOffline(statusCode: statusCode!)
                    return
                }
                else if statusCode == 500 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408{
                    self.delegeteSyncApi!.failWithErrorInternalOffline()
                    self.delegeteSyncApi!.failWithErrorOffline(statusCode: statusCode!)
                    return
                }
                
                switch response.result {
                    
                case .success(let responseObject):
                    
                    print(responseObject)
                    self.delegeteSyncApi!.didFinishApiOffline(response:self.orderString)
                    self.myGroup.leave()
                    
                case .failure(let encodingError):
                    
                    if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                        self.delegeteSyncApi!.failWithErrorInternalOffline()
                        print(err)
                    } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                        // other failures
                        print (encodingError)
                        print (responseString)
                        if let s = statusCode {
                            
                            self.delegeteSyncApi!.failWithErrorOffline(statusCode: s)
                        }
                        else {
                            self.delegeteSyncApi!.failWithErrorInternalOffline()
                        }
                    }
                }
            }
        }
        
    }
    func getOrderDateChange(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatters.ddMMyyyyFormat
        let date1 = dateFormatter.date(from: date ) ?? Date()// create   date from string
        dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
        
        let timeStamp = dateFormatter.string(from: date1)
        print(timeStamp)
        return timeStamp
    }
    func temp(data:OfflineOrder){
        let orderId = Int(data.orderId)
        let isemail = data.statusEmail
        apiSyncClass.animals.removeAll()
        let animaltbl = fetchAllDataOrderStatusIsSyncOfflineAnimal(entityName: Entities.animalAddTblEntity, isSync: "false", orderId: orderId,userId: userId,status:"true")
        
        for item in animaltbl {
            
            var ob = AnimalDetail()
            if let value = item as? AnimaladdTbl {
                
                if value.date != "" {
                    print(value)
                    datee = getOrderDateChange(date: value.date ?? "")
                    ob.dob = datee
                }
                ob.earTag = value.earTag
                ob.bornTypeId = Int(value.selectedBornTypeId)
                ob.onFarmId = value.farmId
                ob.officialTag = value.animalTag
                ob.sampleBarCode = value.animalbarCodeTag
                ob.officialPermanentId = value.animalTag
                ob.providerId = Int(value.providerId)
                ob.breedId = value.breedId
                ob.sampleTypeId = Int(value.tissuId)
                let sexName = value.gender ?? ""
                if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                    
                    nameSex = "F"
                } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                    nameSex = "M"
                    
                } else  {
                    nameSex = "F"
                }
                
                ob.sex = nameSex
                ob.nationalHerdId = value.nationHerdAU
                ob.sireId = value.offsireId
                ob.dob = datee
                ob.sireYOB = 0
                ob.damYOB = 0
                let productData = fetchAllDataOrderStatusIsSyncOffline(entityName: Entities.productAdonAnimalTblEntity, isSync: "false", orderId: orderId,userId: userId,status:"true",animalTag:value.animalTag ?? "", animalID: Int(value.animalId))
                
                
                var product = ProductDetailSubmit()
                for item in productData{
                    var productSubmit = ProductSubmit()
                    if let productValue = item as? ProductAdonAnimalTbl{
                        productSubmit.productID = productValue.productId
                        product.products.append(productSubmit)
                        
                        let addonId = fetchSubProductDataTrueSelectedISYNCAdons(isSync: "false", status: "true", orderstatus: "true",orderId:orderId,userId:userId, productId: Int(productValue.productId), animalID: Int(productValue.animalId))
                        
                        var addOn = AddOnSubmit()
                        for item in addonId {
                            if let addOnValue = item as? SubProductTbl{
                                addOn.addOnID = addOnValue.adonId
                                product.addOns.append(addOn)
                            }
                        }
                        ob.productDetails.append(product)
                        product = ProductDetailSubmit()
                    }
                }
            }
            
            apiSyncClass.animals.append(ob)
            ob = AnimalDetail()
        }
        
        let custId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
        apiSyncClass.customerId = String(custId)
        apiSyncClass.billToCustomerId = String(billToCustomerId)
        apiSyncClass.species = marketNameType.Dairy.rawValue
        apiSyncClass.isOFFline = true
        apiSyncClass.nominatorId = nominatorid
        apiSyncClass.providerId = pvid
        
        do {
            let jsonEncoder = JSONEncoder()
            var jsonData: Data?
            do {
                jsonData = try jsonEncoder.encode(apiSyncClass)
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
            let _: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
            let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
            let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
            
            var urlString = String()
            if isemail == "true" {
                urlString = Configuration.Dev(packet: ApiKeys.emailSave.rawValue).getUrl()
            }
            else {
                urlString = Configuration.Dev(packet: ApiKeys.orderSave.rawValue).getUrl()
            }
            
            var request = URLRequest(url: URL(string: urlString)! )
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headerDict
            request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
            request.httpBody = body
            
            AF.request(request as URLRequestConvertible).responseJSON { response in
                let statusCode =  response.response?.statusCode
                NotificationCenter.default.post(name: Notification.Name(LocalizedStrings.sessionExpiredStr), object: nil, userInfo: [LocalizedStrings.statusCodeText:"\(String(describing: response.response?.statusCode ?? 0))"])
                
                if statusCode == 401  {
                    self.delegeteSyncApi!.failWithErrorOffline(statusCode: statusCode!)
                    return
                }
                else if statusCode == 500 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408{
                    self.delegeteSyncApi!.failWithErrorInternalOffline()
                    self.delegeteSyncApi!.failWithErrorOffline(statusCode: statusCode!)
                    return
                }
                
                switch response.result {
                case .success(let responseObject):
                    print(responseObject)
                    if isemail == "true"{
                        self.delegeteSyncApi!.didFinishApiOffline(response:self.orderString)
                        self.myGroup.leave()
                    }
                    else {
                        self.delegeteSyncApi!.didFinishApiOffline(response:self.orderString)
                        self.myGroup.leave()
                    }
                    
                case .failure(let encodingError):
                    if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                        self.delegeteSyncApi!.failWithErrorInternalOffline()
                        print(err)
                    } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                        print (encodingError)
                        print (responseString)
                        if let s = statusCode {
                            
                            self.delegeteSyncApi!.failWithErrorOffline(statusCode: s)
                        }
                        else {
                            self.delegeteSyncApi!.failWithErrorInternalOffline()
                        }
                    }
                }
            }
        }
    }
    
    func saveAnimaldata() {
        var orderIdData = NSArray()
        if UserDefaults.standard.string(forKey: keyValue.name.rawValue) == marketNameType.Beef.rawValue {
            orderIdData = fetchAllData(entityName: Entities.offlineOrderBeefTblEntity)
            for j in 0..<orderIdData.count{
                let data = orderIdData.object(at: j) as! OfflineOrderBeef
                myGroup.enter()
                tempBeef(data: data)
                
            }
        }
        else {
            orderIdData = fetchAllData(entityName: Entities.offlineOrderTblEntity)
            for j in 0..<orderIdData.count{
                let data = orderIdData.object(at: j) as! OfflineOrder
                myGroup.enter()
                temp(data: data)
                
            }
        }
        
        myGroup.notify(queue: .main) {
            self.delegeteSyncApi!.didFinishApiOffline(response:self.orderString)
        }
    }
    
    func productSave(orderId:Int,animalTag:String){
        let loginTbl = loginData.object(at: 0) as! LoginTbl
        let fethAdonData = fetchAllDataOrderStatusIsSyncOffline(entityName: Entities.productAdonAnimalTblEntity, isSync: "false", orderId: orderId,userId: userId,status:"true",animalTag:animalTag)
        
        let adonServerArray = NSMutableArray()
        let  adonDictOnServer = NSMutableDictionary()
        
        for i in 0..<fethAdonData.count{
            let adonDict = NSMutableDictionary()
            let adondata = fethAdonData.object(at: i) as! ProductAdonAnimalTbl
            
            adonDict.setValue(adondata.farmId, forKey: keyValue.onFarmId.rawValue)
            adonDict.setValue(adondata.animalTag, forKey: keyValue.officialTag.rawValue)
            adonDict.setValue(adondata.udid, forKey: keyValue.deviceOrderId.rawValue)
            adonDict.setValue(adondata.orderId, forKey: keyValue.capsOrderId.rawValue)
            adonDict.setValue(adondata.animalbarCodeTag, forKey: keyValue.sampleBarCode.rawValue)
            adonDict.setValue(adondata.productId, forKey: keyValue.productId.rawValue)
            adonDict.setValue(adondata.providerId, forKey: keyValue.capsProviderId.rawValue)
            adonDict.setValue(Int(loginTbl.userId!), forKey: keyValue.capsUserId.rawValue)
            adonDict.setValue(keyValue.offline.rawValue, forKey: keyValue.isOffline.rawValue)
            adonServerArray.add(adonDict)
        }
        
        adonDictOnServer.setValue(adonServerArray, forKey: keyValue.productDetails.rawValue)
        do {
             let jsonData = try JSONSerialization.data(withJSONObject: adonDictOnServer,
                                                       options: .prettyPrinted)
             if var jsonString = String(data: jsonData, encoding: .utf8) {
                 jsonString = jsonString.trimmingCharacters(in: .whitespacesAndNewlines)
                 print("JSON Payload:", jsonString)
             }
             let headerDict: [String:String] = [
                 LocalizedStrings.authorizationHeader: "BEARER ea4369e9-d4a9-4322-856b-5323e21ff351"
             ]
             
             let urlString = Configuration.Dev(packet: ApiKeys.productSave.rawValue).getUrl()
             guard let url = URL(string: urlString) else {
                 print("Invalid URL: \(urlString)")
                 return
             }
             
             var request = URLRequest(url: url)
             request.httpMethod = "POST"
             request.allHTTPHeaderFields = headerDict
             request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
             request.httpBody = jsonData
            
            AF.request(request as URLRequestConvertible).responseJSON { response in
                let statusCode =  response.response?.statusCode
                
                if statusCode == 401  {
                    self.delegeteSyncApi!.failWithErrorOffline(statusCode: statusCode!)
                }
                else if statusCode == 500 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408{
                    self.delegeteSyncApi!.failWithErrorInternalOffline()
                    self.delegeteSyncApi!.failWithErrorOffline(statusCode: statusCode!)
                }
                
                switch response.result {
                    
                case .success(let responseObject):
                    print("responseObject = \( responseObject)")
                    if statusCode  == 200 {
                        UserDefaults.standard.set(false, forKey: keyValue.syncOff.rawValue)
                        self.myGroup.leave()
                        
                    }
                    
                case .failure(let encodingError):
                    
                    if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                        print(err)
                    } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                        // other failures
                        print (encodingError)
                        print (responseString)
                        if statusCode == 200 {
                            self.orderString = (responseString as? Any)! as! String
                            print("responseObject = \( self.orderString)")
                        } else {
                            self.delegeteSyncApi!.failWithErrorInternalOffline()
                        }
                    }
                }
            }
        }
        catch {
            print("Failed to serialize JSON:", error.localizedDescription)
        }
    }
    
    func saveProductData(dataModel:ProductResponse){
        self.orderString = dataModel.ServerOrderId ?? ""
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = DateFormatters.MMddyyyy0000Format
        dateformatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
        let dates = dateformatter.date(from: (dataModel.OrderDate)!)
        
        saveorderResponse(entity: Entities.productResponseTblEntity, actionRequired: dataModel.ActionRequired ?? "", orderDate: dates!, orderId: dataModel.OrderId, orderStatus: dataModel.OrderStatus ?? "", packageRecieved: dataModel.PackageRecieved ?? "", sampleCount: String(dataModel.SampleCount), serverOrderId: dataModel.ServerOrderId ?? "",userId:userId)
        let data = dataModel.ProductStatus
        for item in data {
            for item1 in item.Addons{
                print(item1)
                saveAdonServerRes(entity: Entities.adOnServerResponseTblEntity, adonId: item1.AddonId , adonName: item1.AddonName ?? "", offbarcde: item.BarCode ?? "", offfarmId: item.OnFarmId ?? "", offId: item.OfficialId ?? "", productId: item.ProductId, serverId: dataModel.ServerOrderId ?? "",userId:userId)
            }
            saveProductResponseFromServer(entity: Entities.productResonseServerTblEntity, productId: item.ProductId, productName: item.ProductName ?? "", offId: item.OfficialId ?? "", farmId: item.OnFarmId ?? "",  barcOde: item.BarCode ?? "", serverId: dataModel.ServerOrderId ?? "", serverstatus: dataModel.OrderStatus ?? "", productStatus: item.ProductStatus ?? "", userId: userId,actreq:dataModel.ActionRequired ?? "", rgn: item.RGN ?? "",rgd: item.RGD ?? "", series: item.Series ?? "",earTag:item.EarTag ?? "")
            
        }
    }
    
    
    func multipleAdonSave(orderId:Int,animalTag:String){
        let loginTbl = loginData.object(at: 0) as! LoginTbl
        let fethAdonData = fetchAllDataOrderStatusIsSyncOffline(entityName: Entities.subProductTblEntity, isSync: "false", orderId: orderId,userId: userId,status:"true", animalTag: animalTag)
        
        let adonServerArray = NSMutableArray()
        let adonDictOnServer = NSMutableDictionary()
        
        for i in 0..<fethAdonData.count{
            let adonDict = NSMutableDictionary()
            let adondata = fethAdonData.object(at: i) as! SubProductTbl
            
            adonDict.setValue(adondata.animalTag, forKey: keyValue.onFarmId.rawValue)
            adonDict.setValue(adondata.animalTag, forKey: keyValue.officialTag.rawValue)
            adonDict.setValue(adondata.udid, forKey: keyValue.deviceOrderId.rawValue)
            adonDict.setValue(adondata.orderId, forKey: keyValue.capsOrderId.rawValue)
            adonDict.setValue(adondata.animalbarCodeTag, forKey: keyValue.sampleBarCode.rawValue)
            adonDict.setValue(adondata.productId, forKey: keyValue.productId.rawValue)
            adonDict.setValue(adondata.adonId, forKey: keyValue.addOnId.rawValue)
            adonDict.setValue(Int(loginTbl.userId!), forKey: keyValue.capsUserId.rawValue)
            adonDict.setValue(keyValue.offline.rawValue, forKey: keyValue.isOffline.rawValue)
            adonServerArray.add(adonDict)
        }
        
        adonDictOnServer.setValue(adonServerArray, forKey: keyValue.addOnDetails.rawValue)
        do {
            
            let jsonData = try JSONSerialization.data(withJSONObject: adonDictOnServer,
                                                       options: .prettyPrinted)
            
            if var jsonString = String(data: jsonData, encoding: .utf8) {
                 jsonString = jsonString.trimmingCharacters(in: .whitespacesAndNewlines)
                 print("JSON Payload:", jsonString)
             }
             
             let headerDict: [String:String] = [
                 LocalizedStrings.authorizationHeader: "BEARER ea4369e9-d4a9-4322-856b-5323e21ff351"
             ]
             
             let urlString = Configuration.Dev(packet: ApiKeys.adonSave.rawValue).getUrl()
             guard let url = URL(string: urlString) else {
                 print("Invalid URL:", urlString)
                 return
             }
             
             var request = URLRequest(url: url)
             request.httpMethod = "POST"
             request.allHTTPHeaderFields = headerDict
             request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
             request.httpBody = jsonData
            
            AF.request(request as URLRequestConvertible).responseJSON { response in
                let statusCode =  response.response?.statusCode
                
                if statusCode == 401  {
                    self.delegeteSyncApi!.failWithErrorOffline(statusCode: statusCode!)
                }
                else if statusCode == 500 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408{
                    self.delegeteSyncApi!.failWithErrorInternalOffline()
                    self.delegeteSyncApi!.failWithErrorOffline(statusCode: statusCode!)
                }
                
                switch response.result {
                    
                case .success(let responseObject):
                    print(responseObject )
                    self.productSave(orderId: orderId, animalTag: animalTag)
                    // internet works.
                case .failure(let encodingError):
                    
                    if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                        self.delegeteSyncApi!.failWithErrorInternalOffline()
                        print(err)
                    } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                        print (encodingError)
                        print (responseString)
                        if let s = statusCode {
                            self.delegeteSyncApi!.failWithErrorOffline(statusCode: s)
                        }
                        else {
                            self.delegeteSyncApi!.failWithErrorInternalOffline()
                        }
                    }
                }
            }
        }
        catch {
            print("Failed to serialize JSON:", error.localizedDescription)
        }
    }
}
