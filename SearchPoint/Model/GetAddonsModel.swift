//
//  GetAddonsModel.swift
//  SearchPoint
//
//  Created by "" on 11/10/2019.
//  ""
//

import Foundation

//struct GetAddonsModel:Codable {
//
//        let addOns: [AddOn]
//        let responseCode: Int
//        let errorDetail, message: String
//    }
//
//    // MARK: - AddOn
//    struct AddOn: Codable {
//        let addOnID: Int
//        let addOn: String
//        let productIDS: [Int]
//        let lastUpdated: String
//
//        enum CodingKeys: String, CodingKey {
//            case addOnID = "addOnId"
//            case addOn
//            case productIDS = "productIds"
//            case lastUpdated
//        }
//    }

struct GetAddonsModel:Codable {
    
    var AddonId :Int
    var AddonName :String?
    var ProductId :Int

    
}
