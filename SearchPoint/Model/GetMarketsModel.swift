//
//  GetMarketsModel.swift
//  SearchPoint
//
//  Created by "" on 10/10/2019.
//  ""
//

import Foundation

//struct GetMarketsModel: Codable {
//    let MarketId: Int
//    let MarketName: String
//}


// MARK: - Welcome
struct GetMarketsModel: Codable {
    let markets: [Market]
    let responseCode: Int?
    let errorDetail, message: String?
}

//// MARK: - Market
//struct Market: Codable {
//    let marketID, marketName ,pricingInfoText ,pricingLinkText,pricingLinkUrl: String
//    let lastUpdated: JSONNull?
//
//    enum CodingKeys: String, CodingKey {
//        case marketID = "marketId"
//        case marketName, lastUpdated , pricingInfoText , pricingLinkText , pricingLinkUrl
//    }
//}



// MARK: - Market
struct Market: Codable {
    let marketID, marketName, pricingInfoText: String?
    let pricingLinkText: String?
    let pricingLinkURL: String?
    let lastUpdated: String?

    enum CodingKeys: String, CodingKey {
        case marketID = "marketId"
        case marketName, pricingInfoText, pricingLinkText
        case pricingLinkURL = "pricingLinkUrl"
        case lastUpdated
    }
}

//enum LastUpdatedMarket: String, Codable {
//    case the20200604T16533356 = "2020-06-04T16:53:33.56"
//}
//
//enum PricingLinkText: String, Codable {
//    case empty = ""
//    case pricing = "Pricing"
//}
