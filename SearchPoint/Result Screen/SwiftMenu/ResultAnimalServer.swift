//
//  ResultAnimalServer.swift
//  SearchPoint
//
//  Created by alok yadav on 20/09/21.
//

import Foundation

struct ResultAnimalServer: Codable {
    var groupId: String?
    var animalIds = [String] ()
    
    init(groupId:String) {
        self.groupId = groupId
        let array = addanimalfetchServer(entityName: Entities.resultGroupAnimalsTblEntity, customerId:UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64 ?? 0, gId: self.groupId ?? "")
        
        if array.count > 0
        {
            for item in array
            {
                let data = item as? ResultGroupsAnimals
                let animalid = data?.animalID
                animalIds.append(animalid ?? "")
            }
        }
    }
}

struct AnimalIds:Codable {
    var animalId: String?
}
