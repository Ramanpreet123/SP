//
//  UpdateGroupModel.swift
//  SearchPoint
//
//  Created by Mishra, Vinay on 02/09/21.
//

import Foundation
struct UpdateGroupModel: Codable {

    var groupId: String?
    var groupName: String?
    var groupTypeId: Int?
    var groupStatusId: Int?
    var description: String?
    var animalIds = [String]()


}
