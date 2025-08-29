//
//  BeefDataEntryModeReviewData.swift
//  SearchPoint
//
//  Created by Mobile Programming on 14/01/21.
//

import UIKit
import DropDown
import CoreData

// MARK: - CLASS
class BeefDataEntryModeReviewData: UIViewController{
    
    // MARK: - IB OUTLETS
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
    let pviduser = (UserDefaults.standard.integer(forKey:keyValue.beefPvid.rawValue))
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    var listIdGet = Int()
    var listName = String()
    var animalTag = Int()
    var barCodeId = Int()
    var earTag = Int()
    var series = Int()
    var rgn = Int()
    var rgd = Int()
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    var offcialId = Int()
    var delegateCustom : objectPickCartScreen?
    var clickOnDropDown = String()
    var reviewListArray = [DataEntryBeefAnimaladdTbl]()
    let dropDown = DropDown()
    var currentCustomerId = Int()
    var objApiSync = ApiSyncList()
    var timeDelayed = DispatchTimeInterval.seconds(4)
    var unchecked = true
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        _ = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        
        
        reviewListArray =  fetchAllDataAnimalDaWithOutOrderId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, userId: userId,orderStatus:"false", listid: Int64(self.listIdGet), custmerId: Int64(currentCustomerId), providerId: pviduser) as! [DataEntryBeefAnimaladdTbl]
        notificationCountLbl.text = String(reviewListArray.count)
        animalLblCount.text = String(reviewListArray.count)
        if reviewListArray.count == 0{
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
        searchTextField.placeholder = NSLocalizedString(ButtonTitles.searchText, comment: "")
        let perfernce = UserDefaults.standard.value(forKey: keyValue.beefDateEntrySaveReviewPreference.rawValue) as? String
        
        if perfernce == LocalizedStrings.animalTagStr.localized{
            self.clickOnDropDown = LocalizedStrings.animalTagStr
            self.sortByButtonOutlet.setTitle(NSLocalizedString(LocalizedStrings.animalTagStr, comment: ""), for: .normal)
            
        } else if perfernce == keyValue.barcode.rawValue || pviduser == 6 && perfernce == keyValue.capsFarmId.rawValue{
            self.clickOnDropDown = ButtonTitles.barcodeText
            self.sortByButtonOutlet.setTitle(NSLocalizedString(ButtonTitles.barcodeText, comment: ""), for: .normal)
            
        } else if perfernce == ButtonTitles.earTagText || perfernce == NSLocalizedString(ButtonTitles.earTagText, comment: ""){
            self.clickOnDropDown = ButtonTitles.earTagText
            self.sortByButtonOutlet.setTitle(NSLocalizedString(ButtonTitles.earTagText, comment: ""), for: .normal)
            
        }
        else if perfernce == NSLocalizedString(LocalizedStrings.RGNText, comment: ""){
            self.clickOnDropDown = LocalizedStrings.RGNText
            self.sortByButtonOutlet.setTitle(NSLocalizedString(LocalizedStrings.RGNText, comment: ""), for: .normal)
            
        }  else if perfernce == NSLocalizedString(LocalizedStrings.RGDText, comment: "") || perfernce == NSLocalizedString(LocalizedStrings.RGDorAnimalIDText, comment: ""){
            self.clickOnDropDown = LocalizedStrings.RGDorAnimalIDText
            self.sortByButtonOutlet.setTitle(NSLocalizedString(LocalizedStrings.RGDorAnimalIDText, comment: ""), for: .normal)
            
        } else if perfernce == NSLocalizedString(LocalizedStrings.seriesText, comment: "") {
            self.clickOnDropDown = LocalizedStrings.seriesText
            self.sortByButtonOutlet.setTitle(NSLocalizedString(LocalizedStrings.seriesText, comment: ""), for: .normal)
            
        }
        
        if pviduser == 7 && (perfernce == "" || perfernce == nil){
            self.clickOnDropDown = LocalizedStrings.animalTagStr
            self.sortByButtonOutlet.setTitle(NSLocalizedString(LocalizedStrings.animalTagStr, comment: ""), for: .normal)
            
        }
        if pviduser == 5 && (perfernce == "" || perfernce == nil){
            self.clickOnDropDown = ButtonTitles.earTagText
            self.sortByButtonOutlet.setTitle(NSLocalizedString(ButtonTitles.earTagText, comment: ""), for: .normal)
            
        }
        if pviduser == 6 && (perfernce == "" || perfernce == nil){
            self.clickOnDropDown = ButtonTitles.barcodeText
            self.sortByButtonOutlet.setTitle(NSLocalizedString(ButtonTitles.barcodeText, comment: ""), for: .normal)
            
        }
        self.objApiSync.delegeteSyncApi = self
        currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as! Int
        listIdGet = UserDefaults.standard.integer(forKey: keyValue.listIdSaveOnSelection.rawValue)
        listName = UserDefaults.standard.object(forKey: keyValue.listNameSaveOnSelection.rawValue) as! String
        self.navigationController?.navigationBar.isHidden = true
        initialNetworkCheck()
        UserDefaults.standard.set(false, forKey: keyValue.expandView.rawValue)
        searchTextField.delegate = self
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
        let storyboard = UIStoryboard(name: "iPad", bundle: Bundle.main)
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
    }
    
    @IBAction func cartBttnAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryBeefViewAnimalControllerVC) as? DataEntryBeefViewAnimalController
        vc?.delegateCustom = self
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
        
        if pviduser == 7  {
            dropDown.dataSource = [NSLocalizedString(LocalizedStrings.animalTagStr, comment: ""), NSLocalizedString(ButtonTitles.barcodeText, comment: "")]
            
        }
        if pviduser == 5  {
            dropDown.dataSource = [NSLocalizedString(ButtonTitles.earTagText, comment: ""), NSLocalizedString(ButtonTitles.barcodeText, comment: "")]
            
        }
        if pviduser == 6  {
            dropDown.dataSource = [NSLocalizedString(ButtonTitles.barcodeText, comment: ""), NSLocalizedString(LocalizedStrings.seriesText, comment: ""),NSLocalizedString(LocalizedStrings.RGNText, comment: ""),NSLocalizedString(LocalizedStrings.RGDorAnimalIDText, comment: "")]
            
        }
        
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let weakSelf = self else {
                return
            }
            weakSelf.clickOnDropDown = item
            weakSelf.sortByButtonOutlet.setTitle(item, for: .normal)
            weakSelf.sortByButtonOutlet.layer.borderColor = UIColor.gray.cgColor
            
            if weakSelf.clickOnDropDown == LocalizedStrings.animalTagStr || weakSelf.clickOnDropDown == LocalizedStrings.tatuagemAnimal {
                
                UserDefaults.standard.set(LocalizedStrings.animalTagStr, forKey: keyValue.beefDateEntrySaveReviewPreference.rawValue)
                self?.sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                self?.reviewListArray = fetchDataEntryReviewDefaultBeef(entityName: Entities.dataEntryBeefAnimalAddTblEntity,asending:true,userId:userID ?? 0,farmId :self?.searchTextField.text ?? "",customerId: currentCustomerId ?? 0,flag:2, listId: self?.listIdGet ?? 0) as! [DataEntryBeefAnimaladdTbl]
                self?.tbleView.reloadData()
                
            } else if weakSelf.clickOnDropDown == NSLocalizedString(ButtonTitles.barcodeText, comment: "")  {
                self?.sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                UserDefaults.standard.set(keyValue.barcode.rawValue, forKey: keyValue.beefDateEntrySaveReviewPreference.rawValue)
                self?.reviewListArray = fetchDataEntryReviewDefaultBeef(entityName: Entities.dataEntryBeefAnimalAddTblEntity,asending:true,userId:userID ?? 0,farmId : self?.searchTextField.text ?? "",customerId: currentCustomerId ?? 0,flag:3, listId: self?.listIdGet ?? 0) as! [DataEntryBeefAnimaladdTbl]
                self?.tbleView.reloadData()
                
            } else if weakSelf.clickOnDropDown == ButtonTitles.earTagText {
                self?.sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                UserDefaults.standard.set(ButtonTitles.earTagText, forKey: keyValue.beefDateEntrySaveReviewPreference.rawValue)
                self?.reviewListArray = fetchDataEntryReviewDefaultBeef(entityName: Entities.dataEntryBeefAnimalAddTblEntity,asending:true,userId:userID ?? 0,farmId : self?.searchTextField.text ?? "",customerId: currentCustomerId ?? 0,flag: 2, listId: self?.listIdGet ?? 0) as! [DataEntryBeefAnimaladdTbl]
                self?.tbleView.reloadData()
                
            }
            else if weakSelf.clickOnDropDown == LocalizedStrings.seriesText {
                self?.sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                
                UserDefaults.standard.set(LocalizedStrings.seriesText, forKey: keyValue.beefDateEntrySaveReviewPreference.rawValue)
                self?.reviewListArray = fetchDataEntryReviewDefaultBeef(entityName: Entities.dataEntryBeefAnimalAddTblEntity,asending:true,userId:userID ?? 0,farmId : self?.searchTextField.text ?? "",customerId: currentCustomerId ?? 0,flag: 5, listId: self?.listIdGet ?? 0) as! [DataEntryBeefAnimaladdTbl]
                self?.tbleView.reloadData()
                
            }else if weakSelf.clickOnDropDown == NSLocalizedString(LocalizedStrings.RGNText, comment: "") {
                
                self?.sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                
                UserDefaults.standard.set(LocalizedStrings.RGNText, forKey: keyValue.beefDateEntrySaveReviewPreference.rawValue)
                self?.reviewListArray = fetchDataEntryReviewDefaultBeef(entityName: Entities.dataEntryBeefAnimalAddTblEntity,asending:true,userId:userID ?? 0,farmId : self?.searchTextField.text ?? "",customerId: currentCustomerId ?? 0,flag: 6, listId: self?.listIdGet ?? 0) as! [DataEntryBeefAnimaladdTbl]
                self?.tbleView.reloadData()
                
            }
            else if weakSelf.clickOnDropDown == LocalizedStrings.RGDText || weakSelf.clickOnDropDown == LocalizedStrings.RGDorAnimalIDText{
                self?.sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                UserDefaults.standard.set(LocalizedStrings.RGDText, forKey: keyValue.beefDateEntrySaveReviewPreference.rawValue)
                self?.reviewListArray = fetchDataEntryReviewDefaultBeef(entityName: Entities.dataEntryBeefAnimalAddTblEntity,asending:true,userId:userID ?? 0,farmId : self?.searchTextField.text ?? "",customerId: currentCustomerId ?? 0,flag: 7, listId: self?.listIdGet ?? 0) as! [DataEntryBeefAnimaladdTbl]
                self?.tbleView.reloadData()
                
            }
            
            else  {
                self?.sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                UserDefaults.standard.set(keyValue.farmId.rawValue, forKey: keyValue.beefDateEntrySaveReviewPreference.rawValue)
                self?.reviewListArray = fetchDataEntryReviewDefaultBeef(entityName: Entities.dataEntryBeefAnimalAddTblEntity,asending:true,userId:userID ?? 0,farmId :self?.searchTextField.text ?? "",customerId: currentCustomerId ?? 0,flag:1, listId: self?.listIdGet ?? 0) as! [DataEntryBeefAnimaladdTbl]
                self?.tbleView.reloadData()
            }
            
        }
        dropDown.show()
        
    }
    
    @IBAction func backBtnNavigateToAnimal(_ sender: Any) {
        if pviduser == 5 {
            let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryBeefAnimalGlobalHD50KVC) as! DataEntryBeefAnimalGlobalHD50KVC
            self.navigationController?.pushViewController(secondViewController, animated: false)
            
        }
        else if pviduser == 6 {
            let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dataEntryBeefAnimalBrazilVC) as! DataEntryBeefAnimalBrazilVC
            self.navigationController?.pushViewController(secondViewController, animated: false)
        }
    }
    
    @IBAction func sortByDropDownAction(_ sender: UIButton) {
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
        let userID = UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int
        if self.clickOnDropDown == NSLocalizedString(ButtonTitles.barcodeText, comment: "")  {
            if self.barCodeId == 0{
                sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                if pviduser == 6 {
                    self.reviewListArray = fetchDataEntryDropDownBarcodeBrazil(entityName: Entities.dataEntryBeefAnimalAddTblEntity,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryBeefAnimaladdTbl]
                    
                }else {
                    self.reviewListArray = fetchDataEntryDropDownBarcode(entityName: Entities.dataEntryBeefAnimalAddTblEntity,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryBeefAnimaladdTbl]
                    
                }
                self.barCodeId = 1
                self.tbleView.reloadData()
                
            }
            else{
                sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                if pviduser == 6 {
                    self.reviewListArray = fetchDataEntryDropDownBarcodeBrazil(entityName: Entities.dataEntryBeefAnimalAddTblEntity,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:false,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryBeefAnimaladdTbl]
                    
                } else {
                    self.reviewListArray = fetchDataEntryDropDownBarcode(entityName: Entities.dataEntryBeefAnimalAddTblEntity,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:false,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryBeefAnimaladdTbl]
                }
                self.barCodeId = 0
                self.tbleView.reloadData()
                
            }
        } else if self.clickOnDropDown == LocalizedStrings.animalTagStr || self.clickOnDropDown == LocalizedStrings.tatuagemAnimal{
            if self.animalTag == 0 {
                sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                self.reviewListArray = fetchDataEntryDropDownOfficaialId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryBeefAnimaladdTbl]
                
                self.animalTag = 1
                self.tbleView.reloadData()
                
            }
            else{
                sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                self.reviewListArray = fetchDataEntryDropDownOfficaialId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:false,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryBeefAnimaladdTbl]
                
                self.animalTag = 0
                self.tbleView.reloadData()
            }
        }
        
        else if self.clickOnDropDown == ButtonTitles.earTagText || self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: ""){
            if self.earTag == 0 {
                sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                self.reviewListArray = fetchDataEntryDropDownOfficaialId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryBeefAnimaladdTbl]
                
                self.earTag = 1
                self.tbleView.reloadData()
                
            } else {
                sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                self.reviewListArray = fetchDataEntryDropDownOfficaialId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:false,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryBeefAnimaladdTbl]
                
                self.earTag = 0
                self.tbleView.reloadData()
                
            }
        }
        
        else if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.seriesText, comment: ""){
            if self.series == 0 {
                sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                self.reviewListArray = fetchDataEntryDropDownSeries(entityName: Entities.dataEntryBeefAnimalAddTblEntity,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryBeefAnimaladdTbl]
                
                self.series = 1
                self.tbleView.reloadData()
                
            } else {
                sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                self.reviewListArray = fetchDataEntryDropDownSeries(entityName: Entities.dataEntryBeefAnimalAddTblEntity,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:false,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryBeefAnimaladdTbl]
                
                self.series = 0
                self.tbleView.reloadData()
                
            }
        }
        
        else if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.RGNText, comment: ""){
            if self.rgn == 0 {
                sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                self.reviewListArray = fetchDataEntryDropDownRGN(entityName: Entities.dataEntryBeefAnimalAddTblEntity,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryBeefAnimaladdTbl]
                self.rgn = 1
                self.tbleView.reloadData()
                
            } else {
                sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                self.reviewListArray = fetchDataEntryDropDownRGN(entityName: Entities.dataEntryBeefAnimalAddTblEntity,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:false,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryBeefAnimaladdTbl]
                
                self.rgn = 0
                self.tbleView.reloadData()
                
            }
        }
        
        else if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.RGDorAnimalIDText, comment: ""){
            
            if self.rgd == 0 {
                sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingDescImg), for: .normal)
                self.reviewListArray = fetchDataEntryDropDownRGd(entityName: Entities.dataEntryBeefAnimalAddTblEntity,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryBeefAnimaladdTbl]
                
                self.rgd = 1
                self.tbleView.reloadData()
                
            } else {
                sortByDropDownOutlet.setImage(UIImage(named: ImageNames.sortingImg), for: .normal)
                self.reviewListArray = fetchDataEntryDropDownRGd(entityName: Entities.dataEntryBeefAnimalAddTblEntity,onfarmId:self.searchTextField.text ?? "",userId:userID ?? 0,asending:false,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryBeefAnimaladdTbl]
                
                self.rgd = 0
                self.tbleView.reloadData()
                
            }
        }
    }
    
    @IBAction func saveListAction(_ sender: UIButton) {
        if Connectivity.isConnectedToInternet() {
            if unchecked  {
                self.view.isUserInteractionEnabled = false
                showIndicator(self.view, withTitle: NSLocalizedString(LocalizedStrings.listSyncProgress, comment: ""), and: "")
                self.objApiSync.postListDataBeef(listId:Int64(listIdGet),custmerId:Int64(currentCustomerId))
            }  else {
                self.view.makeToast(NSLocalizedString(LocalizedStrings.listSaveSuccessfully, comment: ""), duration: 2, position: .top)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
                }
            }
            
        } else {
            if self.unchecked {
                let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(LocalizedStrings.noEmailSent, comment: ""), preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default) { (action:UIAlertAction!) in
                    print(LocalizedStrings.cancelPressed)
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
                
                
            } else {
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
    
    @IBAction func emailMeEnteredDataBtn(_ sender: UIButton) {
        if unchecked {
            unchecked = false
            emailMeEnteredBtnOutlet.setImage(UIImage(named: ImageNames.unCheckImg), for: .normal)
        } else {
            unchecked = true
            emailMeEnteredBtnOutlet.setImage(UIImage(named: ImageNames.checkImg), for: .normal)
            
            
        }
    }
    
}

// MARK: - TEXTFIELD DELEGATES
extension BeefDataEntryModeReviewData : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let newString = (searchTextField.text ?? "")+string
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let currentCustomerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int
        
        tbleView.isHidden = false
        if newString != ""{
            
            if self.clickOnDropDown == NSLocalizedString(ButtonTitles.barcodeText, comment: "")  {
                if pviduser == 6 {
                    reviewListArray = fetchDataEntryBarcodeBrazill(entityName: Entities.dataEntryBeefAnimalAddTblEntity,barcodeID:newString as String,userId:userId,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryBeefAnimaladdTbl]
                    
                    
                }else {
                    reviewListArray = fetchDataEntryBarcode(entityName: Entities.dataEntryBeefAnimalAddTblEntity,barcodeID:newString as String,userId:userId,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryBeefAnimaladdTbl]
                }
                if reviewListArray.count > 0{
                    tbleView.reloadData()
                }
                else{
                    
                    tbleView.isHidden = true
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noDataFound, comment: ""), duration: 1, position: .center)
                }
            }
            if self.clickOnDropDown == LocalizedStrings.animalTagStr || self.clickOnDropDown == LocalizedStrings.tatuagemAnimal{
                reviewListArray = fetchDataEntryOfficalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,barcodeID:newString as String,userId:userId,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet)) as! [DataEntryBeefAnimaladdTbl]
                if reviewListArray.count > 0{
                    tbleView.reloadData()
                }
                else{
                    
                    tbleView.isHidden = true
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noDataFound, comment: ""), duration: 1, position: .center)
                }
            }
            
            if self.clickOnDropDown == NSLocalizedString(ButtonTitles.earTagText, comment: "") {
                reviewListArray = fetchDataEntryEarTagBeef(entityName: Entities.dataEntryBeefAnimalAddTblEntity,barcodeID:newString as String,userId:userId,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet)) as! [DataEntryBeefAnimaladdTbl]
                if reviewListArray.count > 0{
                    tbleView.reloadData()
                }
                else{
                    tbleView.isHidden = true
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noDataFound, comment: ""), duration: 1, position: .center)
                }
            }
            
            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.RGNText, comment: ""){
                reviewListArray = fetchDataEntryDropDownRGN(entityName: Entities.dataEntryBeefAnimalAddTblEntity,onfarmId:newString as String,userId:userId,asending:true,customerId:currentCustomerId ?? 0,listId:Int64(self.listIdGet)) as! [DataEntryBeefAnimaladdTbl]
                if reviewListArray.count > 0{
                    tbleView.reloadData()
                }
                else{
                    tbleView.isHidden = true
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noDataFound, comment: ""), duration: 1, position: .center)
                }
            }
            
            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.RGDText, comment: "") || self.clickOnDropDown == NSLocalizedString(LocalizedStrings.RGDorAnimalIDText, comment: "") {
                reviewListArray = fetchDataEntryDropDownRGd(entityName: Entities.dataEntryBeefAnimalAddTblEntity,onfarmId:newString as String,userId:userId,asending:true,customerId:currentCustomerId ?? 0,listId:Int64(self.listIdGet)) as! [DataEntryBeefAnimaladdTbl]
                if reviewListArray.count > 0{
                    tbleView.reloadData()
                }
                else{
                    tbleView.isHidden = true
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noDataFound, comment: ""), duration: 1, position: .center)
                }
            }
            
            if self.clickOnDropDown == NSLocalizedString(LocalizedStrings.seriesText, comment: "") {
                reviewListArray = fetchDataEntryDropDownSeries(entityName: Entities.dataEntryBeefAnimalAddTblEntity,onfarmId:newString as String,userId:userId,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet)) as! [DataEntryBeefAnimaladdTbl]
                if reviewListArray.count > 0{
                    tbleView.reloadData()
                }
                else{
                    tbleView.isHidden = true
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noDataFound, comment: ""), duration: 1, position: .center)
                }
            }
        }
        
        reviewListArray = fetchDataEntryEarTagBeef(entityName: Entities.dataEntryBeefAnimalAddTblEntity,barcodeID:newString as String,userId:userId,asending:true,customerId:currentCustomerId ?? 0, listId: Int64(self.listIdGet )) as! [DataEntryBeefAnimaladdTbl]
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                if textField.text?.count == 1{
                    
                }
            }
        }
        tbleView.reloadData()
        return true
    }
}

// MARK: - SIDE MENU UI EXTENSION
extension BeefDataEntryModeReviewData : SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}

// MARK: - TABLEVIEW DATASOURCE AND DELEGATES
extension BeefDataEntryModeReviewData :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviewListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:DataEntryModeReviewDataCell = self.tbleView.dequeueReusableCell(withIdentifier: "cell") as! DataEntryModeReviewDataCell
        let animalVal  =  reviewListArray[indexPath.row]
        
        if pviduser == 7{
            if animalVal.animalTag != ""{
                cell.onFarmIdLbl.text = animalVal.animalTag
            } else {
                cell.onFarmIdLbl.text = "N/A"
            }
            if animalVal.animalbarCodeTag != ""{
                cell.officalIdLbl.text = animalVal.animalbarCodeTag
            } else {
                cell.officalIdLbl.text = "N/A"
            }
            cell.onFarmIdTitleLbl.text = LocalizedStrings.animalTagTattoo.localized
            cell.officalIdTitleLbl.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
            cell.officalIdTitleLbl.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
        }
        if pviduser == 5{
            if animalVal.animalTag != ""{
                cell.onFarmIdLbl.text = animalVal.animalTag
            } else {
                cell.onFarmIdLbl.text = "N/A"
            }
            if animalVal.animalbarCodeTag != ""{
                cell.officalIdLbl.text = animalVal.animalbarCodeTag
            } else {
                cell.officalIdLbl.text = "N/A"
            }
            cell.onFarmIdTitleLbl.text = NSLocalizedString(ButtonTitles.earTagText, comment: "")
            cell.officalIdTitleLbl.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
        }
        
        if pviduser == 6 {
            if animalVal.animalTag != ""{
                cell.onFarmIdLbl.text = animalVal.animalTag
            } else {
                cell.onFarmIdLbl.text = "N/A"
            }
            if animalVal.offsireId != ""{
                cell.officalIdLbl.text = animalVal.offsireId
            } else {
                cell.officalIdLbl.text = "N/A"
            }
            if animalVal.offPermanentId != ""{
                cell.barcodeLbl.text = animalVal.offPermanentId
            } else {
                cell.barcodeLbl.text = "N/A"
            }
            if animalVal.offPermanentId != ""{
                cell.barcodeLbl.text = animalVal.offPermanentId
            } else {
                cell.barcodeLbl.text = "N/A"
            }
            if animalVal.offDamId != ""{
                cell.fourthLbl.text = animalVal.offDamId
            } else {
                cell.fourthLbl.text = "N/A"
            }
            cell.onFarmIdTitleLbl.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
            cell.officalIdTitleLbl.text = NSLocalizedString(LocalizedStrings.seriesText, comment: "")
            cell.barcodeTitleLbl.text = NSLocalizedString(LocalizedStrings.RGNText, comment: "")
            cell.fourthTitleLbl.text = NSLocalizedString(LocalizedStrings.RGDorAnimalIDText, comment: "")
            cell.officalIdTitleLbl.text = NSLocalizedString(LocalizedStrings.seriesText, comment: "")
            cell.onFarmIdTitleLbl.text = NSLocalizedString(ButtonTitles.barcodeText, comment: "")
            cell.fourthTitleLbl.text = NSLocalizedString(LocalizedStrings.RGDorAnimalIDText, comment: "")
            cell.barcodeTitleLbl.text = NSLocalizedString(LocalizedStrings.RGNText, comment: "")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if pviduser == 7 || pviduser == 5{
            return 80
        }
        return 134
    }
}

// MARK: - OFFLINE CUSTOM VIEW EXTENSION
extension BeefDataEntryModeReviewData:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

// MARK: - SYNC API VIEW EXTENSION
extension BeefDataEntryModeReviewData : syncApi {
    func failWithError(statusCode: Int) {
        self.hideIndicator()
    }
    
    func failWithErrorInternal() {
        self.hideIndicator()
    }
    
    func didFinishApi(response: String) {
        let emailId = UserDefaults.standard.value(forKey: keyValue.userName.rawValue) as? String ?? ""
        self.view.isUserInteractionEnabled = true
        self.hideIndicator()
        self.view.makeToast(NSLocalizedString(LocalizedStrings.listSaveSuccessfully, comment: ""), duration: 1, position: .top)
        self.objApiSync.postEmailList(listId:Int64(self.listIdGet),custmerId:Int64(self.currentCustomerId),emailAdress :[emailId],providerId: self.pviduser)
        
        self.view.makeToast(NSLocalizedString(LocalizedStrings.receiveDataInEmail, comment: ""), duration: 3, position: .bottom)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.sideMenuViewController?.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.dashboardVC)), animated: true)
        }
        
    }
    
    func failWithInternetConnection() {
        self.hideIndicator()
    }
}

// MARK: - OBJECT PICK CART EXTENSION
extension BeefDataEntryModeReviewData : objectPickCartScreen {
    func objectGetOnSelection(temp: Int) {
        // Intentionally left empty.
        // This function will handle navigation to another view controller in the future.
        // Currently unused, but kept for consistency with protocol or planned implementation.
    }
}
