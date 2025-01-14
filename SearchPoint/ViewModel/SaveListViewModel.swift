//
//  SaveListViewModel.swift
//  SearchPoint
//
//  Created by Mobile Programming on 27/01/21.
//

//import Foundation
//import Alamofire
//import CoreData
//
//class SaveListViewModel {
//    
//    var dependency:DashboardVC?
//    var modalObject: SaveListModel?
//    
//    var completion:()->()?
//    init(ref:DashboardVC,callBack:@escaping ()->()) {
//        dependency = ref
//        completion = callBack
//    }
//   
//    init(callBack:@escaping ()->()) {
//          completion = callBack
//     }
//    
//    func callSaveList() {
//        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
//        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + accessToken!]
//        let Network = NetworkManager()
//        Network.delegate = self
//
//        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.post, Headers: headerDict, bodyParams: nil, Url:Configuration.Dev(packet: ApiKeys.saveList.rawValue).getUrl()))
//    }
//    
//    func saveListGet(dataModel: SaveListModel){
//  
//
//
//        
//    }
//}
//
//extension SaveListViewModel: ResponseDelegate {
//    
//    func responseRecieved(_ data: Data?, status: Bool) {
//        if Connectivity.isConnectedToInternet() {
//            
//            if data == nil {
//                self.completion()
//                return
//            }
//            let decoder = JSONDecoder()
//            
//            modalObject = try? decoder.decode(SaveListModel.self, from: data!)
//           
//            
//            DispatchQueue.main.async {
//                if self.modalObject != nil {
//                    self.saveListGet(dataModel: self.modalObject!)
//                }
//                self.completion()
//            }
//        }
//        
//    }
//}
