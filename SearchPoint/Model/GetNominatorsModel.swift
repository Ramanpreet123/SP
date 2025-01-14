//
//  GetNominators.swift
//  SearchPoint
//
//  Created by "" on 10/10/2019.
//  ""
//

import Foundation
//
//struct GetNominatorsModel: Codable {
//    let nominators: [Nominator]
//    let responseCode: Int
//    let errorDetail, message: String
//}
//
//// MARK: - Nominator
//struct Nominator: Codable {
//    let nominatorID: Int
//    let nominator: String
//    let isDefault: Bool
//    let providerID: Int
//    let provider: String
//    let providerGroupID: Int
//    let providerGroup, lastUpdated: String
//}

// MARK: - Welcome
struct GetNominatorsModel: Codable {
    let nominators: [Nominator]
    let responseCode: Int?
    let errorDetail, message: String?
}

// MARK: - Nominator
struct Nominator: Codable {
    let nominatorID: Int?
    let nominator: String?
    let isDefault: Bool?
    let providerID: Int?
    let provider: String?
    let providerGroupID: Int?
    let providerGroup, lastUpdated: String?

    enum CodingKeys: String, CodingKey {
        case nominatorID = "nominatorId"
        case nominator, isDefault
        case providerID = "providerId"
        case provider
        case providerGroupID = "providerGroupId"
        case providerGroup, lastUpdated
    }
}
