//////
//////  RootClass.swift
//////
//////  Generated using https://jsonmaster.github.io
//////  Created on October 08, 2021
//////
//import Foundation
//struct ResultMasterTemplateModel : Codable {
//    let responseCode : Int?
//    let errorDetail : String?
//    let message : String?
//    let resultsMasterTemplates : [ResultsMasterTemplates]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case responseCode = "responseCode"
//        case errorDetail = keyValue.errorDetail.rawValue
//        case message = keyValue.messageKey.rawValue
//        case resultsMasterTemplates = "resultsMasterTemplates"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        responseCode = try values.decodeIfPresent(Int.self, forKey: .responseCode)
//        errorDetail = try values.decodeIfPresent(String.self, forKey: .errorDetail)
//        message = try values.decodeIfPresent(String.self, forKey: .message)
//        resultsMasterTemplates = try values.decodeIfPresent([ResultsMasterTemplates].self, forKey: .resultsMasterTemplates)
//    }
//
//}
//struct ResultsMasterTemplates : Codable {
//    let resultsView : [ResultsView]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case resultsView = "resultsView"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        resultsView = try values.decodeIfPresent([ResultsView].self, forKey: .resultsView)
//    }
//
//}
//struct ResultsView : Codable {
//    let name : String?
//    let species : String?
//    let traitNames : [TraitNames]?
//    let traitHeaders : [TraitHeaders]?
//    let template : [Template]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case name = "name")
//        case species = "species"
//        case traitNames = "traitNames"
//        case traitHeaders = "traitHeaders"
//        case template = "template"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        species = try values.decodeIfPresent(String.self, forKey: .species)
//        traitNames = try values.decodeIfPresent([TraitNames].self, forKey: .traitNames)
//        traitHeaders = try values.decodeIfPresent([TraitHeaders].self, forKey: .traitHeaders)
//        template = try values.decodeIfPresent([Template].self, forKey: .template)
//    }
//
//}
//struct Template : Codable {
//    let displayName : String?
//    let attribute : String?
//    let traitId : String?
//    let location : String?
//    let sortBy : Bool?
//    let defaultSortOrder : Int?
//    let results : Int?
//    let profile : String?
//    let indexes : String?
//    let production : String?
//    let fertility : String?
//    let wellness : String?
//    let calving : String?
//    let type : String?
//    let geneticConditions : String?
//    let milkProteins : String?
//    let parentage : String?
//    let photos : String?
//    let notes : String?
//    let breedFilter : [String]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case displayName = "displayName"
//        case attribute = "attribute"
//        case traitId = "traitId"
//        case location = "location"
//        case sortBy = "sortBy"
//        case defaultSortOrder = "defaultSortOrder"
//        case results = "results"
//        case profile = "profile"
//        case indexes = "indexes"
//        case production = "production"
//        case fertility = "fertility"
//        case wellness = "wellness"
//        case calving = "calving"
//        case type = "type"
//        case geneticConditions = "geneticConditions"
//        case milkProteins = "milkProteins"
//        case parentage = "parentage"
//        case photos = "photos"
//        case notes = keyValue.notes.rawValue
//        case breedFilter = "breedFilter"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        displayName = try values.decodeIfPresent(String.self, forKey: .displayName)
//        attribute = try values.decodeIfPresent(String.self, forKey: .attribute)
//        traitId = try values.decodeIfPresent(String.self, forKey: .traitId)
//        location = try values.decodeIfPresent(String.self, forKey: .location)
//        sortBy = try values.decodeIfPresent(Bool.self, forKey: .sortBy)
//        defaultSortOrder = try values.decodeIfPresent(Int.self, forKey: .defaultSortOrder)
//        results = try values.decodeIfPresent(Int.self, forKey: .results)
//        profile = try values.decodeIfPresent(String.self, forKey: .profile)
//        indexes = try values.decodeIfPresent(String.self, forKey: .indexes)
//        production = try values.decodeIfPresent(String.self, forKey: .production)
//        fertility = try values.decodeIfPresent(String.self, forKey: .fertility)
//        wellness = try values.decodeIfPresent(String.self, forKey: .wellness)
//        calving = try values.decodeIfPresent(String.self, forKey: .calving)
//        type = try values.decodeIfPresent(String.self, forKey: .type)
//        geneticConditions = try values.decodeIfPresent(String.self, forKey: .geneticConditions)
//        milkProteins = try values.decodeIfPresent(String.self, forKey: .milkProteins)
//        parentage = try values.decodeIfPresent(String.self, forKey: .parentage)
//        photos = try values.decodeIfPresent(String.self, forKey: .photos)
//        notes = try values.decodeIfPresent(String.self, forKey: .notes)
//        breedFilter = try values.decodeIfPresent([String].self, forKey: .breedFilter)
//    }
//
//}
//struct TraitHeaders : Codable {
//    let header : String?
//    let traitIds : [String]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case header = "header"
//        case traitIds = "traitIds"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        header = try values.decodeIfPresent(String.self, forKey: .header)
//        traitIds = try values.decodeIfPresent([String].self, forKey: .traitIds)
//    }
//
//}
//struct TraitNames : Codable {
//    let header : String?
//    let traitNames : [String]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case header = "header"
//        case traitNames = "traitNames"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        header = try values.decodeIfPresent(String.self, forKey: .header)
//        traitNames = try values.decodeIfPresent([String].self, forKey: .traitNames)
//    }
//
//}
//
////
////struct ResultMasterTemplateModel : Codable {
////
////    let responseCode: Int
////    let errorDetail: String
////    let message: String
////    let resultsMasterTemplates: [ResultsMasterTemplates]
////
////    private enum CodingKeys: String, CodingKey {
////        case responseCode = "responseCode"
////        case errorDetail = keyValue.errorDetail.rawValue
////        case message = keyValue.messageKey.rawValue
////        case resultsMasterTemplates = "resultsMasterTemplates"
////    }
////
////    init(from decoder: Decoder) throws {
////        let values = try decoder.container(keyedBy: CodingKeys.self)
////        responseCode = try values.decode(Int.self, forKey: .responseCode)
////        errorDetail = try values.decode(String.self, forKey: .errorDetail)
////        message = try values.decode(String.self, forKey: .message)
////        resultsMasterTemplates = try values.decode([ResultsMasterTemplates].self, forKey: .resultsMasterTemplates)
////    }
////
////    func encode(to encoder: Encoder) throws {
////        var container = encoder.container(keyedBy: CodingKeys.self)
////        try container.encode(responseCode, forKey: .responseCode)
////        try container.encode(errorDetail, forKey: .errorDetail)
////        try container.encode(message, forKey: .message)
////        try container.encode(resultsMasterTemplates, forKey: .resultsMasterTemplates)
////    }
////
////}
////struct ResultsMasterTemplates: Codable {
////
////    let resultsView: [ResultsView]
////
////    private enum CodingKeys: String, CodingKey {
////        case resultsView = "resultsView"
////    }
////
////    init(from decoder: Decoder) throws {
////        let values = try decoder.container(keyedBy: CodingKeys.self)
////        resultsView = try values.decode([ResultsView].self, forKey: .resultsView)
////    }
////
////    func encode(to encoder: Encoder) throws {
////        var container = encoder.container(keyedBy: CodingKeys.self)
////        try container.encode(resultsView, forKey: .resultsView)
////    }
////
////}
////struct ResultsView: Codable {
////
////    let name: String
////    let species: String
////    let traitNames: [TraitNames]
////    let traitHeaders: [TraitHeaders]
////    let template: [Template]
////
////    private enum CodingKeys: String, CodingKey {
////        case name = "name")
////        case species = "species"
////        case traitNames = "traitNames"
////        case traitHeaders = "traitHeaders"
////        case template = "template"
////    }
////
////    init(from decoder: Decoder) throws {
////        let values = try decoder.container(keyedBy: CodingKeys.self)
////        name = try values.decode(String.self, forKey: .name)
////        species = try values.decode(String.self, forKey: .species)
////        traitNames = try values.decode([TraitNames].self, forKey: .traitNames)
////        traitHeaders = try values.decode([TraitHeaders].self, forKey: .traitHeaders)
////        template = try values.decode([Template].self, forKey: .template)
////    }
////
////    func encode(to encoder: Encoder) throws {
////        var container = encoder.container(keyedBy: CodingKeys.self)
////        try container.encode(name, forKey: .name)
////        try container.encode(species, forKey: .species)
////        try container.encode(traitNames, forKey: .traitNames)
////        try container.encode(traitHeaders, forKey: .traitHeaders)
////        try container.encode(template, forKey: .template)
////    }
////
////}
////struct TraitNames: Codable {
////
////    let header: String
////    let traitNames: [String]
////
////    private enum CodingKeys: String, CodingKey {
////        case header = "header"
////        case traitNames = "traitNames"
////    }
////
////    init(from decoder: Decoder) throws {
////        let values = try decoder.container(keyedBy: CodingKeys.self)
////        header = try values.decode(String.self, forKey: .header)
////        traitNames = try values.decode([String].self, forKey: .traitNames)
////    }
////}
////struct TraitHeaders: Codable {
////
////    let header: String
////    let traitIds: [String]
////
////    private enum CodingKeys: String, CodingKey {
////        case header = "header"
////        case traitIds = "traitIds"
////    }
////
////    init(from decoder: Decoder) throws {
////        let values = try decoder.container(keyedBy: CodingKeys.self)
////        header = try values.decode(String.self, forKey: .header)
////        traitIds = try values.decode([String].self, forKey: .traitIds)
////    }
////
////    func encode(to encoder: Encoder) throws {
////        var container = encoder.container(keyedBy: CodingKeys.self)
////        try container.encode(header, forKey: .header)
////        try container.encode(traitIds, forKey: .traitIds)
////    }
////
////}
////struct Template: Codable {
////
////    let displayName: String
////    let attribute: String
////    let traitId: String
////    let location: String
////    let sortBy: Bool
////    let defaultSortOrder: Int
////    let results: Int
////    let profile: String
////    let indexes: String
////    let production: String
////    let fertility: String
////    let wellness: String
////    let calving: String
////    let type: String
////    let geneticConditions: String
////    let milkProteins: String
////    let parentage: String
////    let photos: String
////    let notes: String
////    let breedFilter: [String]
////
////    private enum CodingKeys: String, CodingKey {
////        case displayName = "displayName"
////        case attribute = "attribute"
////        case traitId = "traitId"
////        case location = "location"
////        case sortBy = "sortBy"
////        case defaultSortOrder = "defaultSortOrder"
////        case results = "results"
////        case profile = "profile"
////        case indexes = "indexes"
////        case production = "production"
////        case fertility = "fertility"
////        case wellness = "wellness"
////        case calving = "calving"
////        case type = "type"
////        case geneticConditions = "geneticConditions"
////        case milkProteins = "milkProteins"
////        case parentage = "parentage"
////        case photos = "photos"
////        case notes = keyValue.notes.rawValue
////        case breedFilter = "breedFilter"
////    }
////
////    init(from decoder: Decoder) throws {
////        let values = try decoder.container(keyedBy: CodingKeys.self)
////        displayName = try values.decode(String.self, forKey: .displayName)
////        attribute = try values.decode(String.self, forKey: .attribute)
////        traitId = try values.decode(String.self, forKey: .traitId)
////        location = try values.decode(String.self, forKey: .location)
////        sortBy = try values.decode(Bool.self, forKey: .sortBy)
////        defaultSortOrder = try values.decode(Int.self, forKey: .defaultSortOrder)
////        results = try values.decode(Int.self, forKey: .results)
////        profile = try values.decode(String.self, forKey: .profile)
////        indexes = try values.decode(String.self, forKey: .indexes)
////        production = try values.decode(String.self, forKey: .production)
////        fertility = try values.decode(String.self, forKey: .fertility)
////        wellness = try values.decode(String.self, forKey: .wellness)
////        calving = try values.decode(String.self, forKey: .calving)
////        type = try values.decode(String.self, forKey: .type)
////        geneticConditions = try values.decode(String.self, forKey: .geneticConditions)
////        milkProteins = try values.decode(String.self, forKey: .milkProteins)
////        parentage = try values.decode(String.self, forKey: .parentage)
////        photos = try values.decode(String.self, forKey: .photos)
////        notes = try values.decode(String.self, forKey: .notes)
////        breedFilter = try values.decode([String].self, forKey: .breedFilter)
////    }
////
////    func encode(to encoder: Encoder) throws {
////        var container = encoder.container(keyedBy: CodingKeys.self)
////        try container.encode(displayName, forKey: .displayName)
////        try container.encode(attribute, forKey: .attribute)
////        try container.encode(traitId, forKey: .traitId)
////        try container.encode(location, forKey: .location)
////        try container.encode(sortBy, forKey: .sortBy)
////        try container.encode(defaultSortOrder, forKey: .defaultSortOrder)
////        try container.encode(results, forKey: .results)
////        try container.encode(profile, forKey: .profile)
////        try container.encode(indexes, forKey: .indexes)
////        try container.encode(production, forKey: .production)
////        try container.encode(fertility, forKey: .fertility)
////        try container.encode(wellness, forKey: .wellness)
////        try container.encode(calving, forKey: .calving)
////        try container.encode(type, forKey: .type)
////        try container.encode(geneticConditions, forKey: .geneticConditions)
////        try container.encode(milkProteins, forKey: .milkProteins)
////        try container.encode(parentage, forKey: .parentage)
////        try container.encode(photos, forKey: .photos)
////        try container.encode(notes, forKey: .notes)
////        try container.encode(breedFilter, forKey: .breedFilter)
////    }
////
////}
