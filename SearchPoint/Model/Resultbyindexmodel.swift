////
////  Resultbyindexmodel.swift
////  SearchPoint
////
////  Created by Yamini Sunkara on 1/5/22.
////
//
//import Foundation
//
//// MARK: - Welcome
//struct Resultbyindexmodel: Codable {
//    let responseCode: Int
//    let errorDetail, message, customerName: String
//    let customerID, animalCount: Int
//    let animals: [Animal]
//
//    enum CodingKeys: String, CodingKey {
//        case responseCode, errorDetail, message, customerName
//        case customerID = keyValue.customerId.rawValue
//        case animalCount, animals
//    }
//}
//
//// MARK: - Animal
//struct Animal: Codable {
//    let reportedDate, animalID, onFarmID, officialID: String
//    let dob, sex, name, sireID: String
//    let damID, mgsID, breedID, breed: String
//    let orderNumber, orderDate, products, sampleBarCode: String
//    let sampleStatus, notes: String
//    let groupIDS: [String]
//    let traitValues: [TraitValue]
//
//    enum CodingKeys: String, CodingKey {
//        case reportedDate
//        case animalID = keyValue.animalId.rawValue
//        case onFarmID = "onFarmId"
//        case officialID = "officialId"
//        case dob, sex, name
//        case sireID = "sireId"
//        case damID = "damId"
//        case mgsID = "mgsId"
//        case breedID = keyValue.breedId.rawValue
//        case breed, orderNumber, orderDate, products, sampleBarCode, sampleStatus, notes
//        case groupIDS = "groupIds"
//        case traitValues
//    }
//}
//
//// MARK: - TraitValue
//struct TraitValue: Codable {
//    let traitID, trait, display: String
//    let numericValue: Int
//    let numericFormat, stringValue, date: String
//
//    enum CodingKeys: String, CodingKey {
//        case traitID = "traitId"
//        case trait, display, numericValue, numericFormat, stringValue, date
//    }
//}
