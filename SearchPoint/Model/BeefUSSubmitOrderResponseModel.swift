//
//  BeefUSSubmitOrderResponseModel.swift
//  SearchPoint
//
//  Created by Rajni Raswant on 04/12/23.
//

import Foundation

struct OrderSubmitResponse: Codable {
    
    let ngpCustomerId: Int?
    let ngpOrderId: Int?
    let success: Bool?
    let emailHasBeenSent: Bool?
    let responseCode: Int?
    let errorDetail: String?
    let message: String?
    
}

