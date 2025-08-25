//
//  File.swift
//  SearchPoint
//
//  Created by "" on 20/11/2019.
//

import Foundation


//struct SampleTypeModel: Codable {
//    let responseCode: Int
//    let errorDetail: String
//    let message: String
//
//    let sampleType :[sampleTypes]
//}
//
//struct sampleTypes: Codable {
//
//    let sampleTypeId: Int
//    let sampleType: String
//    let isDefault: Bool
//    let lastUpdated: String
//
//}

// MARK: - Welcome
//struct SampleTypeModel: Codable {
//    let sampleTypes: [SampleType]
//    let responseCode: Int
//    let errorDetail, message: String
//}
//
//// MARK: - SampleType
//struct SampleType: Codable {
//    let sampleTypeID: Int
//    let sampleType: String
//    let isDefault: Bool
//    let lastUpdated: String
//
//    enum CodingKeys: String, CodingKey {
//        case sampleTypeID = "sampleTypeId"
//        case sampleType, isDefault, lastUpdated
//    }
//}

// MARK: - Empty
struct SampleTypeModel: Codable {
    let providerSampleTypes: [ProviderSampleType]
    let responseCode: Int?
    let errorDetail, message: String?
}

// MARK: - ProviderSampleType
struct ProviderSampleType: Codable {
    let providerID: Int?
    let provider: String?
    let sampleTypes: [SampleTypeElement]

    enum CodingKeys: String, CodingKey {
        case providerID = "providerId"
        case provider, sampleTypes
    }
}

// MARK: - SampleTypeElement
struct SampleTypeElement: Codable {
    let sampleTypeID: Int?
    let sampleType: String?
    let isDefault: Bool?
    let lastUpdated: String?

    enum CodingKeys: String, CodingKey {
        case sampleTypeID = "sampleTypeId"
        case sampleType, isDefault, lastUpdated
    }
}

enum SampleTypeEnum: String, Codable {
    case allflexTST = "Allflex (TST)"
    case allflexTSU = "Allflex (TSU)"
    case blood = "Blood"
    case caisleyTSU = "Caisley (TSU)"
    case hair = "Hair"
    case semen = "Semen"
}
