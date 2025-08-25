//
//  OrderDetailByOrderIdVM.swift
//  SearchPoint
//
//  Created by "" on 16/05/20.
//

import Foundation
import Alamofire
import CoreData

class OrderDetailsByDatesVM {
    
    var dependency:DashboardVC?
    var modalObject:OrderDetailByPastDaysModel?
    var completion:()->()?
    
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    
    func saveGetOrderDetailByDatesDays(dataModel:OrderDetailByPastDaysModel){
        
        for item in dataModel.orders{
            
            for sampl in item.samples{
                let saveObject : [String:Any] = ["breedRegNumber" : "","custId":item.customerID as Any,"customerName":item.customerName as Any,keyValue.earTagKey.rawValue:"","latestSampleRecDate":item.latestSampleReceivedDate as Any,"officialId":sampl.officialID as Any,keyValue.smallOfficialTag.rawValue:sampl.officialID as Any,"onFarmId":sampl.onFarmID as Any,"orderCount":dataModel.orderCount as Any,LocalizedStrings.orderedDateStr:item.orderedDate,keyValue.orderId.rawValue:item.orderID,"productName":sampl.productName as Any,"receivedDate":sampl.receivedDate as Any,"reportedDate":sampl.reportedDate as Any,keyValue.smallSampleBarcode.rawValue:sampl.sampleBarCode as Any,"sampleCount":item.sampleCount as Any,"sampleStaus":""]
                
                insert(entity: Entities.productResponseTblEntity, attributeKey: nil, objectToSave: saveObject)
            }
        }
    }
}

extension OrderDetailsByDatesVM: ResponseDelegate {
    
    func responseRecieved(_ data: Data?, status: Bool) {
        if Connectivity.isConnectedToInternet() {
            
            if data == nil {
                self.completion()
                return
            }
            let decoder = JSONDecoder()
            
            modalObject = try? decoder.decode(OrderDetailByPastDaysModel.self, from: data!)
            
            DispatchQueue.main.async {
                deleteRecordFromDatabase(entityName: Entities.productResponseTblEntity)
                
                self.saveGetOrderDetailByDatesDays(dataModel: self.modalObject!)
                self.completion()
            }
        }
        
    }
}
