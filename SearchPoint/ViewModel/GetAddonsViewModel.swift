//
//  GetAddonsViewModel.swift
//  SearchPoint
//
//  Created by "" on 11/10/2019.
//  ""
//

import Foundation
import Alamofire
import CoreData
class GetAddonsViewModel{
    
    var dependency:DashboardVC?
    var modalObject:[GetAddonsModel]?
    
    var completion:()->()?
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
        
    }
    
    
    func callGetAddons(modelObj:LoginModel){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url: Configuration.Dev(packet: ApiKeys.getAddons.rawValue).getUrl()))
    }
    
    func saveGetAddonsData(dataModel:[GetAddonsModel]){}
}

extension GetAddonsViewModel: ResponseDelegate {
    
    
    func responseRecieved(_ data: Data?, status: Bool) {
        let decoder = JSONDecoder()
        modalObject = try! decoder.decode([GetAddonsModel].self, from: data!)
        DispatchQueue.main.async {
            
            if self.modalObject != nil {
                self.saveGetAddonsData(dataModel: self.modalObject!)
            }
            self.completion()
        }
    }
}
