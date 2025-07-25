//
//  HeartBeatViewModel.swift
//  SearchPoint
//
//  Created by Mobile Programming on 31/08/20.
//

import Foundation
import Alamofire
import CoreData

class HeartBeatViewModel{
    var dependency:DashboardVC?
    var completion:()->()?
    
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
        
    }
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    
    func callGetHearBeatData(){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url: Configuration.Dev(packet: ApiKeys.heartBeatAPI.rawValue).getUrl()))
    }
    
}

extension HeartBeatViewModel: ResponseDelegate {
    func responseRecieved(_ data: Data?, status: Bool) {
        DispatchQueue.main.async {
            self.completion()
        }
    }
}
