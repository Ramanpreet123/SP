//
//  ActionRequiredModel.swift
//  SearchPoint
//
//  Created by "" on 11/05/20.
//



import Foundation

// MARK: - Production
//struct ActionRequiredModel: Codable {
//    let conflictsCount, pastDays: Int
//    let conflicts: [ConflictAction]
//    let responseCode: Int
//    let errorDetail, message: String
//}
//
//// MARK: - Conflict
//struct ConflictAction: Codable {
//    let customerID: String
//    let customerName: String?
//    let orderID, orderedDate, receivedDate: String
//    let reportedDate: String?
//    let product, sampleBarCode: String
//    let sampleStatusID: Int
//    let sampleStatus: String
//    let actionRequired: [ActionRequiredA]
//    let onFarmID: String
//    let officialTag: JSONNull?
//    let earTag: String
//    let officialPermanentID: JSONNull?
//    let speciesID: String
//    let species: String
//    let sampleTrackingLabels: [SampleTrackingLabelp]
//
//    enum CodingKeys: String, CodingKey {
//        case customerID = keyValue.customerId.rawValue
//        case customerName
//        case orderID = keyValue.orderId.rawValue
//        case orderedDate, receivedDate, reportedDate, product, sampleBarCode
//        case sampleStatusID = "sampleStatusId"
//        case sampleStatus, actionRequired
//        case onFarmID = "onFarmId"
//        case officialTag, earTag
//        case officialPermanentID = "officialPermanentId"
//        case speciesID = "speciesId"
//        case species, sampleTrackingLabels
//    }
//}
//
//// MARK: - ActionRequired
//struct ActionRequiredA: Codable {
//    let action: String?
//}
//
//
//
//// MARK: - SampleTrackingLabel
//struct SampleTrackingLabelp: Codable {
//    let onFarmID: String?
//    let officialID: String?
//    let breedRegNumber: String?
//
//    enum CodingKeys: String, CodingKey {
//        case onFarmID = "onFarmId"
//        case officialID = "officialId"
//        case breedRegNumber
//    }
//}

/* UAT*/

struct ActionRequiredModel: Codable {

    let conflictsCount, pastDays: Int?
    let conflicts: [ConflictAction]
    let responseCode: Int?
    let errorDetail, message: String?
}

// MARK: - Conflict
struct ConflictAction: Codable {
    let customerID: String?
    let customerName: String?
    let orderID: String?
    let orderedDate: String?
    let receivedDate: String?
    let reportedDate: String?
    let product: String?
    let sampleBarCode: String?
    let sampleStatusID: Int?
    let sampleStatus: String?
    let actionRequired: [ActionRequiredAction]
    let onFarmID :String?
    let  officialTag :String?
    let earTag :String?
    let officialPermanentID: String?
    let speciesID: String?
    let species: String?
    let sampleTrackingLabels: [SampleTrackingLabelAction]

    enum CodingKeys: String, CodingKey {
        case customerID = "customerId"
        case customerName
        case orderID = "orderId"
        case orderedDate, receivedDate, reportedDate, product, sampleBarCode
        case sampleStatusID = "sampleStatusId"
        case sampleStatus, actionRequired
        case onFarmID = "onFarmId"
        case officialTag, earTag
        case officialPermanentID = "officialPermanentId"
        case speciesID = "speciesId"
        case species, sampleTrackingLabels
    }
}

// MARK: - ActionRequired
struct ActionRequiredAction: Codable {
    let action: String?
}



// MARK: - SampleTrackingLabel
struct SampleTrackingLabelAction: Codable {
    let onFarmID: String?
    let officialID: String?
    let breedRegNumber: String?

    enum CodingKeys: String, CodingKey {
        case onFarmID = "onFarmId"
        case officialID = "officialId"
        case breedRegNumber
    }
}






// MARK: - UAT

