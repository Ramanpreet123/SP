//
//  ContactSupportModel.swift
//  SearchPoint
//
//  Created by "" on 11/11/2019.
//  ""
//

import Foundation


//struct ContactSupportModel: Codable {
//      let Country :String
//      let Email :String
//      let Phone :String
//      let HoursOfOperation :String
//
//}

// MARK: - WelcomeElement
struct ContactSupportModel: Codable {
    let text,market, email, phone, hours: String?
}

typealias ContactSupport = [ContactSupportModel]
