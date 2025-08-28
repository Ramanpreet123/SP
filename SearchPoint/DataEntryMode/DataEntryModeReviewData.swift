//
//  DataEntryModeReviewData.swift
//  SearchPoint
//
//  Created by Mobile Programming on 15/12/20.
//

import UIKit
import DropDown
import CoreData

// MARK: - CLASS

class DataEntryModeReviewData: UIViewController{
    
    // MARK: - OUTLETS
    @IBOutlet weak var totalAnimalTitleLbl: UILabel!
    @IBOutlet weak var animalLblCount: UILabel!
    @IBOutlet weak var reviewDataTitle: UILabel!
    @IBOutlet weak var backBtnOutlet: customButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var sortByTtitle: UILabel!
    @IBOutlet weak var sortByButtonOutlet: customButton!
    @IBOutlet weak var sortByDropDownOutlet: UIButton!
    @IBOutlet weak var sortByDownlbl: UILabel!
    @IBOutlet weak var saveListOutlet: UIButton!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var connectionImg: UIImageView!
    @IBOutlet weak var connectedBtnOutlet: UIButton!
    @IBOutlet weak var appStatusText: UILabel!
    @IBOutlet weak var notificationCountLbl: UILabel!
    @IBOutlet weak var tbleView: UITableView!
    @IBOutlet weak var cartButtonOutlet: UIButton!
    @IBOutlet weak var bckkkBtnOutlet: customButton!
    @IBOutlet weak var emailMeEnterData: UILabel!
    @IBOutlet weak var emailMeEnteredBtnOutlet: UIButton!
    
    // MARK: - VARIABLES AND CONSTANTS
    
    let pviduser = (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue))
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    var listIdGet = Int()
    var listName = String()
    var farmId = Int()
    var barCodeId = Int()
    var earTag = Int()
    var objApiSync = ApiSyncList()
    var offcialId = Int()
    var delegateCustom : objectPickCartScreen?
    var clickOnDropDown = String()
    var timeDelayed = DispatchTimeInterval.seconds(4)
    var reviewListArray = [DataEntryAnimaladdTbl]()
    let dropDown = DropDown()
    var heartBeatViewModel:HeartBeatViewModel?
    var currentCustomerId = Int()
    var unchecked = true
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let animalCount =  fetchAllDataAnimalDaWithOutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderStatus:"false", listid: Int64(self.listIdGet ), custmerId: Int64(currentCustomerId), providerId: (UserDefaults.standard.integer(forKey:keyValue.providerID.rawValue)))
        notificationCountLbl.text = String(animalCount.count)
        animalLblCount.text = String(animalCount.count)
        if animalCount.count == 0{
            notificationCountLbl.isHidden = true
        }
    }
    
    // MARK: - INITIAL UI AND OTHER METHODS
    
    func setInitialUI(){
        reviewDataTitle.text = NSLocalizedString(ButtonTitles.reviewDataText, comment: "")
        sortByTtitle.text = ButtonTitles.sortByText.localized
        totalAnimalTitleLbl.text = LocalizedStrings.totalAnimalsAdded.localized
        emailMeEnterData.text = ButtonTitles.emailEnteredData.localized
        appStatusText.text = NSLocalizedString(ButtonTitles.appStatusText, comment: "")
        saveListOutlet.setTitle(LocalizedStrings.saveList.localized, for: .normal)
        bckkkBtnOutlet.setTitle(NSLocalizedString(LocalizedStrings.backBtnText, comment: ""), for: .normal)
        sortByButtonOutlet.setTitle(NSLocalizedString(LocalizedStrings.onFarmIdText, comment: ""), for: .normal)
        searchTextField.placeholder = NSLocalizedString(ButtonTitles.searchText, comment: "")
        currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int
        listIdGet = UserDefaults.standard.integer(forKey: keyValue.listIdSaveOnSelection.rawValue)
        listName = UserDefaults.standard.object(forKey: keyValue.listNameSaveOnSelection.rawValue) as! String
        self.navigationController?.navigationBar.isHidden = true
        initialNetworkCheck()
        UserDefaults.standard.set(false, forKey: keyValue.expandView.rawValue)
        searchTextField.delegate = self
        reviewListArray = fetchDataEnteryAnimalTbl(entityName: Entities.dataEntryAnimalAddTbl,customerId:currentCustomerId, listId: Int64(self.listIdGet)) as!  [DataEntryAnimaladdTbl]
        
        if pviduser == 4 {
            if UserDefaults.standard.value(forKey: keyValue.dateEntrySaveReviewPreference.rawValue) as? String == keyValue.barcode.rawValue {
                sortByButtonOutlet.setTitle(NSLocalizedString(ButtonTitles.barcodeText, comment: ""), for: .normal)
                clickOnDropDown = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
                
            } else if UserDefaults.standard.value(forKey: keyValue.dateEntrySaveReviewPreference.rawValue) as? String == ButtonTitles.earTagText || UserDefaults.standard.value(forKey: keyValue.dateEntrySaveReviewPreference.rawValue) as? String == nil || UserDefaults.standard.value(forKey: keyValue.dateEntrySaveReviewPreference.rawValue) as? String == "" || UserDefaults.standard.value(forKey: keyValue.dateEntrySaveReviewPreference.rawValue) as? String == keyValue.farmId.rawValue || UserDefaults.standard.value(forKey: keyValue.dateEntrySaveReviewPreference.rawValue) as? String == LocalizedStrings.onFarmIdText{
                clickOnDropDown = NSLocalizedString(ButtonTitles.earTagText, comment: "")
                UserDefaults.standard.setValue(ButtonTitles.earTagText, forKey: keyValue.dateEntrySaveReviewPreference.rawValue)
                sortByButtonOutlet.setTitle(NSLocalizedString(ButtonTitles.earTagText, comment: ""), for: .normal)
                
            }
        }
        
        else if pviduser == 2 {
            sortByButtonOutlet.setTitle(NSLocalizedString(LocalizedStrings.officialIDText, comment: ""), for: .normal)
            clickOnDropDown = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
        }
        
        else {
            if UserDefaults.standard.value(forKey: keyValue.dateEntrySaveReviewPreference.rawValue) as? String == keyValue.farmId.rawValue || UserDefaults.standard.value(forKey: keyValue.dateEntrySaveReviewPreference.rawValue) as? String == "" || UserDefaults.standard.value(forKey: keyValue.dateEntrySaveReviewPreference.rawValue) as? String == nil{
                
                sortByButtonOutlet.setTitle(NSLocalizedString(LocalizedStrings.onFarmIdText, comment: ""), for: .normal)
                clickOnDropDown = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
            }
        }
    }
    
    func initialNetworkCheck(){
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del = UIApplication.shared.delegate as? AppDelegate
        self.statusText?.text = NSLocalizedString((del?.status)!, comment: "")
        if statusText?.text == ButtonTitles.connectedText.localized {
            self.connectedBtnOutlet.isHidden = true
            self.connectionImg.image = UIImage(named: ImageNames.statusOnlineSign)
            
        } else {
            self.connectedBtnOutlet.isHidden = false
            self.connectionImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
    
    // MARK: - OBJC SELECTOR METHODS
    @objc func methodOfReceivedNotification(notification: Notification)
    {
        
        UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
        let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
        self.hideIndicator()
        
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
    
    // MARK: - IB ACTIONS
    @IBAction func bckBtnAction(_ sender: UIButton) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func cartBttnAction(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryViewAnimalVC) as? DataEntryViewAnimalController
        vc?.delegateCustom = self
        vc!.dateEnteryReviewScreen = true
        vc!.animalBackSave = false
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func sortByAction(_ sender: UIButton) {
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
        let userID = UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int
        searchTextField.resignFirstResponder()
        dropDown.anchorView = sortByDownlbl
        dropDown.direction = .bottom
        dropDown.backgroundColor = UIColor.white
        dropDown.separatorColor = UIColor.clear
        dropDown.cornerRadius = 10
        dropDown.textFont = UIFont.systemFont(ofSize: 13)
        dropDown.cellHeight = 30
        
        if pviduser == 1 || pviduser == 3 || pviduser == 10 || pviduser == 11 || pviduser == 12 {
            dropDown.dataSource = [ NSLocalizedString(LocalizedStrings.onFarmIdText, comment: ""),NSLocalizedString(LocalizedStrings.officialIDText, comment: ""), NSLocalizedString(ButtonTitles.barcodeText, comment: "")]
            
        } else if  pviduser == 2 {
            dropDown.dataSource = [NSLocalizedString(LocalizedStrings.officialIDText, comment: ""), NSLocalizedString(LocalizedStrings.onFarmIdText, comment: ""), NSLocalizedString(ButtonTitles.barcodeText, comment: "")]
        }
        else {
            dropDown.dataSource = [NSLocalizedString(ButtonTitles.earTagText, comment: ""), NSLocalizedString(ButtonTitles.barcodeText, comment: "")]
        }
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            guard let weakSelf = self else {
                return
            }
            weakSelf.clickOnDropDown = item
            weakSelf.sortByButtonOutlet.setTitle(item, for: .normal)
            weakSelf.sortByButtonOutlet.layer.borderColor = UIColor.gray.cgColor
            
            if weakSelf.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "") {
                UserDefaults.standard.set(keyValue.farmId.rawValue, forKey: keyValue.dateEntrySaveReviewPreference.rawValue)
                self?.sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                
                self?.reviewListArray = fetchDataEntryReviewDefault(entityName: Entities.dataEntryAnimalAddTbl,asending:true,userId:userID ?? 0,farmId :self?.searchTextField.text ?? "",customerId: currentCustomerId ?? 0,flag:1, listId: self?.listIdGet ?? 0) as! [DataEntryAnimaladdTbl]
                self?.tbleView.reloadData()
                
            } else if weakSelf.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: "") {
                self?.sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                
                UserDefaults.standard.set("officialId", forKey: keyValue.dateEntrySaveReviewPreference.rawValue)
                self?.reviewListArray = fetchDataEntryReviewDefault(entityName: Entities.dataEntryAnimalAddTbl,asending:true,userId:userID ?? 0,farmId :self?.searchTextField.text ?? "",customerId: currentCustomerId ?? 0,flag:2, listId: self?.listIdGet ?? 0) as! [DataEntryAnimaladdTbl]
                self?.tbleView.reloadData()
                
            } else if weakSelf.clickOnDropDown == ButtonTitles.barcodeText {
                self?.sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                
                UserDefaults.standard.set(keyValue.barcode.rawValue, forKey: keyValue.dateEntrySaveReviewPreference.rawValue)
                self?.reviewListArray = fetchDataEntryReviewDefault(entityName: Entities.dataEntryAnimalAddTbl,asending:true,userId:userID ?? 0,farmId : self?.searchTextField.text ?? "",customerId: currentCustomerId ?? 0,flag:3, listId: self?.listIdGet ?? 0) as! [DataEntryAnimaladdTbl]
                self?.tbleView.reloadData()
                
            } else if weakSelf.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: "") {
                self?.sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                
                UserDefaults.standard.set(ButtonTitles.earTagText, forKey: keyValue.dateEntrySaveReviewPreference.rawValue)
                self?.reviewListArray = fetchDataEntryReviewDefault(entityName: Entities.dataEntryAnimalAddTbl,asending:true,userId:userID ?? 0,farmId : self?.searchTextField.text ?? "",customerId: currentCustomerId ?? 0,flag: 4, listId: self?.listIdGet ?? 0) as! [DataEntryAnimaladdTbl]
                self?.tbleView.reloadData()
                
            }
            
            else  {
                self?.sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                UserDefaults.standard.set(keyValue.farmId.rawValue, forKey: keyValue.dateEntrySaveReviewPreference.rawValue)
                self?.reviewListArray = fetchDataEntryReviewDefault(entityName: Entities.dataEntryAnimalAddTbl,asending:true,userId:userID ?? 0,farmId :self?.searchTextField.text ?? "",customerId: currentCustomerId ?? 0,flag:1, listId: self?.listIdGet ?? 0) as! [DataEntryAnimaladdTbl]
                self?.tbleView.reloadData()
            }
            
        }
        dropDown.show()
        
    }
    
    @IBAction func backBtnNavigateToAnimal(_ sender: Any) {
        if pviduser == 4 {
            let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryOrderingAnimalVCGirlando) as! DataEntryOrderingAnimalVCGirlando
            self.navigationController?.pushViewController(secondViewController, animated: false)
            
        }else {
            let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryOrderingAnimalVC) as! DataEntryOrderingAnimalVC
            self.navigationController?.pushViewController(secondViewController, animated: false)
        }
        
    }
    
    @IBAction func sortByDropDownAction(_ sender: UIButton) {
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
        let userID = UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int
        
        if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: ""){
            if self.farmId == 0{
                self.reviewListArray = fetchDataEntryDropDownOnFarmId(entityName: Entities.dataEntryAnimalAddTbl,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet)) as! [DataEntryAnimaladdTbl]
                sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                self.farmId = 1
                self.tbleView.reloadData()
            }
            else {
                sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                self.reviewListArray = fetchDataEntryDropDownOnFarmId(entityName: Entities.dataEntryAnimalAddTbl,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:false,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet ))  as! [DataEntryAnimaladdTbl]
                self.farmId = 0
                self.tbleView.reloadData()
            }
        }
        
        else if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: ""){
            if self.offcialId == 0{
                sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                self.reviewListArray = fetchDataEntryDropDownOfficaialId(entityName: Entities.dataEntryAnimalAddTbl,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryAnimaladdTbl]
                self.offcialId = 1
                self.tbleView.reloadData()
                
            }
            
            else{
                sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                self.reviewListArray = fetchDataEntryDropDownOfficaialId(entityName: Entities.dataEntryAnimalAddTbl,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:false,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryAnimaladdTbl]
                
                self.offcialId = 0
                self.tbleView.reloadData()
            }
        }
        
        else if self.clickOnDropDown == NSLocalizedString(ButtonTitles.barcodeText, comment: "") {
            if self.barCodeId == 0{
                sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                self.reviewListArray = fetchDataEntryDropDownBarcode(entityName: Entities.dataEntryAnimalAddTbl,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryAnimaladdTbl]
                self.barCodeId = 1
                self.tbleView.reloadData()
            }
            
            else{
                sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                self.reviewListArray = fetchDataEntryDropDownBarcode(entityName: Entities.dataEntryAnimalAddTbl,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:false,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryAnimaladdTbl]
                
                self.barCodeId = 0
                self.tbleView.reloadData()
                
            }
        }
        
        else if self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: "") {
            if self.earTag == 0{
                sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                self.reviewListArray = fetchDataEntryDropDownEarTagg(entityName: Entities.dataEntryAnimalAddTbl,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryAnimaladdTbl]
                self.earTag = 1
                self.tbleView.reloadData()
                
            }
            else{
                sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                self.reviewListArray = fetchDataEntryDropDownEarTagg(entityName: Entities.dataEntryAnimalAddTbl,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:false,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryAnimaladdTbl]
                self.earTag = 0
                self.tbleView.reloadData()
                
            }
        }
        else {
            if self.farmId == 0{
                self.reviewListArray = fetchDataEntryDropDownOnFarmId(entityName: Entities.dataEntryAnimalAddTbl,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryAnimaladdTbl]
                sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                self.farmId = 1
                self.tbleView.reloadData()
            }
            
            else {
                sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                self.reviewListArray = fetchDataEntryDropDownOnFarmId(entityName: Entities.dataEntryAnimalAddTbl,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:false,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet ))  as! [DataEntryAnimaladdTbl]
                self.farmId = 0
                self.tbleView.reloadData()
            }
        }
    }
    
    @IBAction func emailMeEnteredDataBtn(_ sender: UIButton) {
        if unchecked {
            unchecked = false
            emailMeEnteredBtnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
        } else {
            unchecked = true
            emailMeEnteredBtnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
        }
    }
    
    @IBAction func saveListAction(_ sender: UIButton) {
        if Connectivity.isConnectedToInternet() {
            heartBeatViewModel?.callGetHearBeatData()
            
            if unchecked {
                self.objApiSync.delegeteSyncApi = self
                showIndicator(self.view, withTitle: NSLocalizedString(LocalizedStrings.listSyncProgress, comment: ""), and: "")
                self.objApiSync.postListData(listId:Int64(listIdGet),custmerId:Int64(currentCustomerId))
            }
            else {
                self.view.makeToast(NSLocalizedString(LocalizedStrings.listSaveSuccessfully, comment: ""), duration: 1, position: .top)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    
                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
                }
            }
        }
        
        else {
            if self.unchecked {
                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(LocalizedStrings.noEmailSent, comment: ""), preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default) { (action:UIAlertAction!) in
                    
                }
                alertController.addAction(cancelAction)
                let OKAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { (action:UIAlertAction!) in
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.listSaveSuccessfully, comment: ""), duration: 2, position: .top)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
                    }
                    
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion:nil)
            }
            else {
                self.view.makeToast(NSLocalizedString(LocalizedStrings.listSaveSuccessfully, comment: ""), duration: 2, position: .top)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
                }
            }
        }
    }
    
    @IBAction func menuBtnAction(_ sender: Any) {
        self.view.makeCorner(withRadius: 40)
        self.sideMenuViewController?.presentRightMenuViewController()
    }
    
    @IBAction func helpAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ClassIdentifiers.appHelpImagesVC) as? AppHelpImagesVC
        vc?.module = LocalizedStrings.dataEntryModeText.localized
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
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

// MARK: - OBJECT PICK CART SCREEN EXTENSION
extension DataEntryModeReviewData : objectPickCartScreen {
    func objectGetOnSelection(temp: Int) {
        
    }
}

// MARK: - TEXTFIELD DELEGATE
extension DataEntryModeReviewData : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let newString = (searchTextField.text ?? "")+string
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
        tbleView.isHidden = false
        
        if newString != ""{
            if self.clickOnDropDown == NSLocalizedString(ButtonTitles.barcodeText, comment: "")  {
                reviewListArray = fetchDataEntryBarcode(entityName: Entities.dataEntryAnimalAddTbl,barcodeID:newString as String,userId:userId,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryAnimaladdTbl]
                
                if reviewListArray.count > 0{
                    tbleView.reloadData()
                }
                else{
                    
                    tbleView.isHidden = true
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noDataFound, comment: ""), duration: 1, position: .center)
                }
            }
            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.officialIDText, comment: ""){
                reviewListArray = fetchDataEntryOfficalId(entityName: Entities.dataEntryAnimalAddTbl,barcodeID:newString as String,userId:userId,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryAnimaladdTbl]
                if reviewListArray.count > 0{
                    tbleView.reloadData()
                }
                else{
                    
                    tbleView.isHidden = true
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noDataFound, comment: ""), duration: 1, position: .center)
                }
            }
            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "") || self.clickOnDropDown == "" {
                reviewListArray =
                fetchDataEntryfarmId(entityName: Entities.dataEntryAnimalAddTbl,barcodeID:newString as String,userId:userId,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryAnimaladdTbl]
                if reviewListArray.count > 0{
                    tbleView.reloadData()
                }
                else{
                    
                    tbleView.isHidden = true
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noDataFound, comment: ""), duration: 1, position: .center)
                }
            }
            if self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: "") {
                reviewListArray =  fetchDataEntryEaarTag(entityName: Entities.dataEntryAnimalAddTbl,barcodeID:newString as String,userId:userId,asending:true,customerId:currentCustomerId ?? 0,listId:Int64(self.listIdGet )) as! [DataEntryAnimaladdTbl]
                
                if reviewListArray.count > 0{
                    tbleView.reloadData()
                }
                else{
                    
                    tbleView.isHidden = true
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noDataFound, comment: ""), duration: 1, position: .center)
                }
            }
            
        } else {
            reviewListArray = fetchDataEntryfarmId(entityName: Entities.dataEntryAnimalAddTbl,barcodeID:newString as String,userId:userId,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryAnimaladdTbl]
            if let char = string.cString(using: String.Encoding.utf8) {
                let isBackSpace = strcmp(char, "\\b")
                if (isBackSpace == -92) {
                    if textField.text?.count == 1{
                        
                    }
                }
            }
            tbleView.reloadData()
        }
        
        return true
    }
}

// MARK: - SIDE MENU UI EXTENSION
extension DataEntryModeReviewData : SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}

// MARK: - TABLEVIEW DELEGATES AND DATASOURCES
extension DataEntryModeReviewData :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviewListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DataEntryModeReviewDataCell = self.tbleView.dequeueReusableCell(withIdentifier: "cell") as! DataEntryModeReviewDataCell
        
        if pviduser == 1 || pviduser == 2 || pviduser == 3 || pviduser == 10 || pviduser == 11 || pviduser == 8 || pviduser == 12{
            if reviewListArray[indexPath.row].farmId != ""{
                cell.onFarmIdLbl.text = reviewListArray[indexPath.row].farmId
            } else {
                cell.onFarmIdLbl.text = "N/A"
            }
            if reviewListArray[indexPath.row].animalTag != ""{
                cell.officalIdLbl.text = reviewListArray[indexPath.row].animalTag
            } else {
                cell.officalIdLbl.text = "N/A"
            }
    
            cell.barcodeLbl.text = reviewListArray[indexPath.row].animalbarCodeTag
            cell.onFarmIdTitleLbl.text = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
            cell.officalIdTitleLbl.text = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
            cell.barcodeTitleLbl.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
            
        } else if pviduser == 4 {
            if reviewListArray[indexPath.row].earTag != ""{
                cell.onFarmIdLbl.text = reviewListArray[indexPath.row].earTag
            } else {
                cell.onFarmIdLbl.text = "N/A"
            }
            if reviewListArray[indexPath.row].animalbarCodeTag != ""{
                cell.officalIdLbl.text = reviewListArray[indexPath.row].animalbarCodeTag
            } else {
                cell.officalIdLbl.text = "N/A"
            }
            cell.onFarmIdTitleLbl.text = NSLocalizedString(ButtonTitles.earTagText, comment: "")
            cell.officalIdTitleLbl.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if pviduser == 1 || pviduser == 2 || pviduser == 3 || pviduser == 10  || pviduser == 11 || pviduser == 8 || pviduser == 12 {
            
            return 115
        } else {
            return 80
        }
    }
}

// MARK: - OFFLINE CUSTOMVIEW EXTENSION
extension DataEntryModeReviewData:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

// MARK: - SYNC API EXTENSION
extension DataEntryModeReviewData : syncApi {
    func failWithError(statusCode: Int) {
        self.hideIndicator()
    }
    
    func failWithErrorInternal() {
        self.hideIndicator()
    }
    
    func didFinishApi(response: String) {
        let emailId = UserDefaults.standard.value(forKey: keyValue.userName.rawValue) as? String ?? ""
        self.view.makeToast(NSLocalizedString(LocalizedStrings.listSaveSuccessfully, comment: ""), duration: 1, position: .top)
        self.objApiSync.postEmailList(listId:Int64(self.listIdGet),custmerId:Int64(self.currentCustomerId),emailAdress :[emailId],providerId: self.pviduser)
        self.view.makeToast(NSLocalizedString(LocalizedStrings.receiveDataInEmail, comment: ""), duration: 3, position: .bottom)
        self.view.isUserInteractionEnabled = true
        self.hideIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.sideMenuViewController?.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
        }
        
    }
    
    func failWithInternetConnection() {
        self.hideIndicator()
    }
    
}
