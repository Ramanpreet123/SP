//
//  GetNaabCodeModel.swift
//  SearchPoint
//
//  Created by "" on 05/03/20.
//

import Foundation
//struct GetNaabCodeModel :Codable{
//
//    let NaabCode :String
//    let AnimalId :String
//
//}

// MARK: - Welcome
struct GetNaabCodeModel: Codable {
    let naabCodes: [NaabCode]
    let responseCode: Int?
    let errorDetail, message: String?
}

// MARK: - NaabCode
struct NaabCode: Codable {
    let naabCode, animalID, lastUpdated: String?

    enum CodingKeys: String, CodingKey {
        case naabCode
        case animalID = "animalId"
        case lastUpdated
    }
}
