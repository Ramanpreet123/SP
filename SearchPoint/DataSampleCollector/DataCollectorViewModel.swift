//
//  DataCollectorViewModel.swift
//  SearchPoint
//
//  Created by Rajni Raswant on 02/06/22.
//

import Foundation
import MBProgressHUD
import Toast_Swift
import Alamofire
import CoreData

//MARK: DATA COLLECTOR VIEW MODEL
class DataCollectorViewModel {
    
    var dependency:DataCollectorVC?
    var modalObject:DataCollectorModel?
    var delegate:ResponseDataCollectorApi?
    var completion:()->()?
    init(ref:DataCollectorVC, callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
        saveData()
    }
    
    private func saveData(){
        let Network = NetworkManager()
        Network.delegate = self
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        Network.CallApi(packet: NetwrokPackets(Method: HTTPMethod.post,Headers: headerDict, bodyParams: getParams(), Url: Configuration.Dev(packet: ApiKeys.orderSampleCollector.rawValue).getUrl()))
    }
    
    private func getParams()->[String:Any]{
        let customerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
        let numberOfCollectors = dependency?.txtSampleCollector.text ?? ""
        let address = dependency?.txtaddress.text ?? ""
        let city = dependency?.txtCity.text ?? ""
        let zipCode = dependency?.txtZipCode.text ?? ""
        
        return [keyValue.customerId.rawValue:"\(customerId ?? 0)",
                "numberOfCollectors":Int(numberOfCollectors)!,
                "address":address,
                "city": city,
                "zipCode": zipCode]
    }
}

extension DataCollectorViewModel: ResponseDelegate {
    func responseRecieved(_ data: Data?, status: Bool) {
        if status == false {
            delegate?.responseRecievedStatus(status: status)
        } else {
            let decoder = JSONDecoder()
            modalObject = try! decoder.decode(DataCollectorModel.self, from: data!)
            DispatchQueue.main.async {
                self.completion()
            }
        }
    }
}
