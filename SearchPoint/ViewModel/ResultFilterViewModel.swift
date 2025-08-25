import Foundation
import Alamofire
import CoreData

class ResultFilterViewModel{
    
    var dependency:DashboardVC?
    var dependency1:CustomersListController?
    var modalObject: ResultFilterModel?
    let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
    var completion:()->()?
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    init(ref:CustomersListController,callBack:@escaping ()->()) {
        dependency1 = ref
        completion = callBack
    }
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    
    func callSaveListApi() {
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let activeCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        
        
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url:Configuration.Dev(packet: ApiKeys.resultfilter.rawValue + "/\(activeCustomerId ?? 0)").getUrl()))
    }
    
    func callSaveResultData(dataModel: ResultFilterModel){
        
        UserDefaults.standard.set(dataModel.totalAnimals, forKey: keyValue.filterTotalAnimalAccount.rawValue)
        UserDefaults.standard.set(dataModel.oldest, forKey: keyValue.filterMinDOB.rawValue)
        UserDefaults.standard.set(dataModel.youngest, forKey: keyValue.filterMaxDOB.rawValue)
        
        for animals in dataModel.providers
        {
            
            for breed in animals.breeds
            {
                
                savefilterApiData(entity: Entities.resultFilterDataTblEntity, customerId: dataModel.customerID, customerName: dataModel.customerName, providerId: animals.providerID, providerName: animals.providerName, breedId: breed.breedID, breedName: breed.breed)
                
            }
        }
    }
}

extension ResultFilterViewModel: ResponseDelegate
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
            
            modalObject = try? decoder.decode(ResultFilterModel.self, from: data!)
            
            
            
            DispatchQueue.main.async {
                if self.modalObject != nil
                {
                    self.callSaveResultData(dataModel: self.modalObject!)
                }
                self.completion()
            }
        }
        
    }
}
