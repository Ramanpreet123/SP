//
//  GetCountryCodeModel.swift
//  SearchPoint
//
//  Created by "" on 05/03/20.
//

import Foundation
//struct GetCountryCodeModel :Codable{
//
//    let AlphaCode :String
//    let CountryName :String
//    let NumericCode :Int
//
//}

// MARK: - Welcome
struct GetCountryCodeModel: Codable {
    let countryCodes: [CountryCode]
    let responseCode: Int
    let errorDetail, message: String?
}

// MARK: - CountryCode
struct CountryCode: Codable {
    let countryID: Int
    let countryName, alpha2, alpha3, lastUpdated , marketId: String?

    enum CodingKeys: String, CodingKey {
        case countryID = "countryId"
        case countryName, alpha2, alpha3, lastUpdated ,marketId
    }
}
