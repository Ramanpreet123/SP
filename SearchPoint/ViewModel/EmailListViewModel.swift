//
//  EmailListViewModel.swift
//  SearchPoint
//
//  Created by Mobile Programming on 27/01/21.
//

import Foundation
import Alamofire
import CoreData

class EmailListViewModel {
    
    var dependency:DashboardVC?
    var modalObject: EmailListModel?
    
    var completion:()->()?
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    
    func callEmailList() {
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url:Configuration.Dev(packet: ApiKeys.emailMeList.rawValue).getUrl()))
    }
    
    func callemailListSave(){
       //needs removal
    }
}

extension EmailListViewModel: ResponseDelegate {
    
    func responseRecieved(_ data: Data?, status: Bool) {
        if Connectivity.isConnectedToInternet() {
            
            if data == nil {
                self.completion()
                return
            }
            let decoder = JSONDecoder()
            
            modalObject = try? decoder.decode(EmailListModel.self, from: data!)
            
            DispatchQueue.main.async {
                if self.modalObject != nil {
                    self.callemailListSave()
                }
                self.completion()
            }
        }
        
    }
}
