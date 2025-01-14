//
//  AppVersionViewModel.swift
//  SearchPoint
//
//  Created by MacBook on 24/08/20.
//

import Foundation
import Alamofire
import CoreData
class MobileVersionViewModel{
    
    var dependency:DashboardVC?
    var modalObject:MobileVersionModel?
    var completion:()->()?
    
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
        
    }
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    
    
    func callGetMobileVersioN(){
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: nil, bodyParams: nil, Url: Configuration.Dev(packet: ApiKeys.appVerisonAPI.rawValue).getUrl() + "ios"))
    }
    
    func saveGetAppVersionData(dataModel:MobileVersionModel){
        deleteRecordFromDatabase(entityName: Entities.mobileVersionTbl)
        let saveObject : [String:Any] = ["appVersion": dataModel.appVersion as Any , "deployment": dataModel.deployment as Any,"os": dataModel.os as Any,"versionCode":dataModel.versionCode as Any,"dbVersion":dataModel.dbVersion as Any]
        insert(entity: Entities.mobileVersionTbl, attributeKey: nil, objectToSave: saveObject)
    }
}

extension MobileVersionViewModel: ResponseDelegate {
    func responseRecieved(_ data: Data?, status: Bool) {
        let decoder = JSONDecoder()
        if data == nil {
            self.completion()
            return
        }
        modalObject = try? decoder.decode(MobileVersionModel.self, from: data!)
        DispatchQueue.main.async {
            
            if self.modalObject != nil {
                self.saveGetAppVersionData(dataModel: self.modalObject!)
            }
            self.completion()
        }
    }
}
