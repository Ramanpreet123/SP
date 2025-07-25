//
//  ProviderBornTypesViewModel.swift
//  SearchPoint
//
//  Created by "" 01/05/20.
//

import Foundation
import Alamofire
import CoreData

class ProviderBornTypesViewModel {
    
    var dependency:DashboardVC?
    var modalObject: ProviderBornTypes?
    
    var completion:()->()?
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
        
    }
    init(callBack:@escaping ()->()) {
          completion = callBack
      }
    
    func serverCall() {
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        //let accessToken = appDelegate?.keychain_valueForKey(keyValue.accessToken.rawValue) as? String
       let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url: Configuration.Dev(packet: ApiKeys.bornTypes.rawValue).getUrl()))
    }
    
    func saveData(dataModel: ProviderBornTypes) {
        
        deleteRecordFromDatabase(entityName: Entities.getBornTypeTblEntity)

        
        for providerBornTypes in dataModel.providerBornTypes {
            for bornType in providerBornTypes.bornTypes {
                let saveObject : [String:Any] = [keyValue.providerId.rawValue: providerBornTypes.providerID,
                                                 "provider": providerBornTypes.provider,
                                                 "bornTypeID": bornType.bornTypeID,
                                                 "bornTypeName": bornType.name,
                                                 "bornTypeCode": bornType.bornTypeCode,"lastUpdated":bornType.lastUpdated]
                
                //saveBornTypeData(providerId: providerBornTypes.providerID, provider: providerBornTypes.provider, bornTypeID: bornType.bornTypeID, bornTypeName: bornType.name, bornTypeCode: bornType.bornTypeCode)
                
                insert(entity: Entities.getBornTypeTblEntity, attributeKey: nil, objectToSave: saveObject)
            }
        }
        
       
    }
    
}
extension ProviderBornTypesViewModel: ResponseDelegate {
    func responseRecieved(_ data: Data?, status: Bool) {
        if data == nil {
            self.completion()
            return
        }
        let decoder = JSONDecoder()
        modalObject = try! decoder.decode(ProviderBornTypes.self, from: data!)
        
        DispatchQueue.main.async {
            if self.modalObject != nil {
                self.saveData(dataModel: self.modalObject!)
            }
            
            self.completion()
        }
    }
}
