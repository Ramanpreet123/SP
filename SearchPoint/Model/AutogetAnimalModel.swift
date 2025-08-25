//
//  AutogetAnimalModel.swift
//  SearchPoint
//
//  Created by Rajni Raswant on 15/10/24.
//


// MARK: - Empty
struct AutogetAnimalModel: Codable {
    let responseCode,customerId: Int?
    let errorDetail, message: String?
    let animals : [Animals]

    enum CodingKeys: String, CodingKey {
        case customerId = "customerId"
        case responseCode, errorDetail, message
       case animals
    }
}

// MARK: - Animal
struct Animals: Codable {
    let  officialId, earTag: String?
    
    enum CodingKeys: String, CodingKey {
        case officialId, earTag
    }
}
