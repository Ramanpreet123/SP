//
//  GetCustomerViewModel.swift
//  SearchPoint
//
//  Created by "" on 01/06/20.
//

import Foundation
import Alamofire
import CoreData

class GetCustomerViewModel{
    
    var dependency:DashboardVC?
    var modalObject: GetCustomerModel?
    var completion:()->()?
    
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    
    func callGetCustomerCode(){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url: Configuration.Dev(packet: ApiKeys.customerApi.rawValue).getUrl()))
    }
    
    func saveGetCoustomerCodeData(dataModel: GetCustomerModel){
        deleteRecordFromDatabase(entityName: Entities.getCustomerTblEntity)
        deleteRecordFromDatabase(entityName: Entities.customerMarketsTblEntity)
        deleteRecordFromDatabase(entityName: Entities.getBillingContactEntity)
        for item in dataModel.customers {
            
            for data in item.billingCustomersArray{
                let saveObject : [String:Any] = [keyValue.messageKey.rawValue:"","custId":item.customerID as Any,"billToCustId":data.billingCustomerID as Any,"contactName":data.billingCustomerName as Any,"emailId":"","lastUpdated":"","responseCode":200,keyValue.errorDetail.rawValue:"","isDefault":false]
                insert(entity: Entities.getBillingContactEntity, attributeKey: nil, objectToSave: saveObject)
            }
            
            for market in item.markets {
                let saveObject : [String:Any] = [keyValue.billToCustomerId.rawValue:item.billToCustomerID as Any, "billToCustomerName":item.billToCustomerName as Any,keyValue.customerId.rawValue:item.customerID as Any,"customerName":item.customerName!,"marketId":market.marketID!, keyValue.marketCode.rawValue:market.marketCode as Any ,"emailId" :UserDefaults.standard.value(forKey:keyValue.userName.rawValue) as? String as Any,"country" : item.country!]
                insert(entity: Entities.getCustomerTblEntity, attributeKey: nil, objectToSave: saveObject)
                
                let saveMarketObject : [String:Any] = [keyValue.customerId.rawValue:item.customerID as Any, "marketId":market.marketID as Any, keyValue.marketCode.rawValue:market.marketCode as Any ]
                insert(entity: Entities.customerMarketsTblEntity, attributeKey: nil, objectToSave: saveMarketObject)
            }
            
        }
    }
}



extension GetCustomerViewModel: ResponseDelegate {
    func responseRecieved(_ data: Data?, status: Bool) {
        if data == nil {
            return
        }
        let decoder = JSONDecoder()
        modalObject = try? decoder.decode(GetCustomerModel.self, from: data!)
        
        DispatchQueue.main.async {
            
            if self.modalObject != nil {
                self.saveGetCoustomerCodeData(dataModel: self.modalObject!)
            }
            
            self.completion()
        }
    }
}
