//
//  AnimalgroupsforcustomerLastUpdateDateModel.swift
//  SearchPoint
//
//  Created by Mobile Programming on 18/05/21.
//

import Foundation

// MARK: - AnimalGroupsForCustomerUpdateModel
struct AnimalGroupsForCustomerUpdateModel: Codable {
    let customerID: Int?
    let name: String?
    let groupCount: Int?
    let customerGroups: [AnimalCustomerGroup]
    let responseCode: Int?
    let errorDetail, message: String?

    enum CodingKeys: String, CodingKey {
        case customerID = "customerId"
        case name, groupCount, customerGroups, responseCode, errorDetail, message
    }
}

// MARK: - CustomerGroup
struct AnimalCustomerGroup: Codable {
    let groupID, groupName: String?
    let groupStatusID: Int?
    let groupStatus: String?
    let groupTypeID: Int?
    let groupType, createdDate, modifiedDate: String?
    let animalCount: Int?
    let animals: [AnimalGroup]

    enum CodingKeys: String, CodingKey {
        case groupID = "groupId"
        case groupName
        case groupStatusID = "groupStatusId"
        case groupStatus
        case groupTypeID = "groupTypeId"
        case groupType, createdDate, modifiedDate, animalCount, animals
    }
}

// MARK: - Animal
// MARK: - Animal
struct AnimalGroup: Codable {
    let animalId: String?
    let onFarmId: String?
    let officialId: String?
    let dob : String?
    let sex :String?
    let breedId : String?
    let breed :String?
    let name: String?

}
