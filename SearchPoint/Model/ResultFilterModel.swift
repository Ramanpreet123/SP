//
//  ResultFilterModel.swift
//  SearchPoint
//
//  Created by Mobile Programming on 09/06/21.
//

import Foundation

struct ResultFilterModel: Codable {
    let minDOB, oldest, customerName, message: String
       let youngest: String
       let customerID: Int
       let breeds: JSONNull?
       let totalAnimals: Int
       let providers: [ProviderFilter]
       let responseCode: Int
       let errorDetail, maxDOB: String

       enum CodingKeys: String, CodingKey {
           case minDOB, oldest, customerName, message, youngest
           case customerID = "customerId"
           case breeds, totalAnimals, providers, responseCode, errorDetail, maxDOB
       }
    }

    // MARK: - Provider
    struct ProviderFilter: Codable {
        let providerID: Int
        let providerName: String
        let breeds: [BreedFilter]

        enum CodingKeys: String, CodingKey {
            case providerID = "providerId"
            case providerName, breeds
        }
    }

    // MARK: - Breed
    struct BreedFilter: Codable {
        let breedID, breed: String

        enum CodingKeys: String, CodingKey {
            case breedID = "breedId"
            case breed
        }
    }
