//
//  GetPriorityBreedingModel.swift
//  SearchPoint
//
//  Created by "" on 12/03/20.
//

import Foundation
struct GetPriorityBreedingModel :Codable{
    
       let primaryBreedingPrograms, secondaryBreedingPrograms, tertiaryBreedingPrograms: [AryBreedingProgram]
        let responseCode: Int?
        let errorDetail, message: String?
    }

    // MARK: - AryBreedingProgram
    struct AryBreedingProgram: Codable {
        let breedingProgramID, breedingProgram: String?

        enum CodingKeys: String, CodingKey {
            case breedingProgramID = "breedingProgramId"
            case breedingProgram
        }
    }
