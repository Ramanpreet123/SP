//
//  AnimalAutoPopViewModel.swift
//  SearchPoint
//
//  Created by Rajni Raswant on 14/10/24.
//
import Foundation
import Alamofire
import CoreData

class AnimalAutoPopViewModel{
    var dependency:DashboardVC?
    var completion:()->()?
    var modalObject:AutogetAnimalModel?
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
        
    }
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    
    func callGetAutoPopAnimal(){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
      if let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int {
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url: Configuration.Dev(packet: ApiKeys.getAutopopulateAnimal.rawValue + "\(currentCustomerId)").getUrl()))
        print(ApiKeys.getAutopopulateAnimal.rawValue + "\(currentCustomerId)")
      }
     
    }
  func saveAnimalDetails(dataModel: AutogetAnimalModel){
    let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
    //delete based on customerID
    deleteAutoAnimalListDataForCustomer(currentCustomerId ?? 0)
    for item in dataModel.animals {
      let saveObject : [String:Any] = ["earTag": item.earTag,"officialID": item.officialId,"customerID": currentCustomerId ?? 0 ]
      insert(entity: Entities.getAutoAnimalListEntity, attributeKey: nil, objectToSave: saveObject)
    }
   
  }
    
}

extension AnimalAutoPopViewModel: ResponseDelegate {
    func responseRecieved(_ data: Data?, status: Bool) {
      
      let decoder = JSONDecoder()
      modalObject = try? decoder.decode(AutogetAnimalModel.self, from: data!)
        DispatchQueue.main.async {
          if self.modalObject != nil {
              self.saveAnimalDetails(dataModel: self.modalObject!)
          }
            self.completion()
        }
    }
}
