//
//  GetBreedSocietiesVM.swift
//  SearchPoint
//
//  Created by "" on 12/03/20.
//

import Foundation
import Alamofire
import CoreData

class GetBreedSocietiesVM{
    
    var dependency:DashboardVC?
    var modalObject:GetBreedSocietiesModel?
    var completion:()->()?
    
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    func callGetSocietiesCode(){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url: Configuration.Dev(packet: ApiKeys.breedSoceities.rawValue).getUrl()))
    }
    
    func saveGetSocietiesCodeData(dataModel:GetBreedSocietiesModel){
        
        deleteRecordFromDatabase(entityName: Entities.getBreedSocietiesTblEntity)
        
        for itemNew in dataModel.breedAssociations {
            for it in itemNew.breedAssociations {
                
                let saveObject : [String:Any] = ["sequenceId":it.sequenceID as Any,"productID":itemNew.productID as Any,"association":it.association as Any,"associationId":it.associationID as Any,"emailId":"","productName":itemNew.product as Any,"lastUpdated":itemNew.lastUpdated as Any]
                insert(entity: Entities.getBreedSocietiesTblEntity, attributeKey: nil, objectToSave: saveObject)
                
                
                
            }
        }
    }
}
extension GetBreedSocietiesVM: ResponseDelegate {
    
    
    func responseRecieved(_ data: Data?, status: Bool) {
        if data == nil {
            self.completion()
            return
        }
        let decoder = JSONDecoder()
        modalObject = try? decoder.decode(GetBreedSocietiesModel.self, from: data!)
        DispatchQueue.main.async {
            
            if self.modalObject != nil {
                self.saveGetSocietiesCodeData(dataModel: self.modalObject!)
            }
            self.completion()
        }
    }
}
