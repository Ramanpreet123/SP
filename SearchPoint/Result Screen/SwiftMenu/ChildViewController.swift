//
//  ChildViewController.swift
//  PageMenuExample
//
//  Created by Tamanyan on 3/7/29 H.
//  Copyright © 29 Heisei Tamanyan. All rights reserved.
//

import UIKit
import Alamofire

// MARK: - SWIFT PAGE MENU TABLE VIEW CLASS
class SwiftPageMenuTableView: UITableView, UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.self)
    }
}

// MARK: - CHILD VIEW CONTROLLER CLASS
class ChildViewController: UIViewController {
    
    // MARK: - VARIABLES AND CONSTANTS
    var userId = UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int
    var custmerID = Int64()
    var tabTitles = String()
    var delegateUpadte:UpdateView?
    var tableView: UITableView = SwiftPageMenuTableView()
    var fruits = [String]()
    var hideUnhideArray  = [String]()
    var reaultArrGet = [ResultTraitHeader]()
    var resultMasterGet = [ResultMasterTemplate]()
    var fetchMyHerdData = [ResultMyHerdData]()
    var MyHerdData = [ResultMyHerdData]()
    var myHerdArray = [ResultGroupsAnimals]()
    var scrollIndexGet = Int()
    var bckScreenIndexGet = Int()
    var showAllBool = false
    var productName = String()
    var groupNameExist = String()
    var checkCOntroller = ""
    var animalid = String()
    var officalfetch = String()
    var onformid = String()
    var updateGruop = UpdateGroupModel()
    var searchByAnimal = Bool()
    var selectedProuductName = ""
    let selectedBreedID =  UserDefaults.standard.value(forKey: keyValue.selectedAnimalBreedID.rawValue) as? String ?? ""
    var tabT = [String]()
    
    // MARK: - INITIALIZATION
    init(fruits: [String]) {
        super.init(nibName: nil, bundle: nil)
        self.productName = UserDefaults.standard.value(forKey: keyValue.selectedProviderName.rawValue) as? String ?? ""
        scrollIndexGet = UserDefaults.standard.value(forKey: keyValue.scrollIncrement.rawValue) as? Int ?? 0
        custmerID = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64 ?? 0
        searchByAnimal = UserDefaults.standard.bool(forKey: keyValue.searchByAnimal.rawValue)
        fetchMyHerdData = fetchResultMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:custmerID,searchFound: searchByAnimal) as! [ResultMyHerdData]
        if searchByAnimal {
            selectedProuductName =  productName
        }
        else {
            if productName == keyValue.auDairyProducts.rawValue  {
                selectedProuductName = LocalizedStrings.clarifideDataGene
            } else {
                if UserDefaults.standard.bool(forKey: keyValue.isHerditySelected.rawValue) {
                    selectedProuductName = LocalizedStrings.herdity
                } else {
                    selectedProuductName = LocalizedStrings.clarifideCDCB
                }
            }
        }
        
        if searchByAnimal {
            let traitHeader = fetchResultHeaderAllDataForSearchAnimal(entityName: Entities.resultTraitHeaderTblEntity, productName: selectedProuductName)
            let hName : [String] = traitHeader.value(forKey: keyValue.headerName.rawValue) as! [String]
            tabT = hName.removeDuplicates()
        }
        else {
            let traitHeader = fetchResultHeaderAllData(entityName: Entities.resultTraitHeaderTblEntity, productName: selectedProuductName)
            let hName : [String] = traitHeader.value(forKey: keyValue.headerName.rawValue) as! [String]
            tabT = hName.removeDuplicates()
        }
        bckScreenIndexGet = UserDefaults.standard.value(forKey: keyValue.myHerdListSelectIndex.rawValue) as? Int ?? 0
        fetchMyHerdData = fetchResultMyHerdDataanimal(entityName: Entities.resultMyherdDataTblEntity,customerId:custmerID,breedid: selectedBreedID , searchFound: searchByAnimal) as! [ResultMyHerdData]
        
        if fetchMyHerdData.count > 0
        {
            officalfetch = UserDefaults.standard.object(forKey: keyValue.myHerdOfficalid.rawValue) as! String
            onformid = UserDefaults.standard.object(forKey: keyValue.myHerdOnfarmId.rawValue) as! String
            UserDefaults.standard.set(onformid, forKey: keyValue.groupOnFormId.rawValue)
        }
        
        let onformid = UserDefaults.standard.value(forKey: keyValue.groupOnFormId.rawValue) as? String
        myHerdArray = fetchGroupchild(entityName: Entities.resultGroupAnimalsTblEntity, customerId: custmerID, Onfarmid: onformid ?? "") as! [ResultGroupsAnimals]
        
        self.tabTitles = tabT[scrollIndexGet]
        let fetchTraitObj = fetchResultTraitIdGet(entityName: Entities.resultTraitHeaderTblEntity,species: marketNameType.Dairy.rawValue, headerName: tabTitles,productName: selectedProuductName, searchByAnimal:searchByAnimal)
        
        for i in 0 ..< fetchTraitObj.count {
            let productName = fetchTraitObj[i] as! ResultTraitHeader
            let traitId = productName.traitId
            let resultHideIndex = fetchResultTraitIdHideIndex(entityName: Entities.resultHideIndexTblEntity, headerName: tabTitles , userId: userId ?? 0, customerId: custmerID, traitId: traitId ?? "")
            if resultHideIndex.count == 0 {
                let fetchTempObj = fetchResultTraitIdTemplate1(entityName: Entities.resultMasterTemplateTblEntity,traitId: traitId ?? "")
                if fetchTempObj.count > 1{
                }
                let objFetch = fetchTempObj.object(at: 0) as! ResultMasterTemplate
                print(objFetch.breedFilter as Any)
                let breedFilter : [String] = objFetch.breedFilter as! [String]
                if breedFilter.count > 0 {
                    let breedArray = breedFilter.filter{$0 == selectedBreedID}
                    if breedArray.count > 0{
                        self.resultMasterGet.append(objFetch)
                    } else {
                        
                    }
                } else {
                    self.resultMasterGet.append(objFetch)
                }
            }
        }
        scrollIndexGet = scrollIndexGet + 1
        UserDefaults.standard.setValue(scrollIndexGet, forKey: keyValue.scrollIncrement.rawValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
        self.tableView.showsVerticalScrollIndicator = true
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.tableView.panGestureRecognizer.delaysTouchesBegan = true
        tableView.register(UINib(nibName: ClassIdentifiers.customCellIdentifier, bundle: nil), forCellReuseIdentifier: ClassIdentifiers.customCellIdentifier)
        tableView.register(UINib(nibName: ClassIdentifiers.customSecondCellIdentifier, bundle: nil), forCellReuseIdentifier: ClassIdentifiers.customSecondCellIdentifier)
        tableView.beginUpdates()
        if resultMasterGet.count > 0 {
            tableView.insertRows(at: [IndexPath(row: resultMasterGet.count-1, section: 0)], with: .automatic)
        }
        tableView.flashScrollIndicators()
        tableView.endUpdates()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.flashScrollIndicators()
        self.tableView.reloadData()
    }
    
    // MARK: - OBJC SELECTOR METHODS
    @objc func hideBtnCellClick(_ sender: UIButton){
        let myIndexPath = NSIndexPath(row: sender.tag, section: 0)
        let fetchZeroObj = resultMasterGet[myIndexPath.row]
        saveTraitValueHideWithIndex(entity: Entities.resultHideIndexTblEntity ,traitId: fetchZeroObj.traitId ?? "", customerId: custmerID , headerName: tabTitles, userId: userId ?? 0)
        fetchAllDataShowHide()
        self.tableView.reloadData()
    }
    
    @objc func showAllButton(_ sender: UIButton){
        
        deleteRecordFromDatabase(entityName: Entities.resultHideIndexTblEntity)
        resultMasterGet.removeAll()
        scrollIndexGet = UserDefaults.standard.value(forKey: keyValue.scrollIncrement.rawValue) as? Int ?? 0
        custmerID = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64 ?? 0
        fetchMyHerdData = fetchResultMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:custmerID,searchFound: searchByAnimal) as! [ResultMyHerdData]
        let traitHeader = fetchAllData(entityName: Entities.resultTraitHeaderTblEntity)
        let hName : [String] = traitHeader.value(forKey: keyValue.headerName.rawValue) as! [String]
        let tabT = hName.removeDuplicates()
        bckScreenIndexGet = UserDefaults.standard.value(forKey: keyValue.myHerdListSelectIndex.rawValue) as? Int ?? 0
        
        self.tabTitles = tabT[scrollIndexGet]
        let fetchTraitObj = fetchResultTraitIdGet(entityName: Entities.resultTraitHeaderTblEntity,species: marketNameType.Dairy.rawValue, headerName: tabTitles, productName: selectedProuductName, searchByAnimal: searchByAnimal)
        for i in 0 ..< fetchTraitObj.count {
            let productName = fetchTraitObj[i] as! ResultTraitHeader
            let traitId = productName.traitId
            let resultHideIndex = fetchResultTraitIdHideIndex(entityName: Entities.resultHideIndexTblEntity, headerName: tabTitles , userId: userId ?? 0, customerId: custmerID, traitId: traitId ?? "")
            
            if resultHideIndex.count == 0 {
                let fetchTempObj = fetchResultTraitIdTemplate1(entityName: Entities.resultMasterTemplateTblEntity,traitId: traitId ?? "")
                let objFetch = fetchTempObj.object(at: 0) as! ResultMasterTemplate
                let breedFilter : [String] = objFetch.breedFilter as! [String]
                if breedFilter.count > 0 {
                    let breedArray = breedFilter.filter{$0 == selectedBreedID}
                    if breedArray.count > 0{
                        self.resultMasterGet.append(objFetch)
                        showAllBool = false
                    } else {
                        
                    }
                } else {
                    self.resultMasterGet.append(objFetch)
                    showAllBool = false
                }
            }
        }
        tableView.reloadData()
    }
    
    @objc func barnBtnCellClick(_ sender: UIButton){
        
        let myIndexPath = NSIndexPath(row: sender.tag, section: 0)
        if UserDefaults.standard.value(forKey: keyValue.groupDetails.rawValue) as? String == keyValue.groupName.rawValue
        {
            let onformid = UserDefaults.standard.value(forKey: keyValue.myHerdOnfarmId.rawValue) as? String
            let animal = fetchGroupchild(entityName: Entities.resultGroupAnimalsTblEntity, customerId: custmerID, Onfarmid: onformid ?? "") as! [ResultGroupsAnimals]
            
            if  animal.count > 0 {
                let animalchectgroup = animal[0]
                let animalID = animalchectgroup.animalID
                let onFarmid = animalchectgroup.onFarmId
                let gId  = animalchectgroup.serverGroupId ?? ""
                let officialID = animalchectgroup.officalId
                let dob = animalchectgroup.dob
                let sex = animalchectgroup.sex
                let breedID = animalchectgroup.breedId
                let breedName = animalchectgroup.breedName
                let name = animalchectgroup.name
                custmerID = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64 ?? 0
                let ban =  fetchGroupIdFethSatusG(entityName: Entities.resultGroupCreateTblEntity, customerId: custmerID, groupStatusId: 1, groupTypeId: 1)
                
                if ban.count > 0 {
                    let gruupCreate = ban.object(at: 0) as? ResultGroupCreate
                    let groupName = gruupCreate?.groupName  ?? ""
                    let groupTypeName = gruupCreate?.groupTypeName  ?? ""
                    let groupServerId =  gruupCreate?.groupServerId ?? ""
                    let groupStatusId = gruupCreate?.groupStatusId  ?? 0
                    let groupStatus = gruupCreate?.groupStatus  ?? ""
                    let dollar =  fetchGroupIdFethSatusG(entityName: Entities.resultGroupCreateTblEntity, customerId: custmerID, groupStatusId: 1, groupTypeId: 0)
                    
                    if dollar.count > 0 {
                        let gruupCreate1 = dollar.object(at: 0) as? ResultGroupCreate
                        let groupName1 = gruupCreate1?.groupName  ?? ""
                        self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                        removeAnimalInGroup(groupId: gId , animalIds: animalID ?? "", completionHandler: { (result) in
                            if result {
                                _ = deletGroupInfoResultGroupDetail(entityName: Entities.resultGroupAnimalsTblEntity, groupName: groupName1 , customerId: self.custmerID, onFarmId: onFarmid ?? "", officalId: officialID ?? "")
                                let checkanimal = fetchanimalExistInDataBase(entityName: Entities.resultGroupAnimalsTblEntity, groupStatusId: 1, groupTypeId: 1, customerId: self.custmerID, Onfarmid: onFarmid ?? "", officialID: officialID ?? "")
                                if checkanimal.count < 0
                                {
                                    let checkanimal11 = fetchanimalExistInDataBase(entityName: Entities.resultGroupAnimalsTblEntity, groupStatusId: 1, groupTypeId: 0, customerId: self.custmerID, Onfarmid: onFarmid ?? "", officialID: officialID ?? "")
                                    if checkanimal11.count > 0
                                    {
                                        let fetchdatadoller = checkanimal11[0] as? ResultGroupsAnimals
                                        let servergroupidbarn = fetchdatadoller?.serverGroupId ?? ""
                                        let animaliddoller = fetchdatadoller?.animalID ?? ""
                                        let groupnamedoller = fetchdatadoller?.groupName ?? ""
                                        self.removeAnimalInGroup(groupId: servergroupidbarn , animalIds: animaliddoller , completionHandler: { (result) in
                                            if result {
                                                _ = deletGroupInfoResultGroupDetail(entityName: Entities.resultGroupAnimalsTblEntity, groupName: groupnamedoller , customerId: self.custmerID, onFarmId: onFarmid ?? "", officalId: officialID ?? "")
                                                
                                                let dateFormatter = DateFormatter()
                                                dateFormatter.locale = Locale(identifier: LocalizedStrings.en_US_POSIXStr)
                                                dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                                                
                                                let date:Date? = dateFormatter.date(from:dob ?? "")
                                                
                                                saveAnimaldataResult(entity: Entities.resultGroupAnimalsTblEntity, serverGroupId: groupServerId, groupName: groupName, groupStatusId: Int(groupStatusId), groupStatus: groupStatus, groupTypeId: 1, groupTypeName: groupTypeName, animalID: animalID ?? "" , onFarmId: onFarmid ?? "", officalId:officialID ?? "", dob: dob ?? "", sex:sex ?? "", breedId: breedID ?? "", breedName: breedName ?? "", name: name ?? "", groupId: 0, customerId: self.custmerID,datedob: date ?? Date())
                                                updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:self.custmerID, animalID: animalID ?? "" , status: LocalizedStrings.banStatus)
                                                
                                            }
                                        })
                                    }
                                    else
                                    {
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.locale = Locale(identifier: LocalizedStrings.en_US_POSIXStr)
                                        dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                                        
                                        let date:Date? = dateFormatter.date(from:dob ?? "")
                                        saveAnimaldataResult(entity: Entities.resultGroupAnimalsTblEntity, serverGroupId: groupServerId, groupName: groupName, groupStatusId: Int(groupStatusId), groupStatus: groupStatus, groupTypeId: 1, groupTypeName: groupTypeName, animalID: animalID ?? "" , onFarmId: onFarmid ?? "", officalId:officialID ?? "", dob: dob ?? "", sex:sex ?? "", breedId: breedID ?? "", breedName: breedName ?? "", name: name ?? "", groupId: 0, customerId: self.custmerID,datedob: date ?? Date())
                                        updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:self.custmerID, animalID: animalID ?? "" , status: LocalizedStrings.banStatus)
                                    }
                                }
                                self.hideIndicator()
                                guard let cell = self.tableView.cellForRow(at: myIndexPath as IndexPath) as? CustomCell else {
                                    return
                                }
                                cell.barnBtn.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
                                cell.dollarBtn.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
                                cell.notAssignedBtn.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
                                UserDefaults.standard.setValue("", forKey: keyValue.del.rawValue)
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: LocalizedStrings.newDataToLoad), object: groupName)
                            }
                        })
                    }
                    else{
                        self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                        addAnimalInGroup(groupId: groupServerId , animalIds: animalID ?? "", completionHandler: { (result) in
                            if result {
                                let dateFormatter = DateFormatter()
                                dateFormatter.locale = Locale(identifier: LocalizedStrings.en_US_POSIXStr)
                                dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                                let date:Date? = dateFormatter.date(from:dob ?? "")
                                saveAnimaldataResult(entity: Entities.resultGroupAnimalsTblEntity, serverGroupId: groupServerId, groupName: groupName, groupStatusId: Int(groupStatusId), groupStatus: groupStatus, groupTypeId: 1, groupTypeName: groupTypeName, animalID: animalID ?? "" , onFarmId: onFarmid ?? "", officalId:officialID ?? "", dob: dob ?? "", sex:sex ?? "", breedId: breedID ?? "", breedName: breedName ?? "", name: name ?? "", groupId: 0, customerId: self.custmerID,datedob: date ?? Date())
                                updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:self.custmerID, animalID: animalID ?? "" , status: LocalizedStrings.banStatus)
                            }
                            self.hideIndicator()
                            guard let cell = self.tableView.cellForRow(at: myIndexPath as IndexPath) as? CustomCell else {
                                return
                            }
                            cell.barnBtn.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
                            cell.dollarBtn.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
                            cell.notAssignedBtn.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
                            UserDefaults.standard.setValue("", forKey: keyValue.del.rawValue)
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: LocalizedStrings.newDataToLoad), object: groupName)
                        })
                    }
                } else {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.noActiveBarn, comment: "") )
                    return
                }
            }
            tableView.reloadData()
        }
        
        else
        {
            let onformid = UserDefaults.standard.value(forKey: keyValue.myHerdOnfarmId.rawValue) as? String
            let filterMyherdAnimal =  fetchMyHerdData.filter{$0.onFarmID == onformid}
            if filterMyherdAnimal.count > 0 {
                let animal = filterMyherdAnimal[0]
                let animalID = animal.animalID
                let onFarmid = animal.onFarmID
                let officialID = animal.officialID
                let dob = animal.dob
                let sex = animal.sex
                let breedID = animal.breedID
                let breedName = animal.breed
                let name = animal.name
                
                custmerID = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64 ?? 0
                let ban =  fetchGroupIdFethSatusG(entityName: Entities.resultGroupCreateTblEntity, customerId: custmerID, groupStatusId: 1, groupTypeId: 1)
                if ban.count > 0 {
                    let gruupCreate = ban.object(at: 0) as? ResultGroupCreate
                    let groupName = gruupCreate?.groupName  ?? ""
                    let groupTypeName = gruupCreate?.groupTypeName  ?? ""
                    let groupServerId =  gruupCreate?.groupServerId ?? ""
                    let groupStatusId = gruupCreate?.groupStatusId  ?? 0
                    let groupStatus = gruupCreate?.groupStatus  ?? ""
                    let dollar =  fetchGroupIdFethSatusG(entityName: Entities.resultGroupCreateTblEntity, customerId: custmerID, groupStatusId: 1, groupTypeId: 0)
                    
                    if dollar.count > 0 {
                        let gruupCreate1 = dollar.object(at: 0) as? ResultGroupCreate
                        let groupName1 = gruupCreate1?.groupName  ?? ""
                        let groupServerId1 =  gruupCreate1?.groupServerId ?? ""
                        self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                        removeAnimalInGroup(groupId: groupServerId1 , animalIds: animalID ?? "", completionHandler: { (result) in
                            if result {
                                _ = deletGroupInfoResultGroupDetail(entityName: Entities.resultGroupAnimalsTblEntity, groupName: groupName1 , customerId: self.custmerID, onFarmId: onFarmid ?? "", officalId: officialID ?? "")
                                let checkanimal = fetchanimalExistInDataBase(entityName: Entities.resultGroupAnimalsTblEntity, groupStatusId: 1, groupTypeId: 1, customerId: self.custmerID, Onfarmid: onFarmid ?? "", officialID: officialID ?? "")
                                if checkanimal.count > 0
                                {
                                    updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:self.custmerID, animalID: animalID ?? "" , status: LocalizedStrings.banStatus)
                                }
                                else
                                {
                                    let checkanimal11 = fetchanimalExistInDataBase(entityName: Entities.resultGroupAnimalsTblEntity, groupStatusId: 1, groupTypeId: 0, customerId: self.custmerID, Onfarmid: onFarmid ?? "", officialID: officialID ?? "")
                                    if checkanimal11.count > 0
                                    {
                                        let fetchdatadoller = checkanimal11[0] as? ResultGroupsAnimals
                                        let servergroupidbarn = fetchdatadoller?.serverGroupId ?? ""
                                        let animaliddoller = fetchdatadoller?.animalID ?? ""
                                        let groupnamedoller = fetchdatadoller?.groupName ?? ""
                                        self.removeAnimalInGroup(groupId: servergroupidbarn , animalIds: animaliddoller , completionHandler: { (result) in
                                            if result {
                                                _ = deletGroupInfoResultGroupDetail(entityName: Entities.resultGroupAnimalsTblEntity, groupName: groupnamedoller , customerId: self.custmerID, onFarmId: onFarmid ?? "", officalId: officialID ?? "")
                                                
                                                let dateFormatter = DateFormatter()
                                                dateFormatter.locale = Locale(identifier: LocalizedStrings.en_US_POSIXStr)
                                                dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                                                
                                                let date:Date? = dateFormatter.date(from:dob ?? "")
                                                saveAnimaldataResult(entity: Entities.resultGroupAnimalsTblEntity, serverGroupId: groupServerId, groupName: groupName, groupStatusId: Int(groupStatusId), groupStatus: groupStatus, groupTypeId: 1, groupTypeName: groupTypeName, animalID: animalID ?? "" , onFarmId: onFarmid ?? "", officalId:officialID ?? "", dob: dob ?? "", sex:sex ?? "", breedId: breedID ?? "", breedName: breedName ?? "", name: name ?? "", groupId: 0, customerId: self.custmerID,datedob: date ?? Date())
                                                updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:self.custmerID, animalID: animalID ?? "" , status: LocalizedStrings.banStatus)
                                            }
                                        })
                                    }
                                    else
                                    {
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.locale = Locale(identifier: LocalizedStrings.en_US_POSIXStr)
                                        dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                                        
                                        let date:Date? = dateFormatter.date(from:dob ?? "")
                                        saveAnimaldataResult(entity: Entities.resultGroupAnimalsTblEntity, serverGroupId: groupServerId, groupName: groupName, groupStatusId: Int(groupStatusId), groupStatus: groupStatus, groupTypeId: 1, groupTypeName: groupTypeName, animalID: animalID ?? "" , onFarmId: onFarmid ?? "", officalId:officialID ?? "", dob: dob ?? "", sex:sex ?? "", breedId: breedID ?? "", breedName: breedName ?? "", name: name ?? "", groupId: 0, customerId: self.custmerID,datedob: date ?? Date())
                                        updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:self.custmerID, animalID: animalID ?? "" , status: LocalizedStrings.banStatus)
                                    }
                                }
                                self.hideIndicator()
                                guard let cell = self.tableView.cellForRow(at: myIndexPath as IndexPath) as? CustomCell else {
                                    return
                                }
                                cell.barnBtn.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
                                cell.dollarBtn.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
                                cell.notAssignedBtn.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
                                UserDefaults.standard.setValue("", forKey: keyValue.del.rawValue)
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: LocalizedStrings.newDataToLoad), object: groupName)
                            }
                        })
                    }
                    else{
                        self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                        addAnimalInGroup(groupId: groupServerId , animalIds: animalID ?? "", completionHandler: { (result) in
                            if result {
                                let dateFormatter = DateFormatter()
                                dateFormatter.locale = Locale(identifier: LocalizedStrings.en_US_POSIXStr)
                                dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                                
                                let date:Date? = dateFormatter.date(from:dob ?? "")
                                
                                saveAnimaldataResult(entity: Entities.resultGroupAnimalsTblEntity, serverGroupId: groupServerId, groupName: groupName, groupStatusId: Int(groupStatusId), groupStatus: groupStatus, groupTypeId: 1, groupTypeName: groupTypeName, animalID: animalID ?? "" , onFarmId: onFarmid ?? "", officalId:officialID ?? "", dob: dob ?? "", sex:sex ?? "", breedId: breedID ?? "", breedName: breedName ?? "", name: name ?? "", groupId: 0, customerId: self.custmerID,datedob: date ?? Date())
                                updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:self.custmerID, animalID: animalID ?? "" , status: LocalizedStrings.banStatus)
                            }
                            
                            self.hideIndicator()
                            guard let cell = self.tableView.cellForRow(at: myIndexPath as IndexPath) as? CustomCell else {
                                return
                            }
                            cell.barnBtn.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
                            cell.dollarBtn.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
                            cell.notAssignedBtn.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
                            UserDefaults.standard.setValue("", forKey: keyValue.del.rawValue)
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: LocalizedStrings.newDataToLoad), object: groupName)
                        })
                    }
                } else {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.noActiveBarn, comment: "") )
                    return
                }
                tableView.reloadData()
            }
        }
    }
    
    @objc func dollarBtnBtnCellClick(_ sender: UIButton){
        
        let myIndexPath = NSIndexPath(row: sender.tag, section: 0)
        if UserDefaults.standard.value(forKey: "groupdetails") as? String == "groupName"
        {
            let onformid = UserDefaults.standard.value(forKey: keyValue.myHerdOnfarmId.rawValue) as? String
            let animal = fetchGroupchild(entityName: "ResultGroupsAnimals", customerId: custmerID, Onfarmid: onformid ?? "") as! [ResultGroupsAnimals]
            
            if  animal.count > 0 {
                
                let animalchectgroup = animal[0]
                let customerId = animalchectgroup.customerId
                let animalID = animalchectgroup.animalID
                let onFarmid = animalchectgroup.onFarmId
                let officialID = animalchectgroup.officalId
                let dob = animalchectgroup.dob
                let sex = animalchectgroup.sex
                let breedID = animalchectgroup.breedId
                let breedName = animalchectgroup.breedName
                let name = animalchectgroup.name
                
                custmerID = UserDefaults.standard.value(forKey: "currentActiveCustomerId") as? Int64 ?? 0
                
                
                let dollar =  fetchGroupIdFethSatusG(entityName: "ResultGroupCreate", customerId: custmerID, groupStatusId: 1, groupTypeId: 0)
                
                if dollar.count > 0 {
                    let gruupCreate = dollar.object(at: 0) as? ResultGroupCreate
                    let groupName = gruupCreate?.groupName  ?? ""
                    let groupTypeName = gruupCreate?.groupTypeName  ?? ""
                    let groupServerId =  gruupCreate?.groupServerId ?? ""
                    let groupStatusId = gruupCreate?.groupStatusId  ?? 0
                    let groupStatus = gruupCreate?.groupStatus  ?? ""
                    
                    let ban =  fetchGroupIdFethSatusG(entityName: "ResultGroupCreate", customerId: customerId, groupStatusId: 1, groupTypeId: 1)
                    
                    if ban.count > 0 {
                        
                        let gruupCreate = ban.object(at: 0) as? ResultGroupCreate
                        let gname = gruupCreate?.groupName
                        let serverGid =  gruupCreate?.groupServerId ?? ""
                        
                        self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                        removeAnimalInGroup(groupId: serverGid , animalIds: animalID ?? "", completionHandler: { (result) in
                            if result {
                                _ = deletGroupInfoResultGroupDetail(entityName: "ResultGroupsAnimals", groupName: gname ?? "", customerId: self.custmerID, onFarmId: onFarmid ?? "", officalId: officialID ?? "")
                                let checkanimal = fetchanimalExistInDataBase(entityName: "ResultGroupsAnimals", groupStatusId: 1, groupTypeId: 0, customerId: self.custmerID, Onfarmid: onFarmid ?? "", officialID: officialID ?? "")
                                if checkanimal.count > 0
                                {
                                    
                                }
                                else
                                {
                                    let checkanimal11 = fetchanimalExistInDataBase(entityName: "ResultGroupsAnimals", groupStatusId: 1, groupTypeId: 1, customerId: self.custmerID, Onfarmid: onFarmid ?? "", officialID: officialID ?? "")
                                    if checkanimal11.count > 0
                                    {
                                        let fetchserverid = checkanimal11[0] as? ResultGroupsAnimals
                                        let servergroupidcheck = fetchserverid?.serverGroupId ?? ""
                                        let animalid = fetchserverid?.animalID ?? ""
                                        let groupnamecheck = fetchserverid?.groupName ?? ""
                                        self.removeAnimalInGroup(groupId: servergroupidcheck , animalIds: animalid, completionHandler: { (result) in
                                            if result {
                                                _ = deletGroupInfoResultGroupDetail(entityName: "ResultGroupsAnimals", groupName: groupnamecheck, customerId: self.custmerID, onFarmId: onFarmid ?? "", officalId: officialID ?? "")
                                                let dateFormatter = DateFormatter()
                                                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                                                dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                                                
                                                let date:Date? = dateFormatter.date(from:dob ?? "")
                                                
                                                saveAnimaldataResult(entity: "ResultGroupsAnimals", serverGroupId: groupServerId, groupName: groupName, groupStatusId: Int(groupStatusId), groupStatus: groupStatus, groupTypeId: 0, groupTypeName: groupTypeName, animalID: animalID ?? "" , onFarmId: onFarmid ?? "", officalId:officialID ?? "", dob: dob ?? "", sex:sex ?? "", breedId: breedID ?? "", breedName: breedName ?? "", name: name ?? "", groupId: 0, customerId: self.custmerID,datedob: date ?? Date())
                                                updateMyHerdDataStaus(entity: "ResultMyHerdData", customerId:  self.custmerID, animalID: animalID ?? "" , status: "doller")
                                                
                                            }
                                        })
                                        
                                    }
                                    else
                                    {
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                                        dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                                        
                                        let date:Date? = dateFormatter.date(from:dob ?? "")
                                        saveAnimaldataResult(entity: "ResultGroupsAnimals", serverGroupId: groupServerId, groupName: groupName, groupStatusId: Int(groupStatusId), groupStatus: groupStatus, groupTypeId: 0, groupTypeName: groupTypeName, animalID: animalID ?? "" , onFarmId: onFarmid ?? "", officalId:officialID ?? "", dob: dob ?? "", sex:sex ?? "", breedId: breedID ?? "", breedName: breedName ?? "", name: name ?? "", groupId: 0, customerId: self.custmerID,datedob: date ?? Date())
                                        updateMyHerdDataStaus(entity: "ResultMyHerdData", customerId:  self.custmerID, animalID: animalID ?? "" , status: "doller")
                                    }
                                    
                                    
                                }
                                
                                self.hideIndicator()
                                guard let cell = self.tableView.cellForRow(at: myIndexPath as IndexPath) as? CustomCell else {
                                    return
                                }
                                cell.barnBtn.setImage(UIImage(named: "radioBtn"), for: .normal)
                                cell.dollarBtn.setImage(UIImage(named: "radioSeletedBtn"), for: .normal)
                                cell.notAssignedBtn.setImage(UIImage(named: "radioBtn"), for: .normal)
                                UserDefaults.standard.setValue("", forKey: "del")
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataToLoad"), object: groupName)
                            }
                            
                        })
                    } else{
                        
                        self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                        addAnimalInGroup(groupId: groupServerId , animalIds: animalID ?? "", completionHandler: { (result) in
                            if result {
                                
                                
                                let dateFormatter = DateFormatter()
                                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                                dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                                
                                let date:Date? = dateFormatter.date(from:dob ?? "")
                                
                                saveAnimaldataResult(entity: "ResultGroupsAnimals", serverGroupId: groupServerId, groupName: groupName, groupStatusId: Int(groupStatusId), groupStatus: groupStatus, groupTypeId: 0, groupTypeName: groupTypeName, animalID: animalID ?? "" , onFarmId: onFarmid ?? "", officalId:officialID ?? "", dob: dob ?? "", sex:sex ?? "", breedId: breedID ?? "", breedName: breedName ?? "", name: name ?? "", groupId: 0, customerId: self.custmerID,datedob: date ?? Date())
                                updateMyHerdDataStaus(entity: "ResultMyHerdData", customerId:  self.custmerID, animalID: animalID ?? "" , status: "doller")
                                
                            }
                            
                            
                            
                            self.hideIndicator()
                            guard let cell = self.tableView.cellForRow(at: myIndexPath as IndexPath) as? CustomCell else {
                                return
                            }
                            cell.barnBtn.setImage(UIImage(named: "radioBtn"), for: .normal)
                            cell.dollarBtn.setImage(UIImage(named: "radioSeletedBtn"), for: .normal)
                            cell.notAssignedBtn.setImage(UIImage(named: "radioBtn"), for: .normal)
                            UserDefaults.standard.setValue("", forKey: "del")
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataToLoad"), object: groupName)
                        })
                    }
                    
                } else {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString("No active dollar group exists.", comment: "") )
                    return
                }
                
            }
            
            tableView.reloadData()
        }
        else
        {
            let onformid = UserDefaults.standard.value(forKey: keyValue.myHerdOnfarmId.rawValue) as? String
            let filterMyherdAnimal =  fetchMyHerdData.filter{$0.onFarmID == onformid}
            if filterMyherdAnimal.count > 0 {
                let animal = filterMyherdAnimal[0]
                let customerId = animal.customerId
                let animalID = animal.animalID
                let onFarmid = animal.onFarmID
                let officialID = animal.officialID
                let dob = animal.dob
                let sex = animal.sex
                let breedID = animal.breedID
                let breedName = animal.breed
                let name = animal.name
                
                custmerID = UserDefaults.standard.value(forKey: "currentActiveCustomerId") as? Int64 ?? 0
                
                
                let dollar =  fetchGroupIdFethSatusG(entityName: "ResultGroupCreate", customerId: custmerID, groupStatusId: 1, groupTypeId: 0)
                
                
                
                if dollar.count > 0 {
                    let gruupCreate = dollar.object(at: 0) as? ResultGroupCreate
                    let groupName = gruupCreate?.groupName  ?? ""
                    let groupTypeName = gruupCreate?.groupTypeName  ?? ""
                    let groupServerId =  gruupCreate?.groupServerId ?? ""
                    let groupStatusId = gruupCreate?.groupStatusId  ?? 0
                    let groupStatus = gruupCreate?.groupStatus  ?? ""
                    
                    let ban =  fetchGroupIdFethSatusG(entityName: "ResultGroupCreate", customerId: customerId, groupStatusId: 1, groupTypeId: 1)
                    
                    if ban.count > 0 {
                        
                        let gruupCreate = ban.object(at: 0) as? ResultGroupCreate
                        let gname = gruupCreate?.groupName
                        let serverGid =  gruupCreate?.groupServerId ?? ""
                        
                        self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                        removeAnimalInGroup(groupId: serverGid , animalIds: animalID ?? "", completionHandler: { (result) in
                            if result {
                                _ = deletGroupInfoResultGroupDetail(entityName: "ResultGroupsAnimals", groupName: gname ?? "", customerId: self.custmerID, onFarmId: onFarmid ?? "", officalId: officialID ?? "")
                                let checkanimal = fetchanimalExistInDataBase(entityName: "ResultGroupsAnimals", groupStatusId: 1, groupTypeId: 0, customerId: self.custmerID, Onfarmid: onFarmid ?? "", officialID: officialID ?? "")
                                if checkanimal.count > 0
                                {
                                    
                                }
                                else
                                {
                                    let checkanimal11 = fetchanimalExistInDataBase(entityName: "ResultGroupsAnimals", groupStatusId: 1, groupTypeId: 1, customerId: self.custmerID, Onfarmid: onFarmid ?? "", officialID: officialID ?? "")
                                    if checkanimal11.count > 0
                                    {
                                        let fetchserverid = checkanimal11[0] as? ResultGroupsAnimals
                                        let servergroupidcheck = fetchserverid?.serverGroupId ?? ""
                                        let animalid = fetchserverid?.animalID ?? ""
                                        let groupnamecheck = fetchserverid?.groupName ?? ""
                                        self.removeAnimalInGroup(groupId: servergroupidcheck , animalIds: animalid, completionHandler: { (result) in
                                            if result {
                                                _ = deletGroupInfoResultGroupDetail(entityName: "ResultGroupsAnimals", groupName: groupnamecheck, customerId: self.custmerID, onFarmId: onFarmid ?? "", officalId: officialID ?? "")
                                                let dateFormatter = DateFormatter()
                                                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                                                dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                                                
                                                let date:Date? = dateFormatter.date(from:dob ?? "")
                                                
                                                saveAnimaldataResult(entity: "ResultGroupsAnimals", serverGroupId: groupServerId, groupName: groupName, groupStatusId: Int(groupStatusId), groupStatus: groupStatus, groupTypeId: 0, groupTypeName: groupTypeName, animalID: animalID ?? "" , onFarmId: onFarmid ?? "", officalId:officialID ?? "", dob: dob ?? "", sex:sex ?? "", breedId: breedID ?? "", breedName: breedName ?? "", name: name ?? "", groupId: 0, customerId: self.custmerID,datedob: date ?? Date())
                                                updateMyHerdDataStaus(entity: "ResultMyHerdData", customerId:  self.custmerID, animalID: animalID ?? "" , status: "doller")
                                                
                                            }
                                        })
                                        
                                    }
                                    else
                                    {
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                                        dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                                        
                                        let date:Date? = dateFormatter.date(from:dob ?? "")
                                        saveAnimaldataResult(entity: "ResultGroupsAnimals", serverGroupId: groupServerId, groupName: groupName, groupStatusId: Int(groupStatusId), groupStatus: groupStatus, groupTypeId: 0, groupTypeName: groupTypeName, animalID: animalID ?? "" , onFarmId: onFarmid ?? "", officalId:officialID ?? "", dob: dob ?? "", sex:sex ?? "", breedId: breedID ?? "", breedName: breedName ?? "", name: name ?? "", groupId: 0, customerId: self.custmerID,datedob: date ?? Date())
                                        updateMyHerdDataStaus(entity: "ResultMyHerdData", customerId:  self.custmerID, animalID: animalID ?? "" , status: "doller")
                                    }
                                    
                                    
                                }
                                
                                self.hideIndicator()
                                guard let cell = self.tableView.cellForRow(at: myIndexPath as IndexPath) as? CustomCell else {
                                    return
                                }
                                cell.barnBtn.setImage(UIImage(named: "radioBtn"), for: .normal)
                                cell.dollarBtn.setImage(UIImage(named: "radioSeletedBtn"), for: .normal)
                                cell.notAssignedBtn.setImage(UIImage(named: "radioBtn"), for: .normal)
                                UserDefaults.standard.setValue("", forKey: "del")
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataToLoad"), object: groupName)
                            }
                            
                        })
                    }else{
                      
                        
                        self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                        addAnimalInGroup(groupId: groupServerId , animalIds: animalID ?? "", completionHandler: { (result) in
                            if result {
                                
                                
                                let dateFormatter = DateFormatter()
                                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                                dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
                                
                                let date:Date? = dateFormatter.date(from:dob ?? "")
                                
                                saveAnimaldataResult(entity: "ResultGroupsAnimals", serverGroupId: groupServerId, groupName: groupName, groupStatusId: Int(groupStatusId), groupStatus: groupStatus, groupTypeId: 0, groupTypeName: groupTypeName, animalID: animalID ?? "" , onFarmId: onFarmid ?? "", officalId:officialID ?? "", dob: dob ?? "", sex:sex ?? "", breedId: breedID ?? "", breedName: breedName ?? "", name: name ?? "", groupId: 0, customerId: self.custmerID,datedob: date ?? Date())
                                updateMyHerdDataStaus(entity: "ResultMyHerdData", customerId:  self.custmerID, animalID: animalID ?? "" , status: "doller")
                                
                            }
                            
                            
                            
                            self.hideIndicator()
                            guard let cell = self.tableView.cellForRow(at: myIndexPath as IndexPath) as? CustomCell else {
                                return
                            }
                            cell.barnBtn.setImage(UIImage(named: "radioBtn"), for: .normal)
                            cell.dollarBtn.setImage(UIImage(named: "radioSeletedBtn"), for: .normal)
                            cell.notAssignedBtn.setImage(UIImage(named: "radioBtn"), for: .normal)
                            UserDefaults.standard.setValue("", forKey: "del")
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataToLoad"), object: groupName)
                            
                            
                        })
                    }
                    
                } else {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString("No active dollar group exists.", comment: "") )
                    return
                }
            }
        }
        tableView.reloadData()
        
    }
    
    @objc func notAssignedBtnClick(_ sender: UIButton){
        let myIndexPath = NSIndexPath(row: sender.tag, section: 0)
        if UserDefaults.standard.value(forKey: keyValue.groupDetails.rawValue) as? String == keyValue.groupName.rawValue{
            let onformid = UserDefaults.standard.value(forKey: keyValue.myHerdOnfarmId.rawValue) as? String
            let animal = fetchGroupchild(entityName: Entities.resultGroupAnimalsTblEntity, customerId: custmerID, Onfarmid: onformid ?? "") as! [ResultGroupsAnimals]
            
            if  animal.count > 0 {
                let animalchectgroup = animal[0]
                let cuid = animalchectgroup.customerId
                let animaliId = animalchectgroup.animalID
                let onFarmid = animalchectgroup.onFarmId
                let data = fetchGroupnotassigned(entityName: Entities.resultGroupAnimalsTblEntity, customerId: cuid, onFarmId: onFarmid ?? "")
                if data.count > 0 {
                    let gruupCreate = data.object(at: 0) as? ResultGroupsAnimals
                    let groupServerId =  gruupCreate?.serverGroupId ?? ""
                    
                    self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                    removeAnimalInGroup(groupId: groupServerId , animalIds: animaliId ?? "", completionHandler: { (result) in
                        if result {
                            _ = deletGroupnonassigned(entityName: Entities.resultGroupAnimalsTblEntity, customerId: cuid, onFarmId: onFarmid ?? "")
                            updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  cuid, animalID: animaliId ?? "" , status: LocalizedStrings.inactiveStatus)
                            self.hideIndicator()
                            guard let cell = self.tableView.cellForRow(at: myIndexPath as IndexPath) as? CustomCell else {
                                return
                            }
                            cell.dollarBtn.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
                            cell.barnBtn.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
                            cell.notAssignedBtn.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
                            UserDefaults.standard.setValue("", forKey: keyValue.del.rawValue)
                        }
                    })
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: LocalizedStrings.newDataToLoad), object: "N/A")
                } else {
                    return
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: LocalizedStrings.newDataToLoad), object: "N/A")
            }
        }
        else{
            let onformid = UserDefaults.standard.value(forKey: keyValue.myHerdOnfarmId.rawValue) as? String
            let filterMyherdAnimal =  fetchMyHerdData.filter{$0.onFarmID == onformid}
            if filterMyherdAnimal.count > 0 {
                let animal = filterMyherdAnimal[0]
                UserDefaults.standard.setValue(ImageNames.threeDotsInactiveImg, forKey: keyValue.radioButtonCheck.rawValue)
                let cuid = animal.customerId
                let animaliId = animal.animalID
                let onFarmid = animal.onFarmID
                let data = fetchGroupnotassigned(entityName: Entities.resultGroupAnimalsTblEntity, customerId: cuid, onFarmId: onFarmid ?? "")
                if data.count > 0 {
                    let gruupCreate = data.object(at: 0) as? ResultGroupsAnimals
                    let groupServerId =  gruupCreate?.serverGroupId ?? ""
                    self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                    removeAnimalInGroup(groupId: groupServerId , animalIds: animaliId ?? "", completionHandler: { (result) in
                        if result {
                            _ = deletGroupnonassigned(entityName: Entities.resultGroupAnimalsTblEntity, customerId: cuid, onFarmId: onFarmid ?? "")
                            updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  cuid, animalID: animaliId ?? "" , status: LocalizedStrings.inactiveStatus)
                            self.hideIndicator()
                            guard let cell = self.tableView.cellForRow(at: myIndexPath as IndexPath) as? CustomCell else {
                                return
                            }
                            cell.dollarBtn.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
                            cell.barnBtn.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
                            cell.notAssignedBtn.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
                            UserDefaults.standard.setValue("", forKey: keyValue.del.rawValue)
                        }
                    })
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: LocalizedStrings.newDataToLoad), object: "N/A")
                } else {
                    return
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: LocalizedStrings.newDataToLoad), object: "N/A")
        }
    }
    
    // MARK: - UPDATION AND DELETION METHODS
    func removeDup1(arr: [ResultMasterTemplate]) -> [ResultMasterTemplate] {
        var temparray = [ResultMasterTemplate]()
        var namesarray = [String]()
        for i in arr
        {
            if !namesarray.contains(i.displayName ?? "")
            {
                namesarray.append(i.displayName ?? "")
                temparray.append(i)
            }
        }
        return temparray
    }
    
    func UpdateNewGroupResult(groupName: String, groupTypeId: Int, groupId:String,groupStatusId: Int,decs: String, animalID : [String], completionHandler:  @escaping (Bool) -> ()){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        updateGruop.groupName = groupName
        updateGruop.groupId = groupId
        updateGruop.groupTypeId = groupTypeId
        updateGruop.groupStatusId = groupStatusId
        updateGruop.description = decs
        let jsonEncoder = JSONEncoder()
        var jsonData: Data?
        do {
            jsonData = try jsonEncoder.encode(updateGruop)
            // use jsonData safely
        } catch {
            print("Failed to encode updateGroup: \(error.localizedDescription)")
        }
        
        guard let body = jsonData else {
            return
        }
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + accessToken!]
        let urlString = Configuration.Dev(packet: ApiKeys.update.rawValue).getUrl()
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headerDict
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        request.httpBody = body
        
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            if statusCode == 200 {
                switch response.result {
                case .success(_):
                    return completionHandler(true)
                case let .failure(error):
                    print(error)
                }
            }
            else {
                self.hideIndicator()
            }
        }
        return
    }
    
    func fetchAllDataShowHide(){
        resultMasterGet.removeAll()
        scrollIndexGet = UserDefaults.standard.value(forKey: keyValue.scrollIncrement.rawValue) as? Int ?? 0
        custmerID = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64 ?? 0
        fetchMyHerdData = fetchResultMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:custmerID,searchFound: searchByAnimal) as! [ResultMyHerdData]
        let traitHeader = fetchAllData(entityName: Entities.resultTraitHeaderTblEntity)
        let hName : [String] = traitHeader.value(forKey: keyValue.headerName.rawValue) as! [String]
        let tabT = hName.removeDuplicates()
        bckScreenIndexGet = UserDefaults.standard.value(forKey: keyValue.myHerdListSelectIndex.rawValue) as? Int ?? 0
        
        self.tabTitles = tabT[scrollIndexGet]
        
        let fetchTraitObj = fetchResultTraitIdGet(entityName: Entities.resultTraitHeaderTblEntity,species: marketNameType.Dairy.rawValue, headerName: tabTitles, productName: selectedProuductName,searchByAnimal: searchByAnimal)
        for i in 0 ..< fetchTraitObj.count {
            let productName = fetchTraitObj[i] as! ResultTraitHeader
            let traitId = productName.traitId
            
            let resultHideIndex = fetchResultTraitIdHideIndex(entityName: Entities.resultHideIndexTblEntity, headerName: tabTitles , userId: userId ?? 0, customerId: custmerID, traitId: traitId ?? "")
            
            if resultHideIndex.count == 0 {
                
                let fetchTempObj = fetchResultTraitIdTemplate1(entityName: Entities.resultMasterTemplateTblEntity,traitId: traitId ?? "")
                let objFetch = fetchTempObj.object(at: 0) as! ResultMasterTemplate
                let breedFilter : [String] = objFetch.breedFilter as! [String]
                if breedFilter.count > 0 {
                    let breedArray = breedFilter.filter{$0 == selectedBreedID}
                    if breedArray.count > 0{
                        self.resultMasterGet.append(objFetch)
                    }
                } else {
                    self.resultMasterGet.append(objFetch)
                }
                
            } else {
                showAllBool = true
            }
        }
    }
    
    func removeAnimalInGroup(groupId:String,animalIds: String, completionHandler: @escaping  CompletionHandler){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict = [LocalizedStrings.authorizationHeader: accessToken!,LocalizedStrings.contentType : LocalizedStrings.formURLEncoded]
        
        let urlString = Configuration.Dev(packet: ApiKeys.removeAnimalsGroup.rawValue).getUrl()
        let parameters : [String: Any] = [keyValue.groupId.rawValue: groupId,"animalIds":[animalIds]]
        
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headerDict
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            if statusCode == 200 {
                
                switch response.result {
                case let .success(value):
                    
                    print(value)
                    
                    return completionHandler(true)
                    
                case let .failure(error):
                    print(error)
                }
            }
        }
        return
    }
    
    func addAnimalInGroup(groupId:String,animalIds: String, completionHandler: @escaping CompletionHandler){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict = [LocalizedStrings.authorizationHeader: accessToken!,LocalizedStrings.contentType : LocalizedStrings.formURLEncoded]
        let urlString = Configuration.Dev(packet: ApiKeys.addAnimalGroup.rawValue).getUrl()
        let parameters : [String: Any] = [keyValue.groupId.rawValue: groupId,"animalIds":[animalIds]]
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headerDict
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            if statusCode == 200 {
                
                switch response.result {
                case let .success(value):
                    let groupid = value as? NSDictionary
                    let groupidnew = groupid?.value(forKey: keyValue.groupId.rawValue)
                    updateAnimalgroupsave(entity: Entities.resultGroupAnimalsTblEntity, serverGroupId: groupidnew as? String ?? "", customerId: UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64 ?? 0, isUpdatedtrue: "false")
                    self.hideIndicator()
                    return completionHandler(true)
                    
                case let .failure(error):
                    print(error)
                }
            }
            else {
                self.hideIndicator()
            }
        }
        return
    }
}
