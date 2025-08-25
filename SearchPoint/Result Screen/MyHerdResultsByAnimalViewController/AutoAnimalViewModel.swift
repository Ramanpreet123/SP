//
//  AutoAnimalViewModel.swift
//  SearchPoint
//
//  Created by Rajni Raswant on 17/10/24.
//

class AutoAnimalViewModel {
  var autoAnimalData = [AutoAnimalList]()
  var filterAutoAnimalData = [AutoAnimalList]()
  init() {
  }
  
  func fetchAnimalList() {
    autoAnimalData.removeAll()
    let customerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64
    
    autoAnimalData = fetchAutoAnimalCustomer(entityName: Entities.getAutoAnimalListEntity, customerID: customerId ?? 0) as! [AutoAnimalList]
  }
}
