//
//  GetProviderModel.swift
//  SearchPoint
//
//  Created by "" on 10/10/2019.
//  ""
//

import Foundation
 

// MARK: - Empty
struct GetProviderModel: Codable {
    let providers: [ProviderE]
    let responseCode: Int
    let errorDetail, message: String
}

// MARK: - Provider
struct ProviderE: Codable {
    let providerID: Int?
    let provider: String?
    let providerGroupID: Int?
    let providerGroup: String?
    let isDefault: Bool?
    let species, speciesID: String?
    let markets: [MarketE]
    let lastUpdated: String?

    enum CodingKeys: String, CodingKey {
        case providerID = "providerId"
        case provider
        case providerGroupID = "providerGroupId"
        case providerGroup, isDefault, species
        case speciesID = "speciesId"
        case markets, lastUpdated
    }
}

// MARK: - Market
struct MarketE: Codable {
    let marketsID, name: String?
    let isDefault: Bool?
    enum CodingKeys: String, CodingKey {
        case marketsID = "marketsId"
        case name ,isDefault
    }
}
