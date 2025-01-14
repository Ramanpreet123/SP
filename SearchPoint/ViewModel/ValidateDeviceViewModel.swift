//
//  ValidateDeviceViewModel.swift
//  SearchPoint
//
//  Created by "" 29/04/20.
//

import Foundation
import Alamofire
import CoreData


class ValidateDeviceViewModel {
    
    var dependency: ValidateDeviceController?
    var modalObject: ValidateDeviceModel?
    weak var delegate: ResponseValidateDeviceApi?
    
    var completion:()->()?
    init(ref:ValidateDeviceController, callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    init(callBack:@escaping ()->()) {
          completion = callBack
      }
      
    func validateDevice(modelObj: LoginModel?, validationCode: String) {
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let bodyParm: [String: Any] = [
            "deviceId": UserDefaults.standard.value(forKey: "DeviceId") as! String,
            "validationCode": validationCode
        ]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.post, Headers: headerDict, bodyParams: bodyParm, Url: Configuration.Dev(packet: ApiKeys.validateDevice.rawValue).getUrl()))
    }
    
    func saveData(dataModel: ValidateDeviceModel) {
     
        UserDefaults.standard.set(dataModel.deviceID, forKey: "validateDeviceIDFromServer")
        UserDefaults.standard.set(true, forKey: keyValue.mustRegisterDevice.rawValue)
        UserDefaults.standard.synchronize()

    }
    
}

extension ValidateDeviceViewModel: ResponseDelegate {
    func responseRecieved(_ data: Data?, status: Bool) {
        if status == false {
            delegate?.responseRecievedStatusForValidateDevice(status: status, response: nil)
        } else {
            let decoder = JSONDecoder()
            modalObject = try! decoder.decode(ValidateDeviceModel.self, from: data!)
            
            if modalObject?.errorDetail == "Invalid Code" {
                delegate?.responseRecievedStatusForValidateDevice(status: status, response: modalObject)
                return
            }
            DispatchQueue.main.async {
                
                if self.modalObject != nil {
                    self.saveData(dataModel: self.modalObject!)
                }
                
                self.completion()
            }
        }
    }
}


