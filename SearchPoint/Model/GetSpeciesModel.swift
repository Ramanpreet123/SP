//
//  GetSpeciesModel.swift
//  SearchPoint
//
//  Created by "" on 10/10/2019.
//  ""
//

import Foundation

// MARK: - Welcome
struct GetSpeciesModel: Codable {
    let species: [Species]
    let responseCode: Int?
    let errorDetail, message: String?
}

// MARK: - Species
struct Species: Codable {
    let speciesID, name: String?
    let isDefault: Bool?
    let lastUpdated: JSONNull?

    enum CodingKeys: String, CodingKey {
        case speciesID = "speciesId"
        case name, isDefault, lastUpdated
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
