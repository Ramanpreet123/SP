//
//  GetMarketsViewModel.swift
//  SearchPoint
//
//  Created by "" on 10/10/2019.
//  ""
//

import Foundation
import Alamofire
import CoreData

class GetMarketsViewModel{
    
    var dependency:DashboardVC?
    var modalObject: GetMarketsModel?
    var completion:()->()?
    
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    
    func callGetMarkets(){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url:         Configuration.Dev(packet: ApiKeys.getMarkets.rawValue).getUrl()))
    }
    
    
    func saveGetMarketsData(dataModel: GetMarketsModel){
        
        deleteRecordFromDatabase(entityName: "GetMarketsTbl")
        
        for item in dataModel.markets {
            
            let saveObject : [String:Any] = ["marketId":item.marketID as Any, keyValue.marketName.rawValue:item.marketName as Any , "pricingLinkUrl" :"https://www.zoetis.com.br/especies/bovinos/clarifide/index.aspx", "pricingInfoText" :item.pricingInfoText as Any, "pricingLinkText":item.pricingLinkText as Any,"lastUpdated": item.lastUpdated as Any]
            insert(entity: "GetMarketsTbl", attributeKey: nil, objectToSave: saveObject)
        }
    }
    
    
}
extension GetMarketsViewModel: ResponseDelegate {
    
    
    func responseRecieved(_ data: Data?, status: Bool) {
        if data == nil {
            self.completion()
            return
        }
        
        let decoder = JSONDecoder()
        modalObject = try? decoder.decode(GetMarketsModel.self, from: data!)
        DispatchQueue.main.async {
            
            if self.modalObject != nil {
                self.saveGetMarketsData(dataModel: self.modalObject!)
            }
            
            self.completion()
        }
    }
}
