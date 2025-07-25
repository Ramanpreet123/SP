//
//  GetCountryCodeVM.swift
//  SearchPoint
//
//  Created by "" on 05/03/20.
//

import Foundation
import Alamofire
import CoreData

class GetCountryCodeVM{
    
    var dependency:DashboardVC?
    var modalObject: GetCountryCodeModel?
    var completion:()->()?
    
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    
    func callGetCountryCode(){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String ?? ""
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + accessToken]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url: Configuration.Dev(packet: ApiKeys.countryCode.rawValue).getUrl()))
    }
    
    func saveGetCountryCodeData(dataModel: GetCountryCodeModel){
        deleteRecordFromDatabase(entityName: Entities.getCountryCodeTblEntity)
        
        for item in dataModel.countryCodes {
            let saveObject : [String:Any] = [keyValue.numericCode.rawValue:item.countryID, "countryName":item.countryName as Any, keyValue.alphaCode.rawValue:item.alpha3 as Any,keyValue.alpha2.rawValue:item.alpha2 as Any,"marketId":item.marketId as Any,"lastUpdated" :item.lastUpdated as Any]
            insert(entity: Entities.getCountryCodeTblEntity, attributeKey: nil, objectToSave: saveObject)
        }
    }
}

extension GetCountryCodeVM: ResponseDelegate {
    func responseRecieved(_ data: Data?, status: Bool) {
        if data == nil {
            self.completion()
            return
        }
        let decoder = JSONDecoder()
        modalObject = try? decoder.decode(GetCountryCodeModel.self, from: data!)
        
        DispatchQueue.main.async {
            
            if self.modalObject != nil {
                self.saveGetCountryCodeData(dataModel: self.modalObject!)
            }
            
            self.completion()
        }
    }
}
