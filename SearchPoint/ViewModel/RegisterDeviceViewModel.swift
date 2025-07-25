//
//  RegisterDeviceViewModel.swift
//  SearchPoint
//
//  Created by "" 29/04/20.
//

import Foundation
import Alamofire
import CoreData

protocol ResponseRegisterDeviceApi: class {
    func responseRecievedStatusForRegisterDevice(status:Bool)
}

class RegisterDeviceViewModel {
    
    var dependency: LoginViewController?
    var modalObject: RegisterDeviceModel?
    weak var delegate: ResponseRegisterDeviceApi?
    
    var completion:()->()?
    init(ref:LoginViewController, callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    
    func register(){
        
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        //let accessToken = appDelegate?.keychain_valueForKey(keyValue.accessToken.rawValue) as? String
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        var systemVersion = UIDevice.current.systemVersion

        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let bodyParm: [String: Any] = [
          "deviceId": UserDefaults.standard.value(forKey: "DeviceId") as! String,
          "deviceName": UIDevice.current.name,
          "deviceInfo": systemVersion
        ]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.post, Headers: headerDict, bodyParams: bodyParm, Url: Configuration.Dev(packet: ApiKeys.registerdevice.rawValue).getUrl()))
    }
    
    func saveGetSpeciesData(dataModel: RegisterDeviceModel) {
        
        UserDefaults.standard.set(dataModel.deviceID, forKey: "validateDeviceIDFromServer")
    }
    
}
extension RegisterDeviceViewModel: ResponseDelegate {
    func responseRecieved(_ data: Data?, status: Bool) {
        if status == false {
            delegate?.responseRecievedStatusForRegisterDevice(status: status)
        } else {
             let decoder = JSONDecoder()
            modalObject = try! decoder.decode(RegisterDeviceModel.self, from: data!)
            DispatchQueue.main.async {
                
                if self.modalObject != nil {
                    self.saveGetSpeciesData(dataModel: self.modalObject!)
                }
                
                self.completion()
            }
        }
    }
}

