//
//  AnimalByCustomer.swift
//  SearchPoint
//
//  Created by "" 13/06/20.
//

import Foundation

// MARK: - Empty
struct AnimalByCustomer: Codable {
    let customerID, startIndex, requestedCount, totalAnimals: Int?
    let retrievedAnimalCount: Int?
    let animals: [AnimalC]
    let responseCode: Int?
    let errorDetail, message: String?

    enum CodingKeys: String, CodingKey {
        case customerID = "customerId"
        case startIndex, requestedCount, totalAnimals, retrievedAnimalCount, animals, responseCode, errorDetail, message
    }
}

// MARK: - Animal
struct AnimalC: Codable {
    let onFarmID, officialID, earTag, sex,tissueName: String?
    var species, breed, speciesID, breedID: String?
    let animalName, dob, sireID, sireNAAB, mbc: String?
    let damID,breedRegistrationNumber, lastUpdated: String?
    let bornTypeID: Int?
   let isHausaHerdBook: Bool?
    
    enum CodingKeys: String, CodingKey {
        case onFarmID, officialID, earTag, sex, species, breed, tissueName
        case speciesID = "speciesId"
        case breedID = "breedId"
        case animalName, dob, sireID, sireNAAB, damID, lastUpdated, mbc,breedRegistrationNumber
        case bornTypeID = "bornTypeId"
        case isHausaHerdBook = "isHausaHerdBook"
    }
}

