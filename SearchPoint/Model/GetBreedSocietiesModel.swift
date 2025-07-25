//
//  GetBreedSocietiesModel.swift
//  SearchPoint
//
//  Created by "" on 12/03/20.
//

import Foundation

//struct GetBreedSocietiesModel :Codable{
//
//     let breedAssociations: [GetBreedsModelBreedAssociation]
//        let responseCode: Int
//        let errorDetail, message: String
//    }
//
//    // MARK: - GetBreedsModelBreedAssociation
//    struct GetBreedsModelBreedAssociation: Codable {
//        let productID: Int
//        let product: String
//        let breedAssociations: [BreedAssociationBreedAssociation]
//        let lastUpdated: String
//
//        enum CodingKeys: String, CodingKey {
//            case productID = keyValue.smallProductId.rawValue
//            case product, breedAssociations, lastUpdated
//        }
//    }
//
//    // MARK: - BreedAssociationBreedAssociation
//    struct BreedAssociationBreedAssociation: Codable {
//        let associationID, association: String
//        let sequenceID: Int
//
//        enum CodingKeys: String, CodingKey {
//            case associationID = "associationId"
//            case association
//            case sequenceID = "sequenceId"
//        }
//    }




// MARK: - Welcome
struct GetBreedSocietiesModel: Codable {
    let breedAssociations: [WelcomeBreedAssociation]
    let responseCode: Int?
    let errorDetail, message: String?
}

// MARK: - WelcomeBreedAssociation
struct WelcomeBreedAssociation: Codable {
    let productID: Int?
    let product: String?
    let breedAssociations: [BreedAssociationBreedAssociation]
    let lastUpdated: String?

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case product, breedAssociations, lastUpdated
    }
}

// MARK: - BreedAssociationBreedAssociation
struct BreedAssociationBreedAssociation: Codable {
    let associationID, association: String?
    let sequenceID: Int?

    enum CodingKeys: String, CodingKey {
        case associationID = "associationId"
        case association
        case sequenceID = "sequenceId"
    }
}
