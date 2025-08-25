//
//  RegisterDeviceModel.swift
//  SearchPoint
//
//  Created by "" 29/04/20.
//

import Foundation

struct RegisterDeviceModel: Codable {
    let deviceID: String?
    let responseCode: Int?
    let errorDetail, message: String?

    enum CodingKeys: String, CodingKey {
        case deviceID = "deviceId"
        case responseCode, errorDetail, message
    }
}
