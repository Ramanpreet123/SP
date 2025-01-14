//
//  ResulttotalanimalsViewModel.swift
//  SearchPoint
//
//  Created by Yamini Sunkara on 15/05/1400 AP.
//

import Foundation
import Alamofire
import CoreData

class ResulttotalanimalsViewModel
{
    var dependency:DashboardVC?
    var modalObject: ResultTotalanimalsModel?
    var completion:()->()?
    var pageNumberIncrese = Int()
    let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveMarketId.rawValue) as? Int

    init(ref:DashboardVC,callBack:@escaping ()->()) {
        
        dependency = ref
        completion = callBack
    }
   
    init(callBack:@escaping ()->()) {
          completion = callBack
     }
    
    func callTotalanimalsApi()
    {
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
       // let accessToken = appDelegate?.keychain_valueForKey(keyValue.accessToken.rawValue) as? String
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url:Configuration.Dev(packet: ApiKeys.resulttotalanimals.rawValue + "/\(currentCustomerId ?? 0)").getUrl()))
    }

func callSavetotalanimalsData(dataModel:ResultTotalanimalsModel)
{

   // dependency?.totalanimalcount = dataModel.totalAnimals ?? 0
//    dependency?.collectionView.reloadData()
    UserDefaults.standard.setValue(dataModel.totalAnimals, forKey: keyValue.totalAnimalsCount.rawValue)
    
 
}
}

extension ResulttotalanimalsViewModel: ResponseDelegate
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
            
            modalObject = try? decoder.decode( ResultTotalanimalsModel.self, from: data!)
            
           
            
            DispatchQueue.main.async {
                if self.modalObject != nil
                {
                    
                    self.callSavetotalanimalsData(dataModel: self.modalObject!)
                }
                self.completion()
            }
        }
        
    }
}

