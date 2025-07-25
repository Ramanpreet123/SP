//
//  LogoutModel.swift
//  SearchPoint
//
//  Created by "" 22/04/20.
//

import Foundation

// MARK: - Welcome
struct LogoutModel: Codable {
    let email: String?
    let responseCode: Int?
    let errorDetail, message: String?
}
