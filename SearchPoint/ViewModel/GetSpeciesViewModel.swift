//
//  GetSpeciesViewModel.swift
//  SearchPoint
//
//  Created by "" on 10/10/2019.
//  ""
//


import Foundation
import Alamofire
import CoreData

class GetSpeciesViewModel{
    
    var dependency:DashboardVC?
    var modalObject: GetSpeciesModel?
    var completion:()->()?
    
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    
    
    func callGetSpecies(){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String ?? ""
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + accessToken]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url: Configuration.Dev(packet: ApiKeys.getSpecies.rawValue).getUrl()))
    }
    
    func saveGetSpeciesData(dataModel: GetSpeciesModel) {
        deleteRecordFromDatabase(entityName: Entities.getSpeciesTblEntity)
        for specie in dataModel.species {
            let saveObject : [String:Any] = ["speciesId": specie.speciesID as Any , "speciesName": specie.name as Any,"lastUpdated":specie.lastUpdated as Any]
            insert(entity: Entities.getSpeciesTblEntity, attributeKey: nil, objectToSave: saveObject)
            
        }
    }
    
}

extension GetSpeciesViewModel: ResponseDelegate {
    func responseRecieved(_ data: Data?, status: Bool) {
        if data == nil {
            self.completion()
            return
        }
        let decoder = JSONDecoder()
        modalObject = try? decoder.decode(GetSpeciesModel.self, from: data!)
        DispatchQueue.main.async {
            
            if self.modalObject != nil {
                self.saveGetSpeciesData(dataModel: self.modalObject!)
            }
            self.completion()
        }
    }
}
