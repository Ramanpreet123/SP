//
//  LogoutViewModel.swift
//  SearchPoint
//
//  Created by "" 22/04/20.
//

import Foundation
import Alamofire
import CoreData

protocol ResponseLogoutApi: class {
    func responseRecievedStstus(status:Bool)
}

class LogoutViewModel {
    
    var dependency:SideMenuVC?
    var modalObject: LogoutModel?
    weak var delegate: ResponseLogoutApi?
    
    var completion:()->()?
    init(ref:SideMenuVC, callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    
    func logout(){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String

        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.post, Headers: headerDict, bodyParams: nil, Url: Configuration.Dev(packet: ApiKeys.logOut.rawValue).getUrl()))
        UserDefaults.standard.removeObject(forKey: "BioMetricEnabled")
    }
    
    
}

extension LogoutViewModel: ResponseDelegate {
    func responseRecieved(_ data: Data?, status: Bool) {
        
        if !status {

         delegate?.responseRecievedStstus(status: status)
        } else {
            
            UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
            DispatchQueue.main.async {
                self.completion()
            }
        }
    }
}

