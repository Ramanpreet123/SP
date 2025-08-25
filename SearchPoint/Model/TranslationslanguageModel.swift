//
//  Translationslanguage.swift
//  SearchPoint
//
//  Created by Yamini Sunkara on 12/1/21.
//
import Foundation

// MARK: - Welcome
struct TranslationslanguageModel: Codable {
    let translations: Translations
    let responseCode: Int
    let errorDetail, message: String
}

// MARK: - Translations
struct Translations: Codable {
    let single, multiBirth, et, male: String?
    let female, hair, blood, semen: String?
    let girolandoAssociation, selectBreed: String?

    enum CodingKeys: String, CodingKey {
        case single = "Single"
        case multiBirth = "Multi Birth"
        case et = "ET"
        case male = "Male"
        case female = "Female"
        case hair = "Hair"
        case blood = "Blood"
        case semen = "Semen"
        case girolandoAssociation = "Girolando Association"
        case selectBreed = "Select Breed"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        single = try values.decodeIfPresent(String.self, forKey: .single)
        multiBirth = try values.decodeIfPresent(String.self, forKey: .multiBirth)
        et = try values.decodeIfPresent(String.self, forKey: .et)
        male = try values.decodeIfPresent(String.self, forKey: .male)
        female = try values.decodeIfPresent(String.self, forKey: .female)
        hair = try values.decodeIfPresent(String.self, forKey: .hair)
        blood = try values.decodeIfPresent(String.self, forKey: .blood)
        semen = try values.decodeIfPresent(String.self, forKey: .semen)
        girolandoAssociation = try values.decodeIfPresent(String.self, forKey: .girolandoAssociation)
        selectBreed = try values.decodeIfPresent(String.self, forKey: .selectBreed)
    }
}

class TranslationslanguageResponse {
    var tranlation : Translations?
}
