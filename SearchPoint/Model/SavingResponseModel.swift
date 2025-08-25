//
//  SavingResponseModel.swift
//  SearchPoint
//
//  Created by Mobile Programming on 01/02/21.
//

import Foundation
// MARK: - AnimalDevareListModel
struct SavingResponseModel: Codable {
    var responseCode: Int?
    var errorDetail, message: String?
    var customerList: CustomerList
}

// MARK: - CustomerList
struct CustomerList: Codable {
    var customerID: Int?
    var customerName, listName, customerListDescription, speciesID: String?
    var providerID, productID: Int?
    var animals: [AnimalResponse]

    enum CodingKeys: String, CodingKey {
        case customerID = "customerId"
        case customerName, listName
        case customerListDescription = "description"
        case speciesID = "speciesId"
        case providerID = "providerId"
        case productID = "productId"
        case animals
    }
}

// MARK: - Animal
struct AnimalResponse: Codable {
    var deviceAnimalID: Int?
    var animalID, onFarmID, officialTag, sampleBarCode: String?
    var speciesID, breedID: String?
    var sampvarypeID: Int?
    var sex: String?
    var bornTypeID: Int?
    var nationalHerdID, dob, officialSireID, officialDamID: String?
    var earTag, animalTag, breedRegNumber, breedAssociationID: String?
    var animalName, sireRegNumber, sireAssociationID, damRegNumber: String?
    var damAssociationID, sireID, sireNAAB, damID: String?
    var mbc, breedRegistrationNumber: String?
    var sireYOB, damYOB: Int?
    var series, rgd, rgn, primaryPriorityProgramID: String?
    var secondaryPriorityProgramID, tertiaryPriorityProgramId: String?

    enum CodingKeys: String, CodingKey {
        case deviceAnimalID, animalID, onFarmID, officialTag, sampleBarCode
        case speciesID = "speciesId"
        case breedID = "breedId"
        case sampvarypeID = "sampvarypeId"
        case sex
        case bornTypeID = "bornTypeId"
        case nationalHerdID = "nationalHerdId"
        case dob
        case officialSireID = "officialSireId"
        case officialDamID = "officialDamId"
        case earTag, animalTag, breedRegNumber
        case breedAssociationID = "breedAssociationId"
        case animalName, sireRegNumber
        case sireAssociationID = "sireAssociationId"
        case damRegNumber
        case damAssociationID = "damAssociationId"
        case sireID, sireNAAB, damID, mbc, breedRegistrationNumber, sireYOB, damYOB, series, rgd, rgn
        case primaryPriorityProgramID = "primaryPriorityProgramId"
        case secondaryPriorityProgramID = "secondaryPriorityProgramId"
        case tertiaryPriorityProgramId = "tertiaryPriorityProgramId"
    }
}
