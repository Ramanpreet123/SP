//
//  GetProductsViewModel.swift
//  SearchPoint
//
//  Created by "" on 10/10/2019.
//  ""
//

import Foundation
import Alamofire
import CoreData

class GetProductsViewModel{
    
    var dependency:DashboardVC?
    var modalObject:GetProductsModel?
    var completion:()->()?
    
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    func callGetProducts(){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url: Configuration.Dev(packet: ApiKeys.getProducts.rawValue).getUrl()))
    }
    
    func saveGetProductData(dataModel: GetProductsModel){
        
        deleteRecordFromDatabase(entityName: Entities.getProductTblEntity)
        deleteRecordFromDatabase(entityName: Entities.getAdonTblEntity)
        deleteRecordFromDatabase(entityName: "GetAddOnInfo")
        
        for item in dataModel.products {
            var addOnStatus = false
            var addOnNames = [String]()
            for i in item.addOns {
                if i.isIncludedInProduct ?? false {
                    addOnStatus = true
                    addOnNames.append(i.addOn ?? "")
                }
            }
            let addOnStr = addOnNames.joined(separator: ", ")
            if item.species == marketNameType.Beef.rawValue {
                
                let saveObject : [String:Any] = [keyValue.providerId.rawValue:item.providerID as Any,"providerName":item.provider as Any,"speciesId":item.speciesID as Any,"speciesName":item.species as Any,"marketId":item.marketID as Any,keyValue.marketName.rawValue:item.market as Any,"productId":item.productID as Any, "productName":item.product as Any,"isDefault":item.isDefault as Any, keyValue.breedId.rawValue: "-1", "orderAcceptTerms": item.orderAcceptTerms as Any, "pricing": "$100",keyValue.capsBreedName.rawValue:"","lastUpdated":item.lastUpdated as Any,"isCdcbProduct":item.isCdcbProduct as Any,"productDescription":item.productDescription as Any, "addOnStatus": addOnStatus , "addOnNames" : addOnStr]
                
                insert(entity: Entities.getProductTblEntity, attributeKey: nil, objectToSave: saveObject)
                
            } else {
                for breed in item.breeds {
                    let saveObject : [String:Any] = [keyValue.providerId.rawValue:item.providerID as Any,"providerName":item.provider as Any,"speciesId":item.speciesID as Any,"speciesName":item.species as Any,"marketId":item.marketID as Any,keyValue.marketName.rawValue:item.market as Any,"productId":item.productID as Any, "productName":item.product as Any,"isDefault":item.isDefault as Any, keyValue.breedId.rawValue: breed.breedID as Any, "orderAcceptTerms": item.orderAcceptTerms as Any, "pricing": "$100",keyValue.capsBreedName.rawValue:breed.breed as Any,"lastUpdated":item.lastUpdated as Any,"isCdcbProduct":item.isCdcbProduct as Any,"productDescription":item.productDescription as Any, "addOnStatus": addOnStatus ,  "addOnNames" : addOnStr]
                    
                    insert(entity: Entities.getProductTblEntity, attributeKey: nil, objectToSave: saveObject)
                }
            }
            
            for market in item.markets {
                
                let saveObject : [String:Any] = ["isDefault":item.isDefault as Any , "marketsId":market.marketsId as Any ,keyValue.marketName.rawValue:market.marketName as Any ,"productId":item.productID as Any,"provider":item.provider as Any,keyValue.providerId.rawValue:item.providerID as Any,"speciesId":item.speciesID as Any,"product":item.product as Any]
                insert(entity: Entities.newMarketNameTblEntity, attributeKey: nil, objectToSave: saveObject)
                
            }
            
            for addon in item.addOns {
                
                if addon.isIncludedInProduct == true {
                    
                    
                } else {
                    
                    let addonInfoArray = addon.info
                    var adonInfoEnglish = String()
                    var adonInfoPortiguess = String()
                    var adonInfoItalian = String()
                    
                    for infoArray in addonInfoArray {
                        switch infoArray.language {
                        case "EN":
                            adonInfoEnglish = infoArray.value
                        case "IT" :
                            adonInfoItalian = infoArray.value
                        default:
                            adonInfoPortiguess = infoArray.value
                        }
                    }
                    let saveObject : [String:Any] = ["productId": item.productID as Any , "adonName": addon.addOn as Any,"adonId": addon.addOnID as Any,"isIncludedInProduct":addon.isIncludedInProduct as Any,"lastUpdated":addon.lastUpdated as Any,"isCdcbProduct":addon.isCdcbProduct as Any, keyValue.textValueEnglish.rawValue:adonInfoEnglish ,keyValue.textValuePortugese.rawValue: adonInfoPortiguess ,keyValue.textValueItalian.rawValue: adonInfoItalian]
                    insert(entity: Entities.getAdonTblEntity, attributeKey: nil, objectToSave: saveObject)
                    
                }
            }
        }
    }
}

extension GetProductsViewModel: ResponseDelegate {
    
    func responseRecieved(_ data: Data?, status: Bool) {
        if data == nil {
            self.completion()
            return
        }
        let decoder = JSONDecoder()
        modalObject = try! decoder.decode(GetProductsModel.self, from: data!)
        DispatchQueue.main.async {
            
            if self.modalObject != nil {
                self.saveGetProductData(dataModel: self.modalObject!)
            }
            
            self.completion()
        }
    }
}
