//
//  MyManagementGroupController.swift
//  SearchPoint
//
//  Created by Mobile Programming on 08/03/21.
//

import UIKit
import Alamofire




class MyManagementGroupController: UIViewController {
   
    
    var screenBackSave = Bool()
    var objApiSync = ApiSyncList()
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var myManagmentLblTitle: UILabel!
    @IBOutlet weak var tblView: UITableView!
    var groupArray = [ResultGroupCreate]()
    @IBOutlet weak var connectedBtnOutlet: UIButton!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var connectionImg: UIImageView!
   // @IBOutlet weak var message: UILabel!
   // var delteHomeViewData : ReturnDataBck?
    @IBOutlet weak var bckBtnOutlet: customButton!
    @IBOutlet weak var searchTextField: UITextField!
    var customerId:Int64?
    var userId : Int?
    var langId = Int()
    var orderId = Int()
    var emailId = String()
    var updateGruop = UpdateGroupModel()
    var groupName = String()
    var value = 0
    
    var group = DispatchGroup()
    var saveAnimalGroupUpdatedViewModel: ManagementGroupVM?
    
    @IBOutlet weak var createNewGroupOutlet: customButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialNetworkCheck()
        UserDefaults.standard.removeObject(forKey: "FromManagment")
        self.navigationController?.navigationBar.isHidden = true
        
        DispatchQueue.global(qos: .background).sync {
            self.view.isUserInteractionEnabled = false
            self.showIndicator(self.view, withTitle: NSLocalizedString("Syncing data...", comment: ""), and: "")
            group.enter()
            self.saveAnimalGroupUpdatedViewModel = ManagementGroupVM( callBack: self.leavegroupapi)
            self.saveAnimalGroupUpdatedViewModel?.callAnimalGroupsForCustomerUpdateApi()
            
            self.customerId = UserDefaults.standard.value(forKey: "currentActiveCustomerId") as? Int64
            self.userId = UserDefaults.standard.value(forKey: "userId") as? Int
            self.orderId = UserDefaults.standard.integer(forKey: "orderId")
            let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
            self.emailId = appDelegate?.keychain_valueForKey("userName") as! String
            
        }
    }

    @objc func methodOfReceivedNotification(notification: Notification)
       {
          
           if value == 0
                      {
                      UserDefaults.standard.set("false", forKey: "FirstLogin")
                      let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                      let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                      self.navigationController?.pushViewController(newViewController, animated: true)
                      self.hideIndicator()
                         value = value + 1
                     }
   //        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController")), animated: true)
          
       }
    override func viewWillAppear(_ animated: Bool) {
        
               NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
               

        UserDefaults.standard.set("", forKey: "groupoffid")
        UserDefaults.standard.set("", forKey: "grouponformid")
        UserDefaults.standard.set("", forKey: "groupnamesave")
        UserDefaults.standard.set("", forKey: "groupstatus")
        UserDefaults.standard.set("", forKey: "grouptypeid")
        UserDefaults.standard.set("", forKey: "groupdetails")
        searchTextField.text = ""
        UserDefaults.standard.removeObject(forKey: "dashboardcall")
        UserDefaults.standard.removeObject(forKey: "scrollIncrement")

        self.langId = UserDefaults.standard.value(forKey: "lngId") as? Int ?? 1
        
          myManagmentLblTitle.text = "My Management Groups".localized
            bckBtnOutlet.setTitle(NSLocalizedString("Back", comment: ""), for: .normal)
          createNewGroupOutlet.setTitle("Create Group".localized, for: .normal)
       
        
        groupArray = fetchAllDataEnteryListWithCustId(entityName: "ResultGroupCreate", customerId: customerId ?? 0) as! [ResultGroupCreate]
        
        if groupArray.count == 0
        {
            message.isHidden = false
            tblView.isHidden = true
        }
        else
        {
            message.isHidden = true
            tblView.isHidden = false
        }
        tblView.reloadData()
    }
    
    @IBAction func createNewGroupAction(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ResultCreateGroupViewController") as? ResultCreateGroupViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func bckScreenNavigate(_ sender: Any) {
        
        UserDefaults.standard.setValue("true", forKey: "FromManagment")
        self.navigationController?.popViewController(animated: false)
      
        if screenBackSave == true {
            
           // self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "MyHerdResultsViewController")), animated: true)
       self.navigationController?.popViewController(animated: false)

        } else {
            UserDefaults.standard.setValue("true", forKey: "frommangcreategroup")
         // self.navigationController?.popViewController(animated: true)
          // self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "MyHerdResultsViewController")), animated: true)
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyHerdResultsViewController") as? MyHerdResultsViewController

            vc!.bckRetain = true
            self.navigationController?.pushViewController(vc!, animated: false)
        }
    }
    @IBAction func bckBtnAction(_ sender: Any) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
//        UserDefaults.standard.setValue("true", forKey: "FromManagment")
//        self.navigationController?.popViewController(animated: false)
//
//        if screenBackSave == true {
//
//           // self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "MyHerdResultsViewController")), animated: true)
//       self.navigationController?.popViewController(animated: false)
//
//        } else {
//            UserDefaults.standard.setValue("true", forKey: "frommangcreategroup")
//         // self.navigationController?.popViewController(animated: true)
//          // self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "MyHerdResultsViewController")), animated: true)
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyHerdResultsViewController") as? MyHerdResultsViewController
//
//            vc!.bckRetain = true
//            self.navigationController?.pushViewController(vc!, animated: false)
//        }
        
        
    }
    
    @IBAction func menuBtnClick(_ sender: Any) {
        
        self.view.makeCorner(withRadius: 40)
        self.sideMenuViewController?.presentRightMenuViewController()

    }
    
}
extension MyManagementGroupController :UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let currentString: NSString = searchTextField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        
        if newString != "" {
            
            groupArray = fetchOrdersWithMyGroupFilter(entityName: "ResultGroupCreate",groupName:groupName, searchText: (newString.uppercased) as String,customerId:customerId ?? 0) as! [ResultGroupCreate]
               
            if groupArray.count > 0 {
                message.isHidden = true
                tblView.isHidden = false
            tblView.reloadData()
            }
        
            if groupArray.count == 0{
                message.isHidden = false
                tblView.isHidden = true
               // self.view.makeToast(NSLocalizedString("No records found", comment: ""), duration: 0.5, position: .center)
                tblView.reloadData()
            }
            
        } else {
            message.isHidden = true
            tblView.isHidden = false
            groupArray = fetchOrdersWithMyGroupFilter(entityName: "ResultGroupCreate",groupName:groupName,searchText: (newString.uppercased) as String,customerId:customerId ?? 0) as! [ResultGroupCreate]
            if groupArray.count != 0
            {
                groupArray = fetchAllDataEnteryListWithCustId(entityName: "ResultGroupCreate", customerId: customerId ?? 0) as! [ResultGroupCreate]
            }
            else
            {
                groupArray = fetchAllDataEnteryListWithCustId(entityName: "ResultGroupCreate", customerId: customerId ?? 0) as! [ResultGroupCreate] 
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


extension MyManagementGroupController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groupArray.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MyManagementGroupCell = self.tblView.dequeueReusableCell(withIdentifier: "cell") as! MyManagementGroupCell
        
        let groupObject = self.groupArray[indexPath.row]
        
        cell.groupNameLabel?.text = groupObject.groupName
        cell.groupDescLbl?.text = groupObject.groupDesc
        
        
        if groupObject.groupTypeId == 1 && groupObject.groupStatusId == 1 {

            cell.barnBtnOutlet.setImage(UIImage(named: "active_barn"), for: .normal)
            cell.barnBtnOutlet.isUserInteractionEnabled = false

        } else if groupObject.groupTypeId == 1 && groupObject.groupStatusId == 0 {
            cell.barnBtnOutlet.setImage(UIImage(named: "inactive_barn"), for: .normal)
            cell.barnBtnOutlet.isUserInteractionEnabled = true
        }
        
        if groupObject.groupTypeId == 0 && groupObject.groupStatusId == 1 {
            cell.barnBtnOutlet.setImage(UIImage(named: "active_dollar"), for: .normal)
            cell.barnBtnOutlet.isUserInteractionEnabled = false

        } else if groupObject.groupTypeId == 0 && groupObject.groupStatusId == 0{
            cell.barnBtnOutlet.setImage(UIImage(named: "inactive_dollar"), for: .normal)
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
        
        
        var groupObject = self.groupArray[indexPath.row]
        
        
        
        UserDefaults.standard.set(groupObject.groupStatusId, forKey: "checkactive/inactive")
        UserDefaults.standard.set("group", forKey: "checkgroup")

            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "GroupDetailsViewController") as? GroupDetailsViewController
          //  vc?.deletionDelegate = self
            vc?.groupName = groupObject.groupName ?? ""
            self.navigationController?.pushViewController(vc!, animated: true)
            
     
    }
    

    
    @objc func deleteButtonCell(_ sender: UIButton){
        
        if Connectivity.isConnectedToInternet() {

            let alert = UIAlertController(title: NSLocalizedString("", comment: ""), message: NSLocalizedString("This Group will be deleted for all the users associated with this customer. Do you want to continue?", comment: ""), preferredStyle: UIAlertController.Style.alert)

                 let no = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
                 })
                 alert.addAction(no)
                 let yes = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
                    
                    
                    let arrayGet = self.groupArray[sender.tag]
                    let groupId = arrayGet.value(forKey: "groupId") as? Int
                    let groupServerId = arrayGet.value(forKey: "groupServerId") as? String ?? ""
                   updateGroupTypeIdResultGroupAnimal(entity: "ResultGroupsAnimals",customerId: self.customerId ?? 0,serverGroupId: groupServerId,groupStatus:"Inactive",groupStatusId:0)
                     let fetchObject = fetchGrupExistGroupUpdate(entityName: "ResultGroupsAnimals", groupID: groupServerId)
                     
                     if fetchObject.count > 0{
                     for item in fetchObject{
                         
                         let data23 = item as? ResultGroupsAnimals
                         let animalid = data23?.animalID
                         updateMyHerdDataStaus(entity: "ResultMyHerdData", customerId:  Int64(self.customerId ?? 0), animalID: animalid ?? "", status: "inactive")
                     }
                     }
                   // let fetchletmalGroupExist = deleteAnimalWithGroupId(entityName: "ResultGroupsAnimals", customerId: self.customerId ?? 0,serverGroupId:groupServerId)
                     deletegroupWithGroupId(entityName: "ResultGroupsAnimals", customerId: self.customerId ?? 0, serverGroupId: groupServerId)
                    deleteDataWithGroupId(entityString:"ResultGroupCreate" ,listId: groupServerId, customerId: Int(self.customerId ?? 0))
                    
                     
                  
                    self.deleteGroup(groupId: groupServerId, customerId: self.customerId ?? 0)
                    self.groupArray = fetchAllDataEnteryListWithCustId(entityName: "ResultGroupCreate", customerId: self.customerId ?? 0) as! [ResultGroupCreate]
                     
                     
                    if self.groupArray.count == 0 {
                        
                            self.message.isHidden = false
                        self.tblView.isHidden = true
                           
                        
                        updateMyHerdDataAllStaus(entity: "ResultMyHerdData", customerId: self.customerId ?? 0, status: "inactive")
                   }
                    else
                    {
                        self.message.isHidden = true
                        self.tblView.isHidden = false
                    }
                    self.tblView.reloadData()
                    

                 })//
                 alert.addAction(yes)
                 DispatchQueue.main.async(execute: {
                    self.present(alert, animated: true)

            })
               } else {
                   
                   CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString("Groups can only be deleted online.You cannot delete the group offline.", comment: ""))
                   return
               }
       // deleteRecordFromDatabase(entityName: "ResultGroupCreate")
      //  UserDefaults.standard.removeObject(forKey: "notificationcheck")
       
    }
    
    @objc func emailButtonCell(_ sender: UIButton){
       // UserDefaults.standard.removeObject(forKey: "notificationcheck")
        let arrayGet1 = self.groupArray[sender.tag]
        
        if Connectivity.isConnectedToInternet() {

            self.objApiSync.postEmailGroupList(groupName:arrayGet1.groupName ?? "",custmerId:Int64(arrayGet1.customerId),emailAdress :[emailId])
            
            self.view.makeToast(NSLocalizedString("Group details emailed successfully", comment: ""), duration: 2, position: .bottom)
            
        } else {
            
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString("Please connect to the internet to email the group.", comment: ""))
            return
        }
    }
    @objc func checkForReachability(notification:Notification){
        
        let del =  UIApplication.shared.delegate as? AppDelegate
        
        self.statusText?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if statusText?.text == "Connected".localized{
            self.connectedBtnOutlet.isHidden = true
            self.connectionImg.image = UIImage(named: "status_online_sign")
        }
        else {
            
            self.connectedBtnOutlet.isHidden = false
            self.connectionImg.image = UIImage(named: "status_offline")
            
        }
    }
    func initialNetworkCheck(){
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del = UIApplication.shared.delegate as? AppDelegate
        self.statusText?.text = NSLocalizedString((del?.status)!, comment: "")
        if statusText?.text == "Connected".localized {
            self.connectedBtnOutlet.isHidden = true
            self.connectionImg.image = UIImage(named: "status_online_sign")
        }
        else {
            self.connectedBtnOutlet.isHidden = false
            self.connectionImg.image = UIImage(named: "status_offline")
            
        }
    }
    @objc func barnButtonCell(_ sender: UIButton){
       
        let alert = UIAlertController(title: NSLocalizedString("", comment: ""), message: NSLocalizedString("Are you sure you want to make this group active?", comment: ""), preferredStyle: UIAlertController.Style.alert)

             let no = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
             })
             alert.addAction(no)
             let yes = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
                if Connectivity.isConnectedToInternet() {

                    let arrayGet1 = self.groupArray[sender.tag]
                    let groupname = arrayGet1.groupName
                    let  grouptype = arrayGet1.groupTypeId
                    let groupstatus = arrayGet1.groupStatusId
                    let desc = arrayGet1.groupDesc
                    let groupid = arrayGet1.groupId
                    
                    let groupOb = fetchGroupIdWithStatus(entityName: "ResultGroupCreate", customerId: Int64(arrayGet1.customerId), groupStatusId: 1,groupTypeId: 1)
    //
                    var serverID = arrayGet1.groupServerId ?? ""
                    let fetchObject = fetchGrupExistGroupUpdate(entityName: "ResultGroupsAnimals", groupID: serverID)
                    var animalId = String()
                    if fetchObject.count > 0 {
                      let  anim = fetchObject.object(at: 0) as! ResultGroupsAnimals
                        animalId = anim.animalID ?? ""
                        
                    }

                    if arrayGet1.groupStatusId ==  1 &&  arrayGet1.groupTypeId ==  1 {
                        
                        
                    } else if arrayGet1.groupStatusId ==  0 &&  arrayGet1.groupTypeId ==  1  {
                        
                        let groupOb = fetchGroupIdWithStatus(entityName: "ResultGroupCreate", customerId: Int64(arrayGet1.customerId), groupStatusId: 1,groupTypeId: 1)
                        if groupOb.count > 0{
                        let objectGroup = groupOb.object(at: 0) as? ResultGroupCreate
                        let sId = objectGroup?.groupServerId ?? ""
                        let status = objectGroup?.groupStatus
                        let groupnameactive = objectGroup?.groupName
                        let grouptypeidact = objectGroup?.groupTypeId
                        self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")

                            self.UpdateNewGroupResult( groupName: groupnameactive ?? "", groupTypeId: 1, groupId:sId,groupStatusId: 0,decs: desc ?? "", animalID: [animalId],completionHandler: { (success) -> Void in
                        
                                                        
                            if success == true {
                                
                                
                                self.UpdateNewGroupResult( groupName: groupname ?? "", groupTypeId: 1, groupId:serverID,groupStatusId: 1,decs: desc ?? "", animalID: [animalId],completionHandler: { (success) -> Void in
                               
                                    if success == true{
                                        
                                       // if groupOb.count > 0   {
                                            let objectGroup = groupOb.object(at: 0) as! ResultGroupCreate
                                            let sId = objectGroup.groupServerId ?? ""
                                            let status = objectGroup.groupStatus
                                            let groupnameactive = objectGroup.groupName
                                            let grouptypeidact = objectGroup.groupTypeId
                                        //let gid = objectGroup.groupTypeId
                                        
                                      if status == "Active"{
                                                updateGroupTypeIdInGroupTable(entity: "ResultGroupCreate",customerId: Int64(arrayGet1.customerId) ,groupServerId: sId  ,groupStatus: "Inactive" ,groupStatusId: 0)
                                                
                                                updateGroupTypeIdResultGroupAnimal(entity: "ResultGroupsAnimals",customerId: Int64(arrayGet1.customerId),serverGroupId: sId,groupStatus:"Inactive",groupStatusId:0)
                                               
                    //                            self.UpdateNewGroupResult( groupName: groupnameactive ?? "", groupTypeId: Int(grouptypeidact), groupId:sId,groupStatusId: 0,decs: desc ?? "", animalID: [animalId],completionHandler: { (success) -> Void in
                    //
                    //
                    //
                    //
                    //                           })
                                                let fetchObject = fetchGrupExistGroupUpdate(entityName: "ResultGroupsAnimals", groupID: sId)
                                                
                                                if fetchObject.count > 0{
                                                for item in fetchObject{
                                                    
                                                    let data23 = item as? ResultGroupsAnimals
                                                    let animalid = data23?.animalID
                                                    updateMyHerdDataStaus(entity: "ResultMyHerdData", customerId:  Int64(self.customerId ?? 0), animalID: animalid ?? "", status: "inactive")
                                                }
                                                }
                                                //updateMyHerdDatByGroup(entity: "ResultMyHerdData", customerId:  Int64(self.customerId ?? 0), status: "ban")
                                               
                                                
                                                updateGroupTypeIdInGroupTable(entity: "ResultGroupCreate",customerId: Int64(arrayGet1.customerId) ,groupServerId: serverID  ,groupStatus: "Active" ,groupStatusId: 1)
                                                updateGroupTypeIdResultGroupAnimal(entity: "ResultGroupsAnimals",customerId: Int64(arrayGet1.customerId),serverGroupId: serverID,groupStatus:"Active",groupStatusId:1)
                                                
                                              
                                                let fetchObject1 = fetchGrupExistGroupUpdate(entityName: "ResultGroupsAnimals", groupID: serverID)
                                                if fetchObject1.count > 0{
                                                for item in fetchObject1{
                                                    
                                                    let data23 = item as? ResultGroupsAnimals
                                                    let animalid = data23?.animalID
                                                    updateMyHerdDataStaus(entity: "ResultMyHerdData", customerId:  Int64(self.customerId ?? 0), animalID: animalid ?? "", status: "ban")
                                                }
                                                }
                                            }
                                            else {
                                                updateGroupTypeIdInGroupTable(entity: "ResultGroupCreate",customerId: Int64(arrayGet1.customerId) ,groupServerId: arrayGet1.groupServerId ?? "" ,groupStatus: "Active" ,groupStatusId: 1)
                                                updateGroupTypeIdResultGroupAnimal(entity: "ResultGroupsAnimals",customerId: Int64(arrayGet1.customerId),serverGroupId: serverID,groupStatus:"Active",groupStatusId:1)
                                               
                                            }
                                            
                                      
                                    //}
                                        
                                    }
                                    self.hideIndicator()
                                    self.tblView.reloadData()
                               
                                                  })
                               
                                
                            
                            
                            
                            }
                        
                            
                            
                            })
                       
                        
    //                    self.UpdateNewGroupResult( groupName: groupname ?? "", groupTypeId: Int(grouptype), groupId:serverID,groupStatusId: 1,decs: desc ?? "", animalID: [animalId],completionHandler: { (success) -> Void in
    //
    //
    //
    //
    //                   })
    //
                    }
                        else if groupOb.count == 0
                        {
                            self.UpdateNewGroupResult( groupName: arrayGet1.groupName ?? "", groupTypeId: 1, groupId:serverID,groupStatusId: 1,decs: desc ?? "", animalID: [animalId],completionHandler: { (success) -> Void in

                               if success == true{
                                updateGroupTypeIdInGroupTable(entity: "ResultGroupCreate",customerId: Int64(arrayGet1.customerId) ,groupServerId: arrayGet1.groupServerId ?? "" ,groupStatus: "Active" ,groupStatusId: 1)
                                updateGroupTypeIdResultGroupAnimal(entity: "ResultGroupsAnimals",customerId: Int64(arrayGet1.customerId),serverGroupId: serverID,groupStatus:"Active",groupStatusId:1)
                                   updateMyHerdDataStaus(entity: "ResultMyHerdData", customerId:  Int64(self.customerId ?? 0), animalID: animalId, status: "ban")
                                   
                               }
                               self.tblView.reloadData()
                           })
                        }
                    }
                    
                    else if arrayGet1.groupStatusId ==  1 &&  arrayGet1.groupTypeId ==  0 {

                        updateGroupTypeIdInGroupTable(entity: "ResultGroupCreate",customerId: Int64(arrayGet1.customerId) ,groupServerId: arrayGet1.groupServerId ?? "" ,groupStatus: "Inactive" ,groupStatusId: 0)

                    } else if  arrayGet1.groupStatusId ==  0 && arrayGet1.groupTypeId ==  0{
                        
                        
                        
                        let groupOb = fetchGroupIdWithStatus(entityName: "ResultGroupCreate", customerId: Int64(arrayGet1.customerId), groupStatusId: 1,groupTypeId: 0)
                        if groupOb.count > 0 {
                        let objectGroup = groupOb.object(at: 0) as! ResultGroupCreate
                        let sId = objectGroup.groupServerId ?? ""
                        let status = objectGroup.groupStatus
                        let dollerGname = objectGroup.groupName
                        self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                            self.UpdateNewGroupResult( groupName: dollerGname ?? "", groupTypeId: 0, groupId:sId,groupStatusId: 0,decs: desc ?? "", animalID: [animalId],completionHandler: { (success) -> Void in
                        
                                                if success == true{
                                                    
                                                    self.UpdateNewGroupResult( groupName: arrayGet1.groupName ?? "", groupTypeId: 0, groupId:serverID,groupStatusId: 1,decs: desc ?? "", animalID: [animalId],completionHandler: { (success) -> Void in
                                
                                                        if success == true{
                                                           
                                                                let objectGroup = groupOb.object(at: 0) as! ResultGroupCreate
                                                                let sId = objectGroup.groupServerId ?? ""
                                                                let status = objectGroup.groupStatus
                                                            //let gid = objectGroup.groupTypeId
                                                            
                                                                if status == "Active"{
                                                                    updateGroupTypeIdInGroupTable(entity: "ResultGroupCreate",customerId: Int64(arrayGet1.customerId) ,groupServerId: sId  ,groupStatus: "Inactive" ,groupStatusId: 0)
                                                                    
                                                                    updateGroupTypeIdResultGroupAnimal(entity: "ResultGroupsAnimals",customerId: Int64(arrayGet1.customerId),serverGroupId: sId,groupStatus:"Inactive",groupStatusId:0)
                                        //                            self.UpdateNewGroupResult( groupName: objectGroup.groupName ?? "", groupTypeId: Int(objectGroup.groupTypeId), groupId:sId,groupStatusId:0,decs: desc ?? "", animalID: [animalId],completionHandler: { (success) -> Void in
                                        //
                                        //
                                        //
                                        //
                                        //                           })
                                                                    
                                                                    let fetchObject = fetchGrupExistGroupUpdate(entityName: "ResultGroupsAnimals", groupID: sId)
                                                                   
                                                                    
                                                                    if fetchObject.count > 0{
                                                                    for item in fetchObject{
                                                                        
                                                                        let data23 = item as? ResultGroupsAnimals
                                                                        let animalid = data23?.animalID
                                                                        updateMyHerdDataStaus(entity: "ResultMyHerdData", customerId:  Int64(self.customerId ?? 0), animalID: animalid ?? "", status: "inactive")
                                                                        
                                                                    }
                                                                    }
                                                                    //updateMyHerdDatByGroup(entity: "ResultMyHerdData", customerId:  Int64(self.customerId ?? 0), status: "ban")
                                                                   
                                                                    
                                                                    updateGroupTypeIdInGroupTable(entity: "ResultGroupCreate",customerId: Int64(arrayGet1.customerId) ,groupServerId: serverID  ,groupStatus: "Active" ,groupStatusId: 1)
                                                                    updateGroupTypeIdResultGroupAnimal(entity: "ResultGroupsAnimals",customerId: Int64(arrayGet1.customerId),serverGroupId: serverID,groupStatus:"Active",groupStatusId:1)
                                                                    let fetchObject1 = fetchGrupExistGroupUpdate(entityName: "ResultGroupsAnimals", groupID: serverID)
                                                                    if fetchObject1.count > 0{
                                                                    for item in fetchObject1{
                                                                        
                                                                        let data23 = item as? ResultGroupsAnimals
                                                                        let animalid = data23?.animalID
                                                                        updateMyHerdDataStaus(entity: "ResultMyHerdData", customerId:  Int64(self.customerId ?? 0), animalID: animalid ?? "", status: "doller")
                                                                    }
                                                                    }
                                                                }
                                                                else {
                                                                    updateGroupTypeIdInGroupTable(entity: "ResultGroupCreate",customerId: Int64(arrayGet1.customerId) ,groupServerId: arrayGet1.groupServerId ?? "" ,groupStatus: "Active" ,groupStatusId: 1)
                                                                    updateGroupTypeIdResultGroupAnimal(entity: "ResultGroupsAnimals",customerId: Int64(arrayGet1.customerId),serverGroupId: serverID,groupStatus:"Active",groupStatusId:1)
                                                                   
                                                                }
                                                                
                                                                updateMyHerdDataStaus(entity: "ResultMyHerdData", customerId:  Int64(self.customerId ?? 0), animalID: animalId, status: "doller")
                                                       // }
                                                            
                                                            
                                                        }
                                                        
                                                        self.hideIndicator()
                                                        self.tblView.reloadData()
                                                        
                                
                                                   })
                                                    
                                                }
                                               
                        
                        
                                           })
    //                    self.UpdateNewGroupResult( groupName: groupnameactive ?? "", groupTypeId: 1, groupId:sId,groupStatusId: 0,decs: desc ?? "", animalID: [animalId],completionHandler: { (success) -> Void in
    //
    //
    //                        if success == true {
                        
                        
                        
    //                    self.UpdateNewGroupResult( groupName: groupname ?? "", groupTypeId: Int(grouptype), groupId:serverID,groupStatusId: 1,decs: desc ?? "", animalID: [animalId],completionHandler: { (success) -> Void in
    //
    //
    //
    //
    //                   })
                    }
                     else if groupOb.count == 0
                     {
                        self.UpdateNewGroupResult( groupName: arrayGet1.groupName ?? "", groupTypeId: 0, groupId:serverID,groupStatusId: 1,decs: desc ?? "", animalID: [animalId],completionHandler: { (success) -> Void in

                            if success == true{
                                updateGroupTypeIdInGroupTable(entity: "ResultGroupCreate",customerId: Int64(arrayGet1.customerId) ,groupServerId: arrayGet1.groupServerId ?? "" ,groupStatus: "Active" ,groupStatusId: 1)
                                updateGroupTypeIdResultGroupAnimal(entity: "ResultGroupsAnimals",customerId: Int64(arrayGet1.customerId),serverGroupId: serverID,groupStatus:"Active",groupStatusId:1)
                                updateMyHerdDataStaus(entity: "ResultMyHerdData", customerId:  Int64(self.customerId ?? 0), animalID: animalId, status: "doller")
                                
                            }
                            self.tblView.reloadData()
                        })
                     }
                    }
                   
                    
                  //  self.tblView.reloadData()
                    
                    
                 }

             else {
                            
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString("Group can only be made active online.You cannot update group offline.", comment: ""))
                            return
                        }
             })
             alert.addAction(yes)
             DispatchQueue.main.async(execute: {
                self.tblView.reloadData()
        self.present(alert, animated: true)
        })
        
        
        
        
    }
    

    func deleteGroup(groupId:String,customerId:Int64) {
        
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
       // let accessToken = appDelegate?.keychain_valueForKey("accessToken") as? String
        let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String
        let headerDict = ["Authorization": accessToken!,"Content-Type" : "application/x-www-form-urlencoded"]
        var header = HTTPHeaders(headerDict ?? ["Content-Type": "application/x-www-form-urlencoded","Accept": "application/json"])
        
        let urlString = Configuration.Dev(packet: ApiKeys.deleteGroup.rawValue + "/\(groupId)").getUrl()
        let parameters = [String: Any]()
        
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = headerDict
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            if statusCode == 200 {
                self.view.makeToast(NSLocalizedString("Group deleted successfully.", comment: ""), duration: 2, position: .bottom)
            }
        }
    }
//    func update(groupId:String,customerId:Int64) {
//
//        let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String
//        let headerDict = ["Authorization": accessToken!,"Content-Type" : "application/x-www-form-urlencoded"]
//        var header = HTTPHeaders(headerDict ?? ["Content-Type": "application/x-www-form-urlencoded","Accept": "application/json"])
//
//        let urlString = Configuration.Dev(packet: ApiKeys.update.rawValue + "/\(groupId)").getUrl()
//        let parameters = [String: Any]()
//
//        var request = URLRequest(url: URL(string: urlString)! )
//        request.httpMethod = "DELETE"
//        request.allHTTPHeaderFields = headerDict
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
//        } catch let error {
//
//        }
//
//        AF.request(request as URLRequestConvertible).responseJSON { response in
//            let statusCode =  response.response?.statusCode
//            if statusCode == 200 {
//                self.view.makeToast(NSLocalizedString("Changed.", comment: ""), duration: 2, position: .bottom)
//            }
//        }
//    }
    
    func UpdateNewGroupResult(groupName: String, groupTypeId: Int, groupId:String,groupStatusId: Int,decs: String, animalID : [String], completionHandler:  @escaping (Bool) -> ()){
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        //let accessToken = appDelegate?.keychain_valueForKey("accessToken") as? String
         let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String

        updateGruop.groupName = groupName
        updateGruop.groupId = groupId
        updateGruop.groupTypeId = groupTypeId
        updateGruop.groupStatusId = groupStatusId
        updateGruop.description = decs
        //updateGruop.animalIds = animalID


        let parameters : [String: Any] = ["groupName":groupName,"groupId":groupId,"groupTypeId":groupTypeId,"groupStatusId":groupStatusId,"description":decs,"animalIds":[animalID]]


        let jsonEncoder = JSONEncoder()

        let jsonData = try! jsonEncoder.encode(updateGruop)
        let json = String(data: jsonData, encoding: String.Encoding.utf8)
       


        let headerDict :[String:String] = ["Authorization":"" + accessToken!]


        let urlString = Configuration.Dev(packet: ApiKeys.update.rawValue).getUrl()
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headerDict

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData


          AF.request(request as URLRequestConvertible).responseJSON { response in
              let statusCode =  response.response?.statusCode
              if statusCode == 200 {
                  
                  switch response.result {
                  case let .success(value):
                     
                      
                      
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
}

extension MyManagementGroupController {
    func leavegroupapi() {
        group.leave()
        self.hideIndicator()
        self.view.isUserInteractionEnabled = true
    }
    
}
