//
//  GetProductsModel.swift
//  SearchPoint
//
//  Created by "" on 10/10/2019.
//  ""
//
// MARK: - Empty
struct GetProductsModel: Codable {
    let products: [Product]
    let responseCode: Int?
    let errorDetail, message: String?
}

// MARK: - Product
struct Product: Codable {
    let providerID: Int?
    let provider, speciesID: String?
    let species: String?
    let marketID: String?
    let market: String?
    let productID: Int?
    let product, productDescription: String?
    let isDefault: Bool?
    let breeds: [Breed1]
    let addOns: [AddOn]
    let markets: [MarketsNew]
    let orderAcceptTerms, lastUpdated: String?
    let isCdcbProduct: Bool?
    enum CodingKeys: String, CodingKey {
        case providerID = "providerId"
        case provider
        case speciesID = "speciesId"
        case species
        case marketID = "marketId"
        case market
        case productID = "productId"
        case product, productDescription, isDefault, breeds, addOns, orderAcceptTerms, lastUpdated,isCdcbProduct,markets
    }
}

// MARK: - AddOn
struct AddOn: Codable {
    var addOnID: Int?
    var addOn: String?
    var isIncludedInProduct: Bool?
    var lastUpdated: String?
    var isCdcbProduct: Bool?
    let info: [Info]
    enum CodingKeys: String, CodingKey {
        case addOnID = "addOnId"
        case addOn, isIncludedInProduct, lastUpdated,isCdcbProduct,info
    }
}
struct Info: Codable {
    let language, value: String
}
// MARK: - Breed
struct Breed1: Codable {
    let breedID, breed: String?

    enum CodingKeys: String, CodingKey {
        case breedID = "breedId"
        case breed
    }
}
struct MarketsNew: Codable {
    
    var marketsId: String?
    var marketName: String?
}
//
//enum Species1: String, Codable {
//    case beef = marketNameType.Beef.rawValue
//    case dairy = marketNameType.Dairy.rawValue
//}

