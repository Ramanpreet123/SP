//
//  GetNominatorsViewModel.swift
//  SearchPoint
//
//  Created by "" on 10/10/2019.
//  ""
//

import Foundation
import Alamofire
import CoreData

class GetNominatorsViewModel{
    
    var dependency:DashboardVC?
    var modalObject:GetNominatorsModel?
    var completion:()->()?
    
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    
    func callGetNominators(){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url: Configuration.Dev(packet: ApiKeys.getNominators.rawValue).getUrl()))
    }
    
    func saveGetNominatorsData(dataModel:GetNominatorsModel){
        deleteRecordFromDatabase(entityName: "GetNominatorsTbl")
        for nomi in dataModel.nominators {
            
            let saveObject : [String:Any] = ["nominatorId" :nomi.nominatorID as Any, "nominator":nomi.nominator as Any,"isDefault":nomi.isDefault as Any,keyValue.providerIdText.rawValue:nomi.providerID as Any, "provider":nomi.provider as Any, "providerGroupId":nomi.providerGroupID as Any,"providerGroup":nomi.providerGroup as Any,"lastUpdated":nomi.lastUpdated as Any,"responseCode":dataModel.responseCode as Any,keyValue.errorDetail.rawValue:dataModel.errorDetail as Any,keyValue.messageKey.rawValue:dataModel.message as Any]
            insert(entity: "GetNominatorsTbl", attributeKey: nil, objectToSave: saveObject)
        }
    }
}

extension GetNominatorsViewModel: ResponseDelegate {
    
    func responseRecieved(_ data: Data?, status: Bool) {
        if data == nil {
            self.completion()
            return
        }
        let decoder = JSONDecoder()
        modalObject = try? decoder.decode(GetNominatorsModel.self, from: data!)
        
        DispatchQueue.main.async {
            
            if self.modalObject != nil {
                self.saveGetNominatorsData(dataModel: self.modalObject!)
            }
            
            self.completion()
        }
    }
}
