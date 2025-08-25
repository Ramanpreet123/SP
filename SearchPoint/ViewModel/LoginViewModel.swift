//
//  LoginVC.swift
//  SearchPoint
//
//  Created by "" on 30/09/2019.
//  ""
//

import UIKit
import Alamofire
import CoreData
import CommonCrypto

protocol ResponseLoginApi {
    func responseRecievedStatus(status:Bool)
    func responseRecievedStatusForLoginDevice(status:Bool, response : LoginModel?)
    
}
class  LoginViewModel{
    var dependency:LoginViewController?
    var modalObject:LoginModel?
    var delegate1:ResponseLoginApi?
    
    /********** Creating Closure**********/
    var completion:()->()?
    init(ref:LoginViewController,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    /******Email & Password validation ******************/
    
    func isValidEmail(email1: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email1)
    }
    
    
    func validatePwd(strPwd: String?,controller: UIViewController) {
        
        let length: Int = strPwd?.count ?? 0
        if length >= 8{
            
            Login()
        } else {
            delegate1!.responseRecievedStatus(status: false)
            
            let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString("Password is incorrect", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default))
            controller.present(alert, animated: true, completion: nil)
            
        }
    }
    /*********************************************************************************/
    
    private func Login(){
        
        let Network = NetworkManager()
        Network.delegate = self
        let headerDict :[String:String] = ["Authorization":"BEARER" + " " + "ea4369e9-d4a9-4322-856b-5323e21ff351"]
        
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.post,Headers: headerDict, bodyParams: getParams(), Url: Configuration.Dev(packet: ApiKeys.login.rawValue).getUrl()))
        
    }
    
    private func getParams()->[String:Any]{
        let email = dependency?.emailTextField.text! ?? ""
        let password = dependency?.pwdTextField.text! ?? ""
        let key256   = "559dfef3f987dbdaedf6f3c53363d096"
        let iv       = "abcdefghijklmnop".bytes
        let aes256 = AES(key: key256, iv: String(decoding: iv, as: UTF8.self))
        let encryptedPassword256 = aes256?.encrypt(string: password)
        var newArrayPassword = Array<Any>()
        
        
        for value in iv {
            print(value)
            newArrayPassword.append(value)
        }
        
        for value in encryptedPassword256! {
            print(value)
            newArrayPassword.append(value)
        }
        
        // "password":password ,
        return ["appId":"\(appID)",
                "email":email,
                "deviceId": UserDefaults.standard.value(forKey: "DeviceId") as! String,"pushToken":(UserDefaults.standard.value(forKey: "pushToken") as? String) ?? "","language":"EN", "decryptionRequired" : true, "passwordEncrypted" : newArrayPassword]
        
    }
    
    
    func saveLoginDat(dataModel:LoginModel){
        
        let accessToken =  dataModel.authorizationToken
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        //appDelegate?.keychain_setObject(accessToken! as AnyObject, forKey: "accessToken")
        UserDefaults.standard.set(accessToken, forKey: "accessToken")
        
        deleteRecordFromDatabase(entityName: "GetCustomer")
        deleteRecordFromDatabase(entityName: Entities.customerMarketsTblEntity)
        
        UserDefaults.standard.set(dependency?.emailTextField.text!, forKey: "userName")
        UserDefaults.standard.set(dependency?.pwdTextField.text!, forKey: "password")
        UserDefaults.standard.synchronize()
        
        
        appDelegate?.keychainSetObject(dependency?.emailTextField.text! as AnyObject, forKey: "userName")
        appDelegate?.keychainSetObject(dependency?.pwdTextField.text! as AnyObject, forKey: "password")
        
        //UserDefaults.standard.set(dependency?.emailTextField.text!, forKey: "userName")
        //UserDefaults.standard.set(dependency?.pwdTextField.text!, forKey: "password")
        
        let user = fetchUser(entityName: "OrderUserId", email: dependency?.emailTextField.text?.lowercased() ?? "") as! [OrderUserId]
        
        if user.count > 0 {
            let userId = user[0].userId
            UserDefaults.standard.set(userId, forKey: keyValue.userId.rawValue)
        } else {
            let allUser = fetchAllUser(entityName: "OrderUserId") as! [OrderUserId]
            
            if let lastUser = allUser.last {
                let lastUserId = lastUser.userId + 1
                let saveObject : [String:Any] = ["email": dependency?.emailTextField.text!.lowercased() ?? "",
                                                 keyValue.userId.rawValue: lastUserId]
                insert(entity: "OrderUserId", attributeKey: nil, objectToSave: saveObject)
                
                UserDefaults.standard.set(lastUserId, forKey: keyValue.userId.rawValue)
                
            } else {
                
                let saveObject : [String:Any] = ["email": dependency?.emailTextField.text!.lowercased() ?? "",
                                                 keyValue.userId.rawValue: 1]
                insert(entity: "OrderUserId", attributeKey: nil, objectToSave: saveObject)
                UserDefaults.standard.set(1, forKey: keyValue.userId.rawValue)
            }
        }
        
        UserDefaults.standard.set(dataModel.firstName, forKey: "FirstName")
        UserDefaults.standard.set(dataModel.marketCode, forKey: "marketCode")
        UserDefaults.standard.set(dataModel.mustValidateDevice, forKey: "mustValidateDevice")
        UserDefaults.standard.set(dataModel.mustRegisterDevice, forKey: "mustRegisterDevice")
        UserDefaults.standard.set(dataModel.agreedToTermsOfService, forKey: "Terms")
        UserDefaults.standard.set(dataModel.alert, forKey: AlertMessagesStrings.alertString)
        let saveObject : [String:Any] = ["agreedToTermsOfService":dataModel.agreedToTermsOfService as Any , "errorDetail":dataModel.errorDetail as Any , "marketCode":dataModel.marketCode as Any,"message":"","authorizationToken":dataModel.authorizationToken as Any,keyValue.userId.rawValue:"1","mustValidateDevice":dataModel.mustValidateDevice as Any,"alert":dataModel.alert as Any]
        
        insert(entity: "LoginTbl", attributeKey: nil, objectToSave: saveObject)
        // dependency?.callmethod()
        
    }
}


extension LoginViewModel:ResponseDelegate{
    func responseRecieved(_ data: Data?, status: Bool) {
        if !status {
            delegate1!.responseRecievedStatus(status: status)
        }
        else{
            let decoder = JSONDecoder()
            modalObject = try! decoder.decode(LoginModel.self, from: data!)
            
            let errorDetail = modalObject?.errorDetail
            let token = modalObject?.authorizationToken
            
            if errorDetail == "Invalid Credentials" ||
               errorDetail == "INVALID_CREDENTIALS" ||
               errorDetail == "invalid loginID or password" ||
               errorDetail == "INVALID LOGINID OR PASSWORD" ||
               token == nil ||
               token == "" {

                delegate1?.responseRecievedStatusForLoginDevice(status: status, response: modalObject)
                return
            }
            
            if modalObject != nil {
                
                saveLoginDat(dataModel: modalObject!)
            }
            
            completion()
        }
    }
}


struct AES {
    
    // MARK: - Value
    // MARK: Private
    private var key = "559dfef3f987dbdaedf6f3c53363d096".data(using: .ascii)!
    private var iv = "SuperSecretPasswordasdfasdfadsfasdfasdfadfasdfadfasdfaIOINVOIUTWYPPO&D".data(using: .ascii)!
    
    
    // MARK: - Initialzier
    init?(key: String, iv: String) {
        guard key.count == kCCKeySizeAES128 || key.count == kCCKeySizeAES256, let keyData = key.data(using: .utf8) else {
            debugPrint("Error: Failed to set a key.")
            return nil
        }
        
        guard iv.count == kCCBlockSizeAES128, let ivData = iv.data(using: .utf8) else {
            debugPrint("Error: Failed to set an initial vector.")
            return nil
        }
        
        
        self.key = keyData
        self.iv  = ivData
    }
    
    
    // MARK: - Function
    // MARK: Public
    func encrypt(string: String) -> Data? {
        return crypt(data: string.data(using: .utf8), option: CCOperation(kCCEncrypt))
    }
    
    func decrypt(data: Data?) -> String? {
        guard let decryptedData = crypt(data: data, option: CCOperation(kCCDecrypt)) else { return nil }
        return String(bytes: decryptedData, encoding: .utf8)
    }
    
    func crypt(data: Data?, option: CCOperation) -> Data? {
        guard let data = data else { return nil }
        
        let cryptLength = data.count + key.count
        var cryptData   = Data(count: cryptLength)
        
        var bytesLength = Int(0)
        
        let status = cryptData.withUnsafeMutableBytes { cryptBytes in
            data.withUnsafeBytes { dataBytes in
                iv.withUnsafeBytes { ivBytes in
                    key.withUnsafeBytes { keyBytes in
                        CCCrypt(option, CCAlgorithm(kCCAlgorithmAES), CCOptions(kCCOptionPKCS7Padding), keyBytes.baseAddress, key.count, ivBytes.baseAddress, dataBytes.baseAddress, data.count, cryptBytes.baseAddress, cryptLength, &bytesLength)
                        
                    }
                }
            }
        }
        
        guard Int32(status) == Int32(kCCSuccess) else {
            debugPrint("Error: Failed to crypt data. Status \(status)")
            return nil
        }
        
        cryptData.removeSubrange(bytesLength..<cryptData.count)
        var cipherStream = Data()
        // cipherStream.append(iv)
        cipherStream.append(cryptData)
        return cipherStream
    }
    
}


extension StringProtocol {
    var data: Data { .init(utf8) }
    var bytes: [UInt8] { .init(utf8) }
}
