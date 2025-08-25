//
//  AnimalDeleteListModel.swift
//  SearchPoint
//
//  Created by Mobile Programming on 27/01/21.
//

import Foundation

// MARK: - AnimalDeleteListModel
struct AnimalDeleteListModel: Codable {
    var customerID: Int?
    var listName: String?

    enum CodingKeys: String, CodingKey {
        case customerID = "customerId"
        case listName
    }
}
