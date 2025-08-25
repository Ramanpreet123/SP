//
//  ADHAnimalVM.swift
//  SearchPoint
//
//  Created by Mobile Programming on 14/06/22.
//

import UIKit
import MBProgressHUD

//MARK: ADH ANIMAL VIEW MODEL
class ADHAnimalVM: BaseViewModel {
    var userService: UserServiceProtocol
    var adhAnimalData = [AnimalMaster]()
    var filterAdhAnimalData = [AnimalMaster]()
    var selectedAnimals = [AnimalMaster]()
    var cartAnimals = [AnimaladdTbl]()
    var sortingType: String?
    
    init(userService: UserServiceProtocol) {
        self.userService = userService
    }
    
    func fetchADHAnimalList(userId: Int, customerID: Int) {
        adhAnimalData.removeAll()
        let specieID = SpeciesID.dairySpeciesId
        let breedID  =  UserDefaults.standard.value(forKey: keyValue.breed.rawValue) as? String ?? ""
        
        adhAnimalData = SearchPoint.fetchADHAnimalList(entityName: Entities.animalMasterTblEntity, customerId: customerID, userID: 1, specieID: specieID, breedID: breedID, gender: "F", isADHCart: false) as! [AnimalMaster]
        self.applySorting()
        self.isSuccess = true
    }
    
    func fetchFilteredADHAnimalList(userId: Int, customerID: Int, fromDate: String, toDate: String,gender: String,breedID: String) {
        adhAnimalData.removeAll()
        let specieID = SpeciesID.dairySpeciesId
        adhAnimalData = SearchPoint.fetchADHAnimalList(entityName: Entities.animalMasterTblEntity, customerId: customerID, userID: userId, specieID: specieID, breedID: breedID, gender: gender, isADHCart: false) as! [AnimalMaster]
        let filteredDataFromDate = adhAnimalData.filter {($0.date!).toDate(DateFormatters.ddMMyyyyFormat) > fromDate.toDate(DateFormatters.MMddyyyyFormat)}
        let filteredDataToDate  = filteredDataFromDate.filter { ($0.date!).toDate(DateFormatters.ddMMyyyyFormat) < toDate.toDate(DateFormatters.MMddyyyyFormat) }
        
        adhAnimalData = filteredDataToDate
        applySorting()
        self.isSuccess = true
    }
    
    func applySorting() {
        if self.sortingType == "farmIdAscending" {
            self.adhAnimalData = self.adhAnimalData.sorted {
                ($0.farmId ?? "").localizedStandardCompare($1.farmId ?? "") == .orderedAscending
            }
        } else if self.sortingType == "farmIdDescending" {
            self.adhAnimalData = self.adhAnimalData.sorted {
                ($0.farmId ?? "").localizedStandardCompare($1.farmId ?? "") == .orderedDescending
            }
        } else if self.sortingType == "officialIdDescending" {
            self.adhAnimalData = self.adhAnimalData.sorted {
                ($0.animalTag ?? "").localizedStandardCompare($1.animalTag ?? "") == .orderedDescending
            }
        } else {
            // Default: officialIdAscending
            self.adhAnimalData = self.adhAnimalData.sorted {
                ($0.animalTag ?? "").localizedStandardCompare($1.animalTag ?? "") == .orderedAscending
            }
        }
    }
    
    func fetchCartAnimals() -> [AnimaladdTbl]  {
        cartAnimals.removeAll()
        cartAnimals = SearchPoint.fetchAllData(entityName: Entities.animalAddTblEntity) as! [AnimaladdTbl]
        return cartAnimals
    }
    
    func updateADHListToClearAnimals() {
        SearchPoint.updateADhListToClearAllSelection(entity: Entities.animalMasterTblEntity)
    }
    
    func updateADhListToHideExpansion() {
        SearchPoint.updateADhListToHideExpansion(entity: Entities.animalMasterTblEntity)
    }
    
    func removeDuplicateElements(animalData: [AnimalMaster]) -> [AnimalMaster] {
        var uniqueAnimal = [AnimalMaster]()
        for animal in animalData {
            if !uniqueAnimal.contains(where: { $0.farmId == animal.farmId && $0.animalTag == animal.animalTag }) {
                uniqueAnimal.append(animal)
            }
        }
        return uniqueAnimal
    }
}

extension DispatchQueue {
    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
    
}
