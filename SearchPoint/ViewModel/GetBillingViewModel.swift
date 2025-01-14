//
//  GetBillingViewModel.swift
//  SearchPoint
//
//  Created by "" on 09/12/19.
//

import Foundation
import Alamofire
import CoreData

class GetBillingViewModel {
    
    var dependency:DashboardVC?
    var modalObject:GetBillingModel?
    var completion:()->()?
    
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    
    func callBillingApi(){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams:nil, Url:Configuration.Dev(packet: ApiKeys.billingContacts.rawValue).getUrl()))
    }
    
    func saveGetBillingSupport(dataModel:GetBillingModel){
        for itemNew in dataModel.billToCustomers{
            let saveObject : [String:Any] = [keyValue.messageKey.rawValue:dataModel.message as Any,"custId":1,"billToCustId":itemNew.billToCustomerID as Any,"contactName":itemNew.billToName as Any,"emailId":"","lastUpdated":itemNew.lastUpdated as Any,"responseCode":dataModel.responseCode,keyValue.errorDetail.rawValue:dataModel.errorDetail as Any]
            
            insert(entity: Entities.getBillingContactEntity, attributeKey: nil, objectToSave: saveObject)
        }
    }
}

extension GetBillingViewModel: ResponseDelegate {
    
    func responseRecieved(_ data: Data?, status: Bool) {
        if Connectivity.isConnectedToInternet() {
            
            if data == nil {
                self.completion()
                return
            }
            let decoder = JSONDecoder()
            
            modalObject = try? decoder.decode(GetBillingModel.self, from: data!)
            
            DispatchQueue.main.async {
                if self.modalObject != nil {
                    deleteRecordFromDatabase(entityName: Entities.getBillingContactEntity)
                    self.saveGetBillingSupport(dataModel: self.modalObject!)
                }
                self.completion()
            }
        }
        
    }
}
