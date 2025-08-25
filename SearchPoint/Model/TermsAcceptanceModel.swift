//
//  TermsAcceptanceModel.swift
//  SearchPoint
//
//  Created by "" 30/04/20.
//

import Foundation

struct TermsAcceptanceModel: Codable {
    let setting, type, oldValue, newValue: String?
    let responseCode: Int
    let errorDetail, message: String?
}
