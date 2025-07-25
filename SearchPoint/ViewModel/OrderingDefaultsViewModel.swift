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
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
       //let accessToken = appDelegate?.keychain_valueForKey(keyValue.accessToken.rawValue) as? String
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String

        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]

          let Network = NetworkManager()
          Network.delegate = self
          Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url: Configuration.Dev(packet: "SaveUserSetting/UserId=\(modelObj.UserId!)&CountryId=\(1)").getUrl()))
        }
        
//        private func getParams()->[String:Any]{
//            return ["grant_type":"password",
//                    "Username":dependency?.emailTextField.text! ?? "",
//                    "Password":dependency?.pwdTextField.text! ?? ""]
//        }
        
//        func saveLoginDat(dataModel:settingModal){
//
//            let saveObject : [String:Any] = ["countryId":dataModel.CountryId ?? 0, "roleId":dataModel.RoleId ?? 0, keyValue.userId.rawValue:dataModel.UserId!,keyValue.userName.rawValue:"dataModel","password":""]
//
//            insert(entity: Entities.LoginTblEntity, attributeKey: nil, objectToSave: saveObject)
//
//        }
    }


    extension OrderingDefaultsViewModel:ResponseDelegate{
        func responseRecieved(_ data: Data?, status: Bool) {
            let decoder = JSONDecoder()
            let modal = try? decoder.decode(LoginModel.self, from: data!)
           // saveLoginDat(dataModel: modal!)
            completion()
        }
    }
