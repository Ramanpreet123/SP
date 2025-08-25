
//
//  AusNaabBullVM.swift
//  SearchPoint
//
//  Created by "" on 30/05/20.
//

import Foundation
import Alamofire
import CoreData

class AusNaabBullVM {
    
    var dependency:DashboardVC?
    var modalObject: AusNaabBullModel?
    
    var completion:()->()?
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    func callAusNaabBull() {
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url:Configuration.Dev(packet: ApiKeys.ausNaabBull.rawValue).getUrl()))
    }
    
    func saveGetAusNaabBullCode(dataModel: AusNaabBullModel){
        
        deleteRecordFromDatabase(entityName: Entities.ausNaabBullTblEntity)
        let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        for sample in dataModel.bulls {
            let saveObject : [String:Any] = [keyValue.sireNationalId.rawValue:sample.sireNationalID as Any, "sireName":sample.sireName as Any,"srcLine":sample.srcLine as Any,keyValue.bullID.rawValue:sample.bullID as Any,"lastUpdated":sample.lastUpdated as Any]
            
            let content = NSEntityDescription.insertNewObject(forEntityName: Entities.ausNaabBullTblEntity, into: managedObjectContext)
            content.setValuesForKeys(saveObject)
            
        }
        do {
            try managedObjectContext.save()
            
        } catch {
            
        }
        
    }
}

extension AusNaabBullVM: ResponseDelegate {
    
    func responseRecieved(_ data: Data?, status: Bool) {
        if Connectivity.isConnectedToInternet() {
            
            if data == nil {
                self.completion()
                return
            }
            let decoder = JSONDecoder()
            
            modalObject = try? decoder.decode(AusNaabBullModel.self, from: data!)
            
            
            DispatchQueue.main.async {
                if self.modalObject != nil {
                    self.saveGetAusNaabBullCode(dataModel: self.modalObject!)
                }
                self.completion()
            }
        }
        
    }
}
