//
//  ManagementGroupVM.swift
//  SearchPoint
//
//  Created by Mobile Programming on 26/07/22.
//

import UIKit
import Alamofire
import CoreData

class ManagementGroupVM {
    
    var dependency:MyManagementGroupController?
    var modalObject: AnimalGroupsForCustomerUpdateModel?
    var completion:()->()?
    var dateNew = String()
    
    init(ref:MyManagementGroupController,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    
    func callAnimalGroupsForCustomerUpdateApi() {
        
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        let dateFetch = fetchAllDataLastUpdatedTime(entityName: "ResultGroupUpdatedTime",customerId:Int64(UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int ?? 0))
        if dateFetch.count != 0 {
            
            let abc = dateFetch.object(at: 0) as? ResultGroupUpdatedTime
            self.dateNew = abc?.hittingTime ?? ""
        }
        
        let custId =  UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url:Configuration.Dev(packet: ApiKeys.animalgroupsforcustomer.rawValue + "/\(custId )").getUrl()))
        
    }

    
    func saveAnimalGroupsForCustomer(dataModel: AnimalGroupsForCustomerUpdateModel ){
        for data in dataModel.customerGroups {
            
            let checkGroupExist = fetchAllDataWithServerGroupId(entityName: Entities.resultGroupCreateTblEntity, customerId: Int64(dataModel.customerID ?? 0), serverGroupId: data.groupID ?? "") as! [ResultGroupCreate]
            let groupIdGenerate = UserDefaults.standard.integer(forKey: "groupId")
            if checkGroupExist.count == 0 {
                var groupIdGenerate = UserDefaults.standard.integer(forKey: "groupId")
                
                groupIdGenerate += 1
                UserDefaults.standard.set(groupIdGenerate, forKey: "groupId")
                
                saveGroupDataResult(entity: Entities.resultGroupCreateTblEntity, customerId: Int64(dataModel.customerID ?? 0), groupId: Int64(groupIdGenerate), groupDesc: "", groupName: data.groupName ?? "", groupStatusId: data.groupStatusID ?? 0, groupStatus: data.groupStatus ?? "", groupTypeId: data.groupTypeID ?? 0, groupType: data.groupType ?? "", groupServerId: data.groupID ?? "")
            } else {
                updateGroupTable(entity: Entities.resultGroupCreateTblEntity, customerId: Int64(dataModel.customerID ?? 0), groupId: Int64(checkGroupExist[0].groupId), groupDesc: "", groupName: data.groupName ?? "", groupStatusId: data.groupStatusID ?? 0, groupStatus: data.groupStatus ?? "", groupTypeId: data.groupTypeID ?? 0, groupType: data.groupType ?? "", groupServerId: data.groupID ?? "")
                
            }
            for animals in data.animals {
                
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: LocalizedStrings.en_US_POSIXStr)
                dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                
                let date:Date? = dateFormatter.date(from:animals.dob ?? "")
                
                saveAnimaldataResult(entity: Entities.resultGroupAnimalsTblEntity, serverGroupId: data.groupID ?? "", groupName: data.groupName ?? "", groupStatusId: data.groupStatusID ?? 0, groupStatus: data.groupStatus ?? "", groupTypeId: data.groupTypeID ?? 0, groupTypeName: data.groupType ?? "", animalID: animals.animalId ?? "", onFarmId: animals.onFarmId ?? "", officalId: animals.officialId ?? "", dob: animals.dob ?? "", sex: animals.sex ?? "", breedId: animals.breedId ?? "", breedName: animals.breed ?? "", name: animals.name ?? "", groupId: Int64(groupIdGenerate),customerId :Int64(dataModel.customerID ?? 0),datedob: date ?? Date())
                if data.groupTypeID == 1 && data.groupStatusID == 1
                {
                    updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:Int64(dataModel.customerID ?? 0), animalID: animals.animalId ?? "", status: LocalizedStrings.banStatus)
                }
                else if data.groupTypeID == 0 && data.groupStatusID == 1 {
                    updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:Int64(dataModel.customerID ?? 0), animalID: animals.animalId ?? "", status: LocalizedStrings.dollerStatus)
                } else if  data.groupTypeID == 0 && data.groupStatusID == 0 {
                    let groupOb = fetcresultgroupid(entityName: Entities.resultGroupAnimalsTblEntity, customerId: Int64(dataModel.customerID ?? 0), Groupstatusid: 1,grouptypeid: 1, animalid: animals.animalId ?? "")
                    let groupOb1 = fetcresultgroupid(entityName: Entities.resultGroupAnimalsTblEntity, customerId: Int64(dataModel.customerID ?? 0), Groupstatusid: 1,grouptypeid: 0, animalid: animals.animalId ?? "")
                    if groupOb.count > 0{
                        // handle groupOb case
                    }
                    else if groupOb1.count > 0 {
                        // handle groupOb1 case
                    }
                    else {
                        updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:Int64(dataModel.customerID ?? 0), animalID: animals.animalId ?? "", status: LocalizedStrings.inactiveStatus)
                    }
                }
                
            }
        }
    }
}


extension ManagementGroupVM : ResponseDelegate {
    
    func responseRecieved(_ data: Data?, status: Bool) {
        if Connectivity.isConnectedToInternet() {
            
            if data == nil {
                self.completion()
                return
            }
            let decoder = JSONDecoder()
            
            modalObject = try? decoder.decode(AnimalGroupsForCustomerUpdateModel.self, from: data!)
            
            
            DispatchQueue.global(qos: .background).sync {
                if self.modalObject != nil {
                    self.saveAnimalGroupsForCustomer(dataModel: self.modalObject!)
                    
                }
                self.completion()
            }
        }
    }
}
