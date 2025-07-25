//
//  GetBillingModel.swift
//  SearchPoint
//
//  Created by "" on 09/12/19.
//

import Foundation
struct GetBillingModel: Codable {

     let billToCustomers: [BillToCustomer]
        let responseCode: Int
        let errorDetail, message: String?
    }

    // MARK: - BillToCustomer
    struct BillToCustomer: Codable {
        let billToCustomerID, billToName: String?
        let lastUpdated: String?

        enum CodingKeys: String, CodingKey {
            case billToCustomerID = "billToCustomerId"
            case billToName, lastUpdated
        }
    }

