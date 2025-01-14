//
//  GetPriorityBreedNameVM.swift
//  SearchPoint
//
//  Created by "" on 12/03/20.
//

import Foundation
import Alamofire
import CoreData

class GetPriorityBreedNameVM{
    
    var dependency:DashboardVC?
    var modalObject:GetPriorityBreedingModel?
    var completion:()->()?
    
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    
    func callGetPriorityCode(){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url: Configuration.Dev(packet: ApiKeys.priorityBreeding.rawValue).getUrl()))
    }
    
    func saveGetPriorityCodeData(dataModel:[GetPriorityBreedingModel]){
        deleteRecordFromDatabase(entityName: Entities.getPriorityBreedingTblEntity)
        deleteRecordFromDatabase(entityName: Entities.getSecondaryBreedingProgramsTblEntity)
        deleteRecordFromDatabase(entityName: Entities.getTertiaryBreedingProgramsTblEntity)
        
        
        for item in dataModel{
            
            for breed in item.primaryBreedingPrograms {
                let saveObject : [String:Any] = ["priorityBreedId":breed.breedingProgramID as Any, keyValue.priorityBreedName.rawValue:breed.breedingProgram as Any]
                insert(entity: Entities.getPriorityBreedingTblEntity, attributeKey: nil, objectToSave: saveObject)
            }
            for breed in item.secondaryBreedingPrograms {
                let saveObject : [String:Any] = ["priorityBreedId":breed.breedingProgramID as Any, keyValue.priorityBreedName.rawValue:breed.breedingProgram as Any]
                insert(entity: Entities.getSecondaryBreedingProgramsTblEntity, attributeKey: nil, objectToSave: saveObject)
            }
            for breed in item.tertiaryBreedingPrograms {
                let saveObject : [String:Any] = ["priorityBreedId":breed.breedingProgramID as Any, keyValue.priorityBreedName.rawValue:breed.breedingProgram as Any]
                insert(entity: Entities.getTertiaryBreedingProgramsTblEntity, attributeKey: nil, objectToSave: saveObject)
            }
            
        }
    }
}

extension GetPriorityBreedNameVM: ResponseDelegate {
    func responseRecieved(_ data: Data?, status: Bool) {
        if data == nil {
            self.completion()
        } else {
            let decoder = JSONDecoder()
            modalObject = try! decoder.decode(GetPriorityBreedingModel.self, from: data!)
            
            DispatchQueue.main.async {
                if self.modalObject != nil {
                    self.saveGetPriorityCodeData(dataModel: [self.modalObject!])
                }
                
                self.completion()
            }}
    }
}
