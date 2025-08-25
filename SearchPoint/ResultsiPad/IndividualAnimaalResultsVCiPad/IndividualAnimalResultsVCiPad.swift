//
//  IndividualAnimalResultsVCiPad.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 21/05/25.
//

import Foundation
import UIKit
import Swift_PageMenu
import Alamofire

struct TraitState {
    var dropDown: Bool
}
struct showAll {
    var show: Bool
}
//MARK: CLASS
class IndividualAnimalResultsVCiPad: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var inactiveGroupView: UIView!
    @IBOutlet weak var dollarGroupView: UIView!
    @IBOutlet weak var barnGroupView: UIView!
    @IBOutlet weak var connectedBtnOutlet: UIButton!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var connectionImg: UIImageView!
    @IBOutlet weak var managedGroupoutlet: UIButton!
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indivisualTableView: UITableView!
    @IBOutlet weak var breedTitle: UILabel!
    @IBOutlet weak var evaluationDateTitle: UILabel!
    @IBOutlet weak var sexTitle: UILabel!
    @IBOutlet weak var dobTitle: UILabel!
    @IBOutlet weak var resultTypeTitle: UILabel!
    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var breedLbl: UILabel!
    @IBOutlet weak var evaluationDateLbl: UILabel!
    @IBOutlet weak var sexLbl: UILabel!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var donebutton: UIButton!
    @IBOutlet weak var donebuttonlb: UILabel!
    @IBOutlet weak var resultTypeLbl: UILabel!
    @IBOutlet weak var subVieww: UIView!
    @IBOutlet weak var replaceBtnOutlet: UIButton!
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var notesBackroundView: UIView!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var notesView: customView!
    @IBOutlet weak var notesDoneBtnOutlet: UIButton!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var imageBackroundView: UIView!
    @IBOutlet weak var replaceLbl: UILabel!
    @IBOutlet weak var deleteLbl: UILabel!
    @IBOutlet weak var bckBtnOutlet: customButton!
    @IBOutlet weak var providerChnageOutlet: UIButton!
    @IBOutlet weak var notedBtnOutlet: UIButton!
    @IBOutlet weak var photoBtnOutlet: UIButton!
    @IBOutlet weak var deleteBtnOutlet: UIButton!
    @IBOutlet weak var groupBtnOutlet: UIButton!
    
    //MARK: VARIABLES AND CONSTANTS
    
    var isViewOpen = false
    var groupStatus = String()
    var groupName = String()
    var proModel : ChildViewController?
    var expandedCells: Set<IndexPath> = []
    var backScreenClickIndex = Int()
    var newbackscreenindex = Int()
    var navigateFromGroupDetailScreen = false
    var groupNameExist = String()
    var productName = String()
    var checkCOntroller = ""
    var gronformid = String()
    var getMyHerdArray = [ResultMyHerdData]()
    var groupanimalarray = [ResultGroupsAnimals]()
    var boolcheck = Bool.self
    var itemsArray = [[String]]()
    var tabTitles = [String]()
    var titleArray = [String]()
    let arrayother = MyHerdResultsViewController()
    var titleNameArray = ["ID","NMS", "TPI", "JPI","BPI","Sire_Naab", "PTI/CPI", "NMS","BPI","FM$","Group"]
    var titleLabelArray  = ["1231232","123", "321", "231","343","232", "434", "455","Group"]
    var searchbyAnimal = Bool()
    var note = String()
    var photo = String()
    var animalID: String?
    var farmID: String?
    var officialID: String?
    var fetchMyHerdData = [ResultMyHerdData]()
    var custmerID = Int64()
    var selectedProuductName = ""
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    var value = 0
    var numberOfRows = 0
    var traitStates: [TraitState]!
    var showButton: [showAll]!
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        indivisualTableView.reloadData()
        self.setUIOndidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUIOnWillAppear()
    }
    
    func setUIOndidLoad(){
        
        custmerID = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64 ?? 0
        initialNetworkCheck()
        if navigateFromGroupDetailScreen  {
            let myHerdArray = fetchGroupInfoResult(entityName: Entities.resultGroupAnimalsTblEntity,groupName: groupNameExist,customerId:custmerID) as! [ResultGroupsAnimals]
            let myHerdValueWithIndex = myHerdArray[backScreenClickIndex]
            animalID = myHerdValueWithIndex.animalID
            if searchbyAnimal {
                fetchMyHerdData   = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:custmerID ,searchFound: true) as! [ResultMyHerdData]
            } else {
                fetchMyHerdData = fetchResultMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:custmerID) as! [ResultMyHerdData]
            }
            
            var currentIndex = 0
            for name in fetchMyHerdData {
                if name.animalID == animalID {
                    UserDefaults.standard.set(currentIndex, forKey: keyValue.myHerdListSelectIndex.rawValue)
                    backScreenClickIndex = currentIndex
                    break
                }
                currentIndex += 1
            }
        }
        else {
            UserDefaults.standard.set(backScreenClickIndex, forKey: keyValue.myHerdListSelectIndex.rawValue)
            
        }
        
        if searchbyAnimal {
            fetchMyHerdData   = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:custmerID ,searchFound: true) as! [ResultMyHerdData]
            selectedProuductName = productName
            UserDefaults.standard.set(productName, forKey: keyValue.selectedProviderName.rawValue)
        }
        else {
            fetchMyHerdData = fetchResultMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:custmerID) as! [ResultMyHerdData]
            UserDefaults.standard.set(productName, forKey: keyValue.selectedProviderName.rawValue)
            if productName == keyValue.auDairyProducts.rawValue{
                selectedProuductName = LocalizedStrings.clarifideDataGene
            }
            else{
                if UserDefaults.standard.bool(forKey: keyValue.isHerditySelected.rawValue)
                {
                    selectedProuductName = LocalizedStrings.herdity
                } else {
                    selectedProuductName = LocalizedStrings.clarifideCDCB
                }
            }
        }
        
        if searchbyAnimal {
            let traitHeader = fetchResultHeaderAllDataForSearchAnimal(entityName: Entities.resultTraitHeaderTblEntity, productName: selectedProuductName)
            let hName :[String] = traitHeader.value(forKey: keyValue.headerName.rawValue) as! [String]
            tabTitles = hName.removeDuplicates()
        }
        else {
            let traitHeader = fetchResultHeaderAllData(entityName: Entities.resultTraitHeaderTblEntity, productName: selectedProuductName)
            let hName :[String] = traitHeader.value(forKey: keyValue.headerName.rawValue) as! [String]
            tabTitles = hName.removeDuplicates()
        }
        
        for title in tabTitles {
            titleArray.append(title)
        }
        for _ in tabTitles {
            itemsArray.append(titleArray)
        }
        numberOfRows = titleArray.count
        traitStates = Array(repeating: TraitState(dropDown: false), count: numberOfRows)
        showButton = Array(repeating: showAll(show: false), count: numberOfRows)
        providerChnageOutlet.setTitle(productName, for: .normal)
        if getMyHerdArray.count != 0 {
            
            animalID = getMyHerdArray[backScreenClickIndex].animalID
            farmID = getMyHerdArray[backScreenClickIndex].onFarmID
            officialID = getMyHerdArray[backScreenClickIndex].officialID
            
            if UserDefaults.standard.value(forKey: keyValue.groupName.rawValue) == nil {
                groupBtnOutlet.setImage(UIImage.init(named: "orangeResultsNA"), for: .normal)
            }
            else {
                let groupValue = UserDefaults.standard.value(forKey: keyValue.groupName.rawValue) as? String != "NA" ? UserDefaults.standard.value(forKey: keyValue.groupName.rawValue) as? String : "N/A"
                
                let groupStatusValue = getMyHerdArray[backScreenClickIndex].status ?? "N/A"
                if groupValue == LocalizedStrings.inactiveStatus{
                    groupBtnOutlet.setImage(UIImage.init(named: "orangeResultsNA"), for: .normal)
                }
                
                else{
                    if groupStatusValue == LocalizedStrings.banStatus{
                        groupBtnOutlet.setImage(UIImage.init(named: "barnImageOrange"), for: .normal)
                    } else if groupStatusValue == LocalizedStrings.dollerStatus{
                        groupBtnOutlet.setImage(UIImage.init(named: "dollar_orange"), for: .normal)
                    }
                    else{
                        groupBtnOutlet.setImage(UIImage.init(named: "orangeResultsNA"), for: .normal)
                    }
                    
                }
            }
            
        }
        else {
            if self.groupStatus == "doller" {
                groupBtnOutlet.setImage(UIImage.init(named: "dollar_orange"), for: .normal)
                
            } else if self.groupStatus == "ban" {
                groupBtnOutlet.setImage(UIImage.init(named: "barnImageOrange"), for: .normal)
                
            } else {
                groupBtnOutlet.setImage(UIImage(named: "orangeResultsNA"), for: .normal)
            }
        }
    }
    
    func setUIOnWillAppear(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notificationRecevied(notification:)), name: NSNotification.Name(rawValue: LocalizedStrings.newDataToLoad), object: nil)
        proModel?.delegateUpadte = self
        proModel?.productName = productName
        if Connectivity.isConnectedToInternet(){
            self.getNote()
        }
        
        NotificationCenter.default.addObserver(
                   self,
                   selector: #selector(orientationChanged),
                   name: UIDevice.orientationDidChangeNotification,
                   object: nil)
        
        if let orientation = view.window?.windowScene?.interfaceOrientation {
            if orientation.isLandscape {
            } else if orientation.isPortrait {
            }
        } else {
            // Fallback using size
            let size = UIScreen.main.bounds.size
            if size.width > size.height {
            } else {
            }
        }

    }
    
    //MARK: OBJC SELECTORS
    @objc func orientationChanged() {
        self.tblView.reloadData()
        let orientation = UIDevice.current.orientation
        if orientation.isLandscape {
        } else if orientation.isPortrait {

        }
    }

    @objc func checkForReachability(notification:Notification){
        let del =  UIApplication.shared.delegate as? AppDelegate
        self.statusText?.text = NSLocalizedString((del?.status)!, comment: "")
        if statusText?.text == ButtonTitles.connectedText.localized {
            self.connectedBtnOutlet.isHidden = true
            self.connectionImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else {
            self.connectedBtnOutlet.isHidden = false
            self.connectionImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    @objc func methodOfReceivedNotification(notification: Notification){
        if value == 0{
            UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
            self.hideIndicator()
            value = value + 1
        }
    }
    @objc func notificationRecevied(notification: Notification) {
        let data = notification.object
        let groupValue = data as! String != "" ? data as! String : "N/A"
        self.groupName = groupValue
        indivisualTableView.reloadData()
    }
    
    @objc func buttonbgPressed (){
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
    //MARK: METHODS AND FUNCTIONS
    func initialNetworkCheck(){
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del = UIApplication.shared.delegate as? AppDelegate
        self.statusText?.text = NSLocalizedString((del?.status)!, comment: "")
        if statusText?.text == ButtonTitles.connectedText.localized {
            self.connectedBtnOutlet.isHidden = true
            self.connectionImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else {
            self.connectedBtnOutlet.isHidden = false
            self.connectionImg.image = UIImage(named: ImageNames.statusOfflineImg)
            
        }
    }
    
    
    
    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatters.yyyyMMddTHHmmssFormat
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: "2015-04-01T11:42:00")
    }
    
    func convertImageToBase64(image: UIImage) -> String {
        let imageData = image.pngData()!
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
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
    
    //MARK: IB ACTIONS
    @IBAction func groupBtnAction(_ sender: Any) {
        self.notesBackroundView.isHidden = false
        self.isViewOpen.toggle()
        
        if self.isViewOpen {
            if self.groupStatus == "doller"{
                self.barnGroupView.isHidden = true
                self.dollarGroupView.isHidden = false
                self.inactiveGroupView.isHidden = true
                
            } else if self.groupStatus == "ban" {
                self.barnGroupView.isHidden = false
                self.dollarGroupView.isHidden = true
                self.inactiveGroupView.isHidden = true
                
            } else {
                self.barnGroupView.isHidden = true
                self.dollarGroupView.isHidden = true
                self.inactiveGroupView.isHidden = false
            }
        }
        
    }
    
    @IBAction func dollarBtnAction(_ sender: UIButton) {
        self.isViewOpen.toggle()
        self.notesBackroundView.isHidden = true
        self.barnGroupView.isHidden = true
        self.inactiveGroupView.isHidden = true
        self.dollarGroupView.isHidden = true
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
                                                dateFormatter.dateFormat = "MM/dd/yyyy"
                                                
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
                                        dateFormatter.dateFormat = "MM/dd/yyyy"
                                        
                                        let date:Date? = dateFormatter.date(from:dob ?? "")
                                        saveAnimaldataResult(entity: "ResultGroupsAnimals", serverGroupId: groupServerId, groupName: groupName, groupStatusId: Int(groupStatusId), groupStatus: groupStatus, groupTypeId: 0, groupTypeName: groupTypeName, animalID: animalID ?? "" , onFarmId: onFarmid ?? "", officalId:officialID ?? "", dob: dob ?? "", sex:sex ?? "", breedId: breedID ?? "", breedName: breedName ?? "", name: name ?? "", groupId: 0, customerId: self.custmerID,datedob: date ?? Date())
                                        updateMyHerdDataStaus(entity: "ResultMyHerdData", customerId:  self.custmerID, animalID: animalID ?? "" , status: "doller")
                                    }
                                    
                                    
                                }
                                
                                self.hideIndicator()
                                self.groupBtnOutlet.setImage(UIImage(named: "dollar_orange"), for: .normal)
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
                                dateFormatter.dateFormat = "MM/dd/yyyy"
                                
                                let date:Date? = dateFormatter.date(from:dob ?? "")
                                
                                saveAnimaldataResult(entity: "ResultGroupsAnimals", serverGroupId: groupServerId, groupName: groupName, groupStatusId: Int(groupStatusId), groupStatus: groupStatus, groupTypeId: 0, groupTypeName: groupTypeName, animalID: animalID ?? "" , onFarmId: onFarmid ?? "", officalId:officialID ?? "", dob: dob ?? "", sex:sex ?? "", breedId: breedID ?? "", breedName: breedName ?? "", name: name ?? "", groupId: 0, customerId: self.custmerID,datedob: date ?? Date())
                                updateMyHerdDataStaus(entity: "ResultMyHerdData", customerId:  self.custmerID, animalID: animalID ?? "" , status: "doller")
                                
                            }
                            
                            
                            
                            self.hideIndicator()
                            
                            self.groupBtnOutlet.setImage(UIImage(named: "dollar_orange"), for: .normal)
                            UserDefaults.standard.setValue("", forKey: "del")
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataToLoad"), object: groupName)
                        })
                    }
                    self.groupBtnOutlet.setImage(UIImage(named: "dollar_orange"), for: .normal)
                    self.groupStatus = "doller"
                } else {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString("No active dollar group exists.", comment: "") )
                    return
                }
                
            }
            
            indivisualTableView.reloadData()
        }
        else
        {
            let onformid = UserDefaults.standard.value(forKey: keyValue.myHerdOnfarmId.rawValue) as? String
            let filterMyherdAnimal =  fetchMyHerdData.filter{$0.onFarmID == onformid}
            if filterMyherdAnimal.count > 0 {
                self.groupStatus = "doller"
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
                                                dateFormatter.dateFormat = "MM/dd/yyyy"
                                                
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
                                        dateFormatter.dateFormat = "MM/dd/yyyy"
                                        
                                        let date:Date? = dateFormatter.date(from:dob ?? "")
                                        saveAnimaldataResult(entity: "ResultGroupsAnimals", serverGroupId: groupServerId, groupName: groupName, groupStatusId: Int(groupStatusId), groupStatus: groupStatus, groupTypeId: 0, groupTypeName: groupTypeName, animalID: animalID ?? "" , onFarmId: onFarmid ?? "", officalId:officialID ?? "", dob: dob ?? "", sex:sex ?? "", breedId: breedID ?? "", breedName: breedName ?? "", name: name ?? "", groupId: 0, customerId: self.custmerID,datedob: date ?? Date())
                                        updateMyHerdDataStaus(entity: "ResultMyHerdData", customerId:  self.custmerID, animalID: animalID ?? "" , status: "doller")
                                    }
                                    
                                    
                                }
                                
                                self.hideIndicator()
                                
                                self.groupBtnOutlet.setImage(UIImage(named: "dollar_orange"), for: .normal)
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
                                dateFormatter.dateFormat = "MM/dd/yyyy"
                                
                                let date:Date? = dateFormatter.date(from:dob ?? "")
                                
                                saveAnimaldataResult(entity: "ResultGroupsAnimals", serverGroupId: groupServerId, groupName: groupName, groupStatusId: Int(groupStatusId), groupStatus: groupStatus, groupTypeId: 0, groupTypeName: groupTypeName, animalID: animalID ?? "" , onFarmId: onFarmid ?? "", officalId:officialID ?? "", dob: dob ?? "", sex:sex ?? "", breedId: breedID ?? "", breedName: breedName ?? "", name: name ?? "", groupId: 0, customerId: self.custmerID,datedob: date ?? Date())
                                updateMyHerdDataStaus(entity: "ResultMyHerdData", customerId:  self.custmerID, animalID: animalID ?? "" , status: "doller")
                                
                            }
                            
                            
                            
                            self.hideIndicator()
                            
                            self.groupBtnOutlet.setImage(UIImage(named: "dollar_orange"), for: .normal)
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
        indivisualTableView.reloadData()
    }
    
    @IBAction func barnBtnAction(_ sender: UIButton) {
        self.isViewOpen.toggle()
        self.notesBackroundView.isHidden = true
        self.barnGroupView.isHidden = true
        self.inactiveGroupView.isHidden = true
        self.dollarGroupView.isHidden = true
        
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
                                self.groupBtnOutlet.setImage(UIImage(named: "barnImageOrange"), for: .normal)
                             
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
                       
                            self.groupBtnOutlet.setImage(UIImage(named: "barnImageOrange"), for: .normal)
                         
                            UserDefaults.standard.setValue("", forKey: keyValue.del.rawValue)
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: LocalizedStrings.newDataToLoad), object: groupName)
                        })
                    }
                } else {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.noActiveBarn, comment: "") )
                    return
                }
            }
            indivisualTableView.reloadData()
        }
        
        else
        {
            let onformid = UserDefaults.standard.value(forKey: keyValue.myHerdOnfarmId.rawValue) as? String
            let filterMyherdAnimal =  fetchMyHerdData.filter{$0.onFarmID == onformid}
            if filterMyherdAnimal.count > 0 {
                self.groupStatus = "ban"
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
                              
                                self.groupBtnOutlet.setImage(UIImage(named: "barnImageOrange"), for: .normal)
                             
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
                          
                            self.groupBtnOutlet.setImage(UIImage(named: "barnImageOrange"), for: .normal)
                         
                            UserDefaults.standard.setValue("", forKey: keyValue.del.rawValue)
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: LocalizedStrings.newDataToLoad), object: groupName)
                        })
                    }
                    self.groupBtnOutlet.setImage(UIImage(named: "barnImageOrange"), for: .normal)
                    self.groupStatus = "ban"
                } else {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.noActiveBarn, comment: "") )
                    return
                }
                indivisualTableView.reloadData()
            }
        }
        
    }
    
    @IBAction func inactiveBtnAction(_ sender: UIButton) {
        self.isViewOpen.toggle()
        self.notesBackroundView.isHidden = true
        self.barnGroupView.isHidden = true
        self.inactiveGroupView.isHidden = true
        self.dollarGroupView.isHidden = true
        self.groupBtnOutlet.setImage(UIImage(named: "orangeResultsNA"), for: .normal)
        self.groupStatus = "inactive"
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
                          
                            self.groupBtnOutlet.setImage(UIImage(named: "orangeResultsNA"), for: .normal)
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
                          
                            self.groupBtnOutlet.setImage(UIImage(named: "orangeResultsNA"), for: .normal)
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
        indivisualTableView.reloadData()
    }
    
    
    
    @IBAction func imageBckounBtnClick(_ sender: Any) {
        imageBackroundView.isHidden = true
        deleteLbl.isHidden = true
        donebuttonlb.isHidden = true
        replaceLbl.isHidden = true
        replaceBtnOutlet.isHidden = true
        deleteBtnOutlet.isHidden = true
        profileImgView.isHidden = true
    }
    
    @IBAction func doneBckounBtnClick(_ sender: Any) {
        imageBackroundView.isHidden = true
        imageContainer.isHidden = true
        deleteLbl.isHidden = true
        replaceLbl.isHidden = true
        donebuttonlb.isHidden = true
        replaceBtnOutlet.isHidden = true
        deleteBtnOutlet.isHidden = true
        profileImgView.isHidden = true
    }
    
    @IBAction func noteBckounBtnClick(_ sender: Any) {
        notesBackroundView.isHidden = true
        notesView.isHidden = true
        self.barnGroupView.isHidden = true
        self.inactiveGroupView.isHidden = true
        self.dollarGroupView.isHidden = true
        self.isViewOpen.toggle()
    }
    
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
        vc?.module = LocalizedStrings.resultsText.localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
    }
    
    @IBAction func bckBtnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func notesDoneBtnAction(_ sender: Any) {
        view.endEditing(true)
        notesView.isHidden = true
        notesBackroundView.isHidden = true
        
        if Connectivity.isConnectedToInternet() {
            noteupdateinapi(animalId: animalID ?? "", notes: notesTextView.text ?? "", completionHandler: { (success) -> Void in
                if success {
                    updateNotesAgainstgroupscren(entity: Entities.resultGroupAnimalsTblEntity,custmerId: Int(self.custmerID) ,onFarmID: self.farmID ?? "" ,officialID: self.officialID ?? "",notes: self.notesTextView.text ?? "")
                    
                    updateNotesAgainstFarmIdOfficalId(entity: Entities.resultMyherdDataTblEntity,custmerId: Int(self.custmerID) ,onFarmID: self.farmID ?? "" ,officialID: self.officialID ?? "",notes: self.notesTextView.text ?? "")
                }
            })
        }
        else {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(LocalizedStrings.notConnectedToInternet, comment: ""))
            return
        }
    }
    
    @IBAction func managedGroupAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.myManagementGroupControllerVC) as? MyManagementGroupController
        vc?.searchByAnimal = searchbyAnimal
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func groupChangeBtnClick(_ sender: Any) {
    }
    
    @IBAction func menuBtnClick(_ sender: Any) {
        self.view.makeCorner(withRadius: 40)
        self.sideMenuViewController?.presentRightMenuViewController()
    }
    
    @IBAction func notesBtnClick(_ sender: Any) {
        let onformid = UserDefaults.standard.value(forKey: keyValue.myHerdOnfarmId.rawValue) as? String
        let officialID = UserDefaults.standard.value(forKey: keyValue.myHerdOfficalid.rawValue) as? String
        let fetchnote = fetchResultnote(entityName: Entities.resultMyherdDataTblEntity ,onFarmID: onformid ?? "", customerId: custmerID, officialID: officialID ?? "") as! [ResultMyHerdData]
        if fetchnote.count > 0{
            let note = fetchnote[0]
            notesTextView.text = note.notes
        }
        notesView.isHidden = false
        notesBackroundView.isHidden = false
    }
    
    @IBAction func photoBtnClick(_ sender: Any) {
        profileImgView.alpha = 1
        if profileImgView.image == nil {
            self.showAlert()
        } else {
            self.imageBackroundView.isHidden = false
            self.imageBackroundView.isHidden = false
            self.imageContainer.isHidden = false
            self.donebuttonlb.isHidden = false
            self.deleteLbl.isHidden = false
            self.replaceLbl.isHidden = false
            self.replaceBtnOutlet.isHidden = false
            self.deleteBtnOutlet.isHidden = false
            profileImgView.isHidden = false
        }
    }
    
    @IBAction func doneBtnClick(_ sender: Any) {
        self.imageBackroundView.isHidden = false
        self.imageBackroundView.isHidden = false
        self.imageContainer.isHidden = false
        self.donebuttonlb.isHidden = false
        self.deleteLbl.isHidden = false
        self.replaceLbl.isHidden = false
        self.replaceBtnOutlet.isHidden = false
        self.deleteBtnOutlet.isHidden = false
        profileImgView.isHidden = false
    }
    
    @IBAction func connectedBtnAction(_ sender: Any) {
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(DataEntryModeHelpVC.buttonbgPressed), for: .touchUpInside)
        buttonbg.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view .addSubview(buttonbg)
        customPopView = OfflinePopUp.loadFromNibNamed(ClassIdentifiers.offlineViewNib) as? OfflinePopUp
        customPopView.delegate = self
        customPopView.frame = CGRect(x: 30,y: 160,width: screenSize.width - 30,height: screenSize.height/1.7)
        customPopView.center = view.center
        customPopView.layer.cornerRadius = 8
        customPopView.layer.borderWidth = 3
        customPopView.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg .addSubview(customPopView)
    }
    
    @IBAction func dashBoardBackBtnClick(_ sender: Any) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func deleteBtnClick(_ sender: Any) {
        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(LocalizedStrings.deletePhoto, comment: ""), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
        })
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
            if Connectivity.isConnectedToInternet() {
                self.profileImgView.isHidden = true
                self.imageBackroundView.isHidden = true
                self.imageContainer.isHidden = true
                self.donebuttonlb.isHidden = true
                self.deleteLbl.isHidden = true
                self.replaceLbl.isHidden = true
                self.replaceBtnOutlet.isHidden = true
                self.deleteBtnOutlet.isHidden = true
                self.profileImgView.image = nil
                self.deletePhoto(animalId: self.animalID ?? "", customerId: Int64(Int(self.custmerID)))
                if UserDefaults.standard.value(forKey: keyValue.groupDetails.rawValue) as? String == keyValue.groupName.rawValue{
                    updategroupPhotoNil(entity: Entities.resultGroupAnimalsTblEntity,custmerId: Int(self.custmerID),onFarmID: self.farmID ?? "" ,officialID: self.officialID ?? "")
                }
                else{
                    updatePhotoNil(entity: Entities.resultMyherdDataTblEntity,custmerId: Int(self.custmerID),onFarmID: self.farmID ?? "" ,officialID: self.officialID ?? "")
                }
            }
            else {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(LocalizedStrings.photoCantBeDeleted, comment: ""))
                return
            }
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    @IBAction func replaceBtnClick(_ sender: Any) {
        self.showAlert()
    }
}

//MARK: OFFLINE CUSTOM VIEW EXTENSION
extension IndividualAnimalResultsVCiPad:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

//MARK: UPDATE VIEW EXTENSION
extension IndividualAnimalResultsVCiPad:UpdateView{
    func responseRecievedStatus(value: String) {
        groupTitleLbl.text = value
    }
}


