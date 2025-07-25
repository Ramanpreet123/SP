//
//  ResultTotalanimalsModel.swift
//  SearchPoint
//
//  Created by Yamini Sunkara on 15/05/1400 AP.
//

import Foundation

struct ResultTotalanimalsModel: Codable
{
    let responseCode : Int?
    let errorDetail : String?
    let message : String?
    let customerId : String?
    let customerName : String?
    let totalAnimals : Int?

    enum CodingKeys: String, CodingKey {

        case responseCode = "responseCode"
        case errorDetail = "errorDetail"
        case message = "message"
        case customerId = "customerId"
        case customerName = "customerName"
        case totalAnimals = "totalAnimals"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        responseCode = try values.decodeIfPresent(Int.self, forKey: .responseCode)
        errorDetail = try values.decodeIfPresent(String.self, forKey: .errorDetail)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        customerId = try values.decodeIfPresent(String.self, forKey: .customerId)
        customerName = try values.decodeIfPresent(String.self, forKey: .customerName)
        totalAnimals = try values.decodeIfPresent(Int.self, forKey: .totalAnimals)
    }

}
