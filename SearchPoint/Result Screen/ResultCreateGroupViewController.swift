//
//  ResultCreateGroupViewController.swift
//  SearchPoint
//
//  Created by Mobile Programming on 09/03/21.
//

import UIKit
import Alamofire

//MARK: CLASS
class ResultCreateGroupViewController: UIViewController,UITextFieldDelegate, UITextViewDelegate {
    
    //MARK: OUTLETS
    @IBOutlet weak var groupStatusTitle: UILabel!
    @IBOutlet weak var createGroupNameTitle: UILabel!
    @IBOutlet weak var groupDescriptionTitle: UILabel!
    @IBOutlet weak var submitBtnOutlet: customButton!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var listNameTextField: UITextField!
    @IBOutlet weak var connectedBtnOutlet: UIButton!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var connectionImg: UIImageView!
    @IBOutlet weak var barnIMageView: UIImageView!
    @IBOutlet weak var dollarImageView: UIImageView!
    @IBOutlet weak var barnGroupOutlet: UIButton!
    @IBOutlet weak var dollarBtnOutlet: UIButton!
    @IBOutlet weak var activeLbl: UILabel!
    @IBOutlet weak var inactiveLbl: UILabel!
    @IBOutlet weak var activeStatusOutlet: UIButton!
    @IBOutlet weak var inactiveStatusOutlet: UIButton!
    
    //MARK: VARIABLES AND CONSTANTS
    var currentCustomerId = Int()
    var pvid = Int()
    var beefPvid = Int()
    var groupTypeId = Int()
    var groupStatusId = Int()
    var groupTypeName = String()
    var groupStatusName = String()
    var groupname = String()
    var langId = Int()
    var value = 0
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIOnDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
    }
    
    //MARK: INITIAL UI METHODS
    func setUIOnDidLoad(){
        self.currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int ?? 0
        self.pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        self.beefPvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        self.langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int ?? 1
        self.navigationController?.navigationBar.isHidden = true
        listNameTextField.layer.borderWidth = 0.5
        listNameTextField.layer.borderColor = UIColor.gray.cgColor
        listNameTextField.addPadding(.left(10))
        listNameTextField.delegate = self
        descTextView.delegate = self
        descTextView.layer.borderWidth = 0.5
        descTextView.layer.borderColor = UIColor.gray.cgColor
        initialNetworkCheck()
        barnIMageView.layer.masksToBounds = false
        barnIMageView.layer.cornerRadius = barnIMageView.frame.size.height/2
        barnIMageView.clipsToBounds = true
        dollarImageView.layer.masksToBounds = false
        dollarImageView.layer.cornerRadius = dollarImageView.frame.size.height/2
        dollarImageView.clipsToBounds = true
        barnGroupOutlet.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
        dollarBtnOutlet.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
        activeStatusOutlet.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
        inactiveStatusOutlet.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
        groupStatusId = 1
        groupStatusName = LocalizedStrings.activeGroupType
        groupTypeId = 1
        groupTypeName = LocalizedStrings.barnGroupType
        createGroupNameTitle.text = ButtonTitles.enterGroupName.localized
        groupDescriptionTitle.text = ButtonTitles.enterGroupDesc.localized
        submitBtnOutlet.setTitle(ButtonTitles.submitText.localized, for: .normal)
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
    
    @objc func buttonbgPressed (){
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
    @objc func checkForReachability(notification:Notification){
        let del =  UIApplication.shared.delegate as? AppDelegate
        self.statusText?.text = NSLocalizedString((del?.status)!, comment: "")
        if statusText?.text == ButtonTitles.connectedText.localized{
            self.connectedBtnOutlet.isHidden = true
            self.connectionImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else {
            self.connectedBtnOutlet.isHidden = false
            self.connectionImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    //MARK: METHODS AND FUNCTIONS
    func doesGroupExist(groupName:String,customerId:Int64, completionHandler: @escaping CompletionHandler){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict = [LocalizedStrings.authorizationHeader: accessToken!,LocalizedStrings.contentType : LocalizedStrings.formURLEncoded]
        
        let urlString = Configuration.Dev(packet: ApiKeys.doesGroupExist.rawValue).getUrl()
        let parameters : [String: Any] = [keyValue.customerId.rawValue: customerId,keyValue.groupName.rawValue:groupName]
        
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
                    if value as! Int == 0 {
                        return completionHandler(true)
                    } else {
                        return completionHandler(false)
                    }
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
    
    func createNewGroupResult(customerId: Int64 ,groupName: String, groupTypeId: Int, groupStatusId: Int, description: String, completionHandler:  @escaping (NSDictionary) -> ()){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict = [LocalizedStrings.authorizationHeader: accessToken!,LocalizedStrings.contentType : LocalizedStrings.formURLEncoded]
        let urlString = Configuration.Dev(packet: ApiKeys.groupCreate.rawValue).getUrl()
        let parameters : [String: Any] = [keyValue.customerId.rawValue: customerId,keyValue.groupName.rawValue:groupName,"groupTypeId":groupTypeId,"groupStatusId":groupStatusId,"description":description]
        
        var request = URLRequest(url: URL(string: urlString)!)
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
                    return completionHandler(value as! NSDictionary)
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
    
    func UpdateNewGroupResult(customerId: Int64 ,groupName: String, groupTypeId: Int, groupStatusId: Int, description: String, completionHandler:  @escaping (NSDictionary) -> ()){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict = [LocalizedStrings.authorizationHeader: accessToken!,LocalizedStrings.contentType : LocalizedStrings.formURLEncoded]
        
        let urlString = Configuration.Dev(packet: ApiKeys.update.rawValue).getUrl()
        print(urlString)
        let parameters : [String: Any] = [keyValue.customerId.rawValue: customerId,keyValue.groupName.rawValue:groupName,"groupTypeId":groupTypeId,"groupStatusId":groupStatusId,"description":description]
        
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
                    return completionHandler(value as! NSDictionary)
                    
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
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
        vc?.module = LocalizedStrings.resultsText.localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
    }
    
    @IBAction func menuBtnClick(_ sender: Any) {
        self.view.makeCorner(withRadius: 40)
        self.sideMenuViewController?.presentRightMenuViewController()
    }
    
    @IBAction func barnGroupClick(_ sender: Any) {
        groupTypeId = 1
        groupTypeName = LocalizedStrings.barnGroupType
        barnGroupOutlet.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
        dollarBtnOutlet.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
    }
    
    @IBAction func dollarBtnClick(_ sender: Any) {
        groupTypeName = LocalizedStrings.dollarGroupType
        groupTypeId = 0
        dollarBtnOutlet.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
        barnGroupOutlet.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
    }
    
    @IBAction func activeStatusClick(_ sender: Any) {
        groupStatusId = 1
        activeStatusOutlet.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
        inactiveStatusOutlet.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
        groupStatusName = LocalizedStrings.activeGroupType
    }
    
    @IBAction func inactiveStatusClick(_ sender: Any) {
        inactiveStatusOutlet.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
        activeStatusOutlet.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
        groupStatusId = 0
        groupStatusName = LocalizedStrings.capsInactiveStatus
    }
    
    @IBAction func bckBtnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtnAction(_ sender: Any) {
        if Connectivity.isConnectedToInternet() {
            if listNameTextField.text == "" {
                listNameTextField.layer.borderColor = UIColor.red.cgColor
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(LocalizedStrings.pleaseEnterGroupName, comment: "") )
                return
            }
            if Connectivity.isConnectedToInternet() {
                showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
                doesGroupExist(groupName: listNameTextField.text ?? "", customerId: Int64(currentCustomerId),completionHandler: { [self] (success) -> Void in
                    if success == true {
                        var groupIdGenerate = UserDefaults.standard.integer(forKey: keyValue.groupId.rawValue)
                        if groupIdGenerate == 0 {
                            groupIdGenerate = groupIdGenerate + 1
                            UserDefaults.standard.set(groupIdGenerate, forKey: keyValue.groupId.rawValue)
                        }
                        else {
                            groupIdGenerate = groupIdGenerate + 1
                            UserDefaults.standard.set(groupIdGenerate, forKey: keyValue.groupId.rawValue)
                        }
  
                        self.createNewGroupResult(customerId: Int64(self.currentCustomerId), groupName: self.listNameTextField.text ?? "", groupTypeId: self.groupTypeId, groupStatusId: self.groupStatusId, description: self.descTextView.text ?? "", completionHandler: { (success) -> Void in
                            let errordetails = success.value(forKey: keyValue.errorDetail.rawValue)
                            if(errordetails as! String != ""){
                                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(LocalizedStrings.groupCantBeCreated, comment: "") )
                                self.hideIndicator()
                                return
                            }
                            
                            let groupId = success.value(forKey: keyValue.groupId.rawValue) as? String
                            saveGroupDataResult(entity: Entities.resultGroupCreateTblEntity, customerId: Int64(self.currentCustomerId), groupId: Int64(groupIdGenerate), groupDesc: self.descTextView.text ?? "", groupName: self.listNameTextField.text ?? "", groupStatusId: self.groupStatusId, groupStatus: self.groupStatusName, groupTypeId:  self.groupTypeId, groupType: self.groupTypeName, groupServerId: groupId ?? "")
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.groupCreatedSuccessfully, comment: ""), duration: 8, position: .top)
                          self.navigationController?.popViewController(animated: true)
                           // self.sideMenuViewController?.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.myManagementGroupControllerVC)), animated: true)
                        })
                    }
                    else {
                        self.listNameTextField.layer.borderColor = UIColor.red.cgColor
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(LocalizedStrings.groupAlreadyExists, comment: ""))
                        self.hideIndicator()
                    }
                })
            }
        } 
        else {
            self.view.makeToast(NSLocalizedString(AlertMessagesStrings.noInternetConnected, comment: ""), duration: 2, position: .bottom)
        }
    }
    
    @IBAction func logoBackBtnAction(_ sender: Any) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
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
}

//MARK: OFFLINE CUSTOM VIEW EXTENSION
extension ResultCreateGroupViewController:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

