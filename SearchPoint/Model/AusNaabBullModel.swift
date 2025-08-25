//
//  AusNaabBullModel.swift
//  SearchPoint
//
//  Created by "" on 02/06/20.
//

import Foundation
import Foundation
// MARK: - OrderDetailByPastDaysModel
struct AusNaabBullModel: Codable {
    let bulls: [Bull]
    let responseCode: Int?
    let errorDetail, message: String?
}

// MARK: - Bull
struct Bull: Codable {
    let sireNationalID, sireName ,bullID,srcLine: String?
    let lastUpdated: String?
}
