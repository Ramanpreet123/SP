//
//  SampleTypeViewModel.swift
//  SearchPoint
//
//  Created by "" on 20/11/2019.
//

import Foundation
import Alamofire
import CoreData
class SampleTypeViewModel{
    
    var dependency:DashboardVC?
    var modalObject:SampleTypeModel?
    var completion:()->()?
    
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    
    func callsampleType(){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url: Configuration.Dev(packet: ApiKeys.getSampleType.rawValue).getUrl()))
    }
    
    func saveGetBreedsData(dataModel: SampleTypeModel){
        deleteRecordFromDatabase(entityName: Entities.getSampleTblEntity)
        
        for item in dataModel.providerSampleTypes {
            
            for sample in item.sampleTypes {
                
                let saveObject : [String:Any] = ["lastUpdated":sample.lastUpdated as Any,"isDefault":sample.isDefault as Any,"responseCode": dataModel.responseCode as Any,keyValue.sampleId.rawValue:sample.sampleTypeID as Any,"sampleName":sample.sampleType as Any,keyValue.errorDetail.rawValue:dataModel.errorDetail as Any,keyValue.messageKey.rawValue: dataModel.message as Any, keyValue.providerIdText.rawValue: item.providerID as Any]
                
                
                insert(entity: Entities.getSampleTblEntity, attributeKey: nil, objectToSave: saveObject)
            
            }
            
        }
    }
}
extension SampleTypeViewModel: ResponseDelegate {
    
    func responseRecieved(_ data: Data?, status: Bool) {
        if data == nil {
            self.completion()
            return
        }
        let decoder = JSONDecoder()
        modalObject = try! decoder.decode(SampleTypeModel.self, from: data!)
        
        DispatchQueue.main.async {
            
            if self.modalObject != nil {
                self.saveGetBreedsData(dataModel: self.modalObject!)
            }
            self.completion()
        }
    }
}
