//
//  AnimalDeleteListViewModel.swift
//  SearchPoint
//
//  Created by Mobile Programming on 27/01/21.
//

import Foundation
import Alamofire
import CoreData

class AnimalDeleteListViewModel {
    
    var dependency:DashboardVC?
    var modalObject: AnimalDeleteListModel?
    
    var completion:()->()?
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
   
    init(callBack:@escaping ()->()) {
          completion = callBack
     }
    
    func callDeleteList() {
       let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self

        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url:Configuration.Dev(packet: ApiKeys.deleteList.rawValue).getUrl()))
    }
    
    func callDeleteAnimalList(dataModel: AnimalDeleteListModel){
  
        
        
    }
}

extension AnimalDeleteListViewModel: ResponseDelegate {
    
    func responseRecieved(_ data: Data?, status: Bool) {
        if Connectivity.isConnectedToInternet() {
            
            if data == nil {
                self.completion()
                return
            }
            let decoder = JSONDecoder()
            
            modalObject = try? decoder.decode(AnimalDeleteListModel.self, from: data!)
         
            
            DispatchQueue.main.async {
                if self.modalObject != nil {
                    self.callDeleteAnimalList(dataModel: self.modalObject!)
                }
                self.completion()
            }
        }
        
    }
}
