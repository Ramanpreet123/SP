//
//  GetNaabCodeVM.swift
//  SearchPoint
//
//  Created by "" on 05/03/20.
//

import Foundation
import Alamofire
import CoreData

class GetNaabCodeVM{
    
    var dependency:DashboardVC?
    var modalObject: GetNaabCodeModel?
    
    var completion:()->()?
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    func callGetNaabCode(){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url: Configuration.Dev(packet: ApiKeys.naabCodes.rawValue).getUrl()))
    }
    
    
    
    func saveGetNAABData(dataModel: GetNaabCodeModel){
        deleteRecordFromDatabase(entityName: Entities.getNaabCodeTblEntity)
        let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        for item in dataModel.naabCodes {
            let saveObject : [String:Any] = ["naabCode":item.naabCode as Any, "animalId":item.animalID as Any,"lastUpdated":item.lastUpdated as Any]
            let content = NSEntityDescription.insertNewObject(forEntityName: Entities.getNaabCodeTblEntity, into: managedObjectContext)
            content.setValuesForKeys(saveObject)
        }
        
        do {
            try managedObjectContext.save()
            
        } catch {
            
        }
    }
}

extension GetNaabCodeVM: ResponseDelegate {
    func responseRecieved(_ data: Data?, status: Bool) {
        if data == nil {
            self.completion()
            return
        }
        let decoder = JSONDecoder()
        modalObject = try! decoder.decode(GetNaabCodeModel.self, from: data!)
        DispatchQueue.main.async {
            
            if self.modalObject != nil {
                self.saveGetNAABData(dataModel: self.modalObject!)
            }
            
            self.completion()
        }
    }
}
