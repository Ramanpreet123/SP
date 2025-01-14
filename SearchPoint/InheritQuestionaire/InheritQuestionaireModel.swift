//
//  InheritQuestionaireModel.swift
//  SearchPoint
//
//  Created by "" 16/03/20.
//

import Foundation

enum BreedType: Int {
    case primary = 0
    case secondary = 1
    case tertiary = 2
}

class InheritQuestionaireManager {
    static let shared = InheritQuestionaireManager()
    var inheritQuestionaireModel: InheritQuestionaireModel?
}

class BreedQuestion {
    var breedId = ""
    var title = ""
    var isSelected = false
    
    init(title: String, breedId: String) {
        self.title = title
        self.breedId = breedId
    }
}

class InheritQuestionaireModel {
    
    var selectedPrimaryBreed = ""
    var selectedPrimaryBreedId = ""
    var primaryHerdBreed = [BreedQuestion]()
    var currentActiveBreedType = BreedType.primary
    var currentActiveBreedTypeIntValue = 0
    
    init() {
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        let breeds = fetchproviderProductDataGlobal(entityName: Entities.getBreedsTblEntity, provId: pvid, productId: 20)
        
        if breeds.count > 0 {
            for breed in breeds as? [GetBreedsTbl] ?? [] {
                primaryHerdBreed.append(BreedQuestion(title: breed.breedName ?? "", breedId: breed.breedId ?? ""))
            }
        }
        
    }
    
    //MARK :- Set saved selected breed questionnaire
    func setSelectedBreedQuesionnaire() {
        let selectedBreedQuestionnaires = fetchAllData(entityName: Entities.selectedQuesTblEntity)
        
        
        if selectedBreedQuestionnaires.count > 0 {
            if let selectedBreedQuestionnaire = selectedBreedQuestionnaires[0] as? SelectedQuestionaire {
                self.selectedPrimaryBreed = selectedBreedQuestionnaire.primaryBreed ?? ""
                self.selectedPrimaryBreedId = selectedBreedQuestionnaire.primaryBreedId ?? ""
                
                for breed in primaryHerdBreed {
                    if breed.title == self.selectedPrimaryBreed {
                        breed.isSelected = true
                    }
                }
            }
        }
    }
    
    func getSelectedBreedType() -> String {
         if !self.selectedPrimaryBreed.isEmpty{
            return self.selectedPrimaryBreed
        } else {
            return  LocalizedStrings.breedNameX
        }
    }
    
    //MARK :- Save selected breed questionnaire
    func saveSelectedBreedQuestionaire() {
        self.selectedPrimaryBreed = ""
        self.selectedPrimaryBreedId = ""
        
        //Save Selected dPrimary breed
        for breed in primaryHerdBreed {
            if breed.isSelected {
                selectedPrimaryBreed = breed.title
                selectedPrimaryBreedId = breed.breedId
            }
        }
        
        deleteRecordFromDatabase(entityName: Entities.selectedQuesTblEntity)
        saveSelectedQuestionaire(entityName: Entities.selectedQuesTblEntity, primaryBreed: selectedPrimaryBreed, primaryBreedId: selectedPrimaryBreedId)
    }
    
}
