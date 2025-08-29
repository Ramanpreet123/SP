//
//  DataEntryModeListVC.swift
//  SearchPoint
//
//  Created by Mobile Programming on 14/12/20.
//

import UIKit
import Alamofire
import CoreData

//MARK: CLASS

class DataEntryModeListVC: UIViewController{
    
    //MARK: IB OUTLETS
    @IBOutlet weak var createNewListOutlet: UIButton!
    @IBOutlet weak var bckBtnOutlet: UIButton!
    @IBOutlet weak var dataEntryTitleLbl: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var menuBtnOutlet: UIButton!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var connectionImg: UIImageView!
    @IBOutlet weak var connectedBtnOutlet: UIButton!
    @IBOutlet weak var appStatusText: UILabel!
    @IBOutlet weak var noListFoundlBL: UILabel!
    @IBOutlet weak var dataEntryListSubtitle: UILabel!
    @IBOutlet weak var helpBtnOutlet: UIButton!
    @IBOutlet weak var mergeListBtnOutlet: UIButton!
    
    //MARK: VARIABLES AND CONSTANTS
    var objApiSync = ApiSyncList()
    var delegeteSyncApi : syncApi?
    var listArray = [DataEntryList]()
    var templistArray = [DataEntryList]()
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    var userId = Int()
    var currentCustomerId = Int()
    var selectedIndex = Int()
    let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
    let beefPvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
    var timeDelayed = DispatchTimeInterval.seconds(4)
    let speciesType = UserDefaults.standard.object(forKey: keyValue.name.rawValue) as? String ?? ""
    var cartListName = "CartList"
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    var value = 0
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        self.tblView.reloadData()
    }
    
    //MARK: INITIAL UI AND OTHER METHODS
    func setInitialUI(){
        objApiSync.delegeteSyncApi = self
        UserDefaults.standard.setValue(false, forKey: keyValue.matchedBarcodeFlagDataEntry.rawValue)
        self.userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        self.currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int
        UserDefaults.standard.set(false, forKey: keyValue.expandView.rawValue)
        self.navigationController?.navigationBar.isHidden = true
        initialNetworkCheck()
        if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String == marketNameType.Beef.rawValue{
            helpBtnOutlet.isHidden = true
            if beefPvid == 7 {
                
                templistArray = fetchDataEntryListGet(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId), userId: userId,providerId: beefPvid) as!  [DataEntryList]
                
            } else if beefPvid == 5 {
                
                if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.capsInherit.rawValue {
                    templistArray =  fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:beefPvid,productType:keyValue.capsInherit.rawValue) as! [DataEntryList]
                }
                else {
                    templistArray =  fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:beefPvid,productType:keyValue.globalHD50K.rawValue) as! [DataEntryList]
                    
                }
            } else if beefPvid == 6 {
                if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeOnly.rawValue {
                    
                    templistArray =  fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:beefPvid,productType:keyValue.genoTypeOnly.rawValue) as! [DataEntryList]
                }else  if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeStarBlack.rawValue {
                    templistArray =  fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:beefPvid,productType:keyValue.genoTypeStarBlack.rawValue) as! [DataEntryList]
                }else  if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genStarBlack.rawValue {
                    
                    templistArray =  fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:beefPvid,productType:keyValue.genStarBlack.rawValue) as! [DataEntryList]
                }
                else {
                    templistArray =  fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:beefPvid,productType:keyValue.nonGenoType.rawValue) as! [DataEntryList]
                }
            }
        }
        else {
            if UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue) == 4{
                helpBtnOutlet.isHidden = true
            }
            templistArray = fetchDataEntryListGet(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId), userId: userId,providerId: pvid) as!  [DataEntryList]
            
        }
        if templistArray.count > 0 {
            hideInternalList()
        }
        if listArray.count == 0 {
            noListFoundlBL.isHidden = false
        } else {
            noListFoundlBL.isHidden = true
        }
        
        self.tblView.estimatedRowHeight = 150
        self.tblView.rowHeight = UITableView.automaticDimension
        
        
        if listArray.count <= 1 {
            mergeListBtnOutlet.isHidden = true
        } else {
            mergeListBtnOutlet.isHidden = false
            
        }
        appStatusText.text = NSLocalizedString(ButtonTitles.appStatusText, comment: "")
        dataEntryTitleLbl.text = LocalizedStrings.dataEntryModeList.localized
        createNewListOutlet.setTitle(LocalizedStrings.createNewList.localized, for: .normal)
        noListFoundlBL.text = LocalizedStrings.noListsAvailable.localized
        mergeListBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.mergeList, comment: ""), for: .normal)
    }
    
    func initialNetworkCheck(){
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del =  UIApplication.shared.delegate as? AppDelegate
        self.statusText?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if statusText?.text == ButtonTitles.connectedText.localized {
            self.connectedBtnOutlet.isHidden = true
            self.connectionImg.image = UIImage(named: ImageNames.statusOnlineSign)
            
        } else {
            self.connectedBtnOutlet.isHidden = false
            self.connectionImg.image = UIImage(named: ImageNames.statusOfflineImg)
            
        }
    }
    
    func deleteList(listName:String,customerId:Int64) {
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict = [LocalizedStrings.authorizationHeader: accessToken!,LocalizedStrings.contentType : LocalizedStrings.formURLEncoded]
        let urlString = Configuration.Dev(packet: ApiKeys.deleteList.rawValue).getUrl()
        let parameters : [String: Any] = [keyValue.customerId.rawValue: customerId,keyValue.listName.rawValue:listName]
        
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
                self.view.makeToast(NSLocalizedString(LocalizedStrings.listDeleted, comment: ""), duration: 2, position: .bottom)
            }
        }
    }
    
    //MARK: OBJC SELECTOR METHODS
    @objc func methodOfReceivedNotification(notification: Notification)
    {
        if value == 0
        {
            UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
            self.hideIndicator()
            value = value + 1
        }
    }
    
    @objc func buttonbgPressed (){
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
    @objc func checkForReachability(notification:Notification){
        let del =  UIApplication.shared.delegate as? AppDelegate
        self.statusText?.text = NSLocalizedString((del?.status)!, comment: "")
        if statusText?.text == ButtonTitles.connectedText.localized {
            self.connectedBtnOutlet.isHidden = true
            self.connectionImg.image = UIImage(named: ImageNames.statusOnlineSign)
        } else {
            self.connectedBtnOutlet.isHidden = false
            self.connectionImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    @objc func deleteButtonCell(_ sender: UIButton){
        let arrayGet1 = self.listArray[sender.tag]
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        let listId1 = arrayGet1.value(forKey: keyValue.listId.rawValue) as? Int
        let customerId1 = arrayGet1.value(forKey: keyValue.customerId.rawValue) as? Int
        
        if Connectivity.isConnectedToInternet() {
            if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String  == marketNameType.Dairy.rawValue{
                let animalCount1 = fetchAnimalCountAccrodingToOrderWise(entityName: Entities.animalAddTblEntity, listId:Int64(listId1 ?? 0),customerId:Int64(customerId1 ?? 0),orderId:orderId ,orderstatus:"false")
                if animalCount1.count > 0{
                    let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.cannotDeleteList, comment: ""), preferredStyle: .alert)
                    
                    let ok = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: { action in
                        print("Ok")
                    })
                    alert.addAction(ok)
                    DispatchQueue.main.async(execute: {
                        self.present(alert, animated: true)
                    })
                    
                } else {
                    let refreshAlert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.deleteListForUsers, comment: ""), preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
                        
                        refreshAlert .dismiss(animated: true, completion: nil)
                    }))
                    
                    refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { [self] (action: UIAlertAction!) in
                        let arrayGet = self.listArray[sender.tag]
                        let customerId = arrayGet.value(forKey: keyValue.customerId.rawValue) as? Int
                        let listId = arrayGet.value(forKey: keyValue.listId.rawValue) as? Int
                        let uId = arrayGet.value(forKey: keyValue.userId.rawValue) as? Int
                        let listName = arrayGet.value(forKey: keyValue.listName.rawValue) as? String
                        
                        deleteList(listName:listName ?? "",customerId:Int64(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)))
                        
                        deleteDataWithListId(entityString: Entities.dataEntryListTblEntity, listId: Int64(listId ?? 0), customerId: customerId ?? 0,userId:uId ?? 0)
                        
                        let animalData =  fetchDataEnteryAnimalTbl(entityName: Entities.animalAddTblEntity, customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listId ?? 0))
                        
                        if animalData.count > 0 {
                            for i in 0 ..< animalData.count {
                                let ad = animalData[i] as! AnimaladdTbl
                                deleteDataWithProduct(Int(ad.animalId))
                                deleteDataWithSubProduct(Int(ad.animalId))
                            }
                            if UserDefaults.standard.value(forKey: keyValue.dataEntryListId.rawValue) as? Int == listId {
                                UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListId.rawValue)
                                UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
                            }
                            deleteDataWithListIdDatEntry(entityString: Entities.animalAddTblEntity, listId: Int(listId ?? 0), customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userId:userId)
                        }
                        
                        let animalData1 =  fetchDataEnteryAnimalTbl(entityName: Entities.dataEntryAnimalAddTbl, customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listId ?? 0))
                        if animalData1.count > 0 {
                            
                            deleteDataWithListIdDatEntry(entityString: Entities.dataEntryAnimalAddTbl, listId: Int(listId ?? 0), customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userId:userId)
                            
                        }
                        
                        DispatchQueue.main.async{
                            
                            self.templistArray = fetchDataEntryListGet(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.currentCustomerId),userId:userId, providerId: self.pvid) as!  [DataEntryList]
                            
                            if self.templistArray.count > 0 {
                                self.listArray.removeAll()
                                self.hideInternalList()
                            }
                            if self.listArray.count == 0 {
                                self.noListFoundlBL.isHidden = false
                            } else {
                                self.noListFoundlBL.isHidden = true
                            }
                            
                            
                            if self.listArray.count <= 1 {
                                self.mergeListBtnOutlet.isHidden = true
                            } else {
                                self.mergeListBtnOutlet.isHidden = false
                                
                            }
                            
                            self.tblView.reloadData()
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.listDeleted, comment: ""), duration: 2, position: .bottom)
                            
                        }
                    }))
                    
                    self.present(refreshAlert, animated: true, completion: nil)
                }
                
            } else {
                
                let animalCount1 = fetchAnimalCountAccrodingToOrderWise(entityName: Entities.beefAnimalAddTblEntity, listId:Int64(listId1 ?? 0),customerId:Int64(customerId1 ?? 0),orderId:orderId ,orderstatus:"false")
                
                if animalCount1.count > 0{
                    
                    let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.cannotDeleteList, comment: ""), preferredStyle: .alert)
                    
                    let ok = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: { action in
                        print("Ok")
                    })
                    alert.addAction(ok)
                    DispatchQueue.main.async(execute: {
                        self.present(alert, animated: true)
                    })
                    
                } else {
                    
                    let refreshAlert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.deleteListForUsers, comment: ""), preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
                        
                        refreshAlert .dismiss(animated: true, completion: nil)
                    }))
                    
                    refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { [self] (action: UIAlertAction!) in
                        
                        
                        let arrayGet = self.listArray[sender.tag]
                        let customerId = arrayGet.value(forKey: keyValue.customerId.rawValue) as? Int
                        let listId = arrayGet.value(forKey: keyValue.listId.rawValue) as? Int
                        let uId = arrayGet.value(forKey: keyValue.userId.rawValue) as? Int
                        let listName = arrayGet.value(forKey: keyValue.listName.rawValue) as? String
                        
                        deleteDataWithListId(entityString: Entities.dataEntryListTblEntity, listId: Int64(listId ?? 0), customerId: customerId ?? 0,userId:uId ?? 0)
                        deleteList(listName:listName ?? "",customerId:Int64(UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)))
                        
                        let animalData =  fetchDataEnteryAnimalTbl(entityName: Entities.beefAnimalAddTblEntity, customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listId ?? 0))
                        
                        if animalData.count > 0 {
                            
                            for i in 0 ..< animalData.count {
                                let ad = animalData[i] as! BeefAnimaladdTbl
                                deleteDataWithProductBeefDelete(Int(ad.animalId))
                                deleteDataWithSubProductAnimalId(Int(ad.animalId))
                            }
                            
                            if UserDefaults.standard.value(forKey: keyValue.dataEntryListId.rawValue) as? Int == listId {
                                UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListId.rawValue)
                                UserDefaults.standard.removeObject(forKey: keyValue.dataEntryListName.rawValue)
                            }
                            
                            deleteDataWithListIdDatEntry(entityString: Entities.beefAnimalAddTblEntity, listId: Int(listId ?? 0), customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userId:userId)
                        }
                        
                        
                        let animalData1 =  fetchDataEnteryAnimalTbl(entityName: Entities.dataEntryBeefAnimalAddTblEntity, customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(listId ?? 0))
                        if animalData1.count > 0 {
                            deleteDataWithListIdDatEntry(entityString: Entities.dataEntryBeefAnimalAddTblEntity, listId: Int(listId ?? 0), customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userId:userId)
                        }
                        
                        if beefPvid == 7 {
                            templistArray = fetchDataEntryListGet(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId), userId: userId,providerId: beefPvid) as!  [DataEntryList]
                            
                        } else if beefPvid == 5 {
                            
                            if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.capsInherit.rawValue {
                                templistArray =  fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:beefPvid,productType:keyValue.capsInherit.rawValue) as! [DataEntryList]
                                
                            } else {
                                templistArray =  fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:beefPvid,productType:keyValue.globalHD50K.rawValue) as! [DataEntryList]
                                
                            }
                            
                        } else if beefPvid == 6 {
                            if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeOnly.rawValue {
                                
                                templistArray =  fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:beefPvid,productType:keyValue.genoTypeOnly.rawValue) as! [DataEntryList]
                            }else  if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeStarBlack.rawValue {
                                
                                templistArray =  fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:beefPvid,productType:keyValue.genoTypeStarBlack.rawValue) as! [DataEntryList]
                            }else  if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genStarBlack.rawValue {
                                
                                templistArray =  fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:beefPvid,productType:keyValue.genStarBlack.rawValue) as! [DataEntryList]
                            }
                            else {
                                
                                templistArray =  fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:beefPvid,productType:keyValue.nonGenoType.rawValue) as! [DataEntryList]
                            }
                        }
                        if templistArray.count>0{
                            self.listArray.removeAll()
                            hideInternalList()
                        }
                        
                        if listArray.count == 0 {
                            noListFoundlBL.isHidden = false
                        } else {
                            noListFoundlBL.isHidden = true
                        }
                        
                        if listArray.count <= 1 {
                            mergeListBtnOutlet.isHidden = true
                        } else {
                            mergeListBtnOutlet.isHidden = false
                            
                        }
                        
                        self.tblView.reloadData()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.listDeleted, comment: ""), duration: 2, position: .bottom)
                        
                    }))
                    self.present(refreshAlert, animated: true, completion: nil)
                    
                }
            }
            
        } else {
            
            let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.deleteListForUsers, comment: ""), preferredStyle: .alert)
            let ok = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { action in
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.deleteOnlineList, comment: ""))
                
            })
            let cancel = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in
                print(LocalizedStrings.cancelPressed)
            })
            
            alert.addAction(cancel)
            alert.addAction(ok)
            DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
            })
            return
        }
    }
    
    @objc func emailbtnCell(_ sender: UIButton){
        selectedIndex = sender.tag
        let arrayGet1 = self.listArray[sender.tag]
        guard let listId1 = arrayGet1.value(forKey: keyValue.listId.rawValue) as? Int else {
            return
        }
        if Connectivity.isConnectedToInternet() {
            showIndicator(self.view, withTitle: NSLocalizedString(LocalizedStrings.listSyncProgress, comment: ""), and: "")
            if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String == marketNameType.Beef.rawValue {
                self.objApiSync.postListDataBeef(listId:Int64(listId1),custmerId:Int64(currentCustomerId))
            } else {
                self.objApiSync.postListData(listId:Int64(listId1),custmerId:Int64(currentCustomerId))
            }
        }else {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.emailList, comment: ""))
            return
            
        }
    }
    
    //MARK: IB ACTIONS
    @IBAction func mergeListBtnAction(_ sender: Any) {
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeCreateList) as! DataEntryModeCreateList
        secondViewController.mergeListContain = true
        self.navigationController?.pushViewController(secondViewController, animated: false)
    }
    
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
        vc?.module = LocalizedStrings.dataEntryModeText.localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
        
    }
    
    @IBAction func bckBtnAction(_ sender: Any) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func menuBtnAction(_ sender: Any) {
        self.sideMenuViewController?.presentRightMenuViewController()
    }
    
    @IBAction func createNewListAction(_ sender: Any) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeCreateList)), animated: true)
    }
    
    @IBAction func connectedBtnAction(_ sender: Any) {
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(DataEntryModeListVC.buttonbgPressed), for: .touchUpInside)
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
}

//MARK: OFFLINE CUSTOMVIEW EXTENSION
extension DataEntryModeListVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

//MARK: SYNC API EXTENSION
extension DataEntryModeListVC : syncApi {
    func failWithError(statusCode: Int) {
        self.hideIndicator()
    }
    
    func failWithErrorInternal() {
        self.hideIndicator()
    }
    
    func didFinishApi(response: String) {
        let arrayGet1 = self.listArray[selectedIndex]
        guard let listId1 = arrayGet1.value(forKey: keyValue.listId.rawValue) as? Int else {
            return
        }
        let emailId = UserDefaults.standard.value(forKey:keyValue.userName.rawValue) as! String
        self.hideIndicator()
        self.objApiSync.postEmailList(listId:Int64(listId1),custmerId:Int64(self.currentCustomerId),emailAdress :[emailId],providerId: arrayGet1.value(forKey: keyValue.providerIdText.rawValue) as? Int ?? 0)
        self.view.makeToast(NSLocalizedString(LocalizedStrings.receiveDataInEmail, comment: ""), duration: 2, position: .bottom)
    }
    
    func failWithInternetConnection() {
        self.hideIndicator()
    }
}

//MARK: TABLEVIEW DATASOURCE AND DELEGATES
extension DataEntryModeListVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DataEntryModeListCell = self.tblView.dequeueReusableCell(withIdentifier: "cell") as! DataEntryModeListCell
        cell.listNameLabel.text = listArray[indexPath.row].listName
        cell.listDesclabel.text = listArray[indexPath.row].listDesc
        cell.backrounView?.layer.cornerRadius = 10
        cell.deleteButtonOutlet.tag = indexPath.row
        cell.emailButtonOutlet.tag = indexPath.row
        cell.deleteButtonOutlet.addTarget(self, action: #selector(deleteButtonCell(_:)), for: .touchUpInside)
        cell.emailButtonOutlet.addTarget(self, action: #selector(emailbtnCell(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.set(listArray[indexPath.row].listId, forKey: keyValue.listIdSaveOnSelection.rawValue)
        UserDefaults.standard.set(listArray[indexPath.row].listName, forKey: keyValue.listNameSaveOnSelection.rawValue)
        
        if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String == marketNameType.Beef.rawValue {
            
            if beefPvid == 5 {
                let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryBeefAnimalGlobalHD50KVC) as! DataEntryBeefAnimalGlobalHD50KVC
                self.navigationController?.pushViewController(secondViewController, animated: false)
            }
            else if beefPvid == 6 {
                let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryBeefAnimalBrazilVC) as! DataEntryBeefAnimalBrazilVC
                self.navigationController?.pushViewController(secondViewController, animated: false)
            }
            
        } else {
            if pvid == 1 || pvid == 2 || pvid == 3 || pvid == 8 || pvid == 10 || pvid == 11 || pvid == 12 {
                let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryOrderingAnimalVC) as! DataEntryOrderingAnimalVC
                self.navigationController?.pushViewController(secondViewController, animated: false)
                
            }
            if pvid == 4  {
                let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryOrderingAnimalVCGirlando) as! DataEntryOrderingAnimalVCGirlando
                self.navigationController?.pushViewController(secondViewController, animated: false)
            }
        }
    }
}

//MARK: EXTENSION HIDE INTERNAL LIST HELPER
private typealias HideInternalListHelper = DataEntryModeListVC
extension HideInternalListHelper {
    func hideInternalList(){
        cartListName = "_" + cartListName + "_" + speciesType
        for i in 0 ..< self.templistArray.count {
            let listName = self.templistArray[i].listName?.lowercased()
            if let emails = listName?.getEmails() {
                if emails.count > 0 {
                    cartListName = emails[0] + "_" + cartListName + "_" + speciesType
                    if (listName?.contains(cartListName.lowercased()) ?? false) {
                        
                    }
                } else {
                    listArray.append(templistArray[i])
                }
            }
            
        }
        print(listArray)
    }
}
