//
//  GetBreedCodeVM.swift
//  SearchPoint
//
//  Created by "" on 05/03/20.
//

import Foundation
import Alamofire
import CoreData

class GetBreedCodeVM{
    
    var dependency:DashboardVC?
    var modalObject:[GetBreedCodeModel]?
    
    var completion:()->()?
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    
    func callGetBrredCode(modelObj:LoginModel){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url: Configuration.Dev(packet: ApiKeys.breedCodes.rawValue).getUrl()))
    }
    
    func saveBreedCodeData(dataModel:[GetBreedCodeModel]){
        for item in dataModel{
            let saveObject : [String:Any] = ["breedCode":item.BreedCode as Any, keyValue.breedId.rawValue:item.BreedId as Any]
            insert(entity: "GetBreedsCodes", attributeKey: nil, objectToSave: saveObject)
        }
    }
}
extension GetBreedCodeVM: ResponseDelegate {
    
    
    func responseRecieved(_ data: Data?, status: Bool) {
        let decoder = JSONDecoder()
        modalObject = try! decoder.decode([GetBreedCodeModel].self, from: data!)
        DispatchQueue.main.async {
            
            if self.modalObject != nil {
                self.saveBreedCodeData(dataModel: self.modalObject!)
            }
            
            self.completion()
        }
    }
}
