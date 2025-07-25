//
//  Translationslanguageviewmodel.swift
//  SearchPoint
//
//  Created by Yamini Sunkara on 12/1/21.
//
import Foundation
import Alamofire
import CoreData

class Translationslanguageviewmodel
{
    var dependency:DashboardVC?
    var modalObject: TranslationslanguageModel?
    var completion:()->()?
    var pageNumberIncrese = Int()
    let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
    
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        
        dependency = ref
        completion = callBack
    }
    
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    func callTranslationslanguageApi()
    {
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        let market = "BR"
        
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url:Configuration.Dev(packet: ApiKeys.transulation.rawValue + "\(market)").getUrl()))
        
        print(Configuration.Dev(packet: ApiKeys.transulation.rawValue + "\(market)").getUrl())
    }
    func callSaveTranslationslanguageData(dataModel:TranslationslanguageModel)
    {
        
        let data = TranslationslanguageResponse()
        data.tranlation = dataModel.translations
        print(dataModel)
        languagedata.tranlation = dataModel.translations
        
        //        var userDefaults = UserDefaults.standard
        //        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: dataModel)
        //        userDefaults.set(encodedData, forKey: "Translationslanguage")
        //        userDefaults.synchronize()
        
    }
}
extension Translationslanguageviewmodel: ResponseDelegate
{
    func responseRecieved(_ data: Data?, status: Bool)
    {
        
        if Connectivity.isConnectedToInternet()
        {
            
            if data == nil
            {
                self.completion()
                return
            }
            let decoder = JSONDecoder()
            
            modalObject = try? decoder.decode( TranslationslanguageModel.self, from: data!)
            
            print(modalObject ?? "")
            
            DispatchQueue.main.async {
                if self.modalObject != nil
                {
                    
                    self.callSaveTranslationslanguageData(dataModel: self.modalObject!)
                }
                self.completion()
            }
        }
        
    }
}

var languagedata = TranslationslanguageResponse()

