//
//  ContactSupportViewModel.swift
//  SearchPoint
//
//  Created by "" on 11/11/2019.
//  ""
//

import Foundation
import Alamofire
import CoreData

class ContactSupportViewModel {
    
    var dependency:LoginViewController?
    var modalObject: [ContactSupportModel]?
    
    var completion:()->()?
    init(ref:LoginViewController,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    
    func callContactSupport(){
        
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + "ea4369e9-d4a9-4322-856b-5323e21ff351"]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil,
                                                Url: Configuration.Dev(packet: ApiKeys.contactSupport.rawValue + "/\(appID)").getUrl()))
    }
    
    func saveGetContactSupport(dataModel: [ContactSupportModel]){
        deleteRecordFromDatabase(entityName: Entities.contactSupportTblEntity)
        for item in dataModel {
            let saveObject : [String:Any] = ["text":item.text ?? "NA","hoursOfOpertion": item.hours ?? "" , "country":item.market as Any ,"email":item.email as Any,"phone":item.phone as Any]
            insert(entity: Entities.contactSupportTblEntity, attributeKey: nil, objectToSave: saveObject)
        }
    }
}

extension ContactSupportViewModel: ResponseDelegate {
    
    func responseRecieved(_ data: Data?, status: Bool) {
        let decoder = JSONDecoder()
        if data != nil{
            modalObject = try? decoder.decode([ContactSupportModel].self, from: data!)
            DispatchQueue.main.async {
                
                if self.modalObject != nil {
                    self.saveGetContactSupport(dataModel: self.modalObject!)
                }
                
                self.completion()
            }
        }
    }
}



