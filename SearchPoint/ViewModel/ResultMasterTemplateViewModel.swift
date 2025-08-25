//
//  ResultMasterTemplateViewModel.swift
//  SearchPoint
//
//  Created by Mobile Programming on 18/05/21.
//

import Foundation
import Alamofire
import CoreData

class ResultMasterTemplateViewModel {
    
    var dependency:DashboardVC?
    var modalObject: resultmastermodel?
    var json = [String : Any]()
    var completion:()->()?
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    
    func callResultMasterTemplateApi() {
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url:Configuration.Dev(packet: ApiKeys.resultMastrTemplate.rawValue).getUrl() + "/" + "9EF36AD9-CF10-49E0-BD20-9740E2885E3B"))
    }
    
    func callResultMasterTemplate(dataModel: [String : Any])
    {
        
        let arr = dataModel["resultsMasterTemplates"]! as? NSArray
        let dict = arr?[0] as? NSDictionary
        let value = dict?["resultsView"] as? NSArray
        for i in 0...(value!.count-1) {
            let dict1 = value?[i] as? NSDictionary
            let productname = dict1?["name"]! as?  String ?? ""
            let species = dict1?["species"]! as?  String ?? ""
            let traitNameDict = dict1?["traitNames"] as?  [[String : Any]]
            let traitHeader = dict1?["traitHeaders"]! as?  [[String : Any]]
            let template = dict1?["template"]! as?   [[String : Any]]
            
            if traitNameDict == nil
            {
                return
            }
            for (traitNameIndex, traitNameValue) in traitNameDict!.enumerated() {
                let traitNameHeaderStr = traitNameValue["header"]! as?  String
                
                var traitName = ""
                
                let traitHeaderCurrentIndexxValue = traitHeader?[traitNameIndex] as? [String : Any]
                let traitHeaderCurrentIndexxValueArr = traitHeaderCurrentIndexxValue?["traitIds"] as? [[String : Any]]
                
                let traitNamesArr = traitNameValue["traitNames"] as? [[String : Any]]
                for (traitNameCurrentIndex, traitNameCurrentValue) in traitNamesArr!.enumerated() {
                    
                    
                    traitName = (traitNameCurrentValue["name"]! as?  String)!
                    
                    let traitidsCurrentIndexxValue = traitHeaderCurrentIndexxValueArr?[traitNameCurrentIndex] as? [String : Any]
                    let traitIdStr = traitidsCurrentIndexxValue?["traitId"] as? String
                    
                    saveTraitHeaderMaster(entity: Entities.resultTraitHeaderTblEntity,productName: productname,species: species ,headerName:traitNameHeaderStr!.capitalized ,headerId: traitName ,traidid: traitIdStr ?? "")
   
                }
            }
            
            for template in template!
            {
                let displayname = template["displayName"]! as?  String
                let attribute = template["attribute"]! as?  String
                let traitId = template["traitId"]! as?  String
                let location = template["location"]! as?  String
                let sortBy = template["sortBy"]! as?  Bool
                let defaultSortOrder = template["defaultSortOrder"]! as?  Int ?? 0
                let results = template["results"]! as?  Int
                let profile = template["profile"]! as?  String
                let indexes = template["indexes"]! as?  String
                let production = template["production"]! as?  String ?? ""
                let fertility = template["fertility"]! as?  String
                let wellness = template["wellness"]! as?  String
                let calving = template["calving"]! as?  String
                let type = template["type"]! as?  String
                let geneticConditions = template["geneticConditions"]! as?  String
                let milkProteins = template["milkProteins"]! as?  String
                let parentage = template["parentage"]! as?  String
                let photos = template["photos"]! as?  String
                let notes = template[keyValue.notes.rawValue]! as?  String
                let breedFilter = template["breedFilter"]! as? [String]
                
                saveMasterTemplate(entity: Entities.resultMasterTemplateTblEntity, notes: notes ?? "" , attributeName: attribute ?? "" , calving: calving ?? "" , defaultSortOrder: defaultSortOrder , displayName : displayname ?? "", fertility : fertility ?? "", geneticConditions : geneticConditions ?? "", indexes: indexes ?? "", location : location ?? "", milkProteins: milkProteins ?? "", parentage: parentage ?? "", photos: photos ?? "" , productName: productname , profile: profile ?? "", results: results ?? 0, sortBy:sortBy ?? false , speciesName: species , traitId: traitId ?? "", type: type ?? "", wellness: wellness ?? "",production: production,breedFilter: breedFilter ?? [""] )
      
            }

        }
    }
}

extension ResultMasterTemplateViewModel : ResponseDelegate {
    
    func responseRecieved(_ data: Data?, status: Bool) {
        if Connectivity.isConnectedToInternet() {
            
            if data == nil {
                self.completion()
                return
            }
         
            do{
                
                json = try (JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any])!
                
                
                self.callResultMasterTemplate(dataModel: json)
            }
            catch
            {
                
            }
            self.completion()
        }
        
    }
}
