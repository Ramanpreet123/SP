//
//  GetBreedViewModel.swift
//  SearchPoint
//
//  Created by "" on 10/10/2019.
//  ""
//

import Foundation
import Alamofire
import CoreData

class GetBreedViewModel{
    
    var dependency:DashboardVC?
    var modalObject:GetBreedsModel?
    
    var completion:()->()?
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    
    func callGetBreeds(){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url:         Configuration.Dev(packet: ApiKeys.getBreeds.rawValue).getUrl()))
    }
    
    func saveGetBreedsData(dataModel:GetBreedsModel){
        
        deleteRecordFromDatabase(entityName: Entities.getBreedsTblEntity)
        
        for breedArray in dataModel.breeds{
            
            for productN in breedArray.productIDS {
//                var bredName = breedArray.alpha3
//                if bredName == ""{
//                    bredName = breedArray.name
//                }
                var bredName = String()
                let bredNameAlpha3 = breedArray.alpha3
                let bredNameAlpha2 = breedArray.alpha2
                let bredNameAbbrev = breedArray.abbrev
                let bredFullName = breedArray.name
                if UIDevice().userInterfaceIdiom == .phone {
                    if bredNameAlpha3 != ""{
                        bredName = breedArray.alpha3 ?? ""
                    } else if bredNameAlpha2 != "" {
                        bredName = breedArray.alpha2 ?? ""
                    }
                    else if bredNameAbbrev != "" {
                        bredName = breedArray.abbrev ?? ""
                    }
                    else {
                        bredName = breedArray.name ?? ""
                    }
                } else {
                    bredName = breedArray.name ?? ""
                }
               
                var saveObject : [String:Any] = [keyValue.breedId.rawValue:breedArray.breedID as Any , keyValue.capsBreedName.rawValue:breedArray.name as Any ,keyValue.alpha2.rawValue: breedArray.alpha2 as Any,keyValue.threeCharCode.rawValue:bredName as Any,"abbrev":"","isdefault" :breedArray.isDefault as Any,"speciesId":breedArray.speciesID as Any,"speciesName":breedArray.species as Any,"provideName" :productN.provider as Any, keyValue.providerId.rawValue:productN.providerID as Any,"breedCode":"","productId":productN.productID as Any
                                                 , "market": productN.market as Any,"marketId":productN.marketID as Any,"lastUpdated":breedArray.lastUpdated as Any]
                
                
                if breedArray.species == marketNameType.Dairy.rawValue {
                    let data = fetchBreedProvideDataUnique(entityName: Entities.getBreedsTblEntity, provId: productN.providerID ?? 0, breedId: breedArray.breedID ?? "")
                    
                    if data.count == 0 {
                        
                        insert(entity: Entities.getBreedsTblEntity, attributeKey: nil, objectToSave: saveObject)
                        
                    }
                } else {
                    let data = fetchBreedProvideDataUnique(entityName: Entities.getBreedsTblEntity, provId: productN.providerID ?? 0, breedId: breedArray.breedID ?? "", productId:productN.productID )
                    
                    if data.count == 0 {
                        
                        if breedArray.alpha3!.isEmpty  && breedArray.breedID == "87c30632-8da0-4f86-8d94-46da17c520dd"  {
                            saveObject[keyValue.threeCharCode.rawValue] = breedArray.name
                        }
                        
                        insert(entity: Entities.getBreedsTblEntity, attributeKey: nil, objectToSave: saveObject)
                        
                    }
                }
            }
        }
    }
}
extension GetBreedViewModel: ResponseDelegate {
    
    func responseRecieved(_ data: Data?, status: Bool) {
        if data == nil {
            self.completion()
        }else {
            let decoder = JSONDecoder()
            modalObject = try! decoder.decode(GetBreedsModel.self, from: data!)
            DispatchQueue.main.async {
                
                if self.modalObject != nil {
                    self.saveGetBreedsData(dataModel: self.modalObject!)
                }
                
                self.completion()
            }
        }
    }
}
