//
//  LoginScreenSetViewModel.swift
//  SearchPoint
//
//  Created by Mobile Programming on 27/09/24.
//

import Foundation
import UIKit
import Alamofire
import CoreData
import CommonCrypto
import JavaScriptCore

protocol LoginScreenSetApiResponse: class {
    func responseRecievedForLoginScreenSet(status:Bool)
    func showAlertMessage(message: String)
}

class  LoginScreenSetViewModel{
    
    var dependency:LoginViewController?
    var modalObject:LoginScreenSetModel?
    var delegate1:ResponseLoginApi?
    weak var delegate: LoginScreenSetApiResponse?
    
    /********** Creating Closure**********/
    var completion:()->()?
    init(ref:LoginViewController,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    
    func LoginScreenSet(uid: String, uidSignature: String, signatureTimestamp: String, email: String){
        
        let Network = NetworkManager()
        Network.delegate = self
        let headerDict :[String:String] = ["Authorization":"BEARER" + " " + "ea4369e9-d4a9-4322-856b-5323e21ff351"]
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.post,Headers: headerDict, bodyParams:getParamsForSCreenSet(uid: uid, uidSignature: uidSignature, signatureTimestamp: signatureTimestamp, email: email), Url: Configuration.Dev(packet: ApiKeys.loginScreenSet.rawValue).getUrl()))
    }
    
    func getParamsForSCreenSet(uid:String, uidSignature:String, signatureTimestamp: String, email: String)-> [String:Any] {
        return ["appId":"\(appID)",
                "email":email,
                "deviceId": UserDefaults.standard.value(forKey: "DeviceId") as! String,"language":"EN", "uid":uid, "signatureTimestamp":signatureTimestamp, "uidSignature":uidSignature]
    }
}


extension LoginScreenSetViewModel:ResponseDelegate{
    
    func responseRecieved(_ data: Data?, status: Bool) {
        if !status {
            delegate!.responseRecievedForLoginScreenSet(status: status)
        }
        else{
            let decoder = JSONDecoder()
            modalObject = try! decoder.decode(LoginScreenSetModel.self, from: data!)
            
            
            if modalObject != nil {
                if modalObject?.responseCode == 0 {
                    self.saveLoginScreenSetData(dataModel: modalObject!)
                    completion()
                }
                else {
                    delegate?.showAlertMessage(message: modalObject?.errorDetail ?? "")
                    completion()
                }
            }
        }
    }
    
    func saveLoginScreenSetData(dataModel:LoginScreenSetModel){
        print(dataModel)
        let accessToken =  dataModel.authorizationToken
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        print("ACCESS TOKEN : \(accessToken ?? "")")
        UserDefaults.standard.setValue(accessToken! as AnyObject, forKey: "accessToken")
        
        deleteRecordFromDatabase(entityName: "GetCustomer")
        deleteRecordFromDatabase(entityName: "CustomerMarkets")
        let email = UserDefaults.standard.value(forKey: "GigyaEmail") as? String
        
        UserDefaults.standard.set(email, forKey: "userName")
        UserDefaults.standard.set("", forKey: "password")
        UserDefaults.standard.synchronize()
        
        appDelegate?.keychainSetObject(email as AnyObject, forKey: "userName")
        appDelegate?.keychainSetObject("" as AnyObject, forKey: "password")
        
        let user = fetchUser(entityName: "OrderUserId", email: email ?? "") as! [OrderUserId]
        
        if user.count > 0 {
            let userId = user[0].userId
            UserDefaults.standard.set(userId, forKey: "userId")
        } else {
            let allUser = fetchAllUser(entityName: "OrderUserId") as! [OrderUserId]
            
            if let lastUser = allUser.last {
                let lastUserId = lastUser.userId + 1
                let saveObject : [String:Any] = ["email": email ?? "",
                                                 "userId": lastUserId]
                insert(entity: "OrderUserId", attributeKey: nil, objectToSave: saveObject)
                
                UserDefaults.standard.set(lastUserId, forKey: "userId")
                
            } else {
                
                let saveObject : [String:Any] = ["email": email ?? "",
                                                 "userId": 1]
                insert(entity: "OrderUserId", attributeKey: nil, objectToSave: saveObject)
                UserDefaults.standard.set(1, forKey: "userId")
            }
        }
        
        UserDefaults.standard.set(dataModel.firstName, forKey: "FirstName")
        UserDefaults.standard.set(dataModel.marketCode, forKey: "marketCode")
        UserDefaults.standard.set(dataModel.mustValidateDevice, forKey: "mustValidateDevice")
        UserDefaults.standard.set(dataModel.mustRegisterDevice, forKey: "mustRegisterDevice")
        UserDefaults.standard.set(dataModel.agreedToTermsOfService, forKey: "Terms")
        UserDefaults.standard.set(dataModel.alert, forKey: "Alert")
        let saveObject : [String:Any] = ["agreedToTermsOfService":dataModel.agreedToTermsOfService , "errorDetail":dataModel.errorDetail , "marketCode":dataModel.marketCode,"message":"","authorizationToken":dataModel.authorizationToken,"userId":"1","mustValidateDevice":dataModel.mustValidateDevice,"alert":dataModel.alert]
        
        insert(entity: "LoginTbl", attributeKey: nil, objectToSave: saveObject)
    }
}
