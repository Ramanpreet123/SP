//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let getBreedsModel = try? newJSONDecoder().decode(GetBreedsModel.self, from: jsonData)
//
//import Foundation
//
//// MARK: - Empty
//struct OrderDetailsByDatesModel: Codable {
//    let orderCount, pastDays: Int
//    let orders: [OrderDates]
//    let responseCode: Int
//    let errorDetail, message: String
//}
//
//// MARK: - Order
//struct OrderDates: Codable {
//    let customerID, customerName, orderID, orderedDate: String
//    let sampleCount: Int
//    let latestSampleReceivedDate: String
//    let reportedDate, status: JSONNull?
//    let samples: [SampleDates]
//
//    enum CodingKeys: String, CodingKey {
//        case customerID = keyValue.customerId.rawValue
//        case customerName
//        case orderID = keyValue.orderId.rawValue
//        case orderedDate, sampleCount, latestSampleReceivedDate, reportedDate, status, samples
//    }
//}
//
//// MARK: - Sample
//struct SampleDates: Codable {
//    let receivedDate, reportedDate: String
//    let productName: JSONNull?
//    let sampleBarCode: String
//    let sampleStatus: Status
//    let actionRequired: [String]
//    let onFarmID, officialTag, earTag, officialID: String
//    let breedRegNumber: JSONNull?
//    let sampleTrackingLabels: [SampleTrackingLabel]
//    let sampleDetails: [SampleDetail]
//
//    enum CodingKeys: String, CodingKey {
//        case receivedDate, reportedDate, productName, sampleBarCode, sampleStatus, actionRequired
//        case onFarmID = "onFarmId"
//        case officialTag, earTag
//        case officialID = "officialId"
//        case breedRegNumber, sampleTrackingLabels, sampleDetails
//    }
//}
//
//enum ActionRequired: String, Codable {
//    case contactZoetisGeneticsCustomerService = "Contact Zoetis Genetics Customer Service"
//    case empty = ""
//}
//
//// MARK: - SampleDetail
//struct SampleDetail: Codable {
//    let productName: String
//    let actionRequired: ActionRequired
//    let status: String
//    let reportedDate: String?
//}
//
//enum Status: String, Codable {
//    case atLab = "At Lab"
//    case pendingWellnessTraitResults = "Pending Wellness Trait Results"
//    case possibleSireSonForUnknownSire = "Possible sire|son for unknown sire"
//    case reported = LocalizedStrings.reportedFilterName
//}
//
//// MARK: - SampleTrackingLabel
//struct SampleTrackingLabel: Codable {
//    let onFarmID, officialID, breedRegNumber: String?
//
//    enum CodingKeys: String, CodingKey {
//        case onFarmID = "onFarmId"
//        case officialID = "officialId"
//        case breedRegNumber
//    }
//}
//
