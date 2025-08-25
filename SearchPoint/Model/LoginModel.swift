//
//  LoginModel.swift
//  SearchPoint
//
//  Created by "" on 07/10/2019.
//  ""
//

import Foundation

class LoginManager {
    static let shared = LoginManager()
    var dataModel:LoginScreenSetModel?
}

struct LoginModel:Codable {
    var authorizationToken :String?
    var mustRegisterDevice :Bool?
    var marketCode :String?
    var agreedToTermsOfService :Bool?
    var responseCode: Int?
    var errorDetail :String?
    var message :String?
    var UserId: String?
    var firstName:String?
    var lastName :String?
    var alert :String?
    var mustValidateDevice :Bool?
    var uid :String?
    var signatureTimestamp: String?
    var uidSignature:String?
}

struct LoginScreenSetModel:Codable {
    var authorizationToken :String?
    var mustRegisterDevice :Bool?
    var marketCode :String?
    var agreedToTermsOfService :Bool?
    var responseCode: Int?
    var errorDetail :String?
    var message :String?
    var UserId: String?
    var firstName:String?
    var lastName :String?
    var alert :String?
    var mustValidateDevice :Bool?
    var uid :String?
    var signatureTimestamp: String?
    var uidSignature:String?
}

