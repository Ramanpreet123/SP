//
//  ApiSyncModal.swift
//  SearchPoint
//
//  Created by "" on 18/02/20.
//

import Foundation

struct ApiSyncModal:Codable{

    var customerId: String!
    var billToCustomerId: String!
    var dealerCode: String!
    var orderDate = Date().string(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    var species: String?
    var isOFFline = true
    var breed1: String?
    var breed2: String?
    var breed3: String?
    var providerId :Int?
    var nominatorId :Int?
    var animals = [AnimalDetail]()
    var emailOrder: Bool?
    var emailAddresses = [String]()

    init() {
        
    }
}
//

struct AnimalDetail:Codable {
    /******** DAIRY Model ************/
    //New Params
    var onFarmId: String!
    var officialTag: String!
     var sampleBarCode: String!
     var uniqueID: String?
    var visualID: String?
    var officialPermanentId: String!
    var providerId = 0
    var breedId :String!
    var sampleTypeId = 0
    var sampleType : String?
    var eid :String!
    var secondaryId :String!
    var sex: String!
    var breed: String!
    var bornTypeId = 0
    var nationalHerdId: String!
    var sireId: String!
    var dob: String!
    var birthDate : String?
   var officialSireId: String!
    var officialDamId: String!
    var earTag: String!
    var animalTag: String!
    var breedRegNumber: String!
    var breedAssociationId: String!
    var animalName: String!
    var sireRegNumber: String!
    var sireAssociationId: String!
    var damRegNumber: String!
    var damAssociationId: String!
    var sireYOB = 0
    var damId: String!
    var damYOB = 0
    var series: String!
    var rgd: String!
    var rgn: String!
    var primaryPriorityProgramId : String!
    var secondaryPriorityProgramId :String!
    var tertiaryPriorityProgramId :String!
    var girlandoID : String!
    var productDetails = [ProductDetailSubmit]()
}

struct ProductDetailSubmit: Codable {
   var products = [ProductSubmit]()
   var addOns = [AddOnSubmit]()
}

// MARK: - AddOn
struct AddOnSubmit: Codable {
   var addOnID: Int16?

   enum CodingKeys: String, CodingKey {
       case addOnID = "addOnId"
   }
}

// MARK: - Product
struct ProductSubmit: Codable {
   var productID: Int16?

   enum CodingKeys: String, CodingKey {
       case productID = "productId"
   }
}
