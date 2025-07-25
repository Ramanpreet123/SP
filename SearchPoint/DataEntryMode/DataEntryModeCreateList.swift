//
//  DataEntryModeCreateList.swift
//  SearchPoint
//
//  Created by Mobile Programming on 14/12/20.
//

import UIKit
import Alamofire
import CoreData

// MARK: - CLASS

class DataEntryModeCreateList: UIViewController,UITextFieldDelegate {
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var keyBoardOptionsView: UIView!
    @IBOutlet weak var keyBoardOptionsViewBottomConstrains: NSLayoutConstraint!
    @IBOutlet weak var bckkkBtnOutlet: customButton!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var listNameTextField: UITextField!
    @IBOutlet weak var createListTitleLbl: UILabel!
    @IBOutlet weak var nextBtnOutlet: UIButton!
    @IBOutlet weak var bckBtnOutlet: UIButton!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var menuBtnOutlet: UIButton!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var connectionImg: UIImageView!
    @IBOutlet weak var connectedBtnOutlet: UIButton!
    @IBOutlet weak var appStatusText: UILabel!
    @IBOutlet weak var helpBtnOutlet: UIButton!
    
    // MARK: - VARIABLES

    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    let tapRec = UITapGestureRecognizer()
    let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
    let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
    let beefPvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
    var mergeListContain = Bool()
    var delegeteSyncApi : syncApi?
    var responseVAR = Bool()
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    
    // MARK: - VIEW LIFE CYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeObserver()
    }
    
    // MARK: - UI METHODS AND FUNCTIONS

    func setInitialUI(){
        addObserver()
        if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String == marketNameType.Beef.rawValue ||  UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue) == 4 {
            helpBtnOutlet.isHidden = true
        }
        self.navigationController?.navigationBar.isHidden = true
        listNameTextField.layer.borderWidth = 0.5
        listNameTextField.layer.borderColor = UIColor.gray.cgColor
        listNameTextField.addPadding(.left(10))
        listNameTextField.delegate = self
        descTextView.delegate = self
        descTextView.layer.borderWidth = 0.5
        descTextView.layer.borderColor = UIColor.gray.cgColor
        initialNetworkCheck()
        UserDefaults.standard.set(false, forKey: keyValue.expandView.rawValue)
        appStatusText.text = NSLocalizedString(ButtonTitles.appStatusText, comment: "")
        createListTitleLbl.text = LocalizedStrings.createNewList.localized
        nextBtnOutlet.setTitle(LocalizedStrings.doneStr.localized, for: .normal)
        listNameTextField.placeholder = LocalizedStrings.enterNewList.localized
        descTextView.text = LocalizedStrings.enterListDesc.localized
        descTextView.textColor = UIColor.lightGray
        bckkkBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.backBtnText, comment: ""), for: .normal)
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
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)        } catch let error {
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

    @objc func methodOfReceivedNotification(notification: Notification) {
        UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
        let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
        self.hideIndicator()
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            DispatchQueue.main.async {
                self.keyBoardOptionsView.isHidden = false
            }
            keyBoardOptionsViewBottomConstrains.constant = keyboardHeight + 20
            nextBtnOutlet.isHidden = true
            
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        keyBoardOptionsView.isHidden = true
        nextBtnOutlet.isHidden = false
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
        }
        else {
            
            self.connectedBtnOutlet.isHidden = false
            self.connectionImg.image = UIImage(named: ImageNames.statusOfflineImg)
            
        }
    }

    // MARK: - IB ACTIONS

    @IBAction func bckBtnClickAction(_ sender: Any) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeListVC)), animated: true)
    }
 
    @IBAction func nextBtnAction(_ sender: Any) {
        if listNameTextField.text == "" {
            listNameTextField.layer.borderColor = UIColor.red.cgColor
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.enterListName, comment: "") )
            return
        }
        
        if mergeListContain == true {
            showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
            var _: () = doesListExist(listName:listNameTextField.text ?? "",customerId:Int64(currentCustomerId ?? 0),completionHandler: { (success) -> Void in
                if success == true {
                    let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeMergeListVC) as! DataEntryModeMergeListVC
                    secondViewController.groupNameTemp = self.listNameTextField.text ?? ""
                    secondViewController.groupDecTemp = self.descTextView.text ?? ""
                    self.navigationController?.pushViewController(secondViewController, animated: false)
                    return
                } else {
                    self.listNameTextField.layer.borderColor = UIColor.red.cgColor
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.listNameExists, comment: ""))
                    self.hideIndicator()
                    return
                }})
            
            
        } else {
            
            if Connectivity.isConnectedToInternet() {
                showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                var _: () = doesListExist(listName:listNameTextField.text ?? "",customerId:Int64(currentCustomerId ?? 0),completionHandler: { (success) -> Void in
                    
                    if success == true {
                        var animalID1 = UserDefaults.standard.integer(forKey: keyValue.listId.rawValue)
                        if animalID1 == 0 {
                            animalID1 = animalID1 + 1
                            UserDefaults.standard.set(animalID1, forKey: keyValue.listId.rawValue)
                            
                        } else {
                            animalID1 = animalID1 + 1
                            UserDefaults.standard.set(animalID1, forKey: keyValue.listId.rawValue)
                        }
                        self.hideIndicator()
                        if self.descTextView.text == LocalizedStrings.enterListDesc.localized{
                            self.descTextView.text = ""
                        }
                        
                        if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String == marketNameType.Beef.rawValue {
                            if self.beefPvid == 5 || self.beefPvid == 6 || self.beefPvid == 7 {
                                if self.beefPvid == 5 || self.beefPvid == 6 {
                                    let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.currentCustomerId ?? 0),listName: self.listNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "" ,productName:marketNameType.Beef.rawValue)
                                    
                                    if fetchDatEntry.count == 0 {
                                        UserDefaults.standard.set(true, forKey: keyValue.showbeefInheritTable.rawValue)
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.listCreated, comment: ""), duration: 8, position: .bottom)
                                        
                                        saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(self.currentCustomerId ?? 0),listDesc: self.descTextView.text,listId: Int64(animalID1),listName: self.listNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: self.beefPvid, productType: UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) ?? "", productName: marketNameType.Beef.rawValue)
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                            if self.mergeListContain == true {
                                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeMergeListVC)), animated: true)
                                            } else {
                                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeListVC)), animated: true)
                                            }
                                            
                                        }
                                    } else {
                                        self.listNameTextField.layer.borderColor = UIColor.red.cgColor
                                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.listNameExists, comment: ""))
                                        self.hideIndicator()
                                    }
                                    
                                } else {
                                    let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.currentCustomerId ?? 0),listName: self.listNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "" ,productName:marketNameType.Beef.rawValue)
                                    
                                    if fetchDatEntry.count == 0 {
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.listCreated, comment: ""), duration: 8, position: .bottom)
                                        
                                        saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(self.currentCustomerId ?? 0),listDesc: self.descTextView.text,listId: Int64(animalID1),listName: self.listNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: self.beefPvid, productType: "", productName: marketNameType.Beef.rawValue)
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                            
                                            if self.mergeListContain == true {
                                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeMergeListVC)), animated: true)
                                                
                                            } else {
                                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeListVC)), animated: true)
                                            }
                                        }
                                    } else {
                                        self.listNameTextField.layer.borderColor = UIColor.red.cgColor
                                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.listNameExists, comment: ""))
                                        self.hideIndicator()
                                    }
                                }
                            }
                        } else {
                            
                            if self.pvid == 1 || self.pvid == 2 || self.pvid == 3 || self.pvid == 4 || self.pvid == 8 || self.pvid == 10 || self.pvid == 11 || self.pvid == 12{
                                
                                let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.currentCustomerId ?? 0),listName: self.listNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "" ,productName:marketNameType.Dairy.rawValue)
                                
                                if fetchDatEntry.count == 0 {
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.listCreated, comment: ""), duration: 8, position: .bottom)
                                    
                                    saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(self.currentCustomerId ?? 0),listDesc: self.descTextView.text,listId: Int64(animalID1),listName: self.listNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: self.pvid, productType: "", productName: marketNameType.Dairy.rawValue)
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                        
                                        if self.mergeListContain == true {
                                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeMergeListVC)), animated: true)
                                        } else {
                                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeListVC)), animated: true)
                                        }
                                    }
                                } else {
                                    self.listNameTextField.layer.borderColor = UIColor.red.cgColor
                                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.listNameExists, comment: ""))
                                    self.hideIndicator()
                                }
                                
                            }
                        }
                    } else {
                        self.listNameTextField.layer.borderColor = UIColor.red.cgColor
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.listNameExists, comment: ""))
                        self.hideIndicator()
                    }
                } )
                
            } else {
                var animalID1 = UserDefaults.standard.integer(forKey: keyValue.listId.rawValue)
                if animalID1 == 0 {
                    animalID1 = animalID1 + 1
                    UserDefaults.standard.set(animalID1, forKey: keyValue.listId.rawValue)
                    
                } else {
                    animalID1 = animalID1 + 1
                    UserDefaults.standard.set(animalID1, forKey: keyValue.listId.rawValue)
                }
                
                if descTextView.text == LocalizedStrings.enterListDesc.localized{
                    descTextView.text = ""
                }
                
                if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String == marketNameType.Beef.rawValue {
                    
                    if beefPvid == 5 || beefPvid == 6 || beefPvid == 7 {
                        if beefPvid == 5 || beefPvid == 6 {
                            let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId ?? 0),listName: listNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "" ,productName:marketNameType.Beef.rawValue)
                            
                            if fetchDatEntry.count == 0 {
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.listCreated, comment: ""), duration: 8, position: .bottom)
                                
                                saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(currentCustomerId ?? 0),listDesc: descTextView.text,listId: Int64(animalID1),listName: listNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: beefPvid, productType: UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) ?? "", productName: marketNameType.Beef.rawValue)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                    
                                    if self.mergeListContain == true {
                                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeMergeListVC)), animated: true)
                                        
                                    } else {
                                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeListVC)), animated: true)
                                    }
                                }
                            } else {
                                listNameTextField.layer.borderColor = UIColor.red.cgColor
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.listNameExists, comment: ""))
                                self.hideIndicator()
                            }
                            
                        } else {
                            let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId ?? 0),listName: listNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "" ,productName:marketNameType.Beef.rawValue)
                            
                            if fetchDatEntry.count == 0 {
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.listCreated, comment: ""), duration: 8, position: .bottom)
                                saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(currentCustomerId ?? 0),listDesc: descTextView.text,listId: Int64(animalID1),listName: listNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: beefPvid, productType: "", productName: marketNameType.Beef.rawValue)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                    if self.mergeListContain == true {
                                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeMergeListVC)), animated: true)
                                        
                                    } else {
                                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeListVC)), animated: true)
                                    }
                                }
                            } else {
                                listNameTextField.layer.borderColor = UIColor.red.cgColor
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.listNameExists, comment: ""))
                                self.hideIndicator()
                            }
                        }
                        
                    }
                } else {
                    if pvid == 1 || pvid == 2 || pvid == 3 || pvid == 4 || pvid == 8 || pvid == 11 || pvid == 12 || pvid == 10 {
                        let fetchDatEntry = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(currentCustomerId ?? 0),listName: listNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "" ,productName:marketNameType.Dairy.rawValue)
                        
                        if fetchDatEntry.count == 0 {
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.listCreated, comment: ""), duration: 8, position: .bottom)
                            
                            saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(currentCustomerId ?? 0),listDesc: descTextView.text,listId: Int64(animalID1),listName: listNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "" ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: pvid, productType: "", productName: marketNameType.Dairy.rawValue)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                if self.mergeListContain == true {
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeMergeListVC)), animated: true)
                                    
                                } else {
                                    
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryModeListVC)), animated: true)
                                }
                            }
                        } else {
                            listNameTextField.layer.borderColor = UIColor.red.cgColor
                            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(LocalizedStrings.listNameExists, comment: ""))
                            self.hideIndicator()
                        }
                        
                    }
                }
            }
        }
    }
    
    @IBAction func bckBtnAction(_ sender: Any) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
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
//MARK: TEXTVIEW DELEGATES

extension DataEntryModeCreateList:UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descTextView.textColor == UIColor.lightGray {
            descTextView.text = nil
            descTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if descTextView.text.isEmpty {
            descTextView.textColor = UIColor.lightGray
            
            descTextView.text = LocalizedStrings.enterListDesc.localized
            
            
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == descTextView ) {
        } else {
            listNameTextField.returnKeyType = UIReturnKeyType.next
            
        }
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.textColor = UIColor.black
        addObserver()
        return true;
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == listNameTextField {
            
            if listNameTextField.text == ""{
                listNameTextField.layer.borderColor = UIColor.red.cgColor
            } else {
                listNameTextField.layer.borderColor = UIColor.gray.cgColor
            }
            
            descTextView.becomeFirstResponder()
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let rawString = string
        let range = rawString.rangeOfCharacter(from: .whitespaces)
        if ((textField.text?.count)! == 0 && range  != nil)
            || ((textField.text?.count)! > 0 && textField.text?.last  == " " && range != nil)  {
            return false
        }
        return true
        
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if (textView == descTextView ) {
        }
        return true
    }
}
//MARK: OFFLINE CUSTOM VIEW EXTENSION

extension DataEntryModeCreateList:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}
