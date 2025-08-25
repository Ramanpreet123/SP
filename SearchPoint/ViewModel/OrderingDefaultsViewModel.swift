//
//  SettingViewModel.swift
//  SearchPoint
//
//  Created by "" on 09/10/2019.
//  ""
//

import Foundation
import Alamofire
import CoreData

class  OrderingDefaultsViewModel{
var dependency:OrderingDefaultsVC?
 var completion:()->()?
    init(ref:OrderingDefaultsVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    
    func callSettingApi(modelObj:LoginModel){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String

        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]

          let Network = NetworkManager()
          Network.delegate = self
          Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url: Configuration.Dev(packet: "SaveUserSetting/UserId=\(modelObj.UserId!)&CountryId=\(1)").getUrl()))
        }
    }


    extension OrderingDefaultsViewModel:ResponseDelegate{
        func responseRecieved(_ data: Data?, status: Bool) {
            let decoder = JSONDecoder()
            completion()
        }
    }
