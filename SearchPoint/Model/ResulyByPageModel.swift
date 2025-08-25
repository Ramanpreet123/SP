//
//  ResulyByPageModel.swift
//  SearchPoint
//
//  Created by Mobile Programming on 21/05/21.
//

import Foundation

//struct ResulyByPageModel: Codable {
//    let customerName, customerID: String?
//    let animalCount: Int?
//    let animals: [AnimalPage]
//    let responseCode: Int?
//    let errorDetail, message: String?
//
//    enum CodingKeys: String, CodingKey {
//        case customerName
//        case customerID = keyValue.customerId.rawValue
//        case animalCount, animals, responseCode, errorDetail, message
//    }
//}
//
//// MARK: - Animal
//struct AnimalPage: Codable {
//    let reportedDate, animalID, onFarmID, officialID: String?
//    let dob: String?
//    let sex: String?
//    let name, breedID: String?
//    let breed: String?
//    let orderNumber: String?
//    let products: String?
//    let sampleBarCode: String?
//    let sampleStatus:  String?
//    let notes:  String?
//    let groupIDS: [String]
//    let traitValues: [TraitValue]
//
//    enum CodingKeys: String, CodingKey {
//        case reportedDate
//        case animalID = keyValue.animalId.rawValue
//        case onFarmID = "onFarmId"
//        case officialID = "officialId"
//        case dob, sex, name
//        case breedID = keyValue.breedId.rawValue
//        case breed, orderNumber, products, sampleBarCode, sampleStatus, notes
//        case groupIDS = "groupIds"
//        case traitValues
//    }
//}
//
//// MARK: - TraitValue
//struct TraitValue: Codable {
//    let traitID: String?
//    let trait:  String?
//    let numericValue:  String?
//    let stringValue:  String?
//    let date: String?
//
//    enum CodingKeys: String, CodingKey {
//        case traitID = "traitId"
//        case trait, numericValue, stringValue, date
//    }
//}
//
//



///////// Nw

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let resulyByPageModel = try? newJSONDecoder().decode(ResulyByPageModel.self, from: jsonData)

import Foundation

// MARK: - ResulyByPageModel
struct ResulyByPageModel: Codable {
    let customerName: String?
    let animalCount,customerID: Int?
    let animals: [AnimalPage]
    let responseCode: Int?
    let errorDetail, message: String?

    enum CodingKeys: String, CodingKey {
        case customerName
        case customerID = "customerId"
        case animalCount, animals, responseCode, errorDetail, message
    }
}

// MARK: - Animal
struct AnimalPage: Codable {
    let reportedDate, animalID, onFarmID, officialID, resultType: String?
    let dob: String?
    let sex: String?
    let name,sireID,breedID: String?
    let damID, mgsID,breed: String?
    let orderDate,orderNumber: String?
    let products: String?
    let sampleBarCode: String
    let sampleStatus: String?
    let notes: String?
    let groupIDS: [String]
    let traitValues: [TraitValue]

    enum CodingKeys: String, CodingKey {
        case reportedDate
        case animalID = "animalId"
        case onFarmID = "onFarmId"
        case officialID = "officialId"
        case dob, sex, name
        case sireID = "sireId"
        case damID = "damId"
        case mgsID = "mgsId"
        case breedID = "breedId"
        case breed, orderNumber,orderDate,products, sampleBarCode, sampleStatus, notes
        case groupIDS = "groupIds"
        case traitValues
        case resultType
    }
}



// MARK: - TraitValue
struct TraitValue: Codable {
    let traitID, display, trait: String
    let numericValue: Double?
    let numericFormat,stringValue: String?
    let date: String?

    enum CodingKeys: String, CodingKey {
        case traitID = "traitId"
        case trait, display, numericValue, numericFormat, stringValue, date
    }
}
