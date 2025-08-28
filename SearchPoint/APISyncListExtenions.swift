//
//  APISyncListExtenions.swift
//  SearchPoint
//
//  Created by Mobile Programming on 21/02/24.
//

import Foundation
import Alamofire

// MARK: POST LIST DATA BEEF

extension ApiSyncList {
    
    func postListDataBeef(listId:Int64,custmerId:Int64,listName: String = "") {
        let animaltbl = fetchAllDataAnimalDaWithOutOrderIdserverAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,userId:userId,orderStatus:"false",listid:listId,custmerId:custmerId,providerId:UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue),serverAnimalId:"")
        
        let editCaseData = fetchAllDataEditCondition(entityName: Entities.dataEntryBeefAnimalAddTblEntity,userId:userId,orderStatus:"false",listid:listId,custmerId:custmerId,providerId:UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue),serverAnimalId:"")
        
        if animaltbl.count == 0 && editCaseData.count == 0 {
            self.delegeteSyncApi?.didFinishApi(response: "true")
            return
        }
        
        var breedAssociationId = String()
        var breedAssociationId1 = String()
        var sireIDAUbreedAssociationId1 = String()
        var sireRegAssocationbreedAssociationId = String()
        var breedAssociationIdInherit = String()
        var secondaRyBreedingId = String()
        var priorityBreedingId = String()
        var tertiaryBreedingId = String()
        
        var datee = String()
        if listName == ""{
            let fetchName = fetchListNameAccordingToListId(entityName: Entities.dataEntryListTblEntity,customerId:Int(custmerId ),listId:listId,providerId:UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
            if fetchName.count != 0{
                let getName = fetchName.object(at: 0) as? DataEntryList
                self.getListName = getName?.listName ?? ""
                self.descriptionName = getName?.listDesc ?? ""
            }
        } else {
            self.getListName = listName
        }
        
        apiSyncListClass.addAnimals.removeAll()
        for item in animaltbl{
            var ob = Animal()
            if let value = item as? DataEntryBeefAnimaladdTbl{
                
                if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 5  {
                    if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
                        
                        ob.deviceAnimalID = Int(value.animalId)
                        let serverAnimalId = value.serverAnimalId
                        if serverAnimalId != "" {
                            ob.animalID = serverAnimalId
                        }
                        
                        if value.date != "" {
                            print(value)
                            datee = getOrderDateChange(date: value.date ?? "")
                            ob.dob = datee
                        }
                        
                        let medbreedRegArr = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 19, association: value.farmId ?? "")
                        
                        if medbreedRegArr.count != 0 {
                            let medbreedRegArr1 = medbreedRegArr.object(at: 0) as? GetBreedSocieties
                            breedAssociationId =   medbreedRegArr1!.associationId ?? ""
                            ob.breedAssociationId = breedAssociationId
                        }
                        
                        let nationHerdAU = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 19, association: value.nationHerdAU ?? "")
                        if nationHerdAU.count != 0 {
                            let nationHerdAU1 = nationHerdAU.object(at: 0) as? GetBreedSocieties
                            breedAssociationId1 =   nationHerdAU1?.associationId ?? ""
                            ob.damAssociationId = breedAssociationId1
                        }
                        
                        
                        let sireIDAU = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 19, association: value.sireIDAU ?? "")
                        if sireIDAU.count != 0 {
                            let sireIDAU1 = sireIDAU.object(at: 0) as? GetBreedSocieties
                            sireIDAUbreedAssociationId1 =   sireIDAU1?.associationId ?? ""
                            ob.sireAssociationId = sireIDAUbreedAssociationId1
                        }
                        
                        ob.earTag = value.animalTag //barcode genotype
                        ob.sampleBarCode = value.animalbarCodeTag ///animal genotype
                        ob.bornTypeId = Int(value.selectedBornTypeId)
                        if value.eT != ""{
                            ob.animalName = value.eT
                        }
                        
                        if value.offsireId != "" {
                            ob.sireRegNumber = value.offsireId
                        }
                        
                        if value.offDamId != ""{
                            ob.damRegNumber = value.offDamId
                        }
                        
                        if value.offPermanentId != "" {
                            ob.breedRegNumber = value.offPermanentId
                        }
                        
                        if value.breedId == "" {
                            ob.breedId = brazilianBreedId
                        } else {
                            ob.breedId = value.breedId
                            
                        }
                        ob.speciesId = SpeciesID.beefSpeciesId
                        
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        } else {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                        
                        
                        
                        
                        
                    } else { //INHERIT
                        
                        ob.deviceAnimalID = Int(value.animalId)
                        let serverAnimalId = value.serverAnimalId
                        if serverAnimalId != "" {
                            ob.animalID = serverAnimalId
                        }
                        
                        if value.date != "" {
                            print(value)
                            datee = getOrderDateChange(date: value.date ?? "")
                        }
                        let medbreedRegArr = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 20, association: value.eT ?? "")
                        if medbreedRegArr.count != 0 {
                            
                            let medbreedRegArr1 = medbreedRegArr.object(at: 0) as? GetBreedSocieties
                            breedAssociationIdInherit =   medbreedRegArr1!.associationId ?? ""
                            ob.breedAssociationId = breedAssociationIdInherit
                            
                        }
                        
                        let sireRegAssocation = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 20, association: value.sireRegAssocation ?? "")
                        if sireRegAssocation.count != 0 {
                            
                            let medbreedRegArr1 = sireRegAssocation.object(at: 0) as? GetBreedSocieties
                            sireRegAssocationbreedAssociationId =   medbreedRegArr1!.associationId ?? ""
                            ob.sireAssociationId = sireRegAssocationbreedAssociationId
                        }
                        
                        ob.earTag = value.animalTag //barcode genotype
                        ob.sampleBarCode = value.animalbarCodeTag ///animal genotype
                        
                        if value.offsireId != ""{
                            ob.sireRegNumber = value.offsireId
                        }
                        if value.offPermanentId != ""{
                            ob.breedRegNumber = value.offPermanentId
                        }
                        
                        let numberFromString = value.sireYOB ?? "0"
                        let inTd = Int(numberFromString)
                        if numberFromString != "" {
                            ob.sireYOB = inTd ?? 0
                        }
                        
                        if value.offDamId != "" {
                            ob.damId = value.offDamId
                        }
                        
                        let damYOBString = value.damYOB ?? "0"
                        let inTddamYOB = Int(damYOBString)
                        if numberFromString != "" {
                            ob.damYOB = inTddamYOB ?? 0
                            
                        }
                        ob.speciesId = SpeciesID.beefSpeciesId
                        if value.breedId != "" {
                            ob.breedId = value.breedId
                        }
                        
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        } else {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                        ob.dob = datee
                        ob.nationalHerdId = value.nationHerdAU
                        ob.breedRegistrationNumber = value.sireIDAU
                        ////ob.sireI
                    }
                }
                
                if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 6  {
                    
                    if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeOnly.rawValue{
                        // GENOTYPE
                        ob.deviceAnimalID = Int(value.animalId)
                        let serverAnimalId = value.serverAnimalId
                        if serverAnimalId != "" {
                            ob.animalID = serverAnimalId
                        }
                        
                        let priorityBreeding = fetchAllDataPriorityData(entityName: Entities.getPriorityBreedingTblEntity, priorityBreedId: value.sireIDAU ?? "")
                        
                        if priorityBreeding.count != 0 {
                            
                            let medbreedRegArr1 = priorityBreeding.object(at: 0) as? GetPriorityBreeding
                            priorityBreedingId =   medbreedRegArr1!.priorityBreedId ?? ""
                            ob.primaryPriorityProgramId = priorityBreedingId
                        }
                        
                        let secondaRypriorityBreeding = fetchAllDataPriorityData(entityName: Entities.getSecondaryBreedingProgramsTblEntity, priorityBreedId: value.nationHerdAU ?? "")
                        
                        if secondaRypriorityBreeding.count != 0 {
                            
                            let secondaRy = secondaRypriorityBreeding.object(at: 0) as? GetSecondaryBreedingPrograms
                            secondaRyBreedingId =   secondaRy!.priorityBreedId ?? ""
                            ob.secondaryPriorityProgramId = secondaRyBreedingId
                        }
                        let tertiaryPriorityBreeding = fetchAllDataPriorityData(entityName: Entities.getTertiaryBreedingProgramsTblEntity, priorityBreedId: value.nationHerdAU ?? "")
                        
                        if tertiaryPriorityBreeding.count != 0 {
                            
                            let tertiaryRy = tertiaryPriorityBreeding.object(at: 0) as? GetTertiaryBreedingPrograms
                            tertiaryBreedingId =   tertiaryRy!.priorityBreedId ?? ""
                            ob.tertiaryPriorityProgramId = tertiaryBreedingId
                            
                        }
                        if value.date != "" {
                            
                            datee = getOrderDateChange(date: value.date ?? "")
                            ob.dob = datee
                        }
                        
                        if value.animalTag != ""{
                            ob.sampleBarCode = value.animalTag
                        }
                        ob.speciesId = SpeciesID.beefSpeciesId
                        if value.offsireId != "" {
                            ob.series = value.offsireId
                        }
                        
                        if value.offDamId != ""{
                            ob.rgd = value.offDamId
                        }
                        
                        if value.offPermanentId != "" {
                            ob.rgn = value.offPermanentId
                        }
                        
                        if value.animalbarCodeTag != ""{
                            ob.animalName = value.animalbarCodeTag
                        }
                        
                        if value.breedId == "" {
                            ob.breedId = brazilianBreedId
                        } else {
                            ob.breedId = value.breedId
                            
                        }
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        }  else {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                        
                    }
                    else if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeStarBlack.rawValue
                    {
                        // GENOTYPE
                        ob.deviceAnimalID = Int(value.animalId)
                        let serverAnimalId = value.serverAnimalId
                        if serverAnimalId != "" {
                            ob.animalID = serverAnimalId
                        }
                        
                        let priorityBreeding = fetchAllDataPriorityData(entityName: Entities.getPriorityBreedingTblEntity, priorityBreedId: value.sireIDAU ?? "")
                        
                        if priorityBreeding.count != 0 {
                            
                            let medbreedRegArr1 = priorityBreeding.object(at: 0) as? GetPriorityBreeding
                            priorityBreedingId =   medbreedRegArr1!.priorityBreedId ?? ""
                            ob.primaryPriorityProgramId = priorityBreedingId
                        }
                        
                        let secondaRypriorityBreeding = fetchAllDataPriorityData(entityName: Entities.getSecondaryBreedingProgramsTblEntity, priorityBreedId: value.nationHerdAU ?? "")
                        
                        if secondaRypriorityBreeding.count != 0 {
                            
                            let secondaRy = secondaRypriorityBreeding.object(at: 0) as? GetSecondaryBreedingPrograms
                            secondaRyBreedingId =   secondaRy!.priorityBreedId ?? ""
                            ob.secondaryPriorityProgramId = secondaRyBreedingId
                        }
                        let tertiaryPriorityBreeding = fetchAllDataPriorityData(entityName: Entities.getTertiaryBreedingProgramsTblEntity, priorityBreedId: value.nationHerdAU ?? "")
                        
                        if tertiaryPriorityBreeding.count != 0 {
                            
                            let tertiaryRy = tertiaryPriorityBreeding.object(at: 0) as? GetTertiaryBreedingPrograms
                            tertiaryBreedingId =   tertiaryRy!.priorityBreedId ?? ""
                            ob.tertiaryPriorityProgramId = tertiaryBreedingId
                            
                        }
                        if value.date != "" {
                            
                            datee = getOrderDateChange(date: value.date ?? "")
                            ob.dob = datee
                        }
                        
                        if value.animalTag != ""{
                            ob.sampleBarCode = value.animalTag
                        }
                        ob.speciesId = SpeciesID.beefSpeciesId
                        if value.offsireId != "" {
                            ob.series = value.offsireId
                        }
                        
                        if value.offDamId != ""{
                            ob.rgd = value.offDamId
                        }
                        
                        if value.offPermanentId != "" {
                            ob.rgn = value.offPermanentId
                        }
                        
                        if value.animalbarCodeTag != ""{
                            ob.animalName = value.animalbarCodeTag
                        }
                        
                        if value.breedId == "" {
                            ob.breedId = brazilianBreedId
                        } else {
                            ob.breedId = value.breedId
                            
                        }
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        }  else {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                        
                    }
                    else if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genStarBlack.rawValue
                    { //nonGenotype
                        
                        ob.deviceAnimalID = Int(value.animalId)
                        let serverAnimalId = value.serverAnimalId
                        if serverAnimalId != "" {
                            ob.animalID = serverAnimalId
                        }
                        
                        if value.date != "" {
                            datee = getOrderDateChange(date: value.date ?? "")
                            ob.dob = datee
                        }
                        
                        if value.animalTag != ""{
                            ob.sampleBarCode = value.animalTag
                        }
                        if value.animalbarCodeTag != ""{
                            ob.animalName = value.animalbarCodeTag
                        }
                        if value.offsireId != "" {
                            ob.series = value.offsireId
                        }
                        if value.offDamId != ""{
                            ob.rgd = value.offDamId
                        }
                        if value.offPermanentId != "" {
                            ob.rgn = value.offPermanentId
                        }
                        ob.speciesId = SpeciesID.beefSpeciesId
                        if value.breedId == "" {
                            ob.breedId = brazilianBreedId
                        } else {
                            ob.breedId = value.breedId
                            
                        }
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        }  else {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                    }
                    else { //nonGenotype
                        
                        ob.deviceAnimalID = Int(value.animalId)
                        let serverAnimalId = value.serverAnimalId
                        if serverAnimalId != "" {
                            ob.animalID = serverAnimalId
                        }
                        
                        if value.date != "" {
                            datee = getOrderDateChange(date: value.date ?? "")
                            ob.dob = datee
                        }
                        
                        if value.animalTag != ""{
                            ob.sampleBarCode = value.animalTag
                        }
                        if value.animalbarCodeTag != ""{
                            ob.animalName = value.animalbarCodeTag
                        }
                        if value.offsireId != "" {
                            ob.series = value.offsireId
                        }
                        if value.offDamId != ""{
                            ob.rgd = value.offDamId
                        }
                        if value.offPermanentId != "" {
                            ob.rgn = value.offPermanentId
                        }
                        ob.speciesId = SpeciesID.beefSpeciesId
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        }  else {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                    }
                }
           
            }
            apiSyncListClass.addAnimals.append(ob)
            ob = Animal()
        }
        apiSyncListClass.updateAnimals.removeAll()
        for item in editCaseData{
            
            var ob = Animal()
            if let value = item as? DataEntryBeefAnimaladdTbl{
                
                 if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 5  {
                    if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
                        
                        ob.deviceAnimalID = Int(value.animalId)
                        let serverAnimalId = value.serverAnimalId
                        if serverAnimalId != "" {
                            ob.animalID = serverAnimalId
                        }
                        
                        if value.date != "" {
                            print(value)
                            datee = getOrderDateChange(date: value.date ?? "")
                            ob.dob = datee
                        }
                        
                        let medbreedRegArr = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 19, association: value.farmId ?? "")
                        
                        if medbreedRegArr.count != 0 {
                            let medbreedRegArr1 = medbreedRegArr.object(at: 0) as? GetBreedSocieties
                            breedAssociationId =   medbreedRegArr1!.associationId ?? ""
                            ob.breedAssociationId = breedAssociationId
                        }
                        
                        let nationHerdAU = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 19, association: value.nationHerdAU ?? "")
                        if nationHerdAU.count != 0 {
                            let nationHerdAU1 = nationHerdAU.object(at: 0) as? GetBreedSocieties
                            breedAssociationId1 =   nationHerdAU1?.associationId ?? ""
                            ob.damAssociationId = breedAssociationId1
                        }
                        
                        
                        let sireIDAU = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 19, association: value.sireIDAU ?? "")
                        if sireIDAU.count != 0 {
                            let sireIDAU1 = sireIDAU.object(at: 0) as? GetBreedSocieties
                            sireIDAUbreedAssociationId1 =   sireIDAU1?.associationId ?? ""
                            ob.sireAssociationId = sireIDAUbreedAssociationId1
                        }
                        
                        ob.earTag = value.animalTag //barcode genotype
                        ob.sampleBarCode = value.animalbarCodeTag ///animal genotype
                        ob.bornTypeId = Int(value.selectedBornTypeId)
                        if value.eT != ""{
                            ob.animalName = value.eT
                        }
                        
                        if value.offsireId != "" {
                            ob.sireRegNumber = value.offsireId
                        }
                        
                        if value.offDamId != ""{
                            ob.damRegNumber = value.offDamId
                        }
                        
                        if value.offPermanentId != "" {
                            ob.breedRegNumber = value.offPermanentId
                        }
                        
                        if value.breedId == "" {
                            ob.breedId = brazilianBreedId
                        } else {
                            ob.breedId = value.breedId
                            
                        }
                        ob.speciesId = SpeciesID.beefSpeciesId
                        
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        }  else {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                        
                        
                    } else { //INHERIT
                        
                        ob.deviceAnimalID = Int(value.animalId)
                        let serverAnimalId = value.serverAnimalId
                        if serverAnimalId != "" {
                            ob.animalID = serverAnimalId
                        }
                        
                        if value.date != "" {
                            print(value)
                            datee = getOrderDateChange(date: value.date ?? "")
                        }
                        let medbreedRegArr = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 20, association: value.eT ?? "")
                        if medbreedRegArr.count != 0 {
                            
                            let medbreedRegArr1 = medbreedRegArr.object(at: 0) as? GetBreedSocieties
                            breedAssociationIdInherit =   medbreedRegArr1!.associationId ?? ""
                            ob.breedAssociationId = breedAssociationIdInherit
                            
                        }
                        
                        let sireRegAssocation = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 20, association: value.sireRegAssocation ?? "")
                        if sireRegAssocation.count != 0 {
                            
                            let medbreedRegArr1 = sireRegAssocation.object(at: 0) as? GetBreedSocieties
                            sireRegAssocationbreedAssociationId =   medbreedRegArr1!.associationId ?? ""
                            ob.sireAssociationId = sireRegAssocationbreedAssociationId
                        }
                        
                        ob.earTag = value.animalTag //barcode genotype
                        ob.sampleBarCode = value.animalbarCodeTag ///animal genotype
                        
                        if value.offsireId != ""{
                            ob.sireRegNumber = value.offsireId
                        }
                        if value.offPermanentId != ""{
                            ob.breedRegNumber = value.offPermanentId
                        }
                        
                        let numberFromString = value.sireYOB ?? "0"
                        let inTd = Int(numberFromString)
                        if numberFromString != "" {
                            ob.sireYOB = inTd ?? 0
                        }
                        
                        if value.offDamId != "" {
                            ob.damId = value.offDamId
                        }
                        
                        let damYOBString = value.damYOB ?? "0"
                        let inTddamYOB = Int(damYOBString)
                        if numberFromString != "" {
                            ob.damYOB = inTddamYOB ?? 0
                            
                        }
                        ob.speciesId = SpeciesID.beefSpeciesId
                        if value.breedId != "" {
                            ob.breedId = value.breedId
                        }
                        
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        }  else {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                        ob.dob = datee
                        ob.nationalHerdId = value.nationHerdAU
                        ob.breedRegistrationNumber = value.sireIDAU
                    }
                }
                
                else if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 6  {
                    if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeOnly.rawValue{
                        // GENOTYPE
                        ob.deviceAnimalID = Int(value.animalId)
                        let serverAnimalId = value.serverAnimalId
                        if serverAnimalId != "" {
                            ob.animalID = serverAnimalId
                        }
                        
                        let priorityBreeding = fetchAllDataPriorityData(entityName: Entities.getPriorityBreedingTblEntity, priorityBreedId: value.sireIDAU ?? "")
                        
                        if priorityBreeding.count != 0 {
                            
                            let medbreedRegArr1 = priorityBreeding.object(at: 0) as? GetPriorityBreeding
                            priorityBreedingId =   medbreedRegArr1!.priorityBreedId ?? ""
                            ob.primaryPriorityProgramId = priorityBreedingId
                        }
                        
                        let secondaRypriorityBreeding = fetchAllDataPriorityData(entityName: Entities.getSecondaryBreedingProgramsTblEntity, priorityBreedId: value.nationHerdAU ?? "")
                        
                        if secondaRypriorityBreeding.count != 0 {
                            
                            let secondaRy = secondaRypriorityBreeding.object(at: 0) as? GetSecondaryBreedingPrograms
                            secondaRyBreedingId =   secondaRy!.priorityBreedId ?? ""
                            ob.secondaryPriorityProgramId = secondaRyBreedingId
                        }
                        let tertiaryPriorityBreeding = fetchAllDataPriorityData(entityName: Entities.getTertiaryBreedingProgramsTblEntity, priorityBreedId: value.nationHerdAU ?? "")
                        
                        if tertiaryPriorityBreeding.count != 0 {
                            
                            let tertiaryRy = tertiaryPriorityBreeding.object(at: 0) as? GetTertiaryBreedingPrograms
                            tertiaryBreedingId =   tertiaryRy!.priorityBreedId ?? ""
                            ob.tertiaryPriorityProgramId = tertiaryBreedingId
                            
                        }
                        if value.date != "" {
                            
                            datee = getOrderDateChange(date: value.date ?? "")
                            ob.dob = datee
                        }
                        
                        if value.animalTag != ""{
                            ob.sampleBarCode = value.animalTag
                        }
                        ob.speciesId = SpeciesID.beefSpeciesId
                        if value.offsireId != "" {
                            ob.series = value.offsireId
                        }
                        
                        if value.offDamId != ""{
                            ob.rgd = value.offDamId
                        }
                        
                        if value.offPermanentId != "" {
                            ob.rgn = value.offPermanentId
                        }
                        
                        if value.animalbarCodeTag != ""{
                            ob.animalName = value.animalbarCodeTag
                        }
                        
                        if value.breedId == "" {
                            ob.breedId = brazilianBreedId
                        } else {
                            ob.breedId = value.breedId
                            
                        }
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        }  else {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                        
                    }
                    else if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeStarBlack.rawValue
                    {
                        // GENOTYPE
                        ob.deviceAnimalID = Int(value.animalId)
                        let serverAnimalId = value.serverAnimalId
                        if serverAnimalId != "" {
                            ob.animalID = serverAnimalId
                        }
                        
                        let priorityBreeding = fetchAllDataPriorityData(entityName: Entities.getPriorityBreedingTblEntity, priorityBreedId: value.sireIDAU ?? "")
                        
                        if priorityBreeding.count != 0 {
                            
                            let medbreedRegArr1 = priorityBreeding.object(at: 0) as? GetPriorityBreeding
                            priorityBreedingId =   medbreedRegArr1!.priorityBreedId ?? ""
                            ob.primaryPriorityProgramId = priorityBreedingId
                        }
                        
                        let secondaRypriorityBreeding = fetchAllDataPriorityData(entityName: Entities.getSecondaryBreedingProgramsTblEntity, priorityBreedId: value.nationHerdAU ?? "")
                        
                        if secondaRypriorityBreeding.count != 0 {
                            
                            let secondaRy = secondaRypriorityBreeding.object(at: 0) as? GetSecondaryBreedingPrograms
                            secondaRyBreedingId =   secondaRy!.priorityBreedId ?? ""
                            ob.secondaryPriorityProgramId = secondaRyBreedingId
                        }
                        let tertiaryPriorityBreeding = fetchAllDataPriorityData(entityName: Entities.getTertiaryBreedingProgramsTblEntity, priorityBreedId: value.nationHerdAU ?? "")
                        
                        if tertiaryPriorityBreeding.count != 0 {
                            
                            let tertiaryRy = tertiaryPriorityBreeding.object(at: 0) as? GetTertiaryBreedingPrograms
                            tertiaryBreedingId =   tertiaryRy!.priorityBreedId ?? ""
                            ob.tertiaryPriorityProgramId = tertiaryBreedingId
                            
                        }
                        if value.date != "" {
                            
                            datee = getOrderDateChange(date: value.date ?? "")
                            ob.dob = datee
                        }
                        
                        if value.animalTag != ""{
                            ob.sampleBarCode = value.animalTag
                        }
                        ob.speciesId = SpeciesID.beefSpeciesId
                        if value.offsireId != "" {
                            ob.series = value.offsireId
                        }
                        
                        if value.offDamId != ""{
                            ob.rgd = value.offDamId
                        }
                        
                        if value.offPermanentId != "" {
                            ob.rgn = value.offPermanentId
                        }
                        
                        if value.animalbarCodeTag != ""{
                            ob.animalName = value.animalbarCodeTag
                        }
                        
                        if value.breedId == "" {
                            ob.breedId = brazilianBreedId
                        } else {
                            ob.breedId = value.breedId
                            
                        }
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        }  else {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                        
                    }
                    else if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genStarBlack.rawValue
                    { //nonGenotype
                        
                        ob.deviceAnimalID = Int(value.animalId)
                        let serverAnimalId = value.serverAnimalId
                        if serverAnimalId != "" {
                            ob.animalID = serverAnimalId
                        }
                        
                        if value.date != "" {
                            datee = getOrderDateChange(date: value.date ?? "")
                            ob.dob = datee
                        }
                        
                        if value.animalTag != ""{
                            ob.sampleBarCode = value.animalTag
                        }
                        if value.animalbarCodeTag != ""{
                            ob.animalName = value.animalbarCodeTag
                        }
                        if value.offsireId != "" {
                            ob.series = value.offsireId
                        }
                        if value.offDamId != ""{
                            ob.rgd = value.offDamId
                        }
                        if value.offPermanentId != "" {
                            ob.rgn = value.offPermanentId
                        }
                        ob.speciesId = SpeciesID.beefSpeciesId
                        if value.breedId == "" {
                            ob.breedId = brazilianBreedId
                        } else {
                            ob.breedId = value.breedId
                            
                        }
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        }  else {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                    }
                    else { //nonGenotype
                        
                        ob.deviceAnimalID = Int(value.animalId)
                        let serverAnimalId = value.serverAnimalId
                        if serverAnimalId != "" {
                            ob.animalID = serverAnimalId
                        }
                        
                        if value.date != "" {
                            datee = getOrderDateChange(date: value.date ?? "")
                            ob.dob = datee
                        }
                        
                        if value.animalTag != ""{
                            ob.sampleBarCode = value.animalTag
                        }
                        if value.animalbarCodeTag != ""{
                            ob.animalName = value.animalbarCodeTag
                        }
                        if value.offsireId != "" {
                            ob.series = value.offsireId
                        }
                        if value.offDamId != ""{
                            ob.rgd = value.offDamId
                        }
                        if value.offPermanentId != "" {
                            ob.rgn = value.offPermanentId
                        }
                        ob.speciesId = SpeciesID.beefSpeciesId
                        
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        }  else {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                    }
                }
            }
            apiSyncListClass.updateAnimals.append(ob)
            ob = Animal()
        }
        apiSyncListClass.customerId = custId
        apiSyncListClass.listName = getListName
        apiSyncListClass.description = descriptionName
        apiSyncListClass.speciesId = SpeciesID.beefSpeciesId
        apiSyncListClass.providerId = beefpvid
        
        if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 5  {
            if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
                apiSyncListClass.productId = 19
            } else {
                apiSyncListClass.productId = 20
            }
        }
        if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 6  {
            
            if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeOnly.rawValue
            {
                apiSyncListClass.productId = 23
            }
            else if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeStarBlack.rawValue
            {
                apiSyncListClass.productId = 999
            }
            else if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genStarBlack.rawValue
            {
                apiSyncListClass.productId = 24
            }
        }
      
        let jsonEncoder = JSONEncoder()
        var jsonData: Data?
        do {
            jsonData = try jsonEncoder.encode(apiSyncListClass)
            // use jsonData safely
        } catch {
            print("Failed to encode updateGroup: \(error.localizedDescription)")
        }
        
        guard let body = jsonData else {
            print("No JSON data to send")
            return
        }
        let json = String(data: body, encoding: String.Encoding.utf8)
        print(json!)
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + accessToken!]
        let urlString = Configuration.Dev(packet: ApiKeys.saveList.rawValue).getUrl()
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headerDict
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        request.httpBody = body
        
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            
            NotificationCenter.default.post(name: Notification.Name(LocalizedStrings.sessionExpiredStr), object: nil, userInfo: [LocalizedStrings.statusCodeText:"\(String(describing: response.response?.statusCode ?? 0))"])
            if statusCode == 401  {
                
                self.delegeteSyncApi?.failWithError(statusCode: statusCode!)
            }
            else if statusCode == 500 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408 {
                self.delegeteSyncApi?.failWithErrorInternal()
                self.delegeteSyncApi?.failWithError(statusCode: statusCode!)
            }
            
            switch response.result {
            case .success(let responseObject):
                let data = response.data
                let response = responseObject as! NSDictionary
                self.responseRecieved1Beef(data, status: true,listId: Int(listId))
                //  self.delegeteSyncApi?.didFinishApi(response: "true")
                print(response)
                
            case .failure(let encodingError):
                if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                    self.delegeteSyncApi?.failWithErrorInternal()
                    print(err)
                } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                    // other failures
                    print (encodingError)
                    print (responseString)
                    if let s = statusCode {
                        
                        self.delegeteSyncApi?.failWithError(statusCode: s)
                    } else {
                        self.delegeteSyncApi?.failWithErrorInternal()
                    }
                }
            }
        }
    }
    
    func responseRecieved1Beef(_ data: Data?, status: Bool,listId: Int) {
        print(data as Any)
        print(status)
        if data == nil {
            return
        }
        let decoder = JSONDecoder()
        modalObject = try? decoder.decode(SavingResponseModel.self, from: data!)
        if self.modalObject != nil {
            self.saveApiResponseBeef(dataModel:self.modalObject!,listId: listId)
        }
    }
    
    func saveApiResponseBeef(dataModel: SavingResponseModel, listId:Int){
      if dataModel.customerList.animals.count == 0{
        self.delegeteSyncApi?.didFinishApi(response: "false")
        return
      }
        let custmerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int
        let animaltbl = fetchAllDataAnimalDaWithOutOrderIdserverAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,userId:userId,orderStatus:"false",listid:Int64(listId),custmerId:Int64(custmerId),providerId:UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue),serverAnimalId:"")
        
        var duplicateAnimalData = [AnimalResponse]()
        let filteredAnimals = dataModel.customerList.animals.uniqueElement { $0.earTag == $1.earTag && $0.sampleBarCode == $1.sampleBarCode  }
    
        if dataModel.customerList.animals.count < animaltbl.count {
            // some animal are still pending for update
            if animaltbl.count > 0 {
                self.postListDataBeef(listId: Int64(listId), custmerId: Int64(UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int))
            }
        } else if dataModel.customerList.animals.count > filteredAnimals.count {
            
            for animal  in filteredAnimals {
              if pvid == 13{
                let duplicateAnimal = dataModel.customerList.animals.filter({$0.animalTag == animal.animalTag &&  $0.sampleBarCode == animal.sampleBarCode})
                var doubleAnimals = duplicateAnimal
                if let index = duplicateAnimal.firstIndex(where: {$0.animalID == animal.animalID}) {
                    doubleAnimals.remove(at: index)
                }
                
                for aData in doubleAnimals {
                    duplicateAnimalData.append(aData)
                    
                }
              } else {
                let duplicateAnimal = dataModel.customerList.animals.filter({$0.earTag == animal.earTag &&  $0.sampleBarCode == animal.sampleBarCode})
                var doubleAnimals = duplicateAnimal
                if let index = duplicateAnimal.firstIndex(where: {$0.animalID == animal.animalID}) {
                    doubleAnimals.remove(at: index)
                }
                
                for aData in doubleAnimals {
                    duplicateAnimalData.append(aData)
                    
                }
              }
                
               
            }
            print(duplicateAnimalData.count)
            
            if duplicateAnimalData.count>0{
                
                self.deleteDuplicateAnimalsFromSever(animalList: duplicateAnimalData, listId: listId, speciesID: SpeciesID.beefSpeciesId)
            }
        } else {
            
            for item  in filteredAnimals {
                
              updateDataInSaveClick(entity: Entities.dataEntryBeefAnimalAddTblEntity,serverAnimalId:item.animalID ?? "",farmId:item.onFarmID ?? "",animalTag:item.earTag ?? "",custmerId:custId ,animalId:item.deviceAnimalID ?? 0, listId: listId)
              updateDataInSaveClick(entity: Entities.beefAnimalAddTblEntity,serverAnimalId:item.animalID ?? "",farmId:item.onFarmID ?? "",animalTag:item.earTag ?? "",custmerId:custId ,animalId:item.deviceAnimalID ?? 0, listId: listId)
              updateDataInSaveClick(entity: Entities.beefAnimalMasterTblEntity,serverAnimalId:item.animalID ?? "",farmId:item.onFarmID ?? "",animalTag:item.earTag ?? "",custmerId:custId ,animalId:item.deviceAnimalID ?? 0, listId: listId)
                updadeOfflineSyncInfo(entity: Entities.dataEntryListTblEntity,customerId:custId,offlineSync:true,listid: listId)
                
            }
            self.delegeteSyncApi?.didFinishApi(response: "true")
        }
        
    }
    
    //// Delete List beef
    
    func postListDataDeleteBeef(listId:Int64,custmerId:Int64,clearOrder :Bool,animalId :Int) {
        
        self.apiSyncListClass.deleteAnimals.removeAll()
        self.apiSyncListClass.addAnimals.removeAll()
        self.apiSyncListClass.updateAnimals.removeAll()
        
        if clearOrder {
            self.animaltbl1 = fetchAllDataAnimalDaWithOutOrderId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, userId: userId,orderStatus:"false",listid: Int64(listId ), custmerId: Int64(custmerId ), providerId: pvid)
        } else {
            
            self.animaltbl1 = fetchOneByOneListElements(animalId: Int(animalId), listID: Int(listId),entityName:Entities.dataEntryBeefAnimalAddTblEntity)
            
        }
                
        let fetchName = fetchListNameAccordingToListId(entityName: Entities.dataEntryListTblEntity,customerId:Int(custmerId ),listId:listId,providerId:beefpvid)
        if fetchName.count != 0{
            let getName = fetchName.object(at: 0) as? DataEntryList
            self.getListName = getName?.listName ?? ""
            self.descriptionName = getName?.listDesc ?? ""
        }
        
        for item in animaltbl1{
            
            var ob = Animal()
            if let value = item as? DataEntryBeefAnimaladdTbl{
                let serverAnimalId = value.serverAnimalId
                if serverAnimalId != "" {
                    
                    ob.animalID = serverAnimalId
                }
            }
            apiSyncListClass.deleteAnimals.append(ob)
            ob = Animal()
        }
        
        apiSyncListClass.customerId = custId
        apiSyncListClass.listName = getListName
        apiSyncListClass.description = descriptionName
        apiSyncListClass.speciesId = SpeciesID.beefSpeciesId
        apiSyncListClass.providerId = beefpvid
        let jsonEncoder = JSONEncoder()
        var jsonData: Data?
        do {
            jsonData = try jsonEncoder.encode(apiSyncListClass)
            // use jsonData safely
        } catch {
            print("Failed to encode updateGroup: \(error.localizedDescription)")
        }
        
        guard let body = jsonData else {
            print("No JSON data to send")
            return
        }
        let json = String(data: body, encoding: String.Encoding.utf8)
        print(json!)
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + accessToken!]
        let urlString = Configuration.Dev(packet: ApiKeys.saveList.rawValue).getUrl()
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headerDict
        
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        request.httpBody = body
        
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            
            NotificationCenter.default.post(name: Notification.Name(LocalizedStrings.sessionExpiredStr), object: nil, userInfo: [LocalizedStrings.statusCodeText:"\(String(describing: response.response?.statusCode ?? 0))"])
            if statusCode == 401  {
                
                self.delegeteSyncApi?.failWithError(statusCode: statusCode!)
            }
            else if statusCode == 500 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408 {
                self.delegeteSyncApi?.failWithErrorInternal()
                self.delegeteSyncApi?.failWithError(statusCode: statusCode!)
            }
            
            switch response.result {
                
            case .success(let responseObject):
                let response = responseObject as! NSDictionary
                print(response)
                
            case .failure(let encodingError):
                
                if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                    // no internet connection
                    self.delegeteSyncApi?.failWithErrorInternal()
                    print(err)
                } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                    // other failures
                    print (encodingError)
                    print (responseString)
                    if let s = statusCode {
                        
                        self.delegeteSyncApi?.failWithError(statusCode: s)
                    } else {
                        self.delegeteSyncApi?.failWithErrorInternal()
                    }
                }
            }
        }
    }
    

  
    func postOffineDeleteanimals(species: String){
        var providerId = 0
        if species == SpeciesID.dairySpeciesId {
            providerId = pvid
        } else {
            providerId =  beefpvid
        }
        self.apiSyncListClass.deleteAnimals.removeAll()
        apiSyncListClass.addAnimals.removeAll()
        apiSyncListClass.updateAnimals.removeAll()
        let animals = fetchofflineDeletedAnimals(entityName: Entities.dataEntryOfflineDeletedAnimalTblEntity, serverId: "", speciesID: species) as! [DataEntryOfflineDeletedAnimal]
        let filteredAnimals = animals.uniqueElement { $0.listID == $1.listID}
        for item in filteredAnimals {
            let offlineanimals = animals.filter({$0.listID == item.listID})
            let fetchName = fetchListNameAccordingToListId(entityName: Entities.dataEntryListTblEntity,customerId:Int(custId ),listId:item.listID, providerId:providerId)
            if fetchName.count != 0{
                let getName = fetchName.object(at: 0) as? DataEntryList
                self.getListName = getName?.listName ?? ""
                self.descriptionName = getName?.listDesc ?? ""
            }
            var ob = Animal()
            for a in offlineanimals{
                if let value = a as? DataEntryOfflineDeletedAnimal{
                    let serverAnimalId = value.serverAnimalID
                    if serverAnimalId != "" {
                        ob.animalID = serverAnimalId
                    }
                }
                apiSyncListClass.deleteAnimals.append(ob)
                ob = Animal()
            }
            
            apiSyncListClass.customerId = custId
            apiSyncListClass.listName = getListName
            apiSyncListClass.description = descriptionName
            apiSyncListClass.speciesId = species
            apiSyncListClass.providerId = providerId
            let jsonEncoder = JSONEncoder()
            var jsonData: Data?
            do {
                jsonData = try jsonEncoder.encode(apiSyncListClass)
                // use jsonData safely
            } catch {
                print("Failed to encode updateGroup: \(error.localizedDescription)")
            }
            
            guard let body = jsonData else {
                print("No JSON data to send")
                return
            }
            let json = String(data: body, encoding: String.Encoding.utf8)
            print(json!)
            let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
            let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + accessToken!]
            let urlString = Configuration.Dev(packet: ApiKeys.saveList.rawValue).getUrl()
            var request = URLRequest(url: URL(string: urlString)! )
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headerDict
            
            request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
            request.httpBody = body
            
            AF.request(request as URLRequestConvertible).responseJSON { response in
                let statusCode =  response.response?.statusCode
                
                NotificationCenter.default.post(name: Notification.Name(LocalizedStrings.sessionExpiredStr), object: nil, userInfo: [LocalizedStrings.statusCodeText:"\(String(describing: response.response?.statusCode ?? 0))"])
                if statusCode == 401  {
                    
                    self.delegeteSyncApi?.failWithError(statusCode: statusCode!)
                }
                else if statusCode == 500 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408 {
                    self.delegeteSyncApi?.failWithErrorInternal()
                    self.delegeteSyncApi?.failWithError(statusCode: statusCode!)
                }
                
                switch response.result {
                    
                case .success(_):
                    
                    self.apiSyncListClass.deleteAnimals.removeAll()
                    deleteOfflineDataWithListId(Int(item.listID))
                    
                case .failure(let encodingError):
                    
                    if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                        self.delegeteSyncApi?.failWithErrorInternal()
                        print(err)
                    } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                        print (encodingError)
                        print (responseString)
                        if let s = statusCode {
                            
                            self.delegeteSyncApi?.failWithError(statusCode: s)
                        } else {
                            self.delegeteSyncApi?.failWithErrorInternal()
                        }
                    }
                }
            }
        }
        
    }
    
    func deleteDuplicateAnimalsFromSever(animalList : [AnimalResponse], listId: Int = 0, speciesID :String = SpeciesID.dairySpeciesId){
        self.apiSyncListClass.addAnimals.removeAll()
        if speciesID ==  SpeciesID.dairySpeciesId {
            let fetchName = fetchListNameAccordingToListId(entityName: Entities.dataEntryListTblEntity,customerId:Int(UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int64 ),listId:Int64(listId),providerId:UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue))
            if fetchName.count != 0{
                let getName = fetchName.object(at: 0) as? DataEntryList
                self.getListName = getName?.listName ?? ""
                self.descriptionName = getName?.listDesc ?? ""
            }
        } else {
            let fetchName = fetchListNameAccordingToListId(entityName: Entities.dataEntryListTblEntity,customerId:Int(UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int64 ),listId:Int64(listId),providerId:beefpvid)
            if fetchName.count != 0{
                let getName = fetchName.object(at: 0) as? DataEntryList
                self.getListName = getName?.listName ?? ""
                self.descriptionName = getName?.listDesc ?? ""
            }
        }
        
        for item in animalList{
            
            var ob = Animal()
            if let value = item as? AnimalResponse{
                let serverAnimalId = value.animalID
                if serverAnimalId != "" {
                    ob.animalID = serverAnimalId
                }
                
            }
            apiSyncListClass.deleteAnimals.append(ob)
            ob = Animal()
        }
        apiSyncListClass.customerId = custId
        apiSyncListClass.listName = getListName
        apiSyncListClass.description = descriptionName
        apiSyncListClass.speciesId = speciesID
        if speciesID ==  SpeciesID.dairySpeciesId {
            apiSyncListClass.providerId = pvid
        } else if speciesID == SpeciesID.beefSpeciesId {
            apiSyncListClass.providerId = beefpvid
        }
        
        let jsonEncoder = JSONEncoder()
        var jsonData: Data?
        do {
            jsonData = try jsonEncoder.encode(apiSyncListClass)
            // use jsonData safely
        } catch {
            print("Failed to encode updateGroup: \(error.localizedDescription)")
        }
        
        guard let body = jsonData else {
            print("No JSON data to send")
            return
        }
        let json = String(data: body, encoding: String.Encoding.utf8)
        print(json!)
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + accessToken!]
        let urlString = Configuration.Dev(packet: ApiKeys.saveList.rawValue).getUrl()
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headerDict
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        request.httpBody = body
        
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            
            NotificationCenter.default.post(name: Notification.Name(LocalizedStrings.sessionExpiredStr), object: nil, userInfo: [LocalizedStrings.statusCodeText:"\(String(describing: response.response?.statusCode ?? 0))"])
            if statusCode == 401  {
                
                self.delegeteSyncApi?.failWithError(statusCode: statusCode!)
            }
            else if statusCode == 500 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408 {
                self.delegeteSyncApi?.failWithErrorInternal()
                self.delegeteSyncApi?.failWithError(statusCode: statusCode!)
            }
            
            switch response.result {
                
            case .success(_):
                let data = response.data
                self.apiSyncListClass.deleteAnimals.removeAll()
                if speciesID ==  SpeciesID.dairySpeciesId {
                    self.responseRecieved1(data, status: true, listId: Int(listId))
                } else {
                    self.responseRecieved1Beef(data, status: true, listId: Int(listId))
                }
                
            case .failure(let encodingError):
                
                if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                    self.delegeteSyncApi?.failWithErrorInternal()
                    print(err)
                } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                    // other failures
                    print (encodingError)
                    print (responseString)
                    if let s = statusCode {
                        self.delegeteSyncApi?.failWithError(statusCode: s)
                    } else {
                        self.delegeteSyncApi?.failWithErrorInternal()
                    }
                } else {
                    self.delegeteSyncApi?.failWithErrorInternal()
                }
            }
        }
    }
    
    func postListAddDataBeefOffline() {
        var listID = Int64()
        apiSyncListClass.addAnimals.removeAll()
        apiSyncListClass.updateAnimals.removeAll()
        let animaltbl = fetchAllDataServerAnimalIdWithoutListId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,userId:userId,orderStatus:"false",custmerId:Int64(UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int ?? 0),serverAnimalId:"")
        
        if animaltbl.count == 0  {
            return
        }
        
        var breedAssociationId = String()
        var breedAssociationId1 = String()
        var sireIDAUbreedAssociationId1 = String()
        var sireRegAssocationbreedAssociationId = String()
        var breedAssociationIdInherit = String()
        var secondaRyBreedingId = String()
        var priorityBreedingId = String()
        var tertiaryBreedingId = String()
        
        var datee = String()
        
        for item in animaltbl{
            
            var ob = Animal()
            if let value = item as? DataEntryBeefAnimaladdTbl{
                let fetchName = fetchListNameAccordingToListId(entityName: Entities.dataEntryListTblEntity,customerId:Int(UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int ?? 0),listId:value.listId ,providerId:UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                if fetchName.count != 0{
                    let getName = fetchName.object(at: 0) as? DataEntryList
                    listID = getName?.listId ?? 0
                    self.getListName = getName?.listName ?? ""
                    self.descriptionName = getName?.listDesc ?? ""
                }
                if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 5  {
                    if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
                        
                        ob.deviceAnimalID = Int(value.animalId)
                        let serverAnimalId = value.serverAnimalId
                        if serverAnimalId != "" {
                            ob.animalID = serverAnimalId
                        }
                        
                        if value.date != "" {
                            print(value)
                            datee = getOrderDateChange(date: value.date ?? "")
                            ob.dob = datee
                        }
                        
                        let medbreedRegArr = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 19, association: value.farmId ?? "")
                        
                        if medbreedRegArr.count != 0 {
                            let medbreedRegArr1 = medbreedRegArr.object(at: 0) as? GetBreedSocieties
                            breedAssociationId =   medbreedRegArr1!.associationId ?? ""
                            ob.breedAssociationId = breedAssociationId
                        }
                        
                        let nationHerdAU = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 19, association: value.nationHerdAU ?? "")
                        if nationHerdAU.count != 0 {
                            let nationHerdAU1 = nationHerdAU.object(at: 0) as? GetBreedSocieties
                            breedAssociationId1 =   nationHerdAU1?.associationId ?? ""
                            ob.damAssociationId = breedAssociationId1
                        }
                        
                        
                        let sireIDAU = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 19, association: value.sireIDAU ?? "")
                        if sireIDAU.count != 0 {
                            let sireIDAU1 = sireIDAU.object(at: 0) as? GetBreedSocieties
                            sireIDAUbreedAssociationId1 =   sireIDAU1?.associationId ?? ""
                            ob.sireAssociationId = sireIDAUbreedAssociationId1
                        }
                        
                        ob.earTag = value.animalTag //barcode genotype
                        ob.sampleBarCode = value.animalbarCodeTag ///animal genotype
                        ob.bornTypeId = Int(value.selectedBornTypeId)
                        if value.eT != ""{
                            ob.animalName = value.eT
                        }
                        
                        if value.offsireId != "" {
                            ob.sireRegNumber = value.offsireId
                        }
                        
                        if value.offDamId != ""{
                            ob.damRegNumber = value.offDamId
                        }
                        
                        if value.offPermanentId != "" {
                            ob.breedRegNumber = value.offPermanentId
                        }
                        
                        if value.breedId == "" {
                            ob.breedId = brazilianBreedId
                        } else {
                            ob.breedId = value.breedId
                            
                        }
                        ob.speciesId = SpeciesID.beefSpeciesId
                        
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        }  else {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                        
                        
                        
                        
                        
                    } else { //INHERIT
                        
                        ob.deviceAnimalID = Int(value.animalId)
                        let serverAnimalId = value.serverAnimalId
                        if serverAnimalId != "" {
                            ob.animalID = serverAnimalId
                        }
                        
                        if value.date != "" {
                            print(value)
                            datee = getOrderDateChange(date: value.date ?? "")
                        }
                        let medbreedRegArr = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 20, association: value.eT ?? "")
                        if medbreedRegArr.count != 0 {
                            
                            let medbreedRegArr1 = medbreedRegArr.object(at: 0) as? GetBreedSocieties
                            breedAssociationIdInherit =   medbreedRegArr1!.associationId ?? ""
                            ob.breedAssociationId = breedAssociationIdInherit
                            
                        }
                        
                        let sireRegAssocation = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 20, association: value.sireRegAssocation ?? "")
                        if sireRegAssocation.count != 0 {
                            
                            let medbreedRegArr1 = sireRegAssocation.object(at: 0) as? GetBreedSocieties
                            sireRegAssocationbreedAssociationId =   medbreedRegArr1!.associationId ?? ""
                            ob.sireAssociationId = sireRegAssocationbreedAssociationId
                        }
                        
                        ob.earTag = value.animalTag //barcode genotype
                        ob.sampleBarCode = value.animalbarCodeTag ///animal genotype
                        
                        if value.offsireId != ""{
                            ob.sireRegNumber = value.offsireId
                        }
                        if value.offPermanentId != ""{
                            ob.breedRegNumber = value.offPermanentId
                        }
                        
                        let numberFromString = value.sireYOB ?? "0"
                        let inTd = Int(numberFromString)
                        if numberFromString != "" {
                            ob.sireYOB = inTd ?? 0
                        }
                        
                        if value.offDamId != "" {
                            ob.damId = value.offDamId
                        }
                        
                        let damYOBString = value.damYOB ?? "0"
                        let inTddamYOB = Int(damYOBString)
                        if numberFromString != "" {
                            ob.damYOB = inTddamYOB ?? 0
                            
                        }
                        ob.speciesId = SpeciesID.beefSpeciesId
                        if value.breedId != "" {
                            ob.breedId = value.breedId
                        }
                        
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        }  else {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                        ob.dob = datee
                        ob.nationalHerdId = value.nationHerdAU
                        ob.breedRegistrationNumber = value.sireIDAU
                    }
                }
                
                if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 6  {
                    if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeOnly.rawValue{
                        // GENOTYPE
                        ob.deviceAnimalID = Int(value.animalId)
                        let serverAnimalId = value.serverAnimalId
                        if serverAnimalId != "" {
                            ob.animalID = serverAnimalId
                        }
                        
                        let priorityBreeding = fetchAllDataPriorityData(entityName: Entities.getPriorityBreedingTblEntity, priorityBreedId: value.sireIDAU ?? "")
                        
                        if priorityBreeding.count != 0 {
                            
                            let medbreedRegArr1 = priorityBreeding.object(at: 0) as? GetPriorityBreeding
                            priorityBreedingId =   medbreedRegArr1!.priorityBreedId ?? ""
                            ob.primaryPriorityProgramId = priorityBreedingId
                        }
                        
                        let secondaRypriorityBreeding = fetchAllDataPriorityData(entityName: Entities.getSecondaryBreedingProgramsTblEntity, priorityBreedId: value.nationHerdAU ?? "")
                        
                        if secondaRypriorityBreeding.count != 0 {
                            
                            let secondaRy = secondaRypriorityBreeding.object(at: 0) as? GetSecondaryBreedingPrograms
                            secondaRyBreedingId =   secondaRy!.priorityBreedId ?? ""
                            ob.secondaryPriorityProgramId = secondaRyBreedingId
                        }
                        let tertiaryPriorityBreeding = fetchAllDataPriorityData(entityName: Entities.getTertiaryBreedingProgramsTblEntity, priorityBreedId: value.nationHerdAU ?? "")
                        
                        if tertiaryPriorityBreeding.count != 0 {
                            
                            let tertiaryRy = tertiaryPriorityBreeding.object(at: 0) as? GetTertiaryBreedingPrograms
                            tertiaryBreedingId =   tertiaryRy!.priorityBreedId ?? ""
                            ob.tertiaryPriorityProgramId = tertiaryBreedingId
                            
                        }
                        if value.date != "" {
                            
                            datee = getOrderDateChange(date: value.date ?? "")
                            ob.dob = datee
                        }
                        
                        if value.animalTag != ""{
                            ob.sampleBarCode = value.animalTag
                        }
                        ob.speciesId = SpeciesID.beefSpeciesId
                        if value.offsireId != "" {
                            ob.series = value.offsireId
                        }
                        
                        if value.offDamId != ""{
                            ob.rgd = value.offDamId
                        }
                        
                        if value.offPermanentId != "" {
                            ob.rgn = value.offPermanentId
                        }
                        
                        if value.animalbarCodeTag != ""{
                            ob.animalName = value.animalbarCodeTag
                        }
                        
                        if value.breedId == "" {
                            ob.breedId = brazilianBreedId
                        } else {
                            ob.breedId = value.breedId
                            
                        }
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        }  else {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                        
                    }
                    else if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeStarBlack.rawValue
                    {
                        // GENOTYPE
                        ob.deviceAnimalID = Int(value.animalId)
                        let serverAnimalId = value.serverAnimalId
                        if serverAnimalId != "" {
                            ob.animalID = serverAnimalId
                        }
                        
                        let priorityBreeding = fetchAllDataPriorityData(entityName: Entities.getPriorityBreedingTblEntity, priorityBreedId: value.sireIDAU ?? "")
                        
                        if priorityBreeding.count != 0 {
                            
                            let medbreedRegArr1 = priorityBreeding.object(at: 0) as? GetPriorityBreeding
                            priorityBreedingId =   medbreedRegArr1!.priorityBreedId ?? ""
                            ob.primaryPriorityProgramId = priorityBreedingId
                        }
                        
                        let secondaRypriorityBreeding = fetchAllDataPriorityData(entityName: Entities.getSecondaryBreedingProgramsTblEntity, priorityBreedId: value.nationHerdAU ?? "")
                        
                        if secondaRypriorityBreeding.count != 0 {
                            
                            let secondaRy = secondaRypriorityBreeding.object(at: 0) as? GetSecondaryBreedingPrograms
                            secondaRyBreedingId =   secondaRy!.priorityBreedId ?? ""
                            ob.secondaryPriorityProgramId = secondaRyBreedingId
                        }
                        let tertiaryPriorityBreeding = fetchAllDataPriorityData(entityName: Entities.getTertiaryBreedingProgramsTblEntity, priorityBreedId: value.nationHerdAU ?? "")
                        
                        if tertiaryPriorityBreeding.count != 0 {
                            
                            let tertiaryRy = tertiaryPriorityBreeding.object(at: 0) as? GetTertiaryBreedingPrograms
                            tertiaryBreedingId =   tertiaryRy!.priorityBreedId ?? ""
                            ob.tertiaryPriorityProgramId = tertiaryBreedingId
                            
                        }
                        if value.date != "" {
                            
                            datee = getOrderDateChange(date: value.date ?? "")
                            ob.dob = datee
                        }
                        
                        if value.animalTag != ""{
                            ob.sampleBarCode = value.animalTag
                        }
                        ob.speciesId = SpeciesID.beefSpeciesId
                        if value.offsireId != "" {
                            ob.series = value.offsireId
                        }
                        
                        if value.offDamId != ""{
                            ob.rgd = value.offDamId
                        }
                        
                        if value.offPermanentId != "" {
                            ob.rgn = value.offPermanentId
                        }
                        
                        if value.animalbarCodeTag != ""{
                            ob.animalName = value.animalbarCodeTag
                        }
                        
                        if value.breedId == "" {
                            ob.breedId = brazilianBreedId
                        } else {
                            ob.breedId = value.breedId
                            
                        }
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        }  else {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                        
                    }
                    else if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genStarBlack.rawValue
                    { //nonGenotype
                        
                        ob.deviceAnimalID = Int(value.animalId)
                        let serverAnimalId = value.serverAnimalId
                        if serverAnimalId != "" {
                            ob.animalID = serverAnimalId
                        }
                        
                        if value.date != "" {
                            datee = getOrderDateChange(date: value.date ?? "")
                            ob.dob = datee
                        }
                        
                        if value.animalTag != ""{
                            ob.sampleBarCode = value.animalTag
                        }
                        if value.animalbarCodeTag != ""{
                            ob.animalName = value.animalbarCodeTag
                        }
                        if value.offsireId != "" {
                            ob.series = value.offsireId
                        }
                        if value.offDamId != ""{
                            ob.rgd = value.offDamId
                        }
                        if value.offPermanentId != "" {
                            ob.rgn = value.offPermanentId
                        }
                        ob.speciesId = SpeciesID.beefSpeciesId
                        if value.breedId == "" {
                            ob.breedId = brazilianBreedId
                        } else {
                            ob.breedId = value.breedId
                            
                        }
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        }  else {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                    }
                    else { //nonGenotype
                        
                        ob.deviceAnimalID = Int(value.animalId)
                        let serverAnimalId = value.serverAnimalId
                        if serverAnimalId != "" {
                            ob.animalID = serverAnimalId
                        }
                        
                        if value.date != "" {
                            datee = getOrderDateChange(date: value.date ?? "")
                            ob.dob = datee
                        }
                        
                        if value.animalTag != ""{
                            ob.sampleBarCode = value.animalTag
                        }
                        if value.animalbarCodeTag != ""{
                            ob.animalName = value.animalbarCodeTag
                        }
                        if value.offsireId != "" {
                            ob.series = value.offsireId
                        }
                        if value.offDamId != ""{
                            ob.rgd = value.offDamId
                        }
                        if value.offPermanentId != "" {
                            ob.rgn = value.offPermanentId
                        }
                        if value.breedId == "" {
                            ob.breedId = brazilianBreedId
                        } else {
                            ob.breedId = value.breedId
                            
                        }
                        ob.speciesId = SpeciesID.beefSpeciesId
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        }  else {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                    }
                }
                if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 7  {
                    
                    ob.deviceAnimalID = Int(value.animalId)
                    let serverAnimalId = value.serverAnimalId
                    if serverAnimalId != "" {
                        ob.animalID = serverAnimalId
                    }
                    
                    
                    if value.date != "" {
                        print(value)
                        datee = getOrderDateChange(date: value.date ?? "")
                        ob.dob = datee
                    }
                    if value.animalTag != "" {
                        ob.animalTag = value.animalTag
                    }
                    
                    if value.animalbarCodeTag != ""{
                        ob.sampleBarCode = value.animalbarCodeTag ///animal genotype
                    }
                    
                    if value.eT != "" {
                        ob.animalName = value.eT
                    }
                    
                    if value.offsireId != "" {
                        ob.sireRegNumber = value.offsireId
                    }
                    if value.offDamId != ""{
                        ob.damRegNumber = value.offDamId
                    }
                    ob.speciesId = SpeciesID.beefSpeciesId
                    if value.offPermanentId != ""{
                        ob.breedRegNumber = value.offPermanentId
                    }
                    
                    let sireRegAssocation = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 25, association: value.sireIDAU ?? "")
                    if sireRegAssocation.count != 0 {
                        
                        let medbreedRegArr1 = sireRegAssocation.object(at: 0) as? GetBreedSocieties
                        sireRegAssocationbreedAssociationId =   medbreedRegArr1!.associationId ?? ""
                        ob.breedAssociationId = sireRegAssocationbreedAssociationId
                    }
                    
                    if value.breedId == "" {
                        ob.breedId = brazilianBreedId
                    } else {
                        ob.breedId = value.breedId
                    }
                    
                    ob.sampleTypeId = Int(value.tissuId)
                    let sexName = value.gender ?? ""
                    
                    if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                        
                        nameSex = "F"
                    } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                        nameSex = "M"
                        
                    }  else {
                        nameSex = "F"
                    }
                    
                    ob.sex = nameSex
                }
            }
            apiSyncListClass.addAnimals.append(ob)
            ob = Animal()
        }
        
        apiSyncListClass.customerId = custId
        apiSyncListClass.listName = getListName
        apiSyncListClass.description = descriptionName
        apiSyncListClass.speciesId = SpeciesID.beefSpeciesId
        apiSyncListClass.providerId = beefpvid
        
        if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 5  {
            if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
                apiSyncListClass.productId = 19
            } else {
                apiSyncListClass.productId = 20
            }
        }
        if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 6  {
            
            if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeOnly.rawValue
            {
                apiSyncListClass.productId = 23
            }
            else if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeStarBlack.rawValue
            {
                apiSyncListClass.productId = 999
            }
            else if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genStarBlack.rawValue
            {
                apiSyncListClass.productId = 24
            }
            
        }
        if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 7  {
            apiSyncListClass.productId = 25
        }
        let jsonEncoder = JSONEncoder()
        var jsonData: Data?
        do {
            jsonData = try jsonEncoder.encode(apiSyncListClass)
            // use jsonData safely
        } catch {
            print("Failed to encode updateGroup: \(error.localizedDescription)")
        }
        
        guard let body = jsonData else {
            print("No JSON data to send")
            return
        }
        let json = String(data: body, encoding: String.Encoding.utf8)
        print(json!)
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + accessToken!]
        let urlString = Configuration.Dev(packet: ApiKeys.saveList.rawValue).getUrl()
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headerDict
        
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        request.httpBody = body
        
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            
            NotificationCenter.default.post(name: Notification.Name(LocalizedStrings.sessionExpiredStr), object: nil, userInfo: [LocalizedStrings.statusCodeText:"\(String(describing: response.response?.statusCode ?? 0))"])
            if statusCode == 401  {
                
                self.delegeteSyncApi?.failWithError(statusCode: statusCode!)
            }
            else if statusCode == 500 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408 {
                self.delegeteSyncApi?.failWithErrorInternal()
                self.delegeteSyncApi?.failWithError(statusCode: statusCode!)
            }
            
            switch response.result {
            case .success(let responseObject):
                let data = response.data
                let response = responseObject as! NSDictionary
                self.responseRecieved1Beef(data, status: true, listId: Int(listID))
                print(response)
                
            case .failure(let encodingError):
                if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                    self.delegeteSyncApi?.failWithErrorInternal()
                    print(err)
                } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                    // other failures
                    print (encodingError)
                    print (responseString)
                    if let s = statusCode {
                        
                        self.delegeteSyncApi?.failWithError(statusCode: s)
                    } else {
                        self.delegeteSyncApi?.failWithErrorInternal()
                    }
                }
            }
        }
        
    }
    
    func postListEditDataBeefOffline() {
        apiSyncListClass.addAnimals.removeAll()
        apiSyncListClass.updateAnimals.removeAll()
        var listID = Int64()
        let editCaseData = fetchAllDataEditConditionWithoutListId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,userId:userId,orderStatus:"false",custmerId:Int64(UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int ?? 0),serverAnimalId:"")
        
        if editCaseData.count == 0  {
            
            return
        }
        
        var breedAssociationId = String()
        var breedAssociationId1 = String()
        var sireIDAUbreedAssociationId1 = String()
        var sireRegAssocationbreedAssociationId = String()
        var breedAssociationIdInherit = String()
        var secondaRyBreedingId = String()
        var priorityBreedingId = String()
        var tertiaryBreedingId = String()
        var datee = String()
        
        for item in editCaseData{
            
            var ob = Animal()
            if let value = item as? DataEntryBeefAnimaladdTbl{
                
                let fetchName = fetchListNameAccordingToListId(entityName: Entities.dataEntryListTblEntity,customerId:Int(UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int ?? 0),listId:value.listId ,providerId:UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                if fetchName.count != 0{
                    let getName = fetchName.object(at: 0) as? DataEntryList
                    listID  = getName?.listId ?? 0
                    self.getListName = getName?.listName ?? ""
                    self.descriptionName = getName?.listDesc ?? ""
                }
                if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 5  {
                    if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
                        
                        ob.deviceAnimalID = Int(value.animalId)
                        let serverAnimalId = value.serverAnimalId
                        if serverAnimalId != "" {
                            ob.animalID = serverAnimalId
                        }
                        
                        if value.date != "" {
                            print(value)
                            datee = getOrderDateChange(date: value.date ?? "")
                            ob.dob = datee
                        }
                        
                        let medbreedRegArr = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 19, association: value.farmId ?? "")
                        
                        if medbreedRegArr.count != 0 {
                            let medbreedRegArr1 = medbreedRegArr.object(at: 0) as? GetBreedSocieties
                            breedAssociationId =   medbreedRegArr1!.associationId ?? ""
                            ob.breedAssociationId = breedAssociationId
                        }
                        
                        let nationHerdAU = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 19, association: value.nationHerdAU ?? "")
                        if nationHerdAU.count != 0 {
                            let nationHerdAU1 = nationHerdAU.object(at: 0) as? GetBreedSocieties
                            breedAssociationId1 =   nationHerdAU1?.associationId ?? ""
                            ob.damAssociationId = breedAssociationId1
                        }
                        
                        
                        let sireIDAU = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 19, association: value.sireIDAU ?? "")
                        if sireIDAU.count != 0 {
                            let sireIDAU1 = sireIDAU.object(at: 0) as? GetBreedSocieties
                            sireIDAUbreedAssociationId1 =   sireIDAU1?.associationId ?? ""
                            ob.sireAssociationId = sireIDAUbreedAssociationId1
                        }
                        
                        ob.earTag = value.animalTag //barcode genotype
                        ob.sampleBarCode = value.animalbarCodeTag ///animal genotype
                        ob.bornTypeId = Int(value.selectedBornTypeId)
                        if value.eT != ""{
                            ob.animalName = value.eT
                        }
                        
                        if value.offsireId != "" {
                            ob.sireRegNumber = value.offsireId
                        }
                        
                        if value.offDamId != ""{
                            ob.damRegNumber = value.offDamId
                        }
                        
                        if value.offPermanentId != "" {
                            ob.breedRegNumber = value.offPermanentId
                        }
                        
                        if value.breedId == "" {
                            ob.breedId = brazilianBreedId
                        } else {
                            ob.breedId = value.breedId
                            
                        }
                        ob.speciesId = SpeciesID.beefSpeciesId
                        
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        }  else {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
  
                    } else { //INHERIT
                        
                        ob.deviceAnimalID = Int(value.animalId)
                        let serverAnimalId = value.serverAnimalId
                        if serverAnimalId != "" {
                            ob.animalID = serverAnimalId
                        }
                        
                        if value.date != "" {
                            print(value)
                            datee = getOrderDateChange(date: value.date ?? "")
                        }
                        let medbreedRegArr = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 20, association: value.eT ?? "")
                        if medbreedRegArr.count != 0 {
                            
                            let medbreedRegArr1 = medbreedRegArr.object(at: 0) as? GetBreedSocieties
                            breedAssociationIdInherit =   medbreedRegArr1!.associationId ?? ""
                            ob.breedAssociationId = breedAssociationIdInherit
                            
                        }
                        
                        let sireRegAssocation = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 20, association: value.sireRegAssocation ?? "")
                        if sireRegAssocation.count != 0 {
                            
                            let medbreedRegArr1 = sireRegAssocation.object(at: 0) as? GetBreedSocieties
                            sireRegAssocationbreedAssociationId =   medbreedRegArr1!.associationId ?? ""
                            ob.sireAssociationId = sireRegAssocationbreedAssociationId
                        }
                        
                        ob.earTag = value.animalTag //barcode genotype
                        ob.sampleBarCode = value.animalbarCodeTag ///animal genotype
                        
                        if value.offsireId != ""{
                            ob.sireRegNumber = value.offsireId
                        }
                        if value.offPermanentId != ""{
                            ob.breedRegNumber = value.offPermanentId
                        }
                        
                        let numberFromString = value.sireYOB ?? "0"
                        let inTd = Int(numberFromString)
                        if numberFromString != "" {
                            ob.sireYOB = inTd ?? 0
                        }
                        
                        if value.offDamId != "" {
                            ob.damId = value.offDamId
                        }
                        
                        let damYOBString = value.damYOB ?? "0"
                        let inTddamYOB = Int(damYOBString)
                        if numberFromString != "" {
                            ob.damYOB = inTddamYOB ?? 0
                            
                        }
                        ob.speciesId = SpeciesID.beefSpeciesId
                        if value.breedId != "" {
                            ob.breedId = value.breedId
                        }
                        
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        }  else {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                        ob.dob = datee
                        ob.nationalHerdId = value.nationHerdAU
                        ob.breedRegistrationNumber = value.sireIDAU
                        ////ob.sireI
                    }
                }
                
                if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 6  {
                    
                    if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeOnly.rawValue{
                        // GENOTYPE
                        ob.deviceAnimalID = Int(value.animalId)
                        let serverAnimalId = value.serverAnimalId
                        if serverAnimalId != "" {
                            ob.animalID = serverAnimalId
                        }
                        
                        let priorityBreeding = fetchAllDataPriorityData(entityName: Entities.getPriorityBreedingTblEntity, priorityBreedId: value.sireIDAU ?? "")
                        
                        if priorityBreeding.count != 0 {
                            
                            let medbreedRegArr1 = priorityBreeding.object(at: 0) as? GetPriorityBreeding
                            priorityBreedingId =   medbreedRegArr1!.priorityBreedId ?? ""
                            ob.primaryPriorityProgramId = priorityBreedingId
                        }
                        
                        let secondaRypriorityBreeding = fetchAllDataPriorityData(entityName: Entities.getSecondaryBreedingProgramsTblEntity, priorityBreedId: value.nationHerdAU ?? "")
                        
                        if secondaRypriorityBreeding.count != 0 {
                            
                            let secondaRy = secondaRypriorityBreeding.object(at: 0) as? GetSecondaryBreedingPrograms
                            secondaRyBreedingId =   secondaRy!.priorityBreedId ?? ""
                            ob.secondaryPriorityProgramId = secondaRyBreedingId
                        }
                        let tertiaryPriorityBreeding = fetchAllDataPriorityData(entityName: Entities.getTertiaryBreedingProgramsTblEntity, priorityBreedId: value.nationHerdAU ?? "")
                        
                        if tertiaryPriorityBreeding.count != 0 {
                            
                            let tertiaryRy = tertiaryPriorityBreeding.object(at: 0) as? GetTertiaryBreedingPrograms
                            tertiaryBreedingId =   tertiaryRy!.priorityBreedId ?? ""
                            ob.tertiaryPriorityProgramId = tertiaryBreedingId
                            
                        }
                        if value.date != "" {
                            
                            datee = getOrderDateChange(date: value.date ?? "")
                            ob.dob = datee
                        }
                        
                        if value.animalTag != ""{
                            ob.sampleBarCode = value.animalTag
                        }
                        ob.speciesId = SpeciesID.beefSpeciesId
                        if value.offsireId != "" {
                            ob.series = value.offsireId
                        }
                        
                        if value.offDamId != ""{
                            ob.rgd = value.offDamId
                        }
                        
                        if value.offPermanentId != "" {
                            ob.rgn = value.offPermanentId
                        }
                        
                        if value.animalbarCodeTag != ""{
                            ob.animalName = value.animalbarCodeTag
                        }
                        
                        if value.breedId == "" {
                            ob.breedId = brazilianBreedId
                        } else {
                            ob.breedId = value.breedId
                            
                        }
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        }  else {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                        
                    }
                    else if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeStarBlack.rawValue
                    {
                        // GENOTYPE
                        ob.deviceAnimalID = Int(value.animalId)
                        let serverAnimalId = value.serverAnimalId
                        if serverAnimalId != "" {
                            ob.animalID = serverAnimalId
                        }
                        
                        let priorityBreeding = fetchAllDataPriorityData(entityName: Entities.getPriorityBreedingTblEntity, priorityBreedId: value.sireIDAU ?? "")
                        
                        if priorityBreeding.count != 0 {
                            
                            let medbreedRegArr1 = priorityBreeding.object(at: 0) as? GetPriorityBreeding
                            priorityBreedingId =   medbreedRegArr1!.priorityBreedId ?? ""
                            ob.primaryPriorityProgramId = priorityBreedingId
                        }
                        
                        let secondaRypriorityBreeding = fetchAllDataPriorityData(entityName: Entities.getSecondaryBreedingProgramsTblEntity, priorityBreedId: value.nationHerdAU ?? "")
                        
                        if secondaRypriorityBreeding.count != 0 {
                            
                            let secondaRy = secondaRypriorityBreeding.object(at: 0) as? GetSecondaryBreedingPrograms
                            secondaRyBreedingId =   secondaRy!.priorityBreedId ?? ""
                            ob.secondaryPriorityProgramId = secondaRyBreedingId
                        }
                        let tertiaryPriorityBreeding = fetchAllDataPriorityData(entityName: Entities.getTertiaryBreedingProgramsTblEntity, priorityBreedId: value.nationHerdAU ?? "")
                        
                        if tertiaryPriorityBreeding.count != 0 {
                            
                            let tertiaryRy = tertiaryPriorityBreeding.object(at: 0) as? GetTertiaryBreedingPrograms
                            tertiaryBreedingId =   tertiaryRy!.priorityBreedId ?? ""
                            ob.tertiaryPriorityProgramId = tertiaryBreedingId
                            
                        }
                        if value.date != "" {
                            
                            datee = getOrderDateChange(date: value.date ?? "")
                            ob.dob = datee
                        }
                        
                        if value.animalTag != ""{
                            ob.sampleBarCode = value.animalTag
                        }
                        ob.speciesId = SpeciesID.beefSpeciesId
                        if value.offsireId != "" {
                            ob.series = value.offsireId
                        }
                        
                        if value.offDamId != ""{
                            ob.rgd = value.offDamId
                        }
                        
                        if value.offPermanentId != "" {
                            ob.rgn = value.offPermanentId
                        }
                        
                        if value.animalbarCodeTag != ""{
                            ob.animalName = value.animalbarCodeTag
                        }
                        
                        if value.breedId == "" {
                            ob.breedId = brazilianBreedId
                        } else {
                            ob.breedId = value.breedId
                            
                        }
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        }  else {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                        
                    }
                    else if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genStarBlack.rawValue
                    { //nonGenotype
                        
                        ob.deviceAnimalID = Int(value.animalId)
                        let serverAnimalId = value.serverAnimalId
                        if serverAnimalId != "" {
                            ob.animalID = serverAnimalId
                        }
                        
                        if value.date != "" {
                            datee = getOrderDateChange(date: value.date ?? "")
                            ob.dob = datee
                        }
                        
                        if value.animalTag != ""{
                            ob.sampleBarCode = value.animalTag
                        }
                        if value.animalbarCodeTag != ""{
                            ob.animalName = value.animalbarCodeTag
                        }
                        if value.offsireId != "" {
                            ob.series = value.offsireId
                        }
                        if value.offDamId != ""{
                            ob.rgd = value.offDamId
                        }
                        if value.offPermanentId != "" {
                            ob.rgn = value.offPermanentId
                        }
                        ob.speciesId = SpeciesID.beefSpeciesId
                        if value.breedId == "" {
                            ob.breedId = brazilianBreedId
                        } else {
                            ob.breedId = value.breedId
                            
                        }
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        }  else {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                    }
                    else { //nonGenotype
                        
                        ob.deviceAnimalID = Int(value.animalId)
                        let serverAnimalId = value.serverAnimalId
                        if serverAnimalId != "" {
                            ob.animalID = serverAnimalId
                        }
                        
                        if value.date != "" {
                            datee = getOrderDateChange(date: value.date ?? "")
                            ob.dob = datee
                        }
                        
                        if value.animalTag != ""{
                            ob.sampleBarCode = value.animalTag
                        }
                        if value.animalbarCodeTag != ""{
                            ob.animalName = value.animalbarCodeTag
                        }
                        if value.offsireId != "" {
                            ob.series = value.offsireId
                        }
                        if value.offDamId != ""{
                            ob.rgd = value.offDamId
                        }
                        if value.offPermanentId != "" {
                            ob.rgn = value.offPermanentId
                        }
                        ob.speciesId = SpeciesID.beefSpeciesId
                        ob.sampleTypeId = Int(value.tissuId)
                        let sexName = value.gender ?? ""
                        
                        if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                            
                            nameSex = "F"
                        } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                            nameSex = "M"
                            
                        }  else {
                            nameSex = "F"
                        }
                        
                        ob.sex = nameSex
                    }
                }
                if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 7  {
                    
                    ob.deviceAnimalID = Int(value.animalId)
                    let serverAnimalId = value.serverAnimalId
                    if serverAnimalId != "" {
                        ob.animalID = serverAnimalId
                    }
                    if value.date != "" {
                        print(value)
                        datee = getOrderDateChange(date: value.date ?? "")
                        ob.dob = datee
                    }
                    if value.animalTag != "" {
                        ob.animalTag = value.animalTag
                    }
                    
                    if value.animalbarCodeTag != ""{
                        ob.sampleBarCode = value.animalbarCodeTag ///animal genotype
                    }
                    
                    if value.eT != "" {
                        ob.animalName = value.eT
                    }
                    
                    if value.offsireId != "" {
                        ob.sireRegNumber = value.offsireId
                    }
                    if value.offDamId != ""{
                        ob.damRegNumber = value.offDamId
                    }
                    ob.speciesId = SpeciesID.beefSpeciesId
                    if value.offPermanentId != ""{
                        ob.breedRegNumber = value.offPermanentId
                    }
                    
                    let sireRegAssocation = fetchAllDataProductBeefBreedSocietyNAME(entityName: Entities.getBreedSocietiesTblEntity, productId: 25, association: value.sireIDAU ?? "")
                    if sireRegAssocation.count != 0 {
                        
                        let medbreedRegArr1 = sireRegAssocation.object(at: 0) as? GetBreedSocieties
                        sireRegAssocationbreedAssociationId =   medbreedRegArr1!.associationId ?? ""
                        ob.breedAssociationId = sireRegAssocationbreedAssociationId
                    }
                    
                    if value.breedId == "" {
                        ob.breedId = brazilianBreedId
                    } else {
                        ob.breedId = value.breedId
                    }
                    ob.sampleTypeId = Int(value.tissuId)
                    let sexName = value.gender ?? ""
                    
                    if sexName == ButtonTitles.femaleText.localized || sexName == "female"{
                        
                        nameSex = "F"
                    } else if sexName == ButtonTitles.maleText.localized || sexName == "male" {
                        nameSex = "M"
                        
                    }  else {
                        nameSex = "F"
                    }
                    
                    ob.sex = nameSex
                }
            }
            apiSyncListClass.updateAnimals.append(ob)
            ob = Animal()
        }
        apiSyncListClass.customerId = custId
        apiSyncListClass.listName = getListName
        apiSyncListClass.description = descriptionName
        apiSyncListClass.speciesId = SpeciesID.beefSpeciesId
        apiSyncListClass.providerId = beefpvid
        
        if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 5  {
            if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
                apiSyncListClass.productId = 19
            } else {
                apiSyncListClass.productId = 20
            }
        }
        if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 6  {
            if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeOnly.rawValue
            {
                apiSyncListClass.productId = 23
            }
            else if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeStarBlack.rawValue
            {
                apiSyncListClass.productId = 999
            }
            else if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genStarBlack.rawValue
            {
                apiSyncListClass.productId = 24
            }
        }
        
        if UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue) == 7  {
            apiSyncListClass.productId = 25
        }
        
        let jsonEncoder = JSONEncoder()
        var jsonData: Data?
        do {
            jsonData = try jsonEncoder.encode(apiSyncListClass)
            // use jsonData safely
        } catch {
            print("Failed to encode updateGroup: \(error.localizedDescription)")
        }
        
        guard let body = jsonData else {
            print("No JSON data to send")
            return
        }
        let json = String(data: body, encoding: String.Encoding.utf8)
        print(json!)
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + accessToken!]
        let urlString = Configuration.Dev(packet: ApiKeys.saveList.rawValue).getUrl()
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headerDict
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        request.httpBody = body
        
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            
            NotificationCenter.default.post(name: Notification.Name(LocalizedStrings.sessionExpiredStr), object: nil, userInfo: [LocalizedStrings.statusCodeText:"\(String(describing: response.response?.statusCode ?? 0))"])
            if statusCode == 401  {
                self.delegeteSyncApi?.failWithError(statusCode: statusCode!)
            }
            else if statusCode == 500 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408 {
                self.delegeteSyncApi?.failWithErrorInternal()
                self.delegeteSyncApi?.failWithError(statusCode: statusCode!)
            }
            
            switch response.result {
            case .success(let responseObject):
                let data = response.data
                let response = responseObject as! NSDictionary
                self.responseRecieved1Beef(data, status: true, listId: Int(listID))
                print(response)
                
            case .failure(let encodingError):
                if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                    self.delegeteSyncApi?.failWithErrorInternal()
                    print(err)
                } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                    print (encodingError)
                    print (responseString)
                    if let s = statusCode {
                        self.delegeteSyncApi?.failWithError(statusCode: s)
                    } else {
                        self.delegeteSyncApi?.failWithErrorInternal()
                    }
                }
            }
        }
    }
}
