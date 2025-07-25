

import Foundation
import Alamofire
import CoreData

class GetListForCutomerWithTimeViewModel {
    var damAssociationName = String()
    var dependency:DashboardVC?
    var modalObject: GetListForCustomerModel?
    var associationName = String()
    var sireRegAssocationbreedAssociationId = String()
    var breedAssociationIdInherit = String()
    var priorityBreedName = String()
    var secondaRyBreedingName = String()
    var tertiaryBreedingName = String()
    var breedName = String()
    var sampleType1 = String()
    var breedAssoId = String()
    var sireYob = String()
    var damYob = String()
    var completion:()->()?
    let beefPvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
    
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    
    func localToUTC(date:NSDate) -> String {
        let formatter = DateFormatter()
      //  formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.dateFormat = DateFormatters.yyyyMMddTHHmmssFormat
        let myString = formatter.string(from: Date()) // string purpose I add here
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = DateFormatters.yyyyMMddTHHmmssFormat
        formatter.locale = Locale(identifier: "en_US_POSIX")
        let myStringafd = formatter.string(from: yourDate!)
        let dt = formatter.date(from: myStringafd)
        formatter.dateFormat = DateFormatters.yyyyMMddTHHmmssFormat
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        var dateString = formatter.string(from: dt!)
        if dateString.contains("AM") || dateString.contains("PM")  {
            let endIndex = dateString.index(dateString.endIndex, offsetBy: -3)
            dateString = dateString.substring(to: endIndex)
        }
        return dateString
    }
    
    var dateNew = String()
    
    
    func callListForCustomer() {
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        
        
        let dateFetch = fetchAllDataLastUpdatedTime(entityName: Entities.animalUpdatedTimeEntity,customerId:Int64(UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int ?? 0))
        if dateFetch.count != 0 {
            
            let abc = dateFetch.object(at: 0) as? AnimalUpdatedTime
            self.dateNew = abc?.hittingTime ?? ""
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            let myString = self.dateNew// string purpose I add here
            let formatter1 = DateFormatter()
            if myString.contains("AM") {
                formatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ssa"
            } else {
                formatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            }
            
            formatter1.locale = Locale(identifier: "en_US_POSIX")
//            formatter1.timeZone = TimeZone(abbreviation: "UTC")
            let yourDate = formatter1.date(from: myString)
            let myStringafd = formatter.string(from: yourDate!)
            self.dateNew = myStringafd
        }
        
        let custId =  UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url:Configuration.Dev(packet: ApiKeys.getListForCustomer.rawValue).getUrl() + "/" + String(custId) + "/" + String(dateNew)))
    }
    
    
    var listNameMutableArray = [String]()
    func callListForCustomerSave(dataModel: GetListForCustomerModel){
        
        let dateString = NSDate()
        let localDateTime = self.localToUTC(date: dateString)
        let localDeviceid = UserDefaults.standard.object(forKey: "DeviceId") as! String
        
        updatELastUpdatedData(entity: Entities.animalUpdatedTimeEntity,custmerId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),hittingTime:localDateTime)
        
        for itemOnly in dataModel.animalLists {
            
            /// Delete code enabled
            
            if itemOnly.status == "Deleted" {
                
                if UserDefaults.standard.value(forKey: "name") as? String  == marketNameType.Dairy.rawValue {
                    
                    let listExist1 = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(itemOnly.customerID ?? 0),listName: itemOnly.listName ?? "",productName:"")
                    
                    
                    if listExist1.count != 0 {
                        
                        let listExistObject = listExist1.object(at: 0) as? DataEntryList
                        
                        deleteDataWithListId(entityString: Entities.dataEntryListTblEntity, listId: Int64(listExistObject?.listId ?? 0), customerId: Int(listExistObject?.customerId ?? 0), userId: Int(listExistObject?.userId ?? 0))
                        
                        let animalData =  fetchDataEnteryAnimalTbl(entityName: Entities.animalAddTblEntity, customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listExistObject?.listId ?? 0))
                        
                        if animalData.count > 0 {
                            
                            for i in 0 ..< animalData.count {
                                let ad = animalData[i] as! AnimaladdTbl
                                deleteDataWithProduct(Int(ad.animalId))
                                deleteDataWithSubProduct(Int(ad.animalId))
                            }
                            
                            if UserDefaults.standard.value(forKey: keyValue.dataEntryListId.rawValue) as? Int == Int(listExistObject?.listId ?? 0) {
                                UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListId.rawValue)
                                UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
                            }
                            
                            
                            deleteDataWithListIdDatEntry(entityString: Entities.animalAddTblEntity, listId: Int(listExistObject?.listId ?? 0), customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userId: Int(listExistObject?.userId ?? 0))
                        }
                        
                        let animalData1 =  fetchDataEnteryAnimalTbl(entityName: Entities.dataEntryAnimalAddTbl, customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listExistObject?.listId ?? 0))
                        if animalData1.count > 0 {
                            
                            deleteDataWithListIdDatEntry(entityString: Entities.dataEntryAnimalAddTbl, listId: Int(listExistObject?.listId ?? 0), customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userId: Int(listExistObject?.userId ?? 0))
                            
                        }
                    }
                    
                } else {
                    
                    let listExist1 = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(itemOnly.customerID ?? 0),listName: itemOnly.listName ?? "",productName:"")
                    
                    
                    if listExist1.count != 0 {
                        
                        let listExistObject = listExist1.object(at: 0) as? DataEntryList
                        
                        
                        deleteDataWithListId(entityString: Entities.dataEntryListTblEntity, listId: Int64(listExistObject?.listId ?? 0), customerId: Int(itemOnly.customerID ?? 0),userId: Int(listExistObject?.userId ?? 0))
                        
                        let animalData =  fetchDataEnteryAnimalTbl(entityName: Entities.beefAnimalAddTblEntity, customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listExistObject?.listId ?? 0))
                        
                        if animalData.count > 0 {
                            
                            for i in 0 ..< animalData.count {
                                let ad = animalData[i] as! BeefAnimaladdTbl
                                deleteDataWithProductBeefDelete(Int(ad.animalId))
                                deleteDataWithSubProductAnimalId(Int(ad.animalId))
                            }
                            
                            if UserDefaults.standard.value(forKey: keyValue.dataEntryListId.rawValue) as? Int ?? 0 == Int64(listExistObject?.listId ?? 0) {
                                UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListId.rawValue)
                                UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
                            }
                            
                            
                            deleteDataWithListIdDatEntry(entityString: Entities.beefAnimalAddTblEntity, listId: Int(listExistObject?.listId ?? 0), customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userId:Int(listExistObject?.userId ?? 0))
                        }
                        
                        let animalData1 =  fetchDataEnteryAnimalTbl(entityName: Entities.dataEntryBeefAnimalAddTblEntity, customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listExistObject?.listId ?? 0))
                        if animalData1.count > 0 {
                            deleteDataWithListIdDatEntry(entityString: Entities.dataEntryBeefAnimalAddTblEntity, listId: Int(listExistObject?.listId ?? 0), customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userId:Int(listExistObject?.userId ?? 0))
                            
                        }
                    }
                }
            }
            
            
            let listExist = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(itemOnly.customerID ?? 0),listName: itemOnly.listName ?? "",productName:"")
            
            
            if listExist.count != 0 {
                
                listNameMutableArray.append(itemOnly.listName ?? "")
            }
            
            
            if listNameMutableArray.count != 0{
                if dataModel.animalLists[0].globalDeviceId != localDeviceid.lowercased(){
                    let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: "\(listNameMutableArray.count)" + NSLocalizedString(" list(s) for this customer have updated records. Please select action to proceed.", comment: ""), preferredStyle: .alert)
                    
                    let Keepserver = UIAlertAction(title: NSLocalizedString("Keep server", comment: ""), style: .default, handler: { action in
                        
                        for item in self.listNameMutableArray {
                            
                            let abc = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int ?? 0),listName: item,productName:"")
                            
                            if abc.count != 0 {
                                
                                let listIddd = abc.object(at: 0) as? DataEntryList
                                let ab = listIddd?.listId
                                
                                deleteDataWithListNamee(entityString:Entities.dataEntryListTblEntity ,listName: item,customerId:UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int ?? 0)
                                deleteDataWithListId1(entityString:Entities.dataEntryAnimalAddTbl ,listId: Int(ab ?? 0),customerId:UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int ?? 0)
                                deleteDataWithListId1(entityString:Entities.animalMasterTblEntity ,listId: Int(ab ?? 0),customerId:UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int ?? 0)
                                deleteDataWithListId1(entityString:Entities.dataEntryBeefAnimalAddTblEntity ,listId: Int(ab ?? 0),customerId:UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int ?? 0)
                                deleteDataWithListId1(entityString:Entities.beefAnimalMasterTblEntity ,listId: Int(ab ?? 0),customerId:UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int ?? 0)
                            }
                        }
                        
                        for item in dataModel.animalLists {
                            
                            if item.speciesID == SpeciesID.dairySpeciesId {
                                
                                
                                let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(item.customerID ?? 0),listName: item.listName ?? "" ,productName:marketNameType.Dairy.rawValue)
                                if fetchDatEntry.count == 0 {
                                    
                                    var listIdGenerate = UserDefaults.standard.integer(forKey: keyValue.listId.rawValue)
                                    if listIdGenerate == 0 {
                                        listIdGenerate = listIdGenerate + 1
                                        UserDefaults.standard.set(listIdGenerate, forKey: keyValue.listId.rawValue)
                                        
                                    } else {
                                        listIdGenerate = listIdGenerate + 1
                                        UserDefaults.standard.set(listIdGenerate, forKey: keyValue.listId.rawValue)
                                    }
                                    saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(item.customerID ?? 0),listDesc: item.animalListDescription ?? "",listId: Int64(listIdGenerate),listName: item.listName ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: item.providerID ?? 0, productType: "", productName: marketNameType.Dairy.rawValue)
                                    
                                } else {
                                    return
                                }
                                
                                
                                for itemSecond in item.animals{
                                    
                                    var animalID1 = UserDefaults.standard.integer(forKey: keyValue.animalId.rawValue)
                                    if animalID1 == 0 {
                                        animalID1 = animalID1 + 1
                                        UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                                    }
                                    else {
                                        animalID1 = animalID1 + 1
                                        UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                                    }
                                    
                                    
                                    //Dairy
                                    if item.speciesID == SpeciesID.dairySpeciesId {
                                        
                                        
                                        var timeStamp = String()
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                                        let date =  dateFormatter.date(from: itemSecond.dob ?? "")// create date from string
                                        
                                        if date == nil {
                                            
                                        } else {
                                            
                                            dateFormatter.dateFormat = DateFormatters.ddMMyyyyFormat
                                            timeStamp = dateFormatter.string(from: date!)
                                            
                                        }
                                        
                                        
                                        let inheritBreed = fetchAllDataProductBreedIdDairy(entityName: Entities.getBreedsTblEntity,breedId:itemSecond.breedID ?? "",pvid:item.providerID ?? 0)
                                        if inheritBreed.count != 0 {
                                            let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                                            self.breedName = medbreedRegArr1?.alpha2 ?? medbreedRegArr1?.threeCharCode ?? medbreedRegArr1?.breedName as! String
                                            
                                        }
                                        
                                        let sampleType = fetchSampleDetailDataWithProvideId(entityName: Entities.getSampleTblEntity, sampleId: itemSecond.sampleTypeId ?? 0, providerId: item.providerID ?? 0)
                                        if sampleType.count != 0 {
                                            let medbreedRegArr1 = sampleType.object(at: 0) as? GetSampleTbl
                                            self.sampleType1 = medbreedRegArr1?.sampleName ?? ""
                                            
                                        }
                                        if item.providerID == 4  {
                                            
                                            
                                            if itemSecond.breedAssociationID == "a40549ab9-beae-4c0c-8e48-5147f18333d9" {
                                                
                                                self.breedAssoId = LocalizedStrings.girolandoAssociationStr
                                            }
                                            
                                            
                                            saveAnimaldataGirlando(entity: Entities.animalMasterTblEntity, earTag: itemSecond.earTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: timeStamp , damId: itemSecond.damRegNumber ?? "", sireId: itemSecond.sireRegNumber ?? "" , gender: itemSecond.sex ?? "", update: "false", breedRegNumber: itemSecond.breedRegNumber ?? "", tissuName: self.sampleType1, breedName: self.breedName, et: itemSecond.mbc ?? "", farmId: "", orderId: UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue), orderSataus: "false", breedId: itemSecond.breedID ?? "", isSync: "false", providerId: item.providerID ?? 0, tissuId: itemSecond.sampleTypeId ?? 0, sireIDAU: "", animalName: itemSecond.animalName ?? "", userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as! Int, udid: "", animalId: animalID1, selectedBornTypeId: itemSecond.bornTypeID ?? 0, breedAssocation: self.breedAssoId ,custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "",girlandoID:"")
                                            
                                            saveAnimaldataGirlando(entity: Entities.dataEntryAnimalAddTbl, earTag: itemSecond.earTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: timeStamp , damId: itemSecond.damRegNumber ?? "", sireId: itemSecond.sireRegNumber ?? "" , gender: itemSecond.sex ?? "", update: "false", breedRegNumber: itemSecond.breedRegNumber ?? "", tissuName: self.sampleType1, breedName: self.breedName, et: itemSecond.mbc ?? "", farmId: "", orderId: UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue), orderSataus: "false", breedId: itemSecond.breedID ?? "", isSync: "false", providerId: item.providerID ?? 0, tissuId: itemSecond.sampleTypeId ?? 0, sireIDAU: "", animalName: itemSecond.animalName ?? "", userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as! Int, udid: "", animalId: animalID1, selectedBornTypeId: itemSecond.bornTypeID ?? 0, breedAssocation: self.breedAssoId ,custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "",girlandoID: "")
                                            
                                        } else {
                                            
                                            saveAnimaldata(entity: Entities.dataEntryAnimalAddTbl, animalTag: itemSecond.officialTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: timeStamp , damId: itemSecond.damID ?? "", sireId: itemSecond.sireID  ?? "" , gender: itemSecond.sex ?? "",update: "false", permanentId:"", tissuName: self.sampleType1 , breedName:self.breedName , et: itemSecond.mbc ?? "", farmId:itemSecond.onFarmID ?? "", orderId: UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue),orderSataus:"false",breedId:itemSecond.breedID ?? "" ,isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU:itemSecond.sireID ?? "", nationHerdAU: "", userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as! Int,udid:"", animalId: animalID1, selectedBornTypeId: itemSecond.bornTypeID,custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), specisId: SpeciesID.dairySpeciesId, earTag: itemSecond.earTag ?? "",isSyncServer:false, adhDataServer: false, listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, editFlagSave: false, serverAnimalId: itemSecond.animalID ?? "")
                                            
                                            saveAnimaldata(entity: Entities.animalMasterTblEntity, animalTag: itemSecond.officialTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: timeStamp , damId: itemSecond.damID ?? "", sireId: itemSecond.sireID  ?? "" , gender: itemSecond.sex ?? "",update: "false", permanentId:"", tissuName: self.sampleType1 , breedName:self.breedName , et: itemSecond.mbc ?? "", farmId:itemSecond.onFarmID ?? "", orderId: UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue),orderSataus:"false",breedId:itemSecond.breedID ?? "" ,isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU:itemSecond.sireID ?? "", nationHerdAU: "", userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as! Int,udid:"", animalId: animalID1, selectedBornTypeId: itemSecond.bornTypeID,custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), specisId: SpeciesID.dairySpeciesId, earTag: itemSecond.earTag ?? "",isSyncServer:false, adhDataServer: false, listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, editFlagSave: false, serverAnimalId: itemSecond.animalID ?? "")
                                        }}
                                }
                                
                            }
                            if item.speciesID == SpeciesID.beefSpeciesId{
                                
                                //Beef Data Saving
                                var listIdGenerate = UserDefaults.standard.integer(forKey: keyValue.listId.rawValue)
                                if listIdGenerate == 0 {
                                    listIdGenerate = listIdGenerate + 1
                                    UserDefaults.standard.set(listIdGenerate, forKey: keyValue.listId.rawValue)
                                    
                                } else {
                                    listIdGenerate = listIdGenerate + 1
                                    UserDefaults.standard.set(listIdGenerate, forKey: keyValue.listId.rawValue)
                                }
                                
                                
                                
                                
                                if item.providerID == 5 {
                                    if item.productID == 19 {
                                        
                                        let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(item.customerID ?? 0),listName: item.listName ?? "" ,productName:marketNameType.Beef.rawValue)
                                        if fetchDatEntry.count == 0 {
                                            saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(item.customerID ?? 0),listDesc: item.animalListDescription ?? "",listId: Int64(listIdGenerate),listName: item.listName ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: item.providerID ?? 0, productType: keyValue.globalHD50K.rawValue, productName: marketNameType.Beef.rawValue)
                                            
                                        } else {
                                            return
                                        }
                                    } else {
                                        let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(item.customerID ?? 0),listName: item.listName ?? "" ,productName:marketNameType.Beef.rawValue)
                                        if fetchDatEntry.count == 0 {
                                            saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(item.customerID ?? 0),listDesc: item.animalListDescription ?? "",listId: Int64(listIdGenerate),listName: item.listName ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: item.providerID ?? 0, productType: keyValue.capsInherit.rawValue, productName: marketNameType.Beef.rawValue)
                                            
                                        } else {
                                            return
                                        }
                                    }
                                }
                                if item.providerID == 7 {
                                    
                                    let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(item.customerID ?? 0),listName: item.listName ?? "" ,productName:marketNameType.Beef.rawValue)
                                    
                                    if fetchDatEntry.count == 0 {
                                        
                                        saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(item.customerID ?? 0),listDesc: item.animalListDescription ?? "",listId: Int64(listIdGenerate),listName: item.listName ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: item.providerID ?? 0, productType: "", productName: marketNameType.Beef.rawValue)
                                        
                                    } else {
                                        return
                                    }
                                }
                                
                                if item.providerID == 6 {
                                    if item.productID == 23 {
                                        let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(item.customerID ?? 0),listName: item.listName ?? "" ,productName:marketNameType.Beef.rawValue)
                                        
                                        if fetchDatEntry.count == 0 {
                                            
                                            saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(item.customerID ?? 0),listDesc: item.animalListDescription ?? "",listId: Int64(listIdGenerate),listName: item.listName ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: item.providerID ?? 0, productType: keyValue.genoTypeOnly.rawValue, productName: marketNameType.Beef.rawValue)
                                            
                                        }else {
                                            return
                                        }
                                        
                                    }
                                    else if  item.productID == 999
                                    {
                                        
                                        let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(item.customerID ?? 0),listName: item.listName ?? "" ,productName:marketNameType.Beef.rawValue)
                                        
                                        if fetchDatEntry.count == 0 {
                                            
                                            saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(item.customerID ?? 0),listDesc: item.animalListDescription ?? "",listId: Int64(listIdGenerate),listName: item.listName ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: item.providerID ?? 0, productType: keyValue.genoTypeStarBlack.rawValue, productName: marketNameType.Beef.rawValue)
                                            
                                        }else {
                                            return
                                        }
                                        
                                        
                                    }
                                    else if item.productID == 24
                                    {
                                        let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(item.customerID ?? 0),listName: item.listName ?? "" ,productName:marketNameType.Beef.rawValue)
                                        
                                        if fetchDatEntry.count == 0 {
                                            
                                            saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(item.customerID ?? 0),listDesc: item.animalListDescription ?? "",listId: Int64(listIdGenerate),listName: item.listName ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: item.providerID ?? 0, productType: keyValue.genStarBlack.rawValue, productName: marketNameType.Beef.rawValue)
                                            
                                        }else {
                                            return
                                        }
                                        
                                    }
                                    else {
                                        
                                        
                                        
                                        let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(item.customerID ?? 0),listName: item.listName ?? "" ,productName:marketNameType.Beef.rawValue)
                                        
                                        if fetchDatEntry.count == 0 {
                                            
                                            saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(item.customerID ?? 0),listDesc: item.animalListDescription ?? "",listId: Int64(listIdGenerate),listName: item.listName ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: item.providerID ?? 0, productType: keyValue.nonGenoType.rawValue, productName: marketNameType.Beef.rawValue)
                                            
                                            
                                            
                                        }else {
                                            return
                                        }
                                        
                                        
                                    }
                                    
                                }
                                
                                
                                for itemSecond in item.animals{
                                    
                                    
                                    
                                    var animalID1 = UserDefaults.standard.integer(forKey: keyValue.animalId.rawValue)
                                    if animalID1 == 0 {
                                        animalID1 = animalID1 + 1
                                        UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                                    }
                                    else {
                                        animalID1 = animalID1 + 1
                                        UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                                    }
                                    if item.speciesID == SpeciesID.beefSpeciesId {
                                        
                                        let inheritBreed = fetchAllDataProductBreedIdDairy(entityName: Entities.getBreedsTblEntity,breedId:itemSecond.breedID ?? "",pvid:item.providerID ?? 0)
                                        if inheritBreed.count != 0 {
                                            let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                                            
                                            self.breedName = medbreedRegArr1?.threeCharCode ?? ""
                                            
                                        }
                                        
                                        let sampleType = fetchSampleDetailDataWithProvideId(entityName: Entities.getSampleTblEntity, sampleId: itemSecond.sampleTypeId ?? 0, providerId: item.providerID ?? 0)
                                        if sampleType.count != 0 {
                                            let medbreedRegArr1 = sampleType.object(at: 0) as? GetSampleTbl
                                            self.sampleType1 = medbreedRegArr1?.sampleName ?? ""
                                            
                                        }
                                        
                                        var timeStamp = String()
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                                        let date =  dateFormatter.date(from: itemSecond.dob ?? "")// create date from string
                                        
                                        if date == nil {
                                            
                                        } else {
                                            
                                            dateFormatter.dateFormat = DateFormatters.ddMMyyyyFormat
                                            timeStamp = dateFormatter.string(from: date!)
                                            
                                        }
                                        
                                        
                                        if item.providerID == 5 {
                                            
                                            if item.productID == 19 {
                                                
                                                let medbreedRegArr = fetchAllDataProductBeefBreedSocietyIDD(entityName: Entities.getBreedSocietiesTblEntity, productId: 19, association: itemSecond.breedAssociationID ?? "")
                                                if medbreedRegArr.count != 0 {
                                                    
                                                    let medbreedRegArr1 = medbreedRegArr.object(at: 0) as? GetBreedSocieties
                                                    self.breedAssociationIdInherit =   medbreedRegArr1?.association ?? ""
                                                } else {
                                                    self.breedAssociationIdInherit = ""
                                                    
                                                }
                                                
                                                let sireRegAssocation = fetchAllDataProductBeefBreedSocietyIDD(entityName: Entities.getBreedSocietiesTblEntity, productId: 19, association: itemSecond.sireAssociationID ?? "")
                                                if sireRegAssocation.count != 0 {
                                                    
                                                    let medbreedRegArr1 = sireRegAssocation.object(at: 0) as? GetBreedSocieties
                                                    self.sireRegAssocationbreedAssociationId =   medbreedRegArr1?.association ?? ""
                                                }else {
                                                    self.sireRegAssocationbreedAssociationId = ""
                                                }
                                                
                                                let damAssociation = fetchAllDataProductBeefBreedSocietyIDD(entityName: Entities.getBreedSocietiesTblEntity, productId: 19, association: itemSecond.damAssociationID ?? "")
                                                if damAssociation.count != 0 {
                                                    
                                                    let medbreedRegArr1 = damAssociation.object(at: 0) as? GetBreedSocieties
                                                    self.damAssociationName =   medbreedRegArr1?.association ?? ""
                                                } else {
                                                    
                                                    self.damAssociationName =  ""
                                                }
                                                
                                                saveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: itemSecond.earTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: timeStamp , damId: itemSecond.damRegNumber ?? "", sireId: itemSecond.sireRegNumber ?? "" , gender: itemSecond.sex ?? "" ,update: "false", permanentId:itemSecond.breedRegNumber ?? "", tissuName: self.sampleType1, breedName: self.breedName, et: itemSecond.animalName ?? "", farmId: self.breedAssociationIdInherit, orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: self.sireRegAssocationbreedAssociationId, nationHerdAU:  self.damAssociationName , userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1,productId:item.productID ?? 0,custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "", tertiaryGeno: itemSecond.teriarityProgramID ?? "")
                                                
                                                saveAnimaldataBeefInProductId(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: itemSecond.earTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: timeStamp , damId: itemSecond.damRegNumber ?? "", sireId: itemSecond.sireRegNumber ?? "" , gender: itemSecond.sex ?? "" ,update: "false", permanentId:itemSecond.breedRegNumber ?? "", tissuName: self.sampleType1, breedName: self.breedName, et: itemSecond.animalName ?? "", farmId: self.breedAssociationIdInherit, orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: self.sireRegAssocationbreedAssociationId, nationHerdAU:  self.damAssociationName , userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1,productId:item.productID ?? 0,custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "", tertiaryGeno: itemSecond.teriarityProgramID ?? "")
                                                
                                            } else {
                                                
                                                
                                                let medbreedRegArr = fetchAllDataProductBeefBreedSocietyIDD(entityName: Entities.getBreedSocietiesTblEntity, productId: 20, association: itemSecond.breedAssociationID ?? "")
                                                if medbreedRegArr.count != 0 {
                                                    
                                                    let medbreedRegArr1 = medbreedRegArr.object(at: 0) as? GetBreedSocieties
                                                    self.breedAssociationIdInherit =   medbreedRegArr1?.association ?? ""
                                                }else {
                                                    self.breedAssociationIdInherit = ""
                                                }
                                                
                                                let sireRegAssocation = fetchAllDataProductBeefBreedSocietyIDD(entityName: Entities.getBreedSocietiesTblEntity, productId: 20, association: itemSecond.sireAssociationID ?? "")
                                                if sireRegAssocation.count != 0 {
                                                    
                                                    let medbreedRegArr1 = sireRegAssocation.object(at: 0) as? GetBreedSocieties
                                                    self.sireRegAssocationbreedAssociationId =   medbreedRegArr1?.association ?? ""
                                                } else {
                                                    self.sireRegAssocationbreedAssociationId =  ""
                                                }
                                                
                                                
                                                
                                                if itemSecond.sireYOB == 0 {
                                                    self.sireYob = ""
                                                } else {
                                                    self.sireYob = String(itemSecond.sireYOB ?? 0)
                                                }
                                                
                                                if itemSecond.damYOB == 0 {
                                                    self.damYob = ""
                                                } else {
                                                    self.damYob = String(itemSecond.damYOB ?? 0)
                                                }
                                                
                                                inheritSaveAnimaldataBeefInProductId(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: itemSecond.earTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: timeStamp , damId: itemSecond.damID ?? "", sireId: itemSecond.sireRegNumber ?? "" , gender: itemSecond.sex ?? "",update: "false", permanentId:itemSecond.breedRegNumber ?? "", tissuName: self.sampleType1, breedName: self.breedName, et: self.breedAssociationIdInherit , farmId:"", orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: itemSecond.breedRegistrationNumber ?? "", nationHerdAU: itemSecond.nationalHerdID ?? "", userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1,productId: Int(item.productID ?? 0), sirYOB: self.sireYob , damYOB: self.damYob , sireRegAssocation: self.sireRegAssocationbreedAssociationId ,custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "", tertiaryGeno: itemSecond.teriarityProgramID ?? "")
                                                
                                                
                                                inheritSaveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: itemSecond.earTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: timeStamp , damId: itemSecond.damID ?? "", sireId: itemSecond.sireRegNumber ?? "" , gender: itemSecond.sex ?? "",update: "false", permanentId:itemSecond.breedRegNumber ?? "", tissuName: self.sampleType1, breedName: self.breedName, et: self.breedAssociationIdInherit , farmId:"", orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: itemSecond.breedRegistrationNumber ?? "", nationHerdAU: itemSecond.nationalHerdID ?? "", userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1,productId: Int(item.productID ?? 0), sirYOB: self.sireYob , damYOB: String(self.damYob), sireRegAssocation: self.sireRegAssocationbreedAssociationId ,custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "", tertiaryGeno: itemSecond.teriarityProgramID ?? "")
                                                
                                            }
                                        }
                                        
                                        if item.providerID == 7 {
                                            
                                            let inheritBreed = fetchAllDataProductBreedIdDairy(entityName: Entities.getBreedsTblEntity,breedId:itemSecond.breedID ?? "",pvid:item.providerID ?? 0)
                                            if inheritBreed.count != 0 {
                                                let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                                                
                                                
                                                self.breedName = medbreedRegArr1?.threeCharCode ?? medbreedRegArr1?.breedName ?? ""
                                                
                                            }
                                            
                                            
                                            let sireRegAssocation = fetchAllDataProductBeefBreedSocietyIDD(entityName: Entities.getBreedSocietiesTblEntity, productId: 25, association: itemSecond.breedAssociationID ?? "")
                                            if sireRegAssocation.count != 0 {
                                                
                                                let medbreedRegArr1 = sireRegAssocation.object(at: 0) as? GetBreedSocieties
                                                self.associationName =  medbreedRegArr1?.association ?? ""
                                            } else {
                                                self.associationName =  ""
                                            }
                                            
                                            saveAnimaldatawithAge(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: itemSecond.animalTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: timeStamp , damId: itemSecond.damRegNumber ?? "", sireId: itemSecond.sireRegNumber ?? "" , gender: itemSecond.sex ?? "",update: "true", permanentId:itemSecond.breedRegNumber ?? "", tissuName: self.sampleType1, breedName: self.breedName, et: itemSecond.animalName ?? "", farmId:"", orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: self.associationName , nationHerdAU: "", userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1, age:0,productId :Int(item.productID ?? 0), samconflict: "", ageConf: "", bothConf: "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "")
                                            
                                            saveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: itemSecond.animalTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: timeStamp , damId: itemSecond.damRegNumber ?? "", sireId: itemSecond.sireRegNumber ?? "" , gender: itemSecond.sex ?? "",update: "true", permanentId:itemSecond.breedRegNumber ?? "", tissuName: self.sampleType1, breedName: self.breedName, et: itemSecond.animalName ?? "", farmId:"", orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: self.associationName , nationHerdAU: "", userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1,productId: Int(item.productID ?? 0),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "", tertiaryGeno: itemSecond.teriarityProgramID ?? "")
                                        }
                                        
                                        if item.providerID == 6 {
                                            if item.productID == 23 {
                                                
                                                let priorityBreeding = fetchAllDataPriorityDataId(entityName: Entities.getPriorityBreedingTblEntity, priorityBreedId: itemSecond.primaryPriorityProgramID ?? "")
                                                if priorityBreeding.count != 0 {
                                                    let medbreedRegArr1 = priorityBreeding.object(at: 0) as? GetPriorityBreeding
                                                    self.priorityBreedName =   medbreedRegArr1!.priorityBreedName ?? ""
                                                }
                                                
                                                let secondaRypriorityBreeding = fetchAllDataPriorityDataId(entityName: Entities.getSecondaryBreedingProgramsTblEntity, priorityBreedId: itemSecond.secondaryPriorityProgramID ?? "")
                                                if secondaRypriorityBreeding.count != 0 {
                                                    let secondaRy = secondaRypriorityBreeding.object(at: 0) as? GetSecondaryBreedingPrograms
                                                    self.secondaRyBreedingName =   secondaRy!.priorityBreedName ?? ""
                                                }
                                                
                                                let tertiaryPriorityBreeding = fetchAllDataPriorityDataId(entityName: Entities.getTertiaryBreedingProgramsTblEntity, priorityBreedId: itemSecond.teriarityProgramID ?? "")
                                                if tertiaryPriorityBreeding.count != 0 {
                                                    let tertiary = tertiaryPriorityBreeding.object(at: 0) as? GetTertiaryBreedingPrograms
                                                    self.tertiaryBreedingName =   tertiary!.priorityBreedName ?? ""
                                                }
                                                
                                                saveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: itemSecond.sampleBarCode ?? "", barCodetag: itemSecond.animalName ?? "", date: timeStamp , damId: itemSecond.rgd ?? "", sireId: itemSecond.series ?? "" , gender: itemSecond.sex ?? "",update: "false", permanentId:itemSecond.rgn ?? "", tissuName: self.sampleType1, breedName: "", et: "", farmId:"", orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: self.priorityBreedName , nationHerdAU: self.secondaRyBreedingName , userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1, productId: Int(item.productID ?? 0),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "", tertiaryGeno: itemSecond.teriarityProgramID ?? "")
                                                
                                                saveAnimaldataBeefInProductId(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: itemSecond.sampleBarCode ?? "", barCodetag: itemSecond.animalName ?? "", date: timeStamp , damId: itemSecond.rgd ?? "", sireId: itemSecond.series ?? "", gender: itemSecond.sex ?? "",update: "false", permanentId:itemSecond.rgn ?? "", tissuName: self.sampleType1, breedName: "", et: "", farmId:"", orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: self.priorityBreedName , nationHerdAU: self.secondaRyBreedingName , userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1, productId: Int(item.productID ?? 0),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "", tertiaryGeno: itemSecond.teriarityProgramID ?? "")
                                                
                                            } else {
                                                
                                                
                                                saveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: itemSecond.sampleBarCode ?? "", barCodetag: itemSecond.animalName ?? "", date: timeStamp , damId: itemSecond.rgd ?? "", sireId: itemSecond.series ?? "" , gender: itemSecond.sex ?? "",update: "false", permanentId:itemSecond.rgn ?? "", tissuName: self.sampleType1, breedName: "", et: "", farmId:"", orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: self.priorityBreedName , nationHerdAU: self.secondaRyBreedingName , userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1, productId: Int(item.productID ?? 0),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "", tertiaryGeno: self.tertiaryBreedingName )
                                                
                                                saveAnimaldataBeefInProductId(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: itemSecond.sampleBarCode ?? "", barCodetag: itemSecond.animalName ?? "", date: timeStamp , damId: itemSecond.rgd ?? "", sireId: itemSecond.series ?? "", gender: itemSecond.sex ?? "",update: "false", permanentId:itemSecond.rgn ?? "", tissuName: self.sampleType1, breedName: "", et: "", farmId:"", orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: self.priorityBreedName , nationHerdAU: self.secondaRyBreedingName , userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1, productId: Int(item.productID ?? 0),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "", tertiaryGeno: self.tertiaryBreedingName )
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    })
                    
                    let Keeplocal = UIAlertAction(title: NSLocalizedString("Keep local", comment: ""), style: .default, handler: { action in
                        
                        //********
                        
                        for item in dataModel.animalLists {
                            
                            if item.speciesID == SpeciesID.dairySpeciesId {
                                var listIdGenerate = UserDefaults.standard.integer(forKey: keyValue.listId.rawValue)
                                if listIdGenerate == 0 {
                                    listIdGenerate = listIdGenerate + 1
                                    UserDefaults.standard.set(listIdGenerate, forKey: keyValue.listId.rawValue)
                                    
                                } else {
                                    listIdGenerate = listIdGenerate + 1
                                    UserDefaults.standard.set(listIdGenerate, forKey: keyValue.listId.rawValue)
                                }
                                
                                let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(item.customerID ?? 0),listName: item.listName ?? "" ,productName:marketNameType.Dairy.rawValue)
                                if fetchDatEntry.count == 0 {
                                    saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(item.customerID ?? 0),listDesc: item.animalListDescription ?? "",listId: Int64(listIdGenerate),listName: item.listName ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: item.providerID ?? 0, productType: "", productName: marketNameType.Dairy.rawValue)
                                    
                                } else {
                                    return
                                }
                                
                                
                                for itemSecond in item.animals{
                                    
                                    var animalID1 = UserDefaults.standard.integer(forKey: keyValue.animalId.rawValue)
                                    if animalID1 == 0 {
                                        animalID1 = animalID1 + 1
                                        UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                                    }
                                    else {
                                        animalID1 = animalID1 + 1
                                        UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                                    }
                                    
                                    
                                    //Dairy
                                    if item.speciesID == SpeciesID.dairySpeciesId {
                                        
                                        let inheritBreed = fetchAllDataProductBreedIdDairy(entityName: Entities.getBreedsTblEntity,breedId:itemSecond.breedID ?? "",pvid:item.providerID ?? 0)
                                        if inheritBreed.count != 0 {
                                            let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                                            self.breedName = medbreedRegArr1?.alpha2 ?? medbreedRegArr1?.threeCharCode ?? medbreedRegArr1?.breedName as! String
                                            
                                        }
                                        
                                        let sampleType = fetchSampleDetailDataWithProvideId(entityName: Entities.getSampleTblEntity, sampleId: itemSecond.sampleTypeId ?? 0, providerId: item.providerID ?? 0)
                                        if sampleType.count != 0 {
                                            let medbreedRegArr1 = sampleType.object(at: 0) as? GetSampleTbl
                                            self.sampleType1 = medbreedRegArr1?.sampleName ?? ""
                                            
                                        }
                                        var timeStamp = String()
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                                        let date =  dateFormatter.date(from: itemSecond.dob ?? "")// create date from string
                                        
                                        if date == nil {
                                            
                                        } else {
                                            
                                            dateFormatter.dateFormat = DateFormatters.ddMMyyyyFormat
                                            timeStamp = dateFormatter.string(from: date!)
                                            
                                        }
                                        
                                        if item.providerID == 4 {
                                            
                                            
                                            if itemSecond.breedAssociationID == "a40549ab9-beae-4c0c-8e48-5147f18333d9" {
                                                
                                                self.breedAssoId = LocalizedStrings.girolandoAssociationStr
                                            }
                                            
                                            
                                            saveAnimaldataGirlando(entity: Entities.animalMasterTblEntity, earTag: itemSecond.earTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: timeStamp , damId: itemSecond.damRegNumber ?? "", sireId: itemSecond.sireRegNumber ?? "" , gender: itemSecond.sex ?? "", update: "false", breedRegNumber: itemSecond.breedRegNumber ?? "", tissuName: self.sampleType1, breedName: self.breedName, et: itemSecond.mbc ?? "", farmId: "", orderId: UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue), orderSataus: "false", breedId: itemSecond.breedID ?? "", isSync: "false", providerId: item.providerID ?? 0, tissuId: itemSecond.sampleTypeId ?? 0, sireIDAU: "", animalName: itemSecond.animalName ?? "", userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as! Int, udid: "", animalId: animalID1, selectedBornTypeId: itemSecond.bornTypeID ?? 0, breedAssocation: self.breedAssoId ,custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "",girlandoID: "")
                                            
                                            saveAnimaldataGirlando(entity: Entities.dataEntryAnimalAddTbl, earTag: itemSecond.earTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: timeStamp , damId: itemSecond.damRegNumber ?? "", sireId: itemSecond.sireRegNumber ?? "" , gender: itemSecond.sex ?? "", update: "false", breedRegNumber: itemSecond.breedRegNumber ?? "", tissuName: self.sampleType1, breedName: self.breedName, et: itemSecond.mbc ?? "", farmId: "", orderId: UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue), orderSataus: "false", breedId: itemSecond.breedID ?? "", isSync: "false", providerId: item.providerID ?? 0, tissuId: itemSecond.sampleTypeId ?? 0, sireIDAU: "", animalName: itemSecond.animalName ?? "", userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as! Int, udid: "", animalId: animalID1, selectedBornTypeId: itemSecond.bornTypeID ?? 0, breedAssocation: self.breedAssoId ,custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "",girlandoID: "")
                                            
                                        } else {
                                            
                                            saveAnimaldata(entity: Entities.dataEntryAnimalAddTbl, animalTag: itemSecond.officialTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: timeStamp , damId: itemSecond.damID ?? "", sireId: itemSecond.sireID  ?? "" , gender: itemSecond.sex ?? "",update: "false", permanentId:"", tissuName: self.sampleType1 , breedName:self.breedName , et: itemSecond.mbc ?? "", farmId:itemSecond.onFarmID ?? "", orderId: UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue),orderSataus:"false",breedId:itemSecond.breedID ?? "" ,isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU:itemSecond.sireID ?? "", nationHerdAU: "", userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as! Int,udid:"", animalId: animalID1, selectedBornTypeId: itemSecond.bornTypeID,custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), specisId: SpeciesID.dairySpeciesId, earTag: itemSecond.earTag ?? "",isSyncServer:false, adhDataServer: false, listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, editFlagSave: false, serverAnimalId: itemSecond.animalID ?? "")
                                            
                                            saveAnimaldata(entity: Entities.animalMasterTblEntity, animalTag: itemSecond.officialTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: timeStamp , damId: itemSecond.damID ?? "", sireId: itemSecond.sireID  ?? "" , gender: itemSecond.sex ?? "",update: "false", permanentId:"", tissuName: self.sampleType1 , breedName:self.breedName , et: itemSecond.mbc ?? "", farmId:itemSecond.onFarmID ?? "", orderId: UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue),orderSataus:"false",breedId:itemSecond.breedID ?? "" ,isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU:itemSecond.sireID ?? "", nationHerdAU: "", userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as! Int,udid:"", animalId: animalID1, selectedBornTypeId: itemSecond.bornTypeID,custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), specisId: SpeciesID.dairySpeciesId, earTag: itemSecond.earTag ?? "",isSyncServer:false, adhDataServer: false, listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, editFlagSave: false, serverAnimalId: itemSecond.animalID ?? "")
                                        }
                                    }
                                }
                                
                            }
                            if item.speciesID == SpeciesID.beefSpeciesId{
                                
                                //Beef Data Saving
                                var listIdGenerate = UserDefaults.standard.integer(forKey: keyValue.listId.rawValue)
                                if listIdGenerate == 0 {
                                    listIdGenerate = listIdGenerate + 1
                                    UserDefaults.standard.set(listIdGenerate, forKey: keyValue.listId.rawValue)
                                    
                                } else {
                                    listIdGenerate = listIdGenerate + 1
                                    UserDefaults.standard.set(listIdGenerate, forKey: keyValue.listId.rawValue)
                                }
                                
                                
                                if item.providerID == 5 {
                                    if item.productID == 19 {
                                        
                                        let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(item.customerID ?? 0),listName: item.listName ?? "" ,productName:marketNameType.Beef.rawValue)
                                        if fetchDatEntry.count == 0 {
                                            saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(item.customerID ?? 0),listDesc: item.animalListDescription ?? "",listId: Int64(listIdGenerate),listName: item.listName ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: item.providerID ?? 0, productType: keyValue.globalHD50K.rawValue, productName: marketNameType.Beef.rawValue)
                                            
                                        } else {
                                            return
                                        }
                                    } else {
                                        let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(item.customerID ?? 0),listName: item.listName ?? "" ,productName:marketNameType.Beef.rawValue)
                                        if fetchDatEntry.count == 0 {
                                            saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(item.customerID ?? 0),listDesc: item.animalListDescription ?? "",listId: Int64(listIdGenerate),listName: item.listName ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: item.providerID ?? 0, productType: keyValue.capsInherit.rawValue, productName: marketNameType.Beef.rawValue)
                                            
                                        } else {
                                            return
                                        }
                                    }
                                }
                                if item.providerID == 7 {
                                    
                                    let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(item.customerID ?? 0),listName: item.listName ?? "" ,productName:marketNameType.Beef.rawValue)
                                    
                                    if fetchDatEntry.count == 0 {
                                        
                                        saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(item.customerID ?? 0),listDesc: item.animalListDescription ?? "",listId: Int64(listIdGenerate),listName: item.listName ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: item.providerID ?? 0, productType: "", productName: marketNameType.Beef.rawValue)
                                        
                                    } else {
                                        return
                                    }
                                }
                                
                                if item.providerID == 6 {
                                    if item.productID == 23 {
                                        let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(item.customerID ?? 0),listName: item.listName ?? "" ,productName:marketNameType.Beef.rawValue)
                                        
                                        if fetchDatEntry.count == 0 {
                                            
                                            saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(item.customerID ?? 0),listDesc: item.animalListDescription ?? "",listId: Int64(listIdGenerate),listName: item.listName ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: item.providerID ?? 0, productType: keyValue.genoTypeOnly.rawValue, productName: marketNameType.Beef.rawValue)
                                            
                                        }else {
                                            return
                                        }
                                        
                                    }
                                    else if  item.productID == 999
                                    {
                                        
                                        let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(item.customerID ?? 0),listName: item.listName ?? "" ,productName:marketNameType.Beef.rawValue)
                                        
                                        if fetchDatEntry.count == 0 {
                                            
                                            saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(item.customerID ?? 0),listDesc: item.animalListDescription ?? "",listId: Int64(listIdGenerate),listName: item.listName ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: item.providerID ?? 0, productType: keyValue.genoTypeStarBlack.rawValue, productName: marketNameType.Beef.rawValue)
                                            
                                        }else {
                                            return
                                        }
                                        
                                        
                                    }
                                    else if item.productID == 24
                                    {
                                        let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(item.customerID ?? 0),listName: item.listName ?? "" ,productName:marketNameType.Beef.rawValue)
                                        
                                        if fetchDatEntry.count == 0 {
                                            
                                            saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(item.customerID ?? 0),listDesc: item.animalListDescription ?? "",listId: Int64(listIdGenerate),listName: item.listName ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: item.providerID ?? 0, productType: keyValue.genStarBlack.rawValue, productName: marketNameType.Beef.rawValue)
                                            
                                        }else {
                                            return
                                        }
                                        
                                    }
                                    else {
                                        
                                        
                                        
                                        let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(item.customerID ?? 0),listName: item.listName ?? "" ,productName:marketNameType.Beef.rawValue)
                                        
                                        if fetchDatEntry.count == 0 {
                                            
                                            saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(item.customerID ?? 0),listDesc: item.animalListDescription ?? "",listId: Int64(listIdGenerate),listName: item.listName ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: item.providerID ?? 0, productType: keyValue.nonGenoType.rawValue, productName: marketNameType.Beef.rawValue)
                                            
                                            
                                            
                                        }else {
                                            return
                                        }
                                        
                                        
                                    }
                                    
                                }
                                
                                
                                for itemSecond in item.animals{
                                    
                                    
                                    
                                    var animalID1 = UserDefaults.standard.integer(forKey: keyValue.animalId.rawValue)
                                    if animalID1 == 0 {
                                        animalID1 = animalID1 + 1
                                        UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                                    }
                                    else {
                                        animalID1 = animalID1 + 1
                                        UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                                    }
                                    if item.speciesID == SpeciesID.beefSpeciesId {
                                        
                                        let inheritBreed = fetchAllDataProductBreedIdDairy(entityName: Entities.getBreedsTblEntity,breedId:itemSecond.breedID ?? "",pvid:item.providerID ?? 0)
                                        if inheritBreed.count != 0 {
                                            let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                                            
                                            
                                            self.breedName = medbreedRegArr1?.threeCharCode ?? ""
                                            
                                        }
                                        
                                        let sampleType = fetchSampleDetailDataWithProvideId(entityName: Entities.getSampleTblEntity, sampleId: itemSecond.sampleTypeId ?? 0, providerId: item.providerID ?? 0)
                                        if sampleType.count != 0 {
                                            let medbreedRegArr1 = sampleType.object(at: 0) as? GetSampleTbl
                                            self.sampleType1 = medbreedRegArr1?.sampleName ?? ""
                                            
                                        }
                                        
                                        
                                        var timeStamp = String()
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                                        let date =  dateFormatter.date(from: itemSecond.dob ?? "")// create date from string
                                        
                                        if date == nil {
                                            
                                        } else {
                                            
                                            dateFormatter.dateFormat = DateFormatters.ddMMyyyyFormat
                                            timeStamp = dateFormatter.string(from: date!)
                                            
                                        }
                                        
                                        
                                        if item.providerID == 5 {
                                            
                                            if item.productID == 19 {
                                                
                                                let medbreedRegArr = fetchAllDataProductBeefBreedSocietyIDD(entityName: Entities.getBreedSocietiesTblEntity, productId: 19, association: itemSecond.breedAssociationID ?? "")
                                                if medbreedRegArr.count != 0 {
                                                    
                                                    let medbreedRegArr1 = medbreedRegArr.object(at: 0) as? GetBreedSocieties
                                                    self.breedAssociationIdInherit =   medbreedRegArr1?.association ?? ""
                                                }
                                                
                                                let sireRegAssocation = fetchAllDataProductBeefBreedSocietyIDD(entityName: Entities.getBreedSocietiesTblEntity, productId: 19, association: itemSecond.sireAssociationID ?? "")
                                                if sireRegAssocation.count != 0 {
                                                    
                                                    let medbreedRegArr1 = sireRegAssocation.object(at: 0) as? GetBreedSocieties
                                                    self.sireRegAssocationbreedAssociationId =   medbreedRegArr1?.association ?? ""
                                                }
                                                
                                                let damAssociation = fetchAllDataProductBeefBreedSocietyIDD(entityName: Entities.getBreedSocietiesTblEntity, productId: 19, association: itemSecond.damAssociationID ?? "")
                                                if damAssociation.count != 0 {
                                                    
                                                    let medbreedRegArr1 = damAssociation.object(at: 0) as? GetBreedSocieties
                                                    self.damAssociationName =   medbreedRegArr1?.association ?? ""
                                                }
                                                
                                                saveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: itemSecond.earTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: timeStamp , damId: itemSecond.damRegNumber ?? "", sireId: itemSecond.sireRegNumber ?? "" , gender: itemSecond.sex ?? "" ,update: "false", permanentId:itemSecond.breedRegNumber ?? "", tissuName: self.sampleType1, breedName: self.breedName, et: itemSecond.animalName ?? "", farmId: self.breedAssociationIdInherit, orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: self.sireRegAssocationbreedAssociationId, nationHerdAU:  self.damAssociationName , userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1,productId:item.productID ?? 0,custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "", tertiaryGeno: self.tertiaryBreedingName)
                                                
                                                saveAnimaldataBeefInProductId(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: itemSecond.earTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: timeStamp , damId: itemSecond.damRegNumber ?? "", sireId: itemSecond.sireRegNumber ?? "" , gender: itemSecond.sex ?? "" ,update: "false", permanentId:itemSecond.breedRegNumber ?? "", tissuName: self.sampleType1, breedName: self.breedName, et: itemSecond.animalName ?? "", farmId: self.breedAssociationIdInherit, orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: self.sireRegAssocationbreedAssociationId, nationHerdAU:  self.damAssociationName , userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1,productId:item.productID ?? 0,custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "", tertiaryGeno: itemSecond.teriarityProgramID ?? "")
                                                
                                                
                                            } else {
                                                
                                                
                                                let medbreedRegArr = fetchAllDataProductBeefBreedSocietyIDD(entityName: Entities.getBreedSocietiesTblEntity, productId: 20, association: itemSecond.breedAssociationID ?? "")
                                                if medbreedRegArr.count != 0 {
                                                    
                                                    let medbreedRegArr1 = medbreedRegArr.object(at: 0) as? GetBreedSocieties
                                                    self.breedAssociationIdInherit =   medbreedRegArr1?.association ?? ""
                                                }
                                                
                                                let sireRegAssocation = fetchAllDataProductBeefBreedSocietyIDD(entityName: Entities.getBreedSocietiesTblEntity, productId: 20, association: itemSecond.sireAssociationID ?? "")
                                                if sireRegAssocation.count != 0 {
                                                    
                                                    let medbreedRegArr1 = sireRegAssocation.object(at: 0) as? GetBreedSocieties
                                                    self.sireRegAssocationbreedAssociationId =   medbreedRegArr1?.association ?? ""
                                                }
                                                
                                                inheritSaveAnimaldataBeefInProductId(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: itemSecond.earTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: timeStamp , damId: itemSecond.damID ?? "", sireId: itemSecond.sireRegNumber ?? "" , gender: itemSecond.sex ?? "",update: "false", permanentId:itemSecond.breedRegNumber ?? "", tissuName: self.sampleType1, breedName: self.breedName, et: self.breedAssociationIdInherit , farmId:"", orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: itemSecond.breedRegistrationNumber ?? "", nationHerdAU: itemSecond.nationalHerdID ?? "", userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1,productId: Int(item.productID ?? 0), sirYOB: String(itemSecond.sireYOB ?? 0), damYOB: String(itemSecond.damYOB ?? 0), sireRegAssocation: self.sireRegAssocationbreedAssociationId ,custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "", tertiaryGeno: itemSecond.teriarityProgramID ?? "")
                                                
                                                
                                                inheritSaveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: itemSecond.earTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: timeStamp , damId: itemSecond.damID ?? "", sireId: itemSecond.sireRegNumber ?? "" , gender: itemSecond.sex ?? "",update: "false", permanentId:itemSecond.breedRegNumber ?? "", tissuName: self.sampleType1, breedName: self.breedName, et: self.breedAssociationIdInherit , farmId:"", orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: itemSecond.breedRegistrationNumber ?? "", nationHerdAU: itemSecond.nationalHerdID ?? "", userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1,productId: Int(item.productID ?? 0), sirYOB: String(itemSecond.sireYOB ?? 0), damYOB: String(itemSecond.damYOB ?? 0), sireRegAssocation: self.sireRegAssocationbreedAssociationId ,custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "", tertiaryGeno: itemSecond.teriarityProgramID ?? "")
                                                
                                                
                                            }
                                            
                                        }
                                        if item.providerID == 7 {
                                            
                                            let inheritBreed = fetchAllDataProductBreedIdDairy(entityName: Entities.getBreedsTblEntity,breedId:itemSecond.breedID ?? "",pvid:item.providerID ?? 0)
                                            if inheritBreed.count != 0 {
                                                let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                                                
                                                
                                                self.breedName = medbreedRegArr1?.threeCharCode ?? medbreedRegArr1?.breedName ?? ""
                                                
                                            }
                                            let sireRegAssocation = fetchAllDataProductBeefBreedSocietyIDD(entityName: Entities.getBreedSocietiesTblEntity, productId: 25, association: itemSecond.breedAssociationID ?? "")
                                            if sireRegAssocation.count != 0 {
                                                
                                                let medbreedRegArr1 = sireRegAssocation.object(at: 0) as? GetBreedSocieties
                                                self.associationName =  medbreedRegArr1?.association ?? ""
                                            }
                                            
                                            saveAnimaldatawithAge(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: itemSecond.animalTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: timeStamp , damId: itemSecond.damRegNumber ?? "", sireId: itemSecond.sireRegNumber ?? "" , gender: itemSecond.sex ?? "",update: "true", permanentId:itemSecond.breedRegNumber ?? "", tissuName: self.sampleType1, breedName: self.breedName, et: itemSecond.animalName ?? "", farmId:"", orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: self.associationName , nationHerdAU: "", userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1, age:0,productId :Int(item.productID ?? 0), samconflict: "", ageConf: "", bothConf: "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "")
                                            
                                            saveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: itemSecond.animalTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: timeStamp , damId: itemSecond.damRegNumber ?? "", sireId: itemSecond.sireRegNumber ?? "" , gender: itemSecond.sex ?? "",update: "true", permanentId:itemSecond.breedRegNumber ?? "", tissuName: self.sampleType1, breedName: self.breedName, et: itemSecond.animalName ?? "", farmId:"", orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: self.associationName , nationHerdAU: "", userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1,productId: Int(item.productID ?? 0),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "", tertiaryGeno: itemSecond.teriarityProgramID ?? "")
                                        }
                                        
                                        if item.providerID == 6 {
                                            if item.productID == 23 {
                                                
                                                let priorityBreeding = fetchAllDataPriorityDataId(entityName: Entities.getPriorityBreedingTblEntity, priorityBreedId: itemSecond.primaryPriorityProgramID ?? "")
                                                if priorityBreeding.count != 0 {
                                                    let medbreedRegArr1 = priorityBreeding.object(at: 0) as? GetPriorityBreeding
                                                    self.priorityBreedName =   medbreedRegArr1!.priorityBreedName ?? ""
                                                }
                                                
                                                let secondaRypriorityBreeding = fetchAllDataPriorityDataId(entityName: Entities.getSecondaryBreedingProgramsTblEntity, priorityBreedId: itemSecond.secondaryPriorityProgramID ?? "")
                                                if secondaRypriorityBreeding.count != 0 {
                                                    let secondaRy = secondaRypriorityBreeding.object(at: 0) as? GetSecondaryBreedingPrograms
                                                    self.secondaRyBreedingName =   secondaRy!.priorityBreedName ?? ""
                                                }
                                                
                                                saveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: itemSecond.sampleBarCode ?? "", barCodetag: itemSecond.animalName ?? "", date: timeStamp , damId: itemSecond.rgd ?? "", sireId: itemSecond.series ?? "" , gender: itemSecond.sex ?? "",update: "false", permanentId:itemSecond.rgn ?? "", tissuName: self.sampleType1, breedName: "", et: "", farmId:"", orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: self.priorityBreedName , nationHerdAU: self.secondaRyBreedingName , userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1, productId: Int(item.productID ?? 0),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "", tertiaryGeno: self.tertiaryBreedingName )
                                                
                                                saveAnimaldataBeefInProductId(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: itemSecond.sampleBarCode ?? "", barCodetag: itemSecond.animalName ?? "", date: timeStamp , damId: itemSecond.rgd ?? "", sireId: itemSecond.series ?? "", gender: itemSecond.sex ?? "",update: "false", permanentId:itemSecond.rgn ?? "", tissuName: self.sampleType1, breedName: "", et: "", farmId:"", orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: self.priorityBreedName , nationHerdAU: self.secondaRyBreedingName , userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1, productId: Int(item.productID ?? 0),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "", tertiaryGeno: itemSecond.teriarityProgramID ?? "")
                                                
                                            }else {
                                                
                                                
                                                
                                                saveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: itemSecond.sampleBarCode ?? "", barCodetag: itemSecond.animalName ?? "", date: timeStamp , damId: itemSecond.rgd ?? "", sireId: itemSecond.series ?? "" , gender: itemSecond.sex ?? "",update: "false", permanentId:itemSecond.rgn ?? "", tissuName: self.sampleType1, breedName: "", et: "", farmId:"", orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: self.priorityBreedName , nationHerdAU: self.secondaRyBreedingName , userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1, productId: Int(item.productID ?? 0),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "", tertiaryGeno: self.tertiaryBreedingName)
                                                
                                                saveAnimaldataBeefInProductId(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: itemSecond.sampleBarCode ?? "", barCodetag: itemSecond.animalName ?? "", date: timeStamp , damId: itemSecond.rgd ?? "", sireId: itemSecond.series ?? "", gender: itemSecond.sex ?? "",update: "false", permanentId:itemSecond.rgn ?? "", tissuName: self.sampleType1, breedName: "", et: "", farmId:"", orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: self.priorityBreedName , nationHerdAU: self.secondaRyBreedingName , userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1, productId: Int(item.productID ?? 0),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "", tertiaryGeno: self.tertiaryBreedingName )
                                                
                                            }
                                        }
                                    }
                                }
                                
                            }
                        }
                    })
                    alert.addAction(Keeplocal)
                    alert.addAction(Keepserver)
                    self.dependency?.present(alert, animated: true)
                } else {
                    print("same device id")
                }
            }
            
            else {
                
                for item in dataModel.animalLists {
                    
                    //                if item.status == "Deleted" {
                    //
                    //
                    //                } else {
                    
                    
                    if item.speciesID == SpeciesID.dairySpeciesId {
                        var listIdGenerate = UserDefaults.standard.integer(forKey: keyValue.listId.rawValue)
                        if listIdGenerate == 0 {
                            listIdGenerate = listIdGenerate + 1
                            UserDefaults.standard.set(listIdGenerate, forKey: keyValue.listId.rawValue)
                            
                        } else {
                            listIdGenerate = listIdGenerate + 1
                            UserDefaults.standard.set(listIdGenerate, forKey: keyValue.listId.rawValue)
                        }
                        
                        let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(item.customerID ?? 0),listName: item.listName ?? "" ,productName:marketNameType.Dairy.rawValue)
                        if fetchDatEntry.count == 0 {
                            saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(item.customerID ?? 0),listDesc: item.animalListDescription ?? "",listId: Int64(listIdGenerate),listName: item.listName ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: item.providerID ?? 0, productType: "", productName: marketNameType.Dairy.rawValue)
                            
                        } else {
                            return
                        }
                        
                        
                        for itemSecond in item.animals{
                            
                            var animalID1 = UserDefaults.standard.integer(forKey: keyValue.animalId.rawValue)
                            if animalID1 == 0 {
                                animalID1 = animalID1 + 1
                                UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                            }
                            else {
                                animalID1 = animalID1 + 1
                                UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                            }
                            
                            
                            //Dairy
                            if item.speciesID == SpeciesID.dairySpeciesId {
                                
                                let inheritBreed = fetchAllDataProductBreedIdDairy(entityName: Entities.getBreedsTblEntity,breedId:itemSecond.breedID ?? "",pvid:item.providerID ?? 0)
                                if inheritBreed.count != 0 {
                                    let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                                    self.breedName = medbreedRegArr1?.alpha2 ?? medbreedRegArr1?.threeCharCode ?? medbreedRegArr1?.breedName as! String
                                    
                                }
                                
                                let sampleType = fetchSampleDetailDataWithProvideId(entityName: Entities.getSampleTblEntity, sampleId: itemSecond.sampleTypeId ?? 0, providerId: item.providerID ?? 0)
                                if sampleType.count != 0 {
                                    let medbreedRegArr1 = sampleType.object(at: 0) as? GetSampleTbl
                                    self.sampleType1 = medbreedRegArr1?.sampleName ?? ""
                                    
                                }
                                var timeStamp = String()
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                                let date =  dateFormatter.date(from: itemSecond.dob ?? "")// create date from string
                                
                                if date == nil {
                                    
                                } else {
                                    
                                    dateFormatter.dateFormat = DateFormatters.ddMMyyyyFormat
                                    timeStamp = dateFormatter.string(from: date!)
                                    
                                }
                                if item.providerID == 4 {
                                    
                                    
                                    if itemSecond.breedAssociationID == "a40549ab9-beae-4c0c-8e48-5147f18333d9" {
                                        
                                        self.breedAssoId = LocalizedStrings.girolandoAssociationStr
                                    }
                                    
                                    
                                    saveAnimaldataGirlando(entity: Entities.animalMasterTblEntity, earTag: itemSecond.earTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: timeStamp , damId: itemSecond.damRegNumber ?? "", sireId: itemSecond.sireRegNumber ?? "" , gender: itemSecond.sex ?? "", update: "false", breedRegNumber: itemSecond.breedRegNumber ?? "", tissuName: self.sampleType1, breedName: self.breedName, et: itemSecond.mbc ?? "", farmId: "", orderId: UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue), orderSataus: "false", breedId: itemSecond.breedID ?? "", isSync: "false", providerId: item.providerID ?? 0, tissuId: itemSecond.sampleTypeId ?? 0, sireIDAU: "", animalName: itemSecond.animalName ?? "", userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as! Int, udid: "", animalId: animalID1, selectedBornTypeId: itemSecond.bornTypeID ?? 0, breedAssocation: self.breedAssoId ,custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "",girlandoID:"")
                                    
                                    saveAnimaldataGirlando(entity: Entities.dataEntryAnimalAddTbl, earTag: itemSecond.earTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: timeStamp , damId: itemSecond.damRegNumber ?? "", sireId: itemSecond.sireRegNumber ?? "" , gender: itemSecond.sex ?? "", update: "false", breedRegNumber: itemSecond.breedRegNumber ?? "", tissuName: self.sampleType1, breedName: self.breedName, et: itemSecond.mbc ?? "", farmId: "", orderId: UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue), orderSataus: "false", breedId: itemSecond.breedID ?? "", isSync: "false", providerId: item.providerID ?? 0, tissuId: itemSecond.sampleTypeId ?? 0, sireIDAU: "", animalName: itemSecond.animalName ?? "", userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as! Int, udid: "", animalId: animalID1, selectedBornTypeId: itemSecond.bornTypeID ?? 0, breedAssocation: self.breedAssoId ,custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "",girlandoID:"")
                                    
                                } else {
                                    
                                    saveAnimaldata(entity: Entities.dataEntryAnimalAddTbl, animalTag: itemSecond.officialTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: timeStamp , damId: itemSecond.damID ?? "", sireId: itemSecond.sireID  ?? "" , gender: itemSecond.sex ?? "",update: "false", permanentId:"", tissuName: self.sampleType1 , breedName:self.breedName , et: itemSecond.mbc ?? "", farmId:itemSecond.onFarmID ?? "", orderId: UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue),orderSataus:"false",breedId:itemSecond.breedID ?? "" ,isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU:itemSecond.sireID ?? "", nationHerdAU: "", userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as! Int,udid:"", animalId: animalID1, selectedBornTypeId: itemSecond.bornTypeID,custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), specisId: SpeciesID.dairySpeciesId, earTag: itemSecond.earTag ?? "",isSyncServer:false, adhDataServer: false, listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, editFlagSave: false, serverAnimalId: itemSecond.animalID ?? "")
                                    
                                    saveAnimaldata(entity: Entities.animalMasterTblEntity, animalTag: itemSecond.officialTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: timeStamp , damId: itemSecond.damID ?? "", sireId: itemSecond.sireID  ?? "" , gender: itemSecond.sex ?? "",update: "false", permanentId:"", tissuName: self.sampleType1 , breedName:self.breedName , et: itemSecond.mbc ?? "", farmId:itemSecond.onFarmID ?? "", orderId: UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue),orderSataus:"false",breedId:itemSecond.breedID ?? "" ,isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU:itemSecond.sireID ?? "", nationHerdAU: "", userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as! Int,udid:"", animalId: animalID1, selectedBornTypeId: itemSecond.bornTypeID,custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), specisId: SpeciesID.dairySpeciesId, earTag: itemSecond.earTag ?? "",isSyncServer:false, adhDataServer: false, listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, editFlagSave: false, serverAnimalId: itemSecond.animalID ?? "")
                                }
                            }
                        }
                        
                    }
                    if item.speciesID == SpeciesID.beefSpeciesId{
                        
                        //Beef Data Saving
                        var listIdGenerate = UserDefaults.standard.integer(forKey: keyValue.listId.rawValue)
                        if listIdGenerate == 0 {
                            listIdGenerate = listIdGenerate + 1
                            UserDefaults.standard.set(listIdGenerate, forKey: keyValue.listId.rawValue)
                            
                        } else {
                            listIdGenerate = listIdGenerate + 1
                            UserDefaults.standard.set(listIdGenerate, forKey: keyValue.listId.rawValue)
                        }
                        
                        
                        if item.providerID == 5 {
                            if item.productID == 19 {
                                
                                let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(item.customerID ?? 0),listName: item.listName ?? "" ,productName:marketNameType.Beef.rawValue)
                                if fetchDatEntry.count == 0 {
                                    saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(item.customerID ?? 0),listDesc: item.animalListDescription ?? "",listId: Int64(listIdGenerate),listName: item.listName ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: item.providerID ?? 0, productType: keyValue.globalHD50K.rawValue, productName: marketNameType.Beef.rawValue)
                                    
                                } else {
                                    return
                                }
                            } else {
                                let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(item.customerID ?? 0),listName: item.listName ?? "" ,productName:marketNameType.Beef.rawValue)
                                if fetchDatEntry.count == 0 {
                                    saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(item.customerID ?? 0),listDesc: item.animalListDescription ?? "",listId: Int64(listIdGenerate),listName: item.listName ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: item.providerID ?? 0, productType: keyValue.capsInherit.rawValue, productName: marketNameType.Beef.rawValue)
                                    
                                } else {
                                    return
                                }
                            }
                        }
                        if item.providerID == 7 {
                            
                            let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(item.customerID ?? 0),listName: item.listName ?? "" ,productName:marketNameType.Beef.rawValue)
                            
                            if fetchDatEntry.count == 0 {
                                
                                saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(item.customerID ?? 0),listDesc: item.animalListDescription ?? "",listId: Int64(listIdGenerate),listName: item.listName ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: item.providerID ?? 0, productType: "", productName: marketNameType.Beef.rawValue)
                                
                            } else {
                                return
                            }
                        }
                        
                        if item.providerID == 6 {
                            if item.productID == 23 {
                                let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(item.customerID ?? 0),listName: item.listName ?? "" ,productName:marketNameType.Beef.rawValue)
                                
                                if fetchDatEntry.count == 0 {
                                    
                                    saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(item.customerID ?? 0),listDesc: item.animalListDescription ?? "",listId: Int64(listIdGenerate),listName: item.listName ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: item.providerID ?? 0, productType: keyValue.genoTypeOnly.rawValue, productName: marketNameType.Beef.rawValue)
                                    
                                }else {
                                    return
                                }
                                
                            }
                            else if  item.productID == 999
                            {
                                
                                let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(item.customerID ?? 0),listName: item.listName ?? "" ,productName:marketNameType.Beef.rawValue)
                                
                                if fetchDatEntry.count == 0 {
                                    
                                    saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(item.customerID ?? 0),listDesc: item.animalListDescription ?? "",listId: Int64(listIdGenerate),listName: item.listName ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: item.providerID ?? 0, productType: keyValue.genoTypeStarBlack.rawValue, productName: marketNameType.Beef.rawValue)
                                    
                                }else {
                                    return
                                }
                                
                                
                            }
                            else if item.productID == 24
                            {
                                let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(item.customerID ?? 0),listName: item.listName ?? "" ,productName:marketNameType.Beef.rawValue)
                                
                                if fetchDatEntry.count == 0 {
                                    
                                    saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(item.customerID ?? 0),listDesc: item.animalListDescription ?? "",listId: Int64(listIdGenerate),listName: item.listName ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: item.providerID ?? 0, productType: keyValue.genStarBlack.rawValue, productName: marketNameType.Beef.rawValue)
                                    
                                }else {
                                    return
                                }
                                
                            }
                            else {
                                
                                
                                
                                let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(item.customerID ?? 0),listName: item.listName ?? "" ,productName:marketNameType.Beef.rawValue)
                                
                                if fetchDatEntry.count == 0 {
                                    
                                    saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(item.customerID ?? 0),listDesc: item.animalListDescription ?? "",listId: Int64(listIdGenerate),listName: item.listName ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: item.providerID ?? 0, productType: keyValue.nonGenoType.rawValue, productName: marketNameType.Beef.rawValue)
                                    
                                    
                                    
                                }else {
                                    return
                                }
                                
                                
                            }
                            
                        }
                        
                        
                        for itemSecond in item.animals{
                            
                            
                            
                            var animalID1 = UserDefaults.standard.integer(forKey: keyValue.animalId.rawValue)
                            if animalID1 == 0 {
                                animalID1 = animalID1 + 1
                                UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                            }
                            else {
                                animalID1 = animalID1 + 1
                                UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                            }
                            if item.speciesID == SpeciesID.beefSpeciesId {
                                
                                let inheritBreed = fetchAllDataProductBreedIdDairy(entityName: Entities.getBreedsTblEntity,breedId:itemSecond.breedID ?? "",pvid:item.providerID ?? 0)
                                if inheritBreed.count != 0 {
                                    let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                                    
                                    
                                    self.breedName = medbreedRegArr1?.threeCharCode ?? ""
                                    
                                }
                                
                                let sampleType = fetchSampleDetailDataWithProvideId(entityName: Entities.getSampleTblEntity, sampleId: itemSecond.sampleTypeId ?? 0, providerId: item.providerID ?? 0)
                                if sampleType.count != 0 {
                                    let medbreedRegArr1 = sampleType.object(at: 0) as? GetSampleTbl
                                    self.sampleType1 = medbreedRegArr1?.sampleName ?? ""
                                    
                                }
                                if item.providerID == 5 {
                                    
                                    if item.productID == 19 {
                                        
                                        let medbreedRegArr = fetchAllDataProductBeefBreedSocietyIDD(entityName: Entities.getBreedSocietiesTblEntity, productId: 19, association: itemSecond.breedAssociationID ?? "")
                                        if medbreedRegArr.count != 0 {
                                            
                                            let medbreedRegArr1 = medbreedRegArr.object(at: 0) as? GetBreedSocieties
                                            breedAssociationIdInherit =   medbreedRegArr1?.association ?? ""
                                        }
                                        
                                        let sireRegAssocation = fetchAllDataProductBeefBreedSocietyIDD(entityName: Entities.getBreedSocietiesTblEntity, productId: 19, association: itemSecond.sireAssociationID ?? "")
                                        if sireRegAssocation.count != 0 {
                                            
                                            let medbreedRegArr1 = sireRegAssocation.object(at: 0) as? GetBreedSocieties
                                            sireRegAssocationbreedAssociationId =   medbreedRegArr1?.association ?? ""
                                        }
                                        
                                        let damAssociation = fetchAllDataProductBeefBreedSocietyIDD(entityName: Entities.getBreedSocietiesTblEntity, productId: 19, association: itemSecond.damAssociationID ?? "")
                                        if damAssociation.count != 0 {
                                            
                                            let medbreedRegArr1 = damAssociation.object(at: 0) as? GetBreedSocieties
                                            damAssociationName =   medbreedRegArr1?.association ?? ""
                                        }
                                        
                                        saveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: itemSecond.earTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: itemSecond.dob ?? "" , damId: itemSecond.damRegNumber ?? "", sireId: itemSecond.sireRegNumber ?? "" , gender: itemSecond.sex ?? "" ,update: "false", permanentId:itemSecond.breedRegNumber ?? "", tissuName: sampleType1, breedName: breedName, et: itemSecond.animalName ?? "", farmId: breedAssociationIdInherit, orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: sireRegAssocationbreedAssociationId, nationHerdAU:  damAssociationName , userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1,productId:item.productID ?? 0,custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "", tertiaryGeno: self.tertiaryBreedingName )
                                        
                                        saveAnimaldataBeefInProductId(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: itemSecond.earTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: itemSecond.dob ?? "" , damId: itemSecond.damRegNumber ?? "", sireId: itemSecond.sireRegNumber ?? "" , gender: itemSecond.sex ?? "" ,update: "false", permanentId:itemSecond.breedRegNumber ?? "", tissuName: sampleType1, breedName: breedName, et: itemSecond.animalName ?? "", farmId: breedAssociationIdInherit, orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: sireRegAssocationbreedAssociationId, nationHerdAU:  damAssociationName , userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1,productId:item.productID ?? 0,custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "", tertiaryGeno: self.tertiaryBreedingName )
                                        
                                        
                                    } else {
                                        
                                        
                                        let medbreedRegArr = fetchAllDataProductBeefBreedSocietyIDD(entityName: Entities.getBreedSocietiesTblEntity, productId: 20, association: itemSecond.breedAssociationID ?? "")
                                        if medbreedRegArr.count != 0 {
                                            
                                            let medbreedRegArr1 = medbreedRegArr.object(at: 0) as? GetBreedSocieties
                                            breedAssociationIdInherit =   medbreedRegArr1?.association ?? ""
                                        }
                                        
                                        let sireRegAssocation = fetchAllDataProductBeefBreedSocietyIDD(entityName: Entities.getBreedSocietiesTblEntity, productId: 20, association: itemSecond.sireAssociationID ?? "")
                                        if sireRegAssocation.count != 0 {
                                            
                                            let medbreedRegArr1 = sireRegAssocation.object(at: 0) as? GetBreedSocieties
                                            sireRegAssocationbreedAssociationId =   medbreedRegArr1?.association ?? ""
                                        }
                                        
                                        inheritSaveAnimaldataBeefInProductId(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: itemSecond.earTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: itemSecond.dob ?? "" , damId: itemSecond.damID ?? "", sireId: itemSecond.sireRegNumber ?? "" , gender: itemSecond.sex ?? "",update: "false", permanentId:itemSecond.breedRegNumber ?? "", tissuName: sampleType1, breedName: breedName, et: breedAssociationIdInherit , farmId:"", orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: itemSecond.breedRegistrationNumber ?? "", nationHerdAU: itemSecond.nationalHerdID ?? "", userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1,productId: Int(item.productID ?? 0), sirYOB: String(itemSecond.sireYOB ?? 0), damYOB: String(itemSecond.damYOB ?? 0), sireRegAssocation: sireRegAssocationbreedAssociationId ,custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "", tertiaryGeno: itemSecond.teriarityProgramID ?? "")
                                        
                                        
                                        inheritSaveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: itemSecond.earTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: itemSecond.dob ?? "" , damId: itemSecond.damID ?? "", sireId: itemSecond.sireRegNumber ?? "" , gender: itemSecond.sex ?? "",update: "false", permanentId:itemSecond.breedRegNumber ?? "", tissuName: sampleType1, breedName: breedName, et: breedAssociationIdInherit , farmId:"", orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: itemSecond.breedRegistrationNumber ?? "", nationHerdAU: itemSecond.nationalHerdID ?? "", userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1,productId: Int(item.productID ?? 0), sirYOB: String(itemSecond.sireYOB ?? 0), damYOB: String(itemSecond.damYOB ?? 0), sireRegAssocation: sireRegAssocationbreedAssociationId ,custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "",tertiaryGeno: itemSecond.teriarityProgramID ?? "")
                                        
                                    }
                                    
                                }
                                if item.providerID == 7 {
                                    
                                    let inheritBreed = fetchAllDataProductBreedIdDairy(entityName: Entities.getBreedsTblEntity,breedId:itemSecond.breedID ?? "",pvid:item.providerID ?? 0)
                                    if inheritBreed.count != 0 {
                                        let medbreedRegArr1 = inheritBreed.object(at: 0) as? GetBreedsTbl
                                        self.breedName = medbreedRegArr1?.threeCharCode ?? medbreedRegArr1?.breedName ?? ""
                                        
                                    }
                                    let sireRegAssocation = fetchAllDataProductBeefBreedSocietyIDD(entityName: Entities.getBreedSocietiesTblEntity, productId: 25, association: itemSecond.breedAssociationID ?? "")
                                    if sireRegAssocation.count != 0 {
                                        
                                        let medbreedRegArr1 = sireRegAssocation.object(at: 0) as? GetBreedSocieties
                                        associationName =  medbreedRegArr1?.association ?? ""
                                    }
                                    
                                    saveAnimaldatawithAge(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: itemSecond.animalTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: itemSecond.dob ?? "" , damId: itemSecond.damRegNumber ?? "", sireId: itemSecond.sireRegNumber ?? "" , gender: itemSecond.sex ?? "",update: "true", permanentId:itemSecond.breedRegNumber ?? "", tissuName: sampleType1, breedName: breedName, et: itemSecond.animalName ?? "", farmId:"", orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: associationName , nationHerdAU: "", userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1, age:0,productId :Int(item.productID ?? 0), samconflict: "", ageConf: "", bothConf: "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "")
                                    
                                    saveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: itemSecond.animalTag ?? "", barCodetag: itemSecond.sampleBarCode ?? "", date: itemSecond.dob ?? "" , damId: itemSecond.damRegNumber ?? "", sireId: itemSecond.sireRegNumber ?? "" , gender: itemSecond.sex ?? "",update: "true", permanentId:itemSecond.breedRegNumber ?? "", tissuName: sampleType1, breedName: breedName, et: itemSecond.animalName ?? "", farmId:"", orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: associationName , nationHerdAU: "", userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1,productId: Int(item.productID ?? 0),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "", tertiaryGeno: itemSecond.teriarityProgramID ?? "")
                                }
                                
                                if item.providerID == 6 {
                                    if item.productID == 23 {
                                        
                                        let priorityBreeding = fetchAllDataPriorityDataId(entityName: Entities.getPriorityBreedingTblEntity, priorityBreedId: itemSecond.primaryPriorityProgramID ?? "")
                                        if priorityBreeding.count != 0 {
                                            let medbreedRegArr1 = priorityBreeding.object(at: 0) as? GetPriorityBreeding
                                            priorityBreedName =   medbreedRegArr1!.priorityBreedName ?? ""
                                        }
                                        
                                        let secondaRypriorityBreeding = fetchAllDataPriorityDataId(entityName: Entities.getSecondaryBreedingProgramsTblEntity, priorityBreedId: itemSecond.secondaryPriorityProgramID ?? "")
                                        if secondaRypriorityBreeding.count != 0 {
                                            let secondaRy = secondaRypriorityBreeding.object(at: 0) as? GetSecondaryBreedingPrograms
                                            secondaRyBreedingName =   secondaRy!.priorityBreedName ?? ""
                                        }
                                        
                                        let tertiaryPriorityBreeding = fetchAllDataPriorityDataId(entityName: Entities.getTertiaryBreedingProgramsTblEntity, priorityBreedId: itemSecond.teriarityProgramID ?? "")
                                        if tertiaryPriorityBreeding.count != 0 {
                                            let tertiary = tertiaryPriorityBreeding.object(at: 0) as? GetTertiaryBreedingPrograms
                                            self.tertiaryBreedingName =   tertiary!.priorityBreedName ?? ""
                                        }
                                        
                                        saveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: itemSecond.sampleBarCode ?? "", barCodetag: itemSecond.animalName ?? "", date: itemSecond.dob ?? "" , damId: itemSecond.rgd ?? "", sireId: itemSecond.series ?? "" , gender: itemSecond.sex ?? "",update: "false", permanentId:itemSecond.rgn ?? "", tissuName: sampleType1, breedName: "", et: "", farmId:"", orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: priorityBreedName , nationHerdAU: secondaRyBreedingName , userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1, productId: Int(item.productID ?? 0),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "", tertiaryGeno: self.tertiaryBreedingName )
                                        
                                        saveAnimaldataBeefInProductId(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: itemSecond.sampleBarCode ?? "", barCodetag: itemSecond.animalName ?? "", date: itemSecond.dob ?? "" , damId: itemSecond.rgd ?? "", sireId: itemSecond.series ?? "", gender: itemSecond.sex ?? "",update: "false", permanentId:itemSecond.rgn ?? "", tissuName: sampleType1, breedName: "", et: "", farmId:"", orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: priorityBreedName , nationHerdAU: secondaRyBreedingName , userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1, productId: Int(item.productID ?? 0),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "", tertiaryGeno: self.tertiaryBreedingName )
                                        
                                    } else {
                                        
                                        
                                        saveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: itemSecond.sampleBarCode ?? "", barCodetag: itemSecond.animalName ?? "", date: itemSecond.dob ?? "" , damId: itemSecond.rgd ?? "", sireId: itemSecond.series ?? "" , gender: itemSecond.sex ?? "",update: "false", permanentId:itemSecond.rgn ?? "", tissuName: sampleType1, breedName: "", et: "", farmId:"", orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: priorityBreedName , nationHerdAU: secondaRyBreedingName , userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1, productId: Int(item.productID ?? 0),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "", tertiaryGeno: self.tertiaryBreedingName )
                                        
                                        saveAnimaldataBeefInProductId(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: itemSecond.sampleBarCode ?? "", barCodetag: itemSecond.animalName ?? "", date: itemSecond.dob ?? "" , damId: itemSecond.rgd ?? "", sireId: itemSecond.series ?? "", gender: itemSecond.sex ?? "",update: "false", permanentId:itemSecond.rgn ?? "", tissuName: sampleType1, breedName: "", et: "", farmId:"", orderId: 0,orderSataus:"false",breedId:itemSecond.breedID ?? "",isSync:"false", providerId: item.providerID ?? 0,tissuId: itemSecond.sampleTypeId ?? 0,sireIDAU: priorityBreedName , nationHerdAU: secondaRyBreedingName , userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0,udid:"", animalId: animalID1, productId: Int(item.productID ?? 0),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: UserDefaults.standard.value(forKey: keyValue.listId.rawValue) as! Int64, serverAnimalId: itemSecond.animalID ?? "", tertiaryGeno: self.tertiaryBreedingName )
                                        
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

extension GetListForCutomerWithTimeViewModel: ResponseDelegate {
    
    func responseRecieved(_ data: Data?, status: Bool) {
        if Connectivity.isConnectedToInternet() {
            
            if data == nil {
                self.completion()
                return
            }
            let decoder = JSONDecoder()
            
            modalObject = try? decoder.decode(GetListForCustomerModel.self, from: data!)
            
            
            DispatchQueue.main.async {
                if self.modalObject != nil {
                    self.callListForCustomerSave(dataModel: self.modalObject!)
                }
                self.completion()
            }
        }
        
    }
}
