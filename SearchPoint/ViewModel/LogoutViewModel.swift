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
    
    func logout(modelObj: LoginModel?){
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        //let accessToken = appDelegate?.keychain_valueForKey(keyValue.accessToken.rawValue) as? String
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
        
        if status == false{

         delegate?.responseRecievedStstus(status: status)
        } else {
            // let decoder = JSONDecoder()
            //modalObject = try! decoder.decode(LogoutModel.self, from: data!)
            
            UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
            DispatchQueue.main.async {
                //self.saveGetSpeciesData(dataModel: self.modalObject!)
                self.completion()
            }
        }
    }
}

