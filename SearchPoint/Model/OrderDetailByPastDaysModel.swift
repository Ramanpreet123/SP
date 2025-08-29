// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getBreedsModel = try? newJSONDecoder().decode(GetBreedsModel.self, from: jsonData)

import Foundation


// MARK: - Welcome
struct OrderDetailByPastDaysModel: Codable {
    let orderCount, pastDays: Int?
    let orders: [Order]
    let responseCode: Int?
    let errorDetail, message: String?
}

// MARK: - Order
struct Order: Codable {
    let customerID: String?
    let customerName: String?
    let orderID, orderedDate: String
    let sampleCount: Int?
    let latestSampleReceivedDate: String?
    let reportedDate: String?
    let status: String?
    let samples: [SamplePast]

    enum CodingKeys: String, CodingKey {
        case customerID = "customerId"
        case customerName
        case orderID = "orderId"
        case orderedDate, sampleCount, latestSampleReceivedDate, reportedDate, status, samples
    }
}



// MARK: - Sample
struct SamplePast: Codable {
    let receivedDate: String?
    let reportedDate: String?
    let productName: String?
    let sampleBarCode: String?
    let sampleStatusID: Int
    let sampleStatus: String?
    let actionRequired: [ActionRequired]
    let onFarmID, officialTag, earTag: String?
    let officialID, breedRegNumber: String?
    let speciesID: String?
    let species: String?
    let sampleTrackingLabels: [SampleTrackingLabel]
    let sampleDetails: [SampleDetail]

    enum CodingKeys: String, CodingKey {
        case receivedDate, reportedDate, productName, sampleBarCode
        case sampleStatusID = "sampleStatusId"
        case sampleStatus, actionRequired
        case onFarmID = "onFarmId"
        case officialTag, earTag
        case officialID = "officialId"
        case breedRegNumber
        case speciesID = "speciesId"
        case species, sampleTrackingLabels, sampleDetails
    }
}

// MARK: - ActionRequired
struct ActionRequired: Codable {
    let action: String?
}



// MARK: - SampleDetail
struct SampleDetail: Codable {
    let productName: String?
    let actionRequired: String?
    let status: String?
    let reportedDate: String?
}




// MARK: - SampleTrackingLabel
struct SampleTrackingLabel: Codable {
    let onFarmID: String?
    let officialID: String?
    let breedRegNumber: String?

    enum CodingKeys: String, CodingKey {
        case onFarmID = "onFarmId"
        case officialID = "officialId"
        case breedRegNumber
    }
}







// MARK: - Encode/decode helpers

