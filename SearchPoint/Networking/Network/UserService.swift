//
//  LoginAPIManager.swift
//  iOSArchitecture
//
//  Created by Amit on 23/02/18.
//  Copyright © 2018 smartData. All rights reserved.
//

import Foundation
import UIKit

protocol UserServiceProtocol {
    func doLogin(email: String, password: String, completion:@escaping (Result<Any>) -> Void)
 
}

public class UserService: APIService, UserServiceProtocol {
   
    func doLogin(email: String, password: String, completion: @escaping (Result<Any>) -> Void) {
//        guard let fcmToken = UserDefaults.standard.value(forKey: "FCM_TOKEN") as? String else {
//            return
//        }
/*        let param = [Keys.email: email, Keys.password: password, "device_token": fcmToken, "platform": 2] as [String : Any]
           let serviceConfig: Service.config = (.POST, Config.login, false)
           super.startService(config: serviceConfig, parameters: param, files: nil, modelType: UserBase.self) { (result) in
               DispatchQueue.main.async {
                   switch result {
                   case .success(let data):
                       if let userModel = data {
                           // Parse Here
                        completion(.success(userModel))
                       }
                   case .error(let message):
                        completion(.error(message))
                    case .customError(let errorModel):
                                      completion(.customError(errorModel))
                   }
               }
        } */
    }
    
}


