//
//  NetworkPackets.swift
//  SearchPoint
//
//  Created by "" on 07/10/2019.
//  ""
//

import Foundation
import Alamofire

enum Configuration{
    case Dev(packet:String)
    case Prod(packet:String)
    case UAT(packet:String)
    
    func getUrl()->String{
        
        switch self {
        case .Dev(let packet):
            return "https://gde-uat.zoetis.com/api/" + packet
                   //"https://gde-uat.zoetis.com/api/"
//            return "https://gde-uat.zoetis.com/api/" + packet
        case .Prod(let packet):
            return "https://gde-uat.zoetis.com/api/"+packet
        case .UAT(let packet):
            return ""+packet
        }
    }
}

struct NetwrokPackets {
    
    var Method:HTTPMethod!
    var Headers:[String:String]?
    var bodyParams:[String:Any]?
    var Url:String!
}
