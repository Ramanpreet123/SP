//
//  SaveListModel.swift
//  SearchPoint
//
//  Created by Mobile Programming on 27/01/21.
//

import Foundation
struct SaveListModel: Codable {
    var customerId: Int?
    var listName : String?
    var description : String?
    var speciesId: String?
    var providerId :Int?
    var productId: Int?
    var addAnimals = [Animal]()
    var updateAnimals = [Animal]()
    var deleteAnimals = [Animal]()

//    enum CodingKeys: String, CodingKey {
//        case customerID = keyValue.customerId.rawValue
//        case listName
//        case saveListDescription = "description"
//        case speciesID = "speciesId"
//        case providerID = keyValue.providerId.rawValue
//        case productID = keyValue.smallProductId.rawValue
//        case addAnimals, updateAnimals, deleteAnimals
//    }
     init() {
        
     }
}

// MARK: - Animal
struct Animal: Codable {
    var deviceAnimalID :Int?
    var animalID : String?
    var onFarmID : String?
    var officialTag : String?
    var sampleBarCode : String?
    var speciesId : String?
    var breedId: String?
    var sampleTypeId: Int?
    var sex: String?
    var bornTypeId: Int?
    var nationalHerdId: String?
    var sireId: String?
    var dob: String?
    var officialSireId : String?
    var officialDamId : String?
    var earTag : String?
    var animalTag : String?
    var breedRegNumber : String?
    var breedAssociationId : String?
    var animalName : String?
    var sireRegNumber : String?
    var sireAssociationId: String?
    var damRegNumber : String?
    var damAssociationId : String?
    var sireID : String?
    var sireNAAB: String?
    var damId: String?
    var mbc : String?
    var breedRegistrationNumber: String?
    var sireYOB: Int?
    var animalDamID: String?
    var damYOB: Int?
    var series : String?
    var rgd : String?
    var rgn : String?
    var primaryPriorityProgramId: String?
    var secondaryPriorityProgramId: String?
    var tertiaryPriorityProgramId: String?
    var uniqueId : String?

//    enum CodingKeys: String, CodingKey {
//        case animalID, onFarmID, officialTag, sampleBarCode
//        case speciesID = "speciesId"
//        case breedID = keyValue.breedId.rawValue
//        case sampleTypeID = "sampleTypeId"
//        case sex
//        case bornTypeID = "bornTypeId"
//        case nationalHerdID = "nationalHerdId"
//        case animalSireID = "sireId"
//        case dob
//        case officialSireID = "officialSireId"
//        case officialDamID = "officialDamId"
//        case earTag, animalTag, breedRegNumber
//        case breedAssociationID = "breedAssociationId"
//        case animalName, sireRegNumber
//        case sireAssociationID = "sireAssociationId"
//        case damRegNumber
//        case damAssociationID = "damAssociationId"
//        case sireID, sireNAAB, damID, mbc, breedRegistrationNumber, sireYOB
//        case animalDamID = "damId"
//        case damYOB, series, rgd, rgn
//        case primaryPriorityProgramID = "primaryPriorityProgramId"
//        case secondaryPriorityProgramID = "secondaryPriorityProgramId"
//    }
}
