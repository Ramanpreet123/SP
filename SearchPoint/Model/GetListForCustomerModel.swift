//
//  GetListForCustomerModel.swift
//  SearchPoint
//
//  Created by Mobile Programming on 27/01/21.
//

import Foundation
struct GetListForCustomerModel: Codable {
    var responseCode: Int?
    var errorDetail, message: String?
    var animalLists: [AnimalList]
}

// MARK: - AnimalList
struct AnimalList: Codable {
    var customerID: Int?
    var customerName, listName, animalListDescription,status, globalDeviceId, speciesID: String?
    var providerID, productID: Int?
    var animals: [AnimalGetList]

    enum CodingKeys: String, CodingKey {
        case customerID = "customerId"
        case customerName, listName
        case animalListDescription = "description"
        case speciesID = "speciesId"
        case providerID = "providerId"
        case productID = "productId"
        case status = "status"
        case globalDeviceId = "globalDeviceId"
        case animals
    }
}

// MARK: - Animal
struct AnimalGetList: Codable {
    var deviceAnimalID:Int?
    var animalID, onFarmID, officialTag, sampleBarCode: String?
    var speciesID, breedID: String?
    var sampleTypeId: Int?
    var sex: String?
    var bornTypeID: Int?
    var nationalHerdID, animalSireID, dob, officialSireID: String?
    var officialDamID, earTag, animalTag, breedRegNumber: String?
    var breedAssociationID, animalName, sireRegNumber, sireAssociationID: String?
    var damRegNumber, damAssociationID, sireID, sireNAAB: String?
    var damID, mbc, breedRegistrationNumber: String?
    var sireYOB: Int?
    var animalDamID: String?
    var damYOB: Int?
    var series, rgd, rgn, primaryPriorityProgramID: String?
    var secondaryPriorityProgramID, teriarityProgramID: String?

    enum CodingKeys: String, CodingKey {
        case animalID, onFarmID, officialTag, sampleBarCode
        case speciesID = "speciesId"
        case breedID = "breedId"
        case sampleTypeId = "sampleTypeId"
        case sex
        case bornTypeID = "bornTypeId"
        case nationalHerdID = "nationalHerdId"
        case animalSireID = "sireId"
        case dob
        case officialSireID = "officialSireId"
        case officialDamID = "officialDamId"
        case earTag, animalTag, breedRegNumber
        case breedAssociationID = "breedAssociationId"
        case animalName, sireRegNumber
        case sireAssociationID = "sireAssociationId"
        case damRegNumber
        case damAssociationID = "damAssociationId"
        case sireID, sireNAAB, damID, mbc, breedRegistrationNumber, sireYOB
        case animalDamID = "damId"
        case damYOB, series, rgd, rgn
        case primaryPriorityProgramID = "primaryPriorityProgramId"
        case secondaryPriorityProgramID = "secondaryPriorityProgramId"
        case teriarityProgramID = "tertiaryPriorityProgramId"
    }
}
