//
//  SampleStatusViewModel.swift
//  SearchPoint
//
//  Created by "" 20/05/20.
//

import Foundation


import Foundation
import Alamofire
import CoreData

class SampleStatusViewModel {
    
    var dependency:DashboardVC?
    var modalObject: SampleStatuses?
    var completion:()->()?
    
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    
    func callSampleStatuses() {
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url:Configuration.Dev(packet: ApiKeys.samplestatuses.rawValue).getUrl()))
    }
    
    func saveGetOrderDetailByDatesDays(dataModel: SampleStatuses){
        deleteRecordFromDatabase(entityName: Entities.sampleStatusTblEntity)
        for sample in dataModel.sampleStatuses {
            if sample.sampleStatusID != 3 {
                let saveObject : [String:Any] = ["sampleStatusID":sample.sampleStatusID as Any, "sampleStatus":sample.sampleStatus as Any]
                insert(entity: Entities.sampleStatusTblEntity, attributeKey: nil, objectToSave: saveObject)
            }
        }
    }
}

extension SampleStatusViewModel: ResponseDelegate {
    
    func responseRecieved(_ data: Data?, status: Bool) {
        if Connectivity.isConnectedToInternet() {
            
            if data == nil {
                self.completion()
                return
            }
            let decoder = JSONDecoder()
            
            modalObject = try? decoder.decode(SampleStatuses.self, from: data!)
            
            DispatchQueue.main.async {
                if self.modalObject != nil {
                    self.saveGetOrderDetailByDatesDays(dataModel: self.modalObject!)
                }
                self.completion()
            }
        }
        
    }
}
