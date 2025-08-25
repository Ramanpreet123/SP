//
//  DataEntryModeListVC.swift
//  SearchPoint
//
//  Created by Rajni on 13/03/25.
//


import UIKit
import Alamofire
import CoreData

//MARK: CLASS

class DataEntryModeListiPadVC: UIViewController{
    
    //MARK: IB OUTLETS
    @IBOutlet weak var menuIconLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var createNewListOutlet: UIButton!
    @IBOutlet weak var bckBtnOutlet: UIButton!
    @IBOutlet weak var dataEntryTitleLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
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
    var sideMenuViewVC: SideMenuVC!
    var sideMenuShadowView: UIView!
    var sideMenuRevealWidth: CGFloat = 300
    let paddingForRotation: CGFloat = 150
    var isExpanded: Bool = false
    var draggingIsEnabled: Bool = false
    var panBaseLocation: CGFloat = 0.0
    var gestureEnabled: Bool = true
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var revealSideMenuOnTop: Bool = true
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialization Code
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setInitialUI()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        self.collectionView.reloadData()
    }
    
    //MARK: INITIAL UI AND OTHER METHODS
    func setInitialUI(){
        self.setSideMenu()
        templistArray.removeAll()
        listArray.removeAll()
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
        
        if listArray.count <= 1 {
            mergeListBtnOutlet.isHidden = true
        } else {
            mergeListBtnOutlet.isHidden = false
            
        }
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
            let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
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
                            } else if self.templistArray.count == 0 {
                                self.listArray.removeAll()
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
                            
                            self.collectionView.reloadData()
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
                        
                        self.collectionView.reloadData()
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
    
    //MARK: SIDE MENU UI METHODS
    func setSideMenu(){
        if UIDevice.current.orientation.isLandscape {
            self.sideMenuRevealWidth = 300
        }
        else {
            self.sideMenuRevealWidth = 260
            
        }
        
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewVC = storyboard.instantiateViewController(withIdentifier: "SideMenuVC") as? SideMenuVC
        view.insertSubview(self.sideMenuViewVC!.view, at: self.revealSideMenuOnTop ? 1 : 0)
        addChild(self.sideMenuViewVC!)
        self.sideMenuViewVC!.didMove(toParent: self)
        self.sideMenuViewVC.view.backgroundColor = UIColor.white
                
        self.sideMenuViewVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        if self.revealSideMenuOnTop {
            self.sideMenuTrailingConstraint = self.sideMenuViewVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -self.sideMenuRevealWidth - self.paddingForRotation)
            self.sideMenuTrailingConstraint.isActive = true
        }
        NSLayoutConstraint.activate([
            self.sideMenuViewVC.view.widthAnchor.constraint(equalToConstant: self.sideMenuRevealWidth),
            self.sideMenuViewVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.sideMenuViewVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            self.sideMenuViewVC.searchpointImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 42.0)
        ])
    }
    
    func animateShadow(targetPosition: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            self.sideMenuShadowView.alpha = (targetPosition == 0) ? 0.6 : 0.0
        }
    }
    
    @IBAction open func revealSideMenu() {
        self.sideMenuState(expanded: self.isExpanded ? false : true)
    }
    
    func sideMenuState(expanded: Bool) {
        if expanded {
            if UIDevice.current.orientation.isLandscape {
                self.menuIconLeadingConstraint.constant = 320
                print("Landscape")
            } else {
                self.menuIconLeadingConstraint.constant = 270
                print("Portrait")
            }
            
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? 0 : self.sideMenuRevealWidth) { _ in
                self.isExpanded = true
                
            }
         
        }
        else {
            self.menuIconLeadingConstraint.constant = 30
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? (-self.sideMenuRevealWidth - self.paddingForRotation) : 0) { _ in
                self.isExpanded = false
                
            }
         
        }
    }
    
    func animateSideMenu(targetPosition: CGFloat, completion: @escaping (Bool) -> ()) {
        self.view.bringSubviewToFront(self.sideMenuViewVC.view)
        self.sideMenuViewVC.tblView.reloadData()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .layoutSubviews, animations: {
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = targetPosition
                self.view.layoutIfNeeded()
            }
            else {
                self.view.subviews[1].frame.origin.x = targetPosition
            }
        }, completion: completion)
    }
    
    func sideMenuRevealSettingsViewController() -> DataEntryModeListiPadVC? {
        var viewController: UIViewController? = self
        
        if viewController != nil && viewController is DataEntryModeListiPadVC {
            return viewController! as? DataEntryModeListiPadVC
        }
        while (!(viewController is DataEntryModeListiPadVC) && viewController?.parent != nil) {
            viewController = viewController?.parent
        }
        if viewController is DataEntryModeListiPadVC {
            return viewController as? DataEntryModeListiPadVC
        }
        return nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != self.sideMenuViewVC {
            sideMenuState(expanded: false)
        }
    }
    
    //MARK: IB ACTIONS
    @IBAction func mergeListBtnAction(_ sender: Any) {
      
        let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: nil)
        if let viewController = storyboard.instantiateViewController(identifier: "DataEntryModeCreateListiPadVC") as? DataEntryModeCreateListiPadVC {
            viewController.delegateCustom = self
            viewController.mergeListContain = true
            present(viewController, animated: true)
        }
    }
    
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
        vc?.module = LocalizedStrings.dataEntryModeText.localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
        
    }
    
    @IBAction func bckBtnAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "iPad", bundle: nil)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func menuBtnAction(_ sender: Any) {
        self.sideMenuRevealSettingsViewController()?.revealSideMenu()
    }
    
    @IBAction func createNewListAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: nil)
        if let viewController = storyboard.instantiateViewController(identifier: "DataEntryModeCreateListiPadVC") as? DataEntryModeCreateListiPadVC {
            viewController.delegateCustom = self
            present(viewController, animated: true)
        }
        
    }
    
    @IBAction func connectedBtnAction(_ sender: Any) {
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(DataEntryModeListiPadVC.buttonbgPressed), for: .touchUpInside)
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
extension DataEntryModeListiPadVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

//MARK: SYNC API EXTENSION
extension DataEntryModeListiPadVC : syncApi {
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
        self.objApiSync.postEmailList(listId:Int64(listId1),custmerId:Int64(self.currentCustomerId),emailAdress :[emailId],providerId: arrayGet1.value(forKey: keyValue.providerId.rawValue) as? Int ?? 0)
        self.view.makeToast(NSLocalizedString(LocalizedStrings.receiveDataInEmail, comment: ""), duration: 2, position: .bottom)
    }
    
    func failWithInternetConnection() {
        self.hideIndicator()
    }
}



//MARK: TABLEVIEW DATASOURCE AND DELEGATES
extension DataEntryModeListiPadVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : DataListCollectionCellView = self.collectionView.dequeueReusableCell(withReuseIdentifier: "dataentrycell", for: indexPath as IndexPath) as! DataListCollectionCellView
        let listId = listArray[indexPath.row].listId
        
        if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String == marketNameType.Beef.rawValue {
            let listAnimalCount = fetchDataEnteryAnimalTbl(entityName: Entities.dataEntryBeefAnimalAddTblEntity,customerId:currentCustomerId, listId: Int64(listId)) as!  [DataEntryBeefAnimaladdTbl]
            if listAnimalCount.count > 0 {
                cell.animalCountLabel.text = "\(listAnimalCount.count) " + "Animals".localized
            } else {
                cell.animalCountLabel.isHidden = true
            }
        } else {
            let listAnimalCount = fetchDataEnteryAnimalTbl(entityName: Entities.dataEntryAnimalAddTbl,customerId:currentCustomerId, listId: Int64(listId)) as!  [DataEntryAnimaladdTbl]
            if listAnimalCount.count > 0 {
                cell.animalCountLabel.text = "\(listAnimalCount.count) " + "Animals".localized
            } else {
                cell.animalCountLabel.isHidden = true
            }
        }
        cell.listNameLabel.text = listArray[indexPath.row].listName
        cell.listDesclabel.text = listArray[indexPath.row].listDesc
        
        
        cell.backrounView?.layer.cornerRadius = 10
        cell.deleteButtonOutlet.tag = indexPath.row
        cell.emailButtonOutlet.tag = indexPath.row
        cell.deleteButtonOutlet.addTarget(self, action: #selector(deleteButtonCell(_:)), for: .touchUpInside)
        cell.emailButtonOutlet.addTarget(self, action: #selector(emailbtnCell(_:)), for: .touchUpInside)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UserDefaults.standard.set(listArray[indexPath.row].listId, forKey: keyValue.listIdSaveOnSelection.rawValue)
        UserDefaults.standard.set(listArray[indexPath.row].listName, forKey: keyValue.listNameSaveOnSelection.rawValue)
        
        if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String == marketNameType.Beef.rawValue {
            let storyboard = UIStoryboard(name: "DataEntryBeefiPad", bundle: nil)
            if beefPvid == 5 {
                let secondViewController = storyboard.instantiateViewController(withIdentifier: "DataEntryInheritBeefVC") as! DataEntryInheritBeefVC
                self.navigationController?.pushViewController(secondViewController, animated: false)
            }
            else if beefPvid == 6 {
                let secondViewController = storyboard.instantiateViewController(withIdentifier: "DEBrazilBeefVCIpad") as! DEBrazilBeefVCIpad
                self.navigationController?.pushViewController(secondViewController, animated: false)
            }
            
        } else {
            let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: nil)
            if pvid == 1 || pvid == 2 || pvid == 3 || pvid == 8 || pvid == 10 || pvid == 11 || pvid == 12 {
                
                if let viewController = storyboard.instantiateViewController(identifier: "DataEntryOrderingAnimalVCIpad") as? DataEntryOrderingAnimalVCIpad {
                    self.navigationController?.pushViewController(viewController, animated: false)
                }
            }
            if pvid == 4  {
                let secondViewController = storyboard.instantiateViewController(withIdentifier: "DEOAnimalVCGirlando") as! DEOAnimalVCGirlando
                self.navigationController?.pushViewController(secondViewController, animated: false)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if pvid == 4 {
            let totalSpacing = 15 * 2
            let screenWidth = UIScreen.main.bounds.width
            let itemWidth = screenWidth / 2
            return CGSize(width: Int(itemWidth) - totalSpacing, height: 186)
        }
        else if pvid == 8 {
            let totalSpacing = 15 * 2
            let screenWidth = UIScreen.main.bounds.width
            let itemWidth = screenWidth / 2
            return CGSize(width: Int(itemWidth) - totalSpacing, height: 186)
        }
        else {
            let totalSpacing = 15 * 2
            let screenWidth = UIScreen.main.bounds.width
            let itemWidth = screenWidth / 2
            return CGSize(width: Int(itemWidth) - totalSpacing, height: 186)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if UIDevice().userInterfaceIdiom == .pad {
            return 15
            
        }
        else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: EXTENSION HIDE INTERNAL LIST HELPER
private typealias HideInternalListHelper = DataEntryModeListiPadVC
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

extension DataEntryModeListiPadVC: updateDataEntryListDelegate{
    
    func refreshList() {
        self.setInitialUI()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.reloadData()
    }
    
    func navigateToMergeList(listName: String, descText: String) {
        let storyboard = UIStoryboard(name: "DataEntryiPad", bundle: Bundle.main)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "DataEntryaMergeListIpadVc") as! DataEntryaMergeListIpadVc
        secondViewController.groupNameTemp = listName
        secondViewController.groupDecTemp = descText
        self.navigationController?.pushViewController(secondViewController, animated: false)
    }
    
    
}
