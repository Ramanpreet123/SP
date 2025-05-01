//
//  CoreDataManager.swift
//  SearchPoint
//
//  Created by "" on 07/10/2019.
//  ""
//

import Foundation
import CoreData
typealias CoreDataResponse = (_ : Any?) -> Void
var commanArray = NSArray()
var dependency:DashboardVC?
func insert(entity: String, attributeKey: String?, objectToSave: [String : Any]) {
    //officicalID
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    content.setValuesForKeys(objectToSave)
    do {
        try managedObjectContext.save()
       
    } catch {
       
    }
}

func deleteAllData(_ entity: String) {
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  entity)
    fetchRequest.returnsObjectsAsFaults = false
    do
        
    {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results
        {
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
            
        }
        
    } catch let error as NSError {
        
        print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        
    }
}


func deleteAnimalfromdataEntry (enitityName:String,_ animalId: Int, listId: Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  enitityName)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "animalId == %d AND listId == %d", animalId,listId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}


func saveLastUpdatedDate(entity: String,emailId: String,userId: Int,speciesLastUpdated: String,sampleTypesLastUpdated: String,sampleStatusesLastUpdated: String, productsLastUpdated: String, priorityBreedingProgrLastUpdated: String,marketsLastUpdated: String,evaluationProvidersLastUpdated: String,countryCodesLastUpdated:String,breedsLastUpdated:String,breedAssociationsLastUpdated:String,bornTypesLastUpdated:String,austrailianBullsLastUpdated:String,addOnsLastUpdated:String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: "LastUpdatedDates", into: managedObjectContext)
    
    content.setValue(emailId, forKey: "emailId")
    content.setValue(userId, forKey: "userId")
    content.setValue(speciesLastUpdated, forKey: "speciesLastUpdated")
    content.setValue(sampleTypesLastUpdated, forKey: "sampleTypesLastUpdated")
    content.setValue(sampleStatusesLastUpdated, forKey: "sampleStatusesLastUpdated")
    content.setValue(productsLastUpdated, forKey: "productsLastUpdated")
    content.setValue(priorityBreedingProgrLastUpdated, forKey: "priorityBreedingProgrLastUpdated")
    content.setValue(marketsLastUpdated, forKey: "marketsLastUpdated")
    content.setValue(evaluationProvidersLastUpdated, forKey: "evaluationProvidersLastUpdated")
    content.setValue(countryCodesLastUpdated, forKey: "countryCodesLastUpdated")
    content.setValue(breedsLastUpdated, forKey: "breedsLastUpdated")
    content.setValue(breedAssociationsLastUpdated, forKey: "breedAssociationsLastUpdated")
    content.setValue(bornTypesLastUpdated, forKey: "bornTypesLastUpdated")
    content.setValue(austrailianBullsLastUpdated, forKey: "austrailianBullsLastUpdated")
    content.setValue(addOnsLastUpdated, forKey: "addOnsLastUpdated")
    
    do {
        try managedObjectContext.save()
       
    } catch {
       
    }
}

func saveCustomerDataPercentage(entity: String, customerDataPercentage: Int64, customerName: String){
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
       //adding new doc and saving in database...
       let content = NSEntityDescription.insertNewObject(forEntityName: "ManageCustomerDownloadData", into: managedObjectContext)
    
    content.setValue(customerDataPercentage, forKey: "customerDataPercentage")
    content.setValue(customerName, forKey: "customerName")
       
        
        do {
            try managedObjectContext.save()
          
        } catch {
           
        }
}



func updateLastUpdatedDate(entity: String,emailId: String,speciesLastUpdated: String,sampleTypesLastUpdated: String,sampleStatusesLastUpdated: String, productsLastUpdated: String, priorityBreedingProgrLastUpdated: String,marketsLastUpdated: String,evaluationProvidersLastUpdated: String,countryCodesLastUpdated:String,breedsLastUpdated:String,breedAssociationsLastUpdated:String,bornTypesLastUpdated:String,austrailianBullsLastUpdated:String,addOnsLastUpdated:String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "emailId == %@", emailId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(speciesLastUpdated, forKey: "speciesLastUpdated")
                objTable.setValue(sampleTypesLastUpdated, forKey: "sampleTypesLastUpdated")
                objTable.setValue(sampleStatusesLastUpdated, forKey: "sampleStatusesLastUpdated")
                objTable.setValue(productsLastUpdated, forKey: "productsLastUpdated")
                objTable.setValue(priorityBreedingProgrLastUpdated, forKey: "priorityBreedingProgrLastUpdated")
                objTable.setValue(marketsLastUpdated, forKey: "marketsLastUpdated")
                objTable.setValue(evaluationProvidersLastUpdated, forKey: "evaluationProvidersLastUpdated")
                objTable.setValue(countryCodesLastUpdated, forKey: "countryCodesLastUpdated")
                objTable.setValue(breedsLastUpdated, forKey: "breedsLastUpdated")
                objTable.setValue(breedAssociationsLastUpdated, forKey: "breedAssociationsLastUpdated")
                objTable.setValue(bornTypesLastUpdated, forKey: "bornTypesLastUpdated")
                objTable.setValue(austrailianBullsLastUpdated, forKey: "austrailianBullsLastUpdated")
                objTable.setValue(addOnsLastUpdated, forKey: "addOnsLastUpdated")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}


/************** Save Setting  Data ********************************/

func saveSettingData(entity: String,specisId: String,specisName: String,providerName: String,providerId: Int,nominater: String, fromDatae: String, toDate: String,status: String,index: Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: "SettingTbl", into: managedObjectContext)
    
    content.setValue(specisId, forKey: "specisId")
    content.setValue(specisName, forKey: "specisName")
    content.setValue(providerName, forKey: "providerName")
    content.setValue(providerId, forKey: "providerId")
    content.setValue(nominater, forKey: "nominater")
    content.setValue(fromDatae, forKey: "fromDate")
    content.setValue(toDate, forKey: "toDate")
    content.setValue(status, forKey: "staus")
    content.setValue(index, forKey: "index")
    
    do {
        try managedObjectContext.save()
        
    } catch {
      
    }
}
//*****
func savecustomerSettingData(customerID: Int64,emailId: String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: "CustomerSettingSave", into: managedObjectContext)
    
    content.setValue(customerID, forKey: "customerId")
    content.setValue(emailId, forKey: "emailId")
    
    do {
        try managedObjectContext.save()
       
    } catch {
       
    }
}



func saveSingleTimeSampleToastSetting(emailId: String,sampleTracking:String? = "") {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: "SingleTimeToastsample", into: managedObjectContext)
    
    content.setValue(sampleTracking, forKey: "sampleTracking")
    content.setValue(emailId, forKey: "emaild")
    
    do {
        try managedObjectContext.save()
       
    } catch {
        
    }
}
func saveSingleTimeActionToastSetting(emailId: String,actionRequired:String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: "SingleTimeToastAction", into: managedObjectContext)
    
    content.setValue(actionRequired, forKey: "actionRequired")
    content.setValue(emailId, forKey: "emaild")
    
    do {
        try managedObjectContext.save()
      
    } catch {
       
    }
}
func fetchGroupExAnimal(entityName: String, groupID: String,custmerId:Int64,onFarmId:String) -> NSArray {
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d && serverGroupId == %@ && onFarmId == %@", custmerId,groupID,onFarmId)
    fetchRequest.returnsObjectsAsFaults = false

    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
      
        }
        
    } catch {
    }
    
    return commanArray
}

func fetchAllSingleTimeToastSetting(entityName: String,emailId:String) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "emaild ==%@", emailId)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func updateSingleTimeToastSetting(entity: String,emailId: String,actionRequire:String?,sampleTracking:String?) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "emaild == %@", emailId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(actionRequire, forKey: "actionRequired")
                
                objTable.setValue(sampleTracking, forKey: "sampleTracking")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func fetchAllCustomerSettingData(entityName: String,emailId:String) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "emailId ==%@", emailId)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchDataNonSyncListGet(entityName: String,isSyncStatus:Bool = true) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "offlineSync == %d", isSyncStatus)
    
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "listId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchCustomerDownloadPercentageData(entityeName: String, customerName: String) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityeName)
        fetchRequest.predicate = NSPredicate(format: "customerName ==%@", customerName)
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult{
                commanArray = results as NSArray
            }
        } catch {
        }
        
        return commanArray
}


func updateCustomerSettingData(entity: String,emailId: String,customerId:Int64) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "emailId == %@", emailId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(customerId, forKey: "customerId")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

///**
func updateProductTablevaleeSinglee(entity: String,productId: Int,status: String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    requestDel.predicate = NSPredicate(format: "productId == %d", productId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                objTable.setValue(status, forKey: "status")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
    
    
}
func updateProductTablevaleeSingleeInBef(entity: String,productId: Int,status: String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    requestDel.predicate = NSPredicate(format: "adonId == %d", productId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                objTable.setValue(status, forKey: "status")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateOrderStatusISyncProductGirlando(entity: String,earTag: String,barCodetag: String,farmId: String,orderId: Int,userId:Int,animalId:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "userId == %d AND orderId == %d AND animalId == %d", userId,orderId,animalId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(earTag, forKey: "earTag")
                objTable.setValue(barCodetag, forKey: "animalbarCodeTag")
                objTable.setValue(farmId, forKey: "farmId")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func fetchAllDataOrderStatusMasterGirlando(entityName: String,ordestatus: String,userId:Int,farmId:String,earTag:String,barcodeTag:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND userId == %d AND earTag == %@ AND animalbarCodeTag == %@", ordestatus,userId,earTag,barcodeTag)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func updateOrderStatusISyncSubProductGirlando(entity: String,earTag: String,barCodetag: String,farmId: String,orderId: Int,userId:Int,animalId:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "userId == %d AND orderId == %d AND animalId == %d", userId,orderId,animalId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(earTag, forKey: "earTag")
                objTable.setValue(barCodetag, forKey: "animalbarCodeTag")
                objTable.setValue(farmId, forKey: "farmId")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func fetchAnimaldataValidateAnimalwithouOrderIDGirlando(entityName: String, earTag: String,farmId:String,animalbarCodeTag:String,offDamId:String,offsireId:String,orderId:Int,userId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    if earTag == "" && farmId  == ""{
        requestDel.predicate = NSPredicate(format: "earTag LIKE[c] %@ AND farmId == %@ AND userId == %d " ,earTag,farmId,userId)
    }
    else if earTag == ""{
        requestDel.predicate = NSPredicate(format: "animalbarCodeTag == %@ AND userId == %d " ,animalbarCodeTag,userId)
    }
    else if farmId == "" {
        requestDel.predicate = NSPredicate(format: "earTag LIKE[c] %@  AND userId == %d " ,earTag,userId)
    }
    else {
        requestDel.predicate = NSPredicate(format: "earTag LIKE[c] %@ OR farmId == %@ AND userId == %d " ,earTag,farmId,userId)
    }
    
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func saveAnimaldataGirlando(entity: String,earTag: String,barCodetag: String,date: String,damId: String,sireId: String,gender: String,update: String,breedRegNumber: String,tissuName: String,breedName: String,et: String,farmId: String,orderId: Int,orderSataus:String,breedId: String,isSync:String,providerId:Int,tissuId: Int,sireIDAU:String,animalName:String,userId:Int,udid: String,animalId:Int,  selectedBornTypeId:Int,breedAssocation:String,custId:Int,listId:Int64,serverAnimalId:String,girlandoID:String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
  if entity == Entities.dataEntryAnimalAddTbl{
    content.setValue(1, forKey: "addeditdelete")
  }
    content.setValue(earTag, forKey: "earTag")
    content.setValue(breedRegNumber, forKey: "breedRegNumber")
    content.setValue(animalName, forKey: "animalName")
    content.setValue(breedAssocation, forKey: "breedAssocation")
    content.setValue(serverAnimalId, forKey: "serverAnimalId")

    
    content.setValue(barCodetag, forKey: "animalbarCodeTag")
    content.setValue(date, forKey: "date")
    content.setValue(gender, forKey: "gender")
    content.setValue(sireId, forKey: "offsireId")
    content.setValue(damId, forKey: "offDamId")
    content.setValue(tissuName, forKey: "tissuName")
    content.setValue(breedName, forKey: "breedName")
    content.setValue(farmId, forKey: "farmId")
    content.setValue(et, forKey: "eT")
    content.setValue(update, forKey: "status")
    content.setValue(orderId, forKey: "orderId")
    content.setValue(orderSataus, forKey: "orderstatus")
    content.setValue(breedId, forKey: "breedId")
    content.setValue(isSync, forKey: "isSync")
    content.setValue(providerId, forKey: "providerId")
    content.setValue(tissuId, forKey: "tissuId")
    content.setValue(sireIDAU, forKey: "sireIDAU")
    content.setValue(userId, forKey: "userId")
    content.setValue(udid, forKey: "udid")
    content.setValue(animalId, forKey: "animalId")
    content.setValue(selectedBornTypeId, forKey: "selectedBornTypeId")
    content.setValue(custId, forKey: "custmerId")
    content.setValue(girlandoID, forKey: "girlandoID")
    content.setValue(listId, forKey: "listId")

    do {
        try managedObjectContext.save()
      
    } catch {
       
    }
}

func updateOrderStatusISyncAnimalMasterAnimalIdGirlando(entity: String,earTag: String,barCodetag: String,date: String,damId: String,sireId: String,gender: String,update: String,breedRegNumber: String,tissuName: String,breedName: String,et: String,farmId: String,orderId: Int,orderSataus:String,breedId: String,isSync:String,providerId:Int,tissuId: Int,sireIDAU:String,animalName:String,userId:Int,udid: String,animalId:Int,animalidNew:Int, selectedBornTypeId: Int? = nil,breedAssocation:String,girlandoID:String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "userId == %d AND animalId == %d ", userId,animalId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(earTag, forKey: "earTag")
                objTable.setValue(breedRegNumber, forKey: "breedRegNumber")
                objTable.setValue(animalName, forKey: "animalName")
                objTable.setValue(breedAssocation, forKey: "breedAssocation")
                
                
                
                
                objTable.setValue(barCodetag, forKey: "animalbarCodeTag")
                objTable.setValue(date, forKey: "date")
                objTable.setValue(gender, forKey: "gender")
                objTable.setValue(sireId, forKey: "offsireId")
                objTable.setValue(damId, forKey: "offDamId")
                objTable.setValue(tissuName, forKey: "tissuName")
                objTable.setValue(breedName, forKey: "breedName")
                objTable.setValue(farmId, forKey: "farmId")
                objTable.setValue(et, forKey: "eT")
                objTable.setValue(update, forKey: "status")
                objTable.setValue(orderId, forKey: "orderId")
                // objTable.setValue(orderSataus, forKey: "orderstatus")
                objTable.setValue(breedId, forKey: "breedId")
                objTable.setValue(isSync, forKey: "isSync")
                objTable.setValue(providerId, forKey: "providerId")
                objTable.setValue(tissuId, forKey: "tissuId")
                objTable.setValue(sireIDAU, forKey: "sireIDAU")
                //     objTable.setValue(nationHerdAU, forKey: "nationHerdAU")
                objTable.setValue(userId, forKey: "userId")
                objTable.setValue(udid, forKey: "udid")
                objTable.setValue(animalidNew, forKey: "animalId")
                objTable.setValue(selectedBornTypeId, forKey: "selectedBornTypeId")
                objTable.setValue(girlandoID, forKey: "girlandoID")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func updateOrderStatusISyncAnimalMasterGirlando(entity: String,earTag: String,barCodetag: String,date: String,damId: String,sireId: String,gender: String,update: String,breedRegNumber: String,tissuName: String,breedName: String,et: String,farmId: String,orderId: Int,orderSataus:String,breedId: String,isSync:String,providerId:Int,tissuId: Int,sireIDAU:String,animalName:String,userId:Int,udid: String,animalId:Int, selectedBornTypeId: Int? = nil,breedAssocation:String,girlandoID:String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "userId == %d AND orderId == %d  AND animalId == %d", userId,orderId,animalId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
              if entity == Entities.dataEntryAnimalAddTbl{
                objTable.setValue(2, forKey: "addeditdelete")
              }
                objTable.setValue(earTag, forKey: "earTag")
                objTable.setValue(animalName, forKey: "animalName")
                objTable.setValue(breedRegNumber, forKey: "breedRegNumber")
                
                objTable.setValue(breedAssocation, forKey: "breedAssocation")
                objTable.setValue(barCodetag, forKey: "animalbarCodeTag")
                objTable.setValue(date, forKey: "date")
                objTable.setValue(gender, forKey: "gender")
                objTable.setValue(sireId, forKey: "offsireId")
                objTable.setValue(damId, forKey: "offDamId")
                objTable.setValue(tissuName, forKey: "tissuName")
                objTable.setValue(breedName, forKey: "breedName")
                objTable.setValue(farmId, forKey: "farmId")
                objTable.setValue(et, forKey: "eT")
                // objTable.setValue(update, forKey: "status")
                //objTable.setValue(orderId, forKey: "orderId")
                objTable.setValue(girlandoID, forKey: "girlandoID")
                objTable.setValue(breedId, forKey: "breedId")
                objTable.setValue(isSync, forKey: "isSync")
                objTable.setValue(providerId, forKey: "providerId")
                objTable.setValue(tissuId, forKey: "tissuId")
                objTable.setValue(sireIDAU, forKey: "sireIDAU")
                objTable.setValue(userId, forKey: "userId")
                objTable.setValue(udid, forKey: "udid")
                objTable.setValue(animalId, forKey: "animalId")
                objTable.setValue(selectedBornTypeId, forKey: "selectedBornTypeId")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func fetchAnimaldataValidateAnimalTagGirlando(entityName: String, earTag: String,orderId: Int, userId: Int,animalId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "animalId == %d AND orderId == %d AND userId == %d",animalId,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func updateProductTablSecononvc(entity: String,productId: Int,status: String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "productId == %d", productId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                objTable.setValue(status, forKey: "status")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
    
    
}




func fetchAllDataBreediDd(entityName: String,breedName:String) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "breedName ==%@", breedName)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}




func fetchAllDataAnimalDataBeefSampleTypeAnimaTagNZ(entityName: String,aTag:Int,orderId:Int) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "diffAge <= %d AND orderId ==%d", aTag,orderId)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataAnimalDataBeefSampleTypeAnimaTagNZATAg(entityName: String,aTag:Int,orderId:Int,anmalTag:String) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "diffAge <= %d AND orderId ==%d AND animalTag ==%@", aTag,orderId,anmalTag)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataAnimalFarmiIdCheckBothMandatory(entityName: String,farmId:String,animalTag:String,custmerId :Int,userID :Int,listId:Int64) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    fetchRequest.predicate = NSPredicate(format: "(farmId == %@ OR animalTag ==  %@) AND custmerId == %d AND listId == %d",farmId, animalTag,custmerId,listId)
        
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataAnimalFarmiIdCheck(entityName: String,anmalTag:String,custmerId :Int,userID :Int,listId:Int64) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    fetchRequest.predicate = NSPredicate(format: "farmId == %@  AND custmerId == %d AND listId == %d", anmalTag,custmerId,listId)
        
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}


func fetchAllDataAnimalAnimalIgnoreCase(entityName: String,custmerId :Int,userID :Int,listId:Int64) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND listId == %d", custmerId,listId)
        
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}




func fetchAllDataAnimalAnimalTagCheck(entityName: String,anmalTag:String,custmerId :Int,userID :Int,listId:Int64) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    fetchRequest.predicate = NSPredicate(format: "animalTag == %@  AND custmerId == %d AND listId == %d", anmalTag,custmerId,listId)
        
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAllDataAnimalAnimalIdOfficalId(entityName: String,animalId:String,anmalTag:String,custmerId :Int,userID :Int,orderId :Int) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    
    if animalId == "" {
        
        fetchRequest.predicate = NSPredicate(format: "animalTag LIKE[c] %@ AND custmerId == %d AND userId == %d AND orderId == %d ", anmalTag,custmerId,userID,orderId)

    } else if anmalTag == "" {
        
        fetchRequest.predicate = NSPredicate(format: "farmId LIKE[c] %@  AND custmerId == %d AND userId == %d AND orderId == %d ", animalId,custmerId,userID,orderId)
        
    } else {
    
    fetchRequest.predicate = NSPredicate(format: "(farmId LIKE[c] %@ OR animalTag LIKE[c] %@) AND custmerId == %d AND userId == %d AND orderId == %d ", animalId,anmalTag,custmerId,userID,orderId)
        
    }
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}




func fetchAllDataAnimalDatarderIdInBEEF(entityName: String,userId:Int,orderId:Int,orderStatus:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "userId == %d AND orderId == %d AND orderstatus == %@",userId,orderId,orderStatus)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "isUpadte", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            //commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func saveDataEnteryList(entity: String,customerId: Int64,listDesc: String,listId: Int64,listName: String,userId: Int,providerId:Int,productType:String,productName:String) {
    //dssd
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    
    content.setValue(customerId, forKey: "customerId")
    content.setValue(listDesc, forKey: "listDesc")
    content.setValue(listId, forKey: "listId")
    content.setValue(listName, forKey: "listName")
    content.setValue(productType, forKey: "productType")
    content.setValue(providerId, forKey: "providerId")
    content.setValue(productName, forKey: "productName")

    
    do {
        try managedObjectContext.save()
        
    } catch {
       
    }
}

func saveorderResponse(entity: String,actionRequired: String,orderDate: Date,orderId: Int,orderStatus: String,packageRecieved: String, sampleCount: String, serverOrderId: String,userId:Int) {
    //dssd
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    
    content.setValue(actionRequired, forKey: "actionRequired")
    content.setValue(orderDate, forKey: "orderDate")
    content.setValue(orderId, forKey: "orderId")
    content.setValue(orderStatus, forKey: "orderStatus")
    content.setValue(packageRecieved, forKey: "packageRecieved")
    content.setValue(sampleCount, forKey: "sampleCount")
    content.setValue(serverOrderId, forKey: "serverOrderId")
    content.setValue(userId, forKey: "userId")
    
    
    do {
        try managedObjectContext.save()
       
    } catch {
       
    }
}
func saveSettingProviderData(entity: String,specisId: String,specisName: String,providerName: String,providerId: Int,nominater: String, fromDatae: String, toDate: String,status: String,index: Int) {
    
    let data = fetchproviderData(provId: providerId)
    if data.count>0{
        return
    }
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    
    content.setValue(specisId, forKey: "specisId")
    content.setValue(specisName, forKey: "specisName")
    content.setValue(providerName, forKey: "providerName")
    content.setValue(providerId, forKey: "providerId")
    content.setValue(nominater, forKey: "nominater")
    content.setValue(fromDatae, forKey: "fromDate")
    content.setValue(toDate, forKey: "toDate")
    content.setValue(index, forKey: "index")
    content.setValue(status, forKey: "status")
    //content.setValue(scannerSelection, forKey: "scannerSelection")
    
    do {
        try managedObjectContext.save()
       
    } catch {
        
    }
}
func saveAnimaldata(entity: String,animalTag: String,barCodetag: String,date: String,damId: String,sireId: String,gender: String,update: String,permanentId: String,tissuName: String,breedName: String,et: String,farmId: String,orderId: Int,orderSataus:String,breedId: String,isSync:String,providerId:Int,tissuId: Int,sireIDAU:String,nationHerdAU:String,userId:Int,udid: String,animalId:Int, selectedBornTypeId: Int? = nil,custId: Int,specisId:String,earTag:String,isSyncServer:Bool, adhDataServer: Bool,listId:Int64,editFlagSave:Bool,serverAnimalId:String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    content.setValue(specisId, forKey: "specisType")
    content.setValue(editFlagSave, forKey: "editFlagSave")
  if entity == Entities.dataEntryAnimalAddTbl{
    content.setValue(1, forKey: "addeditdelete")
  }
    content.setValue(serverAnimalId, forKey: "serverAnimalId")

    content.setValue(earTag, forKey: "earTag")
    content.setValue(animalTag, forKey: "animalTag")
    content.setValue(barCodetag, forKey: "animalbarCodeTag")
    content.setValue(date, forKey: "date")
    content.setValue(gender, forKey: "gender")
    content.setValue(permanentId, forKey: "offPermanentId")
    content.setValue(sireId, forKey: "offsireId")
    content.setValue(damId, forKey: "offDamId")
    content.setValue(tissuName, forKey: "tissuName")
    content.setValue(breedName, forKey: "breedName")
    content.setValue(farmId, forKey: "farmId")
    content.setValue(et, forKey: "eT")
    content.setValue(update, forKey: "status")
    content.setValue(orderId, forKey: "orderId")
    content.setValue(orderSataus, forKey: "orderstatus")
    content.setValue(breedId, forKey: "breedId")
    content.setValue(isSync, forKey: "isSync")
    content.setValue(providerId, forKey: "providerId")
    content.setValue(tissuId, forKey: "tissuId")
    content.setValue(sireIDAU, forKey: "sireIDAU")
    content.setValue(nationHerdAU, forKey: "nationHerdAU")
    content.setValue(userId, forKey: "userId")
    content.setValue(udid, forKey: "udid")
    content.setValue(animalId, forKey: "animalId")
    content.setValue(selectedBornTypeId, forKey: "selectedBornTypeId")
    content.setValue(custId, forKey: "custmerId")
    
    content.setValue(isSyncServer, forKey: "isSyncServer")
    content.setValue(adhDataServer, forKey: "adhDataServer")
    content.setValue(listId, forKey: "listId")

    
    do {
        try managedObjectContext.save()
       
    } catch {
       
    }
}

func inheritSaveAnimaldataBeefInProductId (entity: String,animalTag: String,barCodetag: String,date: String,damId: String,sireId: String,gender: String,update: String,permanentId: String,tissuName: String,breedName: String,et: String,farmId: String,orderId: Int,orderSataus:String,breedId: String,isSync:String,providerId:Int,tissuId: Int,sireIDAU:String,nationHerdAU:String,userId:Int,udid: String,animalId:Int,productId:Int,sirYOB:String,damYOB:String,sireRegAssocation:String,custId:Int,listId:Int64,serverAnimalId:String, tertiaryGeno: String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    content.setValue(serverAnimalId, forKey: "serverAnimalId")
    content.setValue(listId, forKey: "listId")

    content.setValue(animalTag, forKey: "animalTag")
    content.setValue(barCodetag, forKey: "animalbarCodeTag")
    content.setValue(date, forKey: "date")
    content.setValue(gender, forKey: "gender")
    content.setValue(permanentId, forKey: "offPermanentId")
    content.setValue(sireId, forKey: "offsireId")
    content.setValue(damId, forKey: "offDamId")
    content.setValue(tissuName, forKey: "tissuName")
    content.setValue(breedName, forKey: "breedName")
    content.setValue(farmId, forKey: "farmId")
    content.setValue(et, forKey: "eT")
    content.setValue(update, forKey: "status")
    content.setValue(orderId, forKey: "orderId")
    content.setValue(orderSataus, forKey: "orderstatus")
    content.setValue(breedId, forKey: "breedId")
    content.setValue(isSync, forKey: "isSync")
    content.setValue(providerId, forKey: "providerId")
    content.setValue(tissuId, forKey: "tissuId")
    content.setValue(sireIDAU, forKey: "sireIDAU")
    content.setValue(nationHerdAU, forKey: "nationHerdAU")
    content.setValue(userId, forKey: "userId")
    content.setValue(udid, forKey: "udid")
    content.setValue(animalId, forKey: "animalId")
    content.setValue(productId, forKey: "productId")
    content.setValue(sirYOB, forKey: "sireYOB")
    content.setValue(damYOB, forKey: "damYOB")
    content.setValue(custId, forKey: "custmerId")
  if entity == Entities.dataEntryBeefAnimalAddTblEntity{
    content.setValue(1, forKey: "addeditdelete")
  }
  
    content.setValue(tertiaryGeno, forKey: "tertiaryGeno")
  
    
    content.setValue(sireRegAssocation, forKey: "sireRegAssocation")
    
    do {
        try managedObjectContext.save()
        
    } catch {
        
    }
}
func deleteDataWithProductwithEntity (_ animalId: Int,entity:String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "animalId == %d", animalId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}


//func deleteDataWithAdh1(custmerId: Int,entity:String,animalbarCodeTag:String,farmId:String,animalTag:String,animalId:Int) {
    func deleteDataWithAdh1(entity:String,animalId:Int64,userId:Int,custmerId:Int) {

    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    fetchRequest.returnsObjectsAsFaults = false
   // fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND farmId == %@ AND animalbarCodeTag == %@ AND animalTag == %@ AND animalId == %@", custmerId,farmId,animalbarCodeTag,animalTag,animalId)
    
        fetchRequest.predicate = NSPredicate(format: "animalId == %d AND userId == %d AND custmerId == %d", animalId,userId,custmerId)

    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}






func saveAnimaldataBeefInProductId (entity: String,animalTag: String,barCodetag: String,date: String,damId: String,sireId: String,gender: String,update: String,permanentId: String,tissuName: String,breedName: String,et: String,farmId: String,orderId: Int,orderSataus:String,breedId: String,isSync:String,providerId:Int,tissuId: Int,sireIDAU:String,nationHerdAU:String,userId:Int,udid: String,animalId:Int,productId:Int,custId:Int,listId:Int64,serverAnimalId:String,IsEmailData:Bool = false, tertiaryGeno:String) {
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    content.setValue(serverAnimalId, forKey: "serverAnimalId")

    content.setValue(listId, forKey: "listId")
    content.setValue(animalTag, forKey: "animalTag")
    content.setValue(barCodetag, forKey: "animalbarCodeTag")
    content.setValue(date, forKey: "date")
    content.setValue(gender, forKey: "gender")
    content.setValue(permanentId, forKey: "offPermanentId")
    content.setValue(sireId, forKey: "offsireId")
    content.setValue(damId, forKey: "offDamId")
    content.setValue(tissuName, forKey: "tissuName")
    content.setValue(breedName, forKey: "breedName")
    content.setValue(farmId, forKey: "farmId")
    content.setValue(et, forKey: "eT")
    content.setValue(update, forKey: "status")
    content.setValue(orderId, forKey: "orderId")
    content.setValue(orderSataus, forKey: "orderstatus")
    content.setValue(breedId, forKey: "breedId")
    content.setValue(isSync, forKey: "isSync")
    content.setValue(providerId, forKey: "providerId")
    content.setValue(tissuId, forKey: "tissuId")
    content.setValue(sireIDAU, forKey: "sireIDAU")
    content.setValue(nationHerdAU, forKey: "nationHerdAU")
    content.setValue(userId, forKey: "userId")
    content.setValue(udid, forKey: "udid")
    content.setValue(animalId, forKey: "animalId")
    content.setValue(productId, forKey: "productId")
    content.setValue(custId, forKey: "custmerId")
    content.setValue(tertiaryGeno, forKey: "tertiaryGeno")
  //  content.setValue(IsEmailData, forKey: "isDataEmailed")
    do {
        try managedObjectContext.save()
       
    } catch {
       
    }
}
//AND custmerId == %d", animalId,customerID)
func fetchAllDataWithAnimalIdstatus(entityName: String,animalId:Int,orderststus: String,customerId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "animalId == %d AND orderstatus == %@ AND custmerId == %d", animalId,orderststus,customerId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAllDataWithEarTagstatus(entityName: String,animalTag:String,orderststus: String,customerId:Int, pvid: Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "animalTag == %@ AND orderstatus == %@ AND custmerId == %d AND providerId == %d", animalTag,orderststus,customerId,pvid)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}


func fetchAnimalExistData(entityName: String,animalId:Int,orderststus: String,customerId:Int,barcode:String,tissueID:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "animalId == %d AND orderstatus == %@ AND custmerId == %d AND animalbarCodeTag == %@ AND tissuId == %d ", animalId,orderststus,customerId,barcode,tissueID)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func saveProductAdonTbl(entity: String,animalTag: String,barCodetag: String,mkdId: String,productId: Int,productName: String,providerId: Int,status: String,farmId:String,orderId:Int,orderStatus: String,isSync: String,userId:Int,udid:String,animalId:Int,marketName:String,orderTerrms: String,pricing: String,custId:Int,isCdcbProduct:Bool) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    
    content.setValue(animalTag, forKey: "animalTag")
    content.setValue(barCodetag, forKey: "animalbarCodeTag")
    content.setValue(mkdId, forKey: "mkdId")
    content.setValue(productId, forKey: "productId")
    content.setValue(productName, forKey: "productName")
    content.setValue(providerId, forKey: "providerId")
    content.setValue(status, forKey: "status")
    content.setValue(farmId, forKey: "farmId")
    content.setValue(orderId, forKey: "orderId")
    content.setValue(orderStatus, forKey: "orderstatus")
    content.setValue(isSync, forKey: "isSync")
    content.setValue(userId, forKey: "userId")
    content.setValue(udid, forKey: "udid")
    content.setValue(animalId, forKey: "animalId")
    content.setValue(marketName, forKey: "marketName")
    content.setValue(orderTerrms, forKey: "orderAcceptTerms")
    content.setValue(pricing, forKey: "pricing")
    content.setValue(custId, forKey: "custmerId")
    content.setValue(isCdcbProduct, forKey: "isCdcbProduct")
   
    do {
        try managedObjectContext.save()
       
    } catch {
        
    }
}
func saveProductAdonTblEarTagGirlando(entity: String,animalTag: String,barCodetag: String,mkdId: String,productId: Int,productName: String,providerId: Int,status: String,farmId:String,orderId:Int,orderStatus: String,isSync: String,userId:Int,udid:String,animalId:Int,marketName:String,orderTerrms: String,pricing: String,eartag: String,custId:Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    
    content.setValue(animalTag, forKey: "animalTag")
    content.setValue(barCodetag, forKey: "animalbarCodeTag")
    content.setValue(mkdId, forKey: "mkdId")
    content.setValue(productId, forKey: "productId")
    content.setValue(productName, forKey: "productName")
    content.setValue(providerId, forKey: "providerId")
    content.setValue(status, forKey: "status")
    content.setValue(farmId, forKey: "farmId")
    content.setValue(orderId, forKey: "orderId")
    content.setValue(orderStatus, forKey: "orderstatus")
    content.setValue(isSync, forKey: "isSync")
    content.setValue(userId, forKey: "userId")
    content.setValue(udid, forKey: "udid")
    content.setValue(animalId, forKey: "animalId")
    content.setValue(marketName, forKey: "marketName")
    content.setValue(orderTerrms, forKey: "orderAcceptTerms")
    content.setValue(pricing, forKey: "pricing")
    content.setValue(pricing, forKey: "pricing")
    content.setValue(eartag, forKey: "earTag")
    content.setValue(custId, forKey: "custmerId")
    
    
    
    
    do {
        try managedObjectContext.save()
       
    } catch {
       
    }
}

func fetchSpeciesAllData(entityName: String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "speciesName", ascending: true)]
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "speciesId", ascending: true)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray

        }
    } catch {
    }
    
    return commanArray
}

var farmsArrReturn = NSArray ()

func fetchAusNaabBullData() -> NSArray {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName:  "AusNaabBull")
    fetchRequest.returnsDistinctResults = true
    fetchRequest.returnsObjectsAsFaults = false
    //       let fetchPredicate  = NSPredicate(format: "countryId == %@", complexId)
    //       fetchRequest.predicate = fetchPredicate
    do {
        let fetchedResult = try context.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult {
            
            farmsArrReturn = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "bullID", ascending: true)
            let sortedResults = farmsArrReturn.sortedArray(using: [descriptor])
            farmsArrReturn = sortedResults as NSArray
        } else {
            
        }
    }
    catch {
        
    }
    return farmsArrReturn
}

func fetchAusNaabBullDataWithBullid(entityName: String,bullId:String) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest  =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "bullID == %@ || sireNationalId == %@", bullId,bullId)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func beefSaveProductAdonTbl(entity: String,animalTag: String,barCodetag: String,mkdId: String,productId: Int,productName: String,providerId: Int,status: String,farmId:String,orderId:Int,orderStatus: String,isSync: String,userId:Int,udid:String,animalId:Int,rgd:String,rgn:String,marketName:String,custId:Int, orderTerrms: String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    
    content.setValue(animalTag, forKey: "animalTag")
    content.setValue(barCodetag, forKey: "animalbarCodeTag")
    content.setValue(mkdId, forKey: "mkdId")
    content.setValue(productId, forKey: "productId")
    content.setValue(productName, forKey: "productName")
    content.setValue(providerId, forKey: "providerId")
    content.setValue(status, forKey: "status")
    content.setValue(farmId, forKey: "farmId")
    content.setValue(orderId, forKey: "orderId")
    content.setValue(orderStatus, forKey: "orderstatus")
    content.setValue(isSync, forKey: "isSync")
    content.setValue(userId, forKey: "userId")
    content.setValue(udid, forKey: "udid")
    content.setValue(animalId, forKey: "animalId")
    content.setValue(rgd, forKey: "rgd")
    content.setValue(rgn, forKey: "rgn")
    content.setValue(marketName, forKey: "marketName")
    content.setValue(custId, forKey: "custmerId")
    content.setValue(orderTerrms, forKey: "orderAcceptTerms")
    
    do {
        try managedObjectContext.save()
        
    } catch {
        
    }
}
func saveProductIdentify(entity: String,productId: Int,productName: String,providerId: Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    
    content.setValue(productId, forKey: "productId")
    content.setValue(productName, forKey: "productName")
    content.setValue(providerId, forKey: "providerId")
    
    
    do {
        try managedObjectContext.save()
       
    } catch {
      
    }
}


func saveProductSaveBeef(entity: String,productId: Int,productName: String,providerId: Int,breedId: String, mkId: String, status: String, isAdded: String, orderAcceptTerms: String, pricing: String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    
    content.setValue(productId, forKey: "productId")
    content.setValue(productName, forKey: "productName")
    content.setValue(providerId, forKey: "providerId")
    content.setValue(status, forKey: "status")
    content.setValue(breedId, forKey: "breedId")
    content.setValue(mkId, forKey: "marketId")
    content.setValue(isAdded, forKey: "isAdded")
    
    content.setValue(orderAcceptTerms, forKey: "orderAcceptTerms")
    content.setValue(pricing, forKey: "pricing")
    do {
        try managedObjectContext.save()
        
    } catch {
        
    }
}
////

func saveAdonServerRes(entity: String,adonId: Int,adonName: String,offbarcde: String,offfarmId:String,offId:String,productId:Int,serverId:String,userId:Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    
    content.setValue(adonId, forKey: "adonId")
    content.setValue(adonName, forKey: "adonName")
    content.setValue(offbarcde, forKey: "offbarcde")
    content.setValue(offfarmId, forKey: "offfarmId")
    content.setValue(offId, forKey: "offId")
    content.setValue(productId, forKey: "productId")
    content.setValue(serverId, forKey: "serverId")
    content.setValue(userId, forKey: "userId")
    
    
    do {
        try managedObjectContext.save()
       
    } catch {
        
    }
}

func saveImageDetailsInDB(entity: String, dict: NSMutableDictionary) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: entity, in: managedObjectContext)
    let person = NSManagedObject(entity: entity!, insertInto: managedObjectContext)
    let name = dict["name"]
    let url = dict["url"]
    let number = dict["number"]
    let data = dict["imageData"]

    person.setValue(name, forKey: "name")
    person.setValue(url, forKey: "url")
    person.setValue(number, forKey: "number")
    person.setValue(data, forKey: "imageData")

    //  person.setValue(imageData, forKey: "imageData")
    
    //        if imageDataBase64.count > 0 {
    //            let imageData = Data(base64Encoded: imageDataBase64, options: .ignoreUnknownCharacters)
    //            person.setValue(imageData, forKey: "imageData")
    //
    //         }
    
    
    do {
        try managedObjectContext.save()
        } catch {
        }

    }

func fetchImgDetailsFromDB(name:String) -> [NSDictionary] {

    var dataArray = [NSDictionary]()
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "name == %@",name)
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "number", ascending: true)]
//    do {
//        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
//        if let results = fetchedResult {
//            dataArray = results as NSArray
//        } else {
//
//        }
//    } catch {
//    }
    do {
        // Execute the fetch request
        let images = try managedObjectContext.fetch(fetchRequest)
        
        // Loop through the fetched results
        for image in images {
            // Access the properties of the ImageEntity
            if let name = image.name,
               let url = image.url {
                print("Name: \(name), URL: \(url)")
                let number = image.number
                let imageData = image.imageData
                var scoreDict = [String : Any]()
                scoreDict.merge(dict: ["url" : url])
                scoreDict.merge(dict: ["name" : name])
                scoreDict.merge(dict: ["number" : number])
                scoreDict.merge(dict: ["imageData" : imageData!])
                let myNSDictionary = scoreDict as NSDictionary

                // Create an NSArray and add the NSDictionary to it
                let myNSArray = [myNSDictionary]

                // You can access the NSArray and its NSDictionary
                if let firstDict = myNSArray.first {
                    for (key, value) in firstDict {
                        print("Key: \(key), Value: \(value)")
                        dataArray.append([key:value])
                    }
                }
            }
        }
    } catch {
        print("Error fetching data: \(error)")
    }
    print(dataArray.count)
    return dataArray

}

func fetchImgDetailsFromDB() -> [NSDictionary] {
    
    var dataArray = [NSDictionary]()
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()
    fetchRequest.returnsObjectsAsFaults = false
  //  fetchRequest.predicate = NSPredicate(format: "name == %@",name)
    //fetchRequest.sortDescriptors = [NSSortDescriptor(key: "number", ascending: true)]
        do {
            let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                dataArray = (results as NSArray) as! [NSDictionary]
            } else {
    
            }
        } catch {
        }
    return dataArray
}


func saveOffLineOrderId(entity: String,orderId: Int,status: String,isemail:String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    
    content.setValue(orderId, forKey: "orderId")
    content.setValue(status, forKey: "status")
    content.setValue(isemail, forKey: "statusEmail")
    
    
    
    do {
        try managedObjectContext.save()
       
    } catch {
        
    }
}



/////
func saveProductResponseFromServer(entity: String,productId: Int,productName: String,offId:String,farmId:String,barcOde:String,serverId:String,serverstatus:String,productStatus:String,userId:Int,actreq:String,rgn:String,rgd:String,series:String,earTag:String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    
    content.setValue(productId, forKey: "productId")
    content.setValue(productName, forKey: "productName")
    content.setValue(productId, forKey: "productId")
    content.setValue(productName, forKey: "productName")
    content.setValue(offId, forKey: "officialId")
    content.setValue(farmId, forKey: "onfarmId")
    content.setValue(barcOde, forKey: "onBarcode")
    content.setValue(serverId, forKey: "serverOrderId")
    content.setValue(serverstatus, forKey: "serverStatus")
    content.setValue(productStatus, forKey: "productStatus")
    content.setValue(userId, forKey: "userId")
    content.setValue(actreq, forKey: "actionReq")
    //
    content.setValue(rgn, forKey: "rgn")
    content.setValue(rgd, forKey: "rgd")
    content.setValue(series, forKey: "series")
    content.setValue(earTag, forKey: "earTag")
    
    
    
    do {
        try managedObjectContext.save()
       
    } catch {
        
    }
}
func saveSubroductTbl (entity: String,animalTag: String,barCodetag: String,productId: Int,adonName: String,adonId: Int,status: String,orderId:Int,orderStatus: String,isSync: String,userId:Int,udid:String,farmId:String,animalId:Int,custId:Int,textValueEnglish:String,textValuePortugese:String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    
    content.setValue(textValueEnglish, forKey: "textValueEnglish")
    content.setValue(textValuePortugese, forKey: "textValuePortugese")
    
    
    content.setValue(animalTag, forKey: "animalTag")
    content.setValue(barCodetag, forKey: "animalbarCodeTag")
    content.setValue(productId, forKey: "productId")
    content.setValue(adonName, forKey: "adonName")
    content.setValue(adonId, forKey: "adonId")
    content.setValue(status, forKey: "status")
    content.setValue(orderId, forKey: "orderId")
    content.setValue(orderStatus, forKey: "orderstatus")
    content.setValue(isSync, forKey: "isSync")
    content.setValue(userId, forKey: "userId")
    content.setValue(udid, forKey: "udid")
    content.setValue(farmId, forKey: "farmId")
    content.setValue(animalId, forKey: "animalId")
    content.setValue(custId, forKey: "custmerId")
    
    do {
        try managedObjectContext.save()
        
    } catch {
       
    }
}

typealias CompletionHandler = (_ success:Bool) -> Void

func updateAnimalTblData(entity: String,status: String,animalTag: String,orderId: Int,userId: Int,completionHandler: CompletionHandler) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "animalTag == %@ AND orderId == %d AND userId == %d",animalTag,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(status, forKey: "status")
                do
                {
                    
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
    
    completionHandler(true)
    
}

func updateAnimalTblDataDairy(entity: String,status: String,animalTag: Int,orderId: Int,userId: Int,completionHandler: CompletionHandler) {
   
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "animalId == %d AND orderId == %d AND userId == %d",animalTag,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(status, forKey: "status")
                do
                {
                    
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
    
    completionHandler(true)
    
}
func updateAnimalTblDataDairystatus(entity: String,status: String,animalTag: Int,orderId: Int,userId: Int) {
   
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "animalId == %d AND orderId == %d AND userId == %d",animalTag,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(status, forKey: "status")
                do
                {
                    
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
    
    
    
}
func fetchAllDataOrdercheckfarmid(entityName: String,ordestatus: String,farmid:String,userId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND farmId== %@ AND userId == %d", ordestatus,farmid,userId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataOrdercheck(entityName: String,ordestatus: String,animalTag:String,userId:Int, animalBarcode: String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    if animalBarcode != "" {
        fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND animalTag == %@ AND userId == %d AND animalbarCodeTag == %@", ordestatus,animalTag,userId, animalBarcode)

    }
    else {
        fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND animalTag == %@ AND userId == %d", ordestatus,animalTag,userId)

    }
    
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataofflicalID(entityName: String,animalTag:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "animalTag == %@",animalTag)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataOrderStatusMaster(entityName: String,ordestatus: String,userId:Int,farmId:String,animalTag:String,barcodeTag:String, sireID: String = "",damId: String = "") -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  if sireID == "" {
    fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND userId == %d AND farmId == %@ AND animalTag == %@ AND animalbarCodeTag == %@", ordestatus,userId,farmId,animalTag,barcodeTag)
  } else {
   
    fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND userId == %d AND farmId == %@ AND animalTag == %@ AND animalbarCodeTag == %@ AND offsireId == %@ AND offDamId == %@", ordestatus,userId,farmId,animalTag,barcodeTag,sireID,damId)
  }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

//
func fetchAllDataWithAnimalId(entityName: String,animalId:Int,customerID: Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "animalId == %d AND custmerId == %d", animalId,customerID)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}




func updateProducData(entity: String,productID:Int,status: String,animalTag: String,orderId:Int,userId:Int,completionHandler: CompletionHandler) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "productId == %d AND animalTag == %@ AND orderId == %d AND userId == %d", productID,animalTag,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(status, forKey: "status")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
    completionHandler(true)
    
}

func updateProducDataDairy(entity: String,productID:Int,status: String,animalTag: Int,orderId:Int,userId:Int,completionHandler: CompletionHandler) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "productId == %d AND animalId == %d AND orderId == %d AND userId == %d", productID,animalTag,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(status, forKey: "status")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
    completionHandler(true)
    
}

func updateProducDataSingle(entity: String,productID:Int,status: String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "productId == %d", productID)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(status, forKey: "status")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func updateBeeanimalIsUpade(entity: String,isUpadte:String,animalId: String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "animalTag == %@", animalId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(isUpadte, forKey: "isUpadte")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateBeeanimalIsUpadeWithout(entity: String,isUpadte:String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    // requestDel.predicate = NSPredicate(format: "animalTag == %@", animalId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(isUpadte, forKey: "isUpadte")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateAdonData(entity: String,adonId:Int,status: String,animaltag: String,orderId:Int,userId:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "adonId == %d AND animalTag == %@ AND orderId == %d  AND userId == %d", adonId,animaltag,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(status, forKey: "status")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func updateAdonDataDairy(entity: String,adonId:Int,status: String,animaltag: Int,orderId:Int,userId:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "adonId == %d AND animalId == %d AND orderId == %d  AND userId == %d", adonId,animaltag,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(status, forKey: "status")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateAdonDataDairyFalseClarifide(entity: String,adonId:String,status: String,animaltag: Int,orderId:Int,userId:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "adonName == %@ AND animalId == %d AND orderId == %d  AND userId == %d", adonId,animaltag,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(status, forKey: "status")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateAdonDataSingle(entity: String,adonId:Int,status: String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "adonId == %d", adonId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(status, forKey: "status")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateProviderIDAnimal(entityName: String,ordestatus: String,providerId: Int,orderId:Int,userId:Int){
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entityName)
    requestDel.predicate = NSPredicate(format: "orderstatus == %@ AND orderId == %d AND userId == %d", ordestatus,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
  
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(providerId, forKey: "providerId")
                //objTable.setValue("true", forKey: "status")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
    
}

func updateBeefAnimalProviderID_AnimalTag_Sireid(entityName: String,ordestatus: String,providerId: Int,orderId:Int,userId:Int, earTag:String,sireIDAU: String, barCode: String){
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entityName)
    requestDel.predicate = NSPredicate(format: "orderstatus == %@ AND orderId == %d AND userId == %d AND animalbarCodeTag == %@", ordestatus,orderId,userId, barCode)
    requestDel.returnsObjectsAsFaults = false
  
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(providerId, forKey: "providerId")
                objTable.setValue(earTag, forKey: "animalTag")
                objTable.setValue(sireIDAU, forKey: "sireIDAU")
             
                //objTable.setValue("true", forKey: "status")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
    
}
func updateOrderStatus(entity: String,status: String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "orderstatus == %@", status)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue("true", forKey: "orderstatus")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateOrderStatusISyncAnimal(entity: String,isSync: String,status:String,orderstatus: String,orderId:Int,userId:Int,toUpdate:String = "true") {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "isSync == %@ AND status == %@ AND orderstatus == %@ AND orderId  == %d AND userId  == %d ", isSync,status,orderstatus,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue("true", forKey: "isSync")
                objTable.setValue("false", forKey: "status")
                objTable.setValue(toUpdate, forKey: "orderstatus")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateOrderStatusISyncAnimalMaster(entity: String,isSync: String,status:String,orderstatus: String,orderId:Int,userId:Int,animalId:Int,toUpdate:String = "true") {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "isSync == %@ AND status == %@ AND orderstatus == %@ AND orderId  == %d AND userId  == %d AND animalId  == %d", isSync,status,orderstatus,orderId,userId,animalId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue("true", forKey: "isSync")
                objTable.setValue("false", forKey: "status")
                objTable.setValue(toUpdate, forKey: "orderstatus")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func updateOrderStatusISyncAnimalOffline(entity: String,isSync: String,status:String,orderId:Int,userId:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "isSync == %@ AND status == %@ AND orderId  == %d AND userId  == %d ", isSync,status,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue("true", forKey: "isSync")
                objTable.setValue("false", forKey: "status")
                objTable.setValue("true", forKey: "orderstatus")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func inheritUpdateOrderStatusISyncAnimalMaster(entity: String,animalTag: String,barCodetag: String,date: String,damId: String,sireId: String,gender: String,update: String,permanentId: String,tissuName: String,breedName: String,et: String,farmId: String,orderId: Int,orderSataus:String,breedId: String,isSync:String,providerId:Int,tissuId: Int,sireIDAU:String,nationHerdAU:String,userId:Int,udid: String,animalId:Int,sirYOB :String,damYOB:String,sireRegAssocation:String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "userId == %d AND providerId == %d AND animalId == %d", userId,providerId,animalId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
              
               objTable.setValue(true, forKey: "editFlagSave")
                objTable.setValue(animalTag, forKey: "animalTag")
                objTable.setValue(barCodetag, forKey: "animalbarCodeTag")
                objTable.setValue(date, forKey: "date")
                objTable.setValue(gender, forKey: "gender")
                objTable.setValue(permanentId, forKey: "offPermanentId")
                objTable.setValue(sireId, forKey: "offsireId")
                objTable.setValue(damId, forKey: "offDamId")
                objTable.setValue(tissuName, forKey: "tissuName")
                objTable.setValue(breedName, forKey: "breedName")
                objTable.setValue(farmId, forKey: "farmId")
                objTable.setValue(et, forKey: "eT")
                // objTable.setValue(update, forKey: "status")
                //objTable.setValue(orderId, forKey: "orderId")
                // objTable.setValue(orderSataus, forKey: "orderstatus")
                objTable.setValue(breedId, forKey: "breedId")
                objTable.setValue(isSync, forKey: "isSync")
                objTable.setValue(providerId, forKey: "providerId")
                objTable.setValue(tissuId, forKey: "tissuId")
                objTable.setValue(sireIDAU, forKey: "sireIDAU")
                objTable.setValue(nationHerdAU, forKey: "nationHerdAU")
                objTable.setValue(userId, forKey: "userId")
                objTable.setValue(udid, forKey: "udid")
              if entity == Entities.dataEntryBeefAnimalAddTblEntity{
                objTable.setValue(2, forKey: "addeditdelete")
              }
               // objTable.setValue(animalId, forKey: "animalId")
                objTable.setValue(sirYOB, forKey: "sireYOB")
                objTable.setValue(damYOB, forKey: "damYOB")
                objTable.setValue(sireRegAssocation, forKey: "sireRegAssocation")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}


func updateOrderStatusISyncAnimalMaster(entity: String,animalTag: String,barCodetag: String,date: String,damId: String,sireId: String,gender: String,update: String,permanentId: String,tissuName: String,breedName: String,et: String,farmId: String,orderId: Int,orderSataus:String,breedId: String,isSync:String,providerId:Int,tissuId: Int,sireIDAU:String,nationHerdAU:String,userId:Int,udid: String,animalId:Int, selectedBornTypeId: Int? = nil,isSyncServer:Bool,adhDataServer:Bool,editFlagSave:Bool , territoryGeno: String, productID: Int = 0) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "userId == %d AND orderId == %d  AND animalId == %d", userId,orderId,animalId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                objTable.setValue(editFlagSave, forKey: "editFlagSave")
                objTable.setValue(animalTag, forKey: "animalTag")
                objTable.setValue(barCodetag, forKey: "animalbarCodeTag")
                objTable.setValue(date, forKey: "date")
                objTable.setValue(gender, forKey: "gender")
                objTable.setValue(permanentId, forKey: "offPermanentId")
                objTable.setValue(sireId, forKey: "offsireId")
                objTable.setValue(damId, forKey: "offDamId")
                objTable.setValue(tissuName, forKey: "tissuName")
                objTable.setValue(breedName, forKey: "breedName")
                objTable.setValue(farmId, forKey: "farmId")
                objTable.setValue(et, forKey: "eT")
                objTable.setValue(breedId, forKey: "breedId")
                objTable.setValue(isSync, forKey: "isSync")
                objTable.setValue(providerId, forKey: "providerId")
                objTable.setValue(tissuId, forKey: "tissuId")
                objTable.setValue(sireIDAU, forKey: "sireIDAU")
                objTable.setValue(nationHerdAU, forKey: "nationHerdAU")
                objTable.setValue(userId, forKey: "userId")
                objTable.setValue(udid, forKey: "udid")
                objTable.setValue(animalId, forKey: "animalId")
                objTable.setValue(selectedBornTypeId, forKey: "selectedBornTypeId")
                objTable.setValue(adhDataServer, forKey: "adhDataServer")
                objTable.setValue(isSyncServer, forKey: "isSyncServer")
              if productID != 0 {
                objTable.setValue(productID, forKey: "productId")
              }
              
              if entity == "BeefAnimalMaster" || entity == "BeefAnimaladdTbl" || entity == "DataEntryBeefAnimaladdTbl" {
                objTable.setValue(territoryGeno, forKey: "tertiaryGeno")
              }

                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
///


func updateOrderStatusISyncAnimalMasterNew(entity: String,animalTag: String,barCodetag: String,date: String,damId: String,sireId: String,gender: String,update: String,permanentId: String,tissuName: String,breedName: String,et: String,farmId: String,orderId: Int,orderSataus:String,breedId: Int,isSync:String,providerId:Int,tissuId: Int,sireIDAU:String,nationHerdAU:String,userId:Int,udid: String,animalId:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "userId == %d AND orderId == %d  OR animalTag == %@ OR animalbarCodeTag == %@ OR offPermanentId == %@ ", userId,orderId,animalTag,barCodetag,permanentId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(animalTag, forKey: "animalTag")
                objTable.setValue(barCodetag, forKey: "animalbarCodeTag")
                objTable.setValue(date, forKey: "date")
                objTable.setValue(gender, forKey: "gender")
                objTable.setValue(permanentId, forKey: "offPermanentId")
                objTable.setValue(sireId, forKey: "offsireId")
                objTable.setValue(damId, forKey: "offDamId")
                objTable.setValue(tissuName, forKey: "tissuName")
                objTable.setValue(breedName, forKey: "breedName")
                objTable.setValue(farmId, forKey: "farmId")
                objTable.setValue(et, forKey: "eT")
                objTable.setValue(update, forKey: "status")
                //objTable.setValue(orderId, forKey: "orderId")
                // objTable.setValue(orderSataus, forKey: "orderstatus")
                objTable.setValue(breedId, forKey: "breedId")
                objTable.setValue(isSync, forKey: "isSync")
                objTable.setValue(providerId, forKey: "providerId")
                objTable.setValue(tissuId, forKey: "tissuId")
                objTable.setValue(sireIDAU, forKey: "sireIDAU")
                objTable.setValue(nationHerdAU, forKey: "nationHerdAU")
                objTable.setValue(userId, forKey: "userId")
                objTable.setValue(udid, forKey: "udid")
                // objTable.setValue(animalId, forKey: "animalId")
                
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

///

func InheritUpdateOrderStatusISyncAnimalMasterAnimalId(entity: String,animalTag: String,barCodetag: String,date: String,damId: String,sireId: String,gender: String,update: String,permanentId: String,tissuName: String,breedName: String,et: String,farmId: String,orderId: Int,orderSataus:String,breedId: String,isSync:String,providerId:Int,tissuId: Int,sireIDAU:String,nationHerdAU:String,userId:Int,udid: String,animalId:Int,animalidNew:Int,sirYOB:String,DamYOB:String,sireRegAssocation:String) {
  var custmerId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "userId == %d AND animalId == %d ",userId,animalId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(animalTag, forKey: "animalTag")
                objTable.setValue(barCodetag, forKey: "animalbarCodeTag")
                objTable.setValue(date, forKey: "date")
                objTable.setValue(gender, forKey: "gender")
                objTable.setValue(permanentId, forKey: "offPermanentId")
                objTable.setValue(sireId, forKey: "offsireId")
                objTable.setValue(damId, forKey: "offDamId")
                objTable.setValue(tissuName, forKey: "tissuName")
                objTable.setValue(breedName, forKey: "breedName")
                objTable.setValue(farmId, forKey: "farmId")
                objTable.setValue(et, forKey: "eT")
                objTable.setValue(update, forKey: "status")
                objTable.setValue(orderId, forKey: "orderId")
                // objTable.setValue(orderSataus, forKey: "orderstatus")
                objTable.setValue(breedId, forKey: "breedId")
                objTable.setValue(isSync, forKey: "isSync")
                objTable.setValue(providerId, forKey: "providerId")
                objTable.setValue(tissuId, forKey: "tissuId")
                objTable.setValue(sireIDAU, forKey: "sireIDAU")
                objTable.setValue(nationHerdAU, forKey: "nationHerdAU")
                objTable.setValue(userId, forKey: "userId")
                objTable.setValue(udid, forKey: "udid")
                objTable.setValue(animalidNew, forKey: "animalId")
                objTable.setValue(sirYOB, forKey: "sireYOB")
                objTable.setValue(DamYOB, forKey: "damYOB")
                objTable.setValue(sireRegAssocation, forKey: "sireRegAssocation")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func updateOrderStatusISyncAnimalMasterAnimalId(entity: String,animalTag: String,barCodetag: String,date: String,damId: String,sireId: String,gender: String,update: String,permanentId: String,tissuName: String,breedName: String,et: String,farmId: String,orderId: Int,orderSataus:String,breedId: String,isSync:String,providerId:Int,tissuId: Int,sireIDAU:String,nationHerdAU:String,userId:Int,udid: String,animalId:Int,animalidNew:Int, selectedBornTypeId: Int? = nil,isSyncServer:Bool,adhDataServer:Bool, tertiaryGeno: String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "userId == %d AND animalId == %d ", userId,animalId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(animalTag, forKey: "animalTag")
                objTable.setValue(barCodetag, forKey: "animalbarCodeTag")
                objTable.setValue(date, forKey: "date")
                objTable.setValue(gender, forKey: "gender")
                objTable.setValue(permanentId, forKey: "offPermanentId")
                objTable.setValue(sireId, forKey: "offsireId")
                objTable.setValue(damId, forKey: "offDamId")
                objTable.setValue(tissuName, forKey: "tissuName")
                objTable.setValue(breedName, forKey: "breedName")
                objTable.setValue(farmId, forKey: "farmId")
                objTable.setValue(et, forKey: "eT")
                objTable.setValue(update, forKey: "status")
                objTable.setValue(orderId, forKey: "orderId")
                // objTable.setValue(orderSataus, forKey: "orderstatus")
                objTable.setValue(breedId, forKey: "breedId")
                objTable.setValue(isSync, forKey: "isSync")
                objTable.setValue(providerId, forKey: "providerId")
                objTable.setValue(tissuId, forKey: "tissuId")
                objTable.setValue(sireIDAU, forKey: "sireIDAU")
                objTable.setValue(nationHerdAU, forKey: "nationHerdAU")
                objTable.setValue(userId, forKey: "userId")
                objTable.setValue(udid, forKey: "udid")
                objTable.setValue(animalidNew, forKey: "animalId")
                objTable.setValue(selectedBornTypeId, forKey: "selectedBornTypeId")
                
                objTable.setValue(isSyncServer, forKey: "isSyncServer")
                objTable.setValue(adhDataServer, forKey: "adhDataServer")
              if entity == "BeefAnimaladdTbl" ||  entity == "BeefAnimalMaster" {
               objTable.setValue(tertiaryGeno, forKey: "tertiaryGeno")
              }

                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func updateOrderStatusISyncProduct(entity: String,animalTag: String,barCodetag: String,farmId: String,orderId: Int,userId:Int,animalId:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "userId == %d AND orderId == %d AND animalId == %d", userId,orderId,animalId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(animalTag, forKey: "animalTag")
                objTable.setValue(barCodetag, forKey: "animalbarCodeTag")
                objTable.setValue(farmId, forKey: "farmId")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateOrderStatusISyncProductbr(entity: String,animalTag: String,barCodetag: String,farmId: String,orderId: Int,userId:Int,animalId:Int,rgd:String,rgn:String,serie:String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "userId == %d AND orderId == %d AND animalId == %d", userId,orderId,animalId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(animalTag, forKey: "animalTag")
                objTable.setValue(serie, forKey: "animalbarCodeTag")
                
                
                objTable.setValue(rgd, forKey: "rgd")
                objTable.setValue(rgn, forKey: "rgn")

                objTable.setValue(farmId, forKey: "farmId")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateOrderStatusAnimal(entity: String,status: String,orderId: Int,userId:Int,animalId:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "userId == %d AND orderId == %d AND animalId == %d", userId,orderId,animalId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(status, forKey: "status")
                
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateOrderStatusISyncProductWithotAnimalID(entity: String,animalTag: String,barCodetag: String,farmId: String,orderId: Int,userId:Int,animalId:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "userId == %d AND orderId == %d AND animalTag == %@ OR animalbarCodeTag == %@ OR farmId == %@", userId,orderId,animalTag,barCodetag,farmId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(animalTag, forKey: "animalTag")
                objTable.setValue(barCodetag, forKey: "animalbarCodeTag")
                objTable.setValue(farmId, forKey: "farmId")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
//
func updateOrderStatusISyncSubProduct(entity: String,animalTag: String,barCodetag: String,farmId: String,orderId: Int,userId:Int,animalId:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "userId == %d AND orderId == %d AND animalId == %d", userId,orderId,animalId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(animalTag, forKey: "animalTag")
                objTable.setValue(barCodetag, forKey: "animalbarCodeTag")
                objTable.setValue(farmId, forKey: "farmId")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateOrderStatusISyncAnimalOFFline(entity: String,isSync: String,status:String,orderstatus: String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "isSync == %@ AND status == %@ AND orderstatus == %@ ", isSync,status,orderstatus)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue("false", forKey: "isSync")
                // objTable.setValue("false", forKey: "status")
                objTable.setValue("true", forKey: "orderstatus")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func updateOrderStatusISyncAnimalOFFlineMaster(entity: String,isSync: String,status:String,orderstatus: String,aid:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "isSync == %@ AND status == %@ AND orderstatus == %@ AND animalId == %d", isSync,status,orderstatus,aid)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue("false", forKey: "isSync")
                // objTable.setValue("false", forKey: "status")
                objTable.setValue("true", forKey: "orderstatus")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateOrderStatusISyncProduct(entity: String,isSync: String,animalTag:Int,orderstatus: String,orderId:Int,userId:Int, toUpdate:String = "true") {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "isSync == %@ AND animalId == %d AND orderstatus == %@ AND orderId == %d AND userId == %d", isSync,animalTag,orderstatus,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue("true", forKey: "isSync")
                // objTable.setValue("false", forKey: "status")
                objTable.setValue(toUpdate, forKey: "orderstatus")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateOrderStatusISyncProductclarifde(entity: String,isSync: String,animalTag:Int,orderstatus: String,orderId:Int,userId:Int,productName:String,status: String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "isSync == %@ AND animalId == %d AND orderstatus == %@ AND orderId == %d AND userId == %d AND  productName == %@ AND  status ==%@", isSync,animalTag,orderstatus,orderId,userId,productName,status)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue("true", forKey: "clarifidestatus")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateOrderStatusISyncProductclarifdeAU(entity: String,isSync: String,animalTag:Int,orderstatus: String,orderId:Int,userId:Int,productName:String,productName1:String,productName2:String,status:String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    
    requestDel.predicate = NSPredicate(format: "isSync == %@ AND animalId == %d AND orderstatus == %@ AND orderId == %d AND userId == %d  AND status == %@ AND (productName == %@  OR productName == %@ OR productName == %@)", isSync,animalTag,orderstatus,orderId,userId,status,productName,productName1,productName2)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue("true", forKey: "clarifidestatusAu")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateOrderStatusISyncProductclarifdeUK(entity: String,isSync: String,animalTag:Int,orderstatus: String,orderId:Int,userId:Int,productName:String,productName1:String,productName2:String,status:String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    
    requestDel.predicate = NSPredicate(format: "isSync == %@ AND animalId == %d AND orderstatus == %@ AND orderId == %d AND userId == %d  AND status == %@ AND (productName == %@  OR productName == %@ OR productName == %@)", isSync,animalTag,orderstatus,orderId,userId,status,productName,productName1,productName2)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue("true", forKey: "clarifidestatusUk")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateOrderStatusISyncProductOFFline(entity: String,isSync: String,animalTag:Int,status: String,orderId:Int,userId:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "isSync == %@ AND animalId == %d AND status == %@ AND orderId == %d AND userId == %d", isSync,animalTag,status,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue("true", forKey: "isSync")
                objTable.setValue("false", forKey: "status")
                objTable.setValue("true", forKey: "orderstatus")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func updateOrderStatusISyncProductOFFLine(entity: String,isSync: String,animalTag:Int,orderstatus: String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "isSync == %@ AND animalId == %d AND orderstatus == %@ ", isSync,animalTag,orderstatus)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue("false", forKey: "isSync")
                // objTable.setValue("false", forKey: "status")
                objTable.setValue("true", forKey: "orderstatus")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func updateOrderStatusServer(entity: String,isSync: String,status:String,orderstatus: String,orderId:Int,userId:Int,newOrderId:Int,udid:String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "isSync == %@ AND status == %@ AND orderstatus == %@ AND orderId == %d  AND userId == %d", isSync,status,orderstatus,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                // objTable.setValue("false", forKey: "orderstatus")
                objTable.setValue(newOrderId, forKey: "orderId")
                objTable.setValue(udid, forKey: "udid")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateOrderStatusServerRemain(entity: String,aniamltag:String,userId:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "animalTag == %@  AND userId == %d", aniamltag,userId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                objTable.setValue("false", forKey: "orderstatus")
                
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func updateOrderStatusISyncAdon(entity: String,isSync: String,status:String,orderstatus: String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "isSync == %@ AND status == %@ AND orderstatus == %@ ", isSync,status,orderstatus)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue("true", forKey: "isSync")
                objTable.setValue("false", forKey: "status")
                objTable.setValue("true", forKey: "orderstatus")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func saveAnimaldataProductList (entity: String,animalTag: String,barCodetag: String,date: String,regCode: String,regrfid: String,gender: String,addonId:String,AddonName:String ,ProductId: Int, ProductName: String,MKId: Int,PvId: Int,status: String) {
    if entity == "ProductAddTbl" {
        let data =   fetchProductAdonData(entityName: entity, prodId: ProductId)
        if data.count > 0 {
            return
        }
    }
    else{
        let data =   fetchProductAdonDatawithAonId(entityName: "AdontAddTbl", addonId: addonId)
        if data.count > 0{
            return
        }
    }
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    
    content.setValue(animalTag, forKey: "animalTag")
    content.setValue(barCodetag, forKey: "animalbarCodeTag")
    content.setValue(date, forKey: "date")
    content.setValue(gender, forKey: "gender")
    content.setValue(regCode, forKey: "regCode")
    content.setValue(regrfid, forKey: "regrfid")
    content.setValue(addonId, forKey: "addonId")
    content.setValue(AddonName, forKey: "addoName")
    content.setValue(ProductId, forKey: "productId")
    content.setValue(ProductName, forKey: "productName")
    content.setValue(MKId, forKey: "mkdId")
    content.setValue(PvId, forKey: "providerId")
    content.setValue(status, forKey: "status")
    
    do {
        try managedObjectContext.save()
      
    } catch {
      
    }
}



func updateSettingData(entity: String,specid: Int,providerName: String,providerId: Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "SettingTbl")
    requestDel.predicate = NSPredicate(format: "specid == %d", providerId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                objTable.setValue(providerName, forKey: "providerName")
                objTable.setValue(providerId, forKey: "providerId")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func updateAdoonTabl(entity: String,AdonId: Int,status: String,productId :Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "GetAdonTbl")
    requestDel.predicate = NSPredicate(format: "adonId == %d AND productId == %d", AdonId,productId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                objTable.setValue(status, forKey: "status")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateAdoonTablClarifide(entity: String,AdonId: String,status: String,productId :Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "GetAdonTbl")
    requestDel.predicate = NSPredicate(format: "adonName == %@ AND productId == %d", AdonId,productId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                objTable.setValue(status, forKey: "status")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateAdoonTablBVDV(entity: String,AdonId: String,status: String,orderId:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    requestDel.predicate = NSPredicate(format: "adonName == %@ AND orderId == %d", AdonId,orderId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                objTable.setValue(status, forKey: "status")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateAdoonTablBVDVMaster(entity: String,AdonId: String,status: String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    requestDel.predicate = NSPredicate(format: "adonName == %@ ", AdonId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                objTable.setValue(status, forKey: "status")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func fetchAllAdonSingle (entityName: String,status: String,productId: Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "status == %@ AND productId ==  %d" , status,productId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllAdonSingleBeefAdonlist (entityName: String,status: String,productId: Int,orderId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "status == %@ AND productId ==  %d AND orderId == %d" , status,productId,orderId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}
func updateProductTablData(entity: String,status: String,completionHandler: CompletionHandler) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                objTable.setValue(status, forKey: "status")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
    completionHandler(true)
    
}

func fetchBornTypesWithProviderId(entityName: String, providerId:Int) -> [GetBornTypes] {
    var results = [GetBornTypes]()
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "providerId ==%d", providerId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResults = try managedObjectContext.fetch(requestDel) as? [GetBornTypes]
        if let fetchedResult = fetchedResults {
            results = fetchedResult
        }
    } catch {
    }
    
    return results
}

func updateProductTablStatus(entity: String){
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity )
    
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                objTable.setValue("false", forKey: "status")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func updateProductTabl(entity: String,productId: Int,status: String,completionHandler: CompletionHandler) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    requestDel.predicate = NSPredicate(format: "productId == %d", productId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                objTable.setValue(status, forKey: "status")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
    completionHandler(true)
    
}
func fetchAllProductlistBreed (entityName: String,status: String,providerId: Int,breedId:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "status == %@ AND providerId ==  %d AND breedId == %@" , status,providerId,breedId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllProductlistBreedBeef (entityName: String,status: String,providerId: Int,breedId:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "status == %@ AND providerId ==  %d" , status,providerId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}

func updateProviderSettingData (specisId: Int,specisName: String,providerName: String,providerId: Int,nominater: String, fromDatae: String, toDate: String,status: String,index: Int){
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "Saveprovider")
    requestDel.predicate = NSPredicate(format: "providerId == %d", providerId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                objTable.setValue(specisName, forKey: "specisName")
                objTable.setValue(fromDatae, forKey: "fromDate")
                objTable.setValue(toDate, forKey: "toDate")
                objTable.setValue(index, forKey: "index")
                objTable.setValue(status, forKey: "status")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func readData(entity: String, attributeKey: String?, completion: @escaping (CoreDataResponse)) -> Void {
    let request = NSFetchRequest < NSFetchRequestResult > (entityName: entity)
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    request.returnsObjectsAsFaults = false
    request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
    
    do {
        let results = try managedObjectContext.fetch(request)
        
    } catch {
       
    }
    
}

func fetchAllSelectedProduct(entityName: String, status: String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    fetchRequest.predicate = NSPredicate(format: "status ==%@", status)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAllData(entityName: String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchBillingCustomer(entityName: String,customerID:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "custId == %d",customerID)
    
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAutoAnimalCustomer(entityName: String,customerID:Int64) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerID == %d",customerID)
    
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func updateBillingCustomer(entity: String,customerID: Int,isDefault: Bool,billcustomerId: String,billcustomerName: String) {
   
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "custId == %d AND billToCustId == %@ AND contactName == %@",customerID,billcustomerId,billcustomerName)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(isDefault, forKey: "isDefault")
                do
                {
                    
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
    
    
    
}

func fetchResultHeaderAllData(entityName: String, productName: String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  if productName == "Herdity" {
     let pName = "CLARIFIDE CDCB"
    fetchRequest.predicate = NSPredicate(format: "productName == %@ OR productName == %@",productName,pName)
  } else {
    fetchRequest.predicate = NSPredicate(format: "productName == %@",productName)
  }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchResultHeaderAllDataForSearchAnimal(entityName: String, productName: String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
 
    fetchRequest.predicate = NSPredicate(format: "productName == %@",productName)
  
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataPriorityData(entityName: String,priorityBreedId:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "priorityBreedName == %@",priorityBreedId)
    
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataPriorityDataId(entityName: String,priorityBreedId:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "priorityBreedId == %@",priorityBreedId)
    
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchDataEntryListGet(entityName: String,customerId:Int64,userId:Int,providerId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND providerId == %d",customerId,providerId)
    
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "listId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchDataEntryListGetBeefProduct(entityName: String,customerId:Int64,userId:Int,providerId:Int,productType:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND providerId == %d AND productType == %@",customerId,providerId,productType)
    
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "listId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataCustomer(entityName: String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "customerName", ascending: true)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    
    return commanArray
}








func fetchAllDataWithCustomerID(entityName: String,customerId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "customerId ==%d", customerId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAllDataWithOrderID(entityName: String,orderId:Int,userId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "orderId ==%d AND userId ==%d AND orderstatus == %@ " ,orderId,userId,"false")
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataWithOrderIDWithBeef(entityName: String,pid:Int,userId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "productId ==%d AND userId ==%d" ,pid,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAnimaldataValidate(entityName: String, animalTag: String,farmId:String,animalbarCodeTag:String,offPermanentId:String,offDamId:String,offsireId:String,orderId:Int,userId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "animalTag == %@ or farmId == %@ or animalbarCodeTag == %@ or offPermanentId == %@ AND orderId ==%d AND userId ==%d" ,animalTag ,farmId,animalbarCodeTag,offPermanentId,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAnimaldataValidateAnimalMaster(entityName: String, animalTag: String,farmId:String,animalbarCodeTag:String,offPermanentId:String,offDamId:String,offsireId:String,orderId:Int,userId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "(animalTag == %@ or farmId == %@ or animalbarCodeTag == %@) AND userId == %d AND orderId == %d" ,animalTag ,farmId,animalbarCodeTag,userId,orderId)
    //  requestDel.predicate = NSPredicate(format: "farmId == %@ AND userId == %d" ,farmId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchAnimaldataValidateAnimalId(entityName: String, animalId:Int, orderId:Int,userId:Int,orderStatus:String,listId: Int = 0) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    if listId == 0 {
        requestDel.predicate = NSPredicate(format: "animalId == %d AND userId == %d  AND orderstatus == %@" ,animalId ,userId,orderStatus)
    }
    else {
        requestDel.predicate = NSPredicate(format: "animalId == %d AND userId == %d  AND orderstatus == %@ AND listId == %d" ,animalId ,userId,orderStatus, listId)
    }
    
    //  requestDel.predicate = NSPredicate(format: "farmId == %@ AND userId == %d" ,farmId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAnimaldataValidateBarcodeforValidationBeef(entityName: String, barcode:String,userId:Int,orderId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "animalbarCodeTag ==%@ AND userId == %d AND orderId == %d" ,barcode,userId,orderId)
    //  requestDel.predicate = NSPredicate(format: "farmId == %@ AND userId == %d" ,farmId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
//fetchRequest.predicate = NSPredicate(format: "farmId LIKE[c] %@  AND custmerId == %d", animalId,custmerId)

func fetchAnimaldataValidateAnimalIdforValidationBeef(entityName: String, animalId:String,userId:Int,orderId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "animalTag LIKE[c] %@ AND userId == %d AND orderId == %d" ,animalId,userId,orderId)
    //  requestDel.predicate = NSPredicate(format: "farmId == %@ AND userId == %d" ,farmId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAnimaldataValidateAnimalIdforValidationBeefEartag(entityName: String, animalId:String,userId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "animalTag ==%@ AND userId == %d " ,animalId,userId)
    //  requestDel.predicate = NSPredicate(format: "farmId == %@ AND userId == %d" ,farmId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAnimaldataValidateAnimalIdforValidationBeefBarcode(entityName: String, animalId:String,userId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "animalbarCodeTag ==%@ AND userId == %d" ,animalId,userId)
    //  requestDel.predicate = NSPredicate(format: "farmId == %@ AND userId == %d" ,farmId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAnimaldataValidateAnimalIdUpdate(entityName: String ,farmId: String,animalTag:String,barcodeTag:String,userId:Int,orderStatus: String,animalId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "animalTag ==%@ OR userId == %d  OR orderstatus == %@ OR farmId == %@ OR animalbarCodeTag == %@ OR animalId == %d" ,animalTag ,userId,orderStatus,farmId,barcodeTag,animalId)
    //  requestDel.predicate = NSPredicate(format: "farmId == %@ AND userId == %d" ,farmId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAnimaldataValidateAnimalwithouOrderIDAnd(entityName: String, animalTag: String,farmId:String,animalbarCodeTag:String,offPermanentId:String,offDamId:String,offsireId:String,orderId:Int,userId:Int,custmerId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
    let pid =   UserDefaults.standard.integer(forKey: "BfProductId")
    
    if  UserDefaults.standard.value(forKey: "name") as? String == "Beef" {
        if pvid == 5  || pvid == 7 {
            requestDel.predicate = NSPredicate(format: "(animalTag LIKE[c] %@ ) AND userId == %d AND productId == %d AND custmerId == %d" ,animalTag,userId,pid,custmerId)
            
        }
        else if  pvid == 6{
            requestDel.predicate = NSPredicate(format: "(animalTag LIKE[c] %@ ) AND userId == %d AND productId == %d AND custmerId == %d" ,animalTag,userId,pid,custmerId)
        }
        
    } else {
        if animalTag == "" && farmId  == ""{
            requestDel.predicate = NSPredicate(format: "animalTag LIKE[c] %@ AND farmId LIKE[c] %@ AND userId == %d AND custmerId == %d" ,animalTag,farmId,userId,custmerId)
        }
        else if animalTag == ""{
            requestDel.predicate = NSPredicate(format: "farmId LIKE[c] %@ AND userId == %d AND custmerId == %d" ,farmId,userId,custmerId)
        }
        else if farmId == "" {
            requestDel.predicate = NSPredicate(format: "animalTag LIKE[c] %@  AND userId == %d AND custmerId == %d " ,animalTag,userId,custmerId)
        }
        else {
            requestDel.predicate = NSPredicate(format: "(animalTag LIKE[c] %@ AND farmId LIKE[c] %@) AND userId == %d AND custmerId == %d" ,animalTag,farmId,userId,custmerId)
        }
        
    }
    
    //  requestDel.predicate = NSPredicate(format: "farmId == %@ AND userId == %d" ,farmId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAnimaldataValidateAnimalwithouOrderIDAND(entityName: String, animalTag: String,farmId:String,animalbarCodeTag:String,offPermanentId:String,offDamId:String,offsireId:String,orderId:Int,userId:Int,custmerId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
    let pid =   UserDefaults.standard.integer(forKey: "BfProductId")
    
    if  UserDefaults.standard.value(forKey: "name") as? String == "Beef" {
        if pvid == 5  || pvid == 7 {
            requestDel.predicate = NSPredicate(format: "(animalTag LIKE[c] %@ ) AND userId == %d AND productId == %d AND custmerId == %d" ,animalTag,userId,pid,custmerId)
            
        }
        else if  pvid == 6{
            requestDel.predicate = NSPredicate(format: "(animalTag LIKE[c] %@ ) AND userId == %d AND productId == %d AND custmerId == %d" ,animalTag,userId,pid,custmerId)
        }
        
    } else {
        if animalTag == "" && farmId  == ""{
            requestDel.predicate = NSPredicate(format: "animalTag LIKE[c] %@ AND farmId LIKE[c] %@ AND userId == %d AND custmerId == %d" ,animalTag,farmId,userId,custmerId)
        }
        else if animalTag == ""{
            requestDel.predicate = NSPredicate(format: "farmId LIKE[c] %@ AND userId == %d AND custmerId == %d" ,farmId,userId,custmerId)
        }
        else if farmId == "" {
            requestDel.predicate = NSPredicate(format: "animalTag LIKE[c] %@  AND userId == %d AND custmerId == %d " ,animalTag,userId,custmerId)
        }
        else {
            requestDel.predicate = NSPredicate(format: "(animalTag LIKE[c] %@ AND farmId LIKE[c] %@) AND userId == %d AND custmerId == %d" ,animalTag,farmId,userId,custmerId)
        }
        
    }
    
    //  requestDel.predicate = NSPredicate(format: "farmId == %@ AND userId == %d" ,farmId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAnimaldataValidateAnimalwithouOrderID(entityName: String, animalTag: String,farmId:String,animalbarCodeTag:String,offPermanentId:String,offDamId:String,offsireId:String,orderId:Int,userId:Int,custmerId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
    let pid =   UserDefaults.standard.integer(forKey: "BfProductId")
    
    if  UserDefaults.standard.value(forKey: "name") as? String == "Beef" {
        if pvid == 5  || pvid == 7  { //|| pvid == 13
            requestDel.predicate = NSPredicate(format: "(animalTag LIKE[c] %@ )  AND userId == %d AND custmerId == %d" ,animalTag,userId,custmerId)
            
        }
        else if  pvid == 6{
            requestDel.predicate = NSPredicate(format: "(animalTag LIKE[c] %@ ) AND userId == %d OR productId == %d AND custmerId == %d" ,animalTag,userId,pid,custmerId)
        }
        
    } else {
        if animalTag == "" && farmId  == ""{
            requestDel.predicate = NSPredicate(format: "animalTag LIKE[c] %@ AND farmId LIKE[c] %@ AND userId == %d AND custmerId == %d" ,animalTag,farmId,userId,custmerId)
        }
        else if animalTag == ""{
            requestDel.predicate = NSPredicate(format: "farmId LIKE[c] %@ AND userId == %d AND custmerId == %d" ,farmId,userId,custmerId)
        }
        else if farmId == "" {
            requestDel.predicate = NSPredicate(format: "animalTag LIKE[c] %@  AND userId == %d AND custmerId == %d " ,animalTag,userId,custmerId)
        }
        else {
            requestDel.predicate = NSPredicate(format: "(animalTag LIKE[c] %@ AND farmId LIKE[c] %@) AND userId == %d AND custmerId == %d" ,animalTag,farmId,userId,custmerId)
        }
        
    }
    
    //  requestDel.predicate = NSPredicate(format: "farmId == %@ AND userId == %d" ,farmId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAllDataOrderStatus(entityName: String,ordestatus: String,orderId:Int,userId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND orderId == %d AND userId == %d", ordestatus,orderId,userId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataOrderStatusOrder(entityName: String,ordestatus: String,orderId:Int,userId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND userId == %d", ordestatus,userId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataOrderStatusDataEntry(entityName: String,ordestatus: String,orderId:Int,userId:Int,listId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND userId == %d AND listId == %d", ordestatus,userId,listId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataOrderStatusIsCdcbProduct(entityName: String,ordestatus: String,orderId:Int,userId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND orderId == %d AND userId == %d AND isCdcbProduct == %d", ordestatus,orderId,userId,false)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func deleteOfflineDataWithListId (_ listID: Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  "DataEntryOfflineDeletedAnimal")
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "listID == %d", listID)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}

func saveDeletedDataListAnimal(entity: String,animalID:Int,listID:Int,customerID:Int64, serverAnimalID:String, speciesID:String) {
  
  let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
  
  content.setValue(animalID, forKey: "animalID")
  content.setValue(listID, forKey: "listID")
  content.setValue(customerID, forKey: "customerID")
  content.setValue(serverAnimalID, forKey: "serverAnimalID")
  content.setValue(speciesID, forKey: "speciesID")
  do {
    try managedObjectContext.save()
    
  } catch {
    
  }
}
///
func fetchAllDataWithAnimalId(entityName: String,orderId:Int,userId:Int,animalId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "animalId == %d AND orderId == %d AND userId == %d", animalId,orderId,userId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}
//

func fetchofflineDeletedAnimals(entityName: String, serverId :String ,speciesID :String)-> NSArray{
  
  let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

  let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)

  fetchRequest.predicate = NSPredicate(format: "serverAnimalID != %@ AND speciesID == %@ ",serverId, speciesID)

  fetchRequest.returnsObjectsAsFaults = false

  do{

      let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]

      if let results = fetchedResult{

          commanArray = results as NSArray

      }

  } catch {

  }

  

  return commanArray

}


func fetchAllCustomerDataSave(entityName: String,customerId:Int64) -> NSArray{
      let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
      fetchRequest.predicate = NSPredicate(format: "customerId ==%d", customerId)
      fetchRequest.returnsObjectsAsFaults = false
       do {
       let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
       if let results = fetchedResult {
           commanArray = results as NSArray
     }
    } catch {
        
    }
        return commanArray
}


func saveCustomerDataCount(customerId: Int64,dataCount: Int64) {
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let content = NSEntityDescription.insertNewObject(forEntityName: "GetDatabaseCount", into: managedObjectContext)
    content.setValue(customerId, forKey: "customerId")
    content.setValue(dataCount, forKey: "dataCount")
    do {
        try managedObjectContext.save()
       
        
    } catch {
      
        
    }}



func updateCustomerDatabase(entity: String,dataCount: Int64,customerId:Int64) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
      let context = appDelegate.persistentContainer.viewContext
      let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
      requestDel.predicate = NSPredicate(format: "customerId == %d", customerId)
      requestDel.returnsObjectsAsFaults = false
       do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if fetchedResult!.count > 0 {
         for i in 0..<fetchedResult!.count {
         let objTable = fetchedResult![i]
          objTable.setValue(dataCount, forKey: "dataCount")
            do {
                try context.save()
                    
        } catch {
              }}
              } }    catch {
                
}}




func deleteRemaningSubmitOrderReview(entityName: String,isSync: String,status:String,orderstatus: String,orderId:Int,userId:Int,aid:Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    // fetchRequest.predicate = NSPredicate(format: "orderstatus == %@", status)
    fetchRequest.predicate = NSPredicate(format: "isSync == %@ AND status == %@ AND orderstatus == %@ AND orderId == %d  AND userId == %d AND animalId == %d", isSync,status,orderstatus,orderId,userId,aid)
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}
func fetchAllDataAnimalData(entityName: String,userId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "userId == %d",userId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: String,userId:Int,orderId:Int,orderStatus:String,listid:Int64,custmerId:Int64,providerId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND listId == %d AND custmerId == %d AND providerId == %d",orderStatus,listid,custmerId,providerId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            //commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataAnimalDatarderIdDateEntry(entityName: String,userId:Int,orderId:Int,orderStatus:String,listid:Int64,custmerId:Int64,providerId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "userId == %d AND orderId == %d AND orderstatus == %@ AND listId == %d AND custmerId == %d AND providerId == %d",userId,orderId,orderStatus,listid,custmerId,providerId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            //commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: String,userId:Int,orderId:Int,orderStatus:String,listid:Int64,custmerId:Int64,providerId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND listId == %d AND custmerId == %d AND providerId == %d",orderStatus,listid,custmerId,providerId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            //commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAllDataAnimalDatarderIdDateEntrycheckfarmIdOffId(entityName: String,userId:Int,orderId:Int,listid:Int64,custmerId:Int64,providerId:Int,farmId: String,animaTag : String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "listId == %d AND custmerId == %d AND providerId == %d AND farmId == %@ AND animalTag == %@",listid,custmerId,providerId,farmId,animaTag)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            //commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataAnimalDatarderIdDateEntrycheckGirlandoEARtag(entityName: String,userId:Int,orderId:Int,listid:Int64,custmerId:Int64,providerId:Int,earTag: String,orderStatus:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "listId == %d AND custmerId == %d AND providerId == %d AND earTag == %@ AND orderstatus == %@",listid,custmerId,providerId,earTag,orderStatus)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "earTag", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            //commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataAnimalDatarderIdDateEntrycheckBeef(entityName: String,userId:Int,orderId:Int,listid:Int64,custmerId:Int64,providerId:Int,earTag: String,orderStatus:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "listId == %d AND custmerId == %d AND providerId == %d AND animalTag == %@ AND orderstatus == %@",listid,custmerId,providerId,earTag,orderStatus)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalTag", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            //commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAllDataAnimalDatarderId(entityName: String,userId:Int,orderId:Int,orderStatus:String,providerId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "userId == %d AND orderId == %d AND orderstatus == %@ AND providerId == %d",userId,orderId,orderStatus,providerId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            //commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}


func fetchAllDataAnimalDatarderIdNil(entityName: String,userId:Int,orderId:Int,orderStatus:String,farmid:String,animalTag:String,pvid :Int,dob: String = "") -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  if pvid == 2{
    fetchRequest.predicate = NSPredicate(format: "userId == %d AND orderId == %d AND orderstatus == %@ AND (animalTag == %@ OR date == %@)",userId,orderId,orderStatus,animalTag,"")
  } else {
    fetchRequest.predicate = NSPredicate(format: "userId == %d AND orderId == %d AND orderstatus == %@ AND (animalTag == %@ OR farmId == %@ OR date == %@)",userId,orderId,orderStatus,animalTag,farmid,dob)
  }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            //commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataGirlandoAnimalDatarderIdNil(entityName: String,userId:Int,orderId:Int,orderStatus:String,animalTag:String,pvid :Int,dob: String = "", animalName: String = "") -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)

    fetchRequest.predicate = NSPredicate(format: "userId == %d AND orderId == %d AND orderstatus == %@ AND (earTag == %@ OR date == %@ OR animalName == %@)",userId,orderId,orderStatus,animalTag,"","")
  
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            //commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAllDataAnimalGirlando(entityName: String,userId:Int,orderId:Int,orderStatus:String,animalName:String,breedRegNumber:String,dateString :String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "userId == %d AND orderId == %d AND orderstatus == %@ AND (animalName == %@ OR date == %@)",userId,orderId,orderStatus,animalName,dateString)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            //commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataAnimalDataAnimalId(entityName: String,userId:Int,orderId:Int,orderStatus:String,animalId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "userId == %d AND orderId == %d AND orderstatus == %@ AND animalId == %d",userId,orderId,orderStatus,animalId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            //commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}



func beefFetchAllDataAnimalDatarderId(entityName: String,userId:Int,orderId:Int,orderStatus:String,pvid :Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "userId == %d AND orderId == %d AND orderstatus == %@ AND providerId == %d" ,userId,orderId,orderStatus,pvid)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            //commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataOrderStatusIsSync(entityName: String,isSync: String,ordestatus: String,status: String,orderId:Int,userId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "isSync == %@ AND orderstatus == %@ AND status == %@ AND orderId == %d AND userId == %d", isSync,ordestatus,status,orderId,userId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataFarmIdStatusCheckdata(entityName: String,asending:Bool ,status: String,orderStatus:String,orderId:Int,userId:Int,aTag: String,pId: Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    
    fetchRequest.predicate = NSPredicate(format: "status == %@ AND orderstatus == %@ AND orderId == %d AND userId == %d AND animalTag == %@ AND productId == %d", status,orderStatus,orderId,userId,aTag,pId)
    
    
    
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataFarmIdStatusCheckdataBR(entityName: String,asending:Bool ,status: String,orderStatus:String,orderId:Int,userId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    
    fetchRequest.predicate = NSPredicate(format: "status == %@ AND orderstatus == %@ AND orderId == %d AND userId == %d", status,orderStatus,orderId,userId)
    
    
    
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    
    return commanArray
}


func fetchAllDataFarmIdStatusCheckdataDairy(entityName: String,asending:Bool ,status: String,orderStatus:String,orderId:Int,userId:Int,aTag: Int,pId: Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    
    fetchRequest.predicate = NSPredicate(format: "status == %@ AND orderstatus == %@ AND orderId == %d AND userId == %d AND animalId == %d AND productId == %d", status,orderStatus,orderId,userId,aTag,pId)
    
    
    
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    
    return commanArray
}

//
func fetchAllDataOrderStatusUpdate(entityName: String,ordestatus: String,status: String,orderId:Int,userId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND orderId == %d AND userId == %d", ordestatus,orderId,userId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func updateStatusAnimal(entityName: String,ordestatus: String,status: String,orderId:Int,userId:Int){
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entityName)
    requestDel.predicate = NSPredicate(format: "orderstatus == %@ AND orderId == %d AND userId == %d", ordestatus,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(status, forKey: "status")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
    
}


//
func fetchAllDataOrderStatusIsSyncOfflineAnimal(entityName: String,isSync: String,orderId:Int,userId:Int,status: String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "isSync == %@ AND orderId == %d AND userId == %d AND status == %@", isSync,orderId,userId,status)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataOrderStatusIsSyncOfflineAnimalordrId(entityName: String,orderId:Int,userId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "orderId == %d AND userId == %d",orderId,userId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataOrderStatusIsSyncOffline(entityName: String,isSync: String,orderId:Int,userId:Int,status: String, animalTag:String, animalID: Int? = nil) -> NSArray {
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    if animalID != nil {
        fetchRequest.predicate = NSPredicate(format: "isSync == %@ AND orderId == %d AND userId == %d AND status == %@ AND animalId == %d", isSync, orderId, userId, status, animalID!)
    } else {
        fetchRequest.predicate = NSPredicate(format: "isSync == %@ AND orderId == %d AND userId == %d AND status == %@", isSync,orderId,userId,status)
    }
    
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAllDataOrderStatusIsSyncOfflineProductBeef(entityName: String,orderId:Int,userId:Int,status:String,animalId:Int) -> NSArray {
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    //    if animalID != nil {
    //        fetchRequest.predicate = NSPredicate(format: "orderId == %d AND userId == %d", orderId, userId)
    //    } else {
    fetchRequest.predicate = NSPredicate(format: "orderId == %d AND userId == %d AND animalId == %d AND status == %@",orderId,userId,animalId,status)
    //  }
    
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataOrderStatusIsSyncOffLine(entityName: String,isSync: String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "isSync == %@ ", isSync)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataFarmId(entityName: String,asending:Bool,orderId:Int,userId:Int,farmId :String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    if farmId == ""{
        fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND orderId == %d AND userId == %d", "false",orderId,userId)
    }
    else{
        fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND orderId == %d AND userId == %d AND (farmId contains[cd] %@ OR animalTag contains[cd] %@ OR animalbarCodeTag contains[cd] %@ OR productName contains[cd] %@)", "false",orderId,userId,farmId,farmId,farmId,farmId)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataFarmIdisCdcbProduct(entityName: String,asending:Bool,orderId:Int,userId:Int,farmId :String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    if farmId == ""{
        fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND orderId == %d AND userId == %d AND isCdcbProduct == %d", "false",orderId,userId,false)
    }
    else{
        fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND orderId == %d AND userId == %d AND (farmId contains[cd] %@ OR animalTag contains[cd] %@ OR animalbarCodeTag contains[cd] %@ OR productName contains[cd] %@) AND isCdcbProduct == %d", "false",orderId,userId,farmId,farmId,farmId,farmId,false)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAllDataFarmIdStatusisSync(entityName: String,asending:Bool ,status: String,isSync:String,orderstatus:String,orderId:Int,userId:Int, animalID: Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "status == %@ AND isSync == %@ AND orderstatus == %@ AND orderId == %d AND userId == %d AND animalId == %d", status,isSync,orderstatus,orderId,userId, animalID)
    
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAllDataFarmIdStatusisSyncTerms(entityName: String,asending:Bool ,status: String,isSync:String,orderstatus:String,orderId:Int,userId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "status == %@ AND isSync == %@ AND orderstatus == %@ AND orderId == %d AND userId == %d", status,isSync,orderstatus,orderId,userId)
    
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func updateProductTablDataFromServer(entity: String,status:String,isSync:String,orderstatus:String,deviceOrderId: String,productStatus: String,orderStatusserver:String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "status == %@ AND isSync == %@ AND orderstatus == %@", status,isSync,orderstatus)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                objTable.setValue(deviceOrderId, forKey: "serverOrderId")
                objTable.setValue(productStatus, forKey: "serverStatus")
                objTable.setValue(orderStatusserver, forKey: "orderStatusServer")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func fetchAllDataFarmIdStatusCheck(entityName: String,asending:Bool ,status: String,orderStatus:String,orderId:Int,userId:Int,farmId :String) -> NSArray{
  let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  fetchRequest.returnsObjectsAsFaults = false
  
  fetchRequest.predicate = NSPredicate(format: "status == %@ AND orderstatus == %@ AND orderId == %d AND userId == %d AND animalTag == %@", status,orderStatus,orderId,userId,farmId)
  
  fetchRequest.returnsObjectsAsFaults = false
  do{
    let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
    if let results = fetchedResult{
      
      commanArray = results as NSArray
      let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: asending)
      let sortedResults = commanArray.sortedArray(using: [descriptor])
      commanArray = sortedResults as NSArray
    }
  } catch {
  }
  
  return commanArray
}


 
func fetchAllDataFarmIdStatus(entityName: String,asending:Bool ,status: String,orderStatus:String,orderId:Int,userId:Int,farmId :String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    if farmId == ""
    { fetchRequest.predicate = NSPredicate(format: "status == %@ AND orderstatus == %@ AND orderId == %d AND userId == %d", status,orderStatus,orderId,userId)
        
    }else{
        //NSPredicate(format: "userId == %d AND (onfarmId contains[cd] %@ OR officialId contains[cd] %@ OR onBarcode contains[cd] %@ OR productName contains[cd] %@ OR serverOrderId contains[cd] %@)",userId,onfarmId,onfarmId,onfarmId,onfarmId,onfarmId)
        fetchRequest.predicate = NSPredicate(format: "status == %@ AND orderstatus == %@ AND orderId == %d AND userId == %d AND (farmId contains[cd] %@ OR animalbarCodeTag contains[cd] %@ OR animalTag contains[cd] %@ OR productName contains[cd] %@)", status,orderStatus,orderId,userId,farmId,farmId,farmId,farmId)
    }
    
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    
    return commanArray
}
//sampletracking dropdown
func fetchAllDatasampleData(entityName: String,asending:Bool,userId:Int,fromDate: NSDate , toDate : NSDate) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    // fetchRequest.predicate = NSPredicate(format: "(orderDate >= %@) AND (orderDate <= %@) ",fromDate,toDate)
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            
            //  let descriptor: NSSortDescriptor = NSSortDescriptor(key: "serverOrderId", ascending: asending)
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "orderId", ascending: asending)
            
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
   
    return commanArray
}
func fetchAllDatasampleDataByOrderID(entityName: String,asending:Bool,userId:Int,orderID: String,fromDate: NSDate,toDate: NSDate) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    if orderID == ""{
        fetchRequest.predicate = NSPredicate(format: "userId == %d AND (orderDate >= %@) AND (orderDate <= %@) ",userId,fromDate,toDate)
    }
    else{
        fetchRequest.predicate = NSPredicate(format: "userId == %d AND (orderDate >= %@) AND (orderDate <= %@) AND (serverOrderId contains[cd] %@ OR sampleCount contains[cd] %@ OR packageRecieved contains[cd] %@)",userId,fromDate,toDate,orderID,orderID,orderID)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            
            //  let descriptor: NSSortDescriptor = NSSortDescriptor(key: "serverOrderId", ascending: asending)
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "serverOrderId", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDatasampleDataByOrderDate(entityName: String,asending:Bool,userId:Int,orderID: String,fromDate: NSDate,toDate: NSDate) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    if orderID == ""{
        fetchRequest.predicate = NSPredicate(format: "userId == %d AND (orderDate >= %@) AND (orderDate <= %@)",userId,fromDate,toDate)
    }
    else{
        fetchRequest.predicate = NSPredicate(format: "userId == %d AND (orderDate >= %@) AND (orderDate <= %@) AND (serverOrderId contains[cd] %@ OR sampleCount contains[cd] %@ OR packageRecieved contains[cd] %@)",userId,fromDate,toDate,orderID,orderID,orderID)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            
            //  let descriptor: NSSortDescriptor = NSSortDescriptor(key: "serverOrderId", ascending: asending)
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "orderDate", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
  
    return commanArray
}
func fetchAllDatasampleDataByDate(entityName: String,asending:Bool,userId:Int, datefrom : NSDate , dateTo : NSDate) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    
    fetchRequest.predicate =  NSPredicate(format: "(orderDate >= %@) AND (orderDate <= %@)",datefrom , dateTo)
    
    
    
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "serverOrderId", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
  
    return commanArray
}

func fetchAllDatasampleDataFROMPRODUCT(entityName: String,userId:Int,orderStatus:String,serverStatus:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "userId == %d AND productStatus == %@ AND serverOrderId == %@",userId,orderStatus,serverStatus)
    
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}

func fetchAllDatasampleDataFROMPRODUCTAll(entityName: String,userId:Int,orderStatus:String,serverStatus:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "userId == %d AND serverOrderId == %@",userId,serverStatus)
    
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}
//textfield
func fetchAllDatasampleDataFROMPRODUCTAllResolvedIssue(entityName: String,userId:Int,customerId:String, fromDate: NSDate, toDate: NSDate) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    
    fetchRequest.predicate = NSPredicate(format: "(orderedDate >= %@) AND (orderedDate <= %@) AND customerId == %@", fromDate,toDate,customerId)
    
    //fetchRequest.predicate = NSPredicate(format: "customerId == %@",customerId)
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "orderedDate", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
            
        }
    } catch {
    }
    
    return commanArray
}

func fetchAllDatasampleDataFROMPRODUCToFFid(entityName: String,userId:Int,orderStatus:String,serverStatus:String,asending:Bool,officialID :String) -> NSArray{
    
    //fetchRequest.predicate = NSPredicate(format: "userId == %d AND serverOrderId == %@",userId,serverStatus)
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    if officialID == ""{
        fetchRequest.predicate = NSPredicate(format: "userId == %d AND productStatus == %@ AND serverOrderId == %@",userId,orderStatus,serverStatus)
    }
    else{
        
        fetchRequest.predicate = NSPredicate(format: "userId == %d AND productStatus == %@ AND serverOrderId == %@ AND (onfarmId contains[cd] %@ OR officialId contains[cd] %@ OR onBarcode contains[cd] %@ OR productName contains[cd] %@)",userId,orderStatus,officialID,officialID,officialID,officialID,officialID)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "officialId", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}
//MARKS:- OfficialId
func fetchAllDatasampleDataFROMPRODUCToFFidResolve(entityName: String,officialId:String,userId:Int,asending:Bool ,customerId:String,fromDate: NSDate,toDate: NSDate) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    if officialId == ""{
        //  fetchRequest.predicate = NSPredicate(format: "customerId == %@",customerId)
        fetchRequest.predicate = NSPredicate(format: "customerId == %@ AND (orderedDate >= %@) AND (orderedDate <= %@)",customerId,fromDate,toDate)
        
    }else{
        
        fetchRequest.predicate = NSPredicate(format: "(onFarmId contains[cd] %@ OR officialTag contains[cd] %@ OR sampleBarcode contains[cd] %@ OR product contains[cd] %@ OR orderId contains[cd] %@) AND customerId ==  %@ AND (orderedDate >= %@) AND (orderedDate <= %@)",officialId,officialId,officialId,officialId,officialId,customerId,fromDate,toDate)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "officialTag", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}

func fetchAllDatasampleDataFROMPRODUCTfarmId(entityName: String,userId:Int,orderStatus:String,serverStatus:String,asending:Bool,farmId :String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    if farmId == ""{
        fetchRequest.predicate = NSPredicate(format: "userId == %d AND productStatus == %@ AND serverOrderId == %@",userId,orderStatus,serverStatus)
    }else{
        //  NSPredicate(format: "onfarmId contains[cd] %@ || officialId contains[cd] %@ || onBarcode contains[cd] %@ || productName contains[cd] %@ || serverOrderId contains[cd] %@", newString,newString,newString,newString,newString)
        
        fetchRequest.predicate = NSPredicate(format: "userId == %d AND productStatus == %@ AND serverOrderId == %@ AND (onfarmId contains[cd] %@ OR officialId contains[cd] %@ OR onBarcode contains[cd] %@ OR productName contains[cd] %@)" ,userId,orderStatus,serverStatus,farmId,farmId,farmId,farmId)
        
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "onfarmId", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}

//MARKS:-FarmID aks
func fetchAllDatasampleDataEarTag(entityName: String,onfarmId:String,userId:Int,asending:Bool,customerId:String,fromDate: NSDate,toDate: NSDate) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    if onfarmId == ""{
        //fetchRequest.predicate = NSPredicate(format: "customerId == %@",customerId)
        fetchRequest.predicate = NSPredicate(format: "customerId == %@ AND (orderedDate >= %@) AND (orderedDate <= %@)",customerId,fromDate,toDate)
        
        // fetchRequest.predicate = NSPredicate(format: "userId == %d",userId)
    }else{
        // (SUBQUERY(subs, $x, $x.numbervalue == %@ or $x.numbervalue == %@).@count > 0)
        fetchRequest.predicate = NSPredicate(format: "(earTag contains[cd] %@ OR onFarmId contains[cd] %@ OR officialTag contains[cd] %@ OR sampleBarcode contains[cd] %@ OR product contains[cd] %@ OR orderId contains[cd] %@) AND customerId ==  %@ AND (orderedDate >= %@) AND (orderedDate <= %@)",onfarmId,onfarmId,onfarmId,onfarmId,onfarmId,onfarmId,customerId,fromDate,toDate)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "earTag", ascending: asending)
            
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}
//MARKS:-FarmID aks
func fetchAllDatasampleDataFROMPRODUCTfarmIdResolve(entityName: String,onfarmId:String,userId:Int,asending:Bool,customerId:String,fromDate: NSDate, toDate: NSDate) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    if onfarmId == ""{
        fetchRequest.predicate = NSPredicate(format: "customerId == %@ AND (orderedDate >= %@) AND (orderedDate <= %@)",customerId,fromDate,toDate)
    } else {
        // (SUBQUERY(subs, $x, $x.numbervalue == %@ or $x.numbervalue == %@).@count > 0)
        fetchRequest.predicate = NSPredicate(format: "(onFarmId contains[cd] %@ OR officialTag contains[cd] %@ OR sampleBarcode contains[cd] %@ OR product contains[cd] %@ OR orderId contains[cd] %@ OR sampleStatus contains[cd] %@) AND customerId == %@ AND (orderedDate >= %@) AND (orderedDate <= %@)",onfarmId,onfarmId,onfarmId,onfarmId,onfarmId,onfarmId,customerId,fromDate,toDate)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "onFarmId", ascending: asending)
            
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDatasampleDataFROMPRODUCTfarmIdResolveDate(entityName: String,onfarmId:String,userId:Int,asending:Bool,customerId:String,fromDate: NSDate, toDate: NSDate) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    if onfarmId == ""{
        fetchRequest.predicate = NSPredicate(format: "customerId == %@ AND (orderedDate >= %@) AND (orderedDate <= %@)",customerId,fromDate,toDate)
    } else {
        // (SUBQUERY(subs, $x, $x.numbervalue == %@ or $x.numbervalue == %@).@count > 0)
        fetchRequest.predicate = NSPredicate(format: "(onFarmId contains[cd] %@ OR officialTag contains[cd] %@ OR sampleBarcode contains[cd] %@ OR product contains[cd] %@ OR orderId contains[cd] %@ OR sampleStatus contains[cd] %@) AND customerId == %@ AND (orderedDate >= %@) AND (orderedDate <= %@)",onfarmId,onfarmId,onfarmId,onfarmId,onfarmId,onfarmId,customerId,fromDate,toDate)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "orderedDate", ascending: asending)
            
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDatasampleDataFROMPRODUCTBarcode(entityName: String,userId:Int,orderStatus:String,serverStatus:String,asending:Bool,barcode :String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    
    if barcode == "" {
        fetchRequest.predicate = NSPredicate(format: "userId == %d AND productStatus == %@ AND serverOrderId == %@",userId,orderStatus,serverStatus)
    }
    else{
        
        //fetchRequest.predicate = NSPredicate(format: "userId == %d AND productStatus == %@ AND serverOrderId == %@ AND onBarcode contains[cd] %@",userId,orderStatus,serverStatus,barcode)
        fetchRequest.predicate = NSPredicate(format: "userId == %d AND productStatus == %@ AND serverOrderId == %@ AND (onfarmId contains[cd] %@ OR officialId contains[cd] %@ OR onBarcode contains[cd] %@ OR productName contains[cd] %@)",userId,orderStatus,serverStatus,barcode,barcode,barcode,barcode)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "onBarcode", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}
//Barcode
func fetchAllDatasampleDataFROMPRODUCTBarcodeResolve(entityName: String,barcodeID:String,userId:Int,asending:Bool,customerId:String,fromDate: NSDate, toDate: NSDate) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    if barcodeID == ""{
        //fetchRequest.predicate = NSPredicate(format: "userId == %d",userId)
        // fetchRequest.predicate = NSPredicate(format: "customerId == %@",customerId)
        fetchRequest.predicate = NSPredicate(format: "customerId == %@ AND (orderedDate >= %@) AND (orderedDate <= %@)",customerId,fromDate,toDate)
        
    }else{
        
        fetchRequest.predicate = NSPredicate(format: "(onFarmId contains[cd] %@ OR officialTag contains[cd] %@ OR sampleBarcode contains[cd] %@ OR product contains[cd] %@ OR orderId contains[cd] %@) AND customerId ==  %@ AND (orderedDate >= %@) AND (orderedDate <= %@)",barcodeID,barcodeID,barcodeID,barcodeID,barcodeID,customerId,fromDate,toDate)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "sampleBarcode", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}
//orderID
func fetchAllDatasampleDataFROMPRODUCTOrderIDResolve(entityName: String,barcodeID:String,userId:Int,asending:Bool,customerId:String,fromDate: NSDate, toDate: NSDate) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    if barcodeID == ""{
        // fetchRequest.predicate = NSPredicate(format: "userId == %d",userId)
        //fetchRequest.predicate = NSPredicate(format: "customerId == %@",customerId)
        fetchRequest.predicate = NSPredicate(format: "customerId == %@ AND (orderedDate >= %@) AND (orderedDate <= %@)",customerId,fromDate,toDate)
        
    }else{
        
        fetchRequest.predicate = NSPredicate(format: "(onFarmId contains[cd] %@ OR officialTag contains[cd] %@ OR sampleBarcode contains[cd] %@ OR product contains[cd] %@ OR orderId contains[cd] %@) AND customerId ==  %@  AND (orderedDate >= %@) AND (orderedDate <= %@)",barcodeID,barcodeID,barcodeID,barcodeID,barcodeID,customerId,fromDate,toDate)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "orderId", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}
func fetchAdonDataFromServer(entityName: String, animalTag: String,productId:Int,userId:Int,orderId:String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "offId == %@ AND productId == %d AND userId == %d AND serverId == %@" ,animalTag ,productId,userId,orderId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAllDatasampleDataSearch(entityName: String,asending:Bool,userId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "userId == %d AND serverOrderId == %@,AND orderDate == %@ AND packageRecieved == %@ AND sampleCount == %@",userId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "orderDate", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAllDataanimalTag(entityName: String,asending:Bool,orderId:Int,userId:Int,animalTag : String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    if animalTag == ""{
        fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND orderId == %d AND userId == %d", "false",orderId,userId)
    }
    else{
        fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND orderId == %d AND userId == %d AND (farmId contains[cd] %@ OR animalTag contains[cd] %@ OR animalbarCodeTag contains[cd] %@ OR productName contains[cd] %@)", "false",orderId,userId,animalTag,animalTag,animalTag,animalTag)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalTag", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAllDataanimalTagIsCdcbProdcut(entityName: String,asending:Bool,orderId:Int,userId:Int,animalTag : String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    if animalTag == ""{
        fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND orderId == %d AND userId == %d AND isCdcbProduct == %d", "false",orderId,userId,false)
    }
    else{
        fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND orderId == %d AND userId == %d AND (farmId contains[cd] %@ OR animalTag contains[cd] %@ OR animalbarCodeTag contains[cd] %@ OR productName contains[cd] %@) AND isCdcbProduct == %d", "false",orderId,userId,animalTag,animalTag,animalTag,animalTag,false)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalTag", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAllDataEarTag(entityName: String,asending:Bool,orderId:Int,userId:Int,animalTag : String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    if animalTag == ""{
        fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND orderId == %d AND userId == %d", "false",orderId,userId)
    }
    else{
        fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND orderId == %d AND userId == %d AND (earTag contains[cd] %@ OR animalbarCodeTag contains[cd] %@ OR productName contains[cd] %@)", "false",orderId,userId,animalTag,animalTag,animalTag)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "earTag", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAllDataanimalTagStatus(entityName: String,asending:Bool,status: String,orderStatus: String,animalTag :String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    if animalTag == ""
    {  fetchRequest.predicate = NSPredicate(format: "status == %@ AND orderstatus == %@", status,orderStatus)
        
    }else{
        fetchRequest.predicate = NSPredicate(format: "status == %@ AND orderstatus == %@ AND (farmId contains[cd] %@ OR animalbarCodeTag contains[cd] %@ OR animalTag contains[cd] %@ OR productName contains[cd] %@)",status,orderStatus,animalTag,animalTag,animalTag,animalTag)
    }
    // fetchRequest.predicate = NSPredicate(format: "status == %@ AND orderstatus == %@", status,orderStatus)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalTag", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAllDataBarcOdeStatus(entityName: String,asending:Bool,status: String,orderStatus:String,barcode :String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    if barcode == ""
    {  fetchRequest.predicate = NSPredicate(format: "status == %@ AND orderstatus == %@", status,orderStatus)
        
    }else{
        
        fetchRequest.predicate = NSPredicate(format: "status == %@ AND orderstatus == %@ AND (farmId contains[cd] %@ OR animalbarCodeTag contains[cd] %@ OR animalTag contains[cd] %@ OR productName contains[cd] %@)", status,orderStatus,barcode,barcode,barcode,barcode)
    }
    // fetchRequest.predicate = NSPredicate(format: "status == %@ AND orderstatus == %@", status,orderStatus)
    fetchRequest.returnsObjectsAsFaults = false
    do
     {
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalbarCodeTag", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAllDataRGDStatus(entityName: String,asending:Bool,status: String,orderStatus:String,barcode :String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    if barcode == ""
    {  fetchRequest.predicate = NSPredicate(format: "status == %@ AND orderstatus == %@", status,orderStatus)
        
    }else{
        
        fetchRequest.predicate = NSPredicate(format: "status == %@ AND orderstatus == %@ AND (rgn contains[cd] %@ OR animalbarCodeTag contains[cd] %@ OR animalTag contains[cd] %@ OR rgd contains[cd] %@ OR productName contains[cd] %@)", status,orderStatus,barcode,barcode,barcode,barcode,barcode)
    }
    // fetchRequest.predicate = NSPredicate(format: "status == %@ AND orderstatus == %@", status,orderStatus)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "rgd", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAllDataRGNStatus(entityName: String,asending:Bool,status: String,orderStatus:String,barcode :String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    if barcode == ""
    {  fetchRequest.predicate = NSPredicate(format: "status == %@ AND orderstatus == %@", status,orderStatus)
        
    }else{
        
        fetchRequest.predicate = NSPredicate(format: "status == %@ AND orderstatus == %@ AND (rgn contains[cd] %@ OR animalbarCodeTag contains[cd] %@ OR animalTag contains[cd] %@ OR rgd contains[cd] %@ OR productName contains[cd] %@)", status,orderStatus,barcode,barcode,barcode,barcode,barcode)
    }
    // fetchRequest.predicate = NSPredicate(format: "status == %@ AND orderstatus == %@", status,orderStatus)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "rgn", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAllDataBarcOde(entityName: String,asending:Bool,orderId:Int,userId:Int,barcode :String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    if barcode == ""{
        fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND orderId == %d AND userId == %d", "false",orderId,userId)
    }
    else{
        fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND orderId == %d AND userId == %d AND (farmId contains[cd] %@ OR animalTag contains[cd] %@ OR animalbarCodeTag contains[cd] %@ OR productName contains[cd] %@)", "false",orderId,userId,barcode,barcode,barcode,barcode)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalbarCodeTag", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAllDataBarcOdeIsCdcbProduct(entityName: String,asending:Bool,orderId:Int,userId:Int,barcode :String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    if barcode == ""{
        fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND orderId == %d AND userId == %d AND isCdcbProduct == %d", "false",orderId,userId,false)
    }
    else{
        fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND orderId == %d AND userId == %d AND (farmId contains[cd] %@ OR animalTag contains[cd] %@ OR animalbarCodeTag contains[cd] %@ OR productName contains[cd] %@) AND isCdcbProduct == %d", "false",orderId,userId,barcode,barcode,barcode,barcode,false)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalbarCodeTag", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAllDataRGD(entityName: String,asending:Bool,orderId:Int,userId:Int,barcode :String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    if barcode == ""{
        fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND orderId == %d AND userId == %d", "false",orderId,userId)
    }
    else{
        fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND orderId == %d AND userId == %d AND (rgd contains[cd] %@ OR rgn contains[cd] %@ OR animalTag contains[cd] %@ OR animalbarCodeTag contains[cd] %@ OR productName contains[cd] %@)", "false",orderId,userId,barcode,barcode,barcode,barcode,barcode)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "rgd", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAllDataRGN(entityName: String,asending:Bool,orderId:Int,userId:Int,barcode :String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    if barcode == ""{
        fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND orderId == %d AND userId == %d", "false",orderId,userId)
    }
    else{
        fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND orderId == %d AND userId == %d AND (rgd contains[cd] %@ OR rgn contains[cd] %@ OR animalTag contains[cd] %@ OR animalbarCodeTag contains[cd] %@ OR productName contains[cd] %@)", "false",orderId,userId,barcode,barcode,barcode,barcode,barcode)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "rgn", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    return commanArray
}



func deleteRecordFromDatabase(entityName: String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let arrUsrObj = try context.fetch(requestDel)
        for object in arrUsrObj as! [NSManagedObject] { // Fetching Object
            context.delete(object) // Deleting Object
        }
    } catch {
       
    }
    // Saving the Delete operation
    do {
        try context.save()
    } catch {
        
    }
}
func deleteDataWithmyPagetrait (customerId:Int64) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  "ResultPageByTrait")
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "customerId == %d",customerId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}

func deleteDataOnmyPagetraitwith (customerId:Int64, farmID:String, officialId: String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  "ResultPageByTrait")
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND onFarmId != %@ AND officalId != %@",customerId, farmID,officialId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}

func deleteDataMyGroupAnimalwith (customerId:Int64, farmID:String, officialId: String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  "ResultGroupsAnimals")
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND onFarmId == %@ AND officalId == %@",customerId, farmID,officialId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}
func deleteDataWithMyHerdResult (customerId:Int64, searchFound: Bool) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  "ResultMyHerdData")
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND searchbyanimal == %d",customerId, searchFound)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}
//****** Delete Data from Particular Attribute  ****////
func deleteDataWithProviderId (_ providerId: Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  "Saveprovider")
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "providerId == %d", providerId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}
func deleteDataForCustomer(_ customerId: Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  "ResultFIlterDataSave")
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "customerId == %d", customerId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}

func deleteAutoAnimalListDataForCustomer(_ customerId: Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  "AutoAnimalList")
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "customerID == %d", customerId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}
//****** Delete Data from Particular Attribute  ****////
func deleteDataWithProduct (_ animalId: Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  "ProductAdonAnimalTbl")
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "animalId == %d", animalId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}
func deleteDataWithProductBeefDelete(_ animalId: Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  "ProductAdonAnimlTbLBeef")
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "animalId == %d", animalId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}
func BeefDeleteDataWithProduct (_ animalId: Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  "ProductAdonAnimlTbLBeef")
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "animalId == %d", animalId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}
func beefDeleteDataWithAnimal (_ animalId: Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  "BeefAnimaladdTbl")
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "animalId == %d", animalId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}
func beefDeleteDataWithAnimalDataEntry(_ animalId: Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  "DataEntryBeefAnimaladdTbl")
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "animalId == %d", animalId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}
func beefDeleteDataWithAnimalDataEntryAnimalId(animalId: Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  "DataEntryBeefAnimaladdTbl")
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "animalId == %d", animalId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}
func deleteAnimalDatafromList (entityName:String = "AnimaladdTbl", _ animalId: Int, listID: Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  entityName)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "animalId == %d && listId == %d", animalId, listID)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}
func deleteDataWithAnimal (_ animalId: Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  "AnimaladdTbl")
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "animalId == %d", animalId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}
func deleteDatafromMyHerdAnimal (_ animalId: String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:"ResultMyHerdData")
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "animalID == %@ AND searchbyanimal == %d", animalId,true)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
          
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}

func deleteDataWithAnimaldataEntry (_ animalId: Int,entityName : String = "DataEntryAnimaladdTbl" ) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  entityName)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "animalId == %d", animalId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}
func fetchOneByOneListElements(animalId: Int,listID: Int, entityName:String)->NSArray {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  entityName)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "animalId == %d AND listId == %d", animalId, listID)
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAllDataAnimalDataBeefSampleTypeanimalId(entityName: String,sampleType1:String,sampleType2: String,sampleType3: String,orderId:Int,animalId: Int) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "tissuName != %@ AND tissuName != %@ AND tissuName != %@ AND orderId == %d AND animalId == %d",sampleType1,sampleType2,sampleType3,orderId,animalId)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func deleteDataWithAnimalSampleType (_ samType: String,orderstatus:String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  "AnimaladdTbl")
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "tissuName == %@ AND orderstatus == %@", samType,orderstatus)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}

func deleteDataWithAnimalSampleTypeforBeef (_ samType: String,orderstatus:String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  "BeefAnimaladdTbl")
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "tissuName == %@ AND orderstatus == %@", samType,orderstatus)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}
func deleteDataWithAnimalBreedIdForBeef (_ breedid: String,orderstatus:String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  "BeefAnimaladdTbl")
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "breedId == %@ AND orderstatus == %@", breedid,orderstatus)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}

func deleteDataWithAnimalBreedId (_ breedid: String,orderstatus:String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  "AnimaladdTbl")
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "breedId == %@ AND orderstatus == %@", breedid,orderstatus)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}

func deleteDataWithSubProduct (_ animalId: Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  "SubProductTbl")
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "animalId == %d", animalId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}
func deleteDataWithSubProductAnimalId(_ animalId: Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  "SubProductTblBeef")
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "animalId == %d", animalId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}
func beefDeleteDataWithSubProduct (_ animalId: Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  "SubProductTblBeef")
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "animalId == %d", animalId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}
func deleteDataProduct (entityName: String,status: String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "orderstatus == %@", status)
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}
func deleteDataFarmidOfficaialId(entityName: String,status: String,farmId:String,officalId:String,userId:Int,orderId:Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "userId == %d AND orderId == %d AND orderstatus == %@ AND (farmId == %@ OR animalTag == %@)",userId,orderId, status,farmId,officalId)
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}
func deleteDataFarmidAnimalid(entityName: String,status: String,animalId:Int,userId:Int,orderId:Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "userId == %d AND orderId == %d AND orderstatus == %@ AND animalId == %d",userId,orderId,status,animalId)
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}

func fetchAllDataProductBeef(entityName: String, productId: Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "productId == %d", productId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAllDataProductBeefBreedSociety(entityName: String, productId: Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "productID == %d", productId)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "sequenceId", ascending: true)]
    fetchRequest.returnsObjectsAsFaults = false
    
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataProductBeefBreedSocietyNAME(entityName: String, productId: Int,association:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "productID == %d AND association == %@", productId,association)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "sequenceId", ascending: true)]
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataProductBeefBreedSocietyIDD(entityName: String, productId: Int,association:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "productID == %d AND associationId == %@", productId,association)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "sequenceId", ascending: true)]
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllCountryDataWithMarketId(entityName: String,alpha2:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "marketId == %@",alpha2)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAllCountryDataWithMarketIdandCountryname(entityName: String,alpha2:String,countryName:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  fetchRequest.predicate = NSPredicate(format: "marketId == %@ AND countryName == %@",alpha2, countryName)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}



func fetchAllDetailWithMarketSpeciesId(entityName: String,marketId:String,species:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "marketsID == %@" ,marketId)
        //AND species ==%@",marketId,species)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDetailWithMarketSpeciesIdnEW(entityName: String,marketId:String,providerId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "marketsId == %@ AND providerId == %d" ,marketId,providerId)
        //AND species ==%@",marketId,species)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDetailWithMarketSpeciesIdTrue(entityName: String,marketId:String,species:String,isDefault :Bool) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "marketsID == %@ AND species == %@ AND isDefault == %@",marketId,species, NSNumber(value: isDefault))
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}


func fetchAllOrderSetting(entityName: String, customerId: Int,userId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND userId == %d", customerId,userId)
    fetchRequest.returnsObjectsAsFaults = false
    do {
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchAusNaabBullAgaintName(entityName: String, sireNationalId: String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "sireNationalId == %@ || bullID == %@", sireNationalId,sireNationalId)
    fetchRequest.returnsObjectsAsFaults = false
    
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}


func fetchAllDataProductBeefId(entityName: String,breedName:String,productId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "threeCharCode == %@ AND productId == %d", breedName,productId)
    fetchRequest.returnsObjectsAsFaults = false
    
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAllDataProductBeefIdNz(entityName: String,breedName:String,pvid:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "threeCharCode == %@ AND providerId == %d", breedName,pvid)
    fetchRequest.returnsObjectsAsFaults = false
    
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataProductGirlandoBreedID(entityName: String,breedId:String,pvid:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "breedId == %@ AND providerId == %d", breedId,pvid)
    fetchRequest.returnsObjectsAsFaults = false
    
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAllDataProductBeefIdDairy(entityName: String,breedName:String,pvid:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "alpha2 == %@ AND providerId == %d", breedName,pvid)
    fetchRequest.returnsObjectsAsFaults = false
    
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataProductBreedIdDairy(entityName: String,breedId:String,pvid:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "breedId == %@ AND providerId == %d", breedId,pvid)
    fetchRequest.returnsObjectsAsFaults = false
    
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

//****** Delete Data from Particular Attribute  ****////
func deleteDataWithProductBeef (entityName: String, productId: Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  entityName)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "productId == %d", productId)
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}

func fetchBreedDataWithSpeciesId( entityName: String,speciesId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "speciesId == %d",speciesId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
//////
func deleteRemaningSubmitOrder(entityName: String,isSync: String,status:String,orderstatus: String,orderId:Int,userId:Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    // fetchRequest.predicate = NSPredicate(format: "orderstatus == %@", status)
    fetchRequest.predicate = NSPredicate(format: "isSync == %@ AND status == %@ AND orderstatus == %@ AND orderId == %d  AND userId == %d", isSync,status,orderstatus,orderId,userId)
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}

func fetchRemaningSubmitOrder(entityName: String,isSync: String,status:String,orderstatus: String,orderId:Int,userId:Int) -> NSArray {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    // fetchRequest.predicate = NSPredicate(format: "orderstatus == %@", status)
    fetchRequest.predicate = NSPredicate(format: "isSync == %@ AND status == %@ AND orderstatus == %@ AND orderId == %d  AND userId == %d", isSync,status,orderstatus,orderId,userId)
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            
        }
    } catch {
    }
    return commanArray
}
func fetchBeefSetValueDobCheck(entityName: String,orderId:Int,userId:Int,customerId:Int,date:String) -> NSArray {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "orderId == %d  AND userId == %d AND custmerId == %d AND orderstatus == %@ AND date == %@", orderId,userId,customerId,"false",date)
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            
        }
    } catch {
    }
    return commanArray
}

///** **** Fetch data from particular  Attribute ******//

func fetchdataFromMarketId(marketId: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "GetMarketsTbl")
    requestDel.predicate = NSPredicate(format: "marketId == %@",marketId)
    //requestDel.sortDescriptors = [NSSortDescriptor(key: "species", ascending: true)]
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchdataOfProvider(specisId: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "GetProviderTbl")
    requestDel.predicate = NSPredicate(format: "speciesId == %@",specisId)
    requestDel.sortDescriptors = [NSSortDescriptor(key: "species", ascending: true)]
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchdataOfProviderWith(marketId: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "GetProviderTbl")
    requestDel.predicate = NSPredicate(format: "marketsId == %@",marketId)
    // requestDel.sortDescriptors = [NSSortDescriptor(key: "species", ascending: true)]
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

////
func fetchproductData(status: String,orderStatus: String,orderId:Int,userId: Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductAdonAnimalTbl")
    requestDel.predicate = NSPredicate(format: "status == %@ AND orderstatus == %@ AND orderId == %d AND userId == %d",status,orderStatus,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
//            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "ProductId", ascending: false)
//            let sortedResults = commanArray.sortedArray(using: [descriptor])
//            commanArray = sortedResults as NSArray
            
        }
    } catch {
    }
    return commanArray
}

func BeefFetchproductData(status: String,orderStatus: String,orderId:Int,userId: Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductAdonAnimlTbLBeef")
    requestDel.predicate = NSPredicate(format: "status == %@ AND orderstatus == %@ AND orderId == %d AND userId == %d",status,orderStatus,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
           // let descriptor: NSSortDescriptor = NSSortDescriptor(key: "ProductId", ascending: false)
            //let sortedResults = commanArray.sortedArray(using: [descriptor])
            //commanArray = sortedResults as NSArray
            
        }
    } catch {
    }
    return commanArray
}
func fetchproductDataProductAnimal(animal: String,orderStatus: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductAdonAnimalTbl")
    requestDel.predicate = NSPredicate(format: "animalTag == %@ AND orderstatus == %@",animal,orderStatus)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchproductDataAnimal(orderStatus: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductAdonAnimalTbl")
    requestDel.predicate = NSPredicate(format: "orderstatus == %@",orderStatus)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchproductDataPvid(status: String,orderStatus: String,pvid: Int,orderId:Int,userId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductAdonAnimalTbl")
    requestDel.predicate = NSPredicate(format: "status == %@ AND orderstatus == %@ AND providerId == %d AND orderId == %d AND userId == %d",status,orderStatus,pvid,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchAnimaldata(status: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "AnimaladdTbl")
    requestDel.predicate = NSPredicate(format: "status == %@",status)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchproviderData(provId: Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "Saveprovider")
    requestDel.predicate = NSPredicate(format: "providerId == %d",provId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchproviderData( entityName
    : String,provId: Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "providerId == %d",provId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            
        }
    } catch {
    }
    return commanArray
}


func fetchproviderDataISDefault( entityName
    : String,provId: Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "providerID == %d",provId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            
        }
    } catch {
    }
    return commanArray
}










func fetchproviderDataChekValidation( entityName
    : String,
                                      provId: Int,sampleID:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "providerId == %d AND sampleId == %d",provId,sampleID)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "sampleName", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    return commanArray
}
///

func fetchBreedDataWithProvideId( entityName: String,provId: Int,breedId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "providerId == %d AND breedId == %d",provId,breedId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}






//



func fetchBreedData( entityName: String,provId: Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "providerId == %d",provId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "breedName", ascending: true)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchproviderProductData( entityName: String,provId: Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "providerId == %d",provId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchBreedProvideDataUnique( entityName: String,provId: Int,breedId:String, productId:Int? = nil) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    if let productID = productId {
        requestDel.predicate = NSPredicate(format: "providerId == %d AND breedId == %@ AND productId == %d", provId, breedId, productID)
    } else {
        requestDel.predicate = NSPredicate(format: "providerId == %d AND breedId == %@",provId, breedId)
    }
    
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchproviderProductDataGlobal( entityName: String,provId: Int,productId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "providerId == %d AND productId == %d  ",provId,productId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func autoIncrementidtable(){
    var auto = fetchFromAutoIncrement()
    auto += 1
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: "OrderId", into: managedObjectContext)
    content.setValue(auto, forKey: "autoId")
    
    do {
        try managedObjectContext.save()
       
    } catch {
        
    }
    
    
}
func fetchFromAutoIncrementOrderId() -> NSArray
    
{
    //var auto: NSManagedObject?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "OrderId")
    requestDel.returnsObjectsAsFaults = false
    var auto: Int?
    do
    {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        let results = fetchedResult
        commanArray = results as! NSArray
        
        
    }
    catch
    {
    }
    
    return commanArray
    
}

func fetchFromAutoIncrement() -> Int {
  //var auto: NSManagedObject?
  let appDelegate = UIApplication.shared.delegate as! AppDelegate
  let context = appDelegate.persistentContainer.viewContext
  let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "OrderId")
  requestDel.returnsObjectsAsFaults = false
  var auto: Int?
  do
  {
    let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
    
    auto = fetchedResult?.count == 0 ? 0 : 0
    if let results = fetchedResult
    {
      if results.count > 0{
        let ob = results.last as! OrderId
        auto = Int(ob.autoId)
      }
    }
    else
    {
      
      
    }
    
    
  }
  catch
  {
  }
  
  return auto!
  
}

func fetchproviderProductDataBreedId( entityName : String,provId: Int,breedId:String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "providerId == %d AND breedId == %@",provId,breedId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchproviderProductDataBreedIdIScdcbProduct( entityName : String,provId: Int,breedId:String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "providerId == %d AND breedId == %@ AND isCdcbProduct == %d",provId,breedId,false)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchproviderProductDataBeef( entityName : String,provId: Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "providerId == %d",provId)
    requestDel.sortDescriptors = [NSSortDescriptor(key: "productId", ascending: true)]
    requestDel.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchproviderProductDataBeefststus( entityName: String,
                                         provId: Int,ststus: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "providerId == %d AND status ==%@",provId,ststus)
    requestDel.sortDescriptors = [NSSortDescriptor(key: "productName", ascending: true)]
    requestDel.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}


func fetchSubProductData(productId: Int,animalTag: String,orderId:Int,userId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "SubProductTbl")
    requestDel.predicate = NSPredicate(format: "productId == %d AND animalTag == %@ AND orderId == %d AND userId == %d",productId,animalTag,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchSubProductDataDairy(productId: Int,animalTag: Int,orderId:Int,userId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "SubProductTbl")
    requestDel.predicate = NSPredicate(format: "productId == %d AND animalId == %d AND orderId == %d AND userId == %d",productId,animalTag,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "adonId", ascending: true)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
            
            
            
            
            //  commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchSubProductDataDairyreview(productId: Int,animalTag: Int,orderId:Int,userId:Int,status: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "SubProductTbl")
    requestDel.predicate = NSPredicate(format: "productId == %d AND animalId == %d AND orderId == %d AND userId == %d AND status == %@",productId,animalTag,orderId,userId,status)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "adonId", ascending: true)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
            
            
            
            
            //  commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchSubProductDataBeef(entityName: String,productId: Int,animalTag: String,orderId:Int,userId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "productId == %d AND animalTag == %@ AND orderId == %d AND userId == %d",productId,animalTag,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [ProductAdonAnimlTbLBeef]
        
        if let results = fetchedResult{
            commanArray = results as NSArray
//            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "adonId", ascending: true)
//            let sortedResults = commanArray.sortedArray(using: [descriptor])
//            commanArray = sortedResults as NSArray
            //commanArray = results as NSArray
            var animalId = Int()
            if fetchedResult!.count > 1 {
                    for x in fetchedResult! {
                        if x.animalId == animalId {
                            print("already exist")
                            context.delete(x)
                            let fetchedResult = try context.fetch(requestDel) as? [ProductAdonAnimlTbLBeef]
                            if let results = fetchedResult{
                                commanArray = results as NSArray
                            }
                        } else {
                            animalId = Int(x.animalId)
                            let fetchedResult = try context.fetch(requestDel) as? [ProductAdonAnimlTbLBeef]
                            if let results = fetchedResult{
                                commanArray = results as NSArray
                            }
                        }
                    }
                }
            
        }
    } catch {
    }
    return commanArray
}

func deleteDuplicateProductIds(entityName: String,asending:Bool ,status: String,orderStatus:String,orderId:Int,userId:Int,farmId :String){
  let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  fetchRequest.returnsObjectsAsFaults = false
  
  fetchRequest.predicate = NSPredicate(format: "status == %@ AND orderstatus == %@ AND orderId == %d AND userId == %d AND animalTag == %@", status,orderStatus,orderId,userId,farmId)
  
  fetchRequest.returnsObjectsAsFaults = false
  do{
    let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [ProductAdonAnimlTbLBeef]
    if let results = fetchedResult{
      
      commanArray = results as NSArray
      let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: asending)
      let sortedResults = commanArray.sortedArray(using: [descriptor])
      commanArray = sortedResults as NSArray
        
        var productIdArray = [Int]()
        var productId = Int()
        for product in fetchedResult! {
            if product.productId == productId {
                managedObjectContext.delete(product)
            } else {
                productId = Int(product.productId)
                productIdArray.append(Int(product.productId))
//                for id in productIdArray {
//                    if id == product.productId {
//                        managedObjectContext.delete(product)
//                    } else {
//                        
//                    }
//                }
            }
            print(productIdArray)
        }
    }
  } catch {
  }
  
}


func fetchSubProductDataTrue(productId: Int,animalTag: String,status: String,orderId:Int,userId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "SubProductTbl")
    requestDel.predicate = NSPredicate(format: "productId == %d AND animalTag == %@  AND status == %@ AND orderId == %d AND userId == %d",productId,animalTag,status,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchSubProductDataTrueBeef(entityName: String,productId: Int,animalTag: String,status: String,orderId:Int,userId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "productId == %d AND animalTag == %@  AND status == %@ AND orderId == %d AND userId == %d",productId,animalTag,status,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchSubProductDataTrueClarifedvalidationfarmId(entityName: String,productId: String,status: String,userId:Int,farmId: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "productName == %@  AND onFarmId == %@", productId,farmId)
    
    // requestDel.predicate = NSPredicate(format: "productId == %d AND animalTag == %d  AND status == %@ AND orderId == %d AND userId == %d",productId,animalTag,status,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchSubProductDataTrueClarifedvalidationfarmIdAU(entityName: String,productId: String,productId1: String,productId2: String,status: String,userId:Int,farmId: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    requestDel.predicate = NSPredicate(format: "(productName == %@  OR productName == %@ OR productName == %@) AND onFarmId == %@", productId,productId1,productId2,farmId)
    
    // requestDel.predicate = NSPredicate(format: "productId == %d AND animalTag == %d  AND status == %@ AND orderId == %d AND userId == %d",productId,animalTag,status,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchSubProductDataTrueClarifedvalidationanimalTagUk(entityName: String,productId: String,productId1: String,productId2: String,status: String,userId:Int,farmId: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    requestDel.predicate = NSPredicate(format: "(productName == %@  OR productName == %@ OR productName == %@) AND userId == %d AND clarifidestatusUk == %@ AND animalTag == %@", productId,productId1,productId2,userId,status,farmId)
    
    // requestDel.predicate = NSPredicate(format: "productId == %d AND animalTag == %d  AND status == %@ AND orderId == %d AND userId == %d",productId,animalTag,status,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchSubProductDataTrueClarifedvalidationfarmIdUk(entityName: String,productId: String,productId1: String,productId2: String,status: String,userId:Int,farmId: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    requestDel.predicate = NSPredicate(format: "(productName == %@  OR productName == %@ OR productName == %@) AND onFarmId == %@", productId,productId1,productId2,farmId)
    
    // requestDel.predicate = NSPredicate(format: "productId == %d AND animalTag == %d  AND status == %@ AND orderId == %d AND userId == %d",productId,animalTag,status,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchSubProductDataTrueClarifedvalidationOffIdAU(entityName: String,productId: String,productId1: String,productId2: String,status: String,userId:Int,animalTag: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    requestDel.predicate = NSPredicate(format: "(productName == %@  OR productName == %@ OR productName == %@) AND userId == %d AND clarifidestatusAu == %@ AND animalTag == %@", productId,productId1,productId2,userId,status,animalTag)
    
    // requestDel.predicate = NSPredicate(format: "productId == %d AND animalTag == %d  AND status == %@ AND orderId == %d AND userId == %d",productId,animalTag,status,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchSubProductDataTrueClarifedvalidationoffid(entityName: String,productId: String,status: String,userId:Int,animaltag: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "productName == %@  AND userId == %d AND clarifidestatus == %@ AND animalTag == %@", productId,userId,status,animaltag)
    
    // requestDel.predicate = NSPredicate(format: "productId == %d AND animalTag == %d  AND status == %@ AND orderId == %d AND userId == %d",productId,animalTag,status,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchSubProductDataTrueSelectedISYNC(isSync: String,status: String,orderstatus: String,orderId:Int,userId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "SubProductTbl")
    
    requestDel.predicate = NSPredicate(format: "isSync == %@  AND status == %@  AND orderstatus == %@ AND orderId == %d AND userId == %d",isSync,status,orderstatus,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchSubProductDataTrueSelectedISYNCAdons(isSync: String,status: String,orderstatus: String,orderId:Int,userId:Int, productId: Int, animalID: Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "SubProductTbl")
    
    requestDel.predicate = NSPredicate(format: "isSync == %@  AND status == %@  AND orderstatus == %@ AND orderId == %d AND userId == %d AND productId == %d AND animalId == %d",isSync,status,orderstatus,orderId,userId, productId, animalID)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchSubProductDataTrueSelectedISYNCAdonsBeef(isSync: String,status: String,orderstatus: String,orderId:Int,userId:Int, productId: Int, animalID: Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "SubProductTblBeef")
    
    requestDel.predicate = NSPredicate(format: "isSync == %@  AND status == %@  AND orderstatus == %@ AND orderId == %d AND userId == %d AND productId == %d AND animalId == %d",isSync,status,orderstatus,orderId,userId, productId, animalID)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchSubProductDataTrueSelectedISYNCAdonsBeefOfflineAdon(orderId:Int,userId:Int, productId: Int, animalID: Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "SubProductTblBeef")
    
    requestDel.predicate = NSPredicate(format: "orderId == %d AND userId == %d AND productId == %d AND animalId == %d",orderId,userId, productId, animalID)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchSubProductDataTrueSelected(orderStatus: String,status: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "SubProductTbl")
    requestDel.predicate = NSPredicate(format: "orderstatus == %@  AND status == %@",orderStatus,status)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchSubProductDataStatus(productId: Int,animalTag: String ,status: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "SubProductTbl")
    requestDel.predicate = NSPredicate(format: "productId == %d AND animalTag == %@  AND status == %@",productId,animalTag,status)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchSubProductDataStatusUpdate(productId: Int,animalTag: String ,status: String,orderId: Int ,userId: Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "SubProductTbl")
    requestDel.predicate = NSPredicate(format: "adonId == %d AND animalTag == %@  AND status == %@ AND orderId == %d AND userId == %d",productId,animalTag,status,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchSubProductDataStatusUpdateDairy(productId: Int,animalTag: Int ,status: String,orderId: Int ,userId: Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "SubProductTbl")
    requestDel.predicate = NSPredicate(format: "adonId == %d AND animalId == %d  AND status == %@ AND orderId == %d AND userId == %d",productId,animalTag,status,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchSubProductDataStatusUpdateDairychkpValidation(productId: String ,animalId :Int, status: String,orderId: Int ,userId: Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "SubProductTbl")
    requestDel.predicate = NSPredicate(format: "adonName == %@  AND animalId == %d  AND status == %@ AND orderId == %d AND userId == %d",productId,animalId,status,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchSubProductDataStatusUpdateBeef(entityName:String, productId: Int,animalTag: String ,status: String,orderId: Int ,userId: Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "adonId == %d AND animalTag == %@  AND status == %@ AND orderId == %d AND userId == %d",productId,animalTag,status,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchAnimaldata(entityName: String, animalTag: String,orderId:Int,userId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "animalTag == %@ AND orderId == %d AND userId == %d",animalTag,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchbreedname(entityName: String, breedid : String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "breedId == %@", breedid)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAnimaldataDairy(entityName: String, animalTag: Int,orderId:Int,userId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "animalId == %d AND orderId == %d AND userId == %d",animalTag,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAnimaldataDairyOrderIdUserId(entityName: String,orderId:Int,userId:Int,providerId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "orderId == %d AND userId == %d AND providerId == %d",orderId,userId,providerId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}


func fetchAnimaldataSampleType(entityName: String, sampleType: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "tissuName != %@",sampleType)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}


func fetchAnimaldatabreeIdType(entityName: String, breedId: Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "breedId == %d",breedId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
//    requestDel.predicate = NSPredicate(format: "userId == %d AND listId == %d AND earTag == %@ AND custmerId == %d",userId,listId,earTag,custmerId)
func fetchAnimaldataValidateAnimalTagDataEntry(entityName: String, animalTag: String,listId: Int, custmerId: Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "animalTag == %@ AND listId == %d AND custmerId == %d",animalTag,listId,custmerId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func checkAnimaldataValidateAnimalTagDataEntry(entityName: String, animalTag: String,listId: Int, custmerId: Int, providerID: Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "animalTag == %@ AND listId == %d AND custmerId == %d AND providerId == %d",animalTag,listId,custmerId, providerID)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchAnimaldataValidateAnimalTag(entityName: String, animalTag: String,orderId: Int, userId: Int,animalId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "animalId == %d AND orderId == %d AND userId == %d",animalId,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchAnimaldataValidateAnimalTagWithBarcode(entityName: String, animalTag: String,orderId: Int, userId: Int,animalId:Int, barCode: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "animalId == %d AND orderId == %d AND userId == %d AND animalbarCodeTag == %d",animalId,orderId,userId,barCode)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchAnimaldataValidateAnimalTagWithoutOrderId(entityName: String, animalTag: String, sireId: String , animalBarCode: String , orderId: Int, custmerId: Int,animalId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
   if pvid == 6 {
    requestDel.predicate = NSPredicate(format: "animalId == %d AND offsireId == %@ AND animalTag == %@ AND custmerId == %d",animalId,sireId,animalBarCode,custmerId)
  } else {
    requestDel.predicate = NSPredicate(format: "(animalId == %d OR animalTag == %@)  AND offsireId == %@ AND animalbarCodeTag == %@ AND custmerId == %d",animalId,animalTag,sireId,animalBarCode,custmerId)
  }
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
//////
func fetchAnimaldataValidateListAndCustomerId(entityName: String, animalTag: String,farmId:String, userId: Int,listId:Int,customerId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "listId == %d AND userId == %d AND custmerId == %d AND (farmId LIKE[c] %@ OR animalTag LIKE[c] %@)",listId,userId,customerId,farmId,animalTag)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAnimaldataValidateListAndCustomerIdaUTOPOP(entityName: String, userId: Int,listId:Int,customerId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "listId == %d AND userId == %d AND custmerId == %d ",listId,userId,customerId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAnimaldataValidatePermanentId(entityName: String,offPermanentId:String,orderId: Int, userId: Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "offPermanentId == %@ AND orderId == %d AND userId == %d" ,offPermanentId,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}








func fetchAnimaldataValidateSireId(entityName: String,offsireId:String,orderId: Int, userId: Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "offsireId == %@ AND orderId == %d AND userId == %d" ,offsireId,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}








func fetchAnimaldataValidateDamId(entityName: String,offDamId:String,orderId: Int, userId: Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "offDamId == %@ AND orderId == %d AND userId == %d" ,offDamId,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}







func fetchAnimaldataValidateAnimalBarcode(entityName: String,animalbarCodeTag:String,orderId: Int, userId: Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "animalbarCodeTag == %@ AND orderId == %d AND userId == %d" ,animalbarCodeTag,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAnimaldataValidateAnimalBarcodeanimalId(entityName: String,animalbarCodeTag:String, userId: Int,animalId : Int,orderSatatus: String,custId:Int,IsDataEmail:Bool = false) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "animalbarCodeTag == %@  AND userId == %d AND orderstatus == %@ AND custmerId == %d" ,animalbarCodeTag,userId,orderSatatus,custId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAnimaldataValidateAnimalBarcodeanimalIdearTag(entityName: String, animalbarCodeTag: String , sireId: String = "" , animalBarCode: String = "", userId: Int,animalId : Int,orderStatus: String,IsDataEmail:Bool = false) -> NSArray{
 
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  if sireId == "" {
    requestDel.predicate = NSPredicate(format: "animalTag == %@  AND userId == %d AND orderstatus == %@ AND isDataEmailed == %d" ,animalbarCodeTag,userId,orderStatus,IsDataEmail)
  } else {
    requestDel.predicate = NSPredicate(format: "animalTag == %@  AND offsireId == %@ AND animalbarCodeTag == %@ AND userId == %d AND orderstatus == %@ AND isDataEmailed == %d" ,animalbarCodeTag,animalBarCode,sireId,userId,orderStatus,IsDataEmail)
  }
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAnimaldataAnimalBarcodeandAnimalIdAndEarTag(entityName: String, animalTag: String , sireId: String, animalBarCode: String, userId: Int,orderStatus: String,listID: Int, providerId:Int) -> NSArray{
 
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  
    requestDel.predicate = NSPredicate(format: "animalTag == %@ AND offsireId == %@ AND animalbarCodeTag == %@ AND userId == %d AND orderstatus == %@ AND listId == %d AND providerId == %d" ,animalTag,sireId,animalBarCode,userId,orderStatus,listID,providerId)
  
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func checkAnimaldataAnimalBarcodeandAnimalIdAndEarTag(entityName: String, animalTag: String , sireId: String, animalBarCode: String, userId: Int,orderStatus: String, providerId:Int) -> NSArray{
 
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  
    requestDel.predicate = NSPredicate(format: "animalTag == %@ AND offsireId == %@ AND animalbarCodeTag == %@ AND userId == %d AND orderstatus == %@ AND providerId == %d" ,animalTag,sireId,animalBarCode,userId,orderStatus,providerId)
  
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAnimaldataValidateAnimalRGDmaster(entityName: String,RGD:String, userId: Int,animalId : Int,orderSatatus: String,IsDataEmail:Bool = false) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "offDamId == %@ AND userId == %d AND orderstatus == %@ AND isDataEmailed == %d",RGD,userId,orderSatatus,IsDataEmail)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAnimaldataValidateAnimalBarcodeanimalIdOrderId(entityName: String,animalbarCodeTag:String, userId: Int,animalId : Int,orderSatatus: String,orderid:Int,custId:Int,IsDataEmail:Bool = false) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "animalbarCodeTag == %@  AND userId == %d AND orderstatus == %@ AND orderId == %d AND custmerId == %d " ,animalbarCodeTag,userId,orderSatatus,orderid,custId)
    //requestDel.predicate = NSPredicate(format: "animalbarCodeTag == %@  AND userId == %d AND orderstatus == %@ AND orderId == %d AND custmerId == %d  AND isDataEmailed == %@" ,animalbarCodeTag,userId,orderSatatus,orderid,custId,NSNumber(value: IsDataEmail))
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAnimaldataBarcodeanimalId(entityName: String,animalbarCodeTag:String,animalId : Int,orderStatus: String,custId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "animalbarCodeTag == %@ AND orderstatus == %@ AND animalId == %d AND custmerId == %d " ,animalbarCodeTag,orderStatus,animalId,custId)
    //requestDel.predicate = NSPredicate(format: "animalbarCodeTag == %@  AND userId == %d AND orderstatus == %@ AND orderId == %d AND custmerId == %d  AND isDataEmailed == %@" ,animalbarCodeTag,userId,orderSatatus,orderid,custId,NSNumber(value: IsDataEmail))
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAnimaldataCheckAnimalBarcodeExist(entityName: String,animalbarCodeTag:String, userId: Int,custId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "animalbarCodeTag == %@ AND userId == %d AND custmerId == %d " ,animalbarCodeTag,userId,custId)
    //requestDel.predicate = NSPredicate(format: "animalbarCodeTag == %@  AND userId == %d AND orderstatus == %@ AND orderId == %d AND custmerId == %d  AND isDataEmailed == %@" ,animalbarCodeTag,userId,orderSatatus,orderid,custId,NSNumber(value: IsDataEmail))
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchAnimaldataValidateRGD(entityName: String,rgd:String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "offDamId == %@" ,rgd)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAnimaldataValidateAnimalBarcodeanimalIdOrderIdEarTag(entityName: String,animalbarCodeTag:String, userId: Int,animalId : Int,orderSatatus: String,orderid:Int,IsDataEmail:Bool = false) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "animalTag == %@  AND userId == %d AND orderstatus == %@ AND orderId == %d " ,animalbarCodeTag,userId,orderSatatus,orderid)
   // requestDel.predicate = NSPredicate(format: "animalTag == %@  AND userId == %d AND orderstatus == %@ AND orderId == %d AND isDataEmailed == %@" ,animalbarCodeTag,userId,orderSatatus,orderid,NSNumber(value: IsDataEmail))
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAnimaldataValidateAnimalRGD(entityName: String,RGD:String, userId: Int,animalId : Int,orderSatatus: String,orderid:Int,IsDataEmail:Bool = false) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "offDamId == %@  AND userId == %d AND orderstatus == %@ AND orderId == %d  " ,RGD,userId,orderSatatus,orderid)
   // requestDel.predicate = NSPredicate(format: "offDamId == %@  AND userId == %d AND orderstatus == %@ AND orderId == %d  AND isDataEmailed == %@" ,RGD,userId,orderSatatus,orderid,NSNumber(value: IsDataEmail))
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAnimaBarcodeValidateWithoutOrderId(entityName: String,animalbarCodeTag:String,orderSatatus: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "animalTag == %@  AND orderstatus == %@" ,animalbarCodeTag,orderSatatus)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAnimaBarcodeValidateWithoutOrderIdRGD(entityName: String,RGD:String,orderSatatus: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "offDamId == %@  AND orderstatus == %@ " ,RGD,orderSatatus)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
//fetchRequest.predicate = NSPredicate(format: "farmId LIKE[c] %@  AND custmerId == %d", animalId,custmerId)

func fetchAnimaldataValidateFamIDListId(entityName: String,farmId:String,custmerId: Int, userId: Int,animalId:Int64,listId:Int64) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "farmId LIKE[c] %@ AND custmerId == %d AND userId == %d AND animalId != %d AND listId == %d" ,farmId,custmerId,userId,animalId,listId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAnimaldataValidateFamID(entityName: String,farmId:String,custmerId: Int, userId: Int,animalId:Int64) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "farmId LIKE[c] %@ AND custmerId == %d AND userId == %d AND animalId != %d" ,farmId,custmerId,userId,animalId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAnimaldataValidateAnimalBarcodetag(entityName: String,animalbarCodeTag:String,orderId: Int, userId: Int, custmerId: Int) -> NSArray{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "animalTag LIKE[c] %@ AND orderId == %d AND userId == %d AND custmerId == %d " ,animalbarCodeTag,orderId,userId,custmerId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchAnimaldataValidateFamIDGetListId(entityName: String,farmId:String,custmerId: Int, userId: Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "farmId LIKE[c] %@ AND custmerId == %d AND userId == %d" ,farmId,custmerId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

//
//func fetchProductAdonDataDairy(entityName : String,prodId: Int,isIncludedInProduct:Bool) -> NSArray{
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    let context = appDelegate.persistentContainer.viewContext
//    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//
//    requestDel.predicate = NSPredicate(format: "productId == %d AND isIncludedInProduct == %d",prodId,isIncludedInProduct)
//    requestDel.returnsObjectsAsFaults = false
//    do{
//        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
//        if let results = fetchedResult{
//            commanArray = results as NSArray
//        }
//    } catch {
//    }
//    return commanArray
//}


//////

func fetchProductAdonData(entityName : String,prodId: Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    requestDel.predicate = NSPredicate(format: "productId == %d",prodId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}





func fetchProductAdonDataWithBVDV(entityName : String,prodId: Int,adonId: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    requestDel.predicate = NSPredicate(format: "productId == %d AND adonName == %@",prodId,adonId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchProductAdonDataStatus(entityName : String,prodId: Int,status: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    requestDel.predicate = NSPredicate(format: "productId == %d AND status == %@",prodId,status)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}


func fetchProductAdonDatawithAonId( entityName : String,addonId: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    requestDel.predicate = NSPredicate(format: "addonId == %@",addonId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchProductAdonDatawithAonIdInt( entityName : String,addonId: Int,animalTag: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    requestDel.predicate = NSPredicate(format: "adonId == %d",addonId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}



///////////

func fetchNaabIdToAnimalId( entityName : String,naabCode: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    requestDel.predicate = NSPredicate(format: "naabCode == %@",naabCode)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func saveSelectedQuestionaire( entityName : String, primaryBreed: String, primaryBreedId: String) //secondaryBreed: String, secondaryBreedId: String,
//tersioryBreed: String, tersioryBreedId: String
{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: entityName, into: managedObjectContext)
    
    if !primaryBreed.isEmpty {
        content.setValue(primaryBreed, forKey: "primaryBreed")
        content.setValue(primaryBreedId, forKey: "primaryBreedId")
    }
    
//    if !secondaryBreed.isEmpty {
//        content.setValue(secondaryBreed, forKey: "secondaryBreed")
//        content.setValue(secondaryBreedId, forKey: "secondaryBreedId")
//    }
//
//
//    if !tersioryBreed.isEmpty {
//        content.setValue(tersioryBreed, forKey: "tersioryBreed")
//        content.setValue(tersioryBreedId, forKey: "tersioryBreedId")
//    }
    
    do {
        try managedObjectContext.save()
      
    } catch {
      
    }
}
func fetchBreedDatabreedCode( entityName: String,provId: Int,breedCode:String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "providerId == %d AND alpha2 == %@",provId,breedCode)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "breedName", ascending: true)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchBreedDatabreedCodeThree( entityName: String,provId: Int,breedCode:String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "providerId == %d AND threeCharCode == %@",provId,breedCode)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "breedName", ascending: true)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchBreedDataTissueCode( entityName: String,provId: Int,tissueName:String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "providerId == %d AND sampleName == %@",provId,tissueName)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "breedName", ascending: true)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAllDataAnimalDataBeefSampleType(entityName: String,sampleType1:String,sampleType2: String,sampleType3: String,orderId:Int,pvid:Int) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "tissuName != %@ AND tissuName != %@ AND tissuName != %@ AND orderId == %d AND providerId == %d AND orderstatus == %@",sampleType1,sampleType2,sampleType3,orderId,pvid,"false")
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAllDataAnimalDataBeefSampleTypeConflict(entityName: String,sampleType1:String,orderId:Int) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "sampTypeConf == %@ AND orderId == %d",sampleType1,orderId)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataAnimalDataBeefSampleTypeBothConflict(entityName: String,sampleType1:String,orderId:Int) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "bothConf == %@ AND orderId == %d",sampleType1,orderId)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataAnimalDataBeefSampleTypeAgeConflict(entityName: String,sampleType1:String,orderId:Int) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "ageConf == %@ AND orderId == %d",sampleType1,orderId)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAllDataAnimalDataBeefSampleTypeAtag(entityName: String,sampleType1:String,sampleType2: String,sampleType3: String,orderId:Int,atAg:String) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "tissuName != %@ AND tissuName != %@ AND tissuName != %@ AND orderId == %d AND orderId == %d AND animalTag == %@",sampleType1,sampleType2,sampleType3,orderId,atAg)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataAnimalDataBeefSampleTypewithAge(entityName: String,sampleType1:String,sampleType2: String,sampleType3: String,age:Int,orderId:Int) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "tissuName != %@ AND tissuName != %@ AND tissuName != %@ AND diffAge <= %d AND orderId == %d",sampleType1,sampleType2,sampleType3,age,orderId)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func saveAnimaldatawithAge (entity: String,animalTag: String,barCodetag: String,date: String,damId: String,sireId: String,gender: String,update: String,permanentId: String,tissuName: String,breedName: String,et: String,farmId: String,orderId: Int,orderSataus:String,breedId: String,isSync:String,providerId:Int,tissuId: Int,sireIDAU:String,nationHerdAU:String,userId:Int,udid: String,animalId:Int,age: Int,productId:Int,samconflict:String,ageConf: String,bothConf: String,custId:Int,listId:Int64,serverAnimalId:String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    
    content.setValue(serverAnimalId, forKey: "serverAnimalId")
    content.setValue(listId, forKey: "listId")
    content.setValue(animalTag, forKey: "animalTag")
    content.setValue(barCodetag, forKey: "animalbarCodeTag")
    content.setValue(date, forKey: "date")
    content.setValue(gender, forKey: "gender")
    content.setValue(permanentId, forKey: "offPermanentId")
    content.setValue(sireId, forKey: "offsireId")
    content.setValue(damId, forKey: "offDamId")
    content.setValue(tissuName, forKey: "tissuName")
    content.setValue(breedName, forKey: "breedName")
    content.setValue(farmId, forKey: "farmId")
    content.setValue(et, forKey: "eT")
    content.setValue(update, forKey: "status")
    content.setValue(orderId, forKey: "orderId")
    content.setValue(orderSataus, forKey: "orderstatus")
    content.setValue(breedId, forKey: "breedId")
    content.setValue(isSync, forKey: "isSync")
    content.setValue(providerId, forKey: "providerId")
    content.setValue(tissuId, forKey: "tissuId")
    content.setValue(sireIDAU, forKey: "sireIDAU")
    content.setValue(nationHerdAU, forKey: "nationHerdAU")
    content.setValue(userId, forKey: "userId")
    content.setValue(udid, forKey: "udid")
    content.setValue(animalId, forKey: "animalId")
    content.setValue(age, forKey: "diffAge")
    content.setValue(productId, forKey: "productId")
    content.setValue(ageConf, forKey: "ageConf")
    content.setValue(bothConf, forKey: "bothConf")
    content.setValue(samconflict, forKey: "sampTypeConf")
    content.setValue(custId, forKey: "custmerId")
    
    
    do {
        try managedObjectContext.save()
      
    } catch {
       
    }
}


func updateOrderStatusISyncAnimalMasterNZ(entity: String,animalTag: String,barCodetag: String,date: String,damId: String,sireId: String,gender: String,update: String,permanentId: String,tissuName: String,breedName: String,et: String,farmId: String,orderId: Int,orderSataus:String,breedId: String,isSync:String,providerId:Int,tissuId: Int,sireIDAU:String,nationHerdAU:String,userId:Int,udid: String,animalId:Int,diffDate:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "userId == %d AND orderId == %d  AND animalId == %d", userId,orderId,animalId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(animalTag, forKey: "animalTag")
                objTable.setValue(barCodetag, forKey: "animalbarCodeTag")
                objTable.setValue(date, forKey: "date")
                objTable.setValue(gender, forKey: "gender")
                objTable.setValue(permanentId, forKey: "offPermanentId")
                objTable.setValue(sireId, forKey: "offsireId")
                objTable.setValue(damId, forKey: "offDamId")
                objTable.setValue(tissuName, forKey: "tissuName")
                objTable.setValue(breedName, forKey: "breedName")
                objTable.setValue(farmId, forKey: "farmId")
                objTable.setValue(et, forKey: "eT")
                // objTable.setValue(update, forKey: "status")
                //objTable.setValue(orderId, forKey: "orderId")
                // objTable.setValue(orderSataus, forKey: "orderstatus")
                objTable.setValue(breedId, forKey: "breedId")
                objTable.setValue(isSync, forKey: "isSync")
                objTable.setValue(providerId, forKey: "providerId")
                objTable.setValue(tissuId, forKey: "tissuId")
                objTable.setValue(sireIDAU, forKey: "sireIDAU")
                objTable.setValue(nationHerdAU, forKey: "nationHerdAU")
                objTable.setValue(userId, forKey: "userId")
                objTable.setValue(udid, forKey: "udid")
                objTable.setValue(animalId, forKey: "animalId")
                objTable.setValue(diffDate, forKey: "diffAge")
                objTable.setValue("", forKey: "bothConf")
                
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateOrderStatusISyncAnimalMasterNZBoth(entity: String,animalTag: String,barCodetag: String,date: String,damId: String,sireId: String,gender: String,update: String,permanentId: String,tissuName: String,breedName: String,et: String,farmId: String,orderId: Int,orderSataus:String,breedId: Int,isSync:String,providerId:Int,tissuId: Int,sireIDAU:String,nationHerdAU:String,userId:Int,udid: String,animalId:Int,diffDate:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "userId == %d AND orderId == %d  AND animalId == %d", userId,orderId,animalId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(animalTag, forKey: "animalTag")
                objTable.setValue(barCodetag, forKey: "animalbarCodeTag")
                objTable.setValue(date, forKey: "date")
                objTable.setValue(gender, forKey: "gender")
                objTable.setValue(permanentId, forKey: "offPermanentId")
                objTable.setValue(sireId, forKey: "offsireId")
                objTable.setValue(damId, forKey: "offDamId")
                objTable.setValue(tissuName, forKey: "tissuName")
                objTable.setValue(breedName, forKey: "breedName")
                objTable.setValue(farmId, forKey: "farmId")
                objTable.setValue(et, forKey: "eT")
                // objTable.setValue(update, forKey: "status")
                //objTable.setValue(orderId, forKey: "orderId")
                // objTable.setValue(orderSataus, forKey: "orderstatus")
                objTable.setValue(breedId, forKey: "breedId")
                objTable.setValue(isSync, forKey: "isSync")
                objTable.setValue(providerId, forKey: "providerId")
                objTable.setValue(tissuId, forKey: "tissuId")
                objTable.setValue(sireIDAU, forKey: "sireIDAU")
                objTable.setValue(nationHerdAU, forKey: "nationHerdAU")
                objTable.setValue(userId, forKey: "userId")
                objTable.setValue(udid, forKey: "udid")
                objTable.setValue(animalId, forKey: "animalId")
                objTable.setValue(diffDate, forKey: "diffAge")
                objTable.setValue("", forKey: "bothConf")
                objTable.setValue("", forKey: "ageConf")
                objTable.setValue("", forKey: "sampTypeConf")
                
                
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func updateOrderStatusISyncAnimalMasterNZAge(entity: String,animalTag: String,barCodetag: String,date: String,damId: String,sireId: String,gender: String,update: String,permanentId: String,tissuName: String,breedName: String,et: String,farmId: String,orderId: Int,orderSataus:String,breedId: Int,isSync:String,providerId:Int,tissuId: Int,sireIDAU:String,nationHerdAU:String,userId:Int,udid: String,animalId:Int,diffDate:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "userId == %d AND orderId == %d  AND animalId == %d", userId,orderId,animalId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(animalTag, forKey: "animalTag")
                objTable.setValue(barCodetag, forKey: "animalbarCodeTag")
                objTable.setValue(date, forKey: "date")
                objTable.setValue(gender, forKey: "gender")
                objTable.setValue(permanentId, forKey: "offPermanentId")
                objTable.setValue(sireId, forKey: "offsireId")
                objTable.setValue(damId, forKey: "offDamId")
                objTable.setValue(tissuName, forKey: "tissuName")
                objTable.setValue(breedName, forKey: "breedName")
                objTable.setValue(farmId, forKey: "farmId")
                objTable.setValue(et, forKey: "eT")
                // objTable.setValue(update, forKey: "status")
                //objTable.setValue(orderId, forKey: "orderId")
                // objTable.setValue(orderSataus, forKey: "orderstatus")
                objTable.setValue(breedId, forKey: "breedId")
                objTable.setValue(isSync, forKey: "isSync")
                objTable.setValue(providerId, forKey: "providerId")
                objTable.setValue(tissuId, forKey: "tissuId")
                objTable.setValue(sireIDAU, forKey: "sireIDAU")
                objTable.setValue(nationHerdAU, forKey: "nationHerdAU")
                objTable.setValue(userId, forKey: "userId")
                objTable.setValue(udid, forKey: "udid")
                objTable.setValue(animalId, forKey: "animalId")
                objTable.setValue(diffDate, forKey: "diffAge")
                objTable.setValue("", forKey: "ageConf")
                
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateOrderStatusISyncAnimalMasterSaample(entity: String,animalTag: String,barCodetag: String,date: String,damId: String,sireId: String,gender: String,update: String,permanentId: String,tissuName: String,breedName: String,et: String,farmId: String,orderId: Int,orderSataus:String,breedId: Int,isSync:String,providerId:Int,tissuId: Int,sireIDAU:String,nationHerdAU:String,userId:Int,udid: String,animalId:Int,diffDate:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "userId == %d AND orderId == %d  AND animalId == %d", userId,orderId,animalId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(animalTag, forKey: "animalTag")
                objTable.setValue(barCodetag, forKey: "animalbarCodeTag")
                objTable.setValue(date, forKey: "date")
                objTable.setValue(gender, forKey: "gender")
                objTable.setValue(permanentId, forKey: "offPermanentId")
                objTable.setValue(sireId, forKey: "offsireId")
                objTable.setValue(damId, forKey: "offDamId")
                objTable.setValue(tissuName, forKey: "tissuName")
                objTable.setValue(breedName, forKey: "breedName")
                objTable.setValue(farmId, forKey: "farmId")
                objTable.setValue(et, forKey: "eT")
                // objTable.setValue(update, forKey: "status")
                //objTable.setValue(orderId, forKey: "orderId")
                // objTable.setValue(orderSataus, forKey: "orderstatus")
                objTable.setValue(breedId, forKey: "breedId")
                objTable.setValue(isSync, forKey: "isSync")
                objTable.setValue(providerId, forKey: "providerId")
                objTable.setValue(tissuId, forKey: "tissuId")
                objTable.setValue(sireIDAU, forKey: "sireIDAU")
                objTable.setValue(nationHerdAU, forKey: "nationHerdAU")
                objTable.setValue(userId, forKey: "userId")
                objTable.setValue(udid, forKey: "udid")
                objTable.setValue(animalId, forKey: "animalId")
                objTable.setValue(diffDate, forKey: "diffAge")
                objTable.setValue("", forKey: "sampTypeConf")
                
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}


func deleteDataWithAnimalSampleTypeBeef (entityName: String,animalId:String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "animalTag == %@", animalId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}

func fetchSubProductDataTrueSelectedISYNCBeef(isSync: String,status: String,orderstatus: String,orderId:Int,userId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "SubProductTblBeef")
    
    requestDel.predicate = NSPredicate(format: "isSync == %@  AND status == %@  AND orderstatus == %@ AND orderId == %d AND userId == %d",isSync,status,orderstatus,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}



func fetchProductAdonDataStatusBeef(entityName : String,adonId: Int,adonId1:Int,adonId3:Int,status: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    requestDel.predicate = NSPredicate(format: "(adonId == %d or adonId == %d or adonId == %d) AND status == %@",adonId,adonId1,adonId3,status)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchProductAdonDataBVDV(entityName : String,adonId: String,status: String = "",ordrId:Int, productId:Int = 0) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
  if status == "" {
    requestDel.predicate = NSPredicate(format: "adonName == %@ AND orderId == %d AND productId == %d",adonId,ordrId, productId)
  } else if status == "" && productId == 0 {
    requestDel.predicate = NSPredicate(format: "adonName == %@ AND status == %@ AND orderId == %d",adonId,status,ordrId)
  }
  else {
    requestDel.predicate = NSPredicate(format: "adonName == %@ AND status == %@ AND orderId == %d AND productId == %d",adonId,status,ordrId, productId)
  }
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchProductAdonDataStatusBVDV(entityName : String,adonId: String,status: String,ordrId:Int, customerID:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    requestDel.predicate = NSPredicate(format: "adonName == %@ AND status == %@ AND orderId == %d AND custmerId == %d",adonId,status,ordrId,customerID)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchProductAdonDataStatusDairy(entityName : String,adonId: Int,status: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    requestDel.predicate = NSPredicate(format: "adonId == %d  AND status == %@",adonId,status)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchAllDataAnimalDataBeefSampleTypeWithAnimalId(entityName: String,sampleType1:String,sampleType2: String,sampleType3: String,atAg : String) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "tissuName == %@ OR tissuName == %@  OR tissuName == %@ AND animalTag == %@",sampleType1,sampleType2,sampleType3,atAg)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAnimalDataBeefSampleTypeWithAnimalId(entityName: String,sampleType1:String,sampleType2: String,sampleType3: String) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "tissuName != %@ AND tissuName != %@  AND tissuName != %@",sampleType1,sampleType2,sampleType3)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAllDataAnimalDataBeefSampleTypeWithAnimalIdDairy(entityName: String,sampleType1:String,sampleType2: String,sampleType3: String,atAg : Int) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "tissuName == %@ OR tissuName == %@  OR tissuName == %@ AND animalId == %d",sampleType1,sampleType2,sampleType3,atAg)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAllDataAnimalDataSampleTypeWithAnimalId(entityName: String,sampleType1:String,sampleType2: String,sampleType3: String,atAg : Int,pvid: Int) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  fetchRequest.predicate = NSPredicate(format: "tissuName != %@ AND tissuName != %@  AND tissuName != %@ AND providerId == %d AND orderstatus == %@",sampleType1,sampleType2,sampleType3,pvid,"false")
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchOrdersWithFilter(entityName: String, ascending: Bool = true, sortingKey: String = "", searchText: String = "", fromDate: NSDate, toDate: NSDate,customerId:String) -> NSArray {
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    
    if entityName == "GetActionRequired" {
        if !searchText.isEmpty {
            
            fetchRequest.predicate = NSPredicate(format: "(orderedDate >= %@) AND (orderedDate <= %@) AND (orderId contains[c] %@ OR onFarmId contains[c] %@ OR officialTag contains[c] %@ OR sampleBarcode contains[c] %@ OR earTag contains[c] %@ OR offcialPermanenetId contains[c] %@ OR sampleStatus contains[c] %@) AND customerId == %@", fromDate, toDate, searchText, searchText, searchText, searchText, searchText, searchText, searchText,searchText,customerId)
        } else {
            fetchRequest.predicate = NSPredicate(format: "(orderedDate >= %@) AND (orderedDate <= %@) AND customerId == %@", fromDate,toDate,customerId)
        }
        
    } else {
        if !searchText.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "(orderedDate >= %@) AND (orderedDate <= %@) AND (orderId contains[c] %@ OR onFarmId contains[c] %@ OR officialTag contains[c] %@ OR sampleBarcode contains[c] %@ OR productName contains[c] %@ OR earTag contains[c] %@ OR species contains[c] %@ OR officialId contains[c] %@ OR status contains[c] %@ OR sampleStatus contains[c] %@) AND customerId == %@", fromDate, toDate, searchText, searchText, searchText, searchText, searchText, searchText, searchText, searchText, searchText,searchText,customerId)
        } else {
            fetchRequest.predicate = NSPredicate(format: "(orderedDate >= %@) AND (orderedDate <= %@) AND customerId == %@", fromDate,toDate,customerId)
        }
        
    }
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            
            if !sortingKey.isEmpty {
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: sortingKey, ascending: ascending)
                let sortedResults = commanArray.sortedArray(using: [descriptor])
                commanArray = sortedResults as NSArray
            }
        }
        
    } catch {
    }
    
    return commanArray
}

func fetchSamplesWithFilter(entityName: String, sampleStatus: String, sampleStatusId: Int, ascending: Bool, sortingKey: String = "", searchText: String = "", orderId: String) -> NSArray {
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    
    
    if sampleStatus != "All" {
        if !searchText.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "orderId == %@ AND sampleStatusId == %d AND (onFarmId contains[c] %@ OR officialId contains[c] %@ OR sampleBarcode contains[c] %@ OR productName contains[c] %@ OR earTag contains[c] %@ OR sampleStatus contains[c] %@)", orderId, sampleStatusId, searchText, searchText, searchText, searchText, searchText ,searchText)
        } else {
            fetchRequest.predicate = NSPredicate(format: "orderId == %@ AND sampleStatusId ==%d", orderId, sampleStatusId)
        }
    } else {
        if !searchText.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "orderId == %@ AND (onFarmId contains[c] %@ OR officialId contains[c] %@ OR sampleBarcode contains[c] %@ OR productName contains[c] %@ OR earTag contains[c] %@ OR sampleStatus contains[c] %@)",orderId , searchText, searchText, searchText, searchText, searchText ,searchText)
        } else {
            fetchRequest.predicate = NSPredicate(format: "orderId == %@", orderId)
        }
    }
    
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            
            if !sortingKey.isEmpty {
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: sortingKey, ascending: ascending)
                let sortedResults = commanArray.sortedArray(using: [descriptor])
                commanArray = sortedResults as NSArray
            }
        }
        
    } catch {
    }
    
    return commanArray
}


func fetchDataEntryReviewDefault(entityName: String,asending:Bool,userId:Int,farmId :String,customerId:Int,flag:Int,listId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    if farmId == ""{
        fetchRequest.predicate = NSPredicate(format: "orderstatus == %@  AND userId == %d AND custmerId == %d AND listId == %d", "false",userId,customerId,listId)
    }
    else {
            
            fetchRequest.predicate = NSPredicate(format: "orderstatus == %@  AND userId == %d AND (farmId contains[cd] %@ OR animalTag contains[cd] %@ OR animalbarCodeTag contains[cd] %@ OR earTag contains[cd] %@) AND custmerId == %d AND listId == %d", "false",userId,farmId,farmId,farmId,farmId,customerId,listId)

    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            if flag == 1 {
          
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: asending)
                let sortedResults = commanArray.sortedArray(using: [descriptor])
                commanArray = sortedResults as NSArray

            } else if flag == 2 {
          
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalTag", ascending: asending)
                let sortedResults = commanArray.sortedArray(using: [descriptor])
                commanArray = sortedResults as NSArray

            } else if flag == 3 {
         
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalbarCodeTag", ascending: asending)
                let sortedResults = commanArray.sortedArray(using: [descriptor])
                commanArray = sortedResults as NSArray

            
            } else if flag == 4 {
                
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "earTag", ascending: asending)
                let sortedResults = commanArray.sortedArray(using: [descriptor])
                commanArray = sortedResults as NSArray

            
            }
           
        }
    } catch {
    }
    
    return commanArray
}
func fetchSampleDetailData(entityName: String, sampleId: Int, orderId: String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    fetchRequest.predicate = NSPredicate(format: "sampleId ==%d AND orderId == %@", sampleId, orderId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func updateProducDataSingleanimalId(entity: String,productID:Int,status: String,animalId: Int,orderId:Int,userId: Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "productId == %d AND animalId == %d AND orderId ==%d AND userId ==%d", productID,animalId,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(status, forKey: "status")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func updateAdonDataSingleanimalId(entity: String,pid:Int,adonId:Int,status: String,animalId:Int,ordeId:Int,userId:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "productId == %d AND adonId == %d AND animalId == %d AND orderId == %d AND userId == %d", pid,adonId,animalId,ordeId,userId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(status, forKey: "status")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func fetchAllAdonSingleadon (entityName: String,status: String,productId: Int,ordrId:Int,userId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "status == %@ AND productId ==  %d AND orderId == %d AND userId == %d" , status,productId,ordrId,userId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}


func updateProductTablDataaid(entity: String,status: String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                objTable.setValue(status, forKey: "status")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}


func updateProductTablaid(entity: String,productId: Int,status: String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    requestDel.predicate = NSPredicate(format: "productId == %d", productId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                objTable.setValue(status, forKey: "status")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
    
}


func fetchCurrentActiveCustomer(entityName: String, customerId: Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d", customerId)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchCustomerOrderSetting(entityName: String, customerId: Int, userId: Int) -> NSArray {
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND userId == %d", customerId, userId)
    //fetchRequest.predicate = NSPredicate(format: "customerId == %d", customerId)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchCustomerOrderSettingProvider(entityName: String, customerId: Int, userId: Int, pvid: Int) -> NSArray {
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND userId == %d AND pvid == %d", customerId, userId,pvid)
    //fetchRequest.predicate = NSPredicate(format: "customerId == %d", customerId)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func deleteCustomerOrderSetting(entityName: String, customerId: Int, userId: Int?) {
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND userId == %d", customerId,userId!)
    fetchRequest.returnsObjectsAsFaults = false
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}

func deleteCustomerOrderSettingforProvider(entityName: String, customerId: Int, userId: Int?, pvid: Int?) {
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND userId == %d AND pvid == %d", customerId,userId!)
    fetchRequest.returnsObjectsAsFaults = false
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}


func updateCustomerOrderSetting(entityName: String, customerId: Int, userId: String? = "",emailId:String) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    //fetchRequest.predicate = NSPredicate(format: "customerId == %d AND userId == %@", customerId, userId)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND emailId == %@", customerId,emailId)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchEvaluationMarkets(entityName: String, marketId: String, speciesId: String) -> NSArray {
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    fetchRequest.predicate = NSPredicate(format: "marketsID == %@ AND speciesId == %@", marketId, speciesId)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchEvaluationProvider(entityName: String, providerId: Int) -> NSArray {
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    fetchRequest.predicate = NSPredicate(format: "providerId == %d", providerId)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}


func updateProducDataBr(entity: String,status: String,orderId:Int,userId:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "orderId == %d AND userId == %d",orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(status, forKey: "status")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
    
    
}

func fetchUser(entityName: String, email: String) -> NSArray {
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    fetchRequest.predicate = NSPredicate(format: "email == %@", email)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "userId", ascending: true)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAllUser(entityName: String) -> NSArray {
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    // fetchRequest.predicate = NSPredicate(format: "email == %@", email)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "userId", ascending: true)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    
    return commanArray
}
///




func deleteDataWithUserId(entity: String, userId: Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "userId == %d", userId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}

func fetchDataWithUserId(entityName: String, userId: Int) -> NSArray {
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    fetchRequest.predicate = NSPredicate(format: "userId == %d", userId)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "userId", ascending: true)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    
    return commanArray
}

// Date Entry
func fetchDataEnteryAnimalTbl(entityName: String,customerId:Int,listId:Int64) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest  =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND listId == %d", customerId,listId)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: true)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray

        }
    } catch {
    }
    
    return commanArray
}

func fetchDataEntryDropDownOnFarmId(entityName: String,onfarmId:String,userId:Int,asending:Bool,customerId:Int,listId:Int64) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    if onfarmId == ""{
        fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND listId == %d",customerId,listId)
    } else {
        fetchRequest.predicate = NSPredicate(format: "(farmId contains[cd] %@ OR animalTag contains[cd] %@ OR animalbarCodeTag contains[cd] %@ OR orderId contains[cd] %@ OR sampleStatus contains[cd] %@) AND custmerId == %d AND listId == %d ",onfarmId,onfarmId,onfarmId,onfarmId,onfarmId,customerId,listId)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}
func fetchDataEntryDropDownOfficaialId(entityName: String,onfarmId:String,userId:Int,asending:Bool,customerId:Int,listId:Int64) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    if onfarmId == ""{
        fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND listId == %d",customerId,listId)
    } else {
        fetchRequest.predicate = NSPredicate(format: "(farmId contains[cd] %@ OR animalTag contains[cd] %@ OR animalbarCodeTag contains[cd] %@ OR orderId contains[cd] %@)  AND custmerId == %d AND listId == %d",onfarmId,onfarmId,onfarmId,onfarmId,customerId,listId)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalTag", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}
func fetchDataEntryDropDownBarcode(entityName: String,onfarmId:String,userId:Int,asending:Bool,customerId:Int,listId:Int64) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    if onfarmId == ""{
        fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND listId == %d",customerId,listId)
    } else {
        fetchRequest.predicate = NSPredicate(format: "(farmId contains[cd] %@ OR animalTag contains[cd] %@ OR animalbarCodeTag contains[cd] %@) AND custmerId == %d AND listId == %d",onfarmId,onfarmId,onfarmId,customerId,listId)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalbarCodeTag", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}

func fetchDataEntryBarcode(entityName: String,barcodeID:String,userId:Int,asending:Bool,customerId:Int,listId:Int64) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    if barcodeID == ""{
        fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND listId == %d",customerId,listId)
        
    }else{
        
        fetchRequest.predicate = NSPredicate(format: "(farmId contains[cd] %@ OR animalTag contains[cd] %@ OR animalbarCodeTag contains[cd] %@) AND custmerId == %d AND listId == %d",barcodeID,barcodeID,barcodeID,customerId,listId)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalbarCodeTag", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}
func fetchDataEntryBarcodeBrazill(entityName: String,barcodeID:String,userId:Int,asending:Bool,customerId:Int,listId:Int64) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    if barcodeID == ""{
        fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND listId == %d",customerId,listId)
        
    }else{
        
        fetchRequest.predicate = NSPredicate(format: "(farmId contains[cd] %@ OR animalTag contains[cd] %@ OR animalbarCodeTag contains[cd] %@) AND custmerId == %d AND listId == %d",barcodeID,barcodeID,barcodeID,customerId,listId)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalTag", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}
func fetchDataEntryOfficalId(entityName: String,barcodeID:String,userId:Int,asending:Bool,customerId:Int,listId:Int64) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    if barcodeID == ""{
        fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND listId == %d ",customerId,listId)
        
    }else{
        
        fetchRequest.predicate = NSPredicate(format: "(farmId contains[cd] %@ OR animalTag contains[cd] %@ OR animalbarCodeTag contains[cd] %@) AND custmerId ==  %d AND listId == %d ",barcodeID,barcodeID,barcodeID,customerId,listId)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalTag", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}



func fetchDataEntryfarmId(entityName: String,barcodeID:String,userId:Int,asending:Bool,customerId:Int,listId:Int64) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    if barcodeID == ""{
        fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND listId == %d",customerId,listId)
        
    }else{
        
        fetchRequest.predicate = NSPredicate(format: "(farmId contains[cd] %@ OR animalTag contains[cd] %@ OR animalbarCodeTag contains[cd] %@ ) AND custmerId ==  %d AND listId == %d",barcodeID,barcodeID,barcodeID,customerId,listId)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}

func deleteDataWithListId(entityString:String ,listId: Int64,customerId:Int,userId:Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  entityString)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "listId == %d AND customerId == %d ", listId,customerId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}
func deleteDataWithListIdDatEntry(entityString:String ,listId: Int,customerId:Int,userId:Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  entityString)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "listId == %d AND custmerId == %d ", listId,customerId,userId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}

func fetchAllDataAnimalDatarderIdDataEntry(entityName: String,userId:Int,orderId:Int,orderStatus:String,listId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND listId == %d ",orderStatus,listId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            //commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}


func fetchAllDataAnimalDatarderIdGirlando(entityName: String,userId:Int,orderId:Int,orderStatus:String,listId:Int,pvid:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND listId == %d AND providerId == %d",orderStatus,listId,pvid)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "earTag", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            //commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}




func fetchDataEntryDropDownEarTagg(entityName: String,onfarmId:String,userId:Int,asending:Bool,customerId:Int,listId:Int64) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    if onfarmId == ""{
        fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND listId == %d",customerId,listId)
    } else {
        fetchRequest.predicate = NSPredicate(format: "(farmId contains[cd] %@ OR animalTag contains[cd] %@ OR animalbarCodeTag contains[cd] %@) AND custmerId == %d AND listId == %d",onfarmId,onfarmId,onfarmId,customerId,listId)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "earTag", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}








func fetchDataEntryEaarTag(entityName: String,barcodeID:String,userId:Int,asending:Bool,customerId:Int,listId:Int64) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    if barcodeID == ""{
        fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND listId == %d",customerId,listId)
        
    }else{
        
        fetchRequest.predicate = NSPredicate(format: "(farmId contains[cd] %@ OR animalTag contains[cd] %@ OR animalbarCodeTag contains[cd] %@ OR earTag contains[cd] %@) AND custmerId ==  %d AND listId == %d",barcodeID,barcodeID,barcodeID,barcodeID,customerId,listId)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "earTag", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}




func fetchAllDataAnimalGiirlando(entityName: String,earTag:String,custmerId :Int,userID :Int,orderId :Int) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    fetchRequest.predicate = NSPredicate(format: "earTag LIKE[c] %@ AND custmerId == %d AND userId == %d AND orderId == %d ",earTag,custmerId,userID,orderId)
        
    
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataAnimalDaWithOutOrderId(entityName: String,userId:Int,orderStatus:String,listid:Int64,custmerId:Int64,providerId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND listId == %d AND custmerId == %d AND providerId == %d",orderStatus,listid,custmerId,providerId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
          if entityName == "DataEntryBeefAnimaladdTbl" {
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
          } else {
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
          }
           
            //commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataAnimalDaWithOutOrderIdserverAnimalId(entityName: String,userId:Int,orderStatus:String,listid:Int64,custmerId:Int64,providerId:Int,serverAnimalId:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND listId == %d AND custmerId == %d AND providerId == %d AND addeditdelete == %d",orderStatus,listid,custmerId,providerId,1)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            //commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataEditCondition(entityName: String,userId:Int,orderStatus:String,listid:Int64,custmerId:Int64,providerId:Int,serverAnimalId:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND listId == %d AND custmerId == %d AND providerId == %d AND serverAnimalId != %@ AND addeditdelete == %d",orderStatus,listid,custmerId,providerId,serverAnimalId,2)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            //commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAllDataEditConditionWithoutServerId(entityName: String,userId:Int,orderStatus:String,listid:Int64,custmerId:Int64,providerId:Int,serverAnimalId:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND listId == %d AND custmerId == %d AND providerId == %d AND serverAnimalId == %@ AND addeditdelete == %d",orderStatus,listid,custmerId,providerId,serverAnimalId,2)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            //commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}



func fetchAllDataOrderStatusWithoutOrderId(entityName: String,ordestatus: String,orderId:Int,userId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "orderstatus == %@", ordestatus)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    
    return commanArray
}



func updateOrderStatusISyncAnimalMasterDataEntry(entity: String,animalTag: String,barCodetag: String,date: String,damId: String,sireId: String,gender: String,update: String,permanentId: String,tissuName: String,breedName: String,et: String,farmId: String,orderId: Int,orderSataus:String,breedId: String,isSync:String,providerId:Int,tissuId: Int,sireIDAU:String,nationHerdAU:String,userId:Int,udid: String,animalId:Int, selectedBornTypeId: Int? = nil,isSyncServer:Bool,adhDataServer:Bool) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    var custmerId = UserDefaults.standard.value(forKey: "currentActiveCustomerId") as! Int
      requestDel.predicate = NSPredicate(format: "farmId LIKE[c] %@ OR custmerId == %d AND animalId == %d" ,farmId,custmerId,animalId)

    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
              if entity == Entities.dataEntryAnimalAddTbl{
                objTable.setValue(2, forKey: "addeditdelete")
              }
                objTable.setValue(animalTag, forKey: "animalTag")
                objTable.setValue(barCodetag, forKey: "animalbarCodeTag")
                objTable.setValue(date, forKey: "date")
                objTable.setValue(gender, forKey: "gender")
                objTable.setValue(permanentId, forKey: "offPermanentId")
                objTable.setValue(sireId, forKey: "offsireId")
                objTable.setValue(damId, forKey: "offDamId")
                objTable.setValue(tissuName, forKey: "tissuName")
                objTable.setValue(breedName, forKey: "breedName")
                objTable.setValue(farmId, forKey: "farmId")
                objTable.setValue(et, forKey: "eT")
                objTable.setValue(breedId, forKey: "breedId")
                objTable.setValue(isSync, forKey: "isSync")
                objTable.setValue(providerId, forKey: "providerId")
                objTable.setValue(tissuId, forKey: "tissuId")
                objTable.setValue(sireIDAU, forKey: "sireIDAU")
                objTable.setValue(nationHerdAU, forKey: "nationHerdAU")
                objTable.setValue(userId, forKey: "userId")
                objTable.setValue(udid, forKey: "udid")
                objTable.setValue(animalId, forKey: "animalId")
                objTable.setValue(selectedBornTypeId, forKey: "selectedBornTypeId")
                
                objTable.setValue(adhDataServer, forKey: "adhDataServer")
                objTable.setValue(isSyncServer, forKey: "isSyncServer")

                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}



func fetchAnimaldataValidateAnimalTagGirlandoDataEntry(entityName: String, earTag: String,listId: Int, userId: Int,custmerId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "userId == %d AND listId == %d AND earTag == %@ AND custmerId == %d",userId,listId,earTag,custmerId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchAnimalGirlandoWithouOrderid(entityName: String, earTag: String,orderId: Int, userId: Int,animalId:Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "animalId == %d AND orderId == %d AND userId == %d",animalId,orderId,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}


func deleteDataProductDataEntry(entityName: String,status: String,listId:Int,customerId:Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND  listId == %d AND custmerId == %d", status,listId,customerId)
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}






func fetchAllDataEnteryList(entityName: String,customerId:Int64,listName: String,productName:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  if productName == ""{
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND listName LIKE[c] %@",customerId,listName)
  } else {
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND listName LIKE[c] %@ AND productName == %@",customerId,listName,productName)
  }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataWithOrderIDStatucCheck(entityName: String,orderId:Int,userId:Int,status:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "orderId == %d AND userId == %d AND status == %@" ,orderId,userId,status)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAnimalCountAccrodingToOrderWise(entityName: String, listId:Int64,customerId:Int64,orderId:Int,orderstatus:String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "listId == %d AND custmerId == %d AND orderId == %d AND orderstatus == %@",listId,customerId,orderId,orderstatus)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchAnimaldataCheckBarcodeDuplicay(entityName: String,animalbarCodeTag:String, userId: Int) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "animalbarCodeTag == %@ AND userId == %d" ,animalbarCodeTag,userId)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}



func fetchAllDataOrderListIDgET(entityName: String,ordestatus: String,orderId:Int,userId:Int,listId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND orderId == %d AND userId == %d AND listId != %d", ordestatus,orderId,userId,listId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func beefFetchAllDataWithListId(entityName: String,orderStatus:String,pvid :Int,listid:Int64,custmerId:Int64) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND providerId == %d AND listId == %d AND custmerId == %d" ,orderStatus,pvid,listid,custmerId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            //commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}


func fetchAllDataAnimalNzImport(entityName: String,animalTag:String,custmerId :Int,userID :Int,orderId :Int) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    fetchRequest.predicate = NSPredicate(format: "animalTag LIKE[c] %@ AND custmerId == %d AND userId == %d AND orderId == %d ",animalTag,custmerId,userID,orderId)
        
    
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchDataEnteryAnimalTblBeef(entityName: String,customerId:Int,listId:Int64) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest  =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND listId == %d", customerId,listId)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalTag", ascending: true)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray

        }
    } catch {
    }
    
    return commanArray
}

func fetchDataEntryEarTagBeef(entityName: String,onfarmId:String,userId:Int,asending:Bool,customerId:Int,listId:Int64) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    if onfarmId == ""{
        fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND listId == %d",customerId,listId)
    } else {
        fetchRequest.predicate = NSPredicate(format: "(farmId contains[cd] %@ OR animalTag contains[cd] %@ OR animalbarCodeTag contains[cd] OR orderId contains[cd] %@ OR sampleStatus contains[cd] %@) AND custmerId == %d AND listId == %d",onfarmId,onfarmId,onfarmId,onfarmId,onfarmId,customerId,listId)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "earTag", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}

func fetchDataEntryEarTagBeef(entityName: String,barcodeID:String,userId:Int,asending:Bool,customerId:Int,listId:Int64) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    if barcodeID == ""{
        fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND listId == %d ",customerId,listId)
        
    }else{
        
        fetchRequest.predicate = NSPredicate(format: "(farmId contains[cd] %@ OR animalTag contains[cd] %@ OR animalbarCodeTag contains[cd] %@) AND custmerId ==  %d AND listId == %d ",barcodeID,barcodeID,barcodeID,customerId,listId)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalTag", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}

func fetchDataEntryReviewDefaultBeef(entityName: String,asending:Bool,userId:Int,farmId :String,customerId:Int,flag:Int,listId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    if farmId == ""{
        fetchRequest.predicate = NSPredicate(format: "orderstatus == %@  AND userId == %d AND custmerId == %d AND listId == %d", "false",userId,customerId,listId)
    }
    else {
            
            fetchRequest.predicate = NSPredicate(format: "orderstatus == %@  AND userId == %d AND (farmId contains[cd] %@ OR animalTag contains[cd] %@ OR animalbarCodeTag contains[cd] %@) AND custmerId == %d AND listId == %d", "false",userId,farmId,farmId,farmId,customerId,listId)

    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            if flag == 1 {
          
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: asending)
                let sortedResults = commanArray.sortedArray(using: [descriptor])
                commanArray = sortedResults as NSArray

            } else if flag == 2 {
          
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalTag", ascending: asending)
                let sortedResults = commanArray.sortedArray(using: [descriptor])
                commanArray = sortedResults as NSArray

            } else if flag == 3 {
         
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalbarCodeTag", ascending: asending)
                let sortedResults = commanArray.sortedArray(using: [descriptor])
                commanArray = sortedResults as NSArray

            
            } else if flag == 4 {
                
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "earTag", ascending: asending)
                let sortedResults = commanArray.sortedArray(using: [descriptor])
                commanArray = sortedResults as NSArray
            }else if flag == 5{
                
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "offsireId", ascending: asending)
                let sortedResults = commanArray.sortedArray(using: [descriptor])
                commanArray = sortedResults as NSArray
            }
            
            else if flag == 6{
                
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "offPermanentId", ascending: asending)
                let sortedResults = commanArray.sortedArray(using: [descriptor])
                commanArray = sortedResults as NSArray
            }
            else if flag == 7{
                
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "offDamId", ascending: asending)
                let sortedResults = commanArray.sortedArray(using: [descriptor])
                commanArray = sortedResults as NSArray
            }
            
            

           
        }
    } catch {
    }
    
    return commanArray
}


func fetchAllDataAnimalDatarderIdGlobal(entityName: String,userId:Int,orderId:Int,orderStatus:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "userId == %d  AND orderstatus == %@",userId,orderStatus)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            //commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchDataEnteryAnimalTblBeefData(entityName: String,customerId:Int,listId:Int64,productId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest  =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND listId == %d AND productId == %d", customerId,listId,productId)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: true)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray

        }
    } catch {
    }
    
    return commanArray
}


func fetchAnimalDataAccOfficalFarmid(entityName: String,farmId:String,anmalTag:String,custmerId :Int) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    
    if farmId == "" {
        
        fetchRequest.predicate = NSPredicate(format: "animalTag LIKE[c] %@ AND custmerId == %d", anmalTag,custmerId)

    } else if anmalTag == "" {
        
        fetchRequest.predicate = NSPredicate(format: "farmId LIKE[c] %@ AND custmerId == %d", farmId,custmerId)
        
    } else {
    
    fetchRequest.predicate = NSPredicate(format: "(farmId LIKE[c] %@ OR animalTag LIKE[c] %@) AND custmerId == %d", farmId,anmalTag,custmerId)
        
    }
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAnimalDataAccOfficalFarmid_ListID(entityName: String,farmId:String,anmalTag:String,custmerId :Int, listId:Int) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    
    if farmId == "" {
        
        fetchRequest.predicate = NSPredicate(format: "animalTag LIKE[c] %@ AND custmerId == %d AND listId == %d", anmalTag,custmerId, listId)

    } else if anmalTag == "" {
        
        fetchRequest.predicate = NSPredicate(format: "farmId LIKE[c] %@ AND custmerId == %d AND listId == %d", farmId,custmerId, listId)
        
    } else {
    
    fetchRequest.predicate = NSPredicate(format: "(farmId LIKE[c] %@ OR animalTag LIKE[c] %@) AND custmerId == %d AND listId == %d", farmId,anmalTag,custmerId, listId)
        
    }
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func checkAnimalDataAccOfficalFarmid_ListID(entityName: String,farmId:String,anmalTag:String,custmerId :Int, listId:Int, providerID:Int) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    fetchRequest.predicate = NSPredicate(format: "farmId == %@ AND animalTag == %@ AND custmerId == %d AND listId == %d AND providerId == %d", farmId,anmalTag,custmerId, listId, providerID)
        
    
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func updateDataInMasterAnimalTbl(entity: String,animalTag: String,barCodetag: String,date: String,damId: String,sireId: String,gender: String,update: String,permanentId: String,tissuName: String,breedName: String,et: String,farmId: String,orderId: Int,orderSataus:String,breedId: String,isSync:String,providerId:Int,tissuId: Int,sireIDAU:String,nationHerdAU:String,userId:Int,udid: String,animalId:Int, selectedBornTypeId: Int? = nil,isSyncServer:Bool,adhDataServer:Bool,custmerId :Int,editFlagSave:Bool) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
  requestDel.predicate = NSPredicate(format: "(farmId LIKE[c] %@ OR animalTag LIKE[c] %@) OR custmerId == %d AND animalId == %d", farmId,animalTag,custmerId,animalId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
              if entity == Entities.dataEntryAnimalAddTbl{
                objTable.setValue(2, forKey: "addeditdelete")
              }
                objTable.setValue(editFlagSave, forKey: "editFlagSave")
                objTable.setValue(animalTag, forKey: "animalTag")
                objTable.setValue(barCodetag, forKey: "animalbarCodeTag")
                objTable.setValue(date, forKey: "date")
                objTable.setValue(gender, forKey: "gender")
                objTable.setValue(permanentId, forKey: "offPermanentId")
                objTable.setValue(sireId, forKey: "offsireId")
                objTable.setValue(damId, forKey: "offDamId")
                objTable.setValue(tissuName, forKey: "tissuName")
                objTable.setValue(breedName, forKey: "breedName")
                objTable.setValue(farmId, forKey: "farmId")
                objTable.setValue(et, forKey: "eT")
                objTable.setValue(breedId, forKey: "breedId")
                objTable.setValue(isSync, forKey: "isSync")
                objTable.setValue(providerId, forKey: "providerId")
                objTable.setValue(tissuId, forKey: "tissuId")
                objTable.setValue(sireIDAU, forKey: "sireIDAU")
                objTable.setValue(nationHerdAU, forKey: "nationHerdAU")
                objTable.setValue(userId, forKey: "userId")
                objTable.setValue(udid, forKey: "udid")
                objTable.setValue(animalId, forKey: "animalId")
                objTable.setValue(selectedBornTypeId, forKey: "selectedBornTypeId")
                objTable.setValue(adhDataServer, forKey: "adhDataServer")
                objTable.setValue(isSyncServer, forKey: "isSyncServer")

                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func fetchDataEntryListGetWithProduct(entityName: String,customerId:Int64,userId:Int,providerId:Int,productType:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND providerId == %d AND productType == %@",customerId,providerId,productType)
    
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "listId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func deleteDataProductWithListid(entityName: String,status: String,listId:Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND listId == %d", status,listId)
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}
func fetchAllDataOrderStatusListId(entityName: String,ordestatus: String,listId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND listId == %d", ordestatus,listId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataGlobalEarTAG(entityName: String,userId:Int,orderId:Int,listid:Int64,custmerId:Int64,providerId:Int,earTag: String,orderStatus:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "listId == %d AND custmerId == %d AND providerId == %d AND animalTag == %@ AND orderstatus == %@",listid,custmerId,providerId,earTag,orderStatus)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            //commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataAnimalImportBeefGet(entityName: String,animalTag:String,custmerId :Int,userID :Int,orderId :Int) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    fetchRequest.predicate = NSPredicate(format: "animalTag LIKE[c] %@ AND custmerId == %d AND userId == %d AND orderId == %d ",animalTag,custmerId,userID,orderId)
        
    
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAnimaldataValidateAnimalBarcodeanimalIdOrderIdEarTag(entityName: String,animalbarCodeTag:String,orderSatatus: String) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    requestDel.predicate = NSPredicate(format: "animalTag == %@ AND orderstatus == %@" ,animalbarCodeTag,orderSatatus)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}
func fetchDataEnteryAnimalTblBeefDataBrazil(entityName: String,customerId:Int,listId:Int64,providerId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest  =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND listId == %d AND providerId == %d", customerId,listId,providerId)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
           // let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: true)
           // let sortedResults = commanArray.sortedArray(using: [descriptor])
           // commanArray = sortedResults as NSArray

        }
    } catch {
    }
    
    return commanArray
}


func fetchDataEntryDropDownSeries(entityName: String,onfarmId:String,userId:Int,asending:Bool,customerId:Int,listId:Int64) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    if onfarmId == ""{
        fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND listId == %d",customerId,listId)
    } else {
        fetchRequest.predicate = NSPredicate(format: "(farmId contains[cd] %@ OR animalTag contains[cd] %@ OR animalbarCodeTag contains[cd] %@ OR orderId contains[cd] %@ OR offsireId contains[cd] %@)  AND custmerId == %d AND listId == %d",onfarmId,onfarmId,onfarmId,onfarmId,onfarmId,customerId,listId)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "offsireId", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}

func fetchDataEntryDropDownRGN(entityName: String,onfarmId:String,userId:Int,asending:Bool,customerId:Int,listId:Int64) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    if onfarmId == ""{
        fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND listId == %d",customerId,listId)
    } else {
        fetchRequest.predicate = NSPredicate(format: "(farmId contains[cd] %@ OR animalTag contains[cd] %@ OR animalbarCodeTag contains[cd] %@ OR orderId contains[cd] %@ OR offPermanentId contains[cd] %@)  AND custmerId == %d AND listId == %d",onfarmId,onfarmId,onfarmId,onfarmId,onfarmId,customerId,listId)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "offPermanentId", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}

func fetchDataEntryDropDownRGd(entityName: String,onfarmId:String,userId:Int,asending:Bool,customerId:Int,listId:Int64) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    if onfarmId == ""{
        fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND listId == %d",customerId,listId)
    } else {
        fetchRequest.predicate = NSPredicate(format: "(farmId contains[cd] %@ OR animalTag contains[cd] %@ OR animalbarCodeTag contains[cd] %@ OR orderId contains[cd] %@ OR offDamId contains[cd] %@)  AND custmerId == %d AND listId == %d",onfarmId,onfarmId,onfarmId,onfarmId,onfarmId,customerId,listId)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "offDamId", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}
func fetchDataEntryDropDownBarcodeBrazil(entityName: String,onfarmId:String,userId:Int,asending:Bool,customerId:Int,listId:Int64) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.returnsObjectsAsFaults = false
    if onfarmId == ""{
        fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND listId == %d",customerId,listId)
    } else {
        fetchRequest.predicate = NSPredicate(format: "(farmId contains[cd] %@ OR animalTag contains[cd] %@ OR animalbarCodeTag contains[cd] %@) AND custmerId == %d AND listId == %d",onfarmId,onfarmId,onfarmId,customerId,listId)
    }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "animalTag", ascending: asending)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            
        }
    } catch {
    }
    
    return commanArray
}



func fetchAnimalDataAccEarTag(entityName: String,animalTag:String, custmerId :Int64,providerid:Int,productId:Int) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    fetchRequest.predicate = NSPredicate(format: "animalTag LIKE[c] %@ AND custmerId == %d AND providerId == %d AND productId == %d", animalTag,custmerId,providerid,productId )
    
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}



func updateOrderInfoBeefGlobal(entity: String,animalTag: String,barCodetag: String,date: String,damId: String,sireId: String,gender: String,permanentId: String,tissuName: String,breedName: String,et: String,farmId: String,orderId: Int,breedId: String,providerId:Int,tissuId: Int,sireIDAU:String,nationHerdAU:String,userId:Int,productId:Int,custmerId:Int64,editFlagSave:Bool) {
   
   let appDelegate = UIApplication.shared.delegate as! AppDelegate
   let context = appDelegate.persistentContainer.viewContext
   let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
   requestDel.predicate = NSPredicate(format: "animalTag LIKE[c] %@ AND custmerId == %d AND productId == %d AND providerId == %d", animalTag,custmerId,productId,providerId)
   requestDel.returnsObjectsAsFaults = false
   
   do {
       let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
       
       if fetchedResult!.count > 0 {
           for i in 0..<fetchedResult!.count {
               let objTable = fetchedResult![i]
               objTable.setValue(editFlagSave, forKey: "editFlagSave")
               objTable.setValue(animalTag, forKey: "animalTag")
               objTable.setValue(date, forKey: "date")
               objTable.setValue(gender, forKey: "gender")
               objTable.setValue(permanentId, forKey: "offPermanentId")
               objTable.setValue(sireId, forKey: "offsireId")
               objTable.setValue(damId, forKey: "offDamId")
               objTable.setValue(tissuName, forKey: "tissuName")
               objTable.setValue(breedName, forKey: "breedName")
               objTable.setValue(farmId, forKey: "farmId")
               objTable.setValue(et, forKey: "eT")
             //  objTable.setValue(orderId, forKey: "orderId")
               objTable.setValue(breedId, forKey: "breedId")
               objTable.setValue(providerId, forKey: "providerId")
               objTable.setValue(tissuId, forKey: "tissuId")
               objTable.setValue(sireIDAU, forKey: "sireIDAU")
               objTable.setValue(nationHerdAU, forKey: "nationHerdAU")
               objTable.setValue(userId, forKey: "userId")
            
          //     objTable.setValue(animalidNew, forKey: "animalId")
               do  {
                   try context.save()
               }
               catch {
               }
           }
       }
   }
   catch {
   }
}


func updateOrderInfoBeefInherit(entity: String,animalTag: String, animalbarCodeTag: String, date: String,damId: String,sireId: String,gender: String,permanentId: String,tissuName: String,breedName: String,et: String,farmId: String,breedId: String,providerId:Int,tissuId: Int,sireIDAU:String,nationHerdAU:String,userId:Int,udid: String,sirYOB :String,damYOB:String,sireRegAssocation:String,productId:Int,custmerId:Int64,editFlagSave:Bool) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "animalTag LIKE[c] %@ AND custmerId == %d AND productId == %d AND providerId == %d", animalTag,custmerId,productId,providerId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                objTable.setValue(editFlagSave, forKey: "editFlagSave")
              if entity == Entities.dataEntryBeefAnimalAddTblEntity{
                objTable.setValue(2, forKey: "addeditdelete")
              }
                objTable.setValue(animalTag, forKey: "animalTag")
              objTable.setValue(animalbarCodeTag, forKey: "animalbarCodeTag")
                objTable.setValue(date, forKey: "date")
                objTable.setValue(gender, forKey: "gender")
                objTable.setValue(permanentId, forKey: "offPermanentId")
                objTable.setValue(sireId, forKey: "offsireId")
                objTable.setValue(damId, forKey: "offDamId")
                objTable.setValue(tissuName, forKey: "tissuName")
                objTable.setValue(breedName, forKey: "breedName")
                objTable.setValue(farmId, forKey: "farmId")
                objTable.setValue(et, forKey: "eT")
                objTable.setValue(breedId, forKey: "breedId")
                objTable.setValue(providerId, forKey: "providerId")
                objTable.setValue(tissuId, forKey: "tissuId")
                objTable.setValue(sireIDAU, forKey: "sireIDAU")
                objTable.setValue(nationHerdAU, forKey: "nationHerdAU")
                objTable.setValue(userId, forKey: "userId")
                objTable.setValue(udid, forKey: "udid")
                objTable.setValue(sirYOB, forKey: "sireYOB")
                objTable.setValue(damYOB, forKey: "damYOB")
                objTable.setValue(sireRegAssocation, forKey: "sireRegAssocation")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateOrderInfoBeefNZ(entity: String,animalTag: String,date: String,damId: String,sireId: String,gender: String,permanentId: String,tissuName: String,breedName: String,et: String,farmId: String,breedId: String,providerId:Int,tissuId: Int,sireIDAU:String,nationHerdAU:String,userId:Int,udid: String,diffDate:Int,productId:Int,custmerId:Int64, editFlagSave: Bool) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "animalTag LIKE[c] %@ AND custmerId == %d AND productId == %d AND providerId == %d", animalTag,custmerId,productId,providerId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                objTable.setValue(editFlagSave, forKey: "editFlagSave")
                objTable.setValue(animalTag, forKey: "animalTag")
              //  objTable.setValue(barCodetag, forKey: "animalbarCodeTag")
                objTable.setValue(date, forKey: "date")
                objTable.setValue(gender, forKey: "gender")
                objTable.setValue(permanentId, forKey: "offPermanentId")
                objTable.setValue(sireId, forKey: "offsireId")
                objTable.setValue(damId, forKey: "offDamId")
                objTable.setValue(tissuName, forKey: "tissuName")
                objTable.setValue(breedName, forKey: "breedName")
                objTable.setValue(farmId, forKey: "farmId")
                objTable.setValue(et, forKey: "eT")
                // objTable.setValue(update, forKey: "status")
                //objTable.setValue(orderId, forKey: "orderId")
                // objTable.setValue(orderSataus, forKey: "orderstatus")
                objTable.setValue(breedId, forKey: "breedId")
              //  objTable.setValue(isSync, forKey: "isSync")
                objTable.setValue(providerId, forKey: "providerId")
                objTable.setValue(tissuId, forKey: "tissuId")
                objTable.setValue(sireIDAU, forKey: "sireIDAU")
                objTable.setValue(nationHerdAU, forKey: "nationHerdAU")
                objTable.setValue(userId, forKey: "userId")
                objTable.setValue(udid, forKey: "udid")
              //  objTable.setValue(animalId, forKey: "animalId")
             //   objTable.setValue(diffDate, forKey: "diffAge")
                //objTable.setValue("", forKey: "bothConf")
                
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func fetchAnimalDataAccEarTagGirlando(entityName: String,animalTag:String,custmerId :Int64,providerid:Int) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    fetchRequest.predicate = NSPredicate(format: "earTag LIKE[c] %@ AND custmerId == %d AND providerId == %d", animalTag,custmerId,providerid)
    
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func checkAnimalDataAccEarTagGirlando(entityName: String,animalTag:String,custmerId :Int64,providerid:Int, listID: Int) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    fetchRequest.predicate = NSPredicate(format: "earTag == %@ AND custmerId == %d AND providerId == %d AND listId == %d", animalTag,custmerId,providerid, listID)
    
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func updateOrderInfoGirlando(entity: String,earTag: String, barCode: String, date: String,damId: String,sireId: String,gender: String,breedRegNumber: String,tissuName: String,breedName: String,et: String,farmId: String,breedId: String,providerId:Int,tissuId: Int,sireIDAU:String,animalName:String,userId:Int,udid: String, selectedBornTypeId: Int? = nil,breedAssocation:String,custmerId:Int64,editFlagSave:Bool) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "earTag LIKE[c] %@ AND custmerId == %d AND providerId == %d", earTag,custmerId,providerId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
              if entity == Entities.dataEntryAnimalAddTbl{
                objTable.setValue(2, forKey: "addeditdelete")
              }
                objTable.setValue(editFlagSave, forKey: "editFlagSave")

                objTable.setValue(earTag, forKey: "earTag")
                objTable.setValue(barCode, forKey: "animalbarCodeTag")
              
                objTable.setValue(animalName, forKey: "animalName")
                objTable.setValue(breedRegNumber, forKey: "breedRegNumber")
                objTable.setValue(breedAssocation, forKey: "breedAssocation")
                objTable.setValue(date, forKey: "date")
                objTable.setValue(gender, forKey: "gender")
                objTable.setValue(sireId, forKey: "offsireId")
                objTable.setValue(damId, forKey: "offDamId")
                objTable.setValue(tissuName, forKey: "tissuName")
                objTable.setValue(breedName, forKey: "breedName")
                objTable.setValue(farmId, forKey: "farmId")
                objTable.setValue(et, forKey: "eT")
                objTable.setValue(breedId, forKey: "breedId")
                objTable.setValue(providerId, forKey: "providerId")
                objTable.setValue(tissuId, forKey: "tissuId")
                objTable.setValue(sireIDAU, forKey: "sireIDAU")
                objTable.setValue(userId, forKey: "userId")
                objTable.setValue(udid, forKey: "udid")
                objTable.setValue(selectedBornTypeId, forKey: "selectedBornTypeId")
                
                do {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func fetchDataEnteryWithListId(entityName: String,customerId:Int,listId:Int64,providerId:Int,orderstatus:String,orderiD:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest  =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND listId != %d AND providerId == %d AND orderstatus == %@ AND orderId == %d", customerId,listId,providerId,orderstatus,orderiD)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
           // let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: true)
           // let sortedResults = commanArray.sortedArray(using: [descriptor])
           // commanArray = sortedResults as NSArray

        }
    } catch {
    }
    
    return commanArray
}
func fetchListNameAccordingToListId(entityName: String,customerId:Int,listId:Int64,providerId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest  =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND listId == %d AND providerId == %d", customerId,listId,providerId)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
           // let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: true)
           // let sortedResults = commanArray.sortedArray(using: [descriptor])
           // commanArray = sortedResults as NSArray

        }
    } catch {
    }
    
    return commanArray
}


///

func updateDataInSaveClick(entity: String,serverAnimalId:String,farmId:String,animalTag:String,custmerId:Int,animalId:Int,listId:Int = 0) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
  if listId != 0{
    requestDel.predicate = NSPredicate(format: "(farmId LIKE[c] %@ OR animalTag LIKE[c] %@ OR animalId == %d) AND custmerId == %d AND listId == %d", farmId,animalTag,animalId,custmerId, listId)
  } else{
    requestDel.predicate = NSPredicate(format: "(farmId LIKE[c] %@ OR animalTag LIKE[c] %@ OR animalId == %d) AND custmerId == %d", farmId,animalTag,animalId,custmerId)
  }
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
              if (entity == Entities.dataEntryBeefAnimalAddTblEntity || entity == Entities.dataEntryAnimalAddTbl) && listId != 0{
                objTable.setValue(0, forKey: "addeditdelete")
              }
                objTable.setValue(serverAnimalId, forKey: "serverAnimalId")
              
                objTable.setValue(false, forKey: "editFlagSave")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updadeOfflineSyncInfo(entity: String,customerId:Int,offlineSync:Bool,listid :Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "customerId == %d AND listId == %d", customerId,listid)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(customerId, forKey: "customerId")
                objTable.setValue(offlineSync, forKey: "offlineSync")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateDataInSaveClickSeverId(entity: String,serverAnimalId:String,farmId:String,animalTag:String,custmerId:Int,animalId:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "(farmId LIKE[c] %@ OR animalTag LIKE[c] %@ OR animalId == %d) AND custmerId == %d", farmId,animalTag,animalId,custmerId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(serverAnimalId, forKey: "serverAnimalId")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}


func fetchSampleDetailDataWithProvideId(entityName: String, sampleId: Int, providerId: Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    fetchRequest.predicate = NSPredicate(format: "sampleId == %d AND providerId == %d", sampleId, providerId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}


func fetchProductAdonData(entityName : String,prodId: Int,isCdcbProduct:Bool) -> NSArray{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    requestDel.predicate = NSPredicate(format: "productId == %d AND isCdcbProduct == %d",prodId,isCdcbProduct)
    requestDel.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}




func deleteDataWithListNamee(entityString:String ,listName: String,customerId:Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  entityString)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "listName == %@ AND customerId == %d ", listName,customerId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}
func deleteDataWithListId1(entityString:String ,listId: Int,customerId:Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  entityString)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "listId == %d AND custmerId == %d ", listId,customerId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}




func fetchAllDataEnteryListWithCustId(entityName: String,customerId:Int64) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d ",customerId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}




func fetchAllDataLastUpdatedData(entityName: String,customerId:Int64,hittingTime :String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  fetchRequest.predicate = NSPredicate(format: "custId == %d  AND hittingTime != %@",customerId,hittingTime)
 //  fetchRequest.predicate = NSPredicate(format: "custId == %d",customerId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func updatELastUpdatedData(entity: String,custmerId:Int,hittingTime:String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "custId == %d", custmerId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(custmerId, forKey: "custId")
                objTable.setValue(hittingTime, forKey: "hittingTime")
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func saveLastInAnimalUpdateTime(entity: String,custId:Int64,hittingTime:String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    
    content.setValue(custId, forKey: "custId")
    content.setValue(hittingTime, forKey: "hittingTime")
    
    
    do {
        try managedObjectContext.save()
       
    } catch {
       
    }
}
func fetchAllDataLastUpdatedTime(entityName: String,customerId:Int64) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "custId == %d ",customerId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}


func fetchListNameAccordingToListIdOnly(entityName: String,customerId:Int,listId:Int64) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest  =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND listId == %d", customerId,listId)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
           // let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: true)
           // let sortedResults = commanArray.sortedArray(using: [descriptor])
           // commanArray = sortedResults as NSArray

        }
    } catch {
    }
    
    return commanArray
}



func fetchListNameToCustId(entityName: String,customerId:Int,providerId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest  =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND providerId == %d", customerId,providerId)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}



func fetchAllDataServerAnimalIdWithoutListId(entityName: String,userId:Int,orderStatus:String,custmerId:Int64,serverAnimalId:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND custmerId == %d AND serverAnimalId == %@",orderStatus,custmerId,serverAnimalId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            //commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataEditConditionWithoutListId(entityName: String,userId:Int,orderStatus:String,custmerId:Int64,serverAnimalId:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "orderstatus == %@ AND custmerId == %d AND serverAnimalId != %@ AND editFlagSave == %d",orderStatus,custmerId,serverAnimalId,true)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
            //commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}



func fetchDataEnteryWithListIdWithoutProviderID(entityName: String,customerId:Int,listId:Int64,orderstatus:String,orderiD:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest  =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND listId != %d AND orderstatus == %@ AND orderId == %d", customerId,listId,orderstatus,orderiD)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
           // let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: true)
           // let sortedResults = commanArray.sortedArray(using: [descriptor])
           // commanArray = sortedResults as NSArray

        }
    } catch {
    }
    
    return commanArray
}






func deleteDataWithGroupId(entityString:String ,listId: String,customerId:Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  entityString)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "groupServerId == %@ AND customerId == %d ", listId,customerId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}


func deletegroupWithGroupId(entityName: String, customerId: Int64,serverGroupId:String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  entityName)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "customerId == %d && serverGroupId == %@" , customerId,serverGroupId)
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}


func saveGroupDataResult(entity: String,customerId: Int64,groupId: Int64,groupDesc: String,groupName: String,groupStatusId: Int,groupStatus : String,groupTypeId: Int,groupType : String,groupServerId:String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
  
    content.setValue(groupServerId, forKey: "groupServerId")

    content.setValue(customerId, forKey: "customerId")
    content.setValue(groupId, forKey: "groupId")
    content.setValue(groupDesc, forKey: "groupDesc")
    content.setValue(groupName, forKey: "groupName")
    content.setValue(groupStatusId, forKey: "groupStatusId")
    content.setValue(groupStatus, forKey: "groupStatus")
    
    content.setValue(groupTypeId, forKey: "groupTypeId")
    content.setValue(groupType, forKey: "groupTypeName")

    do {
        try managedObjectContext.save()
      
    } catch {
      
    }
}

func updateGroupTable(entity: String,customerId: Int64,groupId: Int64,groupDesc: String,groupName: String,groupStatusId: Int,groupStatus : String,groupTypeId: Int,groupType : String,groupServerId:String) {
//(entity: String,customerId:Int64,groupServerId:String,groupTypeName:String,groupTypeId:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    requestDel.predicate = NSPredicate(format: "customerId == %d  AND groupServerId == %@", customerId, groupServerId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let content = fetchedResult![i]
              
              content.setValue(groupServerId, forKey: "groupServerId")

              content.setValue(customerId, forKey: "customerId")
              content.setValue(groupId, forKey: "groupId")
              content.setValue(groupDesc, forKey: "groupDesc")
              content.setValue(groupName, forKey: "groupName")
              content.setValue(groupStatusId, forKey: "groupStatusId")
              content.setValue(groupStatus, forKey: "groupStatus")
              
              content.setValue(groupTypeId, forKey: "groupTypeId")
              content.setValue(groupType, forKey: "groupTypeName")
                
                do {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}


func fetchOrdersWithMyHerdFilter(entityName: String, searchText: String = "", customerId:Int64) -> NSArray {
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    if searchText != "" {

    fetchRequest.predicate = NSPredicate(format: "(officialID contains[cd] %@ OR onFarmID contains[cd] %@ OR dob contains[cd] %@) AND customerId == %d AND searchbyanimal == %d", searchText,searchText,searchText,customerId, false)
    } else {
        
        fetchRequest.predicate = NSPredicate(format: "customerId == %d", customerId)

    }
    fetchRequest.returnsObjectsAsFaults = false

    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
           
           
           
      
        }
        
    } catch {
    }
    
    return commanArray
}

func fetchOrdersresultsearch(entityName: String, searchText: String = "",customerId:Int64) -> NSArray
{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    if searchText != "" {

    fetchRequest.predicate = NSPredicate(format: "(numericValue contains[cd] %d) AND customerId == %d", searchText,customerId)
    } else {
        
        fetchRequest.predicate = NSPredicate(format: "(numericValue == %d) AND customerId == %d",customerId)

    }
    fetchRequest.returnsObjectsAsFaults = false

    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
      
        }
        
    } catch {
    }
    
    return commanArray
}


func fetchOrdersWithMyGroupFilteranimals(entityName: String, searchText: String = "",customerId:Int64,groupName:String) -> NSArray {
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    if searchText != "" {

    fetchRequest.predicate = NSPredicate(format: "(officalId contains[cd] %@ OR onFarmId contains[cd] %@ OR dob contains[cd] %@)  AND customerId == %d AND groupName == %@ ", searchText,searchText,searchText,customerId,groupName)
    } else {
        
        fetchRequest.predicate = NSPredicate(format: "customerId == %d", customerId)

    }
    fetchRequest.returnsObjectsAsFaults = false

    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "dob", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
      
        }
        
    } catch {
    }
    
    return commanArray
}


func fetchOrdersWithMyGroupFilter(entityName: String, groupName: String, searchText: String = "",customerId:Int64) -> NSArray {
   
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    if searchText != "" {
    fetchRequest.predicate = NSPredicate(format: "groupName contains[cd] %@ AND customerId == %d", searchText,customerId)
        fetchRequest.returnsObjectsAsFaults = false

        do{
          let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult{
                commanArray = results as NSArray
          
            }
            
        } catch {
        }
    }
   
    
    return commanArray
}





func saveMergeDataEntryList(entity: String,customerId: Int64,listName: String,listId: Int64,providerId: Int64,listDesc:String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    content.setValue(customerId, forKey: "customerId")
    content.setValue(listName, forKey: "listName")
    content.setValue(listId, forKey: "listId")
    content.setValue(providerId, forKey: "providerId")
    content.setValue(listDesc, forKey: "listDesc")

    do {
        try managedObjectContext.save()
        
    } catch {
       
    }
}




func deleteMergeDataListId(entityString:String ,listId: Int64,customerId:Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  entityString)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "listId == %d AND customerId == %d ", listId,customerId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}



func fetchMergeDataListId(entityName: String,listId: Int64,customerId:Int64) -> NSArray {
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "listId == %d && customerId == %d", listId,customerId)
    fetchRequest.returnsObjectsAsFaults = false

    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
        
    } catch {
    }
    
    return commanArray
}



func deleteDataWithPvidCustomerId(entityString:String ,providerId: Int64,customerId:Int64) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  entityString)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "providerId == %d AND customerId == %d ", providerId,customerId)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}

func fetchMergeDataPvidCustomer(entityName: String,providerId: Int64,customerId:Int64) -> NSArray {
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "providerId == %d && customerId == %d", providerId,customerId)
    fetchRequest.returnsObjectsAsFaults = false

    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
        
    } catch {
    }
    
    return commanArray
}

func fetchGroupNameAccordingToGroupName(entityName: String,customerId:Int,groupName:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest  =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND groupName == %@", customerId,groupName)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray

        }
    } catch {
    }
    
    return commanArray
}



func fetchAllDataEnteryList(entityName: String,customerId:Int64,groupName: String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND groupName LIKE[c] %@",customerId,groupName)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}








func fetchAnimalServerAnimalId(entityName: String,customerId:Int64,serverAnimalId: String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND serverAnimalId == %@",customerId,serverAnimalId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}














func updateOrderInfoGirlandoServeId(entity: String,earTag: String,date: String,damId: String,sireId: String,gender: String,breedRegNumber: String,tissuName: String,breedName: String,et: String,farmId: String,breedId: String,providerId:Int,tissuId: Int,sireIDAU:String,animalName:String,userId:Int,udid: String, selectedBornTypeId: Int? = nil,breedAssocation:String,custmerId:Int64,editFlagSave:Bool,serverAnimalId:String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "custmerId == %d AND providerId == %d AND serverAnimalId == %@", custmerId,providerId,serverAnimalId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(editFlagSave, forKey: "editFlagSave")
                objTable.setValue(earTag, forKey: "earTag")
                objTable.setValue(animalName, forKey: "animalName")
                objTable.setValue(breedRegNumber, forKey: "breedRegNumber")
                objTable.setValue(breedAssocation, forKey: "breedAssocation")
                objTable.setValue(date, forKey: "date")
                objTable.setValue(gender, forKey: "gender")
                objTable.setValue(sireId, forKey: "offsireId")
                objTable.setValue(damId, forKey: "offDamId")
                objTable.setValue(tissuName, forKey: "tissuName")
                objTable.setValue(breedName, forKey: "breedName")
                objTable.setValue(farmId, forKey: "farmId")
                objTable.setValue(et, forKey: "eT")
                objTable.setValue(breedId, forKey: "breedId")
                objTable.setValue(providerId, forKey: "providerId")
                objTable.setValue(tissuId, forKey: "tissuId")
                objTable.setValue(sireIDAU, forKey: "sireIDAU")
                objTable.setValue(userId, forKey: "userId")
                objTable.setValue(udid, forKey: "udid")
                objTable.setValue(selectedBornTypeId, forKey: "selectedBornTypeId")
                
                do {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}


func fetchGroupInfoResultnew(entityName: String,groupName: String,customerId:Int64) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "groupName == %@ AND customerId == %d",groupName,customerId)
    fetchRequest.returnsObjectsAsFaults = false
    //let descriptor: NSSortDescriptor = NSSortDescriptor(key: "dob", ascending: false)
   // fetchRequest.sortDescriptors = [descriptor]
    do{
            let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult{
                
                commanArray = results as NSArray
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "datedob", ascending: false)
                let sortedResults = commanArray.sortedArray(using: [descriptor])
                commanArray = sortedResults as NSArray
            }
        } catch {
        }


    
    return commanArray
}



func fetchGroupInfoResult(entityName: String,groupName: String,customerId:Int64) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "groupName == %@ AND customerId == %d",groupName,customerId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "dob", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
         
        }
    } catch {
    }
    
    return commanArray
}


func fetchGroupnamecheck(entityName: String,groupName: String,customerId:Int64,Onfarmid:String) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "groupName == %@ AND customerId == %d AND onFarmId == %@",groupName,customerId,Onfarmid)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchGroupchild(entityName: String,customerId:Int64,Onfarmid:String) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND onFarmId == %@",customerId,Onfarmid)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchGroupchildstatuscheck(entityName: String,customerId:Int64,Onfarmid:String) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND onFarmID == %@",customerId,Onfarmid)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func isEntityAttributeExist(id: String, entityName: String) -> Bool {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "onFarmID == %@", id)
    let res = try! managedContext.fetch(fetchRequest)
    return res.count > 0 ? true : false
}

var bridIdArray = [Int]()

func fetchResultAnimalbySearch(entity: String,animalID:String,officialID :String,customerId:Int, onFarmID:String, barCode:String = "", searchbyFound: Bool)-> NSArray{
  let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entity)
  if barCode == "" {
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND animalID == %@ AND officialID == %@ AND onFarmID == %@ AND searchbyanimal == %d",customerId, animalID, officialID,onFarmID,searchbyFound)
  } else {
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND animalID == %@ AND officialID == %@ AND onFarmID == %@ AND sampleBarCode == %@ AND searchbyanimal == %d",customerId, animalID, officialID,onFarmID,barCode)
  }
  
  fetchRequest.returnsObjectsAsFaults = false
  do{
      let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
      if let results = fetchedResult{
          
         commanArray = results as NSArray
      }
  } catch {
  }
  
  return commanArray
}

func saveAnimaldataResultByPage(entity: String,animalID:String,breed : String,breedID :String,customerId :Int,customerName:String,dob:String,name:String,notes:String,officialID:String,onFarmID:String,orderNumber:String,products:String,reportedDate: String,sampleBarCode: String,sampleStatus: String,sex: String,animalDownloadCount:Int16,orderDate:String,damID:String,sireID:String,mgsID:String,status:String,datedob:Date, resultType: String,searchbyanimal:Bool,currentDatetime: Int64, searchbyFound: Bool) {
   // dependency?.showIndicator((dependency?.view)!, withTitle: NSLocalizedString("Syncing results data...", comment: ""), and: "")
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.newBackgroundContext()
    
    managedObjectContext.automaticallyMergesChangesFromParent = true

    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)

    content.setValue(customerId, forKey: "customerId")
    content.setValue(animalID, forKey: "animalID")
    content.setValue(breed, forKey: "breed")
    content.setValue(breedID, forKey: "breedID")
    content.setValue(customerName, forKey: "customerName")
    content.setValue(dob, forKey: "dob")
    content.setValue(name, forKey: "name")
    content.setValue(notes, forKey: "notes")
    content.setValue(officialID, forKey: "officialID")
    content.setValue(onFarmID, forKey: "onFarmID")

    content.setValue(orderNumber, forKey: "orderNumber")
    content.setValue(products, forKey: "products")
    content.setValue(reportedDate, forKey: "reportedDate")
    content.setValue(sampleBarCode, forKey: "sampleBarCode")
    content.setValue(sampleStatus, forKey: "sampleStatus")
    content.setValue(sex, forKey: "sex")
    content.setValue(sireID, forKey: "sireID")
    content.setValue(damID, forKey: "damID")
    content.setValue(mgsID, forKey: "mgsID")
    content.setValue(orderDate, forKey: "orderDate")
    content.setValue(animalDownloadCount, forKey: "animalDownloadCount")
    content.setValue(status, forKey: "status")
    content.setValue(datedob, forKey: "datedob")
    content.setValue(resultType, forKey: "resultType")
 
    content.setValue(currentDatetime, forKey: "currentDateTime")
    content.setValue(searchbyanimal, forKey: "searchbyanimal")

        do {
            
            try managedObjectContext.save()
            
        } catch {
            
        }
}

func updateAnimaldataResultByPage(entity: String,animalID:String,breed : String,breedID :String,customerId :Int,customerName:String,dob:String,name:String,notes:String,officialID:String,onFarmID:String,orderNumber:String,products:String,reportedDate: String,sampleBarCode: String,sampleStatus: String,sex: String,animalDownloadCount:Int16,orderDate:String,damID:String,sireID:String,mgsID:String,status:String,datedob:Date, resultType: String,searchbyanimal:Bool,currentDatetime: Int64, searchbyFound: Bool) {
  
    
  let appDelegate = UIApplication.shared.delegate as! AppDelegate
  let context = appDelegate.persistentContainer.viewContext
  let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
  if searchbyFound{
    requestDel.predicate = NSPredicate(format: "customerId == %d AND animalID == %@ AND searchbyanimal == %d ", customerId, animalID, searchbyanimal )
  }else {
    requestDel.predicate = NSPredicate(format: "customerId == %d AND animalID == %@ ", customerId, animalID )
  }
  requestDel.returnsObjectsAsFaults = false
  
  do {
      let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
      
      if fetchedResult!.count > 0 {
          for i in 0..<fetchedResult!.count {
              let content = fetchedResult![i]
            content.setValue(customerId, forKey: "customerId")
            content.setValue(animalID, forKey: "animalID")
            content.setValue(breed, forKey: "breed")
            content.setValue(breedID, forKey: "breedID")
            content.setValue(customerName, forKey: "customerName")
            content.setValue(dob, forKey: "dob")
            content.setValue(name, forKey: "name")
            content.setValue(notes, forKey: "notes")
            content.setValue(officialID, forKey: "officialID")
            content.setValue(onFarmID, forKey: "onFarmID")

            content.setValue(orderNumber, forKey: "orderNumber")
            content.setValue(products, forKey: "products")
            content.setValue(reportedDate, forKey: "reportedDate")
            content.setValue(sampleBarCode, forKey: "sampleBarCode")
            content.setValue(sampleStatus, forKey: "sampleStatus")
            content.setValue(sex, forKey: "sex")
            content.setValue(sireID, forKey: "sireID")
            content.setValue(damID, forKey: "damID")
            content.setValue(mgsID, forKey: "mgsID")
            content.setValue(orderDate, forKey: "orderDate")
            content.setValue(animalDownloadCount, forKey: "animalDownloadCount")
            content.setValue(status, forKey: "status")
            content.setValue(datedob, forKey: "datedob")
            content.setValue(resultType, forKey: "resultType")
        
            content.setValue(currentDatetime, forKey: "currentDateTime")
            content.setValue(searchbyanimal, forKey: "searchbyanimal")

          
             
              do  {
                  try context.save()
              }
              catch {
              }
          }
      }
  }
  catch {
  }
  
}

func updateAnimalSelectedDataResult(entity: String,animalID:String,customerId :Int,searchbyanimal:Bool,selectedAnimal: Bool) {
  
    
  let appDelegate = UIApplication.shared.delegate as! AppDelegate
  let context = appDelegate.persistentContainer.viewContext
  let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
  
    requestDel.predicate = NSPredicate(format: "customerId == %d AND animalID == %@ AND searchbyanimal == %d ", customerId, animalID, searchbyanimal )
  
  requestDel.returnsObjectsAsFaults = false
  
  do {
      let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
      
      if fetchedResult!.count > 0 {
          for i in 0..<fetchedResult!.count {
              let content = fetchedResult![i]
            content.setValue(selectedAnimal, forKey: "selectedAnimal")
              do  {
                  try context.save()
              }
              catch {
              }
          }
      }
  }
  catch {
  }
  
}

/*
 var applicationInfoList = [LogApplicationInfo]()
         let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
         let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ApplicationInfo")
         
         do{
             let result = try context.fetch(request)
        
             if result.count > 0
 */

//func deleteDuplicates(entity: String) {
//
//    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//       let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:  "ResultMyHerdData")
//
//       do {
//           let results = try managedObjectContext.fetch(fetchRequest)

//           for managedObject in results {
//               let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
//               managedObjectContext.delete(managedObjectData)
//           }
//       }
//       catch {
//       }
////    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
////
////    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
////
////            var resultsArr:[ResulyByPageModel] = []
////            do {
////                resultsArr = try (managedObjectContext.fetch(fetchRequest) as! [ResulyByPageModel])
////            } catch {
////                let fetchError = error as NSError

////            }
////
////     if resultsArr.count > 0 {
////      for x in resultsArr {

////       // if x.animals[IndexPath].officialID == id {

////           //   mainManagedObjectContext.deleteObject(x)
////     //       }
////          }
////       }
//}
//
func deleteDataWithofficalId(entityName: String, officialID: String) {

    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  entityName)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "officialID == %@", officialID)
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
       // results.count
        for managedObject in results {
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
           
        }
    }
    catch {
    }
}

func saveAnimaldataafterfetch(entity: String,animalID:String,breed : String,breedID :String,customerId :Int,customerName:String,dob:String,name:String,notes:String,officialID:String,onFarmID:String,orderNumber:String,products:String,reportedDate: String,sampleBarCode: String,sampleStatus: String,sex: String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    
    
    content.setValue(customerId, forKey: "customerId")
    
    content.setValue(animalID, forKey: "animalID")
    content.setValue(breed, forKey: "breed")
    content.setValue(breedID, forKey: "breedID")
    content.setValue(customerName, forKey: "customerName")
    content.setValue(dob, forKey: "dob")
    content.setValue(name, forKey: "name")
    content.setValue(notes, forKey: "notes")
    content.setValue(officialID, forKey: "officialID")
    content.setValue(onFarmID, forKey: "onFarmID")

    content.setValue(orderNumber, forKey: "orderNumber")
    content.setValue(products, forKey: "products")
    content.setValue(reportedDate, forKey: "reportedDate")
    content.setValue(sampleBarCode, forKey: "sampleBarCode")
    content.setValue(sampleStatus, forKey: "sampleStatus")
    content.setValue(sex, forKey: "sex")

    do {
        try managedObjectContext.save()
       
    } catch {
        
    }
}







func saveTraitDataResultByPage(entity: String,orderNumber: String,traitDate : String,numericValue :Double,customerId: Int,customerName: String,officalId: String,onFarmId :String,stringValue : String,trait: String,traitId: String,display:String ,numericFormat: String ) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.newBackgroundContext()
    managedObjectContext.automaticallyMergesChangesFromParent = true

    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    
    content.setValue(orderNumber, forKey: "orderNumber")
    content.setValue(traitDate, forKey: "traitDate")

    content.setValue(numericValue, forKey: "numericValue")
    content.setValue(customerName, forKey: "customerName")
    content.setValue(customerId, forKey: "customerId")
    content.setValue(officalId, forKey: "officalId")
    content.setValue(onFarmId, forKey: "onFarmId")
    content.setValue(stringValue, forKey: "stringValue")
    content.setValue(trait, forKey: "trait")
    content.setValue(traitId, forKey: "traitId")
    content.setValue(display, forKey: "display")
    content.setValue(numericFormat, forKey: "numericFormat")
    
        do {
               try managedObjectContext.save()
             
           } catch {
              
           }
   
}


func saveMasterApiPageNumber(entity: String,customerId: Int64, pageNumber: Int64) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    
    content.setValue(customerId, forKey: "customerId")
    content.setValue(pageNumber, forKey: "pageNumber")
    do {
        try managedObjectContext.save()
       
    } catch {
        
    }
}

func saveHerdanimalGroups(entity: String,customerId: Int, animalId: String, groupID:String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    
    content.setValue(customerId, forKey: "customerID")
    content.setValue(animalId, forKey: "animalID")
    content.setValue(groupID, forKey: "groupServerId")
    do {
        try managedObjectContext.save()
       
    } catch {
        
    }
}

func updateHerdanimalGroups(entity: String,customerId: Int, animalId: String, groupID:String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "customerID == %d AND animalID == %@ ", customerId, animalId )
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
              objTable.setValue(groupID, forKey: "groupServerId")
               
                do  {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func updateMasterApiPageNumber(entity: String,custmerId:Int,pageNumber:Int64) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "customerId == %d", custmerId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                objTable.setValue(pageNumber, forKey: "pageNumber")
               
                do  {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateAnimaldataResultByPage(entity: String,animalID:String,breed : String,breedID :String,customerId :Int,customerName:String,dob:String,name:String,notes:String,officialID:String,onFarmID:String,orderNumber:String,products:String,reportedDate: String,sampleBarCode: String,sampleStatus: String,sex: String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    requestDel.predicate = NSPredicate(format: "customerId == %d && animalID == %@", customerId,animalID)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
    
                
                objTable.setValue(notes, forKey: "notes")
                
                objTable.setValue(customerId, forKey: "customerId")
                
                objTable.setValue(animalID, forKey: "animalID")
                objTable.setValue(breed, forKey: "breed")
                objTable.setValue(breedID, forKey: "breedID")
                objTable.setValue(customerName, forKey: "customerName")
                objTable.setValue(dob, forKey: "dob")
                objTable.setValue(name, forKey: "name")
                objTable.setValue(notes, forKey: "notes")
                objTable.setValue(officialID, forKey: "officialID")
                objTable.setValue(onFarmID, forKey: "onFarmID")

                objTable.setValue(orderNumber, forKey: "orderNumber")
                objTable.setValue(products, forKey: "products")
                objTable.setValue(reportedDate, forKey: "reportedDate")
                objTable.setValue(sampleBarCode, forKey: "sampleBarCode")
                objTable.setValue(sampleStatus, forKey: "sampleStatus")
                objTable.setValue(sex, forKey: "sex")
               
                do  {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
 
}
func fetchMasterApiPageNumberData(entityName: String,customerId:Int64) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.newBackgroundContext()
    managedObjectContext.automaticallyMergesChangesFromParent = true

    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d ",customerId)
    fetchRequest.returnsObjectsAsFaults = false
    managedObjectContext.perform {
        do{
            let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult{
                commanArray = results as NSArray
            }
        } catch {
        }
        
    }
   
    return commanArray
}



func saveTraitHeaderMaster(entity: String,productName: String,species: String,headerName:String,headerId:String,traidid : String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    
    content.setValue(productName, forKey: "productName")
    content.setValue(species, forKey: "species")
    content.setValue(headerName, forKey: "headerName")
    content.setValue(headerId, forKey: "traitNames")
    content.setValue(traidid, forKey: "traitId")
    do {
        
        try managedObjectContext.save()
        
    } catch {
       
    }
}




func saveMasterTemplate(entity: String, notes: String, attributeName: String, calving:String, defaultSortOrder:Int, displayName :String, fertility :String, geneticConditions :String, indexes:String, location :String, milkProteins:String, parentage: String, photos:String, productName:String, profile:String, results:Int, sortBy:Bool, speciesName:String, traitId:String, type:String, wellness:String,production:String, breedFilter : [String]) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    
    content.setValue(notes, forKey: "notes")
    content.setValue(attributeName, forKey: "attributeName")
    content.setValue(calving, forKey: "calving")
    content.setValue(defaultSortOrder, forKey: "defaultSortOder")
    
    content.setValue(displayName, forKey: "displayName")
    content.setValue(fertility, forKey: "fertility")
    content.setValue(geneticConditions, forKey: "geneticConditions")
    content.setValue(indexes, forKey: "indexes")
    
    content.setValue(location, forKey: "location")
    content.setValue(milkProteins, forKey: "milkProteins")
    content.setValue(parentage, forKey: "parentage")
    content.setValue(photos, forKey: "photos")
    
    content.setValue(productName, forKey: "productName")
    content.setValue(profile, forKey: "profile")
    content.setValue(results, forKey: "results")
    content.setValue(sortBy, forKey: "sortBy")
    
    content.setValue(speciesName, forKey: "speciesName")
    content.setValue(traitId, forKey: "traitId")
    content.setValue(type, forKey: "type")
    content.setValue(wellness, forKey: "wellness")
    content.setValue(production, forKey: "production")
    content.setValue(breedFilter, forKey: "breedFilter")
    
    do {
        try managedObjectContext.save()
       
    } catch {
      
    }
}



func fetchResultdata(entityName: String,customerId:Int64,breed:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND headerName == %@",customerId,breed)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
//func fetchResultMyHerdData(entityName: String,customerId:Int64,Breedid:String) -> NSArray{
//    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//    fetchRequest.predicate = NSPredicate(format: "customerId == %d ",customerId)
//    fetchRequest.returnsObjectsAsFaults = false
//    do{
//        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
//        if let results = fetchedResult{
//            commanArray = results as NSArray
//        }
//    } catch {
//    }
//
//    return commanArray
//}
func fetchResultMyHerdData(entityName: String,customerId:Int64 , searchFound: Bool = false) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  if entityName == "ResultMyHerdData"{
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND searchbyanimal == %d",customerId,searchFound)
  } else {
    fetchRequest.predicate = NSPredicate(format: "customerId == %d ",customerId)
  }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
           commanArray = results as NSArray
          if searchFound {
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "currentDateTime", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
          }
        }
    } catch {
    }
    
    return commanArray
}
func fetchdamidseiaid(entityName: String,customerId:Int64,officalid : String,onfarmid: String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND officialID == %@ AND  onFarmID == %@",customerId,officalid,onfarmid)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
           commanArray = results as NSArray
            
//            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "dob", ascending: false)
//            let sortedResults = commanArray.sortedArray(using: [descriptor])
//            commanArray = sortedResults as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchSearchedResultAnimal(entityName: String,customerId:Int64,searchFound: Bool = false,searchText:String,searchByearTag:Bool) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  if searchByearTag {
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND searchbyanimal == %d AND onFarmID == %@",customerId, searchFound,searchText)
  } else {
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND searchbyanimal == %d AND officialID == %@",customerId, searchFound,searchText)
  }

    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray

            
        }
    } catch {
    }
    
    return commanArray
}
func fetchResultpagenumberMyHerdData(entityName: String,customerId:Int64,searchFound: Bool = false) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND searchbyanimal == %d",customerId, searchFound)

//  } else {
//    fetchRequest.predicate = NSPredicate(format: "customerId == %d ",customerId)
//  }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            
            commanArray = results as NSArray
          if searchFound {
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "currentDateTime", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
          }
            
            
        }
    } catch {
    }
    
    return commanArray
}
func fetchResultMyHerdDataanimal(entityName: String,customerId:Int64,breedid:String,searchFound: Bool = false) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d  AND breedID == %@ AND searchbyanimal == %d ",customerId,breedid,searchFound)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
          if searchFound {
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "currentDateTime", ascending: false)
            let sortedResults = commanArray.sortedArray(using: [descriptor])
            commanArray = sortedResults as NSArray
          }
        }
    } catch {
    }
    
    return commanArray
}

func fetchResultTraitIndex(entityName: String,species: String, productName: String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  if productName == "Herdity"{
     let pName = "CLARIFIDE CDCB"
    fetchRequest.predicate = NSPredicate(format: "species == %@ AND (productName == %@ OR productName == %@)",species, productName, pName)
  } else {
    fetchRequest.predicate = NSPredicate(format: "species == %@ AND productName == %@",species, productName)
  }
    
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchResultTraitIdGet(entityName: String,species: String, headerName: String, productName:String, searchByAnimal: Bool) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  if productName == "Herdity" && searchByAnimal {
    fetchRequest.predicate = NSPredicate(format: "species == %@ AND headerName == %@ AND productName == %@",species,headerName,productName)
  }
   else if productName == "Herdity" && !searchByAnimal {
    let pName = "CLARIFIDE CDCB"
    fetchRequest.predicate = NSPredicate(format: "species == %@ AND headerName == %@ AND (productName == %@ OR productName == %@)",species,headerName,productName, pName)
  } else {
    fetchRequest.predicate = NSPredicate(format: "species == %@ AND headerName == %@ AND productName == %@",species,headerName,productName)
  }
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.returnsDistinctResults = true
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchResultTraitIdTemplate1(entityName: String,traitId: String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "traitId == %@ ",traitId )
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.returnsDistinctResults = true
  
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchResultTraitIdTemplate(entityName: String,traitId: String,productName :String, searchByAnimal:Bool) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  if productName == "Herdity" && searchByAnimal {
    fetchRequest.predicate = NSPredicate(format: "traitId == %@ AND productName == %@",traitId, productName)
  }
 else if productName == "Herdity" {
    let pName = "CLARIFIDE CDCB"
    fetchRequest.predicate = NSPredicate(format: "traitId == %@ AND productName == %@ OR productName == %@",traitId, productName,pName)
  } else {
    fetchRequest.predicate = NSPredicate(format: "traitId == %@ AND productName == %@",traitId, productName)
  }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchResultcheck(entityName: String,trait:String,onFarmId:String,officalId:String) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "display == %@ AND onFarmId == %@ AND officalId == %@",trait,onFarmId,officalId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchResultname(entityName: String,trait:String,onFarmId:String,officalId:String) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "trait == %@ AND onFarmId == %@ AND officalId == %@",trait,onFarmId,officalId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchResultTraitIdPageApi(entityName: String,traitId: String, onFarmId:String,officalId:String) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "traitId == %@ AND onFarmId == %@ AND officalId == %@",traitId,onFarmId,officalId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchResultRanknew(entityName: String,onFarmId:String,officalId:String,customerId: Int64,traitId:String) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "onFarmId == %@ AND officalId == %@ AND customerId == %d AND traitId == %@",onFarmId,officalId,customerId,traitId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchResultRank(entityName: String,onFarmId:String,officalId:String,customerId: Int64) -> NSArray{

    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "onFarmId == %@ AND officalId == %@ AND customerId == %d",onFarmId,officalId,customerId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }

    return commanArray
}

func fetchResultnote(entityName: String,onFarmID:String,customerId: Int64,officialID:String) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "onFarmID == %@  AND customerId == %d AND officialID == %@",onFarmID,customerId, officialID)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func deleteDataWithCustomerId(entityName: String, customerId: Int64) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  entityName)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "customerId == %d", customerId)
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}




func fetchGrupExistGroupUpdate(entityName: String, groupID: String) -> NSArray {
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "serverGroupId == %@", groupID)
    fetchRequest.returnsObjectsAsFaults = false

    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
      
        }
        
    } catch {
    }
    
    return commanArray
}

func updateNotesAgainstFarmIdOfficalId(entity: String,custmerId:Int,onFarmID:String,officialID:String,notes:String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "customerId == %d AND onFarmID == %@ AND officialID == %@", custmerId,onFarmID,officialID)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                objTable.setValue(notes, forKey: "notes")
               
                do  {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updatePhotoAgainstFarmIdOfficalId(entity: String,custmerId:Int,onFarmID:String,officialID:String,photos:UIImage) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "customerId == %d AND onFarmID == %@ AND officialID == %@", custmerId,onFarmID,officialID)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                let imageData = NSData(data: photos.jpegData(compressionQuality: 1.0) ?? Data()) as Data

                objTable.setValue(imageData, forKey: "photos")
               
                do  {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updategroupPhotoAgainstFarmIdOfficalId(entity: String,custmerId:Int,onFarmID:String,officialID:String,photos:UIImage) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "customerId == %d AND onFarmId == %@ AND officalId == %@", custmerId,onFarmID,officialID)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                let imageData = NSData(data: photos.jpegData(compressionQuality: 1.0) ?? Data())

                objTable.setValue(imageData, forKey: "photos")
               
                do  {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updatePhotoNil(entity: String,custmerId:Int,onFarmID:String,officialID:String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "customerId == %d AND onFarmID == %@ AND officialID == %@", custmerId,onFarmID,officialID)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                

                objTable.setValue(nil, forKey: "photos")
               
                do  {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updategroupPhotoNil(entity: String,custmerId:Int,onFarmID:String,officialID:String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "customerId == %d AND onFarmId == %@ AND officalId == %@", custmerId,onFarmID,officialID)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                

                objTable.setValue(nil, forKey: "photos")
               
                do  {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateNotesAgainstgroupscren(entity: String,custmerId:Int,onFarmID:String,officialID:String,notes:String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "customerId == %d AND onFarmId == %@ AND officalId == %@", custmerId,onFarmID,officialID)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                objTable.setValue(notes, forKey: "notes")
               
                do  {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updatePhotoAgainstgroup(entity: String,custmerId:Int,onFarmID:String,officialID:String,photos:UIImage) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "customerId == %d AND onFarmId == %@ AND officalId == %@", custmerId,onFarmID,officialID)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                let imageData = NSData(data: photos.jpegData(compressionQuality: 1.0)!) as Data

                objTable.setValue(imageData, forKey: "photos")
               
                do  {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}


func saveTraitValueHideWithIndex(entity: String,traitId: String,customerId: Int64,headerName:String,userId:Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    
    content.setValue(traitId, forKey: "traitId")
    content.setValue(customerId, forKey: "customerId")
    content.setValue(headerName, forKey: "headerName")
    content.setValue(userId, forKey: "userId")
    do {
        try managedObjectContext.save()
        
    } catch {
      
    }
}




func fetchResultTraitIdHideIndex(entityName: String, headerName: String, userId: Int, customerId: Int64,traitId :String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "headerName == %@ AND userId == %d AND customerId == %d AND traitId == %@", headerName,userId,customerId,traitId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchResultTraitIdHideTitles(entityName: String, headerName: String, userId: Int, customerId: Int64) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "headerName == %@ AND userId == %d AND customerId == %d", headerName,userId,customerId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}



func savefilterApiData(entity: String,customerId: Int,customerName : String,providerId :Int,providerName: String,breedId: String,breedName: String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    
    content.setValue(customerId, forKey: "customerId")
    content.setValue(customerName, forKey: "customerName")

    content.setValue(providerId, forKey: "providerID")
    content.setValue(providerName, forKey: "providerName")
    content.setValue(breedId, forKey: "breedId")
    content.setValue(breedName, forKey: "breedName")

    do {
        try managedObjectContext.save()
       
    } catch {
        
    }
}
func fetchResultFilterData(entityName: String,customerId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  
    fetchRequest.predicate = NSPredicate(format: "customerId == %d",customerId)
  
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}


func fetchResultFilterData1(entityName: String,customerId:Int, isheridity:Bool = false, productID:Int = 0) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  if entityName == "ResultFIlterDataSave" {
    if productID == 0{
      fetchRequest.predicate = NSPredicate(format: "customerId == %d AND isHeriditySelected == %d",customerId, isheridity)
    } else {
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND isHeriditySelected == %d AND productID == %d",customerId, isheridity, productID)
  }
  } else {
    fetchRequest.predicate = NSPredicate(format: "customerId == %d",customerId)
  }
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchResultFilterDataWithProduct(entityName: String, customerId:Int, productName:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d", customerId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchResultFilterDataWithProductid(entityName: String, customerId:Int, providerid:Int64) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND providerID == %d", customerId,providerid)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func savefilterSettingData(entity: String,customerId: Int, breedIndex : Int, productIndex : Int,sex : String,dateto : String ,datefrom: String,breedName:String,trait:String,header:String,productname:String,breedId:String,traidsave : String,sortorder:Bool,idselection:String, isHerditySelected: Bool, productID: Int) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    
    content.setValue(breedIndex, forKey: "breedIndex")
    content.setValue(breedName, forKey: "breedName")
    content.setValue(customerId, forKey: "customerId")
    content.setValue(productIndex, forKey: "productIndex")
    content.setValue(productname, forKey: "productName")
    content.setValue(breedId, forKey: "breedID")
    content.setValue(sex, forKey: "sex")
    content.setValue(dateto, forKey: "dateto")
    content.setValue(datefrom, forKey: "datefrom")
    content.setValue(header, forKey: "header")
    content.setValue(trait, forKey: "trait")
    content.setValue(traidsave, forKey: "traidsave")
    content.setValue(sortorder, forKey: "sortorder")
    content.setValue(idselection, forKey: "idselection")
    content.setValue(isHerditySelected, forKey: "isHeriditySelected")
   content.setValue(productID, forKey: "productID")
  
    //idselection
    do {
        try managedObjectContext.save()
          
        print("saved")
        
    } catch {
        print(error.localizedDescription)
    }
}

func updatefilterSettingData(entity: String,customerId: Int, breedIndex : Int, productIndex : Int,sex : String,dateto : String ,datefrom: String,breedName:String,trait:String,header:String,productname:String,breedId:String,traidsave : String,sortorder:Bool,idselection:String, isHerditySelected: Bool, productId: Int) {
  
  let appDelegate = UIApplication.shared.delegate as! AppDelegate
  let context = appDelegate.persistentContainer.viewContext
  let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
  requestDel.predicate = NSPredicate(format: "customerId == %d AND isHeriditySelected == %d ", customerId,isHerditySelected)
  requestDel.returnsObjectsAsFaults = false
  
  do {
    let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
    
    if fetchedResult!.count > 0 {
      for i in 0..<fetchedResult!.count {
        let objTable = fetchedResult![i]
        
        objTable.setValue(breedIndex, forKey: "breedIndex")
        objTable.setValue(breedName, forKey: "breedName")
        objTable.setValue(productIndex, forKey: "productIndex")
        objTable.setValue(productname, forKey: "productName")
        objTable.setValue(breedName, forKey: "breedName")
        objTable.setValue(breedId, forKey: "breedID")
        objTable.setValue(sex, forKey: "sex")
        objTable.setValue(idselection, forKey: "idselection")
        objTable.setValue(dateto, forKey: "dateto")
        objTable.setValue(datefrom, forKey: "datefrom")
        objTable.setValue(header, forKey: "header")
        objTable.setValue(trait, forKey: "trait")
        objTable.setValue(traidsave, forKey: "traidsave")
        objTable.setValue(sortorder, forKey: "sortorder")
        objTable.setValue(isHerditySelected, forKey: "isHeriditySelected")
        objTable.setValue(productId, forKey: "productID")
        
        
        do {
          try context.save()
        }
        catch {
        }
      }
    }
  }
  catch {
  }
}

func fetchanimalExistInDataBase(entityName: String, groupStatusId: Int, groupTypeId: Int, customerId:Int64,Onfarmid: String, officialID: String) -> NSArray {
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  fetchRequest.predicate = NSPredicate(format: "groupStatusId == %d AND groupTypeId == %d AND customerId == %d AND onFarmId == %@ AND officalId == %@", groupStatusId,groupTypeId,customerId,Onfarmid, officialID)

    fetchRequest.returnsObjectsAsFaults = false

    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
        
    } catch {
    }
    
    return commanArray
}


func fetchGroupExistInDataBase(entityName: String, groupStatusId: Int, groupTypeId: Int, customerId:Int64,groupServerID: String =  "") -> NSArray {
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  if groupServerID == "" {
    fetchRequest.predicate = NSPredicate(format: "groupStatusId == %d && groupTypeId == %d && customerId == %d", groupStatusId,groupTypeId,customerId)
  }else {
    fetchRequest.predicate = NSPredicate(format: "groupStatusId == %d && groupTypeId == %d && customerId == %d AND groupServerId == %@", groupStatusId,groupTypeId,customerId,groupServerID)
  }
    fetchRequest.returnsObjectsAsFaults = false

    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
        
    } catch {
    }
    
    return commanArray
}


func fetchGrupExist(entityName: String, groupID: String) -> NSArray {
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "groupServerId == %@", groupID)
    fetchRequest.returnsObjectsAsFaults = false

    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
      
        }
        
    } catch {
    }
    
    return commanArray
}



func updateMyHerdData(entity: String,customerId:Int64,animalID:String,groupIDs:String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "customerId == %d && animalID == %@", customerId,animalID)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
               objTable.setValue(groupIDs, forKey: "groupIDs")

                
                do {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func updateMyHerdDataStaus(entity: String,customerId:Int64,animalID:String,status:String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "customerId == %d && animalID == %@", customerId,animalID)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
               objTable.setValue(status, forKey: "status")

                
                do {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateMyHerdDatByGroup(entity: String,customerId:Int64,status:String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "customerId == %d && status == %@", customerId,status)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
               objTable.setValue(nil, forKey: "status")

                
                do {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func updateMyHerdDataAllStaus(entity: String,customerId:Int64,status:String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "customerId == %d", customerId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
               objTable.setValue(status, forKey: "status")

                
                do {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func updateMyHerdDataNewRequired(entity: String,customerId:Int64,animalID:String,groupStatusId:Int,groupTypeId:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "customerId == %d && animalID == %@", customerId,animalID)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
               objTable.setValue(groupStatusId, forKey: "groupStatusId")
                objTable.setValue(groupTypeId, forKey: "groupTypeId")


                
                do {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}



func deleteAnimalWithGroupId(entityName: String, customerId: Int64,serverGroupId:String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName:  entityName)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "customerId == %d && serverGroupId == %@" , customerId,serverGroupId)
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}


func deletGroupInfoResult(entityName: String,groupName: String,customerId:Int64,animalId :String ,onFarmId : String) -> NSArray
{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND animalID == %@",customerId,animalId)
    fetchRequest.returnsObjectsAsFaults = false
   
    do {
        let commanArray = try context.fetch(fetchRequest)

        for object in commanArray as! [NSManagedObject]
        { // Fetching Object
            context.delete(object) // Deleting Object
        }
    }
    catch
    {
        
    }

    
    return commanArray
    

}

func deletGroupInfoResultGroupDetail(entityName: String,groupName: String,customerId:Int64,onFarmId : String, officalId : String) -> NSArray
{
    
   
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  fetchRequest.predicate = NSPredicate(format: "customerId == %d AND onFarmId == %@ AND groupName == %@ AND officalId == %@",customerId,onFarmId,groupName,officalId)
    fetchRequest.returnsObjectsAsFaults = false
   
    do {
        let commanArray = try context.fetch(fetchRequest)

        for object in commanArray as! [NSManagedObject]
        { // Fetching Object
            context.delete(object) // Deleting Object
        }
    }
    catch
    {
       
    }

    
    return commanArray
    

}
func deleteMyHerdGroup(entityName: String,animalID: String,customerId:Int64,groupServerId : String) -> NSArray
{
    
   
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerID == %d AND animalID == %@ AND groupServerId == %@",customerId,animalID,groupServerId)
    fetchRequest.returnsObjectsAsFaults = false
   
    do {
        let commanArray = try context.fetch(fetchRequest)

        for object in commanArray as! [NSManagedObject]
        { // Fetching Object
            context.delete(object) // Deleting Object
        }
    }
    catch
    {
       
    }

    
    return commanArray
    

}
func deletGroupnonassigned(entityName: String,customerId:Int64,onFarmId : String) -> NSArray
{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND onFarmId == %@",customerId,onFarmId)
    fetchRequest.returnsObjectsAsFaults = false
   
    do {
        let commanArray = try context.fetch(fetchRequest)

        for object in commanArray as! [NSManagedObject]
        { // Fetching Object
            context.delete(object) // Deleting Object
        }
    }
    catch
    {
       
    }

    
    return commanArray
    

}
func deletanim(entityName: String,customerId:Int64,animalId: String, onFarmId:String ) -> NSArray
{
    //let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND animalID == %@",customerId,animalId,onFarmId)
    fetchRequest.returnsObjectsAsFaults = false
   

    

    do {
        let commanArray = try context.fetch(fetchRequest)

        for object in commanArray as! [NSManagedObject]
        { // Fetching Object
            context.delete(object) // Deleting Object
        }
    }
    catch
    {
       
    }

    
    return commanArray
    
}
func updateGroupTypeIdInGroupTable(entity: String,customerId:Int64,groupServerId:String,groupStatus:String,groupStatusId:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "customerId == %d && groupServerId == %@", customerId,groupServerId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
               objTable.setValue(groupStatus, forKey: "groupStatus")
               objTable.setValue(groupStatusId, forKey: "groupStatusId")

                
                do {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func updateGroupTypeIdInGroupTableStatus(entity: String,customerId:Int64) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "customerId == %d", customerId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
               objTable.setValue(nil, forKey: "status")
              

                
                do {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func updateGroupTypeIdResultGroupAnimal(entity: String,customerId:Int64,serverGroupId:String,groupStatus:String,groupStatusId:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "customerId == %d && serverGroupId == %@", customerId,serverGroupId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
               objTable.setValue(groupStatus, forKey: "groupStatus")
               objTable.setValue(groupStatusId, forKey: "groupStatusId")

                
                do {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func fetchAnimalAssignExistIntable(entityName: String,customerId:Int64,animalId: String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND animalID == %@",customerId,animalId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchAnimalforGroupIntable(entityName: String,customerId:Int64,animalId: String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerID == %d AND animalID == %@",customerId,animalId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchgroupdata(entityName: String,customerId:Int64,isUpdatedtrue:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND isUpdatedtrue == %@",customerId,isUpdatedtrue)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func addanimalfetchServer(entityName: String,customerId:Int64,gId: String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND serverGroupId == %@",customerId,gId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func addanimalfetch(entityName: String,customerId:Int64) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d",customerId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}


func saveAnimaldataResult(entity: String,serverGroupId:String,groupName:String,groupStatusId:Int,groupStatus:String,groupTypeId:Int,groupTypeName:String,animalID:String,onFarmId:String,officalId:String,dob:String,sex:String,breedId:String,breedName:String,name:String,groupId:Int64,customerId:Int64,datedob:Date) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let content = NSEntityDescription.insertNewObject(forEntityName: entity, into: managedObjectContext)
    
    content.setValue(customerId, forKey: "customerId")
    content.setValue(serverGroupId, forKey: "serverGroupId")
    content.setValue(groupName, forKey: "groupName")
    content.setValue(groupStatusId, forKey: "groupStatusId")
    content.setValue(groupStatus, forKey: "groupStatus")
    content.setValue(groupTypeId, forKey: "groupTypeId")
    content.setValue(groupTypeName, forKey: "groupTypeName")
    content.setValue(animalID, forKey: "animalID")
    content.setValue(onFarmId, forKey: "onFarmId")
    content.setValue(officalId, forKey: "officalId")
    
    content.setValue("true", forKey: "isUpdatedtrue")
    
    content.setValue(dob, forKey: "dob")
    content.setValue(sex, forKey: "sex")
    content.setValue(breedId, forKey: "breedId")
    content.setValue(breedName, forKey: "breedName")
    content.setValue(name, forKey: "name")
    content.setValue(groupId, forKey: "groupId")
    content.setValue(datedob, forKey: "datedob")

    do {
        try managedObjectContext.save()
        
    } catch {
        
    }
}
func updateAnimaldataResult(entity: String,serverGroupId:String,groupName:String,groupStatusId:Int,groupStatus:String,groupTypeId:Int,groupTypeName:String,animalID:String,onFarmId:String,officalId:String,dob:String,sex:String,breedId:String,breedName:String,name:String,groupId:Int64,customerId:Int64,datedob:Date) {
    
  let appDelegate = UIApplication.shared.delegate as! AppDelegate
  let context = appDelegate.persistentContainer.viewContext
  let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
  requestDel.predicate = NSPredicate(format: "serverGroupId == %@ AND customerId == %d AND onFarmId == %@ AND  officalId == %@", serverGroupId,customerId,onFarmId,officalId)
  requestDel.returnsObjectsAsFaults = false
    
  do {
      let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
      
      if fetchedResult!.count > 0 {
          for i in 0..<fetchedResult!.count {
              let content = fetchedResult![i]
            content.setValue(customerId, forKey: "customerId")
            content.setValue(serverGroupId, forKey: "serverGroupId")
            content.setValue(groupName, forKey: "groupName")
            content.setValue(groupStatusId, forKey: "groupStatusId")
            content.setValue(groupStatus, forKey: "groupStatus")
            content.setValue(groupTypeId, forKey: "groupTypeId")
            content.setValue(groupTypeName, forKey: "groupTypeName")
            content.setValue(animalID, forKey: "animalID")
            content.setValue(onFarmId, forKey: "onFarmId")
            content.setValue(officalId, forKey: "officalId")
            
            content.setValue("true", forKey: "isUpdatedtrue")
            
            content.setValue(dob, forKey: "dob")
            content.setValue(sex, forKey: "sex")
            content.setValue(breedId, forKey: "breedId")
            content.setValue(breedName, forKey: "breedName")
            content.setValue(name, forKey: "name")
            content.setValue(groupId, forKey: "groupId")
            content.setValue(datedob, forKey: "datedob")
              
              do
              {
                  try context.save()
              }
              catch {
              }
          }
      }
  }
  catch {
  }
  
}

func fetchGroupAnimalbyCustomerID(entityName: String,customerId:Int64) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d", customerId)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}


func fetchAnimaldataResult(customerId:Int64, serverGroupId:String,onFarmId:String,officalId:String)-> NSArray {
    
  let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

  let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: "ResultGroupsAnimals")

  fetchRequest.predicate = NSPredicate(format: "customerId == %d  AND serverGroupId == %@ AND onFarmId == %@ AND officalId == %@",customerId,serverGroupId,onFarmId,officalId)

  fetchRequest.returnsObjectsAsFaults = false


    do {
      
      let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]

      if let results = fetchedResult{

          commanArray = results as NSArray

      }

  } catch {
        
    }
  return commanArray
}
func fetcresultgroupid(entityName: String,customerId:Int64,Groupstatusid:Int64,grouptypeid:Int64,animalid:String) -> NSArray{

    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)

    fetchRequest.predicate = NSPredicate(format: "customerId == %d  AND groupStatusId == %d AND groupTypeId == %d AND animalID == %@",customerId,Groupstatusid,grouptypeid,animalid)

    fetchRequest.returnsObjectsAsFaults = false

    do{

        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]

        if let results = fetchedResult{

            commanArray = results as NSArray

        }

    } catch {

    }
    return commanArray

}
func updateAnimalgroupsave(entity: String,serverGroupId: String,customerId:Int64,isUpdatedtrue:String) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    requestDel.predicate = NSPredicate(format: "serverGroupId == %@ AND customerId == %d", serverGroupId,customerId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                objTable.setValue("false", forKey: "isUpdatedtrue")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
    
    
}

func updateGroupTypeIdInResulTable(entity: String,serverGroupId:String, groupName:String,groupStatusId:Int,groupStatus:String,groupTypeId:Int,groupTypeName:String,animalID:String,onFarmId:String,officalId:String,dob:String,sex:String,breedId:String,breedName:String,name:String,groupId:Int64,customerId:Int64) {
//(entity: String,customerId:Int64,groupServerId:String,groupTypeName:String,groupTypeId:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    requestDel.predicate = NSPredicate(format: "customerId == %d && animalID == %@", customerId,animalID)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(groupId, forKey: "groupId")
                objTable.setValue(groupName, forKey: "groupName")
                objTable.setValue(groupStatus, forKey: "groupStatus")
                objTable.setValue(groupStatusId, forKey: "groupStatusId")
                objTable.setValue(groupTypeName, forKey: "groupTypeName")
                objTable.setValue(groupTypeId, forKey: "groupTypeId")
                objTable.setValue(serverGroupId, forKey: "serverGroupId")

                objTable.setValue(animalID, forKey: "animalID")
                objTable.setValue(name, forKey: "name")
                
                do {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}

func updateGroupTypeIdInResulTableUpadte(entity: String, groupName:String,groupTypeId:Int,groupTypeName:String,customerId:Int64) {
//(entity: String,customerId:Int64,groupServerId:String,groupTypeName:String,groupTypeId:Int) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    requestDel.predicate = NSPredicate(format: "customerId == %d && groupName == %@", customerId,groupName)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
               // objTable.setValue(groupId, forKey: "groupId")
                objTable.setValue(groupName, forKey: "groupName")
                //objTable.setValue(groupStatus, forKey: "groupStatus")
              //  objTable.setValue(groupStatusId, forKey: "groupStatusId")
                objTable.setValue(groupTypeName, forKey: "groupTypeName")
                objTable.setValue(groupTypeId, forKey: "groupTypeId")
              //  objTable.setValue(serverGroupId, forKey: "serverGroupId")

                //objTable.setValue(animalID, forKey: "animalID")
               // objTable.setValue(name, forKey: "name")
                
                do {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}


func upDateGrupAnimal (entity: String,groupName:String,groupTypeId:Int16,groupTypeName:String,customerId:Int64,updateGname:String,onFarmId:String,gruopSatusId:Int16,serverGid:String){
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    requestDel.predicate = NSPredicate(format: "customerId == %d && groupName == %@ && onFarmId == %@", customerId,groupName,onFarmId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
               
                objTable.setValue(updateGname, forKey: "groupName")
                objTable.setValue(groupTypeName, forKey: "groupTypeName")
                objTable.setValue(groupTypeId, forKey: "groupTypeId")
                objTable.setValue(gruopSatusId, forKey: "groupStatusId")
                objTable.setValue(serverGid, forKey: "serverGroupId")
              
                
                do {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func upDateGrupAnimalIndividual (entity: String,groupName:String,groupTypeId:Int16,groupTypeName:String,customerId:Int64,updateGname:String,onFarmId:String,gruopSatusId:Int16,serverGid:String){
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    requestDel.predicate = NSPredicate(format: "customerId == %d && serverGroupId == %@ && onFarmId == %@", customerId,groupName,onFarmId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
               
                objTable.setValue(updateGname, forKey: "groupName")
                objTable.setValue(groupTypeName, forKey: "groupTypeName")
                objTable.setValue(groupTypeId, forKey: "groupTypeId")
                objTable.setValue(gruopSatusId, forKey: "groupStatusId")
                objTable.setValue(serverGid, forKey: "serverGroupId")
              
                
                do {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}
func fetchGroupIdWithStatus(entityName: String,customerId:Int64,groupStatusId: Int,groupTypeId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND groupStatusId == %d AND groupTypeId == %d",customerId, groupStatusId,groupTypeId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchGroupIdFethSatusG(entityName: String,customerId:Int64,groupStatusId: Int,groupTypeId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND groupStatusId == %d AND groupTypeId == %d",customerId, groupStatusId,groupTypeId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchGroupIdFethSatusanimalId(entityName: String,customerId:Int64,groupName: String,onFarmId:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND groupName == %@ AND onFarmId == %@",customerId, groupName,onFarmId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func fetchGroupnotassigned(entityName: String,customerId:Int64,onFarmId:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND onFarmId == %@",customerId,onFarmId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchGroupIdupdateanimal(entityName: String,customerId:Int64,groupTypeId: Int,onFarmId:String, officialID:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND groupTypeId == %d AND onFarmId == %@ AND officalId == %@",customerId, groupTypeId,onFarmId, officialID)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func fetchAllDataWithServerGroupId(entityName: String,customerId:Int64,serverGroupId:String) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND groupServerId == %@",customerId,serverGroupId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

//let parameters : [String: Any] = ["customerId": customerId,"groupName":groupName,"groupTypeId":groupTypeId,"groupStatusId":groupStatusId,"description":description]


func fetchDbCheckSameGroupTypeExit(entityName: String,customerId:Int64,groupTypeId:Int,groupStatusId:Int) -> NSArray{
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerId == %d AND groupTypeId == %d AND groupStatusId == %d",customerId,groupTypeId,groupStatusId)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}
func updateAnimalOrderEmailStatus(entity: String,IsEmailId: Bool, custId : Int = 0) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "custmerId == %d", custId)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for i in 0..<fetchedResult!.count {
                let objTable = fetchedResult![i]
                
                objTable.setValue(IsEmailId, forKey: "isDataEmailed")
                
                do
                {
                    try context.save()
                }
                catch {
                }
            }
        }
    }
    catch {
    }
}


func fetchADHAnimalList(entityName: String, customerId:Int, userID: Int, specieID: String, breedID: String, gender: String,isADHCart: Bool ) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  if(gender == "A"){
    fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND userId == %d AND specisType == %@ AND breedId == %@ AND orderstatus == %@ AND isADHCart == %d AND adhDataServer == %d",customerId, userID, specieID, breedID, "false", isADHCart, true)
  } else {
    fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND userId == %d AND specisType == %@ AND breedId == %@ AND gender == %@ AND orderstatus == %@ AND isADHCart == %d AND adhDataServer == %d",customerId, userID, specieID, breedID, gender, "false", isADHCart, true)
  }

    fetchRequest.returnsObjectsAsFaults = false
   fetchRequest.returnsDistinctResults = true
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}

func fetchFilteredADHAnimalList(entityName: String, customerId:Int, userID: Int, specieID: String, breedID: String, gender: String, startDate: String, endDate: String) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
   fetchRequest.predicate = NSPredicate(format: "custmerId == %d AND userId == %d AND specisType == %@ AND breedId == %@ AND gender == %@ orderstatus == %@ AND isHausaHerdBook == %d",customerId, userID, specieID, breedID, gender, "false", true)
    fetchRequest.returnsObjectsAsFaults = false
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    return commanArray
}


func updateADhAnimalBarcode(entity: String,officialID: String, barCode: String, pvID: Int, isADHSelected: Bool) { // official ID is AnimalTag
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    requestDel.predicate = NSPredicate(format: "animalTag == %@", officialID)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            let objTable = fetchedResult![0]
            objTable.setValue(barCode, forKey: "animalbarCodeTag")
            objTable.setValue(pvID, forKey: "providerId")
            objTable.setValue(isADHSelected, forKey: "isADHSelected")
            objTable.setValue("false", forKey: "status")
          
            do
            {
                try context.save()
            }
            catch {
            }
        }
    }
    catch {
    }
}

func deleteAddedAdhAnimalData(entity: String, officialID: String, barCode: String) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "animalTag == %@ AND animalbarCodeTag == %@", officialID, barCode)
    
    do {
        let results = try managedObjectContext.fetch(fetchRequest)
        for managedObject in results {
            
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedObjectContext.delete(managedObjectData)
        }
    }
    catch {
    }
}

func updateAdhAnimalDataforCart(entity: String, officialID: String, barCode: String,isADHCart: Bool ) {
  
  let appDelegate = UIApplication.shared.delegate as! AppDelegate
  let context = appDelegate.persistentContainer.viewContext
  let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
  requestDel.predicate = NSPredicate(format: "animalTag == %@ AND animalbarCodeTag == %@", officialID, barCode)
  requestDel.returnsObjectsAsFaults = false
    
    do {
      let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
       if fetchedResult!.count > 0 {
         let objTable = fetchedResult![0]
         objTable.setValue(isADHCart, forKey: "isADHCart")
         objTable.setValue(isADHCart, forKey: "isADHSelected")
       }
        
    }
    catch {
    }
}

func updateADhListToClearAllSelection(entity: String) { // official ID is AnimalTag
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
//    requestDel.predicate = NSPredicate(format: "animalTag == %@", officialID)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for item in fetchedResult! {
                item.setValue(false, forKey: "isADHSelected")
            }
            do
            {
                try context.save()
            }
            catch {
            }
        }
    }
    catch {
    }
}


func updateADhListToHideExpansion(entity: String) { // official ID is AnimalTag
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
    
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for item in fetchedResult! {
                item.setValue(false, forKey: "showTextField")
            }
            do
            {
                try context.save()
            }
            catch {
            }
        }
    }
    catch {
    }
}
func fetchAllSearchByAnimal(entityName: String,customerId:Int64) -> NSArray{
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest   =  NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "customerID == %d", customerId)
    fetchRequest.returnsObjectsAsFaults = false
    
    do{
        let fetchedResult = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
        if let results = fetchedResult{
            commanArray = results as NSArray
        }
    } catch {
    }
    
    return commanArray
}

func saveResultbysearchAnimalData(customerID: Int64,searchbyEarTag: Bool) {
    
    let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //adding new doc and saving in database...
    let content = NSEntityDescription.insertNewObject(forEntityName: "ResultbyAnimal", into: managedObjectContext)
    
    content.setValue(customerID, forKey: "customerID")
    content.setValue(searchbyEarTag, forKey: "searchbyEarTag")
    
    do {
        try managedObjectContext.save()
       
    } catch {
       
    }
}

func updateResultSearchByAnimal(entity: String,customerID: Int64, searchbyEarTag: Bool) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
  requestDel.predicate = NSPredicate(format: "customerID == %d", customerID)
    requestDel.returnsObjectsAsFaults = false
    
    do {
        let fetchedResult = try context.fetch(requestDel) as? [NSManagedObject]
        
        if fetchedResult!.count > 0 {
            for item in fetchedResult! {
                item.setValue(searchbyEarTag, forKey: "searchbyEarTag")
            }
            do
            {
                try context.save()
            }
            catch {
            }
        }
    }
    catch {
    }
}

//func removeDuplicacyfromAnimalMasterTable() {
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    let context = appDelegate.persistentContainer.viewContext
//    let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName:"AnimalMaster")
//    var resultsArr:[AnimalMaster] = []
//    do {
//        resultsArr = try (context.fetch(requestDel) as! [AnimalMaster])
//    } catch {
//        let fetchError = error as NSError
//        print(fetchError)
//    }
//
//    if resultsArr.count > 0 {
//        for x in resultsArr {
//            if x.animalTag == anima {
//                print("already exist")
//                mainManagedObjectContext.deleteObject(x)
//            }
//        }
//    }
//}
