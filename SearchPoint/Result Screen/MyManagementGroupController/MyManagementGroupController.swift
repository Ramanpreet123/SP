//
//  MyManagementGroupController.swift
//  SearchPoint
//
//  Created by Mobile Programming on 08/03/21.
//

import UIKit
import Alamofire

//MARK: CLASS
class MyManagementGroupController: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var myManagmentLblTitle: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var connectedBtnOutlet: UIButton!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var connectionImg: UIImageView!
    @IBOutlet weak var bckBtnOutlet: customButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var createNewGroupOutlet: customButton!
    
    //MARK: VARIABLES AND CONSTANTS
    var screenBackSave = Bool()
    var objApiSync = ApiSyncList()
    var groupArray = [ResultGroupCreate]()
    var customerId:Int64?
    var userId : Int?
    var langId = Int()
    var orderId = Int()
    var emailId = String()
    var updateGruop = UpdateGroupModel()
    var groupName = String()
    var searchByAnimal = Bool()
    var value = 0
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIOnDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUIOnWillAppear()
    }
    
    //MARK: INITIAL UI METHODS
    func setUIOnDidLoad(){
        initialNetworkCheck()
        UserDefaults.standard.removeObject(forKey: keyValue.fromManagement.rawValue)
        self.navigationController?.navigationBar.isHidden = true
        self.customerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64
        self.userId = UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int
        self.orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        self.emailId = UserDefaults.standard.value(forKey: keyValue.userName.rawValue) as? String ?? ""
    }
    
    func setUIOnWillAppear(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        UserDefaults.standard.set("", forKey: keyValue.groupOnFormId.rawValue)
        UserDefaults.standard.set("", forKey: keyValue.groupNameSave.rawValue)
        UserDefaults.standard.set("", forKey: keyValue.groupStatus.rawValue)
        UserDefaults.standard.set("", forKey: keyValue.groupTypeId.rawValue)
        UserDefaults.standard.set("", forKey: keyValue.groupDetails.rawValue)
        searchTextField.text = ""
        UserDefaults.standard.removeObject(forKey: keyValue.scrollIncrement.rawValue)
        self.langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int ?? 1
        myManagmentLblTitle.text = ButtonTitles.myManagementGroupText.localized
        bckBtnOutlet.setTitle(ButtonTitles.lessThanBackText.localized, for: .normal)
        createNewGroupOutlet.setTitle(ButtonTitles.createGroupText.localized, for: .normal)
        groupArray = fetchAllDataEnteryListWithCustId(entityName: Entities.resultGroupCreateTblEntity, customerId: customerId ?? 0) as! [ResultGroupCreate]
        if groupArray.count == 0{
            message.isHidden = false
            tblView.isHidden = true
        }
        else{
            message.isHidden = true
            tblView.isHidden = false
        }
        tblView.reloadData()
    }
    
    //MARK: OBJC SELECTOR METHODS
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
    
    @objc func deleteButtonCell(_ sender: UIButton){
        if Connectivity.isConnectedToInternet() {
            let alert = UIAlertController(title: NSLocalizedString("", comment: ""), message: NSLocalizedString(LocalizedStrings.groupWillBeDeleted, comment: ""), preferredStyle: UIAlertController.Style.alert)
            
            let no = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
                // Intentionally left empty.
                // we don’t need custom behavior here (for now).
            })
            alert.addAction(no)
            let yes = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
                let arrayGet = self.groupArray[sender.tag]
                let groupServerId = arrayGet.value(forKey: keyValue.groupServerId.rawValue) as? String ?? ""
                updateGroupTypeIdResultGroupAnimal(entity: Entities.resultGroupAnimalsTblEntity,customerId: self.customerId ?? 0,serverGroupId: groupServerId,groupStatus:LocalizedStrings.capsInactiveStatus,groupStatusId:0)
                
                let fetchObject = fetchGrupExistGroupUpdate(entityName: Entities.resultGroupAnimalsTblEntity, groupID: groupServerId)
                if fetchObject.count > 0{
                    for item in fetchObject{
                        let data23 = item as? ResultGroupsAnimals
                        let animalid = data23?.animalID
                        updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ?? 0), animalID: animalid ?? "", status: LocalizedStrings.inactiveStatus)
                    }
                }
                deletegroupWithGroupId(entityName: Entities.resultGroupAnimalsTblEntity, customerId: self.customerId ?? 0, serverGroupId: groupServerId)
                deleteDataWithGroupId(entityString:Entities.resultGroupCreateTblEntity ,listId: groupServerId, customerId: Int(self.customerId ?? 0))
                self.deleteGroup(groupId: groupServerId, customerId: self.customerId ?? 0)
                self.groupArray = fetchAllDataEnteryListWithCustId(entityName: Entities.resultGroupCreateTblEntity, customerId: self.customerId ?? 0) as! [ResultGroupCreate]
                if self.groupArray.count == 0 {
                    self.message.isHidden = false
                    self.tblView.isHidden = true
                    updateMyHerdDataAllStaus(entity: Entities.resultMyherdDataTblEntity, customerId: self.customerId ?? 0, status: LocalizedStrings.inactiveStatus)
                }
                else{
                    self.message.isHidden = true
                    self.tblView.isHidden = false
                }
                self.tblView.reloadData()
            })
            alert.addAction(yes)
            DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
            })
        }
        else {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(LocalizedStrings.groupsDeletedOnline, comment: ""))
            return
        }
    }
    
    @objc func emailButtonCell(_ sender: UIButton){
        let arrayGet1 = self.groupArray[sender.tag]
        if Connectivity.isConnectedToInternet() {
            self.objApiSync.postEmailGroupList(groupName:arrayGet1.groupName ?? "",custmerId:Int64(arrayGet1.customerId),emailAdress :[emailId])
            self.view.makeToast(NSLocalizedString(LocalizedStrings.groupDetailEmailed, comment: ""), duration: 2, position: .bottom)
        }
        else {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(LocalizedStrings.connectInternetToMail, comment: ""))
            return
        }
    }
    
    @objc func checkForReachability(notification:Notification){
        let del =  UIApplication.shared.delegate as? AppDelegate
        self.statusText?.text = NSLocalizedString((del?.status)!, comment: "")
        if statusText?.text == ButtonTitles.connectedText || statusText?.text == "Conectado" {
            self.connectedBtnOutlet.isHidden = true
            self.connectionImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else {
            
            self.connectedBtnOutlet.isHidden = false
            self.connectionImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    @objc func barnButtonCell(_ sender: UIButton){
        let alert = UIAlertController(title: NSLocalizedString("", comment: ""), message: NSLocalizedString(AlertMessagesStrings.makeGroupActive, comment: ""), preferredStyle: UIAlertController.Style.alert)
        
        let no = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
            // Intentionally left empty.
            // we don’t need custom behavior here (for now).
        })
        alert.addAction(no)
        let yes = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
            if Connectivity.isConnectedToInternet() {
                
                let arrayGet1 = self.groupArray[sender.tag]
                let groupname = arrayGet1.groupName
                let desc = arrayGet1.groupDesc
                
                
                let serverID = arrayGet1.groupServerId ?? ""
                let fetchObject = fetchGrupExistGroupUpdate(entityName: Entities.resultGroupAnimalsTblEntity, groupID: serverID)
                var animalId = String()
                if fetchObject.count > 0 {
                    let  anim = fetchObject.object(at: 0) as! ResultGroupsAnimals
                    animalId = anim.animalID ?? ""
                    
                }
                
                if arrayGet1.groupStatusId ==  1 &&  arrayGet1.groupTypeId ==  1 {
                    
                    
                } else if arrayGet1.groupStatusId ==  0 &&  arrayGet1.groupTypeId ==  1  {
                    let groupOb = fetchGroupIdWithStatus(entityName: Entities.resultGroupCreateTblEntity, customerId: Int64(arrayGet1.customerId), groupStatusId: 1,groupTypeId: 1)
                    if groupOb.count > 0{
                        let objectGroup = groupOb.object(at: 0) as? ResultGroupCreate
                        let sId = objectGroup?.groupServerId ?? ""
                        let groupnameactive = objectGroup?.groupName
                        self.showIndicator(self.view, withTitle: "", and: "")
                        self.UpdateNewGroupResult( groupName: groupnameactive ?? "", groupTypeId: 1, groupId:sId,groupStatusId: 0,decs: desc ?? "", animalID: [animalId],completionHandler: { (success) -> Void in
                            
                            if success  {
                                self.UpdateNewGroupResult( groupName: groupname ?? "", groupTypeId: 1, groupId:serverID,groupStatusId: 1,decs: desc ?? "", animalID: [animalId],completionHandler: { (success) -> Void in
                                    
                                    if success {
                                        let objectGroup = groupOb.object(at: 0) as! ResultGroupCreate
                                        let sId = objectGroup.groupServerId ?? ""
                                        let status = objectGroup.groupStatus
                                        
                                        if status == LocalizedStrings.activeGroupType{
                                            updateGroupTypeIdInGroupTable(entity: Entities.resultGroupCreateTblEntity,customerId: Int64(arrayGet1.customerId) ,groupServerId: sId  ,groupStatus: LocalizedStrings.capsInactiveStatus ,groupStatusId: 0)
                                            updateGroupTypeIdResultGroupAnimal(entity: Entities.resultGroupAnimalsTblEntity,customerId: Int64(arrayGet1.customerId),serverGroupId: sId,groupStatus:LocalizedStrings.capsInactiveStatus,groupStatusId:0)
                                            let fetchObject = fetchGrupExistGroupUpdate(entityName: Entities.resultGroupAnimalsTblEntity, groupID: sId)
                                            
                                            if fetchObject.count > 0{
                                                for item in fetchObject{
                                                    let data23 = item as? ResultGroupsAnimals
                                                    let animalid = data23?.animalID
                                                    updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ?? 0), animalID: animalid ?? "", status: LocalizedStrings.inactiveStatus)
                                                }
                                            }
                                            updateGroupTypeIdInGroupTable(entity: Entities.resultGroupCreateTblEntity,customerId: Int64(arrayGet1.customerId) ,groupServerId: serverID  ,groupStatus: LocalizedStrings.activeGroupType ,groupStatusId: 1)
                                            updateGroupTypeIdResultGroupAnimal(entity: Entities.resultGroupAnimalsTblEntity,customerId: Int64(arrayGet1.customerId),serverGroupId: serverID,groupStatus:LocalizedStrings.activeGroupType,groupStatusId:1)
                                            let fetchObject1 = fetchGrupExistGroupUpdate(entityName: Entities.resultGroupAnimalsTblEntity, groupID: serverID)
                                            if fetchObject1.count > 0{
                                                for item in fetchObject1{
                                                    
                                                    let data23 = item as? ResultGroupsAnimals
                                                    let animalid = data23?.animalID
                                                    updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ?? 0), animalID: animalid ?? "", status: LocalizedStrings.banStatus)
                                                }
                                            }
                                        }
                                        else {
                                            updateGroupTypeIdInGroupTable(entity: Entities.resultGroupCreateTblEntity,customerId: Int64(arrayGet1.customerId) ,groupServerId: arrayGet1.groupServerId ?? "" ,groupStatus: LocalizedStrings.activeGroupType ,groupStatusId: 1)
                                            updateGroupTypeIdResultGroupAnimal(entity: Entities.resultGroupAnimalsTblEntity,customerId: Int64(arrayGet1.customerId),serverGroupId: serverID,groupStatus:LocalizedStrings.activeGroupType,groupStatusId:1)
                                        }
                                    }
                                    self.hideIndicator()
                                    self.tblView.reloadData()
                                })
                            }
                        })
                    }
                    else if groupOb.count == 0{
                        self.UpdateNewGroupResult( groupName: arrayGet1.groupName ?? "", groupTypeId: 1, groupId:serverID,groupStatusId: 1,decs: desc ?? "", animalID: [animalId],completionHandler: { (success) -> Void in
                            if success {
                                updateGroupTypeIdInGroupTable(entity: Entities.resultGroupCreateTblEntity,customerId: Int64(arrayGet1.customerId) ,groupServerId: arrayGet1.groupServerId ?? "" ,groupStatus: LocalizedStrings.activeGroupType ,groupStatusId: 1)
                                updateGroupTypeIdResultGroupAnimal(entity: Entities.resultGroupAnimalsTblEntity,customerId: Int64(arrayGet1.customerId),serverGroupId: serverID,groupStatus:LocalizedStrings.activeGroupType,groupStatusId:1)
                                updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ?? 0), animalID: animalId, status: LocalizedStrings.banStatus)
                                
                            }
                            self.tblView.reloadData()
                        })
                    }
                }
                else if arrayGet1.groupStatusId ==  1 &&  arrayGet1.groupTypeId ==  0 {
                    updateGroupTypeIdInGroupTable(entity: Entities.resultGroupCreateTblEntity,customerId: Int64(arrayGet1.customerId) ,groupServerId: arrayGet1.groupServerId ?? "" ,groupStatus: LocalizedStrings.capsInactiveStatus ,groupStatusId: 0)
                }
                else if  arrayGet1.groupStatusId ==  0 && arrayGet1.groupTypeId ==  0{
                    let groupOb = fetchGroupIdWithStatus(entityName: Entities.resultGroupCreateTblEntity, customerId: Int64(arrayGet1.customerId), groupStatusId: 1,groupTypeId: 0)
                    if groupOb.count > 0 {
                        let objectGroup = groupOb.object(at: 0) as! ResultGroupCreate
                        let sId = objectGroup.groupServerId ?? ""
                        let dollerGname = objectGroup.groupName
                        self.showIndicator(self.view, withTitle: "", and: "")
                        self.UpdateNewGroupResult( groupName: dollerGname ?? "", groupTypeId: 0, groupId:sId,groupStatusId: 0,decs: desc ?? "", animalID: [animalId],completionHandler: { (success) -> Void in
                            
                            if success {
                                self.UpdateNewGroupResult( groupName: arrayGet1.groupName ?? "", groupTypeId: 0, groupId:serverID,groupStatusId: 1,decs: desc ?? "", animalID: [animalId],completionHandler: { (success) -> Void in
                                    
                                    if success {
                                        let objectGroup = groupOb.object(at: 0) as! ResultGroupCreate
                                        let sId = objectGroup.groupServerId ?? ""
                                        let status = objectGroup.groupStatus
                                        if status == LocalizedStrings.activeGroupType{
                                            updateGroupTypeIdInGroupTable(entity: Entities.resultGroupCreateTblEntity,customerId: Int64(arrayGet1.customerId) ,groupServerId: sId  ,groupStatus: LocalizedStrings.capsInactiveStatus ,groupStatusId: 0)
                                            updateGroupTypeIdResultGroupAnimal(entity: Entities.resultGroupAnimalsTblEntity,customerId: Int64(arrayGet1.customerId),serverGroupId: sId,groupStatus:LocalizedStrings.capsInactiveStatus,groupStatusId:0)
                                            let fetchObject = fetchGrupExistGroupUpdate(entityName: Entities.resultGroupAnimalsTblEntity, groupID: sId)
                                            if fetchObject.count > 0{
                                                for item in fetchObject{
                                                    let data23 = item as? ResultGroupsAnimals
                                                    let animalid = data23?.animalID
                                                    updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ?? 0), animalID: animalid ?? "", status: LocalizedStrings.inactiveStatus)
                                                }
                                            }
                                            
                                            updateGroupTypeIdInGroupTable(entity: Entities.resultGroupCreateTblEntity,customerId: Int64(arrayGet1.customerId) ,groupServerId: serverID  ,groupStatus: LocalizedStrings.activeGroupType ,groupStatusId: 1)
                                            updateGroupTypeIdResultGroupAnimal(entity: Entities.resultGroupAnimalsTblEntity,customerId: Int64(arrayGet1.customerId),serverGroupId: serverID,groupStatus:LocalizedStrings.activeGroupType,groupStatusId:1)
                                            let fetchObject1 = fetchGrupExistGroupUpdate(entityName: Entities.resultGroupAnimalsTblEntity, groupID: serverID)
                                            if fetchObject1.count > 0{
                                                for item in fetchObject1{
                                                    let data23 = item as? ResultGroupsAnimals
                                                    let animalid = data23?.animalID
                                                    updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ?? 0), animalID: animalid ?? "", status: LocalizedStrings.dollerStatus)
                                                }
                                            }
                                        }
                                        else {
                                            updateGroupTypeIdInGroupTable(entity: Entities.resultGroupCreateTblEntity,customerId: Int64(arrayGet1.customerId) ,groupServerId: arrayGet1.groupServerId ?? "" ,groupStatus: LocalizedStrings.activeGroupType ,groupStatusId: 1)
                                            updateGroupTypeIdResultGroupAnimal(entity: Entities.resultGroupAnimalsTblEntity,customerId: Int64(arrayGet1.customerId),serverGroupId: serverID,groupStatus:LocalizedStrings.activeGroupType,groupStatusId:1)
                                        }
                                        
                                        updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ?? 0), animalID: animalId, status: LocalizedStrings.dollerStatus)
                                    }
                                    self.hideIndicator()
                                    self.tblView.reloadData()
                                })
                            }
                        })
                    }
                    
                    else if groupOb.count == 0{
                        self.UpdateNewGroupResult( groupName: arrayGet1.groupName ?? "", groupTypeId: 0, groupId:serverID,groupStatusId: 1,decs: desc ?? "", animalID: [animalId],completionHandler: { (success) -> Void in
                            if success {
                                updateGroupTypeIdInGroupTable(entity: Entities.resultGroupCreateTblEntity,customerId: Int64(arrayGet1.customerId) ,groupServerId: arrayGet1.groupServerId ?? "" ,groupStatus: LocalizedStrings.activeGroupType ,groupStatusId: 1)
                                updateGroupTypeIdResultGroupAnimal(entity: Entities.resultGroupAnimalsTblEntity,customerId: Int64(arrayGet1.customerId),serverGroupId: serverID,groupStatus:LocalizedStrings.activeGroupType,groupStatusId:1)
                                updateMyHerdDataStaus(entity: Entities.resultMyherdDataTblEntity, customerId:  Int64(self.customerId ?? 0), animalID: animalId, status: LocalizedStrings.dollerStatus)
                            }
                            self.tblView.reloadData()
                        })
                    }
                }
            }
            else {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.groupsCanBeMadeOnline, comment: ""))
                return
            }
        })
        alert.addAction(yes)
        self.present(alert, animated: true)
    }
    
    //MARK: METHODS AND FUNCTIONS
    func initialNetworkCheck(){
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del = UIApplication.shared.delegate as? AppDelegate
        self.statusText?.text = NSLocalizedString((del?.status)!, comment: "")
        if statusText?.text == ButtonTitles.connectedText || statusText?.text == "Conectado" {
            self.connectedBtnOutlet.isHidden = true
            self.connectionImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else {
            self.connectedBtnOutlet.isHidden = false
            self.connectionImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    func deleteGroup(groupId:String,customerId:Int64) {
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict = [LocalizedStrings.authorizationHeader: accessToken!,LocalizedStrings.contentType : LocalizedStrings.formURLEncoded]
        let urlString = Configuration.Dev(packet: ApiKeys.deleteGroup.rawValue + "/\(groupId)").getUrl()
        let parameters = [String: Any]()
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "DELETE"
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
                self.view.makeToast(NSLocalizedString(LocalizedStrings.groupDeleted, comment: ""), duration: 2, position: .bottom)
            }
        }
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
                
            } else {
                self.hideIndicator()
            }
        }
        return
    }
    
    //MARK: IB ACTIONS
    @IBAction func createNewGroupAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.resultCreateGroupVC) as? ResultCreateGroupViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func bckScreenNavigate(_ sender: Any) {
        UserDefaults.standard.setValue("true", forKey: keyValue.fromManagement.rawValue)
        self.navigationController?.popViewController(animated: false)
        
    }
    
    @IBAction func bckBtnAction(_ sender: Any) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func menuBtnClick(_ sender: Any) {
        self.view.makeCorner(withRadius: 40)
        self.sideMenuViewController?.presentRightMenuViewController()
    }
    
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
        vc?.module = LocalizedStrings.resultsText.localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
    }
}

//MARK: TEXTFIELD DELEGATES
extension MyManagementGroupController :UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let currentString: NSString = searchTextField.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        if newString != "" {
            groupArray = fetchOrdersWithMyGroupFilter(entityName: Entities.resultGroupCreateTblEntity,groupName:groupName, searchText: (newString.uppercased) as String,customerId:customerId ?? 0) as! [ResultGroupCreate]
            if groupArray.count > 0 {
                message.isHidden = true
                tblView.isHidden = false
                tblView.reloadData()
            }
            
            if groupArray.count == 0{
                message.isHidden = false
                tblView.isHidden = true
                tblView.reloadData()
            }
            
        } else {
            message.isHidden = true
            tblView.isHidden = false
            groupArray = fetchOrdersWithMyGroupFilter(entityName: Entities.resultGroupCreateTblEntity,groupName:groupName,searchText: (newString.uppercased) as String,customerId:customerId ?? 0) as! [ResultGroupCreate]
            if groupArray.count != 0{
                groupArray = fetchAllDataEnteryListWithCustId(entityName: Entities.resultGroupCreateTblEntity, customerId: customerId ?? 0) as! [ResultGroupCreate]
            }
            else{
                groupArray = fetchAllDataEnteryListWithCustId(entityName: Entities.resultGroupCreateTblEntity, customerId: customerId ?? 0) as! [ResultGroupCreate]
            }
            tblView.reloadData()
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: TABLEVIE DATASOURCE AND DELEGATES
extension MyManagementGroupController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groupArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyManagementGroupCell = self.tblView.dequeueReusableCell(withIdentifier: "cell") as! MyManagementGroupCell
        let groupObject = self.groupArray[indexPath.row]
        cell.groupNameLabel?.text = groupObject.groupName
        cell.groupDescLbl?.text = groupObject.groupDesc
        
        if groupObject.groupTypeId == 1 && groupObject.groupStatusId == 1 {
            cell.barnBtnOutlet.setImage(UIImage(named: ImageNames.activeBarnImg), for: .normal)
            cell.barnBtnOutlet.isUserInteractionEnabled = false
        }
        
        else if groupObject.groupTypeId == 1 && groupObject.groupStatusId == 0 {
            cell.barnBtnOutlet.setImage(UIImage(named: ImageNames.inactiveBarnImg), for: .normal)
            cell.barnBtnOutlet.isUserInteractionEnabled = true
        }
        
        if groupObject.groupTypeId == 0 && groupObject.groupStatusId == 1 {
            cell.barnBtnOutlet.setImage(UIImage(named: ImageNames.activeDollarImg), for: .normal)
            cell.barnBtnOutlet.isUserInteractionEnabled = false
        }
        else if groupObject.groupTypeId == 0 && groupObject.groupStatusId == 0{
            cell.barnBtnOutlet.setImage(UIImage(named: ImageNames.inactiveDollarImg), for: .normal)
            cell.barnBtnOutlet.isUserInteractionEnabled = true
            
        }
        cell.deleteBtnOutlet.tag = indexPath.row
        cell.deleteBtnOutlet.addTarget(self, action: #selector(deleteButtonCell(_:)), for: .touchUpInside)
        cell.emailBtnOutlet.tag = indexPath.row
        cell.emailBtnOutlet.addTarget(self, action: #selector(emailButtonCell(_:)), for: .touchUpInside)
        cell.barnBtnOutlet.tag = indexPath.row
        cell.barnBtnOutlet.addTarget(self, action: #selector(barnButtonCell(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let groupObject = self.groupArray[indexPath.row]
        UserDefaults.standard.set(groupObject.groupStatusId, forKey: keyValue.checkActiveInactive.rawValue)
        UserDefaults.standard.set(keyValue.groupKey.rawValue, forKey: keyValue.checkGroup.rawValue)
        let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.GroupDetailsVC) as? GroupDetailsViewController
        vc?.searchByAnimal = searchByAnimal
        vc?.groupName = groupObject.groupName ?? ""
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
