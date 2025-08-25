//
//  ProductResponse.swift
//  SearchPoint
//
//  Created by "" on 30/12/2019.
//

import Foundation

struct ProductResponse: Codable {
    
    let ActionRequired: String?
    let OrderDate: String?
    let OrderId: Int
    let OrderStatus: String?
    let PackageRecieved: String?
    let SampleCount: Int
    let ServerOrderId: String?
    let ProductStatus :[ProductStatus]
}

struct ProductStatus: Codable {
    let ProductName: String?
    let EarTag : String?
    let RGD : String?
    let RGN: String?
    let Series: String?
    
    let ProductStatus: String?
    let ProductId: Int
    let BarCode: String?
    let OfficialId: String?
    let OnFarmId: String?
    let Addons :[Addons]
}

struct Addons: Codable {
    
    let AddonId: Int
    let AddonName: String?
}
