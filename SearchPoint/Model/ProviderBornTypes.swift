//
//  ProviderBornTypes.swift
//  SearchPoint
//
//  Created by "" 01/05/20.
//

import Foundation

// MARK: - Empty
struct ProviderBornTypes: Codable {
    let providerBornTypes: [ProviderBornType]
    let responseCode: Int?
    let errorDetail, message: String?
}

// MARK: - ProviderBornType
struct ProviderBornType: Codable {
    let providerID: Int?
    let provider: String?
    let bornTypes: [BornType]

    enum CodingKeys: String, CodingKey {
        case providerID = "providerId"
        case provider, bornTypes
    }
}

// MARK: - BornType
struct BornType: Codable {
    let bornTypeID: Int?
    let name, bornTypeCode, lastUpdated: String?

    enum CodingKeys: String, CodingKey {
        case bornTypeID = "bornTypeId"
        case name, bornTypeCode, lastUpdated
    }
}

