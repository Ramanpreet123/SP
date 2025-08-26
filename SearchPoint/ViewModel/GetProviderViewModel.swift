//
//  SettingViewModel.swift
//  SearchPoint
//
//  Created by "" on 09/10/2019.
//  ""
//

import Foundation
import Alamofire
import CoreData

class GetProviderViewModel {
    
    var dependency:DashboardVC?
    var modalObject:GetProviderModel?
    var completion:()->()?
    
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    
    //***** GetProvider ******//
    func callGetProvider(){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets(Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url: Configuration.Dev(packet: ApiKeys.getProviders.rawValue).getUrl()))
    }
    
    
    func saveGetProviderData(dataModel: GetProviderModel){
        deleteRecordFromDatabase(entityName: Entities.getProviderTblEntity)
        deleteRecordFromDatabase(entityName: Entities.evaluationMarketsTblEntity)
        
        for item in dataModel.providers {
            let saveObject : [String:Any] = ["lastUpdated": item.lastUpdated as Any,"isDefault": item.isDefault as Any,"providerGroup": item.providerGroup as Any,"providerGroupId": item.providerGroupID as Any,keyValue.providerIdText.rawValue: item.providerID as Any, "providerName": item.provider as Any,"species": item.species as Any,"speciesId": item.speciesID as Any,"responseCode": dataModel.responseCode,keyValue.errorDetail.rawValue: dataModel.errorDetail,keyValue.messageKey.rawValue: dataModel.message]
            
            insert(entity: Entities.getProviderTblEntity, attributeKey: nil, objectToSave: saveObject)
            
            for market in item.markets {
                let marketObject : [String:Any] = ["marketName": market.name as Any,
                                                   "marketsID": market.marketsID as Any,
                                                   "provider": item.provider as Any,
                                                   "providerID": item.providerID as Any,
                                                   "speciesId":item.speciesID as Any,
                                                   "species":item.species as Any,
                                                   "isDefault" :market.isDefault as Any
                ]
                insert(entity: Entities.evaluationMarketsTblEntity, attributeKey: nil, objectToSave: marketObject)
            }
        }
    }
}


extension GetProviderViewModel: ResponseDelegate {
    
    func responseRecieved(_ data: Data?, status: Bool) {
        if data == nil {
            self.completion()
            return
        }
        let decoder = JSONDecoder()
        modalObject = try? decoder.decode(GetProviderModel.self, from: data!)
        DispatchQueue.main.async {
            
            if self.modalObject != nil {
                self.saveGetProviderData(dataModel: self.modalObject!)
            }
            
            self.completion()
        }
    }
}

