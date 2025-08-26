//
//  ApiSync.swift
//  SearchPoint
//
//  Created by "" on 10/12/2019.
//

import UIKit
import Alamofire
import MBProgressHUD
import SystemConfiguration
import CoreData

class ApiSync :NSObject {
    
    var orderString = String()
    let loginData = fetchAllData(entityName: Entities.LoginTblEntity)
    var delegeteSyncApi : syncApi?
    var modalObject:ProductResponse?
    var submitBeefOrderObject: OrderSubmitResponse?
    var userId = Int()
    var idProvider = Int16()
    var orderId = Int()
    var speciesIdClass = Int()
    var apiSyncClass = ApiSyncModal()
    var nameSex = String()
    let billToCustomerId = UserDefaults.standard.integer(forKey: keyValue.billToCustomerId.rawValue)
    let custId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
    var nominatorName =  UserDefaults.standard.value(forKey: keyValue.nominatorSave.rawValue) as? String
    var nominatorid = Int()
    var pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
    var sireNameAus = String()
    var beefpvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
    var orderIdBeef = Int()
    
    override init() {
        super.init()
        print(pvid)
        orderIdBeef = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        if UserDefaults.standard.string(forKey: keyValue.name.rawValue) == marketNameType.Beef.rawValue{
            speciesIdClass = 2
        }
        else{
            speciesIdClass = 1
        }
        
        if nominatorName == keyValue.zoetis.rawValue || nominatorName == nil{
            nominatorid = 1
        } else if nominatorName == keyValue.holsteinUSA.rawValue {
            nominatorid = 2
            
        }
    }
    
    func saveAnimaldata(submitEmailFlag :Bool){
        
        let animaltbl = fetchAllDataOrderStatusIsSync(entityName: Entities.animalAddTblEntity, isSync: "false",ordestatus: "false",status:"true", orderId: orderId,userId: userId)
        
        for item in animaltbl{
            
            var ob = AnimalDetail()
            if let value = item as? AnimaladdTbl{
                if value.date != "" {
                    print(value)
                    ob.dob = getOrderDateChange(date: value.date ?? "")
                }
                //Mandotry Fields
                ob.earTag = value.earTag
                ob.bornTypeId = Int(value.selectedBornTypeId)
                
                if value.farmId != "" {
                    ob.onFarmId = value.farmId
                }
                
                if value.animalTag != "" {
                    ob.officialTag = value.animalTag
                }
                
                if value.eid != "" {
                    ob.eid = value.eid
                }
                ob.sampleBarCode = value.animalbarCodeTag
                ob.providerId = Int(value.providerId )
                ob.breedId = value.breedId ?? ""
                ob.sampleTypeId = Int(value.tissuId)
                ob.eid = value.eid
                ob.girlandoID = value.girlandoID ?? ""
                let sexName = value.gender ?? ""
                
                if sexName == ButtonTitles.femaleText.localized || sexName == "female".localized{
                    
                    nameSex = "F"
                } else if sexName == ButtonTitles.maleText.localized || sexName == "male".localized {
                    nameSex = "M"
                    
                } else {
                    nameSex = "F"
                }
                
                ob.sex = nameSex
                
                if value.offsireId != "" {
                    let sireIdAus = fetchAusNaabBullDataWithBullid(entityName: Entities.ausNaabBullTblEntity,bullId:value.offsireId ?? "")
                    if sireIdAus.count != 0 {
                        let nationHerdAU1 = sireIdAus.object(at: 0) as? AusNaabBull
                        sireNameAus =   nationHerdAU1?.sireNationalId ?? ""
                        ob.officialSireId = sireNameAus
                    } else {
                        ob.officialSireId = value.offsireId
                    }
                }
               
                
                if value.offDamId != ""{
                    ob.officialDamId = value.offDamId
                }
                
                let productData =  fetchAllDataFarmIdStatusisSync(entityName: Entities.productAdonAnimalTblEntity, asending: true, status: "true", isSync: "false",orderstatus:"false",orderId:orderId,userId:userId, animalID: Int(value.animalId))
                
                var product = ProductDetailSubmit()
                for item in productData{
                    var productSubmit = ProductSubmit()
                    if let productValue = item as? ProductAdonAnimalTbl{
                        productSubmit.productID = productValue.productId
                        product.products.append(productSubmit)
                        let addonId = fetchSubProductDataTrueSelectedISYNCAdons(isSync: "false", status: "true", orderstatus: "false",orderId:orderId,userId:userId, productId: Int(productValue.productId), animalID: Int(productValue.animalId))
                        
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
        apiSyncClass.customerId = String(custId)
        apiSyncClass.billToCustomerId = String(billToCustomerId)
        apiSyncClass.species = marketNameType.Dairy.rawValue
        apiSyncClass.isOFFline = false
        apiSyncClass.nominatorId = nominatorid
        apiSyncClass.providerId = pvid
        let _: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        let email = UserDefaults.standard.value(forKey:keyValue.userName.rawValue) as! String
        apiSyncClass.emailOrder = true
        apiSyncClass.emailAddresses = [email]
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(apiSyncClass)
        let json = String(data: jsonData, encoding: String.Encoding.utf8)
        print(json!)
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        var urlString = String()
        if UserDefaults.standard.bool(forKey: keyValue.submitBtnFlag.rawValue) {
            urlString = Configuration.Dev(packet: ApiKeys.emailSave.rawValue).getUrl()
        }
        else {
            urlString = Configuration.Dev(packet: ApiKeys.orderSave.rawValue).getUrl()
        }
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headerDict
        
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        request.httpBody = jsonData
        
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            
            NotificationCenter.default.post(name: Notification.Name(LocalizedStrings.sessionExpiredStr), object: nil, userInfo: [LocalizedStrings.statusCodeText:"\(String(describing: response.response?.statusCode ?? 0))"])
            if statusCode == 401  {
                
                self.delegeteSyncApi!.failWithError(statusCode: statusCode!)
            }
            else if statusCode == 500 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408 {
                self.delegeteSyncApi!.failWithErrorInternal()
                self.delegeteSyncApi!.failWithError(statusCode: statusCode!)
            }
            
            switch response.result {
            case .success(let responseObject):
                _ = responseObject
                self.delegeteSyncApi!.didFinishApi(response:self.orderString)
                
            case .failure(let encodingError):
                
                if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                    self.delegeteSyncApi!.failWithErrorInternal()
                    print(err)
                } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                    // other failures
                    print (encodingError)
                    print (responseString)
                    if let s = statusCode {
                        
                        self.delegeteSyncApi!.failWithError(statusCode: s)
                    }
                    else {
                        self.delegeteSyncApi!.failWithErrorInternal()
                    }
                }
            }
        }
    }
    
    func getOrderDateChange(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatters.ddMMyyyyFormat
        let date1 = dateFormatter.date(from: date )// create   date from string
        dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
        let timeStamp = dateFormatter.string(from: date1 ?? Date())
        print(timeStamp)
        return timeStamp
    }
    
    func saveBeefUSAnimalData(){
        let animaltbl = fetchAllDataOrderStatusIsSync(entityName: Entities.beefAnimalAddTblEntity, isSync: "false",ordestatus: "false",status:"true", orderId: orderIdBeef,userId: userId)
        var datee = String()
        let beefPvId = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        
        for item in animaltbl{
            var ob = AnimalDetail()
            if let value = item as? BeefAnimaladdTbl{
                
                if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 13 {
                    if value.date != "" {
                        print(value)
                        datee = getOrderDateChange(date: value.date ?? "")
                    }
                    
                    ob.uniqueID = value.animalTag //barcode genotype
                    ob.sampleBarCode = value.animalbarCodeTag ///animal genotype
                    if value.sireIDAU != ""{
                        ob.visualID = value.sireIDAU
                    }
                    ob.onFarmId = ""
                    
                    ob.providerId = Int(value.providerId )
                    ob.sampleType = value.tissuName ?? ButtonTitles.allflexTSUText
                    ob.breedId = value.breedId
                    ob.sampleTypeId = Int(value.tissuId)
                    let sexName = value.gender ?? ""
                    
                    if sexName == ButtonTitles.femaleText.localized || sexName == "female".localized{
                        
                        nameSex = "F"
                    }else if sexName == ButtonTitles.maleText.localized || sexName == "male".localized {
                        nameSex = "M"
                        
                    } else {
                        nameSex = "F"
                    }
                    ob.sex = nameSex
                    ob.birthDate = datee
                    
                }
                let productData =  fetchAllDataFarmIdStatusisSync(entityName: Entities.productAdonAnimlBeefTblEntity, asending: true, status: "true", isSync: "false",orderstatus:"false",orderId:orderIdBeef,userId:userId, animalID: Int(value.animalId))
                
                var product = ProductDetailSubmit()
                for item in productData{
                    var productSubmit = ProductSubmit()
                    if let productValue = item as? ProductAdonAnimlTbLBeef{
                        productSubmit.productID = productValue.productId
                        product.products.append(productSubmit)
                        
                        let addonId = fetchSubProductDataTrueSelectedISYNCAdonsBeef(isSync: "false", status: "true", orderstatus: "false",orderId:orderIdBeef,userId:userId, productId: Int(productValue.productId), animalID: Int(productValue.animalId))
                        
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
        
        let addDealerCodeCheck = UserDefaults.standard.value(forKey: keyValue.addDealerCodeCheck.rawValue) as? Bool
        let dealerCode = UserDefaults.standard.value(forKey: keyValue.dealerCode.rawValue) as? String
        
        if !(addDealerCodeCheck ?? false) {
          if dealerCode == "" || dealerCode == nil{
              apiSyncClass.dealerCode = ""
          } else{
              apiSyncClass.dealerCode = dealerCode
          }
          
            
        }
        else {
            apiSyncClass.dealerCode = ""
        }
        
        apiSyncClass.customerId = String(custId)
        apiSyncClass.billToCustomerId = String(billToCustomerId)
        apiSyncClass.species = marketNameType.Beef.rawValue
        let _: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        _ = UserDefaults.standard.value(forKey:keyValue.userName.rawValue) as! String
        apiSyncClass.nominatorId = 1
        apiSyncClass.providerId = beefpvid
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(apiSyncClass)
        let json = String(data: jsonData, encoding: String.Encoding.utf8)
        print(json!)
        _ = loginData.object(at: 0) as! LoginTbl
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let urlString = Configuration.Dev(packet: ApiKeys.blockYardSubmitOrder.rawValue).getUrl()
        
        NSLog("urlString= ",urlString)
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headerDict
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        request.httpBody = jsonData
        UserDefaults.standard.setValue("", forKey: keyValue.dealerCode.rawValue)
        UserDefaults.standard.set(true, forKey: keyValue.addDealerCodeCheck.rawValue)
        UserDefaults.standard.set(nil, forKey: "USDairyGender")
        UserDefaults.standard.set(nil, forKey: "InheritBeefGender")
        UserDefaults.standard.set(nil, forKey: "GirlandoGender")
        UserDefaults.standard.set(nil, forKey: "GenoGender")
        UserDefaults.standard.set(nil, forKey: "NonGenoGender")
        UserDefaults.standard.set(nil, forKey: "DEUSDairyGender")
        UserDefaults.standard.set(nil, forKey: "DEInheritBeef")
        UserDefaults.standard.set(nil, forKey: "DEGirlandoGender")
        UserDefaults.standard.set(nil, forKey: "DEGenoGender")
        UserDefaults.standard.set(nil, forKey: "DENonGenoGender")
        
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            
            NotificationCenter.default.post(name: Notification.Name(LocalizedStrings.sessionExpiredStr), object: nil, userInfo: [LocalizedStrings.statusCodeText:"\(String(describing: response.response?.statusCode ?? 0))"])
            
            if statusCode == 401  {
                self.delegeteSyncApi!.failWithError(statusCode: statusCode!)
                return
            }
            else if statusCode == 500 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408{
                self.delegeteSyncApi!.failWithErrorInternal()
                self.delegeteSyncApi!.failWithError(statusCode: statusCode!)
                return
            }
            
            switch response.result {
                
            case .success(_):
                let data = response.data
                let decoder = JSONDecoder()
                self.submitBeefOrderObject = try! decoder.decode(OrderSubmitResponse.self, from: data!)
                if beefPvId ==  13 {
                    if self.submitBeefOrderObject?.success == true{
                        self.delegeteSyncApi?.didFinishApi(response: self.submitBeefOrderObject?.message ?? "")
                    } else {
                        switch self.submitBeefOrderObject?.responseCode {
                        case 22:
                            self.delegeteSyncApi!.didFinishApi(response:LocalizedStrings.orderSubmittedUnsuccessful.localized)
                        case 23:
                            self.delegeteSyncApi?.didFinishApi(response: LocalizedStrings.referenceCSVFile.localized)
                        case 24 :
                            self.delegeteSyncApi?.didFinishApi(response: LocalizedStrings.logIntoBlockyard.localized)
                        case 25 :
                            self.delegeteSyncApi?.didFinishApi(response: LocalizedStrings.orderSubmittedUnsuccessful.localized)
                        case 26 :
                            self.delegeteSyncApi?.didFinishApi(response: LocalizedStrings.orderRequestNodata.localized)
                        default:
                            self.delegeteSyncApi!.didFinishApi(response:LocalizedStrings.bloackYardOrderUnsuccessful.localized)
                        }
                    }
                    
                } else {
                    self.delegeteSyncApi!.didFinishApi(response:self.orderString)
                }
            case .failure(let encodingError):
                
                if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                    self.delegeteSyncApi!.failWithErrorInternal()
                    print(err)
                } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                    // other failures
                    print (encodingError)
                    print (responseString)
                    if let s = statusCode {
                        self.delegeteSyncApi!.failWithError(statusCode: s)
                    }
                    else
                    {
                        self.delegeteSyncApi!.failWithErrorInternal()
                    }
                }
            }
        }
    }
    
    
    func saveAnimaldataBEEF(){
        _ = loginData.object(at: 0) as! LoginTbl
        let animaltbl = fetchAllDataOrderStatusIsSync(entityName: Entities.beefAnimalAddTblEntity, isSync: "false",ordestatus: "false",status:"true", orderId: orderIdBeef,userId: userId)
        var datee = String()
        var breedAssociationId = String()
        var breedAssociationId1 = String()
        var sireIDAUbreedAssociationId1 = String()
        var sireRegAssocationbreedAssociationId = String()
        var breedAssociationIdInherit = String()
        var secondaRyBreedingId = String()
        var  tertiaryBreedingId = String()
        var priorityBreedingId = String()
        _ =  fetchSubProductDataTrueSelectedISYNCBeef (isSync: "false", status: "true", orderstatus: "false",orderId:orderIdBeef,userId:userId)
        _ = NSMutableArray()
        _ = animaltbl.object(at: 0) as? BeefAnimaladdTbl
        _ = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        
        for item in animaltbl{
            var ob = AnimalDetail()
            if let value = item as? BeefAnimaladdTbl{
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
                        
                        ob.earTag = value.animalTag //barcode genotype
                        ob.sampleBarCode = value.animalbarCodeTag ///animal genotype
                        ob.bornTypeId = Int(value.selectedBornTypeId)
                        if value.eT != ""{
                            ob.animalName = value.eT
                        }
                        
                        if value.offsireId != "" {
                            ob.sireRegNumber = value.offsireId
                        }
                        
                        if value.offDamId != ""{
                            ob.damRegNumber = value.offDamId
                        }
                        
                        if value.offPermanentId != "" {
                            ob.breedRegNumber = value.offPermanentId
                        }
                        
                        ob.providerId = Int(value.providerId)
                        if value.breedId == "" {
                            ob.breedId = "d352c4c2-2ff9-451a-9c00-4f0f5604b387"
                            
                        }else {
                            ob.breedId = value.breedId
                            
                        }
                        
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female".localized{
                            
                            nameSex = "F"
                        }else if sexName == ButtonTitles.maleText.localized || sexName == "male".localized {
                            nameSex = "M"
                            
                        }else {
                            nameSex = "F"
                        }
                        ob.sex = nameSex
                        
                    } else { //INHERIT
                        
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
                        
                        
                        ob.earTag = value.animalTag //barcode genotype
                        ob.sampleBarCode = value.animalbarCodeTag ///animal genotype
                        if value.sireIDAU != ""{
                            ob.eid = value.sireIDAU
                        }
                        if value.nationHerdAU != ""{
                            
                            ob.secondaryId = value.nationHerdAU
                        }
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
                        
                        if value.breedId != "" {
                            ob.breedId = value.breedId
                        }
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female".localized{
                            
                            nameSex = "F"
                        }else if sexName == ButtonTitles.maleText.localized || sexName == "male".localized {
                            nameSex = "M"
                            
                        } else {
                            nameSex = "F"
                        }
                        ob.sex = nameSex
                        ob.dob = datee
                    }
                }
                
                if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 6  {
                    if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeOnly.rawValue || UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeStarBlack.rawValue {
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
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female".localized{
                            
                            nameSex = "F"
                        }else if sexName == ButtonTitles.maleText.localized || sexName == "male".localized {
                            nameSex = "M"
                            
                        } else {
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
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female".localized{
                            
                            nameSex = "F"
                        }else if sexName == ButtonTitles.maleText.localized || sexName == "male".localized {
                            nameSex = "M"
                            
                        }  else {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                    }
                    
                }
                if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 7  {
                    if value.date != "" {
                        print(value)
                        datee = getOrderDateChange(date: value.date ?? "")
                        ob.dob = datee
                    }
                    if value.animalTag != "" {
                        ob.animalTag = value.animalTag
                    }
                    
                    if value.animalbarCodeTag != ""{
                        ob.sampleBarCode = value.animalbarCodeTag ///animal genotype
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
                    
                    if sexName == ButtonTitles.femaleText.localized || sexName == "female".localized{
                        
                        nameSex = "F"
                    } else if sexName == ButtonTitles.maleText.localized || sexName == "male".localized {
                        nameSex = "M"
                        
                    }  else {
                        nameSex = "F"
                    }
                    
                    ob.sex = nameSex
                }
                
                let productData =  fetchAllDataFarmIdStatusisSync(entityName: Entities.productAdonAnimlBeefTblEntity, asending: true, status: "true", isSync: "false",orderstatus:"false",orderId:orderIdBeef,userId:userId, animalID: Int(value.animalId))
                
                var product = ProductDetailSubmit()
                for item in productData{
                    var productSubmit = ProductSubmit()
                    if let productValue = item as? ProductAdonAnimlTbLBeef{
                        productSubmit.productID = productValue.productId
                        product.products.append(productSubmit)
                        
                        let addonId = fetchSubProductDataTrueSelectedISYNCAdonsBeef(isSync: "false", status: "true", orderstatus: "false",orderId:orderIdBeef,userId:userId, productId: Int(productValue.productId), animalID: Int(productValue.animalId))
                        
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
        
        let addDealerCodeCheck = UserDefaults.standard.value(forKey: keyValue.addDealerCodeCheck.rawValue) as? Bool
        let dealerCode = UserDefaults.standard.value(forKey: keyValue.dealerCode.rawValue) as? String
        
        if !(addDealerCodeCheck ?? false) {
          if dealerCode == "" || dealerCode == nil{
              apiSyncClass.dealerCode = ""
          } else {
              apiSyncClass.dealerCode = dealerCode
          }
        }
        else {
            apiSyncClass.dealerCode = ""
        }
        apiSyncClass.customerId = String(custId)
        apiSyncClass.billToCustomerId = String(billToCustomerId)
        apiSyncClass.species = marketNameType.Beef.rawValue
        apiSyncClass.isOFFline = false
        let email = UserDefaults.standard.value(forKey:keyValue.userName.rawValue) as! String
        apiSyncClass.emailOrder = true
        apiSyncClass.emailAddresses = [email]
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
        
        apiSyncClass.nominatorId = 1
        apiSyncClass.providerId = beefpvid
        
        let jsonEncoder = JSONEncoder()
        
        let jsonData = try! jsonEncoder.encode(apiSyncClass)
        let json = String(data: jsonData, encoding: String.Encoding.utf8)
        print(json!)
        
        _ = loginData.object(at: 0) as! LoginTbl
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        
        var urlString = String()
        if UserDefaults.standard.bool(forKey: keyValue.emailBeef.rawValue){
            urlString = Configuration.Dev(packet: ApiKeys.emailSave.rawValue).getUrl()
            print(urlString)
        }
        else {
            urlString = Configuration.Dev(packet: ApiKeys.orderSave.rawValue).getUrl()
        }
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headerDict
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        request.httpBody = jsonData
        
        UserDefaults.standard.setValue("", forKey: keyValue.dealerCode.rawValue)
        UserDefaults.standard.set(true, forKey: keyValue.addDealerCodeCheck.rawValue)
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            
            NotificationCenter.default.post(name: Notification.Name(LocalizedStrings.sessionExpiredStr), object: nil, userInfo: [LocalizedStrings.statusCodeText:"\(String(describing: response.response?.statusCode ?? 0))"])
            
            if statusCode == 401  {
                self.delegeteSyncApi!.failWithError(statusCode: statusCode!)
                return
            }
            else if statusCode == 500 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408{
                self.delegeteSyncApi!.failWithErrorInternal()
                self.delegeteSyncApi!.failWithError(statusCode: statusCode!)
                return
            }
            
            switch response.result {
                
            case .success(let responseObject):
                _ = response.data
                _ = JSONDecoder()
                _ = responseObject
                self.delegeteSyncApi!.didFinishApi(response:self.orderString)
            case .failure(let encodingError):
                
                if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                    // no internet connection
                    self.delegeteSyncApi!.failWithErrorInternal()
                    print(err)
                } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                    // other failures
                    print (encodingError)
                    print (responseString)
                    if let s = statusCode {
                        
                        self.delegeteSyncApi!.failWithError(statusCode: s)
                        
                    }
                    else
                    {
                        self.delegeteSyncApi!.failWithErrorInternal()
                    }
                }
            }
        }
    }
    
    func settingSave(){
        let pvID = UserDefaults.standard.value(forKey: keyValue.providerID.rawValue)
        let speciesId = UserDefaults.standard.value(forKey: keyValue.speciesId.rawValue)
        let nominatorSave = UserDefaults.standard.value(forKey: keyValue.nominatorSave.rawValue)
        let dateFormat = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as! String
        var dateString = String()
        if dateFormat == "MM" {
            
            dateString = DateFormatters.MMDDYYYYAllCapsFormat
        } else {
            
            dateString = DateFormatters.DDMMYYYYAllCapsFormat
        }
        let adonDictOnServer = NSMutableDictionary()
        adonDictOnServer.setValue(userId, forKey: keyValue.capsUserId.rawValue)
        adonDictOnServer.setValue(speciesId, forKey: keyValue.speciesId.rawValue)
        adonDictOnServer.setValue(pvID, forKey: keyValue.capsProviderId.rawValue)
        adonDictOnServer.setValue(nominatorSave, forKey: keyValue.nominator.rawValue)
        adonDictOnServer.setValue(keyValue.dbName.rawValue, forKey: keyValue.capsDBName.rawValue)
        adonDictOnServer.setValue(dateString, forKey: "SetDate")
        adonDictOnServer.setValue("online", forKey: keyValue.isOffline.rawValue)
        adonDictOnServer.setValue(1, forKey: "CountryId")
        
        
        do {
            let jsonData = try! JSONSerialization.data(withJSONObject: adonDictOnServer, options: JSONSerialization.WritingOptions.prettyPrinted)
            var jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
            jsonString = jsonString.trimmingCharacters(in: CharacterSet.whitespaces)
            print(jsonString)
            let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"BEARER" + " " + "ea4369e9-d4a9-4322-856b-5323e21ff351"]
            let urlString: String = Configuration.Dev(packet: ApiKeys.saveUserSetting.rawValue).getUrl()
            var request = URLRequest(url: URL(string: urlString)! )
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headerDict
            request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
            request.httpBody = try! JSONSerialization.data(withJSONObject: adonDictOnServer, options: [])
            
            AF.request(request as URLRequestConvertible).responseJSON { response in
                let statusCode =  response.response?.statusCode
                
                if statusCode == 401  {
                    self.delegeteSyncApi!.failWithError(statusCode: statusCode!)
                }
                else if statusCode == 500 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408{
                    self.delegeteSyncApi!.failWithErrorInternal()
                    self.delegeteSyncApi!.failWithError(statusCode: statusCode!)
                }
                
                switch response.result {
                    
                case .success(let responseObject):
                    // internet works.
                    print("responseObject = \( responseObject)")
                    if statusCode  == 200 {
                        self.delegeteSyncApi!.didFinishApi(response:self.orderString)
                        
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
                        }
                        else
                        {
                            self.delegeteSyncApi!.failWithErrorInternal()
                        }
                    }
                }
            }
        }
        
    }
    
    func saveProductData(dataModel:ProductResponse){
        self.orderString = dataModel.ServerOrderId ?? ""
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = DateFormatters.MMddyyyyFormat
        let dates = dateformatter.date(from: dataModel.OrderDate!)
        
        saveorderResponse(entity: Entities.productResponseTblEntity, actionRequired: dataModel.ActionRequired ?? "", orderDate: dates!, orderId: dataModel.OrderId, orderStatus: dataModel.OrderStatus ?? "", packageRecieved: dataModel.PackageRecieved ?? "", sampleCount: String(dataModel.SampleCount), serverOrderId: dataModel.ServerOrderId ?? "",userId:userId)
        let data = dataModel.ProductStatus
        for item in data{
            for item1 in item.Addons{
                print(item1)
                saveAdonServerRes(entity: Entities.adOnServerResponseTblEntity, adonId: item1.AddonId, adonName: item1.AddonName ?? "", offbarcde: item.BarCode ?? "", offfarmId: item.OnFarmId ?? "", offId: item.OfficialId ?? "", productId: item.ProductId, serverId: dataModel.ServerOrderId ?? "",userId:userId)
            }
            saveProductResponseFromServer(entity: Entities.productResonseServerTblEntity, productId: item.ProductId, productName: item.ProductName ?? "", offId: item.OfficialId ?? "", farmId: item.OnFarmId ?? "", barcOde: item.BarCode ?? "", serverId: dataModel.ServerOrderId ?? "", serverstatus: dataModel.OrderStatus ?? "", productStatus: item.ProductStatus ?? "", userId: userId,actreq:dataModel.ActionRequired ?? "", rgn: item.RGN ?? "",rgd: item.RGD ?? "", series: item.Series ?? "",earTag:item.EarTag ?? "")
        }
    }
    func addAnimalInGroup(groupId:String,animalIds: String, completionHandler: @escaping CompletionHandler){
        let _: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict = [LocalizedStrings.authorizationHeader: accessToken!,LocalizedStrings.contentType : LocalizedStrings.formURLEncoded]
        let urlString = Configuration.Dev(packet: ApiKeys.addAnimalGroup.rawValue).getUrl()
        let parameters : [String: Any] = [keyValue.groupId.rawValue: groupId,"animalIds":[animalIds]]
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "POST"
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
                
                switch response.result {
                case let .success(value):
                    print(value)
                    return completionHandler(true)
                    
                case let .failure(error):
                    print(error)
                }
                
            } else {
            }
        }
    }
}
