//
//  ResulttotalanimalsViewModel.swift
//  SearchPoint
//
//  Created by Yamini Sunkara on 15/05/1400 AP.
//

import Foundation
import Alamofire
import CoreData

class Resulttotalanimalupdate
{
    var dependency:DashboardVC?
    var modalObject: ResultTotalanimalsModel?
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
    
    func callTotalanimalsApi()
    {
        
        let datetopass = (UserDefaults.standard.value(forKey: "fistindexdob") as? String)!
        let dateFormatter = DateFormatter()
         if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
             dateFormatter.dateFormat = DateFormatters.MMddyyyy0000Format
         } else {
             dateFormatter.dateFormat = DateFormatters.ddMMyyyy0000Format
         }
       //
        
        let  fromDaten = dateFormatter.date(from: datetopass)
        dateFormatter.dateFormat = "E,d MMM yyyy 00:00:00"
        var newdate = Date()
        if fromDaten == nil
        {
            
        }
        else
        {
         newdate = Calendar.current.date(byAdding: .day, value: 1, to: fromDaten!)!
        }
        
        
        let currentdate = dateFormatter.string(from: newdate)
       
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
       // let accessToken = appDelegate?.keychain_valueForKey(keyValue.accessToken.rawValue) as? String
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
       
        print(currentCustomerId ?? 0)
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url:Configuration.Dev(packet: ApiKeys.resulttotalanimals.rawValue + "/\(currentCustomerId ?? 0)" + "/\(currentdate)").getUrl()))
    }

func callSavetotalanimalsData(dataModel:ResultTotalanimalsModel)
{

  
    print(dataModel)
   // dependency?.totalanimalcount = dataModel.totalAnimals ?? 0
//    dependency?.collectionView.reloadData()
    UserDefaults.standard.setValue(dataModel.totalAnimals, forKey: keyValue.totalAnimalsCount.rawValue)
    
    if dataModel.totalAnimals ?? 0 >= 1
    {
        deleteRecordFromDatabase(entityName: Entities.resultMyherdDataTblEntity)
        deleteRecordFromDatabase(entityName: Entities.resultPageByTraitTblEntity)
        UserDefaults.standard.setValue(0, forKey: keyValue.pageNumber.rawValue)
    }
    
 
}
}

extension Resulttotalanimalupdate: ResponseDelegate
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
            
            print(modalObject ?? "")
            
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

