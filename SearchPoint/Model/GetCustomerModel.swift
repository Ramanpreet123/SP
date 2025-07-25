//
//  GetCustomerModel.swift
//  SearchPoint
//
//  Created by "" on 01/06/20.
//

import Foundation
// MARK: - OrderDetailByPastDaysModel
struct GetCustomerModel: Codable {
    let customers: [Customer1]
    let responseCode: Int?
    let errorDetail, message: String?
}

// MARK: - Customer
struct Customer1: Codable {
  typealias billingCustomersID = Int?
    let customerID: Int?
    let customerName: String?
    let billToCustomerID: Int?
    let billToCustomerName: String?
    let country: String?
    let markets: [Market1]
  
  let customerBillToDictionary : [Int:String]?
  let billingCustomersArray : [BillingCustomers]
    enum CodingKeys: String, CodingKey {
        case customerID = "customerId"
        case customerName
        case billToCustomerID = "billToCustomerId"
        case billToCustomerName, markets, country
       case customerBillToDictionary
    
    }
  init(from decoder: Decoder) throws {
     let values = try decoder.container(keyedBy: CodingKeys.self)
     customerID = try values.decodeIfPresent(Int.self, forKey: .customerID)
     customerName = try values.decodeIfPresent(String.self, forKey: .customerName)
     billToCustomerID = try values.decodeIfPresent(Int.self, forKey: .billToCustomerID)
     billToCustomerName = try values.decodeIfPresent(String.self, forKey: .billToCustomerName)
     country = try values.decodeIfPresent(String.self, forKey: .country)
     markets = try values.decodeIfPresent([Market1].self, forKey: .markets)!
    let dictionary: [Int: String] = try values.decode([Int: String].self, forKey: .customerBillToDictionary)
    customerBillToDictionary = dictionary
   // print("count = ",dictionary.keys.count)
    var dictKeys = [Int]()
    var dictValues = [String]()
    if dictionary.keys.count != 0{
      dictKeys = Array(dictionary.keys)
      dictValues = Array(dictionary.values)
    }
    var billArray  = [BillingCustomers]()
    for i in 0 ..< dictKeys.count  {
      billArray.append(BillingCustomers.init(billCustid: String(dictKeys[i]), billCustname: dictValues[i]))
    }
    billingCustomersArray = billArray
   }
}

// MARK: - Market
struct Market1: Codable {
    let marketID, marketCode: String?

    enum CodingKeys: String, CodingKey {
        case marketID = "marketId"
        case marketCode
    }
}

struct BillingCustomers {
 
  var billingCustomerName: String?
  var billingCustomerID: String?
  init(billCustid:String, billCustname:String){
    self.billingCustomerID = billCustid
    self.billingCustomerName = billCustname
  }

}


//struct WhateverObject: Codable {
//    var myProperty: String // properties...
//
//    struct CodingKeys: CodingKey, Hashable {
//        var stringValue: String
//
//        static let myProperty = CodingKeys(stringValue: "myProperty")
//
//        init(stringValue: String) {
//            self.stringValue = stringValue
//        }
//
//        // Unused, only for int-backed Codables.
//        var intValue: Int? { return nil }
//        init?(intValue: Int) { return nil }
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        myProperty = container.decode(String.self, forKey: .myProperty)
//
//        let dynamicKeys = container.allKeys
//        for key in dynamicKeys {
//            // do whatever you want to do with the keys.
//        }
//    }
//}
