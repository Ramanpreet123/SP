//
//  OrderDetailByOrderIdVM.swift
//  SearchPoint
//
//  Created by "" on 16/05/20.
//

import Foundation
import Alamofire
import CoreData

class OrderDetailByPastDaysVM {
    
    var dependency:DashboardVC?
    var modalObject:OrderDetailByPastDaysModel?
    var completion:()->()?
    
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    
    func callOrderDetailByPastApi(days: String){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url:Configuration.Dev(packet: ApiKeys.ordersbypastdays.rawValue).getUrl() + "/" + days))
    }
    
    func getOrderDate(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatters.yyyyMMddTHHmmssFormat
        let date = dateFormatter.date(from: date) ?? Date()
        dateFormatter.dateFormat = DateFormatters.yyyyMMddFormat
        let timeStamp = dateFormatter.string(from: date)
        dateFormatter.dateFormat = DateFormatters.yyyyMMddFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let datefinal = dateFormatter.date(from: timeStamp) ?? Date()
        return datefinal
    }
    
    
    func saveGetOrderDetailByPastDays(dataModel:OrderDetailByPastDaysModel){
        let managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        deleteRecordFromDatabase(entityName: Entities.sampleOrdersTblEntity)
        deleteRecordFromDatabase(entityName: Entities.sampleTblEntity)
        deleteRecordFromDatabase(entityName: Entities.sampleDetailsTblEntity)
        
        
        for item in dataModel.orders {
            
            let orderedDate = getOrderDate(date: item.orderedDate)
            
            var saveObject : [String:Any] = [keyValue.customerId.rawValue:item.customerID as Any,"customerName":item.customerName as Any,"latestSampleRecDate":item.latestSampleReceivedDate as Any,LocalizedStrings.orderedDateStr:orderedDate, keyValue.orderId.rawValue:item.orderID,"reportedDate":item.reportedDate ?? "","sampleCount":item.sampleCount as Any, "status": item.status as Any]
            
            
            var onFarmID = ""
            var barcode = ""
            var earTag = ""
            var officialTag = ""
            var productsName = ""
            var species = ""
            var officialId = ""
            var sampleStatus = ""
            for sample in item.samples {
                
                onFarmID += " " + (sample.onFarmID ?? "")
                barcode += " " + (sample.sampleBarCode ?? "")
                earTag += " " + (sample.earTag ?? "")
                officialTag += " " + (sample.officialTag ?? "")
                species = sample.species ?? ""
                officialId += " " + (sample.officialID ?? "")
                for sampleDetails in sample.sampleDetails {
                    productsName += " " + (sampleDetails.productName ?? "")
                    sampleStatus += " " + (sampleDetails.status ?? "")
                    
                }
            }
            
            saveObject["onFarmId"] = onFarmID
            saveObject[keyValue.smallSampleBarcode.rawValue] = barcode
            saveObject["earTag"] = earTag
            saveObject[keyValue.smallOfficialTag.rawValue] = officialTag
            saveObject["productName"] = productsName
            saveObject["species"] = species
            saveObject["officialId"] = officialId
            saveObject["sampleStatus"] = sampleStatus
            
            let contentSampleOrders = NSEntityDescription.insertNewObject(forEntityName: Entities.sampleOrdersTblEntity, into: managedObjectContext)
            contentSampleOrders.setValuesForKeys(saveObject)
            
            
            
            for (index, sample) in item.samples.enumerated() {
                
                var productsName = ""
                for sampleDetails in sample.sampleDetails {
                    productsName += " " + sampleDetails.productName!
                }
                let sampleObject : [String:Any] = ["breedRegNumber":sample.breedRegNumber ?? "","earTag":sample.earTag as Any,"officalTag":sample.officialTag as Any,"officialId":sample.officialID as Any,keyValue.orderId.rawValue:item.orderID,"onFarmId":sample.onFarmID as Any ,"productName": productsName, "recivedDate":sample.receivedDate as Any, "reportedDate":sample.reportedDate ?? "", keyValue.smallSampleBarcode.rawValue:sample.sampleBarCode as Any, "sampleStatus":sample.sampleStatus as Any, "sampleStatusId": "\(sample.sampleStatusID)", "speciesID":sample.speciesID as Any, "species":sample.species as Any, keyValue.sampleId.rawValue: index]
                
                let contentSamples = NSEntityDescription.insertNewObject(forEntityName: Entities.sampleTblEntity, into: managedObjectContext)
                contentSamples.setValuesForKeys(sampleObject)
                
                for sampleDetails in sample.sampleDetails {
                    let sampleDetailsObject : [String:Any] = ["actionRequired": sampleDetails.actionRequired as Any, keyValue.orderId.rawValue: item.orderID, "productName": sampleDetails.productName as Any ,"reportedDate": sampleDetails.reportedDate ?? "", keyValue.sampleId.rawValue: index, "status": sampleDetails.status as Any]
                    
                    let contentSampleDetails = NSEntityDescription.insertNewObject(forEntityName: Entities.sampleDetailsTblEntity, into: managedObjectContext)
                    contentSampleDetails.setValuesForKeys(sampleDetailsObject)
                }
            }
        }
        
        do {
            try managedObjectContext.save()
            
        } catch {
            
        }
    }
}

extension OrderDetailByPastDaysVM: ResponseDelegate {
    
    func responseRecieved(_ data: Data?, status: Bool) {
        if Connectivity.isConnectedToInternet() {
            
            if data == nil {
                self.completion()
                return
            }
            let decoder = JSONDecoder()
            
            modalObject = try? decoder.decode(OrderDetailByPastDaysModel.self, from: data!)
            
            
            DispatchQueue.main.async {
                if self.modalObject != nil {
                    self.saveGetOrderDetailByPastDays(dataModel: self.modalObject!)
                }
                self.completion()
            }
        } else {
            self.completion()
        }
        
    }
}
