// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - resultmastermodel
struct resultmastermodel: Codable {
    
    let responseCode: Int
    let errorDetail, message: String
    let resultsMasterTemplates: [ResultsMasterTemplate]
}

// MARK: - ResultsMasterTemplate
struct ResultsMasterTemplate: Codable {
    
    let resultsView: [ResultsView]
}

// MARK: - ResultsView
struct ResultsView: Codable {
    
    let name, species: String
    let traitNames: [TraitName]
    let traitHeaders: [TraitHeader]
    let template: [Template]
}

// MARK: - Template
struct Template: Codable {
    
    let displayName, attribute, traitID, location: String
    let sortBy: Bool
    let defaultSortOrder, results: Int
    let profile, indexes, production, fertility: String
    let wellness, calving, type, geneticConditions: String
    let milkProteins, parentage, photos, notes: String
    let breedFilter: [String]

    enum CodingKeys: String, CodingKey {
        case displayName, attribute
        case traitID
        case location, sortBy, defaultSortOrder, results, profile, indexes, production, fertility, wellness, calving, type, geneticConditions, milkProteins, parentage, photos, notes, breedFilter
    }
}

// MARK: - TraitHeader
struct TraitHeader: Codable {
    
    let header: String
    let traitIDS: [String]

    enum CodingKeys: String, CodingKey {
        case header
        case traitIDS
    }
}

// MARK: - TraitName
struct TraitName: Codable {
    
    let header: String
    let traitNames: [TraitNameTraitName]
}


// MARK: - TraitNameTraitName
struct TraitNameTraitName: Codable {
    let name: String
}

