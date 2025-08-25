//
//  SampleStatuses.swift
//  SearchPoint
//
//  Created by "" 20/05/20.
//

import Foundation

struct SampleStatuses: Codable {
    let sampleStatuses: [SampleStatus]
    let responseCode: Int?
    let errorDetail, message: String?
}

// MARK: - SampleStatus
struct SampleStatus: Codable {
    let sampleStatusID: Int?
    let sampleStatus: String?

    enum CodingKeys: String, CodingKey {
        case sampleStatusID = "sampleStatusId"
        case sampleStatus
    }
}
