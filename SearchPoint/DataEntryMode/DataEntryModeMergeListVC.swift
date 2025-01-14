//
//  DataEntryModeMergeListVC.swift
//  SearchPoint
//
//  Created by Mobile Programming on 03/05/21.
//

import UIKit
import Alamofire
import CoreData

// MARK: - CLASS

class DataEntryModeMergeListVC: UIViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var keyBoardOptionsView: UIView!
    @IBOutlet weak var keyBoardOptionsViewBottomConstrains: NSLayoutConstraint!
    @IBOutlet weak var dataEntryTitleLbl: UILabel!
    @IBOutlet weak var menuBtnOutlet: UIButton!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var selectListSubTitle: UILabel!
    @IBOutlet weak var noListFoundlBL: UILabel!
    @IBOutlet weak var doneBtnOutlet: UIButton!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var connectionImg: UIImageView!
    @IBOutlet weak var connectedBtnOutlet: UIButton!
    @IBOutlet weak var appStatusText: UILabel!
    @IBOutlet weak var helpBtnOutlet: UIButton!
    
    // MARK: - VARIABLES AND CONSTANTS
    var groupNameTemp = String()
    var groupDecTemp = String()
    var listIdTemp = Int()
    var selectedCells:[Int] = []
    var listArray = [DataEntryList]()
    var tempListArray = [DataEntryList]()
    var userId = Int()
    var currentCustomerId = Int()
    let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
    let beefPvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
    var langId = Int()
    let orderingDataListViewModel = OrderingDataListViewModel()
    var value = 0
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    
    // MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Connectivity.isConnectedToInternet() {
        }
        else
        {
            NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeObserver()
    }
    
    // MARK: - INITIAL UI AND OTHER METHODS
    func setInitialUI(){
        addObserver()
        langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int ?? 1
        self.userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        self.currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int
        self.navigationController?.navigationBar.isHidden = true
        initialNetworkCheck()
        self.fetchBeefProviderIDs()
        if tempListArray.count > 0{
            listArray = orderingDataListViewModel.hideInternalDataList(tempImportListArray: tempListArray)
        }
        if listArray.count == 0 {
            noListFoundlBL.isHidden = false
        } else {
            noListFoundlBL.isHidden = true
        }
        self.tblView.reloadData()
        self.tblView.estimatedRowHeight = 150
        self.tblView.rowHeight = UITableView.automaticDimension
        self.tblView.allowsMultipleSelection = true
        appStatusText.text = NSLocalizedString(ButtonTitles.appStatusText, comment: "")
        noListFoundlBL.text = LocalizedStrings.noListsAvailable.localized
        selectListSubTitle.text = LocalizedStrings.selectList.localized
        doneBtnOutlet.setTitle(LocalizedStrings.doneStr.localized, for: .normal)
    }
    
    func fetchBeefProviderIDs(){
        if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String == marketNameType.Beef.rawValue  {
            helpBtnOutlet.isHidden = true
            if beefPvid == 7 {
                tempListArray = fetchDataEntryListGet(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId), userId: userId,providerId: beefPvid) as!  [DataEntryList]
                
            } else if beefPvid == 5 {
                if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.capsInherit.rawValue {
                    tempListArray =  fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:beefPvid,productType:keyValue.capsInherit.rawValue) as! [DataEntryList]
                }
                else {
                    tempListArray =  fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:beefPvid,productType:keyValue.globalHD50K.rawValue) as! [DataEntryList]
                    
                }
            } else if beefPvid == 6 {
                if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeOnly.rawValue {
                    tempListArray =  fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:beefPvid,productType:keyValue.genoTypeOnly.rawValue) as! [DataEntryList]
                }
                else  if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeStarBlack.rawValue {
                    tempListArray =  fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:beefPvid,productType:keyValue.genoTypeStarBlack.rawValue) as! [DataEntryList]
                }
                else  if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genStarBlack.rawValue {
                    tempListArray =  fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:beefPvid,productType:keyValue.genStarBlack.rawValue) as! [DataEntryList]
                }
                else {
                    tempListArray =  fetchDataEntryListGetBeefProduct(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),userId:userId,providerId:beefPvid,productType:keyValue.nonGenoType.rawValue) as! [DataEntryList]
                }
            }
        }
        else {
            if UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue) == 4{
                helpBtnOutlet.isHidden = true
            }
            tempListArray = fetchDataEntryListGet(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId), userId: userId,providerId: pvid) as!  [DataEntryList]
        }
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification , object: nil)
    }
    
    func newGroupCreated(completionHandler: @escaping CompletionHandler) {
        if Connectivity.isConnectedToInternet() {
            showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
            doesListExist(listName:groupNameTemp,customerId:Int64(currentCustomerId),completionHandler: { (success) -> Void in
                
                if success == true {
                    if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String == marketNameType.Beef.rawValue {
                        var animalID1 = UserDefaults.standard.integer(forKey: keyValue.listId.rawValue)
                        if animalID1 == 0 {
                            animalID1 = animalID1 + 1
                            UserDefaults.standard.set(animalID1, forKey: keyValue.listId.rawValue)
                            
                        } else {
                            animalID1 = animalID1 + 1
                            UserDefaults.standard.set(animalID1, forKey: keyValue.listId.rawValue)
                        }
                        if self.beefPvid == 5 || self.beefPvid == 6 || self.beefPvid == 7 {
                            
                            if self.beefPvid == 5 || self.beefPvid == 6 {
                                
                                let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.currentCustomerId),listName: self.groupNameTemp ,productName:marketNameType.Beef.rawValue)
                                
                                if fetchDatEntry.count == 0 {
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.listCreated, comment: ""), duration: 8, position: .bottom)
                                    
                                    if self.groupDecTemp == LocalizedStrings.enterListDesc.localized  {
                                        self.groupDecTemp = ""
                                    }
                                    
                                    saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(self.currentCustomerId),listDesc: self.groupDecTemp,listId: Int64(animalID1),listName: self.groupNameTemp ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: self.beefPvid, productType: UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) ?? "", productName: marketNameType.Beef.rawValue)
                                    self.listIdTemp = animalID1
                                    return completionHandler(true)
                                    
                                } else {
                                    let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(LocalizedStrings.listNameExists, comment: ""), preferredStyle: .alert)
                                    
                                    let ok = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: { action in
                                        
                                        self.hideIndicator()
                                        self.navigationController?.popViewController(animated: true)
                                        
                                    })
                                    alert.addAction(ok)
                                    DispatchQueue.main.async(execute: {
                                        self.present(alert, animated: true)
                                    })
                                    return completionHandler(false)
                                }
                                
                            } else {
                                let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.currentCustomerId),listName: self.groupNameTemp ,productName:marketNameType.Beef.rawValue)
                                
                                if fetchDatEntry.count == 0 {
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.listCreated, comment: ""), duration: 8, position: .bottom)
                                    
                                    if self.groupDecTemp == LocalizedStrings.enterListDesc.localized {
                                        self.groupDecTemp = ""
                                    }
                                    
                                    saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(self.currentCustomerId),listDesc: self.groupDecTemp,listId: Int64(animalID1),listName: self.groupNameTemp ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: self.beefPvid, productType: "", productName: marketNameType.Beef.rawValue)
                                    self.listIdTemp = animalID1
                                    return completionHandler(true)
                                    
                                } else {
                                    let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(LocalizedStrings.listNameExists, comment: ""), preferredStyle: .alert)
                                    let ok = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: { action in
                                        self.hideIndicator()
                                        self.navigationController?.popViewController(animated: true)
                                        
                                    })
                                    alert.addAction(ok)
                                    DispatchQueue.main.async(execute: {
                                        self.present(alert, animated: true)
                                    })
                                    return completionHandler(false)
                                    
                                }
                            }
                        }
                    }
                    else {
                        
                        if self.pvid == 1 || self.pvid == 2 || self.pvid == 3 || self.pvid == 4 ||  self.pvid == 8 || self.pvid == 11 || self.pvid == 12 || self.pvid == 10 {
                            
                            var animalID1 = UserDefaults.standard.integer(forKey: keyValue.listId.rawValue)
                            if animalID1 == 0 {
                                animalID1 = animalID1 + 1
                                UserDefaults.standard.set(animalID1, forKey: keyValue.listId.rawValue)
                                
                            } else {
                                animalID1 = animalID1 + 1
                                UserDefaults.standard.set(animalID1, forKey: keyValue.listId.rawValue)
                            }
                            
                            let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.currentCustomerId ),listName: self.groupNameTemp  ,productName:marketNameType.Dairy.rawValue)
                            
                            if fetchDatEntry.count == 0 {
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.listCreated, comment: ""), duration: 8, position: .bottom)
                                
                                if self.groupDecTemp == LocalizedStrings.enterListDesc.localized  {
                                    self.groupDecTemp = ""
                                }
                                saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(self.currentCustomerId ),listDesc: self.groupDecTemp,listId: Int64(animalID1),listName: self.groupNameTemp ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: self.pvid, productType: "", productName: marketNameType.Dairy.rawValue)
                                self.listIdTemp = animalID1
                                return completionHandler(true)
                                
                            } else {
                                let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(LocalizedStrings.listNameExists, comment: ""), preferredStyle: .alert)
                                
                                let ok = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: { action in
                                    
                                    self.hideIndicator()
                                    self.navigationController?.popViewController(animated: true)
                                    
                                })
                                alert.addAction(ok)
                                DispatchQueue.main.async(execute: {
                                    self.present(alert, animated: true)
                                })
                                return completionHandler(false)
                                
                            }
                        }
                    }
                } else {
                    
                    self.hideIndicator()
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
        
        else {
            
            var animalID1 = UserDefaults.standard.integer(forKey: keyValue.listId.rawValue)
            if animalID1 == 0 {
                animalID1 = animalID1 + 1
                UserDefaults.standard.set(animalID1, forKey: keyValue.listId.rawValue)
                
            } else {
                animalID1 = animalID1 + 1
                UserDefaults.standard.set(animalID1, forKey: keyValue.listId.rawValue)
            }
            
            if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String == marketNameType.Beef.rawValue {
                
                if beefPvid == 5 || beefPvid == 6 || beefPvid == 7 {
                    if beefPvid == 5 || beefPvid == 6 {
                        let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),listName: self.groupNameTemp  ,productName:marketNameType.Beef.rawValue)
                        
                        if fetchDatEntry.count == 0 {
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.listCreated, comment: ""), duration: 8, position: .bottom)
                            
                            if self.groupDecTemp == LocalizedStrings.enterListDesc.localized {
                                self.groupDecTemp = ""
                            }
                            saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(currentCustomerId),listDesc: self.groupDecTemp,listId: Int64(animalID1),listName: self.groupNameTemp ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: beefPvid, productType: UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) ?? "", productName: marketNameType.Beef.rawValue)
                            
                            self.listIdTemp = animalID1
                            return completionHandler(true)
                            
                            
                        } else {
                            let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(LocalizedStrings.listNameExists, comment: ""), preferredStyle: .alert)
                            
                            let ok = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: { action in
                                
                                self.hideIndicator()
                                self.navigationController?.popViewController(animated: true)
                                
                            })
                            alert.addAction(ok)
                            DispatchQueue.main.async(execute: {
                                self.present(alert, animated: true)
                            })
                            self.hideIndicator()
                            return completionHandler(false)
                            
                        }
                        
                    } else {
                        
                        let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),listName: self.groupNameTemp  ,productName:marketNameType.Beef.rawValue)
                        
                        if fetchDatEntry.count == 0 {
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.listCreated, comment: ""), duration: 8, position: .bottom)
                            
                            if self.groupDecTemp == LocalizedStrings.enterListDesc.localized {
                                self.groupDecTemp = ""
                            }
                            saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(currentCustomerId),listDesc: self.groupDecTemp,listId: Int64(animalID1),listName: self.groupNameTemp  ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: beefPvid, productType: "", productName: marketNameType.Beef.rawValue)
                            self.listIdTemp = animalID1
                            return completionHandler(true)
                            
                            
                        } else {
                            
                            let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(LocalizedStrings.listNameExists, comment: ""), preferredStyle: .alert)
                            
                            let ok = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: { action in
                                
                                self.hideIndicator()
                                self.navigationController?.popViewController(animated: true)
                                
                            })
                            alert.addAction(ok)
                            DispatchQueue.main.async(execute: {
                                self.present(alert, animated: true)
                            })
                            self.hideIndicator()
                            return completionHandler(false)
                        }
                    }
                    
                }
            } else {
                
                if pvid == 1 || pvid == 2 || pvid == 3 || pvid == 4 || pvid == 8 || self.pvid == 11 || self.pvid == 12{
                    
                    let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId),listName: self.groupNameTemp ,productName:marketNameType.Dairy.rawValue)
                    
                    if fetchDatEntry.count == 0 {
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.listCreated, comment: ""), duration: 8, position: .bottom)
                        
                        
                        if self.groupDecTemp == LocalizedStrings.enterListDesc.localized{
                            self.groupDecTemp = ""
                        }
                        saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(currentCustomerId),listDesc: self.groupDecTemp,listId: Int64(animalID1),listName: self.groupNameTemp ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: pvid, productType: "", productName: marketNameType.Dairy.rawValue)
                        self.listIdTemp = animalID1
                        return completionHandler(true)
                        
                        
                    } else {
                        
                        let alert = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(LocalizedStrings.listNameExists, comment: ""), preferredStyle: .alert)
                        
                        let ok = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: { action in
                            
                            self.hideIndicator()
                            self.navigationController?.popViewController(animated: true)
                            
                        })
                        alert.addAction(ok)
                        DispatchQueue.main.async(execute: {
                            self.present(alert, animated: true)
                        })
                        self.hideIndicator()
                        return completionHandler(false)
                        
                    }
                    
                }
            }
        }
    }
    
    func doesListExist(listName:String,customerId:Int64, completionHandler: @escaping CompletionHandler){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict = [LocalizedStrings.authorizationHeader: accessToken!,LocalizedStrings.contentType : LocalizedStrings.formURLEncoded]
        let urlString = Configuration.Dev(packet: ApiKeys.doesListExist.rawValue).getUrl()
        let parameters : [String: Any] = [keyValue.customerId.rawValue: customerId,keyValue.listName.rawValue:listName]
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headerDict
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            if statusCode == 200 {
                
                switch response.result {
                case let .success(value):
                    
                    if value as! Int == 0 {
                        
                        return completionHandler(true)
                    } else {
                        return completionHandler(false)
                    }
                case let .failure(error):
                    print(error)
                }
                
            } else {
                self.hideIndicator()
            }
        }
        return
    }
    
    func initialNetworkCheck(){
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        
        let del =  UIApplication.shared.delegate as? AppDelegate
        self.statusText?.text = NSLocalizedString((del?.status)!, comment: "")
        if statusText?.text == ButtonTitles.connectedText.localized
        {
            self.connectedBtnOutlet.isHidden = true
            self.connectionImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else{
            self.connectedBtnOutlet.isHidden = false
            self.connectionImg.image = UIImage(named: ImageNames.statusOfflineImg)
            
        }
    }
    
    // MARK: - OBJC SELECTOR METHODS
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
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            DispatchQueue.main.async {
                self.keyBoardOptionsView.isHidden = false
            }
            keyBoardOptionsViewBottomConstrains.constant = keyboardHeight + 20
            doneBtnOutlet.isHidden = true
            
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        keyBoardOptionsView.isHidden = true
        doneBtnOutlet.isHidden = false
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
    
    @objc func buttonbgPressed (){
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
    // MARK: - IB ACTIONS
    @IBAction func doneBtnAction(_ sender: Any) {
        if selectedCells.count == 0 {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.selectOneList, comment: ""))
            return
        }
        newGroupCreated { (returnValue) in
            if returnValue == true {
                for i in self.selectedCells {
                    let cellIndex = self.listArray[i]
                    
                    if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String == marketNameType.Beef.rawValue {
                        let animalCount =  fetchAllDataAnimalDaWithOutOrderId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, userId: Int(cellIndex.userId ),orderStatus:"false", listid: Int64(cellIndex.listId), custmerId: Int64(cellIndex.customerId), providerId:  Int(cellIndex.providerId))
                        
                        if animalCount.count != 0 {
                            
                            for i in 0...animalCount.count - 1 {
                                let dataGet = animalCount.object(at: i) as! DataEntryBeefAnimaladdTbl
                                if self.beefPvid == 5 {
                                    
                                    let dataEntryValue = fetchAllDataGlobalEarTAG(entityName: Entities.dataEntryBeefAnimalAddTblEntity,userId:Int(cellIndex.userId),orderId:0,listid:Int64(self.listIdTemp),custmerId:Int64(cellIndex.customerId),providerId:Int(cellIndex.providerId),earTag: dataGet.animalTag ?? "", orderStatus: "false") as! [DataEntryBeefAnimaladdTbl]
                                    
                                    if dataEntryValue.count == 0 {
                                        var animalID1 = UserDefaults.standard.integer(forKey: keyValue.animalId.rawValue)
                                        
                                        if animalID1 == 0 {
                                            animalID1 = animalID1 + 1
                                            UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                                            
                                        }
                                        else {
                                            animalID1 = animalID1 + 1
                                            UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                                        }
                                        
                                        if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
                                            
                                            saveAnimaldataBeefInProductId(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "" , date: dataGet.date ?? ""  , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "", orderId: 0,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU:  dataGet.nationHerdAU ?? "", userId: Int(dataGet.userId),udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId),productId:Int(dataGet.productId),custId: Int(dataGet.custmerId), listId: Int64(self.listIdTemp), serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                            
                                            
                                            saveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "" , date: dataGet.date ?? ""  , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "", orderId: 0,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU:  dataGet.nationHerdAU ?? "", userId: Int(dataGet.userId),udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId),productId:Int(dataGet.productId),custId: Int(dataGet.custmerId), listId: Int64(self.listIdTemp), serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                            
                                        } else {
                                            
                                            
                                            inheritSaveAnimaldataBeefInProductId(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: 0,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ) ,tissuId: Int(dataGet.tissuId ),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: Int(dataGet.userId),udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId ),productId:Int(dataGet.productId ), sirYOB: dataGet.sireYOB ?? "", damYOB: dataGet.damYOB ?? "", sireRegAssocation: dataGet.sireRegAssocation ?? "",custId: Int(dataGet.custmerId ), listId: Int64(self.listIdTemp) , serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                            
                                            
                                            inheritSaveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: 0,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ) ,tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: Int(dataGet.userId),udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId ),productId:Int(dataGet.productId ), sirYOB: dataGet.sireYOB ?? "", damYOB: dataGet.damYOB ?? "", sireRegAssocation: dataGet.sireRegAssocation ?? "",custId: Int(dataGet.custmerId ), listId: Int64(self.listIdTemp) , serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                            
                                        }
                                    }
                                }
                                else if self.beefPvid == 6 {
                                    
                                    let dataEntryValue = fetchAllDataGlobalEarTAG(entityName: Entities.dataEntryBeefAnimalAddTblEntity,userId:Int(cellIndex.userId),orderId:0,listid:Int64(self.listIdTemp),custmerId:Int64(cellIndex.customerId),providerId:Int(cellIndex.providerId),earTag: dataGet.animalTag ?? "", orderStatus: "false") as! [DataEntryBeefAnimaladdTbl]
                                    
                                    if dataEntryValue.count == 0 {
                                        var animalID1 = UserDefaults.standard.integer(forKey: keyValue.animalId.rawValue)
                                        
                                        if animalID1 == 0 {
                                            animalID1 = animalID1 + 1
                                            UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                                        }
                                        else {
                                            animalID1 = animalID1 + 1
                                            UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                                        }
                                        
                                        if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.genoTypeOnly.rawValue {
                                            
                                            saveAnimaldataBeefInProductId(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: 0,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: Int(dataGet.userId),udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId), productId: Int(dataGet.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(self.listIdTemp), serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                            
                                            saveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: 0,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: Int(dataGet.userId),udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId), productId: Int(dataGet.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(self.listIdTemp), serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                            
                                        } else {
                                            
                                            saveAnimaldataBeefInProductId(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: 0,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: Int(dataGet.userId),udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId), productId: Int(dataGet.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId:Int64(self.listIdTemp), serverAnimalId: "",tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                            
                                            saveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: 0,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: Int(dataGet.userId),udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId), productId: Int(dataGet.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(self.listIdTemp), serverAnimalId: "",tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                            
                                        }
                                    }
                                    
                                } else if self.beefPvid == 7 {
                                    
                                    let dataEntryValue = fetchAllDataAnimalDatarderIdDateEntrycheckBeef(entityName: Entities.dataEntryBeefAnimalAddTblEntity,userId:Int(cellIndex.userId),orderId:0,listid:Int64(self.listIdTemp),custmerId:Int64(cellIndex.customerId ),providerId:Int(cellIndex.providerId),earTag: dataGet.animalTag ?? "", orderStatus: "false") as! [DataEntryBeefAnimaladdTbl]
                                    
                                    if dataEntryValue.count == 0 {
                                        var animalID1 = UserDefaults.standard.integer(forKey: keyValue.animalId.rawValue)
                                        
                                        if animalID1 == 0 {
                                            animalID1 = animalID1 + 1
                                            UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                                        }
                                        else {
                                            animalID1 = animalID1 + 1
                                            UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                                        }
                                        
                                        saveAnimaldatawithAge(entity: Entities.dataEntryBeefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "" , barCodetag: dataGet.animalbarCodeTag ?? "" , date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "", gender: dataGet.gender ?? "", update: "true" , permanentId: dataGet.offPermanentId ?? "" , tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "", orderId: 0, orderSataus: dataGet.orderstatus ?? "", breedId: dataGet.breedId ?? "", isSync: dataGet.isSync ?? "", providerId: Int(dataGet.providerId), tissuId: Int(dataGet.tissuId), sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: Int(dataGet.userId), udid: dataGet.udid ?? "", animalId: Int(dataGet.animalId), age: Int(dataGet.diffAge), productId: Int(dataGet.productId), samconflict: dataGet.sampTypeConf ?? "", ageConf: dataGet.ageConf ?? "", bothConf: dataGet.bothConf ?? "", custId: Int(dataGet.custmerId), listId: Int64(self.listIdTemp), serverAnimalId: "")
                                        
                                        
                                        saveAnimaldataBeefInProductId(entity: Entities.beefAnimalMasterTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: 0,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: Int(dataGet.userId),udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId), productId: Int(dataGet.productId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), listId: Int64(self.listIdTemp), serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                        
                                    }
                                }
                            }
                        }
                        
                    } else {
                        
                        let animalCount = fetchAllDataAnimalDaWithOutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: Int(cellIndex.userId ),orderStatus:"false",listid: Int64(cellIndex.listId), custmerId: Int64(cellIndex.customerId), providerId: Int(cellIndex.providerId))
                        
                        if animalCount.count != 0 {
                            for i in 0...animalCount.count - 1 {
                                let dataGet = animalCount.object(at: i) as! DataEntryAnimaladdTbl
                                if self.pvid == 4 {
                                    let dataEntryvalue = fetchAllDataAnimalDatarderIdDateEntrycheckGirlandoEARtag(entityName: Entities.dataEntryAnimalAddTbl,userId:Int(cellIndex.userId) ,orderId:0,listid:Int64(self.listIdTemp),custmerId:Int64(cellIndex.customerId ),providerId:Int(cellIndex.providerId),earTag: dataGet.earTag ?? "", orderStatus: "false") as! [DataEntryAnimaladdTbl]
                                    
                                    if dataEntryvalue.count == 0 {
                                        var animalID1 = UserDefaults.standard.integer(forKey: keyValue.animalId.rawValue)
                                        
                                        if animalID1 == 0 {
                                            animalID1 = animalID1 + 1
                                            UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                                        }
                                        
                                        else {
                                            animalID1 = animalID1 + 1
                                            UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                                        }
                                        
                                        if self.pvid == 4 {
                                            saveAnimaldataGirlando(entity: Entities.dataEntryAnimalAddTbl, earTag: dataGet.earTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "", damId: dataGet.offDamId ?? "" , sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "" , update: dataGet.status ?? "", breedRegNumber: dataGet.breedRegNumber ?? "" , tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "" , et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "" , orderId: 0, orderSataus: dataGet.orderstatus ?? "" , breedId: dataGet.breedId ?? "", isSync: dataGet.isSync ?? "", providerId: Int(dataGet.providerId), tissuId: Int(dataGet.tissuId), sireIDAU: dataGet.sireIDAU ?? "", animalName: dataGet.animalName ?? "" , userId: Int(dataGet.userId), udid: dataGet.udid ?? "", animalId: Int(dataGet.animalId), selectedBornTypeId: Int(dataGet.selectedBornTypeId), breedAssocation: dataGet.breedAssocation ?? "" , custId: Int(dataGet.custmerId), listId: Int64(self.listIdTemp), serverAnimalId: "",girlandoID:"")
                                            
                                            saveAnimaldataGirlando(entity: Entities.animalMasterTblEntity, earTag: dataGet.earTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "", damId: dataGet.offDamId ?? "" , sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "" , update: dataGet.status ?? "", breedRegNumber: dataGet.breedRegNumber ?? "" , tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "" , et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "" , orderId: 0, orderSataus: dataGet.orderstatus ?? "" , breedId: dataGet.breedId ?? "", isSync: dataGet.isSync ?? "", providerId: Int(dataGet.providerId), tissuId: Int(dataGet.tissuId), sireIDAU: dataGet.sireIDAU ?? "", animalName: dataGet.animalName ?? "" , userId: Int(dataGet.userId), udid: dataGet.udid ?? "", animalId: Int(dataGet.animalId), selectedBornTypeId: Int(dataGet.selectedBornTypeId), breedAssocation: dataGet.breedAssocation ?? "" , custId: Int(dataGet.custmerId), listId:Int64(self.listIdTemp), serverAnimalId: "",girlandoID: "")
                                            
                                        }
                                    }
                                } else {
                                    let dataEntryvalue =  fetchAllDataAnimalDatarderIdDateEntrycheckfarmIdOffId(entityName: Entities.dataEntryAnimalAddTbl, userId: Int(cellIndex.userId), orderId: 0, listid: Int64(self.listIdTemp), custmerId: Int64(cellIndex.customerId ), providerId: Int(cellIndex.providerId), farmId: dataGet.farmId ?? "" , animaTag: dataGet.animalTag ?? "") as! [DataEntryAnimaladdTbl]
                                    
                                    if dataEntryvalue.count == 0 {
                                        var animalId = UserDefaults.standard.integer(forKey: keyValue.animalId.rawValue)
                                      var animalID1 = UserDefaults.standard.integer(forKey: keyValue.animalId.rawValue)
                                        if animalID1 == 0 {
                                            animalID1 = animalID1 + 1
                                            UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                                            
                                        }
                                        else {
                                            animalID1 = animalID1 + 1
                                            UserDefaults.standard.set(animalID1, forKey: keyValue.animalId.rawValue)
                                        }
                                        if self.pvid == 1 || self.pvid == 2 || self.pvid == 3 || self.pvid == 4 ||  self.pvid == 8 || self.pvid == 11 || self.pvid == 12 || self.pvid == 10 {
                                          
                                      
//                                          updateOrderStatusISyncAnimalMasterAnimalId(entity: Entities.animalMasterTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: 0,orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(dataGet.userId),udid: dataGet.udid ?? "",animalId:Int(animalId),animalidNew:animalID1, selectedBornTypeId: Int(dataGet.selectedBornTypeId),isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,tertiaryGeno: "")
                                          
                                        //  updateOrderStatusISyncAnimalMasterAnimalId(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: 0,orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(dataGet.userId),udid: dataGet.udid ?? "",animalId:Int(animalId),animalidNew:animalID1, selectedBornTypeId: Int(dataGet.selectedBornTypeId),isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,tertiaryGeno: "")
                                          
                                       //   updateOrderStatusISyncAnimalMasterAnimalId(entity: Entities.dataEntryAnimalAddTbl,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: 0,orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(dataGet.userId),udid: dataGet.udid ?? "",animalId:Int(animalId),animalidNew:animalID1, selectedBornTypeId: Int(dataGet.selectedBornTypeId),isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,tertiaryGeno: "")
                                          
                                            
                                            saveAnimaldata(entity: Entities.dataEntryAnimalAddTbl,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: 0,orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(dataGet.userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(self.listIdTemp), editFlagSave: false, serverAnimalId:  "")
                                            
                                          saveAnimaldata(entity: Entities.animalMasterTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: 0,orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:Int(dataGet.providerId),tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(dataGet.userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(self.listIdTemp), editFlagSave: false, serverAnimalId: "")
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeListVC) as! DataEntryModeListVC
                self.navigationController?.pushViewController(secondViewController, animated: false)
                
            }else {
                
                self.navigationController?.popViewController(animated: true)
                self.hideIndicator()
                
            }
        }
    }
    
    @IBAction func menuBtnAction(_ sender: Any) {
        self.sideMenuViewController?.presentRightMenuViewController()
    }
    
    @IBAction func connectedBtnAction(_ sender: Any) {
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(DataEntryModeCreateList.buttonbgPressed), for: .touchUpInside)
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
    
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
        vc?.module = LocalizedStrings.dataEntryModeText.localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
    }
}

// MARK: - TABLE VIEW DATA SOURCES AND DELEGATES

extension DataEntryModeMergeListVC :UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DataEntryModeListCell = self.tblView.dequeueReusableCell(withIdentifier: "cell") as! DataEntryModeListCell
        cell.listNameLabel.text = listArray[indexPath.row].listName
        cell.listDesclabel.text = listArray[indexPath.row].listDesc
        cell.backrounView?.layer.cornerRadius = 10
        if self.selectedCells.contains(indexPath.row){
            cell.backrounView?.layer.backgroundColor = UIColor.gray.cgColor
        } else {
            cell.backrounView?.layer.backgroundColor = UIColor.systemGroupedBackground.cgColor
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.selectedCells.contains(indexPath.row) {
            let myIndex = self.selectedCells.firstIndex(of: indexPath.row)
            self.selectedCells.remove(at: myIndex!)
            
        } else {
            self.selectedCells.append(indexPath.row)
        }
        
        tblView.reloadData()
    }
}

// MARK: - OFFLINE CUSTOM VIEW EXTENSION
extension DataEntryModeMergeListVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}
