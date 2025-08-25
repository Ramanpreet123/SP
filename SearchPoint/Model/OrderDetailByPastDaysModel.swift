// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getBreedsModel = try? newJSONDecoder().decode(GetBreedsModel.self, from: jsonData)

import Foundation

// MARK: - UAT Model
//
//struct OrderDetailByPastDaysModel: Codable {
//
//    let orderCount, pastDays: Int
//    let orders: [OrderPast]
//    let responseCode: Int
//    let errorDetail, message: String
//}
//
//// MARK: - Order
//struct OrderPast: Codable {
//    let customerId: String
//    let customerName: String
//    let orderId, orderedDate: String
//    let sampleCount: Int
//    let latestSampleReceivedDate: String
//    let reportedDate: JSONNull?
//    let status: String
//
//    let samples: [SamplePast]
//
////    enum CodingKeys: String, CodingKey {
////        //case customerID = keyValue.customerId.rawValue
////        //case customerName
////      //  case orderID = keyValue.orderId.rawValue
////       // case orderedDate, sampleCount, latestSampleReceivedDate, reportedDate, status, samples
////    }
//}
//
////enum CustomerNamePast: String, Codable {
////    case barEDairyWA = "Bar E Dairy -WA"
////    case cowPalace = "Cow Palace"
////    case okDairy = "OK Dairy"
////    case vanBeekDairyFarmsLLC = "Van Beek Dairy Farms LLC"
////}
////
////enum ReceivedDate: String, Codable {
////    case the20200401T123000 = "2020-04-01T12:30:00"
////    case the20200406T054900 = "2020-04-06T05:49:00"
////    case the20200407T010500 = "2020-04-07T01:05:00"
////    case the20200413T120200 = "2020-04-13T12:02:00"
////    case the20200413T120300 = "2020-04-13T12:03:00"
////    case the20200415T011000 = "2020-04-15T01:10:00"
////    case the20200420T071700 = "2020-04-20T07:17:00"
////    case the20200424T031000 = "2020-04-24T03:10:00"
////    case the20200429T121700 = "2020-04-29T12:17:00"
////    case the20200429T121800 = "2020-04-29T12:18:00"
////    case the20200430T084700 = "2020-04-30T08:47:00"
////    case the20200430T085300 = "2020-04-30T08:53:00"
////    case the20200504T091200 = "2020-05-04T09:12:00"
////    case the20200507T054300 = "2020-05-07T05:43:00"
////    case the20200507T054400 = "2020-05-07T05:44:00"
////    case the20200507T054500 = "2020-05-07T05:45:00"
////    case the20200507T054600 = "2020-05-07T05:46:00"
////    case the20200507T054700 = "2020-05-07T05:47:00"
////    case the20200507T054800 = "2020-05-07T05:48:00"
////    case the20200507T054900 = "2020-05-07T05:49:00"
////    case the20200507T055000 = "2020-05-07T05:50:00"
////    case the20200507T055100 = "2020-05-07T05:51:00"
////    case the20200512T011700 = "2020-05-12T01:17:00"
////    case the20200520T012400 = "2020-05-20T01:24:00"
////    case the20200521T043400 = "2020-05-21T04:34:00"
////    case the20200521T043500 = "2020-05-21T04:35:00"
////    case the20200522T025700 = "2020-05-22T02:57:00"
////    case the20200527T035900 = "2020-05-27T03:59:00"
////    case the20200527T073500 = "2020-05-27T07:35:00"
////    case the20200527T124900 = "2020-05-27T12:49:00"
////    case the20200527T125000 = "2020-05-27T12:50:00"
////    case the20200603T023200 = "2020-06-03T02:32:00"
////    case the20200608T032000 = "2020-06-08T03:20:00"
////    case the20200608T032100 = "2020-06-08T03:21:00"
////    case the20200610T063500 = "2020-06-10T06:35:00"
////    case the20200610T063600 = "2020-06-10T06:36:00"
////    case the20200612T012200 = "2020-06-12T01:22:00"
////    case the20200615T093000 = "2020-06-15T09:30:00"
////}
//
//// MARK: - Sample
//struct SamplePast: Codable {
//    let receivedDate: String
//    let reportedDate: String?
//    let productName: String?
//    let sampleBarCode: String
//    let sampleStatusId: Int
//    let sampleStatus: String
//    let actionRequired: [ActionRequired]
//    let onFarmId,officialId,officialTag, earTag: String
//    let breedRegNumber: String?
//    let speciesId: String
//    let species: String
//    let sampleTrackingLabels: [SampleTrackingLabel]
//    let sampleDetails: [SampleDetail]
//
////    enum CodingKeys: String, CodingKey {
////        case receivedDate, reportedDate, productName, sampleBarCode
////        case sampleStatusID = "sampleStatusId"
////        case sampleStatus, actionRequired
////        case onFarmID = "onFarmId"
////        case officialTag, earTag
////        case officialID = "officialId"
////        case breedRegNumber
////        case speciesID = "speciesId"
////        case species, sampleTrackingLabels, sampleDetails
////    }
//}
//
//// MARK: - ActionRequired
//struct ActionRequired: Codable {
//    let action: String
//}
//
////enum Action: String, Codable {
////    case contactBreedAssociation = "Contact Breed Association"
////    case contactZoetisGeneticsCustomerService = "Contact Zoetis Genetics Customer Service"
////    case empty = ""
////    case newSampleRequested = "New Sample Requested"
////    case noActionGPTASNotPossible = "No Action, GPTA's Not Possible"
////}
//
//// MARK: - SampleDetail
//struct SampleDetail: Codable {
//    let productName: String
//    let actionRequired: String
//    let status: String
//    let reportedDate: String?
//}
////
////enum ProductName: String, Codable {
////    case betaCaseinA2 = "Beta Casein A2"
////    case bvd = "BVD"
////    case clarifideCdcb = LocalizedStrings.clarifideCDCB
////    case clarifidePlus = LocalizedStrings.providerClarifidePlus
////}
////
////enum SampleStatusEnum: String, Codable {
////    case atLab = "At Lab"
////    case breedConflict = "Breed Conflict"
////    case cancelled = "Cancelled"
////    case mgsIsUnlikely = "MGS is unlikely"
////    case nonPedigreeParentProgenyRel = "Non-pedigree parent-progeny rel"
////    case parentageCorrectionInProgress = "Parentage Correction In Progress"
////    case possibleDamFound = "Possible dam found"
////    case possibleSireSonForUnknownSire = "Possible sire|son for unknown sire"
////    case reported = LocalizedStrings.reportedFilterName
////    case sampleFailedAtLab = "Sample Failed at Lab"
////    case sireConflict = "Sire conflict"
////}
//
//// MARK: - SampleTrackingLabel
//struct SampleTrackingLabel: Codable {
//    let onFarmId: String?
//    let officialId: String?
//    let breedRegNumber: String?
//
//
//}

//enum OfficialIDPast: String, Codable {
//    case officalID = "Offical ID"
//}
//
//enum OnFarmIDPast: String, Codable {
//    case onFarmID = LocalizedStrings.onFarmIdText
//}
//
//enum SpeciesPast: String, Codable {
//    case dairy = marketNameType.Dairy.rawValue
//}
//
//enum OrderStatus: String, Codable {
//    case inProgress = "In Progress"
//}
//
// MARK: - Encode/decode helpers

//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)



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

