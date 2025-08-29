//
//  EmailListModel.swift
//  SearchPoint
//
//  Created by Mobile Programming on 27/01/21.
//

import Foundation


// MARK: - AnimalDeleteListModel
struct EmailListModel: Codable {
    var customerId: Int?
    var listName: String?
    var emailAddresses = [String]()

  
}
