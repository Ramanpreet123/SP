//
//  GetBreedsModel.swift
//  SearchPoint
//
//  Created by "" on 10/10/2019.
//  ""
//

import Foundation

struct GetBreedsModel: Codable {
        let breeds: [Breed]
        let responseCode: Int?
        let errorDetail, message: String?
    }

    // MARK: - Breed
    struct Breed: Codable {
        let breedID, name: String?
        let alpha2: String? //Alpha2
        let alpha3: String?
        let abbrev: String? //Abbrev
        let isDefault: Bool?
        let speciesID, species: String?
        let productIDS: [ProductID12]
        let lastUpdated: String?

        enum CodingKeys: String, CodingKey {
            case breedID = "breedId"
            case name, alpha2, alpha3, abbrev, isDefault
            case speciesID = "speciesId"
            case species
            case productIDS = "productIds"
            case lastUpdated
        }
    }

//    enum Abbrev: String, Codable {
//        case angx = "ANGX"
//        case brhx = "BRHX"
//        case chlx = "CHLX"
//        case empty = ""
//        case tulx = "TULX"
//    }
//
//    enum Alpha2: String, Codable {
//        case ay = "AY"
//        case bs = "BS"
//        case empty = ""
//        case gu = "GU"
//        case ho = "HO"
//        case je = "JE"
//        case ms = "MS"
//    }

    // MARK: - ProductID
    struct ProductID12: Codable {
        let productID, providerID: Int?
        let provider: String? //Provider12
        let marketID: String?
        let market: String? //Market12

        enum CodingKeys: String, CodingKey {
            case productID = "productId"
            case providerID = "providerId"
            case provider
            case marketID = "marketId"
            case market
        }
    }

//    enum Market12: String, Codable {
//        case au = "AU"
//        case br = "BR"
//        case nz = "NZ"
//        case uk = "UK"
//        case us = "US"
//    }

//    enum Provider12: String, Codable {
//        case brazil = keyValue.capsBrazil.rawValue
//        case clarifideAhdbUk = keyValue.clarifideAHDBUK.rawValue
//        case clarifideCdcbUs = keyValue.clarifideCDCBUS.rawValue
//        case clarifideDatageneAU = "CLARIFIDE Datagene (AU)"
//        case clarifideGirolandoBR = keyValue.clarifideGirolandoBR
//        case global = "Global"
//        case nzAngus = "NZ Angus"
//    }
