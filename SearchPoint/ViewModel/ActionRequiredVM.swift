//
//  GetBillingViewModel.swift
//  SearchPoint
//
//  Created by "" on 09/12/19.

import Foundation
import Alamofire
import CoreData

class ActionRequiredVM {
    
    var dependency:DashboardVC?
    var modalObject:ActionRequiredModel?
    
    var completion:()->()?
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    
    
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    
    
    func callNineteyDaysApi(days:Int){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams:nil, Url:Configuration.Dev(packet: ApiKeys.actionRequiredDays.rawValue).getUrl() + "/" + String(days))) ///"/90"))
    }
    func getOrderDate(date: String) -> Date {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = DateFormatters.yyyyMMddTHHmmssFormat
        let date = dateFormatter.date(from: date) ?? Date()
        
        dateFormatter.dateFormat = DateFormatters.yyyyMMddFormat
        //dateFormatter.timeZone = NSTimeZone.local
        let timeStamp = dateFormatter.string(from: date)
       
        
        dateFormatter.dateFormat = DateFormatters.yyyyMMddFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let datefinal = dateFormatter.date(from: timeStamp) ?? Date()
       
        
        return datefinal
    }
    
    func saveGetActionRequireNinetyDays(dataModel:ActionRequiredModel){
    
        
        let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        deleteRecordFromDatabase(entityName: Entities.getActionRequiredTblEntity)
        
        for action in dataModel.conflicts {
            
            let orderedDate = getOrderDate(date: action.orderedDate ?? "")
          

            
            var actionRequired = ""
            for act in action.actionRequired{
                actionRequired += (act.action ?? "")
            }
            
            ///DEV
            let saveObject : [String:Any] = ["conflictsCount":dataModel.conflictsCount as Any, "pastDays":dataModel.pastDays as Any,keyValue.customerId.rawValue:action.customerID as Any,"customerName":action.customerName as Any,keyValue.earTagKey.rawValue:action.earTag as Any,"offcialPermanenetId":action.officialPermanentID as Any,keyValue.smallOfficialTag.rawValue:action.officialTag as Any,"onFarmId":action.onFarmID as Any,LocalizedStrings.orderedDateStr:orderedDate,keyValue.orderId.rawValue:action.orderID as Any,"product":action.product as Any,"receivedDate":action.receivedDate as Any,"reportedDate":action.reportedDate as Any,keyValue.smallSampleBarcode.rawValue:action.sampleBarCode as Any,"sampleStatus":action.sampleStatus as Any,"actionRequired": actionRequired, "species":action.species as Any , "speciesID":action.speciesID as Any]


            let contentGetActionRequired = NSEntityDescription.insertNewObject(forEntityName: Entities.getActionRequiredTblEntity, into: managedObjectContext)
            contentGetActionRequired.setValuesForKeys(saveObject)
        }
        
        do {
            try managedObjectContext.save()
           
        } catch {
           
        }
        
        
        //GetActionRequired
    }
}

extension ActionRequiredVM: ResponseDelegate {
    
    func responseRecieved(_ data: Data?, status: Bool) {
        if Connectivity.isConnectedToInternet() {
            
            if data == nil {
                self.completion()
                return
            }
            let decoder = JSONDecoder()
            
            modalObject = try? decoder.decode(ActionRequiredModel.self, from: data!)
          
            
            DispatchQueue.main.async {
                //     deleteRecordFromDatabase(entityName: Entities.getActionRequiredTblEntity)
                if self.modalObject != nil {
                    self.saveGetActionRequireNinetyDays(dataModel: self.modalObject!)
                }
                self.completion()
            }
        }
        
    }
}
