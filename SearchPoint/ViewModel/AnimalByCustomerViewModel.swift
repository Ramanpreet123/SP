//
//  AnimalByCustomerViewModel.swift
//  SearchPoint
//
//  Created by "" 13/06/20.
//

import Foundation
import Alamofire
import CoreData

class AnimalByCustomerViewModel {
    
    var dependency:DashboardVC?
    var modalObject: AnimalByCustomer?
    
    var completion:()->()?
    
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    init(callBack:@escaping ()->()) {
          completion = callBack
      }
    func callServer(start: Int, count: Int){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        if let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int {
            Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url: Configuration.Dev(packet: ApiKeys.animalByCustomer.rawValue + "/\(currentCustomerId)" + "/\(start)" + "/\(count)").getUrl()))
            print(Configuration.Dev(packet: ApiKeys.animalByCustomer.rawValue + "/\(currentCustomerId)" + "/\(start)" + "/\(count)").getUrl())
            
        }
        
    }
    
    func saveAnimalsCodeData(dataModel: AnimalByCustomer){
     
        
        let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        UserDefaults.standard.set(dataModel.totalAnimals, forKey:keyValue.countAnimal.rawValue)

        for animal in dataModel.animals {
            var animalID1 = UserDefaults.standard.integer(forKey: keyValue.animalId.rawValue)
            if animalID1 == 0 {
                animalID1 = animalID1 + 1
                UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                
            }
            else {
                animalID1 = animalID1 + 1
                UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
            }
            
            var timeStamp = String()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DateFormatters.yyyyMMddTHHmmssFormat
            dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
            let date =  dateFormatter.date(from: animal.dob ?? "")// create date from string
          
            if date == nil {
                
            } else {
                
                dateFormatter.dateFormat = DateFormatters.ddMMyyyyFormat
                dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
                timeStamp = dateFormatter.string(from: date!)
             
            }

            let damID = animal.damID
            let sireID = animal.sireID
            var breedName = animal.breed
            var breedId = animal.breedID
            
            if breedName == ""{
            } else {
                breedName = animal.breed
                breedId = animal.breedID
            }
            
            

            if (animal.onFarmID == "" && animal.officialID == "")  {
                
            } else {
            
                let saveObject : [String:Any] = ["animalTag":animal.officialID?.uppercased() ?? "", "animalbarCodeTag":"",keyValue.date.rawValue:timeStamp ,"offDamId": damID?.uppercased() ?? "","offsireId":sireID?.uppercased() ?? "","gender":animal.sex ?? "","status":"true","offPermanentId":"","tissuName":  ButtonTitles.allflexTSUText,keyValue.capsBreedName.rawValue:breedName ?? "","eT":animal.mbc ?? "",keyValue.capsFarmId.rawValue:animal.onFarmID?.uppercased() ?? "",keyValue.orderId.rawValue:0,"orderstatus":"false",keyValue.breedId.rawValue:breedId ?? "","isSync":"false",keyValue.providerId.rawValue:-100 ,"tissuId":1,"sireIDAU":animal.sireNAAB ?? "","nationHerdAU":"",keyValue.userId.rawValue:UserDefaults.standard.integer(forKey: keyValue.userId.rawValue),"udid" :"",keyValue.animalId.rawValue:animalID1,"selectedBornTypeId" :animal.bornTypeID as Any ,"custmerId":UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),"specisType":animal.speciesID ?? "",keyValue.earTagKey.rawValue: animal.earTag ?? "","breedRegNumber":animal.breedRegistrationNumber as Any,"adhDataServer":true,"isSyncServer":true, "isHausaHerdBook": animal.isHausaHerdBook as Any]
                
                let content = NSEntityDescription.insertNewObject(forEntityName: Entities.animalMasterTblEntity, into: managedObjectContext)
                content.setValuesForKeys(saveObject)
            }
            
        }
        do {
                   try managedObjectContext.save()
                  
               } catch {
                   
               }
        
    }
    
    func getOrderDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ss"
        let date = dateFormatter.date(from: date) //?? Date()
        
        dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
        
        return dateFormatter.string(from: date!)
    }
}


extension AnimalByCustomerViewModel: ResponseDelegate {
    func responseRecieved(_ data: Data?, status: Bool) {
        
        if data == nil {
            self.completion()
            return
        }
        let decoder = JSONDecoder()
        modalObject = try? decoder.decode(AnimalByCustomer.self, from: data!)
        
        DispatchQueue.main.async {
            
            if self.modalObject != nil {
                self.saveAnimalsCodeData(dataModel: self.modalObject!)
            }
            
            self.completion()
        }
    }
}

