//
//  ResulyByPageViewModel.swift
//  SearchPoint
//
//  Created by Mobile Programming on 21/05/21.
//
import Foundation
import Alamofire
import CoreData
import MBProgressHUD

var dummyArray = [ResulyByPageModel]()
class ResulyByPageViewModel {
    
    var timer = Timer()
    var checkfirsttime = false
    var progress : Double = 0
    var dependency:DashboardVC?
    var myfliter:MyHerdFilterController?
    var myherdresult: MyHerdResultsViewController?
    var myherdresultVC: MyHerdResultsVCiPad?
    var modalObject: ResulyByPageModel?
    var completion:()->()?
    var pageNumberIncrese = Int()
    var providerIndexPath = Int64()
    var sex = String()
    var searchByanimal = Bool()
    var dateto = String()
    var searchText = String()
    var searchType = String()
    var delegate : ResultFoundDelegate?
    
    var datefrom = String()
    var sortorder = Bool()
    var headerstring = String()
    var traidstting = String()
    var resultBreedIb = String()
    let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
    
    var countObjectPercentage = 0
    
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
        
    }
    
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    
    func callResultByAnimalApi(searchText:String, searchType: String) {
        searchByanimal = true
        self.searchText = searchText
        self.searchType = searchType
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.post,Headers: headerDict, bodyParams: getParamsforAnimalResult(), Url: Configuration.Dev(packet: ApiKeys.resultsByEarTagOrOfficial.rawValue).getUrl()))
        
        print(Configuration.Dev(packet: ApiKeys.resultsByEarTagOrOfficial.rawValue).getUrl())
    }
    func callResultByPageAnimalApi() {
        searchByanimal = false
        let pageNY = fetchResultMyHerdData(entityName: Entities.resultMasterPageNumberTblEntity,customerId: Int64(currentCustomerId ?? 0))
        print(pageNY)
        if pageNY.count != 0 {
            let pageNUmber = pageNY.object(at: 0) as! ResultMasterPageNumber
            pageNumberIncrese = Int(pageNUmber.pageNumber) + 1
            
            print(pageNumberIncrese)
        } else {
            pageNumberIncrese =  1
        }
        
        progress = Double(pageNumberIncrese)
        print(progress)
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        
        
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.post,Headers: headerDict, bodyParams: getParams(), Url: Configuration.Dev(packet: ApiKeys.resultByindex.rawValue).getUrl()))
        
        print(Configuration.Dev(packet: ApiKeys.resultByindex.rawValue).getUrl())
        
    }
    private func getParamsforAnimalResult()->[String:Any]{
        let activeCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int ?? 0
        return ["CustomerId":activeCustomerId,
                "SearchText":searchText,"SearchType":searchType]
    }
    
    private func getParams()->[String:Any]{
        
        let activeCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int ?? 0
        let fetchFilterData = fetchResultFilterData1(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: activeCustomerId,isheridity: UserDefaults.standard.bool(forKey: keyValue.isHerditySelected.rawValue))
        
        
        for items in fetchFilterData
        {
            
            let newfetch = items as? ResultFIlterDataSave
            providerIndexPath = newfetch?.productID ?? 0
            sex = newfetch?.sex ?? ""
            dateto = newfetch?.dateto ?? ""
            
            datefrom = newfetch?.datefrom ?? ""
            
            headerstring = newfetch?.header ?? ""
            traidstting = newfetch?.trait ?? ""
            resultBreedIb = newfetch?.breedID ?? ""
            
            sortorder = newfetch?.sortorder ?? false
        }
        
        return [keyValue.customerId.rawValue:activeCustomerId,
                keyValue.providerIdText.rawValue:providerIndexPath,"breedList":resultBreedIb.components(separatedBy: ","),
                "gender": sex,keyValue.fromdate.rawValue:datefrom,"toDate":dateto,"pageNumber":pageNumberIncrese,"pageSize":50,"indexName":traidstting,"orderByAscending": sortorder]
        
    }
    
    func dateConverter(dateString:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = DateFormatters.yyyyMMddTHHmmssFormat
        let date = dateFormatter.date(from: dateString)!
        dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
    
    func saveResultByPageAnimal(dataModel: ResulyByPageModel){
        
        if dataModel.animals.count == 0 {
            if UIDevice().userInterfaceIdiom == .phone {
                myherdresult?.hideIndicator()
                myherdresult?.tblView.reloadData()
                dependency?.collectionView.reloadData()
                stopPagination = true
                self.delegate?.resultStatus(status: false)
                return
            } else {
                myherdresultVC?.hideIndicator()
                myherdresultVC?.resultsCollectionView.reloadData()
                dependency?.collectionView.reloadData()
                stopPagination = true
                self.delegate?.resultStatus(status: false)
                return
            }
            
        }
        myherdresult?.hideIndicator()
        myherdresultVC?.hideIndicator()
        UserDefaults.standard.setValue(dataModel.animalCount, forKey: keyValue.animalReceivedCount.rawValue)
        for animals in dataModel.animals {
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: LocalizedStrings.en_US_POSIXStr) // set locale to reliable US_POSIX
            dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
            
            let date:Date? = dateFormatter.date(from:animals.dob ?? "")
            
            let orderdate = dateConverter(dateString: animals.orderDate ?? "")
            let currentTime = NSDate().timeIntervalSince1970 * 1000
            var resultAnimalCheck = [ResultMyHerdData]()
            if searchByanimal {
                
                resultAnimalCheck = fetchResultAnimalbySearch(entity: Entities.resultMyherdDataTblEntity, animalID: animals.animalID ?? "", officialID: animals.officialID ?? "", customerId: dataModel.customerID ?? 0, onFarmID: animals.onFarmID  ?? "", searchbyFound: searchByanimal) as! [ResultMyHerdData]
                
            } else {
                resultAnimalCheck = fetchResultAnimalbySearch(entity: Entities.resultMyherdDataTblEntity, animalID: animals.animalID ?? "", officialID: animals.officialID ?? "", customerId: dataModel.customerID ?? 0, onFarmID: animals.onFarmID  ?? "",barCode: animals.sampleBarCode, searchbyFound: searchByanimal) as! [ResultMyHerdData]
            }
            
            
            if resultAnimalCheck.count > 0 {
                
                updateAnimaldataResultByPage(entity: Entities.resultMyherdDataTblEntity,animalID: animals.animalID ?? "", breed : animals.breed ?? "", breedID : animals.breedID  ?? "",customerId : dataModel.customerID ?? 0 , customerName : dataModel.customerName  ?? "", dob: animals.dob ?? "", name: animals.name ?? "", notes : animals.notes ?? "",officialID : animals.officialID ?? "",onFarmID : animals.onFarmID  ?? "", orderNumber: animals.orderNumber ?? "", products: animals.products ?? "",reportedDate: animals.reportedDate ?? "", sampleBarCode: animals.sampleBarCode , sampleStatus: animals.sampleStatus ?? "", sex: animals.sex ?? "",animalDownloadCount: Int16(countObjectPercentage),orderDate: orderdate ,damID: animals.damID ?? "",sireID: animals.sireID ?? "",mgsID: animals.mgsID ?? "",status: LocalizedStrings.inactiveStatus,datedob: date ?? Date(), resultType: animals.resultType ?? "",searchbyanimal: searchByanimal,currentDatetime:Int64(currentTime),searchbyFound: searchByanimal)
            } else {
                
                saveAnimaldataResultByPage(entity: Entities.resultMyherdDataTblEntity,animalID: animals.animalID ?? "", breed : animals.breed ?? "", breedID : animals.breedID  ?? "",customerId : dataModel.customerID ?? 0 , customerName : dataModel.customerName  ?? "", dob: animals.dob ?? "", name: animals.name ?? "", notes : animals.notes ?? "",officialID : animals.officialID ?? "",onFarmID : animals.onFarmID  ?? "", orderNumber: animals.orderNumber ?? "", products: animals.products ?? "",reportedDate: animals.reportedDate ?? "", sampleBarCode: animals.sampleBarCode , sampleStatus: animals.sampleStatus ?? "", sex: animals.sex ?? "",animalDownloadCount: Int16(countObjectPercentage),orderDate: orderdate ,damID: animals.damID ?? "",sireID: animals.sireID ?? "",mgsID: animals.mgsID ?? "",status: LocalizedStrings.inactiveStatus,datedob: date ?? Date(), resultType: animals.resultType ?? "",searchbyanimal: searchByanimal,currentDatetime:Int64(currentTime),searchbyFound: searchByanimal)
            }
            
            for groupId in animals.groupIDS {
                let fetchResults :[ResultGroupCreate] = addanimalfetch (entityName: Entities.resultGroupCreateTblEntity, customerId:Int64(dataModel.customerID ?? 0)) as! [ResultGroupCreate]
                
                let groupDetail = fetchResults.filter({$0.groupServerId == groupId})
                if groupDetail.count > 0{
                    let group = groupDetail[0]
                    
                    let groupArray = fetchAnimaldataResult(customerId:Int64(dataModel.customerID ?? 0), serverGroupId: group.groupServerId ?? "", onFarmId: animals.onFarmID ?? "", officalId: animals.officialID ?? "") as! [ResultGroupsAnimals]
                    if groupArray.count == 0{
                        saveAnimaldataResult(entity: Entities.resultGroupAnimalsTblEntity, serverGroupId: group.groupServerId ?? "", groupName: group.groupName ?? "", groupStatusId: Int(group.groupStatusId ), groupStatus: group.groupStatus ?? "", groupTypeId: Int(group.groupTypeId ), groupTypeName: group.groupTypeName ?? "", animalID: animals.animalID ?? "", onFarmId: animals.onFarmID ?? "", officalId: animals.officialID ?? "", dob: animals.dob ?? "", sex: animals.sex ?? "", breedId: animals.breedID ?? "", breedName: animals.breed ?? "", name: animals.name ?? "", groupId: group.groupId,customerId :Int64(dataModel.customerID ?? 0),datedob: date ?? Date())
                        if group.groupTypeId == 1 && group.groupStatusId == 1 {
                            updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:Int64(dataModel.customerID ?? 0), animalID:  animals.animalID ?? "", status: LocalizedStrings.banStatus)
                        } else if group.groupTypeId == 0 && group.groupStatusId == 1 {
                            updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:Int64(dataModel.customerID ?? 0), animalID:  animals.animalID ?? "", status: LocalizedStrings.dollerStatus)
                        }
                    } else{
                        updateAnimaldataResult(entity: Entities.resultGroupAnimalsTblEntity, serverGroupId: group.groupServerId ?? "", groupName: group.groupName ?? "", groupStatusId: Int(group.groupStatusId ), groupStatus: group.groupStatus ?? "", groupTypeId: Int(group.groupTypeId ), groupTypeName: group.groupTypeName ?? "", animalID: animals.animalID ?? "", onFarmId: animals.onFarmID ?? "", officalId: animals.officialID ?? "", dob: animals.dob ?? "", sex: animals.sex ?? "", breedId: animals.breedID ?? "", breedName: animals.breed ?? "", name: animals.name ?? "", groupId: group.groupId,customerId :Int64(dataModel.customerID ?? 0),datedob: date ?? Date())
                        if group.groupTypeId == 1 && group.groupStatusId == 1 {
                            updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:Int64(dataModel.customerID ?? 0), animalID:  animals.animalID ?? "", status: LocalizedStrings.banStatus)
                        } else if group.groupTypeId == 0 && group.groupStatusId == 1 {
                            updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:Int64(dataModel.customerID ?? 0), animalID:  animals.animalID ?? "", status: LocalizedStrings.dollerStatus)
                        }
                    }
                }
                
                
            }
            
            for trait in animals.traitValues {
                
                saveTraitDataResultByPage(entity: Entities.resultPageByTraitTblEntity, orderNumber: animals.orderNumber ?? "", traitDate: trait.date ?? "", numericValue: trait.numericValue ?? 0, customerId: dataModel.customerID ?? 0, customerName: dataModel.customerName  ?? "", officalId: animals.officialID ?? "", onFarmId: animals.onFarmID  ?? "", stringValue: trait.stringValue ?? "", trait: trait.trait , traitId: trait.traitID,display: trait.display , numericFormat: trait.numericFormat ?? "")
            }
            
            //}
        }
        
        if dataModel.animals.count != 0 {
            if !searchByanimal{
                stopPagination = false
                
            }
            
            let fetchMasterApiPage = fetchResultMyHerdData(entityName: Entities.resultMasterPageNumberTblEntity,customerId: Int64(currentCustomerId ?? 0))
            if fetchMasterApiPage.count == 0 {
                
                UserDefaults.standard.setValue(pageNumberIncrese, forKey: keyValue.pageNumber.rawValue)
                saveMasterApiPageNumber(entity: Entities.resultMasterPageNumberTblEntity,customerId: Int64(currentCustomerId ?? 0), pageNumber: Int64(pageNumberIncrese))
                
            } else {
                
                updateMasterApiPageNumber(entity: Entities.resultMasterPageNumberTblEntity,custmerId: Int(currentCustomerId ?? 0),pageNumber: Int64(pageNumberIncrese))
            }
        }
        if dataModel.animalCount == 1 {
            myherdresult?.hideIndicator()
            myherdresultVC?.hideIndicator()
            stopPagination = true
        }
        
        
    }
    func dateformat() -> String {
        let format:String = "dd-MM-yyyy hh-mm-ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let newDate = dateFormatter.string(from: Date())
        return newDate
        
    }
    
    
}

extension ResulyByPageViewModel : ResponseDelegate {
    
    func responseRecieved(_ data: Data?, status: Bool) {
        if Connectivity.isConnectedToInternet() {
            
            if data == nil {
                self.completion()
                self.delegate?.resultStatus(status: false)
                return
            }
            let decoder = JSONDecoder()
            modalObject = try? decoder.decode(ResulyByPageModel.self, from: data!)
            DispatchQueue.main.async {
                
                if self.modalObject != nil {
                    
                    if self.modalObject?.message == "Okay"
                    {
                        
                        self.dependency?.showIndicator((self.dependency?.view)!, withTitle: NSLocalizedString(AlertMessagesStrings.syncResultsData, comment: ""), and: "")
                        self.saveResultByPageAnimal(dataModel: self.modalObject!)
                    }
                    else
                    {
                        self.saveResultByPageAnimal(dataModel: self.modalObject!)
                        
                    }
                    
                }
                self.completion(
                    
                )
            }
            
            
        }
    }
}

class ResulyByPageViewModeliPad {
    
    var timer = Timer()
    var checkfirsttime = false
    var progress : Double = 0
    var dependency: DashboardVC?
    var myfliter: MyHerdFilteriPadVC?
    var myherdresult: MyHerdResultsViewController?
    var modalObject: ResulyByPageModel?
    var completion:()->()?
    var pageNumberIncrese = Int()
    var providerIndexPath = Int64()
    var sex = String()
    var searchByanimal = Bool()
    var dateto = String()
    var searchText = String()
    var searchType = String()
    var delegate : ResultFoundDelegate?
    
    var datefrom = String()
    var sortorder = Bool()
    var headerstring = String()
    var traidstting = String()
    var resultBreedIb = String()
    let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
    
    var countObjectPercentage = 0
    
    init(ref:DashboardVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
        
    }
    
    init(callBack:@escaping ()->()) {
        completion = callBack
    }
    
    func callResultByAnimalApi(searchText:String, searchType: String) {
        searchByanimal = true
        self.searchText = searchText
        self.searchType = searchType
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.post,Headers: headerDict, bodyParams: getParamsforAnimalResult(), Url: Configuration.Dev(packet: ApiKeys.resultsByEarTagOrOfficial.rawValue).getUrl()))
        
        print(Configuration.Dev(packet: ApiKeys.resultsByEarTagOrOfficial.rawValue).getUrl())
    }
    func callResultByPageAnimalApi() {
        searchByanimal = false
        let pageNY = fetchResultMyHerdData(entityName: Entities.resultMasterPageNumberTblEntity,customerId: Int64(currentCustomerId ?? 0))
        print(pageNY)
        if pageNY.count != 0 {
            let pageNUmber = pageNY.object(at: 0) as! ResultMasterPageNumber
            pageNumberIncrese = Int(pageNUmber.pageNumber) + 1
            
            print(pageNumberIncrese)
        } else {
            pageNumberIncrese =  1
        }
        
        progress = Double(pageNumberIncrese)
        print(progress)
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        
        
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.post,Headers: headerDict, bodyParams: getParams(), Url: Configuration.Dev(packet: ApiKeys.resultByindex.rawValue).getUrl()))
        
        print(Configuration.Dev(packet: ApiKeys.resultByindex.rawValue).getUrl())
        
    }
    private func getParamsforAnimalResult()->[String:Any]{
        let activeCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int ?? 0
        return ["CustomerId":activeCustomerId,
                "SearchText":searchText,"SearchType":searchType]
    }
    
    private func getParams()->[String:Any]{
        
        let activeCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int ?? 0
        let fetchFilterData = fetchResultFilterData1(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: activeCustomerId,isheridity: UserDefaults.standard.bool(forKey: keyValue.isHerditySelected.rawValue))
        
        
        for items in fetchFilterData
        {
            
            let newfetch = items as? ResultFIlterDataSave
            providerIndexPath = newfetch?.productID ?? 0
            sex = newfetch?.sex ?? ""
            dateto = newfetch?.dateto ?? ""
            
            datefrom = newfetch?.datefrom ?? ""
            
            headerstring = newfetch?.header ?? ""
            traidstting = newfetch?.trait ?? ""
            resultBreedIb = newfetch?.breedID ?? ""
            
            sortorder = newfetch?.sortorder ?? false
        }
        
        return [keyValue.customerId.rawValue:currentCustomerId as Any,
                keyValue.providerIdText.rawValue:providerIndexPath,"breedList":resultBreedIb.components(separatedBy: ","),
                "gender": sex,keyValue.fromdate.rawValue:datefrom,"toDate":dateto,"pageNumber":pageNumberIncrese,"pageSize":50,"indexName":traidstting,"orderByAscending": sortorder]
        
    }
    
    func dateConverter(dateString:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = DateFormatters.yyyyMMddTHHmmssFormat
        let date = dateFormatter.date(from: dateString)!
        dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
    
    func saveResultByPageAnimal(dataModel: ResulyByPageModel){
        
        if dataModel.animals.count == 0 {
            myherdresult?.hideIndicator()
            myherdresult?.tblView.reloadData()
            dependency?.collectionView.reloadData()
            stopPagination = true
            self.delegate?.resultStatus(status: false)
            return
        }
        myherdresult?.hideIndicator()
        UserDefaults.standard.setValue(dataModel.animalCount, forKey: keyValue.animalReceivedCount.rawValue)
        for animals in dataModel.animals {
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: LocalizedStrings.en_US_POSIXStr) // set locale to reliable US_POSIX
            dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
            
            let date:Date? = dateFormatter.date(from:animals.dob ?? "")
            
            let orderdate = dateConverter(dateString: animals.orderDate ?? "")
            let currentTime = NSDate().timeIntervalSince1970 * 1000
            var resultAnimalCheck = [ResultMyHerdData]()
            if searchByanimal {
                
                resultAnimalCheck = fetchResultAnimalbySearch(entity: Entities.resultMyherdDataTblEntity, animalID: animals.animalID ?? "", officialID: animals.officialID ?? "", customerId: dataModel.customerID ?? 0, onFarmID: animals.onFarmID  ?? "", searchbyFound: searchByanimal) as! [ResultMyHerdData]
                
            } else {
                resultAnimalCheck = fetchResultAnimalbySearch(entity: Entities.resultMyherdDataTblEntity, animalID: animals.animalID ?? "", officialID: animals.officialID ?? "", customerId: dataModel.customerID ?? 0, onFarmID: animals.onFarmID  ?? "",barCode: animals.sampleBarCode, searchbyFound: searchByanimal) as! [ResultMyHerdData]
            }
            
            
            if resultAnimalCheck.count > 0 {
                
                updateAnimaldataResultByPage(entity: Entities.resultMyherdDataTblEntity,animalID: animals.animalID ?? "", breed : animals.breed ?? "", breedID : animals.breedID  ?? "",customerId : dataModel.customerID ?? 0 , customerName : dataModel.customerName  ?? "", dob: animals.dob ?? "", name: animals.name ?? "", notes : animals.notes ?? "",officialID : animals.officialID ?? "",onFarmID : animals.onFarmID  ?? "", orderNumber: animals.orderNumber ?? "", products: animals.products ?? "",reportedDate: animals.reportedDate ?? "", sampleBarCode: animals.sampleBarCode , sampleStatus: animals.sampleStatus ?? "", sex: animals.sex ?? "",animalDownloadCount: Int16(countObjectPercentage),orderDate: orderdate ,damID: animals.damID ?? "",sireID: animals.sireID ?? "",mgsID: animals.mgsID ?? "",status: LocalizedStrings.inactiveStatus,datedob: date ?? Date(), resultType: animals.resultType ?? "",searchbyanimal: searchByanimal,currentDatetime:Int64(currentTime),searchbyFound: searchByanimal)
            } else {
                
                saveAnimaldataResultByPage(entity: Entities.resultMyherdDataTblEntity,animalID: animals.animalID ?? "", breed : animals.breed ?? "", breedID : animals.breedID  ?? "",customerId : dataModel.customerID ?? 0 , customerName : dataModel.customerName  ?? "", dob: animals.dob ?? "", name: animals.name ?? "", notes : animals.notes ?? "",officialID : animals.officialID ?? "",onFarmID : animals.onFarmID  ?? "", orderNumber: animals.orderNumber ?? "", products: animals.products ?? "",reportedDate: animals.reportedDate ?? "", sampleBarCode: animals.sampleBarCode , sampleStatus: animals.sampleStatus ?? "", sex: animals.sex ?? "",animalDownloadCount: Int16(countObjectPercentage),orderDate: orderdate ,damID: animals.damID ?? "",sireID: animals.sireID ?? "",mgsID: animals.mgsID ?? "",status: LocalizedStrings.inactiveStatus,datedob: date ?? Date(), resultType: animals.resultType ?? "",searchbyanimal: searchByanimal,currentDatetime:Int64(currentTime),searchbyFound: searchByanimal)
            }
            
            for groupId in animals.groupIDS {
                let fetchResults :[ResultGroupCreate] = addanimalfetch (entityName: Entities.resultGroupCreateTblEntity, customerId:Int64(dataModel.customerID ?? 0)) as! [ResultGroupCreate]
                
                let groupDetail = fetchResults.filter({$0.groupServerId == groupId})
                if groupDetail.count > 0{
                    let group = groupDetail[0]
                    
                    let groupArray = fetchAnimaldataResult(customerId:Int64(dataModel.customerID ?? 0), serverGroupId: group.groupServerId ?? "", onFarmId: animals.onFarmID ?? "", officalId: animals.officialID ?? "") as! [ResultGroupsAnimals]
                    if groupArray.count == 0{
                        saveAnimaldataResult(entity: Entities.resultGroupAnimalsTblEntity, serverGroupId: group.groupServerId ?? "", groupName: group.groupName ?? "", groupStatusId: Int(group.groupStatusId ), groupStatus: group.groupStatus ?? "", groupTypeId: Int(group.groupTypeId ), groupTypeName: group.groupTypeName ?? "", animalID: animals.animalID ?? "", onFarmId: animals.onFarmID ?? "", officalId: animals.officialID ?? "", dob: animals.dob ?? "", sex: animals.sex ?? "", breedId: animals.breedID ?? "", breedName: animals.breed ?? "", name: animals.name ?? "", groupId: group.groupId,customerId :Int64(dataModel.customerID ?? 0),datedob: date ?? Date())
                        if group.groupTypeId == 1 && group.groupStatusId == 1 {
                            updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:Int64(dataModel.customerID ?? 0), animalID:  animals.animalID ?? "", status: LocalizedStrings.banStatus)
                        } else if group.groupTypeId == 0 && group.groupStatusId == 1 {
                            updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:Int64(dataModel.customerID ?? 0), animalID:  animals.animalID ?? "", status: LocalizedStrings.dollerStatus)
                        }
                    } else{
                        updateAnimaldataResult(entity: Entities.resultGroupAnimalsTblEntity, serverGroupId: group.groupServerId ?? "", groupName: group.groupName ?? "", groupStatusId: Int(group.groupStatusId ), groupStatus: group.groupStatus ?? "", groupTypeId: Int(group.groupTypeId ), groupTypeName: group.groupTypeName ?? "", animalID: animals.animalID ?? "", onFarmId: animals.onFarmID ?? "", officalId: animals.officialID ?? "", dob: animals.dob ?? "", sex: animals.sex ?? "", breedId: animals.breedID ?? "", breedName: animals.breed ?? "", name: animals.name ?? "", groupId: group.groupId,customerId :Int64(dataModel.customerID ?? 0),datedob: date ?? Date())
                        if group.groupTypeId == 1 && group.groupStatusId == 1 {
                            updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:Int64(dataModel.customerID ?? 0), animalID:  animals.animalID ?? "", status: LocalizedStrings.banStatus)
                        } else if group.groupTypeId == 0 && group.groupStatusId == 1 {
                            updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:Int64(dataModel.customerID ?? 0), animalID:  animals.animalID ?? "", status: LocalizedStrings.dollerStatus)
                        }
                    }
                }
                
                
            }
            
            for trait in animals.traitValues {
                
                saveTraitDataResultByPage(entity: Entities.resultPageByTraitTblEntity, orderNumber: animals.orderNumber ?? "", traitDate: trait.date ?? "", numericValue: trait.numericValue ?? 0, customerId: dataModel.customerID ?? 0, customerName: dataModel.customerName  ?? "", officalId: animals.officialID ?? "", onFarmId: animals.onFarmID  ?? "", stringValue: trait.stringValue ?? "", trait: trait.trait , traitId: trait.traitID,display: trait.display , numericFormat: trait.numericFormat ?? "")
            }
            
            //}
        }
        
        if dataModel.animals.count != 0 {
            if !searchByanimal{
                stopPagination = false
                
            }
            
            let fetchMasterApiPage = fetchResultMyHerdData(entityName: Entities.resultMasterPageNumberTblEntity,customerId: Int64(currentCustomerId ?? 0))
            if fetchMasterApiPage.count == 0 {
                
                UserDefaults.standard.setValue(pageNumberIncrese, forKey: keyValue.pageNumber.rawValue)
                saveMasterApiPageNumber(entity: Entities.resultMasterPageNumberTblEntity,customerId: Int64(currentCustomerId ?? 0), pageNumber: Int64(pageNumberIncrese))
                
            } else {
                
                updateMasterApiPageNumber(entity: Entities.resultMasterPageNumberTblEntity,custmerId: Int(currentCustomerId ?? 0),pageNumber: Int64(pageNumberIncrese))
            }
        }
        if dataModel.animalCount == 1 {
            myherdresult?.hideIndicator()
            stopPagination = true
        }
        
        
    }
    func dateformat() -> String {
        let format:String = "dd-MM-yyyy hh-mm-ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let newDate = dateFormatter.string(from: Date())
        return newDate
        
    }
    
    
}

extension ResulyByPageViewModeliPad : ResponseDelegate {
    
    func responseRecieved(_ data: Data?, status: Bool) {
        if Connectivity.isConnectedToInternet() {
            
            if data == nil {
                self.completion()
                self.delegate?.resultStatus(status: false)
                return
            }
            let decoder = JSONDecoder()
            modalObject = try? decoder.decode(ResulyByPageModel.self, from: data!)
            DispatchQueue.main.async {
                
                if self.modalObject != nil {
                    
                    if self.modalObject?.message == "Okay"
                    {
                        
                        self.dependency?.showIndicator((self.dependency?.view)!, withTitle: NSLocalizedString(AlertMessagesStrings.syncResultsData, comment: ""), and: "")
                        self.saveResultByPageAnimal(dataModel: self.modalObject!)
                    }
                    else
                    {
                        self.saveResultByPageAnimal(dataModel: self.modalObject!)
                        
                    }
                    
                }
                self.completion(
                    
                )
            }
            
            
        }
    }
}

enum Vcname{
    
    case MyHerdResultsViewController
    case MyHerdFilterController
}
var selectedVC = Vcname.MyHerdFilterController

extension Date {
    
}
