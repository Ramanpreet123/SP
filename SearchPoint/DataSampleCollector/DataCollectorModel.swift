//
//  DataCollectorModel.swift
//  SearchPoint
//
//  Created by Rajni Raswant on 02/06/22.
//

import Foundation

//MARK: DATA COLLECTOR MODEL
struct DataCollectorModel:Codable {
    var responseCode: Int?
    var errorDetail :String?
    var message :String?
}
