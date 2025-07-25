//
//  EmailGroupModel.swift
//  SearchPoint
//
//  Created by Mobile Programming on 19/05/21.
//

import Foundation


struct EmailGroupModel: Codable {
    
    var customerId: Int?
    var groupName: String?
    var emailAddresses = [String]()

    init() {
        
    }
}
