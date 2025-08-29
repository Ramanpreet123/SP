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


}
